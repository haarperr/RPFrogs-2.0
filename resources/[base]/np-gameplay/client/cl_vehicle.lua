Citizen.CreateThread(function()
    -- Disable vehicle rewards
    DisablePlayerVehicleRewards(PlayerId())

    while true do
        Citizen.Wait(1)

        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local timer = 0

        if IsPedInAnyVehicle(ped, false) then
            if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), 0) == ped then
                if GetIsTaskActive(ped, 165) then
                    SetPedIntoVehicle(ped, GetVehiclePedIsIn(ped, false), 0)
                end
            end

            local model = GetEntityModel(vehicle)
            local roll = GetEntityRoll(vehicle)

            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and IsEntityInAir(vehicle) or (roll < -50 or roll > 50) then
                DisableControlAction(0, 59) -- leaning left/right
                DisableControlAction(0, 60) -- leaning up/down
            end

            timer = 0
        else
            if IsPedWearingHelmet(ped) then
                timer = timer + 1

                if timer >= 5000 and not IsPedInAnyVehicle(ped, true) then
                    RemovePedHelmet(ped, false)
                    timer = 0
                end
            end
        end
    end
end)