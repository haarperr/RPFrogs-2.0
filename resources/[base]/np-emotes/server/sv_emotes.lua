RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local result = MySQL.single.await([[
        SELECT expression, walk, emotes
        FROM characters_emotes
        WHERE cid = ?
    ]],
    { cid })

    if result then
        Citizen.Wait(2000)

        TriggerClientEvent("emote:setAnimsFromDB", src, result.expression, result.walk)
        TriggerClientEvent("emote:setEmotesFromDB", src, json.decode(result.emotes))
    else
        MySQL.insert([[
            INSERT INTO characters_emotes (cid, expression, walk, emotes)
            VALUES (?, ?, ?, ?)
        ]],
        { cid, "default", "default", "{}" })
    end
end)

RegisterNetEvent("np-emotes:setExpData")
AddEventHandler("np-emotes:setExpData", function(data)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    MySQL.update([[
        UPDATE characters_emotes
        SET expression = ?
        WHERE cid = ?
    ]],
    { data, cid })
end)

RegisterNetEvent("np-emotes:setAnimData")
AddEventHandler("np-emotes:setAnimData", function(data)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    MySQL.update([[
        UPDATE characters_emotes
        SET walk = ?
        WHERE cid = ?
    ]],
    { data, cid })
end)

RegisterNetEvent("np-emotes:setEmoteData")
AddEventHandler("np-emotes:setEmoteData", function(data)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    MySQL.update([[
        UPDATE characters_emotes
        SET emotes = ?
        WHERE cid = ?
    ]],
    { json.encode(data), cid })
end)