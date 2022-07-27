--[[

    Variables

]]

guiEnabled = false
currentTask = 0
local coffeetimer = 0

--[[

    Functions

]]

function closeGui()
    SendNUIMessage({
        stop = true
    })

    guiEnabled = false
end

function taskCancel()
    currentTask = 2
    closeGui()
end

function taskBar(length, name, runCheck, keepWeapon, vehicle, vehCheck, cb, moveCheck)
    local playerPed = PlayerPedId()
    local firstPosition = GetEntityCoords(playerPed)

    if guiEnabled then
        if cb then cb(0) end
        return 0
    end

    if coffeetimer > 0 then
        length = math.ceil(length * 0.66)
    end

    Config.display = true
    Config.Duration = length
    Config.Label = name

    SendNUIMessage(Config)

    guiEnabled = true

    if not keepWeapon then
        TriggerEvent("actionbar:setEmptyHanded")
    end

    currentTask = 0

    while currentTask == 0 do
        Citizen.Wait(1)

        local playerPed = PlayerPedId()

        if not keepWeapon and GetSelectedPedWeapon(playerPed) ~= GetHashKey("WEAPON_UNARMED") then
            closeGui()
            if cb then cb(0) end
            return 0
        end

        if runCheck then
            if IsPedClimbing(playerPed) or IsPedJumping(playerPed) or IsPedSwimming(playerPed) or IsPedRagdoll(playerPed) then
                SetPlayerControl(PlayerId(), 0, 0)
                closeGui()
                Citizen.Wait(1000)
                SetPlayerControl(PlayerId(), 1, 1)
                if cb then cb(0) end
                return 0
            end
        end

        if moveCheck then
            if #(firstPosition-GetEntityCoords(playerPed)) > moveCheck then
                closeGui()
                if cb then cb(0) end
                return 0
            end
        end

        if vehicle ~= nil and vehicle ~= 0 then
            local driverPed = GetPedInVehicleSeat(vehicle, -1)
            if driverPed ~= playerPed and vehCheck then
                closeGui()
                if cb then cb(0) end
                return 0
            end

            local model = GetEntityModel(vehicle)
            if IsThisModelACar(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
                if IsEntityInAir(vehicle) then
                    Wait(1000)
                    if IsEntityInAir(vehicle) then
                        closeGui()
                        if cb then cb(0) end
                        return 0
                    end
                end
            end
        end
    end

    if currentTask == 2 then
        if cb then cb(0) end
        return 0
    elseif currentTask == 1 then
        if cb then cb(100) end
        return 100
    end
end

--[[

    Exports

]]

exports("taskBar", taskBar)
exports("taskCancel", taskCancel)

--[[

    NUI

]]

RegisterNUICallback("progress_complete", function(data, cb)
    currentTask = 1
    guiEnabled = false

    cb("ok")
end)

RegisterNUICallback("progress_stop", function(data, cb)
    currentTask = 2
    guiEnabled = false

    cb("ok")
end)

--[[

    Events

]]

RegisterNetEvent("hud:taskBar")
AddEventHandler("hud:taskBar", function(length,name)
    taskBar(length,name)
end)

RegisterNetEvent("coffee:drink")
AddEventHandler("coffee:drink", function()
    if coffeetimer > 0 then
        coffeetimer = 6000
        TriggerEvent("Evidence:StateSet",27,6000)
        return
    else
        TriggerEvent("Evidence:StateSet",27,6000)
        coffeetimer = 6000
    end

    while coffeetimer > 0 do
        coffeetimer = coffeetimer - 1
        Wait(1000)
    end
end)