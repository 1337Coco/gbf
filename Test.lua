local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

local FruitMoves = {}

local function OnPlayerDied()
    print(Players.LocalPlayer.Name .. " has died.")
    RespawnPlayer()
end

local function RespawnPlayer()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = viewportSize.X / 2
    VM1Click(centerX, 325)
end

local function VM1Click(X, Y)
    if VIM then
        VIM:SendMouseButtonEvent(X, Y, 0, true, game, 0)
        wait(0.1)
        VIM:SendMouseButtonEvent(X, Y, 0, false, game, 0)
    else
        warn("VirtualInputManager not found.")
    end
end

game:GetService("UserInputService").InputBegan:Connect(OnKeyPress)

local function OnKeyPress(input)
    if input.KeyCode == Enum.KeyCode.M then
        RespawnPlayer()
    end
end

function FruitMoves.Activate()
    while true do
        for _, move in pairs(FruitMoves) do
            if not Players.LocalPlayer.Cooldowns:FindFirstChild(move) then
                ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, move, {})
            end
        end
        wait()
    end
end

local function MovePlayerToLocation()
    if Players.LocalPlayer.Character then
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
    end
end

Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(OnPlayerDied)
MovePlayerToLocation()

local player = game.Players.LocalPlayer
local mainData = player:WaitForChild("MAIN_DATA")
local slotValue = mainData:WaitForChild("Slot").Value
local slotData = mainData:WaitForChild("Slots")
local currentSlot = slotData[slotValue]
local currentFruitName = currentSlot.Value

local fruitsData = mainData:WaitForChild("Fruits")
local currentFruitData = fruitsData:WaitForChild(currentFruitName)
local currentFruitLevel = currentFruitData.Level.Value

local progressStamina = player.PlayerGui.UI.HUD.Bars.ProgressStamina

if progressStamina then
    local function calculateMaxStamina(level)
        return level * 4 + 200
    end
    
    local progressStaminaText = progressStamina.Text
    if progressStaminaText then
        local trimmedText = progressStaminaText:sub(1, #progressStaminaText - 5)
        local currentStamina = tonumber(trimmedText)
        local maxStamina = calculateMaxStamina(currentFruitLevel)
        local percentageRemaining = (currentStamina / maxStamina) * 100
        local thresholdPercentage = 10
        
        if percentageRemaining <= thresholdPercentage then
            player.Character:BreakJoints()
        end
        print("Current Stamina:", currentStamina)
        print("Max Stamina:", maxStamina)
        print("Percentage Remaining:", percentageRemaining)
    else
        print("ProgressStamina text is nil.")
    end
else
    print("ProgressStamina element not found in PlayerGui.")
end

return FruitMoves
