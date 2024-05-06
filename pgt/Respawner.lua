local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
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
    -- Define the search range around the center of the screen
    local centerX = PlayerGui.AbsoluteSize.X / 2
    local centerY = PlayerGui.AbsoluteSize.Y / 2
    local minX = centerX - 100
    local maxX = centerX + 100
    local minY = centerY - 100
    local maxY = centerY + 100

    -- Iterate through the UI elements to find the Play button within the search range
    for _, button in pairs(PlayerGui:GetChildren()) do
        if button.Name == "Play" and button:IsA("TextButton") then
            local absolutePosition = button.AbsolutePosition
            if absolutePosition.X >= minX and absolutePosition.X <= maxX
               and absolutePosition.Y >= minY and absolutePosition.Y <= maxY
               and button.Visible then
                -- Calculate the center position of the button
                local width = button.AbsoluteSize.X
                local height = button.AbsoluteSize.Y
                local centerX = absolutePosition.X + width / 2
                local centerY = absolutePosition.Y + height / 2 + 35 -- Adjusted downwards by 35 pixels

                -- Click the Play button
                VM1Click(centerX, centerY)
                return  -- Exit the function once the button is clicked
            end
        end
    end
end

-- Coroutine to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
while true do
    CheckAndClickPlayButton() -- Click the Play button if the character is not present
    wait()
end
