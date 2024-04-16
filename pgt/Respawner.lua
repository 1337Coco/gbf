if game.PlaceId == 12413901502 then 
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
        end --if VIM end
    end --VM1Click end

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
            VM1Click(centerX, 325)
            wait()
            if playButton and not playButton.Visible then
                loadstring(game:HttpGet(('https://raw.githubusercontent.com/1337Coco/gbf/3b6ee1701c36d6fe8c817d92bdefb169feb502b9/pgt/Main.lua')))()
            end
        end --end if playButton visible
    end --end CheckAndClickPlayButton()

    -- Coroutine to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present

        while true do
            if LocalPlayer.Character == nil then
                CheckAndClickPlayButton() -- Click the Play button if the character is not present
            end --end while true LocalPlayer == nil
            wait()
        end -- end while true do loop
end
