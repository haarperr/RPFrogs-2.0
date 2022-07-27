local HotZones = {}

RegisterNetEvent("np-infinity:hotzones:requestList")
AddEventHandler("np-infinity:hotzones:requestList", function()
    local src = source

    TriggerClientEvent("np-infinity:hotzones:updateList", src, HotZones)
end)

RegisterNetEvent("np-infinity:hotzones:enteredZone")
AddEventHandler("np-infinity:hotzones:enteredZone", function(zoneId)
    local src = source

end)

RegisterNetEvent("np-infinity:hotzones:exitZone")
AddEventHandler("np-infinity:hotzones:exitZone", function(zoneId)
    local src = source

end)