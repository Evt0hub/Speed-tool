local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("SpeedGui") then
    playerGui.SpeedGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.1, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 2
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.4, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ SPEED HACK"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0.4, 0)
button.Position = UDim2.new(0.1, 0, 0.5, 0)
button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
button.Text = "OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 20
button.Font = Enum.Font.SourceSansBold
button.Parent = frame

local isSpeedOn = false
local TARGET_SPEED = 48
local DEFAULT_SPEED = 16

task.spawn(function()
    while true do
        task.wait(0.1)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if isSpeedOn then
                if humanoid.WalkSpeed ~= TARGET_SPEED then
                    humanoid.WalkSpeed = TARGET_SPEED
                end
            else
                if humanoid.WalkSpeed == TARGET_SPEED then
                    humanoid.WalkSpeed = DEFAULT_SPEED
                end
            end
        end
    end
end)

button.MouseButton1Click:Connect(function()
    isSpeedOn = not isSpeedOn
    if isSpeedOn then
        button.Text = "ON"
        button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        button.Text = "OFF"
        button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = DEFAULT_SPEED
        end
    end
end
