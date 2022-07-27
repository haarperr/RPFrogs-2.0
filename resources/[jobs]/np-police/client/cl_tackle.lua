--[[

    Variables

]]

local TimerEnabled = false

--[[

    Functions

]]

function plyTackel()
	if not exports["np-base"]:getVar("handcuffed") and GetLastInputMethod(2) then
		local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
		if not isInVeh and GetEntitySpeed(PlayerPedId()) > 2.5 then
			TryTackle()
		end
	end
end

function TryTackle()
    if not TimerEnabled then
        local t, distance = GetClosestPlayer()

        if distance ~= -1 and distance < 2 then
            TriggerServerEvent("CrashTackle", GetPlayerServerId(t))
            TriggerEvent("animation:tacklelol")

            TimerEnabled = true
            Citizen.Wait(6000)
            TimerEnabled = false
        else
            TimerEnabled = true
            Citizen.Wait(1000)
            TimerEnabled = false
        end
    end
end

--[[

    Events

]]

RegisterNetEvent("playerTackled")
AddEventHandler("playerTackled", function(target)
	TimerEnabled = true

	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict("missmic2ig_11")
	while not HasAnimDictLoaded("missmic2ig_11") do
		Citizen.Wait(1)
	end

	AttachEntityToEntity(PlayerPedId(), targetPed, 11816, 0.25, 0.5, 0.0, 0.5, 0.5, 180.0, false, false, false, false, 2, false)
	TaskPlayAnim(PlayerPedId(), "missmic2ig_11", "mic_2_ig_11_intro_p_one", 8.0, -8.0, 3000, 0, 0, false, false, false)

	Citizen.Wait(3000)
	DetachEntity(GetPlayerPed(-1), true, false)

	SetPedToRagdoll(PlayerPedId(), math.random(3500,5000), math.random(3500,5000), 0, 0, 0, 0)

	Citizen.Wait(6000)
	TimerEnabled = false
end)

RegisterNetEvent("animation:tacklelol")
AddEventHandler("animation:tacklelol", function()
	RequestAnimDict("missmic2ig_11")
	while not HasAnimDictLoaded("missmic2ig_11") do
		Citizen.Wait(1)
	end

	TaskPlayAnim(PlayerPedId(), "missmic2ig_11", "mic_2_ig_11_intro_goon", 8.0, -8.0, 3000, 0, 0, false, false, false)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "Player", "Tackle", "+plyTackel", "-plyTackel", "G")
    RegisterCommand("+plyTackel", plyTackel, false)
    RegisterCommand("-plyTackel", function() end, false)
end)

Citizen.CreateThread(function()
    while true do
        if TimerEnabled then
			DisableControlAction(1, 140, true) --Disables Melee Actions
			DisableControlAction(1, 141, true) --Disables Melee Actions
			DisableControlAction(1, 142, true) --Disables Melee Actions
			DisableControlAction(1, 37, true) --Disables INPUT_SELECT_WEAPON (tab) Actions
			DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
		end

        Citizen.Wait(1)
    end
end)