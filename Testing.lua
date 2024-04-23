-- Improve variable naming
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
local CurrentData = MainData:WaitForChild("Fruits"):WaitForChild(MainData:WaitForChild("Slots")[MainData:WaitForChild("Slot").Value].Value)

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

local newPosition
-- Farming spots per World
if placeId == 9224601490 then -- Dressrosa
	newPosition = CFrame.new(1195, 562, -826)
elseif placeId == 16190471004 then -- Whole Cake
	newPosition = CFrame.new(1075.33251953125, 149.14910888671875, -1187.79638671875)
elseif placeId == 12413901502 then -- Onigashima
	newPosition = CFrame.new(-4773, 1349, -279)
else
	newPosition = CFrame.new(0, 0, 0)
end


-- Improve readability with comments
-- Function to split a string
local function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end)
    return elements
end

-- This part is the bomb! Spawns the character and makes you the g!
if LocalPlayer then
    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
    wait(3)  -- Wait before enabling core GUI
    Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
end

-- Use descriptive variable names
spawn(function()
    while task.wait(1) do
        pcall(function()
            local character = game.Players.LocalPlayer.Character
            if character == nil then
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
                -- Hide player name
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.Overhead.PlayerName.Visible = false
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.OverheadUIS.Overhead.PlayerName.Visible = false
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.Visible = false
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.PlayerTextBehind = false
                Event:FireServer(unpack(args))
                wait(5)
            else
                local path = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Bars.ProgressStamina.Text
                local exit = split(path, "/")
                if tonumber(exit[1]) <= tonumber(exit[2]) * 0.25 then
                    game.Players.LocalPlayer.Character.Humanoid.Health = 0
                else
                    _G.Toggle = true
                    if game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame ~= newPosition then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newPosition
                    end
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        local x = split(v.Name, " ")
                        if x[2] ~= nil then
                            v.Name = x[1]..x[2]
			    --print(v.Name) prints fruit moves.
                        end
                    end
                    task.wait(0.15)
                    -- xyz
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        local ohString1 = game.Players.LocalPlayer["MAIN_DATA"].Slots[game.Players.LocalPlayer["MAIN_DATA"].Slot.Value].Value
                        local ohString2 = v.Name
                        local ohTable3 = {}
                        game:GetService("ReplicatedStorage").Replicator:InvokeServer(ohString1, ohString2, ohTable3)
                    end
                end
            end
        end)
    end
end)

-- Automatically handle idle state
spawn(function()
    while task.wait(20) do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                vu:CaptureController();
                vu:ClickButton2(Vector2.new());
                wait(2)
            end)
        end)
    end
end)

-- Webhook function with improvements
spawn(function()
    while task.wait(120) do
        pcall(function()
            local Players = game:GetService("Players")
            local LocalLevel = LocalPlayer.PlayerGui.UI.HUD.Level.Text
            local LocalPlayer = Players.LocalPlayer
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
