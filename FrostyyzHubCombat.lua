--==============================
-- KEY SYSTEM
--==============================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

local VALID_KEYS = {
	"Q7mKZ4pR9D8fY2LxHcT5nWbA0E",
	"8ZP2Cq0YxR4m5A6HkB7TnWf9D",
	"R0b7xQ4H8WfMZ2CkY6P5A9nD",
	"M9A0x5H8KfZ7R4C2PqD6nWY",
	"Z6R9P5xC2k8fW0D7AqY4nH",
	"7kP5R8A9f0W6xZC4nY2HDM",
	"0x7fA8ZC2WnK4R9Y5P6HDM",
	"A5Z2x9C7K6P4R0WfHnY8D",
	"H2R0fZ9A8x4W6K5n7PYC",
	"C9R2x0Zf6W8A4K7HnP5Y",
	"20_Fat"
}

local function checkKey(k)
	for _,v in ipairs(VALID_KEYS) do
		if k == v then return true end
	end
	return false
end

-- GUI KEY
local keyGui = Instance.new("ScreenGui", PlayerGui)
keyGui.ResetOnSpawn = false

local kFrame = Instance.new("Frame", keyGui)
kFrame.Size = UDim2.new(0,420,0,220)
kFrame.Position = UDim2.new(0.5,-210,0.5,-110)
kFrame.BackgroundColor3 = Color3.fromRGB(15,15,25)
kFrame.Active = true
kFrame.Draggable = true
Instance.new("UICorner", kFrame).CornerRadius = UDim.new(0,14)

local kTitle = Instance.new("TextLabel", kFrame)
kTitle.Size = UDim2.new(1,0,0,45)
kTitle.Text = "KEY SYSTEM"
kTitle.Font = Enum.Font.GothamBlack
kTitle.TextSize = 22
kTitle.TextColor3 = Color3.fromRGB(0,255,255)
kTitle.BackgroundTransparency = 1

local kBox = Instance.new("TextBox", kFrame)
kBox.Size = UDim2.new(1,-40,0,45)
kBox.Position = UDim2.new(0,20,0,70)
kBox.PlaceholderText = "Insert key"
kBox.Text = ""
kBox.Font = Enum.Font.Gotham
kBox.TextSize = 14
kBox.TextColor3 = Color3.fromRGB(0,255,255)
kBox.BackgroundColor3 = Color3.fromRGB(30,30,45)
Instance.new("UICorner", kBox).CornerRadius = UDim.new(0,10)

local kBtn = Instance.new("TextButton", kFrame)
kBtn.Size = UDim2.new(0,160,0,40)
kBtn.Position = UDim2.new(0.5,-80,0,140)
kBtn.Text = "UNLOCK"
kBtn.Font = Enum.Font.GothamBold
kBtn.TextSize = 15
kBtn.TextColor3 = Color3.fromRGB(0,255,255)
kBtn.BackgroundColor3 = Color3.fromRGB(35,35,55)
Instance.new("UICorner", kBtn).CornerRadius = UDim.new(0,10)

local unlocked = false
kBtn.MouseButton1Click:Connect(function()
	if checkKey(kBox.Text) then
		unlocked = true
		keyGui:Destroy()
	end
end)

repeat task.wait() until unlocked

--==============================
-- FROSTYYZ HUB COMBAT 8.1
--==============================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Workspace = workspace

--==============================
-- VARIÁVEIS
--==============================
local aimOn, espOn, teamCheck, showFOV, wallCheck = false, false, true, true, false
local aimFOV, aimSmoothness = 100, 0
local aimTarget = "Head"
local espObjects = {}
local guiVisible = true
local infiniteJumpOn, bhopOn = false, false
local spaceDown = false

-- BHop leve (1.14x)
local bhopSpeedMultiplier = 1.14

--==============================
-- GUI COMPACTA
--==============================
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "FrostyyzHub"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,450,0,350)
main.Position = UDim2.new(0.5,-225,0.5,-175)
main.BackgroundColor3 = Color3.fromRGB(20,20,30)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "FROSTYYZ HUB COMBAT"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(0,255,255)
title.BackgroundTransparency = 1

local combatPage = Instance.new("Frame", main)
combatPage.Size = UDim2.new(1,0,1,0)
combatPage.Position = UDim2.new(0,0,0,40)
combatPage.BackgroundTransparency = 1

local function createButton(parent,text,x,y,w)
	local b = Instance.new("TextButton", parent)
	b.Position = UDim2.new(0,x,0,y)
	b.Size = UDim2.new(0,w or 120,0,30)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = Color3.fromRGB(0,255,255)
	b.BackgroundColor3 = Color3.fromRGB(35,35,50)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

-- BOTÕES
local aimBtn = createButton(combatPage,"AIMBOT OFF",10,10,120)
local smoothBtn = createButton(combatPage,"Smooth: 0",150,10,120)
local espBtn = createButton(combatPage,"ESP OFF",10,50,120)
local teamBtn = createButton(combatPage,"Team Check ON",150,50,120)
local wallBtn = createButton(combatPage,"Wall Check OFF",10,90,120)
local infJumpBtn = createButton(combatPage,"Infinite Jump OFF",150,90,120)
local bhopBtn = createButton(combatPage,"BHop OFF",10,130,120)

local fovBox = Instance.new("TextBox", combatPage)
fovBox.Position = UDim2.new(0,10,0,170)
fovBox.Size = UDim2.new(0,120,0,30)
fovBox.PlaceholderText = "FOV (ex: 120)"
fovBox.Text = tostring(aimFOV)
fovBox.Font = Enum.Font.Gotham
fovBox.TextSize = 14
fovBox.TextColor3 = Color3.fromRGB(0,255,255)
fovBox.BackgroundColor3 = Color3.fromRGB(35,35,50)
Instance.new("UICorner", fovBox).CornerRadius = UDim.new(0,8)

local hideFovBtn = createButton(combatPage,"Hide FOV: OFF",150,170,120)

-- FOV CIRCLE
local fovCircle = Drawing.new("Circle")
fovCircle.Color = Color3.fromRGB(0,255,255)
fovCircle.Thickness = 2
fovCircle.NumSides = 100
fovCircle.Filled = false
fovCircle.Radius = aimFOV
fovCircle.Visible = true

--==============================
-- ESP / AIM
--==============================
local function clearESP()
	for _,v in pairs(espObjects) do
		if v then
			if v.Box then v.Box:Destroy() end
			if v.Name then v.Name:Destroy() end
		end
	end
	espObjects = {}
end

local function createESP(player)
	if player == LocalPlayer then return end
	if teamCheck and player.Team == LocalPlayer.Team then return end
	if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = player.Character.HumanoidRootPart
	box.Size = Vector3.new(4,6,2)
	box.Color3 = Color3.fromRGB(0,255,255)
	box.Transparency = 0.5
	box.AlwaysOnTop = true
	box.ZIndex = 5
	box.Parent = workspace

	local name = Instance.new("BillboardGui", player.Character)
	name.Size = UDim2.new(0,50,0,15)
	name.Adornee = player.Character.HumanoidRootPart
	name.StudsOffset = Vector3.new(0,-3,0)
	name.AlwaysOnTop = true
	local label = Instance.new("TextLabel", name)
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(0,255,255)
	label.Font = Enum.Font.GothamBold
	label.TextScaled = true
	label.Text = player.Name

	espObjects[player] = {Box = box, Name = name}
end

Players.PlayerRemoving:Connect(function(plr)
	if espObjects[plr] then
		if espObjects[plr].Box then espObjects[plr].Box:Destroy() end
		if espObjects[plr].Name then espObjects[plr].Name:Destroy() end
		espObjects[plr] = nil
	end
end)

local function canSee(target)
	if not wallCheck then return true end
	if not target.Character or not target.Character:FindFirstChild(aimTarget) then return false end
	local origin = Camera.CFrame.Position
	local direction = (target.Character[aimTarget].Position - origin).Unit * 500
	local ray = Ray.new(origin, direction)
	local hit, pos = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character}, false, true)
	if hit and hit:IsDescendantOf(target.Character) then
		return true
	end
	return false
end

local function getClosestTarget()
	local closest, dist = nil, aimFOV
	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(aimTarget) then
			if teamCheck and plr.Team == LocalPlayer.Team then continue end
			if wallCheck and not canSee(plr) then continue end
			local pos, visible = Camera:WorldToViewportPoint(plr.Character[aimTarget].Position)
			if visible then
				local mag = (Vector2.new(pos.X,pos.Y) - UIS:GetMouseLocation()).Magnitude
				if mag < dist then
					dist = mag
					closest = plr
				end
			end
		end
	end
	return closest
end

--==============================
-- BOTÕES
--==============================
aimBtn.MouseButton1Click:Connect(function()
	aimOn = not aimOn
	aimBtn.Text = aimOn and "AIMBOT ON" or "AIMBOT OFF"
end)

smoothBtn.MouseButton1Click:Connect(function()
	aimSmoothness = aimSmoothness + 1
	if aimSmoothness > 10 then aimSmoothness = 0 end
	smoothBtn.Text = "Smooth: "..aimSmoothness
end)

espBtn.MouseButton1Click:Connect(function()
	espOn = not espOn
	espBtn.Text = espOn and "ESP ON" or "ESP OFF"
end)

teamBtn.MouseButton1Click:Connect(function()
	teamCheck = not teamCheck
	teamBtn.Text = teamCheck and "Team Check ON" or "Team Check OFF"
end)

wallBtn.MouseButton1Click:Connect(function()
	wallCheck = not wallCheck
	wallBtn.Text = wallCheck and "Wall Check ON" or "Wall Check OFF"
end)

infJumpBtn.MouseButton1Click:Connect(function()
	infiniteJumpOn = not infiniteJumpOn
	infJumpBtn.Text = infiniteJumpOn and "Infinite Jump ON" or "Infinite Jump OFF"
end)

bhopBtn.MouseButton1Click:Connect(function()
	bhopOn = not bhopOn
	bhopBtn.Text = bhopOn and "BHop ON" or "BHop OFF"
end)

hideFovBtn.MouseButton1Click:Connect(function()
	showFOV = not showFOV
	hideFovBtn.Text = showFOV and "Hide FOV: OFF" or "Hide FOV: ON"
end)

fovBox.FocusLost:Connect(function(enter)
	if enter then
		local v = tonumber(fovBox.Text)
		if v and v >= 20 and v <= 999999 then
			aimFOV = v
		end
		fovBox.Text = tostring(aimFOV)
	end
end)

--==============================
-- GUI TOGGLE + SPACE BHOP
--==============================
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.G then
		guiVisible = not guiVisible
		main.Visible = guiVisible
	end
	if input.KeyCode == Enum.KeyCode.Space then
		spaceDown = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Space then
		spaceDown = false
	end
end)

--==============================
-- LOOP COMBAT + BHOP + ESP + AIM
--==============================
RunService.RenderStepped:Connect(function()
	-- FOV Circle
	fovCircle.Position = UIS:GetMouseLocation()
	fovCircle.Radius = aimFOV
	fovCircle.Visible = showFOV and aimOn

	-- ESP
	if espOn then
		for _,plr in pairs(Players:GetPlayers()) do
			if not espObjects[plr] then
				createESP(plr)
			end
		end
	else
		clearESP()
	end

	-- AIM
	if aimOn and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
		local target = getClosestTarget()
		if target and target.Character then
			local part = target.Character[aimTarget]
			local cf = Camera.CFrame
			local look = CFrame.new(cf.Position, part.Position)
			Camera.CFrame = aimSmoothness == 0 and look or cf:Lerp(look, aimSmoothness/10)
		end
	end

	-- BHop + Infinite Jump
	if (bhopOn or infiniteJumpOn) and spaceDown and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local hum = LocalPlayer.Character.Humanoid
		local root = LocalPlayer.Character.HumanoidRootPart
		if hum.FloorMaterial ~= Enum.Material.Air then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			
			if bhopOn then
				local moveDir = Vector3.new(0,0,0)
				if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + root.CFrame.LookVector end
				if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - root.CFrame.LookVector end
				if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - root.CFrame.RightVector end
				if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + root.CFrame.RightVector end
				
				root.Velocity = root.Velocity + moveDir * (1.4 * bhopSpeedMultiplier)
			end
		end
	end
end)

print("FROSTYYZ HUB COMBAT 8.1 carregado")
