-- Script para copiar um mapa completo do Workspace e salvar como JSON
local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")
local HttpService = game:GetService("HttpService")

-- Função para clonar objetos recursivamente, ignorando objetos não clonáveis
local function cloneMap(parent, destination)
    for _, child in ipairs(parent:GetChildren()) do
        -- Ignorar objetos que não podem ser clonados (ex.: CurrentCamera, TouchInterest, Terrain)
        if child ~= Workspace.CurrentCamera and child.Name ~= "TouchInterest" and child ~= Workspace.Terrain then
            local success, clone = pcall(function()
                return child:Clone()
            end)
            if success and clone then
                clone.Parent = destination
                cloneMap(child, clone) -- Clonar filhos recursivamente
            else
                warn("Falha ao clonar: " .. tostring(child) .. " - Ignorado.")
            end
        end
    end
end

-- Função para serializar o mapa como JSON
local function saveMapToFile()
    -- Criar uma pasta temporária para armazenar o mapa
    local mapCopyFolder = Instance.new("Folder")
    mapCopyFolder.Name = "CopiedMap"
    
    -- Copiar objetos do Workspace
    cloneMap(Workspace, mapCopyFolder)
    
    -- Serializar os dados do mapa
    local mapData = HttpService:JSONEncode(mapCopyFolder:GetDescendants())
    
    -- Caminho para salvar o arquivo (pasta Downloads)
    local filePath = os.getenv("USERPROFILE") .. "\\Downloads\\CopiedMap.json"
    
    -- Salvar como JSON usando writefile (compatível com executores)
    local success, errorMsg = pcall(function()
        writefile(filePath, mapData)
    end)
    
    if success then
        print("Mapa salvo com sucesso em: " .. filePath)
        print("Nota: O arquivo é JSON. Converta manualmente para .rbxm no Roblox Studio.")
    else
        warn("Erro ao salvar mapa: " .. tostring(errorMsg))
    end
    
    -- Limpar a pasta temporária
    mapCopyFolder:Destroy()
end

-- Executar a função de salvamento
saveMapToFile()
