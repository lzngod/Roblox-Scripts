-- Script para clonar um jogo Roblox no lado do cliente (fins acadêmicos)
-- Compatível com Solara V3 e Dex Explorer

-- Carrega o Dex Explorer (se ainda não carregado)
if not game:FindFirstChild("D_E_X") then
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
    end)
    if not success then
        warn("Erro ao carregar Dex Explorer: " .. tostring(err))
        return
    end
    wait(2) -- Aguarda a inicialização do Dex Explorer
end

-- Verifica se saveinstance está disponível
if not saveinstance then
    warn("A função saveinstance não está disponível no Solara V3!")
    return
end

-- Configurações de salvamento
local saveOptions = {
    noscripts = false, -- Inclui LocalScripts e ModuleScripts
    noproperties = false, -- Inclui todas as propriedades
    IgnoreNotArchivable = true, -- Ignora instâncias não arquiváveis
    TreatUnionsAsParts = true, -- Converte UnionOperations em Parts
    SafeMode = true -- Modo seguro (se suportado)
}

-- Função para salvar o jogo inteiro
local function saveGame()
    local filename = "jogo_clonado_" .. os.time()
    local fullPath = filename .. ".rbxmx"
    local logFile = filename .. "_log.txt"

    print("Iniciando clonagem do jogo como " .. fullPath .. "...")

    -- Registra erros em um log para estudo
    local function logError(msg)
        appendfile(logFile, tostring(msg) .. "\n")
        warn("Erro: " .. tostring(msg))
    end

    -- Tenta salvar todas as instâncias
    local success, errorMsg = pcall(function()
        saveinstance(fullPath, saveOptions)
    end)

    if success then
        print("Jogo clonado com sucesso em: " .. fullPath)
        appendfile(logFile, "Salvamento concluído com sucesso em: " .. fullPath .. "\n")
    else
        logError("Erro ao salvar o jogo: " .. errorMsg)
    end
end

-- Função para salvar scripts locais separadamente
local function saveLocalScripts()
    local scriptFolder = "scripts_locais_" .. os.time()
    local logFile = scriptFolder .. "_log.txt"
    print("Salvando scripts locais em: " .. scriptFolder .. "...")

    local scriptsFound = 0
    for _, instance in pairs(game:GetDescendants()) do
        if instance:IsA("LocalScript") or instance:IsA("ModuleScript") then
            local success, source = pcall(function()
                return instance.Source
            end)
            if success and source ~= "" then
                scriptsFound = scriptsFound + 1
                local scriptName = instance.Name:gsub("[^%w]", "_") .. ".lua"
                writefile(scriptFolder .. "/" .. scriptName, source)
                appendfile(logFile, "Script salvo: " .. scriptName .. "\n")
            else
                appendfile(logFile, "Erro ao salvar script: " .. instance.Name .. "\n")
            end
        end
    end

    if scriptsFound > 0 then
        print(scriptsFound .. " scripts locais salvos em: " .. scriptFolder)
        appendfile(logFile, "Total de scripts salvos: " .. scriptsFound .. "\n")
    else
        print("Nenhum script local encontrado ou acessível.")
        appendfile(logFile, "Nenhum script local encontrado.\n")
    end
end

-- Função para explorar com Dex Explorer
local function exploreWithDex()
    print("Use o Dex Explorer para navegar pelas instâncias do jogo.")
    print("1. Clique em 'SaveMap' para salvar o mapa rapidamente.")
    print("2. Use a janela 'SaveInstance', marque 'SaveObjects' para incluir scripts, e salve instâncias específicas.")
    print("3. Verifique os arquivos salvos na pasta do Roblox Studio ou Solara.")
end

-- Executa o processo
print("Iniciando processo de clonagem para estudo acadêmico...")
saveGame()
saveLocalScripts()
exploreWithDex()
print("Clonagem concluída! Verifique os arquivos salvos e o log para análise.")
