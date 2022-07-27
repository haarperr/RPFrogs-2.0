--[[

    Events

]]

AddEventHandler("np-ems:showVehicles", function(pArgs, pEntity, pContext)
    local data = {}
    local ownedVehicles = RPC.execute("np-vehicles:ownedVehiclesModels")

    for _, vehicle in ipairs(pArgs["Vehicles"]) do
        if vehicle.first_free and not has_value(ownedVehicles, vehicle.model) then
            vehicle.price = 1
        end

        vehicle.job = pArgs["Job"]
        vehicle.spawn = pArgs["Spawn"]
        vehicle.garage = pArgs["Garage"]

        table.insert(data, {
            title = vehicle.name,
            description = "$" .. vehicle.price,
            image = vehicle.image,
            children = {
                { title = "Confirm Purchase", action = "np-police:purchaseVehicle", params = vehicle },
            },
        })
    end

    exports["np-context"]:showContext(data)
end)

AddEventHandler("np-ems:purchaseVehicle", function(params)
    if IsAnyVehicleNearPoint(params.spawn.x, params.spawn.y, params.spawn.z, 3.0) then
        TriggerEvent("DoLongHudText", "There is a vehicle interfering with the spawn location!", 2)
        return
    end

    TriggerServerEvent("np-ems:purchaseVehicle", params)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    for i, v in ipairs(VehiclesConfig) do
        exports["np-npcs"]:RegisterNPC(v["NPC"])

        local group = { "isEmsVehicleSeller" }

        local data = {
            {
                id = "ems_vehicles_" .. i,
                label = v["Label"],
                icon = "ambulance",
                event = "np-ems:showVehicles",
                parameters = v,
            }
        }

        local options = {
            distance = { radius = 2.5 },
            isEnabled = function()
                return exports["np-base"]:getChar("job") == v["Job"] and #(GetEntityCoords(PlayerPedId()) - v["Spawn"]["xyz"]) < 300.0
            end
        }

        exports["np-eye"]:AddPeekEntryByFlag(group, data, options)

        local images = {}
        for _, vehicle in ipairs(v["Vehicles"]) do
            table.insert(images, vehicle.image)
        end

        TriggerEvent("np-context:preLoadImages", images)
    end
end)