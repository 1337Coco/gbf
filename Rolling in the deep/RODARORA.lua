local PlaceIDs = {
    [9224601490] = "nips",
    [9224601490] = "nips nottub",
    [9224601490] = "iu smeg",
    [9224601490] = "edoc"
}

if PlaceIDs[game.PlaceId] then
    local scriptURL = "https://raw.githubusercontent.com/1337Coco/gbf/main/Rolling%20in%20the%20deep" .. PlaceIDs[game.PlaceId] .. ".lua"
    local scriptContent = game:HttpGet(scriptURL)
    loadstring(scriptContent)()
end
