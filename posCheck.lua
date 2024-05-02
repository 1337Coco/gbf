
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local VIM = game:GetService("VirtualInputManager")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer  -- Define LocalPlayer here
    local PlayerGui = LocalPlayer.PlayerGui

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
        local playButton = PlayerGui.UI.MainMenu.Buttons.Play

        -- Check if the Play button exists and is visible
        if playButton and playButton.Visible then
	    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
	    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
            -- Calculate the position to click the Play button
            local position = playButton.Position
	    task.wait()
            -- Click the Play button
            VM1Click(position.X, position.Y)
        end
    end

    -- Coroutine to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
    while true do
            CheckAndClickPlayButton() -- Click the Play button if the character is not present
        wait()
    end
