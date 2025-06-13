local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "data.txt"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 170)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(47, 229, 255)
stroke.Thickness = 1.7
stroke.Parent = frame
local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 8)
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local padding = Instance.new("UIPadding", frame)
padding.PaddingTop = UDim.new(0, 12)
local function createToggle(params)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0.9, 0, 0, 32)
    toggle.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    toggle.BorderSizePixel = 0
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Text = params.Name
    toggle.TextXAlignment = Enum.TextXAlignment.Left
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 18
    toggle.Parent = frame
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 18, 0, 18)
    indicator.Position = UDim2.new(1, -26, 0.5, -9)
    indicator.BackgroundColor3 = params.Default and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(150, 150, 150)
    indicator.BorderSizePixel = 0
    indicator.Parent = toggle
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(1, 0)
    local state = params.Default or false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        indicator.BackgroundColor3 = state and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(150, 150, 150)
        if params.Callback then
            params.Callback(state)
        end
    end)
end
createToggle({
    Name = "&serverplaceid=0",
    Default = false,
    Callback = function(state)
        if state then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/Script%20Brainrot%20New"))()
        end
    end
})
local infJump = false
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local player = players.LocalPlayer
local humanoid = nil
runService.JumpRequest:Connect(function()
    if infJump and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
local function onCharacterAdded(char)
    if infJump then
        humanoid = char:WaitForChild("Humanoid")
    end
end
player.CharacterAdded:Connect(onCharacterAdded)
createToggle({
    Name = "Neon",
    Default = false,
    Callback = function(state)
        local players = game:GetService("Players")
        local player = players.LocalPlayer
        local platformName = "Platform"
        local function updatePlatform(enabled)
            local character = player.Character or player.CharacterAdded:Wait()
            if not character:FindFirstChild("Head") or not character:FindFirstChild("HumanoidRootPart") then
                return
            end
            if enabled then
                local platform = workspace:FindFirstChild(platformName)
                if platform then
                    platform:Destroy()
                end
                local newPlatform = Instance.new("Part")
                newPlatform.Name = platformName
                newPlatform.Size = Vector3.new(1000, 1, 1000)
                newPlatform.Transparency = 1
                newPlatform.CanCollide = true
                newPlatform.Material = Enum.Material.Neon
                newPlatform.BrickColor = BrickColor.new("Really red")
                newPlatform.Position = character.Head.Position + Vector3.new(0, 7, 0)
                newPlatform.Anchored = true
                newPlatform.Parent = workspace
                task.wait(0.1)
                character.HumanoidRootPart.CFrame = CFrame.new(newPlatform.Position + Vector3.new(0, 3, 0))
            else
                local platform = workspace:FindFirstChild(platformName)
                if platform then
                    platform:Destroy()
                end
            end
        end
        updatePlatform(state)
        print("✅ Platform toggled:", state)
    end
})
createToggle({
    Name = "1",
    Default = false,
    Callback = function(state)
        print("✅ Kill toggled:", state)
        if state then
            local player = game.Players.LocalPlayer
            if player and player.Character then
                player.Character:BreakJoints()
            end
        end
    end
})
local button = Instance.new("ImageButton")
button.Name = "ToggleButton"
button.Size = UDim2.new(0, 50, 0, 50)
button.Position = UDim2.new(0, 50, 0.2, 0)
button.Image = "rbxassetid://14374987948"
button.BackgroundTransparency = 1
button.Parent = screenGui
button.Active = true
button.Draggable = true
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button
local isVisible = false
button.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    frame.Visible = isVisible
end)
game.StarterGui:SetCore("SendNotification", {
    Title = "Really red",
    Text = "Platform",
    Icon = "rbxassetid://15009557167",
    Duration = 5
})
local function modifyBillboard(obj)
    if obj:IsA("BillboardGui") and obj.Name == "NameTag" then
        local parent = obj.Parent
        while parent do
            if parent:IsA("Model") and parent.Name == "NPC" then
                for _, child in ipairs(obj:GetChildren()) do
                    if child:IsA("TextLabel") then
                        child.Size = UDim2.new(0, 180, 0, 150)
                        child.MaxDistance = 80
                        child.StudsOffset = Vector3.new(0, 5, 0)
                        print("✅ BillboardGui diubah:", obj:GetFullName())
                    end
                end
            end
            parent = parent.Parent
        end
    end
end
for _, obj in ipairs(workspace:GetDescendants()) do
    modifyBillboard(obj)
end
workspace.DescendantAdded:Connect(function(obj)
    modifyBillboard(obj)
end)
local instantInteract = true
local function updateInteractables(state)
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            obj.HoldDuration = state and 0 or 1
        end
    end
end
updateInteractables(instantInteract)
game.DescendantAdded:Connect(function(obj)
    if obj:IsA("ClickDetector") and instantInteract then
        obj.HoldDuration = 0
    end
end)
