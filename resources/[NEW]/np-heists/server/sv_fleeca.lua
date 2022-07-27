local fleecarobbed,fleecacanusepanel, bankfleecaname, fleecalastrobbed = false,true, "", 0
local cachelaptopfleeca,laptopfleecause = {}, ""
RPC.register("heists:fleecaUsePanel",function(pSource,pCoord,pLaptopid)
    if fleecacanusepanel then
        fleecacanusepanel = false
        local idxselect
        for _,pData in pairs(CONFIG.Fleeca) do
            if #(pData.panelCoords - pCoord.param) < 2 then
                idxselect = _
            end
        end
        if (os.time() - 1200) > fleecalastrobbed then
            laptopfleecause = pLaptopid.param
            cachelaptopfleeca[pLaptopid.param] = cachelaptopfleeca[pLaptopid.param] + 1
            return true , CONFIG.Fleeca[idxselect]
        else
            return false, "Cannot robbed this time maybe next time.";
        end
    else
        return false, "Cannot using panel."
    end
    
    
end)

RPC.register("np-heists:fleecaCanGrabTrolley",function(pSource,pLocation,pType)
    local retundata = true
    if pType.param == "cash" then
        returndata = CONFIG.Fleeca[pLocation.param].canGrabCash
        CONFIG.Fleeca[pLocation.param].canGrabCash = not CONFIG.Fleeca[pLocation.param].canGrabCash
    end
    if pType.param == "gold" then
        returndata = CONFIG.Fleeca[pLocation.param].canGrabGold
        CONFIG.Fleeca[pLocation.param].canGrabGold = not CONFIG.Fleeca[pLocation.param].canGrabGold
    end
    return retundata
end)

RPC.register("heists:fleecaStart",function(pSource,pData)
    fleecarobbed = true
    bankfleecaname = pData.param.vaultname
    fleecalastrobbed = os.time();
    CONFIG.VaultDoor[pData.param.vaultname].open = not CONFIG.VaultDoor[pData.param.vaultname].open
    TriggerClientEvent("DoLongHudText",pSource ,"you have 5 minute for grab")
    TriggerClientEvent("np-heists:updateDoorStatus", -1, pData.param.vaultname, CONFIG.VaultDoor[pData.param.vaultname].headingOpen, 200)
    return false
end)

RPC.register("np-heists:fleecaPanelFail",function(pSource)
    if cachelaptopfleeca[laptopfleecause] > 3 then
        -- Delete Item
    end
    fleecacanusepanel = true
    return true
end)

Citizen.CreateThread(function()
    while true do
        if fleecarobbed then
            print("Fleeca Robbery Started")
            Citizen.Wait((1000*60)*5)
            fleecarobbed = false
            CONFIG.Fleeca[bankfleecaname].canGrabCash = true
            CONFIG.Fleeca[bankfleecaname].canGrabGold = true
            CONFIG.VaultDoor[bankfleecaname].open = false
            TriggerClientEvent("np-heists:updateDoorStatus", -1, bankfleecaname, CONFIG.VaultDoor[bankfleecaname].headingClosed, 1)
        else
            Citizen.Wait(1000)
        end
    end
end)