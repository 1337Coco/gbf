local VIM = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
-- Get the LocalPlayer
local LocalPlayer = Players.LocalPlayer
local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value);

local character = LocalPlayer.Character
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

-- Function to transport the character to the specified position
local function TransportCharacter()
    -- Get the character
    local character = player.Character
    if character.HumanoidRootPart.Position ~= Vector3.new(-4773, 1349, -279) then
        character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
    else
        wait()
    end
end


-- Function to check if the Play button is visible and click it if it is
local function CheckAndClickPlayButton()
    -- Find the Play button
    local playButton = LocalPlayer.PlayerGui.UI.MainMenu.Buttons.Play
    
    -- Check if the Play button exists and is visible
    if playButton and playButton.Visible then
        -- Calculate the position to click the Play button
        local absolutePosition = playButton.AbsolutePosition
        local width = playButton.AbsoluteSize.X
        local height = playButton.AbsoluteSize.Y
        local centerX = absolutePosition.X + width / 2
        local centerY = absolutePosition.Y + height / 2 + 35 -- Adjusted downwards by 35 pixels
        
        -- Click the Play button
        VM1Click(centerX, centerY)
    end
end

-- Function to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
local function RunCheckAndClickPlayButton()
    while true do
        if LocalPlayer.Character == nil then
            CheckAndClickPlayButton() -- Click the Play button if the character is not present
        end
        wait(1)
    end
end

while true do
    RunCheckAndClickPlayButton()
    wait(2)
    TransportCharacter() -- Transport the character to the specified position if it's dead
    wait(1)
end
