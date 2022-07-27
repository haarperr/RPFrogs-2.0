local isExercising = false

RegisterNetEvent("np-healthcare:yoga")
AddEventHandler("np-healthcare:yoga", function(pArgs, pEntity, pContext)
	TaskTurnPedToFaceEntity(PlayerPedId(), pEntity, -1)
	Wait(50)
	local animation = AnimationTask:new(PlayerPedId(), "normal", "Breathe in..", 30000, "WORLD_HUMAN_YOGA", nil, nil)
	local result = animation:start()
	result:next(function (data)
		if data == 100 then
			TriggerEvent("client:newStress", false, math.ceil(450))
		else
			TriggerEvent("DoLongHudText", "You just ruined your chakra.")
		end
	end)
end)

RegisterNetEvent("np-healthcare:exercise")
AddEventHandler("np-healthcare:exercise", function(pArgs, pEntity, pContext)
	local function getExerciseAnimation(pModel)
		if pModel == `prop_weight_squat` then
			return "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"
		elseif pModel == `prop_beach_bars_02` then
			return "amb@prop_human_muscle_chin_ups@male@base", "base"
		end
	end

	TaskTurnPedToFaceEntity(PlayerPedId(), pEntity, -1)
	Wait(50)
	local exerciseDict, exerciseAnim = getExerciseAnimation(pContext.model)
	local animation = AnimationTask:new(PlayerPedId(), "normal", "Getting buff as hell", 30000, exerciseDict, exerciseAnim, exerciseAnim and 9 or nil)
	local result = animation:start()
	result:next(function (data)
		if data == 100 then
			TriggerEvent("client:newStress", false, math.ceil(450))
		else
			TriggerEvent("DoLongHudText", "No gains for you bro")
		end
	end)
end)