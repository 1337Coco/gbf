-- WORKING OMG MFKERS
if game.PlaceId == 12413901502 then
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local StarterGui = game:GetService("StarterGui")
	local Workspace = game:GetService("Workspace")
	local MainData = LocalPlayer.MAIN_DATA
	local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
	local FruitMoves = {} -- Initializing FruitMoves table
	
	--[[local function playerXYZ()
		-- Move LocalPlayer to the specified coordinates
			if LocalPlayer.Character then
				while true do
					task.wait(6)
					LocalPlayer.Character:MoveTo(Vector3.new(-4773, 1349, -279))
				end
			end
	end
	]]
	
	local function fruitMoves()
		if LocalPlayer.Character then
			while true do
				if (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()) and LocalPlayer.Character:WaitForChild('HumanoidRootPart',2) then
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
				end
				wait(0.1)
				-- Populate FruitMoves
				FruitMoves = {}
				for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
					if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
						FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
					end
				end
				
				-- Use FruitMoves
				for i,v in pairs(FruitMoves) do
					if not LocalPlayer.Cooldowns:FindFirstChild(v) then
						ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
					end
				end
			end
		end
	end
	
		
	local function checkLocalCharacterLoaded()
		local player = game.Players.LocalPlayer
		if player and player.Character then
			local character = player.Character
			-- Check if all necessary parts exist in the character
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local shirt = character:FindFirstChild("Shirt")
			local pants = character:FindFirstChild("Pants")
			local shirtGraphic = character:FindFirstChild("ShirtGraphic")
			
			if humanoid and shirt and pants then
				print("loaded bruh")
				-- Trigger the BindableEvent when appearance is loaded
				task.delay(6, fruitMoves)
				--task.delay(5, playerXYZ)
				
				characterLoadedEvent:Fire(character)
			end
		end
	end

	game.Players.LocalPlayer.CharacterAdded:Connect(checkLocalCharacterLoaded)
	
	while true do
		if LocalPlayer.Character then
			fruitMoves()
		end
	end
	
end
