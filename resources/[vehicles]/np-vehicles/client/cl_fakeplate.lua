--[[

    Variables

]]

DecorRegister("Vehicle-Fakeplate", 2)


--[[

    Events

]]

AddEventHandler("vehicle:addFakePlate", function()
    local vehicle = nil

    local target = exports["np-target"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local vid = GetVehicleIdentifier(vehicle)
    if not vid then return end

    local plate = RPC.execute("np-vehicles:addFakePlate", vid)
    if plate then
        SetVehiclePlate(vehicle, plate)
        Sync.DecorSetBool(vehicle, "Vehicle-Fakeplate", true)
    end
end)

AddEventHandler("vehicle:removeFakePlate", function()
    local vehicle = nil

    local target = exports["np-target"]:GetCurrentEntity()
    if DoesEntityExist(target) and GetEntityType(target) == 2 and #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(target)) < 5 then
        vehicle = target
    end

    if not vehicle then return end

    local vid = GetVehicleIdentifier(vehicle)
    if not vid then return end

    local plate = RPC.execute("np-vehicles:removeFakePlate", vid)
    if plate then
        SetVehiclePlate(vehicle, plate)
        Sync.DecorSetBool(vehicle, "Vehicle-Fakeplate", false)
    end
end)