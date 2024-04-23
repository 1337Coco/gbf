local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer -- Assuming you're trying to get the local player

local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
local SlotValue = MainData:WaitForChild("Slot").Value
local SlotData = MainData:WaitForChild("Slots"):FindFirstChild(tostring(SlotValue)) -- Corrected indexing

if SlotData then -- Checking if SlotData exists
    local CurrentSlot = SlotData.Value
    local FruitsData = MainData:WaitForChild("Fruits")
    local CurrentFruitData = FruitsData:WaitForChild(CurrentSlot)
    local CurrentFruitLevel = CurrentFruitData.Level.Value

    if CurrentFruitLevel >= 100 and game.PlaceId == 9224601490 then
        TeleportToPlace(16190471004) -- Whole Cake
    elseif CurrentFruitLevel >= 200 and game.PlaceId == 16190471004 then
        game:GetService("TeleportService"):Teleport(12413901502, LocalPlayer)
    end
else
    warn("SlotData not found!")
end
