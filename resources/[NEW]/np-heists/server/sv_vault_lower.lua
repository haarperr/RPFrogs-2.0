CODES = {
    ["kp_1"] = {
        attempts = 0,
        doorId = 325,
        code = 1,
    },
    ["kp_2"] = {
        attempts = 0,
        doorId = 281,
        code = 1,
    },
    ["kp_3"] = {
        attempts = 0,
        doorId = 282,
        code = 1
    },
    ["kp_4"] = {
        attempts = 0,
        doorId = 280,
        code = 1
    },
}

RPC.register("heists:vaultLowerDoorAttempt",function(pSource,pKeyPad,pLaptopId)
    if CONFIG.LowerVaultHeist.canRob then 
        return true, "Unlocked"
    else
        return false, "Locked" 
    end
    print("vaultLowerDoorAttempt",pKeyPad,pLaptopId)
end)

RPC.register("np-heists:vaultLowerPanelFail",function(pSource)
    print("vaultLowerPanelFail")
end)

RPC.register("heists:vaultLowerDoorOpen",function(pSource)
    TriggerEvent("np-doors:change-lock-state", 278, false)
    TriggerEvent("np-doors:change-lock-state", 279, false)
end)

RPC.register("np-heists:getVaultLowerState",function(pSource)
    return CONFIG.LowerVaultHeist
end)

RPC.register("np-heists:lowerVaultEntranceEnter",function(pSource)
    print('hi2')
    TriggerClientEvent("np-heists:checkexplosion", pSource)
end)

RPC.register("np-heists:vaultLowerCanGrabTrolley",function(pSource,pLocation,pType)
    print("vaultLowerCanGrabTrolley",pSource,pLocation,pType)
    local retunvalue = false
    if pType == "cash" then
        retunvalue = CONFIG.LowerVaultHeist.trolley[pLocation].canGrabCash
        CONFIG.LowerVaultHeist.trolley[pLocation].canGrabCash = false
        return returnvalue
    elseif pType == "gold" then
        retunvalue = CONFIG.LowerVaultHeist.trolley[pLocation].canGrabGold
        CONFIG.LowerVaultHeist.trolley[pLocation].canGrabGold = false
        return returnvalue
    end
    return false
end)

RPC.register("np-heists:lowerVaultPanelPublicPush",function(pSource,pPanelId,pState)

end)

RPC.register("heists:lowerVaultPanelPush",function(pSource,pKeyPad,pCode)
    print(pKeyPad)
    print(pCode)
    print(CODES[pKeyPad].code)
    if CODES[pKeyPad].code == tonumber(pCode) then
        TriggerEvent("np-doors:change-lock-state", CODES[pKeyPad].doorId, false)
    else
        TriggerClientEvent("DoLongHudText", pSource, "Authorization Failure ("  .. CODES[pKeyPad].attempts + 1 .. "/4)", 2)
        print('shit code')
        return
    end
    print("lowerVaultPanelPush",pKeyPad,pCode)
    return false
end)

RPC.register("np-heist:explodeVault", function(pSource)
    print('test')
    CONFIG.LowerVaultHeist.doorState["np_vault_broken"] = true
    CONFIG.LowerVaultHeist.doorState["np_vault_clean"] = false
    print('hello?')
    TriggerClientEvent("np-heists:swapLowerVaultIPL", pSource, CONFIG.LowerVaultHeist.doorState, CONFIG.LowerVaultHeist.upperVaultEntityState)
end)

RPC.register("np-heists:registerLVUsbUse",function(pSource)
    print('generating codes')
    local stuff = {"kp_1", "kp_2", "kp_3", "kp_4"}
    for k,v in pairs(stuff) do
        CODES[v].code = math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9) .. math.random(0, 9)
    end
    print(json.encode(CODES))
    return CODES
end)