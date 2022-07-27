--[[

    Events

]]

AddEventHandler("np-bicycles:showBicycles", function()
    local data = {}

    for _, bike in ipairs(Config["Vehicles"]) do
        local tax = RPC.execute("np-financials:priceWithTax", bike.price, "Vehicles")

        bike["tax"] = tax.tax
        bike["price"] = tax.total

        table.insert(data, {
            title = bike.name,
            description = "$" .. tax.total .. " Incl. " .. tax.porcentage .. "% tax",
            image = bike.image,
            children = {
                { title = "Confirm Purchase", action = "np-bicycles:buyBicycle", params = bike },
            },
        })
    end

    exports["np-context"]:showContext(data)
end)

AddEventHandler("np-bicycles:buyBicycle", function(params)
    if IsAnyVehicleNearPoint(Config["Spawn"]["x"], Config["Spawn"]["y"], Config["Spawn"]["z"], 3.0) then
        TriggerEvent("DoLongHudText", "vehicle on the way", 2)
        return
    end

    TriggerServerEvent("np-bicycles:buyBicycle", params)
end)