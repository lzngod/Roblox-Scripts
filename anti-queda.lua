local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local isInvincible = false

local function findEvent(parent, eventName)
    local found = parent:FindFirstChild(eventName)
    if found and found:IsA("RemoteEvent") then
        return found
    end

    for _, child in ipairs(parent:GetChildren()) do
        if #child:GetChildren() > 0 then
            local result = findEvent(child, eventName)
            if result then
                return result
            end
        end
    end
    return nil
end

local impulseEvent, ragdollEvent

local function findTargets()
    local packages = ReplicatedStorage:WaitForChild("Packages")
    local netFolder = packages:WaitForChild("Net")
    local ragdollFolder = packages:WaitForChild("Ragdoll")
    
    print("[Detetive] Procurando por 'ApplyImpulse'...")
    impulseEvent = findEvent(netFolder, "ApplyImpulse")
    
    print("[Detetive] Procurando por 'Ragdoll'...")
    ragdollEvent = findEvent(ragdollFolder, "Ragdoll")

    if impulseEvent then print("[Detetive] 'ApplyImpulse' encontrado em: " .. impulseEvent:GetFullName()) end
    if ragdollEvent then print("[Detetive] 'Ragdoll' encontrado em: " .. ragdollEvent:GetFullName()) end
    
    return impulseEvent and ragdollEvent
end


local originalParents = {}
local fakeEvents = {}

local function disableInvincibility()
    for key, fake in pairs(fakeEvents) do
        if fake and fake.Parent then
            fake:Destroy()
        end
    end
    fakeEvents = {}

    if originalParents.impulse and impulseEvent then impulseEvent.Parent = originalParents.impulse end
    if originalParents.ragdoll and ragdollEvent then ragdollEvent.Parent = originalParents.ragdoll end
    
    isInvincible = false
    print("[Detetive v4.2] Desativado. Vulnerabilidade restaurada.")
end

local function enableInvincibility()
    if isInvincible or not impulseEvent or not ragdollEvent then return end

    originalParents.impulse = impulseEvent.Parent
    impulseEvent.Parent = nil
    local fakeImpulse = Instance.new("RemoteEvent")
    fakeImpulse.Name = "ApplyImpulse"
    fakeImpulse.Parent = originalParents.impulse
    fakeEvents.impulse = fakeImpulse
    
    originalParents.ragdoll = ragdollEvent.Parent
    ragdollEvent.Parent = nil
    local fakeRagdoll = Instance.new("RemoteEvent")
    fakeRagdoll.Name = "Ragdoll"
    fakeRagdoll.Parent = originalParents.ragdoll
    fakeEvents.ragdoll = fakeRagdoll

    isInvincible = true
    print("[Detetive v4.2] Ativado. Você está protegido.")
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DetectiveGUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 160, 0, 50)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Draggable = true
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.BorderSizePixel = 2
toggleButton.BorderColor3 = Color3.fromRGB(255, 255, 255)

local function toggle()
    if isInvincible then
        disableInvincibility()
        toggleButton.Text = "Invencível: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        enableInvincibility()
        toggleButton.Text = "Invencível: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    end
end

if findTargets() then
    toggleButton.MouseButton1Click:Connect(toggle)
    toggleButton.Text = "Invencível: ON"
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    enableInvincibility()
else
    toggleButton.Text = "ERRO: Alvos não encontrados"
    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    print("[Detetive] ERRO: Não foi possível encontrar um ou ambos os RemoteEvents. O script não pode continuar.")
end
