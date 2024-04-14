if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer.PlayerGui
	local character = LocalPlayer.Character

    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)

    local FruitMoves = {}

    while true do
        wait(0.25)

        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
		require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
			if (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()) and LocalPlayer.Character:WaitForChild("Humanoid", 10) then
				Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
				StarterGui:SetCoreGuiEnabled("Backpack", false)
				StarterGui:SetCoreGuiEnabled("PlayerList", false)
				StarterGui:SetCoreGuiEnabled("Chat", false)
			end
			
		if character and character:FindFirstChild("HumanoidRootPart") then
        -- Move the player to the specified position if not already there
			if character.HumanoidRootPart.Position ~= Vector3.new(-4773, 1349, -279) then
				character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
			else
				if #FruitMoves == 0 then
					for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
						if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                    FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
						end
					end
				else
            
				for i,v in pairs(FruitMoves) do
					if not LocalPlayer.Cooldowns:FindFirstChild(v) then
						ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
					end
				end
				end
			end
		end

    end --wow
end
