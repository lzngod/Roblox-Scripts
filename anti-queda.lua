local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isAntiRagdollActive = false
local originalName = "Ragdoll"
local disabledName = "Ragdoll_DISABLED_BY_SCRIPT"

local ragdollEvent = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Ragdoll"):WaitForChild(originalName)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiRagdollGUI"
screenGui.Parent = playerGui

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 150, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.AnchorPoint = Vector2.new(0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BorderSizePixel = 2
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 16
toggleButton.Text = "Anti-Ragdoll: OFF"

local function updateButtonState()
    if isAntiRagdollActive then
        toggleButton.Text = "Anti-Ragdoll: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        toggleButton.Text = "Anti-Ragdoll: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end

local function toggleAntiRagdoll()
    isAntiRagdollActive = not isAntiRagdollActive

    if isAntiRagdollActive then
        if ragdollEvent then
            ragdollEvent.Name = disabledName
            print("[Anti-Ragdoll] Ativado.")
        end
    else
        if ragdollEvent then
            ragdollEvent.Name = originalName
            print("[Anti-Ragdoll] Desativado.")
        end
    end
    
    updateButtonState()
end

if not ragdollEvent then
    toggleButton.Text = "ERRO: Evento não encontrado"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggleButton.Active = false
    warn("[Anti-Ragdoll] AVISO: Não foi possível encontrar o evento 'Ragdoll'. O jogo pode ter atualizado.")
else
    toggleButton.MouseButton1Click:Connect(toggleAntiRagdoll)
end
