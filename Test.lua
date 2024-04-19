local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

-- Function to get the elapsed time in hours and minutes
local function getElapsedTime(startTime)
    local currentTime = os.time() -- Get the current time
    local elapsedTimeSeconds = currentTime - startTime -- Calculate the elapsed time in seconds
    local elapsedHours = math.floor(elapsedTimeSeconds / 3600) -- Calculate the elapsed hours
    local elapsedMinutes = math.floor((elapsedTimeSeconds % 3600) / 60) -- Calculate the elapsed minutes
    return elapsedHours, elapsedMinutes
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

-- Get the start time
local startTime = os.time() -- Get the current time as the start time

-- Calculate elapsed time
local elapsedHours, elapsedMinutes = getElapsedTime(startTime)
local elapsedFormatted = string.format("%02d:%02d hour/minute", elapsedHours, elapsedMinutes)

-- Get the world description
local worldDescription = getWorldDescription(game.PlaceId)

-- Get level as xxx/300
local levelDescription = LocalLevel .. "/300"

local placeId = game.PlaceId
local newPosition
--Farming spots per World
if placeId == 9224601490 then --Dressrosa
	newPosition = CFrame.new(1195, 562, -826)
elseif placeId == 16190471004 then --Whole Cake
	newPosition = Cframe.new(122, 149, -1264)
elseif placeId == 12413901502 then --Onigashima
	newPosition = CFrame.new(-4773, 1349, -279)
else
	newPosition = CFrame.new(0,0,0)
end


local toggleKey = Enum.KeyCode.J
local renderingEnabled = true

--Whitescreen on off by pressing J key
local function toggleRendering()
    renderingEnabled = not renderingEnabled
    game:GetService("RunService"):Set3dRenderingEnabled(renderingEnabled)
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == toggleKey then
        toggleRendering()
    end
end)

-- Function to recursively change the material of parts to Plastic
local function changeMaterialToPlastic(obj)
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.Plastic
    end
    for _, child in ipairs(obj:GetChildren()) do
        changeMaterialToPlastic(child)
    end
end
--Plastic? Love!~
changeMaterialToPlastic(workspace)

-- Function to split a string
local function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end)
    return elements
end
--This shit is the bomb! Spawns the character and makes you the mfking g!
if LocalPlayer then
    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
    wait(3)  -- Wait before enabling core GUI
    Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
end

spawn(function()
    while task.wait(.1) do
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
                
                local Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                local args = {
                    [1] = "Main",
                    [2] = "Core",
                    [3] = {}
                }
                Event:FireServer(unpack(args))
                local Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                local args = {
                    [1] = "Main",
                    [2] = "LoadCharacter"
                }
                --idk which of this mfker is responsible for hiding Name but it works anyway
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.Overhead.PlayerName.Visible = false
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.OverheadUIS.Overhead.PlayerName.Visible = false
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.Visible = false
                game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.PlayerTextBehind = false
                Event:FireServer(unpack(args))
            else
                local path = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Bars.ProgressStamina.Text
                local exit = split(path, "/")
                if tonumber(exit[1]) <= tonumber(exit[2])*0.25 then
                    game.Players.LocalPlayer.Character.Humanoid.Health = 0
                else
                    _G.Toggle = true
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        local x = split(v.Name, " ")
                        if x[2] ~= nil then
                            v.Name = x[1]..x[2]
                        end
                    end
                    task.wait(0.1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newPosition
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

spawn(function()
    while task.wait(5) do
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

spawn(function()
    while task.wait(60) do
        pcall(function()
            local LocalLevel = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Level.Text
            local LocalEXP = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.EXP.Text
            local LocalStamina = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Bars.ProgressStamina.Text
            -- webhook url
            local url = "https://discord.com/api/webhooks/1156422586129989652/kd9jITOgaW8MZ32tNteuxYZq_zCP7VcGAVBT9l6wADEZE1SaVZuyr4Ma2dB5d7W6fxoN"
            local data = {
                ["content"] = "",
                ["embeds"] = {
                    {
                        ["title"] = "**Fruit Battlegrounds!**",
            		["description"] = "**Username**: **" .. LocalPlayer.DisplayName .. "**\n" ..
                              "**Level**: **" .. levelDescription .. "**\n" ..
                              "**Elapsed Time**: Start Time (" .. os.date("%H:%M", startTime) .. "), " .. elapsedFormatted .. "\n" ..
                              "**World**: " .. worldDescription,
            		["type"] = "rich",
            		["color"] = tonumber(0x7269da),
                    }
                }
            }
            local newdata = HttpService:JSONEncode(data)

            local headers = {
                ["content-type"] = "application/json"
            }
            local request = http_request or request or HttpPost or syn.request
            local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
            request(abcdef)
        end)
    end
end)
