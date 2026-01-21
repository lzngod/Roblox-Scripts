local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
StarterGui:SetCore("ResetButtonCallback", false)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HacksGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 320)
mainFrame.Position = UDim2.new(0.01, 0, 0.01, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "MM2 HACKS - FIXED 2026"
title.TextColor3 = Color3.fromRGB(255, 100, 100)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = mainFrame

-- Botões (posições ajustadas)
local function createBtn(text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, posY, 0)
    btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    btn.Text = text
    btn.TextColor3 = Color3.white
    btn.Font = Enum.Font.GothamSemibold
    btn.TextScaled = true
    btn.Parent = mainFrame
    
    local btnCorner = corner:Clone()
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local flyBtn = createBtn("Fly: OFF", 0.15, function()
    flying = not flying
    flyBtn.Text = "Fly: " .. (flying and "ON" or "OFF")
    flyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

local godBtn = createBtn("God: OFF", 0.30, function()
    godmode = not godmode
    godBtn.Text = "God: " .. (godmode and "ON" or "OFF")
    godBtn.BackgroundColor3 = godmode and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

local noclipBtn = createBtn("Noclip: OFF", 0.45, function()
    noclipping = not noclipping
    noclipBtn.Text = "Noclip: " .. (noclipping and "ON" or "OFF")
    noclipBtn.BackgroundColor3 = noclipping and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

local autofarmBtn = createBtn("AutoFarm Coins: OFF", 0.60, function()
    autofarming = not autofarming
    autofarmBtn.Text = "AutoFarm Coins: " .. (autofarming and "ON" or "OFF")
    autofarmBtn.BackgroundColor3 = autofarming and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    if autofarming then flying = true; flyBtn.Text = "Fly: ON"; flyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0) end
end)

-- Minimize (simples, sem tween wait)
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -35, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
minBtn.Text = "-"
minBtn.TextColor3 = Color3.white
minBtn.Font = Enum.Font.GothamBold
minBtn.Parent = mainFrame

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        minBtn.Text = "+"
        mainFrame.Size = UDim2.new(0, 220, 0, 50)
        flyBtn.Visible = false
        godBtn.Visible = false
        noclipBtn.Visible = false
        autofarmBtn.Visible = false
    else
        minBtn.Text = "-"
        mainFrame.Size = UDim2.new(0, 220, 0, 320)
        flyBtn.Visible = true
        godBtn.Visible = true
        noclipBtn.Visible = true
        autofarmBtn.Visible = true
    end
end)

-- Variáveis
local flying = false
local godmode = false
local noclipping = false
local autofarming = false
local bodyVel = nil
local keys = {}

-- Keys
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

-- God mode reforçado
local function applyGod(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        local ff = Instance.new("ForceField")
        ff.Parent = char
        
        -- Clone pra bypass kill scripts
        local oldHum = hum
        local newHum = hum:Clone()
        newHum.Parent = char
        newHum.Name = "Humanoid"
        oldHum:Destroy()
        workspace.CurrentCamera.CameraSubject = newHum
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
        if not char:FindFirstChildOfClass("ForceField") then
            local ff = Instance.new("ForceField")
            ff.Parent = char
        end
    end
    
    -- Fly + AutoFarm
    if flying or autofarming then
        if not bodyVel then
            bodyVel = Instance.new("BodyVelocity")
            bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            bodyVel.Parent = root
            root:SetNetworkOwner(player)
        end
        hum.PlatformStand = true
        
        local move = Vector3.new()
        local cam = workspace.CurrentCamera
        
        if autofarming then
            local closest = nil
            local minDist = 9999
            for _, part in ipairs(workspace:GetChildren()) do
                if part:IsA("BasePart") and part.Name == "Coin" and part.Position then
                    local dist = (root.Position - part.Position).Magnitude
                    if dist < minDist and dist < 800 then
                        minDist = dist
                        closest = part
                    end
                end
            end
            
            if closest then
                local dir = (closest.Position - root.Position).Unit
                move = dir * (minDist > 20 and 180 or 60)  -- Acelera + freia
                print("Indo pra moeda mais próxima: " .. tostring(closest.Position))
            else
                print("Nenhuma moeda encontrada próxima")
            end
        else
            -- Manual
            if keys[Enum.KeyCode.W] then move = move + cam.CFrame.LookVector end
            if keys[Enum.KeyCode.S] then move = move - cam.CFrame.LookVector end
            if keys[Enum.KeyCode.A] then move = move - cam.CFrame.RightVector end
            if keys[Enum.KeyCode.D] then move = move + cam.CFrame.RightVector end
            if keys[Enum.KeyCode.Space] then move = move + Vector3.new(0,1,0) end
            if keys[Enum.KeyCode.LeftShift] then move = move - Vector3.new(0,1,0) end
            
            if move.Magnitude > 0 then
                move = move.Unit * 100
            end
        end
        
        bodyVel.Velocity = move
    else
        if bodyVel then
            bodyVel:Destroy()
            bodyVel = nil
        end
        if root then root:SetNetworkOwner(nil) end
        hum.PlatformStand = false
    end
    
    -- Noclip
    if noclipping then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

print("Script carregado! Abra a GUI no topo esquerdo. Se não aparecer, cheque executor ou reset character.")
