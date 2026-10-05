-- Удаляем старое окно, если оно уже запущено
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local UserInputService = game:GetService("UserInputService")

local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("CustomCheatHub") then
   PlayerGui.CustomCheatHub:Destroy()
end

-- Создание главного GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomCheatHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Плавающая кнопка-иконка слева
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "MenuIcon"
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -22)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleButton.BorderSizePixel = 0
ToggleButton.Draggable = true
ToggleButton.Text = "⚙"
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 128)
ToggleButton.TextSize = 22
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = ScreenGui

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = ToggleButton

-- Главное окно в стиле Glassmorphism (матовое стекло)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 460)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
MainFrame.BackgroundTransparency = 0.15 -- Красивая полупрозрачность
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Неоновая обводка окна
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(80, 80, 120)
UIStroke.Transparency = 0.5
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Логика сворачивания/разворачивания
local isOpen = true
ToggleButton.MouseButton1Click:Connect(function()
   isOpen = not isOpen
   MainFrame.Visible = isOpen
end)

-- Шапка окна
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.BackgroundTransparency = 0.3
Title.BorderSizePixel = 0
Title.Text = "  Custom Hub | Pro"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Контейнер элементов
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.Parent = MainFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 55)
Padding.PaddingLeft = UDim.new(0, 15)
Padding.PaddingRight = UDim.new(0, 15)
Padding.Parent = MainFrame

--------------------------------------------------
-- Компоненты UI
--------------------------------------------------
local function createToggle(name, callback)
   local btn = Instance.new("TextButton")
   btn.Size = UDim2.new(1, 0, 0, 40)
   btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
   btn.BackgroundTransparency = 0.4
   btn.BorderSizePixel = 0
   btn.Text = "   " .. name
   btn.TextColor3 = Color3.fromRGB(200, 200, 200)
   btn.TextSize = 13
   btn.Font = Enum.Font.GothamSemibold
   btn.TextXAlignment = Enum.TextXAlignment.Left
   
   local corner = Instance.new("UICorner")
   corner.CornerRadius = UDim.new(0, 8)
   corner.Parent = btn

   local indicator = Instance.new("Frame")
   indicator.Size = UDim2.new(0, 12, 0, 12)
   indicator.Position = UDim2.new(1, -25, 0.5, -6)
   indicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
   indicator.BorderSizePixel = 0
   indicator.Parent = btn
   
   local indCorner = Instance.new("UICorner")
   indCorner.CornerRadius = UDim.new(1, 0)
   indCorner.Parent = indicator

   local state = false
   btn.MouseButton1Click:Connect(function()
      state = not state
      if state then
         indicator.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
         btn.TextColor3 = Color3.fromRGB(255, 255, 255)
      else
         indicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
         btn.TextColor3 = Color3.fromRGB(200, 200, 200)
      end
      callback(state)
   end)
   
   btn.Parent = MainFrame
end

local function createTextBox(placeholder, callback)
   local box = Instance.new("TextBox")
   box.Size = UDim2.new(1, 0, 0, 35)
   box.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
   box.BackgroundTransparency = 0.5
   box.BorderSizePixel = 0
   box.PlaceholderText = placeholder
   box.Text = ""
   box.TextColor3 = Color3.fromRGB(255, 255, 255)
   box.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
   box.TextSize = 13
   box.Font = Enum.Font.Gotham
   
   local corner = Instance.new("UICorner")
   corner.CornerRadius = UDim.new(0, 8)
   corner.Parent = box
   
   box.FocusLost:Connect(function()
      local num = tonumber(box.Text)
      if num then
         num = math.clamp(num, 1, 1000)
         box.Text = tostring(num)
         callback(num)
      else
         box.Text = ""
      end
   end)
   
   box.Parent = MainFrame
end

--------------------------------------------------
-- Логика функций
--------------------------------------------------

-- 1. SpeedHack
local speedEnabled = false
local speedValue = 16

createToggle("SpeedHack", function(state)
   speedEnabled = state
end)
createTextBox("Скорость бега (1 - 1000)", function(val)
   speedValue = val
end)

RunService.RenderStepped:Connect(function()
   if speedEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
      LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
   end
end)

-- 2. Fly
local flyEnabled = false
local flySpeed = 50
local flyConnection = nil

createToggle("Fly (Полёт)", function(state)
   flyEnabled = state
   local char = LocalPlayer.Character
   if not char or not char:FindFirstChild("HumanoidRootPart") then return end
   
   local rootPart = char.HumanoidRootPart
   local humanoid = char:FindFirstChild("Humanoid")
   
   if flyEnabled then
      if humanoid then humanoid.PlatformStand = true end
      
      local bv = Instance.new("BodyVelocity")
      bv.Name = "CustomFlyVelocity"
      bv.Parent = rootPart
      bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      bv.Velocity = Vector3.new(0, 0, 0)
      
      local bg = Instance.new("BodyGyro")
      bg.Name = "CustomFlyGyro"
      bg.Parent = rootPart
      bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
      
      flyConnection = RunService.RenderStepped:Connect(function()
         if not flyEnabled or not rootPart.Parent then
            if flyConnection then flyConnection:Disconnect() end
            return
         end
         
         if Camera then
            bg.CFrame = Camera.CFrame
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + Camera.CFrame.RightVector end
            
            bv.Velocity = moveDirection * flySpeed
         end
      end)
   else
      if flyConnection then flyConnection:Disconnect() end
      if rootPart:FindFirstChild("CustomFlyVelocity") then rootPart.CustomFlyVelocity:Destroy() end
      if rootPart:FindFirstChild("CustomFlyGyro") then rootPart.CustomFlyGyro:Destroy() end
      if humanoid then humanoid.PlatformStand = false end
   end
end)
createTextBox("Скорость полёта (1 - 1000)", function(val)
   flySpeed = val
end)

-- 3. Noclip
local noclipEnabled = false
local noclipConnection = nil

createToggle("Noclip (Сквозь стены)", function(state)
   noclipEnabled = state
   if noclipEnabled then
      noclipConnection = RunService.Stepped:Connect(function()
         if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
               if part:IsA("BasePart") and part.CanCollide then
                  part.CanCollide = false
               end
            end
         end
      end)
   else
      if noclipConnection then
         noclipConnection:Disconnect()
         noclipConnection = nil
      end
   end
end)
