local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local Maid = require(game:GetService("ReplicatedStorage").Maid)

local maid = Maid.new()

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

-- Get the world description
local worldDescription = getWorldDescription(game.PlaceId)

local placeId = game.PlaceId
local newPosition
--Farming spots per World
if placeId == 9224601490 then --Dressrosa
	newPosition = CFrame.new(1195, 562, -826)
elseif placeId == 16190471004 then --Whole Cake
	newPosition = CFrame.new(122, 149, -1264)
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

-- Connect InputBegan event using Maid
maid:AddConnection(game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == toggleKey then
        toggleRendering()
    end
end))

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

-- Connect loop using Maid
maid:AddThread(function()
    while true do
        task.wait(60)
        pcall(function()
            local elapsedHours, elapsedMinutes = getElapsedTime(startTime)
            local elapsedFormatted = string.format("%02d:%02d hour/minute", elapsedHours, elapsedMinutes)
            local LocalLevel = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Level.Text
            -- Get level as xxx/300
            local levelDescription = LocalLevel .. "/300"
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

-- Cleanup function to disconnect all connections and stop all timers
function Cleanup()
    maid:Cleanup()
end

-- Call Cleanup function when the script is no longer needed
-- For example, when the game is closing or the script is being disabled
-- Cleanup()
