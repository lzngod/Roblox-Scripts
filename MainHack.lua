local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
StarterGui:SetCore("ResetButtonCallback", false)  -- Bloqueia reset manual

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2Hacks"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- GUI simples e segura
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 340)
frame.Position = UDim2.new(0.01, 0, 0.01, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 12)
uicorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "MM2 HACKS 2026 - FIXED"
title.TextColor3 = Color3.fromRGB(255, 80, 80)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

local function makeButton(text, yPos, callback, colorOff)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, yPos, 0)
    btn.BackgroundColor3 = colorOff or Color3.fromRGB(180, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextScaled = true
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local flyBtn = makeButton("Fly: OFF", 0.15, function()
    flying = not flying
    flyBtn.Text = "Fly: " .. (flying and "ON" or "OFF")
    flyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
end)

local godBtn = makeButton("God: OFF", 0.30, function()
    godmode = not godmode
    godBtn.Text = "God: " .. (godmode and "ON" or "OFF")
    godBtn.BackgroundColor3 = godmode and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
end)

local noclipBtn = makeButton("Noclip: OFF", 0.45, function()
    noclipping = not noclipping
    noclipBtn.Text = "Noclip: " .. (noclipping and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = noclipping and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
end)

local farmBtn = makeButton("AutoFarm Coins: OFF", 0.60, function()
    autofarming = not autofarming
    farmBtn.Text = "AutoFarm Coins: " .. (autofarming and "ON" or "OFF")
    farmBtn.BackgroundColor3 = autofarming and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
    if autofarming then 
        flying = true 
        flyBtn.Text = "Fly: ON"
        flyBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    end
end)

-- Minimize simples
local minBtn = makeButton("-", 0.02, function()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        frame.Size = UDim2.new(0, 240, 0, 60)
        flyBtn.Visible = false
        godBtn.Visible = false
        noclipBtn.Visible = false
        farmBtn.Visible = false
    else
        minBtn.Text = "-"
        frame.Size = UDim2.new(0, 240, 0, 340)
        flyBtn.Visible = godBtn.Visible = noclipBtn.Visible = farmBtn.Visible = true
    end
end, Color3.fromRGB(200, 50, 50))
minBtn.Position = UDim2.new(1, -50, 0, 5)
minBtn.Size = UDim2.new(0, 40, 0, 30)

-- Variáveis
local flying = false
local godmode = false
local noclipping = false
local autofarming = false
local minimized = false
local bodyVelocity = nil
local keys = {}

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        keys[input.KeyCode.Name] = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        keys[input.KeyCode.Name] = nil
    end
end)

-- God mode seguro (sem clone pra evitar nil)
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    if godmode then
        hum.MaxHealth = 1e9
        hum.Health = 1e9
        if not char:FindFirstChild("ForceField") then
            local ff = Instance.new("ForceField")
            ff.Parent = char
        end
        -- Anti-morte extra
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        print("God mode ativo - HP huge + ForceField")
    else
        if char:FindFirstChild("ForceField") then
            char.ForceField:Destroy()
        end
    end

    -- Fly + AutoFarm
    if flying or autofarming then
        if not bodyVelocity then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bodyVelocity.Parent = root
            root:SetNetworkOwner(player)
        end
        hum.PlatformStand = true

        local direction = Vector3.new()

        if autofarming then
            local closestCoin = nil
            local minDist = 1200
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name == "Coin" or obj.Name:lower():find("coin")) then
                    if obj.Position then
                        local dist = (root.Position - obj.Position).Magnitude
                        if dist < minDist then
                            minDist = dist
                            closestCoin = obj
                        end
                    end
                end
            end

            if closestCoin then
                direction = (closestCoin.Position - root.Position).Unit
                local speed = minDist > 25 and 180 or 60
                direction = direction * speed
                print("Voando pra moeda! Dist: " .. math.floor(minDist))
            else
                print("Nenhuma moeda detectada no mapa")
            end
        else
            -- Fly manual
            local cam = workspace.CurrentCamera
            if keys.W then direction += cam.CFrame.LookVector end
            if keys.S then direction -= cam.CFrame.LookVector end
            if keys.A then direction -= cam.CFrame.RightVector end
            if keys.D then direction += cam.CFrame.RightVector end
            if keys.Space then direction += Vector3.new(0,1,0) end
            if keys.LeftShift then direction -= Vector3.new(0,1,0) end

            if direction.Magnitude > 0 then
                direction = direction.Unit * 100
            end
        end

        bodyVelocity.Velocity = direction
    else
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        root:SetNetworkOwner(nil)
        hum.PlatformStand = false
    end

    -- Noclip
    if noclipping then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("MM2 HACKS carregado! Teste God primeiro, depois AutoFarm. Veja prints no console.")
