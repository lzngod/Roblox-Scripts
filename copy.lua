-- Script para salvar tudo no lado do cliente (mapas, scripts, assets, propriedades)

-- Verifica se saveinstance está disponível
if not saveinstance then
    warn("A função saveinstance não está disponível neste executor!")
    return
end

-- Configurações de salvamento
local saveOptions = {
    noscripts = false, -- Inclui scripts locais (LocalScripts e ModuleScripts)
    noproperties = false, -- Inclui todas as propriedades (posição, rotação, etc.)
    IgnoreNotArchivable = true, -- Ignora instâncias marcadas como Archivable = false
    TreatUnionsAsParts = true, -- Converte UnionOperations em Parts para evitar erros
    SafeMode = true -- Modo seguro para reduzir riscos de detecção (se suportado)
}

-- Função para salvar o jogo inteiro
local function saveGame()
    local filename = "jogo_completo_" .. os.time() -- Nome do arquivo com timestamp para evitar sobrescrever
    local fullPath = filename .. ".rbxmx"

    print("Iniciando salvamento do jogo como " .. fullPath .. "...")

    -- Tenta salvar todas as instâncias do jogo
    local success, errorMsg = pcall(function()
        saveinstance(fullPath, saveOptions)
    end)

    if success then
        print("Jogo salvo com sucesso em: " .. fullPath)
        print("Verifique a pasta do workspace do Roblox Studio ou a pasta do executor!")
    else
        warn("Erro ao salvar o jogo: " .. tostring(errorMsg))
    end
end

-- Função para salvar scripts locais separadamente (opcional)
local function saveLocalScripts()
    local scriptFolder = "scripts_locais_" .. os.time()
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
            end
        end
    end

    if scriptsFound > 0 then
        print(scriptsFound .. " scripts locais salvos em: " .. scriptFolder)
    else
        print("Nenhum script local encontrado ou acessível.")
    end
end

-- Executa o salvamento
print("Script de salvamento iniciado...")
saveGame()
saveLocalScripts()
print("Salvamento concluído!")
