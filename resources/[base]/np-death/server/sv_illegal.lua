RPC.register("np-death:illegal", function(src, pPrice)
    local cash = exports["np-financials"]:getCash(src)
    if cash < pPrice then
        TriggerClientEvent("DoLongHudText", src, "Você não tem $" .. pPrice .. " com você", 2)
        return false
    end

    if not exports["np-financials"]:updateCash(src, "-", pPrice) then
        TriggerClientEvent("DoLongHudText", src, "Error in updateCash function")
        return false
    end

    return true
end)