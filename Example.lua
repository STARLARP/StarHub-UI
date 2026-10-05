_G.STARHUB_LIBRARY_ONLY = true
local StarHubUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/STARLARP/StarHub-UI/main/StarHubUI.lua"))()
_G.STARHUB_LIBRARY_ONLY = nil

local Window = StarHubUI:CreateWindow({
    Title = "StarHub UI",
    SubTitle = "Minimal Edition",
    Size = UDim2.new(0, 720, 0, 485),
    ToggleKey = Enum.KeyCode.RightControl
})

Window:AddNavHeader("MODULES", 1)

local DashTab = Window:CreateTab({ Title = "Dashboard", IconId = StarHubUI.Icons.Dashboard, BadgeText = "LIVE", LayoutOrder = 2 })
Window:CreateDualColumnDashboard(DashTab)

local CombatTab = Window:CreateTab({ Title = "Combat & Move", IconId = StarHubUI.Icons.Combat, LayoutOrder = 3 })
local AimBox = CombatTab:CreateGroupBox("Left", "AIMBOT CORE ENGINE", "AIM", StarHubUI.Icons.Combat)
AimBox:AddToggle("Aimbot Tracking", "Locks hitscan vectors to closest target", true, function(v) end)
AimBox:AddDropdown("Target Bone", {"Head (Critical)", "UpperTorso", "HumanoidRootPart"}, "Head (Critical)", function(v) end)
AimBox:AddSlider("Smoothness Factor", 1, 20, 8, "VAL", function(v) end)
AimBox:AddSlider("Field of View (FOV)", 30, 400, 120, "DEG", function(v) end)
AimBox:AddToggle("Draw FOV Circle", "Visualizes lock-on radius on screen", true, function(v) end)
AimBox:AddToggle("Wall Check (Visible Only)", "Restricts targeting to visible line of sight", true, function(v) end)

local MoveBox = CombatTab:CreateGroupBox("Right", "MOVEMENT MODIFIERS", "MOVE", StarHubUI.Icons.Zap)
MoveBox:AddToggle("Infinite Jump", "Allows air jumping without touching ground", true, function(v) end)
MoveBox:AddSlider("WalkSpeed Multiplier", 16, 150, 32, "SPD", function(v)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = v
    end
end)
MoveBox:AddSlider("Jump Power", 50, 300, 100, "PWR", function(v)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").JumpPower = v
    end
end)
MoveBox:AddToggle("Bunny Hop Glide", "Continuous momentum hopping across obstacles", true, function(v) end)
MoveBox:AddToggle("Noclip Collision Bypass", "Allows walking through doors and barricades", false, function(v) end)
MoveBox:AddToggle("Auto-Sprint Boost", "Maintains maximum velocity without holding shift", true, function(v) end)

local VisualTab = Window:CreateTab({ Title = "Visuals & ESP", IconId = StarHubUI.Icons.Visuals, LayoutOrder = 4 })
local EspBox = VisualTab:CreateGroupBox("Left", "PLAYER OVERLAYS", "ESP", StarHubUI.Icons.Visuals)
EspBox:AddToggle("2D Bounding Brackets", "Projects corner frame around players", true, function(v) end)
EspBox:AddToggle("Overhead Distance & Tags", "Displays distance in studs and health", true, function(v) end)
EspBox:AddToggle("Dynamic Healthbars", "Displays colored dynamic health indicators", true, function(v) end)
EspBox:AddToggle("Directional Snaplines", "Draws line from screen bottom to nearest target", false, function(v) end)
EspBox:AddColorPicker("ESP Glow Color", Color3.fromRGB(0, 245, 155), function(col) end)

local WorldBox = VisualTab:CreateGroupBox("Right", "RENDER THRESHOLDS", "WORLD", StarHubUI.Icons.Logo)
WorldBox:AddSlider("Render Distance", 100, 3500, 1200, "STUDS", function(v) end)
WorldBox:AddToggle("Occlusion Ray Check", "Shift color when target behind wall", true, function(v) end)
WorldBox:AddToggle("Player Chams Highlight", "Silhouettes character models through walls", true, function(v) end)
WorldBox:AddToggle("Fullbright Night Vision", "Removes shadows and maximizes map illumination", true, function(v) end)
WorldBox:AddInput("Custom Skybox Decal", "https://... or Decal ID", "", function(txt) end)

local TeleTab = Window:CreateTab({ Title = "World Teleport", IconId = StarHubUI.Icons.Teleport, LayoutOrder = 5 })
local WpBox = TeleTab:CreateGroupBox("Left", "COORDINATE WAYPOINTS", "LOCATIONS", StarHubUI.Icons.Teleport)
local dest = "Spawn Lobby"
WpBox:AddDropdown("Select Destination", {"Spawn Lobby", "Egg Market", "Secret Vault", "Safe Zone", "VIP Lounge", "Sky Islands"}, "Spawn Lobby", function(w) dest = w end)
WpBox:AddToggle("Auto-Teleport On Spawn", "Automatically warp to destination after death/respawn", false, function(v) end)
WpBox:AddSlider("Tween Glide Speed", 50, 400, 180, "STUDS/S", function(v) end)

local ActionBox = TeleTab:CreateGroupBox("Right", "WARP EXECUTION", "ACTIVE", StarHubUI.Icons.Zap)
ActionBox:AddActionRow("Execute Instant Warp", "Warps local character directly to selected coordinate", StarHubUI.Icons.Zap, function()
    StarHubUI:Notify({Title = "WARP DISPATCH", Content = "Warping character to: " .. dest})
end)
ActionBox:AddActionRow("Copy Vector3 Position", "Copies current player studs coordinates to clipboard", StarHubUI.Icons.Copy, function()
    pcall(function() setclipboard("Vector3.new(0, 50, 0)") end)
    StarHubUI:Notify({Title = "POSITION COPIED", Content = "Vector3 coordinates copied to clipboard!"})
end)
ActionBox:AddToggle("Void Fall Protection", "Prevents character falling beneath map boundaries", true, function(v) end)
ActionBox:AddModeSelector("WARP METHOD", {"Tween Smooth", "Instant", "Pathfind Walk"}, "Tween Smooth", function(m) end)
ActionBox:AddDangerButton("Emergency Reset", "Instantly resets character to escape combat", StarHubUI.Icons.Skull, function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").Health = 0
    end
end)

Window:AddNavHeader("PREFERENCES", 6)

local SettingsTab = Window:CreateTab({ Title = "System & Theme", IconId = StarHubUI.Icons.Settings, LayoutOrder = 7 })
Window:CreateDualColumnSettings(SettingsTab)

StarHubUI:Notify({
    Title = "STARHUB v5.7 DEFINITIVE EDITION",
    Content = "Apple iOS Bubble Audio & 7 Particle Suites active!",
    Duration = 4
})
