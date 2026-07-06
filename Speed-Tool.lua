local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- 1. 창 생성 (창이 무조건 뜨도록 설정)
local Window = Library.CreateLib("made by evt_all", "DarkTheme")

local player = game.Players.LocalPlayer
local isSpeedOn = false
local TARGET_SPEED = 48
local DEFAULT_SPEED = 16

-- 2. 기능 넣기
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Speed Controller")

Section:NewToggle("Speed 3x (48)", "Turn speed hack on/off", function(state)
    isSpeedOn = state
    if not isSpeedOn then
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = DEFAULT_SPEED
        end
    end
end)

-- 3. 스피드 루프
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
-- 📱 모바일 강제 노출 및 닫기 연동 최적화
----------------------------------------------------
local playerGui = player:WaitForChild("PlayerGui")
local coreGui = playerGui:WaitForChild("Kavo", 10)

if coreGui then
    local mainFrame = coreGui:WaitForChild("Main", 5)
    
    -- 무조건 화면에 크게 보이도록 강제 시작 설정
    if mainFrame then
        mainFrame.Visible = true
    end

    -- 미니 번개 아이콘 미리 생성해두기
    local openButton = Instance.new("TextButton")
    openButton.Name = "MiniMenuIcon"
    openButton.Size = UDim2.new(0, 45, 0, 45) 
    openButton.Position = UDim2.new(0.02, 0, 0.3, 0) 
    openButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    openButton.Text = "⚡"
    openButton.TextColor3 = Color3.fromRGB(255, 255, 0) 
    openButton.TextSize = 20
    openButton.BorderSizePixel = 0
    openButton.Visible = false -- 처음엔 창이 열려있으니 숨김
    openButton.Parent = coreGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 50) 
    corner.Parent = openButton

    -- 번개 누르면 창 다시 열리기
    openButton.MouseButton1Click:Connect(function()
        if mainFrame then
            mainFrame.Visible = true
            openButton.Visible = false
        end
    end)

    -- 창의 상태를 실시간 감시해서 숨기기/보이기 전환
    task.spawn(function()
        while true do
            task.wait(0.2)
            if mainFrame then
                if mainFrame.Visible == false then
                    openButton.Visible = true
                else
                    openButton.Visible = false
                end
            end
        end
    end)
end
