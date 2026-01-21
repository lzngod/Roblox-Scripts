local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
StarterGui:SetCore("ResetButtonCallback", false)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2HacksFixed"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 350)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(70, 70, 70)
stroke.Thickness = 2
stroke.Parent = frame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🛡️ MM2 HACKS 2026"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Função pra criar botão
local function createButton(posY, textOff)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.Position = UDim2.new(0.075, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    btn.Text = textOff
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamSemibold
    btn.Parent = frame
    
    local btnCorner = corner:Clone()
    btnCorner.Parent = btn
    
    local btnStroke = stroke:Clone()
    btnStroke.Parent = btn
    
    return btn
end

-- Botões
local flyBtn = createButton(0.18, "Fly: OFF")
local godBtn = createButton(0.36, "God: OFF")
local noclipBtn = createButton(0.54, "Noclip: OFF")
local farmBtn = createButton(0.72, "AutoFarm: OFF")

-- Minimize botão
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 40, 0, 35)
minBtn.Position = UDim2.new(1, -50, 0, 2.5)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
minBtn.Text = "–"
minBtn.TextColor3 = Color3.white
minBtn.TextScaled = true
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = frame

local minCorner = corner:Clone()
minCorner.Parent = minBtn

-- Variáveis
local flying = false
local godmode = false
local noclipping = false
local autofarming = false
local minimized = false
local bodyVelocity = nil
local keys = {}

-- Draggin GUI
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Teclas
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    local kc = input.KeyCode.Name
    keys[kc] = true
end)

UserInputService.InputEnded:Connect(function(input, gp)
    if gp then return end
    local kc = input.KeyCode.Name
    keys[kc] = nil
end)

-- Toggle funções
local function updateBtn(btn, state, textOn, textOff)
    btn.Text = state and textOn or textOff
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 50, 50)
end

flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    updateBtn(flyBtn, flying, "Fly: ON", "Fly: OFF")
end)

godBtn.MouseButton1Click:Connect(function()
    godmode = not godmode
    updateBtn(godBtn, godmode, "God: ON", "God: OFF")
end)

noclipBtn.MouseButton1Click:Connect(function()
    noclipping = not noclipping
    updateBtn(noclipBtn, noclipping, "Noclip: ON", "Noclip: OFF")
end)

farmBtn.MouseButton1Click:Connect(function()
    autofarming = not autofarming
    updateBtn(farmBtn, autofarming, "AutoFarm: ON", "AutoFarm: OFF")
    if autofarming then
        flying = true
        updateBtn(flyBtn, true, "Fly: ON", "Fly: OFF")
    end
end)

-- Minimize
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 250, 0, 50)}):Play()
        flyBtn.Visible = godBtn.Visible = noclipBtn.Visible = farmBtn.Visible = title.Visible = false
    else
        minBtn.Text = "–"
        TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 250, 0, 350)}):Play()
        flyBtn.Visible = godBtn.Visible = noclipBtn.Visible = farmBtn.Visible = title.Visible = true
    end
end)

-- God no respawn
local function applyGod(char)
    task.wait(1)
    local hum = char:FindFirstChild("Humanoid")
    if hum and godmode then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
    end
end
player.CharacterAdded:Connect(applyGod)
if player.Character then applyGod(player.Character) end

-- Loop principal
RunService.Heartbeat:Connect(function()
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
            local ff = Instance.new("ForceField")
            ff.Parent = char
        end
    else
        if char:FindFirstChild("ForceField") then
            char.ForceField:Destroy()
        end
    end

    -- Fly + Farm
    if flying then
        if not bodyVelocity or not bodyVelocity.Parent then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyVelocity.Parent = root
            root:SetNetworkOwner(player)
        end
        hum.PlatformStand = true

        local moveVector = Vector3.new(0, 0, 0)
        local cam = workspace.CurrentCamera

        if autofarming then
            local closestDist = math.huge
            local target = nil
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (string.lower(obj.Name):find("coin") or obj.Name == "Coin") then
                    local dist = (root.Position - obj.Position).Magnitude
                    if dist < closestDist and dist < 1000 then
                        closestDist = dist
                        target = obj
                    end
                end
            end
            if target then
                moveVector = (target.Position - root.Position).Unit * (closestDist > 20 and 150 or 50)
            end
        else
            if keys.W then moveVector += cam.CFrame.LookVector end
            if keys.S then moveVector -= cam.CFrame.LookVector end
            if keys.A then moveVector -= cam.CFrame.RightVector end
            if keys.D then moveVector += cam.CFrame.RightVector end
            if keys.Space then moveVector += Vector3.new(0, 1, 0) end
            if keys.LeftShift then moveVector -= Vector3.new(0, 1, 0) end
            if moveVector.Magnitude > 0 then
                moveVector = moveVector.Unit * 100
            else
                moveVector = Vector3.new(0, 0.1, 0)
            end
        end

        bodyVelocity.Velocity = moveVector
    else
        hum.PlatformStand = false
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if root then root:SetNetworkOwner(nil) end
    end

    -- Noclip
    if noclipping then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part ~= root then
                part.CanCollide = false
            end
        end
    end
end)

print("🛡️ MM2 HACKS CARREGADO! GUI arrastável, todos botões funcionam agora. Teste God + AutoFarm!")
