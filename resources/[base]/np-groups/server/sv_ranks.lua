--[[

    Functions

]]

function rankInfos(group, rank)
    if not group or not rank then return {} end

    local infos = MySQL.single.await([[
        SELECT *
        FROM ??
        WHERE ?? = ? AND ?? = ?
    ]],
    { "groups_ranks", "group", group, "rank", rank })

    if not infos then return {} end

    return infos
end

function rankAmount(group)
    if not group then return 0 end

    local ranks = MySQL.query.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ?
        ORDER BY ??
    ]],
    { "rank", "groups_ranks", "group", group, "rank" })

    if not ranks[1] then return 0 end

    local total = ranks[#ranks]["rank"]

    return total
end

function setRank(group, rank, cid, _src)
    if not group or not rank or not cid then return false end

    local src = source
    if _src then src = _src end

    local giver = exports["np-base"]:getChar(src, "id")

    if giver == cid then
        TriggerClientEvent("DoLongHudText", src, "Really dude?", 2)
        return false
    end

    local exist = characterExist(cid)
    if not exist then
        TriggerClientEvent("DoLongHudText", src, "This id dont exist", 2)
        return false
    end

    local total = rankAmount(group)
    if rank > total then
        TriggerClientEvent("DoLongHudText", src, "Rank max for this groups is " .. total, 2)
        return false
    end

    local giverrank = getRank(group, 0, giver)
    local currentrank = getRank(group, 0, cid)

    if giverrank <= currentrank then
        TriggerClientEvent("DoLongHudText", src, "You cant do that", 2)
        return false
    end

    if rank < 1 and currentrank > 0 then
        MySQL.query.await([[
            DELETE FROM ??
            WHERE ?? = ? AND ?? = ?
        ]],
        { "groups_members", "cid", cid, "group", group })
    elseif rank > 0 and currentrank == 0 then
        MySQL.query.await([[
            INSERT INTO ?? (??, ??, ??, ??)
            VALUES (?, ?, ?, ?)
        ]],
        { "groups_members", "cid", "group", "rank", "giver", cid, group, rank, giver })
    elseif rank > 0 and currentrank > 0 then
        MySQL.query.await([[
            UPDATE ??
            SET ?? = ?, ?? = ?
            WHERE ?? = ? AND ?? = ?
        ]],
        { "groups_members", "rank", rank, "giver", giver, "cid", cid, "group", group })
    end

    local sid = exports["np-base"]:getSidWithCid(cid)
    if sid > 0 then
        loadGroups(sid)
    end

    exports["np-logs"]:AddLog("groupRank", src, giverrank, cid, sid, currentrank, rank, group)
    groupLog(group, "Rank", exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name") .. " change " .. getCharacter(cid, "first_name") .. " " .. getCharacter(cid, "last_name") .. " rank to " .. rank)

    return true
end

function getRank(group, _src, _cid)
    if not group then return 0 end

    local src = source
    if _src then src = _src end

    local cid = 0
    if _cid then
        cid = _cid
    else
        cid = exports["np-base"]:getChar(src, "id")
    end

    local rank = MySQL.scalar.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ? AND ?? = ?
    ]],
    { "rank", "groups_members", "cid", cid, "group", group })

    if not rank then return 0 end

    return rank
end

--[[

    Exports

]]

exports("getRank", getRank)
exports("rankInfos", rankInfos)

--[[

    RPCs

]]

RPC.register("np-groups:setRank", function(src, group, rank, cid)
    return setRank(group, rank, cid, src)
end)

RPC.register("np-groups:ranks", function(src, group)
    local ranks = MySQL.query.await([[
        SELECT *
        FROM ??
        WHERE ?? = ?
    ]],
    { "groups_ranks", "group", group })

    return ranks
end)

RPC.register("np-groups:rankInfos", function(src, group, rank)
    return rankInfos(group, rank)
end)