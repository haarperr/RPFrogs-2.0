RegisterNetEvent("vehicle:flip")
AddEventHandler("vehicle:flip", function(pTarget, pVehicle, pPitch, pVRoll, pVYaw)
	TriggerClientEvent("vehicle:flip", pTarget, pVehicle, pPitch, pVRoll, pVYaw)
end)