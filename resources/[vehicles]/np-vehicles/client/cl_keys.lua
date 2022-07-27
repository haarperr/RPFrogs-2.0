--[[

    Variables

]]

local currentVehicle = 0
local currentVehicleIdentifier = nil
local currentVehicleSeat = -1

local Keys = {
    ["identifier"] = {},
    ["plate"] = {},
}

--[[

    Functions

]]

function HasVehicleKey(vehicle)
    if not DoesEntityExist(vehicle) then
		return false
	end

    local plate = GetVehiclePlate(vehicle)
    local identifier = GetVehicleIdentifier(vehicle)

    if identifier then
        return has_value(Keys["identifier"], identifier)
    elseif plate then
        return has_value(Keys["plate"], plate)
    end

    return false
end

local function getClosestPlayer(coords, pDist)
    local closestPlyPed
    local closestPly
    local dist = -1

    for _, player in ipairs(GetActivePlayers()) do
        if player ~= PlayerId() then
            local ped = GetPlayerPed(player)
            local pedcoords = GetEntityCoords(ped)
            local newdist = #(coords - pedcoords)

            if (newdist <= pDist) then
                if (newdist < dist) or dist == -1 then
                    dist = newdist
                    closestPlyPed = ped
                    closestPly = player
                end
            end
        end
    end

    return GetPlayerServerId(closestPly), dist
end

function HotwireVehicle(cb)
    local hotwire = {}

    if currentVehicle == 0 then
        cb(hotwire)
        return
    end

    for i = 1, 5 do
        local skill = {30000, 20}
        hotwire.stage = 5

        if i == 2 then
            hotwire.stage = 4
            skill = {math.random(25000, 30000), 18}
        elseif i == 3 then
            hotwire.stage = 3
            skill = {math.random(15000, 20000), 15}
        elseif i == 4 then
            hotwire.stage = 2
            skill = {math.random(10000, 15000), 13}
        elseif i == 5 then
            hotwire.stage = 1
            skill = {math.random(5000, 7000), 10}
        end

        local finished = exports["np-taskbarskill"]:taskBarSkill(skill[1],  skill[2])
        if finished ~= 100 then
            cb(hotwire)
            return
        end
    end

    hotwire.stage = 0
    hotwire.success = true

    cb(hotwire)

    SetVehicleHasBeenOwnedByPlayer(currentVehicle, true)
    Sync.SetVehicleDoorsLocked(currentVehicle, 1)
    TriggerEvent("keys:addNew", currentVehicle)
    TriggerEvent("DoLongHudText", "Ignition Working.")

    exports["np-flags"]:SetVehicleFlag(currentVehicle, "isHotwiredVehicle", true)
end

--[[

    Exports

]]

exports("HasVehicleKey", HasVehicleKey)
exports("HotwireVehicle", HotwireVehicle)

--[[

    Events

]]

RegisterNetEvent("keys:receive")
AddEventHandler("keys:receive", function(_keys)
    Keys = _keys
end)

AddEventHandler("vehicle:giveKey", function()
    local vehicle = nil

    if currentVehicle == 0 then
        local target = exports["np-target"]:GetCurrentEntity()
        if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
            vehicle = target
        end
    else
        vehicle = currentVehicle
    end

    if not vehicle then return end

    local identifier = GetVehicleIdentifier(vehicle)
    local plate = GetVehiclePlate(vehicle)

    local target, distance = getClosestPlayer(GetEntityCoords(PlayerPedId()), 5.0)
    if distance ~= -1 and distance < 5 then
        TriggerServerEvent("np-vehicles:sendKeys", target, identifier, plate)
    else
        TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!", 2)
    end
end)

RegisterNetEvent("keys:addNew")
AddEventHandler("keys:addNew", function(vehicle, _identifier, _plate)
    if not vehicle or not DoesEntityExist(vehicle) then
		if not _identifier and not _plate then
            return
        end
	end

    local identifier = GetVehicleIdentifier(vehicle)
    local plate = GetVehiclePlate(vehicle)

    if _identifier then identifier = _identifier end
    if _plate then plate = _plate end

    if identifier then
        if not has_value(Keys["identifier"], identifier) then
            table.insert(Keys["identifier"], identifier)
            TriggerServerEvent("keys:update", "identifier", identifier)
        end
    elseif plate then
        if not has_value(Keys["plate"], plate) then
            table.insert(Keys["plate"], plate)
            TriggerServerEvent("keys:update", "plate", plate)
        end
    end
end)

AddEventHandler("keys:cannotOperate", function(toggle)
    if toggle then
        Sync.SetVehicleUndriveable(currentVehicle, false)
    else
        Sync.SetVehicleEngineOn(currentVehicle, 0, 1, 1)
	    Sync.SetVehicleUndriveable(currentVehicle, true)
    end
end)

AddEventHandler("keys:toggleLock", function(_vehicle)
    local vehicle = nil

    if _vehicle then
        vehicle = _vehicle
    elseif currentVehicle ~= 0 then
        vehicle = currentVehicle
    else
        local target = exports["np-target"]:GetCurrentEntity()
        if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5  then
            vehicle = target
        end
    end

    if not vehicle or not HasVehicleKey(vehicle) then return end

    local lockStatus = GetVehicleDoorLockStatus(vehicle)

    TriggerEvent("dooranim")

    if lockStatus == 1 or lockStatus == 0 then
        Sync.SetVehicleDoorsLocked(vehicle, 2)

        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "lock", 0.4)
        TriggerEvent("DoLongHudText", "Veiculo Trancado")

        if currentVehicle == 0 then
            SetVehicleLights(vehicle, 2)

            SetVehicleBrakeLights(vehicle, true)
            SetVehicleInteriorlight(vehicle, true)
            SetVehicleIndicatorLights(vehicle, 0, true)
            SetVehicleIndicatorLights(vehicle, 1, true)

            Citizen.Wait(450)

            SetVehicleIndicatorLights(vehicle, 0, false)
            SetVehicleIndicatorLights(vehicle, 1, false)

            Citizen.Wait(450)

            SetVehicleInteriorlight(vehicle, true)
            SetVehicleIndicatorLights(vehicle, 0, true)
            SetVehicleIndicatorLights(vehicle, 1, true)

            Citizen.Wait(450)

            SetVehicleLights(vehicle, 0)
            SetVehicleBrakeLights(vehicle, false)
            SetVehicleInteriorlight(vehicle, false)
            SetVehicleIndicatorLights(vehicle, 0, false)
            SetVehicleIndicatorLights(vehicle, 1, false)
        end
    else
        Sync.SetVehicleDoorsLocked(vehicle, 1)

        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5.0, "unlock", 0.1)
        TriggerEvent("DoLongHudText", "Vehicle Unlocked")

        if currentVehicle == 0 then
            SetVehicleLights(vehicle, 2)
            SetVehicleFullbeam(vehicle, true)
            SetVehicleBrakeLights(vehicle, true)
            SetVehicleInteriorlight(vehicle, true)
            SetVehicleIndicatorLights(vehicle, 0, true)
            SetVehicleIndicatorLights(vehicle, 1, true)

            Citizen.Wait(450)

            SetVehicleIndicatorLights(vehicle, 0, false)
            SetVehicleIndicatorLights(vehicle, 1, false)

            Citizen.Wait(450)

            SetVehicleInteriorlight(vehicle, true)
            SetVehicleIndicatorLights(vehicle, 0, true)
            SetVehicleIndicatorLights(vehicle, 1, true)

            Citizen.Wait(450)

            SetVehicleLights(vehicle, 0)
            SetVehicleFullbeam(vehicle, false)
            SetVehicleBrakeLights(vehicle, false)
            SetVehicleInteriorlight(vehicle, false)
            SetVehicleIndicatorLights(vehicle, 0, false)
            SetVehicleIndicatorLights(vehicle, 1, false)
        end
    end
end)

AddEventHandler("baseevents:enteringVehicle", function(pVehicle, pSeat, pClass)
    if pSeat == -1 and pVehicle then
        local hasDriver = IsVehicleSeatFree(pVehicle, -1) ~= 1
        if hasDriver then return end
    end

    SetVehicleCanEngineOperateOnFire(pVehicle, false)
end)

AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    currentVehicle = pCurrentVehicle
    currentVehicleIdentifier = GetVehicleIdentifier(pCurrentVehicle)
    currentVehicleSeat = pCurrentSeat

    local vehicleClass = GetVehicleClass(pCurrentVehicle)
    if vehicleClass ~= 13 then
        if currentVehicleSeat == -1 and not IsVehicleEngineOn(currentVehicle) then
            TriggerEvent("keys:cannotOperate")
        end
    end
end)

AddEventHandler("baseevents:leftVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    currentVehicle = 0
    currentVehicleIdentifier = nil
    currentVehicleSeat = -1
end)

AddEventHandler("baseevents:vehicleChangedSeat", function(pCurrentVehicle, pCurrentSeat, previousSeat)
    currentVehicleSeat = pCurrentSeat

    if pCurrentSeat == -1 and not IsVehicleEngineOn(currentVehicle) then
        TriggerEvent("keys:cannotOperate")
    end
end)

--[[

    Threads

]]

Citizen.CreateThread( function()
    RegisterCommand('+toggleLock', function()
        TriggerEvent("keys:toggleLock")
    end, false)
    RegisterCommand('-toggleLock', function() end, false)
    exports["np-keybinds"]:registerKeyMapping("", "Vehicle", "Lock/Unlock Vehicle", "+toggleLock", "-toggleLock", "U")

    while true do
        Citizen.Wait(1)

        local doingsomething = false

        if currentVehicle ~= 0 and currentVehicleSeat == -1 then
            doingsomething = true

            CanShuffleSeat(PlayerPedId(), false)

            if IsControlJustReleased(1, 96) and not IsThisModelAHeli(GetEntityModel(currentVehicle)) then
                TriggerEvent("vehicle:toggleEngine")
            end
        end

        if GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= nil and GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 0 then
            doingsomething = true

            local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId())

            if IsVehicleNeedsToBeHotwired(vehicle) then
                SetVehicleNeedsToBeHotwired(vehicle, false)
            end

            if not HasVehicleKey(vehicle) then
                local pedDriver = GetPedInVehicleSeat(vehicle, -1)

                if pedDriver ~= 0 and (not IsPedAPlayer(pedDriver) or IsEntityDead(pedDriver)) then
                    if IsEntityDead(pedDriver) then
                        TriggerEvent("civilian:alertPolice", 20.0, "lockpick", targetVehicle)

                        local finished = exports["np-taskbar"]:taskBar(3000, "Taking Keys", false)
                        if finished == 100 then
                            TriggerEvent("keys:addNew", vehicle)
                            exports["np-flags"]:SetVehicleFlag(vehicle, "isStolenVehicle", true)
                        else
                            ClearPedTasksImmediately(PlayerPedId())
                        end
                    else
                        if math.random(100) > 95 then
                            TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)

                            local finished = exports["np-taskbar"]:taskBar(3000, "Taking Keys")
                            if finished == 100 then
                                TriggerEvent("keys:addNew", vehicle)
                            else
                                ClearPedTasksImmediately(PlayerPedId())
                            end
                        else
                            Sync.SetVehicleDoorsLocked(vehicle, 2)
                            Citizen.Wait(1000)
                            TriggerEvent("civilian:alertPolice",20.0,"lockpick",targetVehicle)
                            TaskReactAndFleePed(pedDriver, PlayerPedId())
                            SetPedKeepTask(pedDriver, true)
                            ClearPedTasksImmediately(PlayerPedId())
                        end
                    end
                end
            end
        end

        if IsPedJacking(PlayerPedId()) then
            doingsomething = true

            local vehicle = GetVehiclePedIsUsing(PlayerPedId())

            while true do
                if not IsPedInAnyVehicle(PlayerPedId(), false) then
                    break
                end

                if IsVehicleEngineOn(vehicle) and not HasVehicleKey(vehicle) then
                    TriggerEvent("keys:cannotOperate")
                    break
                end

                Citizen.Wait(1)
            end
        end

        if not doingsomething then
            Citizen.Wait(100)
        end
    end
end)