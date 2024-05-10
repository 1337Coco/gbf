local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local centerX = screenWidth / 2
local centerY = screenHeight / 2
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

    -- If the Play button is found and visible, simulate a mouse click on it
    if not playButton.Visible and LocalPlayer == nil then
	-- Calculate the click position as a percentage of the button's position and size
        local absolutePosition = playButton.AbsolutePosition
        local width = playButton.AbsoluteSize.X
        local height = playButton.AbsoluteSize.Y
        
        -- Define the percentage of the button's position and size to click
        local clickX = absolutePosition.X + width * 0.5  -- Click at the center horizontally
        local clickY = absolutePosition.Y + height * 1 -- Click slightly downward from the center vertically
		
        -- Click the Play button
        VM1Click(clickX, clickY)
    
	
     elseif playButton and playButton.Visible then
	-- Calculate the click position as a percentage of the button's position and size
        local absolutePosition = playButton.AbsolutePosition
        local width = playButton.AbsoluteSize.X
        local height = playButton.AbsoluteSize.Y
        
        -- Define the percentage of the button's position and size to click
        local clickX = absolutePosition.X + width * 0.5  -- Click at the center horizontally
        local clickY = absolutePosition.Y + height * 1.4 -- Click slightly downward from the center vertically

        -- Click the Play button
        VM1Click(clickX, clickY)
    end
end

--Test
while not playButton.Visible do
    VM1Click(centerX, centerY)
    print("Clicking center screen")
    wait(1) -- Adding a short delay to avoid excessive looping
end
--end test

-- Coroutine to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
while true do
    CheckAndClickPlayButton() -- Click the Play button if the character is not present
    wait()
end
