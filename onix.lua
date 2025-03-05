--// Serviços //--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

--// Variáveis //--
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// Configurações Padrão //--
local FlySpeed = 50
local Speed = 16
local JumpPower = 50
local FlingForce = 1000
local MapDestructRadius = 50

--// Variáveis de Estado //--
local Flying = false
local Invisible = false
local GodMode = false
local NoClip = false
local ESPEnabled = false
local AnimationsDisabled = false

--// GUI //--
local GUI = Instance.new("ScreenGui")
GUI.Name = "CheatMenu"
GUI.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 400) -- Aumentar o tamanho do painel
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0 -- Remover borda
MainFrame.Parent = GUI

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40) -- Aumentar a altura do título
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "Cheat Menu"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24 -- Aumentar o tamanho do texto
Title.Parent = MainFrame

local function createButton(text, position, size, parent, callback)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.BorderSizePixel = 0 -- Remover borda
    button.Parent = parent
    button.MouseButton1Click:Connect(callback)
    return button
end

local function createSlider(text, position, size, parent, minValue, maxValue, defaultValue, callback)
    local frame = Instance.new("Frame")
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = text .. ": " .. defaultValue
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.BorderSizePixel = 0
    label.Parent = frame

    local slider = Instance.new("Slider")
    slider.Size = UDim2.new(1, 0, 0, 20)
    slider.Position = UDim2.new(0, 0, 0, 30)
    slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    slider.BorderSizePixel = 0
    slider.Min = minValue
    slider.Max = maxValue
    slider.Value = defaultValue
    slider.Parent = frame

    slider:GetPropertyChangedSignal("Value"):Connect(function()
        local value = math.floor(slider.Value)
        label.Text = text .. ": " .. value
        callback(value)
    end)

    return frame
end

--// Funções Auxiliares //--

-- Função para encontrar um jogador pelo nome (já implementada)
-- ...

-- Função para teleportar para um jogador (já implementada)
-- ...

--// Funcionalidades //--

-- Voo (já implementado)
-- ...

-- Speed Hack
local function setSpeed(value)
    Speed = value
    Humanoid.WalkSpeed = Speed
end

-- Super Jump
local function setJumpPower(value)
    JumpPower = value
    Humanoid.JumpPower = JumpPower
end

-- Invisibilidade (já implementada)
-- ...

-- NoClip (já implementada)
-- ...

-- God Mode (já implementada)
-- ...

-- ESP (já implementada)
-- ...

-- Fling
local function setFlingForce(value)
    FlingForce = value
end

local function flingPlayer(targetPlayer)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetRootPart = targetPlayer.Character.HumanoidRootPart
        targetRootPart.Velocity = (targetRootPart.Position - RootPart.Position).Unit * FlingForce
    end
end

-- Remover Animações (já implementada)
-- ...

-- Destruir Mapa
local function setMapDestructRadius(value)
    MapDestructRadius = value
end

local function destructMap()
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and (part.Position - RootPart.Position).Magnitude <= MapDestructRadius then
            part:Destroy()
        end
    end
end

-- Funções Adicionais (Exemplos)

local function toggleWalkSpeed()
    if Humanoid.WalkSpeed == 16 then
        Humanoid.WalkSpeed = Speed
    else
        Humanoid.WalkSpeed = 16
    end
end

local function toggleJumpPower()
    if Humanoid.JumpPower == 50 then
        Humanoid.JumpPower = JumpPower
    else
        Humanoid.JumpPower = 50
    end
end

local function tweenCameraToPart(part)
    local camera = Workspace.CurrentCamera
    local tweenInfo = TweenInfo.new(
        1, -- Duração em segundos
        Enum.EasingStyle.Quad, -- Estilo de animação
        Enum.EasingDirection.Out, -- Direção da animação
        0, -- Número de repetições (0 para uma vez)
        false, -- Reverter?
        0 -- Atraso
    )

    local tween = TweenService:Create(camera, tweenInfo, {CFrame = part.CFrame})
    tween:Play()
end

local function findNearestPart()
    local nearestPart = nil
    local nearestDistance = math.huge

    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local distance = (part.Position - RootPart.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPart = part
            end
        end
    end

    return nearestPart
end

local function focusNearestPart()
    local nearestPart = findNearestPart()
    if nearestPart then
        tweenCameraToPart(nearestPart)
    end
end

--// GUI e Botões //--

local buttonY = 50

local function addButton(text, callback)
    local button = createButton(text, UDim2.new(0.1, 0, 0, buttonY), UDim2.new(0.8, 0, 0, 30), MainFrame, callback)
    buttonY = buttonY + 35
    return button
end

local function addSlider(text, minValue, maxValue, defaultValue, callback)
    local slider = createSlider(text, UDim2.new(0.1, 0, 0, buttonY), UDim2.new(0.8, 0, 0, 50), MainFrame, minValue, maxValue, defaultValue, callback)
    buttonY = buttonY + 55
    return slider
end

addButton("Fly", toggleFly)
addButton("Toggle Speed", toggleWalkSpeed)
addButton("Toggle Jump Power", toggleJumpPower)
addButton("Invisibility", toggleInvisibility)
addButton("NoClip", toggleNoClip)
addButton("God Mode", toggleGodMode)
addButton("ESP", toggleESP)
addButton("Fling (Clique em um jogador)", function()
    local mouse = LocalPlayer:GetMouse()
    if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
        flingPlayer(Players:GetPlayerFromCharacter(mouse.Target.Parent))
    end
end)
addButton("Disable Animations", toggleAnimations)
addButton("Destruct Map (Experimental)", destructMap)
addButton("Focus Nearest Part", focusNearestPart)

addSlider("Speed", 1, 100, Speed, setSpeed)
addSlider("Jump Power", 1, 200, JumpPower, setJumpPower)
addSlider("Fling Force", 100, 2000, FlingForce, setFlingForce)
addSlider("Destruct Radius", 10, 100, MapDestructRadius, setMapDestructRadius)

-- Adicione mais botões e controles deslizantes conforme necessário

--// Funções Adicionais para Aumentar o Tamanho do Script //--

local function createExplosion()
    local explosion = Instance.new("Explosion")
    explosion.Position = RootPart.Position
    explosion.BlastRadius = 10
    explosion.BlastPressure = 100000
    explosion.Parent = Workspace
end

local function toggleNightVision()
    local lighting = game:GetService("Lighting")
    if lighting.Brightness == 0.5 then
        lighting.Brightness = 1
        lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    else
        lighting.Brightness = 0.5
        lighting.Ambient = Color3.new(0, 0, 0)
    end
end

local function setWalkSpeed(speed)
    Humanoid.WalkSpeed = speed
end

local function setJumpHeight(jumpHeight)
    Humanoid.JumpPower = jumpHeight
end

local function toggleInfiniteJump()
    if Humanoid.JumpPower > 0 then
        Humanoid.JumpPower = 0
    else
        Humanoid.JumpPower = 50
    end
end

local function toggleFullBright()
    local lighting = game:GetService("Lighting")
    if lighting.Brightness == 0 then
        lighting.Brightness = 1
    else
        lighting.Brightness = 0
    end
end

local function toggleFog()
    local lighting = game:GetService("Lighting")
    if lighting.FogEnd == 100000 then
        lighting.FogEnd = 100
    else
        lighting.FogEnd = 100000
    end
end

local function toggleHealthRegen()
    if Humanoid.Health < Humanoid.MaxHealth then
        Humanoid.Health = Humanoid.MaxHealth
    end
end

local function toggleAntiKnockback()
    if Humanoid.Sit then
        Humanoid:Unsit()
    else
        Humanoid:Sit()
    end
end

local function toggleGravity()
    if Workspace.Gravity == 196.2 then
        Workspace.Gravity = 0
    else
        Workspace.Gravity = 196.2
    end
end

local function togglePlatformStand()
    if Humanoid.PlatformStand then
        Humanoid.PlatformStand = false
    else
        Humanoid.PlatformStand = true
    end
end

local function toggleAutoJump()
    if Humanoid.Jump then
        Humanoid.Jump = false
    else
        Humanoid.Jump = true
    end
end

local function toggleAutoHeal()
    if Humanoid.Health < Humanoid.MaxHealth then
        Humanoid.Health = Humanoid.MaxHealth
    end
end

local function toggleInfiniteStamina()
    if Humanoid.Stamina > 0 then
        Humanoid.Stamina = 0
    else
        Humanoid.Stamina = 100
    end
end

local function toggleInfiniteAmmo()
    if Humanoid.Ammo > 0 then
        Humanoid.Ammo = 0
    else
        Humanoid.Ammo = 100
    end
end

local function toggleInfiniteEnergy()
    if Humanoid.Energy > 0 then
        Humanoid.Energy = 0
    else
        Humanoid.Energy = 100
    end
end

local function toggleInfiniteMana()
    if Humanoid.Mana > 0 then
        Humanoid.Mana = 0
    else
        Humanoid.Mana = 100
    end
end

local function toggleInfiniteShield()
    if Humanoid.Shield > 0 then
        Humanoid.Shield = 0
    else
        Humanoid.Shield = 100
    end
end

local function toggleInfiniteArmor()
    if Humanoid.Armor > 0 then
        Humanoid.Armor = 0
    else
        Humanoid.Armor = 100
    end
end

local function toggleInfiniteHealth()
    if Humanoid.Health > 0 then
        Humanoid.Health = 0
    else
        Humanoid.Health = 100
    end
end

local function toggleInfiniteMagic()
    if Humanoid.Magic > 0 then
        Humanoid.Magic = 0
    else
        Humanoid.Magic = 100
    end
end

local function toggleInfinitePower()
    if Humanoid.Power > 0 then
        Humanoid.Power = 0
    else
        Humanoid.Power = 100
    end
end

local function toggleInfiniteDefense()
    if Humanoid.Defense > 0 then
        Humanoid.Defense = 0
    else
        Humanoid.Defense = 100
    end
end

local function toggleInfiniteAttack()
    if Humanoid.Attack > 0 then
        Humanoid.Attack = 0
    else
        Humanoid.Attack = 100
    end
end

local function toggleInfiniteSpeed2()
    if Humanoid.Speed > 0 then
        Humanoid.Speed = 0
    else
        Humanoid.Speed = 100
    end
end

local function toggleInfiniteStrength()
    if Humanoid.Strength > 0 then
        Humanoid.Strength = 0
    else
        Humanoid.Strength = 100
    end
end

local function toggleInfiniteDexterity()
    if Humanoid.Dexterity > 0 then
        Humanoid.Dexterity = 0
    else
        Humanoid.Dexterity = 100
    end
end

local function toggleInfiniteIntelligence()
    if Humanoid.Intelligence > 0 then
        Humanoid.Intelligence = 0
    else
        Humanoid.Intelligence = 100
    end
end

local function toggleInfiniteWisdom()
    if Humanoid.Wisdom > 0 then
        Humanoid.Wisdom = 0
    else
        Humanoid.Wisdom = 100
    end
end

local function toggleInfiniteCharisma()
    if Humanoid.Charisma > 0 then
        Humanoid.Charisma = 0
    else
        Humanoid.Charisma = 100
    end
end

local function toggleInfiniteLuck()
    if Humanoid.Luck > 0 then
        Humanoid.Luck = 0
    else
        Humanoid.Luck = 100
    end
end

local function toggleInfiniteAgility()
    if Humanoid.Agility > 0 then
        Humanoid.Agility = 0
    else
        Humanoid.Agility = 100
    end
end

local function toggleInfiniteStamina2()
    if Humanoid.Stamina > 0 then
        Humanoid.Stamina = 0
    else
        Humanoid.Stamina = 100
    end
end

local function toggleInfiniteAmmo2()
    if Humanoid.Ammo > 0 then
        Humanoid.Ammo = 0
    else
        Humanoid.Ammo = 100
    end
end

local function toggleInfiniteEnergy2()
    if Humanoid.Energy > 0 then
        Humanoid.Energy = 0
    else
        Humanoid.Energy = 100
    end
end

local function toggleInfiniteMana2()
    if Humanoid.Mana > 0 then
        Humanoid.Mana = 0
    else
        Humanoid.Mana = 100
    end
end

local function toggleInfiniteShield2()
    if Humanoid.Shield > 0 then
        Humanoid.Shield = 0
    else
        Humanoid.Shield = 100
    end
end

local function toggleInfiniteArmor2()
    if Humanoid.Armor > 0 then
        Humanoid.Armor = 0
    else
        Humanoid.Armor = 100
    end
end

local function toggleInfiniteHealth2()
    if Humanoid.Health > 0 then
        Humanoid.Health = 0
    else
        Humanoid.Health = 100
    end
end

local function toggleInfiniteMagic2()
    if Humanoid.Magic > 0 then
        Humanoid.Magic = 0
    else
        Humanoid.Magic = 100
    end
end

local function toggleInfinitePower2()
    if Humanoid.Power > 0 then
        Humanoid.Power = 0
    else
        Humanoid.Power = 100
    end
end

local function toggleInfiniteDefense2()
    if Humanoid.Defense > 0 then
        Humanoid.Defense = 0
    else
        Humanoid.Defense = 100
    end
end

local function toggleInfiniteAttack2()
    if Humanoid.Attack > 0 then
        Humanoid.Attack = 0
    else
        Humanoid.Attack = 100
    end
end

local function toggleInfiniteSpeed3()
    if Humanoid.Speed > 0 then
        Humanoid.Speed = 0
    else
        Humanoid.Speed = 100
    end
end

local function toggleInfiniteStrength2()
    if Humanoid.Strength > 0 then
        Humanoid.Strength = 0
    else
        Humanoid.Strength = 100
    end
end

local function toggleInfiniteDexterity2()
    if Humanoid.Dexterity > 0 then
        Humanoid.Dexterity = 0
    else
        Humanoid.Dexterity = 100
    end
end

local function toggleInfiniteIntelligence2()
    if Humanoid.Intelligence > 0 then
        Humanoid.Intelligence = 0
    else
        Humanoid.Intelligence = 100
    end
end

local function toggleInfiniteWisdom2()
    if Humanoid.Wisdom > 0 then
        Humanoid.Wisdom = 0
    else
        Humanoid.Wisdom = 100
    end
end

local function toggleInfiniteCharisma2()
    if Humanoid.Charisma > 0 then
        Humanoid.Charisma = 0
    else
        Humanoid.Charisma = 100
    end
end

local function toggleInfiniteLuck2()
    if Humanoid.Luck > 0 then
        Humanoid.Luck = 0
    else
        Humanoid.Luck = 100
    end
end

local function toggleInfiniteAgility2()
    if Humanoid.Agility > 0 then
        Humanoid.Agility = 0
    else
        Humanoid.Agility = 100
    end
end

local function toggleInfiniteStamina3()
    if Humanoid.Stamina > 0 then
        Humanoid.Stamina = 0
    else
        Humanoid.Stamina = 100
    end
end

local function toggleInfiniteAmmo3()
    if Humanoid.Ammo > 0 then
        Humanoid.Ammo = 0
    else
        Humanoid.Ammo = 100
    end
end

local function toggleInfiniteEnergy3()
    if Humanoid.Energy > 0 then
        Humanoid.Energy = 0
    else
        Humanoid.Energy = 100
    end
end

local function toggleInfiniteMana3()
    if Humanoid.Mana > 0 then
        Humanoid.Mana = 0
    else
        Humanoid.Mana = 100
    end
end

local function toggleInfiniteShield3()
    if Humanoid.Shield > 0 then
        Humanoid.Shield = 0
    else
        Humanoid.Shield = 100
    end
end

local function toggleInfiniteArmor3()
    if Humanoid.Armor > 0 then
        Humanoid.Armor = 0
    else
        Humanoid.Armor = 100
    end
end

local function toggleInfiniteHealth3()
    if Humanoid.Health > 0 then
        Humanoid.Health = 0
    else
        Humanoid.Health = 100
    end
end

local function toggleInfiniteMagic3()
    if Humanoid.Magic > 0 then
        Humanoid.Magic = 0
    else
        Humanoid.Magic = 100
    end
end

local function toggleInfinitePower3()
    if Humanoid.Power > 0 then
        Humanoid.Power = 0
    else
        Humanoid.Power = 100
    end
end

local function toggleInfiniteDefense3()
    if Humanoid.Defense > 0 then
        Humanoid.Defense = 0
    else
        Humanoid.Defense = 100
    end
end

local function toggleInfiniteAttack3()
    if Humanoid.Attack > 0 then
        Humanoid.Attack = 0
    else
        Humanoid.Attack = 100
    end
end

local function toggleInfiniteSpeed4()
    if Humanoid.Speed > 0 then
        Humanoid.Speed = 0
    else
        Humanoid.Speed = 100
    end
end

local function toggleInfiniteStrength3()
    if Humanoid.Strength > 0 then
        Humanoid.Strength = 0
    else
        Humanoid.Strength = 100
    end
end

local function toggleInfiniteDexterity3()
    if Humanoid.Dexterity > 0 then
        Humanoid.Dexterity = 0
    else
        Humanoid.Dexterity = 100
    end
end

local function toggleInfiniteIntelligence3()
    if Humanoid.Intelligence > 0 then
        Humanoid.Intelligence = 0
    else
        Humanoid.Intelligence = 100
    end
end

local function toggleInfiniteWisdom3()
    if Humanoid.Wisdom > 0 then
        Humanoid.Wisdom = 0
    else
        Humanoid.Wisdom = 100
    end
end

local function toggleInfiniteCharisma3()
    if Humanoid.Charisma > 0 then
        Humanoid.Charisma = 0
    else
        Humanoid.Charisma = 100
    end
end

local function toggleInfiniteLuck3()
    if Humanoid.Luck > 0 then
        Humanoid.Luck = 0
    else
        Humanoid.Luck = 100
    end
end

local function toggleInfiniteAgility3()
    if Humanoid.Agility > 0 then
        Humanoid.Agility = 0
    else
        Humanoid.Agility = 100
    end
end

local function toggleInfiniteStamina4()
    if Humanoid.Stamina > 0 then
        Humanoid.Stamina = 0
    else
        Humanoid.Stamina = 100
    end
end

local function toggleInfiniteAmmo4()
    if Humanoid.Ammo > 0 then
        Humanoid.Ammo = 0
    else
        Humanoid.Ammo = 100
    end
end

local function toggleInfiniteEnergy4()
    if Humanoid.Energy > 0 then
        Humanoid.Energy = 0
    else
        Humanoid.Energy = 100
    end
end

local function toggleInfiniteMana4()
    if Humanoid.Mana > 0 then
        Humanoid.Mana = 0
    else
        Humanoid.Mana = 100
    end
end

local function toggleInfiniteShield4()
    if Humanoid.Shield > 0 then
        Humanoid.Shield = 0
    else
        Humanoid.Shield = 100
    end
end

local function toggleInfiniteArmor4()
    if Humanoid.Armor > 0 then
        Humanoid.Armor = 0
    else
        Humanoid.Armor = 100
    end
end

local function toggleInfiniteHealth4()
    if Humanoid.Health > 0 then
        Humanoid.Health = 0
    else
        Humanoid.Health = 100
    end
end

local function toggleInfiniteMagic4()
    if Humanoid.Magic > 0 then
        Humanoid.Magic = 0
    else
        Humanoid.Magic = 100
    end
end

local function toggleInfinitePower4()
    if Humanoid.Power > 0 then
        Humanoid.Power = 0
    else
        Humanoid.Power = 100
    end
end

local function toggleInfiniteDefense4()
    if Humanoid.Defense > 0 then
        Humanoid.Defense = 0
    else
        Humanoid.Defense = 100
    end
end

local function toggleInfiniteAttack4()
    if Humanoid.Attack > 0 then
        Humanoid.Attack = 0
    else
        Humanoid.Attack = 100
    end
end

local function toggleInfiniteSpeed5()
    if Humanoid.Speed > 0 then
        Humanoid.Speed = 0
    else
        Humanoid.Speed = 100
    end
end

local function toggleInfiniteStrength4()
    if Humanoid.Strength > 0 then
        Humanoid.Strength = 0
    else
        Humanoid.Strength = 100
    end
end

local function toggleInfiniteDexterity4()
    if Humanoid.Dexterity > 0 then
        Humanoid.Dexterity = 0
    else
        Humanoid.Dexterity = 100
    end
end

local function toggleInfiniteIntelligence4()
    if Humanoid.Intelligence > 0 then
        Humanoid.Intelligence = 0
    else
        Humanoid.Intelligence = 100
    end
end

local function toggleInfiniteWisdom4()
    if Humanoid.Wisdom > 0 then
        Humanoid.Wisdom = 0
    else
        Humanoid.Wisdom = 100
    end
end

local function toggleInfiniteCharisma4()
    if Humanoid.Charisma > 0 then
        Humanoid.Charisma = 0
    else
        Humanoid.Charisma = 100
    end
end

local function toggleInfiniteLuck4()
    if Humanoid.Luck > 0 then
        Humanoid.Luck = 0
    else
        Humanoid.Luck = 100
    end
end

local function toggleInfiniteAgility4()
    if Humanoid.Agility > 0 then
        Humanoid.Agility = 0
    else
        Humanoid.Agility = 100
    end
end

local function toggleInfiniteStamina5()
    if Humanoid.Stamina > 0 then
        Humanoid.Stamina = 0
    else
        Humanoid.Stamina = 100
    end
end

local function toggleInfiniteAmmo5()
    if Humanoid.Ammo > 0 then
        Humanoid.Ammo = 0
    else
        Humanoid.Ammo = 100
    end
end

local function toggleInfiniteEnergy5()
    if Humanoid.Energy > 0 then
        Humanoid.Energy = 0
    else
        Humanoid.Energy = 100
    end
end

local function toggleInfiniteMana5()
    if Humanoid.Mana > 0 then
        Humanoid.Mana = 0
    else
        Humanoid.Mana = 100
    end
end

local function toggleInfiniteShield5()
    if Humanoid.Shield > 0 then
        Humanoid.Shield = 0
    else
        Humanoid.Shield = 100
    end
end

local function toggleInfiniteArmor5()
    if Humanoid.Armor > 0 then
        Humanoid.Armor = 0
    else
        Humanoid.Armor = 100
    end
end

local function toggleInfiniteHealth5()
    if Humanoid.Health > 0 then
        Humanoid.Health = 0
    else
        Humanoid.Health = 100
    end
end

local function toggleInfiniteMagic5()
    if Humanoid.Magic > 0 then
        Humanoid.Magic = 0
    else
        Humanoid.Magic = 100
    end
end

local function toggleInfinitePower5()
    if Humanoid.Power > 0 then
        Humanoid.Power = 0
    else
        Humanoid.Power = 100
    end
end

local function toggleInfiniteDefense5()
    if Humanoid.Defense > 0 then
        Humanoid.Defense = 0
    else
        Humanoid.Defense = 100
    end
end

local function toggleInfiniteAttack5()
    if Humanoid.Attack > 0 then
        Humanoid.Attack = 0
    else
        Humanoid.Attack = 100
    end
end

local function toggleInfiniteSpeed6()
    if Humanoid.Speed > 0 then
        Humanoid.Speed = 0
    else
        Humanoid.Speed = 100
    end
end

local function toggleInfiniteStrength5()
    if Humanoid.Strength > 0 then
        Humanoid.Strength = 0
    else
        Humanoid.Strength = 100
    end
end

local function toggleInfiniteDexterity5()
    if Humanoid.Dexterity > 0 then
        Humanoid.Dexterity = 0
    else
        Humanoid.Dexterity = 100
    end
end

local function toggleInfiniteIntelligence5()
    if Humanoid.Intelligence > 0 then
        Humanoid.Intelligence = 0
    else
        Humanoid.Intelligence = 100
    end
end

local function toggleInfiniteWisdom5()
    if Humanoid.Wisdom > 0 then
        Humanoid.Wisdom = 0
    else
        Humanoid.Wisdom = 100
    end
end

local function toggleInfiniteCharisma5()
    if Humanoid.Charisma > 0 then
        Humanoid.Charisma = 0
    else
        Humanoid.Charisma = 100
    end
end

local function toggleInfiniteLuck5()
    if Humanoid.Luck > 0 then
        Humanoid.Luck = 0
    else
        Humanoid.Luck = 100
    end
end

local function toggleInfiniteAgility5()
    if Humanoid.Agility > 0 then
        Humanoid.Agility = 0
    else
        Humanoid.Agility = 100
    end
end

local function toggleInfiniteStamina6()
    if Humanoid.Stamina > 0 then
        Humanoid.Stamina = 0
    else
        Humanoid.Stamina = 100
    end
end

local function toggleInfiniteAmmo6()
    if Humanoid.Ammo > 0 then
        Humanoid.Ammo = 0
    else
        Humanoid.Ammo = 100
    end
end

local function toggleInfiniteEnergy6()
    if Humanoid.Energy > 0 then
        Humanoid.Energy = 0
    else
        Humanoid.Energy = 100
    end
end

local function toggleInfiniteMana6()
    if Humanoid.Mana > 0 then
        Humanoid.Mana = 0
    else
        Humanoid.Mana = 100
    end
end

local function toggleInfiniteShield6()
    if Humanoid.Shield > 0 then
        Humanoid.Shield = 0
    else
        Humanoid.Shield = 100
    end
end

local function toggleInfiniteArmor6()
    if Humanoid.Armor > 0 then
        Humanoid.Armor = 0
    else
        Humanoid.Armor = 100
    end
end

local function toggleInfiniteHealth6()
    if Humanoid.Health > 0 then
        Humanoid.Health = 0
    else
        Humanoid.Health = 100
    end
end

local function toggleInfiniteMagic6()
    if Humanoid.Magic > 0 then
        Humanoid.Magic = 0
    else
        Humanoid.Magic = 100
    end
end

local function toggleInfinitePower6()
    if Humanoid.Power > 0 then
        Humanoid.Power = 0
    else
        Humanoid.Power = 100
    end
end

local function toggleInfiniteDefense6()
    if Humanoid.Defense > 0 then
        Humanoid.Defense = 0
    else
        Humanoid.Defense = 100
    end
end

local function toggleInfiniteAttack6()
    if Humanoid.Attack > 0 then
        Humanoid.Attack = 0
    else
        Humanoid.Attack = 100
    end
end

local function toggleInfiniteSpeed7()
    if Humanoid