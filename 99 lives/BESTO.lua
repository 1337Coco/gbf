if game.PlaceId == 12413901502 or game.PlaceId == 16190471004 or game.PlaceId == 9224601490 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
	local currentFruitLevel = CurrentData.Level.Value
	local TeleportService = game:GetService("TeleportService")
    local FruitMoves = {} -- Initializing FruitMoves table
	local TeleportService = game:GetService("TeleportService")

	-- Function to teleport to a specific placeId
	local function TeleportToPlace(placeId)
		local success, errorMessage = pcall(function()
			TeleportService:Teleport(placeId)
		end)
		
		if not success then
			warn("Teleport failed:", errorMessage)
		end
	end

	-- Example: Teleport to a specific placeId
	local targetPlaceId = '' -- Replace this with your desired placeId (Whole Cake)
	
	
	
	
    -- Function to respawn the player
    local function RespawnPlayer()
        FruitMoves = {} -- Reset FruitMoves
        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
        wait(3)  -- Wait before enabling core GUI
        Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
        -- Hide the menu GUI
        StarterGui:SetCore("TopbarEnabled", false)
        StarterGui:SetCore("ResetButtonCallback", true)
        StarterGui:SetCoreGuiEnabled("Backpack", false)
        StarterGui:SetCoreGuiEnabled("PlayerList", false)
        StarterGui:SetCoreGuiEnabled("Chat", false)
		-- Removes the Menu Gui Play, Spin, Join Friend, Afk World
		game.Players.LocalPlayer.PlayerGui.UI.MainMenu.Visible = false
		-- Makes Level, Player Name, HP, Stamina, Shop, Titles, Settings, Daily Visible
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Visible = true
		task.wait()
		--idk which of this mfker is responsible for hiding Name but it works anyway
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.Overhead.PlayerName.Visible = false
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.OverheadUIS.Overhead.PlayerName.Visible = false
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.Visible = false
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.PlayerTextBehind = false
		--[[game.Players.LocalPlayer.PlayerGui.UI.HUD.Level.Visible = true
		game.Players.LocalPlayer.PlayerGui.UI.HUD.EXP.Visible = true
		game.Players.LocalPlayer.PlayerGui.UI.HUD.HP.Visible = true
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Bars.HP.Visible = true
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Bars.HP.Bar.Visible = true
		game.Players.LocalPlayer.PlayerGui.UI.HUD.Bars.ProgressHP.Visible = true]]

    end

    -- Function to handle player's death
    local function OnPlayerDied()
		print("Local player has died or hasn't spawned.")
		RespawnPlayer()
	end

	game.Players.PlayerAdded:Connect(function(player)
		if player == game.Players.LocalPlayer then
			player.CharacterAdded:Connect(function(character)
				-- Connect to the Character's Died event
				character:WaitForChild("Humanoid").Died:Connect(function()
					OnPlayerDied()
				end)
			end)
		end
	end)


    -- Main logic function
    while true do
		if currentFruitLevel >= 100 and not currentFruitLevel >= 200 then
			targetPlaceId = 16190471004
			TeleportToPlace(targetPlaceId)
		elseif currentFruitLevel >= 200 and not currentFruitLevel <= 100 then
			targetPlaceId = 12413901502
		end
		task.spawn(RespawnPlayer)
        wait(0.1)

        -- Move player to the specified coordinates
        if LocalPlayer.Character then
            LocalPlayer.Character:MoveTo(Vector3.new(-4773, 1349, -279))
        end

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
