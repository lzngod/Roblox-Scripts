-- Script de Log Ajustado para Ações do Jogador em Roblox
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
            remote.OnClientEvent:Connect(function(...)
                local args = {...}
                local argString = table.concat(table.pack(...), ", ", function(v) return tostring(v) end)
                logMessage("OnClientEvent em " .. remote:GetFullName() .. " | Args: " .. (argString or "Nenhum"))
            end)
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
logMessage("Script de log ajustado iniciado")
pcall(monitorRemotes)
pcall(monitorPlayerActions)
pcall(monitorGUIs)

logMessage("Pronto! Realize suas ações no jogo para capturar logs.")
