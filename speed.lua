local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 180)
frame.Position = UDim2.new(0.5, -140, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui

local dragging = false
local dragStart = nil
local startPos = nil

local dragArea = Instance.new("Frame")
dragArea.Size = UDim2.new(1, 0, 0, 40)
dragArea.Position = UDim2.new(0, 0, 0, 0)
dragArea.BackgroundTransparency = 1
dragArea.Parent = frame

dragArea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

dragArea.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

dragArea.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 240, 0, 40)
speedBox.Position = UDim2.new(0, 20, 0, 50)
speedBox.PlaceholderText = "Enter Speed"
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedBox.Parent = frame

local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(0, 100, 0, 40)
saveButton.Position = UDim2.new(0, 90, 0, 100)
saveButton.Text = "Save"
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
saveButton.Parent = frame

local madeByText = Instance.new("TextLabel")
madeByText.Size = UDim2.new(0, 240, 0, 20)
madeByText.Position = UDim2.new(0, 20, 0, 160)
madeByText.Text = "Made by Kailkex"
madeByText.TextColor3 = Color3.fromRGB(255, 255, 255)
madeByText.TextSize = 14
madeByText.BackgroundTransparency = 1
madeByText.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(0, 250, 0, 10)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
closeButton.Parent = frame

closeButton.MouseButton1Click:Connect(function()
    frame:Destroy()
end)

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(0, 220, 0, 10)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimizeButton.Parent = frame

local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        frame.Size = UDim2.new(0, 280, 0, 40)
        speedBox.Visible = false
        saveButton.Visible = false
        madeByText.Visible = false
    else
        frame.Size = UDim2.new(0, 280, 0, 180)
        speedBox.Visible = true
        saveButton.Visible = true
        madeByText.Visible = true
    end
    isMinimized = not isMinimized
end)

local function changeSpeed()
    local speedValue = tonumber(speedBox.Text)
    if speedValue then
        if speedValue > 0 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
        else
            print("Speed must be greater than 0")
        end
    else
        print("Invalid speed value")
    end
end

saveButton.MouseButton1Click:Connect(changeSpeed)

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
end)
    end
    isMinimized = not isMinimized
end)

local function changeSpeed()
    local speedValue = tonumber(speedBox.Text)
    if speedValue then
        if speedValue > 0 then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
        else
            print("Speed must be greater than 0")
        end
    else
        print("Invalid speed value")
    end
end

saveButton.MouseButton1Click:Connect(changeSpeed)

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
end)
