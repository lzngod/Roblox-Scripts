local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isInvincible = true

local targets = {
    Impulse = {
        Path = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"),
        Name = "RE/CombatService/ApplyImpulse"
    },
    Ragdoll = {
        Path = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Ragdoll"),
        Name = "Ragdoll"
    }
}

local originalEvents = {}
local fakeEvents = {}

local function disableInvincibility()
    for key, fake in pairs(fakeEvents) do
        if fake and fake.Parent then
            fake:Destroy()
        end
    end
    fakeEvents = {}
    
    for key, original in pairs(originalEvents) do
        if original and not original.Parent and targets[key] then
             original.Parent = targets[key].Path
        end
    end
    
    isInvincible = false
    print("[Solução Final] Desativado. Vulnerabilidade restaurada.")
end

local function enableInvincibility()
    if not isInvincible then return end

    for key, targetInfo in pairs(targets) do
        local realEvent = targetInfo.Path:FindFirstChild(targetInfo.Name)
        if realEvent and not fakeEvents[key] then
            originalEvents[key] = realEvent
            realEvent.Parent = nil 
            
            local fakeEvent = Instance.new("RemoteEvent")
            fakeEvent.Name = targetInfo.Name
            fakeEvent.Parent = targetInfo.Path
            fakeEvents[key] = fakeEvent
        end
    end
    
    print("[Solução Final] Ativado. Proteção máxima.")
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FinalSolutionGUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 160, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
toggleButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BorderSizePixel = 2
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Text = "Invencível: ON"
toggleButton.Draggable = true

local function toggle()
    if isInvincible then
        disableInvincibility()
        toggleButton.Text = "Invencível: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        enableInvincibility()
        toggleButton.Text = "Invencível: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end
end

local success, err = pcall(function()
    local impulseTarget = targets.Impulse.Path:WaitForChild(targets.Impulse.Name, 10)
    local ragdollTarget = targets.Ragdoll.Path:WaitForChild(targets.Ragdoll.Name, 10)
    if not impulseTarget or not ragdollTarget then
        error("Um ou mais alvos não foram encontrados a tempo.")
    end
end)

if success then
    toggleButton.MouseButton1Click:Connect(toggle)
    enableInvincibility()
else
    toggleButton.Text = "ERRO: Alvos não encontrados"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    warn("[Solução Final] ERRO:", err)
end
