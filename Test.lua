local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)


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
    
    -- Function to transport the character to the specified position
    local function TransportCharacter()
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local characterPosition = character.HumanoidRootPart.Position
            local targetPosition = Vector3.new(-4773, 1349, -279)
            local distanceThreshold = 5 -- Adjust as needed
            if (characterPosition - targetPosition).magnitude > distanceThreshold then
                character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
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
    
    -- BindableEvent for character respawned signal
    local characterSpawnedSignal = Instance.new("BindableEvent")

    -- Coroutine to continuously transport the character to the specified position
    local function TransportCoroutine()
        while true do
            CheckAndClickPlayButton() -- Check if the player can respawn
            wait(5)
            characterSpawnedSignal.Event:Wait() -- Wait for the character to spawn
            TransportCharacter() -- Transport the character to the specified position if it's dead
            wait(2)
        end
    end

    -- Start the coroutine
    coroutine.wrap(TransportCoroutine)()

    -- Connect this to the character's respawn event
    LocalPlayer.CharacterAdded:Connect(function(character)
        print("Character respawned!")
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
        characterSpawnedSignal:Fire(character)
    end)
end
