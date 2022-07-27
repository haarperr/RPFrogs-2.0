--[[

    Variables

]]

DecorRegister("Vehicle-Identifier", 3)


--[[

    Functions

]]

function SetVehicleIdentifier(vehicle, id)
	if not DoesEntityExist(vehicle) then return end
	if not id or type(id) ~= "number" then return end

	Sync.DecorSetInt(vehicle, "Vehicle-Identifier", id)
end

function SetVehiclePlate(vehicle, plate)
	if not DoesEntityExist(vehicle) then return end
	if not plate or type(plate) ~= "string" then return end

	SetVehicleNumberPlateText(vehicle, plate)
end

function SetVehicleMods(vehicle, mods)
	if not DoesEntityExist(vehicle) then return end

	if not mods then
		SetVehicleColours(vehicle, 0, 0)
		SetVehicleExtraColours(vehicle, 0, 0)

		return
	end

	local customisations = json.decode(mods)

	SetVehicleWheelType(vehicle, customisations["wheeltype"])
	SetVehicleNumberPlateTextIndex(vehicle, customisations["plateIndex"])

	for i = 0, 16 do
		SetVehicleMod(vehicle, i, customisations["mods"][tostring(i)])
	end

	for i = 17, 22 do
		ToggleVehicleMod(vehicle, i, customisations["mods"][tostring(i)])
	end

	for i = 23, 24 do
		SetVehicleMod(vehicle, i, customisations["mods"][tostring(i)], customisations["mods"][tostring(i)])
	end

	for i = 23, 48 do
		SetVehicleMod(vehicle, i, customisations["mods"][tostring(i)])
	end

	for i = 0, 3 do
		SetVehicleNeonLightEnabled(vehicle, i, customisations["neon"][tostring(i)])
	end

	if customisations["extras"] ~= nil then
		for i = 1, 12 do
			local onoff = tonumber(customisations["extras"][i])
			if onoff == 1 then
				SetVehicleExtra(vehicle, i, 0)
			else
				SetVehicleExtra(vehicle, i, 1)
			end
		end
	end

	if customisations["oldLiveries"] ~= nil and customisations["oldLiveries"] ~= 24  then
		SetVehicleLivery(vehicle, customisations["oldLiveries"])
	end

	SetVehicleXenonLightsColour(vehicle, (customisations["xenonColor"] or -1))
	SetVehicleColours(vehicle, customisations["colors"][1], customisations["colors"][2])
	SetVehicleExtraColours(vehicle, customisations["extracolors"][1], customisations["extracolors"][2])
	SetVehicleNeonLightsColour(vehicle, customisations["lights"][1], customisations["lights"][2], customisations["lights"][3])
	SetVehicleTyreSmokeColor(vehicle, customisations["smokecolor"][1], customisations["smokecolor"][2], customisations["smokecolor"][3])
	SetVehicleWindowTint(vehicle, customisations["tint"])
	SetVehicleInteriorColour(vehicle, customisations["dashColour"])
	SetVehicleDashboardColour(vehicle, customisations["interColour"])
end

function GetVehicleIdentifier(vehicle)
    if not DoesEntityExist(vehicle) then
		return false
	end

	if not DecorExistOn(vehicle, "Vehicle-Identifier") then
		return false
	end

	return DecorGetInt(vehicle, "Vehicle-Identifier")
end

function GetVehiclePlate(vehicle)
	if not DoesEntityExist(vehicle) then
		return ""
	end

	local plate = GetVehicleNumberPlateText(vehicle)

	return string.gsub(plate, "%s+", "")
end

function GetVehicleMetadata(vehicle, data)
	if not DoesEntityExist(vehicle) then
		return
	end

    local vid = GetVehicleIdentifier(vehicle)
    if not vid then return end

    if data == "fakePlate" and DecorExistOn(vehicle, "Vehicle-Fakeplate") then
        return DecorGetBool(vehicle, "Vehicle-Fakeplate")
    end

	if data == "harness" and DecorExistOn(vehicle, "Vehicle-Harness") then
		return DecorGetInt(vehicle, "Vehicle-Harness")
	end

	return
end

function GetVehicleTier(vehicle)
	if not DoesEntityExist(vehicle) then
		return
	end

	local function getField(field)
		return GetVehicleHandlingFloat(vehicle, "CHandlingData", field)
	end

	local model = GetEntityModel(vehicle)
	local isMotorCycle = IsThisModelABike(model)

	local fInitialDriveMaxFlatVel = getField("fInitialDriveMaxFlatVel")
	local fInitialDriveForce = getField("fInitialDriveForce")
	local fDriveBiasFront = getField("fDriveBiasFront")
	local fInitialDragCoeff = getField("fInitialDragCoeff")
	local fTractionCurveMax = getField("fTractionCurveMax")
	local fTractionCurveMin = getField("fTractionCurveMin")
	local fSuspensionReboundDamp = getField("fSuspensionReboundDamp")
	local fBrakeForce = getField("fBrakeForce")

	-- Acceleration: (fInitialDriveMaxFlatVel x fInitialDriveForce)/10
	-- If the fDriveBiasFront is greater than 0 but less than 1, multiply fInitialDriveForce by 1.1.
	local force = fInitialDriveForce
	if fInitialDriveForce > 0 and fInitialDriveForce < 1 then
		force = force * 1.1
	end

	local accel = (fInitialDriveMaxFlatVel * force) / 10

	-- Speed:
	-- ((fInitialDriveMaxFlatVel / fInitialDragCoeff) x (fTractionCurveMax + fTractionCurveMin))/40
	local speed = ((fInitialDriveMaxFlatVel / fInitialDragCoeff) * (fTractionCurveMax + fTractionCurveMin)) / 40
	if isMotorCycle then
	  	speed = speed * 2
	end

	-- Handling:
	-- (fTractionCurveMax + fSuspensionReboundDamp) x fTractionCurveMin
	local handling = (fTractionCurveMax + fSuspensionReboundDamp) * fTractionCurveMin
	if isMotorCycle then
	  	handling = handling / 2
	end

	-- Braking:
	-- ((fTractionCurveMin / fInitialDragCoeff) x fBrakeForce) x 7
	local braking = ((fTractionCurveMin / fInitialDragCoeff) * fBrakeForce) * 7

	-- Overall Performance Bracket:
	-- ((Acceleration x 5) + Speed + Handling + Braking) * 15
	-- X Class: > 1000
	-- S Class: > 650
	-- A Class: > 500
	-- B Class: > 400
	-- C Class: > 325
	-- D Class: =< 325
	local perfRating = ((accel * 5) + speed + handling + braking) * 15
	local vehClass = "F"
	if isMotorCycle then
		vehClass = "M"
	elseif perfRating > 900 then
	  	vehClass = "X"
	elseif perfRating > 700 then
	  	vehClass = "S"
	elseif perfRating > 550 then
	  	vehClass = "A"
	elseif perfRating > 400 then
	  	vehClass = "B"
	elseif perfRating > 325 then
	  	vehClass = "C"
	else
	  	vehClass = "D"
	end

	return vehClass
end

function GetVehicleAfterMarket(vehicle, type)
	if type then
		return nil
	else
		return {}
	end
end

function spawnVehicle(model, coords, id, plate, fuel, mods, fakeplate, harness, body_damage, engine_damage, seatIntoVehicle)
	if not coords then
        local plyCoords = GetEntityCoords(PlayerPedId())
        local heading = GetEntityHeading(PlayerPedId())

        coords = vector4(plyCoords["x"], plyCoords["y"], plyCoords["z"], heading)
    end

	local hash = nil
	if tonumber(model) then
		hash = model
	else
		hash = GetHashKey(model)
	end

    RequestModel(hash)
	while not HasModelLoaded(hash) do Citizen.Wait(0) end

    local veh = CreateVehicle(hash, coords["x"], coords["y"], coords["z"], coords["w"] or 0.0, true, false)

	SetVehRadioStation(veh, "OFF")
	SetVehicleNeedsToBeHotwired(veh, false)
	SetVehicleOnGroundProperly(veh)
	SetEntityInvincible(veh, false)
	SetVehicleModKit(veh, 0)
	SetVehicleHasBeenOwnedByPlayer(veh, true)
	SetEntityAsMissionEntity(veh, true, true)
	SetVehicleIsWanted(veh, false)
	SetVehicleIsStolen(veh, false)

	NetworkRegisterEntityAsNetworked(veh)
	local netid = NetworkGetNetworkIdFromEntity(veh)
	SetNetworkIdCanMigrate(netid, true)
	SetNetworkIdExistsOnAllMachines(netid, true)

	SetVehicleMods(veh, mods)
	SetVehicleIdentifier(veh, id)
	SetVehiclePlate(veh, plate)
	SetVehicleFuel(veh, fuel, true)
	SetVehicleDamage(veh, body_damage, engine_damage)

	if fakeplate then
		SetVehiclePlate(veh, fakeplate)
		Sync.DecorSetBool(veh, "Vehicle-Fakeplate", true)
	end

	if harness then
		Sync.DecorSetInt(veh, "Vehicle-Harness", harness)
	end

	TriggerEvent("keys:addNew", veh)

	exports["np-flags"]:SetVehicleFlag(veh, "isPlayerVehicle", true)

	if seatIntoVehicle then
		SetPedIntoVehicle(PlayerPedId(), veh, -1)
	end

	TriggerEvent("np-vehicles:spawnedVehicleSync", netid, model)

	return veh
end

--[[

    Exports

]]

exports("GetVehicleIdentifier", GetVehicleIdentifier)
exports("GetVehiclePlate", GetVehiclePlate)
exports("GetVehicleMetadata", GetVehicleMetadata)
exports("GetVehicleTier", GetVehicleTier)
exports("GetVehicleAfterMarket", GetVehicleAfterMarket)
exports("spawnVehicle", spawnVehicle)

--[[

    Events

]]

RegisterNetEvent("np-vehicles:spawnVehicle")
AddEventHandler("np-vehicles:spawnVehicle", spawnVehicle)

AddEventHandler("vehicle:swapSeat", function(seat)
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)

	if vehicle ~= 0 then
        SetPedIntoVehicle(player, vehicle, seat)
    end
end)

AddEventHandler("vehicle:toggleEngine", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player, false)
	local isPlayerDriving = GetPedInVehicleSeat(vehicle, -1) == player

	if not HasVehicleKey(vehicle) then return end

	if vehicle ~= 0 and isPlayerDriving then
		if IsVehicleEngineOn(vehicle) then
            Sync.SetVehicleEngineOn(vehicle, 0, 1, 1)
			Sync.SetVehicleUndriveable(vehicle, true)

            TriggerEvent("DoLongHudText", "Engine Off")
        else
            if GetVehicleEngineHealth(vehicle) > 199 then
				Sync.SetVehicleEngineOn(vehicle, 0, 1, 1)

				Citizen.Wait(100)

				Sync.SetVehicleUndriveable(vehicle, false)
				Sync.SetVehicleEngineOn(vehicle, 1, 0, 1)

				Citizen.Wait(100)

				if not Citizen.InvokeNative(0xAE31E7DF9B5B132E, vehicle) then
					Sync.SetVehicleEngineOn(vehicle, 1, 1, 1)
				end

				TriggerEvent("DoLongHudText", "Engine On")
			else
				Sync.SetVehicleEngineOn(vehicle, 0, 1, 1)
				Sync.SetVehicleUndriveable(vehicle, true)
			end
        end
    end
end)