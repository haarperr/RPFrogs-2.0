--[[

    Variables

]]

DecorRegister("CurrentJob", 3)

--[[

    Events

]]

RegisterNetEvent("np-jobs:jobChanged")
AddEventHandler("np-jobs:jobChanged", function(job)
    DecorSetInt(PlayerPedId(), "CurrentJob", jobDecor(job))
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
	Citizen.Wait(500)

	JOBS = RPC.execute("np-jobs:getJobs")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		if not DecorExistOn(PlayerPedId(), "CurrentJob") then
			DecorSetInt(PlayerPedId(), "CurrentJob", jobDecor(exports["np-base"]:getChar("job")))
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1800000)

		local job = exports["np-base"]:getChar("job")
		local paycheck = exports["np-groups"]:GroupRankInfo(job, "paycheck") or JOBS[job]["paycheck"]

		if job and JOBS[job] then
			TriggerServerEvent("np-jobs:paycheck", "Paycheck Job: " .. JOBS[job]["name"], paycheck)
		end
	end
end)