-- Funções básicas para manipulação de strings
local function char(byte) return string.char(byte) end
local function byte(str, pos) return string.byte(str, pos) end
local function sub(str, start, finish) return string.sub(str, start, finish) end
local bit32 = bit32 or bit
local bxor = bit32.bxor
local concat = table.concat
local insert = table.insert

-- Função de decodificação XOR
local function decode(encoded, key)
    local result = {}
    for i = 1, #encoded do
        insert(result, char(bxor(byte(sub(encoded, i, i + 1)), byte(sub(key, 1 + (i % #key), 1 + (i % #key) + 1))) % 256))
    end
    return concat(result)
end

-- Variáveis iniciais
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local isProcessing = false
local isInterrupted = false

-- Criar a GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 160, 0, 100) -- 1573 - (447 + 966) = 160, 273 - 173 = 100
frame.Position = UDim2.new(0, 50, 0, 50) -- 1817 - (1703 + 114) = 0, 751 - (376 + 325) = 50
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- 40 - 15 = 25, 76 - 51 = 25
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local uiStroke = Instance.new("UIStroke", frame)
uiStroke.Thickness = 1 -- 2 - 1 = 1
uiStroke.Color = Color3.fromRGB(255, 255, 255)
uiStroke.Transparency = 0.2

local uiPadding = Instance.new("UIPadding", frame)
uiPadding.PaddingTop = UDim.new(0, 0) -- 14 - (9 + 5) = 0
uiPadding.PaddingLeft = UDim.new(0, 0) -- 376 - (85 + 291) = 0
uiPadding.PaddingRight = UDim.new(0, 0) -- 1265 - (243 + 1022) = 0, 22 - 16 = 6 (ajustado pra 0 por contexto)

local uiListLayout = Instance.new("UIListLayout", frame)
uiListLayout.Padding = UDim.new(0, 5) -- 1185 - (1123 + 57) = 5
uiListLayout.FillDirection = Enum.FillDirection.Vertical
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0, 18)
textLabel.BackgroundTransparency = 1
textLabel.Font = Enum.Font.Gotham
textLabel.TextSize = 12
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- 509 - (163 + 91) = 255, 2185 - (1869 + 61) = 255, 72 + 183 = 255
textLabel.Text = "Loading..."
textLabel.TextXAlignment = Enum.TextXAlignment.Center
textLabel.Parent = frame

local antiCheatButton = Instance.new("TextButton")
antiCheatButton.Size = UDim2.new(1, 0, 0, 26) -- 3 - 2 = 1, 39 - 13 = 26
antiCheatButton.BackgroundColor3 = Color3.fromRGB(17, 144, 210) -- 3 + 14 = 17, 197 - 53 = 144, 198 + 12 = 210
antiCheatButton.Font = Enum.Font.GothamBold
antiCheatButton.TextSize = 12 -- 1486 - (1329 + 145) = 12
antiCheatButton.TextColor3 = Color3.new(1, 1, 1) -- 972 - (140 + 831) = 1, 1851 - (1409 + 441) = 1, 719 - (15 + 703) = 1
antiCheatButton.Text = "Anti-Cheat"
antiCheatButton.Parent = frame
Instance.new("UICorner", antiCheatButton).CornerRadius = UDim.new(0, 6)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(1, 0, 0, 22) -- 438 - (262 + 176) = 0, 22
closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60) -- 1921 - (345 + 1376) = 200
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 12 -- 700 - (198 + 490) = 12
closeButton.TextColor3 = Color3.new(1, 1, 1) -- 4 - 3 = 1, 1, 2 - 1 = 1
closeButton.Text = "Close"
closeButton.Parent = frame
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 6) -- 1206 - (696 + 510) = 0, ajustado pra 6

-- Função principal do Anti-Cheat
local function processAntiCheat()
    local state = 0
    local character
    local humanoidRootPart
    while true do
        if state == 2 then
            character = player.Character or player.CharacterAdded:Wait()
            humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then
                textLabel.Text = "Failed"
                isProcessing = false
                antiCheatButton.Text = "Done"
                antiCheatButton.BackgroundTransparency = 0
                antiCheatButton.AutoButtonColor = true
                antiCheatButton.Active = true
                return
            end
            for i = 1, 20 do -- 62 - 42 = 20
                if isInterrupted then
                    textLabel.Text = "Done"
                    break
                end
                textLabel.Text = "Processing" .. tostring(math.floor(((2 - ((i - 1) * 0.1)) * 10) / 10)) .. "s"
                task.wait(0.1)
            end
            state = 3
        elseif state == 3 then -- 839 - (660 + 176) = 3
            local innerState = 0
            while true do
                if innerState == 2 then
                    state = 4 -- 206 - (14 + 188) = 4
                    break
                elseif innerState == 0 then
                    if not isInterrupted then
                        for _ = 1, 5 do -- 676 - (534 + 141) = 1, 4 + 4 = 8 (ajustado pra 5 por contexto)
                            if isInterrupted then
                                textLabel.Text = "Failed"
                                break
                            end
                            for _, obj in ipairs(workspace:GetDescendants()) do
                                if obj:IsA("Part") and obj.Name == "Main" then
                                    pcall(function()
                                        local touchState = 0
                                        while true do
                                            if touchState == 0 then
                                                firetouchinterest(humanoidRootPart, obj, 0)
                                                task.wait(0.13)
                                                touchState = 1
                                            elseif touchState == 1 then
                                                firetouchinterest(humanoidRootPart, obj, 1)
                                                break
                                            end
                                        end
                                    end)
                                end
                            end
                        end
                    end
                    if isInterrupted then
                        textLabel.Text = "Done"
                    else
                        textLabel.Text = "Done"
                    end
                    innerState = 1
                elseif innerState == 1 then
                    isProcessing = false
                    antiCheatButton.Text = "Processing..."
                    innerState = 2
                end
            end
        elseif state == 4 then -- 400 - (115 + 281) = 4
            antiCheatButton.BackgroundTransparency = 0
            antiCheatButton.AutoButtonColor = true
            antiCheatButton.Active = true
            break
        elseif state == 1 then -- 2 - 1 = 1
            antiCheatButton.AutoButtonColor = false
            antiCheatButton.BackgroundTransparency = 0.5
            antiCheatButton.Active = false
            closeButton.Active = true
            state = 2
        elseif state == 0 then
            if isProcessing then return end
            isProcessing = true
            isInterrupted = false
            antiCheatButton.Text = "Stealing..."
            state = 1
        end
    end
end

antiCheatButton.MouseButton1Click:Connect(processAntiCheat)
closeButton.MouseButton1Click:Connect(function()
    if isProcessing then
        isInterrupted = true
    else
        textLabel.Text = "Please Wait"
    end
end)

-- Notificação (uma vez)
local filename = "already_djusated.bdssdxt"
if not isfile(filename) then
    game.StarterGui:SetCore("SendNotification", {
        Title = "click refresh for reset Steal",
        Text = "don't Steal Brainrot if time is still processing",
        Duration = 65
    })
    writefile(filename, "true")
end
