-- Configurações iniciais
local groupId = 34479814 -- ID do grupo
local username = "FaDhenGaming"
local userId = 6027385792

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- Esperar até o jogador estar completamente carregado
if not player:IsDescendantOf(Players) then
    player.AncestryChanged:Wait()
end

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealBrainrotGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Frame principal (arrastável)
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.Size = UDim2.new(0, 360, 0, 220)
Frame.Active = true
Frame.Draggable = true
local UICorner_Frame = Instance.new("UICorner")
UICorner_Frame.CornerRadius = UDim.new(0, 8)
UICorner_Frame.Parent = Frame
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.2
UIStroke.Parent = Frame

-- Título
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Frame
TitleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.BackgroundTransparency = 0.25
TitleLabel.Position = UDim2.new(0.5, 0, 0, 10)
TitleLabel.Size = UDim2.new(0, 340, 0, 30)
TitleLabel.AnchorPoint = Vector2.new(0.5, 0)
TitleLabel.Text = "Follow me and join my group to unlock Steal!"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
local UICorner_Title = Instance.new("UICorner")
UICorner_Title.CornerRadius = UDim.new(0, 10)
UICorner_Title.Parent = TitleLabel

-- Avatar
local Avatar = Instance.new("ImageLabel")
Avatar.Parent = Frame
Avatar.Size = UDim2.new(0, 80, 0, 80)
Avatar.Position = UDim2.new(0, 15, 0, 50)
Avatar.BackgroundTransparency = 1
Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..userId.."&width=100&height=100&format=png"

-- Label para username
local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Parent = Frame
UsernameLabel.Size = UDim2.new(0, 230, 0, 25)
UsernameLabel.Position = UDim2.new(0, 110, 0, 50)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = "Username: " .. username
UsernameLabel.Font = Enum.Font.GothamSemibold
UsernameLabel.TextSize = 16
UsernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Botão Copy Username
local CopyBurgundyButton = Instance.new("TextButton")
CopyButton.Parent = Frame
CopyButton.BackgroundColor3 = Color3.fromRGB(0, 145, 255)
CopyButton.Position = UDim2.new(0, 110, 0, 80)
CopyButton.Size = UDim2.new(0, 230, 0, 30)
CopyButton.Font = Enum.Font.GothamBold
CopyButton.Text = "Copy Username"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = 15
local UICorner_Copy = Instance.new("UICorner")
UICorner_Copy.CornerRadius = UDim.new(0, 8)
UICorner_Copy.Parent = CopyButton

-- Botão Start
local StartButton = Instance.new("TextButton")
StartButton.Parent = Frame
StartButton.BackgroundColor3 = Color3.fromRGB(17, 144, 210)
StartButton.Position = UDim2.new(0, 110, 0, 120)
StartButton.Size = UDim2.new(0, 110, 0, 30)
StartButton.Font = Enum.Font.GothamBold
StartButton.Text = "Start Steal"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 15
local UICorner_Start = Instance.new("UICorner")
UICorner_Start.CornerRadius = UDim.new(0, 6)
UICorner_Start.Parent = StartButton

-- Botão Stop
local StopButton = Instance.new("TextButton")
StopButton.Parent = Frame
StopButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
StopButton.Position = UDim2.new(0, 230, 0, 120)
StopButton.Size = UDim2.new(0, 110, 0, 30)
StopButton.Font = Enum.Font.GothamBold
StopButton.Text = "Stop"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.TextSize = 15
local UICorner_Stop = Instance.new("UICorner")
UICorner_Stop.CornerRadius = UDim.new(0, 6)
UICorner_Stop.Parent = StopButton

-- Label de status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = Frame
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StatusLabel.Position = UDim2.new(0, 10, 0, 160)
StatusLabel.Size = UDim2.new(0, 340, 0, 30)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Text = "Checking group status..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 14
local UICorner_Status = Instance.new("UICorner")
UICorner_Status.CornerRadius = UDim.new(0, 6)
UICorner_Status.Parent = StatusLabel

-- Botão Close
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Frame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
local UICorner_Close = Instance.new("UICorner")
UICorner_Close.CornerRadius = UDim.new(0, 6)
UICorner_Close.Parent = CloseButton

-- Efeitos de hover
local function hoverEffect(btn, normalColor, hoverColor)
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = hoverColor
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = normalColor
    end)
end
hoverEffect(CopyButton, Color3.fromRGB(0, 145, 255), Color3.fromRGB(0, 120, 220))
hoverEffect(StartButton, Color3.fromRGB(17, 144, 210), Color3.fromRGB(0, 120, 180))
hoverEffect(StopButton, Color3.fromRGB(200, 60, 60), Color3.fromRGB(180, 40, 40))
hoverEffect(CloseButton, Color3.fromRGB(200, 50, 50), Color3.fromRGB(180, 30, 30))

-- Variáveis de controle
local isRunning = false
local stopRequested = false

-- Função para copiar username
CopyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(username)
        StatusLabel.Text = "✅ Username Copied!"
        wait(1.5)
        StatusLabel.Text = isRunning and "Processing..." or "Ready"
    else
        StatusLabel.Text = "❌ Clipboard Error"
    end
end)

-- Fechar GUI
CloseButton.MouseButton1Click:Connect(function()
    isRunning = false
    stopRequested = true
    ScreenGui:Destroy()
end)

-- Função para encontrar a base do jogador
local function findPlayerBase()
    local possibleFolders = {"Plots", "Bases", "PlayerBases", "Tycoon", "PlayerPlots"}
    for _, folderName in ipairs(possibleFolders) do
        local folder = Workspace:FindFirstChild(folderName)
        if folder then
            for _, base in ipairs(folder:GetChildren()) do
                if base:IsA("BasePart") or base:IsA("Model") then
                    if base:FindFirstChild("Owner") and base.Owner.Value == player.UserId then
                        return base
                    elseif base.Name:find(player.Name) or base.Name:find(tostring(player.UserId)) then
                        return base
                    end
                end
            end
        end
    end
    for _, base in ipairs(Workspace:GetDescendants()) do
        if base:IsA("BasePart") or base:IsA("Model") then
            if base.Name:find("Base") or base.Name:find("Plot") or base.Name:find(player.Name) or base.Name:find(tostring(player.UserId)) then
                if base:FindFirstChild("Owner") and base.Owner.Value == player.UserId then
                    return base
                elseif base.Name:find(player.Name) or base.Name:find(tostring(player.UserId)) then
                    return base
                end
            end
        end
    end
    return nil
end

-- Função para verificar se o jogador está segurando um Brainrot
local function isHoldingBrainrot()
    local char = player.Character
    if char then
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA("Model") and obj.Name:find("Brainrot") then
                return true
            end
        end
    end
    return false
end

-- Função principal de automação
local function startSteal()
    if isRunning then return end
    isRunning = true
    stopRequested = false
    StartButton.Text = "Processing"
    StartButton.BackgroundTransparency = 0.5
    StartButton.AutoButtonColor = false
    StartButton.Active = false
    StopButton.Active = true

    local char = player.Character or player.CharacterAdded:Wait()
    local toucher = char:FindFirstChild("HumanoidRootPart")
    if not toucher then
        StatusLabel.Text = "No HumanoidRootPart found"
        isRunning = false
        StartButton.Text = "Start Steal"
        StartButton.BackgroundTransparency = 0
        StartButton.AutoButtonColor = true
        StartButton.Active = true
        return
    end

    if not isHoldingBrainrot() then
        StatusLabel.Text = "You are not holding a Brainrot"
        isRunning = false
        StartButton.Text = "Start Steal"
        StartButton.BackgroundTransparency = 0
        StartButton.AutoButtonColor = true
        StartButton.Active = true
        return
    end

    local playerBase = findPlayerBase()
    if not playerBase then
        StatusLabel.Text = "Could not find your base. Ensure you have a base."
        isRunning = false
        StartButton.Text = "Start Steal"
        StartButton.BackgroundTransparency = 0
        StartButton.AutoButtonColor = true
        StartButton.Active = true
        return
    end

    while isRunning and not stopRequested do
        for i = 1, 20 do
            if stopRequested then
                StatusLabel.Text = "Stopped"
                break
            end
            local timeLeft = math.floor((2 - (i - 1) * 0.1) * 100) / 100
            StatusLabel.Text = "Processing " .. tostring(timeLeft) .. "s"
            task.wait(0.1)
        end

        if not stopRequested then
            local touched = 0
            for i = 1, 8 do
                if stopRequested then
                    StatusLabel.Text = "Stopped"
                    break
                end
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("TouchTransmitter") and obj.Name == "TouchInterest" then
                        pcall(function()
                            firetouchinterest(toucher, obj.Parent, 0) -- Toca a parte associada
                            task.wait(0.13)
                            firetouchinterest(toucher, obj.Parent, 1) -- Solta
                            touched += 1
                        end)
                    end
                end
            end

            if touched > 0 then
                local basePosition
                if playerBase:IsA("BasePart") then
                    basePosition = playerBase.Position + Vector3.new(0, 5, 0)
                elseif playerBase:IsA("Model") then
                    basePosition = playerBase:GetPivot().Position + Vector3.new(0, 5, 0)
                end
                toucher.CFrame = CFrame.new(basePosition)
                StatusLabel.Text = "Success: Touched " .. touched .. " hitboxes! Teleported to base"
            else
                StatusLabel.Text = "No TouchInterest found"
            end
        end

        task.wait(0.5) -- Pequeno delay para evitar spam
    end

    isRunning = false
    StartButton.Text = "Start Steal"
    StartButton.BackgroundTransparency = 0
    StartButton.AutoButtonColor = true
    StartButton.Active = true
end

-- Bot君子

-- Conectar botões
StartButton.MouseButton1Click:Connect(startSteal)
StopButton.MouseButton1Click:Connect(function()
    if isRunning then
        stopRequested = true
        StatusLabel.Text = "Stopped"
        StartButton.Text = "Start Steal"
        StartButton.BackgroundTransparency = 0
        StartButton.AutoButtonColor = true
        StartButton.Active = true
    else
        StatusLabel.Text = "Not Running"
    end
end)

-- Verificar associação ao grupo
local isInGroup = player:IsInGroup(groupId)
if isInGroup then
    StatusLabel.Text = "Ready"
    StartButton.BackgroundColor3 = Color3.fromRGB(17, 144, 210)
    StartButton.MouseButton1Click:Connect(startSteal)
else
    StatusLabel.Text = "Join group (ID: " .. groupId .. ") to unlock Steal!"
    StartButton.Text = "Locked"
    StartButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
end

-- Notificação inicial
local filename = "already_notified.txt"
if not isfile(filename) then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Welcome!",
        Text = "Follow " .. username .. " and join group (ID: " .. groupId .. ") to unlock Steal! Don't use Steal during countdown.",
        Duration = 65
    })
    writefile(filename, "true")
end
