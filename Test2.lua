-- Function to respawn the player
local function Respawn()
    -- Reset FruitMoves
    FruitMoves = {}

    -- Load the character
    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")

    -- Show the HUD
    if LocalPlayer.PlayerGui and LocalPlayer.PlayerGui:FindFirstChild("HUD") then
        LocalPlayer.PlayerGui.HUD.Visible = true
    end

    -- Move player to the specified coordinates
    print("Respawning...")
    if LocalPlayer.Character then
        LocalPlayer.Character:MoveTo(Vector3.new(1195, 562, -826))
    end

    -- Delay respawn to avoid spamming
    wait(5)
end
