--[[

    Functions

]]

function groupsBanks(cid)
    local groups = {}

    local _groups = MySQL.query.await([[
        SELECT g2.withdraw, g2.deposit, g3.id, g3.bank
        FROM groups_members g1
        INNER JOIN groups_ranks g2 ON g1.group = g2.group AND g1.rank = g2.rank
        INNER JOIN ?? g3 ON g1.group = g3.group
        WHERE g1.cid = ? AND g1.rank > 0
    ]],
    { "groups", cid })

    for i, v in ipairs(_groups) do
        if v.withdraw or v.deposit then
            groups[v.bank] = v
        end
    end

    return groups
end

function groupBank(group)
    if not group then return 1 end

    local bank = MySQL.scalar.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ?
    ]],
    { "bank", "groups", "group", group })

    if not bank then return 1 end

    return bank
end

--[[

    Exports

]]

exports("groupsBanks", groupsBanks)
exports("groupBank", groupBank)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local groups = MySQL.query.await([[
        SELECT id, bank
        FROM ??
    ]],
    { "groups" })

    for i, v in ipairs(groups) do
        if v.bank == 0 then
            local accountId = exports["np-financials"]:generateAccountId(4)
            if accountId then
                local created = exports["np-financials"]:createAccount(accountId, 4, v.id)
                if created then
                    local result = MySQL.update.await([[
                        UPDATE ??
                        SET bank = ?
                        WHERE id = ?
                    ]],
                    { "groups", accountId, v.id })
                end
            end
        end
    end
end)