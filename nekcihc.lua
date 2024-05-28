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

local LightV2Attacks = {
    "Piercing Shine",
    "Photon Storm",
    "X-Flash",
    "Heavenly Descent",
    "Solar Grenade",
    "Mirror Flight"
}

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

local worldDescription = getWorldDescription(game.PlaceId)
local placeId = game.PlaceId
local newPosition
local bossName

if placeId == 9224601490 then
    newPosition = CFrame.new(1195, 562, -826)
    bossName = "Marco"
elseif placeId == 16190471004 then
    newPosition = CFrame.new(1075.33251953125, 149.14910888671875, -1187.79638671875)
    bossName = "Cake Queen"
elseif placeId == 12413901502 then
    newPosition = CFrame.new(-4773, 1349, -279)
    bossName = "Kaido"
else
    newPosition = CFrame.new(0, 0, 0)
end

local function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] = value end)
    return elements
end

if LocalPlayer then
    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
    StarterGui:SetCoreGuiEnabled('Backpack', false)
    StarterGui:SetCoreGuiEnabled('PlayerList', false)
    Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
end

local boss

spawn(function()
    while task.wait() do
        boss = game.Workspace.Characters.NPCs:FindFirstChild(bossName)
        if boss and boss:WaitForChild("Humanoid").Health >= 1 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = boss:WaitForChild("HumanoidRootPart").CFrame * CFrame.new(0, 0, 3)
        end
    end
end)

spawn(function()
    while task.wait(1) do
        pcall(function()
            local plr = game.Players.LocalPlayer.Character
            if not plr then
                wait(5)
                local Event = game:GetService("ReplicatedStorage").Replicator
                local args = {"Core", "LoadCharacter", {}}
                Event:InvokeServer(unpack(args))
                wait()

                Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                args = {"Main", "Core", {}}
                Event:FireServer(unpack(args))
                wait()

                Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                args = {"Main", "LoadCharacter"}
                Event:FireServer(unpack(args))

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
                            local Attack
                            if v:GetAttribute('Name') then
                                Attack = v:GetAttribute('Name')
                            else
                                Attack = v.Name:gsub(" ", "")
                            end

                            local fruit = GetFruit()
                            if fruit == "LightV2" then
                                if table.find(LightV2Attacks, Attack) then
                                    ReplicatedStorage.Replicator:InvokeServer(fruit, Attack)
                                end
                            else
                                ReplicatedStorage.Replicator:InvokeServer(fruit, Attack)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

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

spawn(function()
    while task.wait(600) do
        pcall(function()
            LocalLevel = LocalPlayer.PlayerGui.UI.HUD.Level.Text
            local levelDescription = LocalLevel .. "/300"
            local CurrentFruit = CurrentData.Name

            local worldDescription = getWorldDescription(game.PlaceId)

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
