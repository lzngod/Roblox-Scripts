-- Script de Log Otimizado para Ações do Jogador em Roblox
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

local function logMessage(message)
    local time = os.date("%H:%M:%S")
    print(string.format("[LOG %s]: %s", time, message))
end

local function formatArgs(args)
    local formatted = {}
    for i, v in ipairs(args) do
        if type(v) ~= "function" then
            formatted[i] = tostring(v)
        end
    end
    return table.concat(formatted, ", ") or "Nenhum"
end

local function monitorRemotes()
    logMessage("Monitorando RemoteEvents em ReplicatedStorage")
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") then
            logMessage("Encontrado RemoteEvent: " .. remote:GetFullName())
            remote.OnClientEvent:Connect(function(...)
                local args = {...}
                logMessage("OnClientEvent em " .. remote:GetFullName() .. " | Args: " .. formatArgs(args))
            end)
        end
    end
end

local function monitorPlayerActions()
    logMessage("Monitorando ações do jogador")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local target = player:GetMouse().Target
            if target then
                logMessage("Clique em: " .. target:GetFullName() .. " | Classe: " .. target.ClassName)
            end
        end
    end)

    if player.Character then
        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.Touched:Connect(function(part)
                if part and part.Name:find("Claim_Hitbox") then
                    logMessage("Tocou Claim_Hitbox: " .. part:GetFullName() .. " | Classe: " .. part.ClassName)
                end
            end)
        end
    end
    player.CharacterAdded:Connect(function(character)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.Touched:Connect(function(part)
            if part and part.Name:find("Claim_Hitbox") then
                logMessage("Tocou Claim_Hitbox: " .. part:GetFullName() .. " | Classe: " .. part.ClassName)
            end
        end)
    end)
end

local function monitorGUIs()
    logMessage("Monitorando GUIs")
    local function hookGui(gui)
        if gui:IsA("GuiButton") or gui:IsA("TextButton") then
            logMessage("Botão GUI: " .. gui:GetFullName())
            gui.MouseButton1Click:Connect(function()
                logMessage("Clicou em: " .. gui:GetFullName())
            end)
        end
    end
    for _, gui in pairs(player:WaitForChild("PlayerGui"):GetDescendants()) do
        hookGui(gui)
    end
    player.PlayerGui.DescendantAdded:Connect(hookGui)
end

logMessage("Script de log iniciado")
pcall(monitorRemotes)
pcall(monitorPlayerActions)
pcall(monitorGUIs)
logMessage("Realize ações para capturar logs")
