--[[

    Variables

]]

local stageLasers = {}
local lasersActive = false

local laserStartPoints = {
    vector3(-837.101, -717.194, 29.87),
    vector3(-837.373, -718.705, 29.885),
    vector3(-838.132, -720.017, 29.889),
    vector3(-839.292, -720.998, 29.892),
    vector3(-840.698, -721.493, 29.904),
    vector3(-842.464, -718.813, 29.914),
    vector3(-841.685, -717.493, 29.896),
    vector3(-840.545, -716.519, 29.898),
    vector3(-838.317, -716.619, 30.56),
    vector3(-841.83, -720.161, 30.56),
    vector3(-839.613, -718.692, 30.56)
}
local laserGridPoints = {
    vector3(-841.727, -721.388, 27.285),
    vector3(-840.012, -720.993, 27.285),
    vector3(-838.837, -720.22, 27.285),
    vector3(-837.966, -718.903, 27.285),
    vector3(-837.759, -717.651, 27.285),
    vector3(-841.939, -719.116, 27.285),
    vector3(-841.53, -717.168, 27.285),
    vector3(-839.534, -716.783, 27.285),
    vector3(-839.81, -719.167, 27.285),
    vector3(-840.648, -719.859, 27.285),
    vector3(-839.037, -717.671, 27.285)
}

--[[

    Functions

]]

local function activateLasers(doActivate)
    if doActivate and #(GetEntityCoords(PlayerPedId()) - vector3(-837.101, -717.194, 29.87)) > 100 then return end
    if doActivate and lasersActive then return end

    lasersActive = doActivate

    if not lasersActive then
        for _, v in pairs(stageLasers) do
            v.setActive(false)
        end
        return
    end

    Citizen.CreateThread(function()
         while lasersActive do
            for _, v in pairs(stageLasers) do
                v.setActive(true)
            end

            if math.random() < 0.1 then
                local lc = 0
                local wasActive = true

                while lc < 6 do
                    lc = lc + 1
                    wasActive = not wasActive

                    for _, v in pairs(stageLasers) do
                        v.setActive(wasActive)
                    end

                    Citizen.Wait(125)
                end

                for _, v in pairs(stageLasers) do
                    v.setActive(true)
                end
            end

            Citizen.Wait(2500)
        end

        for _, v in pairs(stageLasers) do
            v.setActive(false)
        end
    end)
end

--[[

    Events

]]

RegisterNetEvent("np-ghettorecords:activateLasers")
AddEventHandler("np-ghettorecords:activateLasers", function(doActivate)
    activateLasers(doActivate)
end)

AddEventHandler("np-polyzone:enter", function(zone)
    if zone ~= "ghettorecords_laser" then return end

    activateLasers(true)
end)

AddEventHandler("np-polyzone:exit", function(zone)
    if zone ~= "ghettorecords_laser" then return end

    activateLasers(false)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    for k, coords in pairs(laserStartPoints) do
        local cLaser = Laser.new(coords, laserGridPoints, {
            travelTimeBetweenTargets = {1.0, 1.0},
            waitTimeAtTargets = {0.0, 0.0},
            randomTargetSelection = true,
            name = "laser_wc_" .. tostring(k),
            color = {0, 255, 100, 200},
            extensionEnabled = false,
        })
        stageLasers[#stageLasers + 1] = cLaser
    end

    exports["np-polyzone"]:AddPolyZone("ghettorecords_laser", {
        vector2(-842.6162109375, -730.47924804688),
        vector2(-842.63787841797, -716.04516601562),
        vector2(-815.86633300781, -716.15338134766),
        vector2(-813.33898925781, -729.83660888672),
        vector2(-823.32220458984, -730.83538818359)
    }, {
        --debugPoly = true,
        gridDivisions = 25,
        minZ = 27.17,
        maxZ = 30.72,
    })

    exports["np-polytarget"]:AddBoxZone("ghettorecords_music_maker", vector3(-818.17, -719.02, 32.34), 3.0, 0.6, {
        heading = 0,
        minZ = 32.14,
        maxZ = 32.74,
        data = {
            id = "ghettorecords_music_maker",
        },
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("ghettorecords_music_maker", {{
        event = "np-music:addMusicEntry",
        id = "ghettorecordsMusicEntry",
        icon = "music",
        label = "Add Music",
        parameters = { group = "ghettorecords" },
    }}, { distance = { radius = 3.5 } })

    exports["np-eye"]:AddPeekEntryByPolyTarget("ghettorecords_music_maker", {{
        event = "np-music:createMusicTapes",
        id = "ghettorecordsMusicTapes",
        icon = "play-circle",
        label = "Create Tapes",
        parameters = { group = "ghettorecords" },
    }}, { distance = { radius = 3.5 } })
end)