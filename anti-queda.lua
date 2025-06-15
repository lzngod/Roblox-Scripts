local player = game:GetService("Players").LocalPlayer

local character
local humanoid

local invisEnabled = false
local originalTransparencies = {}

-- [[ GUI ]]

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AbilityGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 80)
mainFrame.Position = UDim2.new(0, 20, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", mainFrame).Color = Color3.fromRGB(80, 80, 100)

local layout = Instance.new("UIListLayout", mainFrame)
layout.Padding = UDim.new(0, 8)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top

local padding = Instance.new("UIPadding", mainFrame)
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 0, 25)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Text = "Habilidade"
titleLabel.LayoutOrder = 0
titleLabel.Parent = mainFrame

local function createToggle(data)
    local state = data.Default or false

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    button.TextColor3 = Color3.fromRGB(220, 220, 220)
    button.Text = "  " .. data.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.LayoutOrder = data.Order
    button.Parent = mainFrame
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 8, 0.6, 0)
    indicator.Position = UDim2.new(1, -20, 0.5, 0)
    indicator.AnchorPoint = Vector2.new(0.5, 0.5)
    indicator.BackgroundColor3 = state and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(255, 85, 85)
    indicator.Parent = button
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)

    button.MouseButton1Click:Connect(function()
        state = not state
        indicator.BackgroundColor3 = state and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(255, 85, 85)
        if data.Callback then
            pcall(data.Callback, state)
        end
    end)
    return button
end

-- [[ FUNÇÃO DA HABILIDADE ]]

local function setInvisibility(enabled)
    invisEnabled = enabled
    if not character then return end
    if enabled then
        originalTransparencies = {}
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                originalTransparencies[part] = part.Transparency
                part.Transparency = 1
            end
        end
        if humanoid then humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
    else
        for part, transparency in pairs(originalTransparencies) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
        originalTransparencies = {}
        if humanoid then humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer end
    end
end

-- [[ CRIAR BOTÃO ]]

createToggle({ Name = "Invisibilidade", Order = 1, Callback = setInvisibility, Default = false })

-- [[ GERENCIAMENTO DE PERSONAGEM ]]

local function onCharacterAdded(char)
    character = char
    humanoid = char:WaitForChild("Humanoid")
    
    if invisEnabled then setInvisibility(true) end
end

if player.Character then onCharacterAdded(player.Character) end
player.CharacterAdded:Connect(onCharacterAdded)
