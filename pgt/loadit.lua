local url = "https://raw.githubusercontent.com/1337Coco/gbf/main/pgt/"
local response = game:HttpGet(url)

-- Split the response into lines to get individual file names
local lines = {}
for line in response:gmatch("[^\r\n]+") do
    table.insert(lines, line)
end

-- Iterate through each file in the response
for _, fileName in ipairs(lines) do
    local fileURL = url .. fileName
    local scriptContent = game:HttpGet(fileURL)
    
    -- Execute the Lua code in the file
    local success, err = pcall(loadstring(scriptContent))
    
    -- Check if there was an error during execution
    if not success then
        print("Error executing file:", fileName)
        print(err)
    else
        print("Successfully executed file:", fileName)
    end
end
