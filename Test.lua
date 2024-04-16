if game.PlaceId == 12413901502 then
    local VIM = game:GetService("VirtualInputManager")
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    -- Get the LocalPlayer
    local LocalPlayer = Players.LocalPlayer
    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)

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
        if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
            local characterPosition = LocalPlayer.Character.HumanoidRootPart.Position
            local targetPosition = Vector3.new(-4773, 1349, -279)
            local distanceThreshold = 5 -- Adjust as needed
            if (characterPosition - targetPosition).magnitude > distanceThreshold then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            else
                print("Character is already at the target position.")
            end
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
    
    -- Coroutine to continuously check for the presence of the local player's character and run CheckAndClickPlayButton if the character is not present
    local function CharacterMonitoringCoroutine()
        while true do
            if LocalPlayer.Character == nil then
                CheckAndClickPlayButton() -- Click the Play button if the character is not present
            end
            wait(1)
        end
    end

    -- Start the coroutine
    coroutine.wrap(CharacterMonitoringCoroutine)()

    -- BindableEvent for character respawned signal
    local characterRespawnedSignal = Instance.new("BindableEvent")

    -- Coroutine to continuously transport the character to the specified position
    local function TransportCoroutine()
        while true do
            if LocalPlayer.Character and LocalPlayer.Character.HumanoidRootPart then
                TransportCharacter() -- Transport the character to the specified position if it's dead
            end
            wait(2)
        end
    end

    -- Start the coroutine when the character respawns
    characterRespawnedSignal.Event:Connect(TransportCoroutine)

    -- Connect this to the character's respawn event
    LocalPlayer.CharacterAdded:Connect(function(character)
        characterRespawnedSignal:Fire(character)
    end)
end
