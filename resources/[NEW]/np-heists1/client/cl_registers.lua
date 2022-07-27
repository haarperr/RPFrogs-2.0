--[[

    Variables

]]

local currentTarget = nil
local currentTargetCoords = nil
local skilling = false
local insideSouthSide = false

--[[

    Functions

]]

local function breakInToRegister()
    skilling = true

    local registerId = string.format("%.2f", currentTargetCoords.x) .. "_" .. string.format("%.2f", currentTargetCoords.y) .. "_" .. string.format("%.2f", currentTargetCoords.z)

    local message = RPC.execute("np-heists:canRobRegister", registerId)
    if message ~= nil then
        TriggerEvent("DoLongHudText", message, 2)
        skilling = false
        return
    end

    TriggerEvent("alert:storeRobbery")

    RequestAnimDict("oddjobs@shop_robbery@rob_till")
    while not HasAnimDictLoaded("oddjobs@shop_robbery@rob_till") do
        Citizen.Wait(0)
    end

    ClearPedTasksImmediately(PlayerPedId())
    TaskTurnPedToFaceEntity(PlayerPedId(), currentTarget, -1)
    TaskPlayAnim(PlayerPedId(), "oddjobs@shop_robbery@rob_till", "loop", 8.0, -8, -1, 1, 0, 0, 0, 0)

    local finished = exports["np-taskbar"]:taskBar(10000, "Stealing", true, false, nil, false, nil, 3)
    if finished == 100 then
        TriggerServerEvent("np-heists:complete", math.random(300, 400))
    end

    skilling = false
    ClearPedTasksImmediately(PlayerPedId())
end

--[[

    Events

]]

AddEventHandler("np-heists:breakInToRegister", function(pArgs, pEntity)
    currentTarget = pEntity
    currentTargetCoords = GetEntityCoords(pEntity)
    breakInToRegister()
end)

AddEventHandler("np-polyzone:enter", function(name, data)
    if name == "southside_register" then
        insideSouthSide = true
    end
end)

AddEventHandler("np-polyzone:exit", function(name, data)
    if name == "southside_register" then
        insideSouthSide = false
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-eye"]:AddPeekEntryByModel({ 303280717 }, {{
        event = "np-heists:breakInToRegister",
        id = "heists_breakInToRegister",
        icon = "hammer",
        label = "to break!",
        parameters = {},
    }}, {
        distance = { radius = 1.0 },
        isEnabled = function(pEntity)
            return GetObjectFragmentDamageHealth(pEntity, true) < 1.0 and not skilling and insideSouthSide
        end,
    })
end)

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddCircleZone("southside_register", vector3(76.37, -1390.35, 29.38), 3.8, {
		useZ=false,
	})

    exports["np-polyzone"]:AddCircleZone("southside_register", vector3(24.7, -1346.1, 29.5), 1.5, {
		useZ=false,
	})

    exports["np-polyzone"]:AddCircleZone("southside_register", vector3(-47.16, -1758.67, 29.42), 1.45, {
		useZ=false,
	})

    exports["np-polyzone"]:AddCircleZone("southside_register", vector3(134.16, -1708.21, 29.29), 1.0, {
		useZ=false,
	})

    exports["np-polyzone"]:AddCircleZone("southside_register", vector3(1324.91, -1650.71, 52.28), 1.0, {
		useZ=false,
	})
end)