--// UI Library (Use sua preferida, esta é um exemplo básico)
local Library = {}

function Library:CreateWindow(title)
    local window = Instance.new("ScreenGui")
    window.Name = "CheatMenu"
    window.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    frame.BorderSizePixel = 0
    frame.Parent = window

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Text = title
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 16
    titleLabel.Parent = titleBar

	local closeButton = Instance.new("TextButton")
	closeButton.Size = UDim2.new(0,30,0,30)
	closeButton.Position = UDim2.new(1,-30,0,0)
	closeButton.BackgroundColor3 = Color3.new(1,0,0)
	closeButton.Text = "X"
	closeButton.TextColor3 = Color3.new(1,1,1)
	closeButton.Font = Enum.Font.SourceSansBold
	closeButton.TextSize = 16
	closeButton.BorderSizePixel = 0
	closeButton.Parent = titleBar
	closeButton.MouseButton1Click:Connect(function()
		window:Destroy()
	end)


    return frame
end

function Library:CreateButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 35 + 5) -- Spacing
    button.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text
    button.Font = Enum.Font.SourceSans
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.Parent = parent

    button.MouseButton1Click:Connect(callback)
    return button
end

function Library:CreateToggle(parent, text, defaultState, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 30)
    toggleFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 35 + 5) -- Spacing
    toggleFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = parent

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 60, 0, 25)
    toggleButton.Position = UDim2.new(1, -70, 0, 2.5)
    toggleButton.BackgroundColor3 = defaultState and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.Text = defaultState and "ON" or "OFF"
    toggleButton.Font = Enum.Font.SourceSans
    toggleButton.TextSize = 14
    toggleButton.BorderSizePixel = 0
    toggleButton.Parent = toggleFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = text
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.Parent = toggleFrame

    local state = defaultState

    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.Text = state and "ON" or "OFF"
        toggleButton.BackgroundColor3 = state and Color3.new(0, 0.7, 0) or Color3.new(0.7, 0, 0)
        callback(state)
    end)

    return toggleFrame
end

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// Variables
local Flying = false
local Invisible = false
local Speed = 50 -- Default speed
local JumpPower = 50 -- Default JumpPower
local GodModeEnabled = false
local NoClipEnabled = false

--// Functions

--// ESP
local function createESP(player)
	if player and player.Character and player.Character:FindFirstChild("Head") and player ~= LocalPlayer then
		local Head = player.Character:FindFirstChild("Head")
		if Head then
			local Box = Instance.new("BillboardGui")
			Box.Name = "ESP"
			Box.Adornee = Head
			Box.Size = UDim2.new(0,50,0,50)
			Box.AlwaysOnTop = true
			Box.StudsOffsetWorldSpace = Vector3.new(0, 1.5, 0)
			Box.Parent = Head

			local Frame = Instance.new("Frame")
			Frame.Size = UDim2.new(1,0,1,0)
			Frame.BackgroundTransparency = 0.5
			Frame.BackgroundColor3 = Color3.new(1,1,1)
			Frame.Parent = Box

			local TextLabel = Instance.new("TextLabel")
			TextLabel.Size = UDim2.new(1,0,0.5,0)
			TextLabel.Position = UDim2.new(0,0,1,-0.5)
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextColor3 = Color3.new(1,1,1)
			TextLabel.Text = player.Name
			TextLabel.Font = Enum.Font.SourceSansBold
			TextLabel.TextSize = 14
			TextLabel.Parent = Frame
		end
	end
end

local function removeESP(player)
	if player and player.Character then
		for i,v in pairs(player.Character:GetChildren()) do
			if v:IsA("BillboardGui") and v.Name == "ESP" then
				v:Destroy()
			end
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		wait(1)
		createESP(player)
	end)
	createESP(player)
end)

Players.PlayerRemoving:Connect(function(player)
	removeESP(player)
end)

for i, player in pairs(Players:GetPlayers()) do
	if player.Character then
		createESP(player)
	end
end
--// Teleport to Player
local function TeleportToPlayer(playerName)
	for i, player in pairs(Players:GetPlayers()) do
		if player.Name == playerName and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character:MoveTo(player.Character.HumanoidRootPart.Position)
			break
		end
	end
end

--// Fly
local function ToggleFly(state)
    Flying = state
    if Flying then
        Humanoid.PlatformStand = true
        Humanoid.JumpPower = 0
    else
        Humanoid.PlatformStand = false
        Humanoid.JumpPower = JumpPower -- Restore original jump power
    end
end

RunService.RenderStepped:Connect(function()
    if Flying then
        HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(math.rad(-UserInputService:GetAxis("MoveForward", "MoveBackward") * 2), math.rad(-UserInputService:GetAxis("MoveLeft", "MoveRight") * 2),0)

        if UserInputService:IsKeyDown(Enum.KeyCode.E) then
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, Speed/10, 0)
        elseif UserInputService:IsKeyDown(Enum.KeyCode.Q) then
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -Speed/10, 0)
        end

        local moveVector = Vector3.new(UserInputService:GetAxis("MoveLeft", "MoveRight"), 0, UserInputService:GetAxis("MoveForward", "MoveBackward")).Unit
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + moveVector * Speed/5
    end
end)

--// Invisibility
local function ToggleInvisibility(state)
	Invisible = state
	for i, v in pairs(Character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = Invisible and 1 or 0
		end
	end
end

--// Fling
local function Fling(target)
	if target and target:IsA("Humanoid") and target.Parent:FindFirstChild("HumanoidRootPart") then
		local hrp = target.Parent:FindFirstChild("HumanoidRootPart")
		hrp.Velocity = Vector3.new(math.random(-500, 500), 500, math.random(-500, 500))
	end
end

--// Speed Hack
local function SetSpeed(speed)
	Humanoid.WalkSpeed = speed
end

--// Super Jump
local function SetJumpPower(jumpPower)
	JumpPower = jumpPower
	Humanoid.JumpPower = jumpPower
end

--// NoClip
local function ToggleNoClip(state)
	NoClipEnabled = state
	for i, v in pairs(Character:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = not NoClipEnabled
		end
	end
end

--// God Mode (Basic Example, Game Dependent)
local function ToggleGodMode(state)
    GodModeEnabled = state
	--  A implementacao do GodMode DEPENDE do jogo. Voce precisaria interceptar o dano
	--  O ideal e substituir a funcao TakeDamage do humanoid para previnir a morte.
	--  Este exemplo eh SIMPLIFICADO e pode nao funcionar em todos os jogos.
	--  Em jogos que usam scripts customizados de dano, sera necessario encontrar
	--  e modificar esses scripts diretamente, o que eh mais avancado.

	-- Exemplo basico: Modificar a health do Humanoid
	if GodModeEnabled then
		Humanoid.MaxHealth = 99999
		Humanoid.Health = 99999
	else
		Humanoid.MaxHealth = 100
		Humanoid.Health = 100
	end
end

--// Remove Ragdoll
local function RemoveRagdoll()
    for i, v in pairs(Character:GetDescendants()) do
        if v:IsA("Motor6D") then
            v.Enabled = true
        end
    end
end

--// Destroy Map (Extremely Experimental and Likely to Cause Lag)
local function DestroyMap()
    for i, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Anchored == true then
            obj:Destroy()
        end
    end
end

--// User Input Service (For Fly)
local UserInputService = game:GetService("UserInputService")

--// UI Creation
local window = Library:CreateWindow("Cheat Menu")

--// ESP Button (Lista de jogadores com botão de teleporte)
Library:CreateButton(window, "Mostrar Lista de Jogadores", function()
	local playerListWindow = Library:CreateWindow("Jogadores")
	playerListWindow.Size = UDim2.new(0, 200, 0, 300)
	playerListWindow.Position = UDim2.new(0.2, -100, 0.5, -150)

	for i, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			Library:CreateButton(playerListWindow, player.Name, function()
				TeleportToPlayer(player.Name)
				playerListWindow.Parent:Destroy() -- Fecha a lista apos o teleporte
			end)
		end
	end
end)

--// Toggle Buttons
Library:CreateToggle(window, "Fly", false, ToggleFly)
Library:CreateToggle(window, "Invisibility", false, ToggleInvisibility)
Library:CreateToggle(window, "NoClip", false, ToggleNoClip)
Library:CreateToggle(window, "God Mode", false, ToggleGodMode)

--// Fling Button (Ação ao tocar)
--// Speed Hack Buttons
local speedFrame = Instance.new("Frame")
speedFrame.Size = UDim2.new(1, -20, 0, 30)
speedFrame.Position = UDim2.new(0, 10, 0, #window:GetChildren() * 35 + 5)
speedFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
speedFrame.BorderSizePixel = 0
speedFrame.Parent = window

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
speedLabel.Position = UDim2.new(0, 0, 0, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Text = "Velocidade:"
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextSize = 14
speedLabel.Parent = speedFrame

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.5, 0, 1, 0)
speedBox.Position = UDim2.new(0.5, 0, 0, 0)
speedBox.Text = tostring(Speed)
speedBox.Font = Enum.Font.SourceSans
speedBox.TextSize = 14
speedBox.Parent = speedFrame

speedBox.FocusLost:Connect(function()
	local newSpeed = tonumber(speedBox.Text)
	if newSpeed then
		Speed = newSpeed
		SetSpeed(Speed)
	else
		speedBox.Text = tostring(Speed)
	end
end)

--// Jump Power Buttons
local jumpFrame = Instance.new("Frame")
jumpFrame.Size = UDim2.new(1, -20, 0, 30)
jumpFrame.Position = UDim2.new(0, 10, 0, #window:GetChildren() * 35 + 5)
jumpFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
jumpFrame.BorderSizePixel = 0
jumpFrame.Parent = window

local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(0.5, 0, 1, 0)
jumpLabel.Position = UDim2.new(0, 0, 0, 0)
jumpLabel.BackgroundTransparency = 1
jumpLabel.TextColor3 = Color3.new(1, 1, 1)
jumpLabel.Text = "Pulo:"
jumpLabel.Font = Enum.Font.SourceSans
jumpLabel.TextSize = 14
jumpLabel.Parent = jumpFrame

local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0.5, 0, 1, 0)
jumpBox.Position = UDim2.new(0.5, 0, 0, 0)
jumpBox.Text = tostring(JumpPower)
jumpBox.Font = Enum.Font.SourceSans
jumpBox.TextSize = 14
jumpBox.Parent = jumpFrame

jumpBox.FocusLost:Connect(function()
	local newJump = tonumber(jumpBox.Text)
	if newJump then
		JumpPower = newJump
		SetJumpPower(JumpPower)
	else
		jumpBox.Text = tostring(JumpPower)
	end
end)

--// Fling
Character.Touched:Connect(function(hit)
	if hit and hit.Parent:FindFirstChild("Humanoid") then
		Fling(hit.Parent:FindFirstChild("Humanoid"))
	end
end)

--// Other Buttons
Library:CreateButton(window, "Remover Ragdoll", RemoveRagdoll)
--Library:CreateButton(window, "Destruir Mapa (Experimental)", DestroyMap) -- Cuidado, pode travar

print("Cheat Menu Loaded!")
