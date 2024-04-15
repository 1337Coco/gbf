if game.PlaceId == 12413901502 then
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
    
    -- Check for the Play button periodically
    while true do
        -- Check and click the Play button
        CheckAndClickPlayButton()
        
        -- Wait before checking again (you can adjust the wait time as needed)
        wait(2)
    end
end --end of game.PlaceId
