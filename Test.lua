if game.PlaceId == 12413901502 then
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer.PlayerGui
    local StarterGui = game:GetService("StarterGui")
    local Workspace = game:GetService("Workspace")
    local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
    local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)

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
    
    local FruitMoves = {}
	
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
	
     local function CheckPlayerStatus()
         local character = LocalPlayer.Character
         local UI = LocalPlayer.PlayerGui.UI

         if (not character or character == nil) and not UI.HUD.Visible then
           Respawn()  -- Respawn the player if dead
         end
end
    while true do
        wait(0.1)
	CheckPlayerStatus()

	
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
