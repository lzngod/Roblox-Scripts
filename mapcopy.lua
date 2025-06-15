-- Script para copiar um mapa completo do Workspace e salvar como .rbxm
local Workspace = game:GetService("Workspace")
local ServerStorage = game:GetService("ServerStorage")
local HttpService = game:GetService("HttpService")

-- Função para clonar objetos recursivamente
local function cloneMap(parent, destination)
    for _, child in ipairs(parent:GetChildren()) do
        -- Ignorar objetos que não devem ser clonados (ex.: CurrentCamera)
        if child ~= Workspace.CurrentCamera then
            local success, clone = pcall(function()
                return child:Clone()
            end)
            if success and clone then
                clone.Parent = destination
                cloneMap(child, clone) -- Clonar filhos recursivamente
            else
                warn("Falha ao clonar: " .. tostring(child))
            end
        end
    end
end

-- Função para exportar terreno (serializar como dados)
local function exportTerrain()
    local terrain = Workspace.Terrain
    local terrainData = {}
    
    -- Capturar propriedades básicas do terreno
    terrainData.Region = terrain.MaxExtents -- Extensão do terreno
    -- Serializar materiais do terreno (exemplo simplificado)
    terrainData.Materials = {}
    -- Nota: Exportar terreno completo requer APIs específicas ou ferramentas externas
    -- Aqui, capturamos apenas propriedades básicas
    return terrainData
end

-- Função para serializar o mapa em .rbxm
local function saveMapToFile()
    -- Criar uma pasta temporária para armazenar o mapa
    local mapCopyFolder = Instance.new("Folder")
    mapCopyFolder.Name = "CopiedMap"
    
    -- Copiar objetos do Workspace
    cloneMap(Workspace, mapCopyFolder)
    
    -- Adicionar terreno (como objeto ou dados serializados)
    local terrainData = exportTerrain()
    local terrainFolder = Instance.new("Folder")
    terrainFolder.Name = "TerrainData"
    terrainFolder.Parent = mapCopyFolder
    
    -- Serializar terreno como StringValue (para referência)
    local terrainValue = Instance.new("StringValue")
    terrainValue.Name = "SerializedTerrain"
    terrainValue.Value = HttpService:JSONEncode(terrainData)
    terrainValue.Parent = terrainFolder
    
    -- Caminho para salvar o arquivo (pasta Downloads)
    local filePath = os.getenv("USERPROFILE") .. "\\Downloads\\CopiedMap.rbxm"
    
    -- Tentar usar a API do executor para salvar como .rbxm
    local success, errorMsg = pcall(function()
        -- A função `saveinstance` é comum em executores como Synapse X
        if saveinstance then
            saveinstance({mapCopyFolder}, filePath)
        else
            warn("Função 'saveinstance' não disponível. Usando método alternativo.")
            -- Alternativa: Serializar como JSON (menos ideal para .rbxm)
            local serializedData = HttpService:JSONEncode(mapCopyFolder:GetDescendants())
            writefile(filePath .. ".json", serializedData)
        end
    end)
    
    if success then
        print("Mapa salvo com sucesso em: " .. filePath)
    else
        warn("Erro ao salvar mapa: " .. tostring(errorMsg))
    end
    
    -- Limpar a pasta temporária
    mapCopyFolder:Destroy()
end

-- Executar a função de salvamento
saveMapToFile()
