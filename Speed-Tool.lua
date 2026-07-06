-- 모바일 전용 안정형 UI 라이브러리를 불러옵니다
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
-- 창 만들기
local Window = Library.CreateLib("⚡ SPEED HACK", "DarkTheme")

-- 탭 만들기
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Speed Settings")

local isSpeedOn = false
local TARGET_SPEED = 48
local DEFAULT_SPEED = 16

-- ON / OFF 토글 스위치 생성
Section:NewToggle("Speed 3x (48)", "Toggle your walkspeed", function(state)
    isSpeedOn = state
    if not isSpeedOn then
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = DEFAULT_SPEED
        end
    end
end)

-- 속도 무한 고정 루프
task.spawn(function()
    while true do
        task.wait(0.1)
        local player = game.Players.LocalPlayer
        if isSpeedOn and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid.WalkSpeed ~= TARGET_SPEED then
                humanoid.WalkSpeed = TARGET_SPEED
            end
        end
    end
end)
