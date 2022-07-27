--[[

    Variables

]]

local doors = {}
local currentDoorCoords, currentDoorId, currentDoorLockState, currentZone = vector3(0, 0, 0), nil, nil, nil
local listening = false

local bollards = {
    mrpd_bollards_01 = {
        doorId = 1001,
        inside = false
    },
    mrpd_bollards_02 = {
        doorId = 1002,
        inside = false
    },
}

local Throttles = {}

--[[

    Functions

]]

function GetTargetDoorId(pEntity)
    local activeDoors = DoorSystemGetActive()

    for _, activeDoor in pairs(activeDoors) do
        if activeDoor[2] == pEntity then
            return activeDoor[1]
        end
    end
end

local function listenForKeypress()
    listening = true
    Citizen.CreateThread(function()

        local newDoorId, newLockState = currentDoorId

        currentDoorLockState = (DoorSystemGetDoorState(currentDoorId) ~= 0 and true or false)

        local hasAccess = hasSecuredAccess(currentDoorId, "door")

        local isHidden = doors[currentDoorId] and doors[currentDoorId].hidden or false

        if not hasAccess and currentDoorLockState and not isHidden then
            exports["np-interaction"]:showInteraction("Locked", "error")
        end

        while listening do
            local idle = 0

            if currentDoorId ~= newDoorId then
                currentDoorLockState = (DoorSystemGetDoorState(currentDoorId) ~= 0 and true or false)
                newDoorId = currentDoorId
            end

            if currentDoorLockState ~= newLockState then
                if #(GetOffsetFromEntityGivenWorldCoords(PlayerPedId(), currentDoorCoords)) <= 1.2 then
                    newLockState = currentDoorLockState
                    if hasAccess and not isHidden then
                        exports["np-interaction"]:showInteraction(("[E] %s"):format(newLockState and "Locked" or "Unlocked"), newLockState and "error" or "success")
                    else
                    end
                else
                    idle = 100
                end
            end

            if currentDoorId ~= nil and hasAccess and IsControlJustReleased(0, 38) and #(GetOffsetFromEntityGivenWorldCoords(PlayerPedId(), currentDoorCoords)) <= 1.2 then
                loadAnimDict("anim@heists@keycard@")
                TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 48, 0, 0, 0, 0)
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "keydoors", 0.4)
                TriggerServerEvent("np-doors:change-lock-state", currentDoorId, not currentDoorLockState)
            end

            Wait(idle)
        end

        exports["np-interaction"]:hideInteraction((not hasAccess or newLockState) and "error" or "success")
    end)
end

function AllowsKeyFob(pDoorId)
    if not doors[pDoorId] then return false end

    return doors[pDoorId]["keyFob"] == true
end

function Throttled(name, time)
    if not Throttles[name] then
        Throttles[name] = true
        Citizen.SetTimeout(time or 500, function() Throttles[name] = false end)
        return false
    end

    return true
end

--[[

    Exports

]]

exports("GetTargetDoorId", GetTargetDoorId)

--[[

    Events

]]

RegisterNetEvent("np-doors:initial-lock-state")
AddEventHandler("np-doors:initial-lock-state", function(pDoors)
    doors = pDoors

    setSecuredAccesses(doors, "door")

    for doorId, door in pairs(doors) do
        if door.active and not IsDoorRegisteredWithSystem(doorId) then
            AddDoorToSystem(doorId, door.model, door.coords, false, false, false)
            if door.automatic then
                if door.automatic.distance then
                    DoorSystemSetAutomaticDistance(doorId, door.automatic.distance, 0, 1)
                end
                if door.automatic.rate then
                    DoorSystemSetAutomaticRate(doorId, door.automatic.rate, 0, 1)
                end
            end
            DoorSystemSetDoorState(doorId, door.lock, 0, 1)
        end
    end
end)

RegisterNetEvent("np-doors:change-lock-state")
AddEventHandler("np-doors:change-lock-state", function(pDoorId, pDoorLockState, pDoorForceUnlock)
    if doors and doors[pDoorId] then
        doors[pDoorId].lock = pDoorLockState
        doors[pDoorId].forceUnlocked = pDoorForceUnlock
        DoorSystemSetAutomaticRate(pDoorId, 1.0, 0, 0)
        DoorSystemSetDoorState(pDoorId, pDoorLockState, 0, 1)
        if pDoorId == currentDoorId then
            currentDoorLockState = pDoorLockState
        end
    end
end)

AddEventHandler("np-doors:doorKeyFob", function()
    local doorId, isBollard = -1, false

    if currentZone ~= nil and bollards[currentZone].inside then
        doorId = bollards[currentZone].doorId
        isBollard = true
    else
        local entity = exports["np-target"]:GetEntityPlayerIsLookingAt(10.0, 2.0, 16)

        if not entity then
            return TriggerEvent("DoLongHudText","Door Not Found.",2)
        end

        if printEntityDetails then
            print(entity, GetEntityType(entity), GetEntityCoords(entity), GetEntityModel(entity), GetEntityCoords(entity))
        end

        doorId = GetTargetDoorId(entity)

        if printEntityDetails then
            print(doorId)
        end
    end


    if not doorId then
        return TriggerEvent("DoLongHudText","Door Not Found.",2)
    end

    if (not hasSecuredAccess(doorId, "door") or not AllowsKeyFob(doorId)) then
        PlaySoundFromEntity(-1, "Keycard_Fail", PlayerPedId(), "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 1, 5.0);
        return TriggerEvent("DoLongHudText", "Keys don't work on this door",2)
    end

    local isLocked = (DoorSystemGetDoorState(doorId) ~= 0 and true or false)
    PlaySoundFromEntity(-1, "Keycard_Success", PlayerPedId(), "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 1, 5.0);

    TriggerServerEvent("np-doors:change-lock-state", doorId, isBollard and (not isLocked and 6 or 0) or (not isLocked))
end)

AddEventHandler("np:target:changed", function(pEntity, pEntityType, pEntityCoords)
    if pEntityType == nil or pEntityType ~= 3 then
        listening, currentDoorCoords, currentDoorId, currentDoorLockState = nil
        return
    end

    if printEntityDetails then
        print(pEntity, pEntityType, pEntityCoords, GetEntityModel(pEntity), GetEntityCoords(pEntity))
    end

    local doorId = GetTargetDoorId(pEntity)

    if printEntityDetails then
        print(doorId)
    end

    if (doorId) then
        currentDoorId = doorId
        currentDoorCoords = pEntityCoords

        if not listening then
            listenForKeypress()
        end
    end
end)

AddEventHandler("np-polyzone:enter", function(zone, data)
    if zone == "mrpd_bollards_01" or zone == "mrpd_bollards_02" then
        bollards[zone].inside = true
        currentZone = zone
    end
end)

AddEventHandler("np-polyzone:exit", function(zone)
    if zone == "mrpd_bollards_01" or zone == "mrpd_bollards_02" then
        bollards[zone].inside = false
        currentZone = nil
    end
end)

RegisterNetEvent("dooranim")
AddEventHandler("dooranim", function()
    ClearPedSecondaryTask(PlayerPedId())
    loadAnimDict("anim@heists@keycard@")
    TaskPlayAnim(PlayerPedId(), "anim@heists@keycard@", "exit", 8.0, 1.0, -1, 16, 0, 0, 0, 0)
    Citizen.Wait(850)
    ClearPedTasks(PlayerPedId())
end)

--[[

    Commands

]]

RegisterCommand("+useKeyFob", function()
    if Throttled("np-doors:doorKeyFob", 1000) then return end
    TriggerEvent("np-doors:doorKeyFob")
end, false)
RegisterCommand("-useKeyFob", function() end, false)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "Vehicle", "Door Keyfob", "+useKeyFob", "-useKeyFob", "Y")

    exports["np-polyzone"]:AddBoxZone("mrpd_bollards_01", vector3(411.66, -1027.95, 29.24), 7.8, 23.4, {
        heading=0,
        minZ=28.14,
        maxZ=32.14
    })
    exports["np-polyzone"]:AddBoxZone("mrpd_bollards_02", vector3(411.66, -1020.09, 29.34), 7.8, 23.4, {
        heading=0,
        minZ=28.14,
        maxZ=32.14
    })
end)

--[[

    Debug

]]

-- local printEntityDetails = false

-- RegisterCommand("doors:print-entity", function()
--     printEntityDetails = not printEntityDetails
-- end)

RegisterNetEvent("np-doors:add")
AddEventHandler("np-doors:add", function()
    local pEntity = exports["np-target"]:GetEntityPlayerIsLookingAt(10.0, 2.0, 16)
    local pEntityType = GetEntityType(pEntity)

    if pEntity == nil or pEntityType ~= 3 then
        TriggerEvent("DoLongHudText", "Door Not Found.", 2)
        return
    end

    TriggerServerEvent("np-door:add", GetEntityCoords(pEntity), GetEntityModel(pEntity))
end)

-- -- GetUserInput function inspired by vMenu (https://github.com/TomGrobbe/vMenu/blob/master/vMenu/CommonFunctions.cs)
-- function GetUserInput(windowTitle, defaultText, maxInputLength)
--     -- Create the window title string.
--     local resourceName = string.upper(GetCurrentResourceName())
--     local textEntry = resourceName .. "_WINDOW_TITLE"
--     if windowTitle == nil then
--       windowTitle = "Enter:"
--     end
--     AddTextEntry(textEntry, windowTitle)

--     -- Display the input box.
--     DisplayOnscreenKeyboard(1, textEntry, "", defaultText or "", "", "", "", maxInputLength or 30)
--     Wait(0)
--     -- Wait for a result.
--     while true do
--       local keyboardStatus = UpdateOnscreenKeyboard();
--       if keyboardStatus == 3 then -- not displaying input field anymore somehow
--         return nil
--       elseif keyboardStatus == 2 then -- cancelled
--         return nil
--       elseif keyboardStatus == 1 then -- finished editing
--         return GetOnscreenKeyboardResult()
--       else
--         Wait(0)
--       end
--     end
-- end

-- local doorIndex = 0
-- local doorsCache = {}

-- RegisterCommand("door-next", function()
--     doorIndex = doorIndex + 1
--     local door = doors[doorIndex]
--     doorsCache[doorIndex] = door
--     doorsCache[doorIndex]["id"] = doorIndex
--     doorsCache[doorIndex]["access"] = {
--         job = { "PD" },
--         business = {},
--     }
--     doorsCache[doorIndex]["forceOpened"] = false
--     SetEntityCoords(PlayerPedId(), door.coords)

--     Wait(1000)
--     doorsCache[doorIndex]["desc"] = GetUserInput("Desc")
--     Wait(0)
--     doorsCache[doorIndex]["access"]["job"][#doorsCache[doorIndex]["access"]["job"] + 1] = GetUserInput("Job")
--     Wait(0)
--     doorsCache[doorIndex]["access"]["business"][#doorsCache[doorIndex]["access"]["business"] + 1] = GetUserInput("Business")
-- end)

-- -- RegisterCommand("door-desc", function(s, args)
-- --     doorsCache[doorIndex]["desc"] = args[1]
-- -- end)
-- -- RegisterCommand("door-business", function(s, args)
-- --     doorsCache[doorIndex]["access"]["business"][#doorsCache[doorIndex]["access"]["business"] + 1] = args[1]
-- -- end)
-- -- RegisterCommand("door-job", function(s, args)
-- --     doorsCache[doorIndex]["access"]["job"][#doorsCache[doorIndex]["access"]["job"] + 1] = args[1]
-- -- end)

-- RegisterCommand("door-print", function()
--     print(json.encode(doorsCache, { indent = true }))
-- end)

-- RegisterCommand("doors-save", function()
--     TriggerServerEvent("np-doors:save-config", doorsCache)
-- end)