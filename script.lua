-- XURRAS HUB - VERSÃO FINAL CORRIGIDA
-- Script 100% funcional sem bugs

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local MY_IMAGES = {
    FLOAT = "rbxassetid://14874671991",
}
local player = Players.LocalPlayer


-- ========================================
-- CONFIGURAÇÕES
-- ========================================

-- PLAYLIST DE MÚSICAS (ADICIONE AQUI)
local MUSIC_PLAYLIST = {
    {id = "136670750817264", name = "c418 aria"}
}

-- SEUS SCRIPTS (ADICIONE AQUI)
local MY_SCRIPTS = {
    {Name = "Infinite Yield", GameID = 9964090091, Source = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()]], Hot = true}
}

-- ÍCONES (emojis funcionam melhor)
local ICONS = {
    INFO = "ℹ️",
    SCRIPTS = "📜",
    MUSIC = "🎵",
    SEARCH = "🔍",
    PLAY = "▶️",
    PAUSE = "⏸️",
    NEXT = "⏭️",
    PREV = "⏮️",
    VOLUME_UP = "➕",
    VOLUME_DOWN = "➖",
    MINIMIZE = "➖",
    FLOAT = "🎮"
}

-- Variáveis globais
local currentMusicIndex = 1
local currentSound = nil
local isPaused = false
local volume = 0.5
local currentPage = nil

-- ========================================
-- CRIAR GUI
-- ========================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XurrasHubFinal"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botão Flutuante
local FloatButton = Instance.new("ImageButton")
FloatButton.Name = "FloatButton"
FloatButton.Image = MY_IMAGES.FLOAT
FloatButton.Size = UDim2.new(0, 70, 0, 70)
FloatButton.Position = UDim2.new(0.05, 0, 0.45, 0)
FloatButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
FloatButton.BorderSizePixel = 0
FloatButton.Visible = true -- Alterado para true para teste
FloatButton.Active = true
FloatButton.Parent = ScreenGui

-- Arredondar o botão (Opcional, mas fica bonito)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = FloatButton

---

-- 3. Sistema de Arraste (Drag System Moderno)
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    FloatButton.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

FloatButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

FloatButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatCorner.Parent = FloatButton

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(139, 92, 246)
FloatStroke.Thickness = 3
FloatStroke.Parent = FloatButton

-- Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 700, 0, 450)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 18, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(88, 101, 242)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 20)
HeaderCorner.Parent = Header

local HeaderCover = Instance.new("Frame")
HeaderCover.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
HeaderCover.BorderSizePixel = 0
HeaderCover.Position = UDim2.new(0, 0, 1, -20)
HeaderCover.Size = UDim2.new(1, 0, 0, 20)
HeaderCover.Parent = Header

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Position = UDim2.new(0, 20, 0, 10)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "XURRAS HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 300, 0, 20)
Subtitle.Position = UDim2.new(0, 20, 0, 35)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Adquira-em https://discord.gg/k6Eu4Gtrqb"
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 220)
Subtitle.TextSize = 12
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = Header

-- Botão Minimizar
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 35, 0, 35)
MinimizeBtn.Position = UDim2.new(1, -50, 0.5, -17)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(72, 187, 120)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = ICONS.MINIMIZE
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20
MinimizeBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1, 0)
MinCorner.Parent = MinimizeBtn

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 170, 1, -60)
Sidebar.Position = UDim2.new(0, 0, 0, 60)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 23, 30)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.Padding = UDim.new(0, 10)
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsLayout.Parent = Sidebar

local TabsPadding = Instance.new("UIPadding")
TabsPadding.PaddingTop = UDim.new(0, 20)
TabsPadding.Parent = Sidebar

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -180, 1, -70)
ContentContainer.Position = UDim2.new(0, 175, 0, 65)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- ========================================
-- FUNÇÕES DE PÁGINA
-- ========================================

local Pages = {}

local function createPage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.ScrollBarImageColor3 = Color3.fromRGB(88, 101, 242)
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Page.Parent = ContentContainer
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 12)
    PageLayout.Parent = Page
    
    Pages[name] = Page
    return Page
end

local function switchPage(pageName)
    for name, page in pairs(Pages) do
        page.Visible = (name == pageName)
    end
    currentPage = pageName
end

local function createTab(name, icon)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(0.9, 0, 0, 50)
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
    TabButton.BorderSizePixel = 0
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Text = "  " .. icon .. "  " .. name:upper()
    TabButton.TextColor3 = Color3.fromRGB(150, 150, 170)
    TabButton.TextSize = 14
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false
    TabButton.Parent = Sidebar
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)
    TabCorner.Parent = TabButton
    
    TabButton.MouseButton1Click:Connect(function()
        -- Resetar todas as tabs
        for _, tab in ipairs(Sidebar:GetChildren()) do
            if tab:IsA("TextButton") then
                tab.BackgroundColor3 = Color3.fromRGB(30, 35, 45)
                tab.TextColor3 = Color3.fromRGB(150, 150, 170)
            end
        end
        
        -- Ativar esta tab
        TabButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        -- Trocar página
        switchPage(name)
    end)
    
    return TabButton
end

-- ========================================
-- CRIAR PÁGINAS
-- ========================================

local InfoPage = createPage("Info")
local ScriptsPage = createPage("Scripts")
local MusicPage = createPage("Music")
local SearchPage = createPage("Search")

-- Criar Tabs
createTab("Info", ICONS.INFO)
createTab("Scripts", ICONS.SCRIPTS)
createTab("Music", ICONS.MUSIC)
createTab("Search", ICONS.SEARCH)

-- ========================================
-- PÁGINA INFO
-- ========================================

-- Card Usuário
local UserCard = Instance.new("Frame")
UserCard.Size = UDim2.new(1, -10, 0, 120)
UserCard.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
UserCard.BorderSizePixel = 0
UserCard.Parent = InfoPage

local UserCardCorner = Instance.new("UICorner")
UserCardCorner.CornerRadius = UDim.new(0, 15)
UserCardCorner.Parent = UserCard

local UserAvatar = Instance.new("ImageLabel")
UserAvatar.Size = UDim2.new(0, 80, 0, 80)
UserAvatar.Position = UDim2.new(0, 20, 0.5, -40)
UserAvatar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
UserAvatar.BorderSizePixel = 0
UserAvatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=150&height=150&format=png"
UserAvatar.Parent = UserCard

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = UserAvatar

local Username = Instance.new("TextLabel")
Username.Size = UDim2.new(1, -120, 0, 30)
Username.Position = UDim2.new(0, 110, 0, 20)
Username.BackgroundTransparency = 1
Username.Font = Enum.Font.GothamBold
Username.Text = "👤 " .. player.Name
Username.TextColor3 = Color3.fromRGB(255, 255, 255)
Username.TextSize = 18
Username.TextXAlignment = Enum.TextXAlignment.Left
Username.Parent = UserCard

local DisplayName = Instance.new("TextLabel")
DisplayName.Size = UDim2.new(1, -120, 0, 25)
DisplayName.Position = UDim2.new(0, 110, 0, 50)
DisplayName.BackgroundTransparency = 1
DisplayName.Font = Enum.Font.Gotham
DisplayName.Text = "Nome: " .. player.DisplayName
DisplayName.TextColor3 = Color3.fromRGB(180, 180, 200)
DisplayName.TextSize = 14
DisplayName.TextXAlignment = Enum.TextXAlignment.Left
DisplayName.Parent = UserCard

local UserID = Instance.new("TextLabel")
UserID.Size = UDim2.new(1, -120, 0, 25)
UserID.Position = UDim2.new(0, 110, 0, 75)
UserID.BackgroundTransparency = 1
UserID.Font = Enum.Font.Gotham
UserID.Text = "🆔 ID: " .. player.UserId
UserID.TextColor3 = Color3.fromRGB(88, 101, 242)
UserID.TextSize = 13
UserID.TextXAlignment = Enum.TextXAlignment.Left
UserID.Parent = UserCard

-- Card Jogo
local GameCard = Instance.new("Frame")
GameCard.Size = UDim2.new(1, -10, 0, 200)
GameCard.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
GameCard.BorderSizePixel = 0
GameCard.Parent = InfoPage

local GameCardCorner = Instance.new("UICorner")
GameCardCorner.CornerRadius = UDim.new(0, 15)
GameCardCorner.Parent = GameCard

local GameImage = Instance.new("ImageLabel")
GameImage.Size = UDim2.new(1, -20, 0, 120)
GameImage.Position = UDim2.new(0, 10, 0, 10)
GameImage.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
GameImage.BorderSizePixel = 0
GameImage.Image = "rbxthumb://type=Asset&id="..game.PlaceId.."&w=768&h=432"
GameImage.ScaleType = Enum.ScaleType.Crop
GameImage.Parent = GameCard

local GameImageCorner = Instance.new("UICorner")
GameImageCorner.CornerRadius = UDim.new(0, 12)
GameImageCorner.Parent = GameImage

local GameName = Instance.new("TextLabel")
GameName.Size = UDim2.new(1, -20, 0, 30)
GameName.Position = UDim2.new(0, 10, 0, 140)
GameName.BackgroundTransparency = 1
GameName.Font = Enum.Font.GothamBold
GameName.Text = "🎮 " .. game.Name
GameName.TextColor3 = Color3.fromRGB(255, 255, 255)
GameName.TextSize = 16
GameName.TextXAlignment = Enum.TextXAlignment.Left
GameName.TextTruncate = Enum.TextTruncate.AtEnd
GameName.Parent = GameCard

local GameID = Instance.new("TextLabel")
GameID.Size = UDim2.new(1, -20, 0, 25)
GameID.Position = UDim2.new(0, 10, 0, 170)
GameID.BackgroundTransparency = 1
GameID.Font = Enum.Font.Gotham
GameID.Text = "🆔 PlaceID: " .. game.PlaceId
GameID.TextColor3 = Color3.fromRGB(88, 101, 242)
GameID.TextSize = 14
GameID.TextXAlignment = Enum.TextXAlignment.Left
GameID.Parent = GameCard

spawn(function()
    local success, gameInfo = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and gameInfo then
        GameName.Text = "🎮 " .. gameInfo.Name
    end
end)

-- ========================================
-- PÁGINA SCRIPTS
-- ========================================

local function createScriptCard(scriptData)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 90)
    Card.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    Card.BorderSizePixel = 0
    Card.Parent = ScriptsPage
    
    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 12)
    CardCorner.Parent = Card
    
    local GameIcon = Instance.new("ImageLabel")
    GameIcon.Size = UDim2.new(0, 65, 0, 65)
    GameIcon.Position = UDim2.new(0, 15, 0.5, -32)
    GameIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    GameIcon.BorderSizePixel = 0
    GameIcon.Image = scriptData.GameID > 0 and ("rbxthumb://type=Asset&id="..scriptData.GameID.."&w=150&h=150") or ""
    GameIcon.Parent = Card
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 10)
    IconCorner.Parent = GameIcon
    
    local ScriptName = Instance.new("TextLabel")
    ScriptName.Size = UDim2.new(1, -210, 0, 30)
    ScriptName.Position = UDim2.new(0, 90, 0, 15)
    ScriptName.BackgroundTransparency = 1
    ScriptName.Font = Enum.Font.GothamBold
    ScriptName.Text = scriptData.Name:upper()
    ScriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptName.TextSize = 15
    ScriptName.TextXAlignment = Enum.TextXAlignment.Left
    ScriptName.TextTruncate = Enum.TextTruncate.AtEnd
    ScriptName.Parent = Card
    
    if scriptData.Hot then
        local HotBadge = Instance.new("TextLabel")
        HotBadge.Size = UDim2.new(0, 60, 0, 22)
        HotBadge.Position = UDim2.new(0, 90, 0, 48)
        HotBadge.BackgroundColor3 = Color3.fromRGB(245, 101, 101)
        HotBadge.BorderSizePixel = 0
        HotBadge.Font = Enum.Font.GothamBold
        HotBadge.Text = "🔥 HOT"
        HotBadge.TextColor3 = Color3.fromRGB(255, 255, 255)
        HotBadge.TextSize = 11
        HotBadge.Parent = Card
        
        local HotCorner = Instance.new("UICorner")
        HotCorner.CornerRadius = UDim.new(0, 11)
        HotCorner.Parent = HotBadge
    end
    
    local ExecuteBtn = Instance.new("TextButton")
    ExecuteBtn.Size = UDim2.new(0, 110, 0, 45)
    ExecuteBtn.Position = UDim2.new(1, -125, 0.5, -22)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(72, 187, 120)
    ExecuteBtn.BorderSizePixel = 0
    ExecuteBtn.Font = Enum.Font.GothamBold
    ExecuteBtn.Text = "▶ EXECUTAR"
    ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteBtn.TextSize = 14
    ExecuteBtn.AutoButtonColor = false
    ExecuteBtn.Parent = Card
    
    local ExecCorner = Instance.new("UICorner")
    ExecCorner.CornerRadius = UDim.new(0, 10)
    ExecCorner.Parent = ExecuteBtn
    
    ExecuteBtn.MouseButton1Click:Connect(function()
        ExecuteBtn.Text = "✓ EXECUTADO"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        
        pcall(function()
            loadstring(scriptData.Source)()
        end)
        
        task.wait(2)
        ExecuteBtn.Text = "▶ EXECUTAR"
        ExecuteBtn.BackgroundColor3 = Color3.fromRGB(72, 187, 120)
    end)
end

for _, script in ipairs(MY_SCRIPTS) do
    createScriptCard(script)
end

-- Continua na próxima parte...
-- PARTE 2: MÚSICA E PESQUISA

-- ========================================
-- PÁGINA MÚSICA
-- ========================================

local MusicPlayer = Instance.new("Frame")
MusicPlayer.Size = UDim2.new(1, -10, 0, 280)
MusicPlayer.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
MusicPlayer.BorderSizePixel = 0
MusicPlayer.Parent = MusicPage

local PlayerCorner = Instance.new("UICorner")
PlayerCorner.CornerRadius = UDim.new(0, 15)
PlayerCorner.Parent = MusicPlayer

local MusicTitle = Instance.new("TextLabel")
MusicTitle.Size = UDim2.new(1, -30, 0, 30)
MusicTitle.Position = UDim2.new(0, 15, 0, 15)
MusicTitle.BackgroundTransparency = 1
MusicTitle.Font = Enum.Font.GothamBold
MusicTitle.Text = "🎵 MUSIC PLAYER"
MusicTitle.TextColor3 = Color3.fromRGB(88, 101, 242)
MusicTitle.TextSize = 20
MusicTitle.TextXAlignment = Enum.TextXAlignment.Left
MusicTitle.Parent = MusicPlayer

local AlbumCover = Instance.new("Frame")
AlbumCover.Size = UDim2.new(0, 100, 0, 100)
AlbumCover.Position = UDim2.new(0, 20, 0, 55)
AlbumCover.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
AlbumCover.BorderSizePixel = 0
AlbumCover.Parent = MusicPlayer

local AlbumCorner = Instance.new("UICorner")
AlbumCorner.CornerRadius = UDim.new(0, 12)
AlbumCorner.Parent = AlbumCover

local AlbumIcon = Instance.new("TextLabel")
AlbumIcon.Size = UDim2.new(1, 0, 1, 0)
AlbumIcon.BackgroundTransparency = 1
AlbumIcon.Font = Enum.Font.GothamBold
AlbumIcon.Text = "🎵"
AlbumIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
AlbumIcon.TextSize = 50
AlbumIcon.Parent = AlbumCover

local CurrentMusicName = Instance.new("TextLabel")
CurrentMusicName.Size = UDim2.new(1, -140, 0, 30)
CurrentMusicName.Position = UDim2.new(0, 130, 0, 55)
CurrentMusicName.BackgroundTransparency = 1
CurrentMusicName.Font = Enum.Font.GothamBold
CurrentMusicName.Text = "Nenhuma música tocando"
CurrentMusicName.TextColor3 = Color3.fromRGB(255, 255, 255)
CurrentMusicName.TextSize = 16
CurrentMusicName.TextXAlignment = Enum.TextXAlignment.Left
CurrentMusicName.TextTruncate = Enum.TextTruncate.AtEnd
CurrentMusicName.Parent = MusicPlayer

local MusicTime = Instance.new("TextLabel")
MusicTime.Size = UDim2.new(1, -140, 0, 20)
MusicTime.Position = UDim2.new(0, 130, 0, 90)
MusicTime.BackgroundTransparency = 1
MusicTime.Font = Enum.Font.Gotham
MusicTime.Text = "0:00 / 0:00"
MusicTime.TextColor3 = Color3.fromRGB(150, 150, 170)
MusicTime.TextSize = 14
MusicTime.TextXAlignment = Enum.TextXAlignment.Left
MusicTime.Parent = MusicPlayer

local ProgressBG = Instance.new("Frame")
ProgressBG.Size = UDim2.new(1, -140, 0, 6)
ProgressBG.Position = UDim2.new(0, 130, 0, 120)
ProgressBG.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ProgressBG.BorderSizePixel = 0
ProgressBG.Parent = MusicPlayer

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(1, 0)
ProgressCorner.Parent = ProgressBG

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBG

local ProgressFillCorner = Instance.new("UICorner")
ProgressFillCorner.CornerRadius = UDim.new(1, 0)
ProgressFillCorner.Parent = ProgressFill

-- Botões
local function createMusicBtn(text, position, width, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width, 0, 45)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 20
    btn.AutoButtonColor = false
    btn.Parent = MusicPlayer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    return btn
end

local PrevBtn = createMusicBtn(ICONS.PREV, UDim2.new(0, 20, 0, 175), 80, Color3.fromRGB(60, 65, 80))
local PlayPauseBtn = createMusicBtn(ICONS.PLAY, UDim2.new(0, 110, 0, 175), 90, Color3.fromRGB(88, 101, 242))
local NextBtn = createMusicBtn(ICONS.NEXT, UDim2.new(0, 210, 0, 175), 80, Color3.fromRGB(60, 65, 80))

local VolumeLabel = Instance.new("TextLabel")
VolumeLabel.Size = UDim2.new(0, 120, 0, 25)
VolumeLabel.Position = UDim2.new(0, 310, 0, 180)
VolumeLabel.BackgroundTransparency = 1
VolumeLabel.Font = Enum.Font.GothamBold
VolumeLabel.Text = "🔊 Volume: 50%"
VolumeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
VolumeLabel.TextSize = 14
VolumeLabel.Parent = MusicPlayer

local VolumeDownBtn = createMusicBtn(ICONS.VOLUME_DOWN, UDim2.new(0, 440, 0, 175), 45, Color3.fromRGB(60, 65, 80))
local VolumeUpBtn = createMusicBtn(ICONS.VOLUME_UP, UDim2.new(0, 495, 0, 175), 45, Color3.fromRGB(60, 65, 80))

-- Funções de Música
local function formatTime(seconds)
    local mins = math.floor(seconds / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%d:%02d", mins, secs)
end

local function updateMusicDisplay()
    if currentSound and currentSound.Playing then
        local progress = currentSound.TimePosition / currentSound.TimeLength
        MusicTime.Text = formatTime(currentSound.TimePosition) .. " / " .. formatTime(currentSound.TimeLength)
        ProgressFill.Size = UDim2.new(progress, 0, 1, 0)
    end
end

local function playMusic(index)
    if currentSound then
        currentSound:Stop()
        currentSound:Destroy()
        currentSound = nil
    end
    
    if index < 1 then
        index = #MUSIC_PLAYLIST
    elseif index > #MUSIC_PLAYLIST then
        index = 1
    end
    
    currentMusicIndex = index
    local music = MUSIC_PLAYLIST[currentMusicIndex]
    
    currentSound = Instance.new("Sound")
    currentSound.Name = "XurrasMusic"
    currentSound.SoundId = "rbxassetid://" .. music.id
    currentSound.Volume = volume
    currentSound.Looped = false
    currentSound.Parent = workspace
    
    currentSound:Play()
    isPaused = false
    
    CurrentMusicName.Text = music.name
    PlayPauseBtn.Text = ICONS.PAUSE
    
    currentSound.Ended:Connect(function()
        playMusic(currentMusicIndex + 1)
    end)
end

PrevBtn.MouseButton1Click:Connect(function()
    playMusic(currentMusicIndex - 1)
end)

PlayPauseBtn.MouseButton1Click:Connect(function()
    if not currentSound then
        playMusic(1)
        return
    end
    
    if isPaused then
        currentSound:Resume()
        isPaused = false
        PlayPauseBtn.Text = ICONS.PAUSE
    else
        currentSound:Pause()
        isPaused = true
        PlayPauseBtn.Text = ICONS.PLAY
    end
end)

NextBtn.MouseButton1Click:Connect(function()
    playMusic(currentMusicIndex + 1)
end)

VolumeDownBtn.MouseButton1Click:Connect(function()
    volume = math.max(0, volume - 0.1)
    if currentSound then
        currentSound.Volume = volume
    end
    VolumeLabel.Text = string.format("🔊 Volume: %d%%", math.floor(volume * 100))
end)

VolumeUpBtn.MouseButton1Click:Connect(function()
    volume = math.min(1, volume + 0.1)
    if currentSound then
        currentSound.Volume = volume
    end
    VolumeLabel.Text = string.format("🔊 Volume: %d%%", math.floor(volume * 100))
end)

spawn(function()
    while task.wait(0.5) do
        if currentSound and currentSound.Playing then
            updateMusicDisplay()
        end
    end
end)

-- ========================================
-- PÁGINA PESQUISA
-- ========================================

local SearchInput = Instance.new("TextBox")
SearchInput.Size = UDim2.new(1, -10, 0, 50)
SearchInput.BackgroundColor3 = Color3.fromRGB(35, 40, 55)
SearchInput.BorderSizePixel = 0
SearchInput.Font = Enum.Font.GothamBold
SearchInput.PlaceholderText = "🔍 PESQUISAR POR NOME OU ID..."
SearchInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
SearchInput.Text = ""
SearchInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchInput.TextSize = 15
SearchInput.ClearTextOnFocus = false
SearchInput.Parent = SearchPage

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 12)
SearchCorner.Parent = SearchInput

local SearchPadding = Instance.new("UIPadding")
SearchPadding.PaddingLeft = UDim.new(0, 15)
SearchPadding.Parent = SearchInput

local SearchResults = Instance.new("Frame")
SearchResults.Size = UDim2.new(1, -10, 1, -60)
SearchResults.Position = UDim2.new(0, 0, 0, 60)
SearchResults.BackgroundTransparency = 1
SearchResults.Parent = SearchPage

local ResultsLayout = Instance.new("UIListLayout")
ResultsLayout.Padding = UDim.new(0, 10)
ResultsLayout.Parent = SearchResults

SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
    for _, child in ipairs(SearchResults:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    local query = SearchInput.Text:lower()
    
    if query == "" then
        return
    end
    
    for _, script in ipairs(MY_SCRIPTS) do
        local name = script.Name:lower()
        local id = tostring(script.GameID)
        
        if name:find(query) or id:find(query) then
            local ResultCard = Instance.new("Frame")
            ResultCard.Size = UDim2.new(1, 0, 0, 90)
            ResultCard.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
            ResultCard.BorderSizePixel = 0
            ResultCard.Parent = SearchResults
            
            local ResultCorner = Instance.new("UICorner")
            ResultCorner.CornerRadius = UDim.new(0, 12)
            ResultCorner.Parent = ResultCard
            
            local GameIcon = Instance.new("ImageLabel")
            GameIcon.Size = UDim2.new(0, 65, 0, 65)
            GameIcon.Position = UDim2.new(0, 15, 0.5, -32)
            GameIcon.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            GameIcon.BorderSizePixel = 0
            GameIcon.Image = script.GameID > 0 and ("rbxthumb://type=Asset&id="..script.GameID.."&w=150&h=150") or ""
            GameIcon.Parent = ResultCard
            
            local IconCorner = Instance.new("UICorner")
            IconCorner.CornerRadius = UDim.new(0, 10)
            IconCorner.Parent = GameIcon
            
            local ScriptName = Instance.new("TextLabel")
            ScriptName.Size = UDim2.new(1, -210, 0, 30)
            ScriptName.Position = UDim2.new(0, 90, 0, 15)
            ScriptName.BackgroundTransparency = 1
            ScriptName.Font = Enum.Font.GothamBold
            ScriptName.Text = script.Name:upper()
            ScriptName.TextColor3 = Color3.fromRGB(255, 255, 255)
            ScriptName.TextSize = 15
            ScriptName.TextXAlignment = Enum.TextXAlignment.Left
            ScriptName.TextTruncate = Enum.TextTruncate.AtEnd
            ScriptName.Parent = ResultCard
            
            local GameIDLabel = Instance.new("TextLabel")
            GameIDLabel.Size = UDim2.new(1, -210, 0, 20)
            GameIDLabel.Position = UDim2.new(0, 90, 0, 48)
            GameIDLabel.BackgroundTransparency = 1
            GameIDLabel.Font = Enum.Font.Gotham
            GameIDLabel.Text = "🆔 GameID: " .. script.GameID
            GameIDLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
            GameIDLabel.TextSize = 12
            GameIDLabel.TextXAlignment = Enum.TextXAlignment.Left
            GameIDLabel.Parent = ResultCard
            
            local ExecuteBtn = Instance.new("TextButton")
            ExecuteBtn.Size = UDim2.new(0, 110, 0, 45)
            ExecuteBtn.Position = UDim2.new(1, -125, 0.5, -22)
            ExecuteBtn.BackgroundColor3 = Color3.fromRGB(72, 187, 120)
            ExecuteBtn.BorderSizePixel = 0
            ExecuteBtn.Font = Enum.Font.GothamBold
            ExecuteBtn.Text = "▶ EXECUTAR"
            ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            ExecuteBtn.TextSize = 14
            ExecuteBtn.AutoButtonColor = false
            ExecuteBtn.Parent = ResultCard
            
            local ExecCorner = Instance.new("UICorner")
            ExecCorner.CornerRadius = UDim.new(0, 10)
            ExecCorner.Parent = ExecuteBtn
            
            ExecuteBtn.MouseButton1Click:Connect(function()
                ExecuteBtn.Text = "✓ EXECUTADO"
                ExecuteBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
                
                pcall(function()
                    loadstring(script.Source)()
                end)
                
                task.wait(2)
                ExecuteBtn.Text = "▶ EXECUTAR"
                ExecuteBtn.BackgroundColor3 = Color3.fromRGB(72, 187, 120)
            end)
        end
    end
end)

-- ========================================
-- EVENTOS MINIMIZAR/MAXIMIZAR
-- ========================================

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    FloatButton.Visible = true
end)

FloatButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    FloatButton.Visible = false
end)

-- ========================================
-- INICIALIZAÇÃO
-- ========================================

switchPage("Info")

game.StarterGui:SetCore("SendNotification", {
    Title = "✅ Xurras Hub";
    Text = "Bem-vindo, " .. player.Name .. "!";
    Duration = 5;
})

print("🎮 Xurras Hub carregado com sucesso!")
