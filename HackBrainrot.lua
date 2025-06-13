local key = "Brainrot"
local gameId = 6027386986 - (352 + 842)
local filePath = "data.txt"
local timer = 544 - 244
if writefile and not isfile(filePath) then
    writefile(filePath, tostring(os.time()))
end
local startTime = 0
if isfile and isfile(filePath) then
    startTime = tonumber(readfile(filePath)) or 0
end
pcall(function()
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("ScreenGui")
    if playerGui then
        playerGui:Destroy()
    end
end)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 340, 0, 30)
textLabel.AnchorPoint = Vector2.new(0.5, 1)
textLabel.Position = UDim2.new(0.5, 0, 0.5, -95)
textLabel.BackgroundTransparency = 1
textLabel.Text = "JOIN MY DISCORD SERVER FOR MORE COOL SCRIPTS!"
textLabel.Font = Enum.Font.GothamBold
textLabel.TextSize = 16
textLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
textLabel.TextStrokeTransparency = 0.6
textLabel.TextWrapped = true
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.Parent = screenGui
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 340, 0, 190)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)
local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(0, 100, 0, 60)
imageLabel.Position = UDim2.new(0, 15, 0, 15)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "https://www.roblox.com/asset/?id=" .. gameId .. "&serverplaceid=0"
imageLabel.Parent = frame
local discordLabel = Instance.new("TextLabel")
discordLabel.Size = UDim2.new(1, -90, 0, 60)
discordLabel.Position = UDim2.new(0, 85, 0, 15)
discordLabel.BackgroundTransparency = 1
discordLabel.Text = "DISCORD SERVER"
discordLabel.Font = Enum.Font.GothamBold
discordLabel.TextSize = 20
discordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
discordLabel.TextXAlignment = Enum.TextXAlignment.Left
discordLabel.Parent = frame
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -30, 0, 40)
textBox.Position = UDim2.new(0, 15, 0, 90)
textBox.Text = key
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 18
textBox.TextColor3 = Color3.fromRGB(20, 20, 20)
textBox.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
textBox.ClearTextOnFocus = false
pcall(function()
    textBox.TextEditable = false
end)
textBox.Parent = frame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 12)
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 100, 0, 40)
copyButton.Position = UDim2.new(0, 15, 0, 140)
copyButton.Text = "COPY"
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 16
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
copyButton.Parent = frame
Instance.new("UICorner", copyButton).CornerRadius = UDim.new(0, 14)
copyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(key)
        print("✅ Username berhasil disalin!")
    else
        warn("❌ Clipboard tidak tersedia.")
    end
end)
local joinButton = Instance.new("TextButton")
joinButton.Size = UDim2.new(0, 100, 0, 40)
joinButton.Position = UDim2.new(0.52, -15, 0, 140)
joinButton.Text = "JOIN"
joinButton.Font = Enum.Font.GothamBold
joinButton.TextSize = 16
joinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
joinButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
joinButton.Parent = frame
Instance.new("UICorner", joinButton).CornerRadius = UDim.new(0, 14)
joinButton.AutoButtonColor = false
joinButton.Active = false
local function updateTimer()
    while true do
        local currentTime = os.time()
        local timeLeft = timer - (currentTime - startTime)
        if timeLeft <= 0 then
            joinButton.Text = "JOIN NOW"
            joinButton.AutoButtonColor = true
            joinButton.Active = true
            break
        else
            local minutes = math.floor(timeLeft / 60)
            local seconds = timeLeft % 60
            joinButton.Text = string.format("JOIN IN %02d:%02d", minutes, seconds)
        end
        wait(1)
    end
end
task.spawn(updateTimer)
joinButton.MouseButton1Click:Connect(function()
    if not joinButton.Active then
        return
    end
    screenGui:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Akbar123s/Script-Roblox-/refs/heads/main/Brainrot"))()
end)
local notificationFile = "notified.txt"
if not isfile(notificationFile) then
    game.StarterGui:SetCore("SendNotification", {
        Title = "Script Loaded",
        Text = "Join my Discord server for more scripts!\nClick COPY to copy the server link and JOIN to proceed.",
        Duration = 300
    })
    writefile(notificationFile, "1")
end
