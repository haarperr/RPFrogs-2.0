RPC.register("np-vehicles:refuel", function(src, price, tax)
    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local cash = exports["np-financials"]:getCash(src)
    if cash < price then
        TriggerClientEvent("DoLongHudText", src, "You dont have $" .. price .. " with you", 2)
        return false
    end

    if not exports["np-financials"]:updateCash(src, "-", price) then
        return false
    end

    exports["np-financials"]:updateBalance(12, "+", price)
    exports["np-financials"]:transactionLog(12, 12, price, "", cid, 7)
    exports["np-financials"]:addTax("Services", tax)

    return true
end)