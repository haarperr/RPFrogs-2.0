--[[

    Variables

]]

DecorRegister("Vehicle-Harness", 3)

local currentVehicle = 0
local wearingSeatbelt = false
local wearingHarness = false
local isInsideVehicle = 0
local lastAlert = GetGameTimer()

--[[

    Functions

]]

function isDriver()
    return GetPedInVehicleSeat(currentVehicle, -1) == PlayerPedId()
end

function toggleSeatbelt()
    isInsideVehicle = currentVehicle ~= 0

    if isInsideVehicle then
        local harnessLevel = GetVehicleMetadata(currentVehicle, "harness") or 0
        local hasHarness = harnessLevel > 0

        if wearingSeatbelt and not wearingHarness then -- Wearing seatbelt but no harness, taking off
            TriggerEvent("InteractSound_CL:PlayOnOne", "seatbeltoff", 0.7)
            wearingSeatbelt = false
            SetFlyThroughWindscreenParams(10.0, 1.0, 1.0, 1.0)
        elseif wearingSeatbelt and wearingHarness and isDriver() then -- Wearing seatbelt/harness, taking off
            toggleHarness(false)
        elseif not wearingSeatbelt and not wearingSeatbelt and isDriver() and hasHarness then -- Not wearing anything and have harness
            toggleHarness(true)
        elseif not wearingSeatbelt and not wearingHarness then
            TriggerEvent("InteractSound_CL:PlayOnOne", "seatbelt", 0.7) -- Not wearing anything and have no harness
            wearingSeatbelt = true
            SetFlyThroughWindscreenParams(45.0, 1.0, 1.0, 1.0)
        end

        TriggerEvent("harness", wearingHarness, GetVehicleMetadata(currentVehicle, "harness"))
        TriggerEvent("seatbelt", wearingSeatbelt)
    end
end

function toggleHarness(pState)
    local defaultSteering = GetVehicleHandlingFloat(currentVehicle, "CHandlingData", "fSteeringLock")
    toggleTurning(currentVehicle, false, defaultSteering)
    local harnessTimer = exports["np-taskbar"]:taskBar(5000, (pState and "Putting on Harness" or "Taking off Harness"), true)

    if harnessTimer == 100 then
        wearingHarness = pState
        wearingSeatbelt = pState
        TriggerEvent("InteractSound_CL:PlayOnOne", (pState and "seatbelt" or "seatbeltoff"), 0.7)
    end

    toggleTurning(currentVehicle, true, defaultSteering)
end

function IsUsingNitro() -- tried to fix the error for seatbelts lol
   return exports['np-vehicles']:IsUsingNitro()
end

function toggleTurning(pVehicle, pToggle, pDefaultHandlingValue)
    if pVehicle ~= 0 then
        SetVehicleHandlingFloat(pVehicle, "CHandlingData", "fSteeringLock", (pToggle and pDefaultHandlingValue or (pDefaultHandlingValue / 4)))
    end
end

function EjectLUL(pVehicle, pVelocity)
    local coords = GetOffsetFromEntityInWorldCoords(pVehicle, 1.0, 0.0, 1.0)

    SetEntityCoords(PlayerPedId(), coords)

    Citizen.Wait(1)

    SetPedToRagdoll(PlayerPedId(), 5511, 5511, 0, 0, 0, 0)
    SetEntityVelocity(PlayerPedId(), pVelocity["x"] * 4, pVelocity["y"] * 4, pVelocity["z"] * 4)

    local ejectspeed = math.ceil(GetEntitySpeed(PlayerPedId()) * 8)
    if IsPedWearingHelmet(PlayerPedId()) and IsThisModelABicycle(GetEntityModel(veh)) then
        local damageAmount = GetEntityHealth(PlayerPedId()) - 1
        if damageAmount > ejectspeed then
            damageAmount = ejectspeed
        end

        SetEntityHealth(PlayerPedId(), GetEntityHealth(PlayerPedId()) - damageAmount)

        return
    end

    SetEntityHealth(PlayerPedId(), (GetEntityHealth(PlayerPedId()) - ejectspeed) )
end

--[[

    Events

]]

AddEventHandler("vehicle:addHarness", function(type)
    local vehicle = GetVehiclePedIsUsing(PlayerPedId())
    if not vehicle or not DoesEntityExist(vehicle) then return end

    Sync.DecorSetInt(vehicle, "Vehicle-Harness", 100)

    local vid = GetVehicleIdentifier(vehicle)
    if not vid then return end

    RPC.execute("np-vehicles:updateVehicle", vid, "metadata", "harness", 100)
end)

AddEventHandler("baseevents:enteredVehicle", function(pCurrentVehicle, currentSeat, vehicleDisplayName)
    currentVehicle = pCurrentVehicle

    TriggerEvent("harness", wearingHarness, GetVehicleMetadata(pCurrentVehicle, "harness"))
end)

AddEventHandler("baseevents:leftVehicle", function(pCurrentVehicle, pCurrentSeat, vehicleDisplayName)
    wearingHarness = false
    wearingSeatbelt = false
    currentVehicle = 0

    TriggerEvent("harness", false, 0)
    TriggerEvent("seatbelt", false)
end)

AddEventHandler("baseevents:vehicleChangedSeat", function(pCurrentVehicle, pCurrentSeat, previousSeat)
    wearingHarness = false
    wearingSeatbelt = false

    if pCurrentSeat == -1 then
        TriggerEvent("harness", wearingHarness, GetVehicleMetadata(pCurrentVehicle, "harness"))
    else
        TriggerEvent("harness", false, 0)
    end

    TriggerEvent("seatbelt", wearingSeatbelt)
end)

AddEventHandler("baseevents:vehicleCrashed", function(pCurrentVehicle, pCurrentSeat, pCurrentSpeed, pPreviousSpeed, pVelocity, pImpactDamage, pHeavyImpact, pLightImpact)
    local beltChange = 0.0
    local engineDamage = 0.0

    if pImpactDamage > 70 then
        engineDamage = 150 + pImpactDamage

        if pImpactDamage > 100 then
            pImpactDamage = 100
        end

        beltChange = wearingSeatbelt and math.floor(pImpactDamage / 3) or pImpactDamage
    end

    local ejectLUL = false
    if math.random(150) < beltChange then
        ejectLUL = true
    end

    local wasJump = pVelocity.z <= -25

    if ejectLUL and wearingHarness then
        local harnessLevel = GetVehicleMetadata(pCurrentVehicle, "harness") or 0

        local newLevel = harnessLevel - 10
        if newLevel < 1 then
            newLevel = 0

            wearingHarness = false
            wearingSeatbelt = false

            TriggerEvent("seatbelt", wearingSeatbelt)

            TriggerEvent("DoLongHudText", "Harness Broken!", 2)
        end

        Sync.DecorSetInt(pCurrentVehicle, "Vehicle-Harness", newLevel)
        TriggerEvent("harness", wearingHarness, GetVehicleMetadata(pCurrentVehicle, "harness"))

        local vid = GetVehicleIdentifier(currentVehicle)
        if vid then
            RPC.execute("np-vehicles:updateVehicle", vid, "metadata", "harness", newLevel)
        end
    elseif ejectLUL and not wasJump then
        EjectLUL(pCurrentVehicle, pVelocity)
    end

    if pCurrentSeat ~= -1 then return end

    if ejectLUL and not wasJump and GetGameTimer() > lastAlert then
        lastAlert = GetGameTimer() + 60000
        TriggerEvent("civilian:alertPolice", 50.0, "carcrash", 0)
    end

    local engineHealth = GetVehicleEngineHealth(pCurrentVehicle)
    local bodyHealth = GetVehicleBodyHealth(pCurrentVehicle)
    local speedDamage = (pPreviousSpeed - pCurrentSpeed) * 4

    local damage = engineHealth - engineDamage

    if type(damage) ~= "number" then return end

    if damage < 150 or bodyHealth < 100 then
        damage = 150
        SetVehicleUndriveable(pCurrentVehicle, true)
        SetVehicleEngineOn(pCurrentVehicle, false, true, true)
    end

    SetVehicleEngineHealth(pCurrentVehicle, damage)

    if speedDamage < 5 or (type(engineDamage) ~= "number" and math.random(0, 1) ~= 1) then return end

    TriggerEvent("np-vehicles:randomDegredation", pCurrentVehicle, 15, 10)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "Vehicle", "Seatbelt", "+toggleSeatbelt", "-toggleSeatbelt", "B")
    RegisterCommand("+toggleSeatbelt", toggleSeatbelt, false)
    RegisterCommand("-toggleSeatbelt", function() end, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if currentVehicle ~= 0 then
            if wearingHarness then
                DisableControlAction(0, 75, true)
                if IsDisabledControlJustPressed(1, 75) then
                    TriggerEvent("DoLongHudText", "You probably should undo your harness...", 101)
                end
        
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(5000)
        end
    end
end)