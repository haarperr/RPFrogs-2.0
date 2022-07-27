--[[

    Functions

]]

function getCallsign(pSrc, pJob)
    local cid = exports["np-base"]:getChar(pSrc, "id")
    if not cid then return end

    local callSign = MySQL.scalar.await([[
        SELECT callsign
        FROM jobs_callsigns
        WHERE cid = ? AND job = ?
    ]],
    { cid, pJob })

    return callSign
end

function setCallsign(cid, job, callsign)
    local exist = MySQL.scalar.await([[
        SELECT id
        FROM jobs_callsigns
        WHERE cid = ? AND job = ?
    ]],
    { cid, job })

    if exist then
        local affectedRows = MySQL.update.await([[
            UPDATE jobs_callsigns
            SET callsign = ?
            WHERE id = ?
        ]],
        { callsign, exist })

        if not affectedRows or affectedRows < 1 then
            return false, "Database update error"
        end

        return true, "Callsign updated"
    else
        local insertId = MySQL.insert.await([[
            INSERT INTO jobs_callsigns (cid, job, callsign)
            VALUES (?, ?, ?)
        ]],
        { cid, job, callsign })

        if not insertId or insertId < 1 then
            return false, "Database insert error"
        end

        return true, "Callsign updated"
    end
end

--[[

    Exports

]]

exports("getCallsign", getCallsign)
exports("setCallsign", setCallsign)

--[[

    RPC

]]

RPC.register("np-jobs:getCallsign", function(src, job)
    return getCallsign(src, job)
end)

RPC.register("np-jobs:setCallsign", function(src, cid, job, callsign)
    return setCallsign(cid, job, callsign)
end)