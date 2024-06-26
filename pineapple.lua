local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)
local LocalLevel

local function GetFruit()
    return tostring(MainData.Slots[tostring(MainData.Slot.Value)].Value)
end

-- Function to get the world description based on the PlaceId
local function getWorldDescription(placeId)
    if placeId == 9224601490 then
        return "Dressrosa"
    elseif placeId == 16190471004 then
        return "Whole Cake"
    elseif placeId == 12413901502 then
        return "Onigashima"
    else
        return "Unknown World"
    end
end

-- Get the world description
local worldDescription = getWorldDescription(game.PlaceId)

local placeId = game.PlaceId
local newPosition
local bossName

-- Farming spots per World
if placeId == 9224601490 then -- Dressrosa
    newPosition = CFrame.new(1195, 562, -826)
    bossName = "Marco"
elseif placeId == 16190471004 then -- Whole Cake
    newPosition = CFrame.new(1075.33251953125, 149.14910888671875, -1187.79638671875)
    bossName = "BigMom"
elseif placeId == 12413901502 then -- Onigashima
    newPosition = CFrame.new(-4773, 1349, -279)
    bossName = "Kaido"
else
    newPosition = CFrame.new(0, 0, 0)
end

-- Function to split a string
local function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] = value end)
    return elements
end

-- This part is the bomb! Spawns the character and makes you the g!
if LocalPlayer then
    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
    StarterGui:SetCoreGuiEnabled('Backpack', false)
    StarterGui:SetCoreGuiEnabled('PlayerList', false)
    Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
end

local boss

-- Boss checker
spawn(function()
    while task.wait() do
        boss = game.Workspace.Characters.NPCs:FindFirstChild(bossName)
        if boss and boss:WaitForChild("Humanoid").Health >= 1 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = boss:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 3)
        end
    end
end)

-- Respawn, load character, tp to xyz coords, initialize skills, use skills. loop
spawn(function()
    while task.wait(1) do
        pcall(function()
            local plr = game.Players.LocalPlayer.Character
            if plr == nil then
                wait(5)
                local Event = game:GetService("ReplicatedStorage").Replicator
                local args = {
                    [1] = "Core",
                    [2] = "LoadCharacter",
                    [3] = {}
                }
                Event:InvokeServer(unpack(args))
                wait()

                local Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                local args = {
                    [1] = "Main",
                    [2] = "Core",
                    [3] = {}
                }
                Event:FireServer(unpack(args))
                wait()
                local Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                local args = {
                    [1] = "Main",
                    [2] = "LoadCharacter"
                }
                Event:FireServer(unpack(args))
                
                -- Hide UI elements
                LocalPlayer.PlayerGui.UI.HUD.Handler.Overhead.PlayerName.Visible = false
                LocalPlayer.PlayerGui.UI.HUD.Handler.OverheadUIS.Overhead.PlayerName.Visible = false
                LocalPlayer.PlayerGui.UI.HUD.Player.Visible = false
                LocalPlayer.PlayerGui.UI.HUD.Player.PlayerTextBehind = false
                StarterGui:SetCoreGuiEnabled('Backpack', false)
                StarterGui:SetCoreGuiEnabled('PlayerList', false)
            else
                local path = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Bars.ProgressStamina.Text
                local exit = split(path, "/")
                if tonumber(exit[1]) <= tonumber(exit[2]) * 0.15 then
                    LocalPlayer.Character:BreakJoints()
                else
                    _G.Toggle = true
                    if LocalPlayer.Character.HumanoidRootPart.CFrame ~= newPosition and not game.Workspace.Characters.NPCs:FindFirstChild(bossName) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = newPosition
                    elseif LocalPlayer.Character.HumanoidRootPart.CFrame ~= newPosition and game.Workspace.Characters.NPCs:FindFirstChild(bossName) then
                        local boss = game.Workspace.Characters.NPCs:FindFirstChild(bossName)
                        if boss and boss:WaitForChild("Humanoid").Health >= 1 then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = boss:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 3)
                        end
                    end
                    for i, v in pairs(LocalPlayer:GetDescendants()) do
                        if v.ClassName == 'Tool' then
                            if v:GetAttribute('Name') then 
                                local Attack = v:GetAttribute('Name')
                                ReplicatedStorage.Replicator:InvokeServer(GetFruit(), Attack)
                            else
                                local Attack = v.Name:gsub(" ", "")
                                ReplicatedStorage.Replicator:InvokeServer(GetFruit(), Attack)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- M1s
spawn(function()
    while task.wait() do
	boss = game.Workspace.Characters.NPCs:FindFirstChild(bossName)
		if boss then
			local ohString1 = "Core"
			local ohString2 = "M1"
			local ohTable3 = {}
			game:GetService("ReplicatedStorage").Replicator:InvokeServer(ohString1, ohString2, ohTable3)
		end
    end
end)

-- anti afk
spawn(function()
    while task.wait(20) do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
                wait(2)
            end)
        end)
    end
end)

-- tp when level is reached
spawn(function() 
    while task.wait() do
        pcall(function()
            LocalLevel = LocalPlayer.PlayerGui.UI.HUD.Level.Text
            local levelNumber = tonumber(LocalLevel)
            if levelNumber >= 100 and game.PlaceId == 9224601490 then
                game:GetService("TeleportService"):Teleport(16190471004, LocalPlayer)
            elseif levelNumber >= 200 and game.PlaceId == 16190471004 then
                game:GetService("TeleportService"):Teleport(12413901502, LocalPlayer)
            end
        end)
        task.wait(600)
    end
end)

-- Webhook function with improvements
spawn(function()
    while task.wait(600) do
        pcall(function()
            LocalLevel = LocalPlayer.PlayerGui.UI.HUD.Level.Text
            local levelDescription = LocalLevel .. "/300"
            local CurrentFruit = CurrentData.Name

            -- Get the world description dynamically
            local worldDescription = getWorldDescription(game.PlaceId)

            -- Webhook URL
            local url = "https://discord.com/api/webhooks/1156422586129989652/kd9jITOgaW8MZ32tNteuxYZq_zCP7VcGAVBT9l6wADEZE1SaVZuyr4Ma2dB5d7W6fxoN"
            local data = {
                ["content"] = "",
                ["embeds"] = {
                    {
                        ["title"] = "**Fruit Battlegrounds!**",
                        ["description"] = "**Username**: **" .. LocalPlayer.DisplayName .. "**\n" ..
                                          "**Level**: **" .. levelDescription .. "**\n" ..
                                          "**Fruit**: **" .. CurrentFruit .. "**\n" ..
                                          "**World**: **" .. worldDescription .. "**",
                        ["type"] = "rich",
                        ["color"] = tonumber(0x7269da),
                    }
                }
            }

            local newdata = game:GetService("HttpService"):JSONEncode(data)

            local headers = {
                ["content-type"] = "application/json"
            }
            request = http_request or request or HttpPost or syn.request
            local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
            request(abcdef)
        end)
    end
end)
