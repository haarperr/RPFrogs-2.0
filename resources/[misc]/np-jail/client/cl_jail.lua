--[[

    Variables

]]

local insidePrison = false
local currentZone = ""
local myCell = 1
local count = 0
local jailed = false
local listening = true
local lastMessage = 0

local cells = {
    vector4(1700.19, 2463.19, 45.85, 178.13),
    vector4(1696.95, 2462.85, 45.85, 174.64),
    vector4(1689.9, 2462.71, 45.85, 179.12),
    vector4(1686.33, 2463.06, 45.85, 177.14),
    vector4(1683.03, 2462.93, 45.85, 176.67),
    vector4(1679.48, 2463.08, 45.85, 178.55),
    vector4(1675.98, 2463.01, 45.85, 178.79),
    vector4(1674.99, 2443.2, 45.84, 357.38),
    vector4(1678.56, 2442.96, 45.84, 359.5),
    vector4(1681.94, 2442.97, 45.84, 357.19),
    vector4(1685.42, 2442.87, 45.84, 357.18),
    vector4(1689.1, 2442.99, 45.84, 353.64),
    vector4(1692.38, 2443.09, 45.84, 358.19),
    vector4(1695.87, 2443.32, 45.84, 358.88),
    vector4(1699.28, 2443.15, 45.84, 358.52),
    vector4(1675.13, 2443.26, 50.45, 358.83),
    vector4(1678.56, 2442.97, 50.45, 357.66),
    vector4(1681.91, 2443.26, 50.45, 359.11),
    vector4(1685.33, 2443.18, 50.45, 358.08),
    vector4(1688.83, 2443.0, 50.45, 354.1),
    vector4(1692.55, 2443.25, 50.45, 357.08),
    vector4(1695.84, 2443.11, 50.45, 357.79),
    vector4(1699.37, 2442.91, 50.45, 354.99),
    vector4(1700.31, 2462.99, 50.46, 177.56),
    vector4(1696.82, 2462.69, 50.46, 177.14),
    vector4(1693.43, 2462.79, 50.46, 176.28),
    vector4(1689.93, 2462.91, 50.46, 176.25),
    vector4(1686.45, 2462.75, 50.46, 175.57),
    vector4(1682.9, 2462.71, 50.46, 179.14),
    vector4(1679.46, 2462.75, 50.45, 175.07),
    vector4(1675.88, 2462.85, 50.45, 177.34),

    vector4(1590.81, 2542.28, 45.99, 87.53),
    vector4(1590.76, 2545.89, 45.99, 86.74),
    vector4(1590.69, 2549.6, 45.99, 87.6),
    vector4(1590.39, 2556.78, 45.99, 89.09),
    vector4(1590.44, 2560.4, 45.99, 87.32),
    vector4(1590.68, 2564.04, 45.99, 86.42),
    vector4(1570.65, 2564.66, 45.99, 267.29),
    vector4(1570.8, 2560.95, 45.99, 269.16),
    vector4(1570.91, 2557.24, 45.99, 269.73),
    vector4(1570.86, 2553.73, 45.99, 270.16),
    vector4(1570.81, 2550.15, 45.99, 267.84),
    vector4(1571.12, 2546.46, 45.99, 270.75),
    vector4(1570.46, 2543.07, 45.99, 270.02),
    vector4(1570.51, 2543.07, 49.95, 270.74),
    vector4(1570.87, 2546.63, 49.95, 264.85),
    vector4(1571.24, 2550.1, 49.95, 271.8),
    vector4(1570.71, 2553.82, 49.95, 270.62),
    vector4(1570.78, 2557.51, 49.95, 270.2),
    vector4(1570.29, 2561.31, 49.95, 269.9),
    vector4(1570.88, 2564.67, 49.95, 265.4),
    vector4(1590.78, 2564.04, 49.95, 88.63),
    vector4(1591.11, 2560.23, 49.95, 92.54),
    vector4(1590.88, 2556.68, 49.95, 90.56),
    vector4(1590.85, 2553.05, 49.95, 89.13),
    vector4(1590.76, 2549.37, 49.95, 89.78),
    vector4(1590.8, 2545.85, 49.95, 89.57),
    vector4(1590.6, 2542.32, 49.95, 87.93),
}


--[[

    Functions

]]

function listenForKeypress()
    listening = true

    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 244) then
                if currentZone == "prison_leave" then
                    leavePrison()
                elseif currentZone == "prison_possessions" then
                    TriggerEvent("server-inventory-open", "1", "jail-" .. exports["np-base"]:getChar("id"))
                end
            end
            Wait(0)
        end
    end)
end

function IsNearPlayer(player)
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
    local ply2Coords = GetEntityCoords(ply2, 0)
    local distance = Vdist2(plyCoords, ply2Coords)
    if(distance <= 5) then
        return true
    end
end

function JailIntro(pName, pTime, pCid, pDate)
    DoScreenFadeOut(10)
    FreezeEntityPosition(PlayerPedId(), true)
    TriggerEvent("InteractSound_CL:PlayOnOne", "handcuff", 1.0)

    Citizen.Wait(1000)

    SetEntityCoords(PlayerPedId(), 472.98, -1011.18, 25.28)
    SetEntityHeading(PlayerPedId(), 180.0)

    Citizen.Wait(1500)
    DoScreenFadeIn(500)

    TriggerEvent("drawScaleformJail", pTime, pName, pCid, pDate)
    TriggerEvent("attachPropPoliceIdBoard", "prop_police_id_board", 28422, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0)

    TriggerEvent("InteractSound_CL:PlayOnOne", "photo", 0.4)
    Citizen.Wait(3000)
    TriggerEvent("InteractSound_CL:PlayOnOne", "photo", 0.4)
    Citizen.Wait(3000)
    SetEntityHeading(PlayerPedId(), 270.0)

    TriggerEvent("InteractSound_CL:PlayOnOne", "photo", 0.4)
    Citizen.Wait(3000)
    TriggerEvent("InteractSound_CL:PlayOnOne", "photo", 0.4)
    Citizen.Wait(3000)
    SetEntityHeading(PlayerPedId(), 90.0)

    TriggerEvent("InteractSound_CL:PlayOnOne", "photo", 0.4)
    Citizen.Wait(3000)
    TriggerEvent("InteractSound_CL:PlayOnOne", "photo", 0.4)
    Citizen.Wait(3000)

    SetEntityHeading(PlayerPedId(), 180.0)

    Citizen.Wait(2000)
    DoScreenFadeOut(1100)
    Citizen.Wait(2000)
    TriggerEvent("InteractSound_CL:PlayOnOne", "jaildoor", 1.0)
    TriggerEvent("destroyProp")
end

function scaleformPaste(scaleform, obj, name, years, cid, date)
    local position = GetOffsetFromEntityInWorldCoords(obj, -0.2, -0.0132 - (GetEntitySpeed(PlayerPedId()) / 50), 0.105)
    local scale = vector3(0.41, 0.23, 1.0)
    local push = GetEntityRotation(obj, 2)

    Citizen.InvokeNative(0x87D51D72255D4E78, scaleform, position, 180.0 + push["x"], 0.0 - GetEntityRoll(obj),GetEntityHeading(obj), 1.0, 0.8, 4.0, scale, 0)

    if not date then
        date = "Mugshot Board"
    end

    if not years then
        years = 0
    end

    if not name then
        name = "No Name"
    end

    PushScaleformMovieFunction(scaleform, "SET_BOARD")
    PushScaleformMovieFunctionParameterString("LOS SANTOS POLICE DEPARTMENT")
    PushScaleformMovieFunctionParameterString(date)
    PushScaleformMovieFunctionParameterString("sentenced to " .. years .. " Months")
    PushScaleformMovieFunctionParameterString(name)
    PushScaleformMovieFunctionParameterFloat(0.0)
    PushScaleformMovieFunctionParameterString(cid)
    PushScaleformMovieFunctionParameterFloat(0.0)
    PopScaleformMovieFunctionVoid()
end

function leavePrison()
    local jailTime = exports["np-base"]:getChar("jail")
    if jailTime == 0 then
        jailed = false
        TriggerServerEvent("np-jail:updateJailTime", -1)
        SetEntityCoords(PlayerPedId(), 1839.91, 2590.03, 46.02)
        SetEntityHeading(PlayerPedId(), 178.63)
    elseif jailTime == -1 then
        TriggerEvent("DoLongHudText", "You are not in Jail", 2)
    else
        TriggerEvent("DoLongHudText", "Your sentence is not over yet!", 2)
    end
end

--[[

    Events

]]

RegisterNetEvent("np-jail:reset")
AddEventHandler("np-jail:reset", function(startPosition, cid, name)
    insidePrison = false
    myCell = 1
    count = 0
    jailed = false
    lastMessage = 0
end)

AddEventHandler("np-polyzone:enter", function(pZoneName, pZoneData)
    if pZoneName == "prison" then
        insidePrison = true
        ClearAreaOfPeds(1691.86, 2604.6, 45.55, 1000, 1)
        exports["np-density"]:ChangeDensity("prison", 0.0)
    elseif pZoneName == "prison_leave" then
        currentZone = pZoneName
        exports["np-interaction"]:showInteraction("[M] get out of prison")
        listenForKeypress()
    elseif pZoneName == "prison_possessions" then
        currentZone = pZoneName
        exports["np-interaction"]:showInteraction("[M] get your items back")
        listenForKeypress()
    end
end)

AddEventHandler("np-polyzone:exit", function(pZoneName, pZoneData)
    if pZoneName == "prison" then
        if jailed then
            SetEntityCoords(PlayerPedId(), cells[myCell].x, cells[myCell].y, cells[myCell].z)
            SetEntityHeading(PlayerPedId(), cells[myCell].w)
        else
            insidePrison = false
            exports["np-density"]:ChangeDensity("prison", -1)
        end
    elseif pZoneName == "prison_leave" then
        exports["np-interaction"]:hideInteraction()
        listening = false
    elseif pZoneName == "prison_possessions" then
        exports["np-interaction"]:hideInteraction()
        listening = false
    end

    currentZone = ""
end)

RegisterNetEvent("inventory-jail")
AddEventHandler("inventory-jail", function(startPosition, cid, name)
    if insidePrison and exports["np-inventory"]:hasEnoughOfItem("okaylockpick", 1, false) then
        TriggerServerEvent("server-inventory-open", startPosition, cid, "1", name)
    end
end)

AddEventHandler("np-jail:sendToJail", function(pParams, pEntity, pContext)
    local input = exports["np-input"]:showInput({
		{
            icon = "timer",
            label = "Timer",
            name = "time",
        },
	})

	if input["time"] then
		local time = tonumber(input["time"])
		if not time or time < 1 then
			TriggerEvent("DoLongHudText", "Invalid Number", 2)
			return
		end

        if not IsNearPlayer(pEntity) then
            TriggerEvent("DoLongHudText", "You are not close to the player!", 2)
            return
        end

        TriggerEvent("animation:PlayAnimation","id")
		TriggerServerEvent("np-jail:sendToJail", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)), time)
	end
end)

RegisterNetEvent("np-jail:begInJail")
AddEventHandler("np-jail:begInJail", function(pSkip, pTime, pName, pCid, pDate)
    myCell = math.random(#cells)

    if not pSkip then
        TriggerEvent("np-police:uncuff")
        TriggerServerEvent("np-jobs:changeJob", "unemployed")
        TriggerServerEvent("np-jail:claimPossessions")
        JailIntro(pName, pTime, pCid, pDate)
    end

    DoScreenFadeOut(1)
    SetEntityCoords(PlayerPedId(), cells[myCell].x, cells[myCell].y, cells[myCell].z)
    SetEntityHeading(PlayerPedId(), cells[myCell].w)

    Citizen.Wait(500)

    DoScreenFadeIn(1500)
    FreezeEntityPosition(PlayerPedId(), false)

    jailed = true
    lastMessage = tonumber(GetCloudTimeAsInt()) + 300

    TriggerEvent("chatMessage", "DOC: " , { 33, 118, 255 }, "you have " .. exports["np-base"]:getChar("jail") .. " remaining months")
end)

AddEventHandler("drawScaleformJail", function(years,name,cid,date)
    if #(GetEntityCoords(PlayerPedId()) - vector3(472.92, -1011.57, 26.0)) < 10.0 then
        if count > 0 then
            count = 0
        end

        Citizen.Wait(1)

        local scaleform = RequestScaleformMovie("mugshot_board_01")
        while not HasScaleformMovieLoaded(scaleform) do
            Wait(1)
        end

        count = 10000

        while count > 0 do
            count = count - 1
            local objFound = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, `prop_police_id_board`, 0, 0, 0)
            if objFound then
                scaleformPaste(scaleform, objFound, name, years, cid, date)
            end
            Citizen.Wait(1)
        end
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-density"]:RegisterDensityReason("prison", 69)

    exports["np-polyzone"]:AddPolyZone("prison", {
        vector2(1845.6815185547, 2585.9074707031),
        vector2(1845.6871337891, 2612.7360839844),
        vector2(1827.8706054688, 2612.4467773438),
        vector2(1827.5889892578, 2622.3190917969),
        vector2(1853.3553466797, 2700.3278808594),
        vector2(1774.2952880859, 2767.4338378906),
        vector2(1647.5544433594, 2762.4067382812),
        vector2(1566.3303222656, 2682.7998046875),
        vector2(1530.3841552734, 2585.3186035156),
        vector2(1536.6389160156, 2468.2019042969),
        vector2(1658.8604736328, 2390.0854492188),
        vector2(1763.5825195312, 2406.298828125),
        vector2(1828.1220703125, 2473.9348144531),
        vector2(1824.3211669922, 2559.0690917969),
        vector2(1846.3316650391, 2559.4621582031)
    }, {
        --debugPoly = true,
        gridDivisions = 25,
        minZ = 40,
        maxZ = 80,
    })

    exports["np-polyzone"]:AddBoxZone("prison_leave", vector3(1830.54, 2594.43, 46.01), 4.2, 1.4, {
        --debugPoly=true,
        heading=0,
        minZ=45.01,
        maxZ=47.61
    })

    exports["np-polyzone"]:AddBoxZone("prison_possessions", vector3(1840.4, 2579.31, 46.01), 0.8, 1.4, {
        --debugPoly=true,
        heading=0,
        minZ=45.01,
        maxZ=47.61
    })

    exports["np-polytarget"]:AddBoxZone("prison_food", vector3(1781.44, 2559.52, 45.67), 0.4, 5.0, {
        --debugPoly=true,
        heading=0,
        minZ=45.67,
        maxZ=45.87
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("prison_food", {{
        event = "np-npcs:ped:keeper",
        id = "prison_food",
        icon = "Food",
        label = "Comida",
        parameters = { "22" }
    }}, { distance = { radius = 3.5 } })

    exports["np-eye"]:AddPeekEntryByEntityType({ 1 }, {
        {
            id = "jail",
            label = "Jail",
            icon = "link",
            event = "np-jail:sendToJail",
            parameters = {},
        }
    }, {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return pContext.flags["isPlayer"] and pContext.distance <= 1.2 and exports["np-jobs"]:getJob(CurrentJob, "is_police")
        end
    })

    while true do
        Citizen.Wait(60000)

        if jailed then
            local jailTime = exports["np-base"]:getChar("jail")
            if jailTime ~= nil and type(jailTime) == "number" then
                local newTime = jailTime - 1
                if newTime > -1 then
                    TriggerServerEvent("np-jail:updateJailTime", newTime)
                else
                    newTime = 0
                end

                local currentTime = tonumber(GetCloudTimeAsInt())

                if currentTime > lastMessage then
                    lastMessage = currentTime + 300
                    TriggerEvent("chatMessage", "DOC: " , { 33, 118, 255 }, "you have " .. newTime .. " remaining months")
                end
            end
        end
    end
end)