if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local FruitMoves = {} -- Initializing FruitMoves table
    local character = LocalPlayer.Character

    -- Function to handle player's death
    local function OnPlayerDied()
        print(LocalPlayer.Name .. " has died.")
        -- You may add custom death handling logic here if needed
    end

    -- Connect to player's death event
    LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(OnPlayerDied)

    -- Monitor stamina periodically
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        local level = CurrentFruitLevel
        local maxStamina = level * 4 + 200

        -- Get the current stamina value
        local stamina = humanoid.Stamina

        -- Calculate the threshold for triggering the action (95% of max stamina)
        local threshold = 0.95 * maxStamina

        local function breakJoints()
            if localPlayer then
                character = localPlayer.Character
                if character then
                    humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:TakeDamage(100000) -- This will break all joints
                    end
                end
            end
        end

        breakJoints()
    end

    -- Main logic function
    while true do
        wait(0.1)

        -- Always populate FruitMoves
        FruitMoves = {}
        for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" and v.Name ~= "Enthral Grasp" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
            end
        end

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

        -- Check stamina and break joints if necessary
        if humanoid then
            stamina = humanoid.Stamina

            if stamina < threshold then
                breakJoints()
            end
        end
    end
end
