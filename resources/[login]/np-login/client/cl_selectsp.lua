--[[

	Variables

]]

Spawn.defaultSpawns = {
	[1] =  { ["pos"] = vector4(130.59, -1739.06, 30.11, 320.28), ["info"] = " Davis Train Station"},
	[2] =  { ["pos"] = vector4(85.47, -1404.68, 29.41, 293.58), ["info"] = " Strawberry Avenue"},
	[3] =  { ["pos"] = vector4(-232.95, -1490.77, 32.97, 269.63), ["info"] = " Chamberlain Hills"},
	[4] =  { ["pos"] = vector4(1211.68, -1389.85, 35.38, 186.1), ["info"] = " El Burro Gas Station"},
	[5] =  { ["pos"] = vector4(1122.11, 2667.24, 38.04, 180.39), ['info'] = ' Harmony Motel'},
	[6] =  { ["pos"] = vector4(453.29, -662.23, 28.01, 5.73), ['info'] = ' Bus Station'},
	[7] =  { ["pos"] = vector4(-1266.53, 273.86, 64.66, 28.52), ['info'] = ' The Richman Hotel'},
	[8] =  { ["pos"] = vector4(-1044.93, -2750.06, 21.36, 328.37), ['info'] = ' LSIA'},
	[9] =  { ["pos"] = vector4(913.48, 56.73, 80.89, 240.71), ['info'] = ' Casino Entrance'},
	[10] =  { ["pos"] = vector4(178.05, -671.46, 43.14, 106.09), ['info'] = ' Centre City'},
	[11] =  { ["pos"] = vector4(250.57, -1072.57, 29.46, 1.23), ['info'] = ' Court House'},
	[12] =  { ["pos"] = vector4(-517.32, -211.35, 38.17, 120.86), ['info'] = ' City Hall'},
	[13] =  { ["pos"] = vector4(1507.6, 3768.2, 34.13, 170.37), ['info'] = ' Sandy Shores'},
	[14] =  { ["pos"] = vector4(-3169.76, 1067.3, 20.85, 252.97), ['info'] = ' Chumash Plaza'},
	[15] =  { ["pos"] = vector4(145.62, 6563.19, 32.0, 42.83), ['info'] = ' Paleto Gas Station'},
}

Spawn.motel = {
	[1] = { ["pos"] = vector4(-260.40, -973.67, 31.22, 42.83), ["info"] = " Apartments 1"},
	[2] = { ["pos"] = vector4(-1236.27,-860.84,12.91,213.56), ["info"] = " Apartments 2"},
	[3] = { ["pos"] = vector4(173.96, -631.29, 47.08, 303.12), ["info"] = " Apartments 3"}
}

Spawn.Crash = nil
Spawn.housingCoords = nil
Spawn.isNew = false

Spawn.tempHousing = {}
Spawn.defaultApartmentSpawn = {}
Spawn.tempGroups = {}

cam = 0

--[[

	Functions

]]

function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end

function Login.SetTestCam()
	--LoginSafe.Cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	local camCoords = {-3968.85, 2015.93,502.22 }
	SetCamRot(LoginSafe.Cam, -90.0, 0.0, 250.0, 2)
	SetCamCoord(LoginSafe.Cam, camCoords[1], camCoords[2], camCoords[3])
	StopCamShaking(LoginSafe.Cam, true)
	SetCamFov(LoginSafe.Cam, 50.0)
	SetCamActive(LoginSafe.Cam, true)
	RenderScriptCams(true, false, 0, true, true)
end

function Spawn.getDevSpawn()
	local spawn = nil

	local devspawn = exports["storage"]:tryGet("vector4","devspawn")
	if devspawn then
		spawn = { ["pos"] = devspawn, ["info"] = "Dev Spawn" }
	end

	return spawn
end

function Spawn.createDefaultData(housing_id)
	local defaultData = nil

	if Spawn.housingCoords == nil or Spawn.housingCoords[housing_id] == nil then return end
	if Spawn.housingCoords[housing_id].assigned then return end

	local housing = Spawn.housingCoords[housing_id]
	defaultData = {["pos"] = housing["pos"], ["info"] = housing["street"] .. " House"}

	return defaultData
end

function Spawn.selectedSpawn(spawnInfo)
	if spawnInfo == nil or spawnInfo == "" or type(spawnInfo) ~= "string" then
		return
	end

	Citizen.SetTimeout(15000, function()
		SetEntityInvincible(PlayerPedId(), false)
	end)

	FreezeEntityPosition(PlayerPedId(), false)
	SetEntityVisible(PlayerPedId(), true)
	EnableAllControlActions(0)

	Login.DeleteCamera()
	SetNuiFocus(false,false)

	TriggerEvent("insideSpawn", false)
	TriggerEvent("np-hud:EnableHud", true)

	local apartment = Spawn.obtainApartmentType(spawnInfo)
	if apartment then
		DoScreenFadeOut(2)
		TriggerEvent("apartments:spawnIntoRoom")
	else
		local pos = Spawn.obtainWorldSpawnPos(spawnInfo)
		if pos then
			SetEntityCoords(PlayerPedId(),pos.x,pos.y,pos.z)
			SetEntityHeading(PlayerPedId(),pos.w)

			doCamera(pos.x,pos.y,pos.z)
			DoScreenFadeOut(2)

			Login.DeleteCamera()

			Wait(200)

			DoScreenFadeIn(2500)
		elseif spawnInfo == "Última Localização" then
			local pos = Spawn.Crash

			SetEntityCoords(PlayerPedId(),pos.x,pos.y,pos.z)
			SetEntityHeading(PlayerPedId(),pos.w)

			doCamera(pos.x,pos.y,pos.z)
			DoScreenFadeOut(2)

			Login.DeleteCamera()

			Wait(200)

			DoScreenFadeIn(2500)
		else
			local pos = Spawn.obtainHousingPos(spawnInfo)
			if pos then
				doCamera(pos.x,pos.y,pos.z)
				DoScreenFadeOut(2)

				Login.DeleteCamera()
				SetEntityCoords(PlayerPedId(),pos.x,pos.y,pos.z)
				SetEntityHeading(PlayerPedId(),pos.w)
				Wait(200)

				DoScreenFadeIn(2500)
				TriggerEvent("housing:playerSpawned",spawnInfo)

				Citizen.CreateThread(function()
					local checkStart = GetCloudTimeAsInt() + 60
					while true do
						Citizen.Wait(500)

						if exports["np-base"]:getVar("dead") then
							TriggerEvent("reviveFunction")
							SetEntityHealth(PlayerPedId(), 200)
						end

						local currentTime = GetCloudTimeAsInt()
						if currentTime > checkStart then
							break
						end
					end
				end)
			end
		end
 	end

	isNear = false
 	Spawn.tempHousing  = {}
	Spawn.tempGroups  = {}
end

function Spawn.overwriteSpawn(overwrite)
	local pos = vector4(1802.51,2607.19,46.01,93.0) -- default prison

	if overwrite == "maxsec" then
		pos = vector4(1690.75,2593.14,45.61,178.75)
	elseif overwrite == "rehab" then
		pos = vector4(-1475.86,884.47,182.93,93.0)
	elseif overwrite == "jail" then
		pos = vector4(1802.51,2607.19,46.01,93.0)
	end

	Login.DeleteCamera()
	SetNuiFocus(false,false)
 	doCamera(pos.x,pos.y,pos.z)
 	Wait(300)
	DoScreenFadeOut(2)
	Login.DeleteCamera()

	if overwrite == "jail" then
		TriggerEvent("np-jail:begInJail", true)
	end

	Wait(200)

	SetEntityInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)
	SetEntityVisible(PlayerPedId(), true)
	EnableAllControlActions(0)

	DoScreenFadeIn(2500)

	TriggerEvent("insideSpawn", false)
	TriggerEvent("np-hud:EnableHud", true)
end

function doCamera(x,y,z)
	DoScreenFadeOut(1)
	if(not DoesCamExist(cam)) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
	end

	i = 3200
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	SetCamActive(cam,  true)
	RenderScriptCams(true,  false,  0,  true,  true)
	DoScreenFadeIn(1500)
	local camAngle = -90.0
	while i > 1 do
		local factor = i / 50
		if i < 1 then i = 1 end
		i = i - factor
		SetCamCoord(cam, x,y,z+i)
		if i < 1200 then
			DoScreenFadeIn(600)
		end
		if i < 90.0 then
			camAngle = i - i - i
		end
		SetCamRot(cam, camAngle, 0.0, 0.0)
		Citizen.Wait(2/i)
	end
end

function Spawn.getCrash(exitData)
	local spawn = nil
	if exitData then
		local vec3 = vector3(exitData.x,exitData.y,exitData.z)
		local newPos = vector4(exitData.x,exitData.y,exitData.z,0.0)
		local canUse = true

		if #(vec3-vector3(0.0,0.0,0.0)) < 10 then canUse = false end
		-- if vec3.z < 0.0 then canUse = false end
		-- if GetInteriorAtCoords(vec3) ~= 0 then canUse = false end

		if canUse then
			spawn = { ["pos"] = newPos, ["info"] = "Last Location"}
			Spawn.Crash = exitData
		end
	end

	return spawn
end

--[[

	Events

]]

RegisterNetEvent("spawn:clientSpawnData")
AddEventHandler("spawn:clientSpawnData", function(spawnData)
	Login.Selected = false
	Login.CurrentPedInfo = nil
	Login.CurrentPed = nil
	Login.CreatedPeds = {}

	Login.SetTestCam()
	DoScreenFadeIn(1)

	if spawnData.hospital.illness == "dead" or spawnData.hospital.illness == "icu" then
		return
	end

	runGameplay()

	TriggerServerEvent("SpawnEventsServer")
    TriggerEvent("SpawnEventsClient")

	if spawnData.overwrites ~= nil then
		if spawnData.overwrites == "jail" or spawnData.overwrites == "maxsec" or spawnData.overwrites == "rehab" then
			Spawn.overwriteSpawn(spawnData.overwrites)
		elseif spawnData.overwrites == "new" then
			Spawn.isNew = true
			Spawn.selectedSpawn(" Apartments 1")

			Citizen.CreateThread(function()
				Citizen.Wait(5000)

				SetEntityMaxHealth(PlayerPedId(), 200)
				SetPedMaxHealth(PlayerPedId(), 200)
  				SetPlayerMaxArmour(PlayerId(), 60)
				SetEntityHealth(PlayerPedId(), 200)

				TriggerEvent("player:receiveItem", "idcard", 1)
				TriggerEvent("player:receiveItem", "mobilephone", 1)
			end)
		end

		return
	end

	SendNUIMessage({
		showSpawnMenu = true,
	})

	if Spawn.housingCoords == nil then
		Spawn.housingCoords = exports["np-housing"]:retriveHousingTable()
	end

	local currentSpawns = Spawn.shallowCopy(Spawn.defaultSpawns)
	local currentCheckList = {}

	currentSpawns[#currentSpawns + 1] = Spawn.getCrash(spawnData.exitData)
	currentSpawns[#currentSpawns + 1] = Spawn.getDevSpawn()
	currentSpawns[#currentSpawns + 1] = Spawn.motel[spawnData.motelRoom.roomType]
	Spawn.defaultApartmentSpawn = spawnData.motelRoom

	Spawn.tempGroups = {}
	for i, v in ipairs(spawnData.groups) do
		table.insert(Spawn.tempGroups, v)
		currentSpawns[#currentSpawns + 1] = v
	end

	Spawn.tempHousing = {}
	for k,v in pairs(spawnData.houses) do
		local data = Spawn.createDefaultData(k)
		currentSpawns[#currentSpawns + 1] = data
		table.insert(Spawn.tempHousing, data)
		currentCheckList[k] = true
	end

	for k,v in pairs(spawnData.keys) do
		if not currentCheckList[k] then
			local data = Spawn.createDefaultData(k)
			currentSpawns[#currentSpawns + 1] = data
			table.insert(Spawn.tempHousing, data)
		end
	end

	-- fuck json , makes me only send the info of the table :( , json does not support vector4 kek
	local infoTable = {}
	for i=1,#currentSpawns do
		local spawn = currentSpawns[i]
		infoTable[i] = {["info"] = spawn.info,["posX"] = spawn.pos.x,["posY"] = spawn.pos.y,["checkS"] = i}
	end

	local fav = exports["storage"]:tryGet("string","cauefavorite")
	if fav == nil then fav = "" end

	local fonund = false
	for k,v in pairs(currentSpawns) do
		if fav == v.info then fonund = true end
	end

	if not fonund then fav = "" end

	Wait(200)
	SetNuiFocus(true,true)
	SendNUIMessage({
		updateSpawnMenu = true,
		spawns = infoTable,
		fav = fav
	})

	Spawn.housingCoords = nil
end)