local PlaceIDs = {
    [12413901502] = "Main",
    [12413901502] = "Respawner"
}

if PlaceIDs[game.PlaceId] then
    local scriptURL = "https://raw.githubusercontent.com/1337Coco/gbf/main/pgt/" .. PlaceIDs[game.PlaceId] .. ".lua"
    local scriptContent = game:HttpGet(scriptURL)
    loadstring(scriptContent)()
end
