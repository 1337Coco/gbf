if game.PlaceId == 12413901502 or game.PlaceId == 16190471004 or game.PlaceId == 9224601490 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local VIM = game:GetService("VirtualInputManager")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer  -- Define LocalPlayer here
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

    -- Function to check if the Spin button is visible and click it if it is
    local function CheckAndClickSpinButton()
        -- Find the Spin button
        local spinButton = PlayerGui.UI.MainMenu.Buttons.Spin

        -- Check if the Spin button exists and is visible
        if spinButton and spinButton.Visible then
            -- Click the Spin button
            local absolutePosition = spinButton.AbsolutePosition
            local width = spinButton.AbsoluteSize.X
            local height = spinButton.AbsoluteSize.Y
            local centerX = absolutePosition.X + width / 2
            local centerY = absolutePosition.Y + height / 2 + 45
            VM1Click(centerX, centerY)
        end
    end

    -- Coroutine to continuously check for the presence of the Spin button and click it if found
    while true do
        CheckAndClickSpinButton() -- Click the Spin button if found
        wait(3)
    end
end
