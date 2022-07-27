--[[

    Variables

]]

local currentVehicle = 0
local currentSeat = 0
local has2step = false

--[[

    Events

]]

AddEventHandler("np-vehicles:2step", function()
    local vehicle = currentVehicle


end)

AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    currentVehicle = pCurrentVehicle
    currentSeat = pCurrentSeat

    local vid = GetVehicleIdentifier(currentVehicle)
    if not vid then return end

    has2step = RPC.execute("np-vehicles:GetVehicleMetadata", vid, "2step")
end)

AddEventHandler("baseevents:leftVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    currentVehicle = 0
    currentSeat = 0
    has2step = false
end)

AddEventHandler("baseevents:vehicleChangedSeat", function(pCurrentVehicle, pCurrentSeat, previousSeat)
    currentSeat = pCurrentSeat
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    while true do
        if currentVehicle ~= 0 and currentSeat == -1 and has2step then
            if IsControlPressed(1, 21) then
                local RPM = GetVehicleCurrentRpm(currentVehicle)

                if RPM > 0.3 and RPM < 0.5 then
                    local vehiclePos = GetEntityCoords(currentVehicle)
                    local BackFireDelay = (math.random(100, 500))

                    TriggerEvent("np-vehicles:2step")
                    AddExplosion(vehiclePos["x"], vehiclePos["y"], vehiclePos["z"] - 0.4, 61, 0.0, true, false, 0.0, true)

                    Citizen.Wait(BackFireDelay)
                end
            end

            if IsControlJustReleased(1, 21) then
                if IsPedInAnyVehicle(PlayerPedId(), true) then
                    SetVehicleTurboPressure(currentVehicle, 25)
                end
            end
        else
            Citizen.Wait(2000)
        end

        Citizen.Wait(1)
    end
end)