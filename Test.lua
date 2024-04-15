local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RESPAWN_DELAY = 5 -- Respawn delay in seconds
local SPAWN_POSITION = Vector3.new(-4773, 1349, -279) -- Coordinates of the spawn location

local function setupHumanoidAsync(player, humanoid)
    -- Customize humanoid properties
    humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Subject
    humanoid.NameDisplayDistance = 1000
    humanoid.HealthDisplayDistance = 1000
    humanoid.NameOcclusion = Enum.NameOcclusion.OccludeAll
    humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn
    humanoid.BreakJointsOnDeath = false

    -- Wait for the humanoid to die
    humanoid.Died:Wait()

    -- Teleport the player to the spawn position
    player.Character:SetPrimaryPartCFrame(CFrame.new(SPAWN_POSITION))
end
