-- script.lua (базовый GUI, вкладки пустые)
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("BugaBugaHub") then
    CoreGui.BugaBugaHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BugaBugaHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 600, 0, 400)
Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = Frame

local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = Frame
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TopBar.BorderSizePixel = 0

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 20)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Position = UDim2.new(0.5, 0, 0.5, 0)
Title.Size = UDim2.new(1, -20, 1, -10)
Title.BackgroundTransparency = 1
Title.Text = "BugaBugaHub 🎄🎉 Happy New Year! 🎉🎄"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextStrokeTransparency = 0.7
Title.TextWrapped = true

-- Контейнер для вкладок слева
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Parent = Frame
TabsFrame.Position = UDim2.new(0, 10, 0, 60)
TabsFrame.Size = UDim2.new(0, 140, 1, -70)
TabsFrame.BackgroundTransparency = 1

-- Контейнер для содержимого вкладок справа
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = Frame
ContentFrame.Position = UDim2.new(0, 160, 0, 60)
ContentFrame.Size = UDim2.new(1, -170, 1, -70)
ContentFrame.BackgroundTransparency = 1

-- Снежинки для новогоднего вайба
local Snowflakes = Instance.new("Frame")
Snowflakes.Name = "Snowflakes"
Snowflakes.Parent = Frame
Snowflakes.Size = UDim2.new(1, 0, 1, 0)
Snowflakes.BackgroundTransparency = 1

for i = 1, 20 do
    local Snowflake = Instance.new("TextLabel")
    Snowflake.Parent = Snowflakes
    Snowflake.Size = UDim2.new(0, 10, 0, 10)
    Snowflake.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Snowflake.BackgroundTransparency = 1
    Snowflake.Text = "❄"
    Snowflake.Font = Enum.Font.Gotham
    Snowflake.TextSize = 20
    Snowflake.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- Анимация падения снежинок
    local tween = game:GetService("TweenService"):Create(Snowflake, TweenInfo.new(5, Enum.EasingStyle.Linear), {Position = UDim2.new(Snowflake.Position.X.Scale, 0, 1, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        Snowflake.Position = UDim2.new(math.random(), 0, 0, 0)
        tween:Play()
    end)
end

-- Вспомогательная функция для создания кнопок вкладок
local function CreateTabButton(name, parent)
    local btn = Instance.new("TextButton")
    btn.Name = name.."Tab"
    btn.Parent = parent
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.AutoButtonColor = false

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    btn.MouseLeave:Connect(function()
        if not btn:GetAttribute("Selected") then
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        end
    end)

    return btn
end

-- Вспомогательная функция для очистки контента
local function ClearContent()
    for _, child in pairs(ContentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

-- Переменная для хранения текущей вкладки
local currentTab = nil

-- Функция переключения вкладок (пока пустые)
local function SwitchTab(tabName)
    if currentTab == tabName then return end
    currentTab = tabName

    -- Сброс выделения кнопок
    for _, btn in pairs(TabsFrame:GetChildren()) do
        if btn:IsA("TextButton") then
            btn:SetAttribute("Selected", false)
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        end
    end

    -- Выделяем активную кнопку
    local activeBtn = TabsFrame:FindFirstChild(tabName.."Tab")
    if activeBtn then
        activeBtn:SetAttribute("Selected", true)
        activeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end

    ClearContent()

    -- Здесь пока ничего нет — вкладки пустые
end

-- Создание кнопок вкладок
local mainTab = CreateTabButton("Main", TabsFrame)
mainTab.Position = UDim2.new(0, 0, 0, 0)
local speedHackTab = CreateTabButton("Speed Hack", TabsFrame)
speedHackTab.Position = UDim2.new(0, 0, 0, 50)
local flyTab = CreateTabButton("Fly", TabsFrame)
flyTab.Position = UDim2.new(0, 0, 0, 100)
local aimbotTab = CreateTabButton("Aimbot", TabsFrame)
aimbotTab.Position = UDim2.new(0, 0, 0, 150)
local espTab = CreateTabButton("ESP", TabsFrame)
espTab.Position = UDim2.new(0, 0, 0, 200)
local settingsTab = CreateTabButton("Settings", TabsFrame)
settingsTab.Position = UDim2.new(0, 0, 0, 250)

-- Подключение переключения вкладок
mainTab.MouseButton1Click:Connect(function() SwitchTab("Main") end)
speedHackTab.MouseButton1Click:Connect(function() SwitchTab("Speed Hack") end)
flyTab.MouseButton1Click:Connect(function() SwitchTab("Fly") end)
aimbotTab.MouseButton1Click:Connect(function() SwitchTab("Aimbot") end)
espTab.MouseButton1Click:Connect(function() SwitchTab("ESP") end)
settingsTab.MouseButton1Click:Connect(function() SwitchTab("Settings") end)

-- Активация первой вкладки по умолчанию
SwitchTab("Main")

-- Логика перетаскивания окна
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

print("BugaBugaHub GUI loaded!")
