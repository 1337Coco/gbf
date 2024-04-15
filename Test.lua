local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RESPAWN_DELAY = 5 -- Respawn delay in seconds
local SPAWN_POSITION = Vector3.new(-4773, 1349, -279) -- Coordinates of the spawn location

-- Function to respawn the local player
local function respawnPlayer()
    -- Teleport the player to the spawn location
    LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(SPAWN_POSITION))

    -- Ensure the player's humanoid is not dead
    if LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = LocalPlayer.Character.Humanoid.MaxHealth
    end
end

-- Connect to the player's characterAdded event
LocalPlayer.CharacterAdded:Connect(function(character)
    -- Connect to the player's humanoid's Died event
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        -- Wait for the respawn delay before respawning the player
        wait(RESPAWN_DELAY)
        respawnPlayer()
    end)
end)

-- Teleport the player to the spawn location
respawnPlayer()
