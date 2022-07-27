function DumpTable(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == "table" then
		local s = ""
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = "{\n"
		for k,v in pairs(table) do
			if type(k) ~= "number" then k = "'"..k.."'" end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. "["..k.."] = " .. DumpTable(v, nb + 1) .. ",\n"
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. "}"
	else
		return tostring(table)
	end
end

RPC.register("np-debug:getInfosClient", function()
    local playerId = PlayerId()
    local playerPed = PlayerPedId()
    local serverId = GetPlayerServerId(playerId)

    local data = {
        isActive = MumbleIsActive(),
        isConnected = MumbleIsConnected(),
    }

    return data
end)

RegisterCommand("debugMumble", function(src, args)
    local playerId = tonumber(args[1])

    if not playerId then return end

    local data = RPC.execute("np-debug:getInfosServer", playerId)

    print(DumpTable(data))
end)