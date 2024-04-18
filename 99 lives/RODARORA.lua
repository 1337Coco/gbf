local PlaceIDs = {
    [12413901502] = "BESTO",
    [16190471004] = "BESTO",
    [9224601490] = "BESTO",
    [12413901502] = "Plastic? Love~!",
    [16190471004] = "Plastic? Love~!",
    [9224601490] = "Plastic? Love~!"
}

if PlaceIDs[game.PlaceId] then
    local scriptURL = "https://raw.githubusercontent.com/1337Coco/gbf/main/pgt/" .. PlaceIDs[game.PlaceId] .. ".lua"
    local scriptContent = game:HttpGet(scriptURL)
    loadstring(scriptContent)()
end
