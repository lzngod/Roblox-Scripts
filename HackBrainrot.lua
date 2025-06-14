-- Script de log para monitorar ações em Steal a Brainrot
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Tabela para armazenar nomes de Brainrots conhecidos
local brainrotNames = {"Odin", "Din", "Dun"} -- Adicione mais nomes conforme encontrar

-- Função para logar mensagens no console
local function logMessage(message)
    print("[LOG " .. os.time() .. "]: " .. message)
end

-- Monitorar RemoteEvents e RemoteFunctions em ReplicatedStorage
local function monitorRemotes()
    for _, remote in pairs(ReplicatedStorage:GetChildren()) do
        if remote:IsA("RemoteEvent") then
            logMessage("Monitorando RemoteEvent: " .. remote.Name)
            remote.OnClientEvent:Connect(function(...)
                local args = {...}
                local argString = ""
                for i, arg in pairs(args) do
                    argString = argString .. tostring(arg) .. (i < #args and ", " or "")
                end
                logMessage("RemoteEvent disparado: " .. remote.Name .. " | Argumentos: " .. argString)
            end)
            -- Tentar capturar FireServer do cliente
            local oldFireServer = remote.FireServer
            remote.FireServer = function(self, ...)
                local args = {...}
                local argString = ""
                for i, arg in pairs(args) do
                    argString = argString .. tostring(arg) .. (i < #args and ", " or "")
                end
                logMessage("FireServer chamado em: " .. remote.Name .. " | Argumentos: " .. argString)
                return oldFireServer(self, ...)
            end
        elseif remote:IsA("RemoteFunction") then
            logMessage("Monitorando RemoteFunction: " .. remote.Name)
            -- Tentar capturar InvokeServer do cliente
            local oldInvokeServer = remote.InvokeServer
            remote.InvokeServer = function(self, ...)
                local args = {...}
                local argString = ""
                for i, arg in pairs(args) do
                    argString = argString .. tostring(arg) .. (i < #args and ", " or "")
                end
                logMessage("InvokeServer chamado em: " .. remote.Name .. " | Argumentos: " .. argString)
                return oldInvokeServer(self, ...)
            end
        end
    end
end

-- Monitorar criação e destruição de Brainrots no Workspace
local function monitorWorkspace()
    logMessage("Monitorando Workspace para Brainrots: " .. table.concat(brainrotNames, ", "))
    Workspace.ChildAdded:Connect(function(child)
        for _, name in pairs(brainrotNames) do
            if child.Name == name then
                logMessage("Novo Brainrot criado: " .. child.Name .. " | Caminho: " .. child:GetFullName())
                -- Monitorar propriedades do Brainrot
                monitorProperties(child)
            end
        end
    end)
    Workspace.ChildRemoved:Connect(function(child)
        for _, name in pairs(brainrotNames) do
            if child.Name == name then
                logMessage("Brainrot removido: " .. child.Name .. " | Caminho: " .. child:GetFullName())
            end
        end
    end)
end

-- Monitorar mudanças em propriedades de um Brainrot
local function monitorProperties(brainrot)
    logMessage("Monitorando propriedades do Brainrot: " .. brainrot.Name)
    brainrot.Changed:Connect(function(property)
        logMessage("Propriedade alterada em " .. brainrot.Name .. ": " .. property .. " = " .. tostring(brainrot[property]))
    end)
    -- Monitorar valores específicos (ex.: StringValue, BoolValue)
    for _, child in pairs(brainrot:GetChildren()) do
        if child:IsA("ValueBase") then
            child.Changed:Connect(function(value)
                logMessage("Valor alterado em " .. brainrot.Name .. "." .. child.Name .. ": " .. tostring(value))
            end)
        end
    end
end

-- Iniciar monitoramento
logMessage("Iniciando script de log para Steal a Brainrot")
monitorRemotes()
monitorWorkspace()

-- Monitorar Brainrots já existentes no Workspace
for _, child in pairs(Workspace:GetChildren()) do
    for _, name in pairs(brainrotNames) do
        if child.Name == name then
            logMessage("Brainrot encontrado no início: " .. child.Name)
            monitorProperties(child)
        end
    end
end

logMessage("Script de log ativo. Realize ações no jogo para capturar eventos.")
