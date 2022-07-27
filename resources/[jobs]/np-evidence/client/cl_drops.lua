DroppedEvidence, IsAccumulating = {}, false

AddEventHandler("np-evidence:dropEvidence", function (pCoords, pMeta, pSuffix)
    local uid = pCoords.x .. "-" .. pCoords.y .. "-" .. pCoords.z

    if pSuffix then
        uid = uid .. "-" .. pSuffix
    end

    DroppedEvidence[uid] = {
        ["x"] = pCoords.x,
        ["y"] = pCoords.y,
        ["z"] = pCoords.z,
        ["meta"] = pMeta
    }

    if IsAccumulating then return end

    IsAccumulating = true

    Citizen.SetTimeout(5000, function ()
        local dropped = DroppedEvidence

        DroppedEvidence = {}

        IsAccumulating = false

        RPC.execute("np-evidence:addEvidence", dropped)
    end)
end)