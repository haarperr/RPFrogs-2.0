--[[

    Functions

]]

function loadGroups(_src)
    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local result = MySQL.query.await([[
        SELECT g1.group, g2.name, g1.rank
        FROM groups_members g1
        INNER JOIN ?? g2 ON g2.group = g1.group
        WHERE cid = ?
    ]],
    { "groups", cid })

    for i, v in ipairs(result) do
        result[i]["rankinfos"] = rankInfos(v["group"], v["rank"])
    end

    exports["np-base"]:setChar(src, "groups", result)
    TriggerClientEvent("np-base:setChar", src, "groups", result)
end

function groupInformations(group)
    if not group then return end

    local bank = exports["np-financials"]:getBalance(groupBank(group))

    local members = MySQL.query.await([[
        SELECT g1.cid, CONCAT(c1.first_name," ",c1.last_name) AS name, g1.rank, (IF(g1.giver IS NULL, "Unknown", CONCAT(c2.first_name," ",c2.last_name))) AS giver, g2.name AS rankname
        FROM groups_members g1
        INNER JOIN characters c1 ON c1.id = g1.cid
        INNER JOIN characters c2 ON (IF(g1.giver IS NULL, c2.id = g1.cid, c2.id = g1.giver))
        INNER JOIN groups_ranks g2 ON g2.group = g1.group AND g2.rank = g1.rank
        WHERE (g1.group = ? AND g1.rank > 0)
    ]],
    { group })

    local infos = {
        ["bank"] = bank,
        ["members"] = members,
    }

    return infos
end

function groupName(group)
    if not group then return "ERROR" end

    local name = MySQL.scalar.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ?
    ]],
    { "name", "groups", "group", group })

    if not name then return "ERROR" end

    return name
end

function groupLog(group, type, text)
    if not group or not type or not text then return end

    MySQL.insert([[
        INSERT INTO ?? (??, ??, ??, ??)
        VALUES (?, ?, ?, UNIX_TIMESTAMP())
    ]],
    { "groups_logs", "group", "type", "text", "date", group, type, text })
end

function groupLogs(group)
    if not group then return {} end

    local logs = MySQL.query.await([[
        SELECT ??, ??, FROM_UNIXTIME(??, "%d/%m/%y %H:%i:%s") AS ??
        FROM ??
        WHERE ?? = ?
        ORDER BY ?? DESC
    ]],
    { "type", "text", "date", "date", "groups_logs", "group", group, "id" })

    return logs
end

--[[

    Exports

]]

exports("groupName", groupName)
exports("groupLog", groupLog)

--[[

    Events

]]

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    loadGroups(src)
end)

--[[

    RPCs

]]

RPC.register("np-groups:groupInformations", function(src, group)
    return groupInformations(group)
end)

RPC.register("np-groups:groupLogs", function(src, group)
    return groupLogs(group)
end)