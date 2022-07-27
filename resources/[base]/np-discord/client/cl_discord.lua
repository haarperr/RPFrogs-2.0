Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(949909010386124840)

        local first_name = exports["np-base"]:getChar("first_name")
        local last_name = exports["np-base"]:getChar("last_name")

        if first_name then
            SetRichPresence("RPFrogs 2.0 | Dev Server " .. first_name .. " " .. last_name)
        end

        SetDiscordRichPresenceAsset("logo")
        SetDiscordRichPresenceAssetText("RPFrogs 2.0")
        SetDiscordRichPresenceAssetSmall("6e5")
        SetDiscordRichPresenceAssetSmallText("Dev Server")
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/rpfrog")
       -- SetDiscordRichPresenceAction(1, "Forum", "https://rare5m.cc")

		Citizen.Wait(60000)
	end
end)