local readyPlayers = {}

RegisterNetEvent("np-sync:playerReady")
AddEventHandler("np-sync:playerReady", function()
    local src = source

    readyPlayers[src] = true
end)

RegisterNetEvent("np-sync:request")
AddEventHandler("np-sync:request", function(native, playerid, entityid, args)
    local src = source

    if readyPlayers[playerid] then
        TriggerClientEvent("np-sync:execute", playerid, native, entityid, args)
    end
end)

RegisterNetEvent("np-sync:executeSyncNative")
AddEventHandler("np-sync:executeSyncNative", function(native, netEntity, options, args)
    local src = source

    TriggerClientEvent("np-sync:clientExecuteSyncNative", -1, native, netEntity, options, args)
end)