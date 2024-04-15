if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local FruitMoves = {} -- Initializing FruitMoves table
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local level = 0 -- Initialize level to 0

    if humanoid then
        level = CurrentData.Level.Value
    else
        warn("Subject_Character not found!")
    end

    if level == 0 then
        warn("Level not found!")
    end

    -- Main logic function
    while true do
        wait(0.1)

        -- Always populate FruitMoves
        FruitMoves = {}
        for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
            if tool.ClassName == "Tool" and tool.Name ~= "Enthral Grasp" and CurrentData.Level.Value >= tool:GetAttribute("Level") then
                FruitMoves[#FruitMoves + 1] = string.gsub(tool.Name, " ", "")
            end
        end

        -- Move player to the specified coordinates
        if LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
        end

        -- Use FruitMoves
        for _, toolName in ipairs(FruitMoves) do
            if not LocalPlayer.Cooldowns:FindFirstChild(toolName) then
                ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, toolName, {})
            end
        end
    end

    -- Check stamina and break joints if necessary
    local function checkStamina()
        while true do
            wait(0.5) -- Adjust the interval as needed

            if humanoid and level ~= 0 then
                local maxStamina = level * 4 + 200
                local stamina = humanoid.Stamina

                if Percent(stamina, maxStamina) <= 0.95 then
                    LocalPlayer.Character:BreakJoints()
                end
            end
        end
    end

    coroutine.wrap(checkStamina)()
end
