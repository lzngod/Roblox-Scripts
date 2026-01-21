local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
StarterGui:SetCore("ResetButtonCallback", false)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2HacksFixed"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- GUI básica (sem tween pra evitar lag/crash)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 300)
frame.Position = UDim2.new(0.01, 0, 0.01, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = screenGui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "MM2 HACKS FIXED - 2026"
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

local function createBtn(txt, y, func, offColor)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, y, 0)
    btn.BackgroundColor3 = offColor or Color3.fromRGB(180, 0, 0)
    btn.Text = txt
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextScaled = true
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(func)
    return btn
end

local flying, godmode, noclipping, autofarming = false, false, false, false
local bodyVel = nil
local keys = {}

createBtn("Fly: OFF", 0.18, function()
    flying = not flying
    createBtn("Fly: " .. (flying and "ON" or "OFF"), 0.18, nil) -- update text (hack simples)
    print("Fly toggled: " .. tostring(flying))
end)

createBtn("God: OFF", 0.32, function()
    godmode = not godmode
    print("God toggled: " .. tostring(godmode))
end)

createBtn("Noclip: OFF", 0.46, function()
    noclipping = not noclipping
    print("Noclip toggled: " .. tostring(noclipping))
end)

createBtn("AutoFarm Coins: OFF", 0.60, function()
    autofarming = not autofarming
    if autofarming then flying = true end
    print("AutoFarm toggled: " .. tostring(autofarming))
end)

-- Keys pra fly manual
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        keys[input.KeyCode.Name] = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        keys[input.KeyCode.Name] = false
    end
end)

-- Loop principal
RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    -- God simples e seguro
    if godmode then
        hum.MaxHealth = 1e9
        hum.Health = 1e9
        hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        if not char:FindFirstChild("ForceField") then
            local ff = Instance.new("ForceField")
            ff.Parent = char
        end
    end

    -- Fly + AutoFarm
    if flying or autofarming then
        if not bodyVel then
            bodyVel = Instance.new("BodyVelocity")
            bodyVel.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bodyVel.Parent = root
            root:SetNetworkOwner(player)
        end
        hum.PlatformStand = true

        local moveDir = Vector3.new()

        if autofarming then
            local closest = nil
            local minDist = 1500
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name:lower():find("coin") then
                    local dist = (root.Position - obj.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = obj
                    end
                end
            end
            if closest then
                moveDir = (closest.Position - root.Position).Unit * (minDist > 30 and 150 or 50)
                print("AutoFarm: indo pra coin! Dist: " .. math.floor(minDist))
            else
                print("AutoFarm: nenhuma coin encontrada (verifique se spawnou)")
            end
        else
            -- Manual fly
            local cam = workspace.CurrentCamera
            if keys.W then moveDir += cam.CFrame.LookVector end
            if keys.S then moveDir -= cam.CFrame.LookVector end
            if keys.A then moveDir -= cam.CFrame.RightVector end
            if keys.D then moveDir += cam.CFrame.RightVector end
            if keys.Space then moveDir += Vector3.new(0,1,0) end
            if keys.LeftShift then moveDir -= Vector3.new(0,1,0) end
            if moveDir.Magnitude > 0 then moveDir = moveDir.Unit * 90 end
        end

        bodyVel.Velocity = moveDir
    else
        if bodyVel then bodyVel:Destroy() bodyVel = nil end
        root:SetNetworkOwner(nil)
        hum.PlatformStand = false
    end

    -- Noclip
    if noclipping then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

print("Script FIXED carregado! Ative God primeiro. Veja prints no console pra debug. Se AutoFarm não achar coins, me manda o que printou.")
