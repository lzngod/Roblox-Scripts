-- Configurações iniciais
local groupId = 34479814 -- ID do grupo
local username = "FaDhenGaming"
local userId = 6027385792

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Esperar até o jogador estar completamente carregado
if not player:IsDescendantOf(Players) then
    player.AncestryChanged:Wait()
end

-- Criar GUI principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CombinedGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Frame principal (arrastável)
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.Size = UDim2.new(0, 360, 0, 200)
Frame.Active = true
Frame.Draggable = true
local UICorner_Frame = Instance.new("UICorner")
UICorner_Frame.CornerRadius = UDim.new(0, 10)
UICorner_Frame.Parent = Frame

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
local CopyButton = Instance.new("TextButton")
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

-- Botão Steal (inicialmente desativado)
local StealButton = Instance.new("TextButton")
StealButton.Parent = Frame
StealButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Cinza quando desativado
StealButton.Position = UDim2.new(0, 110, 0, 120)
StealButton.Size = UDim2.new(0, 230, 0, 30)
StealButton.Font = Enum.Font.GothamBold
StealButton.Text = "Click Steal"
StealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StealButton.TextSize = 15
local UICorner_Steal = Instance.new("UICorner")
UICorner_Steal.CornerRadius = UDim.new(0, 8)
UICorner_Steal.Parent = StealButton

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
hoverEffect(StealButton, Color3.fromRGB(30, 200, 100), Color3.fromRGB(25, 180, 90))
hoverEffect(CloseButton, Color3.fromRGB(200, 50, 50), Color3.fromRGB(180, 30, 30))

-- Função para copiar username
CopyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(username)
        StatusLabel.Text = "✅ Username Copied!"
        wait(1.5)
        StatusLabel.Text = "Ready"
    else
        StatusLabel.Text = "❌ Clipboard Error"
    end
end)

-- Fechar GUI
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Função para interagir com DeliveryHitbox
local function fireTouch()
    local char = player.Character or player.CharacterAdded:Wait()
    local toucher = char:FindFirstChild("HumanoidRootPart")
    if not toucher then
        StatusLabel.Text = "No HumanoidRootPart found"
        return
    end

    -- Contagem regressiva
    for i = 1, 19 do
        local timeLeft = math.floor((1.9 - (i - 1) * 0.1) * 10) / 10
        StatusLabel.Text = "Working " .. tostring(timeLeft) .. "s"
        wait(0.1)
    end

    local touched = 0
    for i = 1, 2 do
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name == "DeliveryHitbox" then
                firetouchinterest(toucher, obj, 0) -- Toca
                wait(0.13)
                firetouchinterest(toucher, obj, 1) -- Solta
                touched += 1
            end
        end
    end

    StatusLabel.Text = touched > 0 and "Success: Touched " .. touched .. " hitboxes!" or "No DeliveryHitbox found"
end

-- Verificar associação ao grupo
local isInGroup = player:IsInGroup(groupId)
if isInGroup then
    StatusLabel.Text = "Ready"
    StealButton.BackgroundColor3 = Color3.fromRGB(30, 200, 100) -- Verde quando ativado
    StealButton.MouseButton1Click:Connect(fireTouch)
else
    StatusLabel.Text = "Join group (ID: " .. groupId .. ") to unlock Steal!"
    StealButton.Text = "Locked"
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
