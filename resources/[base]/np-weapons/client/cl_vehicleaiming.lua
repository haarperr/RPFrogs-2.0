--[[

    Variables

]]

local isInVehicle = false
local currentSeat = 0

--[[

    Functions

]]

function VehicleAiming(pIsInVehicle, pCurrentVehicle, pCurrentSeat, pVehicleType)
    isInVehicle = pIsInVehicle
    if not isInVehicle then return end

    Citizen.CreateThread(function()
        while isInVehicle do
            if pVehicleType == 8 or pVehicleType == 13 then
                DisableControlAction(0, 345, true)
            end

            if IsPedArmed(PlayerPedId(), 6) then
                if pCurrentSeat == -1 and pVehicleType ~= 8 and pVehicleType ~= 13 then
                    DisableControlAction(0, 25, true)
                    DisableControlAction(0, 68, true)
                    DisableControlAction(0, 91, true)
                end

                if IsPedDoingDriveby(PlayerPedId())  then
                    if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
                        local curWeapon = GetSelectedPedWeapon(PlayerPedId())

                        SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
                        SetCurrentPedVehicleWeapon(PlayerPedId(), `WEAPON_UNARMED`)
                        SetPlayerCanDoDriveBy(PlayerId(), false)
                        SetFollowPedCamViewMode(4)
                        SetFollowVehicleCamViewMode(4)

                        Wait(250)

                        SetCurrentPedWeapon(PlayerPedId(), curWeapon, true)
                        SetCurrentPedVehicleWeapon(PlayerPedId(), curWeapon)
                        SetPlayerCanDoDriveBy(PlayerId(), true)
                    end
                else
                    DisableControlAction(0, 36, true)

                    if GetPedStealthMovement(PlayerPedId()) == 1 then
                        SetPedStealthMovement(PlayerPedId(), 0)
                    end
                end
            end

            Wait(1)
        end
    end)
end


--[[

    Events

]]

AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle, pCurrentSeat, _, _, pModel)
    currentSeat = pCurrentSeat

    VehicleAiming(true, pCurrentVehicle, pCurrentSeat, GetVehicleClass(pCurrentVehicle))
end)

AddEventHandler("baseevents:leftVehicle", function(pCurrentVehicle, pCurrentSeat)
    VehicleAiming(false)

    currentSeat = 0
end)

AddEventHandler("baseevents:vehicleChangedSeat", function(pCurrentVehicle, pCurrentSeat, previousSeat)
    currentSeat = pCurrentSeat
end)