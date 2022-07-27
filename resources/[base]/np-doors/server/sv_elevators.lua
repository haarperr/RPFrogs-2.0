RegisterNetEvent("np-doors:change-elevator-state")
AddEventHandler("np-doors:change-elevator-state", function (pElevatorId, pFloorId, pRestricted, pForceUnlock)
    if not ELEVATORS[pElevatorId] then return end
    if not ELEVATORS[pElevatorId]["floors"][pFloorId] then return end

    ELEVATORS[pElevatorId]["floors"][pFloorId]["locked"] = pRestricted

    TriggerClientEvent("np-doors:elevators:updateState", -1, pElevatorId, pFloorId, pRestricted, pForceUnlock)
end)

RPC.register("np-doors:elevators:fetch", function(src)
    return ELEVATORS
end)