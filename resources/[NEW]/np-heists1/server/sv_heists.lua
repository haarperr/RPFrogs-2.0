RegisterNetEvent("np-heists:complete")
AddEventHandler("np-heists:complete", function(pValue)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    exports["np-financials"]:updateCash(src, "+", pValue)
end)