local StaminaUtils = require(game:GetService("ReplicatedStorage"):WaitForChild("StaminaUtils"))
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

    -- Check if the ProgressStamina element exists
    if progressStamina then
        -- Call the CheckStamina function from the imported file
        StaminaUtils.CheckStamina(progressStamina.Text, currentFruitLevel)
    else
        print("ProgressStamina element not found in PlayerGui.")
    end
