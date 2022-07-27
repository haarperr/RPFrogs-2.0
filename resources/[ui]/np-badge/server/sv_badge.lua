RegisterServerEvent("np-police:showBadge", function(pInventoryData)
	local src = source

	local coords = GetEntityCoords(GetPlayerPed(src))
	local players = exports["np-infinity"]:GetNerbyPlayers(coords, 5)

	for i, v in ipairs(players) do
        TriggerClientEvent("np-police:showBadge", v, src, pInventoryData)
    end
end)
