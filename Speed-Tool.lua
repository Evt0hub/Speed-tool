local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- 창 제목을 'made by evt_all'로 설정
local Window = Library.CreateLib("made by evt_all", "DarkTheme")

Library:ToggleUI() 

local player = game.Players.LocalPlayer
local isSpeedOn = false
local TARGET_SPEED = 48
local DEFAULT_SPEED = 16

-- 메인 기능 탭
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Speed Controller")

-- ON/OFF 스위치
Section:NewToggle("Speed 3x (48)", "Turn speed hack on/off", function(state)
    isSpeedOn = state
    if not isSpeedOn then
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = DEFAULT_SPEED
        end
    end
end)

-- 속도 무한 고정 루프
task.spawn(function()
    while true do
        task.wait(0.1)
        if isSpeedOn and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid.WalkSpeed ~= TARGET_SPEED then
                humanoid.WalkSpeed = TARGET_SPEED
            end
        end
    end
end)

----------------------------------------------------
-- 📱 모바일 전용: 창 닫기 / 아이콘 변환 커스텀 버튼
----------------------------------------------------
local playerGui = player:WaitForChild("PlayerGui")
local coreGui = playerGui:FindFirstChild("Kavo") or playerGui:WaitForChild("Kavo", 5)

if coreGui then
    local openButton = Instance.new("TextButton")
    openButton.Name = "MiniMenuIcon"
    openButton.Size = UDim2.new(0, 45, 0, 45) 
    openButton.Position = UDim2.new(0.02, 0, 0.3, 0) 
    openButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    openButton.Text = "⚡"
    openButton.TextColor3 = Color3.fromRGB(255, 255, 0) 
    openButton.TextSize = 20
    openButton.BorderSizePixel = 0
    openButton.Parent = coreGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 50) 
    corner.Parent = openButton

    local mainFrame = coreGui:FindFirstChild("Main")
    
    if mainFrame then
        openButton.Visible = false
    end

    openButton.MouseButton1Click:Connect(function()
        if mainFrame then
            mainFrame.Visible = true
            openButton.Visible = false 
        end
    end)

    task.spawn(function()
        while true do
            task.wait(0.2)
            if mainFrame and mainFrame.Visible == false then
                openButton.Visible = true 
            end
        end
    end)
end
