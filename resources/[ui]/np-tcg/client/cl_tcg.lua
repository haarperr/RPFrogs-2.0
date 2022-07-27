--[[

    Variables

]]

local inBinder = false
local inPackOpening = true

--[[

    Functions

]]

function LoadAnimationDic(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
    end
end

local function playPackOpeningAnimation()
    inPackOpening = true
    Citizen.Wait(500)
    ClearPedTasksImmediately()
    Citizen.Wait(500)
    LoadAnimationDic("amb@world_human_tourist_map@male@idle_a")
    TaskPlayAnim(PlayerPedId(), "amb@world_human_tourist_map@male@idle_a", "idle_b", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
    TriggerEvent("attachItemPhone", "tcg_card_inspect")
end

local function stopPackOpeningAnimation()
    Citizen.Wait(1000)
    StopAnimTask(PlayerPedId(), "amb@world_human_tourist_map@male@idle_a", "idle_b", 1.0)
    TriggerEvent("destroyPropPhone")
    inPackOpening = false
end

local function playBinderAnimation()
    inBinder = true
    Citizen.Wait(500)
    ClearPedTasksImmediately()
    Citizen.Wait(500)
    LoadAnimationDic("amb@code_human_in_bus_passenger_idles@female@tablet@base")
    TaskPlayAnim(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 3.0, 3.0, -1, 49, 0, 0, 0, 0)
    TriggerEvent("attachItemPhone", "binder01")
end

local function stopBinderAnimation()
    Citizen.Wait(1000)
    StopAnimTask(PlayerPedId(), "amb@code_human_in_bus_passenger_idles@female@tablet@base", "base", 1.0)
    TriggerEvent("destroyPropPhone")
    inBinder = false
end

--[[

    Events

]]

AddEventHandler("np-inventory:itemUsed", function(item, info, inventory, slot, dbid)
    local itemInfo = json.decode(info)

    if item == "tcgcard" then
        TriggerEvent("np-tcg:previewCard", itemInfo)
    elseif TCG.Packs[item] then
        TriggerEvent("inventory:removeItem", item, 1)
        TriggerEvent("np-tcg:openPack", item)
    elseif item == "tcgbinder" then
        TriggerEvent("np-tcg:openBinder", dbid)
    end
end)

AddEventHandler("np-tcg:openPack", function(type)
    playPackOpeningAnimation()

    local packCards = TCG.Packs[type]

    local cards = {}
    local _cards = {}
    local count = 0
    for i=1, 1000 do
        local randomCard = packCards[math.random(#packCards)]
        if not _cards[randomCard] then
            _cards[randomCard] = true
            count = count + 1

            if count == 5 then
                break
            end
        end
    end

    for k, v in pairs(_cards) do
        table.insert(cards, {
            card = k,
            image = TCG.Cards[k]["image"],
            hollow = math.random(100) > 95,
        })
    end

	SetNuiFocus(true, true)
    SendNUIMessage({
		open = true,
		cards = cards
	})
end)

AddEventHandler("np-tcg:previewCard", function(pInfo)
	playPackOpeningAnimation()

    SetNuiFocus(true, true)
    SendNUIMessage({
		open = true,
		card = pInfo._image_url,
		hollow = pInfo._hollow
	})
end)

AddEventHandler("np-tcg:openBinder", function(pDBID)
    playBinderAnimation()
    TriggerEvent("server-inventory-open", "1", "tcg_binder_" .. pDBID)
end)

AddEventHandler("inventory:wepDropCheck", function()
    if inBinder then
        stopBinderAnimation()
    end
end)

AddEventHandler("np-tcg:shop", function(pParams, pEntity, pContext)
    TriggerServerEvent("np-tcg:buy", pParams.type)
end)

--[[

    NUI

]]

RegisterNUICallback("giveCard", function(data, cb)
	local name = TCG.Cards[data.card]["name"]
	local description = TCG.Cards[data.card]["description"]
    local image = TCG.Cards[data.card]["image"]
    local hollow = data.hollow

    if hollow then
        name = name .. " (Brilhante)"
    end

    local metaInfo = {
        _name = name,
        _description = description,
        _image_url = image,
        _hollow = data.hollow,
        _remove_id = math.random(1000000, 9999999),

        _hideKeys = {
            "_name",
            "_description",
            "_image_url",
            "_hollow",
            "_remove_id",
        },
    }

    TriggerEvent("player:receiveItem", "tcgcard", 1, true, metaInfo)

    cb(true)
end)

RegisterNUICallback("close", function(data, cb)
	SetNuiFocus(false, false)

    if inPackOpening then
        stopPackOpeningAnimation()
    end

	cb(true)
end)


--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    exports["np-npcs"]:RegisterNPC({
        id = "tcg_seller_npc",
        name = "TCG Seller",
        pedType = 4,
        model = "a_m_y_vinewood_01",
        networked = false,
        distance = 25.0,
        position = {
            coords = vector3(256.66, -1598.44, 30.54),
            heading = 315.64,
            random = false,
        },
        appearance = nil,
        settings = {
            { mode = "invincible", active = true },
            { mode = "ignore", active = true },
            { mode = "freeze", active = true },
        },
        flags = {
            ["isNPC"] = true,
        },
        scenario = "WORLD_HUMAN_STAND_MOBILE",
    })

    exports["np-eye"]:AddPeekEntryByFlag({ "isNPC" }, {
        {
            id = "tgc_buy_binder",
            label = "Card Binder - $250",
            icon = "book-open",
            event = "np-tcg:shop",
            parameters = {
                type = "tcgbinder",
            },
        },
        {
            id = "tgc_buy_pack_1",
            label = "Card Pack - $50",
            icon = "circle",
            event = "np-tcg:shop",
            parameters = {
                type = "tcgpack_ogs",
            },
        },
    }, { distance = { radius = 2.5 }, npcIds = { "tcg_seller_npc" } })
end)




