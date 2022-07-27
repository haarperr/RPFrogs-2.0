--[[

    Variables

]]

local vehiclesGarage = {}

local nearGarage = {
    ["garage"] = "",
    ["space"] = 0,
    ["coords"] = nil,
}

local Garages = {}

--[[

    Functions

]]

function IsOnParkingSpot(pEntity, pCheck, pRadius)
    local entityCoords = GetEntityCoords(pEntity)

    local _distance = 300
    local garage = nil
    for k, v in pairs(Garages) do
        local distance = #(entityCoords - v["pos"]["xyz"])

        if distance < _distance then
            if distance < v["distance"] then
                _distance = distance
                garage = k
            end
        end
    end

    if not garage then
        return false
    end

    local radius = 2.0
    if pRadius then
        radius = pRadius
    end

    local space = nil
    local nearest = 999.99
    for i, v in ipairs(Garages[garage]["spaces"]) do
        local distance = #(entityCoords - v["xyz"])
        if distance < radius and distance < nearest then
            if pCheck and not IsAnyVehicleNearPoint(v["x"], v["y"], v["z"], radius) then
                space = i
                nearest = distance
            else
                space = i
                nearest = distance
            end
        end
    end

    if not space then
        return false
    end

    nearGarage = {
        ["garage"] = garage,
        ["space"] = space,
        ["coords"] = Garages[garage]["spaces"][space],
    }

    return true
end

--[[

    Exports

]]

exports("IsOnParkingSpot", IsOnParkingSpot)

--[[

    Events

]]

AddEventHandler("np-vehicles:garage", function(params)
    local job = exports["np-base"]:getChar("job")
    local garage = Garages[nearGarage["garage"]]

    if garage["jobGarage"] and garage["type"] ~= job then
        TriggerEvent("DoLongHudText", "You can't use this garage", 2)
        return
    end

    if garage["houseid"] and not exports["np-housing"]:hasKey(garage["houseid"]) then
        TriggerEvent("DoLongHudText", "You can't use this garage", 2)
        return
    end

    local vehiclesGarage = RPC.execute("np-vehicles:getGarage", nearGarage["garage"])

    local data = {
        {
            title = "Garage " .. nearGarage["garage"],
        }
    }

    for i, v in ipairs(vehiclesGarage) do
        table.insert(data,{
            title = (GetDisplayNameFromVehicleModel(v["model"])),
            description = "Plate: " .. v["plate"],
            children = {
                { title = "Take Out Vehicle", action = "np-vehicles:retriveVehicle", params = v["id"] },
                { title = "Vehicle Status", description = "Engine: " .. v["engine_damage"] / 10 .. "% | Body: " .. v["body_damage"] / 10 .. "% | Fuel: " .. v["fuel"] .. "%"},
            },
        })
    end

    exports["np-context"]:showContext(data)
end)

AddEventHandler("np-vehicles:retriveVehicle", function(vehID)
    local vehicle = RPC.execute("np-vehicles:getVehicle", vehID)
    if vehicle then
        if not nearGarage["coords"] then return end

        TriggerEvent("np-vehicles:spawnVehicle", vehicle.model, nearGarage["coords"], vehicle.id, vehicle.plate, vehicle.fuel, vehicle.modifications, vehicle.fakePlate, vehicle.harness, vehicle.body_damage, vehicle.engine_damage)
        RPC.execute("np-vehicles:updateVehicle", vehicle.id, "garage", "state", "Out")
    end
end)

AddEventHandler("np-vehicles:storeVehicle", function(params, vehicle)
    local vid = GetVehicleIdentifier(vehicle)
    if not vid then return end

    local garage = nearGarage["garage"]
    if garage == "" then return end

    local canStore = RPC.execute("np-vehicles:canStoreVehicle", garage, vid)
    if not canStore then return end

    local garageData = Garages[nearGarage["garage"]]

    if garageData["houseid"] then
        if exports["np-housing"]:hasKey(garageData["houseid"]) then
            local cid = exports["np-base"]:getChar("id")
            local owner = RPC.execute("np-vehicles:selectVehicle", vid, "vehicles", "cid")

            if owner ~= cid then
                TriggerEvent("DoLongHudText", "You cant't use this garage", 2)
                return
            end
        else
            TriggerEvent("DoLongHudText", "You can't use this garage", 2)
            return
        end
    end

    local store1 = RPC.execute("np-vehicles:updateVehicle", vid, "garage", "garage", garage)
    if store1 then
        local store2 = RPC.execute("np-vehicles:updateVehicle", vid, "garage", "state", "In")
        if store2 then
            Sync.DeleteVehicle(vehicle)
            Sync.DeleteEntity(vehicle)
        end
    end
end)

RegisterNetEvent("np-vehicles:setGarage")
AddEventHandler("np-vehicles:setGarage", function(pGarage, pVar, pValue, pEdit)
    if pEdit then
        Garages[pGarage][pVar] = pValue
    else
        Garages[pGarage] = pVar
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(2000)

    Garages = RPC.execute("np-vehicles:requestGarages")
end)