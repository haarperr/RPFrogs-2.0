RegisterNetEvent("np-fx:smoke:grenade", function(pCoords)
    local players = exports["np-infinity"]:GetNerbyPlayers(pCoords, 100)
    local ptDict, ptName = "core", "exp_grd_grenade_smoke"
    local position = {
        coords = { { x = pCoords.x, y = pCoords.y, z = pCoords.z } },
        rot = { x = 0.0, y = 0.0, z = 0.0 },
        scale = 1.0,
        alpha = 10.0,
    }
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
    position.coords[1].z = position.coords[1].z + 1.0
    Wait(1000)
    TriggerParticleAtCoord(ptDict, ptName, true, position, 15000, players)
end)

RegisterNetEvent("np-fx:chain:blingDiamonds", function(pCoords, pType, pSize, pStrengh, pScale)
    local serverId = source
    local players = exports["np-infinity"]:GetNerbyPlayers(pCoords, 25)
    local ptDict, ptName = "", ""
    if pType == "diamonds" then
        ptDict, ptName = "scr_bike_adversary", "scr_adversary_weap_glow"
    end
    if pType == "ruby" then
        ptDict, ptName = "scr_bike_adversary", "scr_adversary_foot_flames"
    end
    if pType == "tanzanite" then
        ptDict, ptName = "scr_bike_adversary", "scr_adversary_gunsmith_weap_change"
    end
    local scale = (math.min(0.5, math.max(0.1, 0.025 * pSize))) * (pScale or 1.0)
    local alpha = 1.0 + (pStrengh / 10)
    local position = {
        offset = {x = -0.04, y = 0.17, z = -0.1},
        rot = {x = -386.0, y = 19.0, z = -163.0},
        scale = scale,
        alpha = alpha
    }
    TriggerParticleOnPlayer(ptDict, ptName, true, serverId, 10706, position, 2000, players)
end)

RegisterNetEvent("fx:poo:start", function(PooingID)
    local serverId = source

    local coords = GetEntityCoords(GetPlayerPed(serverId))
    local players = exports["np-infinity"]:GetNerbyPlayers(coords, 25)

    local position = {
        offset = {x = 0.0, y = 0.0, z = -0.1},
        rot = {x = 0.0, y = 0.0, z = 0.0},
        scale = 0.85,
        alpha = 20.0
    }

    for i, v in ipairs(players) do
        TriggerClientEvent("particle:sync:player", v, "scr_amb_chop", "ent_anim_dog_poo", true, serverId, 11816, position, false, PooingID)
    end
end)

RegisterNetEvent("fx:puke", function(pTarget)
    local serverId = source
    if pTarget ~= nil then
        serverId = pTarget
    end

    local coords = GetEntityCoords(GetPlayerPed(serverId))
    local players = exports["np-infinity"]:GetNerbyPlayers(coords, 25)

    local position = {
        offset = {x = 0.0, y = 0.0, z = 0.0},
        rot = {x = 0.0, y = 0.0, z = 0.0},
        scale = 1.0,
        alpha = 10.0
    }

    TriggerParticleOnPlayer("scr_family5", "scr_trev_puke", true, serverId, 31086, position, 5000, players)
end)