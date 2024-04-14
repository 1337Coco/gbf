if game.PlaceId == 9224601490 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local FruitMoves = {} -- Initializing FruitMoves table

    -- Function to respawn the player
    local function RespawnPlayer()
        FruitMoves = {} -- Reset FruitMoves
        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
        wait(3)  -- Wait before enabling core GUI
        Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
        -- Hide the menu GUI
        StarterGui:SetCore("TopbarEnabled", false)
        StarterGui:SetCore("ResetButtonCallback", false)
        StarterGui:SetCoreGuiEnabled("Backpack", false)
        StarterGui:SetCoreGuiEnabled("PlayerList", false)
        StarterGui:SetCoreGuiEnabled("Chat", false)
    end

    -- Function to handle player's death
    local function OnPlayerDied()
        print(LocalPlayer.Name .. " has died.")
        RespawnPlayer()
    end

    -- Connect to player's death event
    LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(OnPlayerDied)

    -- Main logic function
    while true do
        wait(0.1)

        -- Move player to the specified coordinates
        if LocalPlayer.Character then
            LocalPlayer.Character:MoveTo(Vector3.new(1195, 562, -826))
        end

        -- Populate FruitMoves
        FruitMoves = {}
        for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
            if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
            end
        end

        -- Use FruitMoves
        for i,v in pairs(FruitMoves) do
            if not LocalPlayer.Cooldowns:FindFirstChild(v) then
                ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
            end
        end
    end
end
