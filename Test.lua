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
        VM1Click(centerX, 305)
    end
end

-- Function to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
local function RunCheckAndClickPlayButton()
    while player.Character == nil do
        CheckAndClickPlayButton()
        wait(2)
    end
end

-- Run the function to continuously check for the presence of the local player's character
RunCheckAndClickPlayButton()
