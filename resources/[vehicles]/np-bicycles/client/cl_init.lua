Citizen.CreateThread(function()

    Citizen.Wait(1000)

    exports["np-npcs"]:RegisterNPC(Config["NPC"])

    local group = { "isBicycleShop" }

    local data = {
        {
            id = "bicycle_shop",
            label = "View Bikes",
            icon = "bicycle",
            event = "np-bicycles:showBicycles",
            parameters = {},
        }
    }

    local options = {
        distance = { radius = 2.5 }
    }

    exports["np-eye"]:AddPeekEntryByFlag(group, data, options)

    local images = {}
    for _, vehicle in ipairs(Config["Vehicles"]) do
        table.insert(images, vehicle.image)
    end

    TriggerEvent("np-context:preLoadImages", images)
end)