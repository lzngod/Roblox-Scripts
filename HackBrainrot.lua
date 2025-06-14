local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
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
        "ReplicatedStorage.Packages.Net.RE/CombatService" -- Gênero pra cobrir variações
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

    -- Bloquear danos ou knockback no personagem
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            local oldTakeDamage = humanoid.TakeDamage
            humanoid.TakeDamage = function(self, damage)
                if isActive then
                    print("Dano bloqueado: " .. tostring(damage))
                    return 0 -- Retorna 0 dano
                else
                    return oldTakeDamage(self, damage)
                end
            end
        end
    end
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        local oldTakeDamage = humanoid.TakeDamage
        humanoid.TakeDamage = function(self, damage)
            if isActive then
                print("Dano bloqueado: " .. tostring(damage))
                return 0
            else
                return oldTakeDamage(self, damage)
            end
        end
    end)
end

-- Iniciar o script
print("Script Anti-Damage iniciado")
local button = createAntiDamageButton()
blockCombatEvents()
print("Clique em Anti-Damage para ativar/desativar a proteção")
