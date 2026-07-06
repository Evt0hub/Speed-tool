local tool = script.Parent
local DEFAULT_SPEED = 16
local BOOST_SPEED = DEFAULT_SPEED * 3

local function onEquip()
    local character = tool.Parent
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = BOOST_SPEED
        print(character.Name .. "님이 Speed 아이템을 장착하여 3배 빨라졌습니다!")
    end
end

local function onUnequip()
    local backpack = tool.Parent
    local player = backpack.Parent
    if player and player:FindFirstChild("Character") then
        local character = player.Character
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = DEFAULT_SPEED
            print(character.Name .. "님의 속도가 원래대로 돌아왔습니다.")
        end
    end
end

tool.Equipped:Connect(onEquip)
tool.Unequipped:Connect(onUnequip)
