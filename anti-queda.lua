-- Remote Spy v1.0
print("==========================================================")
print("[Remote Spy] Ativado. Pressione F9 para abrir/fechar o console.")
print("[Remote Spy] A partir de agora, todos os RemoteEvents recebidos pelo seu cliente serão registrados aqui.")
print("[Remote Spy] FIQUE PRONTO PARA USAR A HABILIDADE DA CAPA!")
print("==========================================================")

local function log(remote, ...)
    local args = {...}
    local argString = ""
    if #args > 0 then
        for i, v in ipairs(args) do
            argString = argString .. tostring(v) .. " (" .. type(v) .. ")"
            if i < #args then argString = argString .. ", " end
        end
    else
        argString = "Nenhum"
    end
    
    print("[REMOTE RECEBIDO] Caminho: ".. remote:GetFullName(), "| Argumentos: " .. argString)
end

for _, obj in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        obj.OnClientEvent:Connect(function(...)
            log(obj, ...)
        end)
    end
end
