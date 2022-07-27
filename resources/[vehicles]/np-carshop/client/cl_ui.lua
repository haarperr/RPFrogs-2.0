--[[

    Variables

]]

inTheShop = false

local lastSelectedVehicleEntity
local vehiclesTable = {}
local shopWorker = false

--[[

    Functions

]]

local function getVehiclesTable(shop)
    local _vehicles = RPC.execute("np-carshop:getVehicles", shop)

    local categorys = {}
    for i, v in ipairs(_vehicles) do
        if not has_value(categorys, v.category) then
            table.insert(categorys, v.category)
        end
    end

    local tempTable = {}
    for i, v in ipairs(categorys) do
        tempTable[v] = {}
    end

    for i, v in ipairs(_vehicles) do
        local brandName = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, GetHashKey(v.model), Citizen.ResultAsString()))
        if brandName == "NULL" then
            brandName = "Custom"
        end

        local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(v.model))
        if vehicleName == "NULL" then
            vehicleName = GetDisplayNameFromVehicleModel(v.model)
        end

        local provisoryObject = {
            brand = brandName,
            name = vehicleName,
            price = v.price,
            model = v.model,
            qtd = v.stock
        }

        table.insert(tempTable[v.category], provisoryObject)
    end

    vehiclesTable = {}

    for k, v in pairs(tempTable) do
        local _temp = {}

        for k2, v2 in spairs(v, function(t, a, b) return t[a].name < t[b].name end) do
            table.insert(_temp, v2)
        end

        vehiclesTable[k] = _temp
    end

    return categorys
end

function OpenCarShop(shop, worker)
    inTheShop = true

    exports["np-interaction"]:hideInteraction()

    shopWorker = worker

    local categorys = getVehiclesTable(shop)

    SendNUIMessage({
        type = "display",
        showBuy = shopWorker,
        categorys = categorys,
    })

    SetNuiFocus(true, true)

    RequestCollisionAtCoord(x, y, z)

    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 974.1, -2997.94, -39.00, 216.5, 0.00, 0.00, 60.00, false, 0)
    PointCamAtCoord(cam, 979.1, -3003.00, -40.50)

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1, true, true)

    SetFocusPosAndVel(974.1, -2997.94, -39.72, 0.0, 0.0, 0.0)
end

local function updateSelectedVehicle(model)
    local hash = GetHashKey(model)

    if not HasModelLoaded(hash) then
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(10)
        end
    end

    if lastSelectedVehicleEntity ~= nil then
        DeleteEntity(lastSelectedVehicleEntity)
    end

    lastSelectedVehicleEntity = CreateVehicle(hash, 978.19, -3001.99, -40.62, 89.5, false, false)

    local vehicleData = {}

    vehicleData.traction = GetVehicleMaxTraction(lastSelectedVehicleEntity)

    vehicleData.breaking = GetVehicleMaxBraking(lastSelectedVehicleEntity) * 0.9650553
    if vehicleData.breaking >= 1.0 then
        vehicleData.breaking = 1.0
    end

    vehicleData.maxSpeed = GetVehicleEstimatedMaxSpeed(lastSelectedVehicleEntity) * 0.9650553
    if vehicleData.maxSpeed >= 50.0 then
        vehicleData.maxSpeed = 50.0
    end

    vehicleData.acceleration = GetVehicleAcceleration(lastSelectedVehicleEntity) * 2.6
    if  vehicleData.acceleration >= 1.0 then
        vehicleData.acceleration = 1.0
    end

    SendNUIMessage({
        data = vehicleData,
        type = "updateVehicleInfos",
    })

    SetEntityHeading(lastSelectedVehicleEntity, 89.5)
end

local function rotation(dir)
    local entityRot = GetEntityHeading(lastSelectedVehicleEntity) + dir
    SetEntityHeading(lastSelectedVehicleEntity, entityRot % 360)
end

local function CloseNui()
    SendNUIMessage({
        type = "hide"
    })

    SetNuiFocus(false, false)

    if inTheShop then
        if lastSelectedVehicleEntity ~= nil then
            DeleteVehicle(lastSelectedVehicleEntity)
        end
        RenderScriptCams(false)
        DestroyAllCams(true)
        SetFocusEntity(GetPlayerPed(PlayerId()))
    end

    inTheShop = false

    if listening then
        exports["np-interaction"]:showInteraction("[E] Catalogo")
    end
end

--[[

    NUI

]]

RegisterNUICallback("rotate", function(data, cb)
    if (data["key"] == "left") then
        rotation(2)
    else
        rotation(-2)
    end
    cb("ok")
end)

RegisterNUICallback("SpawnVehicle", function(data, cb)
    updateSelectedVehicle(data.modelcar)
end)

RegisterNUICallback("Buy", function(data, cb)
    TriggerServerEvent("np-carshop:change", exports["np-base"]:getVar("carshop"), currentVehicle, data.modelcar)
    CloseNui()
end)

RegisterNUICallback("menuSelected", function(data, cb)
    local categoryVehicles

    if data.menuId ~= "all" then
        categoryVehicles = vehiclesTable[data.menuId]
    else
        SendNUIMessage({
            type = "display",
            data = vehiclesTable,
            showBuy = shopWorker
        })

        return
    end

    SendNUIMessage({
        type = "menu",
        data = categoryVehicles
    })
end)

RegisterNUICallback("Close", function(data, cb)
    CloseNui()
end)