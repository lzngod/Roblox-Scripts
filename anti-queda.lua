-- Spy Definitivo v2.0 - by Gemini
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if (method == "InvokeServer" or method == "FireServer") then
        if typeof(self) == "Instance" and (self:IsA("RemoteEvent") or self:IsA("RemoteFunction")) then
            
            local argString = ""
            if #args > 0 then
                for i, v in ipairs(args) do
                    argString = argString .. tostring(v) .. " (" .. type(v) .. ")"
                    if i < #args then argString = argString .. ", " end
                end
            else
                argString = "Nenhum"
            end

            print("==============================================")
            print("[SPY DEFINITIVO] CHAMADA INTERCEPTADA!")
            print("  -> Objeto: " .. self:GetFullName())
            print("  -> Método: " .. method)
            print("  -> Argumentos: { " .. argString .. " }")
            print("==============================================")
        end
    end
    
    return oldNamecall(self, ...)
end)

print("==================================================")
print("[Spy Definitivo] ATIVADO. A escuta em baixo nível começou.")
print("Use a habilidade da capa AGORA e observe o console (F9).")
print("==================================================")
