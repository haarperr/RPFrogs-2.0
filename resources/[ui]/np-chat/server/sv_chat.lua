Commands = {}

RegisterNetEvent("chat:init")
AddEventHandler("chat:init", function()
    local src = source

    --TriggerEvent("np-chat:buildCommands", src)
end)

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    TriggerEvent("np-chat:buildCommands", src)
end)

RegisterNetEvent("_chat:messageEntered")
AddEventHandler("_chat:messageEntered", function(data)
    local src = source

    local isCmd = string.sub(data, 1, 1) == "/" and true or false
    if not isCmd then
        local name = exports["np-base"]:getChar(source, "first_name") .. " " .. exports["np-base"]:getChar(source, "last_name")
        TriggerClientEvent("np-chat:local", -1, source, name, data, GetEntityCoords(GetPlayerPed(src)))
        return
    end

    local args = {}
    for word in string.gmatch(string.gsub(data, "/", ""), "%S+") do
        table.insert(args, word)
    end

    if not args[1] then return end

    local cmd = string.lower(args[1])
    table.remove(args, 1)

    if Commands[cmd] then
        local infos = {
            ["rank"] = exports["np-base"]:getUser(src, "rank"),
            ["job"] = exports["np-base"]:getChar(src, "job"),
            ["jobrank"] = exports["np-groups"]:getRank(exports["np-base"]:getChar(src, "job"), src),
        }

        if Conditions[Commands[cmd]["condition"]["type"]](src, Commands[cmd]["condition"]["params"], infos) then
            Commands[cmd]["function"](src, args)
        end
    else
        TriggerClientEvent("chatMessage", src, "System: ", {255, 0, 0}, 'Invalid Command "' .. "/" .. cmd .. '"')
    end
end)

RegisterNetEvent("np-chat:buildCommands")
AddEventHandler("np-chat:buildCommands", function(_src)
    local src = source
    if _src then src = _src end

    local infos = {
        ["rank"] = exports["np-base"]:getUser(src, "rank"),
        ["job"] = exports["np-base"]:getChar(src, "job"),
        ["jobrank"] = exports["np-groups"]:getRank(exports["np-base"]:getChar(src, "job"), src),
    }

    TriggerClientEvent("chat:removeSuggestions", src)

    local suggestions = {}
    for k, v in pairs(Commands) do
        if v["condition"] then
            if Conditions[v["condition"]["type"]](src, v["condition"]["params"], infos) then
                if v["suggestion"] then
                    v["suggestion"]["name"] = "/" .. k
                    table.insert(suggestions, v["suggestion"])
                end
            end
        end
    end

    TriggerClientEvent("chat:addSuggestions", src, suggestions)
end)