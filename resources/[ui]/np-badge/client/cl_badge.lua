RegisterNetEvent("np-police:showBadge")
AddEventHandler("np-police:showBadge", function(pSource, pInventoryData)
	local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    local isInCar = veh ~= 0 and veh ~= nil

    Citizen.CreateThread(function()
       	Citizen.Wait(isInCar and 1000 or 4500)

		SendNUIMessage({
			action = "open",
			img = pInventoryData.image,
			job = pInventoryData.job,
			rank = pInventoryData.Rank,
			callsign = pInventoryData.Callsign,
			name = pInventoryData.Name .. " " .. pInventoryData.Surname,
		})

		Citizen.Wait(5600)

		SendNUIMessage({
			action = "close"
		})
    end)

	if GetPlayerServerId(PlayerId()) == pSource then
        if isInCar then return end

        TriggerEvent("attachItem", "police_badge")

        local animation = AnimationTask:new(PlayerPedId(), "normal", nil, 9500, "paper_1_rcm_alt1-7", "player_one_dual-7", 63)

        local result = Citizen.Await(animation:start(function(self)
            local vehicle = GetVehiclePedIsIn(self.ped, false)

            if not exports["np-base"]:getVar("dead") and vehicle ~= 0 then
              	TaskLeaveVehicle(self.ped, vehicle, 1)
            elseif exports["np-base"]:getVar("dead") and vehicle ~= 0 then
              	ClearPedTasksImmediately(self.ped)
              	self:abort()
            elseif exports["np-base"]:getVar("dead") or IsPedRagdoll(self.ped) then
              	self:abort()
            end
        end))

        TriggerEvent("destroyProp")
    end
end)