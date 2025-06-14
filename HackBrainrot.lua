local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local isActive = false

-- Função pra criar o botão "Anti-Damage"
local function createAntiDamageButton()
    local screenGui = Instance.new("ScreenGui")
    local button = Instance.new("TextButton")
    
    screenGui.Parent = player:WaitForChild("PlayerGui")
    button.Parent = screenGui
    button.Size = UDim2.new(0, 120, 0, 50)
    button.Position = UDim2.new(0.5, -60, 0.9, -25)
    button.Text = "Anti-Damage: Off"
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    button.MouseButton1Click:Connect(function()
        isActive = not isActive
        button.Text = "Anti-Damage: " .. (isActive and "On" or "Off")
        button.BackgroundColor3 = isActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        if isActive then
            print("Proteção Anti-Damage ativada")
        else
            print("Proteção Anti-Damage desativada")
        end
    end)
    
    return button
end

-- Função pra bloquear eventos de combate
local function blockCombatEvents()
    local blockedEvents = {
        "ReplicatedStorage.Packages.Net.RE/CombatService/ApplyImpulse",
        "ReplicatedStorage.Packages.Net.RE/BoogieBomb/Throw",
        "ReplicatedStorage.Packages.Net.RE/CombatService",
        "ReplicatedStorage.Packages.Ragdoll.Ragdoll"
    }

    for _, eventPath in pairs(blockedEvents) do
        local event = ReplicatedStorage:FindFirstChild(eventPath, true)
        if event and event:IsA("RemoteEvent") then
            local oldOnClientEvent = event.OnClientEvent
            event.OnClientEvent:Connect(function(...)
                if isActive then
                    print("Evento de combate bloqueado: " .. eventPath)
                    return -- Bloqueia a execução do evento
                else
                    oldOnClientEvent(...) -- Permite se desativado
                end
            end)
        end
    end
end

-- Função pra proteger a física e o Brainrot
local function protectPhysicsAndBrainrot()
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not (humanoid and humanoidRootPart) then return end

    local originalPosition = humanoidRootPart.Position
    local originalOrientation = humanoidRootPart.Orientation

    -- Congelar física com Anchored temporariamente
    local function freezePhysics()
        if isActive and humanoidRootPart then
            humanoidRootPart.Anchored = true
            wait(0.1) -- Tempo mínimo pra bloquear movimento
            humanoidRootPart.Anchored = false
            if humanoidRootPart.Position ~= originalPosition then
                humanoidRootPart.Position = originalPosition
                humanoidRootPart.Orientation = originalOrientation
                print("Knockback bloqueado, posição e orientação restauradas")
            end
        end
    end

    -- Bloquear estados de Humanoid
    humanoid.Changed:Connect(function(property)
        if isActive then
            if property == "PlatformStand" and humanoid.PlatformStand then
                humanoid.PlatformStand = false
                print("Ragdoll bloqueado")
            elseif property == "Sit" and humanoid.Sit then
                humanoid.Sit = false
                print("Sentar bloqueado")
            end
        end
    end)

    -- Manter o Brainrot na mão
    local function keepBrainrot()
        if isActive then
            local backpack = player:FindFirstChild("Backpack")
            local character = player.Character
            if backpack and character then
                local brainrot = backpack:FindFirstChild("Brainrot") or character:FindFirstChild("Brainrot")
                if brainrot and brainrot:IsA("Tool") then
                    if not character:FindFirstChild("Brainrot") then
                        brainrot.Parent = character
                        print("Brainrot mantido na mão")
                    end
                end
            end
        end
    end

    -- Monitorar e corrigir a cada frame
    RunService.Heartbeat:Connect(function()
        freezePhysics()
        keepBrainrot()
        -- Correção de bugs (teletransporte fora do mapa)
        if isActive and humanoidRootPart then
            local x, y, z = humanoidRootPart.Position.X, humanoidRootPart.Position.Y, humanoidRootPart.Position.Z
            if y < -50 or math.abs(x) > 500 or math.abs(z) > 500 then -- Limites aproximados do mapa
                humanoidRootPart.Position = originalPosition
                humanoidRootPart.Orientation = originalOrientation
                print("Teletransporte fora do mapa corrigido")
            end
        end
    end)

    -- Reiniciar proteção ao trocar de personagem
    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        humanoid = character:WaitForChild("Humanoid")
        humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        originalPosition = humanoidRootPart.Position
        originalOrientation = humanoidRootPart.Orientation
    end)
end

-- Iniciar o script
print("Script Anti-Damage iniciado")
local button = createAntiDamageButton()
blockCombatEvents()
protectPhysicsAndBrainrot()
print("Clique em Anti-Damage para ativar/desativar a proteção")
