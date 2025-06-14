-- Script de Log Universal para Roblox
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

-- Função para logar mensagens com timestamp
local function logMessage(message)
    local time = os.date("%H:%M:%S")
    print(string.format("[LOG %s]: %s", time, message))
end

-- Monitorar RemoteEvents e RemoteFunctions em ReplicatedStorage
local function monitorRemotes()
    logMessage("Monitorando RemoteEvents e RemoteFunctions em ReplicatedStorage")
    local function hookRemote(remote)
        if remote:IsA("RemoteEvent") then
            logMessage("Encontrado RemoteEvent: " .. remote:GetFullName())
            -- Hook para FireServer
            local oldFireServer
            oldFireServer = hookfunction(remote.FireServer, function(self, ...)
                local args = {...}
                local argString = table.concat(table.pack(...), ", ", function(v) return tostring(v) end)
                logMessage("FireServer em " .. remote:GetFullName() .. " | Args: " .. (argString or "Nenhum"))
                return oldFireServer(self, ...)
            end)
            -- Monitorar OnClientEvent (se aplicável)
            remote.OnClientEvent:Connect(function(...)
                local args = {...}
                local argString = table.concat(table.pack(...), ", ", function(v) return tostring(v) end)
                logMessage("OnClientEvent em " .. remote:GetFullName() .. " | Args: " .. (argString or "Nenhum"))
            end)
        elseif remote:IsA("RemoteFunction") then
            logMessage("Encontrado RemoteFunction: " .. remote:GetFullName())
            -- Hook para InvokeServer
            local oldInvokeServer
            oldInvokeServer = hookfunction(remote.InvokeServer, function(self, ...)
                local args = {...}
                local argString = table.concat(table.pack(...), ", ", function(v) return tostring(v) end)
                logMessage("InvokeServer em " .. remote:GetFullName() .. " | Args: " .. (argString or "Nenhum"))
                return oldInvokeServer(self, ...)
            end)
        end
    end

    -- Monitorar remotes existentes
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        hookRemote(remote)
    end
    -- Monitorar novos remotes
    ReplicatedStorage.DescendantAdded:Connect(function(descendant)
        hookRemote(descendant)
    end)
end

-- Monitorar mudanças no Workspace (ex.: Brainrots criados/removidos)
local function monitorWorkspace()
    logMessage("Monitorando mudanças no Workspace")
    Workspace.DescendantAdded:Connect(function(instance)
        logMessage("Nova instância criada: " .. instance:GetFullName() .. " | Classe: " .. instance.ClassName)
        -- Monitorar propriedades
        instance.Changed:Connect(function(property)
            logMessage("Propriedade alterada em " .. instance:GetFullName() .. ": " .. property .. " = " .. tostring(instance[property]))
        end)
        -- Monitorar valores (ex.: StringValue, BoolValue)
        for _, child in pairs(instance:GetDescendants()) do
            if child:IsA("ValueBase") then
                child.Changed:Connect(function(value)
                    logMessage("Valor alterado em " .. child:GetFullName() .. ": " .. tostring(value))
                end)
            end
        end)
    end)
    Workspace.DescendantRemoving:Connect(function(instance)
        logMessage("Instância removida: " .. instance:GetFullName() .. " | Classe: " .. instance.ClassName)
    end)
end

-- Monitorar interações do jogador (ex.: cliques, teclas)
local function monitorPlayerActions()
    logMessage("Monitorando ações do jogador")
    -- Capturar cliques do mouse
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local target = player:GetMouse().Target
                if target then
                    logMessage("Clique com botão esquerdo em: " .. target:GetFullName() .. " | Classe: " .. target.ClassName)
                else
                    logMessage("Clique com botão esquerdo (sem alvo)")
                end
            elseif input.UserInputType == Enum.UserInputType.Keyboard then
                logMessage("Tecla pressionada: " .. input.KeyCode.Name)
            end
        end
    end)

    -- Monitorar colisões do personagem
    if player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.Touched:Connect(function(part)
                logMessage("Personagem tocou: " .. part:GetFullName() .. " | Classe: " .. part.ClassName)
            end)
        end
    end
    -- Monitorar novos personagens
    player.CharacterAdded:Connect(function(character)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.Touched:Connect(function(part)
            logMessage("Personagem tocou: " .. part:GetFullName() .. " | Classe: " .. part.ClassName)
        end)
    end)
end

-- Monitorar GUIs (ex.: botões clicados)
local function monitorGUIs()
    logMessage("Monitorando GUIs em CoreGui e PlayerGui")
    local function hookGui(gui)
        if gui:IsA("GuiButton") then
            logMessage("Encontrado botão GUI: " .. gui:GetFullName())
            gui.MouseButton1Click:Connect(function()
                logMessage("Botão clicado: " .. gui:GetFullName())
            end)
        end
    end

    -- Monitorar GUIs existentes
    for _, gui in pairs(CoreGui:GetDescendants()) do
        hookGui(gui)
    end
    for _, gui in pairs(player:WaitForChild("PlayerGui"):GetDescendants()) do
        hookGui(gui)
    end
    -- Monitorar novas GUIs
    CoreGui.DescendantAdded:Connect(hookGui)
    player.PlayerGui.DescendantAdded:Connect(hookGui)
end

-- Iniciar monitoramento
logMessage("Script de log universal iniciado")
monitorRemotes()
monitorWorkspace()
monitorPlayerActions()
monitorGUIs()

logMessage("Pronto! Realize ações no jogo para capturar logs.")
