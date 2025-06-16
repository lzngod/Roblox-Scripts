-- Script para clonar jogo no lado do cliente com foco em scripts locais (fins acadêmicos)
-- Compatível com Solara V3, Krnl, ou outros executores

-- Carrega o Dex Explorer (se não carregado)
if not game:FindFirstChild("D_E_X") then
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
    end)
    if not success then
        warn("Erro ao carregar Dex Explorer: " .. tostring(err))
        return
    end
    wait(2)
end

-- Verifica saveinstance
if not saveinstance then
    warn("saveinstance não disponível!")
    return
end

-- Scripts a ignorar (frameworks Roblox)
local ignoredScripts = {
    ["React"] = true,
    ["Roact"] = true,
    ["UIBlox"] = true,
    ["ApolloClient"] = true,
    ["Cryo"] = true,
    ["jest.config"] = true,
    ["AnalyticsService"] = true,
    ["RobloxAppHooks"] = true,
    ["Localization"] = true,
    ["SharedFlags"] = true,
    ["Animate"] = true,
    ["HDAdminStarterCharacter"] = true
}

-- Scripts específicos do jogo para tentar salvar
local targetScripts = {
    ["ComboScript"] = true,
    ["TrapScript"] = true,
    ["BeeLauncherScript"] = true,
    ["HideGUIs"] = true,
    ["RagdollClient"] = true
}

-- Configurações de salvamento
local saveOptions = {
    noscripts = false,
    noproperties = false,
    IgnoreNotArchivable = true,
    TreatUnionsAsParts = true,
    SafeMode = true
}

-- Função para tentar descompilar (se suportado pelo executor)
local function tryDecompile(scriptInstance)
    if decompile then -- Verifica se a função decompile existe
        local success, source = pcall(function()
            return decompile(scriptInstance)
        end)
        return success, source
    end
    return false, ""
end

-- Função para salvar o jogo
local function saveGame()
    local filename = "jogo_clonado_" .. os.time()
    local fullPath = filename .. ".rbxmx"
    local logFile = filename .. "_log.txt"

    print("Iniciando clonagem como " .. fullPath .. "...")
    appendfile(logFile, "Início do salvamento: " .. os.date() .. "\n")

    local success, errorMsg = pcall(function()
        saveinstance(fullPath, saveOptions)
    end)

    if success then
        print("Jogo salvo em: " .. fullPath)
        appendfile(logFile, "Salvamento concluído: " .. fullPath .. "\n")
    else
        appendfile(logFile, "Erro ao salvar jogo: " .. tostring(errorMsg) .. "\n")
        warn("Erro ao salvar: " .. tostring(errorMsg))
    end
end

-- Função para salvar scripts locais
local function saveLocalScripts()
    local scriptFolder = "scripts_locais_" .. os.time()
    local logFile = scriptFolder .. "_log.txt"
    print("Salvando scripts em: " .. scriptFolder .. "...")
    appendfile(logFile, "Início do salvamento de scripts: " .. os.date() .. "\n")

    local scriptsFound = 0
    local uniqueScripts = {}

    for _, instance in pairs(game:GetDescendants()) do
        if (instance:IsA("LocalScript") or instance:IsA("ModuleScript")) and not ignoredScripts[instance.Name] then
            if not uniqueScripts[instance.Name] and targetScripts[instance.Name] then
                uniqueScripts[instance.Name] = true
                -- Tenta acessar instance.Source
                local success, source = pcall(function()
                    return instance.Source
                end)
                -- Tenta descompilar se instance.Source falhar
                if not success or source == "" then
                    success, source = tryDecompile(instance)
                end
                if success and source ~= "" then
                    scriptsFound = scriptsFound + 1
                    local scriptName = instance.Name:gsub("[^%w]", "_") .. ".lua"
                    writefile(scriptFolder .. "/" .. scriptName, source)
                    appendfile(logFile, "Script salvo: " .. scriptName .. " (Caminho: " .. instance:GetFullName() .. ")\n")
                else
                    appendfile(logFile, "Erro ao salvar script: " .. instance.Name .. " (Caminho: " .. instance:GetFullName() .. ")\n")
                end
            end
        end
    end

    if scriptsFound > 0 then
        print(scriptsFound .. " scripts salvos em: " .. scriptFolder)
        appendfile(logFile, "Total de scripts salvos: " .. scriptsFound .. "\n")
    else
        print("Nenhum script salvo.")
        appendfile(logFile, "Nenhum script salvo.\n")
    end
end

-- Função para explorar com Dex Explorer
local function exploreWithDex()
    print("Use o Dex Explorer para inspecionar scripts manualmente.")
    print("1. Navegue até StarterGui, PlayerScripts, ou ReplicatedStorage.")
    print("2. Verifique scripts como ComboScript, TrapScript, ou BeeLauncherScript.")
    print("3. Use a janela 'SaveInstance' com 'SaveObjects' marcado para salvar manualmente.")
end

-- Executa o processo
print("Iniciando clonagem para estudo acadêmico...")
saveGame()
saveLocalScripts()
exploreWithDex()
print("Clonagem concluída! Verifique os arquivos e logs.")
