--[[
DISCLAIMER:
Este script é para fins experimentais e educativos no contexto de um jogo de sua propriedade.
Use-o com cautela, esteja ciente de que funcionalidades como ESP, Fling e similares podem
afetar a jogabilidade e, se mal utilizadas, gerar problemas. Certifique-se de seguir as diretrizes
do Roblox e de manter o equilíbrio na experiência dos jogadores.
--]]

-----------------------------
-- Serviços e variáveis
-----------------------------
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local UIS = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Estados iniciais e valores padrão
local espEnabled = false
local flyEnabled = false
local invisEnabled = false
local flingEnabled = false
local speedHackEnabled = false
local superJumpEnabled = false
local noClipEnabled = false
local godModeEnabled = false
local removeAnimsEnabled = false

local defaultWalkSpeed = humanoid.WalkSpeed
local defaultJumpPower = humanoid.JumpPower

-----------------------------
-- Criar interface gráfica (GUI)
-----------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0, 250, 0, 550)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Painel de Funcionalidades"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

-- Função auxiliar para criar botões
local function createButton(text, posY)
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(0, 230, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Text = text .. " OFF"
    btn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextScaled = true
    return btn
end

local closeButton = createButton("Fechar Painel", 40)
local espButton = createButton("ESP", 80)
local teleportButton = createButton("Teleport", 120)
local flyButton = createButton("Fly", 160)
local invisButton = createButton("Invisibilidade", 200)
local flingButton = createButton("Fling", 240)
local speedButton = createButton("Speed Hack", 280)
local jumpButton = createButton("Super Jump", 320)
local noClipButton = createButton("NoClip", 360)
local godModeButton = createButton("God Mode", 400)
local removeAnimsButton = createButton("Remover Anims", 440)
local destroyMapButton = createButton("Destruir Mapa", 480)
local moreFuncButton = createButton("Nova Funcionalidade", 520)

-- Criar um TextBox para informar o nome do jogador alvo para Teleporte
local teleportTextBox = Instance.new("TextBox")
teleportTextBox.Parent = frame
teleportTextBox.Size = UDim2.new(0, 230, 0, 30)
teleportTextBox.Position = UDim2.new(0, 10, 0, 155)
teleportTextBox.PlaceholderText = "Nome do jogador alvo"
teleportTextBox.Visible = false

-----------------------------
-- Função para fechar painel
-----------------------------
closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-----------------------------
-- Abrir painel com Ctrl esquerdo
-----------------------------
UIS.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

-----------------------------
-- 1. ESP (Exibição de nomes dos jogadores)
-----------------------------
local function addESP(character)
    if character and character:FindFirstChild("Head") and not character.Head:FindFirstChild("ESPLabel") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESPLabel"
        billboard.Adornee = character:FindFirstChild("Head")
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.Parent = character:FindFirstChild("Head")
        
        local textLabel = Instance.new("TextLabel", billboard)
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = character.Name
        textLabel.TextColor3 = Color3.new(1, 0, 0)
        textLabel.TextScaled = true
    end
end

local function removeESP(character)
    if character and character:FindFirstChild("Head") then
        local label = character.Head:FindFirstChild("ESPLabel")
        if label then
            label:Destroy()
        end
    end
end

local function toggleESP(enabled)
    espEnabled = enabled
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                addESP(player.Character)
            end
            player.CharacterAdded:Connect(function(char)
                wait(0.5)
                if espEnabled and player ~= localPlayer then
                    addESP(char)
                end
            end)
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                removeESP(player.Character)
            end
        end
    end
end

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.Text = "ESP ON"
    else
        espButton.Text = "ESP OFF"
    end
    toggleESP(espEnabled)
end)

-----------------------------
-- 2. Teleporte para jogadores
-----------------------------
local teleportMode = false
teleportButton.MouseButton1Click:Connect(function()
    teleportMode = not teleportMode
    if teleportMode then
        teleportButton.Text = "Teleport ON"
        teleportTextBox.Visible = true
    else
        teleportButton.Text = "Teleport OFF"
        teleportTextBox.Visible = false
    end
end)

local function teleportToPlayer(targetName)
    local targetPlayer = Players:FindFirstChild(targetName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        end
    end
end

teleportTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        teleportToPlayer(teleportTextBox.Text)
    end
end)

-----------------------------
-- 3. Voo
-----------------------------
local flySpeed = 50
local flyConnection, bodyVelocity, bodyGyro

local function startFly()
    if not character or not rootPart then return end
    bodyVelocity = Instance.new("BodyVelocity", rootPart)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    
    bodyGyro = Instance.new("BodyGyro", rootPart)
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    
    flyConnection = RunService.RenderStepped:Connect(function()
        local direction = Vector3.new(0, 0, 0)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - workspace.CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + workspace.CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end)
end

local function stopFly()
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    if flyConnection then flyConnection:Disconnect() end
end

flyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    if flyEnabled then
        flyButton.Text = "Fly ON"
        startFly()
    else
        flyButton.Text = "Fly OFF"
        stopFly()
    end
end)

-----------------------------
-- 4. Invisibilidade
-----------------------------
local function setInvisibility(on)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            if on then
                part.Transparency = 1
                -- Caso haja decals, ajusta-os também
                for _, d in pairs(part:GetChildren()) do
                    if d:IsA("Decal") then
                        d.Transparency = 1
                    end
                end
            else
                part.Transparency = 0
                for _, d in pairs(part:GetChildren()) do
                    if d:IsA("Decal") then
                        d.Transparency = 0
                    end
                end
            end
        end
    end
end

invisButton.MouseButton1Click:Connect(function()
    invisEnabled = not invisEnabled
    if invisEnabled then
        invisButton.Text = "Invisibilidade ON"
        setInvisibility(true)
    else
        invisButton.Text = "Invisibilidade OFF"
        setInvisibility(false)
    end
end)

-----------------------------
-- 5. Fling (Empurrar inimigos ao tocar)
-----------------------------
local flingConnection
local function startFling()
    flingConnection = rootPart.Touched:Connect(function(hit)
        local hitCharacter = hit.Parent
        local hitHumanoid = hitCharacter and hitCharacter:FindFirstChildWhichIsA("Humanoid")
        if hitCharacter and hitCharacter ~= character and hitHumanoid then
            local hrp = hitCharacter:FindFirstChild("HumanoidRootPart")
            if hrp then
                local bv = Instance.new("BodyVelocity", hrp)
                bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                bv.Velocity = (hrp.Position - rootPart.Position).Unit * 100
                Debris:AddItem(bv, 0.5)
            end
        end
    end)
end

local function stopFling()
    if flingConnection then flingConnection:Disconnect() end
end

flingButton.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        flingButton.Text = "Fling ON"
        startFling()
    else
        flingButton.Text = "Fling OFF"
        stopFling()
    end
end)

-----------------------------
-- 6. Speed Hack (Aumenta a velocidade de caminhada)
-----------------------------
local speedHackValue = 100
speedButton.MouseButton1Click:Connect(function()
    speedHackEnabled = not speedHackEnabled
    if speedHackEnabled then
        speedButton.Text = "Speed Hack ON"
        humanoid.WalkSpeed = speedHackValue
    else
        speedButton.Text = "Speed Hack OFF"
        humanoid.WalkSpeed = defaultWalkSpeed
    end
end)

-----------------------------
-- 7. Super Jump (Aumenta a força de pulo)
-----------------------------
local superJumpValue = 150
jumpButton.MouseButton1Click:Connect(function()
    superJumpEnabled = not superJumpEnabled
    if superJumpEnabled then
        jumpButton.Text = "Super Jump ON"
        humanoid.JumpPower = superJumpValue
    else
        jumpButton.Text = "Super Jump OFF"
        humanoid.JumpPower = defaultJumpPower
    end
end)

-----------------------------
-- 8. NoClip (Atravessa paredes)
-----------------------------
local noClipConnection
local function startNoClip()
    noClipConnection = RunService.Stepped:Connect(function()
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

local function stopNoClip()
    if noClipConnection then noClipConnection:Disconnect() end
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

noClipButton.MouseButton1Click:Connect(function()
    noClipEnabled = not noClipEnabled
    if noClipEnabled then
        noClipButton.Text = "NoClip ON"
        startNoClip()
    else
        noClipButton.Text = "NoClip OFF"
        stopNoClip()
    end
end)

-----------------------------
-- 9. God Mode (Mantém o jogador com saúde máxima)
-----------------------------
local godModeConnection
local function startGodMode()
    godModeConnection = RunService.Heartbeat:Connect(function()
        if humanoid then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

local function stopGodMode()
    if godModeConnection then godModeConnection:Disconnect() end
end

godModeButton.MouseButton1Click:Connect(function()
    godModeEnabled = not godModeEnabled
    if godModeEnabled then
        godModeButton.Text = "God Mode ON"
        startGodMode()
    else
        godModeButton.Text = "God Mode OFF"
        stopGodMode()
    end
end)

-----------------------------
-- 10. Remover Animações de RagDoll/Morte (experimental)
-----------------------------
local function removeAnimations()
    -- ATENÇÃO: Uma vez removidas, as animações não serão restauradas automaticamente.
    for _, obj in pairs(character:GetDescendants()) do
        if obj:IsA("Animation") then
            obj:Destroy()
        end
    end
end

removeAnimsButton.MouseButton1Click:Connect(function()
    removeAnimsEnabled = not removeAnimsEnabled
    if removeAnimsEnabled then
        removeAnimsButton.Text = "Remover Anims ON"
        removeAnimations()
    else
        removeAnimsButton.Text = "Remover Anims OFF"
        print("Reinicie o jogo para restaurar as animações.")
    end
end)

-----------------------------
-- 11. Destruir Mapa (Experimental)
-----------------------------
local function isPlayerCharacter(model)
    return model:IsA("Model") and model:FindFirstChild("Humanoid")
end

local function destroyMap()
    for _, obj in pairs(workspace:GetChildren()) do
        if not isPlayerCharacter(obj) and obj.Name ~= "Terrain" then
            pcall(function() obj:Destroy() end)
        end
    end
end

destroyMapButton.MouseButton1Click:Connect(function()
    destroyMapButton.Text = "Mapa Destruído"
    destroyMap()
end)

-----------------------------
-- 12. Nova Funcionalidade (Exemplo)
-----------------------------
moreFuncButton.MouseButton1Click:Connect(function()
    moreFuncButton.Text = "Nova Func ON"
    -- Insira aqui a nova funcionalidade desejada
end)
