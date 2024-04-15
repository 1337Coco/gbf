local Players = game:GetService("Players")
local RESPAWN_DELAY = 5

Players.CharacterAutoLoads = false

local function onPlayerAdded(player)
    local function onCharacterAdded(character)
        local humanoid = character:WaitForChild("Humanoid")

        local function onDied()
            task.wait(RESPAWN_DELAY)
            if player.Character == nil then
                print("Respawning player:", player.Name)
                player:LoadCharacter()
            end
        end

        humanoid.Died:Connect(onDied)
    end

    player.CharacterAdded:Connect(onCharacterAdded)

    player:LoadCharacter()
end

Players.PlayerAdded:Connect(onPlayerAdded)
