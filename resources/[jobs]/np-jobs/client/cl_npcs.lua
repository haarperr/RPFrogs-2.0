--[[

    Variables

]]

local NPCs = {}
local Created = false

--[[

    Functions

]]

function GetNPCJobData(pId)
    for jobId, data in pairs(NPCs) do
        local id = GetHashKey(jobId)

        if id == pId then
           return {id = jobId}
        end
    end
end

--[[

    Exports

]]

exports("GetNPCJobData", GetNPCJobData)

--[[

    Events

]]

AddEventHandler("np:jobs:createNPCs", function(pNPCs)
    if not Created then
        Created = true

        for _, npc in ipairs(pNPCs) do
            local vectors = npc.headquarters
            npc.data.id = npc.jobid
            npc.data.position = {
              coords = vector3(vectors.x, vectors.y, vectors.z - 1.0),
              heading = vectors.h or 0.0
            }
            npc.data.position.heading = npc.data.position.heading
            NPCs[npc.jobid] = exports["np-npcs"]:RegisterNPC(npc.data)
        end
    end
end)