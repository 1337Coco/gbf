if game.PlaceId == 12413901502 or game.PlaceId == 16190471004 or game.PlaceId == 9224601490 then
  repeat
      wait()
  until game:IsLoaded()
  
  -- Initialize Gems value
  local Gems = game.Players.LocalPlayer.MAIN_DATA:WaitForChild("Gems")
  
  -- Create UI elements
  wait(0.5)
  local ScreenGui = Instance.new("ScreenGui")
  local TopFrame = Instance.new("Frame")
  local GemsLabel = Instance.new("TextLabel")
  local FooterLabel = Instance.new("TextLabel")
  
  ScreenGui.Parent = game.CoreGui
  ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  
  TopFrame.Parent = ScreenGui
  TopFrame.Active = true
  TopFrame.BackgroundColor3 = Color3.new(0.176471, 0.176471, 0.176471)
  TopFrame.Draggable = true
  TopFrame.Position = UDim2.new(1, -243, 0.5, -36)  -- Adjusted position 20 units from the right
  TopFrame.Size = UDim2.new(0, 220, 0, 60)  -- Set size to fit Gems label and footer label
  
  GemsLabel.Parent = TopFrame
  GemsLabel.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
  GemsLabel.Position = UDim2.new(0, 0, 0, 0)  -- Adjusted position to the top
  GemsLabel.Size = UDim2.new(1, 0, 0.8, 0)  -- Adjusted size to occupy most of the frame
  GemsLabel.Font = Enum.Font.SourceSansSemibold
  GemsLabel.Text = "Gems: " .. Gems.Value -- Initialize with current gems value
  GemsLabel.TextColor3 = Color3.new(0, 1, 1)
  GemsLabel.TextSize = 20  -- Decreased font size
  
  FooterLabel.Parent = TopFrame
  FooterLabel.BackgroundColor3 = Color3.new(0.196078, 0.196078, 0.196078)
  FooterLabel.Position = UDim2.new(0, 0, 0.8, 0)  -- Adjusted position to the bottom
  FooterLabel.Size = UDim2.new(1, 0, 0.2, 0)  -- Occupies the bottom portion of the frame
  FooterLabel.Font = Enum.Font.SourceSansSemibold
  FooterLabel.Text = "Made by Oapogi"
  FooterLabel.TextColor3 = Color3.new(0, 1, 1)
  FooterLabel.TextSize = 10  -- Decreased font size
  
  -- Idle kick prevention
  local VirtualUser = game:GetService('VirtualUser')
  game.Players.LocalPlayer.Idled:Connect(function()
      VirtualUser:CaptureController()
      VirtualUser:ClickButton2(Vector2.new())
      GemsLabel.Text = "Updating Gems..."
      task.wait()
      GemsLabel.Text = "Gems: " .. Gems.Value -- Update gems value after idle kick prevention
  end)
end
