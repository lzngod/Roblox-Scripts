local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
StarterGui:SetCore("ResetButtonCallback", false)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HacksGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 320)
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
title.Text = "🛡️ HACKS MM2 ✅"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Fly Button
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.85, 0, 0, 35)
flyBtn.Position = UDim2.new(0.075, 0, 0.18, 0)
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
godBtn.Position = UDim2.new(0.075, 0, 0.42, 0)
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

-- Noclip Button
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = flyBtn.Size
noclipBtn.Position = UDim2.new(0.075, 0, 0.66, 0)
noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextScaled = true
noclipBtn.Font = Enum.Font.GothamSemibold
noclipBtn.Parent = mainFrame

local noclipCorner = frameCorner:Clone()
noclipCorner.Parent = noclipBtn
local noclipStroke = frameStroke:Clone()
noclipStroke.Parent = noclipBtn

-- AutoFarm Button
local autofarmBtn = Instance.new("TextButton")
autofarmBtn.Size = flyBtn.Size
autofarmBtn.Position = UDim2.new(0.075, 0, 0.90, 0)
autofarmBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
autofarmBtn.Text = "AutoFarm: OFF"
autofarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autofarmBtn.TextScaled = true
autofarmBtn.Font = Enum.Font.GothamSemibold
autofarmBtn.Parent = mainFrame

local autofarmCorner = frameCorner:Clone()
autofarmCorner.Parent = autofarmBtn
local autofarmStroke = frameStroke:Clone()
autofarmStroke.Parent = autofarmBtn

-- Minimize
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

-- Vars
local flying = false
local godmode = false
local noclipping = false
local autofarming = false
local minimized = false
local bodyVelocity = nil
local forcefield = nil
local keys = {W = false, A = false, S = false, D = false, Space = false, LShift = false}

-- Godmode function (MM2 fix: humanoid clone bypass)
local function godmodefunc(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum.Name = "1"
        local cl = hum:Clone()
        cl.Name = "Humanoid"
        cl.MaxHealth = math.huge
        cl.Health = math.huge
        cl.Parent = char
        hum:Destroy()
        workspace.CurrentCamera.CameraSubject = cl
        local anim = char:FindFirstChild("Animate")
        if anim then
            anim.Disabled = true
            spawn(function()
                wait(0.1)
                anim.Disabled = false
            end)
        end
    end
end

-- Character respawn handler for god
local function onCharacterAdded(char)
    char:WaitForChild("HumanoidRootPart", 5)
    char.ChildAdded:Connect(function(child)
        if child.Name == "Humanoid" and godmode then
            wait(0.5)  -- Wait stable
            godmodefunc(char)
        end
    end)
    if godmode then
        wait(1)
        godmodefunc(char)
    end
end
player.CharacterAdded:Connect(onCharacterAdded)
if player.Character then
    onCharacterAdded(player.Character)
end

-- Dragging (same)
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

-- Key input (manual fly only)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    local kc = input.KeyCode
    if kc == Enum.KeyCode.W then keys.W = true
    elseif kc == Enum.KeyCode.A then keys.A = true
    elseif kc == Enum.KeyCode.S then keys.S = true
    elseif kc == Enum.KeyCode.D then keys.D = true
    elseif kc == Enum.KeyCode.Space then keys.Space = true
    elseif kc == Enum.KeyCode.LeftShift then keys.LShift = true end
end)

UserInputService.InputEnded:Connect(function(input, gp)
    if gp then return end
    local kc = input.KeyCode
    if kc == Enum.KeyCode.W then keys.W = false
    elseif kc == Enum.KeyCode.A then keys.A = false
    elseif kc == Enum.KeyCode.S then keys.S = false
    elseif kc == Enum.KeyCode.D then keys.D = false
    elseif kc == Enum.KeyCode.Space then keys.Space = false
    elseif kc == Enum.KeyCode.LeftShift then keys.LShift = false end
end)

-- Main Loop
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end

    -- God reinforce (MM2 bulletproof)
    if godmode then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        if not char:FindFirstChild("ForceField") then
            forcefield = Instance.new("ForceField")
            forcefield.Parent = char
        end
        -- Anti-die
        hum.Died:Connect(function() hum.Health = math.huge end)
    else
        if forcefield then forcefield:Destroy(); forcefield = nil end
    end

    -- Fly + AutoFarm
    if flying then
        if not bodyVelocity or not bodyVelocity.Parent then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bodyVelocity.Parent = root
            root:SetNetworkOwner(player)
        end
        hum.PlatformStand = true

        local vel = Vector3.new(0, 0, 0)
        local cam = workspace.CurrentCamera

        if autofarming then
            -- FIXADO: Coins são BasePart "Coin" direto no workspace!
            local pos = root.Position
            local distMin = math.huge
            local targetPos = nil
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj:IsA("BasePart") and obj.Name == "Coin" then
                    local dist = (pos - obj.Position).Magnitude
                    if dist < distMin and dist < 1000 and dist > 8 then
                        distMin = dist
                        targetPos = obj.Position
                    end
                end
            end
            if targetPos then
                local dir = (targetPos - pos).Unit
                local speed = distMin > 30 and 200 or 70
                vel = dir * speed
            end
            -- else vel=0 (hover)
        else
            -- Manual fly
            local moveDir = Vector3.new(0,0,0)
            if keys.W then moveDir = moveDir + cam.CFrame.LookVector end
            if keys.S then moveDir = moveDir - cam.CFrame.LookVector end
            if keys.A then moveDir = moveDir - cam.CFrame.RightVector end
            if keys.D then moveDir = moveDir + cam.CFrame.RightVector end
            if keys.Space then moveDir = moveDir + Vector3.yAxis end
            if keys.LShift then moveDir = moveDir - Vector3.yAxis end
            if moveDir.Magnitude > 0 then
                vel = moveDir.Unit * 100
            end
        end

        bodyVelocity.Velocity = vel
    else
        hum.PlatformStand = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        root:SetNetworkOwner(nil)
    end

    -- Noclip
    if noclipping then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- Toggles
local function toggleFly()
    flying = not flying
    flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
    flyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
flyBtn.MouseButton1Click:Connect(toggleFly)

local function toggleGod()
    godmode = not godmode
    godBtn.Text = godmode and "God: ON" or "God: OFF"
    godBtn.BackgroundColor3 = godmode and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
    if player.Character and godmode then
        godmodefunc(player.Character)
    end
end
godBtn.MouseButton1Click:Connect(toggleGod)

local function toggleNoclip()
    noclipping = not noclipping
    noclipBtn.Text = noclipping and "Noclip: ON" or "Noclip: OFF"
    noclipBtn.BackgroundColor3 = noclipping and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
noclipBtn.MouseButton1Click:Connect(toggleNoclip)

local function toggleAutofarm()
    autofarming = not autofarming
    flying = autofarming  -- Auto fly
    toggleFly()  -- Update UI
    autofarmBtn.Text = autofarming and "AutoFarm: ON" or "AutoFarm: OFF"
    autofarmBtn.BackgroundColor3 = autofarming and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
autofarmBtn.MouseButton1Click:Connect(toggleAutofarm)

-- Minimize
local function toggleMinimize()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        flyBtn.Visible = godBtn.Visible = noclipBtn.Visible = autofarmBtn.Visible = false
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 45)}):Play()
    else
        minBtn.Text = "–"
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 320)})
        tween:Play()
        tween.Completed:Wait()
        flyBtn.Visible = godBtn.Visible = noclipBtn.Visible = autofarmBtn.Visible = true
    end
end
minBtn.MouseButton1Click:Connect(toggleMinimize)
