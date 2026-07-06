local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 중복 생성 방지
if playerGui:FindFirstChild("EvtSpeedGui") then
    playerGui.EvtSpeedGui:Destroy()
end

-- 1. 메인 GUI 생성
local sg = Instance.new("ScreenGui")
sg.Name = "EvtSpeedGui"
sg.ResetOnSpawn = false
sg.Parent = playerGui

-- 2. 메인 조절 창 (made by evt_all)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 140, 0, 75)
frame.Position = UDim2.new(0.03, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = true -- 처음에 켜진 상태로 시작
frame.Parent = sg

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = frame

-- 타이틀 (made by evt_all)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.75, 0, 0.4, 0)
title.Position = UDim2.new(0.05, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "made by evt_all"
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.SourceSansBold
title.Parent = frame

-- ON/OFF 스위치 버튼
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.85, 0, 0.45, 0)
button.Position = UDim2.new(0.075, 0, 0.45, 0)
button.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
button.Text = "SPEED OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 14
button.Font = Enum.Font.SourceSansBold
button.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = button

-- 창 닫기 버튼 (작은 X 버튼)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(0.82, 0, 0.1, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(150, 150, 150)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = frame

----------------------------------------------------
-- 3. 숨겨졌을 때 나타날 'evt' 네모 박스 아이콘 생성
----------------------------------------------------
local iconButton = Instance.new("TextButton")
iconButton.Size = UDim2.new(0, 40, 0, 30) -- 콤팩트한 네모 크기
iconButton.Position = UDim2.new(0.03, 0, 0.2, 0) -- 메인 창과 같은 위치
iconButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- 어두운 회색 박스
iconButton.BorderSizePixel = 0
iconButton.Text = "evt"
iconButton.TextColor3 = Color3.fromRGB(255, 255, 255) -- 하얀색 글씨
iconButton.TextSize = 14
iconButton.Font = Enum.Font.SourceSansBold
iconButton.Visible = false -- 처음엔 메인 창이 켜져 있으므로 숨김
iconButton.Parent = sg

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 5) -- 살짝 부드러운 네모 모서리
iconCorner.Parent = iconButton

----------------------------------------------------
-- 기능 및 이벤트 연동 파트
----------------------------------------------------
local isSpeedOn = false
local TARGET_SPEED = 48
local DEFAULT_SPEED = 16

-- 무한 속도 고정 루프
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

-- ON/OFF 스위치 기능
button.MouseButton1Click:Connect(function()
    isSpeedOn = not isSpeedOn
    if isSpeedOn then
        button.Text = "SPEED ON"
        button.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
    else
        button.Text = "SPEED OFF"
        button.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = DEFAULT_SPEED
        end
    end
end)

-- [X] 버튼 누르면 메인 창 숨기고 'evt' 네모 박스 띄우기
closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    iconButton.Visible = true
end)

-- 'evt' 네모 박스 누르면 다시 메인 창 켜기
iconButton.MouseButton1Click:Connect(function()
    iconButton.Visible = false
    frame.Visible = true
end
