--[[
    Script Anti-Ragdoll 
    Método: Interceptação de Conexão (Hooking)
    Descrição: Este script intercepta tentativas de conexão ao RemoteEvent de ragdoll.
               Quando ativado, ele impede que o script do jogo receba o sinal para
               derrubar o jogador, oferecendo uma solução robusta e alternável.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tenta encontrar o RemoteEvent de ragdoll
local success, ragdollEvent = pcall(function()
    return ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Ragdoll"):WaitForChild("Ragdoll")
end)

local isAntiRagdollActive = false

-- Implementação da função de hook (necessária para a interceptação)
local hookfunction = hookfunction or newcclosure
local getconnections = getconnections or get_connections

-- Criação da Interface Gráfica (Botão)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiRagdollGUI_v3"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 150, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BorderSizePixel = 2
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 16
toggleButton.Text = "Anti-Ragdoll: OFF"
toggleButton.Draggable = true -- Permite arrastar o botão
toggleButton.Active = true

-- Função que atualiza a aparência do botão
local function updateButtonState()
    if isAntiRagdollActive then
        toggleButton.Text = "Anti-Ragdoll: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        toggleButton.Text = "Anti-Ragdoll: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end

-- Função principal que liga ou desliga o anti-ragdoll
local function toggleAntiRagdoll()
    isAntiRagdollActive = not isAntiRagdollActive
    if isAntiRagdollActive then
        print("[Anti-Ragdoll v3] Ativado. Conexões serão bloqueadas.")
    else
        print("[Anti-Ragdoll v3] Desativado. Conexões são permitidas.")
    end
    updateButtonState()
end

-- A MÁGICA ACONTECE AQUI
if success and ragdollEvent then
    -- Se o evento de ragdoll for encontrado, preparamos a interceptação
    
    local original_connect
    original_connect = hookfunction(ragdollEvent.OnClientEvent.Connect, function(self, ...)
        if isAntiRagdollActive and self == ragdollEvent.OnClientEvent then
            -- Se o anti-ragdoll está ativo e algo tenta se conectar ao evento de ragdoll,
            -- nós retornamos uma conexão falsa que não faz nada.
            return { Disconnect = function() end }
        end
        -- Caso contrário, deixamos a conexão original acontecer.
        return original_connect(self, ...)
    end)
    
    -- Conecta a função de toggle ao clique do botão
    toggleButton.MouseButton1Click:Connect(toggleAntiRagdoll)
    updateButtonState()
    
else
    -- Se o evento não for encontrado, desativa o botão e avisa
    toggleButton.Text = "ERRO: Evento não encontrado"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    toggleButton.Active = false
    warn("[Anti-Ragdoll v3] AVISO: Não foi possível encontrar o evento 'Ragdoll'.")
end
