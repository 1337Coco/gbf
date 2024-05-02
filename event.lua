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

-- Function to run when the local player's character is added
local function onCharacterAdded(character)
    -- Check and click the Play button when the character is added
    CheckAndClickPlayButton()
end

-- Function to run when the local player's character is removed
local function onCharacterRemoving(character)
    -- You can add any additional handling here if needed
end

-- Connect the functions to the corresponding events for the local player
if LocalPlayer then
    LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
    LocalPlayer.CharacterRemoving:Connect(onCharacterRemoving)
else
    warn("Local player not found.")
end

-- Function to check if the Play button is visible and click it if it is
local function CheckAndClickPlayButton()
    -- Find the Play button
    local playButton = PlayerGui.UI.MainMenu.Buttons.Play

    -- Check if the Play button exists and is visible
    if playButton and playButton.Visible then
        --require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        --require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
        -- Calculate the position to click the Play button
        local position = playButton.Position
        -- Click the Play button
        VM1Click(position.X, position.Y)
    end
end

-- Initial check and click for the Play button when the script starts
CheckAndClickPlayButton()
