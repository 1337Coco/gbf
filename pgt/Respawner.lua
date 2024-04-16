-- Respawner.lua

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to simulate a mouse click at the specified coordinates
local function VM1Click(X, Y)
    local VIM = game:GetService("VirtualInputManager")
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
    local PlayerGui = LocalPlayer.PlayerGui
    -- Find the Play button
    local playButton = PlayerGui.UI.MainMenu.Buttons.Play
    
    -- Check if the Play button exists and is visible
    if playButton and playButton.Visible then
        -- Calculate the position to click the Play button
        local absolutePosition = playButton.AbsolutePosition
        local width = playButton.AbsoluteSize.X
        local height = playButton.AbsoluteSize.Y
        local centerX = absolutePosition.X + width / 2
        local centerY = absolutePosition.Y + height / 2 + 35 -- Adjusted downwards by 35 pixels
        
        -- Click the Play button
        VM1Click(centerX, 325)
    end
end

-- Coroutine to continuously check if character is nil and respawn if needed
local function RespawnerCoroutine()
    print("RespawnerCoroutine started.")
    while true do
        if LocalPlayer.Character == nil then
            print("Character is nil. Respawning...")
            CheckAndClickPlayButton()
        end
        wait(1) -- Adjust as needed, check every second
    end
end

-- Start the coroutine
coroutine.wrap(RespawnerCoroutine)()
