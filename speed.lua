local player = game:GetService("Players").LocalPlayer
local userInputService = game:GetService("UserInputService")

if not player then return end

-- Создание GUI
local screenGui = Instance.new("ScreenGui", player:FindFirstChildOfClass("PlayerGui"))

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 280, 0, 180)
frame.Position = UDim2.new(0.5, -140, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Active = true -- Разрешает перетаскивание

-- Поле для ввода скорости
local speedBox = Instance.new("TextBox", frame)
speedBox.Size = UDim2.new(0, 240, 0, 40)
speedBox.Position = UDim2.new(0, 20, 0, 50)
speedBox.PlaceholderText = "Enter Speed"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Кнопка "Сохранить"
local saveButton = Instance.new("TextButton", frame)
saveButton.Size = UDim2.new(0, 100, 0, 40)
saveButton.Position = UDim2.new(0, 90, 0, 100)
saveButton.Text = "Save"
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)

-- Надпись "Made by Kailkex"
local madeByText = Instance.new("TextLabel", frame)
madeByText.Size = UDim2.new(0, 240, 0, 20)
madeByText.Position = UDim2.new(0, 20, 0, 160)
madeByText.Text = "Made by Kailkex"
madeByText.TextColor3 = Color3.fromRGB(255, 255, 255)
madeByText.TextSize = 14
madeByText.BackgroundTransparency = 1

-- Кнопка закрытия
local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(0, 250, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Кнопка сворачивания
local minimizeButton = Instance.new("TextButton", frame)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(0, 220, 0, 10)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)

-- Функция изменения скорости
local function changeSpeed()
    local speedValue = tonumber(speedBox.Text)
    if speedValue and speedValue > 0 then
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speedValue
            end
        end
    else
        warn("Invalid speed value. Enter a number greater than 0.")
    end
end

-- Привязка события нажатия к кнопке
saveButton.MouseButton1Click:Connect(changeSpeed)

-- Обновление скорости после респауна
player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if humanoid then
        humanoid.WalkSpeed = tonumber(speedBox.Text) or humanoid.WalkSpeed
    end
end)

-- Функция перетаскивания
local dragging, dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

userInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Закрытие GUI
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Сворачивание GUI
local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    frame.Size = isMinimized and UDim2.new(0, 280, 0, 40) or UDim2.new(0, 280, 0, 180)
    speedBox.Visible = not isMinimized
    saveButton.Visible = not isMinimized
    madeByText.Visible = not isMinimized
end)
