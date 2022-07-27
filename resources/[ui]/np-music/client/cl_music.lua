--[[

	Variables

]]

local musicPlaying = false

--[[

	Events

]]

AddEventHandler("np-inventory:itemUsed", function(item, info)
	if item == "musictape" then
		local info = json.decode(info)
		local url = string.gsub(info.url, "NULL", "?")

		if musicPlaying == false or musicPlaying ~= url then
			if not exports["np-inventory"]:hasEnoughOfItem("musicwalkman", 1, false, true) then
				TriggerEvent("DoLongHudText", "You need a walkman!", 2)
				return
			end

			musicPlaying = url

			SetNuiFocus(true, true)
			SendNUIMessage({ show = true, link = url })
		elseif musicPlaying == url then
			SetNuiFocus(true, true)
		end
	elseif item == "musicwalkman" then
		if musicPlaying ~= false then
			musicPlaying = false
			SetNuiFocus(false, false)
			SendNUIMessage({ show = false })
		end
	end
end)

AddEventHandler("np-inventory:itemCheck", function(itemId, hasItem)
    if not itemId == "musicwalkman" then return end

    if not hasItem and musicPlaying ~= false then
        musicPlaying = false
		SetNuiFocus(false, false)
		SendNUIMessage({ show = false })
    end
end)

AddEventHandler("np-music:addMusicEntry", function(pParams)
	if exports["np-groups"]:GroupRank(pParams.group) < 1 then
	  	TriggerEvent("DoLongHudText", "You can't do that.", 2)
	  	return
	end

	local input = exports["np-input"]:showInput({
		{
			icon = "music",
			label = "Soundcloud URL",
			name = "url",
		},
		{
			icon = "user",
			label = "Artist",
			name = "artist",
		},
		{
			icon = "user-edit",
			label = "Title",
			name = "title",
		},
	})

	if input["url"] and input["artist"] and input["title"] then
		RPC.execute("np-music:addMusicEntry", input, pParams.group)
	end
end)

AddEventHandler("np-music:createMusicTapes", function(pParams)
	if exports["np-groups"]:GroupRank(pParams.group) < 1 then
		TriggerEvent("DoLongHudText", "You can't do that.", 2)
		return
  	end

	local songOptionsRaw = RPC.execute("np-music:getSongOptions", pParams.group)

	local songOptions = {}
	for i, v in ipairs(songOptionsRaw) do
	  	if not songOptions[v.artist] then
			songOptions[v.artist] = {}
		end

		table.insert(songOptions[v.artist], v)
	end

	local context = {}
	for k, v in pairs(songOptions) do
		local _children = {}
		for i2, v2 in ipairs(v) do
			table.insert(_children, {
				title = v2.title,
				action = "np-music:createMusicTape",
				params = v2,
			})
		end

		table.insert(context, {
			title = k,
			children = _children,
		})
	end

	exports["np-context"]:showContext(context)
end)

AddEventHandler("np-music:createMusicTape", function(pParameters)
	local data = {
		["Artista"] = pParameters.artist,
		["Musica"] = pParameters.title,
		["url"] = pParameters.url,
		["_hideKeys"] = { "url" },
	}
	TriggerEvent("player:receiveItem", "musictape", 5, true, data)
end)

--[[

	NUI

]]

RegisterNUICallback("mouseToggle", function(data)
	SetNuiFocus(false, false)
end)