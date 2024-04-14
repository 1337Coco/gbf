if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local FruitMoves = {} -- Initializing FruitMoves table

    -- Function to respawn the player
    local function Respawn()
        require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
        require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
        wait(3)  -- Wait before enabling core GUI
        Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
        StarterGui:SetCoreGuiEnabled("Backpack", false)
        StarterGui:SetCoreGuiEnabled("PlayerList", false)
        StarterGui:SetCoreGuiEnabled("Chat", false)
    end

    -- Main logic function
    local function MainLogic()
        while true do
            wait(0.1)

            -- Check local player status
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                if LocalPlayer.Character.Humanoid.Health <= 0 then
                    Respawn()
                else
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
        end
    end

    -- Connect local player's character removal event
    LocalPlayer.CharacterRemoving:Connect(function(character)
        print(character.Name .. " has died.")
    end)

    -- Call the main logic function
    MainLogic()
end
