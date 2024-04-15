local Button = script.Parent
local Players = game:GetService("Players")

-- Wait for the LocalPlayer to be available
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    LocalPlayer = Players.LocalPlayer
    wait(0.1)
end

-- Initialize local PlayerGui
local PlayerGui = LocalPlayer.PlayerGui

-- Connect the MouseButton1Click event
Button.MouseButton1Click:Connect(function()
    -- Get the Play button
    local playButton = PlayerGui.UI.MainMenu.Buttons.Play
    if playButton and playButton.Visible then
        -- Fire the button's click event
        playButton.MouseButton1Click:Fire()
    end
end)
