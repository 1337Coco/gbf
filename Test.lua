if game.PlaceId == 9224601490 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local Backpack = LocalPlayer.Backpack
    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)

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

        -- Check and click the Play button if the character is still not present
        if LocalPlayer.Character == nil then
            CheckAndClickPlayButton()
        end
    end

    -- Function to check if the player is dead and respawn if necessary
    local function CheckPlayerStatus()
        local character = LocalPlayer.Character
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

-- Define the VirtualInputManager (VIM) object
local VIM = game:GetService("VirtualInputManager")

-- Get the LocalPlayer
local player = game.Players.LocalPlayer

-- Function to simulate a mouse click at the specified coordinates
local function VM1Click(X, Y)
    if VIM then
        VIM:SendMouseButtonEvent(X, Y, 0, true, game, 0)
        wait(0.1) -- Adjust wait time as needed
        VIM:SendMouseButtonEvent(X, Y, 0, false, game, 0)
    else
        warn("VirtualInputManager not found.")
    end
end

-- Function to check if the Play button is visible and click it if it is
local function CheckAndClickPlayButton()
    -- Find the Play button
    local playButton = player.PlayerGui.UI.MainMenu.Buttons.Play
    
    -- Check if the Play button exists and is visible
    if playButton and playButton.Visible then
        -- Calculate the position to click the Play button
        local absolutePosition = playButton.AbsolutePosition
        local width = playButton.AbsoluteSize.X
        local height = playButton.AbsoluteSize.Y
        local centerX = absolutePosition.X + width / 2
        local centerY = absolutePosition.Y + height / 2
        
        -- Click the Play button
        VM1Click(centerX, centerY)
    end
end

-- Function to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
local function RunCheckAndClickPlayButton()
    while player.Character == nil do
        CheckAndClickPlayButton()
        wait(1)
    end
end

-- Run the function to continuously check for the presence of the local player's character
RunCheckAndClickPlayButton()
