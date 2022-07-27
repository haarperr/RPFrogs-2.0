RegisterNetEvent("np-jail:sendToJail", function(pTarget, pTime)
    local src = source

    local cid = exports["np-base"]:getChar(pTarget, "id")
    if not cid then return end

    local affectedRows = MySQL.update.await([[
        UPDATE characters
        SET jail = ?
        WHERE id = ?
    ]],
    { pTime, cid })

    if not affectedRows or affectedRows < 1 then return end

    exports["np-base"]:setChar(pTarget, "jail", pTime)
    TriggerClientEvent("np-base:setChar", pTarget, "jail", pTime)

    local date = os.date("%d/%m/%Y %H:%M:%S", os.time())
	local name = exports["np-base"]:getChar(pTarget, "first_name") .. " " .. exports["np-base"]:getChar(pTarget, "last_name")

    TriggerClientEvent("np-jail:begInJail", pTarget, false, pTime, name, cid, date)
    TriggerClientEvent("chatMessage", src, "DOC: " , { 33, 118, 255 }, name .. " foi preso por " .. pTime .. " meses")
end)

RegisterNetEvent("np-jail:updateJailTime", function(pTime)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local affectedRows = MySQL.update.await([[
        UPDATE characters
        SET jail = ?
        WHERE id = ?
    ]],
    { pTime, cid })

    if not affectedRows or affectedRows < 1 then return end

    exports["np-base"]:setChar(src, "jail", tonumber(pTime))
    TriggerClientEvent("np-base:setChar", src, "jail", tonumber(pTime))
end)

RegisterNetEvent("np-jail:claimPossessions", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local name = "ply-" .. cid
    local jail = "jail-" .. cid

    MySQL.update.await([[
        DELETE FROM inventory
        WHERE name = ?
    ]],
    { jail })

    MySQL.update.await([[
        UPDATE inventory
        SET name = ?
        WHERE name = ?
    ]],
    { jail, name })
end)