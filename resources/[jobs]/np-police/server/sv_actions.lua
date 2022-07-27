RegisterNetEvent("police:remmaskGranted")
AddEventHandler("police:remmaskGranted", function(pTarget)
    TriggerClientEvent("police:remmaskAccepted", pTarget)
end)

RegisterNetEvent("police:targetCheckInventory")
AddEventHandler("police:targetCheckInventory", function(pTarget, pFrisk)
    local src = source

    local cid = exports["np-base"]:getChar(pTarget, "id")
    if not cid then return end

    if pFrisk then
        local inv = exports["np-inventory"]:getInventory("ply-" .. cid)

        local hasWeapons = false

        for i, v in ipairs(inv) do
            if tonumber(v.ihave_id) then
                hasWeapons = true
                break
            end
        end

        if hasWeapons then
            TriggerClientEvent("DoLongHudText", src, "found weapon")
        else
            TriggerClientEvent("DoLongHudText", src, "Weapon not found")
        end
    else
        TriggerClientEvent("DoLongHudText", pTarget, "you are being searched")
        TriggerClientEvent("server-inventory-open", src, "1", ("ply-" .. cid))
    end
end)

RegisterNetEvent("police:rob")
AddEventHandler("police:rob", function(pTarget)
    local src = source

    local cash = exports["np-financials"]:getCash(pTarget)

    if cash > 0 then
        if exports["np-financials"]:updateCash(pTarget, "-", cash) then
            exports["np-financials"]:updateCash(src, "+", cash)
        end
    end
end)

RegisterNetEvent("police:gsr")
AddEventHandler("police:gsr", function(pTarget)
	local src = source

    local shotRecently = RPC.execute(pTarget, "police:gsr")

    if shotRecently then
        TriggerClientEvent("DoLongHudText", src, "We found powder residue")
    else
        TriggerClientEvent("DoLongHudText", src, "We did not find any powder residue.")
    end
end)

RegisterNetEvent("police:checkBank")
AddEventHandler("police:checkBank", function(pTarget)
	local src = source
    local cid = exports["np-base"]:getChar(pTarget, "id")
    local accountId = exports["np-base"]:getChar(pTarget, "bankid")
    local bank = exports["np-financials"]:getBalance(accountId)
    TriggerClientEvent("DoLongHudText", src, "have $ " .. bank .. " in the account " .. accountId)
end)

RegisterNetEvent("np-jail:giveTicket", function(pTarget, pAmount, pComment)
    local src = source

    local cid = exports["np-base"]:getChar(pTarget, "id")
    if not cid then
        TriggerClientEvent("DoLongHudText", src, "cid not found?", 2)
        return
    end

    local accountId = exports["np-base"]:getChar(pTarget, "bankid")

    local success, message = exports["np-financials"]:transaction(accountId, 1, pAmount, pComment, cid, 8)
    if not success then
         TriggerClientEvent("DoLongHudText", src, message, 2)
    end

    TriggerClientEvent("DoLongHudText", src, "Fine sent successfully!")
    TriggerClientEvent("np-phone:notification", pTarget, "fas fa-university", "Bank", "You received a fine of $" .. pAmount, 5000)
end)