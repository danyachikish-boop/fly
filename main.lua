-- Создание главного окна или загрузка интерфейса
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Пример структуры твоего интерфейса (ScreenGui)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomWindow"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Главный контейнер (Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Скругление углов главного окна
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Картинка-фон (ImageLabel) с твоей рабочей ссылкой
local BgImage = Instance.new("ImageLabel")
BgImage.Name = "BgImage"
BgImage.Size = UDim2.new(1, 0, 1, 0)
BgImage.BackgroundTransparency = 1 -- Прозрачный фон под картинкой
BgImage.Image = "https://iili.io/n0QnS3J.jpg" -- Твоя прямая ссылка на изображение
BgImage.ScaleType = Enum.ScaleType.Slice -- Или Enum.ScaleType.Stretch в зависимости от того, как хочешь растянуть
BgImage.ZIndex = 0 -- Чтобы картинка была под остальными элементами
BgImage.Parent = MainFrame

-- Скругление для картинки, чтобы оно повторяло форму окна
local ImageCorner = Instance.new("UICorner")
ImageCorner.CornerRadius = UDim.new(0, 8)
ImageCorner.Parent = BgImage

-- Пример заголовка окна
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "Мое меню"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.ZIndex = 2
TitleLabel.Parent = MainFrame
