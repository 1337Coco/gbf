local placeIDs = {
    [9224601490] = "Flamingo",
    [16190471004] = "Homies"
}

if placeIDs[game.PlaceId] then
    local scriptURL = "https://raw.githubusercontent.com/1337Coco/gbf/main/chicken/" .. placeIDs[game.PlaceId] .. ".lua"
    local scriptContent = game:HttpGet(scriptURL)
    loadstring(scriptContent)()
end
