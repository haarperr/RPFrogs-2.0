local VehicleEntries = MenuEntries["vehicles"]

VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "vehicle-parkvehicle",
        title = "Park Vehicle",
        icon = "#vehicle-parkvehicle",
        event = "np-vehicles:storeVehicle"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and exports["np-vehicles"]:HasVehicleKey(pEntity) and exports["np-vehicles"]:IsOnParkingSpot(pEntity, false) and not IsPedInAnyVehicle(PlayerPedId(), false)
    end
}

VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "247goods",
        title = "Take Items",
        icon = "#obj-box",
        event = "np-jobs:247delivery:takeGoods"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and GetEntityModel(pEntity) == `benson` and CurrentJob == "247_deliveries" and isCloseToTrunk(pEntity, PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), false)
    end
}

VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "impound-vehicle",
        title = "Request Impound",
        icon = "#vehicle-impound",
        event = "np-police:impound",
        parameters = {}
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and pContext.distance <= 2.5 and not IsPedInAnyVehicle(PlayerPedId(), false) and exports["np-jobs"]:getJob(CurrentJob, "is_emergency")
    end
}

VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "impound-vehicle",
        title = "Impound Car",
        icon = "#vehicle-impound",
        event = "np-jobs:impound:openImpoundMenu",
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and pContext.distance <= 2.5 and CurrentJob == "impound" and IsImpoundDropOff and not IsPedInAnyVehicle(PlayerPedId(), false)
    end
}

VehicleEntries[#VehicleEntries+1] = {
    data = {
        id = "prepare-boat-trailer",
        title = "Prep for Mount",
        icon = "#vehicle-plate-remove",
        event = "vehicle:primeTrailerForMounting"
    },
    isEnabled = function(pEntity, pContext)
        local model = GetEntityModel(pEntity)
        return not isDisabled() and (model == `boattrailer` or model == `trailersmall`)
    end
}
