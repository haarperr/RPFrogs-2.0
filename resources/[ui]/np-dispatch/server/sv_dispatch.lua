--[[

    Variables

]]

local calls = {}

--[[

    Functions

]]

function getCalls()
    return calls
end

function removeCall(pCallId)
    if calls and calls[pCallId] then
        calls[pCallId] = nil
        return true
    end
    return false
end

function addUnit(player, callid)
    if not calls[callid] then return end

    local cid = exports["np-base"]:getChar(player, "id")

    if #calls[callid]["units"] > 0 then
        for i, v in ipairs(calls[callid]["units"]) do
            if v.cid == cid then
                return (#calls[callid]["units"])
            end
        end
    end

    local name = exports["np-base"]:getChar(player, "first_name") .. " " .. exports["np-base"]:getChar(player, "last_name")
    local job = exports["np-base"]:getChar(player, "job")
    local jobName = exports["np-jobs"]:getJob(job, "name")
    local callsign = exports["np-jobs"]:getCallsign(player, job)

    table.insert(calls[callid]["units"], {
        cid = cid,
        fullname = name,
        job = jobName,
        callsign = callsign
    })

    return (#calls[callid]["units"])
end

function removeUnit(player, callid)
    if not calls[callid] then return end

    local cid = exports["np-base"]:getChar(player, "id")

    if #calls[callid]["units"] > 0 then
        for i, v in ipairs(calls[callid]["units"]) do
            if v.cid == cid then
                table.remove(calls[callid]["units"], i)
                break
            end
        end
    end

    return (#calls[callid]["units"])
end

function getUnits(callid)
    if not calls[callid] then return end

    return (calls[callid]["units"])
end

function sendCallResponse(player, callid, message, time)
    if not calls[callid] then return false end

    table.insert(calls[callid]["responses"], {
        name = player,
        message = message,
        time = time
    })

    local player = calls[callid]["source"]
    if GetPlayerPing(player) > 0 then
        TriggerClientEvent("dispatch:getCallResponse", player, message)
    end

    return true
end

function getCallReponses(callid)
    if calls[callid] then
        return (calls[callid]["responses"])
    else
        return {}
    end
end

--[[

    Exports

]]

exports("getCalls", getCalls)
exports("removeCall", removeCall)
exports("addUnit", addUnit)
exports("removeUnit", removeUnit)
exports("getUnits", getUnits)
exports("sendCallResponse", sendCallResponse)
exports("getCallReponses", getCallReponses)

--[[

    Events

]]

RegisterNetEvent("dispatch:svNotify")
AddEventHandler("dispatch:svNotify", function(data)
	local newId = #calls + 1

    data["source"] = source
    data["callId"] = newId
    data["units"] = {}
    data["responses"] = {}
    data["time"] = os.time() * 1000

    calls[newId] = data

    TriggerClientEvent("dispatch:clNotify", -1, data, newId, source)

    if data["dispatchCode"] == "911" or data["dispatchCode"] == "311" then
        TriggerClientEvent("erp-dispatch:setBlip", -1, data["dispatchCode"], vector3(data["origin"]["x"], data["origin"]["y"], data["origin"]["z"]), newId)
    end
end)

--[[

    RPCs

]]

RPC.register("np-dispatch:getCall", function(src, pCall)
    if not pCall then return end

    if calls[pCall] then
        return calls[pCall]
    else
        return
    end
end)