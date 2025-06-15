local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isInvincible = false

local targets = {
    Impulse = {
        Path = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/CombatService"),
        Name = "ApplyImpulse"
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
    print("[Invencibility v4.1] Desativado. Vulnerabilidade restaurada.")
end

local function enableInvincibility()
    if isInvincible then return end

    for key, targetInfo in pairs(targets) do
        local realEvent = targetInfo.Path:FindFirstChild(targetInfo.Name)
        if realEvent then
            originalEvents[key] = realEvent
            realEvent.Parent = nil 
            
            local fakeEvent = Instance.new("RemoteEvent")
            fakeEvent.Name = targetInfo.Name
            fakeEvent.Parent = targetInfo.Path
            fakeEvents[key] = fakeEvent
        end
    end
    
    isInvincible = true
    print("[Invencibility v4.1] Ativado. Você está protegido.")
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "InvincibilityGUI"
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
toggleButton.Active = true

function toggle()
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

toggleButton.MouseButton1Click:Connect(toggle)

pcall(enableInvincibility)
