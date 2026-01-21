local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")local player = Players.LocalPlayer
StarterGui:SetCore("ResetButtonCallback", false)  -- Anti-reset pra God funcionarlocal screenGui = Instance.new("ScreenGui")
screenGui.Name = "HacksGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false-- Main Frame (aumentado pra AutoFarm)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 320)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGuilocal frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFramelocal frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(60, 60, 60)
frameStroke.Thickness = 1
frameStroke.Parent = mainFrame-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 35)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = " HACKS MM2"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame-- Fly Button
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.85, 0, 0, 35)
flyBtn.Position = UDim2.new(0.075, 0, 0.18, 0)
flyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
flyBtn.Text = "Fly: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextScaled = true
flyBtn.Font = Enum.Font.GothamSemibold
flyBtn.Parent = mainFramelocal flyCorner = frameCorner:Clone()
flyCorner.Parent = flyBtn
local flyStroke = frameStroke:Clone()
flyStroke.Parent = flyBtn-- God Button (melhorado pra MM2)
local godBtn = Instance.new("TextButton")
godBtn.Size = flyBtn.Size
godBtn.Position = UDim2.new(0.075, 0, 0.42, 0)
godBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
godBtn.Text = "God: OFF"
godBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
godBtn.TextScaled = true
godBtn.Font = Enum.Font.GothamSemibold
godBtn.Parent = mainFramelocal godCorner = frameCorner:Clone()
godCorner.Parent = godBtn
local godStroke = frameStroke:Clone()
godStroke.Parent = godBtn-- Noclip Button
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = flyBtn.Size
noclipBtn.Position = UDim2.new(0.075, 0, 0.66, 0)
noclipBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipBtn.TextScaled = true
noclipBtn.Font = Enum.Font.GothamSemibold
noclipBtn.Parent = mainFramelocal noclipCorner = frameCorner:Clone()
noclipCorner.Parent = noclipBtn
local noclipStroke = frameStroke:Clone()
noclipStroke.Parent = noclipBtn-- AutoFarm Coins Button (novo: voa e coleta auto!)
local autofarmBtn = Instance.new("TextButton")
autofarmBtn.Size = flyBtn.Size
autofarmBtn.Position = UDim2.new(0.075, 0, 0.90, 0)
autofarmBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
autofarmBtn.Text = "AutoFarm: OFF"
autofarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autofarmBtn.TextScaled = true
autofarmBtn.Font = Enum.Font.GothamSemibold
autofarmBtn.Parent = mainFramelocal autofarmCorner = frameCorner:Clone()
autofarmCorner.Parent = autofarmBtn
local autofarmStroke = frameStroke:Clone()
autofarmStroke.Parent = autofarmBtn-- Minimize Button
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 35, 0, 30)
minBtn.Position = UDim2.new(1, -42, 0, 2)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
minBtn.Text = "–"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainFramelocal minCorner = frameCorner:Clone()
minCorner.Parent = minBtn-- Variables
local flying = false
local godmode = false
local noclipping = false
local autofarming = false
local minimized = false
local bodyVelocity = nil
local forcefield = nil
local keys = {W = false, A = false, S = false, D = false, Space = false, LShift = false}-- Dragging (igual)
local dragging = false
local dragStart = nil
local startPos = nilmainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)-- Key Input (só pra fly manual)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = true
    elseif input.KeyCode == Enum.KeyCode.A then keys.A = true
    elseif input.KeyCode == Enum.KeyCode.S then keys.S = true
    elseif input.KeyCode == Enum.KeyCode.D then keys.D = true
    elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = true
    elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.LShift = true end
end)UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then keys.W = false
    elseif input.KeyCode == Enum.KeyCode.A then keys.A = false
    elseif input.KeyCode == Enum.KeyCode.S then keys.S = false
    elseif input.KeyCode == Enum.KeyCode.D then keys.D = false
    elseif input.KeyCode == Enum.KeyCode.Space then keys.Space = false
    elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.LShift = false end
end)-- Main Loop SUPER MELHORADO (God pra MM2 + AutoFarm Coins)
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end-- GOD MODE MELHORADO PRA MM2 (huge health + ForceField + anti-reset já setado)
if godmode then
    hum.MaxHealth = math.huge
    hum.Health = math.huge
    if not char:FindFirstChild("ForceField") then
        forcefield = Instance.new("ForceField")
        forcefield.Parent = char
    end
else
    if char:FindFirstChild("ForceField") then
        char.ForceField:Destroy()
        forcefield = nil
    end
end

-- FLY + AUTO FARM COINS (voa direto pras moedas no MM2!)
if flying then
    if not bodyVelocity or not bodyVelocity.Parent then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = root
        root:SetNetworkOwner(player)
    end
    hum.PlatformStand = true

    local camera = workspace.CurrentCamera
    local moveVector = Vector3.new(0, 0, 0)

    -- AUTO FARM: acha moeda mais próxima e voa pra ela!
    if autofarming then
        local charPos = root.Position
        local shortestDistance = math.huge
        local targetPos = nil
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "Coin" and obj:FindFirstChild("Coin") then  -- Estrutura das moedas MM2
                local coinPart = obj.Coin
                local dist = (charPos - coinPart.Position).Magnitude
                if dist < shortestDistance and dist < 500 then  -- Só moedas próximas pra otimizado
                    shortestDistance = dist
                    targetPos = coinPart.Position
                end
            end
        end
        if targetPos then
            local direction = (targetPos - charPos)
            moveVector = direction.Unit * (direction.Magnitude > 10 and 200 or 50)  -- Acelera + freia perto
        else
            moveVector = Vector3.new(0, 0.1, 0)  -- Hover se sem moedas
        end
    else
        -- Fly manual normal
        if keys.W then moveVector = moveVector + camera.CFrame.LookVector end
        if keys.S then moveVector = moveVector - camera.CFrame.LookVector end
        if keys.A then moveVector = moveVector - camera.CFrame.RightVector end
        if keys.D then moveVector = moveVector + camera.CFrame.RightVector end
        if keys.Space then moveVector = moveVector + Vector3.new(0, 1, 0) end
        if keys.LShift then moveVector = moveVector - Vector3.new(0, 1, 0) end
    end

    if moveVector.Magnitude > 0 then
        bodyVelocity.Velocity = moveVector.Unit * 100
    else
        bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
    end
else
    hum.PlatformStand = false
    if bodyVelocity then bodyVelocity:Destroy(); bodyVelocity = nil end
    root:SetNetworkOwner(nil)
end

-- Noclip
if noclipping then
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
endend)-- Toggles
local function toggleFly()
    flying = not flying
    flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
    flyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
flyBtn.MouseButton1Click:Connect(toggleFly)local function toggleGod()
    godmode = not godmode
    godBtn.Text = godmode and "God: ON" or "God: OFF"
    godBtn.BackgroundColor3 = godmode and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
godBtn.MouseButton1Click:Connect(toggleGod)local function toggleNoclip()
    noclipping = not noclipping
    noclipBtn.Text = noclipping and "Noclip: ON" or "Noclip: OFF"
    noclipBtn.BackgroundColor3 = noclipping and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
noclipBtn.MouseButton1Click:Connect(toggleNoclip)local function toggleAutofarm()
    autofarming = not autofarming
    flying = autofarming  -- Liga fly auto pra farm
    flyBtn.Text = flying and "Fly: ON" or "Fly: OFF"  -- Sync
    flyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
    autofarmBtn.Text = autofarming and "AutoFarm: ON" or "AutoFarm: OFF"
    autofarmBtn.BackgroundColor3 = autofarming and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(255, 0, 0)
end
autofarmBtn.MouseButton1Click:Connect(toggleAutofarm)-- Minimize (atualizado)
local function toggleMinimize()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        flyBtn.Visible = false
        godBtn.Visible = false
        noclipBtn.Visible = false
        autofarmBtn.Visible = false
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 45)}):Play()
    else
        minBtn.Text = "–"
        local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 220, 0, 320)})
        tween:Play()
        tween.Completed:Connect(function()
            flyBtn.Visible = true
            godBtn.Visible = true
            noclipBtn.Visible = true
            autofarmBtn.Visible = true
        end)
    end
end
minBtn.MouseButton1Click:Connect(toggleMinimize)

