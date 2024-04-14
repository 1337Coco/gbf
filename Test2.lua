if game.PlaceId == 9224601490 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")

    local FruitMoves = {} -- Initialize FruitMoves table

    -- Function to respawn the player
    local Respawn = function()
        -- Delay respawn to avoid spamming
        wait(5)

        -- Reset FruitMoves
        FruitMoves = {}

        -- Load the character
        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")

        -- Show the HUD
        if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("HUD") then
            LocalPlayer.PlayerGui.HUD.Visible = true
        end
    end

    -- Function to adjust camera after respawn
    local function AdjustCamera()
        -- Reset the camera to the player's character
        Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
    end

    -- Function to check if the player is dead and respawn if necessary
    local function CheckPlayerStatus()
        local character = LocalPlayer.Character
        local UI = LocalPlayer.PlayerGui.UI

        if (not character or character == nil) and not UI.HUD.Visible then
            Respawn()  -- Respawn the player if dead
        end
    end

    -- Function to destroy GUI elements
    local function destroyGUI(player)
        -- Check if the player has a PlayerGui
        if player and player:FindFirstChild("PlayerGui") then
            -- Destroy all GUI descendants of PlayerGui
            for _, guiElement in ipairs(player.PlayerGui:GetChildren()) do
                guiElement:Destroy()
            end
        end
    end

    -- Function to connect to player respawn event
    local function onPlayerRespawn(player)
        -- Connect to the player's characterAdded event
        player.CharacterAdded:Connect(function(character)
            -- Destroy GUI elements when the player's character respawns
            destroyGUI(player)
            -- Adjust camera after respawn
            AdjustCamera()
        end)
    end

    -- Connect the onPlayerRespawn function to each player when they join the game
    game.Players.PlayerAdded:Connect(onPlayerRespawn)

    -- Destroy GUI elements for all existing players when the script runs
    for _, player in ipairs(game.Players:GetPlayers()) do
        onPlayerRespawn(player)
    end

    -- Target position coordinates
    local targetPosition = Vector3.new(1195, 562, -826)

    -- Main logic loop
    while true do
        wait(0.1)
        -- Check if the player is dead and respawn if necessary
        CheckPlayerStatus()

        -- Move player to the target location
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
        end

        -- Perform FruitMoves logic (insert here)
        -- Populate FruitMoves
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
