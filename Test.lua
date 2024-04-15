if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer.PlayerGui

    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)

    local FruitMoves = {}

    -- Get the LocalPlayer
    local Player = game.Players.LocalPlayer

    -- Extracting data for the equipped fruit
    local MainData = Player:WaitForChild("MAIN_DATA")
    local SlotValue = MainData:WaitForChild("Slot").Value
    local SlotData = MainData:WaitForChild("Slots")
    local CurrentSlot = SlotData[SlotValue]
    local CurrentFruitName = CurrentSlot.Value

    local FruitsData = MainData:WaitForChild("Fruits")
    local CurrentFruitData = FruitsData:WaitForChild(CurrentFruitName)
    local CurrentFruitLevel = CurrentFruitData.Level.Value

    -- Find the ProgressStamina element within PlayerGui
    local ProgressStamina = Player.PlayerGui.UI.HUD.Bars.ProgressStamina

    local function CheckStamina(progressStaminaText, currentFruitLevel)
        if progressStaminaText then
            -- Trim the last 5 characters from the ProgressStamina text
            local TrimmedText = progressStaminaText:sub(1, #progressStaminaText - 5) -- Trims 5 characters from the right
            
            -- Convert the trimmed text to a number (currentStamina)
            local CurrentStamina = tonumber(TrimmedText)
            
            -- Function to calculate maxStamina
            local function CalculateMaxStamina(level)
                return level * 4 + 200
            end
            
            -- Calculate maxStamina based on currentFruitLevel
            local MaxStamina = CalculateMaxStamina(currentFruitLevel)
            
            -- Calculate the percentage of currentStamina relative to maxStamina
            local PercentageRemaining = (CurrentStamina / MaxStamina) * 100
            
            -- Define the threshold percentage
            local ThresholdPercentage = 10
            
            -- Check if the percentage remaining is below the threshold
            if PercentageRemaining <= ThresholdPercentage then
                -- Perform an action when currentStamina is low
                print("Current stamina is low. Performing action...")
                Player.Character:BreakJoints()
            end
        end
    end

    -- Coroutine for looping FruitMoves
    local function MoveFruits()
        while true do
            for i,v in pairs(FruitMoves) do
                if not LocalPlayer.Cooldowns:FindFirstChild(v) then
                    ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
                end
                wait(0.1) -- Adjust the wait time as needed
            end
        end
    end

    -- Coroutine for checking stamina
    local function CheckStaminaCoroutine()
        while true do
            wait(1) -- Adjust the wait time as needed
            CheckStamina(ProgressStamina, CurrentFruitLevel)
        end
    end

    -- Reset FruitMoves when player joins or respawns
    LocalPlayer.Added:Connect(function()
        FruitMoves = {}
    end)

    -- Start FruitMoves coroutine
    coroutine.wrap(MoveFruits)()

    -- Start CheckStamina coroutine
    coroutine.wrap(CheckStaminaCoroutine)()

    -- Main loop for other tasks
    while true do
        wait(0.1)
        
        -- Populate FruitMoves
        for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
            end
        end
    end
end
