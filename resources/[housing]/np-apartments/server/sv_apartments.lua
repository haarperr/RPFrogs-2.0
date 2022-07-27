--[[

    Variables

]]

local Apartments = {}

--[[

    Events

]]

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    local hotel = exports["np-base"]:getChar(src, "hotel")

    local type = hotel
    local room = 1

    for i, v in ipairs(Apartments[type]) do
        if v == 0 then
            Apartments[type][i] = {
                src = src,
                cid = cid,
                type = type,
                room = i,
            }

            room = i

            break
        end
    end

    TriggerClientEvent("apartments:apartmentSpawn", src, hotel, room)
end)

AddEventHandler("np-apartments:deSpawn", function(src)
    for i, v in ipairs(Apartments) do
        for i2, v2 in ipairs(v) do
            if v2 ~= 0 then
                if v2.src == src then
                    Apartments[i][i2] = 0
                end
            end
        end
    end
end)

AddEventHandler("playerDropped", function()
	local src = source

    for i, v in ipairs(Apartments) do
        for i2, v2 in ipairs(v) do
            if v2 ~= 0 then
                if v2.src == src then
                    Apartments[i][i2] = 0
                end
            end
        end
    end
end)

--[[

    RPCs

]]

RPC.register("GetMotelInformation", function(src, type, room)
    return Apartments[type][room]
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    for i, v in ipairs(Apart.MaxRooms) do
        Apartments[i] = {}

        for i2 = 1, v do
            table.insert(Apartments[i], 0)
        end
    end
end)