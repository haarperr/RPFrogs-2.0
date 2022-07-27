--[[

    Variables

]]

local activePurchases = {}

--[[

    Functions

]]

function isChargeActive(pEntity, pContext)
    return exports["np-base"]:getChar("job") == "yb14"
end

function isInGroup(pEntity, pContext)
    return exports["np-groups"]:GroupRank("yb14") > 0
end

--[[

    Events

]]

AddEventHandler("np-youngboys:stationPrompt", function(pParameters, pEntity, pContext)
    if pParameters.stationId == 1 then
        TriggerEvent("np-signin:peekAction", nil, nil, { zones = { job_sign_in = { job = "yb14_sign_in" } } })
    elseif pParameters.stationId == 2 then
        TriggerEvent("server-inventory-open", "1", "youngboys_stash")
    elseif pParameters.stationId == 3 then
        local input = exports["np-input"]:showInput({
            {
                icon = "dollar-sign",
                label = "Cost",
                name = "cost",
            },
            {
                icon = "pencil-alt",
                label = "Comment",
                name = "comment",
            },
        })

        if input["cost"] and input["comment"] then
            local cost = tonumber(input["cost"])
            local comment = input["comment"]

            if cost == nil or not cost or comment == nil or comment == "" then return end

            TriggerServerEvent("np-youngboys:orderFood", {cost = cost, comment = comment, registerId = pParameters.registerId})
        end
    elseif pParameters.stationId == 4 then
        local activeRegisterId = pParameters.registerId
        local activeRegister = activePurchases[activeRegisterId]

        if not activeRegister or activeRegister == nil then
            TriggerEvent("DoLongHudText", "Nenhuma compra ativa.")
            return
        end

        local priceWithTax = RPC.execute("np-financials:priceWithTax", activeRegister.cost, "Goods")
        local acceptContext = {{
            title = "accept buy",
            description = "$" .. priceWithTax.total .. " Incl. " .. priceWithTax.porcentage .. "% Taxes | " .. activeRegister.comment,
            action = "np-youngboys:finishPurchasePrompt",
            params = {cost = activeRegister.cost, comment = activeRegister.comment, registerId = pParameters.registerId, charger = activeRegister.charger, tax = priceWithTax.tax}
        }}
        exports['np-context']:showContext(acceptContext)
    elseif pParameters.stationId == 5 then
        TriggerEvent("server-inventory-open", "1", "trays-Young Boys Drip-" .. pParameters.registerId)
    end
end)

AddEventHandler("np-youngboys:orderFood", function(data)
    local startPos = GetEntityCoords(PlayerPedId())

    local tempContext, tempAction, tempAnimDict, tempAnim, animLoop = {}, "", "", "", false
    if data.context == "foods" then
        tempContext = foodsContext
        tempAction = "Preparing" .. " "
        tempAnimDict = "anim@amb@business@coc@coc_unpack_cut@"
        tempAnim = "fullcut_cycle_v6_cokecutter"
        animLoop = true
    elseif data.context == "drinks" then
        tempContext = drinksContext
        tempAction = "Dispensing" .. " "
        tempAnimDict = "mp_ped_interaction"
        tempAnim = "handshake_guy_a"
        animLoop = false
    end

    --Ingredient check
    for _,itemid in pairs(data.recipe) do
        local hasItem = exports['np-inventory']:hasEnoughOfItem(itemid, 1, false, true)
        if not hasItem then
            TriggerEvent("DoLongHudText", "You're missing" .. " " .. tostring(itemid))
            return
        end
    end

    if IsPedArmed(PlayerPedId(), 7) then
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
    end

    RequestAnimDict(tempAnimDict)

    while not HasAnimDictLoaded(tempAnimDict) do
        Citizen.Wait(0)
    end

    if IsEntityPlayingAnim(PlayerPedId(), tempAnimDict, tempAnim, 3) then
        ClearPedSecondaryTask(PlayerPedId())
    else
        local animLength = animLoop and -1 or GetAnimDuration(tempAnimDict, tempAnim)
        TaskPlayAnim(PlayerPedId(), tempAnimDict, tempAnim, 1.0, 4.0, animLength, 18, 0, 0, 0, 0)
    end

    local finished = exports["np-taskbar"]:taskBar(data.craftTime * 1000, tempAction .. data.displayName)
    if finished == 100 then
        local pos = GetEntityCoords(PlayerPedId(), false)
        if(#(startPos - pos) < 2.0) then
            for _,itemid in pairs(data.recipe) do
                TriggerEvent("inventory:removeItem", itemid, 1)
            end
            TriggerEvent("player:receiveItem", data.itemid, 1, false, {})
            exports['np-context']:showContext(tempContext)
        end
    end

    StopAnimTask(PlayerPedId(), tempAnimDict, tempAnim, 3.0)
end)

RegisterNetEvent("np-youngboys:activePurchase")
AddEventHandler("np-youngboys:activePurchase", function(data, toggle)
    if toggle then
        activePurchases[data.registerId] = nil
    else
        activePurchases[data.registerId] = data
    end
end)

AddEventHandler("np-youngboys:finishPurchasePrompt", function(pParams)
    TriggerServerEvent("np-youngboys:completePurchase", pParams)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-polytarget"]:AddBoxZone("np-youngboys", vector3(71.76, -1392.47, 29.38), 0.45, 1.6, {
        heading=0,
        minZ=28.38,
        maxZ=30.58,
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-youngboys", {{
        event = "np-youngboys:stationPrompt",
        id = "youngboys_sign",
        icon = "pager",
        label = "Enter/Exit Service",
        parameters = { stationId = 1 }
    }}, { distance = { radius = 3.5 }, isEnabled = isInGroup })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-youngboys", {{
        event = "np-youngboys:stationPrompt",
        id = "youngboys_storage",
        icon = "box-open",
        label = "inventory",
        parameters = { stationId = 2 }
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })

    exports["np-polytarget"]:AddBoxZone("np-youngboys:register1", vector3(74.56, -1392.08, 29.38), 0.45, 0.55, {
        heading=0,
        minZ=29.33,
        maxZ=29.73
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-youngboys:register1", {{
        event = "np-youngboys:stationPrompt",
        id = "youngboys_register1_worker",
        icon = "credit-card",
        label = "Charge",
        parameters = { stationId = 3, registerId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = isChargeActive })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-youngboys:register1", {{
        event = "np-youngboys:stationPrompt",
        id = "youngboys_register1_customer",
        icon = "credit-card",
        label = "Pay",
        parameters = { stationId = 4, registerId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-polytarget"]:AddBoxZone("np-youngboys-trays1", vector3(74.65, -1393.36, 29.38), 1.6, 0.8, {
        heading=0,
        minZ=29.33,
        maxZ=29.66
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-youngboys-trays1", {{
        event = "np-youngboys:stationPrompt",
        id = "youngboys_trays1",
        icon = "hand-holding",
        label = "Open",
        parameters = { stationId = 5, registerId = 1 }
    }}, { distance = { radius = 6.0 } })
end)