local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RESPAWN_DELAY = 5

Players.CharacterAutoLoads = false

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")

    local function onDied()
        task.wait(RESPAWN_DELAY)
        if LocalPlayer.Character == nil then
            print("Respawning local player...")
            LocalPlayer:LoadCharacter()
        end
    end

    humanoid.Died:Connect(onDied)
end

LocalPlayer.CharacterAdded:Connect(onCharacterAdded)
LocalPlayer:LoadCharacter()
