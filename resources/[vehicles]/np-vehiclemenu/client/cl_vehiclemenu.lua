--[[

    Variables

]]

local enabled = false
local player = false
local veh = 0
local vehicle_fuel = 0

--[[

    Functions

]]

function EnableGUI(enable)
    enabled = enable

    SetCustomNuiFocus(enable, enable)

    SendNUIMessage({
        type = "enablecarmenu",
        enable = enable
    })
end

function checkSeat(player, veh, seatIndex)
    local ped = GetPedInVehicleSeat(veh, seatIndex);
    if ped == player then
        return seatIndex;
    elseif ped ~= 0 then
        return false;
    else
        return true;
    end
end

function refreshUI()
    local settings = {}
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        settings.seat1 = checkSeat(player, veh, -1)
        settings.seat2 = checkSeat(player, veh,  0)
        settings.seat3 = checkSeat(player, veh,  1)
        settings.seat4 = checkSeat(player, veh,  2)

        settings.doorAccess = settings.seat1 == -1 and true or false
        if GetVehicleDoorAngleRatio(veh, 0) ~= 0 then
            settings.door0 = true
        end
        if GetVehicleDoorAngleRatio(veh, 1) ~= 0 then
            settings.door1 = true
        end
        if GetVehicleDoorAngleRatio(veh, 2) ~= 0 then
            settings.door2 = true
        end
        if GetVehicleDoorAngleRatio(veh, 3) ~= 0 then
            settings.door3 = true
        end
        if GetVehicleDoorAngleRatio(veh, 4) ~= 0 then
            settings.hood = true
        end
        if GetVehicleDoorAngleRatio(veh, 5) ~= 0 then
            settings.trunk = true
        end

        if not IsVehicleWindowIntact(veh, 0) then
            settings.windowr1 = true
        end
        if not IsVehicleWindowIntact(veh, 1) then
            settings.windowl1 = true
        end
        if not IsVehicleWindowIntact(veh, 2) then
            settings.windowr2 = true
        end
        if not IsVehicleWindowIntact(veh, 3) then
            settings.windowl2 = true
        end

        local engine = GetIsVehicleEngineRunning(veh);
        -- local lockStatus = GetVehicleDoorLockStatus(veh)
        -- if (lockStatus == 1 or lockStatus == 0) and settings.seat1 == -1 then
        --     settings.engineAccess = true
        -- end
        if engine then
            settings.engine = true
        else
            settings.engine = false
        end

        SendNUIMessage({
            type = "refreshcarmenu",
            settings = settings
        })
    else
        SendNUIMessage({
            type = "resetcarmenu"
        })
    end
end

function SetCustomNuiFocus(hasKeyboard, hasMouse)
    HasNuiFocus = hasKeyboard or hasMouse

    SetNuiFocus(hasKeyboard, hasMouse)
    SetNuiFocusKeepInput(HasNuiFocus)

    TriggerEvent("np-voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end

--[[

    Events

]]

RegisterNetEvent("veh:options")
AddEventHandler("veh:options", function()
    EnableGUI(true)
end)

AddEventHandler("car:doors", function(pArgs, pEntity)
    local lockStatus = GetVehicleDoorLockStatus(pEntity)
    if lockStatus ~= 1 and lockStatus ~= 0 then
        TriggerEvent("DoLongHudText", "The vehicle is locked!", 2)
        return
    end

    loadAnimDict("anim@narcotics@trash")
    TaskPlayAnim(PlayerPedId(), "anim@narcotics@trash", "drop_front", 0.9, -8, 1500, 49, 3.0, 0, 0, 0)
    TaskTurnPedToFaceEntity(PlayerPedId(), pEntity, 1.0)
    Citizen.Wait(1600)
    ClearPedTasks(PlayerPedId())

    if (GetVehicleDoorAngleRatio(pEntity, pArgs) == 0) then
        Sync.SetVehicleDoorOpen(pEntity, pArgs, false, false)
    else
        Sync.SetVehicleDoorShut(pEntity, pArgs, false)
    end
end)

--[[

    NUI

]]

RegisterNUICallback("openDoor", function(data, cb)
    doorIndex = tonumber(data["doorIndex"])
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)

    if veh ~= 0 then
        -- if doors are unlocked?
        -- if not GetVehicleDoorsLockedForPlayer(veh, player) then
        local lockStatus = GetVehicleDoorLockStatus(veh)
        if lockStatus == 1 or lockStatus == 0 then
            if (GetVehicleDoorAngleRatio(veh, doorIndex) == 0) then
                Sync.SetVehicleDoorOpen(veh, doorIndex, false, false)
            else
                Sync.SetVehicleDoorShut(veh, doorIndex, false)
            end
        end
    end
    cb("ok")
end)

RegisterNUICallback("switchSeat", function(data, cb)
    TriggerEvent("vehicle:swapSeat", tonumber(data["seatIndex"]))
    cb("ok")
end)

RegisterNUICallback("togglewindow", function(data, cb)
    windowIndex = tonumber(data["windowIndex"])
    player = GetPlayerPed(-1)
    veh = GetVehiclePedIsIn(player, false)
    if veh ~= 0 then
        if not IsVehicleWindowIntact(veh, windowIndex) then
            RollUpWindow(veh, windowIndex)
            if not IsVehicleWindowIntact(veh, windowIndex) then
                RollDownWindow(veh, windowIndex)
            end
        else
            RollDownWindow(veh, windowIndex)
        end
    end
    cb("ok")
end)

RegisterNUICallback("toggleengine", function(data, cb)
    TriggerEvent("vehicle:toggleEngine")
    cb("ok")
end)

RegisterNUICallback("escape", function(data, cb)
    EnableGUI(false)
    cb("ok")
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if veh ~= 0 then
            if enabled then
                refreshUI()
            end
        else
            Wait(100)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        player = GetPlayerPed(-1)
        veh = GetVehiclePedIsIn(player, false)
        if veh ~= 0 then
            local temp_veh_fuel = GetVehicleFuelLevel(veh)
            if temp_veh_fuel > 0 then
                vehicle_fuel = temp_veh_fuel
            end
        end
        Citizen.Wait(2000)
    end
end)