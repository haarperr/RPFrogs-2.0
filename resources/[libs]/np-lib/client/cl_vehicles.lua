function GetVehicleIdentifier(pVehicle)
    return exports["np-vehicles"]:GetVehicleIdentifier(pVehicle)
end

function HasVehicleKey(pVehicle)
    return exports["np-vehicles"]:HasVehicleKey(pVehicle)
end

function GetVehicleFuel(pVehicle)
    return exports["np-vehicles"]:GetVehicleFuel(pVehicle)
end

function IsOnParkingSpot(pEntity, pEntity, pRadius)
    return exports["np-vehicles"]:IsOnParkingSpot(pEntity, pEntity, pRadius)
end

function VehicleHasHarness(pVehicle)
    return exports["np-vehicles"]:VehicleHasHarness(pVehicle)
end

function GetHarnessLevel(pVehicle)
    return exports["np-vehicles"]:GetHarnessLevel(pVehicle)
end

function IsUsingNitro()
    return exports["np-vehicles"]:IsUsingNitro()
end

function VehicleHasNitro(pVehicle)
    return exports["np-vehicles"]:VehicleHasNitro(pVehicle)
end

function GetNitroLevel(pVehicle)
    return exports["np-vehicles"]:GetNitroLevel(pVehicle)
end

function GetVehicleMetadata(pVehicle, pKey)
    return exports["np-vehicles"]:GetVehicleMetadata(pVehicle, pKey)
end