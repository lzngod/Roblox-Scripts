-- LocalScript para criar um botão e copiar o mapa
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

-- Criar a GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui
screenGui.Name = "MapCopierGUI"

-- Criar o botão
local button = Instance.new("TextButton")
button.Parent = screenGui
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Copiar Mapa"
button.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.MouseButton1Click:Connect(function()
    copyMap()
end)

-- Função para clonar objetos recursivamente, ignorando objetos não clonáveis
local function cloneMap(parent, destination)
    for _, child in ipairs(parent:GetChildren()) do
        local isClonable = true
        if child == Workspace.CurrentCamera or child.Name == "TouchInterest" or child == Workspace.Terrain then
            isClonable = false
        end
        if isClonable then
            local success, clone = pcall(function()
                return child:Clone()
            end)
            if success and clone then
                clone.Parent = destination
                cloneMap(child, clone)
            else
                warn("Falha ao clonar: " .. tostring(child) .. " - Ignorado.")
            end
        end
    end
end

-- Função para salvar o mapa como JSON
local function saveMapToFile()
    local mapCopyFolder = Instance.new("Folder")
    mapCopyFolder.Name = "CopiedMap"
    
    -- Copiar objetos do Workspace
    cloneMap(Workspace, mapCopyFolder)
    
    -- Serializar os dados do mapa
    local mapData
    local success, errorMsg = pcall(function()
        mapData = HttpService:JSONEncode(mapCopyFolder:GetDescendants())
    end)
    if not success then
        warn("Erro ao serializar mapa: " .. tostring(errorMsg))
        return
    end
    
    -- Verificar se writefile está disponível
    if writefile then
        local filePath = os.getenv("USERPROFILE") .. "\\Downloads\\CopiedMap.json"
        success, errorMsg = pcall(function()
            writefile(filePath, mapData)
        end)
        if success then
            print("Mapa salvo com sucesso em: " .. filePath)
            print("Nota: O arquivo é JSON. Converta manualmente para .rbxm no Roblox Studio.")
        else
            warn("Erro ao salvar mapa: " .. tostring(errorMsg))
        end
    else
        warn("Função writefile não disponível. Use um executor compatível (ex.: Synapse X, Krnl).")
        -- Opcional: Exibir mensagem na tela
        local message = Instance.new("Hint")
        message.Text = "Erro: Executor não suporta salvamento. Contate o suporte!"
        message.Parent = game:GetService("CoreGui")
        wait(5)
        message:Destroy()
    end
    
    mapCopyFolder:Destroy()
end

-- Função principal para copiar o mapa
local function copyMap()
    saveMapToFile()
end
