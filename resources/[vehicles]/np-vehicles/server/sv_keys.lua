--[[

    Variables

]]

local Keys = {}

--[[

    Events

]]

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    if Keys[cid] then
        TriggerClientEvent("keys:receive", src, Keys[cid])
    end
end)

RegisterNetEvent("keys:update")
AddEventHandler("keys:update", function(type, value)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    if not Keys[cid] then
        Keys[cid] = {}
    end

    if not Keys[cid][type] then
        Keys[cid][type] = {}
    end

    table.insert(Keys[cid][type], value)
end)

RegisterNetEvent("np-vehicles:sendKeys")
AddEventHandler("np-vehicles:sendKeys", function(target, identifier, plate)
    local src = source

    TriggerClientEvent("keys:addNew", target, 0, identifier, plate)

    TriggerClientEvent("DoLongHudText", src, "You gave the keys from the vehicle")
    TriggerClientEvent("DoLongHudText", target, "You received the keys from the vehicle")
end)