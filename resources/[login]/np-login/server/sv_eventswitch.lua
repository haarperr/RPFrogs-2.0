RegisterNetEvent("np-login:switchCharacter")
AddEventHandler("np-login:switchCharacter", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")

    TriggerClientEvent("np-base:resetVars", src)
    TriggerClientEvent("np-death:reset", src)
    TriggerClientEvent("np-police:resetCuffs", src)
    TriggerClientEvent("np-police:resetEscort", src)
    TriggerClientEvent("np-housing:reset", src)
    TriggerClientEvent("np-evidence:reset", src)
    TriggerClientEvent("np-jail:reset", src)

    TriggerEvent("np-apartments:deSpawn", src)

    TriggerClientEvent("insideShell", src, false)

    exports["np-base"]:setUser(src, "char", nil)
    TriggerClientEvent("np-base:setVar", src, "char", nil)
end)