local function flipVehicle(pVehicle, pPitch, pVRoll, pVYaw)
	SetEntityRotation(pVehicle, pPitch, pVRoll, pVYaw, 1, true)
	Wait(10)
	SetVehicleOnGroundProperly(pVehicle)
end

RegisterNetEvent("vehicle:flip")
AddEventHandler("vehicle:flip", function(pVehicle, pPitch, pVRoll, pVYaw)
	flipVehicle(NetToVeh(pVehicle), pPitch, pVRoll, pVYaw)
end)

RegisterNetEvent("FlipVehicle")
AddEventHandler("FlipVehicle", function(pDummy, pEntity)
    TriggerEvent("animation:PlayAnimation", "push")
    local finished = exports["np-taskbar"]:taskBar(30000, "Flipping Vehicle Over", false, true, nil, false, nil, 10)
    ClearPedTasks(PlayerPedId())

    if finished == 100 then
        local playerped = PlayerPedId()
        local coordA = GetEntityCoords(playerped, 1)
        local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
        local pPitch, pRoll, pYaw = GetEntityRotation(playerped)
        local vPitch, vRoll, vYaw = GetEntityRotation(pEntity)

        if targetVehicle ~= 0 then
            if not NetworkHasControlOfEntity(pEntity) then
                local vehicleOwnerId = NetworkGetEntityOwner(pEntity)
                TriggerServerEvent("vehicle:flip", GetPlayerServerId(vehicleOwnerId), VehToNet(pEntity), pPitch, vRoll, vYaw)
            else
                flipVehicle(pEntity, pPitch, vRoll, vYaw)
            end
        end
    end
end)