print('check')
-- Get the LocalPlayer
local player = game.Players.LocalPlayer

-- Extracting data for the equipped fruit
local mainData = player:WaitForChild("MAIN_DATA")
local slotValue = mainData:WaitForChild("Slot").Value
local slotData = mainData:WaitForChild("Slots")
local currentSlot = slotData[slotValue]
local currentFruitName = currentSlot.Value

local fruitsData = mainData:WaitForChild("Fruits")
local currentFruitData = fruitsData:WaitForChild(currentFruitName)
local currentFruitLevel = currentFruitData.Level.Value

-- Find the ProgressStamina element within PlayerGui
local progressStamina = player.PlayerGui.UI.HUD.Bars.ProgressStamina

local function CheckStamina(progressStaminaText, currentFruitLevel)
    if progressStaminaText then
        -- Trim the last 5 characters from the ProgressStamina text
        local trimmedText = progressStaminaText:sub(1, #progressStaminaText - 5) -- Trims 5 characters from the right
        
        -- Convert the trimmed text to a number (currentStamina)
        local currentStamina = tonumber(trimmedText)
        
        -- Function to calculate maxStamina
        local function calculateMaxStamina(level)
            return level * 4 + 200
        end
        
        -- Calculate maxStamina based on currentFruitLevel
        local maxStamina = calculateMaxStamina(currentFruitLevel)
        
        -- Calculate the percentage of currentStamina relative to maxStamina
        local percentageRemaining = (currentStamina / maxStamina) * 100
        
        -- Define the threshold percentage
        local thresholdPercentage = 10
        
        -- Check if the percentage remaining is below the threshold
        if percentageRemaining <= thresholdPercentage then
            -- Perform an action when currentStamina is low
            print("Current stamina is low. Performing action...")
            player.Character:BreakJoints()
        end
    end
end

return {
    CheckStamina = CheckStamina
}
