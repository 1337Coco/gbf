-- Function to perform fruit moves
local function PerformFruitMoves()
    local character = LocalPlayer.Character
    local MainData = LocalPlayer.MAIN_DATA
    local CurrentData = MainData.Fruits:WaitForChild(MainData.Slots[MainData.Slot.Value].Value)
    local FruitMoves = {}

    if #FruitMoves == 0 then
        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and CurrentData.Level.Value >= tool:GetAttribute("Level") then
                FruitMoves[#FruitMoves + 1] = string.gsub(tool.Name, " ", "")
            end
        end
    else
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Move the player to the specified position if not already there
            if character.HumanoidRootPart.Position ~= Vector3.new(-4773, 1349, -279) then
                character.HumanoidRootPart.CFrame = CFrame.new(-4773, 1349, -279)
            else
                -- Perform fruit moves if the player is in the specified position
                for _, toolName in pairs(FruitMoves) do
                    if not LocalPlayer.Cooldowns:FindFirstChild(toolName) then
                        ReplicatedStorage.Replicator:InvokeServer(CurrentData.Name, toolName, {})
                    end
                end
            end
        end
    end
end
