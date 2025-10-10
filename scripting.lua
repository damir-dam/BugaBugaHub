local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))() 
local Window = Library.CreateLib("BugaBuga Hub - New Year Edition", "DarkTheme") 
local TweenService = game:GetService("TweenService") 

-- Снежинки (новогодний эффект)
for i = 1, 50 do 
    local snow = Instance.new("Frame") 
    snow.Size = UDim2.new(0, 5, 0, 5) 
    snow.Position = UDim2.new(math.random(), 0, -0.1, 0) 
    snow.BackgroundColor3 = Color3.new(1,1,1) 
    snow.BorderSizePixel = 0 
    snow.Parent = game.CoreGui 
    snow:ClearAllChildren() 
    local corner = Instance.new("UICorner", snow) 
    corner.CornerRadius = UDim.new(0.5, 0) 
    local tween = TweenService:Create(snow, TweenInfo.new(math.random(5,10), Enum.EasingStyle.Linear), {Position = UDim2.new(math.random(), 0, 1.1, 0)}) 
    tween:Play() 
    tween.Completed:Connect(function() snow:Destroy() end) 
end 

-- Переменные для функций
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChild("Humanoid")
local rootPart = character:FindFirstChild("HumanoidRootPart")
local flyEnabled = false
local speedEnabled = false
local aimbotEnabled = false
local espEnabled = false
local flyVelocity = nil
local espHighlights = {}

-- Функция Speed Hack
local function toggleSpeed(state)
    if state then
        speedEnabled = true
        if humanoid then
            humanoid.WalkSpeed = 100  -- Увеличенная скорость
        end
    else
        speedEnabled = false
        if humanoid then
            humanoid.WalkSpeed = 16  -- Стандартная скорость
        end
    end
end

-- Функция Fly
local function toggleFly(state)
    if state then
        flyEnabled = true
        flyVelocity = Instance.new("BodyVelocity")
        flyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        flyVelocity.Parent = rootPart
    else
        flyEnabled = false
        if flyVelocity then
            flyVelocity:Destroy()
            flyVelocity = nil
        end
    end
end

-- Функция Aimbot (простая версия для теста)
local function toggleAimbot(state)
    if state then
        aimbotEnabled = true
        local mouse = player:GetMouse()
        mouse.Button1Down:Connect(function()
            if aimbotEnabled then
                local target = mouse.Target
                if target and target.Parent:FindFirstChild("Humanoid") then
                    local targetRoot = target.Parent:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        rootPart.CFrame = CFrame.new(rootPart.Position, targetRoot.Position)
                    end
                end
            end
        end)
    else
        aimbotEnabled = false
    end
end

-- Функция ESP (подсветка игроков)
local function toggleESP(state)
    if state then
        espEnabled = true
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = plr.Character
                highlight.FillColor = Color3.new(1, 0, 0)  -- Красный цвет
                highlight.OutlineColor = Color3.new(0, 0, 0)
                highlight.Parent = plr.Character
                table.insert(espHighlights, highlight)
            end
        end
    else
        espEnabled = false
        for _, highlight in pairs(espHighlights) do
            highlight:Destroy()
        end
        espHighlights = {}
    end
end

-- Вкладка Main
local Main = Window:NewTab("Main")
Main:NewToggle("Speed Hack", "Увеличивает скорость ходьбы", function(state)
    toggleSpeed(state)
end)
Main:NewToggle("Fly", "Включает полёт", function(state)
    toggleFly(state)
end)
Main:NewToggle("Aimbot", "Авто-прицеливание (нажми ЛКМ)", function(state)
    toggleAimbot(state)
end)
Main:NewToggle("ESP", "Подсветка игроков", function(state)
    toggleESP(state)
end)

-- Вкладка Settings
local Settings = Window:NewTab("Settings")
Settings:NewLabel("Настройки хаба")
Settings:NewButton("Reset Speed", "Сбросить скорость до стандартной", function()
    if humanoid then
        humanoid.WalkSpeed = 16
    end
end)
Settings:NewButton("Reset Fly", "Отключить полёт", function()
    toggleFly(false)
end)
Settings:NewSlider("Walk Speed", "Настройка скорости (16-200)", 200, 16, function(value)
    if speedEnabled and humanoid then
        humanoid.WalkSpeed = value
    end
end)

-- Обновление персонажа при респавне
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:FindFirstChild("Humanoid")
    rootPart = character:FindFirstChild("HumanoidRootPart")
    if speedEnabled then toggleSpeed(true) end
    if flyEnabled then toggleFly(true) end
end)
