RegisterServerEvent("np-heists:bobcat:inStockade")
AddEventHandler("np-heists:bobcat:inStockade", function(netId, atDeliveryLocation)
    -- body
end)

RegisterServerEvent("np-heists:bobcat:acceptBobcatOffer")
AddEventHandler("np-heists:bobcat:acceptBobcatOffer", function()
    local src = source
    
end)

-- RPC.register("heists:bobcatUseSecurityCard",function(pSource)

-- end)

-- RPC.register("heists:bobcatLootCache",function(pSource,pType)

-- end)

-- RPC.register("np-heists:bobcatMoneyTruckBegin",function(pSource,pNetId)

-- end)

-- RPC.register("np-heists:bobcatMoneyTruckLootPlease",function(pSource,pNetId)

-- end)

-- RPC.register("heists:activateC4Npc",function(pSource,pNetId)

-- end)

-- RPC.register("np-heists:bobcat:updateMyLocationForTruck",function(pSource,pCoord)

-- end)

-- RPC.register("heists:bobcatDoorOpen",function(pSource,pLocation)

-- end)

RPC.register("heists:bobcatGetIplStates",function(pSource)
    return CONFIG.Bobcat.iplState
end)

RPC.register("heists:bobcatUseSecurityCard",function(pSource)
    if not CONFIG.Bobcat["startRob"] then
        if (os.time() - CONFIG.Bobcat["cooldown"]) > lastrobbedbobcat then
            lastrobbedbobcat = os.time()
            CONFIG.Bobcat["startRob"] = true
            for k,v in pairs(CONFIG.Bobcat["securityDoor"]) do
                TriggerEvent("np-doors:change-lock-state", v,false)
            end
            for k,v in pairs(CONFIG.Bobcat["securityNpc"]) do
                local model = `s_m_y_swat_01`
                local pPed = CreatePed(0, model, v.x, v.y, v.z, v.h, 1, 0)
                local mnetid = NetworkGetNetworkIdFromEntity(pPed)
                TriggerClientEvent("np-heists:controlBobcatNpc", -1, mnetid)
            end
            local modelhostage = `cs_casey`
            local hostagePed = CreatePed(0, modelhostage, CONFIG.Bobcat["hostageNpc"].x, CONFIG.Bobcat["hostageNpc"].y, CONFIG.Bobcat["hostageNpc"].z, CONFIG.Bobcat["hostageNpc"].h, 1, 0)
            local hostagenetid = NetworkGetNetworkIdFromEntity(hostagePed)
            for k,v in pairs(CONFIG.Bobcat["createBox"]) do
                CreateObject(v.objHash,v.objCoord,1,1,0)
            end
            TriggerClientEvent("heists:bobcatControlC4Npc", -1, hostagenetid)
        else
            CONFIG.Bobcat["startRob"] = false
            CONFIG.Bobcat["iplState"]["np_prolog_clean"] = true
            CONFIG.Bobcat["iplState"]["np_prolog_broken"] = false
            TriggerClientEvent("heists:updatebobcatIplStates", -1, CONFIG.Bobcat["iplState"])
            for k,v in pairs(Config.vaultUpperDoor["bobcat_security_entry"]) do
                TriggerEvent("np-doors:change-lock-state", v,true)
            end
            for k,v in pairs(Config.vaultUpperDoor["bobcat_security_inner_1"]) do
                TriggerEvent("np-doors:change-lock-state", v,true)
            end
            for k,v in pairs(CONFIG.Bobcat["securityDoor"]) do
                TriggerEvent("np-doors:change-lock-state", v,true)
            end
            TriggerClientEvent("DoHudLong", pSource, "You can't rob please wait a while more")
        end
    end
end)

RPC.register("heists:bobcatLootCache",function(pSource,pType)
    print("bobcatLootCache soon for this using lootsystem",pType.param)
    local typ = pType.param
    if typ == "smgs" then
        -- Smg Loot Box
    elseif typ == "explosives" then
        -- Explosion Loot Box
    else
        -- Rifle Loot Box
    end
end)

RPC.register("heists:activateC4Npc",function(pSource,pNetId)
    print("activateC4Npc",pNetId.param)
    TriggerClientEvent("heists:bobcatControlC4NpcActivate",-1, pSource, pNetId.param)
    Citizen.Wait(16000)
    CONFIG.Bobcat["iplState"]["np_prolog_clean"] = false
    CONFIG.Bobcat["iplState"]["np_prolog_broken"] = true
    TriggerClientEvent("heists:updatebobcatIplStates", -1, CONFIG.Bobcat["iplState"])
    for k,v in pairs(CONFIG.Bobcat["createBox"]) do
        print(k,v)
        CreateObject(v.objHash,v.objCoord,1,1,0)
    end
    print("Active Box")
end)

RPC.register("heists:bobcatDoorOpen",function(pSource,pLocationName)
    for k,v in pairs(Config.vaultUpperDoor[pLocationName.param]) do
        TriggerEvent("np-doors:change-lock-state", v,false)
    end
end)

RegisterCommand("createbox", function(source,args,raw)
    for k,v in pairs(Config.bobcat["createBox"]) do
        print(k,v)
        CreateObject(v.objHash,v.objCoord,1,1,0)
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait((1000*60)*5)
        if CONFIG.bobcat["startRob"] then
            if (os.time() - CONFIG.bobcat["cooldown"]) > lastrobbedbobcat then
                CONFIG.bobcat["startRob"] = false
                CONFIG.bobcat["iplState"]["np_prolog_clean"] = true
                CONFIG.bobcat["iplState"]["np_prolog_broken"] = false
                TriggerClientEvent("heists:updatebobcatIplStates", -1, Config.bobcat["iplState"])
                for k,v in pairs(CONFIG.vaultUpperDoor[pLocationName.param]) do
                    TriggerEvent("np-doors:change-lock-state", v,true)
                end
                for k,v in pairs(CONFIG.bobcat["securityDoor"]) do
                    TriggerEvent("np-doors:change-lock-state", v,true)
                end
            end
        end
    end
end)