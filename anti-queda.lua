local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local isProtected = false
local connections = {}
local character
local humanoid

local function onStateChanged(old, new)
    if new == Enum.HumanoidStateType.Ragdoll or new == Enum.HumanoidStateType.FallingDown or new == Enum.HumanoidStateType.GettingUp then
        RunService.Heartbeat:Wait() 
        humanoid:ChangeState(Enum.HumanoidStateType.Running)
    end
end

local function onDescendantAdded(descendant)
    if descendant:IsA("BodyMover") or descendant.Name == "BodyAngularVelocity" then
        descendant:Destroy()
    end
end

local function enableProtection()
    if isProtected or not character or not humanoid then return end
    
    connections.stateChanged = humanoid.StateChanged:Connect(onStateChanged)
    connections.descendantAdded = character.DescendantAdded:Connect(onDescendantAdded)
    
    isProtected = true
    print("[Guarda-Costas v5] Ativado. Proteção máxima.")
end

local function disableProtection()
    if not isProtected then return end
    
    for _, conn in pairs(connections) do
        if conn then
            conn:Disconnect()
        end
    end
    connections = {}
    
    isProtected = false
    print("[Guarda-Costas v5] Desativado. Proteção desligada.")
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BodyguardGUI"
screenGui.Parent = player.PlayerGui
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 180, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Draggable = true
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BorderSizePixel = 2
toggleButton.BorderColor3 = Color3.fromRGB(255, 255, 255)

local function updateButton()
    if isProtected then
        toggleButton.Text = "Proteção: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(45, 179, 83)
    else
        toggleButton.Text = "Proteção: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end

local function toggle()
    if isProtected then
        disableProtection()
    else
        enableProtection()
    end
    updateButton()
end

toggleButton.MouseButton1Click:Connect(toggle)

local function setupCharacter(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    if isProtected then
        enableProtection()
    end
end

player.CharacterAdded:Connect(setupCharacter)
if player.Character then
    setupCharacter(player.Character)
end

enableProtection()
updateButton()
