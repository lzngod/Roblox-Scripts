local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local isProtected = false
local targets = {
    Impulse = {
        Path = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"),
        Name = "RE/CombatService/ApplyImpulse",
        Real = nil,
        Fake = nil
    },
    Ragdoll = {
        Path = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Ragdoll"),
        Name = "Ragdoll",
        Real = nil,
        Fake = nil
    }
}

local function restoreTarget(target)
    if target.Fake then
        target.Fake:Destroy()
        target.Fake = nil
    end
    if target.Real and not target.Real.Parent then
        target.Real.Parent = target.Path
    end
end

local function neutralizeTarget(target)
    local realEvent = target.Path:FindFirstChild(target.Name)
    if realEvent and not target.Real then
        target.Real = realEvent
        target.Real.Parent = nil
        
        local fakeEvent = Instance.new("RemoteEvent")
        fakeEvent.Name = target.Name
        fakeEvent.Parent = target.Path
        target.Fake = fakeEvent
        print("[Sentinela] Alvo '" .. target.Name .. "' foi neutralizado.")
    end
end

local sentinelLoop
local function setProtection(enabled)
    isProtected = enabled
    
    if enabled then
        if sentinelLoop then sentinelLoop:Disconnect() end
        
        sentinelLoop = RunService.Heartbeat:Connect(function()
            for _, target in pairs(targets) do
                if not target.Real then
                    neutralizeTarget(target)
                end
            end
        end)
        print("[Sentinela] Proteção ATIVADA. Vigilância contínua iniciada.")
    else
        if sentinelLoop then sentinelLoop:Disconnect() sentinelLoop = nil end
        
        for _, target in pairs(targets) do
            restoreTarget(target)
        end
        print("[Sentinela] Proteção DESATIVADA. Alvos restaurados.")
    end
end

-- [[ GUI ]]
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SentinelGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 180, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.Draggable = true
toggleButton.BackgroundColor3 = Color3.fromRGB(45, 179, 83)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Text = "Invencibilidade: ON"
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", toggleButton).Color = Color3.fromRGB(255,255,255)
toggleButton.Parent = screenGui

toggleButton.MouseButton1Click:Connect(function()
    if isProtected then
        setProtection(false)
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        toggleButton.Text = "Invencibilidade: OFF"
    else
        setProtection(true)
        toggleButton.BackgroundColor3 = Color3.fromRGB(45, 179, 83)
        toggleButton.Text = "Invencibilidade: ON"
    end
end)

setProtection(true)
