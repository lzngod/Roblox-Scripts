-- Script de Log Universal Corrigido para Roblox
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
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            logMessage("Encontrado RemoteEvent: " .. remote:GetFullName())
            -- Monitorar disparos do cliente (se possível)
            local connection
            connection = remote.OnClientEvent:Connect(function(...)
                local args = {...}
                local argString = table.concat(table.pack(...), ", ", function(v) return tostring(v) end)
                logMessage("OnClientEvent em " .. remote:GetFullName() .. " | Args: " .. (argString or "Nenhum"))
            end)
            if not connection then
                logMessage("Falha ao conectar OnClientEvent para: " .. remote:GetFullName())
            end
        elseif remote:IsA("RemoteFunction") then
            logMessage("Encontrado RemoteFunction: " .. remote:GetFullName())
        end
    end
    ReplicatedStorage.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("RemoteEvent") or descendant:IsA("RemoteFunction") then
            logMessage("Novo Remote detectado: " .. descendant:GetFullName())
        end
    end)
end

-- Monitorar mudanças no Workspace
local function monitorWorkspace()
    logMessage("Monitorando mudanças no Workspace")
    Workspace.DescendantAdded:Connect(function(instance)
        logMessage("Nova instância criada: " .. instance:GetFullName() .. " | Classe: " .. instance.ClassName)
        instance.Changed:Connect(function(property)
            if instance and instance[property] ~= nil then
                logMessage("Propriedade alterada em " .. instance:GetFullName() .. ": " .. property .. " = " .. tostring(instance[property]))
            end
        end)
        for _, child in pairs(instance:GetDescendants()) do
            if child:IsA("ValueBase") then
                child.Changed:Connect(function(value)
                    if child and value ~= nil then
                        logMessage("Valor alterado em " .. child:GetFullName() .. ": " .. tostring(value))
                    end
                end)
            end
        end
    end)
    Workspace.DescendantRemoving:Connect(function(instance)
        if instance then
            logMessage("Instância removida: " .. instance:GetFullName() .. " | Classe: " .. instance.ClassName)
        end
    end)
end

-- Monitorar interações do jogador
local function monitorPlayerActions()
    logMessage("Monitorando ações do jogador")
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

    if player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.Touched:Connect(function(part)
                if part then
                    logMessage("Personagem tocou: " .. part:GetFullName() .. " | Classe: " .. part.ClassName)
                end
            end)
        end
    end
    player.CharacterAdded:Connect(function(character)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.Touched:Connect(function(part)
            if part then
                logMessage("Personagem tocou: " .. part:GetFullName() .. " | Classe: " .. part.ClassName)
            end
        end)
    end)
end

-- Monitorar GUIs
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

    for _, gui in pairs(CoreGui:GetDescendants()) do
        hookGui(gui)
    end
    for _, gui in pairs(player:WaitForChild("PlayerGui"):GetDescendants()) do
        hookGui(gui)
    end
    CoreGui.DescendantAdded:Connect(hookGui)
    player.PlayerGui.DescendantAdded:Connect(hookGui)
end

-- Iniciar monitoramento
logMessage("Script de log universal iniciado")
pcall(monitorRemotes) -- Usa pcall para evitar crashes
pcall(monitorWorkspace)
pcall(monitorPlayerActions)
pcall(monitorGUIs)

logMessage("Pronto! Realize ações no jogo para capturar logs.")
