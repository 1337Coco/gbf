local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

-- Function to respawn the player
local Respawn = function()
    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
    if (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()) and LocalPlayer.Character:WaitForChild("Humanoid", 10) then
        Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
        StarterGui:SetCoreGuiEnabled("Backpack", false)
        StarterGui:SetCoreGuiEnabled("PlayerList", false)
        StarterGui:SetCoreGuiEnabled("Chat", false)
        -- Assuming these are defined elsewhere in your script
        -- UI.MainMenu.Visible = false
        -- UI.HUD.Visible = false
    end
end

-- Function to get the equipped fruit
local function GetFruit()
    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)
    return CurrentData.Name
end

-- Function to perform fruit moves
local function PerformFruitMoves()
    if (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()) and LocalPlayer.Character:WaitForChild('HumanoidRootPart', 2) then
        for _, tool in ipairs(LocalPlayer:GetDescendants()) do
            if tool.ClassName == 'Tool' then
                local Attack
                if tool:GetAttribute('Name') then 
                    Attack = tool:GetAttribute('Name')
                else
                    Attack = tool.Name:gsub(" ","")
                end
                ReplicatedStorage.Replicator:InvokeServer(GetFruit(), Attack)
            end
        end
    end
end

-- Function to check if the player is dead and respawn if necessary
local function CheckPlayerStatus()
    local character = LocalPlayer.Character
    local UI = LocalPlayer.PlayerGui.UI

    if (not character or character == nil) and not UI.HUD.Visible then
        Respawn()  -- Respawn the player if dead
    end
end

-- Function to check if the player is in the specified position and perform fruit moves if so
local function CheckPlayerPosition()
    local character = LocalPlayer.Character

    if character and character:FindFirstChild("HumanoidRootPart") then
        -- Move the player to the specified position if not already there
        if character.HumanoidRootPart.Position ~= Vector3.new(122, 149, -1264) then
            character.HumanoidRootPart.CFrame = CFrame.new(122, 149, -1264)
        else
            -- Perform fruit moves if the player is in the specified position
            PerformFruitMoves()
        end
    end
end

-- Continuously check player status and position
while true do
    wait(0.25)
    -- Check if the player is dead and respawn if necessary
    CheckPlayerStatus()
    -- Check if the player is in the specified position and perform fruit moves if so
    CheckPlayerPosition()
end
