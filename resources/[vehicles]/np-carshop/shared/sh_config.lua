Config = {}
Config["Vehicles"] = {}
Config["Zones"] = {}

Config["pdm"] = {
    TestDrive = vector4(-45.22, -1083.05, 26.01, 69.47),
    Buyed = vector4(-48.94, -1077.68, 26.81, 65.88),

    Spawns = {
        { ["model"] = "gauntlet",    ["pos"] = vector4(-38.25, -1104.18, 26.43, 14.46) },
	    { ["model"] = "dubsta3",     ["pos"] = vector4(-36.36, -1097.30, 26.43, 109.4) },
	    { ["model"] = "landstalker", ["pos"] = vector4(-43.11, -1095.02, 26.43, 67.77) },
	    { ["model"] = "bobcatxl",    ["pos"] = vector4(-50.45, -1092.66, 26.43, 116.33) },
	    { ["model"] = "glendale",    ["pos"] = vector4(-49.73, -1098.63, 26.43, 240.99) },
	    { ["model"] = "washington",  ["pos"] = vector4(-45.58, -1101.40, 26.43, 287.3) },
    },

    Init = function()
        exports["np-polyzone"]:AddBoxZone("pdm", vector3(-58.34, -1111.57, 26.44), 87.6, 86.8, {
            -- debugPoly = true,
            heading = 339,
            minZ = 23.84,
            maxZ = 37.64,
        })

        exports["np-polyzone"]:AddBoxZone("catalog", vector3(-57.11, -1097.17, 26.42), 1.0, 3.8, {
            -- debugPoly = true,
            heading = 30,
            minZ = 25.42,
            maxZ = 28.02,
        })

        exports["np-polyzone"]:AddBoxZone("pdmbackdoor", vector3(-29.28, -1086.63, 26.57), 2.2, 5.0, {
            -- debugPoly = true,
            heading = 340,
            minZ = 25.52,
            maxZ = 28.12,
        })


        local listening = false

        local function listenForKeypress()
            listening = true

            Citizen.CreateThread(function()
                while listening do
                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("np-carshop:pdmBackDoor")
                    end
                    Wait(0)
                end
            end)
        end

        RegisterNetEvent("np-carshop:pdmBackDoor")
        AddEventHandler("np-carshop:pdmBackDoor", function(toggle)
            local Simeon = exports["np-assets-ipls"]:GetSimeonObject()
            Simeon.Shutter.Set(Simeon.Shutter[toggle])
            RefreshInterior(Simeon.interiorId)
        end)

        AddEventHandler("np-polyzone:enter", function(name)
            if name ~= "pdmbackdoor" then return end

            exports["np-interaction"]:showInteraction("[E] Abrir/Fechar")
            listenForKeypress()
        end)

        AddEventHandler("np-polyzone:exit", function(name)
            if name ~= "pdmbackdoor" then return end

            exports["np-interaction"]:hideInteraction()
            listening = false
        end)
    end,
}