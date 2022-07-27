RegisterNetEvent("np-ems:purchaseVehicle")
AddEventHandler("np-ems:purchaseVehicle", function(params)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local accountId = exports["np-base"]:getChar(src, "bankid")
    local bank = exports["np-financials"]:getBalance(accountId)

    if params.price > bank then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", "You dont $" .. params.price .. " in your bank account", 5000)
        return
    end

    local comment = "Brought " .. params.name
    local success, message = exports["np-financials"]:transaction(accountId, 1, params.price, comment, cid, 5)
    if not success then
        TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", message, 5000)
        return
    end

    local vid = exports["np-vehicles"]:insertVehicle(src, params.model, params.job, params.price, false, true)
    if not vid then
        TriggerClientEvent("DoLongHudText", src, "Error??", 2)
        return
    end

    exports["np-vehicles"]:updateVehicle(vid, "garage", "garage", params.garage)

    local vehicle = exports["np-vehicles"]:getVehicle(vid)

    TriggerClientEvent("np-vehicles:spawnVehicle", src, params.model, params.spawn, vehicle.id, vehicle.plate, 100, false, false, false, false, false, true)
end)