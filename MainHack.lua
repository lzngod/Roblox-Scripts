local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HacksGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 160)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(60, 60, 60)
frameStroke.Thickness = 1
frameStroke.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🛡️ HACKS"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Fly Button
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.85, 0, 0, 35)
flyBtn.Position = UDim2.new(0.075, 0, 0.28, 0)
flyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextScaled = true
flyBtn.Font = Enum.Font.GothamSemibold
flyBtn.Parent = mainFrame

local flyCorner = frameCorner:Clone()
flyCorner.Parent = flyBtn

local flyStroke = frameStroke:Clone()
flyStroke.Parent = flyBtn

-- God Button
local godBtn = Instance.new("TextButton")
godBtn.Size = flyBtn.Size
godBtn.Position = UDim2.new(0.075, 0, 0.55, 0)
godBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
godBtn.Text = "God: OFF"
godBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
godBtn.TextScaled = true
godBtn.Font = Enum.Font.GothamSemibold
godBtn.Parent = mainFrame

local godCorner = frameCorner:Clone()
godCorner.Parent = godBtn

local godStroke = frameStroke:Clone()
godStroke.Parent = godBtn

-- Minimize Button
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 35, 0, 30)
minBtn.Position = UDim2.new(1, -42, 0, 2)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
minBtn.Text = "–"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainFrame

local minCorner = frameCorner:Clone()
minCorner.Parent = minBtn

-- Variables
local flying = false
local godmode = false
local minimized = false
local bodyVelocity = nil
local keys = {W = false, A = false, S = false, D = false, Space = false, LShift = false}

-- Dragging
local dragging = false
local dragStart = nil
local startPos = nil

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Key Input
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = true
    elseif input.KeyCode == Enum.KeyCode.A then keys.A = true
    elseif input.KeyCode == Enum.KeyCode.S then keys.S = true
    elseif input.KeyCode == Enum.KeyCode.D then keys.D = true
    elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = true
    elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.LShift = true end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = false
    elseif input.KeyCode == Enum.KeyCode.A then keys.A = false
    elseif input.KeyCode == Enum.KeyCode.S then keys.S = false
    elseif input.KeyCode == Enum.KeyCode.D then keys.D = false
    elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = false
    elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.LShift = false end
end)

-- Fly Loop
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    if flying then
        if not bodyVelocity or not bodyVelocity.Parent then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.Parent = root
        end
        hum.PlatformStand = true

        local camera = workspace.CurrentCamera
        local moveVector = Vector3.new(0, 0, 0)
        if keys.W then moveVector = moveVector + camera.CFrame.LookVector end
        if keys.S then moveVector = moveVector - camera.CFrame.LookVector end
        if keys.A then moveVector = moveVector - camera.CFrame.RightVector end
        if keys.D then moveVector = moveVector + camera.CFrame.RightVector end
        if keys.Space then moveVector = moveVector + Vector3.new(0, 1, 0) end
        if keys.LShift then moveVector = moveVector - Vector3.new(0, 1, 0) end

        if moveVector.Magnitude > 0 then
            bodyVelocity.Velocity = moveVector.Unit * 50
        else
            bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
        end
    else
        hum.PlatformStand = false
        if bodyVelocity and bodyVelocity.Parent then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end)

-- God Loop
RunService.Heartbeat:Connect(function()
    if godmode then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
        end
    end
end)

-- Toggle Fly
local function toggleFly()
    flying = not flying
    flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
    flyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
flyBtn.MouseButton1Click:Connect(toggleFly)

-- Toggle God
local function toggleGod()
    godmode = not godmode
    godBtn.Text = godmode and "God: ON" or "God: OFF"
    godBtn.BackgroundColor3 = godmode and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
godBtn.MouseButton1Click:Connect(toggleGod)

-- Toggle Minimize
local function toggleMinimize()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        flyBtn.Visible = false
        godBtn.Visible = false
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 45)}):Play()
    else
        minBtn.Text = "–"
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 160)})
        tween:Play()
        tween.Completed:Connect(function()
            flyBtn.Visible = true
            godBtn.Visible = true
        end)
    end
end
minBtn.MouseButton1Click:Connect(toggleMinimize)
