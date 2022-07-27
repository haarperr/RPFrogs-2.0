local GeneralEntries = MenuEntries["general"]

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "scenes",
        title = "Scenes",
        icon = "#general-scenes",
        event = "place-scenes"
    },
    isEnabled = function(pEntity, pContext)
        return true
    end
}

AddEventHandler("place-scenes", function()
    ExecuteCommand("+startScene")
end)

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "check_jail",
        title = "Jail Time",
        icon = "#general-keys-give",
        event = "checkjailtime"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and exports["np-base"]:getChar("jail") > 0
    end
}

AddEventHandler("checkjailtime", function()
    TriggerEvent("chatMessage", "DOC: " , { 33, 118, 255 }, "Você tem " .. exports["np-base"]:getChar("jail") .. " meses restantes")
end)

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicles",
        title = "Vehicle",
        icon = "#vehicle-options-vehicle",
        event = "veh:options"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and IsPedInAnyVehicle(PlayerPedId(), false)
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "car-radio",
        title = "Radio",
        icon = "#car-radio",
        event = "np-radiocar:openRadial"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and (GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId() or GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId())
    end
}

AddEventHandler("np-radiocar:openRadial", function()
    ExecuteCommand("radiocar")
end)

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicles-keysgive",
        title = "Give Keys",
        icon = "#general-keys-give",
        event = "vehicle:giveKey"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and IsPedInAnyVehicle(PlayerPedId(), false) and exports["np-vehicles"]:HasVehicleKey(GetVehiclePedIsIn(PlayerPedId(), false))
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "peds-escort",
        title = "Escort",
        icon = "#general-escort",
        event = "np-police:escort"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and DecorGetInt(PlayerPedId(), "escorting") ~= 0
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "poledance:toggle",
        title = "Poledance",
        icon = "#poledance-toggle",
        event = "poledance:toggle"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and polyChecks.vanillaUnicorn.isInside and not exports["np-flags"]:HasPedFlag(PlayerPedId(), "isPoledancing")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "poledance:toggle",
        title = "Stop Poledancing",
        icon = "#poledance-toggle",
        event = "poledance:toggle"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and polyChecks.vanillaUnicorn.isInside and exports["np-flags"]:HasPedFlag(PlayerPedId(), "isPoledancing")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "oxygentank",
        title = "Remover O2 Tank",
        icon = "#oxygen-mask",
        event = "RemoveOxyTank"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and hasOxygenTankOn
    end
}


GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "policeDeadA",
        title = "10-13A",
        icon = "#police-dead",
        event = "police:tenThirteenA",
    },
    isEnabled = function(pEntity, pContext)
        return exports["np-base"]:getVar("dead") and (exports["np-jobs"]:getJob(CurrentJob, "is_police") or CurrentJob == "doc")
    end
}


GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "policeDeadB",
        title = "10-13B",
        icon = "#police-dead",
        event = "police:tenThirteenB",
    },
    isEnabled = function(pEntity, pContext)
        return exports["np-base"]:getVar("dead") and (exports["np-jobs"]:getJob(CurrentJob, "is_police") or CurrentJob == "doc")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "emsDeadA",
        title = "10-14A",
        icon = "#ems-dead",
        event = "police:tenForteenA",
    },
    isEnabled = function(pEntity, pContext)
        return exports["np-base"]:getVar("dead") and exports["np-jobs"]:getJob(false, "is_medic")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "emsDeadB",
        title = "10-14B",
        icon = "#ems-dead",
        event = "police:tenForteenB",
    },
    isEnabled = function(pEntity, pContext)
        return exports["np-base"]:getVar("dead") and exports["np-jobs"]:getJob(false, "is_medic")
    end
}


GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "unseat",
        title = "Stand Up",
        icon = "#obj-chair",
        event = "np-emotes:sitOnChair"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["np-base"]:getVar("dead") and exports["np-flags"]:HasPedFlag(PlayerPedId(), "isSittingOnChair")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "property-rent",
        title = "Rent Property",
        icon = "#real-estate-sell",
        event = "np-housing:rent"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["np-base"]:getVar("dead") and exports["np-housing"]:canRent()
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "property-enter",
        title = "Enter Property",
        icon = "#property-enter",
        event = "housing:interactionTriggered",
        parameters = false,
    },
    isEnabled = function(pEntity, pContext)
        local isNear, propertyId = exports["np-housing"]:isNearProperty()
        return not exports["np-base"]:getVar("dead") and isNear
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "property-lock",
        title = "Lock/Unlock Property",
        icon = "#property-lock",
        event = "housing:toggleClosestLock"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["np-base"]:getVar("dead") and exports["np-housing"]:canEdit()
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "property-invade",
        title = "Invade Property",
        icon = "#property-enter",
        event = "housing:interactionTriggered",
        parameters = true,
    },
    isEnabled = function(pEntity, pContext)
        local isNear, propertyId = exports["np-housing"]:isNearProperty()
        return not exports["np-base"]:getVar("dead") and isNear and exports["np-housing"]:isBeingRobbed(propertyId)
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "property-edit",
        title = "Edit Property",
        icon = "#property-edit",
        event = "np-housing:edit"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["np-base"]:getVar("dead") and exports["np-housing"]:canEdit()
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "vehicle-vehicleList",
        title = "Vehicle List",
        icon = "#vehicle-vehicleList",
        event = "np-vehicles:garage",
        parameters = { nearby = true, radius = 4.0 }
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags["isVehicleSpawner"] or not pEntity and exports["np-vehicles"]:IsOnParkingSpot(PlayerPedId(), true, 4.0))
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "fishing-borrowBoat",
        title = "Borrow Fishing Boat",
        icon = "#vehicle-vehicleList",
        event = "np-fishing:rentBoat",
        parameters = { nearby = true, radius = 4.0 }
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and not IsPedInAnyVehicle(PlayerPedId()) and (pEntity and pContext.flags["isBoatRenter"])
    end
}

local hasDrugs = function()
    return exports["np-inventory"]:hasEnoughOfItem("joint", 1, false) or
        exports["np-inventory"]:hasEnoughOfItem("1gcocaine", 1, false) or
        exports["np-inventory"]:hasEnoughOfItem("1gmeta", 1, false) or
        exports["np-inventory"]:hasEnoughOfItem("lean", 1, false)
end

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drugs-selling",
        title = "Sell Drugs",
        icon = "#weed-cultivation",
        event = "np-drugs:startSell"
    },
    isEnabled = function(pEntity, pContext)
        return not isDisabled() and hasDrugs() and not exports["np-drugs"]:isSelling() and not exports["np-jobs"]:getJob(CurrentJob, "is_emergency")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drugs-selling",
        title = "Stop Sellings",
        icon = "#weed-cultivation",
        event = "np-drugs:startSell"
    },
    isEnabled = function(pEntity, pContext)
        return exports["np-drugs"]:isSelling()
    end
}


GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "emotes:OpenMenu",
        title = "Emotes",
        icon = "#general-emotes",
        event = "emotes:OpenMenu"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["np-base"]:getVar("dead")
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drivingInstructor:testToggle",
        title = "Driving Test",
        icon = "#drivinginstructor-drivingtest",
        event = "drivingInstructor:testToggle"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["np-base"]:getVar("dead") and isInstructorMode
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "drivingInstructor:submitTest",
        title = "Submit Test",
        icon = "#drivinginstructor-submittest",
        event = "drivingInstructor:submitTest"
    },
    isEnabled = function(pEntity, pContext)
        return not exports["np-base"]:getVar("dead") and isInstructorMode
    end
}

--GeneralEntries[#GeneralEntries+1] = {
 --    data = {
--         id = "general:checkoverself",
--         title = "Se examinar",
--         icon = "#general-check-over-self",
--         event = "Evidence:CurrentDamageList"
--     },
--     isEnabled = function(pEntity, pContext)
--         return not exports["np-base"]:getVar("dead")
--     end
-- }

 GeneralEntries[#GeneralEntries+1] = {
     data = {
         id = "bennys:enter",
         title = "Enter Bennys",
         icon = "#general-check-vehicle",
         event = "bennys:enter"
     },
     isEnabled = function(pEntity, pContext)
         return not isDisabled() and polyChecks.bennys.isInside and IsPedInAnyVehicle(PlayerPedId(), false) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), -1) == PlayerPedId()
     end
 }

GeneralEntries[#GeneralEntries+1] = {
    data = {
      id = "toggle-anchor",
      title = "Toggle Anchor",
      icon = "#vehicle-anchor",
      event = "client:anchor"
    },
    isEnabled = function(pEntity, pContext)
        local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        local boatModel = GetEntityModel(currentVehicle)
        return not isDisabled() and currentVehicle ~= 0 and (IsThisModelABoat(boatModel) or IsThisModelAJetski(boatModel) or IsThisModelAnAmphibiousCar(boatModel) or IsThisModelAnAmphibiousQuadbike(boatModel))
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
      id = "mdw",
      title = "MDT",
      icon = "#mdt",
      event = "np-mdt:open"
    },
    isEnabled = function()
        return not exports["np-base"]:getVar("dead") and (exports["np-jobs"]:getJob(CurrentJob, "is_emergency") or exports["np-jobs"]:getJob(CurrentJob, "is_doj"))
    end
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "prepare-boat-mount",
        title = "Mount on Trailer",
        icon = "#vehicle-plate-remove",
        event = "vehicle:mountBoatOnTrailer"
    },
    isEnabled = function()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        if veh == 0 then
            return false
        end
        local seat = GetPedInVehicleSeat(veh, -1)
        if seat ~= ped then
            return false
        end
        local model = GetEntityModel(veh)
        if isDisabled() or not (IsThisModelABoat(model) or IsThisModelAJetski(model) or IsThisModelAnAmphibiousCar(model)) then
            return false
        end
        local left, right = GetModelDimensions(model)
        return #(vector3(0, left.y, 0) - vector3(0, right.y, 0)) < 15
    end
}

local currentJob = nil
local policeModels = {
    [`npolvic`] = true,
    [`npolexp`] = true,
    [`npolstang`] = true,
    [`npolchar`] = true,
    [`npolchal`] = true,
    [`npolvette`] = true,
}

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "open-rifle-rack",
        title = "Rifle Rack",
        icon = "#vehicle-plate-remove",
        event = "vehicle:openRifleRack"
    },
    isEnabled = function(pEntity)
        if not exports["np-jobs"]:getJob(CurrentJob, "is_police") then return false end
        local veh = GetVehiclePedIsIn(PlayerPedId())
        if veh == 0 then return false end
        local model = GetEntityModel(veh)
        if policeModels[model] == nil then return false end
        return true
    end
}

AddEventHandler("vehicle:openRifleRack", function()
    local finished = exports["np-taskbar"]:taskBar(2500, "unlocking")
    if finished ~= 100 then return end
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if veh == 0 then return end
    local vehId = exports["np-vehicles"]:GetVehicleIdentifier(veh)
    TriggerEvent("server-inventory-open", "1", "rifle-rack-" .. vehId)
end)

GeneralEntries[#GeneralEntries+1] = {
    data = {
        id = "open-documents",
        title = "Documents",
        icon = "#general-documents",
        event = "np-documents:openDocuments"
    },
    isEnabled = function()
        return not exports["np-base"]:getVar("dead")
    end
}