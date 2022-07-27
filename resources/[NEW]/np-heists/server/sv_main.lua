RPC.register("np-heists:payoutTrolleyGrab",function(pSource,pLocation,pType)
    print("payoutTrolleyGrab",pLocation,pType)
    if pLocation == "fleeca" then
        if pType == "cash" then
            print("Fleeca Reward Cash")
        elseif pType == "gold" then
            print("Fleeca Reward Gold")
        end
    elseif pLocation == "paleto" then
        if pType == "cash" then
            print("Paleto Reward Cash")
        elseif pType == "gold" then
            print("Paleto Reward Gold")
        end
    elseif pLocation == "vault_upper_cash_1" then
        local inked = math.random(1, 5)
        local cash = math.random(5, 20)
        local gold = math.random(1, 15)
        if pType == "cash" then
            TriggerClientEvent("player:receiveItem", pSource, "inkedmoneybag", inked)
            TriggerClientEvent("player:receiveItem", pSource, "markedbills", cash)
        elseif pType == "gold" then
            TriggerClientEvent("player:receiveItem", pSource, "goldbar", gold)
        end
    elseif pLocation == "vault_upper_cash_2" then
        local inked = math.random(1, 5)
        local cash = math.random(5, 20)
        local gold = math.random(1, 15)
        if pType == "cash" then
            TriggerClientEvent("player:receiveItem", pSource, "inkedmoneybag", inked)
            TriggerClientEvent("player:receiveItem", pSource, "markedbills", cash)
        elseif pType == "gold" then
            TriggerClientEvent("player:receiveItem", pSource, "goldbar", gold)
        end
    elseif pLocation == "vault_upper_cash_3" then
        local inked = math.random(1, 8)
        local cash = math.random(5, 20)
        local gold = math.random(1, 15)
        if pType == "cash" then
            TriggerClientEvent("player:receiveItem", pSource, "inkedmoneybag", inked)
            TriggerClientEvent("player:receiveItem", pSource, "markedbills", cash)
        elseif pType == "gold" then
            TriggerClientEvent("player:receiveItem", pSource, "goldbar", gold)
        end
    elseif pLocation == "vault_lower_cash_1" then
        local inked = math.random(1, 8)
        local cash = math.random(5, 20)
        if type == "cash" then
            TriggerClientEvent("player:receiveItem", pSource, "inkedmoneybag", inked)
            TriggerClientEvent("player:receiveItem", pSource, "markedbills", cash)
        end
    elseif pLocation == "vault_lower_cash_2" then
        local inked = math.random(1, 8)
        local cash = math.random(5, 20)
        if type == "cash" then
            TriggerClientEvent("player:receiveItem", pSource, "inkedmoneybag", inked)
            TriggerClientEvent("player:receiveItem", pSource, "markedbills", cash)
        end
    elseif pLocation == "vault_lower_cash_3" then
        local inked = math.random(1, 8)
        local cash = math.random(5, 20)
        if type == "cash" then
            TriggerClientEvent("player:receiveItem", pSource, "inkedmoneybag", inked)
            TriggerClientEvent("player:receiveItem", pSource, "markedbills", cash)
        end
    elseif pLocation == "vault_lower_cash_4" then
        local inked = math.random(1, 8)
        local cash = math.random(5, 20)
        if type == "cash" then
            TriggerClientEvent("player:receiveItem", pSource, "inkedmoneybag", inked)
            TriggerClientEvent("player:receiveItem", pSource, "markedbills", cash)
        end
    end
    return true
end)

RegisterServerEvent("np-heists:hack:success")
AddEventHandler("np-heists:hack:success", function(pExp)
    local src = source
    --Upgrade progression character about hack
end)



function GetNearbyPlayers(pCoords,pRadius)
    local pData = exports["np-infinity"]:GetPlayersCoord()
    local returndata = {}
    for pPlayer,COORD in pairs(pData) do
        if #(vector3(pCoords.x,pCoords.y,pCoords.z) - vector3(COORD.x,COORD.y,COORD.z)) < pRadius then
            table.insert( returndata, pPlayer )
        end
    end
    return returndata
end

--- this for thermite event swxy
RegisterServerEvent("fx:ThermiteChargeEnt")
AddEventHandler("fx:ThermiteChargeEnt", function(pNetId)
    local pEntity = NetworkGetEntityFromNetworkId(pNetId)
    local pCoords = GetEntityCoords(pEntity)
    local players = GetNearbyPlayers(pCoords, 45)
    local ptDict, ptName = "scr_ornate_heist","scr_heist_ornate_thermal_burn"
    local position = {
        coords = { { x = pCoords.x, y = pCoords.y, z = pCoords.z } },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
        scale = 1.0,
        alpha = 1.0,
    }
    TriggerParticleAtCoord(ptDict, ptName, true, position, 7000, players)
end)