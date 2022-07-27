RegisterNetEvent("CrashTackle")
AddEventHandler("CrashTackle", function(target)
	local src = source

    TriggerClientEvent("playerTackled", target, src)
end)