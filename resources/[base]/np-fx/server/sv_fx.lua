--[[

    Functions

]]

function GetRandomString(lenght)
    local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
    local randomString, stringLenght = '', lenght or 10
    local charTable = {}

    for char in chars:gmatch"." do
        table.insert(charTable, char)
    end

    for i = 1, stringLenght do
        randomString = randomString .. charTable[math.random(1, #charTable)]
    end

    return randomString
end

function TriggerParticleAtCoord(pDict, pName, pLooped, pPosition, pDuration, pPlayers)
    for i, v in ipairs(pPlayers) do
        TriggerClientEvent("particle:sync:coord", v, pDict, pName, pLooped, pPosition, pDuration, nil)
    end
end

function TriggerParticleOnEntity(pDict, pName, pLooped, pTarget, pBone, pPosition, pDuration, pPlayers)
    for i, v in ipairs(pPlayers) do
        TriggerClientEvent("particle:sync:entity", v, pDict, pName, pLooped, pTarget, pBone, pPosition, pDuration, nil)
    end
end

function TriggerParticleOnPlayer(pDict, pName, pLooped, pTarget, pBone, pPosition, pDuration, pPlayers)
    for i, v in ipairs(pPlayers) do
        TriggerClientEvent("particle:sync:player", v, pDict, pName, pLooped, pTarget, pBone, pPosition, pDuration, nil)
    end
end


--[[

    Threads

]]

-- Citizen.CreateThread(function()
--     Wait(2000)

--     local ptDict = "scr_family5"
--     local ptName = "scr_trev_puke"
--     local looped = true
--     local target = 1
--     local bone = 31086
--     local duration = 30000
--     local position = {
--         offset = {x = 0.0, y = 0.0, z = 0.0},
--         rot = {x = 0.0, y = 0.0, z = 0.0},
--         scale = 1.0,
--         alpha = 10.0
--     }

--     TriggerClientEvent("particle:sync:player", -1, ptDict, ptName, looped, target, bone, position, duration)
-- end)