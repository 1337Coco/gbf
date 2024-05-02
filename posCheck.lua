local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local playButton = PlayerGui.UI.MainMenu.Buttons.Play

if playButton then
    -- Get the position of the playButton
    local position = playButton.Position
    print("Play button found at position:", position.X, position.Y)
else
    print("Play button not found!")
end
