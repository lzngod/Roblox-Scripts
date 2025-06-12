-- Script de trapaças para Steal a Brainrot por LZNGOD
local username = "LZNGOD" -- Seu nome de usuário do Roblox
local userId = 927638286 -- Seu ID de usuário do Roblox
local timerFile = "follow_timer.txt" -- Arquivo para armazenar o tempo inicial
local waitTime = 300 -- 5 minutos (300 segundos)
local toggleIcon = "rbxassetid://15078669572" -- Ícone original

-- Função para exibir notificações
local function notify(title, text, duration)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Icon = toggleIcon,
            Duration = duration or 5
        })
    end)
end

-- Salvar tempo inicial se o arquivo não existir
if writefile and not isfile(timerFile) then
    writefile(timerFile, tostring(os.time()))
end

-- Ler tempo inicial do arquivo
local startTime = 0
if isfile and isfile(timerFile) then
    startTime = tonumber(readfile(timerFile)) or 0
end

-- Remover GUI antiga
pcall(function()
    local oldGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("FollowGui")
    if oldGui then oldGui:Destroy() end
end)

-- Criar GUI inicial
local gui = Instance.new("ScreenGui")
gui.Name = "FollowGui"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Texto de instrução
local instruction = Instance.new("TextLabel")
instruction.Size = UDim2.new(0, 340, 0, 30)
instruction.AnchorPoint = Vector2.new(0.5, 1)
instruction.Position = UDim2.new(0.5, 0, 0.5, -95)
instruction.BackgroundTransparency = 1
instruction.Text = "Siga LZNGOD no Roblox para abrir o script!"
instruction.Font = Enum.Font.GothamBold
instruction.TextSize = 16
instruction.TextColor3 = Color3.fromRGB(255, 200, 0)
instruction.TextStrokeTransparency = 0.6
instruction.TextWrapped = true
instruction.TextXAlignment = Enum.TextXAlignment.Center
instruction.Parent = gui

-- Frame principal da GUI inicial
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 190)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

-- Avatar do usuário
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0, 60, 0, 60)
avatar.Position = UDim2.new(0, 15, 0, 15)
avatar.BackgroundTransparency = 1
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=60&height=60&format=png"
avatar.Parent = frame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -90, 0, 60)
title.Position = UDim2.new(0, 85, 0, 15)
title.BackgroundTransparency = 1
title.Text = "Siga LZNGOD no Roblox!"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Caixa de texto com o nome de usuário
local box = Instance.new("TextBox")
box.Size = UDim2.new(1, -30, 0, 40)
box.Position = UDim2.new(0, 15, 0, 90)
box.Text = username
box.Font = Enum.Font.Gotham
box.TextSize = 18
box.TextColor3 = Color3.fromRGB(20, 20, 20)
box.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
box.ClearTextOnFocus = false
pcall(function() box.TextEditable = false end)
box.Parent = frame
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)

-- Botão para copiar o nome de usuário
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.48, 0, 0, 40)
copyButton.Position = UDim2.new(0, 15, 0, 140)
copyButton.Text = "Copiar Nome"
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 16
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
copyButton.Parent = frame
Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 14)

copyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(username)
        print("✅ Nome de usuário copiado!")
    else
        warn("❌ Clipboard não disponível.")
    end
end)

-- Botão de fechar (com temporizador)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.48, 0, 0, 40)
closeButton.Position = UDim2.new(0.52, -15, 0, 140)
closeButton.Text = "Aguarde 5 minutos..."
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
closeButton.Parent = frame
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 14)
closeButton.AutoButtonColor = false
closeButton.Active = false

-- Atualizar temporizador
local function updateTimer()
    while true do
        local now = os.time()
        local remaining = waitTime - (now - startTime)
        if remaining <= 0 then
            closeButton.Text = "Abrir Script"
            closeButton.AutoButtonColor = true
            closeButton.Active = true
            break
        else
            local minutes = math.floor(remaining / 60)
            local seconds = remaining % 60
            closeButton.Text = string.format("Aguarde %02d:%02d", minutes, seconds)
        end
        wait(1)
    end
end

task.spawn(updateTimer)

-- Ação ao clicar no botão de fechar
closeButton.MouseButton1Click:Connect(function()
    if not closeButton.Active then return end
    gui:Destroy()

    -- Script de trapaças (nabaruBrainrot traduzido)
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "StealBrainrot"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Frame principal
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 180, 0, 170)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Visible = false
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    -- Borda do frame
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(47, 229, 255)
    uiStroke.Thickness = 1.7
    uiStroke.Parent = frame

    -- Layout para organização
    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.Padding = UDim.new(0, 8)
    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.Parent = frame

    -- Espaçamento superior
    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingTop = UDim.new(0, 12)
    uiPadding.Parent = frame

    -- Função para criar botões com toggle
    local function createToggleButton(config)
        local default = config.Default or false
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.9, 0, 0, 32)
        button.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
        button.Font = Enum.Font.GothamBold
        button.TextSize = 18
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Text = config.Name
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.BorderSizePixel = 0
        button.Parent = frame
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

        -- Indicador de toggle
        local toggleIndicator = Instance.new("Frame")
        toggleIndicator.Size = UDim2.new(0, 18, 0, 18)
        toggleIndicator.Position = UDim2.new(1, -26, 0.5, -9)
        toggleIndicator.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(150, 150, 150)
        toggleIndicator.BorderSizePixel = 0
        toggleIndicator.Parent = button
        Instance.new("UICorner", toggleIndicator).CornerRadius = UDim.new(1, 0)

        button.MouseButton1Click:Connect(function()
            default = not default
            toggleIndicator.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(150, 150, 150)
            if config.Callback then
                config.Callback(default)
            end
        end)
    end

    -- Toggle para Auto Steal
    createToggleButton({
        Name = "Roubo Automático",
        Default = false,
        Callback = function(enabled)
            if enabled then
                print("✅ Iniciando Roubo Automático")
                pcall(function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/AutoSteal"))()
                end)
            end
        end
    })

    -- Toggle para Auto Click
    createToggleButton({
        Name = "Clique Automático",
        Default = false,
        Callback = function(enabled)
            autoClick = enabled
            modifyClickDetectors(autoClick)
        end
    })

    -- Função para modificar ClickDetectors
    local autoClick = false
    local function modifyClickDetectors(enabled)
        for _, descendant in ipairs(game:GetDescendants()) do
            if descendant:IsA("ClickDetector") then
                descendant.HoldDuration = enabled and 0 or 1
            end
        end
    end

    -- Monitorar novos ClickDetectors
    game.DescendantAdded:Connect(function(descendant)
        if descendant:IsA("ClickDetector") and autoClick then
            descendant.HoldDuration = 0
        end
    end)

    -- Toggle para Auto Jump
    local autoJump = false
    createToggleButton({
        Name = "Pulo Automático",
        Default = false,
        Callback = function(enabled)
            print("Pulo Automático:", enabled)
            if enabled then
                local function setupAutoJump()
                    local player = game:GetService("Players").LocalPlayer
                    if player:FindFirstChild("PlayerGui") then
                        player:FindFirstChild("PlayerGui"):FindFirstChild("Clicker"):Destroy()
                    end
                    local gui = Instance.new("ScreenGui")
                    gui.Name = "ClickerSteal"
                    gui.ResetOnSpawn = false
                    gui.Parent = player:WaitForChild("PlayerGui")

                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(0, 150, 0, 95)
                    frame.Position = UDim2.new(0.5, 0, 1, -50)
                    frame.AnchorPoint = Vector2.new(0.5, 1)
                    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    frame.BorderSizePixel = 0
                    frame.Active = true
                    frame.Draggable = true
                    frame.Parent = gui

                    local uiCorner = Instance.new("UICorner")
                    uiCorner.CornerRadius = UDim.new(0, 10)
                    uiCorner.Parent = frame

                    local uiStroke = Instance.new("UIStroke")
                    uiStroke.Color = Color3.fromRGB(80, 80, 100)
                    uiStroke.Thickness = 1
                    uiStroke.Transparency = 0.2
                    uiStroke.Parent = frame

                    local uiListLayout = Instance.new("UIListLayout")
                    uiListLayout.Padding = UDim.new(0, 6)
                    uiListLayout.FillDirection = Enum.FillDirection.Vertical
                    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    uiListLayout.Parent = frame

                    local uiPadding = Instance.new("UIPadding")
                    uiPadding.PaddingTop = UDim.new(0, 8)
                    uiPadding.PaddingBottom = UDim.new(0, 8)
                    uiPadding.PaddingLeft = UDim.new(0, 8)
                    uiPadding.PaddingRight = UDim.new(0, 8)
                    uiPadding.Parent = frame

                    local textBox = Instance.new("TextBox")
                    textBox.Size = UDim2.new(1, 0, 0, 22)
                    textBox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                    textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
                    textBox.Font = Enum.Font.Gotham
                    textBox.PlaceholderText = "Insira a altura"
                    textBox.Text = "7"
                    textBox.ClearTextOnFocus = false
                    textBox.TextSize = 12
                    textBox.Parent = frame

                    local uiCornerTextBox = Instance.new("UICorner")
                    uiCornerTextBox.CornerRadius = UDim.new(0, 6)
                    uiCornerTextBox.Parent = textBox

                    local button = Instance.new("TextButton")
                    button.Size = UDim2.new(1, 0, 0, 26)
                    button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    button.TextColor3 = Color3.new(1, 1, 1)
                    button.Text = "Pular!"
                    button.Font = Enum.Font.GothamBold
                    button.TextSize = 13
                    button.AutoButtonColor = true
                    button.Parent = frame

                    local uiCornerButton = Instance.new("UICorner")
                    uiCornerButton.CornerRadius = UDim.new(0, 6)
                    uiCornerButton.Parent = button

                    local part = nil
                    button.MouseButton1Click:Connect(function()
                        if part and part.Parent then
                            part:Destroy()
                            part = nil
                            button.Text = "Pular!"
                        else
                            local character = player.Character
                            if not character or not character:FindFirstChild("Head") or not character:FindFirstChild("HumanoidRootPart") then
                                return
                            end
                            local height = tonumber(textBox.Text) or 6
                            local head = character.Head
                            part = Instance.new("Part")
                            part.Name = "ClickerPart"
                            part.Size = Vector3.new(1000, 1, 1000)
                            part.Anchored = true
                            part.Transparency = 1
                            part.CanCollide = true
                            part.Position = head.Position + Vector3.new(0, height, 0)
                            part.Material = Enum.Material.Neon
                            part.BrickColor = BrickColor.new("Really red")
                            part.Parent = workspace
                            task.wait(0.1)
                            character.HumanoidRootPart.CFrame = CFrame.new(part.Position + Vector3.new(0, 3, 0))
                            button.Text = "Parar Pulo"
                        end
                    end)
                end
                setupAutoJump()
            end
            autoJump = enabled
        end
    })

    -- Botão de toggle da GUI
    local toggleButton = Instance.new("ImageButton")
    toggleButton.Name = "ToggleSteal"
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 50, 0.2, 0)
    toggleButton.Image = toggleIcon
    toggleButton.BackgroundTransparency = 1
    toggleButton.Parent = screenGui
    toggleButton.Active = true
    toggleButton.Draggable = true
    Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 12)

    local guiVisible = false
    toggleButton.MouseButton1Click:Connect(function()
        guiVisible = not guiVisible
        frame.Visible = guiVisible
    end)

    -- Notificação inicial
    game.StarterGui:SetCore("SendNotification", {
        Title = "Sucesso!",
        Text = "Script carregado com sucesso!",
        Icon = toggleIcon,
        Duration = 5
    })

    -- Modificar BillboardGuis
    local function modifyBillboardGui(descendant)
        if descendant:IsA("BillboardGui") and descendant.Name == "Clicker" then
            local parent = descendant.Parent
            while parent do
                if parent:IsA("Model") and parent.Name == "Clicker" then
                    for _, child in ipairs(descendant:GetChildren()) do
                        if child:IsA("Frame") then
                            child.Size = UDim2.new(0, 180, 0, 150)
                            child.MaxDistance = 80
                            child.StudsOffset = Vector3.new(0, 5, 0)
                            print("✅ Placa modificada:", descendant:GetFullName())
                        end
                    end
                    break
                end
                parent = parent.Parent
            end
        end
    end

    for _, descendant in ipairs(workspace:GetDescendants()) do
        modifyBillboardGui(descendant)
    end
    workspace.DescendantAdded:Connect(function(descendant)
        modifyBillboardGui(descendant)
    end)

    -- Modificar ProximityPrompts
    local function modifyProximityPrompt(descendant)
        if descendant:IsA("ProximityPrompt") and descendant.Name == "StealPrompt" then
            local parent = descendant.Parent
            while parent do
                if parent:IsA("Model") and parent.Name == "Clicker" and parent:IsDescendantOf(workspace) then
                    descendant.Enabled = false
                    descendant.RequiresLineOfSight = false
                    descendant.HoldDuration = 0
                    descendant.MaxActivationDistance = 0
                    print("🫥 Prompt oculto:", descendant:GetFullName())
                    break
                end
                parent = parent.Parent
            end
        end
    end

    for _, descendant in ipairs(workspace:GetDescendants()) do
        modifyProximityPrompt(descendant)
    end
    workspace.DescendantAdded:Connect(function(descendant)
        modifyProximityPrompt(descendant)
    end)
end)

-- Notificação inicial
local filename = "already_executed.txt"
if not isfile(filename) then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Mensagem",
        Text = "Siga LZNGOD antes do tempo acabar!",
        Duration = 300
    })
    writefile(filename, "true")
end
