local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local SoundService = game:GetService("SoundService")
local TeleportService = game:GetService("TeleportService")
local StatsService = game:GetService("Stats")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local function LoadCustomImage(urlOrAsset, defaultAsset)
    defaultAsset = defaultAsset or "rbxassetid://10709819149"
    if not urlOrAsset or urlOrAsset == "" then return defaultAsset end

    local assetNum = urlOrAsset:match("%d+")
    if urlOrAsset:find("roblox%.com") and assetNum then
        return "rbxassetid://" .. assetNum
    end
    if string.find(urlOrAsset, "^rbxassetid://") or tonumber(urlOrAsset) then
        return tonumber(urlOrAsset) and ("rbxassetid://" .. urlOrAsset) or urlOrAsset
    end

    if string.find(urlOrAsset, "^http") and writefile and isfile then
        local safeName = "starhub_custom_logo_" .. tostring(math.abs(urlOrAsset:len() * 37 + (urlOrAsset:byte(1) or 0) * 17)) .. ".png"
        pcall(function()
            if not isfile(safeName) then
                local res = game:HttpGet(urlOrAsset)
                if res and #res > 100 then
                    writefile(safeName, res)
                end
            end
        end)
        if isfile and isfile(safeName) then
            if getcustomasset then
                return getcustomasset(safeName)
            elseif getsynasset then
                return getsynasset(safeName)
            end
        end
    end
    return urlOrAsset
end

local StarHubUI = {
    Version = "5.3.0",
    Settings = {
        AutoSaveEnabled = true,
        SoundEnabled = true,
        SoundVolume = 0.55,
        SoundTheme = "Apple iOS Bubble",
        WindowTransparency = 0,
        AcrylicEnabled = true,
        ShowFloatingToggle = true,
        ControlsPosition = "Left",
        KeybindMode = "Toggle",
        ToggleKey = "RightControl",
        CurrentTheme = "NeverloseCrimson",
        AccentStyle = "Gradient",
        CustomColor1 = "",
        CustomColor2 = "",
        WallpaperTransparency = 0.92,
        WallpaperDimming = 0.35,
        BackgroundEffect = "Floating Bubbles",
        CustomWallpaperId = "",
        CustomLogoUrl = "https://raw.githubusercontent.com/nibamako08-code/xd/main/content.png"
    },
    Themes = {
        NeverloseCrimson = {
            Name        = "Neverlose Crimson",
            Grad1       = Color3.fromRGB(235, 55, 75),
            Grad2       = Color3.fromRGB(255, 110, 80),
            Accent      = Color3.fromRGB(235, 55, 75),
            AccentLight = Color3.fromRGB(255, 110, 130),
            Background  = Color3.fromRGB(13, 14, 18),
            Sidebar     = Color3.fromRGB(10, 11, 14),
            Box         = Color3.fromRGB(18, 19, 25),
            SubBox      = Color3.fromRGB(24, 26, 34),
            Border      = Color3.fromRGB(36, 35, 46),
            BorderLight = Color3.fromRGB(58, 52, 68),
            TextTitle   = Color3.fromRGB(255, 255, 255),
            TextBody    = Color3.fromRGB(220, 218, 228),
            TextDim     = Color3.fromRGB(140, 136, 150),
            TextMuted   = Color3.fromRGB(90, 85, 98),
            Success     = Color3.fromRGB(34, 197, 94),
            Danger      = Color3.fromRGB(235, 55, 75)
        },
        StarHubGold = {
            Name        = "StarHub Gold",
            Grad1       = Color3.fromRGB(245, 158, 11),
            Grad2       = Color3.fromRGB(251, 191, 36),
            Accent      = Color3.fromRGB(245, 158, 11),
            AccentLight = Color3.fromRGB(251, 191, 36),
            Background  = Color3.fromRGB(14, 13, 10),
            Sidebar     = Color3.fromRGB(11, 10, 8),
            Box         = Color3.fromRGB(21, 19, 15),
            SubBox      = Color3.fromRGB(28, 25, 19),
            Border      = Color3.fromRGB(44, 39, 30),
            BorderLight = Color3.fromRGB(64, 56, 42),
            TextTitle   = Color3.fromRGB(255, 255, 255),
            TextBody    = Color3.fromRGB(230, 225, 212),
            TextDim     = Color3.fromRGB(145, 138, 125),
            TextMuted   = Color3.fromRGB(95, 88, 78),
            Success     = Color3.fromRGB(16, 185, 129),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        CyberCyan = {
            Name        = "Cyber Cyan",
            Grad1       = Color3.fromRGB(6, 182, 212),
            Grad2       = Color3.fromRGB(139, 92, 246),
            Accent      = Color3.fromRGB(6, 182, 212),
            AccentLight = Color3.fromRGB(56, 189, 248),
            Background  = Color3.fromRGB(10, 13, 18),
            Sidebar     = Color3.fromRGB(8, 10, 14),
            Box         = Color3.fromRGB(16, 21, 30),
            SubBox      = Color3.fromRGB(22, 28, 40),
            Border      = Color3.fromRGB(32, 42, 60),
            BorderLight = Color3.fromRGB(48, 68, 96),
            TextTitle   = Color3.fromRGB(250, 252, 255),
            TextBody    = Color3.fromRGB(215, 225, 238),
            TextDim     = Color3.fromRGB(130, 145, 170),
            TextMuted   = Color3.fromRGB(80, 95, 115),
            Success     = Color3.fromRGB(34, 197, 94),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        MatrixEmerald = {
            Name        = "Matrix Emerald",
            Grad1       = Color3.fromRGB(16, 185, 129),
            Grad2       = Color3.fromRGB(52, 211, 153),
            Accent      = Color3.fromRGB(16, 185, 129),
            AccentLight = Color3.fromRGB(52, 211, 153),
            Background  = Color3.fromRGB(10, 14, 12),
            Sidebar     = Color3.fromRGB(8, 11, 10),
            Box         = Color3.fromRGB(16, 22, 19),
            SubBox      = Color3.fromRGB(22, 30, 26),
            Border      = Color3.fromRGB(28, 44, 36),
            BorderLight = Color3.fromRGB(44, 68, 54),
            TextTitle   = Color3.fromRGB(245, 255, 250),
            TextBody    = Color3.fromRGB(210, 230, 220),
            TextDim     = Color3.fromRGB(120, 145, 130),
            TextMuted   = Color3.fromRGB(75, 95, 85),
            Success     = Color3.fromRGB(16, 185, 129),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        ObsidianViolet = {
            Name        = "Obsidian Violet",
            Grad1       = Color3.fromRGB(124, 58, 237),
            Grad2       = Color3.fromRGB(192, 132, 252),
            Accent      = Color3.fromRGB(124, 58, 237),
            AccentLight = Color3.fromRGB(144, 97, 249),
            Background  = Color3.fromRGB(12, 14, 19),
            Sidebar     = Color3.fromRGB(9, 10, 14),
            Box         = Color3.fromRGB(18, 20, 28),
            SubBox      = Color3.fromRGB(24, 27, 38),
            Border      = Color3.fromRGB(34, 38, 52),
            BorderLight = Color3.fromRGB(52, 60, 80),
            TextTitle   = Color3.fromRGB(255, 255, 255),
            TextBody    = Color3.fromRGB(215, 218, 230),
            TextDim     = Color3.fromRGB(125, 130, 150),
            TextMuted   = Color3.fromRGB(80, 85, 102),
            Success     = Color3.fromRGB(16, 185, 129),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        SakuraBlossom = {
            Name        = "Sakura Blossom",
            Grad1       = Color3.fromRGB(244, 63, 94),
            Grad2       = Color3.fromRGB(251, 113, 133),
            Accent      = Color3.fromRGB(244, 63, 94),
            AccentLight = Color3.fromRGB(251, 113, 133),
            Background  = Color3.fromRGB(18, 12, 16),
            Sidebar     = Color3.fromRGB(14, 9, 12),
            Box         = Color3.fromRGB(26, 18, 23),
            SubBox      = Color3.fromRGB(34, 24, 30),
            Border      = Color3.fromRGB(52, 34, 44),
            BorderLight = Color3.fromRGB(78, 48, 64),
            TextTitle   = Color3.fromRGB(255, 250, 252),
            TextBody    = Color3.fromRGB(235, 215, 225),
            TextDim     = Color3.fromRGB(155, 130, 142),
            TextMuted   = Color3.fromRGB(105, 80, 92),
            Success     = Color3.fromRGB(34, 197, 94),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        GlacierIce = {
            Name        = "Glacier Ice",
            Grad1       = Color3.fromRGB(2, 132, 199),
            Grad2       = Color3.fromRGB(56, 189, 248),
            Accent      = Color3.fromRGB(2, 132, 199),
            AccentLight = Color3.fromRGB(56, 189, 248),
            Background  = Color3.fromRGB(10, 14, 20),
            Sidebar     = Color3.fromRGB(8, 11, 16),
            Box         = Color3.fromRGB(15, 22, 32),
            SubBox      = Color3.fromRGB(20, 30, 44),
            Border      = Color3.fromRGB(30, 48, 70),
            BorderLight = Color3.fromRGB(45, 75, 110),
            TextTitle   = Color3.fromRGB(245, 252, 255),
            TextBody    = Color3.fromRGB(210, 230, 245),
            TextDim     = Color3.fromRGB(130, 150, 175),
            TextMuted   = Color3.fromRGB(80, 100, 125),
            Success     = Color3.fromRGB(34, 197, 94),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        SunsetFlame = {
            Name        = "Sunset Flame",
            Grad1       = Color3.fromRGB(234, 88, 12),
            Grad2       = Color3.fromRGB(245, 158, 11),
            Accent      = Color3.fromRGB(234, 88, 12),
            AccentLight = Color3.fromRGB(251, 146, 60),
            Background  = Color3.fromRGB(16, 12, 10),
            Sidebar     = Color3.fromRGB(13, 9, 8),
            Box         = Color3.fromRGB(24, 18, 14),
            SubBox      = Color3.fromRGB(32, 24, 18),
            Border      = Color3.fromRGB(50, 36, 26),
            BorderLight = Color3.fromRGB(75, 52, 36),
            TextTitle   = Color3.fromRGB(255, 250, 245),
            TextBody    = Color3.fromRGB(235, 220, 210),
            TextDim     = Color3.fromRGB(155, 135, 125),
            TextMuted   = Color3.fromRGB(105, 85, 75),
            Success     = Color3.fromRGB(34, 197, 94),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        ElectricLime = {
            Name        = "Electric Lime",
            Grad1       = Color3.fromRGB(132, 204, 22),
            Grad2       = Color3.fromRGB(163, 230, 53),
            Accent      = Color3.fromRGB(132, 204, 22),
            AccentLight = Color3.fromRGB(163, 230, 53),
            Background  = Color3.fromRGB(11, 14, 10),
            Sidebar     = Color3.fromRGB(9, 11, 8),
            Box         = Color3.fromRGB(17, 22, 15),
            SubBox      = Color3.fromRGB(23, 30, 20),
            Border      = Color3.fromRGB(36, 48, 30),
            BorderLight = Color3.fromRGB(54, 72, 44),
            TextTitle   = Color3.fromRGB(250, 255, 245),
            TextBody    = Color3.fromRGB(220, 235, 215),
            TextDim     = Color3.fromRGB(135, 150, 130),
            TextMuted   = Color3.fromRGB(85, 100, 80),
            Success     = Color3.fromRGB(132, 204, 22),
            Danger      = Color3.fromRGB(239, 68, 68)
        },
        MidnightStealth = {
            Name        = "Midnight Stealth",
            Grad1       = Color3.fromRGB(148, 163, 184),
            Grad2       = Color3.fromRGB(203, 213, 225),
            Accent      = Color3.fromRGB(148, 163, 184),
            AccentLight = Color3.fromRGB(226, 232, 240),
            Background  = Color3.fromRGB(11, 12, 14),
            Sidebar     = Color3.fromRGB(9, 9, 11),
            Box         = Color3.fromRGB(17, 18, 22),
            SubBox      = Color3.fromRGB(23, 24, 30),
            Border      = Color3.fromRGB(34, 36, 44),
            BorderLight = Color3.fromRGB(52, 55, 66),
            TextTitle   = Color3.fromRGB(255, 255, 255),
            TextBody    = Color3.fromRGB(220, 222, 228),
            TextDim     = Color3.fromRGB(135, 140, 150),
            TextMuted   = Color3.fromRGB(85, 90, 100),
            Success     = Color3.fromRGB(34, 197, 94),
            Danger      = Color3.fromRGB(239, 68, 68)
        }
    },
    Icons = {
        Logo        = "rbxassetid://10709819149",
        Search      = "rbxassetid://10734943674",
        Close       = "rbxassetid://10747384394",
        Minimize    = "rbxassetid://10709791185",
        Settings    = "rbxassetid://10734950309",
        ChevronDown = "rbxassetid://10709790948",
        Palette     = "rbxassetid://10734910430",
        Save        = "rbxassetid://10734941499",
        Skull       = "rbxassetid://10734962068",
        Dashboard   = "rbxassetid://10709752035",
        Combat      = "rbxassetid://10709818534",
        Visuals     = "rbxassetid://10747375132",
        Teleport    = "rbxassetid://10723404337",
        Refresh     = "rbxassetid://10734933222",
        Server      = "rbxassetid://10734963400",
        Copy        = "rbxassetid://10709812159",
        Sound       = "rbxassetid://10709810814",
        SoundMute   = "rbxassetid://10709810619",
        Bell        = "rbxassetid://10709752996",
        Info        = "rbxassetid://10709752996",
        Check       = "rbxassetid://10709790644",
        Zap         = "rbxassetid://10709791882"
    }
}

local Theme = (StarHubUI.Settings.CurrentTheme and StarHubUI.Themes[StarHubUI.Settings.CurrentTheme]) or StarHubUI.Themes.NeverloseCrimson

local ThemeRegistry = {
    Gradients = {},
    Accents = {},
    Backgrounds = {},
    Sidebars = {},
    Boxes = {},
    SubBoxes = {},
    Borders = {},
    ModeSelectors = {}
}

local function RegisterElement(category, obj)
    if ThemeRegistry[category] then
        table.insert(ThemeRegistry[category], obj)
    end
end

local function ApplyGradient(parentObj, color1, color2, rotation)
    if parentObj:IsA("TextLabel") or parentObj:IsA("TextButton") then
        parentObj.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
    local isSolid = (StarHubUI.Settings.AccentStyle == "Solid")
    color1 = color1 or Theme.Grad1
    color2 = isSolid and color1 or (color2 or Theme.Grad2)
    rotation = rotation or 0
    local grad = parentObj:FindFirstChildOfClass("UIGradient")
    if not grad then
        grad = Instance.new("UIGradient")
        grad.Parent = parentObj
    end
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    grad.Rotation = rotation
    RegisterElement("Gradients", grad)
    return grad
end

local function UpdateLiveTheme()
    local isSolid = (StarHubUI.Settings.AccentStyle == "Solid")
    local c1 = Theme.Grad1 or Theme.Accent
    local c2 = isSolid and c1 or (Theme.Grad2 or Theme.AccentLight)

    for _, g in ipairs(ThemeRegistry.Gradients) do
        if g and g.Parent then
            if g.Name == "ChasingRingGrad" then
                g.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0.00, c1),
                    ColorSequenceKeypoint.new(0.50, c2),
                    ColorSequenceKeypoint.new(1.00, c1)
                })
            else
                g.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, c1),
                    ColorSequenceKeypoint.new(1, c2)
                })
            end
            if g.Parent:IsA("TextLabel") or g.Parent:IsA("TextButton") then
                g.Parent.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
    end
    for _, item in ipairs(ThemeRegistry.Accents) do
        if item and item.Parent then
            if item:IsA("UIStroke") then
                item.Color = Theme.Accent
            elseif item:IsA("ImageLabel") or item:IsA("ImageButton") then
                item.ImageColor3 = Theme.AccentLight
            elseif item:IsA("TextLabel") or item:IsA("TextButton") then
                if item:FindFirstChildOfClass("UIGradient") then
                    item.TextColor3 = Color3.fromRGB(255, 255, 255)
                else
                    item.TextColor3 = Theme.AccentLight
                end
            elseif item:IsA("Frame") then
                item.BackgroundColor3 = Theme.Accent
            end
        end
    end
    for _, bg in ipairs(ThemeRegistry.Backgrounds) do
        if bg and bg.Parent then bg.BackgroundColor3 = Theme.Background end
    end
    for _, sb in ipairs(ThemeRegistry.Sidebars) do
        if sb and sb.Parent then sb.BackgroundColor3 = Theme.Sidebar end
    end
    for _, bx in ipairs(ThemeRegistry.Boxes) do
        if bx and bx.Parent then bx.BackgroundColor3 = Theme.Box end
    end
    for _, sb in ipairs(ThemeRegistry.SubBoxes) do
        if sb and sb.Parent then sb.BackgroundColor3 = Theme.SubBox end
    end
    for _, st in ipairs(ThemeRegistry.Borders) do
        if st and st.Parent then
            if st:IsA("UIStroke") then
                st.Color = Theme.Border
            elseif st:IsA("Frame") then
                st.BackgroundColor3 = Theme.Border
            end
        end
    end

    pcall(function()
        if StarHubUI.CurrentMainWindow and StarHubUI.CurrentMainWindow.Parent then
            for _, child in ipairs(StarHubUI.CurrentMainWindow:GetDescendants()) do
                if child.Name == "ActiveGlow" and child:IsA("Frame") then
                    child.BackgroundColor3 = Theme.Accent
                    local ag = child:FindFirstChildOfClass("UIGradient")
                    if ag then ag.Color = ColorSequence.new(Theme.Accent) end
                elseif child.Name == "RightIndicator" and child:IsA("ImageLabel") then
                    child.ImageColor3 = Theme.AccentLight
                end
            end
        end
        if StarHubUI.CurrentWindowObj and StarHubUI.CurrentWindowObj.ActiveTab then
            local act = StarHubUI.CurrentWindowObj.ActiveTab
            local btn = act.Button
            if btn then
                local ts = btn:FindFirstChild("TabStroke")
                if ts then ts.Color = Theme.Accent end
                local ib = btn:FindFirstChild("IconBadge")
                if ib then
                    ib.BackgroundColor3 = Theme.Accent
                    local ibs = ib:FindFirstChild("BadgeStroke")
                    if ibs then ibs.Color = Theme.AccentLight end
                end
                local ri = btn:FindFirstChild("RightIndicator")
                if ri then ri.ImageColor3 = Theme.AccentLight end
            end
        end

        for _, fn in ipairs(ThemeRegistry.ModeSelectors) do
            pcall(fn)
        end
    end)
end

local function Tween(obj, duration, props, style, dir)
    style = style or Enum.EasingStyle.Quart
    dir = dir or Enum.EasingDirection.Out
    local tw = TweenService:Create(obj, TweenInfo.new(duration, style, dir), props)
    tw:Play()
    return tw
end

local function MicroBounce(obj)
    local s = obj:FindFirstChildOfClass("UIScale")
    if not s then s = Instance.new("UIScale", obj) end
    Tween(s, 0.08, {Scale = 0.94}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    task.delay(0.08, function()
        Tween(s, 0.2, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end)
end

local BubbleSoundMap = {
    Click     = { id = "rbxassetid://6895079853", pitch = 1.10, vol = 0.32 },
    ToggleOn  = { id = "rbxassetid://6895079853", pitch = 1.40, vol = 0.35 },
    ToggleOff = { id = "rbxassetid://6895079853", pitch = 0.88, vol = 0.28 },
    TabSwitch = { id = "rbxassetid://6895079853", pitch = 1.25, vol = 0.30 },
    Dropdown  = { id = "rbxassetid://6895079853", pitch = 1.00, vol = 0.30 },
    Notify    = { id = "rbxassetid://4590662766", pitch = 1.35, vol = 0.38 }
}

local function PlaySound(name)
    if not StarHubUI.Settings.SoundEnabled then return end
    local conf = BubbleSoundMap[name] or BubbleSoundMap.Click
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = conf.id
        s.Volume = conf.vol * (StarHubUI.Settings.SoundVolume or 0.55)
        s.PlaybackSpeed = conf.pitch
        s.Parent = SoundService
        s.Ended:Connect(function() s:Destroy() end)
        task.delay(1.5, function() if s and s.Parent then s:Destroy() end end)
        s:Play()
    end)
end

local function GetSafeGuiParent()
    local ok, p = pcall(function()
        if type(gethui) == "function" then return gethui() end
        if CoreGui then return CoreGui end
    end)
    return (ok and p) or LocalPlayer:WaitForChild("PlayerGui")
end

local function ColorToHex(col)
    return string.format("#%02x%02x%02x", math.floor(col.R * 255), math.floor(col.G * 255), math.floor(col.B * 255))
end

local function HexToColor(hex)
    if not hex or type(hex) ~= "string" then return nil end
    local clean = hex:gsub("#", ""):gsub("%s+", "")
    if #clean == 6 then
        local r = tonumber(clean:sub(1, 2), 16)
        local g = tonumber(clean:sub(3, 4), 16)
        local b = tonumber(clean:sub(5, 6), 16)
        if r and g and b then
            return Color3.fromRGB(r, g, b)
        end
    end
    return nil
end

local ConfigFileName = "StarHubUI_Config.json"
local autoSaveDebounce = nil

function StarHubUI:SaveConfig()
    pcall(function()
        if writefile then
            local data = {}
            for k, v in pairs(StarHubUI.Settings) do
                data[k] = v
            end
            local json = HttpService:JSONEncode(data)
            writefile(ConfigFileName, json)
        end
    end)
end

function StarHubUI:LoadConfig()
    local loaded = false
    pcall(function()
        if isfile and readfile and isfile(ConfigFileName) then
            local raw = readfile(ConfigFileName)
            if raw and raw ~= "" then
                local data = HttpService:JSONDecode(raw)
                if type(data) == "table" then
                    for k, v in pairs(data) do
                        if StarHubUI.Settings[k] ~= nil then
                            StarHubUI.Settings[k] = v
                        end
                    end
                    loaded = true
                end
            end
        end
    end)

    if loaded then
        pcall(function()
            if StarHubUI.Settings.CurrentTheme and StarHubUI.Themes[StarHubUI.Settings.CurrentTheme] then
                Theme = StarHubUI.Themes[StarHubUI.Settings.CurrentTheme]
            else
                Theme = StarHubUI.Themes.NeverloseCrimson
            end
            if StarHubUI.Settings.CurrentTheme == "Custom" then
                if StarHubUI.Settings.CustomColor1 and StarHubUI.Settings.CustomColor1 ~= "" then
                    local c1 = HexToColor(StarHubUI.Settings.CustomColor1)
                    if c1 then
                        Theme.Accent = c1
                        Theme.Grad1 = c1
                    end
                end
                if StarHubUI.Settings.CustomColor2 and StarHubUI.Settings.CustomColor2 ~= "" then
                    local c2 = HexToColor(StarHubUI.Settings.CustomColor2)
                    if c2 then
                        Theme.AccentLight = c2
                        Theme.Grad2 = c2
                    end
                end
            end
            UpdateLiveTheme()
        end)
    end
    return loaded
end

function StarHubUI:AutoSave()
    if StarHubUI.Settings.AutoSaveEnabled == false then return end
    if autoSaveDebounce then task.cancel(autoSaveDebounce) end
    autoSaveDebounce = task.delay(0.35, function()
        StarHubUI:SaveConfig()
        autoSaveDebounce = nil
    end)
end

StarHubUI:LoadConfig()

local ActiveDiscordNotification = nil

function StarHubUI:Notify(cfg)
    cfg = cfg or {}
    local title = cfg.Title or "NOTIFICATION"
    local desc = cfg.Content or cfg.Description or ""
    local duration = cfg.Duration or 3.5
    local iconId = cfg.Icon or StarHubUI.Icons.Bell or StarHubUI.Icons.Logo or "rbxassetid://10709752996"
    local badgeText = cfg.Badge or "INFO"
    local badgeCol = cfg.BadgeColor or (badgeText == "COPIED" and Color3.fromRGB(34, 197, 94) or Theme.AccentLight)

    PlaySound("Notify")

    if ActiveDiscordNotification and ActiveDiscordNotification.Parent then
        pcall(function() ActiveDiscordNotification:Destroy() end)
        ActiveDiscordNotification = nil
    end

    local targetParent = nil
    local isProtruding = false
    if StarHubUI.CurrentMainWindow and StarHubUI.CurrentMainWindow.Parent and StarHubUI.CurrentMainWindow.Visible then
        targetParent = StarHubUI.CurrentMainWindow
        isProtruding = true
    else
        local host = GetSafeGuiParent():FindFirstChild("StarHubUI_Host")
        targetParent = host or GetSafeGuiParent()
        isProtruding = false
    end

    if not targetParent then return end

    local modal = nil
    pcall(function()
        modal = Instance.new("Frame", targetParent)
        modal.Name = "DiscordNotificationModal"
        modal.AnchorPoint = Vector2.new(0.5, 0)
        modal.Size = UDim2.new(0, 390, 0, 58)
        modal.BackgroundColor3 = Color3.fromRGB(18, 16, 26)
        modal.BackgroundTransparency = 0.05
        modal.ZIndex = 5000
        modal.ClipsDescendants = true
        Instance.new("UICorner", modal).CornerRadius = UDim.new(0, 14)

        local mStroke = Instance.new("UIStroke", modal)
        mStroke.Thickness = 1.4
        mStroke.Color = Theme.BorderLight
        ApplyGradient(mStroke, Theme.Grad1, Theme.Grad2, 45)

        local pGlow = Instance.new("Frame", modal)
        pGlow.Name = "ModalGlow"
        pGlow.Size = UDim2.new(1, 0, 1, 0)
        pGlow.BackgroundColor3 = Theme.Accent
        pGlow.BackgroundTransparency = 0.95
        pGlow.BorderSizePixel = 0
        pGlow.ZIndex = 5000
        Instance.new("UICorner", pGlow).CornerRadius = UDim.new(0, 14)
        RegisterElement("Accents", pGlow)

        local icBadge = Instance.new("Frame", modal)
        icBadge.Size = UDim2.new(0, 36, 0, 36)
        icBadge.Position = UDim2.new(0, 12, 0.5, -18)
        icBadge.BackgroundColor3 = Theme.SubBox
        icBadge.BackgroundTransparency = 0.2
        icBadge.BorderSizePixel = 0
        icBadge.ZIndex = 5001
        Instance.new("UICorner", icBadge).CornerRadius = UDim.new(0, 10)
        local ibStroke = Instance.new("UIStroke", icBadge)
        ibStroke.Color = Theme.Border
        ibStroke.Thickness = 0.8
        ibStroke.Transparency = 0.5

        local icImg = Instance.new("ImageLabel", icBadge)
        icImg.Size = UDim2.new(0, 20, 0, 20)
        icImg.Position = UDim2.new(0.5, -10, 0.5, -10)
        icImg.BackgroundTransparency = 1
        icImg.Image = tostring(iconId)
        icImg.ImageColor3 = Theme.AccentLight
        icImg.ZIndex = 5002
        RegisterElement("Accents", icImg)

        local tL = Instance.new("TextLabel", modal)
        tL.Size = UDim2.new(1, -145, 0, 16)
        tL.Position = UDim2.new(0, 58, 0, 11)
        tL.BackgroundTransparency = 1
        tL.Font = Enum.Font.GothamBold
        tL.TextSize = 11
        tL.TextColor3 = Theme.TextTitle
        tL.TextXAlignment = Enum.TextXAlignment.Left
        tL.TextTruncate = Enum.TextTruncate.AtEnd
        tL.Text = string.upper(title)
        tL.ZIndex = 5001

        local sL = Instance.new("TextLabel", modal)
        sL.Size = UDim2.new(1, -145, 0, 16)
        sL.Position = UDim2.new(0, 58, 0, 29)
        sL.BackgroundTransparency = 1
        sL.Font = Enum.Font.GothamMedium
        sL.TextSize = 9.5
        sL.TextColor3 = Theme.AccentLight
        sL.TextXAlignment = Enum.TextXAlignment.Left
        sL.TextTruncate = Enum.TextTruncate.AtEnd
        sL.Text = desc
        sL.ZIndex = 5001
        RegisterElement("Accents", sL)

        local tag = Instance.new("Frame", modal)
        tag.Size = UDim2.new(0, 64, 0, 22)
        tag.Position = UDim2.new(1, -76, 0.5, -11)
        tag.BackgroundColor3 = badgeCol
        tag.BackgroundTransparency = 0.82
        tag.ZIndex = 5001
        Instance.new("UICorner", tag).CornerRadius = UDim.new(1, 0)
        local tagStroke = Instance.new("UIStroke", tag)
        tagStroke.Color = badgeCol
        tagStroke.Thickness = 0.8
        tagStroke.Transparency = 0.4

        local tagText = Instance.new("TextLabel", tag)
        tagText.Size = UDim2.new(1, 0, 1, 0)
        tagText.BackgroundTransparency = 1
        tagText.Font = Enum.Font.GothamBold
        tagText.TextSize = 8.5
        tagText.TextColor3 = badgeCol
        tagText.Text = string.upper(badgeText)
        tagText.ZIndex = 5002

        local clickBtn = Instance.new("TextButton", modal)
        clickBtn.Size = UDim2.new(1, 0, 1, 0)
        clickBtn.BackgroundTransparency = 1
        clickBtn.Text = ""
        clickBtn.ZIndex = 5005

        ActiveDiscordNotification = modal

        local startY = isProtruding and -75 or -60
        local targetY = isProtruding and -36 or 24
        local exitY = isProtruding and -75 or -60

        modal.Position = UDim2.new(0.5, 0, 0, startY)
        Tween(modal, 0.35, {Position = UDim2.new(0.5, 0, 0, targetY)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

        local isDismissed = false
        local function Dismiss()
            if isDismissed then return end
            isDismissed = true
            pcall(function()
                local tw = Tween(modal, 0.25, {Position = UDim2.new(0.5, 0, 0, exitY), BackgroundTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                tw.Completed:Connect(function()
                    if modal and modal.Parent then modal:Destroy() end
                    if ActiveDiscordNotification == modal then ActiveDiscordNotification = nil end
                end)
            end)
            task.delay(0.28, function()
                if modal and modal.Parent then modal:Destroy() end
                if ActiveDiscordNotification == modal then ActiveDiscordNotification = nil end
            end)
        end

        clickBtn.MouseButton1Click:Connect(Dismiss)
        task.delay(duration, Dismiss)
        task.delay(duration + 0.8, function()
            if modal and modal.Parent then modal:Destroy() end
        end)
    end)
end

function StarHubUI:CreateWindow(cfg)
    cfg = cfg or {}
    local WinTitle = cfg.Title or "StarHub UI"
    local WinSubTitle = cfg.SubTitle or "Minimal Edition"
    local WinSize = cfg.Size or UDim2.new(0, 720, 0, 485)
    local savedKey = nil
    if StarHubUI.Settings.ToggleKey and type(StarHubUI.Settings.ToggleKey) == "string" then
        pcall(function() savedKey = Enum.KeyCode[StarHubUI.Settings.ToggleKey] end)
    end
    local ToggleKey = savedKey or cfg.ToggleKey or Enum.KeyCode.RightControl
    local LogoInput = cfg.Logo or StarHubUI.Settings.CustomLogoUrl or "https://raw.githubusercontent.com/nibamako08-code/xd/main/content.png"
    local ResolvedLogo = LoadCustomImage(LogoInput, StarHubUI.Icons.Logo)

    local GuiParent = GetSafeGuiParent()

    pcall(function()
        local old = GuiParent:FindFirstChild("StarHubUI_Host")
        if old then old:Destroy() end
    end)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "StarHubUI_Host"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = GuiParent

    local MainWindow = Instance.new("Frame", ScreenGui)
    MainWindow.Name = "MainWindow"
    MainWindow.Size = WinSize
    MainWindow.Position = UDim2.new(0.5, -WinSize.X.Offset/2, 0.5, -WinSize.Y.Offset/2)
    MainWindow.BackgroundColor3 = Theme.Background
    MainWindow.BackgroundTransparency = StarHubUI.Settings.WindowTransparency
    MainWindow.BorderSizePixel = 0
    MainWindow.ClipsDescendants = false
    Instance.new("UICorner", MainWindow).CornerRadius = UDim.new(0, 16)
    local MainStroke = Instance.new("UIStroke", MainWindow)
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1.2
    MainStroke.Transparency = 0.2

    RegisterElement("Backgrounds", MainWindow)
    RegisterElement("Borders", MainStroke)
    StarHubUI.CurrentMainWindow = MainWindow

    local winScale = Instance.new("UIScale", MainWindow)

    local function UpdateResponsiveScale()
        local cam = workspace.CurrentCamera
        if not cam then return end
        local vp = cam.ViewportSize
        local isTouch = UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled and UserInputService.MouseEnabled)

        if isTouch or vp.X < 920 or vp.Y < 560 then
            local scaleX = (vp.X * 0.92) / 720
            local scaleY = (vp.Y * 0.90) / 485
            winScale.Scale = math.clamp(math.min(scaleX, scaleY), 0.55, 0.92)
        else
            winScale.Scale = 1.0
        end
    end

    UpdateResponsiveScale()
    pcall(function()
        if workspace.CurrentCamera then
            workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateResponsiveScale)
        end
    end)

    local CustomWallpaper = Instance.new("ImageLabel", MainWindow)
    CustomWallpaper.Size = UDim2.new(1, 0, 1, 0)
    CustomWallpaper.BackgroundTransparency = 1
    CustomWallpaper.ScaleType = Enum.ScaleType.Crop
    CustomWallpaper.ImageTransparency = StarHubUI.Settings.WallpaperTransparency
    CustomWallpaper.ImageColor3 = Color3.fromRGB(
        math.floor(255 * (1 - StarHubUI.Settings.WallpaperDimming)),
        math.floor(255 * (1 - StarHubUI.Settings.WallpaperDimming)),
        math.floor(255 * (1 - StarHubUI.Settings.WallpaperDimming))
    )
    CustomWallpaper.ZIndex = 0
    Instance.new("UICorner", CustomWallpaper).CornerRadius = UDim.new(0, 16)

    local FxCanvas = Instance.new("Frame", MainWindow)
    FxCanvas.Name = "FxCanvas"
    FxCanvas.Size = UDim2.new(1, 0, 1, 0)
    FxCanvas.BackgroundTransparency = 1
    FxCanvas.ClipsDescendants = true
    FxCanvas.ZIndex = 0
    Instance.new("UICorner", FxCanvas).CornerRadius = UDim.new(0, 16)

    local NebulaCanvas = Instance.new("Frame", FxCanvas)
    NebulaCanvas.Name = "NebulaCanvas"
    NebulaCanvas.Size = UDim2.new(1, 0, 1, 0)
    NebulaCanvas.BackgroundTransparency = 1
    NebulaCanvas.ZIndex = 0
    NebulaCanvas.Visible = (StarHubUI.Settings.BackgroundEffect == "Subtle Ambient Glow")

    local NebulaGlow1 = Instance.new("Frame", NebulaCanvas)
    NebulaGlow1.Name = "NebulaGlow1"
    NebulaGlow1.AnchorPoint = Vector2.new(0.5, 0.5)
    NebulaGlow1.Position = UDim2.new(0.72, 0, 0.35, 0)
    NebulaGlow1.Size = UDim2.new(0.65, 0, 0.65, 0)
    NebulaGlow1.BackgroundColor3 = Theme.Accent
    NebulaGlow1.BackgroundTransparency = 0.96
    NebulaGlow1.BorderSizePixel = 0
    NebulaGlow1.ZIndex = 0
    Instance.new("UICorner", NebulaGlow1).CornerRadius = UDim.new(1, 0)
    RegisterElement("Accents", NebulaGlow1)

    local NebulaGlow2 = Instance.new("Frame", NebulaCanvas)
    NebulaGlow2.Name = "NebulaGlow2"
    NebulaGlow2.AnchorPoint = Vector2.new(0.5, 0.5)
    NebulaGlow2.Position = UDim2.new(0.28, 0, 0.70, 0)
    NebulaGlow2.Size = UDim2.new(0.55, 0, 0.55, 0)
    NebulaGlow2.BackgroundColor3 = Theme.AccentLight
    NebulaGlow2.BackgroundTransparency = 0.97
    NebulaGlow2.BorderSizePixel = 0
    NebulaGlow2.ZIndex = 0
    Instance.new("UICorner", NebulaGlow2).CornerRadius = UDim.new(1, 0)
    RegisterElement("Accents", NebulaGlow2)

    local BubbleCanvas = Instance.new("Frame", FxCanvas)
    BubbleCanvas.Name = "BubbleCanvas"
    BubbleCanvas.Size = UDim2.new(1, 0, 1, 0)
    BubbleCanvas.BackgroundTransparency = 1
    BubbleCanvas.ZIndex = 0
    BubbleCanvas.Visible = (StarHubUI.Settings.BackgroundEffect == "Floating Bubbles")

    local bubbles = {}
    for i = 1, 16 do
        local sz = math.random(14, 38)
        local b = Instance.new("Frame", BubbleCanvas)
        b.Name = "Bubble_" .. i
        b.Size = UDim2.new(0, sz, 0, sz)
        b.AnchorPoint = Vector2.new(0.5, 0.5)
        local startX = math.random(4, 96) / 100
        local startY = math.random(5, 105) / 100
        b.Position = UDim2.new(startX, 0, startY, 0)
        b.BackgroundColor3 = Theme.AccentLight
        b.BackgroundTransparency = math.random(88, 94) / 100
        b.BorderSizePixel = 0
        b.ZIndex = 0
        Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)

        local bStroke = Instance.new("UIStroke", b)
        bStroke.Color = Theme.AccentLight
        bStroke.Thickness = 1
        bStroke.Transparency = 0.82

        local bGloss = Instance.new("Frame", b)
        bGloss.Size = UDim2.new(0.35, 0, 0.35, 0)
        bGloss.Position = UDim2.new(0.2, 0, 0.15, 0)
        bGloss.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        bGloss.BackgroundTransparency = 0.65
        bGloss.BorderSizePixel = 0
        bGloss.ZIndex = 0
        Instance.new("UICorner", bGloss).CornerRadius = UDim.new(1, 0)

        RegisterElement("Accents", b)
        RegisterElement("Accents", bStroke)

        table.insert(bubbles, {
            Obj = b,
            Speed = math.random(18, 36) / 100,
            BaseX = startX,
            Phase = math.random() * math.pi * 2,
            SwayFreq = math.random(12, 25) / 10,
            SwayAmp = math.random(8, 20) / 1000
        })
    end

    local MatrixCanvas = Instance.new("Frame", FxCanvas)
    MatrixCanvas.Name = "MatrixCanvas"
    MatrixCanvas.Size = UDim2.new(1, 0, 1, 0)
    MatrixCanvas.BackgroundTransparency = 1
    MatrixCanvas.ZIndex = 0
    MatrixCanvas.Visible = (StarHubUI.Settings.BackgroundEffect == "Matrix Cyber Rain")

    local matrixChars = {"0", "1", "X", "Z", "7", "4", "A", "F", "9", "3", "#", "*", "+", "§", "%", "0", "1"}
    local matrixDrops = {}
    for i = 1, 16 do
        local colX = (i - 0.5) / 16
        local startY = math.random(0, 100) / 100
        local lbl = Instance.new("TextLabel", MatrixCanvas)
        lbl.Name = "MatrixDrop_" .. i
        lbl.Size = UDim2.new(0, 16, 0, 16)
        lbl.AnchorPoint = Vector2.new(0.5, 0.5)
        lbl.Position = UDim2.new(colX, 0, startY, 0)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.Code
        lbl.TextSize = 11.5
        lbl.TextColor3 = Theme.AccentLight
        lbl.TextTransparency = math.random(25, 75) / 100
        lbl.Text = matrixChars[math.random(1, #matrixChars)]
        lbl.ZIndex = 0
        RegisterElement("Accents", lbl)

        table.insert(matrixDrops, {
            Obj = lbl,
            Speed = math.random(14, 38) / 100,
            NextCharTime = tick() + math.random(10, 40) / 100
        })
    end

    local FireflyCanvas = Instance.new("Frame", FxCanvas)
    FireflyCanvas.Name = "FireflyCanvas"
    FireflyCanvas.Size = UDim2.new(1, 0, 1, 0)
    FireflyCanvas.BackgroundTransparency = 1
    FireflyCanvas.ZIndex = 0
    FireflyCanvas.Visible = (StarHubUI.Settings.BackgroundEffect == "Starlight Fireflies")

    local fireflies = {}
    for i = 1, 18 do
        local sz = math.random(5, 10)
        local f = Instance.new("Frame", FireflyCanvas)
        f.Name = "Firefly_" .. i
        f.Size = UDim2.new(0, sz, 0, sz)
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        local startX = math.random(5, 95) / 100
        local startY = math.random(8, 92) / 100
        f.Position = UDim2.new(startX, 0, startY, 0)
        f.BackgroundColor3 = Theme.AccentLight
        f.BackgroundTransparency = math.random(30, 70) / 100
        f.BorderSizePixel = 0
        f.ZIndex = 0
        Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)

        local fStroke = Instance.new("UIStroke", f)
        fStroke.Color = Color3.fromRGB(255, 255, 255)
        fStroke.Thickness = 0.8
        fStroke.Transparency = 0.55

        RegisterElement("Accents", f)

        table.insert(fireflies, {
            Obj = f,
            BaseX = startX,
            BaseY = startY,
            FreqX = math.random(4, 12) / 10,
            FreqY = math.random(5, 14) / 10,
            AmpX = math.random(25, 65) / 1000,
            AmpY = math.random(25, 65) / 1000,
            Phase = math.random() * math.pi * 2,
            PulseSpeed = math.random(15, 30) / 10,
            BaseTrans = math.random(30, 60) / 100
        })
    end

    local EmberCanvas = Instance.new("Frame", FxCanvas)
    EmberCanvas.Name = "EmberCanvas"
    EmberCanvas.Size = UDim2.new(1, 0, 1, 0)
    EmberCanvas.BackgroundTransparency = 1
    EmberCanvas.ZIndex = 0
    EmberCanvas.Visible = (StarHubUI.Settings.BackgroundEffect == "Fire Embers")

    local embers = {}
    for i = 1, 18 do
        local sz = math.random(4, 8)
        local e = Instance.new("Frame", EmberCanvas)
        e.Name = "Ember_" .. i
        e.Size = UDim2.new(0, sz, 0, sz)
        e.AnchorPoint = Vector2.new(0.5, 0.5)
        local startX = math.random(4, 96) / 100
        local startY = math.random(10, 105) / 100
        e.Position = UDim2.new(startX, 0, startY, 0)
        e.BackgroundColor3 = Color3.fromRGB(255, math.random(120, 200), 50)
        e.BackgroundTransparency = math.random(30, 65) / 100
        e.BorderSizePixel = 0
        e.ZIndex = 0
        Instance.new("UICorner", e).CornerRadius = UDim.new(1, 0)

        table.insert(embers, {
            Obj = e,
            Speed = math.random(25, 55) / 100,
            BaseX = startX,
            JitterFreq = math.random(18, 36) / 10,
            JitterAmp = math.random(6, 16) / 1000,
            Phase = math.random() * math.pi * 2
        })
    end

    local SnowCanvas = Instance.new("Frame", FxCanvas)
    SnowCanvas.Name = "SnowCanvas"
    SnowCanvas.Size = UDim2.new(1, 0, 1, 0)
    SnowCanvas.BackgroundTransparency = 1
    SnowCanvas.ZIndex = 0
    SnowCanvas.Visible = (StarHubUI.Settings.BackgroundEffect == "Snowfall Drift")

    local snowflakes = {}
    for i = 1, 20 do
        local sz = math.random(3, 7)
        local s = Instance.new("Frame", SnowCanvas)
        s.Name = "Snowflake_" .. i
        s.Size = UDim2.new(0, sz, 0, sz)
        s.AnchorPoint = Vector2.new(0.5, 0.5)
        local startX = math.random(2, 98) / 100
        local startY = math.random(-5, 95) / 100
        s.Position = UDim2.new(startX, 0, startY, 0)
        s.BackgroundColor3 = Color3.fromRGB(240, 245, 255)
        s.BackgroundTransparency = math.random(35, 75) / 100
        s.BorderSizePixel = 0
        s.ZIndex = 0
        Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)

        table.insert(snowflakes, {
            Obj = s,
            Speed = math.random(12, 28) / 100,
            BaseX = startX,
            DriftFreq = math.random(8, 18) / 10,
            DriftAmp = math.random(10, 25) / 1000,
            Phase = math.random() * math.pi * 2
        })
    end

    RunService.RenderStepped:Connect(function(dt)
        if not MainWindow.Visible then return end
        local currentMode = StarHubUI.Settings.BackgroundEffect or "Floating Bubbles"
        if currentMode == "Off (Clean Minimal)" or currentMode == "Off" then return end

        local t = tick()
        local h = MainWindow.AbsoluteSize.Y
        if h <= 0 then h = 485 end

        if NebulaCanvas.Visible then
            NebulaGlow1.BackgroundTransparency = 0.96 + math.sin(t * 1.2) * 0.015
            NebulaGlow2.BackgroundTransparency = 0.97 + math.cos(t * 0.9) * 0.015
        end

        if BubbleCanvas.Visible then
            for _, bData in ipairs(bubbles) do
                local curPos = bData.Obj.Position
                local newY = curPos.Y.Scale - (bData.Speed / h)
                local newX = bData.BaseX + math.sin(t * bData.SwayFreq + bData.Phase) * bData.SwayAmp
                if newY < -0.08 then
                    newY = 1.05
                    bData.BaseX = math.random(4, 96) / 100
                    bData.Obj.BackgroundTransparency = math.random(88, 94) / 100
                end
                bData.Obj.Position = UDim2.new(newX, 0, newY, 0)
            end
        elseif MatrixCanvas.Visible then
            for _, mData in ipairs(matrixDrops) do
                local curPos = mData.Obj.Position
                local newY = curPos.Y.Scale + (mData.Speed / h)
                if newY > 1.06 then
                    newY = -0.06
                    mData.Obj.Text = matrixChars[math.random(1, #matrixChars)]
                    mData.Obj.TextTransparency = math.random(25, 75) / 100
                end
                if t >= mData.NextCharTime then
                    mData.Obj.Text = matrixChars[math.random(1, #matrixChars)]
                    mData.NextCharTime = t + math.random(15, 50) / 100
                end
                mData.Obj.Position = UDim2.new(curPos.X.Scale, 0, newY, 0)
            end
        elseif FireflyCanvas.Visible then
            for _, fData in ipairs(fireflies) do
                local x = fData.BaseX + math.sin(t * fData.FreqX + fData.Phase) * fData.AmpX
                local y = fData.BaseY + math.cos(t * fData.FreqY + fData.Phase) * fData.AmpY
                fData.Obj.Position = UDim2.new(x, 0, y, 0)
                fData.Obj.BackgroundTransparency = fData.BaseTrans + math.sin(t * fData.PulseSpeed + fData.Phase) * 0.22
            end
        elseif EmberCanvas.Visible then
            for _, eData in ipairs(embers) do
                local curPos = eData.Obj.Position
                local newY = curPos.Y.Scale - (eData.Speed / h)
                local newX = eData.BaseX + math.sin(t * eData.JitterFreq + eData.Phase) * eData.JitterAmp
                if newY < -0.06 then
                    newY = 1.05
                    eData.BaseX = math.random(4, 96) / 100
                    eData.Obj.BackgroundTransparency = math.random(30, 65) / 100
                end
                eData.Obj.Position = UDim2.new(newX, 0, newY, 0)
            end
        elseif SnowCanvas.Visible then
            for _, sData in ipairs(snowflakes) do
                local curPos = sData.Obj.Position
                local newY = curPos.Y.Scale + (sData.Speed / h)
                local newX = sData.BaseX + math.sin(t * sData.DriftFreq + sData.Phase) * sData.DriftAmp
                if newY > 1.06 then
                    newY = -0.06
                    sData.BaseX = math.random(2, 98) / 100
                end
                sData.Obj.Position = UDim2.new(newX, 0, newY, 0)
            end
        end
    end)

    local function SetBackgroundEffect(mode)
        StarHubUI.Settings.BackgroundEffect = mode
        NebulaCanvas.Visible = false
        BubbleCanvas.Visible = false
        MatrixCanvas.Visible = false
        FireflyCanvas.Visible = false
        EmberCanvas.Visible = false
        SnowCanvas.Visible = false

        if mode == "Off (Clean Minimal)" or mode == "Off" then
        elseif mode == "Subtle Ambient Glow" then
            NebulaCanvas.Visible = true
        elseif mode == "Matrix Cyber Rain" then
            MatrixCanvas.Visible = true
        elseif mode == "Starlight Fireflies" then
            FireflyCanvas.Visible = true
        elseif mode == "Fire Embers" then
            EmberCanvas.Visible = true
        elseif mode == "Snowfall Drift" then
            SnowCanvas.Visible = true
        else
            BubbleCanvas.Visible = true
        end
    end

    SetBackgroundEffect(StarHubUI.Settings.BackgroundEffect or "Floating Bubbles")

    local function ApplyGlobalFont(fontName)
        StarHubUI.Settings.FontFamily = fontName
        local fontMap = {
            ["Gotham"] = { Reg = Enum.Font.Gotham, Med = Enum.Font.GothamMedium, Bold = Enum.Font.GothamBold },
            ["Roboto"] = { Reg = Enum.Font.Roboto, Med = Enum.Font.RobotoMedium, Bold = Enum.Font.RobotoBold },
            ["SourceSans"] = { Reg = Enum.Font.SourceSans, Med = Enum.Font.SourceSansSemibold, Bold = Enum.Font.SourceSansBold },
            ["Ubuntu"] = { Reg = Enum.Font.Ubuntu, Med = Enum.Font.UbuntuMedium, Bold = Enum.Font.UbuntuBold },
            ["Arial"] = { Reg = Enum.Font.Arial, Med = Enum.Font.ArialBold, Bold = Enum.Font.ArialBold },
            ["FredokaOne"] = { Reg = Enum.Font.FredokaOne, Med = Enum.Font.FredokaOne, Bold = Enum.Font.FredokaOne },
        }
        local entry = fontMap[fontName] or fontMap["Gotham"]
        for _, desc in ipairs(MainWindow:GetDescendants()) do
            if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
                local f = desc.Font
                if f == Enum.Font.GothamBold or f == Enum.Font.RobotoBold or f == Enum.Font.SourceSansBold or f == Enum.Font.UbuntuBold or f == Enum.Font.ArialBold or f == Enum.Font.FredokaOne then
                    desc.Font = entry.Bold
                elseif f == Enum.Font.GothamMedium or f == Enum.Font.RobotoMedium or f == Enum.Font.SourceSansSemibold or f == Enum.Font.UbuntuMedium then
                    desc.Font = entry.Med
                else
                    desc.Font = entry.Reg
                end
            end
        end
    end

    local function AttachDrag(handle)
        local dragging = false
        local dragInput, dragStart, startPos
        handle.InputBegan:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = inp.Position
                startPos = MainWindow.Position
                inp.Changed:Connect(function()
                    if inp.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        handle.InputChanged:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
                dragInput = inp
            end
        end)
        UserInputService.InputChanged:Connect(function(inp)
            if inp == dragInput and dragging then
                local delta = inp.Position - dragStart
                Tween(MainWindow, 0.04, {
                    Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                }, Enum.EasingStyle.Linear)
            end
        end)
    end

    local BodyContainer = nil
    local Header = Instance.new("Frame", MainWindow)
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 44)
    Header.BackgroundTransparency = 1
    AttachDrag(Header)

    local HeaderLine = Instance.new("Frame", Header)
    HeaderLine.Size = UDim2.new(1, 0, 0, 1)
    HeaderLine.Position = UDim2.new(0, 0, 1, -1)
    HeaderLine.BackgroundColor3 = Theme.Border
    HeaderLine.BorderSizePixel = 0
    RegisterElement("Borders", HeaderLine)

    local TrafficContainer = Instance.new("Frame", Header)
    TrafficContainer.Name = "TrafficContainer"
    TrafficContainer.Size = UDim2.new(0, 60, 1, 0)
    TrafficContainer.Position = UDim2.new(0, 14, 0, 0)
    TrafficContainer.BackgroundTransparency = 1
    local tcLayout = Instance.new("UIListLayout", TrafficContainer)
    tcLayout.FillDirection = Enum.FillDirection.Horizontal
    tcLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    tcLayout.Padding = UDim.new(0, 7)

    local function MakeTrafficDot(col, hovCol, fn)
        local d = Instance.new("TextButton", TrafficContainer)
        d.Size = UDim2.new(0, 12, 0, 12)
        d.BackgroundColor3 = col
        d.Text = ""
        d.AutoButtonColor = false
        Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
        local s = Instance.new("UIStroke", d)
        s.Color = hovCol
        s.Thickness = 0.5
        s.Transparency = 0.4

        d.MouseEnter:Connect(function() Tween(d, 0.15, {BackgroundColor3 = hovCol}) end)
        d.MouseLeave:Connect(function() Tween(d, 0.15, {BackgroundColor3 = col}) end)
        d.MouseButton1Click:Connect(function()
            PlaySound("Click")
            MicroBounce(d)
            fn()
        end)
        return d
    end

    local isMinimized = false
    local UpdateFloatingToggleVisual = nil

    local function ToggleMainWindow(show)
        if show == nil then show = not MainWindow.Visible end
        if show then
            MainWindow.Visible = true
            winScale.Scale = 0.8
            MainWindow.Position = UDim2.new(0.5, -WinSize.X.Offset/2, 0.5, -WinSize.Y.Offset/2)
            MainWindow.Size = isMinimized and UDim2.new(0, WinSize.X.Offset, 0, 44) or WinSize
            if isMinimized then
                HeaderLine.Visible = false
                MainWindow.ClipsDescendants = true
            else
                HeaderLine.Visible = true
                MainWindow.ClipsDescendants = false
                if BodyContainer then BodyContainer.Visible = true end
            end
            PlaySound("ToggleOn")
            Tween(winScale, 0.35, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        else
            PlaySound("ToggleOff")
            local tw = Tween(winScale, 0.22, {Scale = 0.8}, Enum.EasingStyle.Back, Enum.EasingDirection.In)
            tw.Completed:Connect(function()
                if not MainWindow.Visible or winScale.Scale <= 0.85 then
                    MainWindow.Visible = false
                    winScale.Scale = 1
                end
            end)
            task.delay(0.24, function()
                if not MainWindow.Visible or winScale.Scale <= 0.85 then
                    MainWindow.Visible = false
                    winScale.Scale = 1
                end
            end)
        end
        if UpdateFloatingToggleVisual then
            pcall(UpdateFloatingToggleVisual)
        end
    end

    MakeTrafficDot(Color3.fromRGB(255, 95, 87), Color3.fromRGB(255, 130, 120), function()
        ToggleMainWindow(false)
    end)

    MakeTrafficDot(Color3.fromRGB(254, 188, 46), Color3.fromRGB(255, 215, 80), function()
        isMinimized = not isMinimized
        PlaySound(isMinimized and "ToggleOff" or "ToggleOn")
        if isMinimized then
            if BodyContainer then BodyContainer.Visible = false end
            HeaderLine.Visible = false
            MainWindow.ClipsDescendants = true
            Tween(MainWindow, 0.25, {Size = UDim2.new(0, WinSize.X.Offset, 0, 44)}, Enum.EasingStyle.Quart)
        else
            MainWindow.ClipsDescendants = false
            HeaderLine.Visible = true
            Tween(MainWindow, 0.3, {Size = UDim2.new(0, WinSize.X.Offset, 0, WinSize.Y.Offset)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            task.delay(0.05, function()
                if not isMinimized and BodyContainer then BodyContainer.Visible = true end
            end)
        end
    end)

    MakeTrafficDot(Color3.fromRGB(39, 201, 63), Color3.fromRGB(75, 235, 100), function()
        PlaySound("Click")
        Tween(MainWindow, 0.32, {Position = UDim2.new(0.5, -WinSize.X.Offset/2, 0.5, -WinSize.Y.Offset/2)}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end)

    local sep1 = Instance.new("Frame", Header)
    sep1.Size = UDim2.new(0, 1, 0, 16)
    sep1.Position = UDim2.new(0, 84, 0.5, -8)
    sep1.BackgroundColor3 = Theme.Border
    sep1.BorderSizePixel = 0
    sep1.Visible = false
    RegisterElement("Borders", sep1)

    local TitleLabel = Instance.new("TextLabel", Header)
    TitleLabel.AutomaticSize = Enum.AutomaticSize.X
    TitleLabel.Size = UDim2.new(0, 0, 0, 16)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 13
    TitleLabel.TextColor3 = Theme.TextTitle
    TitleLabel.Text = WinTitle

    local SubLabel = Instance.new("TextLabel", Header)
    SubLabel.AutomaticSize = Enum.AutomaticSize.X
    SubLabel.Size = UDim2.new(0, 0, 0, 12)
    SubLabel.BackgroundTransparency = 1
    SubLabel.Font = Enum.Font.Gotham
    SubLabel.TextSize = 9.5
    SubLabel.TextColor3 = Theme.TextDim
    SubLabel.Text = WinSubTitle

    local function SetControlsPosition(pos)
        StarHubUI.Settings.ControlsPosition = pos
        sep1.Visible = false
        if pos == "Right" then
            TrafficContainer.Position = UDim2.new(1, -78, 0, 0)
            TitleLabel.AnchorPoint = Vector2.new(0, 0)
            TitleLabel.Position = UDim2.new(0, 18, 0, 8)
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            SubLabel.AnchorPoint = Vector2.new(0, 0)
            SubLabel.Position = UDim2.new(0, 18, 0, 24)
            SubLabel.TextXAlignment = Enum.TextXAlignment.Left
        else
            TrafficContainer.Position = UDim2.new(0, 14, 0, 0)
            TitleLabel.AnchorPoint = Vector2.new(1, 0)
            TitleLabel.Position = UDim2.new(1, -18, 0, 8)
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Right
            SubLabel.AnchorPoint = Vector2.new(1, 0)
            SubLabel.Position = UDim2.new(1, -18, 0, 24)
            SubLabel.TextXAlignment = Enum.TextXAlignment.Right
        end
    end
    SetControlsPosition(StarHubUI.Settings.ControlsPosition)

    BodyContainer = Instance.new("Frame", MainWindow)
    BodyContainer.Name = "BodyContainer"
    BodyContainer.Size = UDim2.new(1, 0, 1, -44)
    BodyContainer.Position = UDim2.new(0, 0, 0, 44)
    BodyContainer.BackgroundTransparency = 1

    local Sidebar = Instance.new("Frame", BodyContainer)
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 175, 1, 0)
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 16)
    RegisterElement("Sidebars", Sidebar)

    local SideLine = Instance.new("Frame", Sidebar)
    SideLine.Size = UDim2.new(0, 1, 1, 0)
    SideLine.Position = UDim2.new(1, -1, 0, 0)
    SideLine.BackgroundColor3 = Theme.Border
    SideLine.BorderSizePixel = 0
    RegisterElement("Borders", SideLine)

    local LogoHolder = Instance.new("Frame", Sidebar)
    LogoHolder.Size = UDim2.new(1, 0, 0, 94)
    LogoHolder.Position = UDim2.new(0, 0, 0, 6)
    LogoHolder.BackgroundTransparency = 1

    local BrandSquircle = Instance.new("TextButton", LogoHolder)
    BrandSquircle.Size = UDim2.new(0, 74, 0, 74)
    BrandSquircle.Position = UDim2.new(0.5, -37, 0.5, -37)
    BrandSquircle.BackgroundColor3 = Theme.Box
    BrandSquircle.Text = ""
    BrandSquircle.AutoButtonColor = false
    Instance.new("UICorner", BrandSquircle).CornerRadius = UDim.new(0, 20)
    local bsStroke = Instance.new("UIStroke", BrandSquircle)
    bsStroke.Thickness = 1.6
    ApplyGradient(bsStroke, Theme.Grad1, Theme.Grad2, 45)
    RegisterElement("Boxes", BrandSquircle)
    RegisterElement("Borders", bsStroke)

    local BrandIcon = Instance.new("ImageLabel", BrandSquircle)
    BrandIcon.Size = UDim2.new(0, 62, 0, 62)
    BrandIcon.Position = UDim2.new(0.5, -31, 0.5, -31)
    BrandIcon.BackgroundTransparency = 1
    BrandIcon.ScaleType = Enum.ScaleType.Fit
    BrandIcon.Image = ResolvedLogo
    BrandIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

    BrandSquircle.MouseEnter:Connect(function()
        Tween(BrandSquircle, 0.15, {Size = UDim2.new(0, 80, 0, 80), Position = UDim2.new(0.5, -40, 0.5, -40)})
    end)
    BrandSquircle.MouseLeave:Connect(function()
        Tween(BrandSquircle, 0.15, {Size = UDim2.new(0, 74, 0, 74), Position = UDim2.new(0.5, -37, 0.5, -37)})
    end)
    BrandSquircle.MouseButton1Click:Connect(function()
        MicroBounce(BrandSquircle)
        PlaySound("Click")
    end)

    local SearchBox = Instance.new("Frame", Sidebar)
    SearchBox.Size = UDim2.new(1, -16, 0, 28)
    SearchBox.Position = UDim2.new(0, 8, 0, 104)
    SearchBox.BackgroundColor3 = Theme.Box
    Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 9)
    local sStroke = Instance.new("UIStroke", SearchBox)
    sStroke.Color = Theme.Border
    RegisterElement("Boxes", SearchBox)
    RegisterElement("Borders", sStroke)

    local sIcon = Instance.new("ImageLabel", SearchBox)
    sIcon.Size = UDim2.new(0, 13, 0, 13)
    sIcon.Position = UDim2.new(0, 8, 0.5, -6.5)
    sIcon.BackgroundTransparency = 1
    sIcon.Image = StarHubUI.Icons.Search
    sIcon.ImageColor3 = Theme.TextMuted

    local SearchInput = Instance.new("TextBox", SearchBox)
    SearchInput.Size = UDim2.new(1, -44, 1, 0)
    SearchInput.Position = UDim2.new(0, 26, 0, 0)
    SearchInput.BackgroundTransparency = 1
    SearchInput.Font = Enum.Font.Gotham
    SearchInput.TextSize = 10.5
    SearchInput.TextColor3 = Theme.TextTitle
    SearchInput.PlaceholderColor3 = Theme.TextMuted
    SearchInput.PlaceholderText = "Search..."
    SearchInput.ClearTextOnFocus = false
    SearchInput.Text = ""

    local sClear = Instance.new("TextButton", SearchBox)
    sClear.Size = UDim2.new(0, 16, 0, 16)
    sClear.Position = UDim2.new(1, -20, 0.5, -8)
    sClear.BackgroundTransparency = 1
    sClear.Text = "X"
    sClear.Font = Enum.Font.GothamBold
    sClear.TextSize = 9
    sClear.TextColor3 = Theme.TextMuted
    sClear.Visible = false

    sClear.MouseButton1Click:Connect(function()
        SearchInput.Text = ""
        sClear.Visible = false
    end)

    local NavScroll = Instance.new("ScrollingFrame", Sidebar)
    NavScroll.Name = "NavScroll"
    NavScroll.Size = UDim2.new(1, -8, 1, -146)
    NavScroll.Position = UDim2.new(0, 4, 0, 140)
    NavScroll.BackgroundTransparency = 1
    NavScroll.BorderSizePixel = 0
    NavScroll.ScrollBarThickness = 2
    NavScroll.ScrollBarImageColor3 = Theme.Border
    NavScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    NavScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

    local navLayout = Instance.new("UIListLayout", NavScroll)
    navLayout.SortOrder = Enum.SortOrder.LayoutOrder
    navLayout.Padding = UDim.new(0, 4)

    local navPad = Instance.new("UIPadding", NavScroll)
    navPad.PaddingLeft = UDim.new(0, 4)
    navPad.PaddingRight = UDim.new(0, 4)
    navPad.PaddingTop = UDim.new(0, 4)
    navPad.PaddingBottom = UDim.new(0, 12)

    local ContentArea = Instance.new("Frame", BodyContainer)
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -175, 1, 0)
    ContentArea.Position = UDim2.new(0, 175, 0, 0)
    ContentArea.BackgroundTransparency = 1

    local FloatingSquircle = Instance.new("Frame", ScreenGui)
    FloatingSquircle.Name = "StarHubUI_FloatingSquircle"
    FloatingSquircle.Size = UDim2.new(0, 52, 0, 52)
    FloatingSquircle.Position = UDim2.new(0, 20, 0.45, 0)
    FloatingSquircle.BackgroundColor3 = Color3.fromRGB(12, 13, 17)
    FloatingSquircle.BackgroundTransparency = 0.05
    FloatingSquircle.Visible = StarHubUI.Settings.ShowFloatingToggle
    Instance.new("UICorner", FloatingSquircle).CornerRadius = UDim.new(1, 0)

    local flScale = Instance.new("UIScale", FloatingSquircle)
    flScale.Scale = 1

    local flCircleStroke = Instance.new("UIStroke", FloatingSquircle)
    flCircleStroke.Color = Color3.fromRGB(255, 255, 255)
    flCircleStroke.Thickness = 3.6
    flCircleStroke.Transparency = 0

    local flGrad = Instance.new("UIGradient", flCircleStroke)
    flGrad.Name = "ChasingRingGrad"
    local c1 = Theme.Grad1 or Theme.Accent
    local c2 = Theme.Grad2 or Theme.AccentLight
    flGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, c1),
        ColorSequenceKeypoint.new(0.50, c2),
        ColorSequenceKeypoint.new(1.00, c1)
    })
    flGrad.Rotation = 0
    RegisterElement("Gradients", flGrad)

    RegisterElement("Boxes", FloatingSquircle)

    local flAura = Instance.new("Frame", FloatingSquircle)
    flAura.Name = "AuraGlow"
    flAura.AnchorPoint = Vector2.new(0.5, 0.5)
    flAura.Position = UDim2.new(0.5, 0, 0.5, 0)
    flAura.Size = UDim2.new(1, 10, 1, 10)
    flAura.BackgroundColor3 = Theme.Accent
    flAura.BackgroundTransparency = 0.88
    flAura.BorderSizePixel = 0
    flAura.ZIndex = 0
    Instance.new("UICorner", flAura).CornerRadius = UDim.new(1, 0)
    RegisterElement("Accents", flAura)

    task.spawn(function()
        while FloatingSquircle and FloatingSquircle.Parent do
            Tween(flAura, 1.4, {Size = UDim2.new(1, 16, 1, 16), BackgroundTransparency = 0.82}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.4)
            if not FloatingSquircle or not FloatingSquircle.Parent then break end
            Tween(flAura, 1.4, {Size = UDim2.new(1, 8, 1, 8), BackgroundTransparency = 0.94}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            task.wait(1.4)
        end
    end)

    local flLogoGlow = Instance.new("Frame", FloatingSquircle)
    flLogoGlow.Name = "LogoUnderglow"
    flLogoGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    flLogoGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    flLogoGlow.Size = UDim2.new(0, 30, 0, 30)
    flLogoGlow.BackgroundColor3 = Theme.Accent
    flLogoGlow.BackgroundTransparency = 0.75
    flLogoGlow.BorderSizePixel = 0
    flLogoGlow.ZIndex = 3
    Instance.new("UICorner", flLogoGlow).CornerRadius = UDim.new(1, 0)
    RegisterElement("Accents", flLogoGlow)

    local flIconShadow = Instance.new("ImageLabel", FloatingSquircle)
    flIconShadow.Name = "IconShadow"
    flIconShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    flIconShadow.Size = UDim2.new(0, 28, 0, 28)
    flIconShadow.Position = UDim2.new(0.5, 1, 0.5, 2)
    flIconShadow.BackgroundTransparency = 1
    flIconShadow.ScaleType = Enum.ScaleType.Fit
    flIconShadow.Image = ResolvedLogo
    flIconShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    flIconShadow.ImageTransparency = 0.6
    flIconShadow.ZIndex = 5

    local flIcon = Instance.new("ImageLabel", FloatingSquircle)
    flIcon.Name = "MainLogo"
    flIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    flIcon.Size = UDim2.new(0, 28, 0, 28)
    flIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    flIcon.BackgroundTransparency = 1
    flIcon.ScaleType = Enum.ScaleType.Fit
    flIcon.Image = ResolvedLogo
    flIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    flIcon.Rotation = 0
    flIcon.ZIndex = 10
    local flIconScale = Instance.new("UIScale", flIcon)

    RunService.RenderStepped:Connect(function()
        if flGrad and flGrad.Parent then
            flGrad.Rotation = (tick() * 120) % 360
        end
    end)

    AttachDrag(FloatingSquircle)

    local flBtn = Instance.new("TextButton", FloatingSquircle)
    flBtn.Name = "HitboxButton"
    flBtn.Size = UDim2.new(1, 0, 1, 0)
    flBtn.BackgroundTransparency = 1
    flBtn.Text = ""
    flBtn.ZIndex = 25

    UpdateFloatingToggleVisual = function()
        if not FloatingSquircle or not FloatingSquircle.Parent then return end
        local isOpen = MainWindow and MainWindow.Visible
        if isOpen then
            Tween(flCircleStroke, 0.25, {Thickness = 3.6, Transparency = 0})
            Tween(flAura, 0.25, {BackgroundTransparency = 0.80})
            Tween(flLogoGlow, 0.25, {BackgroundTransparency = 0.65})
        else
            Tween(flCircleStroke, 0.25, {Thickness = 3.2, Transparency = 0.25})
            Tween(flAura, 0.25, {BackgroundTransparency = 0.90})
            Tween(flLogoGlow, 0.25, {BackgroundTransparency = 0.85})
        end
    end

    flBtn.MouseEnter:Connect(function()
        Tween(flScale, 0.2, {Scale = 1.1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        Tween(flCircleStroke, 0.2, {Thickness = 4.2, Transparency = 0})
        Tween(flAura, 0.2, {BackgroundTransparency = 0.70, Size = UDim2.new(1, 18, 1, 18)})
        Tween(flLogoGlow, 0.2, {BackgroundTransparency = 0.55})
    end)

    flBtn.MouseLeave:Connect(function()
        Tween(flScale, 0.2, {Scale = 1.0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        UpdateFloatingToggleVisual()
    end)

    flBtn.MouseButton1Click:Connect(function()
        Tween(flScale, 0.06, {Scale = 0.88}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        task.delay(0.06, function()
            Tween(flScale, 0.22, {Scale = 1.0}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end)

        flIconScale.Scale = 0.84
        Tween(flIconScale, 0.3, {Scale = 1}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

        local ripple = Instance.new("Frame", FloatingSquircle)
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.Size = UDim2.new(0, 10, 0, 10)
        ripple.BackgroundColor3 = Theme.AccentLight
        ripple.BackgroundTransparency = 0.35
        ripple.BorderSizePixel = 0
        ripple.ZIndex = 1
        Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
        local ripTw = Tween(ripple, 0.45, {
            Size = UDim2.new(2.4, 0, 2.4, 0),
            BackgroundTransparency = 1
        }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        ripTw.Completed:Connect(function() ripple:Destroy() end)
        task.delay(0.5, function() if ripple and ripple.Parent then ripple:Destroy() end end)

        ToggleMainWindow()
        UpdateFloatingToggleVisual()
    end)

    local WindowObj = {
        ScreenGui = ScreenGui,
        MainWindow = MainWindow,
        FloatingCircle = FloatingSquircle,
        FloatingSquircle = FloatingSquircle,
        CustomWallpaper = CustomWallpaper,
        Tabs = {},
        ActiveTab = nil,
        Keybind = ToggleKey,
        AllSearchableItems = {}
    }
    StarHubUI.CurrentWindowObj = WindowObj

    function WindowObj:ShowDiscordModal(inviteUrl)
        inviteUrl = inviteUrl or "https://discord.gg/aikaihub"
        pcall(function() setclipboard(inviteUrl) end)
        StarHubUI:Notify({
            Title = "DISCORD SERVER COPIED",
            Content = inviteUrl,
            Icon = StarHubUI.Icons.Copy,
            Badge = "COPIED",
            BadgeColor = Color3.fromRGB(34, 197, 94),
            Duration = 3.5
        })
    end

    function WindowObj:Notify(notifCfg)
        StarHubUI:Notify(notifCfg)
    end

    SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
        local q = string.lower(SearchInput.Text)
        sClear.Visible = (q ~= "")
        for _, item in ipairs(WindowObj.AllSearchableItems) do
            if item.Frame and item.SearchText then
                item.Frame.Visible = (q == "" or string.find(item.SearchText, q) ~= nil)
            end
        end
    end)

    UserInputService.InputBegan:Connect(function(inp, gpe)
        if not gpe and inp.KeyCode == WindowObj.Keybind then
            if StarHubUI.Settings.KeybindMode == "Toggle" then
                ToggleMainWindow()
            elseif StarHubUI.Settings.KeybindMode == "Hold" then
                ToggleMainWindow(true)
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(inp, gpe)
        if not gpe and inp.KeyCode == WindowObj.Keybind then
            if StarHubUI.Settings.KeybindMode == "Hold" then
                ToggleMainWindow(false)
            end
        end
    end)

    function WindowObj:AddNavHeader(titleText, order)
        local hFrame = Instance.new("Frame", NavScroll)
        hFrame.Name = "NavHeader_" .. titleText
        hFrame.Size = UDim2.new(1, -4, 0, 24)
        hFrame.BackgroundTransparency = 1
        hFrame.LayoutOrder = order or 1

        local h = Instance.new("TextLabel", hFrame)
        h.Size = UDim2.new(0, 80, 1, 0)
        h.Position = UDim2.new(0, 6, 0, 0)
        h.BackgroundTransparency = 1
        h.Font = Enum.Font.GothamBold
        h.TextSize = 9
        h.TextColor3 = Theme.TextDim
        h.TextXAlignment = Enum.TextXAlignment.Left
        h.Text = string.upper(titleText)

        local divLine = Instance.new("Frame", hFrame)
        divLine.Size = UDim2.new(1, -92, 0, 1)
        divLine.Position = UDim2.new(0, 88, 0.5, 0)
        divLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        divLine.BorderSizePixel = 0
        local dGrad = Instance.new("UIGradient", divLine)
        dGrad.Color = ColorSequence.new(Theme.Border)
        dGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.35),
            NumberSequenceKeypoint.new(1, 1)
        })
        RegisterElement("Borders", divLine)

        return hFrame
    end

    local ColorPickerModal = Instance.new("Frame", MainWindow)
    ColorPickerModal.Name = "ColorPickerModal"
    ColorPickerModal.Size = UDim2.new(0, 350, 0, 265)
    ColorPickerModal.Position = UDim2.new(0.5, -175, 0.5, -132)
    ColorPickerModal.BackgroundColor3 = Color3.fromRGB(24, 21, 33)
    ColorPickerModal.BorderSizePixel = 0
    ColorPickerModal.Visible = false
    ColorPickerModal.ZIndex = 100
    ColorPickerModal.ClipsDescendants = true
    Instance.new("UICorner", ColorPickerModal).CornerRadius = UDim.new(0, 14)
    local cpStroke = Instance.new("UIStroke", ColorPickerModal)
    cpStroke.Color = Color3.fromRGB(62, 54, 82)
    cpStroke.Thickness = 1.2

    local cpHeader = Instance.new("Frame", ColorPickerModal)
    cpHeader.Size = UDim2.new(1, 0, 0, 36)
    cpHeader.BackgroundTransparency = 1
    cpHeader.ZIndex = 101
    AttachDrag(cpHeader)

    local cpTitle = Instance.new("TextLabel", cpHeader)
    cpTitle.Size = UDim2.new(1, -50, 1, 0)
    cpTitle.Position = UDim2.new(0, 14, 0, 0)
    cpTitle.BackgroundTransparency = 1
    cpTitle.Font = Enum.Font.GothamBold
    cpTitle.TextSize = 13
    cpTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    cpTitle.TextXAlignment = Enum.TextXAlignment.Left
    cpTitle.Text = "Colorpicker"
    cpTitle.ZIndex = 101

    local cpClose = Instance.new("TextButton", cpHeader)
    cpClose.Size = UDim2.new(0, 22, 0, 22)
    cpClose.Position = UDim2.new(1, -30, 0.5, -11)
    cpClose.BackgroundColor3 = Color3.fromRGB(36, 32, 48)
    cpClose.Text = "X"
    cpClose.Font = Enum.Font.GothamBold
    cpClose.TextSize = 10
    cpClose.TextColor3 = Color3.fromRGB(180, 175, 195)
    cpClose.ZIndex = 102
    Instance.new("UICorner", cpClose).CornerRadius = UDim.new(1, 0)

    local currH, currS, currV = 0.45, 1, 0.9
    local oldColor = Color3.fromRGB(0, 255, 140)
    local activeColor = oldColor
    local activeColorCallback = nil
    local isUpdatingInternal = false

    local SVBox = Instance.new("Frame", ColorPickerModal)
    SVBox.Name = "SVBox"
    SVBox.Size = UDim2.new(0, 155, 0, 125)
    SVBox.Position = UDim2.new(0, 14, 0, 42)
    SVBox.BackgroundColor3 = Color3.fromHSV(currH, 1, 1)
    SVBox.BorderSizePixel = 0
    SVBox.ClipsDescendants = true
    SVBox.ZIndex = 101
    Instance.new("UICorner", SVBox).CornerRadius = UDim.new(0, 6)

    local WhiteOverlay = Instance.new("Frame", SVBox)
    WhiteOverlay.Size = UDim2.new(1, 0, 1, 0)
    WhiteOverlay.BackgroundColor3 = Color3.new(1, 1, 1)
    WhiteOverlay.BorderSizePixel = 0
    WhiteOverlay.ZIndex = 102
    local wGrad = Instance.new("UIGradient", WhiteOverlay)
    wGrad.Color = ColorSequence.new(Color3.new(1, 1, 1))
    wGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    })
    wGrad.Rotation = 0

    local BlackOverlay = Instance.new("Frame", SVBox)
    BlackOverlay.Size = UDim2.new(1, 0, 1, 0)
    BlackOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
    BlackOverlay.BorderSizePixel = 0
    BlackOverlay.ZIndex = 103
    local bGrad = Instance.new("UIGradient", BlackOverlay)
    bGrad.Color = ColorSequence.new(Color3.new(0, 0, 0))
    bGrad.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    })
    bGrad.Rotation = 90

    local SVCursor = Instance.new("Frame", SVBox)
    SVCursor.Size = UDim2.new(0, 11, 0, 11)
    SVCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    SVCursor.Position = UDim2.new(currS, 0, 1 - currV, 0)
    SVCursor.BackgroundTransparency = 1
    SVCursor.ZIndex = 104
    Instance.new("UICorner", SVCursor).CornerRadius = UDim.new(1, 0)
    local curStroke = Instance.new("UIStroke", SVCursor)
    curStroke.Color = Color3.new(1, 1, 1)
    curStroke.Thickness = 1.6

    local HueBar = Instance.new("Frame", ColorPickerModal)
    HueBar.Name = "HueBar"
    HueBar.Size = UDim2.new(0, 11, 0, 125)
    HueBar.Position = UDim2.new(0, 178, 0, 42)
    HueBar.BackgroundColor3 = Color3.new(1, 1, 1)
    HueBar.BorderSizePixel = 0
    HueBar.ZIndex = 101
    Instance.new("UICorner", HueBar).CornerRadius = UDim.new(1, 0)
    local hueGrad = Instance.new("UIGradient", HueBar)
    hueGrad.Rotation = 90
    hueGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
    })

    local HueKnob = Instance.new("Frame", HueBar)
    HueKnob.Size = UDim2.new(1, 6, 0, 6)
    HueKnob.AnchorPoint = Vector2.new(0.5, 0.5)
    HueKnob.Position = UDim2.new(0.5, 0, currH, 0)
    HueKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HueKnob.ZIndex = 104
    Instance.new("UICorner", HueKnob).CornerRadius = UDim.new(1, 0)
    local hkStroke = Instance.new("UIStroke", HueKnob)
    hkStroke.Color = Color3.fromRGB(40, 36, 52)
    hkStroke.Thickness = 1.2

    local InputsContainer = Instance.new("Frame", ColorPickerModal)
    InputsContainer.Size = UDim2.new(1, -204, 0, 125)
    InputsContainer.Position = UDim2.new(0, 198, 0, 42)
    InputsContainer.BackgroundTransparency = 1
    InputsContainer.ZIndex = 101

    local inLayout = Instance.new("UIListLayout", InputsContainer)
    inLayout.SortOrder = Enum.SortOrder.LayoutOrder
    inLayout.Padding = UDim.new(0, 6)

    local function MakeField(labelName, order)
        local row = Instance.new("Frame", InputsContainer)
        row.Size = UDim2.new(1, 0, 0, 26)
        row.BackgroundTransparency = 1
        row.LayoutOrder = order
        row.ZIndex = 101

        local box = Instance.new("TextBox", row)
        box.Size = UDim2.new(1, -44, 1, 0)
        box.Position = UDim2.new(0, 0, 0, 0)
        box.BackgroundColor3 = Color3.fromRGB(36, 31, 50)
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
        box.Font = Enum.Font.GothamBold
        box.TextSize = 10.5
        box.ClearTextOnFocus = false
        box.ZIndex = 102
        Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
        local bSt = Instance.new("UIStroke", box)
        bSt.Color = Color3.fromRGB(56, 48, 76)
        bSt.Thickness = 1

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(0, 40, 1, 0)
        lbl.Position = UDim2.new(1, -40, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = 9.5
        lbl.TextColor3 = Color3.fromRGB(180, 175, 195)
        lbl.TextXAlignment = Enum.TextXAlignment.Center
        lbl.Text = labelName
        lbl.ZIndex = 102

        return box
    end

    local hexInput   = MakeField("Hex", 1)
    local redInput   = MakeField("Red", 2)
    local greenInput = MakeField("Green", 3)
    local blueInput  = MakeField("Blue", 4)

    local SwatchRow = Instance.new("Frame", ColorPickerModal)
    SwatchRow.Size = UDim2.new(0, 175, 0, 24)
    SwatchRow.Position = UDim2.new(0, 14, 0, 176)
    SwatchRow.BackgroundTransparency = 1
    SwatchRow.ZIndex = 101

    local oldSwatch = Instance.new("TextButton", SwatchRow)
    oldSwatch.Size = UDim2.new(0.5, -4, 1, 0)
    oldSwatch.Position = UDim2.new(0, 0, 0, 0)
    oldSwatch.BackgroundColor3 = oldColor
    oldSwatch.Text = ""
    oldSwatch.AutoButtonColor = false
    oldSwatch.ZIndex = 102
    Instance.new("UICorner", oldSwatch).CornerRadius = UDim.new(0, 6)
    local osSt = Instance.new("UIStroke", oldSwatch)
    osSt.Color = Color3.fromRGB(62, 54, 82)
    osSt.Thickness = 1

    local newSwatch = Instance.new("Frame", SwatchRow)
    newSwatch.Size = UDim2.new(0.5, -4, 1, 0)
    newSwatch.Position = UDim2.new(0.5, 4, 0, 0)
    newSwatch.BackgroundColor3 = activeColor
    newSwatch.ZIndex = 102
    Instance.new("UICorner", newSwatch).CornerRadius = UDim.new(0, 6)
    local nsSt = Instance.new("UIStroke", newSwatch)
    nsSt.Color = Color3.fromRGB(255, 255, 255)
    nsSt.Thickness = 1
    nsSt.Transparency = 0.5

    local btnRow = Instance.new("Frame", ColorPickerModal)
    btnRow.Size = UDim2.new(1, -28, 0, 32)
    btnRow.Position = UDim2.new(0, 14, 1, -44)
    btnRow.BackgroundTransparency = 1
    btnRow.ZIndex = 101

    local doneBtn = Instance.new("TextButton", btnRow)
    doneBtn.Size = UDim2.new(0.5, -5, 1, 0)
    doneBtn.Position = UDim2.new(0, 0, 0, 0)
    doneBtn.BackgroundColor3 = Color3.fromRGB(38, 33, 52)
    doneBtn.Text = "Done"
    doneBtn.Font = Enum.Font.GothamBold
    doneBtn.TextSize = 11
    doneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    doneBtn.AutoButtonColor = false
    doneBtn.ZIndex = 102
    Instance.new("UICorner", doneBtn).CornerRadius = UDim.new(0, 8)
    local dbSt = Instance.new("UIStroke", doneBtn)
    dbSt.Color = Color3.fromRGB(62, 54, 82)

    local cancelBtn = Instance.new("TextButton", btnRow)
    cancelBtn.Size = UDim2.new(0.5, -5, 1, 0)
    cancelBtn.Position = UDim2.new(0.5, 5, 0, 0)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(38, 33, 52)
    cancelBtn.Text = "Cancel"
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 11
    cancelBtn.TextColor3 = Color3.fromRGB(180, 175, 195)
    cancelBtn.AutoButtonColor = false
    cancelBtn.ZIndex = 102
    Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 8)
    local cbSt = Instance.new("UIStroke", cancelBtn)
    cbSt.Color = Color3.fromRGB(62, 54, 82)

    doneBtn.MouseEnter:Connect(function() Tween(doneBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(48, 42, 68)}) end)
    doneBtn.MouseLeave:Connect(function() Tween(doneBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(38, 33, 52)}) end)
    cancelBtn.MouseEnter:Connect(function() Tween(cancelBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(48, 42, 68)}) end)
    cancelBtn.MouseLeave:Connect(function() Tween(cancelBtn, 0.15, {BackgroundColor3 = Color3.fromRGB(38, 33, 52)}) end)

    local function RefreshVisuals(fromInputs)
        activeColor = Color3.fromHSV(currH, currS, currV)
        SVBox.BackgroundColor3 = Color3.fromHSV(currH, 1, 1)
        SVCursor.Position = UDim2.new(currS, 0, 1 - currV, 0)
        HueKnob.Position = UDim2.new(0.5, 0, currH, 0)
        newSwatch.BackgroundColor3 = activeColor

        if not fromInputs then
            isUpdatingInternal = true
            hexInput.Text = ColorToHex(activeColor)
            redInput.Text = tostring(math.floor(activeColor.R * 255))
            greenInput.Text = tostring(math.floor(activeColor.G * 255))
            blueInput.Text = tostring(math.floor(activeColor.B * 255))
            isUpdatingInternal = false
        end
    end

    local svDragging = false
    local hueDragging = false

    local function UpdateSV(x, y)
        local w = SVBox.AbsoluteSize.X
        local h = SVBox.AbsoluteSize.Y
        local relX = math.clamp(x - SVBox.AbsolutePosition.X, 0, w)
        local relY = math.clamp(y - SVBox.AbsolutePosition.Y, 0, h)
        currS = relX / w
        currV = 1 - (relY / h)
        RefreshVisuals(false)
    end

    local function UpdateHue(y)
        local h = HueBar.AbsoluteSize.Y
        local relY = math.clamp(y - HueBar.AbsolutePosition.Y, 0, h)
        currH = relY / h
        RefreshVisuals(false)
    end

    SVBox.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            svDragging = true
            UpdateSV(inp.Position.X, inp.Position.Y)
        end
    end)

    HueBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            hueDragging = true
            UpdateHue(inp.Position.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            svDragging = false
            hueDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            if svDragging then UpdateSV(inp.Position.X, inp.Position.Y) end
            if hueDragging then UpdateHue(inp.Position.Y) end
        end
    end)

    hexInput.FocusLost:Connect(function()
        if isUpdatingInternal then return end
        local parsed = HexToColor(hexInput.Text)
        if parsed then
            currH, currS, currV = Color3.toHSV(parsed)
            RefreshVisuals(false)
        else
            hexInput.Text = ColorToHex(activeColor)
        end
    end)

    local function HandleRGBInput()
        if isUpdatingInternal then return end
        local r = math.clamp(tonumber(redInput.Text) or 0, 0, 255)
        local g = math.clamp(tonumber(greenInput.Text) or 0, 0, 255)
        local b = math.clamp(tonumber(blueInput.Text) or 0, 0, 255)
        local parsed = Color3.fromRGB(r, g, b)
        currH, currS, currV = Color3.toHSV(parsed)
        RefreshVisuals(false)
    end

    redInput.FocusLost:Connect(HandleRGBInput)
    greenInput.FocusLost:Connect(HandleRGBInput)
    blueInput.FocusLost:Connect(HandleRGBInput)

    oldSwatch.MouseButton1Click:Connect(function()
        PlaySound("Click")
        currH, currS, currV = Color3.toHSV(oldColor)
        RefreshVisuals(false)
    end)

    doneBtn.MouseButton1Click:Connect(function()
        PlaySound("Click")
        MicroBounce(doneBtn)
        ColorPickerModal.Visible = false
        if activeColorCallback then
            pcall(activeColorCallback, activeColor, ColorToHex(activeColor))
        end
    end)

    cancelBtn.MouseButton1Click:Connect(function()
        PlaySound("Click")
        ColorPickerModal.Visible = false
    end)

    cpClose.MouseButton1Click:Connect(function()
        ColorPickerModal.Visible = false
    end)

    function WindowObj:OpenColorPicker(initialColor, onColorChange, titleText)
        initialColor = initialColor or Theme.Accent
        oldColor = initialColor
        currH, currS, currV = Color3.toHSV(initialColor)
        oldSwatch.BackgroundColor3 = oldColor
        activeColorCallback = onColorChange
        cpTitle.Text = titleText or "Colorpicker"
        RefreshVisuals(false)
        ColorPickerModal.Visible = true
    end

    function WindowObj:CreateTab(tabConfig)
        tabConfig = tabConfig or {}
        local TabTitle = tabConfig.Title or "Tab"
        local TabIcon = tabConfig.IconId or StarHubUI.Icons.Dashboard
        local BadgeText = tabConfig.BadgeText
        local LayoutOrder = tabConfig.LayoutOrder or (#WindowObj.Tabs + 5)

        local Page = Instance.new("ScrollingFrame", ContentArea)
        Page.Name = "Page_" .. TabTitle
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Theme.Border
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.Visible = false

        local pagePad = Instance.new("UIPadding", Page)
        pagePad.PaddingLeft = UDim.new(0, 10)
        pagePad.PaddingRight = UDim.new(0, 10)
        pagePad.PaddingTop = UDim.new(0, 10)
        pagePad.PaddingBottom = UDim.new(0, 20)

        local pageLayout = Instance.new("UIListLayout", Page)
        pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        pageLayout.Padding = UDim.new(0, 10)

        local TopContainer = Instance.new("Frame", Page)
        TopContainer.Name = "TopContainer"
        TopContainer.Size = UDim2.new(1, 0, 0, 0)
        TopContainer.BackgroundTransparency = 1
        TopContainer.AutomaticSize = Enum.AutomaticSize.Y
        TopContainer.LayoutOrder = 1

        local topLayout = Instance.new("UIListLayout", TopContainer)
        topLayout.SortOrder = Enum.SortOrder.LayoutOrder
        topLayout.Padding = UDim.new(0, 8)

        local Columns = Instance.new("Frame", Page)
        Columns.Name = "Columns"
        Columns.Size = UDim2.new(1, 0, 0, 0)
        Columns.BackgroundTransparency = 1
        Columns.AutomaticSize = Enum.AutomaticSize.Y
        Columns.LayoutOrder = 2

        local LeftCol = Instance.new("Frame", Columns)
        LeftCol.Name = "LeftColumn"
        LeftCol.Size = UDim2.new(0.488, 0, 0, 0)
        LeftCol.Position = UDim2.new(0, 0, 0, 0)
        LeftCol.BackgroundTransparency = 1
        LeftCol.AutomaticSize = Enum.AutomaticSize.Y

        local leftLayout = Instance.new("UIListLayout", LeftCol)
        leftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        leftLayout.Padding = UDim.new(0, 10)

        local RightCol = Instance.new("Frame", Columns)
        RightCol.Name = "RightColumn"
        RightCol.Size = UDim2.new(0.488, 0, 0, 0)
        RightCol.Position = UDim2.new(0.512, 0, 0, 0)
        RightCol.BackgroundTransparency = 1
        RightCol.AutomaticSize = Enum.AutomaticSize.Y

        local rightLayout = Instance.new("UIListLayout", RightCol)
        rightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        rightLayout.Padding = UDim.new(0, 10)

        local TabBtn = Instance.new("TextButton", NavScroll)
        TabBtn.Name = "Nav_" .. TabTitle
        TabBtn.Size = UDim2.new(1, 0, 0, 38)
        TabBtn.BackgroundColor3 = Theme.SubBox
        TabBtn.BackgroundTransparency = 0.85
        TabBtn.Text = ""
        TabBtn.AutoButtonColor = false
        TabBtn.LayoutOrder = LayoutOrder
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 10)

        local tabStroke = Instance.new("UIStroke", TabBtn)
        tabStroke.Name = "TabStroke"
        tabStroke.Color = Theme.Border
        tabStroke.Thickness = 1
        tabStroke.Transparency = 0.75

        local activeGlow = Instance.new("Frame", TabBtn)
        activeGlow.Name = "ActiveGlow"
        activeGlow.Size = UDim2.new(1, 0, 1, 0)
        activeGlow.BackgroundColor3 = Theme.Accent
        activeGlow.BackgroundTransparency = 0.8
        activeGlow.BorderSizePixel = 0
        activeGlow.Visible = false
        Instance.new("UICorner", activeGlow).CornerRadius = UDim.new(0, 10)
        local agGrad = Instance.new("UIGradient", activeGlow)
        agGrad.Color = ColorSequence.new(Theme.Accent)
        agGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.65),
            NumberSequenceKeypoint.new(1, 1)
        })
        RegisterElement("Accents", activeGlow)

        local iconBadge = Instance.new("Frame", TabBtn)
        iconBadge.Name = "IconBadge"
        iconBadge.Size = UDim2.new(0, 26, 0, 26)
        iconBadge.Position = UDim2.new(0, 8, 0.5, -13)
        iconBadge.BackgroundColor3 = Theme.SubBox
        iconBadge.BackgroundTransparency = 0.45
        iconBadge.BorderSizePixel = 0
        Instance.new("UICorner", iconBadge).CornerRadius = UDim.new(0, 8)
        local ibStroke = Instance.new("UIStroke", iconBadge)
        ibStroke.Name = "BadgeStroke"
        ibStroke.Color = Theme.Border
        ibStroke.Thickness = 1
        ibStroke.Transparency = 0.6

        local tIcon = Instance.new("ImageLabel", iconBadge)
        tIcon.Name = "TabIcon"
        tIcon.Size = UDim2.new(0, 15, 0, 15)
        tIcon.Position = UDim2.new(0.5, -7.5, 0.5, -7.5)
        tIcon.BackgroundTransparency = 1
        tIcon.Image = TabIcon
        tIcon.ImageColor3 = Theme.TextDim

        local tName = Instance.new("TextLabel", TabBtn)
        tName.Name = "TabName"
        tName.Size = UDim2.new(1, -70, 1, 0)
        tName.Position = UDim2.new(0, 40, 0, 0)
        tName.BackgroundTransparency = 1
        tName.Font = Enum.Font.GothamMedium
        tName.TextSize = 11.5
        tName.TextColor3 = Theme.TextDim
        tName.TextXAlignment = Enum.TextXAlignment.Left
        tName.Text = TabTitle

        local rightIndicator = Instance.new("ImageLabel", TabBtn)
        rightIndicator.Name = "RightIndicator"
        rightIndicator.Size = UDim2.new(0, 12, 0, 12)
        rightIndicator.Position = UDim2.new(1, -16, 0.5, -6)
        rightIndicator.BackgroundTransparency = 1
        rightIndicator.Image = StarHubUI.Icons.ChevronDown
        rightIndicator.Rotation = -90
        rightIndicator.ImageColor3 = Theme.AccentLight
        rightIndicator.ImageTransparency = 1
        rightIndicator.Visible = false
        RegisterElement("Accents", rightIndicator)

        if BadgeText then
            local bTag = Instance.new("Frame", TabBtn)
            bTag.Name = "BadgeTag"
            bTag.Size = UDim2.new(0, 46, 0, 18)
            bTag.Position = UDim2.new(1, -52, 0.5, -9)
            bTag.BackgroundColor3 = Color3.fromRGB(15, 26, 20)
            bTag.BackgroundTransparency = 0.25
            bTag.BorderSizePixel = 0
            Instance.new("UICorner", bTag).CornerRadius = UDim.new(1, 0)

            local btStroke = Instance.new("UIStroke", bTag)
            btStroke.Color = Color3.fromRGB(34, 197, 94)
            btStroke.Transparency = 0.5
            btStroke.Thickness = 1

            local bText = Instance.new("TextLabel", bTag)
            bText.BackgroundTransparency = 1
            bText.Font = Enum.Font.GothamBold
            bText.TextSize = 8.5
            bText.TextColor3 = Color3.fromRGB(34, 197, 94)
            bText.Text = BadgeText

            if BadgeText == "LIVE" then
                bText.Size = UDim2.new(1, -17, 1, 0)
                bText.Position = UDim2.new(0, 16, 0, 0)
                bText.TextXAlignment = Enum.TextXAlignment.Left

                local liveDot = Instance.new("Frame", bTag)
                liveDot.Size = UDim2.new(0, 6, 0, 6)
                liveDot.Position = UDim2.new(0, 6, 0.5, -3)
                liveDot.BackgroundColor3 = Color3.fromRGB(34, 197, 94)
                liveDot.BorderSizePixel = 0
                Instance.new("UICorner", liveDot).CornerRadius = UDim.new(1, 0)

                task.spawn(function()
                    while bTag and bTag.Parent do
                        Tween(liveDot, 0.5, {BackgroundTransparency = 0.85}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                        task.wait(0.5)
                        if not bTag or not bTag.Parent then break end
                        Tween(liveDot, 0.5, {BackgroundTransparency = 0}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
                        task.wait(0.5)
                    end
                end)
            else
                bText.Size = UDim2.new(1, 0, 1, 0)
                bText.Position = UDim2.new(0, 0, 0, 0)
                bText.TextXAlignment = Enum.TextXAlignment.Center
            end
        end

        local TabObj = {
            Page = Page,
            Button = TabBtn,
            Title = TabTitle,
            TopContainer = TopContainer,
            Columns = Columns,
            LeftCol = LeftCol,
            RightCol = RightCol
        }

        TabBtn.MouseEnter:Connect(function()
            if WindowObj.ActiveTab ~= TabObj then
                Tween(tabStroke, 0.18, {Color = Theme.BorderLight, Transparency = 0.2, Thickness = 1.2})
                Tween(TabBtn, 0.18, {BackgroundColor3 = Theme.SubBox, BackgroundTransparency = 0.35})
                Tween(iconBadge, 0.18, {Position = UDim2.new(0, 11, 0.5, -13), BackgroundTransparency = 0.25})
                Tween(ibStroke, 0.18, {Color = Theme.BorderLight, Transparency = 0.25})
                Tween(tName, 0.18, {Position = UDim2.new(0, 44, 0, 0), TextColor3 = Theme.TextTitle})
                Tween(tIcon, 0.18, {ImageColor3 = Color3.fromRGB(255, 255, 255)})
            else
                Tween(tabStroke, 0.18, {Color = Theme.AccentLight, Transparency = 0.1, Thickness = 1.4})
                Tween(tName, 0.18, {Position = UDim2.new(0, 43, 0, 0)})
                Tween(iconBadge, 0.18, {Position = UDim2.new(0, 10, 0.5, -13)})
                if rightIndicator and not BadgeText then
                    rightIndicator.ImageColor3 = Theme.AccentLight
                    Tween(rightIndicator, 0.18, {Position = UDim2.new(1, -14, 0.5, -6), ImageTransparency = 0.1})
                end
            end
        end)

        TabBtn.MouseLeave:Connect(function()
            if WindowObj.ActiveTab ~= TabObj then
                Tween(tabStroke, 0.18, {Color = Theme.Border, Transparency = 0.75, Thickness = 1})
                Tween(TabBtn, 0.18, {BackgroundColor3 = Theme.SubBox, BackgroundTransparency = 0.85})
                Tween(iconBadge, 0.18, {Position = UDim2.new(0, 8, 0.5, -13), BackgroundTransparency = 0.45})
                Tween(ibStroke, 0.18, {Color = Theme.Border, Transparency = 0.6})
                Tween(tName, 0.18, {Position = UDim2.new(0, 40, 0, 0), TextColor3 = Theme.TextDim})
                Tween(tIcon, 0.18, {ImageColor3 = Theme.TextDim})
            else
                Tween(tabStroke, 0.18, {Color = Theme.Accent, Transparency = 0.2, Thickness = 1.2})
                Tween(TabBtn, 0.18, {BackgroundColor3 = Theme.SubBox, BackgroundTransparency = 0.15})
                Tween(tName, 0.18, {Position = UDim2.new(0, 40, 0, 0)})
                Tween(iconBadge, 0.18, {Position = UDim2.new(0, 8, 0.5, -13)})
                if rightIndicator and not BadgeText then
                    rightIndicator.ImageColor3 = Theme.AccentLight
                    Tween(rightIndicator, 0.18, {Position = UDim2.new(1, -16, 0.5, -6), ImageTransparency = 0.35})
                end
            end
        end)

        local function Activate()
            if WindowObj.ActiveTab == TabObj then return end
            PlaySound("TabSwitch")
            MicroBounce(TabBtn)

            for _, t in ipairs(WindowObj.Tabs) do
                t.Page.Visible = false
                t.Button.BackgroundColor3 = Theme.SubBox
                t.Button.BackgroundTransparency = 0.85
                local st = t.Button:FindFirstChild("TabStroke")
                if st then
                    st.Color = Theme.Border
                    st.Transparency = 0.75
                    st.Thickness = 1
                end
                local ag = t.Button:FindFirstChild("ActiveGlow")
                if ag then ag.Visible = false end
                local ri = t.Button:FindFirstChild("RightIndicator")
                if ri then ri.Visible = false ri.ImageTransparency = 1 end
                local ib = t.Button:FindFirstChild("IconBadge")
                if ib then
                    ib.BackgroundColor3 = Theme.SubBox
                    ib.BackgroundTransparency = 0.45
                    local ibs = ib:FindFirstChild("BadgeStroke")
                    if ibs then ibs.Color = Theme.Border ibs.Transparency = 0.6 ibs.Thickness = 1 end
                    local ic = ib:FindFirstChild("TabIcon") or ib:FindFirstChildOfClass("ImageLabel")
                    if ic then ic.ImageColor3 = Theme.TextDim end
                end
                local tn = t.Button:FindFirstChild("TabName") or t.Button:FindFirstChildOfClass("TextLabel")
                if tn then
                    tn.TextColor3 = Theme.TextDim
                    tn.Font = Enum.Font.GothamMedium
                end
            end

            WindowObj.ActiveTab = TabObj

            Page.Position = UDim2.new(0, 0, 0, 6)
            Page.Visible = true
            Tween(Page, 0.22, {Position = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

            activeGlow.Visible = true
            TabBtn.BackgroundColor3 = Theme.SubBox
            TabBtn.BackgroundTransparency = 0.15
            tabStroke.Color = Theme.Accent
            tabStroke.Transparency = 0.2
            tabStroke.Thickness = 1.2

            iconBadge.BackgroundColor3 = Theme.Accent
            iconBadge.BackgroundTransparency = 0.12
            ibStroke.Color = Theme.AccentLight
            ibStroke.Transparency = 0
            ibStroke.Thickness = 1.2
            tName.TextColor3 = Theme.TextTitle
            tName.Font = Enum.Font.GothamBold
            tIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

            if rightIndicator and not BadgeText then
                rightIndicator.Visible = true
                rightIndicator.ImageColor3 = Theme.AccentLight
                Tween(rightIndicator, 0.2, {ImageTransparency = 0.35})
            end
        end

        TabBtn.MouseButton1Click:Connect(Activate)
        TabObj.Activate = Activate

        if TabTitle == "System & Theme" or TabTitle == "Settings" then SettingsTabRef = TabObj end
        table.insert(WindowObj.Tabs, TabObj)
        if #WindowObj.Tabs == 1 then Activate() end

        local groupCounter = 0
        function TabObj:CreateGroupBox(sideOrTitle, titleOrBadge, badgeOrIcon, iconOpt)
            local side, titleText, rightBadgeText, iconIdOpt
            if sideOrTitle == "Right" or sideOrTitle == "Left" or sideOrTitle == 1 or sideOrTitle == 2 then
                side = (sideOrTitle == "Right" or sideOrTitle == 2) and "Right" or "Left"
                titleText = titleOrBadge or "Group"
                rightBadgeText = badgeOrIcon
                iconIdOpt = iconOpt
            else
                groupCounter = groupCounter + 1
                side = (groupCounter % 2 == 0) and "Right" or "Left"
                titleText = sideOrTitle or "Group"
                rightBadgeText = titleOrBadge
                iconIdOpt = badgeOrIcon
            end

            local targetCol = (side == "Right") and RightCol or LeftCol
            local BoxCard = Instance.new("Frame", targetCol)
            BoxCard.Name = "GroupBox_" .. tostring(titleText)
            BoxCard.Size = UDim2.new(1, 0, 0, 36)
            BoxCard.BackgroundColor3 = Theme.Box
            BoxCard.BorderSizePixel = 0
            BoxCard.AutomaticSize = Enum.AutomaticSize.Y
            Instance.new("UICorner", BoxCard).CornerRadius = UDim.new(0, 12)
            local bStroke = Instance.new("UIStroke", BoxCard)
            bStroke.Color = Theme.Border
            bStroke.Thickness = 1

            RegisterElement("Boxes", BoxCard)
            RegisterElement("Borders", bStroke)

            local BoxHeader = Instance.new("Frame", BoxCard)
            BoxHeader.Size = UDim2.new(1, 0, 0, 34)
            BoxHeader.BackgroundTransparency = 1

            local bIcon = Instance.new("ImageLabel", BoxHeader)
            bIcon.Size = UDim2.new(0, 14, 0, 14)
            bIcon.Position = UDim2.new(0, 12, 0.5, -7)
            bIcon.BackgroundTransparency = 1
            bIcon.Image = iconIdOpt or StarHubUI.Icons.Logo
            bIcon.ImageColor3 = Theme.AccentLight
            RegisterElement("Accents", bIcon)

            local bTitle = Instance.new("TextLabel", BoxHeader)
            bTitle.Size = UDim2.new(1, -90, 1, 0)
            bTitle.Position = UDim2.new(0, 32, 0, 0)
            bTitle.BackgroundTransparency = 1
            bTitle.Font = Enum.Font.GothamBold
            bTitle.TextSize = 10.5
            bTitle.TextColor3 = Theme.TextTitle
            bTitle.TextXAlignment = Enum.TextXAlignment.Left
            bTitle.Text = string.upper(titleText)

            if rightBadgeText then
                local bBadge = Instance.new("TextLabel", BoxHeader)
                bBadge.Size = UDim2.new(0, 75, 0, 18)
                bBadge.Position = UDim2.new(1, -85, 0.5, -9)
                bBadge.BackgroundColor3 = Theme.SubBox
                bBadge.Font = Enum.Font.GothamBold
                bBadge.TextSize = 8.5
                bBadge.TextColor3 = Theme.Success
                bBadge.Text = string.upper(rightBadgeText)
                Instance.new("UICorner", bBadge).CornerRadius = UDim.new(1, 0)
                RegisterElement("SubBoxes", bBadge)
            end

            local line = Instance.new("Frame", BoxHeader)
            line.Size = UDim2.new(1, 0, 0, 1)
            line.Position = UDim2.new(0, 0, 1, -1)
            line.BackgroundColor3 = Theme.Border
            line.BorderSizePixel = 0
            RegisterElement("Borders", line)

            local Container = Instance.new("Frame", BoxCard)
            Container.Name = "Container"
            Container.Size = UDim2.new(1, 0, 0, 0)
            Container.Position = UDim2.new(0, 0, 0, 34)
            Container.BackgroundTransparency = 1
            Container.AutomaticSize = Enum.AutomaticSize.Y

            local cLayout = Instance.new("UIListLayout", Container)
            cLayout.SortOrder = Enum.SortOrder.LayoutOrder
            cLayout.Padding = UDim.new(0, 7)

            local cPad = Instance.new("UIPadding", Container)
            cPad.PaddingLeft = UDim.new(0, 12)
            cPad.PaddingRight = UDim.new(0, 12)
            cPad.PaddingTop = UDim.new(0, 8)
            cPad.PaddingBottom = UDim.new(0, 12)

            local BoxObj = { Card = BoxCard, Container = Container }

            function BoxObj:AddToggle(title, desc, defaultVal, callback)
                callback = callback or function() end
                local state = defaultVal or false

                local row = Instance.new("Frame", Container)
                row.Size = UDim2.new(1, 0, 0, 0)
                row.BackgroundTransparency = 1
                row.AutomaticSize = Enum.AutomaticSize.Y

                table.insert(WindowObj.AllSearchableItems, {
                    Frame = row,
                    SearchText = string.lower(title .. " " .. (desc or ""))
                })

                local textCol = Instance.new("Frame", row)
                textCol.Size = UDim2.new(1, -48, 0, 0)
                textCol.Position = UDim2.new(0, 0, 0, 2)
                textCol.BackgroundTransparency = 1
                textCol.AutomaticSize = Enum.AutomaticSize.Y

                local tcLayout = Instance.new("UIListLayout", textCol)
                tcLayout.SortOrder = Enum.SortOrder.LayoutOrder
                tcLayout.Padding = UDim.new(0, 2)

                local tLbl = Instance.new("TextLabel", textCol)
                tLbl.Size = UDim2.new(1, 0, 0, 0)
                tLbl.BackgroundTransparency = 1
                tLbl.Font = Enum.Font.GothamMedium
                tLbl.TextSize = 11
                tLbl.TextColor3 = Theme.TextBody
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.TextWrapped = true
                tLbl.AutomaticSize = Enum.AutomaticSize.Y
                tLbl.Text = title

                if desc then
                    local dLbl = Instance.new("TextLabel", textCol)
                    dLbl.Size = UDim2.new(1, 0, 0, 0)
                    dLbl.BackgroundTransparency = 1
                    dLbl.Font = Enum.Font.Gotham
                    dLbl.TextSize = 9.5
                    dLbl.TextColor3 = Theme.TextDim
                    dLbl.TextXAlignment = Enum.TextXAlignment.Left
                    dLbl.TextWrapped = true
                    dLbl.AutomaticSize = Enum.AutomaticSize.Y
                    dLbl.Text = desc
                end

                local Pill = Instance.new("TextButton", row)
                Pill.Size = UDim2.new(0, 38, 0, 20)
                Pill.AnchorPoint = Vector2.new(1, 0.5)
                Pill.Position = UDim2.new(1, 0, 0.5, 0)
                Pill.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Theme.SubBox
                Pill.Text = ""
                Pill.AutoButtonColor = false
                Instance.new("UICorner", Pill).CornerRadius = UDim.new(1, 0)

                local pGrad = nil
                if state then pGrad = ApplyGradient(Pill, Theme.Grad1, Theme.Grad2, 45) end

                local Knob = Instance.new("Frame", Pill)
                Knob.Size = UDim2.new(0, 14, 0, 14)
                Knob.Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
                Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

                local function Set(v)
                    state = v
                    PlaySound(state and "ToggleOn" or "ToggleOff")
                    MicroBounce(Pill)
                    if state then
                        Pill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        if not pGrad then pGrad = ApplyGradient(Pill, Theme.Grad1, Theme.Grad2, 45) end
                        Tween(Knob, 0.2, {Position = UDim2.new(1, -17, 0.5, -7)})
                    else
                        if pGrad then pGrad:Destroy() pGrad = nil end
                        Pill.BackgroundColor3 = Theme.SubBox
                        Tween(Knob, 0.2, {Position = UDim2.new(0, 3, 0.5, -7)})
                    end
                    pcall(callback, state)
                end

                Pill.MouseButton1Click:Connect(function() Set(not state) end)
                return { Set = Set, Get = function() return state end }
            end

            function BoxObj:AddSlider(title, minVal, maxVal, defaultVal, suffix, callback)
                callback = callback or function() end
                suffix = suffix or ""
                local currentVal = math.clamp(defaultVal or minVal, minVal, maxVal)

                local row = Instance.new("Frame", Container)
                row.Size = UDim2.new(1, 0, 0, 0)
                row.BackgroundTransparency = 1
                row.AutomaticSize = Enum.AutomaticSize.Y

                local rLayout = Instance.new("UIListLayout", row)
                rLayout.SortOrder = Enum.SortOrder.LayoutOrder
                rLayout.Padding = UDim.new(0, 5)

                local topRow = Instance.new("Frame", row)
                topRow.Size = UDim2.new(1, 0, 0, 0)
                topRow.BackgroundTransparency = 1
                topRow.AutomaticSize = Enum.AutomaticSize.Y
                topRow.LayoutOrder = 1

                local tLbl = Instance.new("TextLabel", topRow)
                tLbl.Size = UDim2.new(1, -70, 0, 0)
                tLbl.Position = UDim2.new(0, 0, 0, 0)
                tLbl.BackgroundTransparency = 1
                tLbl.Font = Enum.Font.GothamBold
                tLbl.TextSize = 10
                tLbl.TextColor3 = Theme.TextBody
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.TextWrapped = true
                tLbl.AutomaticSize = Enum.AutomaticSize.Y
                tLbl.Text = string.upper(title)

                local valLbl = Instance.new("TextLabel", topRow)
                valLbl.Size = UDim2.new(0, 65, 0, 15)
                valLbl.Position = UDim2.new(1, -65, 0, 0)
                valLbl.BackgroundTransparency = 1
                valLbl.Font = Enum.Font.GothamBold
                valLbl.TextSize = 10
                valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                valLbl.TextXAlignment = Enum.TextXAlignment.Right
                valLbl.Text = tostring(currentVal) .. " " .. suffix
                ApplyGradient(valLbl, Theme.Grad1, Theme.Grad2, 0)
                RegisterElement("Accents", valLbl)

                local trackRow = Instance.new("Frame", row)
                trackRow.Size = UDim2.new(1, 0, 0, 20)
                trackRow.BackgroundTransparency = 1
                trackRow.LayoutOrder = 2

                local btnDown = Instance.new("TextButton", trackRow)
                btnDown.Size = UDim2.new(0, 20, 0, 20)
                btnDown.Position = UDim2.new(0, 0, 0, 0)
                btnDown.BackgroundColor3 = Theme.SubBox
                btnDown.Text = "-"
                btnDown.Font = Enum.Font.GothamBold
                btnDown.TextSize = 12
                btnDown.TextColor3 = Theme.TextDim
                Instance.new("UICorner", btnDown).CornerRadius = UDim.new(1, 0)
                local bdSt = Instance.new("UIStroke", btnDown)
                bdSt.Color = Theme.Border
                RegisterElement("SubBoxes", btnDown)
                RegisterElement("Borders", bdSt)

                local Track = Instance.new("Frame", trackRow)
                Track.Size = UDim2.new(1, -54, 0, 6)
                Track.Position = UDim2.new(0, 27, 0.5, -3)
                Track.BackgroundColor3 = Theme.SubBox
                Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

                local ratio = (currentVal - minVal) / (maxVal - minVal)
                local Fill = Instance.new("Frame", Track)
                Fill.Size = UDim2.new(ratio, 0, 1, 0)
                Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
                ApplyGradient(Fill, Theme.Grad1, Theme.Grad2, 0)

                local Knob = Instance.new("Frame", Track)
                Knob.Size = UDim2.new(0, 12, 0, 12)
                Knob.Position = UDim2.new(ratio, -6, 0.5, -6)
                Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

                local btnUp = Instance.new("TextButton", trackRow)
                btnUp.Size = UDim2.new(0, 20, 0, 20)
                btnUp.Position = UDim2.new(1, -20, 0, 0)
                btnUp.BackgroundColor3 = Theme.SubBox
                btnUp.Text = "+"
                btnUp.Font = Enum.Font.GothamBold
                btnUp.TextSize = 12
                btnUp.TextColor3 = Theme.TextDim
                Instance.new("UICorner", btnUp).CornerRadius = UDim.new(1, 0)
                local buSt = Instance.new("UIStroke", btnUp)
                buSt.Color = Theme.Border
                RegisterElement("SubBoxes", btnUp)
                RegisterElement("Borders", buSt)

                local function SetVal(v)
                    currentVal = math.clamp(v, minVal, maxVal)
                    local r = (currentVal - minVal) / (maxVal - minVal)
                    Fill.Size = UDim2.new(r, 0, 1, 0)
                    Knob.Position = UDim2.new(r, -6, 0.5, -6)
                    valLbl.Text = tostring(currentVal) .. " " .. suffix
                    valLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                    pcall(callback, currentVal)
                end

                btnDown.MouseButton1Click:Connect(function() PlaySound("Click") SetVal(currentVal - 1) end)
                btnUp.MouseButton1Click:Connect(function() PlaySound("Click") SetVal(currentVal + 1) end)

                local dragging = false
                Track.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                        dragging = true
                        PlaySound("Click")
                        local w = Track.AbsoluteSize.X
                        local rel = math.clamp(inp.Position.X - Track.AbsolutePosition.X, 0, w)
                        SetVal(math.floor(minVal + (maxVal - minVal) * (rel / w)))
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then dragging = false end
                end)
                UserInputService.InputChanged:Connect(function(inp)
                    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                        local w = Track.AbsoluteSize.X
                        local rel = math.clamp(inp.Position.X - Track.AbsolutePosition.X, 0, w)
                        SetVal(math.floor(minVal + (maxVal - minVal) * (rel / w)))
                    end
                end)
                return { Set = SetVal, Get = function() return currentVal end }
            end

            function BoxObj:AddDropdown(title, options, defaultVal, callback)
                callback = callback or function() end
                options = options or {}
                local selected = defaultVal or options[1] or ""
                local isOpen = false

                local row = Instance.new("Frame", Container)
                row.Size = UDim2.new(1, 0, 0, 48)
                row.BackgroundTransparency = 1
                row.ClipsDescendants = true

                local tLbl = Instance.new("TextLabel", row)
                tLbl.Size = UDim2.new(1, 0, 0, 14)
                tLbl.BackgroundTransparency = 1
                tLbl.Font = Enum.Font.GothamMedium
                tLbl.TextSize = 10
                tLbl.TextColor3 = Theme.TextDim
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.Text = string.upper(title)

                local Box = Instance.new("TextButton", row)
                Box.Size = UDim2.new(1, 0, 0, 28)
                Box.Position = UDim2.new(0, 0, 0, 18)
                Box.BackgroundColor3 = Theme.SubBox
                Box.Text = ""
                Box.AutoButtonColor = false
                Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 10)
                local bSt = Instance.new("UIStroke", Box)
                bSt.Color = Theme.Border
                RegisterElement("SubBoxes", Box)
                RegisterElement("Borders", bSt)

                local vLbl = Instance.new("TextLabel", Box)
                vLbl.Size = UDim2.new(1, -26, 1, 0)
                vLbl.Position = UDim2.new(0, 10, 0, 0)
                vLbl.BackgroundTransparency = 1
                vLbl.Font = Enum.Font.GothamMedium
                vLbl.TextSize = 10.5
                vLbl.TextColor3 = Theme.TextTitle
                vLbl.TextXAlignment = Enum.TextXAlignment.Left
                vLbl.Text = selected

                local chev = Instance.new("ImageLabel", Box)
                chev.Size = UDim2.new(0, 12, 0, 12)
                chev.Position = UDim2.new(1, -20, 0.5, -6)
                chev.BackgroundTransparency = 1
                chev.Image = StarHubUI.Icons.ChevronDown
                chev.ImageColor3 = Theme.TextDim

                local listFrame = Instance.new("Frame", row)
                listFrame.Size = UDim2.new(1, 0, 0, 0)
                listFrame.Position = UDim2.new(0, 0, 0, 50)
                listFrame.BackgroundTransparency = 1
                local lLayout = Instance.new("UIListLayout", listFrame)
                lLayout.Padding = UDim.new(0, 3)

                local function Toggle()
                    isOpen = not isOpen
                    PlaySound("Dropdown")
                    local h = isOpen and (54 + (#options * 26)) or 48
                    Tween(row, 0.22, {Size = UDim2.new(1, 0, 0, h)})
                    Tween(chev, 0.22, {Rotation = isOpen and 180 or 0})
                end

                Box.MouseButton1Click:Connect(Toggle)

                for _, opt in ipairs(options) do
                    local ob = Instance.new("TextButton", listFrame)
                    ob.Size = UDim2.new(1, 0, 0, 24)
                    ob.BackgroundColor3 = Theme.Box
                    ob.Text = ""
                    ob.AutoButtonColor = false
                    Instance.new("UICorner", ob).CornerRadius = UDim.new(0, 8)
                    RegisterElement("Boxes", ob)

                    local ot = Instance.new("TextLabel", ob)
                    ot.Size = UDim2.new(1, -12, 1, 0)
                    ot.Position = UDim2.new(0, 10, 0, 0)
                    ot.BackgroundTransparency = 1
                    ot.Font = Enum.Font.Gotham
                    ot.TextSize = 10
                    ot.TextColor3 = Theme.TextBody
                    ot.TextXAlignment = Enum.TextXAlignment.Left
                    ot.Text = opt

                    ob.MouseButton1Click:Connect(function()
                        PlaySound("Click")
                        selected = opt
                        vLbl.Text = opt
                        Toggle()
                        pcall(callback, opt)
                    end)
                end
                return { Get = function() return selected end }
            end

            function BoxObj:AddInput(name, placeholder, defaultVal, callback)
                local row = Instance.new("Frame", Container)
                row.Size = UDim2.new(1, 0, 0, 32)
                row.BackgroundTransparency = 1

                local lbl = Instance.new("TextLabel", row)
                lbl.Size = UDim2.new(0.4, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 9.5
                lbl.TextColor3 = Theme.TextTitle
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Text = string.upper(name)

                local input = Instance.new("TextBox", row)
                input.Size = UDim2.new(0.6, 0, 0, 26)
                input.Position = UDim2.new(0.4, 0, 0.5, -13)
                input.BackgroundColor3 = Theme.SubBox
                input.Text = defaultVal or ""
                input.PlaceholderText = placeholder or ""
                input.PlaceholderColor3 = Theme.TextMuted
                input.Font = Enum.Font.Gotham
                input.TextSize = 9.5
                input.TextColor3 = Theme.TextTitle
                input.TextXAlignment = Enum.TextXAlignment.Left
                input.ClearTextOnFocus = false
                Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)
                local inSt = Instance.new("UIStroke", input)
                inSt.Color = Theme.Border
                RegisterElement("SubBoxes", input)
                RegisterElement("Borders", inSt)

                local inPad = Instance.new("UIPadding", input)
                inPad.PaddingLeft = UDim.new(0, 8)
                inPad.PaddingRight = UDim.new(0, 8)

                input.FocusLost:Connect(function()
                    if callback then pcall(callback, input.Text) end
                end)
                return input
            end

            function BoxObj:AddColorPalette(callback)
                local row = Instance.new("Frame", Container)
                row.Size = UDim2.new(1, 0, 0, 82)
                row.BackgroundTransparency = 1

                local tLbl = Instance.new("TextLabel", row)
                tLbl.Size = UDim2.new(1, 0, 0, 16)
                tLbl.Position = UDim2.new(0, 0, 0, 0)
                tLbl.BackgroundTransparency = 1
                tLbl.Font = Enum.Font.GothamBold
                tLbl.TextSize = 9.5
                tLbl.TextColor3 = Theme.TextMuted
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.Text = "QUICK ACCENT PALETTES (ONE-TAP)"

                local palContainer = Instance.new("Frame", row)
                palContainer.Size = UDim2.new(1, 0, 0, 58)
                palContainer.Position = UDim2.new(0, 0, 0, 20)
                palContainer.BackgroundTransparency = 1

                local pLayout = Instance.new("UIGridLayout", palContainer)
                pLayout.CellSize = UDim2.new(0.2, -6, 0, 24)
                pLayout.CellPadding = UDim2.new(0, 6, 0, 6)
                pLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                pLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                local palettes = {
                    { Name = "Crimson", Col1 = Color3.fromRGB(235, 55, 75),  Col2 = Color3.fromRGB(255, 110, 80) },
                    { Name = "Gold",    Col1 = Color3.fromRGB(245, 158, 11), Col2 = Color3.fromRGB(251, 191, 36) },
                    { Name = "Cyan",    Col1 = Color3.fromRGB(6, 182, 212),  Col2 = Color3.fromRGB(139, 92, 246) },
                    { Name = "Emerald", Col1 = Color3.fromRGB(16, 185, 129), Col2 = Color3.fromRGB(52, 211, 153) },
                    { Name = "Violet",  Col1 = Color3.fromRGB(124, 58, 237), Col2 = Color3.fromRGB(192, 132, 252) },
                    { Name = "Sakura",  Col1 = Color3.fromRGB(244, 63, 94),  Col2 = Color3.fromRGB(251, 113, 133) },
                    { Name = "Glacier", Col1 = Color3.fromRGB(2, 132, 199),  Col2 = Color3.fromRGB(56, 189, 248) },
                    { Name = "Sunset",  Col1 = Color3.fromRGB(234, 88, 12),  Col2 = Color3.fromRGB(245, 158, 11) },
                    { Name = "Lime",    Col1 = Color3.fromRGB(132, 204, 22), Col2 = Color3.fromRGB(163, 230, 53) },
                    { Name = "Stealth", Col1 = Color3.fromRGB(148, 163, 184),Col2 = Color3.fromRGB(203, 213, 225) }
                }

                for _, pal in ipairs(palettes) do
                    local cBtn = Instance.new("TextButton", palContainer)
                    cBtn.BackgroundColor3 = pal.Col1
                    cBtn.Text = ""
                    cBtn.AutoButtonColor = false
                    Instance.new("UICorner", cBtn).CornerRadius = UDim.new(0, 8)

                    local cStroke = Instance.new("UIStroke", cBtn)
                    cStroke.Color = Color3.fromRGB(255, 255, 255)
                    cStroke.Thickness = 1.2
                    cStroke.Transparency = 0.5

                    cBtn.MouseEnter:Connect(function()
                        Tween(cStroke, 0.15, {Transparency = 0, Thickness = 1.8})
                        MicroBounce(cBtn)
                    end)
                    cBtn.MouseLeave:Connect(function()
                        Tween(cStroke, 0.15, {Transparency = 0.5, Thickness = 1.2})
                    end)

                    cBtn.MouseButton1Click:Connect(function()
                        PlaySound("Click")
                        MicroBounce(cBtn)
                        Theme.Accent = pal.Col1
                        Theme.AccentLight = pal.Col2
                        Theme.Grad1 = pal.Col1
                        Theme.Grad2 = pal.Col2
                        UpdateLiveTheme()
                        if callback then pcall(callback, pal.Col1, pal.Col2, pal.Name) end
                        StarHubUI:Notify({Title = "ACCENT CHANGED", Content = "Live palette switched to: " .. pal.Name})
                    end)
                end
                return row
            end

            function BoxObj:AddColorPickerRow(name, defaultColor, callback)
                defaultColor = defaultColor or Theme.Accent
                local row = Instance.new("Frame", Container)
                row.Size = UDim2.new(1, 0, 0, 34)
                row.BackgroundTransparency = 1

                local lbl = Instance.new("TextLabel", row)
                lbl.Size = UDim2.new(0.5, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 9.5
                lbl.TextColor3 = Theme.TextTitle
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Text = string.upper(name)

                local rightSide = Instance.new("Frame", row)
                rightSide.Size = UDim2.new(0.5, 0, 1, 0)
                rightSide.Position = UDim2.new(0.5, 0, 0, 0)
                rightSide.BackgroundTransparency = 1

                local swatch = Instance.new("Frame", rightSide)
                swatch.Size = UDim2.new(0, 18, 0, 18)
                swatch.Position = UDim2.new(1, -95, 0.5, -9)
                swatch.BackgroundColor3 = defaultColor
                Instance.new("UICorner", swatch).CornerRadius = UDim.new(1, 0)
                local swSt = Instance.new("UIStroke", swatch)
                swSt.Color = Color3.fromRGB(255, 255, 255)
                swSt.Thickness = 1
                swSt.Transparency = 0.4

                local hexLbl = Instance.new("TextLabel", rightSide)
                hexLbl.Size = UDim2.new(0, 60, 1, 0)
                hexLbl.Position = UDim2.new(1, -70, 0, 0)
                hexLbl.BackgroundTransparency = 1
                hexLbl.Font = Enum.Font.GothamBold
                hexLbl.TextSize = 10
                hexLbl.TextColor3 = Theme.AccentLight
                hexLbl.TextXAlignment = Enum.TextXAlignment.Left
                hexLbl.Text = ColorToHex(defaultColor)
                RegisterElement("Accents", hexLbl)

                local palBtn = Instance.new("ImageLabel", rightSide)
                palBtn.Size = UDim2.new(0, 16, 0, 16)
                palBtn.Position = UDim2.new(1, -6, 0.5, -8)
                palBtn.BackgroundTransparency = 1
                palBtn.Image = StarHubUI.Icons.Palette
                palBtn.ImageColor3 = Theme.TextDim

                local function Open()
                    PlaySound("Click")
                    WindowObj:OpenColorPicker(swatch.BackgroundColor3, function(newCol, newHex)
                        swatch.BackgroundColor3 = newCol
                        hexLbl.Text = newHex
                        if callback then pcall(callback, newCol, newHex) end
                    end, name)
                end

                local clickArea = Instance.new("TextButton", row)
                clickArea.Size = UDim2.new(1, 0, 1, 0)
                clickArea.BackgroundTransparency = 1
                clickArea.Text = ""
                clickArea.MouseButton1Click:Connect(Open)

                return {
                    Row = row,
                    Set = function(c)
                        swatch.BackgroundColor3 = c
                        hexLbl.Text = ColorToHex(c)
                    end,
                    Get = function() return swatch.BackgroundColor3 end
                }
            end

            function BoxObj:AddModeSelector(name, modes, defaultMode, callback)
                local row = Instance.new("Frame", Container)
                row.Size = UDim2.new(1, 0, 0, 44)
                row.BackgroundTransparency = 1

                local lbl = Instance.new("TextLabel", row)
                lbl.Size = UDim2.new(1, 0, 0, 14)
                lbl.BackgroundTransparency = 1
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 9.5
                lbl.TextColor3 = Theme.TextDim
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.Text = string.upper(name)

                local btnRow = Instance.new("Frame", row)
                btnRow.Size = UDim2.new(1, 0, 0, 26)
                btnRow.Position = UDim2.new(0, 0, 0, 18)
                btnRow.BackgroundTransparency = 1

                local bLayout = Instance.new("UIListLayout", btnRow)
                bLayout.FillDirection = Enum.FillDirection.Horizontal
                bLayout.Padding = UDim.new(0, 6)

                local active = defaultMode or modes[1]
                local modeButtons = {}

                local function RefreshSelector()
                    for nameMode, data in pairs(modeButtons) do
                        local isAct = (nameMode == active)
                        if isAct then
                            if StarHubUI.Settings.AccentStyle == "Gradient" then
                                data.Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                if not data.Grad or not data.Grad.Parent then
                                    data.Grad = ApplyGradient(data.Btn, Theme.Grad1, Theme.Grad2, 45)
                                else
                                    data.Grad.Color = ColorSequence.new({
                                        ColorSequenceKeypoint.new(0, Theme.Grad1 or Theme.Accent),
                                        ColorSequenceKeypoint.new(1, Theme.Grad2 or Theme.AccentLight)
                                    })
                                end
                            else
                                if data.Grad then data.Grad:Destroy() data.Grad = nil end
                                data.Btn.BackgroundColor3 = Theme.Accent
                            end
                            data.Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                            data.Stroke.Color = Theme.Accent
                        else
                            if data.Grad then data.Grad:Destroy() data.Grad = nil end
                            data.Btn.BackgroundColor3 = Theme.SubBox
                            data.Btn.TextColor3 = Theme.TextDim
                            data.Stroke.Color = Theme.Border
                        end
                    end
                end

                for _, m in ipairs(modes) do
                    local b = Instance.new("TextButton", btnRow)
                    b.Size = UDim2.new(1 / #modes, -((#modes - 1) * 6) / #modes, 1, 0)
                    b.Text = m
                    b.Font = Enum.Font.GothamBold
                    b.TextSize = 9.5
                    b.AutoButtonColor = false
                    Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
                    local bSt = Instance.new("UIStroke", b)

                    modeButtons[m] = { Btn = b, Stroke = bSt, Grad = nil }

                    b.MouseButton1Click:Connect(function()
                        PlaySound("Click")
                        active = m
                        RefreshSelector()
                        if callback then pcall(callback, m) end
                    end)
                end

                RefreshSelector()
                table.insert(ThemeRegistry.ModeSelectors, RefreshSelector)
            end

            function BoxObj:AddActionRow(title, subtitle, iconAsset, callback)
                callback = callback or function() end
                local row = Instance.new("TextButton", Container)
                row.Size = UDim2.new(1, 0, 0, 0)
                row.AutomaticSize = Enum.AutomaticSize.Y
                row.BackgroundColor3 = Theme.SubBox
                row.Text = ""
                row.AutoButtonColor = false
                Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
                local rStroke = Instance.new("UIStroke", row)
                rStroke.Color = Theme.Border
                RegisterElement("SubBoxes", row)
                RegisterElement("Borders", rStroke)

                local rPad = Instance.new("UIPadding", row)
                rPad.PaddingLeft = UDim.new(0, 10)
                rPad.PaddingRight = UDim.new(0, 30)
                rPad.PaddingTop = UDim.new(0, 6)
                rPad.PaddingBottom = UDim.new(0, 6)

                local rLayout = Instance.new("UIListLayout", row)
                rLayout.SortOrder = Enum.SortOrder.LayoutOrder
                rLayout.Padding = UDim.new(0, 2)

                local tLbl = Instance.new("TextLabel", row)
                tLbl.Size = UDim2.new(1, 0, 0, 0)
                tLbl.BackgroundTransparency = 1
                tLbl.Font = Enum.Font.GothamBold
                tLbl.TextSize = 10.5
                tLbl.TextColor3 = Theme.TextTitle
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.TextWrapped = true
                tLbl.AutomaticSize = Enum.AutomaticSize.Y
                tLbl.Text = title

                if subtitle and subtitle ~= "" then
                    local sLbl = Instance.new("TextLabel", row)
                    sLbl.Size = UDim2.new(1, 0, 0, 0)
                    sLbl.BackgroundTransparency = 1
                    sLbl.Font = Enum.Font.Gotham
                    sLbl.TextSize = 8.5
                    sLbl.TextColor3 = Theme.TextDim
                    sLbl.TextXAlignment = Enum.TextXAlignment.Left
                    sLbl.TextWrapped = true
                    sLbl.AutomaticSize = Enum.AutomaticSize.Y
                    sLbl.Text = subtitle
                end

                local ic = Instance.new("ImageLabel", row)
                ic.Size = UDim2.new(0, 14, 0, 14)
                ic.AnchorPoint = Vector2.new(1, 0.5)
                ic.Position = UDim2.new(1, 22, 0.5, 0)
                ic.BackgroundTransparency = 1
                ic.Image = iconAsset or StarHubUI.Icons.Copy
                ic.ImageColor3 = Theme.AccentLight
                RegisterElement("Accents", ic)

                row.MouseButton1Click:Connect(function()
                    PlaySound("Click")
                    MicroBounce(row)
                    pcall(callback)
                end)
                return row
            end

            function BoxObj:AddDangerButton(title, subtitle, iconAsset, callback)
                local btn = Instance.new("TextButton", Container)
                btn.Size = UDim2.new(1, 0, 0, 0)
                btn.AutomaticSize = Enum.AutomaticSize.Y
                btn.BackgroundColor3 = Theme.Danger
                btn.Text = ""
                btn.AutoButtonColor = false
                Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

                local bPad = Instance.new("UIPadding", btn)
                bPad.PaddingLeft = UDim.new(0, 32)
                bPad.PaddingRight = UDim.new(0, 10)
                bPad.PaddingTop = UDim.new(0, 7)
                bPad.PaddingBottom = UDim.new(0, 7)

                local bLayout = Instance.new("UIListLayout", btn)
                bLayout.SortOrder = Enum.SortOrder.LayoutOrder
                bLayout.Padding = UDim.new(0, 2)

                local ic = Instance.new("ImageLabel", btn)
                ic.Size = UDim2.new(0, 14, 0, 14)
                ic.AnchorPoint = Vector2.new(0, 0.5)
                ic.Position = UDim2.new(0, -22, 0.5, 0)
                ic.BackgroundTransparency = 1
                ic.Image = iconAsset or StarHubUI.Icons.Skull
                ic.ImageColor3 = Color3.fromRGB(255, 255, 255)

                local tLbl = Instance.new("TextLabel", btn)
                tLbl.Size = UDim2.new(1, 0, 0, 0)
                tLbl.BackgroundTransparency = 1
                tLbl.Font = Enum.Font.GothamBold
                tLbl.TextSize = 10
                tLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
                tLbl.TextXAlignment = Enum.TextXAlignment.Left
                tLbl.TextWrapped = true
                tLbl.AutomaticSize = Enum.AutomaticSize.Y
                tLbl.Text = title

                if subtitle and subtitle ~= "" then
                    local sLbl = Instance.new("TextLabel", btn)
                    sLbl.Size = UDim2.new(1, 0, 0, 0)
                    sLbl.BackgroundTransparency = 1
                    sLbl.Font = Enum.Font.Gotham
                    sLbl.TextSize = 8.5
                    sLbl.TextColor3 = Color3.fromRGB(255, 220, 220)
                    sLbl.TextXAlignment = Enum.TextXAlignment.Left
                    sLbl.TextWrapped = true
                    sLbl.AutomaticSize = Enum.AutomaticSize.Y
                    sLbl.Text = subtitle
                end

                btn.MouseButton1Click:Connect(function()
                    PlaySound("Click")
                    MicroBounce(btn)
                    pcall(callback)
                end)
                return btn
            end

            return BoxObj
        end
        return TabObj
    end

    function WindowObj:CreateDualColumnDashboard(tabObj)
        local targetHero = tabObj.TopContainer or tabObj.Page

        local SectionHeader = Instance.new("Frame", targetHero)
        SectionHeader.Name = "SectionHeader"
        SectionHeader.Size = UDim2.new(1, 0, 0, 24)
        SectionHeader.BackgroundTransparency = 1
        SectionHeader.LayoutOrder = 1

        local shTitle = Instance.new("TextLabel", SectionHeader)
        shTitle.Size = UDim2.new(1, 0, 0, 16)
        shTitle.BackgroundTransparency = 1
        shTitle.Font = Enum.Font.GothamBold
        shTitle.TextSize = 11.5
        shTitle.TextColor3 = Theme.TextDim
        shTitle.TextXAlignment = Enum.TextXAlignment.Left
        shTitle.Text = "ภาพรวมและข้อมูลเซิร์ฟเวอร์"

        local shLine = Instance.new("Frame", SectionHeader)
        shLine.Size = UDim2.new(0, 48, 0, 2)
        shLine.Position = UDim2.new(0, 0, 1, -2)
        shLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        shLine.BorderSizePixel = 0
        Instance.new("UICorner", shLine).CornerRadius = UDim.new(1, 0)
        ApplyGradient(shLine, Theme.Grad1, Theme.Grad2, 0)

        local function GetThaiGreeting()
            local h = tonumber(os.date("%H")) or 12
            if h >= 5 and h < 12 then
                return "อรุณสวัสดิ์"
            elseif h >= 12 and h < 17 then
                return "สวัสดีตอนบ่าย"
            elseif h >= 17 and h < 20 then
                return "สวัสดีตอนเย็น"
            else
                return "ราตรีสวัสดิ์"
            end
        end

        local PlayerCard = Instance.new("Frame", targetHero)
        PlayerCard.Name = "PlayerGreetingCard"
        PlayerCard.Size = UDim2.new(1, 0, 0, 68)
        PlayerCard.BackgroundColor3 = Theme.Box
        PlayerCard.BorderSizePixel = 0
        PlayerCard.LayoutOrder = 2
        Instance.new("UICorner", PlayerCard).CornerRadius = UDim.new(0, 12)
        local pcStroke = Instance.new("UIStroke", PlayerCard)
        pcStroke.Color = Theme.Border
        pcStroke.Thickness = 1
        RegisterElement("Boxes", PlayerCard)
        RegisterElement("Borders", pcStroke)

        local AvatarImg = Instance.new("ImageLabel", PlayerCard)
        AvatarImg.Size = UDim2.new(0, 46, 0, 46)
        AvatarImg.Position = UDim2.new(0, 12, 0.5, -23)
        AvatarImg.BackgroundTransparency = 1
        AvatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150&filters=circular"
        Instance.new("UICorner", AvatarImg).CornerRadius = UDim.new(1, 0)
        local avStroke = Instance.new("UIStroke", AvatarImg)
        avStroke.Color = Theme.BorderLight
        avStroke.Thickness = 1

        local GreetLabel = Instance.new("TextLabel", PlayerCard)
        GreetLabel.Size = UDim2.new(0.5, -70, 0, 14)
        GreetLabel.Position = UDim2.new(0, 68, 0, 14)
        GreetLabel.BackgroundTransparency = 1
        GreetLabel.Font = Enum.Font.GothamMedium
        GreetLabel.TextSize = 10.5
        GreetLabel.TextColor3 = Theme.TextMuted
        GreetLabel.TextXAlignment = Enum.TextXAlignment.Left
        GreetLabel.Text = GetThaiGreeting()

        local NameLabel = Instance.new("TextLabel", PlayerCard)
        NameLabel.Size = UDim2.new(0.5, -70, 0, 22)
        NameLabel.Position = UDim2.new(0, 68, 0, 30)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Font = Enum.Font.GothamBold
        NameLabel.TextSize = 16
        NameLabel.TextColor3 = Theme.TextTitle
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Text = LocalPlayer.DisplayName or LocalPlayer.Name

        local ClockLabel = Instance.new("TextLabel", PlayerCard)
        ClockLabel.Size = UDim2.new(0.5, 0, 0, 24)
        ClockLabel.Position = UDim2.new(0.5, -16, 0, 11)
        ClockLabel.BackgroundTransparency = 1
        ClockLabel.Font = Enum.Font.GothamBold
        ClockLabel.TextSize = 20
        ClockLabel.TextColor3 = Theme.TextTitle
        ClockLabel.TextXAlignment = Enum.TextXAlignment.Right
        ClockLabel.Text = os.date("%H:%M:%S")

        local DateLabel = Instance.new("TextLabel", PlayerCard)
        DateLabel.Size = UDim2.new(0.45, 0, 0, 14)
        DateLabel.Position = UDim2.new(0.55, -16, 0, 38)
        DateLabel.BackgroundTransparency = 1
        DateLabel.Font = Enum.Font.GothamMedium
        DateLabel.TextSize = 10.5
        DateLabel.TextColor3 = Theme.TextMuted
        DateLabel.TextXAlignment = Enum.TextXAlignment.Right
        DateLabel.Text = os.date("%d / %m / %Y")

        local placeName = "Roblox Experience"
        local creatorName = "Roblox Studio"
        local resolvedGameIcon = ""
        pcall(function()
            local MarketplaceService = game:GetService("MarketplaceService")
            local info = MarketplaceService:GetProductInfo(game.PlaceId)
            if info then
                if info.Name and info.Name ~= "" then
                    placeName = info.Name
                end
                if info.Creator and info.Creator.Name and info.Creator.Name ~= "" then
                    creatorName = info.Creator.Name
                end
                if info.IconImageAssetId and tonumber(info.IconImageAssetId) and tonumber(info.IconImageAssetId) > 0 then
                    resolvedGameIcon = "rbxassetid://" .. tostring(info.IconImageAssetId)
                end
            end
        end)

        if resolvedGameIcon == "" then
            local universeId = (game.GameId and tonumber(game.GameId) and tonumber(game.GameId) > 0) and game.GameId or nil
            if universeId then
                resolvedGameIcon = "rbxthumb://type=GameIcon&id=" .. tostring(universeId) .. "&w=150&h=150"
            else
                resolvedGameIcon = "rbxthumb://type=Asset&id=" .. tostring(game.PlaceId) .. "&w=150&h=150"
            end
        end

        local GameCard = Instance.new("CanvasGroup", targetHero)
        GameCard.Name = "GameServerCard"
        GameCard.Size = UDim2.new(1, 0, 0, 86)
        GameCard.BackgroundColor3 = Theme.Box
        GameCard.BorderSizePixel = 0
        GameCard.LayoutOrder = 3
        Instance.new("UICorner", GameCard).CornerRadius = UDim.new(0, 14)
        local gcStroke = Instance.new("UIStroke", GameCard)
        gcStroke.Color = Theme.Border
        gcStroke.Thickness = 1
        RegisterElement("Boxes", GameCard)
        RegisterElement("Borders", gcStroke)

        local BannerImg = Instance.new("ImageLabel", GameCard)
        BannerImg.Name = "MapBanner"
        BannerImg.AnchorPoint = Vector2.new(1, 0)
        BannerImg.Position = UDim2.new(1, 0, 0, 0)
        BannerImg.Size = UDim2.new(0.65, 0, 1, 0)
        BannerImg.BackgroundTransparency = 1
        BannerImg.ScaleType = Enum.ScaleType.Crop
        BannerImg.Image = resolvedGameIcon
        BannerImg.ImageTransparency = 0.70
        BannerImg.ZIndex = 1
        Instance.new("UICorner", BannerImg).CornerRadius = UDim.new(0, 14)

        local bGrad = Instance.new("UIGradient", BannerImg)
        bGrad.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.35, 0.82),
            NumberSequenceKeypoint.new(1, 0.35)
        })

        local GameThumb = Instance.new("ImageLabel", GameCard)
        GameThumb.Size = UDim2.new(0, 60, 0, 60)
        GameThumb.Position = UDim2.new(0, 12, 0.5, -30)
        GameThumb.BackgroundColor3 = Theme.SubBox
        GameThumb.BackgroundTransparency = 0.1
        GameThumb.ScaleType = Enum.ScaleType.Fit
        GameThumb.Image = resolvedGameIcon
        GameThumb.ZIndex = 3
        Instance.new("UICorner", GameThumb).CornerRadius = UDim.new(0, 14)
        local gtStroke = Instance.new("UIStroke", GameThumb)
        gtStroke.Color = Theme.BorderLight
        gtStroke.Thickness = 1

        task.spawn(function()
            pcall(function()
                game:GetService("ContentProvider"):PreloadAsync({GameThumb, BannerImg})
            end)
        end)

        local GameTitleLbl = Instance.new("TextLabel", GameCard)
        GameTitleLbl.Size = UDim2.new(1, -90, 0, 18)
        GameTitleLbl.Position = UDim2.new(0, 84, 0, 12)
        GameTitleLbl.BackgroundTransparency = 1
        GameTitleLbl.Font = Enum.Font.GothamBold
        GameTitleLbl.TextSize = 14
        GameTitleLbl.TextColor3 = Theme.TextTitle
        GameTitleLbl.TextXAlignment = Enum.TextXAlignment.Left
        GameTitleLbl.Text = placeName
        GameTitleLbl.ZIndex = 3

        local GameSubLbl = Instance.new("TextLabel", GameCard)
        GameSubLbl.Size = UDim2.new(1, -90, 0, 14)
        GameSubLbl.Position = UDim2.new(0, 84, 0, 32)
        GameSubLbl.BackgroundTransparency = 1
        GameSubLbl.Font = Enum.Font.Gotham
        GameSubLbl.TextSize = 9.5
        GameSubLbl.TextColor3 = Theme.TextDim
        GameSubLbl.TextXAlignment = Enum.TextXAlignment.Left
        GameSubLbl.Text = "โดย " .. ((creatorName and creatorName ~= "") and creatorName or "Roblox Creator")
        GameSubLbl.ZIndex = 3

        local PillsRow = Instance.new("Frame", GameCard)
        PillsRow.Size = UDim2.new(1, -90, 0, 22)
        PillsRow.Position = UDim2.new(0, 84, 0, 52)
        PillsRow.BackgroundTransparency = 1
        PillsRow.ZIndex = 3

        local prLayout = Instance.new("UIListLayout", PillsRow)
        prLayout.FillDirection = Enum.FillDirection.Horizontal
        prLayout.Padding = UDim.new(0, 6)

        local function MakePill(text, minW, col)
            local p = Instance.new("Frame", PillsRow)
            p.AutomaticSize = Enum.AutomaticSize.X
            p.Size = UDim2.new(0, minW or 60, 0, 20)
            p.BackgroundColor3 = Theme.SubBox
            p.BackgroundTransparency = 0.2
            Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
            local ps = Instance.new("UIStroke", p)
            ps.Color = Theme.Border
            ps.Thickness = 0.8

            local t = Instance.new("TextLabel", p)
            t.AutomaticSize = Enum.AutomaticSize.X
            t.Size = UDim2.new(0, 0, 1, 0)
            t.Position = UDim2.new(0, 8, 0, 0)
            t.BackgroundTransparency = 1
            t.Font = Enum.Font.GothamBold
            t.TextSize = 8.5
            t.TextColor3 = col or Theme.TextDim
            t.Text = text
            local pad = Instance.new("UIPadding", p)
            pad.PaddingRight = UDim.new(0, 8)
            return t
        end

        local pillId = MakePill("ID " .. tostring(game.PlaceId), 90, Theme.TextDim)
        local pillPl = MakePill("ผู้เล่น " .. tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers), 70, Theme.TextDim)
        local pillPing = MakePill("Ping 35 ms", 60, Theme.Success)

        task.spawn(function()
            while task.wait(0.25) do
                if not PlayerCard or not PlayerCard.Parent then break end
                ClockLabel.Text = os.date("%H:%M:%S")
                DateLabel.Text = os.date("%d / %m / %Y")
                GreetLabel.Text = GetThaiGreeting()
                pillPl.Text = "ผู้เล่น " .. tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers)
                pcall(function()
                    local p = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue())
                    pillPing.Text = "Ping " .. tostring(p) .. " ms"
                end)
            end
        end)

        local PerfBox = tabObj:CreateGroupBox("Left", "LIVE PERFORMANCE", "SYNCHRONIZED", StarHubUI.Icons.Logo)

        local grid = Instance.new("Frame", PerfBox.Container)
        grid.Size = UDim2.new(1, 0, 0, 82)
        grid.BackgroundTransparency = 1

        local function MakeMetric(label, val, sub, col, row)
            local card = Instance.new("Frame", grid)
            local posX = (col == 1) and UDim.new(0, 0) or UDim.new(0.5, 3)
            local posY = (row == 1) and UDim.new(0, 0) or UDim.new(0, 42)
            card.Size = UDim2.new(0.5, -3, 0, 38)
            card.Position = UDim2.new(posX.Scale, posX.Offset, posY.Scale, posY.Offset)
            card.BackgroundColor3 = Theme.SubBox
            card.ClipsDescendants = true
            Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
            local s = Instance.new("UIStroke", card)
            s.Color = Theme.Border
            RegisterElement("SubBoxes", card)
            RegisterElement("Borders", s)

            local lL = Instance.new("TextLabel", card)
            lL.Size = UDim2.new(1, -12, 0, 12)
            lL.Position = UDim2.new(0, 8, 0, 4)
            lL.BackgroundTransparency = 1
            lL.Font = Enum.Font.GothamBold
            lL.TextSize = 8
            lL.TextColor3 = Theme.TextMuted
            lL.TextXAlignment = Enum.TextXAlignment.Left
            lL.Text = string.upper(label)

            local vL = Instance.new("TextLabel", card)
            vL.Size = UDim2.new(0.62, 0, 0, 18)
            vL.Position = UDim2.new(0, 8, 0, 16)
            vL.BackgroundTransparency = 1
            vL.Font = Enum.Font.GothamBold
            vL.TextSize = 12.5
            vL.TextColor3 = Theme.TextTitle
            vL.TextXAlignment = Enum.TextXAlignment.Left
            vL.TextTruncate = Enum.TextTruncate.AtEnd
            vL.Text = val

            local sL = Instance.new("TextLabel", card)
            sL.Size = UDim2.new(0.38, -6, 0, 14)
            sL.Position = UDim2.new(0.62, 0, 0, 18)
            sL.BackgroundTransparency = 1
            sL.Font = Enum.Font.GothamBold
            sL.TextSize = 8
            sL.TextColor3 = Color3.fromRGB(255, 255, 255)
            sL.TextXAlignment = Enum.TextXAlignment.Right
            sL.Text = string.upper(sub)
            ApplyGradient(sL, Theme.Grad1, Theme.Grad2, 0)
            RegisterElement("Accents", sL)
            return vL
        end

        local fpsM = MakeMetric("FRAMERATE", "60.0", "FPS", 1, 1)
        local pingM = MakeMetric("LATENCY", "35 ms", "OPTIMAL", 2, 1)
        local plM = MakeMetric("PLAYERS", tostring(#Players:GetPlayers()) .. " / " .. tostring(Players.MaxPlayers), "ONLINE", 1, 2)
        local sessM = MakeMetric("SESSION", "00:00", "ACTIVE", 2, 2)

        local WaveBox = Instance.new("Frame", PerfBox.Container)
        WaveBox.Size = UDim2.new(1, 0, 0, 56)
        WaveBox.BackgroundColor3 = Theme.SubBox
        WaveBox.ClipsDescendants = true
        Instance.new("UICorner", WaveBox).CornerRadius = UDim.new(0, 10)
        local wStroke = Instance.new("UIStroke", WaveBox)
        wStroke.Color = Theme.Border
        RegisterElement("SubBoxes", WaveBox)
        RegisterElement("Borders", wStroke)

        local wTitle = Instance.new("TextLabel", WaveBox)
        wTitle.Size = UDim2.new(0.55, 0, 0, 14)
        wTitle.Position = UDim2.new(0, 10, 0, 4)
        wTitle.BackgroundTransparency = 1
        wTitle.Font = Enum.Font.GothamBold
        wTitle.TextSize = 8.5
        wTitle.TextColor3 = Theme.TextMuted
        wTitle.TextXAlignment = Enum.TextXAlignment.Left
        wTitle.Text = "FRAME BUFFER ACTIVITY"

        local wSub = Instance.new("TextLabel", WaveBox)
        wSub.Size = UDim2.new(0.45, -10, 0, 14)
        wSub.Position = UDim2.new(0.55, 0, 0, 4)
        wSub.BackgroundTransparency = 1
        wSub.Font = Enum.Font.GothamBold
        wSub.TextSize = 8.5
        wSub.TextColor3 = Theme.AccentLight
        wSub.TextXAlignment = Enum.TextXAlignment.Right
        wSub.Text = "REALTIME | 60 FPS"
        RegisterElement("Accents", wSub)

        local barBox = Instance.new("Frame", WaveBox)
        barBox.Size = UDim2.new(1, -20, 0, 28)
        barBox.Position = UDim2.new(0, 10, 0, 22)
        barBox.BackgroundTransparency = 1
        barBox.ClipsDescendants = true

        local bLayout = Instance.new("UIListLayout", barBox)
        bLayout.FillDirection = Enum.FillDirection.Horizontal
        bLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        bLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
        bLayout.Padding = UDim.new(0, 3)

        local graphBars = {}
        for i = 1, 22 do
            local b = Instance.new("Frame", barBox)
            b.Size = UDim2.new(0, 6, 0.6, 0)
            b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            b.BorderSizePixel = 0
            Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
            ApplyGradient(b, Theme.Grad1, Theme.Grad2, 90)
            table.insert(graphBars, b)
        end

        local fpsHistory = {}
        for i = 1, 22 do
            fpsHistory[i] = 60
        end

        local currentFPS = 60
        local frameCount = 0
        local lastCheck = tick()
        local startTime = tick()
        local maxObservedFPS = 60

        RunService.RenderStepped:Connect(function()
            frameCount = frameCount + 1
            local now = tick()
            local elapsed = now - lastCheck
            if elapsed >= 0.18 then
                currentFPS = math.clamp(math.floor((frameCount / elapsed) + 0.5), 1, 360)
                fpsM.Text = string.format("%.1f", currentFPS)
                wSub.Text = "REALTIME | " .. tostring(currentFPS) .. " FPS"
                frameCount = 0
                lastCheck = now

                if currentFPS > maxObservedFPS then
                    maxObservedFPS = math.max(60, currentFPS)
                end

                table.remove(fpsHistory, 1)
                table.insert(fpsHistory, currentFPS)

                for i, bar in ipairs(graphBars) do
                    local sample = fpsHistory[i] or 60
                    local targetHeight = math.clamp(sample / maxObservedFPS, 0.12, 0.98)
                    Tween(bar, 0.16, {Size = UDim2.new(0, 6, targetHeight, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                end
            end
        end)

        task.spawn(function()
            while task.wait(0.5) do
                if not MainWindow or not MainWindow.Parent then break end
                local elapsed = math.floor(tick() - startTime)
                sessM.Text = string.format("%02d:%02d", math.floor(elapsed / 60), elapsed % 60)
                plM.Text = tostring(#Players:GetPlayers()) .. " / " .. tostring(Players.MaxPlayers)
                pcall(function()
                    local p = math.floor(StatsService.Network.ServerStatsItem["Data Ping"]:GetValue())
                    pingM.Text = tostring(p) .. " ms"
                end)
            end
        end)

        local QuickBox = tabObj:CreateGroupBox("Right", "QUICK INSTANCE CONTROL", nil, StarHubUI.Icons.Refresh)
        QuickBox:AddActionRow("Reconnect Instance", "Rejoin current place server directly", StarHubUI.Icons.Refresh, function()
            StarHubUI:Notify({Title = "TELEPORT", Content = "Reconnecting to server...", Duration = 3})
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
        QuickBox:AddActionRow("Server Hop", "Relocate to lowest ping active instance", StarHubUI.Icons.Server, function()
            StarHubUI:Notify({Title = "SERVER HOP", Content = "Routing to optimal cluster instance...", Duration = 3})
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)
        QuickBox:AddActionRow("Discord Community", "Copy encrypted access link to clipboard", StarHubUI.Icons.Copy, function()
            WindowObj:ShowDiscordModal("https://discord.gg/aikaihub")
        end)
    end

    function WindowObj:CreateDualColumnSettings(tabObj)
        local ThemeBox = tabObj:CreateGroupBox("Left", "THEMES & ACCENT COLOR", "PALETTE", StarHubUI.Icons.Palette)

        ThemeBox:AddModeSelector("ACCENT COLOR STYLE", {"Gradient Mode", "Solid Mode"},
            (StarHubUI.Settings.AccentStyle == "Solid") and "Solid Mode" or "Gradient Mode",
            function(choice)
                StarHubUI.Settings.AccentStyle = choice:find("Solid") and "Solid" or "Gradient"
                UpdateLiveTheme()
                StarHubUI:Notify({
                    Title = "ACCENT STYLE CHANGED",
                    Content = "Rendering in " .. StarHubUI.Settings.AccentStyle .. " accent mode"
                })
                StarHubUI:AutoSave()
            end
        )

        local tList = {}
        for _, v in pairs(StarHubUI.Themes) do table.insert(tList, v.Name) end
        table.sort(tList)

        local p1Row, p2Row

        ThemeBox:AddDropdown("READY-MADE THEME PRESET", tList, Theme.Name, function(sel)
            for k, v in pairs(StarHubUI.Themes) do
                if v.Name == sel then
                    StarHubUI.Settings.CurrentTheme = k
                    Theme = v
                    UpdateLiveTheme()
                    if p1Row and p1Row.Set then p1Row.Set(Theme.Grad1 or Theme.Accent) end
                    if p2Row and p2Row.Set then p2Row.Set(Theme.Grad2 or Theme.AccentLight) end
                    StarHubUI:Notify({Title = "THEME CHANGED", Content = "Applied preset: " .. v.Name})
                    StarHubUI:AutoSave()
                    break
                end
            end
        end)

        ThemeBox:AddColorPalette(function(col1, col2, name)
            StarHubUI.Settings.CurrentTheme = "Custom"
            StarHubUI.Settings.CustomColor1 = ColorToHex(col1)
            StarHubUI.Settings.CustomColor2 = ColorToHex(col2)
            if p1Row and p1Row.Set then p1Row.Set(col1) end
            if p2Row and p2Row.Set then p2Row.Set(col2) end
            StarHubUI:AutoSave()
        end)

        p1Row = ThemeBox:AddColorPickerRow("PRIMARY ACCENT (COLOR 1)", Theme.Grad1 or Theme.Accent, function(newCol, hex)
            Theme.Accent = newCol
            Theme.Grad1 = newCol
            StarHubUI.Settings.CurrentTheme = "Custom"
            StarHubUI.Settings.CustomColor1 = hex
            if StarHubUI.Settings.AccentStyle == "Solid" then
                Theme.Grad2 = newCol
                Theme.AccentLight = newCol
                StarHubUI.Settings.CustomColor2 = hex
                if p2Row and p2Row.Set then p2Row.Set(newCol) end
            end
            UpdateLiveTheme()
            StarHubUI:Notify({Title = "PRIMARY COLOR 1 SET", Content = "Color 1 updated to: " .. hex})
            StarHubUI:AutoSave()
        end)

        p2Row = ThemeBox:AddColorPickerRow("SECONDARY ACCENT (COLOR 2)", Theme.Grad2 or Theme.AccentLight, function(newCol, hex)
            Theme.Grad2 = newCol
            Theme.AccentLight = newCol
            StarHubUI.Settings.CurrentTheme = "Custom"
            StarHubUI.Settings.CustomColor2 = hex
            UpdateLiveTheme()
            StarHubUI:Notify({Title = "SECONDARY COLOR 2 SET", Content = "Color 2 updated to: " .. hex})
            StarHubUI:AutoSave()
        end)

        local GlassBox = tabObj:CreateGroupBox("Left", "INTERFACE & WINDOW CONTROLS", nil, StarHubUI.Icons.Visuals)

        GlassBox:AddModeSelector("CONTROLS ALIGNMENT", {"Left (macOS)", "Right (Windows)"}, StarHubUI.Settings.ControlsPosition == "Left" and "Left (macOS)" or "Right (Windows)", function(pos)
            local p = pos:find("Left") and "Left" or "Right"
            SetControlsPosition(p)
            StarHubUI.Settings.ControlsPosition = p
            StarHubUI:Notify({Title = "LAYOUT CHANGED", Content = "Controls moved to: " .. pos})
            StarHubUI:AutoSave()
        end)

        GlassBox:AddActionRow("TEST NOTIFICATION", "Send sample Discord-style breakout notification", StarHubUI.Icons.Bell, function()
            StarHubUI:Notify({
                Title = "DISCORD STYLE NOTIFICATION",
                Content = "Breakout notification modal verified & active!",
                Duration = 3.5,
                Badge = "VERIFIED",
                BadgeColor = Color3.fromRGB(34, 197, 94),
                Icon = StarHubUI.Icons.Bell
            })
        end)

        GlassBox:AddActionRow("RESPONSIVE AUTO-SCALE", "Locked for PC (100%) & Auto-Fit for Mobile", StarHubUI.Icons.Zap, function()
            UpdateResponsiveScale()
            StarHubUI:Notify({Title = "RESPONSIVE SCALE", Content = "Display scale re-synchronized!", Badge = "SYSTEM"})
        end)

        GlassBox:AddToggle("SHOW FLOATING TOGGLE BUTTON", "Displays draggable Logo Squircle to open/close...", StarHubUI.Settings.ShowFloatingToggle, function(v)
            StarHubUI.Settings.ShowFloatingToggle = v
            FloatingSquircle.Visible = v
            StarHubUI:AutoSave()
        end)

        GlassBox:AddToggle("ACRYLIC GLASS EFFECT", "Enables translucent glowing backdrop...", StarHubUI.Settings.AcrylicEnabled, function(v)
            StarHubUI.Settings.AcrylicEnabled = v
            StarHubUI:AutoSave()
        end)

        GlassBox:AddSlider("WINDOW TRANSPARENCY", 0, 80, math.floor((StarHubUI.Settings.WindowTransparency or 0) * 100), "%", function(v)
            StarHubUI.Settings.WindowTransparency = v / 100
            MainWindow.BackgroundTransparency = v / 100
            StarHubUI:AutoSave()
        end)

        local AudioBox = tabObj:CreateGroupBox("Left", "AUDIO & HAPTICS", nil, StarHubUI.Icons.Zap)

        AudioBox:AddToggle("UI SOUND EFFECTS", "Toggle interactive Apple iOS Bubble audio on clicks and switches", StarHubUI.Settings.SoundEnabled, function(v)
            StarHubUI.Settings.SoundEnabled = v
            if v then PlaySound("ToggleOn") end
            StarHubUI:AutoSave()
        end)

        AudioBox:AddSlider("SOUND VOLUME", 0, 100, math.floor((StarHubUI.Settings.SoundVolume or 0.55) * 100), "%", function(v)
            StarHubUI.Settings.SoundVolume = v / 100
            StarHubUI:AutoSave()
        end)

        AudioBox:AddActionRow("TEST BUBBLE SOUND", "Play Apple iOS Bubble audio sequence", StarHubUI.Icons.Bell, function()
            PlaySound("ToggleOn")
            task.delay(0.16, function() PlaySound("Click") end)
            task.delay(0.32, function() PlaySound("Notify") end)
        end)

        local BrandBox = tabObj:CreateGroupBox("Right", "BRANDING & BACKGROUND", nil, StarHubUI.Icons.Logo)

        BrandBox:AddDropdown("BACKGROUND EFFECT", {
            "Floating Bubbles",
            "Matrix Cyber Rain",
            "Starlight Fireflies",
            "Fire Embers",
            "Snowfall Drift",
            "Subtle Ambient Glow",
            "Off (Clean Minimal)"
        }, StarHubUI.Settings.BackgroundEffect or "Floating Bubbles", function(sel)
            SetBackgroundEffect(sel)
            StarHubUI.Settings.BackgroundEffect = sel
            StarHubUI:Notify({Title = "BACKGROUND EFFECT", Content = "Active mode: " .. sel, Badge = "EFFECT"})
            StarHubUI:AutoSave()
        end)

        BrandBox:AddInput("CUSTOM LOGO...", "https://... or Decal ID", StarHubUI.Settings.CustomLogoUrl or "", function(txt)
            if txt and txt ~= "" then
                local res = LoadCustomImage(txt, StarHubUI.Icons.Logo)
                BrandIcon.Image = res
                flIcon.Image = res
                StarHubUI.Settings.CustomLogoUrl = txt
                StarHubUI:AutoSave()
            end
        end)

        BrandBox:AddInput("BACKGROUND...", "https://... or Decal ID", StarHubUI.Settings.CustomWallpaperId or "", function(txt)
            if txt and txt ~= "" then
                local res = LoadCustomImage(txt, "")
                CustomWallpaper.Image = res
                StarHubUI.Settings.CustomWallpaperId = txt
                StarHubUI:AutoSave()
            end
        end)

        BrandBox:AddSlider("BACKGROUND TRANSPARENCY", 0, 100, math.floor((StarHubUI.Settings.WallpaperTransparency or 0.92) * 100), "%", function(v)
            StarHubUI.Settings.WallpaperTransparency = v / 100
            CustomWallpaper.ImageTransparency = v / 100
            StarHubUI:AutoSave()
        end)

        BrandBox:AddSlider("WALLPAPER DIMMING", 0, 100, math.floor((StarHubUI.Settings.WallpaperDimming or 0.35) * 100), "%", function(v)
            StarHubUI.Settings.WallpaperDimming = v / 100
            local f = 1 - (v / 100)
            CustomWallpaper.ImageColor3 = Color3.fromRGB(math.floor(255 * f), math.floor(255 * f), math.floor(255 * f))
            StarHubUI:AutoSave()
        end)

        local ConfigBox = tabObj:CreateGroupBox("Right", "CONFIG & SYSTEM", nil, StarHubUI.Icons.Settings)

        ConfigBox:AddToggle("REAL-TIME AUTO SAVE", "Automatically saves all configuration changes to disk", StarHubUI.Settings.AutoSaveEnabled ~= false, function(v)
            StarHubUI.Settings.AutoSaveEnabled = v
            if v then
                StarHubUI:SaveConfig()
                StarHubUI:Notify({Title = "AUTO SAVE ENABLED", Content = "Real-time configuration auto-saving active!", Badge = "CONFIG"})
            else
                StarHubUI:Notify({Title = "AUTO SAVE PAUSED", Content = "Auto-save disabled. Use manual save button.", Badge = "CONFIG"})
            end
        end)

        ConfigBox:AddModeSelector("KEYBIND MODE", {"Toggle", "Hold", "Always"}, StarHubUI.Settings.KeybindMode, function(m)
            StarHubUI.Settings.KeybindMode = m
            StarHubUI:Notify({Title = "KEYBIND_MODE", Content = "Mode active: " .. m})
            StarHubUI:AutoSave()
        end)

        local kBtn = Instance.new("TextButton", ConfigBox.Container)
        kBtn.Size = UDim2.new(1, 0, 0, 28)
        kBtn.BackgroundColor3 = Theme.SubBox
        kBtn.Text = "TOGGLE KEY: " .. WindowObj.Keybind.Name
        kBtn.Font = Enum.Font.GothamBold
        kBtn.TextSize = 9.5
        kBtn.TextColor3 = Theme.AccentLight
        Instance.new("UICorner", kBtn).CornerRadius = UDim.new(0, 8)
        local kbStroke = Instance.new("UIStroke", kBtn)
        kbStroke.Color = Theme.Border
        RegisterElement("SubBoxes", kBtn)
        RegisterElement("Borders", kbStroke)
        RegisterElement("Accents", kBtn)

        local listening = false
        kBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            kBtn.Text = "PRESS ANY KEY..."
            kBtn.TextColor3 = Theme.TextTitle

            local conn
            conn = UserInputService.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.Keyboard then
                    WindowObj.Keybind = inp.KeyCode
                    StarHubUI.Settings.ToggleKey = inp.KeyCode.Name
                    kBtn.Text = "TOGGLE KEY: " .. inp.KeyCode.Name
                    if KeyPill and KeyPill.Parent then KeyPill.Text = inp.KeyCode.Name end
                    StarHubUI:Notify({Title = "KEYBIND UPDATED", Content = "Hub bind set to: " .. inp.KeyCode.Name})
                    StarHubUI:AutoSave()
                    conn:Disconnect()
                    listening = false
                end
            end)
        end)

        ConfigBox:AddActionRow("Save UI Settings", "Manually writes configuration to StarHubUI_Config.json", StarHubUI.Icons.Save, function()
            StarHubUI:SaveConfig()
            StarHubUI:Notify({Title = "CONFIG SAVED", Content = "Preferences saved to StarHubUI_Config.json!", Badge = "SAVED", Icon = StarHubUI.Icons.Save})
        end)

        ConfigBox:AddActionRow("Reset All Settings", "Deletes saved configuration and restores defaults", StarHubUI.Icons.Refresh, function()
            pcall(function()
                if isfile and delfile and isfile(ConfigFileName) then
                    delfile(ConfigFileName)
                end
            end)
            StarHubUI:Notify({Title = "RESET DEFAULTS", Content = "Saved config deleted! Reopen UI to apply defaults.", Badge = "RESET"})
        end)

        ConfigBox:AddDangerButton("Unload Script Hub", "Completely unloads UI and disconnects hooks", StarHubUI.Icons.Skull, function()
            local tw = Tween(MainWindow, 0.22, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
            tw.Completed:Connect(function() ScreenGui:Destroy() end)
        end)
    end

    return WindowObj
end

pcall(function()
    if getgenv then
        getgenv().StarHubUI = StarHubUI
    end
    _G.StarHubUI = StarHubUI
end)

if not _G.STARHUB_LIBRARY_ONLY then
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
        MoveBox:AddSlider("WalkSpeed Multiplier", 16, 150, 32, "SPD", function(v) end)
        MoveBox:AddSlider("Jump Power", 50, 300, 100, "PWR", function(v) end)
        MoveBox:AddToggle("Bunny Hop Glide", "Continuous momentum hopping across obstacles", true, function(v) end)
        MoveBox:AddToggle("Noclip Collision Bypass", "Allows walking through doors and barricades", false, function(v) end)
        MoveBox:AddToggle("Auto-Sprint Boost", "Maintains maximum velocity without holding shift", true, function(v) end)

        local VisualTab = Window:CreateTab({ Title = "Visuals & ESP", IconId = StarHubUI.Icons.Visuals, LayoutOrder = 4 })
        local EspBox = VisualTab:CreateGroupBox("Left", "PLAYER OVERLAYS", "ESP", StarHubUI.Icons.Visuals)
        EspBox:AddToggle("2D Bounding Brackets", "Projects corner frame around players", true, function(v) end)
        EspBox:AddToggle("Overhead Distance & Tags", "Displays distance in studs and health", true, function(v) end)
        EspBox:AddToggle("Dynamic Healthbars", "Displays colored dynamic health indicators", true, function(v) end)
        EspBox:AddToggle("Directional Snaplines", "Draws line from screen bottom to nearest target", false, function(v) end)

        local WorldBox = VisualTab:CreateGroupBox("Right", "RENDER THRESHOLDS", "WORLD", StarHubUI.Icons.Logo)
        WorldBox:AddSlider("Render Distance", 100, 3500, 1200, "STUDS", function(v) end)
        WorldBox:AddToggle("Occlusion Ray Check", "Shift color when target behind wall", true, function(v) end)
        WorldBox:AddToggle("Player Chams Highlight", "Silhouettes character models through walls", true, function(v) end)
        WorldBox:AddToggle("Fullbright Night Vision", "Removes shadows and maximizes map illumination", true, function(v) end)

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

        Window:AddNavHeader("PREFERENCES", 6)

        local SettingsTab = Window:CreateTab({ Title = "System & Theme", IconId = StarHubUI.Icons.Settings, LayoutOrder = 7 })
        Window:CreateDualColumnSettings(SettingsTab)

        StarHubUI:Notify({
            Title = "STARHUB v5.7 DEFINITIVE EDITION",
            Content = "Apple iOS Bubble Audio & 7 Particle Suites active!",
            Duration = 4
        })
    end

return StarHubUI
