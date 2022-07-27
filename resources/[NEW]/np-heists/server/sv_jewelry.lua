RPC.register("np-heists:jewelryCanRob",function(pSource)
    if (os.time() - CONFIG.Jewelry.cooldown) > CONFIG.Jewelry.lastrobbed then
        for k,v in pairs(CONFIG.Jewelry.jewelryBox) do
            CONFIG.Jewelry.jewelryBox[k] = true
        end
        return true
    end
    return false
end)

RPC.register("np-heists:jewelryStartRobbery",function(pSource)
    -- Door unlocked and set lasttimerobbery
    CONFIG.Jewelry.lastrobbed = os.time()
    CONFIG.Jewelry.startRob = true
    TriggerEvent("np-doors:change-lock-state", 111 , false)
    TriggerEvent("np-doors:change-lock-state", 112 , false)
    return true
end)

RPC.register("np-heists:jewelryCanSmashBox",function(pSource,pId,pState)
    local returnvalue = CONFIG.Jewelry.jewelryBox[pId]
    CONFIG.Jewelry.jewelryBox[pId] = pState
    return returnvalue
end)

-- Make sure police locked door for jewelry