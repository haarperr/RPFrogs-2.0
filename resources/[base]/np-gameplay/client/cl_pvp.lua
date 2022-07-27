Citizen.CreateThread(function()
    -- enable pvp
    for i = 0, 255 do
        if NetworkIsPlayerConnected(i) then
            if NetworkIsPlayerConnected(i) and GetPlayerPed(i) ~= nil then
                SetCanAttackFriendly(GetPlayerPed(i), true, true)
            end
        end
    end

    NetworkSetFriendlyFireOption(true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if IsPedUsingActionMode(PlayerPedId()) then
                SetPedUsingActionMode(PlayerPedId(), -1, -1, 1)
            end
        else
            Citizen.Wait(3000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsPedInCover(PlayerPedId(), 0) and not IsPedAimingFromCover(PlayerPedId()) then
            DisablePlayerFiring(PlayerPedId(), true)
        end

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        SetPedMinGroundTimeForStungun(PlayerPedId(), 5000)
        SetEntityProofs(PlayerPedId(), false, false, false, false, false, true, false, false)
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
        SetRadarBigmapEnabled(false, false)

        Wait(2000)
    end
end)