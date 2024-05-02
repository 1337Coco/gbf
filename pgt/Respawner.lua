if game.PlaceId == 12413901502 or game.PlaceId == 16190471004 or game.PlaceId == 9224601490 then 
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
            local absolutePosition = playButton.AbsolutePosition
            local width = playButton.AbsoluteSize.X
            local height = playButton.AbsoluteSize.Y
            local centerX = absolutePosition.X + width / 2
            local centerY = absolutePosition.Y + height / 2 + 35 -- Adjusted downwards by 35 pixels
	    task.wait()
            -- Click the Play button
            VM1Click(centerX, 325)
        end
    end

    -- Coroutine to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
    while true do
            CheckAndClickPlayButton() -- Click the Play button if the character is not present
        wait()
    end
end
