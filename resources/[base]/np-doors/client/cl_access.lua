--[[

    Variables

]]

local CurrentJob = "unemployed"

local accessCheckCache = {}
local accessCheckCacheTimer = {}
local businesses = {}
local businessesCacheTimer = nil

local securedAccesses = {}

--[[

    Functions

]]

function setSecuredAccesses(pAccesses, pType)
    securedAccesses[pType] = pAccesses
    accessCheckCache[pType] = {}
    accessCheckCacheTimer[pType] = {}
end

function clearAccessCache()
    for accessType, _ in pairs(accessCheckCache) do
        accessCheckCacheTimer[accessType] = {}
    end
end

function hasSecuredAccess(pId, pType)
    if accessCheckCacheTimer[pType][pId] ~= nil and accessCheckCacheTimer[pType][pId] + 60000 > GetGameTimer() then -- 1 minute
        return accessCheckCache[pType][pId] == true
    end

    local characterId = exports["np-base"]:getChar("id")

    accessCheckCacheTimer[pType][pId] = GetGameTimer()

    local job = exports["np-base"]:getChar("job")

    local secured = securedAccesses[pType][pId]

    if not secured then return end

    if secured.forceUnlocked then
        return false
    end

    if (secured.access.job and has_value(secured.access.job, "is_police") and exports["np-jobs"]:getJob(CurrentJob, "is_police")) then
        accessCheckCache[pType][pId] = true
        return true
    end

    if (secured.access.job and has_value(secured.access.job, "is_medic") and exports["np-jobs"]:getJob(CurrentJob, "is_medic")) then
        accessCheckCache[pType][pId] = true
        return true
    end

    if (secured.access.job and has_value(secured.access.job, CurrentJob) or false) or (secured.access.cid ~= nil and has_value(secured.access.cid, characterId)) then
        accessCheckCache[pType][pId] = true
        return true
    end

    if secured.access.item ~= nil then
        accessCheckCacheTimer[pType][pId] = 0
        for i, v in pairs(secured.access.item) do
            if exports["np-inventory"]:hasEnoughOfItem(i, 1, false) then
                return true
            end
        end
    end

    local groups = exports["np-base"]:getChar("groups")
    for i, v in pairs(groups) do
        if secured.access.groups and secured.access.groups[v.group] then
            local rank = exports["np-groups"]:GroupRank(v.group)
            if rank >= secured.access.groups[v.group] then
                accessCheckCache[pType][pId] = true
                return true
            end
        end
    end

    accessCheckCache[pType][pId] = false
    return false
end

--[[

    Events

]]

RegisterNetEvent("np-jobs:jobChanged")
AddEventHandler("np-jobs:jobChanged", function(currentJob, previousJob)
    CurrentJob = currentJob

    clearAccessCache()
end)