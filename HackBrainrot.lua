local player = game.Players.LocalPlayer

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ToggleMenuGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- GUI Frame (menu utama)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 170)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0) -- posisi tengah layar
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Tambahkan UICorner
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = frame

-- Tambahkan UIStroke
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(47, 229, 255) -- warna garis
stroke.Thickness = 1.7
stroke.Parent = frame

-- Layout dan padding
local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 8)
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local padding = Instance.new("UIPadding", frame)
padding.PaddingTop = UDim.new(0, 12)

-- Fungsi Tambah Toggle
local function AddToggle(data)
    local toggleState = data.Default or false

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 32)
    button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = data.Name
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.BorderSizePixel = 0
    button.Parent = frame
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button

    local icon = Instance.new("Frame")
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(1, -26, 0.5, -9)
    icon.BackgroundColor3 = toggleState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(150, 150, 150)
    icon.BorderSizePixel = 0
    icon.Parent = button
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = icon

    button.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        icon.BackgroundColor3 = toggleState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(150, 150, 150)
        if data.Callback then
            data.Callback(toggleState)
        end
    end)
end

-- Toggle Auto Steal
AddToggle({
    Name = "Auto Steal",
    Default = false,
    Callback = function(v)
        if v then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/nabaruBrainrot"))()
        end
    end
})

-- Infinite Jump
local infJumpEnabled = false
local UserInputService = game:GetService("UserInputService")
local humanoid = nil

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

player.CharacterAdded:Connect(function(character)
    if infJumpEnabled then
        humanoid = character:WaitForChild("Humanoid")
    end
end)

AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(v)
        infJumpEnabled = v
        if v and player.Character then
            humanoid = player.Character:WaitForChild("Humanoid")
        else
            humanoid = nil
        end
        print("Infinite Jump:", v)
    end
})

-- Toggle SkyWalk
AddToggle({
    Name = "SkyWalk",
    Default = false,
    Callback = function(v)
        local plr = player
        local skyPartName = "SkyWalk"

        local function toggleSkyWalk(enabled)
            local character = plr.Character or plr.CharacterAdded:Wait()
            if not character:FindFirstChild("Head") or not character:FindFirstChild("HumanoidRootPart") then return end

            if enabled then
                local old = workspace:FindFirstChild(skyPartName)
                if old then old:Destroy() end

                local skyPart = Instance.new("Part")
                skyPart.Name = skyPartName
                skyPart.Size = Vector3.new(1000, 1, 1000)
                skyPart.Anchored = true
                skyPart.Transparency = 1
                skyPart.CanCollide = true
                skyPart.Material = Enum.Material.Neon
                skyPart.BrickColor = BrickColor.new("Cyan")
                skyPart.Position = character.Head.Position + Vector3.new(0, 7, 0)
                skyPart.Parent = workspace

                task.wait(0.1)
                character.HumanoidRootPart.CFrame = CFrame.new(skyPart.Position + Vector3.new(0, 3, 0))
            else
                local old = workspace:FindFirstChild(skyPartName)
                if old then old:Destroy() end
            end
        end

        toggleSkyWalk(v)
        print("SkyWalk Toggle:", v)
    end
})

-- Toggle Reset
AddToggle({
    Name = "Reset",
    Default = false,
    Callback = function(v)
        print("Reset:", v)
        if v then
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0 -- Reset ao zerar a vida
            end
        end
    end
})

-- Tombol Open/Close
local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "OpenCloseButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 50, 0.2, 0)
toggleButton.Image = "rbxassetid://121962590520433"
toggleButton.BackgroundTransparency = 1
toggleButton.Parent = screenGui
toggleButton.Active = true
toggleButton.Draggable = true

local uiCornerButton = Instance.new("UICorner")
uiCornerButton.CornerRadius = UDim.new(0, 12)
uiCornerButton.Parent = toggleButton

local isOpen = false
toggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    frame.Visible = isOpen
end)

-- Notificação
game.StarterGui:SetCore("SendNotification", {
    Title = "Script Executado com Sucesso",
    Text = "Criado por FaDhen",
    Icon = "rbxthumb://type=AvatarHeadShot&id=6027385792&w=150&h=150",
    Duration = 5
})

-- Função pra processar BillboardGui
local function processBillboardIfNeeded(obj)
    if obj:IsA("BasePart") and obj.Name == "Main" then
        local parent = obj.Parent
        while parent do
            if parent:IsA("Folder") and parent.Name == "Purchases" then
                for _, child in ipairs(obj:GetChildren()) do
                    if child:IsA("BillboardGui") then
                        child.Size = UDim2.new(0, 180, 0, 150)
                        child.MaxDistance = 80
                        child.StudsOffset = Vector3.new(0, 5, 0)
                        print("✅ BillboardGui ajustado:", obj:GetFullName())
                    end
                end
                break
            end
            parent = parent.Parent
        end
    end
end

-- Processar objetos existentes
for _, obj in ipairs(workspace:GetDescendants()) do
    processBillboardIfNeeded(obj)
end

-- Monitorar novos objetos
workspace.DescendantAdded:Connect(processBillboardIfNeeded)

-- InstanToggle para ProximityPrompts
local instanToggleAktif = true

local function setAllPromptsInstant(active)
    for _, prompt in ipairs(game:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            prompt.HoldDuration = active and 0 or 1
        end
    end
end

setAllPromptsInstant(instanToggleAktif)

game.DescendantAdded:Connect(function(desc)
    if desc:IsA("ProximityPrompt") and instanToggleAktif then
        desc.HoldDuration = 0
    end
end)
