--[[

    Events

]]

RegisterNetEvent("np-chat:local", function(id, name, message, coords)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

    if sonid == monid then
		TriggerEvent("chatMessage", "", {205, 205, 205}, "(( [" .. id .. "] " .. name .. ": " .. message .. " ))")
	elseif #(GetEntityCoords(PlayerPedId()) - coords) < 20 then
		TriggerEvent("chatMessage", "", {205, 205, 205}, "(( [" .. id .. "] " .. name .. ": " .. message .. " ))")
	end
end)

RegisterNetEvent("np-chat:me", function(id, name, message, coords)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

	local lastLetter = string.sub(message, string.len(message))

	local hasFinalPoint = lastLetter == "."
	local hasQuestionMark = lastLetter == "?"
	local hasExclamationMark = lastLetter == "!"

	if not hasFinalPoint and not hasQuestionMark and not hasExclamationMark then
		message = message .. "."
	end

	if sonid == monid then
		TriggerEvent("chatMessage", "", {170, 102, 204}, "*" .. name .." " .. message)
	elseif #(GetEntityCoords(PlayerPedId()) - coords) < 20 then
		TriggerEvent("chatMessage", "", {170, 102, 204}, "*" .. name .." " .. message)
	end
end)

RegisterNetEvent("np-chat:do", function(id, name, message, coords)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

	local message = (message:gsub("^%l", string.upper))

	local lastLetter = string.sub(message, string.len(message))

	local hasFinalPoint = lastLetter == "."
	local hasQuestionMark = lastLetter == "?"
	local hasExclamationMark = lastLetter == "!"

	if not hasFinalPoint and not hasQuestionMark and not hasExclamationMark then
		message = message .. "."
	end

    if sonid == monid then
		TriggerEvent("chatMessage", "", {170, 102, 204}, "*" .. message .. " (( " .. name .. " ))")
	elseif #(GetEntityCoords(PlayerPedId()) - coords) < 20 then
		TriggerEvent("chatMessage", "", {170, 102, 204}, "*" .. message .. " (( " .. name .. " ))")
	end
end)

RegisterNetEvent("np-chat:say", function(id, name, message, coords)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

	local message = (message:gsub("^%l", string.upper))

	local lastLetter = string.sub(message, string.len(message))

	local hasFinalPoint = lastLetter == "."
	local hasQuestionMark = lastLetter == "?"
	local hasExclamationMark = lastLetter == "!"

	if not hasFinalPoint and not hasQuestionMark and not hasExclamationMark then
		message = message .. "."
	end

    if sonid == monid then
		TriggerEvent("chatMessage", "", {205, 205, 205}, name .. " diz: " .. message)
	elseif #(GetEntityCoords(PlayerPedId()) - coords) < 20 then
		TriggerEvent("chatMessage", "", {205, 205, 205}, name .. " diz: " .. message)
	end
end)