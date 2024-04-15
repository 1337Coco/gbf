local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VIM = game:GetService("VirtualInputManager")

local FruitMoves = {}

-- Function to handle player's death
local function OnPlayerDied()
    print(Players.LocalPlayer.Name .. " has died.")
    -- Respawn the player
    RespawnPlayer()
end

-- Function to respawn the player
local function RespawnPlayer()
    -- Simulate mouse click to respawn
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local centerX = viewportSize.X / 2
    VM1Click(centerX, 325)
end

-- Function to simulate a mouse click at the specified coordinates
local function VM1Click(X, Y)
    if VIM then
        VIM:SendMouseButtonEvent(X, Y, 0, true, game, 0)
        wait(0.1) -- Adjust wait time as needed
        VIM:SendMouseButtonEvent(X, Y, 0, false, game, 0)
    else
        warn("VirtualInputManager not found.")
    end
end

-- Connect the key press event to the function
game:GetService("UserInputService").InputBegan:Connect(OnKeyPress)

-- Function to handle key press events
local function OnKeyPress(input)
    if input.KeyCode == Enum.KeyCode.M then
        -- Call the mouse click function to respawn
        RespawnPlayer()
    end
end

-- Function to activate FruitMoves
function FruitMoves.Activate()
    FruitMoves = {} -- Reset FruitMoves table
    while true do
        for _, move in pairs(FruitMoves) do
            if not Players.LocalPlayer.Cooldowns:FindFirstChild(move) then
                ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, move, {})
            end
        end
        wait() -- Wait for the next iteration
    end
end


-- Function to move the player to a desired location
local function MovePlayerToLocation()
    while true do
        if Players.LocalPlayer.Character then
            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
        end
        wait(5) -- Adjust the wait time as needed
    end
end

-- Connect to player's death event
Players.LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(OnPlayerDied)

-- Start FruitMoves activation loop in a separate coroutine
coroutine.wrap(FruitMoves.Activate)()

-- Start moving the player to the desired location in a separate coroutine
coroutine.wrap(MovePlayerToLocation)()

-- Start the script with respawn functionality
RespawnPlayer()

return FruitMoves
