RegisterNetEvent("np-npcs:set:ped")
AddEventHandler("np-npcs:set:ped", function(pNPCs)
    if type(pNPCs) == "table" then
        for _, ped in ipairs(pNPCs) do
            RegisterNPC(ped)
            EnableNPC(ped.id)
        end
    else
        RegisterNPC(ped)
        EnableNPC(ped.id)
    end
end)

RegisterNetEvent("np-npcs:set:position")
AddEventHandler("np-npcs:set:position", function(pId, pVectors, pHeading)
    local position = { coords = pVectors, heading = pHeading}
    UpdateNPCData(pId, 'position', position)
end)

RegisterNetEvent("np-npcs:ped:signInJob")
AddEventHandler("np-npcs:ped:signInJob", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    if #pArgs == 0 then
        local npcId = DecorGetInt(pEntity, 'NPC_ID')
        if npcId == `news_reporter` then
            TriggerServerEvent("jobssystem:jobs", "news")
        elseif npcId == `head_stripper` then
            TriggerServerEvent("jobssystem:jobs", "entertainer")
        end
    else
        TriggerServerEvent("jobssystem:jobs", "unemployed")
    end
end)

RegisterNetEvent("np-npcs:ped:paycheckCollect")
AddEventHandler("np-npcs:ped:paycheckCollect", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    TriggerServerEvent("np-jobs:paycheckPickup")
end)

RegisterNetEvent("np-npcs:ped:tijolo")
AddEventHandler("np-npcs:ped:tijolo", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
TriggerEvent("player:receiveItem", "1064738331", 1)
end)

RegisterNetEvent("np-npcs:ped:keeper")
AddEventHandler("np-npcs:ped:keeper", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    if pArgs[1] == "5" then
        local hasLicense = RPC.execute("np-licenses:hasLicense", "weapon")
        if not hasLicense then
            TriggerEvent("DoLongHudText", "You are not allowed to talk to me.", 2)
            return
        end
    end

    TriggerEvent("server-inventory-open", pArgs[1], "Shop")
end)

TriggerServerEvent("np-npcs:location:fetch")