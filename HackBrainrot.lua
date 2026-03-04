--[[
    LZNGOD O TOTOSO CREATOR.

    LZNDEV - 2026
]]

-- ===================== SERVICES =====================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

-- ===================== CONFIG =====================
local LocalPlayer = Players.LocalPlayer
local CORRECT_USERNAME = "LZNGOD"
local CORRECT_PASSWORD = "lzndev"
local DISCORD_LINK = "https://discord.gg/EmBreveCria"
local TIKTOK_LINK = "https://www.tiktok.com/EmBreveCria"
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

-- ===================== BLUR EFFECT (TELA DE LOGIN) =====================
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 0
blurEffect.Parent = Lighting
TweenService:Create(blurEffect, TweenInfo.new(0.4), {Size = 18}):Play()

-- ===================== LOGIN SCREEN GUI =====================
local loginGui = Instance.new("ScreenGui")
loginGui.ResetOnSpawn = false
loginGui.Name = "LZN_PRIVATE_ACCESS"
loginGui.IgnoreGuiInset = true
loginGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local loginFrame = Instance.new("Frame")
loginFrame.Size = UDim2.new(0, 520, 0, 340)
loginFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
loginFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
loginFrame.BackgroundTransparency = 0.06
loginFrame.Parent = loginGui
loginFrame.ClipsDescendants = true
Instance.new("UICorner", loginFrame).CornerRadius = UDim.new(0, 16)

-- ===================== DRAG FUNCTION =====================
local function makeDraggable(guiObject)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function update(input)
        if not dragging then return end
        local delta = input.Position - dragStart
        guiObject.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            dragInput = input

            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    dragInput = nil
                    connection:Disconnect()
                end
            end)
        end
    end)

    guiObject.InputChanged:Connect(function(input)
        if input == dragInput then
            update(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input == dragInput then
            dragging = false
            dragInput = nil
        end
    end)
end

makeDraggable(loginFrame)

-- ===================== RAINBOW STROKE (LOGIN) =====================
local loginStroke = Instance.new("UIStroke")
loginStroke.Thickness = 1.5
loginStroke.Parent = loginFrame

RunService.RenderStepped:Connect(function()
    local hue = 0.75 + (math.sin(tick() * 0.6) * 0.05)
    loginStroke.Color = Color3.fromHSV(hue, 1, 1)
end)

-- ===================== TITLE =====================
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 60)
titleLabel.Position = UDim2.new(0, 0, 0, 25)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "LZNGOD PRO"
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 26
titleLabel.TextColor3 = Color3.fromRGB(210, 180, 255)
titleLabel.Parent = loginFrame

-- ===================== SUBTITLE =====================
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(1, 0, 0, 25)
subtitleLabel.Position = UDim2.new(0, 0, 0, 80)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "@LZNDEV"
subtitleLabel.Font = Enum.Font.GothamMedium
subtitleLabel.TextSize = 13
subtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 160)
subtitleLabel.Parent = loginFrame

-- ===================== INPUT FIELDS =====================
local function createInputField(yPos, placeholder)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.7, 0, 0, 40)
    textBox.Position = UDim2.new(0.15, 0, 0, yPos)
    textBox.BackgroundTransparency = 1
    textBox.Text = ""
    textBox.PlaceholderText = placeholder
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 15
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Parent = loginFrame

    local underline = Instance.new("Frame")
    underline.Size = UDim2.new(0.7, 0, 0, 2)
    underline.Position = UDim2.new(0.15, 0, 0, yPos + 40)
    underline.BackgroundColor3 = Color3.fromRGB(80, 0, 180)
    underline.BorderSizePixel = 0
    underline.Parent = loginFrame

    return textBox
end

local usernameBox = createInputField(120, "Username")
local passwordBox = createInputField(175, "Password")

-- ===================== LOGIN BUTTON =====================
local loginButton = Instance.new("TextButton")
loginButton.Size = UDim2.new(0.7, 0, 0, 45)
loginButton.Position = UDim2.new(0.15, 0, 0, 230)
loginButton.Text = "LOGIN"
loginButton.Font = Enum.Font.GothamBold
loginButton.TextSize = 15
loginButton.TextColor3 = Color3.new(1, 1, 1)
loginButton.BackgroundColor3 = Color3.fromRGB(95, 0, 210)
loginButton.Parent = loginFrame
Instance.new("UICorner", loginButton).CornerRadius = UDim.new(0, 10)

-- ===================== SOCIAL BUTTONS =====================
local function createSocialButton(text, xScale, url)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 30)
    btn.Position = UDim2.new(xScale, 0, 1, -40)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    btn.BorderSizePixel = 0
    btn.Parent = loginFrame

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 1.2

    RunService.RenderStepped:Connect(function()
        local hue = 0.75 + (math.sin(tick() * 0.6) * 0.05)
        stroke.Color = Color3.fromHSV(hue, 1, 1)
    end)

    btn.Activated:Connect(function()
        pcall(function() GuiService:OpenBrowserWindow(url) end)
        pcall(function() GuiService:PromptOpenBrowserWindow(url) end)
        pcall(function()
            if setclipboard then setclipboard(url) end
        end)
    end)

    return btn
end

local discordBtn = createSocialButton("Discord", 0.2, DISCORD_LINK)
local tiktokBtn = createSocialButton("TikTok", 0.58, TIKTOK_LINK)

-- ===================== CLOSE BUTTON (X) =====================
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 32, 0, 32)
closeButton.Position = UDim2.new(1, -45, 0, 12)
closeButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.TextColor3 = Color3.fromRGB(220, 90, 90)
closeButton.BorderSizePixel = 0
closeButton.Parent = loginFrame
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(1, 0)

closeButton.Activated:Connect(function()
    TweenService:Create(loginFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.25)
    loginGui:Destroy()
    blurEffect:Destroy()
end)

-- ===================== LOGIN HANDLER =====================
loginButton.Activated:Connect(function()
    if usernameBox.Text == CORRECT_USERNAME and passwordBox.Text == CORRECT_PASSWORD then
        -- Login correto: fechar tela de login
        TweenService:Create(loginFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.25)
        loginGui:Destroy()
        blurEffect:Destroy()

        -- ===================== SERVIÇOS PÓS-LOGIN =====================
        local TeleportService = game:GetService("TeleportService")
        local camera = workspace.CurrentCamera

        -- ===================== MAIN MENU GUI =====================
        local mainGui = Instance.new("ScreenGui")
        mainGui.Name = "LZN_PRO"
        mainGui.ResetOnSpawn = false
        mainGui.IgnoreGuiInset = true
        mainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local mainFrame = Instance.new("Frame")
        mainFrame.Size = isMobile and UDim2.new(0, 480, 0, 320) or UDim2.new(0, 650, 0, 420)
        mainFrame.Position = isMobile and UDim2.new(0.5, -240, 0.5, -160) or UDim2.new(0.5, -325, 0.5, -210)
        mainFrame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
        mainFrame.Parent = mainGui
        mainFrame.ClipsDescendants = true
        Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 20)

        -- Rainbow stroke (menu principal)
        local mainStroke = Instance.new("UIStroke", mainFrame)
        mainStroke.Thickness = 1.5
        RunService.RenderStepped:Connect(function()
            local hue = (tick() * 0.08) % 1
            mainStroke.Color = Color3.fromHSV(hue, 0.8, 1)
        end)

        makeDraggable(mainFrame)

        -- ===================== SIDEBAR =====================
        local sidebar = Instance.new("Frame")
        sidebar.Size = isMobile and UDim2.new(0, 140, 1, 0) or UDim2.new(0, 180, 1, 0)
        sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
        sidebar.Parent = mainFrame
        Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 20)

        -- Título do menu
        local menuTitle = Instance.new("TextLabel")
        menuTitle.Size = UDim2.new(1, 0, 0, 60)
        menuTitle.BackgroundTransparency = 1
        menuTitle.Text = "LZN"
        menuTitle.Font = Enum.Font.GothamBlack
        menuTitle.TextSize = isMobile and 20 or 22
        menuTitle.TextColor3 = Color3.fromRGB(200, 170, 255)
        menuTitle.Parent = sidebar

        -- ===================== CONTENT AREA =====================
        local contentArea = Instance.new("Frame")
        contentArea.Size = UDim2.new(1, -(isMobile and 140 or 180), 1, 0)
        contentArea.Position = UDim2.new(0, isMobile and 140 or 180, 0, 0)
        contentArea.BackgroundTransparency = 1
        contentArea.Parent = mainFrame

        -- ===================== TOGGLE MENU BUTTON =====================
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 120, 0, 40)
        toggleBtn.Position = UDim2.new(0.5, -60, 0, 20)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        toggleBtn.Text = "ABRIR MENU"
        toggleBtn.TextColor3 = Color3.new(1, 1, 1)
        toggleBtn.Font = Enum.Font.GothamBold
        toggleBtn.TextSize = 16
        toggleBtn.Parent = mainGui
        Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", toggleBtn).Color = Color3.new(1, 1, 1)

        toggleBtn.Activated:Connect(function()
            mainFrame.Visible = not mainFrame.Visible
            toggleBtn.Text = mainFrame.Visible and "FECHAR MENU" or "ABRIR MENU"
        end)

        -- ===================== TABS =====================
        local TAB_NAMES = {"Player", "Mapa", "Farm", "Misc"}
        local tabPages = {}

        local function createTabPage(tabName)
            local scrollFrame = Instance.new("ScrollingFrame")
            scrollFrame.Size = UDim2.new(1, -40, 1, -40)
            scrollFrame.Position = UDim2.new(0, 20, 0, 20)
            scrollFrame.ScrollBarThickness = 4
            scrollFrame.BackgroundTransparency = 1
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
            scrollFrame.Visible = false
            scrollFrame.Parent = contentArea

            local layout = Instance.new("UIListLayout")
            layout.Parent = scrollFrame
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 10)
            layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

            tabPages[tabName] = scrollFrame
            return scrollFrame
        end

        -- Criar botões das tabs e páginas
        for i, tabName in ipairs(TAB_NAMES) do
            local tabBtn = Instance.new("TextButton")
            tabBtn.Size = UDim2.new(1, -20, 0, isMobile and 42 or 45)
            tabBtn.Position = UDim2.new(0, 10, 0, 70 + ((i - 1) * (isMobile and 52 or 60)))
            tabBtn.Text = tabName
            tabBtn.Font = Enum.Font.GothamBold
            tabBtn.TextSize = isMobile and 14 or 15
            tabBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
            tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
            tabBtn.Parent = sidebar
            Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 12)

            local page = createTabPage(tabName)

            tabBtn.MouseEnter:Connect(function()
                TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 50)}):Play()
            end)

            tabBtn.MouseLeave:Connect(function()
                TweenService:Create(tabBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
            end)

            tabBtn.Activated:Connect(function()
                for _, p in pairs(tabPages) do p.Visible = false end
                page.Visible = true
                task.delay(0.03, function()
                    page.CanvasSize = UDim2.new(0, 0, 0, page.UIListLayout.AbsoluteContentSize.Y + 40)
                end)
            end)
        end

        -- Mostrar tab "Player" por padrão
        tabPages["Player"].Visible = true
        task.delay(0.1, function()
            local layout = tabPages["Player"]:FindFirstChild("UIListLayout")
            if layout then
                tabPages["Player"].CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 40)
            end
        end)

        -- ===================== TOGGLE SWITCH CREATOR =====================
        local function createToggle(parent, label, callback)
            local isOn = false

            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -10, 0, 60)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            toggleFrame.Parent = parent
            Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 16)

            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
            toggleLabel.Position = UDim2.new(0, 20, 0, 0)
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Text = label
            toggleLabel.Font = Enum.Font.GothamBold
            toggleLabel.TextSize = 16
            toggleLabel.TextColor3 = Color3.fromRGB(230, 230, 255)
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.TextWrapped = true
            toggleLabel.Parent = toggleFrame

            -- Track (fundo do switch)
            local track = Instance.new("Frame")
            track.Size = UDim2.new(0, 55, 0, 28)
            track.Position = UDim2.new(1, -85, 0.5, -14)
            track.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            track.Parent = toggleFrame
            Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

            -- Knob (bolinha do switch)
            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 24, 0, 24)
            knob.Position = UDim2.new(0, 2, 0.5, -12)
            knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            knob.Parent = track
            Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

            toggleFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or
                   input.UserInputType == Enum.UserInputType.Touch then
                    isOn = not isOn

                    if isOn then
                        TweenService:Create(knob, TweenInfo.new(0.2), {
                            Position = UDim2.new(1, -26, 0.5, -12)
                        }):Play()
                        TweenService:Create(track, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                        }):Play()
                    else
                        TweenService:Create(knob, TweenInfo.new(0.2), {
                            Position = UDim2.new(0, 2, 0.5, -12)
                        }):Play()
                        TweenService:Create(track, TweenInfo.new(0.2), {
                            BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                        }):Play()
                    end

                    print("[LZN] " .. label .. " → " .. (isOn and "ON" or "OFF"))
                    if callback then callback(isOn) end
                end
            end)

            return function() return isOn end
        end

        -- ===================== ACTION BUTTON CREATOR =====================
        local function createActionButton(parent, label, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 60)
            btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
            btn.Text = label
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 16
            btn.TextColor3 = Color3.fromRGB(230, 230, 255)
            btn.Parent = parent
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 16)

            btn.Activated:Connect(callback)
            return btn
        end

        -- ===================== TAB: PLAYER =====================
        local getAimbot = createToggle(tabPages["Player"], "Aimbot")
        local getFovCircle = createToggle(tabPages["Player"], "FOV Circle")
        local getEsp = createToggle(tabPages["Player"], "EPS") -- ESP para todos os players

        -- ===================== TAB: MAPA =====================
        local getFullbright = createToggle(tabPages["Mapa"], "Fullbright")
        local getRemoveFog = createToggle(tabPages["Mapa"], "Remove Fog")
        local getRemoveLag = createToggle(tabPages["Mapa"], "Remove Lag", function(state)
            if state then
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
                print("[LZN] Remove Lag ON - gráficos baixos")
            else
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
                print("[LZN] Remove Lag OFF - qualidade normal")
            end
        end)

        -- ===================== TAB: FARM =====================
        local farmWarning = Instance.new("Frame")
        farmWarning.Size = UDim2.new(1, -10, 0, 60)
        farmWarning.BackgroundColor3 = Color3.fromRGB(35, 20, 20)
        farmWarning.Parent = tabPages["Farm"]
        Instance.new("UICorner", farmWarning).CornerRadius = UDim.new(0, 16)

        local farmWarningLabel = Instance.new("TextLabel")
        farmWarningLabel.Size = UDim2.new(1, -20, 1, 0)
        farmWarningLabel.Position = UDim2.new(0, 10, 0, 0)
        farmWarningLabel.BackgroundTransparency = 1
        farmWarningLabel.Text = "⚠ SISTEMA DE FARM TEMPORARIAMENTE EM MANUTENÇÃO"
        farmWarningLabel.Font = Enum.Font.GothamBold
        farmWarningLabel.TextSize = 16
        farmWarningLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
        farmWarningLabel.TextWrapped = true
        farmWarningLabel.TextXAlignment = Enum.TextXAlignment.Center
        farmWarningLabel.Parent = farmWarning

        createToggle(tabPages["Farm"], "Auto Farm Lixo")
        createToggle(tabPages["Farm"], "Auto Farm Peixe")
        createToggle(tabPages["Farm"], "Auto Farm Essência")
        createToggle(tabPages["Farm"], "Auto Farm Peças")

        -- ===================== TAB: MISC =====================
        local getStaffEsp = createToggle(tabPages["Misc"], "Staff ESP")

        local noclipEnabled = false
        local noclipConnection

        createToggle(tabPages["Misc"], "Noclip", function(state)
            noclipEnabled = state
            if state then
                if noclipConnection then noclipConnection:Disconnect() end
                noclipConnection = RunService.Stepped:Connect(function()
                    if LocalPlayer.Character then
                        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
                print("[Noclip] Ativado")
            else
                if noclipConnection then noclipConnection:Disconnect() end
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
                print("[Noclip] Desativado")
            end
        end)

        createActionButton(tabPages["Misc"], "Rejoin (Outro Server)", function()
            print("[LZN] Tentando rejoin...")
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)

        createActionButton(tabPages["Misc"], "Speed Hack", function()
            -- Verifica se já existe o menu de speed
            local speedGui = LocalPlayer.PlayerGui:FindFirstChild("LZNSpeed")
            if speedGui then
                speedGui.Enabled = not speedGui.Enabled
                return
            end

            -- Criar GUI de Speed separada
            speedGui = Instance.new("ScreenGui")
            speedGui.Name = "LZNSpeed"
            speedGui.ResetOnSpawn = false
            speedGui.IgnoreGuiInset = true
            speedGui.Parent = LocalPlayer.PlayerGui

            local speedFrame = Instance.new("Frame")
            speedFrame.Size = UDim2.new(0, 240, 0, 340)
            speedFrame.Position = UDim2.new(0.5, -120, 0.5, -170)
            speedFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
            speedFrame.Parent = speedGui
            Instance.new("UICorner", speedFrame).CornerRadius = UDim.new(0, 12)

            local speedStroke = Instance.new("UIStroke", speedFrame)
            speedStroke.Thickness = 2
            speedStroke.Color = Color3.fromRGB(0, 170, 255)

            makeDraggable(speedFrame)

            local speedTitle = Instance.new("TextLabel")
            speedTitle.Size = UDim2.new(1, 0, 0, 40)
            speedTitle.BackgroundTransparency = 1
            speedTitle.Text = "LZN Speed"
            speedTitle.Font = Enum.Font.GothamBlack
            speedTitle.TextSize = 24
            speedTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
            speedTitle.Parent = speedFrame

            local currentSpeed = 16 -- Velocidade padrão do Roblox
            local speedConnection = nil

            local function setSpeed(speed)
                if speedConnection then
                    speedConnection:Disconnect()
                    speedConnection = nil
                end
                currentSpeed = speed

                print("[SPEED SAFE] Ativando " .. speed .. " studs/s")

                if speed > 16 then
                    speedConnection = RunService.Heartbeat:Connect(function(dt)
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                            local rootPart = char.HumanoidRootPart
                            local humanoid = char.Humanoid
                            local moveDir = humanoid.MoveDirection
                            if moveDir.Magnitude > 0 then
                                local newPos = rootPart.Position + (moveDir * (speed - 16) * dt * 2)
                                rootPart.CFrame = (CFrame.new(newPos) * rootPart.CFrame) - rootPart.Position
                            end
                        end
                    end)
                end
            end

            -- Botões Speed x1, x2, x3
            for level = 1, 3 do
                local speedBtn = Instance.new("TextButton")
                speedBtn.Size = UDim2.new(0.8, 0, 0, 40)
                speedBtn.Position = UDim2.new(0.1, 0, 0.15 + ((level - 1) * 0.15), 0)
                speedBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
                speedBtn.Text = "Speed x" .. level
                speedBtn.Font = Enum.Font.GothamBold
                speedBtn.TextSize = 16
                speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                speedBtn.Parent = speedFrame
                Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 8)

                speedBtn.Activated:Connect(function()
                    setSpeed(16 + (level * 20)) -- Speed x1=36, x2=56, x3=76
                end)
            end

            -- Botão Parar
            local stopBtn = Instance.new("TextButton")
            stopBtn.Size = UDim2.new(0.8, 0, 0, 40)
            stopBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
            stopBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            stopBtn.Text = "Parar (16)"
            stopBtn.Font = Enum.Font.GothamBold
            stopBtn.TextSize = 16
            stopBtn.TextColor3 = Color3.new(1, 1, 1)
            stopBtn.Parent = speedFrame
            Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 8)
            stopBtn.Activated:Connect(function() setSpeed(16) end)

            -- Botão Minimizar
            local minimizeBtn = Instance.new("TextButton")
            minimizeBtn.Size = UDim2.new(0.8, 0, 0, 40)
            minimizeBtn.Position = UDim2.new(0.1, 0, 0.82, 0)
            minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
            minimizeBtn.Text = "Minimizar"
            minimizeBtn.Font = Enum.Font.GothamBold
            minimizeBtn.TextSize = 16
            minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
            minimizeBtn.Parent = speedFrame
            Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 8)

            minimizeBtn.Activated:Connect(function()
                speedGui.Enabled = false
                print("[LZN Speed] Menu minimizado")
            end)

            print("[LZN Speed] Menu separado aberto!")
        end)

        -- ===================== FOV CIRCLE (AIMBOT VISUAL) =====================
        local fovSize = 120 -- Tamanho padrão do FOV

        local fovGui = Instance.new("ScreenGui")
        fovGui.ResetOnSpawn = false
        fovGui.IgnoreGuiInset = true
        fovGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local fovContainer = Instance.new("Frame")
        fovContainer.AnchorPoint = Vector2.new(0.5, 0.5)
        fovContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
        fovContainer.Size = UDim2.new(0, fovSize * 2, 0, fovSize * 2)
        fovContainer.BackgroundTransparency = 1
        fovContainer.Parent = fovGui

        local fovCircle = Instance.new("Frame")
        fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
        fovCircle.Size = UDim2.new(1, 0, 1, 0)
        fovCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
        fovCircle.BackgroundTransparency = 1
        fovCircle.Parent = fovContainer

        local fovStroke = Instance.new("UIStroke")
        fovStroke.Thickness = 4
        fovStroke.Transparency = 0
        fovStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        fovStroke.Parent = fovCircle

        local fovCorner = Instance.new("UICorner")
        fovCorner.CornerRadius = UDim.new(1, 0)
        fovCorner.Parent = fovCircle

        -- ===================== ESP SYSTEM =====================
        local espDrawings = {Box = {}, Tracer = {}, Name = {}}     -- ESP normal (branco)
        local staffDrawings = {Box = {}, Tracer = {}, Name = {}}   -- ESP Staff (vermelho)

        local function initializeESP(drawingTable, color)
            for _, player in Players:GetPlayers() do
                if player ~= LocalPlayer then
                    drawingTable.Box[player] = Drawing.new("Square")
                    drawingTable.Box[player].Filled = false
                    drawingTable.Box[player].Thickness = 3
                    drawingTable.Box[player].Color = color

                    drawingTable.Tracer[player] = Drawing.new("Line")
                    drawingTable.Tracer[player].Thickness = 2
                    drawingTable.Tracer[player].Color = color

                    drawingTable.Name[player] = Drawing.new("Text")
                    drawingTable.Name[player].Size = 14
                    drawingTable.Name[player].Center = true
                    drawingTable.Name[player].Outline = true
                    drawingTable.Name[player].Color = color
                end
            end
        end

        initializeESP(espDrawings, Color3.new(1, 1, 1))          -- Branco para players normais
        initializeESP(staffDrawings, Color3.fromRGB(255, 0, 0))  -- Vermelho para staff

        -- Novo player entra
        Players.PlayerAdded:Connect(function(player)
            if player ~= LocalPlayer then
                -- ESP normal
                espDrawings.Box[player] = Drawing.new("Square")
                espDrawings.Box[player].Filled = false
                espDrawings.Box[player].Thickness = 3
                espDrawings.Box[player].Color = Color3.new(1, 1, 1)

                espDrawings.Tracer[player] = Drawing.new("Line")
                espDrawings.Tracer[player].Thickness = 2
                espDrawings.Tracer[player].Color = Color3.new(1, 1, 1)

                espDrawings.Name[player] = Drawing.new("Text")
                espDrawings.Name[player].Size = 14
                espDrawings.Name[player].Center = true
                espDrawings.Name[player].Outline = true
                espDrawings.Name[player].Color = Color3.new(1, 1, 1)

                -- ESP Staff
                staffDrawings.Box[player] = Drawing.new("Square")
                staffDrawings.Box[player].Filled = false
                staffDrawings.Box[player].Thickness = 3
                staffDrawings.Box[player].Color = Color3.fromRGB(255, 0, 0)

                staffDrawings.Tracer[player] = Drawing.new("Line")
                staffDrawings.Tracer[player].Thickness = 2
                staffDrawings.Tracer[player].Color = Color3.fromRGB(255, 0, 0)

                staffDrawings.Name[player] = Drawing.new("Text")
                staffDrawings.Name[player].Size = 14
                staffDrawings.Name[player].Center = true
                staffDrawings.Name[player].Outline = true
                staffDrawings.Name[player].Color = Color3.fromRGB(255, 0, 0)
            end
        end)

        -- Player sai: limpar drawings
        Players.PlayerRemoving:Connect(function(player)
            for _, drawingTable in {espDrawings, staffDrawings} do
                if drawingTable.Box[player] then
                    drawingTable.Box[player]:Remove()
                    drawingTable.Box[player] = nil
                end
                if drawingTable.Tracer[player] then
                    drawingTable.Tracer[player]:Remove()
                    drawingTable.Tracer[player] = nil
                end
                if drawingTable.Name[player] then
                    drawingTable.Name[player]:Remove()
                    drawingTable.Name[player] = nil
                end
            end
        end)

        -- ===================== AIMBOT: ENCONTRAR ALVO MAIS PRÓXIMO =====================
        local function getClosestPlayer()
            local closest = nil
            local closestDist = fovSize
            local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

            for _, player in Players:GetPlayers() do
                if player ~= LocalPlayer and player.Character
                   and player.Character:FindFirstChild("Head")
                   and player.Character:FindFirstChild("Humanoid")
                   and player.Character.Humanoid.Health > 0 then

                    local head = player.Character.Head
                    local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)

                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closest = head
                        end
                    end
                end
            end

            return closest
        end

        -- ===================== FULLBRIGHT SYSTEM =====================
        local fullbrightActive = false
        local savedLighting = {}
        local originalFogEnd = Lighting.FogEnd

        -- ===================== MAIN RENDER LOOP =====================
        RunService.RenderStepped:Connect(function()
            -- Atualizar FOV Circle
            fovContainer.Size = UDim2.new(0, fovSize * 2, 0, fovSize * 2)
            fovContainer.Visible = getFovCircle()
            fovStroke.Color = Color3.new(1, 1, 1)

            -- Fullbright
            if getFullbright() then
                if not fullbrightActive then
                    savedLighting = {
                        Brightness = Lighting.Brightness,
                        ClockTime = Lighting.ClockTime,
                        GlobalShadows = Lighting.GlobalShadows,
                        EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
                        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
                        OutdoorAmbient = Lighting.OutdoorAmbient,
                    }
                    fullbrightActive = true
                end
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.GlobalShadows = false
                Lighting.EnvironmentDiffuseScale = 0
                Lighting.EnvironmentSpecularScale = 0
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            elseif fullbrightActive then
                Lighting.Brightness = savedLighting.Brightness
                Lighting.ClockTime = savedLighting.ClockTime
                Lighting.GlobalShadows = savedLighting.GlobalShadows
                Lighting.EnvironmentDiffuseScale = savedLighting.EnvironmentDiffuseScale
                Lighting.EnvironmentSpecularScale = savedLighting.EnvironmentSpecularScale
                Lighting.OutdoorAmbient = savedLighting.OutdoorAmbient
                fullbrightActive = false
            end

            -- Remove Fog
            Lighting.FogEnd = getRemoveFog() and 8999999488 or originalFogEnd

            -- ===================== ESP RENDERING =====================
            local tracerOrigin = Vector2.new(camera.ViewportSize.X / 2, 50)

            -- ESP normal (todos os players)
            for player, box in pairs(espDrawings.Box) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = player.Character.HumanoidRootPart
                    local topPos, topVisible = camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
                    local botPos = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 4, 0))

                    if topVisible and getEsp() then
                        local height = math.abs(botPos.Y - topPos.Y)
                        local width = height / 2

                        box.Size = Vector2.new(width, height)
                        box.Position = Vector2.new(topPos.X - (width / 2), topPos.Y)
                        box.Visible = true

                        espDrawings.Tracer[player].From = tracerOrigin
                        espDrawings.Tracer[player].To = Vector2.new(topPos.X, topPos.Y + (height / 2))
                        espDrawings.Tracer[player].Visible = true

                        espDrawings.Name[player].Text = player.DisplayName
                        espDrawings.Name[player].Position = Vector2.new(topPos.X, topPos.Y - 25)
                        espDrawings.Name[player].Visible = true
                    else
                        box.Visible = false
                        espDrawings.Tracer[player].Visible = false
                        espDrawings.Name[player].Visible = false
                    end
                else
                    box.Visible = false
                    espDrawings.Tracer[player].Visible = false
                    espDrawings.Name[player].Visible = false
                end
            end

            -- ESP Staff (rank >= 200 no grupo)
            for player, box in pairs(staffDrawings.Box) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and getStaffEsp() then
                    local success, rank = pcall(function()
                        return player:GetRankInGroup(1)
                    end)

                    if success and rank >= 200 then
                        local rootPart = player.Character.HumanoidRootPart
                        local topPos, topVisible = camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0))
                        local botPos = camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 4, 0))

                        if topVisible then
                            local height = math.abs(botPos.Y - topPos.Y)
                            local width = height / 2

                            box.Size = Vector2.new(width, height)
                            box.Position = Vector2.new(topPos.X - (width / 2), topPos.Y)
                            box.Visible = true

                            staffDrawings.Tracer[player].From = tracerOrigin
                            staffDrawings.Tracer[player].To = Vector2.new(topPos.X, topPos.Y + (height / 2))
                            staffDrawings.Tracer[player].Visible = true

                            staffDrawings.Name[player].Text = "[STAFF] " .. player.DisplayName
                            staffDrawings.Name[player].Position = Vector2.new(topPos.X, topPos.Y - 25)
                            staffDrawings.Name[player].Visible = true
                        else
                            box.Visible = false
                            staffDrawings.Tracer[player].Visible = false
                            staffDrawings.Name[player].Visible = false
                        end
                    else
                        box.Visible = false
                        staffDrawings.Tracer[player].Visible = false
                        staffDrawings.Name[player].Visible = false
                    end
                else
                    box.Visible = false
                    staffDrawings.Tracer[player].Visible = false
                    staffDrawings.Name[player].Visible = false
                end
            end

            -- ===================== AIMBOT =====================
            if getAimbot() then
                local target = getClosestPlayer()
                if target then
                    camera.CFrame = camera.CFrame:Lerp(
                        CFrame.new(camera.CFrame.Position, target.Position),
                        0.28
                    )
                end
            end
        end)

        -- ===================== FOV SIZE INPUT =====================
        local fovInput = Instance.new("TextBox")
        fovInput.Size = UDim2.new(1, -10, 0, 60)
        fovInput.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        fovInput.Parent = tabPages["Player"]
        Instance.new("UICorner", fovInput).CornerRadius = UDim.new(0, 16)

        local fovLabel = Instance.new("TextLabel")
        fovLabel.Size = UDim2.new(0.7, 0, 1, 0)
        fovLabel.Position = UDim2.new(0, 20, 0, 0)
        fovLabel.BackgroundTransparency = 1
        fovLabel.Text = "FOV Size (0-240)"
        fovLabel.Font = Enum.Font.GothamBold
        fovLabel.TextSize = 16
        fovLabel.TextColor3 = Color3.fromRGB(230, 230, 255)
        fovLabel.TextXAlignment = Enum.TextXAlignment.Left
        fovLabel.Parent = fovInput

        fovInput.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local value = tonumber(fovInput.Text)
                if value and value >= 0 and value <= 240 then
                    fovSize = value
                    print("[FOV] Ajustado para: " .. fovSize)
                else
                    fovInput.Text = tostring(fovSize)
                end
            end
        end)

        print("[LZNGOD_PRO] Menu liberado após login correto! Tamanho ajustado para " .. (isMobile and "celular" or "PC"))

    else
        -- Login incorreto: shake animation
        local originalPos = loginFrame.Position
        for i = 1, 5 do
            loginFrame.Position = loginFrame.Position + UDim2.new(0, 8, 0, 0)
            task.wait(0.02)
            loginFrame.Position = loginFrame.Position - UDim2.new(0, 8, 0, 0)
            task.wait(0.02)
        end
        loginFrame.Position = originalPos
    end
end)

print("[LZNGOD] Sistema de login carregado. Aguarde credenciais corretas.")
