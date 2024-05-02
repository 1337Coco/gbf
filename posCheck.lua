local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

local playButton = PlayerGui.UI.MainMenu.Buttons.Play

local position = playButton.Position

print("Play button pos: .. position.X.Offset .. ", " .. position.Y.Offset .. ")")
