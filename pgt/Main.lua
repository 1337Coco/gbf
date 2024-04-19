local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")

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

-- Listen for the player's character added event
Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then
        player.CharacterAdded:Connect(function(character)
            -- Connect to the Character's Died event
            character:WaitForChild("Humanoid").Died:Connect(function()
                RespawnPlayer()
            end)
        end)
    end
end)

-- Extracting data for the equipped fruit
local MainData = LocalPlayer:WaitForChild("MAIN_DATA")
local slotValue = MainData:WaitForChild("Slot").Value
local slotData = MainData:WaitForChild("Slots")
local currentSlot = slotData[slotValue]
local currentFruitName = currentSlot.Value
local fruitsData = MainData:WaitForChild("Fruits")
local currentFruitData = fruitsData:WaitForChild(currentFruitName)
local currentFruitLevel = currentFruitData.Level.Value

-- Create a BindableEvent for character added events
local characterAddedEvent = Instance.new("BindableEvent")

-- Function to handle character added event
Players.LocalPlayer.CharacterAdded:Connect(function(character)
    FruitMoves = {}  -- Clear the FruitMoves table
    characterAddedEvent:Fire()  -- Fire the BindableEvent
    print("FruitMoves reset!")
end)

-- Find the ProgressStamina element within PlayerGui
local progressStamina = PlayerGui.UI.HUD.Bars.ProgressStamina

-- Merge functions from StaminaUtils.lua

local function CheckStamina()
    if progressStamina then
        -- Trim the last 5 characters from the ProgressStamina text
        local progressStaminaText = progressStamina.Text
        local trimmedText = progressStaminaText:sub(1, #progressStaminaText - 5) -- Trims 5 characters from the right
        
        -- Convert the trimmed text to a number (currentStamina)
        local currentStamina = tonumber(trimmedText)
        
        -- Function to calculate maxStamina
        local function calculateMaxStamina(level)
            return level * 4 + 200
        end
        
        -- Calculate maxStamina based on currentFruitLevel
        local maxStamina = calculateMaxStamina(currentFruitLevel)
        
        -- Calculate the percentage of currentStamina relative to maxStamina
        local percentageRemaining = (currentStamina / maxStamina) * 100
        
        -- Define the threshold percentage
        local thresholdPercentage = 10
        
        -- Check if the percentage remaining is below the threshold
        if percentageRemaining <= thresholdPercentage then
            -- Perform an action when currentStamina is low
            print("Current stamina is low. Performing action...")
            LocalPlayer.Character:BreakJoints()
        end
    end
end

-- Coroutine to continuously check stamina and fruit moves
local function MainCoroutine()
    while true do
        CheckStamina()

        -- Check for fruit moves
        if #FruitMoves == 0 then
            for _, tool in ipairs(LocalPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") and currentFruitLevel >= tool:GetAttribute("Level") then
                    FruitMoves[#FruitMoves + 1] = string.gsub(tool.Name, " ", "")
                end
            end
        else
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)

            for _, toolName in ipairs(FruitMoves) do
                if not LocalPlayer.Cooldowns:FindFirstChild(toolName) then
                    ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, toolName, {})
                end
            end
        end

        wait(0.25)
    end
end

-- Start the main coroutine
coroutine.wrap(MainCoroutine)()
