local player = game:GetService("Players").LocalPlayer
local TARGET_SPEED = 48

print("스피드 3배 핵 스크립트가 활성화되었습니다.")

task.spawn(function()
    while true do
        task.wait(0.1)
        if player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid.WalkSpeed ~= TARGET_SPEED then
                humanoid.WalkSpeed = TARGET_SPEED
            end
        end
    end
end)
