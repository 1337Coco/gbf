if game.PlaceId == 16190471004 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer.PlayerGui

    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)

    local FruitMoves = {}

    -- Function to teleport to a specific placeId
    local function TeleportToPlace(placeId)
        local TeleportService = game:GetService("TeleportService")
        local success, errorMessage = pcall(function()
            TeleportService:Teleport(placeId)
        end)
        
        if not success then
            warn("Teleport failed:", errorMessage)
        end
    end

    -- Teleport to Whole Cake (placeId: 16190471004) if the equipped fruit's level is greater than or equal to 100
    local CurrentFruitLevel = CurrentData.Level.Value
    if CurrentFruitLevel >= 100 then
        TeleportToPlace(16190471004) -- Replace this with your desired placeId
    end

    while true do
        wait(0.25)

        if PlayerGui:FindFirstChild("UI") and not PlayerGui.UI.HUD.Visible then
            return
        end
        if LocalPlayer.Character.Stats:GetAttribute("Stamina") <= 50 then
            return
        end

        if #FruitMoves == 0 then
            for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
                if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                    FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
                end
            end
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(122, 149, -1264)

            for i,v in pairs(FruitMoves) do
                if not LocalPlayer.Cooldowns:FindFirstChild(v) then
                    ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
                end
            end
        end
    end
end
