RegisterNetEvent("np-idcard:show", function(pInfo)
    local src = source

	local cid = pInfo["ID"]
    local name = pInfo["Name"] .. " " .. pInfo["Surname"]
    local dob = pInfo["Date of Birth"]
    local gender = pInfo["Sex"]

    local image = MySQL.scalar.await([[
        SELECT image
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if not image then
        image = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/434px-Unknown_person.jpg"
    end

    local coords = GetEntityCoords(GetPlayerPed(src))
	local players = exports["np-infinity"]:GetNerbyPlayers(coords, 5)

	for i, v in ipairs(players) do
        TriggerClientEvent("np-idcard:open", v, name, dob, gender, cid, image)
    end
end)