RegisterNetEvent("np-police:escort")
AddEventHandler("np-police:escort", function(pTarget, pToggle, pDrag)
    local src = source

    if pToggle == -1 then
        pToggle = src
    end

    TriggerClientEvent("np-police:escortReceive", pTarget, pToggle, pDrag)
end)

RegisterNetEvent("np-police:escorting")
AddEventHandler("np-police:escorting", function(pTarget, pToggle, pDrag)
    local src = source

    if not pTarget or pTarget == 0 then return end

    if pToggle == -1 then
        pToggle = src
    end

    TriggerClientEvent("np-police:escortingReceive", pTarget, pToggle, pDrag)
end)

RegisterNetEvent("police:tellSitInVehicle")
AddEventHandler("police:tellSitInVehicle", function(pTarget, pVehicle, pSeat)
    TriggerClientEvent("police:forceSeatPlayer", pTarget, pVehicle, pSeat)
end)

RegisterNetEvent("police:tellGetOutOfVehicle")
AddEventHandler("police:tellGetOutOfVehicle", function(pTarget, pVehicle)
    TriggerClientEvent("police:forceUnseatPlayer", pTarget, pVehicle)
end)