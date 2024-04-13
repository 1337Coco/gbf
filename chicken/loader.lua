local PlaceIDs = {
    [9224601490] = "Flamingo",
    [16190471004] = "Homies",
    [12413901502] = "Dragon"
}

if PlaceIDs[game.PlaceId] then
    local scriptURL = "https://raw.githubusercontent.com/1337Coco/gbf/main/chicken/" .. PlaceIDs[game.PlaceId] .. ".lua"
    local scriptContent = game:HttpGet(scriptURL)
    loadstring(scriptContent)()
end
