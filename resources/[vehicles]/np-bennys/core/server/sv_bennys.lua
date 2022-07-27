--[[

    Variables

]]

local inUseBennys = {}
local repairPrices = {}

--[[

    Events

]]

AddEventHandler("playerDropped", function()
	local src = source

    for k, v in pairs(inUseBennys) do
        if v == src then
            inUseBennys[k] = nil
        end
    end
end)

RegisterNetEvent("np-bennys:addToInUse")
AddEventHandler("np-bennys:addToInUse", function(currentBennys)
    local src = source

    inUseBennys[currentBennys] = src
end)

RegisterNetEvent("np-bennys:removeFromInUse")
AddEventHandler("np-bennys:removeFromInUse", function(currentBennys)
    local src = source

    inUseBennys[currentBennys] = nil
end)

RegisterNetEvent("np-bennys:updateRepairCost")
AddEventHandler("np-bennys:updateRepairCost", function(price)
    local src = source

    repairPrices[src] = price
end)

RegisterNetEvent("np-bennys:attemptPurchase")
AddEventHandler("np-bennys:attemptPurchase", function(cheap, type, upgradeLevel)
    local src = source

    local price = 0
    if type == "repair" then
        price = repairPrices[src]
    elseif type == "performance" then
        price = vehicleCustomisationPrices.performance.prices[tonumber(upgradeLevel)]
    else
        price = vehicleCustomisationPrices[type].price
    end

    if cheap then
        price = math.ceil(price / 2)
    end

    local cash = exports["np-financials"]:getCash(src)
    if price > cash then
        TriggerClientEvent("np-bennys:purchaseFailed", src)
    else
        if exports["np-financials"]:updateCash(src, "-", price) then
            TriggerClientEvent("np-bennys:purchaseSuccessful", src)
        else
            TriggerClientEvent("np-bennys:purchaseFailed", src)
        end
    end
end)

RegisterNetEvent("np-bennys:resetDegredation")
AddEventHandler("np-bennys:resetDegredation", function(pVid, pPlate)
    local src = source

    TriggerEvent("np-vehicles:bennysResetDegradation", pVid, pPlate)
end)

--[[

    RPCs

]]

RPC.register("np-bennys:checkIfUsed", function(src, currentBennys)
    return inUseBennys[currentBennys]
end)