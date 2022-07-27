RegisterNetEvent("hadcocaine")
AddEventHandler("hadcocaine", function(quality)
    drugEffectTime = 20

    TriggerEvent("fx:run", "cocaine", 8, 0.0, false, false)

    while drugEffectTime > 0 do
        Citizen.Wait(1000)

        drugEffectTime = drugEffectTime - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end
    end

    drugEffectTime = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), 1000, 1000, 3, 0, 0, 0)
    end
end)

RegisterNetEvent('hadcrack')
AddEventHandler('hadcrack', function()
    drugEffectTime = 30

    TriggerEvent("fx:run", "crack", 8, 0.0, false, false)

    while drugEffectTime > 0 do
        Citizen.Wait(1000)

        drugEffectTime = drugEffectTime - 1

        if IsPedRagdoll(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(5), math.random(5), 3, 0, 0, 0)
        end

        if math.random(500) < 100 then
            TriggerEvent("fx:run", "crack", 8, 0.0, false, false)
            Citizen.Wait(math.random(30000))
        end

        if math.random(100) > 91 and IsPedRunning(PlayerPedId()) then
            SetPedToRagdoll(PlayerPedId(), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end
    end

    drugEffectTime = 0

    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), 6000, 6000, 3, 0, 0, 0)
    end
end)

AddEventHandler("np-weapons:threwSmokeGrenade", function()
    Citizen.CreateThread(function()
        local finalizingPosition = true
        local prevCoords = 0

        while finalizingPosition do
            local outCoords = vector3(0, 0, 0)
            local outProjectile = 0
            local _, coords = GetProjectileNearPed(PlayerPedId(), -37975472, 1000.0, outCoords, outProjectile, 1)

            if prevCoords ~= 0 and #(coords - prevCoords) < 1 then
                finalizingPosition = false
            end

            prevCoords = coords

            Wait(1000)
        end

        TriggerServerEvent("np-fx:smoke:grenade", prevCoords)
    end)
end)