local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
StarterGui:SetCore("ResetButtonCallback", false)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2Hacks"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal (arrastável)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 340)
mainFrame.Position = UDim2.new(0.01, 0, 0.01, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Título (parte do drag)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "MM2 HACKS - FIXED"
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = mainFrame

-- Botões
local function createBtn(yPos, defaultText)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.88, 0, 0, 45)
    btn.Position = UDim2.new(0.06, 0, yPos, 0)
    btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    btn.Text = defaultText
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextScaled = true
    btn.Parent = mainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    return btn
end

local flyBtn = createBtn(0.15, "Fly: OFF")
local godBtn = createBtn(0.30, "God: OFF")
local noclipBtn = createBtn(0.45, "Noclip: OFF")
local farmBtn = createBtn(0.60, "AutoFarm Coins: OFF")

-- Minimize
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 40, 0, 35)
minBtn.Position = UDim2.new(1, -50, 0, 2)
minBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
minBtn.Text = "–"
minBtn.TextColor3 = Color3.white
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainFrame
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 8)

-- Variáveis
local flying = false
local godmode = false
local noclipping = false
local autofarming = false
local minimized = false
local linearVel = nil
local keys = {}

-- Drag function
local dragging, dragInput, dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Teclas fly manual
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        keys[input.KeyCode] = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        keys[input.KeyCode] = false
    end
end)

-- Toggle visual
local function toggleVisual(btn, state)
    btn.Text = btn.Text:gsub("OFF", state and "ON" or "OFF")
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    toggleVisual(flyBtn, flying)
end)

godBtn.MouseButton1Click:Connect(function()
    godmode = not godmode
    toggleVisual(godBtn, godmode)
end)

noclipBtn.MouseButton1Click:Connect(function()
    noclipping = not noclipping
    toggleVisual(noclipBtn, noclipping)
end)

farmBtn.MouseButton1Click:Connect(function()
    autofarming = not autofarming
    toggleVisual(farmBtn, autofarming)
    if autofarming then
        flying = true
        toggleVisual(flyBtn, true)
        noclipping = true  -- Noclip auto no farm
        toggleVisual(noclipBtn, true)
    end
end)

-- Minimize/Maximize
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 240, 0, 50)}):Play()
        flyBtn.Visible = false
        godBtn.Visible = false
        noclipBtn.Visible = false
        farmBtn.Visible = false
        title.Visible = false
    else
        minBtn.Text = "–"
        TweenService:Create(mainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 240, 0, 340)}):Play()
        task.delay(0.35, function()
            flyBtn.Visible = true
            godBtn.Visible = true
            noclipBtn.Visible = true
            farmBtn.Visible = true
            title.Visible = true
        end)
    end
end)

-- God mode on respawn
player.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum and godmode then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
    end
end)

-- Loop principal
RunService.Heartbeat:Connect(function(dt)
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    -- God
    if godmode then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        if not char:FindFirstChild("ForceField") then
            Instance.new("ForceField", char)
        end
    end

    -- Fly + AutoFarm (LinearVelocity pra liso)
    if flying or autofarming then
        if not linearVel then
            linearVel = Instance.new("LinearVelocity")
            linearVel.MaxForce = math.huge
            linearVel.VectorVelocity = Vector3.zero
            linearVel.Attachment0 = Instance.new("Attachment", root)
            linearVel.Parent = root
            root:SetNetworkOwner(player)
        end
        hum.PlatformStand = true

        local targetVel = Vector3.zero
        local cam = workspace.CurrentCamera

        if autofarming then
            local closest, minDist = nil, 2000
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name == "Coin") then
                    local dist = (root.Position - obj.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = obj
                    end
                end
            end
            if closest then
                local dir = (closest.Position - root.Position).Unit
                local speed = minDist > 40 and 250 or 80  -- Mais rápido e suave
                targetVel = dir * speed
            end
        else
            -- Manual
            local move = Vector3.zero
            if keys[Enum.KeyCode.W] then move += cam.CFrame.LookVector end
            if keys[Enum.KeyCode.S] then move -= cam.CFrame.LookVector end
            if keys[Enum.KeyCode.A] then move -= cam.CFrame.RightVector end
            if keys[Enum.KeyCode.D] then move += cam.CFrame.RightVector end
            if keys[Enum.KeyCode.Space] then move += Vector3.yAxis end
            if keys[Enum.KeyCode.LeftShift] then move -= Vector3.yAxis end
            if move.Magnitude > 0 then
                targetVel = move.Unit * 110
            end
        end

        linearVel.VectorVelocity = targetVel
    else
        hum.PlatformStand = false
        if linearVel then
            linearVel:Destroy()
            linearVel = nil
        end
        if root then root:SetNetworkOwner(nil) end
    end

    -- Noclip
    if noclipping or autofarming then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("Script corrigido! GUI arrastável, minimize/maximize, toggles verde/vermelho, AutoFarm liso e com noclip auto.")
