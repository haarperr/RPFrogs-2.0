local door = "closed"

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    Citizen.Wait(5000)

    TriggerClientEvent("np-carshop:pdmBackDoor", src, door)
end)

RegisterNetEvent("np-carshop:pdmBackDoor")
AddEventHandler("np-carshop:pdmBackDoor", function()
    local update = "opened"
    if door == "opened" then
        update = "closed"
    end

    door = update

    TriggerClientEvent("np-carshop:pdmBackDoor", -1, door)
end)