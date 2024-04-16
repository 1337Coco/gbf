local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

if game.PlaceId == 12413901502 then
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
    
    -- BindableEvent for character respawned signal
    local characterDeadSignal = Instance.new("BindableEvent")

    -- Connect this to the character's death event
    LocalPlayer.CharacterRemoving:Connect(function()
        print("Character is dead or removed!")
        characterDeadSignal:Fire()
    end)

    -- Connect this to the character's spawn event
    LocalPlayer.CharacterAdded:Connect(function()
        print("Character respawned!")
    end)

    -- Connect the bindable event to CheckAndClickPlayButton
    characterDeadSignal.Event:Connect(CheckAndClickPlayButton)
end
