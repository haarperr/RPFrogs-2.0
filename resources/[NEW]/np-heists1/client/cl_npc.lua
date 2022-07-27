--[[

    Variables

]]

local recentRobs = {}
local lastRobbery = GetGameTimer()

--[[

    Events

]]

RegisterNetEvent("robEntity")
AddEventHandler("robEntity", function(pEntity, pVehicle)
	local robbingEntity = true

    local pedOwner = NetworkGetEntityOwner(pEntity)
    if pedOwner == PlayerId() then
        DecorSetBool(pEntity, "ScriptedPed", true)
    else
        TriggerServerEvent("np:peds:decor", GetPlayerServerId(pedOwner), PedToNet(usingped))
    end

    TaskTurnPedToFaceEntity(pEntity, PlayerPedId(), 3.0)
    TaskSetBlockingOfNonTemporaryEvents(pEntity, true)
    SetPedFleeAttributes(pEntity, 0, false)
    SetPedCombatAttributes(pEntity, 17, 1)

    SetPedSeeingRange(pEntity, 0.0)
    SetPedHearingRange(pEntity, 0.0)
    SetPedAlertness(pEntity, 0)
    SetPedKeepTask(pEntity, true)

    RequestAnimDict("missfbi5ig_22")
    while not HasAnimDictLoaded("missfbi5ig_22") do
        Citizen.Wait(0)
	end

	local robberySuccessful = true

	while robbingEntity do
		Citizen.Wait(100)

        if not IsEntityPlayingAnim(pEntity, "missfbi5ig_22", "hands_up_anxious_scientist", 3) then
			TaskPlayAnim(pEntity, "missfbi5ig_22", "hands_up_anxious_scientist", 5.0, 1.0, -1, 1, 0, 0, 0, 0)
			Citizen.Wait(1000)
		end

		local pedCrds = GetEntityCoords(PlayerPedId())
		local entCrds = GetEntityCoords(pEntity)

		if #(pedCrds - entCrds) > 15.0 then
			robbingEntity = false
			robberySuccessful = false
		end

		if math.random(1000) < 30 and #(pedCrds - entCrds) < 7.0 then
			if pVehicle ~= 0 then
				TriggerEvent("DoLongHudText", "Did you get the vehicle keys")
				SetVehicleHasBeenOwnedByPlayer(pVehicle, true)
                TriggerEvent("keys:addNew", pVehicle)
			end

			if robberySuccessful then
				if GetGameTimer() > lastRobbery then
					lastRobbery = GetGameTimer() + 120000

					TriggerServerEvent("np-heists:complete", math.random(5, 30))

					RequestAnimDict("mp_common")
		    		while not HasAnimDictLoaded("mp_common") do
		        		Citizen.Wait(0)
		    		end
		    		TaskPlayAnim(pEntity, "mp_common", "givetake1_a", 1.0, 1.0, -1, 1, 0, 0, 0, 0)

					Citizen.Wait(1200)
				else
					TriggerEvent("DoLongHudText", "I have nothing", 2)
				end
			end

			robbingEntity = false
		end
	end

	Citizen.Wait(2000)

	ClearPedTasks(pEntity)
	TaskReactAndFleePed(pEntity, PlayerPedId())

	Citizen.Wait(math.random(5000, 15000))

    if pVehicle ~= 0 then
		TriggerEvent("civilian:alertPolice", 8.0, "personRobbed", pVehicle)
	else
		TriggerEvent("civilian:alertPolice", 8.0, "personRobbed", 0)
	end

	if #recentRobs > 20 then
		recentRobs = {}
	end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1)

		local aiming, ent = GetEntityPlayerIsFreeAimingAt(PlayerId())

        if aiming then
            local pedCrds = GetEntityCoords(PlayerPedId())
            local entCrds = GetEntityCoords(ent)

            local pedType = GetPedType(ent)
			local animalped = false
			if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then
                animalped = true
            end

            if DecorGetInt(ent, 'NPC_ID') == 0 and not animalped and #(pedCrds - entCrds) < 5.0 and not recentRobs["rob" .. ent] and not IsPedAPlayer(ent) and not IsEntityDead(ent) and not IsPedDeadOrDying(ent, 1) and IsPedArmed(PlayerPedId(), 6) and not IsPedArmed(ent, 7) and not IsEntityPlayingAnim(ent, "missfbi5ig_22", "hands_up_anxious_scientist", 3) then
				recentRobs["rob" .. ent] = true
				local veh = 0

                if IsPedInAnyVehicle(ent, false) then
					veh = GetVehiclePedIsIn(ent,false)

                    TaskLeaveVehicle(ent, veh, 256)
					while IsPedInAnyVehicle(ent, false) do
						Citizen.Wait(0)
					end

					SetPedCombatAttributes(ent, 46, true)
					SetBlockingOfNonTemporaryEvents(ent, true)
					ResetPedLastVehicle(ent)

					TriggerEvent("robEntity",ent,veh)

					Citizen.Wait(1000)
				else
                    TriggerEvent("robEntity",ent,veh)

                    Citizen.Wait(1000)
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)