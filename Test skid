-- MIGRAINE | KNIXNKK 
-- 10:30 PM 18 Dec 2022

function split(source, delimiters)
    local elements = {}
    local pattern = '([^'..delimiters..']+)'
    string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
    return elements
end


spawn(function()
    while task.wait(.1) do
        pcall(function()
            plr = game.Players.LocalPlayer.Character
            if plr == nil then
                wait(5)
                local Event = game:GetService("ReplicatedStorage").Replicator
                local args = {
                    [1] = "Core",
                    [2] = "LoadCharacter",
                    [3] = {
                        
                    }
                }
                Event:InvokeServer(unpack(args))
                
                local Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                local args = {
                    [1] = "Main",
                    [2] = "Core",
                    [3] = {
                        
                    }
                }
                Event:FireServer(unpack(args))
                local Event = game:GetService("ReplicatedStorage").ReplicatorNoYield
                local args = {
                    [1] = "Main",
                    [2] = "LoadCharacter"
                }
                Event:FireServer(unpack(args))
            else
                path = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Bars.ProgressStamina.Text
                exit = (split(path, "/"))
                if tonumber(exit[1]) <= tonumber(exit[2])*0.25 then
                    game.Players.LocalPlayer.Character.Humanoid.Health = 0
                else
                    _G.Toggle = true
                    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                        x = string.split(v.Name, " ")
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
                        --print(ohString1)
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait(.5) do
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
    while task.wait(600) do
        pcall(function()
            LocalLevel = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Level.Text
            LocalEXP = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.EXP.Text
            LocalStamina = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Bars.ProgressStamina.Text
            -- webhook url
            local url = "https://discordapp.com/api/webhooks/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
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
