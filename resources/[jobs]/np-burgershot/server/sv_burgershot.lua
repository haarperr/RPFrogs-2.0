--[[

    Variables

]]

local activePurchases = {}



--[[

    Events

]]

RegisterNetEvent("np-burgershot:orderFood")
AddEventHandler("np-burgershot:orderFood", function(pData)
    local src = source

    local params = pData
    params.charger = src

    activePurchases[params.registerId] = params
    TriggerClientEvent("np-burgershot:activePurchase", -1, params, false)

    Citizen.Wait(60000)

    if activePurchases[params.registerId] ~= nil then
        activePurchases[params.registerId] = nil
        TriggerClientEvent("np-burgershot:activePurchase", -1, params, true)
    end
end)

RegisterNetEvent("np-burgershot:completePurchase")
AddEventHandler("np-burgershot:completePurchase", function(pParams)
    if not pParams then return end

    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local accountId = exports["np-base"]:getChar(src, "bankid")
    local groupBank = exports["np-groups"]:groupBank("burgershot")

    if not accountId or not groupBank then return end

    local bank = exports["np-financials"]:getBalance(accountId)
    if bank < pParams.cost then
        TriggerClientEvent("DoLongHudText", src, "Você não tem $" .. pParams.cost .. " na sua conta.", 2)
        return
    end

    local comment = pParams.comment
    local success, message = exports["np-financials"]:transaction(accountId, groupBank, pParams.cost, comment, cid, 5)
    if not success then
        TriggerClientEvent("DoLongHudText", src, message)
        return
    end

    exports["np-financials"]:addTax("Goods", pParams.tax)

    local buyer = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local seller = exports["np-base"]:getChar(pParams.charger, "first_name") .. " " .. exports["np-base"]:getChar(pParams.charger, "last_name")
    exports["np-groups"]:groupLog("burgershot", "Sell", seller .. " | $" .. pParams.cost .. " | " .. pParams.comment)

    TriggerClientEvent("DoLongHudText", pParams.charger, buyer .. " payed $" .. pParams.cost)
end)