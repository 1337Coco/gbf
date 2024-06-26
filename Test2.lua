if game.PlaceId == 9224601490 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local Backpack = LocalPlayer.Backpack
    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)
    local character = LocalPlayer.Character

    local FruitMoves = {} -- Initialize FruitMoves table

    -- Function to respawn the player
    local function Respawn()
        -- Reset FruitMoves
        FruitMoves = {}

        -- Load the character
        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")

        -- Show the HUD
        if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("HUD") then
            LocalPlayer.PlayerGui.HUD.Visible = true
        end

        -- Move player to the specified coordinates
        print("Respawning...")
        if LocalPlayer.Character then
            LocalPlayer.Character:MoveTo(Vector3.new(1195, 562, -826))
        end

        -- Delay respawn to avoid spamming
        wait(5)
    end

    -- Function to check if the player is dead and respawn if necessary
    local function CheckPlayerStatus()
        character = LocalPlayer.Character
        local UI = LocalPlayer.PlayerGui.UI

        if (not character or character == nil) and (not UI or not UI.HUD or not UI.HUD.Visible) then
            print("Player is dead. Respawning...")
            Respawn()  -- Respawns the player if dead
        end
    end

    -- Function to connect to player respawn event
    local function onPlayerRespawn(player)
        -- Connect to the player's characterAdded event
        player.CharacterAdded:Connect(function(character)
            -- Adjust camera after respawn
            if player == LocalPlayer then
                print("Adjusting camera for local player...")
                Workspace.CurrentCamera.CameraSubject = character
            end
        end)
    end

    -- Connect the onPlayerRespawn function to each player when they join the game
    game.Players.PlayerAdded:Connect(onPlayerRespawn)

    -- Destroy GUI elements for all existing players when the script runs
    for _, player in ipairs(game.Players:GetPlayers()) do
        onPlayerRespawn(player)
    end

    -- Main logic loop
    while true do
        wait(0.1)
        -- Check if the player is dead and respawn if necessary
        CheckPlayerStatus()

        -- Perform FruitMoves logic
        -- Reset FruitMoves
        FruitMoves = {}

        -- Populate FruitMoves
        for i,v in pairs(Backpack:GetChildren()) do
            if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
            end
        end

        -- Use FruitMoves
        for i,v in pairs(FruitMoves) do
            if not LocalPlayer.Cooldowns:FindFirstChild(v) then
                print("Invoking server with:", v)
                ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
            end
        end
    end
end
