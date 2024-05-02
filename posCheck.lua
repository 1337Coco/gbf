local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local playButton = PlayerGui.UI.MainMenu.Buttons.Play

if playButton then
    wait(10)
    -- Simulate a button click
    playButton.MouseButton1Click:Fire()
else
    print("Play button not found!")
end
