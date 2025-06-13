-- Script de promoção para o perfil Roblox: ID 927638286, Usuário LZNGOD

-- Configuração do temporizador
local filePath = "timer_file.txt"  -- Nome do arquivo para armazenar o tempo
local waitTime = 30  -- Tempo de espera em segundos (30 Segundos)

if not isfile(filePath) then
    writefile(filePath, tostring(os.time()))
end

local startTime = tonumber(readfile(filePath)) or 0

-- Criação da ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PromotionGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Título
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 340, 0, 30)
titleLabel.AnchorPoint = Vector2.new(0.5, 1)
titleLabel.Position = UDim2.new(0.5, 0, 0.5, -95)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Follow LZNGOD on Roblox"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
titleLabel.TextStrokeTransparency = 0.6
titleLabel.TextWrapped = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.Parent = screenGui

-- Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 190)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 16)

-- Imagem (ajustada para o ID fornecido)
local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 60, 0, 60)
imageLabel.Position = UDim2.new(0, 15, 0, 15)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://927638286"  -- ID do perfil fornecido
imageLabel.Parent = frame

-- Texto informativo
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -90, 0, 60)
textLabel.Position = UDim2.new(0, 85, 0, 15)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Follow this user"
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 20
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = frame

-- Caixa de texto com o nome de usuário
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -30, 0, 40)
textBox.Position = UDim2.new(0, 15, 0, 90)
textBox.Text = "LZNGOD"
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 18
textBox.TextColor3 = Color3.fromRGB(200, 200, 200)
textBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
textBox.ClearTextOnFocus = false
textBox.TextEditable = false
textBox.Parent = frame

local textBoxCorner = Instance.new("UICorner", textBox)
textBoxCorner.CornerRadius = UDim.new(0, 12)

-- Botão para copiar o nome de usuário
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.48, 0, 0, 40)
copyButton.Position = UDim2.new(0, 15, 0, 140)
copyButton.Text = "Copy Username"
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 16
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
copyButton.Parent = frame

local copyButtonCorner = Instance.new("UICorner", copyButton)
copyButtonCorner.CornerRadius = UDim.new(0, 14)

copyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("LZNGOD")
        print("✅ Username successfully copied!")
    else
        warn("❌ Clipboard not available.")
    end
end)

-- Botão para prosseguir
local proceedButton = Instance.new("TextButton")
proceedButton.Size = UDim2.new(0.48, 0, 0, 40)
proceedButton.Position = UDim2.new(0.52, -15, 0, 140)
proceedButton.Text = "Wait..."
proceedButton.Font = Enum.Font.GothamBold
proceedButton.TextSize = 16
proceedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
proceedButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
proceedButton.Parent = frame

local proceedButtonCorner = Instance.new("UICorner", proceedButton)
proceedButtonCorner.CornerRadius = UDim.new(0, 14)

proceedButton.AutoButtonColor = false
proceedButton.Active = false

-- Função para atualizar o botão de prosseguir
local function updateButton()
    while true do
        local currentTime = os.time()
        local timeLeft = waitTime - (currentTime - startTime)
        if timeLeft <= 0 then
            proceedButton.Text = "Proceed"
            proceedButton.AutoButtonColor = true
            proceedButton.Active = true
            break
        else
            local minutes = math.floor(timeLeft / 60)
            local seconds = timeLeft % 60
            proceedButton.Text = string.format("Wait %d minutes %d seconds", minutes, seconds)
        end
        wait(=1)
    end
end

task.spawn(updateButton)

-- Evento de clique no botão de prosseguir
proceedButton.MouseButton1Click:Connect(function()
    if proceedButton.Active then
        screenGui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/Script%20Brainrot%20New"))()
    end
end)

-- Notificação
if not isfile("notification_sent.txt") then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Follow",
        Text = "Follow LZNGOD on Roblox",
        Duration = 300
    })
    writefile("notification_sent.txt", "sent")
end
