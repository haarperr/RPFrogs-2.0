local paletorobbed = false
RPC.register("heists:paletoReady",function(pSource,pLaptopId)
    if CONFIG.Paleto.canUsePanel then
        CONFIG.Paleto.canUsePanel = false
        if (os.time() - 1200) > CONFIG.Paleto.lastRob then
            return true , CONFIG.Fleeca[idxselect]
        else
            return false," Cannot robbery this time"
        end
    else
        return false, "cannot using this panel"
    end
end)

RPC.register("np-heists:paletoPanelFail",function(pSource)
    CONFIG.Paleto.canUsePanel = true
    return true
end)

RPC.register("heists:paletoStart",function(pSource)
    local chance = math.random()
    local retundata = false
    if CONFIG.Paleto.chanceGoldSpawn > chance then
        retundata = true
    end
    paletorobbed = true
    CONFIG.Paleto.lastRob = os.time()
    TriggerClientEvent("DoLongHudText",pSource ,"you have 5 minute for grab")
    TriggerClientEvent("np-heists:updateDoorStatus", -1,"paleto", CONFIG.VaultDoor["paleto"].headingOpen, 200)
    return retundata
end)

RPC.register("np-heists:paletoCanGrabTrolley",function(pSource,pLocation,pType)
    print("paletoCanGrabTrolley",pLocation,pType)
    local returndata = true
    if pType == "cash" then
        returndata = CONFIG.Paleto.canGrabCash
        CONFIG.Paleto.canGrabCash = not CONFIG.Paleto.canGrabCash
    end
    if pType == "gold" then
        returndata = CONFIG.Paleto.canGrabGold
        CONFIG.Paleto.canGrabGold = not CONFIG.Paleto.canGrabGold
    end
    return returndata
end)


Citizen.CreateThread(function()
    while true do
        if paletorobbed then
            Citizen.Wait((1000*60)*5)
            paletorobbed = false
            CONFIG.Paleto.canGrabCash = true
            CONFIG.Paleto.canGrabGold = true
            CONFIG.VaultDoor["paleto"].open = false
            TriggerClientEvent("np-heists:updateDoorStatus", -1, "paleto", CONFIG.VaultDoor["paleto"].headingClosed, 1)
        else
            Citizen.Wait(1000)
        end
    end
end)