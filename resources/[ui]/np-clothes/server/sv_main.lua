--[[

    Variables

]]

databaseFormat = {
    "model",
    "drawables",
    "props",
    "drawtextures",
    "proptextures",
    "hairColor",
    "fadeStyle",
    "headBlend",
    "headStructure",
    "headOverlay",
}

--[[

    Events

]]

RegisterServerEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    TriggerEvent("np-clothes:getClothes", src)
end)

RegisterServerEvent("np-clothes:getClothes")
AddEventHandler("np-clothes:getClothes", function(_src)
    local src = (not _src and source or _src)

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local clothes = MySQL.single.await([[
        SELECT *
        FROM characters_clothes
        WHERE cid = ?
    ]],
    { cid })

    if clothes then
        local data = {
            model = clothes.model,
            drawables = json.decode(clothes.drawables),
            props = json.decode(clothes.props),
            drawtextures = json.decode(clothes.drawtextures),
            proptextures = json.decode(clothes.proptextures),
            hairColor = json.decode(clothes.hairColor),
            fadeStyle = clothes.fadeStyle,
            headBlend = json.decode(clothes.headBlend),
            headStructure = json.decode(clothes.headStructure),
            headOverlay = json.decode(clothes.headOverlay),
            tattoos = json.decode(clothes.tattoos),
        }

        TriggerClientEvent("np-clothes:setClothes", src, data)
    end
end)

RegisterServerEvent("np-clothes:updateClothes")
AddEventHandler("np-clothes:updateClothes",function(data, tats)
    if not data then return end
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    for i, v in ipairs(databaseFormat) do
        if v == "model" then
            data[v] = tostring(data[v])
        elseif v == "fadeStyle" then
            data[v] = tonumber(data[v])
        else
            if data[v] then
                data[v] = json.encode(data[v])
            else
                data[v] = json.encode({})
            end
        end
    end

    if type(tats) ~= "table" then tats = {} end
    local tattoos = json.encode(tats)

    local exist = MySQL.scalar.await([[
        SELECT cid
        FROM characters_clothes
        WHERE cid = ?
    ]],
    { cid })

    if exist then
        MySQL.update([[
            UPDATE characters_clothes
            SET model = ?, drawables = ?, props = ?, drawtextures = ?, proptextures = ?, hairColor = ?, fadeStyle = ?, headBlend = ?, headStructure = ?, headOverlay = ?, tattoos = ?
            WHERE cid = ?
        ]],
        { data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay, tattoos, cid })
    else
        MySQL.insert([[
            INSERT INTO characters_clothes (cid, model, drawables, props, drawtextures, proptextures, hairColor, fadeStyle, headBlend, headStructure, headOverlay, tattoos)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, data.model, data.drawables, data.props, data.drawtextures, data.proptextures, data.hairColor, data.fadeStyle, data.headBlend, data.headStructure, data.headOverlay, tattoos })
    end
end)

RegisterServerEvent("np-clothes:getTattoos")
AddEventHandler("np-clothes:getTattoos", function(_src)
    local src = (not _src and source or _src)

    local cid = exports["np-base"]:getChar(src, "id")

    local tattoos = MySQL.scalar.await([[
        SELECT tattoos
        FROM characters_clothes
        WHERE cid = ?
    ]],
    { cid })

    if tattoos then
        TriggerClientEvent("raid_clothes:settattoos", src, json.decode(tattoos))
    else
        TriggerClientEvent("raid_clothes:settattoos", src, {})
    end
end)

--[[

    RPCs

]]

RPC.register("np-clothes:purchase", function(src, price, tax, paymentType)
    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    if paymentType == "cash" then
        local cash = exports["np-financials"]:getCash(src)

        if price > cash then
            return false
        end

        if not exports["np-financials"]:updateCash(src, "-", price) then
            return false
        end

        exports["np-financials"]:updateBalance(13, "+", price)
        exports["np-financials"]:transactionLog(13, 13, price, "", cid, 7)
        exports["np-financials"]:addTax("Services", tax)
    else
        local accountId = exports["np-base"]:getChar(src, "bankid")
        local bank = exports["np-financials"]:getBalance(accountId)

        if price > bank then
            return false
        end

        local comment = "Clothing"
        local success, message = exports["np-financials"]:transaction(accountId, 13, price, comment, cid, 5)
        if not success then
            TriggerClientEvent("np-phone:notification", src, "fas fa-exclamation-circle", "Error", message, 5000)
            return false
        end

        TriggerClientEvent("np-phone:notification", src, "fas fa-university", "Bank", "You transfered $" .. price .. " to State ID: " .. 13, 3000)

        exports["np-financials"]:addTax("Services", tax)
    end

    return true
end)