RPC.register("np-carwash:cleanVehicle", function(src)
    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local cash = exports["np-financials"]:getCash(src)
    if cash < 100 then
        TriggerClientEvent("DoLongHudText", src, "You dont have $100 with you", 2)
        return false
    end

    if not exports["np-financials"]:updateCash(src, "-", 100) then
        return false
    end

    exports["np-financials"]:updateBalance(11, "+", 100)
    exports["np-financials"]:transactionLog(11, 11, 100, "", cid, 7)

    return true
end)