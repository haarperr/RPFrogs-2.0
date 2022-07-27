--[[

    Variables

]]

local trunkveh = 0
local cam = 0

local frontTrunk = {}

local disabledTrunk = {
    "penetrator",
    "vacca",
    "monroe",
    "turismor",
    "osiris",
    "comet",
    "ardent",
    "jester",
    "nero",
    "nero2",
    "vagner",
    "infernus",
    "zentorno",
    "comet2",
    "comet3",
    "comet4",
    "lp700r",
    "r8ppi",
    "911turbos",
    "rx7rb",
    "fnfrx7",
    "delsoleg",
    "s15rb",
    "gtr",
    "fnf4r34",
    "ap2",
    "bullet",
}

local trunkOffsets = {
    [`taxi`] = { y = 0.0, z = -0.5 },
    [`buccaneer`] = { y = 0.5, z = 0.0 },
    [`peyote`] = { y = 0.35, z = -0.15 },
    [`regina`] = { y = 0.2, z = -0.35 },
    [`pigalle`] = { y = 0.2, z = -0.15 },
    [`glendale`] = { y = 0.0, z = -0.35 },
}

--[[

    Functions

]]

local function DrawText3DTrunk(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function disabledCarCheck(veh)
    for i, v in ipairs(disabledTrunk) do
        if GetEntityModel(veh) == GetHashKey(v) then
            return true
        end
    end
    return false
end

function frontTrunkCheck(veh)
    for i, v in ipairs(frontTrunk) do
        if GetEntityModel(veh) == GetHashKey(v) then
            return true
        end
    end
    return false
end

function PutInTrunk(veh)
    if disabledCarCheck(veh) then return end

    if not DoesVehicleHaveDoor(veh, 6) and DoesVehicleHaveDoor(veh, 5) and IsThisModelACar(GetEntityModel(veh)) then
    	Sync.SetVehicleDoorOpen(veh, 5, 1, 1)

        local d1, d2 = GetModelDimensions(GetEntityModel(veh))

        local trunkZ = d2["z"]
        if trunkZ > 1.4 then
            trunkZ =  1.4 - (d2.z -  1.4)
        end

        exports["np-base"]:setVar("trunk", true)
        exports["np-flags"]:SetPedFlag(PlayerPedId(), "isInTrunk", true)

        local testdic = "mp_common_miss"
        local testanim = "dead_ped_idle"
        RequestAnimDict(testdic)
        while not HasAnimDictLoaded(testdic) do
            Citizen.Wait(0)
        end

        SetBlockingOfNonTemporaryEvents(PlayerPedId(), true)
        SetPedSeeingRange(PlayerPedId(), 0.0)
        SetPedHearingRange(PlayerPedId(), 0.0)
        SetPedFleeAttributes(PlayerPedId(), 0, false)
        SetPedKeepTask(PlayerPedId(), true)
        DetachEntity(PlayerPedId())
        ClearPedTasks(PlayerPedId())
        TaskPlayAnim(PlayerPedId(), testdic, testanim, 8.0, 8.0, -1, 2, 999.0, 0, 0, 0)
        local vehicleName = GetEntityModel(veh)
        local vehicleTrunkOffset = trunkOffsets[vehicleName] or { y = 0.0, z = 0.0 }

        AttachEntityToEntity(PlayerPedId(), veh, 0, -0.1, (d1["y"] + 0.85) + vehicleTrunkOffset.y, ( trunkZ - 0.87) + vehicleTrunkOffset.z, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
        trunkveh = veh

        while true do
            Citizen.Wait(1)

            CamTrunk()

            local DropPosition = GetOffsetFromEntityInWorldCoords(veh, 0.0, d1["y"] - 0.2, 0.0)

            DrawText3DTrunk(DropPosition["x"], DropPosition["y"], DropPosition["z"],"[G] Open/Close | [F] Climb Out")

            if IsControlJustReleased(0, 47) then
                if GetVehicleDoorAngleRatio(veh, 5) > 0.0 then
                    Sync.SetVehicleDoorShut(veh, 5, 1, 0)
                else
                    Sync.SetVehicleDoorOpen(veh, 5, 1, 0)
                end
            end

            if IsControlJustReleased(0, 23) then
                exports["np-base"]:setVar("trunk", false)
                exports["np-flags"]:SetPedFlag(PlayerPedId(), "isInTrunk", false)
                break
            end

			if GetVehicleEngineHealth(veh) < 100.0 or not DoesEntityExist(veh) then
		        exports["np-base"]:setVar("trunk", false)
                exports["np-flags"]:SetPedFlag(PlayerPedId(), "isInTrunk", false)
		        Sync.SetVehicleDoorOpen(trunkveh, 5, 1, 1)
		        trunkveh = 0
                break
			end

			if not IsEntityPlayingAnim(PlayerPedId(), testdic, testanim, 3) then
				TaskPlayAnim(PlayerPedId(), testdic, testanim, 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end
        end

        DoScreenFadeOut(10)
        Citizen.Wait(1000)
        CamDisable()

        DetachEntity(PlayerPedId())

        if DoesEntityExist(veh) then
        	local DropPosition = GetOffsetFromEntityInWorldCoords(veh, 0.0,d1["y"]-0.5,0.0)
	        SetEntityCoords(PlayerPedId(), DropPosition["x"], DropPosition["y"], DropPosition["z"])
	    end

        DoScreenFadeIn(2000)
    end
end

function CamTrunk()
    if not DoesCamExist(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
        SetCamRot(cam, 0.0, 0.0, 0.0)
        SetCamActive(cam,  true)
        RenderScriptCams(true,  false,  0,  true,  true)
        SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
    end

    AttachCamToEntity(cam, PlayerPedId(), 0.0,-2.5,1.0, true)
    SetCamRot(cam, -30.0, 0.0, GetEntityHeading(PlayerPedId()) )
end

function CamDisable()
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
end

--[[

    Events

]]

RegisterNetEvent("vehicle:getInTrunk")
AddEventHandler("vehicle:getInTrunk", function(pArgs, pEntity)
    PutInTrunk(pEntity)
end)