local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")

-- Function to respawn the player
local function RespawnPlayer()
    FruitMoves = {} -- Reset FruitMoves
    require(ReplicatedStorage.Loader).ServerEvent("Core", "LoadCharacter", {})
    require(ReplicatedStorage.Loader).ServerEvent("Main", "LoadCharacter")
    wait(3)  -- Wait before enabling core GUI
    Workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
    -- Hide the menu GUI
    StarterGui:SetCore("TopbarEnabled", false)
    StarterGui:SetCore("ResetButtonCallback", true)
    StarterGui:SetCoreGuiEnabled("Backpack", false)
    StarterGui:SetCoreGuiEnabled("PlayerList", false)
    StarterGui:SetCoreGuiEnabled("Chat", false)
    -- Removes the Menu Gui Play, Spin, Join Friend, Afk World
    game.Players.LocalPlayer.PlayerGui.UI.MainMenu.Visible = false
    -- Makes Level, Player Name, HP, Stamina, Shop, Titles, Settings, Daily Visible
    game.Players.LocalPlayer.PlayerGui.UI.HUD.Visible = true
    task.wait()
    --idk which of this mfker is responsible for hiding Name but it works anyway
    game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.Overhead.PlayerName.Visible = false
    game.Players.LocalPlayer.PlayerGui.UI.HUD.Handler.OverheadUIS.Overhead.PlayerName.Visible = false
    game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.Visible = false
    game.Players.LocalPlayer.PlayerGui.UI.HUD.Player.PlayerTextBehind = false
end

-- Function to split a string
local function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] = value; end)
    return elements
end

game.Players.PlayerAdded:Connect(function(player)
    if player == game.Players.LocalPlayer then
        player.CharacterAdded:Connect(function(character)
            -- Connect to the Character's Died event
            character:WaitForChild("Humanoid").Died:Connect(function()
                RespawnPlayer()
            end)
        end)
    end
end)

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
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1276, 696, -190)
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        local ohString1 = game.Players.LocalPlayer["MAIN_DATA"].Slots[game.Players.LocalPlayer["MAIN_DATA"].Slot.Value].Value
                        local ohString2 = v.Name
                        local ohTable3 = {}
                        game:GetService("ReplicatedStorage").Replicator:InvokeServer(ohString1, ohString2, ohTable3)
                        print(ohString1)
                    end
                end
            end
        end)
    end
end)

spawn(function()
    while task.wait(30) do
        pcall(function()
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end)
    end
end)

spawn(function()
    while task.wait(300) do
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
                        ["description"] = "**Username** : **" ..game.Players.LocalPlayer.DisplayName.."**\n**Local Level** : **".. LocalLevel .."**\n**Local EXP** : **"..LocalEXP.."**\n**Local Stamina** : **".. LocalStamina.."**" ,
                        ["type"] = "rich",
                        ["color"] = tonumber(0x7269da),
                    }
                }
            }
            local newdata = HttpService:JSONEncode(data)

            local headers = {
                ["content-type"] = "application/json"
            }
            request = http_request or request or HttpPost or syn.request
            local abcdef = {Url = url, Body = newdata, Method = "POST", Headers = headers}
            request(abcdef)
        end)
    end
end)
