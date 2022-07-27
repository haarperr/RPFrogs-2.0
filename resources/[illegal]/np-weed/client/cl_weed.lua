--[[

    Variables

]]

local weedPlants = {}
local activeZones = {}
local inZone = false

--[[

    Functions

]]

function addPlant(pPlant)
    exports["np-polyzone"]:AddCircleZone("np-weed:plant", pPlant.coords, 50, {
        --debugPoly = true,
        data = pPlant,
    })

    weedPlants[pPlant.id] = pPlant
end

function createWeedStageAtCoords(pStage, pCoords)
    local model = PlantConfig.GrowthObjects[pStage].hash
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local plantObject = CreateObject(model, pCoords.x, pCoords.y, pCoords.z + PlantConfig.GrowthObjects[pStage].zOffset, 0, 0, 0)
    FreezeEntityPosition(plantObject, true)
    -- SetEntityHeading(plantObject, math.random(0, 360) + 0.0)
    return plantObject
end

function getStageFromPercent(pPercent)
    local growthObjects = #PlantConfig.GrowthObjects - 1
    local percentPerStage = 100 / growthObjects
    return math.floor((pPercent / percentPerStage) + 1.5)
end

function getPlantGrowthPercent(pPlant)
    local timeDiff = (GetCloudTimeAsInt() - pPlant.timestamp) / 60
    local genderFactor = (pPlant.gender == 1 and PlantConfig.MaleFactor or 1)
    local fertilizerFactor = pPlant.strain.n >= 0.9 and PlantConfig.FertilizerFactor or 1.0
    local growthFactors = (PlantConfig.GrowthTime * genderFactor * fertilizerFactor)
    return math.min((timeDiff / growthFactors) * 100, 100.0)
end

function playPourAnimation()
    RequestAnimDict("weapon@w_sp_jerrycan")
    while (not HasAnimDictLoaded("weapon@w_sp_jerrycan")) do
        Wait(0)
    end
    TaskPlayAnim(PlayerPedId(),"weapon@w_sp_jerrycan","fire",2.0, -8, -1,49, 0, 0, 0, 0)
end

function showPlantMenu(pPlantId)
    local plant = weedPlants[pPlantId]
    local growth = getPlantGrowthPercent(plant)
    local water = plant.strain.water * 100.0
    local myjob = exports["np-base"]:getChar("job")
    local context = {}

    context[#context+1] = {
        title = "Growth: " .. string.format("%.2f", growth) .. "%",
        description = "Sex: " .. (plant.gender == 1 and "Male" or "Female"),
    }

    local disableActions = growth >= PlantConfig.HarvestPercent

    --Only allow adding water/fertilzier before harvest time
    context[#context+1] = {
        title = "Add Water",
        description = "Water: " .. string.format("%.2f", water) .. "%",
        action = "np-weed:addWater",
        params = { id = pPlantId },
        disabled = water >= 100.0 or not exports["np-inventory"]:hasEnoughOfItem("water", 1, false),
    }

    context[#context+1] = {
        title  = "Add Fertilizer",
        children = {
            {
                title = "Add Fertilizer (N)",
                action = "np-weed:addFertilizer",
                params = { id = pPlantId, type = "n" },
            },
            {
                title = "Add Fertilizer (P)",
                action = "np-weed:addFertilizer",
                params = { id = pPlantId, type = "p" },
            },
            {
                title = "Add Fertilizer (K)",
                action = "np-weed:addFertilizer",
                params = { id = pPlantId, type = "k" },
            }
        },
        disabled = not exports["np-inventory"]:hasEnoughOfItem("fertilizer", 1, false) or disableActions,
    }

    --Only allow changing gender in the first 2~ stages
    if getStageFromPercent(growth) < 3 and plant.gender == 0 then
        context[#context+1] = {
            title = "Add Male Seed",
            description = "Breed The Plants",
            action = "np-weed:addMaleSeed",
            params = { id = pPlantId },
            disabled = not exports["np-inventory"]:hasEnoughOfItem("maleseed", 1, false),
        }
    end

    if growth >= 95 or exports["np-jobs"]:getJob(myjob, "is_police") or myjob == "judge" then
        context[#context+1] = {
            title = "Destroy Plant",
            action = "np-weed:removePlant",
            params = { id = pPlantId },
        }
    end

    exports["np-context"]:showContext(context)
end

--[[

    Events

]]

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for id, plant in pairs(activeZones) do
        DeleteObject(plant)
    end
end)

AddEventHandler("np-polyzone:enter", function(zone, data)
    if zone == "np-weed:area" then
        inZone = true
    elseif zone == "np-weed:plant" then
        if activeZones[data.id] == nil then
            local plantGrowth = getPlantGrowthPercent(data)
            local curStage = getStageFromPercent(plantGrowth)
            local object = createWeedStageAtCoords(curStage, data.coords)
            if weedPlants[data.id] then
                weedPlants[data.id]["stage"] = curStage
                activeZones[data.id] = object
            end
        end
    end
end)

AddEventHandler("np-polyzone:exit", function(zone, data)
    if zone == "np-weed:area" then
        inZone = false
    elseif zone == "np-weed:plant" then
        if activeZones[data.id] ~= nil then
            DeleteObject(activeZones[data.id])
            activeZones[data.id] = nil
        end
    end
end)

AddEventHandler("np-inventory:itemUsed", function(item)
    if item == "femaleseed" then
        if inZone == true then
            local plyCoords = GetEntityCoords(PlayerPedId())
            local offsetCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 0.7, 0)
            local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(offsetCoords.x, offsetCoords.y, offsetCoords.z, offsetCoords.x, offsetCoords.y, offsetCoords.z - 2, 1, 0, 4)
            local retval, hit, endCoords, _, materialHash, _ = GetShapeTestResultIncludingMaterial(rayHandle)
            if hit then
                local foundHash = false
                for matHash,matType in pairs(MaterialHashes) do
                    if materialHash == matHash then
                        local typeMod = PlantConfig.TypeModifiers[matType]
                        foundHash = true
                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
                        local finished = exports["np-taskbar"]:taskBar(3000, "Planting Seed", false, true, false, false, nil, 5.0, PlayerPedId())
                        ClearPedTasks(PlayerPedId())
                        if finished == 100 then
                            RPC.execute("np-weed:plantSeed", endCoords, typeMod)
                            TriggerEvent("inventory:removeItem", item, 1)
                        end
                    end
                end
                if not foundHash then
                    TriggerEvent("DoLongHudText", "I need to find better soil to plant.", 2)
                end
            end
        else
            TriggerEvent("DoLongHudText", "I need to find a better area to plant.", 2)
        end
    end
end)

RegisterNetEvent("np-weed:trigger_zone", function (type, pData)
    --New plant being added
    if type == 1 then
        addPlant(pData)
    end

    --Plant being harvested/updated
    if type == 2 then
        weedPlants[pData.id] = pData

        if activeZones[pData.id] ~= nil then
            local plantGrowth = getPlantGrowthPercent(pData)
            local curStage = getStageFromPercent(plantGrowth)
            local object = createWeedStageAtCoords(curStage, pData.coords)
            DeleteObject(activeZones[pData.id])
            activeZones[pData.id] = object
        end
    end

    --Plant being removed
    if type == 3 then
        if activeZones[pData.id] ~= nil then
            DeleteObject(activeZones[pData.id])
            activeZones[pData.id] = nil
        end

        weedPlants[pData.id] = nil
    end
end)

AddEventHandler("np-weed:checkPlant", function(pContext, pEntity)
    local plantId = false

    for id, plant in pairs(activeZones) do
        if pEntity == plant then
            plantId = id
            break
        end
    end

    if not plantId then return end

    showPlantMenu(plantId)
end)

AddEventHandler("np-weed:addWater", function (pParams)
    if not exports["np-inventory"]:hasEnoughOfItem("water", 1, true, true) then return end

    playPourAnimation()
    local finished = exports["np-taskbar"]:taskBar(2000, "Adding Water", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local success = RPC.execute("np-weed:addWater", pParams.id)
        if not success then
            TriggerEvent("DoLongHudText", "Could not add water.", 2)
        else
            TriggerEvent("inventory:removeItem", "water", 1)
        end
    end
    showPlantMenu(pParams.id)
end)

AddEventHandler("np-weed:addFertilizer", function (pParams)
    if not exports["np-inventory"]:hasEnoughOfItem("fertilizer", 1, true, true) then return end

    playPourAnimation()
    local finished = exports["np-taskbar"]:taskBar(2000, "Adding Fertilizer", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local success = RPC.execute("np-weed:addFertilizer", pParams.id, pParams.type)
        if not success then
            TriggerEvent("DoLongHudText", "Unable to Add Fertilizer.")
        else
            TriggerEvent("inventory:removeItem", "fertilizer", 1)
        end
    end
    showPlantMenu(pParams.id)
end)

AddEventHandler("np-weed:addMaleSeed", function (pParams)
    if not exports["np-inventory"]:hasEnoughOfItem("maleseed", 1, true, true) then return end

    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    local finished = exports["np-taskbar"]:taskBar(3000, "Adding Male Seed", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute("np-weed:addMaleSeed", pParams.id)
        TriggerEvent("inventory:removeItem", "maleseed", 1)
    end
    showPlantMenu(pParams.id)
end)

AddEventHandler("np-weed:removePlant", function (pParams)
    TriggerEvent("animation:PlayAnimation","layspike")
    local finished = exports["np-taskbar"]:taskBar(30000, "Removing Plant", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        local getFertilizer = getPlantGrowthPercent(weedPlants[pParams.id]) > 20.0
        local success = RPC.execute("np-weed:removePlant", pParams.id, getFertilizer)
        if not success then
            print("[ERROR]: Cannot remove. pid:", pParams.id)
        end
    end
end)

AddEventHandler("np-weed:pickPlant", function(pContext, pEntity)
    local plantId = false

    for id, plant in pairs(activeZones) do
        if pEntity == plant then
            plantId = id
            break
        end
    end

    if not plantId then return end

    local plant = weedPlants[plantId]
    if getPlantGrowthPercent(plant) < PlantConfig.HarvestPercent then
        TriggerEvent("DoLongHudText", "This plant is not ready yet..", 2)
        return
    end

    local timeSinceHarvest = GetCloudTimeAsInt() - plant.last_harvest
    if timeSinceHarvest <= (PlantConfig.TimeBetweenHarvest * 60) then
        TriggerEvent("DoLongHudText", "This plant has been harvested recently! Better come back later to try to harvest again.", 2)
        return
    end

    local plyWeight = exports["np-inventory"]:getCurrentWeight()
    if plyWeight + 35.0 > 250.0 and plant.gender == 0 then
        TriggerEvent("DoLongHudText", "You wouldnt be able to carry all that!", 2)
        return
    end

    TriggerEvent("animation:PlayAnimation", "layspike")
    local finished = exports["np-taskbar"]:taskBar(10000, "Harvesting Plant", false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute("np-weed:harvestPlant", plantId)
    end
end)

--[[

    Threads

]]

--Creates da weed
--TODO: cache close plants
Citizen.CreateThread(function()
    exports["np-polyzone"]:AddPolyZone("np-weed:area", {
        vector2(-342.00247192383, -1253.5378417969),
        vector2(84.262420654297, -1242.6663818359),
        vector2(520.96197509766, -1240.0241699219),
        vector2(1258.8310546875, -1228.4302978516),
        vector2(1407.0397949219, -1121.8983154297),
        vector2(1649.0086669922, -976.5205078125),
        vector2(1924.1279296875, -822.08416748047),
        vector2(2068.68359375, -1006.6109008789),
        vector2(2859.5693359375, -1742.0363769531),
        vector2(2648.7900390625, -2252.2673339844),
        vector2(1814.0902099609, -2787.0224609375),
        vector2(1344.9066162109, -2808.6821289062),
        vector2(1001.0428466797, -2734.3996582031),
        vector2(618.41564941406, -2574.2868652344),
        vector2(388.52581787109, -2406.0385742188),
        vector2(66.28978729248, -2305.4445800781),
        vector2(31.951961517334, -2045.0936279297),
        vector2(-192.29954528809, -1838.7125244141),
        vector2(-405.87139892578, -1651.3764648438)
    }, {
        -- debugGrid = true,
        gridDivisions = 25,
        minZ = 10.0,
        maxZ = 500.0,
    })

    Citizen.Wait(1000)

    local _plants = RPC.execute("np-weed:getPlants")
    for idx, plant in pairs(_plants) do
        addPlant(plant)
    end
end)