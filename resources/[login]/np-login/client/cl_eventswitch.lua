RegisterNetEvent("np-login:switchCharacter")
AddEventHandler("np-login:switchCharacter", function()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)

    Citizen.Wait(1000)

    TriggerServerEvent("np-login:switchCharacter")

    Citizen.Wait(500)

    TriggerEvent("np-base:sessionStarted")
end)