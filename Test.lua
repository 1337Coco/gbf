if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local character = LocalPlayer.Character
    local UI = LocalPlayer.PlayerGui.UI
    
    -- Function to respawn the player
    local Respawn = function()
        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
        if (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()) and LocalPlayer.Character:WaitForChild("Humanoid", 10) then
            Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
            StarterGui:SetCoreGuiEnabled("Backpack", false)
            StarterGui:SetCoreGuiEnabled("PlayerList", false)
            StarterGui:SetCoreGuiEnabled("Chat", false)
        end
    end

    -- Continuously check player status and position
    while true do
        wait(0.1)
        game.Players.PlayerAdded:Connect(function(player)
        	player.CharacterRemoving:Connect(function(character)
        		Respawn()
        	end)
        end)
        -- Check if the player is dead and respawn if necessary
        CheckPlayerStatus()
        if #FruitMoves == 0 then
            for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
                if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                    FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
                end
            end
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)

            for i,v in pairs(FruitMoves) do
                if not LocalPlayer.Cooldowns:FindFirstChild(v) then
                    ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
                end
            end
        end
    end
end
