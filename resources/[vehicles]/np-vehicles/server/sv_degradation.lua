--[[

    Variables

]]

local defaultDegradation = {
    ["brake"] = 100,
    ["axle"] = 100,
    ["radiator"] = 100,
    ["clutch"] = 100,
    ["transmission"] = 100,
    ["electronics"] = 100,
    ["injector"] = 100,
    ["tire"] = 100,
}

local vehiclesHealth = {
    ["identifier"] = {},
    ["plate"] = {},
}

local vehiclesDegradation = {
    ["identifier"] = {},
    ["plate"] = {},
}

local vehiclesMileage = {
    ["identifier"] = {},
    ["plate"] = {},
    ["updates"] = {},
}

--[[

    Functions

]]

function getDegradation(identifier, plate)
    if identifier then
        if not vehiclesDegradation["identifier"][identifier] then
            local _degradation = getVehicleMetadata(identifier, "degradation")

            if _degradation then
                _degradation = json.decode(_degradation)
            else
                updateVehicle(identifier, "metadata", "degradation", json.encode(defaultDegradation))
                _degradation = defaultDegradation
            end

            vehiclesDegradation["identifier"][identifier] = _degradation
        end

        return vehiclesDegradation["identifier"][identifier]
    else
        if not vehiclesDegradation["plate"][plate] then
            vehiclesDegradation["plate"][plate] = defaultDegradation
        end

        return vehiclesDegradation["plate"][plate]
    end
end

function getMileage(identifier, plate)
    if identifier then
        if not vehiclesMileage["identifier"][identifier] then
            local _mileage = getVehicleMetadata(identifier, "mileage")

            vehiclesMileage["identifier"][identifier] = _mileage
        end

        return vehiclesMileage["identifier"][identifier]
    else
        if not vehiclesMileage["plate"][plate] then
            vehiclesMileage["plate"][plate] = math.random(10000, 100000) + math.random()
        end

        return vehiclesMileage["plate"][plate]
    end
end

--[[

    Events

]]

RegisterNetEvent("np-vehicles:updateVehicleHealth")
AddEventHandler("np-vehicles:updateVehicleHealth", function(identifier, plate, body, engine)
    local src = source

    if identifier then
        MySQL.update.await([[
            UPDATE vehicles_metadata
            SET body_damage = ?, engine_damage = ?
            WHERE vid = ?
        ]],
        { body, engine, identifier })

        vehiclesHealth["identifier"][identifier] = {
            ["body_damage"] = body,
            ["engine_damage"] = engine,
        }
    else
        vehiclesHealth["plate"][plate] = {
            ["body_damage"] = body,
            ["engine_damage"] = engine,
        }
    end
end)

RegisterNetEvent("np-vehicles:updateVehicleDegradation")
AddEventHandler("np-vehicles:updateVehicleDegradation", function(identifier, plate, degradations)
    local src = source

    if identifier then
        MySQL.update.await([[
            UPDATE vehicles_metadata
            SET degradation = ?
            WHERE vid = ?
        ]],
        { json.encode(degradations), identifier })

        vehiclesDegradation["identifier"][identifier] = degradations
    else
        vehiclesDegradation["plate"][plate] = degradations
    end
end)

RegisterNetEvent("np-vehicles:adminRepair")
AddEventHandler("np-vehicles:adminRepair", function(target)
    if not target then return end

    local ped = GetPlayerPed(target)
    if not ped then return end

    local vehicle = GetVehiclePedIsIn(ped, false)
    if not vehicle then return end

    local plate = string.gsub(GetVehicleNumberPlateText(vehicle), "%s+", "")
    if not plate then return end

    local vid = MySQL.scalar.await([[
        SELECT id
        FROM vehicles
        WHERE plate = ?
    ]],
    { plate })

    TriggerEvent("np-vehicles:updateVehicleHealth", vid, plate, 1000, 1000)
    TriggerEvent("np-vehicles:updateVehicleDegradation", vid, plate, defaultDegradation)
end)

RegisterNetEvent("np-vehicles:bennysResetDegradation")
AddEventHandler("np-vehicles:bennysResetDegradation", function(pVid, pPlate)
    TriggerEvent("np-vehicles:updateVehicleDegradation", vid, pPlate, defaultDegradation)
end)

RegisterNetEvent("np-vehicles:updateVehicleMileage")
AddEventHandler("np-vehicles:updateVehicleMileage", function(identifier, plate, mileage)
    local src = source

    local curMileage = getMileage(identifier, plate)

    if identifier then
        vehiclesMileage["identifier"][identifier] = curMileage + mileage

        if not vehiclesMileage["updates"][identifier] or GetGameTimer() > vehiclesMileage["updates"][identifier] then
            vehiclesMileage["updates"][identifier] = GetGameTimer() + 300000

            MySQL.update.await([[
                UPDATE vehicles_metadata
                SET mileage = ?
                WHERE vid = ?
            ]],
            { roundDecimals(vehiclesMileage["identifier"][identifier], 2), identifier })
        end
    else
        vehiclesMileage["plate"][plate] = curMileage + mileage
    end
end)

--[[

    RPCs

]]

RPC.register("np-vehicles:getDegradation", function(src, identifier, plate)
    return getDegradation(identifier, plate)
end)

RPC.register("np-vehicles:getMileage", function(src, identifier, plate)
    return getMileage(identifier, plate)
end)