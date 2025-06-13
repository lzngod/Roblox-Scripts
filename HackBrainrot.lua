-- Script para Roblox: Steal a Brainrot
-- Criado para o público brasileiro, com interface em português
-- Inspirado nos scripts fornecidos e repositório Akbar123s

-- Função de notificação
local function notify(title, text, duration)
    game.StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

-- Verificação de whitelist
local WHITELIST_FILE = "whitelist_br.txt"
local WAIT_TIME = 300 -- 5 minutos
local function checkWhitelist()
    if writefile and not isfile(WHITELIST_FILE) then
        writefile(WHITELIST_FILE, tostring(os.time()))
    end
    local lastTime = isfile(WHITELIST_FILE) and tonumber(readfile(WHITELIST_FILE)) or 0
    return os.time() - lastTime >= WAIT_TIME
end

-- Criação da GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainRotGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 160, 0, 100)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.2

local UIPadding = Instance.new("UIPadding", Frame)
UIPadding.PaddingTop = UDim.new(0, 6)
UIPadding.PaddingLeft = UDim.new(0, 6)
UIPadding.PaddingRight = UDim.new(0, 6)

local UIGridLayout = Instance.new("UIGridLayout", Frame)
UIGridLayout.Padding = UDim.new(0, 5)
UIGridLayout.FillDirection = Enum.FillDirection.Vertical
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 18)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.Text = "Status: Inativo"
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = Frame

-- Variáveis de controle
local autoStealEnabled = false
local autoCollectEnabled = false
local noClipEnabled = false
local isStealing = false
local stopSteal = false

-- Função Auto Steal
local function autoSteal()
    isStealing = true
    stopSteal = false
    StatusLabel.Text = "Roubando em: 2s"
    for i = 1, 20 do
        if stopSteal then
            StatusLabel.Text = "Roubo parado!"
            isStealing = false
            return
        end
        StatusLabel.Text = "Roubando em: " .. string.format("%.1f", (2 - (i - 1) * 0.1)) .. "s"
        wait(0.1)
    end
    StatusLabel.Text = "Roubando..."
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        StatusLabel.Text = "Personagem não encontrado!"
        isStealing = false
        return
    end
    for i = 1, 20 do
        if stopSteal then
            StatusLabel.Text = "Roubo parado!"
            isStealing = false
            break
        end
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name == "Brainrot" then
                pcall(function()
                    firetouchinterest(rootPart, obj, 0)
                    wait(0.13)
                    firetouchinterest(rootPart, obj, 1)
                end)
            end
        end
    end
    if not stopSteal then
        StatusLabel.Text = "Roubo concluído!"
    end
    isStealing = false
end

-- Função Auto Collect
local function autoCollect()
    while autoCollectEnabled do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name == "Cash" then
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = obj.CFrame
                    wait(0.2)
                end
            end
        end
        wait(1)
    end
end

-- Função NoClip
local function noClip()
    local character = game.Players.LocalPlayer.Character
    while noClipEnabled and character do
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        wait()
    end
end

-- Botão Auto Steal
local AutoStealButton = Instance.new("TextButton")
AutoStealButton.Size = UDim2.new(1, 0, 0, 26)
AutoStealButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
AutoStealButton.Font = Enum.Font.GothamBold
AutoStealButton.TextSize = 12
AutoStealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoStealButton.Text = "Auto Roubar"
AutoStealButton.Parent = Frame
Instance.new("UICorner", AutoStealButton).CornerRadius = UDim.new(0, 6)

AutoStealButton.MouseButton1Click:Connect(function()
    if not checkWhitelist() then
        StatusLabel.Text = "Aguarde a liberação!"
        return
    end
    autoStealEnabled = not autoStealEnabled
    if autoStealEnabled and not isStealing then
        task.spawn(autoSteal)
        AutoStealButton.Text = "Parar Roubo"
        notify("Auto Roubar", "Funcionalidade ativada!", 3)
    else
        stopSteal = true
        autoStealEnabled = false
        AutoStealButton.Text = "Auto Roubar"
        notify("Auto Roubar", "Funcionalidade desativada!", 3)
    end
end)

-- Botão Auto Collect
local AutoCollectButton = Instance.new("TextButton")
AutoCollectButton.Size = UDim2.new(1, 0, 0, 26)
AutoCollectButton.BackgroundColor3 = Color3.fromRGB(17, 144, 210)
AutoCollectButton.Font = Enum.Font.GothamBold
AutoCollectButton.TextSize = 12
AutoCollectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoCollectButton.Text = "Auto Coletar"
AutoCollectButton.Parent = Frame
Instance.new("UICorner", AutoCollectButton).CornerRadius = UDim.new(0, 6)

AutoCollectButton.MouseButton1Click:Connect(function()
    if not checkWhitelist() then
        StatusLabel.Text = "Aguarde a liberação!"
        return
    end
    autoCollectEnabled = not autoCollectEnabled
    AutoCollectButton.Text = autoCollectEnabled and "Parar Coletar" or "Auto Coletar"
    AutoCollectButton.BackgroundColor3 = autoCollectEnabled and Color3.fromRGB(150, 50, 50) or Color3.fromRGB(17, 144, 210)
    if autoCollectEnabled then
        task.spawn(autoCollect)
        notify("Auto Coletar", "Funcionalidade ativada!", 3)
    else
        notify("Auto Coletar", "Funcionalidade desativada!", 3)
    end
end)

-- Botão NoClip
local NoClipButton = Instance.new("TextButton")
NoClipButton.Size = UDim2.new(1, 0, 0, 26)
NoClipButton.BackgroundColor3 = Color3.fromRGB(17, 144, 210)
NoClipButton.Font = Enum.Font.GothamBold
NoClipButton.TextSize = 12
NoClipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoClipButton.Text = "NoClip"
NoClipButton.Parent = Frame
Instance.new("UICorner", NoClipButton).CornerRadius = UDim.new(0, 6)

NoClipButton.MouseButton1Click:Connect(function()
    if not checkWhitelist() then
        StatusLabel.Text = "Aguarde a liberação!"
        return
    end
    noClipEnabled = not noClipEnabled
    NoClipButton.Text = noClipEnabled and "Parar NoClip" or "NoClip"
    NoClipButton.BackgroundColor3 = noClipEnabled and Color3.fromRGB(150, 50, 50) or Color3.fromRGB(17, 144, 210)
    if noClipEnabled then
        task.spawn(noClip)
        notify("NoClip", "Funcionalidade ativada!", 3)
    else
        notify("NoClip", "Funcionalidade desativada!", 3)
        local character = game.Players.LocalPlayer.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Botão Copiar Nome
local CopyNameButton = Instance.new("TextButton")
CopyNameButton.Size = UDim2.new(1, 0, 0, 26)
CopyNameButton.BackgroundColor3 = Color3.fromRGB(17, 144, 210)
CopyNameButton.Font = Enum.Font.GothamBold
CopyNameButton.TextSize = 12
CopyNameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyNameButton.Text = "Copiar Nome"
CopyNameButton.Parent = Frame
Instance.new("UICorner", CopyNameButton).CornerRadius = UDim.new(0, 6)

CopyNameButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(game.Players.LocalPlayer.Name)
        notify("Copiar Nome", "Nome copiado com sucesso!", 3)
    else
        notify("Copiar Nome", "Clipboard não disponível!", 3)
    end
end)

-- Verificação de Whitelist
if not checkWhitelist() then
    StatusLabel.Text = "Verificando whitelist..."
    task.spawn(function()
        while not checkWhitelist() do
            local timeLeft = WAIT_TIME - (os.time() - (tonumber(readfile(WHITELIST_FILE)) or 0))
            StatusLabel.Text = string.format("Aguarde %d min %d seg", math.floor(timeLeft / 60), timeLeft % 60)
            wait(1)
        end
        StatusLabel.Text = "Whitelist liberada!"
        notify("Whitelist", "Verificação concluída! Script liberado!", 5)
    end)
else
    StatusLabel.Text = "Whitelist liberada!"
    notify("Whitelist", "Verificação concluída! Script liberado!", 5)
end

-- Notificação inicial
local NOTIFICATION_FILE = "notification_br.txt"
if not isfile(NOTIFICATION_FILE) then
    notify("Aviso", "Use por sua conta e risco. Não roube enquanto o script está processando. Scripts violam os Termos de Serviço do Roblox.", 10)
    writefile(NOTIFICATION_FILE, "done")
end
