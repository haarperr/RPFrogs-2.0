--[[

    Variables

]]

local isTriageEnabled = true
local currentPrompt = nil

local EVENTS = {
    LOCKERS = 1,
    CLOTHING = 2,
    SWITCHER = 3,
	ARMORY = 4,
}

local zoneData = {
	pillbox_checkin = {
		promptText = "[E] Check In ($200)"
	},
	pillbox_armory = {
		promptText = "[E] Arsenal"
	},
	pillbox_clothing_lockers_staff = {
		promptText = "[E] Lockers & Clothes",
		menuData = {
			{
				title = "Lockers",
				description = "Access your personal locker",
				action = "np-healthcare:handler",
				params = EVENTS.LOCKERS
			},
			{
				title = "Clothing",
				description = "Gotta look Sharp",
				action = "np-healthcare:handler",
				params = EVENTS.CLOTHING
			}
		}
	},
	pillbox_character_switcher_staff = {
		promptText = "[E] Switch Character",
		menuData = {
			{
				title = "Character switch",
				description = "Change Character",
				action = "np-police:handler",
				params = EVENTS.SWITCHER
			}
		}
	},
	pillbox_character_switcher_backroom = {
		promptText = "[E] Switch Character",
		menuData = {
			{
				title = "Character switch",
				description = "Change Character",
				action = "np-police:handler",
				key = EVENTS.SWITCHER
			}
		}
	},
	fire_department = {
		promptText = "[E] Lockers & Clothes & Armory",
		menuData = {
			{
				title = "Lockers",
				description = "Access your personal locker",
				action = "np-healthcare:handler",
				params = EVENTS.LOCKERS
			},
			{
				title = "Clothing",
				description = "Gotta look Sharp",
				action = "np-healthcare:handler",
				params = EVENTS.CLOTHING
			},
			{
				title = "Armory",
				description = "Armory",
				action = "np-healthcare:handler",
				params = EVENTS.ARMORY
			},
			{
				title = "Character switch",
				description = "Change Character",
				action = "np-police:handler",
				key = EVENTS.SWITCHER
			}
		}
	},
}

--[[

    Functions

]]

local function listenForKeypress(pZone, pAction)
    listening = true

    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                if pAction == "context" then
                    exports["np-context"]:showContext(zoneData[pZone].menuData)
                elseif pAction == "armory"  then
                    TriggerEvent("server-inventory-open", "15", "Shop")
                elseif pZone == "pillbox_checkin" then
					loadAnimDict("anim@narcotics@trash")
					TaskPlayAnim(PlayerPedId(),"anim@narcotics@trash", "drop_front",1.0, 1.0, -1, 1, 0, 0, 0, 0)
					local finished = exports["np-taskbar"]:taskBar(1700, (pAction > 0 and not isTriageEnabled) and "Paging a doctor" or "Checking Credentials")
					ClearPedSecondaryTask(PlayerPedId())
					if finished == 100 then
						if pAction > 0 and not isTriageEnabled then
							TriggerEvent("DoLongHudText","A doctor has been paged. Please take a seat and wait.",2)
							TriggerServerEvent("phone:triggerPager")
						else
							TriggerEvent("bed:checkin")
						end
					end
				end
            end

            Citizen.Wait(1)
        end
    end)
end

local function getDoctorsOnline()
	local doctors = RPC.execute("np-jobs:count", "doctor")
	return doctors
end

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function emsRevive()
	if not exports["np-jobs"]:getJob(false, "is_medic") then return end

	TriggerEvent("revive")
end

function emsHeal()
	if not exports["np-jobs"]:getJob(false, "is_medic") then return end

	TriggerEvent("ems:heal")
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)

	if not IsPedInAnyVehicle(PlayerPedId(), false) then
		for index, value in ipairs(players) do
			local target = GetPlayerPed(value)
			if target ~= ply then
				local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
				local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))

				if (closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
					closestPlayer = value
					closestPed = target
					closestDistance = distance
				end
			end
		end

		return closestPlayer, closestDistance, closestPed

	else
		TriggerEvent("DoLongHudText", "Inside Vehicle.", 2)
	end
end

function KneelMedic()
	loadAnimDict("amb@medic@standing@tendtodead@enter")
	loadAnimDict("amb@medic@standing@timeofdeath@enter")
	loadAnimDict("amb@medic@standing@tendtodead@idle_a")
	loadAnimDict("random@crash_rescue@help_victim_up")

	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@tendtodead@enter", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
	Citizen.Wait (1000)
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@tendtodead@idle_a", "idle_b", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
	Citizen.Wait (3000)
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@tendtodead@exit", "exit_flee", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
	Citizen.Wait (1000)
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@timeofdeath@enter", "enter", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
	Citizen.Wait (500)
	TaskPlayAnim(PlayerPedId(), "amb@medic@standing@timeofdeath@enter", "helping_victim_to_feet_player", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
end

--[[

    Events

]]

AddEventHandler("np-polyzone:enter", function(pZoneName, pZoneData)
	if pZoneName == "np-ems:zone" then
        if exports["np-base"]:getChar("job") == pZoneData.job then
            currentPrompt = pZoneData.zone
            exports["np-interaction"]:showInteraction(zoneData[pZoneData.zone].promptText)
            listenForKeypress(pZoneData.zone, pZoneData.action)
        end
	elseif pZoneName == "pillbox_checkin" then
		local doctors = getDoctorsOnline()
		local prompt = (doctors > 0 and not isTriageEnabled) and "[E] Page a doctor" or zoneData[pZoneName].promptText
		exports["np-interaction"]:showInteraction(prompt)
		listenForKeypress(pZoneName, doctors)
	end
end)

AddEventHandler("np-polyzone:exit", function(pZoneName, pZoneData)
	if pZoneName == "np-ems:zone" or pZoneName == "pillbox_checkin" then
        exports["np-interaction"]:hideInteraction()
        listening = false
        currentPrompt = nil
	end
end)

AddEventHandler("np-healthcare:handler", function(params)
	local eventData = params
    local location = string.match(currentPrompt, "(.-)_")

    if eventData == EVENTS.LOCKERS then
		local cid = exports["np-base"]:getChar("id")
		TriggerEvent("server-inventory-open", "1", ("personalStorage-%s-%s"):format(location, cid))
		TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "LockerOpen", 0.4)
	elseif eventData == EVENTS.CLOTHING then
		TriggerEvent("raid_clothes:openClothing", true, true)
	elseif eventData == EVENTS.SWITCHER then
		TriggerEvent("apartments:Logout")
	elseif eventData == EVENTS.ARMORY then
		TriggerEvent("server-inventory-open", "15", "Shop")
	end
end)

RegisterNetEvent("revive")
AddEventHandler("revive", function(t)
	local target, distance = GetClosestPlayer()

	if target and (distance ~= -1 and distance < 5) then
		KneelMedic()
		TriggerServerEvent("reviveGranted", GetPlayerServerId(target))
	else
		TriggerEvent("DoLongHudText", "No player near you (maybe get closer)!", 2)
	end
end)

RegisterNetEvent("ems:heal")
AddEventHandler("ems:heal", function()
	local target, distance = GetClosestPlayer()

	if target and (distance ~= -1 and distance < 5) then
		if not exports["np-jobs"]:getJob(false, "is_medic") then
			local bandages = exports["np-inventory"]:getQuantity("bandage")

			if bandages == 0 then
				return
			else
				TriggerEvent("inventory:removeItem", "bandage", 1)
			end
		end

		TriggerEvent("animation:PlayAnimation","layspike")
		TriggerServerEvent("ems:healplayer", GetPlayerServerId(target))
	end
end)

RegisterNetEvent("ems:stomachpump")
AddEventHandler("ems:stomachpump", function()
	local target, distance = GetClosestPlayer()

	if target and (distance ~= -1 and distance < 5) then
		local finished = exports["np-taskbar"]:taskBar(10000, "Inserting stomach pump 🤢", false, true)
		TriggerEvent("animation:PlayAnimation", "cpr")
		if finished == 100 then
			TriggerServerEvent("fx:puke", GetPlayerServerId(target))
		end
		TriggerEvent("animation:cancel")
	end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
	-- Checkin, pillbox
	exports["np-polyzone"]:AddCircleZone("pillbox_checkin", vector3(306.9, -595.03, 43.28), 0.4, {
		useZ=true,
	})

	-- Armory, pillbox
	exports["np-polyzone"]:AddCircleZone("np-ems:zone", vector3(306.28, -601.58, 43.28), 0.4, {
		useZ=true,
		data = {
            job = "ems",
            action = "armory",
            zone = "pillbox_armory",
        },
	})

	-- Clothing / Personal Lockers, Staff room, pillbox
	exports["np-polyzone"]:AddBoxZone("np-ems:zone", vector3(300.28, -598.83, 43.28), 3.2, 4.2, {
		heading=340,
		minZ=42.28,
		maxZ=45.68,
		data = {
            job = "ems",
            action = "context",
            zone = "pillbox_clothing_lockers_staff",
        },
	})

	-- Character Switcher, Staff room, pillbox
	exports["np-polyzone"]:AddBoxZone("np-ems:zone", vector3(296.16, -598.31, 43.28), 2.4, 1.2, {
		heading=250,
		minZ=42.28,
		maxZ=45.68,
		data = {
            job = "ems",
            action = "context",
            zone = "pillbox_clothing_lockers_staff",
        },
	})

	-- Character Switcher, Backroom pillbox
	exports["np-polyzone"]:AddBoxZone("np-ems:zone", vector3(340.82, -596.46, 43.28), 2.4, 1.2, {
		heading=160,
		minZ=42.28,
		maxZ=45.68,
		data = {
            job = "ems",
            action = "context",
            zone = "pillbox_character_switcher_backroom",
        },
	})

	-- Fire Department
	exports["np-polyzone"]:AddBoxZone("np-ems:zone", vector3(-629.79, -122.2, 39.22), 6.2, 4.2, {
		heading=353,
		minZ=38.22,
  		maxZ=41.62,
		data = {
            job = "fire_department",
            action = "context",
            zone = "fire_department",
        },
	})
end)

Citizen.CreateThread(function()
	RegisterCommand("+emsRevive", emsRevive, false)
	RegisterCommand("-emsRevive", function() end, false)
	exports["np-keybinds"]:registerKeyMapping("", "EMS", "Revive", "+emsRevive", "-emsRevive")

	RegisterCommand("+emsHeal", emsHeal, false)
	RegisterCommand("-emsHeal", function() end, false)
	exports["np-keybinds"]:registerKeyMapping("", "EMS", "Heal", "+emsHeal", "-emsHeal")

	RegisterCommand("+examineTarget", function()
		TriggerEvent("requestWounds")
	end, false)
	RegisterCommand("-examineTarget", function() end, false)
	exports["np-keybinds"]:registerKeyMapping("", "EMS", "Examine Target", "+examineTarget", "-examineTarget")
end)