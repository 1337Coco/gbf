if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local FruitMoves = {} -- Initializing FruitMoves table

    -- Function to handle player's death
    local function OnPlayerDied()
        print(LocalPlayer.Name .. " has died.")
        -- You may add custom death handling logic here if needed
    end

    -- Connect to player's death event
    LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(OnPlayerDied)

-- Function to monitor player's stamina
local function monitorStamina()
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local level = CurrentFruitLevel
        local maxStamina = level * 4 + 200

        -- Get the current stamina value
        local stamina = humanoid.Stamina

        -- Calculate the threshold for triggering the action (95% of max stamina)
        local threshold = 0.95 * maxStamina

        -- If stamina falls below the threshold, trigger the action
        if stamina < threshold then
            -- Trigger BreakJoints action here
            local Players = game:GetService("Players")

            local function breakJoints()
                local localPlayer = Players.LocalPlayer
                if localPlayer then
                    local character = localPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        if humanoid then
                            humanoid:TakeDamage(100000) -- This will break all joints
                        end
                    end
                end
            end

            breakJoints()
        end
    end
end


    -- Main logic function
    while true do
        wait(0.1)

        -- Check if FruitMoves is empty, then populate it
        if #FruitMoves == 0 then
            for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
                if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                    FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
                end
            end
        else
            -- Move player to the specified coordinates
            if LocalPlayer.Character then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
            end

            -- Use FruitMoves
            for i,v in pairs(FruitMoves) do
                if not LocalPlayer.Cooldowns:FindFirstChild(v) then
                    ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
                end
            end

            -- Monitor stamina periodically
            monitorStamina()
        end
    end
end
