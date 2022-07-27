--[[

    Variables

]]

local foodsContext = {}
local drinksContext = {}
local activePurchases = {}

local foodConfig = {
    foods = {
        {itemid = "heartstopper", displayName = "Heart Stopper", description = "1 Cheese, 1 Lettuce, 1 Meat", craftTime = 10, recipe = {"cheese", "lettuce", "freshmeat"}},
        {itemid = "moneyshot", displayName = "Moneyshot", description = "1 Cheese, 1 Lettuce, 1 Meat", craftTime = 10, recipe = {"cheese", "lettuce", "freshmeat"}},
        {itemid = "bleederburger", displayName = "The Bleeder", description = "1 Cheese, 1 Lettuce, 1 Meat", craftTime = 10, recipe = {"cheese", "lettuce", "freshmeat"}},
        {itemid = "torpedo", displayName = "The Torpedo", description = "1 Cheese, 1 Lettuce, 1 Meat", craftTime = 10, recipe = {"cheese", "lettuce", "freshmeat"}},
        {itemid = "meatfree", displayName = "Meat Free", description = "1 Cheese, 1 Lettuce, 1 Rubber", craftTime = 10, recipe = {"cheese", "lettuce", "rubber"}},
    },
    drinks = {
        {itemid = "softdrink", displayName =  "Soft Drink", description = "1 High-Fructose Syrup", craftTime = 5, recipe = {"hfcs"}},
        {itemid = "fruitslushy", displayName =  "Fruit Slushy", description =  "1 Apple, 1 Banana, 1 Cherry, 1 Orange, 1 Peach, 1 Strawberry", craftTime = 15, recipe = {"apple", "banana", "cherry", "orange", "peach", "strawberry",}},
    },
}


--[[

    Functions

]]

function isChargeActive(pEntity, pContext)
    return exports["np-base"]:getChar("job") == "burgershot"
end

--[[

    Events

]]

AddEventHandler("np-burgershot:stationPrompt", function(pParameters, pEntity, pContext)
    if pParameters.stationId == 0 then
        TriggerEvent("server-inventory-open", "1", "Burgershot")
    elseif pParameters.stationId == 1 then
        exports["np-context"]:showContext(foodsContext)
    elseif pParameters.stationId == 2 then
        exports["np-context"]:showContext(drinksContext)
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

            TriggerServerEvent("np-burgershot:orderFood", {cost = cost, comment = comment, registerId = pParameters.registerId})
        end
    elseif pParameters.stationId == 4 then
        local activeRegisterId = pParameters.registerId
        local activeRegister = activePurchases[activeRegisterId]

        if not activeRegister or activeRegister == nil then
            TriggerEvent("DoLongHudText", "No purchase active.")
            return
        end

        local priceWithTax = RPC.execute("np-financials:priceWithTax", activeRegister.cost, "Goods")
        local acceptContext = {{
            title = "Accept Purchase",
            description = "$" .. priceWithTax.total .. " Incl. " .. priceWithTax.porcentage .. "% tax | " .. activeRegister.comment,
            action = "np-burgershot:finishPurchasePrompt",
            params = {cost = activeRegister.cost, comment = activeRegister.comment, registerId = pParameters.registerId, charger = activeRegister.charger, tax = priceWithTax.tax}
        }}
        exports['np-context']:showContext(acceptContext)
    elseif pParameters.stationId == 5 then
        TriggerEvent("server-inventory-open", "1", "trays-Burger Shot-" .. pParameters.registerId)
   
    elseif pParameters.stationId == 6 then
        TriggerEvent("server-inventory-open", "1", "Burgershot")
    end
end)

AddEventHandler("np-burgershot:orderFood", function(data)
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
            TriggerEvent("DoLongHudText", "You are missing " .. " " .. tostring(itemid))
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

RegisterNetEvent("np-burgershot:activePurchase")
AddEventHandler("np-burgershot:activePurchase", function(data, rusticopaunocu)
    if rusticopaunocu then
        activePurchases[data.registerId] = nil
    else
        activePurchases[data.registerId] = data
    end
end)

AddEventHandler("np-burgershot:finishPurchasePrompt", function(pParams)
    TriggerServerEvent("np-burgershot:completePurchase", pParams)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-polytarget"]:AddCircleZone("np-burgershot:fridge", vector3(-1203.42, -895.7, 13.98), 0.65, {
        useZ = true
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:fridge", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_fridge",
        icon = "box-open",
        label = "Open Fridge",
        parameters = { stationId = 0 }
    }}, { distance = { radius = 1.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-polytarget"]:AddBoxZone("np-burgershot:foods1", vector3(-1202.89, -897.28, 14.0), 0.8, 1.8, {
        heading=90,
        minZ=13.57,
        maxZ=14.77
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("burgershot_warmer", {{
        event = "np-burgershot:stationPrompt",
        id = "bs_warmer",
        icon = "hamburger",
        label = "Food Warmer",
        parameters = { stationId = 6 }
    }}, { distance = { radius = 1.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-polytarget"]:AddBoxZone("burgershot_warmer",  vector3(-1197.84, -893.96, 13.98), 3.0, 1, {
        minZ=13.58,
        maxZ=14.78
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:foods1", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_foods1",
        icon = "hamburger",
        label = "Use Grill",
        parameters = { stationId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-polytarget"]:AddBoxZone("np-burgershot:foods2", vector3(-1201.79, -898.58, 13.98), 0.8, 1.8, {
        heading=90,
        minZ=13.07,
        maxZ=14.77
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:foods1", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_foods1",
        icon = "hamburger",
        label = "Use Grill",
        parameters = { stationId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-polytarget"]:AddBoxZone("np-burgershot:grabbox", vector3(-1197.77, -891.43, 14.57), 0.8, 1.8, {
        heading=90,
        minZ=13.07,
        maxZ=14.97
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:foods2", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_grabbox",
        icon = "fries",
        label = "Use Fryer",
        parameters = { stationId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-polytarget"]:AddBoxZone("np-burgershot:drinks1", vector3(-1199.87, -895.3, 13.98), 0.45, 0.7, {
    --  debugPoly=true,
        heading=90,
        minZ=12.27,
        maxZ=14.77
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:drinks1", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_drinks1",
        icon = "mug-hot",
        label = "Make Drink",
        parameters = { stationId = 2 }
    }}, { distance = { radius = 3.7 } , isEnabled = function() return not isChargeActive() end })

     -- BS REGISTERS

    exports["np-polytarget"]:AddBoxZone("np-burgershot:register1", vector3(-1194.38, -893.91, 13.98), 1.2, 0.6, {
        heading=305,
        minZ=10.58,
        maxZ=14.58
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:register1", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_register1_worker",
        icon = "credit-card",
        label = "Charge Customer",
        parameters = { stationId = 3, registerId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:register1", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_register1_customer",
        icon = "credit-card",
        label = "Make Payment",
        parameters = { stationId = 4, registerId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })

    -- 

    
    exports["np-polytarget"]:AddBoxZone("np-burgershot:register2", vector3(-1195.25, -892.3, 13.98), 1.2, 0.6, {
        heading=305,
        minZ=10.58,
        maxZ=14.58
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:register2", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_register2_worker",
        icon = "credit-card",
        label = "Charge Customer",
        parameters = { stationId = 3, registerId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:register2", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_register2_customer",
        icon = "credit-card",
        label = "Make Payment",
        parameters = { stationId = 4, registerId = 1 }
    }}, { distance = { radius = 3.5 } , isEnabled = function() return not isChargeActive() end })


    --



    exports["np-polytarget"]:AddBoxZone("np-burgershot:trays1", vector3(-1193.83, -894.44, 13.98), 1, 0.8, {
        heading=305,
        minZ=10.78,
        maxZ=14.78
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:trays1", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_trays1",
        icon = "hand-holding",
        label = "Food Tray",
        parameters = { stationId = 5, registerId = 1 }
    }}, { distance = { radius = 3.5 } })

   
   
    exports["np-polytarget"]:AddBoxZone("np-burgershot:trays2", vector3(-1194.92, -892.86, 13.98), 1, 0.8, {
        heading=305,
        minZ=10.78,
        maxZ=14.78
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-burgershot:trays2", {{
        event = "np-burgershot:stationPrompt",
        id = "burgershot_trays2",
        icon = "hand-holding",
        label = "Food Tray",
        parameters = { stationId = 5, registerId = 1 }
    }}, { distance = { radius = 3.5 } })

   
   
   
   
   
   
   
    for foodContext, data in pairs(foodConfig) do
        local temp = {}
        for k, item in pairs(data) do
            if not item.cid or item.cid == cid then
                temp[#temp+1] = {
                    title = item.displayName,
                    description = item.description .. " | " .. item.craftTime .. "s",
                    action = "np-burgershot:orderFood",
                    params = {
                        itemid = item.itemid,
                        displayName = item.displayName,
                        craftTime = item.craftTime,
                        recipe = item.recipe,
                        context = foodContext
                    },
                }
            end
        end

        if foodContext == "foods" then
            foodsContext = temp
        elseif foodContext == "drinks" then
            drinksContext = temp
        end
    end

    AddEventHandler("np-inventory:itemUsed", function(item, info, inventory, slot, dbid)
        local itemInfo = json.decode(info)
    
     if item == "bentobox" then
            TriggerEvent("np-burgershot:openbentobox", dbid)
        end
    end)


    AddEventHandler("np-burgershot:openbentobox", function(pDBID)
        TriggerEvent("server-inventory-open", "1", "bento_box_" .. pDBID)
    end)


end)