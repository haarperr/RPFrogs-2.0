local EmergencyPlayers = {}

RegisterNetEvent("e-blips:updateBlips", function(pJob, pSelfUpdate)
    local src = source

    if exports["np-jobs"]:getJob(pJob, "is_emergency") then
        local callSign = exports["np-jobs"]:getCallsign(src, pJob)

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:deleteHandlers", k)
        end

        EmergencyPlayers[src] = {
            netId = src,
            job = pJob,
            callsign = callSign or "CALLSIGN NOT DEFINED"
        }

        Citizen.Wait(1000)

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:setHandlers", k, EmergencyPlayers)
        end
    elseif EmergencyPlayers[src] then
        EmergencyPlayers[src] = nil
        TriggerClientEvent("e-blips:deleteHandlers", src)

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:removeHandler", k, src)
        end
    end
end)

AddEventHandler("playerDropped", function()
	local src = source

    if EmergencyPlayers[src] then
        EmergencyPlayers[src] = nil

        for k, v in pairs(EmergencyPlayers) do
            TriggerClientEvent("e-blips:removeHandler", k, src)
        end
    end
end)