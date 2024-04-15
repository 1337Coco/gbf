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

            -- If stamina falls below maximum, handle accordingly
            if stamina < maxStamina then
                -- Handle low stamina condition here (e.g., perform an action or call a function)
                print("Stamina is not at maximum!")
            end
        end
    end

    -- Function to populate FruitMoves
    local function populateFruitMoves()
        FruitMoves = {}
        for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
            end
        end
    end

    -- Connect to player's equipped tool event
    LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
        -- Populate FruitMoves when a tool is equipped
        populateFruitMoves()
        -- Monitor stamina when a tool is equipped
        monitorStamina()
    end)

    -- Populate FruitMoves initially when LocalPlayer is added
    populateFruitMoves()

    -- Main logic function
    while true do
        wait(0.1)

        -- Move player to the specified coordinates
        if LocalPlayer.Character then
            LocalPlayer.Character:MoveTo(Vector3.new(-4773, 1349, -279))
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
