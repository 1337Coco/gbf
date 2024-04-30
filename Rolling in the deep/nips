if game.PlaceId == 12413901502 or game.PlaceId == 16190471004 or game.PlaceId == 9224601490 then
  repeat
      wait()
  until game:IsLoaded()
  
  -- Continuously check for a specific condition
  while true do
      local MessageBox = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/NotificationGUI/main/source.lua"))()
      -- Define wanted fruits
      
      local wantedFruits = {"Nika", "Venom", "Ope", "Leopard", "Lightning", "Dough", "Dragon", "DragonV2", "Soul", "DarkXQuake"}
      -- Define current fruit
      local currentFruit = game.Players.LocalPlayer.MAIN_DATA.Slots["1"].Value
      
      wait(3)
      if table.find(wantedFruits, currentFruit) then
          wait(2)
          MessageBox.Show({Text = "Fruit Battlegrounds", Description = "YOU GOT A MYTHIC FRUIT:\n\t\t\t\t\t" .. currentFruit .. '!'})
          wait(600)
          break
      elseif currentFruit == 'Nika' then
          MessageBox.Show({Text = "Fruit Battlegrounds", Description = "YOU GOT A MYTHIC FRUIT:\n\t\t\t\t\t" .. "Nika" .. '!'})
          wait(600)
      elseif currentFruit == 'DragonV2' then
          MessageBox.Show({Text = "Fruit Battlegrounds", Description = "YOU GOT A MYTHIC FRUIT:\n\t\t\t\t\t" .. "DragonV2" .. '!'})
          wait(600)
      elseif currentFruit == 'Soul' then
          MessageBox.Show({Text = "Fruit Battlegrounds", Description = "YOU GOT A MYTHIC FRUIT:\n\t\t\t\t\t" .. "Soul" .. '!'})
          wait(600)
      elseif currentFruit == 'DarkXQuake' then
          MessageBox.Show({Text = "Fruit Battlegrounds", Description = "YOU GOT A MYTHIC FRUIT:\n\t\t\t\t\t" .. "DarkXQuake" .. '!'})
          wait(600)
      else
          local string_1 = "FruitsHandler"
          local string_2 = "Spin"
          local table_1 = {}
  
          local target = game:GetService("ReplicatedStorage").Replicator
          target:InvokeServer(string_1, string_2, table_1)
          wait(1)
      end
  end
end
