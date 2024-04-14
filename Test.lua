if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local character = LocalPlayer.Character
    local UI = LocalPlayer.PlayerGui.UI

    -- Function to respawn the player
    local Respawn = function()
        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
        if (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()) and LocalPlayer.Character:WaitForChild("Humanoid", 10) then
            Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
            StarterGui:SetCoreGuiEnabled("Backpack", false)
            StarterGui:SetCoreGuiEnabled("PlayerList", false)
            StarterGui:SetCoreGuiEnabled("Chat", false)
        end
    end

    -- Function to check local player status
    local function CheckLocalPlayerStatus()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            if LocalPlayer.Character.Humanoid.Health <= 0 then
                Respawn()
            end
        end
    end


    -- Continuously check local player status and position
    while true do
        wait(0.1)
        -- Connect local player's character removal event
        LocalPlayer.CharacterRemoving:Connect(function(character)
            print('respawning...')
            Respawn()
        end)
        -- Check local player status
        CheckLocalPlayerStatus()

        -- Your existing logic
        if #FruitMoves == 0 then
            for i,v in pairs(LocalPlayer.Backpack:GetChildren()) do
                if v.ClassName == "Tool" and CurrentData.Level.Value >= v:GetAttribute("Level") then
                    FruitMoves[#FruitMoves + 1] = string.gsub(v.Name, " ", "")
                end
            end
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)

            for i,v in pairs(FruitMoves) do
                if not LocalPlayer.Cooldowns:FindFirstChild(v) then
                    ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, v, {})
                end
            end
        end
    end
end
