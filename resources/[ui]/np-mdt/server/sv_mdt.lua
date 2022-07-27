--[[

    Variables

]]

local usersRadios = {}
local penalCode = {}
local penalCodeCategorys = {}

--[[

    Main

]]

function getJob(src)
    local job = exports["np-base"]:getChar(src, "job")

    if exports["np-jobs"]:getJob(job, "is_police") then
        return "police"
    elseif exports["np-jobs"]:getJob(job, "is_medic") then
        return "ems"
    elseif exports["np-jobs"]:getJob(job, "is_doj") then
        return "doj"
    end

    return "unemployed"
end

--[[

    Bulletins

]]

RPC.register("np-mdt:dashboardBulletin", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT b.id, b.title, b.description, b.time, CONCAT(c.first_name," ",c.last_name) AS author
        FROM mdt_bulletins b
        LEFT JOIN characters c ON c.id = b.cid
        WHERE b.job = ?
    ]],
    { job })

    return result
end)

RegisterServerEvent("np-mdt:newBulletin")
AddEventHandler("np-mdt:newBulletin", function(title, info, time)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

	local insertId = MySQL.insert.await([[
        INSERT INTO mdt_bulletins (cid, title, description, job, time)
        VALUES (?, ?, ?, ?, ?)
    ]],
    { cid, title, info, job, time })

    if not insertId or insertId < 1 then return end

    local bulletin = {
        id = insertId,
        title = title,
        info = info,
        time = time,
        author = name
    }

    TriggerClientEvent("np-mdt:newBulletin", -1, src, bulletin, job)
    TriggerEvent("np-mdt:newLog", name .. " Opened a new Bulletin: Title " .. title .. ", Info " .. info, job, time)
end)

RegisterServerEvent("np-mdt:deleteBulletin")
AddEventHandler("np-mdt:deleteBulletin", function(id)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    local title = MySQL.scalar.await([[
        SELECT title
        FROM mdt_bulletins
        WHERE id = ?
    ]],
    { id })

    MySQL.update.await([[
        DELETE FROM mdt_bulletins
        WHERE id = ?
    ]],
    { id })

    TriggerClientEvent("np-mdt:deleteBulletin", -1, src, id, job)
    TriggerEvent("np-mdt:newLog", "A bulletin was deleted by " .. name .. " with the title: " .. title .. "!", job)
end)

--[[

    Messages

]]

RPC.register("np-mdt:dashboardMessages", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT m.message, m.time, CONCAT(c.first_name," ",c.last_name) AS author, c.gender, p.image
        FROM mdt_messages m
        LEFT JOIN characters c ON c.id = m.cid
        LEFT JOIN mdt_profiles p ON p.cid = m.cid
        WHERE m.job = ?
        ORDER BY m.id DESC
        LIMIT 50
    ]],
    { job })

    for i, v in ipairs(result) do
        result[i].image = profilePic(v.gender, v.image)
    end

    return result
end)

RegisterServerEvent("np-mdt:refreshDispatchMsgs")
AddEventHandler("np-mdt:refreshDispatchMsgs", function()
    local src = source

    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT message, time, CONCAT(c.first_name," ",c.last_name) AS name, c.gender, p.image
        FROM mdt_messages m
        LEFT JOIN characters c ON c.id = m.cid
        LEFT JOIN mdt_profiles p ON p.cid = m.cid
        WHERE m.job = ?
        ORDER BY m.id DESC
        LIMIT 50
    ]],
    { job })

    for i, v in ipairs(result) do
        result[i].image = profilePic(v.gender, v.image)
    end

    TriggerClientEvent("np-mdt:dashboardMessages", src, ReverseTable(result))
end)

RegisterServerEvent("np-mdt:sendMessage")
AddEventHandler("np-mdt:sendMessage", function(message, time)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    MySQL.insert.await([[
        INSERT INTO mdt_messages (cid, message, job, time)
        VALUES (?, ?, ?, ?)
    ]],
    { cid, message, job, time })

    local image = MySQL.scalar.await([[
        SELECT image
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    local lastMsg = {
        name = name,
        image = profilePic(exports["np-base"]:getChar(src, "gender"), image),
        message = message,
        time = time,
    }

    TriggerClientEvent("np-mdt:dashboardMessage", -1, lastMsg, job)
end)

--[[

    Units

]]

RPC.register("np-mdt:getActiveUnits", function(src)
    local police, sheriff, state_police, park_ranger, ems, doj = {}, {}, {}, {}, {}, {}

    local users = exports["np-base"]:getUsers()

    for user, vars in pairs(users) do
        local character = exports["np-base"]:getChar(user)

        if character then
		    local job = character.job

            if exports["np-jobs"]:getJob(job, "is_emergency") or exports["np-jobs"]:getJob(job, "is_doj") then
                local name = character.first_name .. " " .. character.last_name
                local callSign = exports["np-jobs"]:getCallsign(user, job)

                if job == "police" or job == "cid" then
                    table.insert(police, {
                        duty = 1,
                        cid = character.id,
                        radio = usersRadios[character.id] or nil,
                        callsign = callSign,
                        name = name,
                    })
                elseif job == "sheriff" then
                    table.insert(sheriff, {
                        duty = 1,
                        cid = character.id,
                        radio = usersRadios[character.id] or nil,
                        callsign = callSign,
                        name = name,
                    })
                elseif job == "state_police" then
                    table.insert(state_police, {
                        duty = 1,
                        cid = character.id,
                        radio = usersRadios[character.id] or nil,
                        callsign = callSign,
                        name = name,
                    })
                elseif job == "park_ranger" then
                    table.insert(park_ranger, {
                        duty = 1,
                        cid = character.id,
                        radio = usersRadios[character.id] or nil,
                        callsign = callSign,
                        name = name,
                    })
                elseif exports["np-jobs"]:getJob(job, "is_medic") then
                    table.insert(ems, {
                        duty = 1,
                        cid = character.id,
                        radio = usersRadios[character.id] or nil,
                        callsign = callSign,
                        name = name,
                    })
                elseif exports["np-jobs"]:getJob(job, "is_doj") then
                    table.insert(doj, {
                        duty = 1,
                        cid = character.id,
                        radio = usersRadios[character.id] or nil,
                        callsign = (exports["np-groups"]:rankInfos("doj", exports["np-groups"]:getRank("doj", 0, character.id)))["name"],
                        name = name,
                    })
                end
            end
        end
    end

    return police, sheriff, state_police, park_ranger, ems, doj
end)

RegisterServerEvent("np-mdt:setWaypoint:unit")
AddEventHandler("np-mdt:setWaypoint:unit", function(cid)
    local src = source

    local player = exports["np-base"]:getSidWithCid(cid)
    if player == 0 then return end

    local coords = GetEntityCoords(GetPlayerPed(src))

    TriggerClientEvent("np-mdt:setWaypoint:unit", src, coords)
end)

RegisterServerEvent("np-mdt:setRadio")
AddEventHandler("np-mdt:setRadio", function(radio)
    local src = source
    local cid = exports["np-base"]:getChar(src, "id")

    usersRadios[cid] = radio
end)

RegisterServerEvent("np-mdt:setRadioTo")
AddEventHandler("np-mdt:setRadioTo", function(cid, radio)
    local src = source
    local target = exports["np-base"]:getSidWithCid(cid)

    if target == 0 then return end

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local nameTarget = exports["np-base"]:getChar(target, "first_name") .. " " .. exports["np-base"]:getChar(target, "last_name")

    TriggerClientEvent("DoLongHudText", src, "The frequency of" .. nameTarget .. " was set to " .. radio)
    TriggerClientEvent("np-mdt:setRadio", target, tonumber(radio), name)
end)

RegisterServerEvent("np-mdt:setCallsign")
AddEventHandler("np-mdt:setCallsign", function(cid, callsign)
    local src = source

    local job = exports["np-base"]:getChar(src, "job")

    exports["np-jobs"]:setCallsign(cid, job, callsign)
end)

RegisterNetEvent("np-mdt:toggleDuty")
AddEventHandler("np-mdt:toggleDuty", function(cid, status)

end)

--[[

    Calls

]]

RPC.register("np-mdt:getCalls", function(src, pCallId)
    local src = source

    local calls = exports["np-dispatch"]:getCalls()

    return calls
end)

RegisterNetEvent("np-mdt:removeCall", function(pCallId)
    local src = source

    local removed = exports["np-dispatch"]:removeCall(pCallId)
    if removed then
        TriggerClientEvent("np-mdt:removeCall", -1, pCallId)
    end
end)

RegisterServerEvent("np-mdt:callAttach")
AddEventHandler("np-mdt:callAttach", function(callid)
    local src = source

    local units = exports["np-dispatch"]:addUnit(src, callid)

    TriggerClientEvent("np-mdt:callAttach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:callDetach")
AddEventHandler("np-mdt:callDetach", function(callid)
    local src = source

    local units = exports["np-dispatch"]:removeUnit(src, callid)

    TriggerClientEvent("np-mdt:callDetach", -1, callid, units)
end)

RPC.register("np-mdt:attachedUnits", function(src, pCallId)
    local src = source

    local units = exports["np-dispatch"]:getUnits(pCallId)

    return units
end)

RegisterServerEvent("np-mdt:callDragAttach")
AddEventHandler("np-mdt:callDragAttach", function(callid, cid)
    local src = source

    local player = exports["np-base"]:getSidWithCid(cid)
    if player == 0 then return end

    local units = exports["np-dispatch"]:addUnit(player, callid)

    TriggerClientEvent("np-mdt:callAttach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:callDispatchDetach")
AddEventHandler("np-mdt:callDispatchDetach", function(callid, cid)
    local src = source

    local player = exports["np-base"]:getSidWithCid(cid)
    if player == 0 then return end

    local units = exports["np-dispatch"]:removeUnit(player, callid)

    TriggerClientEvent("np-mdt:callDetach", -1, callid, units)
end)

RegisterServerEvent("np-mdt:setDispatchWaypoint")
AddEventHandler("np-mdt:setDispatchWaypoint", function(callid, cid)
    local src = source

    local player = exports["np-base"]:getSidWithCid(cid)
    if player == 0 then return end

    local coords = GetEntityCoords(GetPlayerPed(src))

    TriggerClientEvent("np-mdt:setWaypoint:unit", src, coords)
end)

RegisterServerEvent("np-mdt:getCallResponses")
AddEventHandler("np-mdt:getCallResponses", function(callid)
    local src = source

    local responses = exports["np-dispatch"]:getCallReponses(callid)

    TriggerClientEvent("np-mdt:getCallResponses", src, responses, callid)
end)

RegisterServerEvent("np-mdt:sendCallResponse")
AddEventHandler("np-mdt:sendCallResponse", function(message, time, callid, name)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local responded = exports["np-dispatch"]:sendCallResponse(name, callid, message, time)

    if responded then
        TriggerClientEvent("np-mdt:sendCallResponse", src, message, time, callid, name)
    end
end)

--[[

    Warrants

]]

RPC.register("np-mdt:getWarrants", function(src)
    local WarrantData = {}

    local result = MySQL.query.await([[
        SELECT *
        FROM mdt_incidents
    ]])

    for i, v in ipairs(result) do
        for i2, v2 in ipairs(json.decode(v.associated)) do
            if v2.warrant == true then
                local name = MySQL.scalar.await([[
                    SELECT CONCAT(first_name," ",last_name)
                    FROM characters
                    WHERE id = ?
                ]],
                { v2.cid })

                table.insert(WarrantData, {
                    cid = v2.cid,
                    linkedincident = v.id,
                    name = name,
                    reporttitle = v.title,
                    time = v.time,
                })
            end
        end
    end

    return WarrantData
end)

--[[

    Profiles

]]

function profilePic(pGender, pImage)
	if pImage and pImage ~= "" then
        return pImage
    end

    if pGender == 1 then
        return "img/female.png"
    else
        return "img/male.png"
    end
end

RPC.register("np-mdt:searchProfile", function(src, pName)
    local queryData = string.lower("%" .. pName .. "%")
    local result = MySQL.query.await([[
        SELECT c.id, c.first_name, c.last_name, c.gender, c.licenses, p.image, p.description
        FROM characters c
        LEFT JOIN mdt_profiles p ON p.cid = c.id
        WHERE LOWER(c.first_name) LIKE ? OR LOWER(c.id) LIKE ? OR LOWER(c.last_name) LIKE ? OR CONCAT(LOWER(c.first_name), " ", LOWER(c.last_name), " ", LOWER(c.id)) LIKE ? OR LOWER(p.dna) LIKE ?
        ORDER BY c.first_name DESC
    ]],
    { queryData, queryData, queryData, queryData, queryData })

	for i, v in ipairs(result) do
        result[i].identifier  = v.id
        result[i].firstname = v.first_name
        result[i].lastname  = v.last_name
        result[i].policemdtinfo = v.description
        result[i].warrant = false
        result[i].convictions = 0
        result[i].cid = v.id

        result[i].pp = profilePic(result[i].gender, result[i].image)

        local licenses = json.decode(v.licenses)

        for k2, v2 in pairs(licenses) do
            if k2 == "weapon" and v2 == 1 then
                result[i].Weapon = true
            end
            if k2 == "driver" and v2 == 1 then
                result[i].Drivers = true
            end
            if k2 == "hunting" and v2 == 1 then
                result[i].Hunting = true
            end
            if k2 == "fishing" and v2 == 1 then
                result[i].Fishing = true
            end
            if k2 == "bar" and v2 == 1 then
                result[i].Bar = true
            end
            if k2 == "business" and v2 == 1 then
                result[i].Business = true
            end
            if k2 == "pilot" and v2 == 1 then
                result[i].Pilot = true
            end
        end
    end

	return result
end)

RPC.register("np-mdt:getProfileData", function(src, pCid)
    local result = MySQL.query.await([[
        SELECT c.id, c.first_name, c.last_name, c.dob, c.phone, c.gender, c.job, c.licenses, p.dna, p.image, p.description, p.tags, p.gallery
        FROM characters c
        LEFT JOIN mdt_profiles p ON p.cid = c.id
        WHERE c.id = ?
    ]],
    { pCid })

    local vehicles = MySQL.query.await([[
        SELECT plate, model
        FROM vehicles
        WHERE cid = ?
    ]],
    { pCid })

    local houses = MySQL.query.await([[
        SELECT hid
        FROM housing
        WHERE cid = ?
    ]],
    { pCid })

    for i, v in ipairs(houses) do
        local houseInfo = exports["np-housing"]:getHouse(v.hid)

        houses[i] = {
            house_id = v.hid,
            house_name = houseInfo.street
        }
    end

    local weapons = MySQL.query.await([[
        SELECT serial
        FROM mdt_weapons
        WHERE cid = ?
    ]],
    { pCid })

    for i, v in ipairs(weapons) do
        weapons[i] = v.serial
    end

    local incidents = MySQL.query.await([[
        SELECT associated
        FROM mdt_incidents
    ]])

    local object = {
        cid = result[1].id,
        firstname = result[1].first_name,
        lastname = result[1].last_name,
        job = exports["np-jobs"]:getJob(result[1].job, "name"),
        dateofbirth = result[1]["dob"],
        phone = result[1]["phone"],
        dna = "Unknown",
        profilepic = profilePic(result[1].gender, result[1].image),
        policemdtinfo = "",
        Weapon = false,
        Drivers = false,
        Hunting = false,
        Fishing = false,
        Bar = false,
        Business = false,
        Pilot = false,
        tags = {},
        weapons = weapons,
        vehicles = vehicles,
        properties = houses,
        gallery = {},
        convictions = {}
    }

    if result[1].dna ~= nil then
        object.dna = result[1].dna
    end

    if result[1].description ~= nil then
        object.policemdtinfo = result[1].description
    end

    if result[1].tags ~= nil then
        object.tags = json.decode(result[1].tags)
    end

    if result[1].gallery ~= nil then
        object.gallery = json.decode(result[1].gallery)
    end

    local _charges = {}

    for i, v in ipairs(incidents) do
        for i2, v2 in ipairs(json.decode(v.associated)) do
            if v2.cid == result[1]["id"] then
                for i3, v3 in ipairs(v2.charges) do
                    if _charges[v3] then
                        _charges[v3] = _charges[v3] + 1
                    else
                        _charges[v3] = 1
                    end
                end
            end
        end
    end

    local charges = {}
    for charge, count in pairs(_charges) do
        table.insert(charges, count .. "x " .. charge)
    end

    object.convictions = charges

    local licenses = json.decode(result[1].licenses)
    for k, v in pairs(licenses) do
        if k == "weapon" and v == 1 then
            object.Weapon = true
        end
        if k == "driver" and v == 1 then
            object.Drivers = true
        end
        if k == "hunting" and v == 1 then
            object.Hunting = true
        end
        if k == "fishing" and v == 1 then
            object.Fishing = true
        end
        if k == "bar" and v == 1 then
            object.Bar = true
        end
        if k == "business" and v == 1 then
            object.Business = true
        end
        if k == "pilot" and v == 1 then
            object.Pilot = true
        end
    end

    return object
end)

RegisterServerEvent("np-mdt:saveProfile")
AddEventHandler("np-mdt:saveProfile", function(image, description, cid, fname, lname)
    if not cid then return end

    local src = source

    if not image then image = "" end
    if not description then description = "" end

    local result = MySQL.scalar.await([[
        SELECT id
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

	if result then
        MySQL.update.await([[
            UPDATE mdt_profiles
            SET image = ?, description = ?
            WHERE cid = ?
        ]],
        { image, description, cid })
	else
		MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { cid, image, description, "{}", "{}" })
	end
end)

RegisterServerEvent("np-mdt:updateLicense")
AddEventHandler("np-mdt:updateLicense", function(identifier, type, status)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local time = os.date()

    if status == "revoke" then
        action = "Revoked"
        status = 0
    else
        action = "Given"
        status = 1
    end

    TriggerEvent("np-mdt:newLog", name .. " " .. action .. " licenses type: " .. (type:gsub("^%l", string.upper)) .. " Edited Citizen Id: " .. identifier, time)

    exports["np-licenses"]:updateLicense(0, type, status, identifier)
end)

RegisterServerEvent("np-mdt:newTag")
AddEventHandler("np-mdt:newTag", function(cid, tag)
    local result = MySQL.scalar.await([[
        SELECT tags
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local tags = json.decode(result)

        table.insert(tags, tag)

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET tags = ?
            WHERE cid = ?
        ]],
        { json.encode(tags), cid })
    else
        local tags = {}

        table.insert(tags, tag)

        MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { cid, "", "", json.encode(tags), "{}" })
    end
end)

RegisterServerEvent("np-mdt:removeProfileTag")
AddEventHandler("np-mdt:removeProfileTag", function(cid, tag)
    local result = MySQL.scalar.await([[
        SELECT tags
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local tags = json.decode(result)

        for i, v in ipairs(tags) do
            if v == tag then
                table.remove(tags, i)
            end
        end

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET tags = ?
            WHERE cid = ?
        ]],
        { json.encode(tags), cid })
    end
end)

RegisterServerEvent("np-mdt:addGalleryImg")
AddEventHandler("np-mdt:addGalleryImg", function(cid, url)
    local result = MySQL.scalar.await([[
        SELECT gallery
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local gallery = json.decode(result)

        table.insert(gallery, url)

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET gallery = ?
            WHERE cid = ?
        ]],
        { json.encode(gallery), cid })
    else
        local gallery = {}

        table.insert(gallery, url)

        MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { cid, "", "", "{}", json.encode(gallery) })
    end
end)

RegisterServerEvent("np-mdt:removeGalleryImg")
AddEventHandler("np-mdt:removeGalleryImg", function(cid, url)
    local result = MySQL.scalar.await([[
        SELECT gallery
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        local gallery = json.decode(result)

        for i, v in ipairs(gallery) do
            if v == url then
                table.remove(gallery, i)
            end
        end

        MySQL.update.await([[
            UPDATE mdt_profiles
            SET gallery = ?
            WHERE cid = ?
        ]],
        { json.encode(gallery), cid })
    end
end)

RegisterNetEvent("np-mdt:dnaEdit", function(cid, dna)
    local result = MySQL.scalar.await([[
        SELECT cid
        FROM mdt_profiles
        WHERE cid = ?
    ]],
    { cid })

    if result then
        MySQL.update.await([[
            UPDATE mdt_profiles
            SET dna = ?
            WHERE cid = ?
        ]],
        { dna, cid })
    else
        MySQL.insert.await([[
            INSERT INTO mdt_profiles (cid, image, description, tags, gallery, dna)
            VALUES (?, ?, ?, ?, ?, ?)
        ]],
        { cid, "", "", "{}", "{}", dna })
    end
end)

--[[

    Incidents

]]

RPC.register("np-mdt:getAllIncidents", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT i.id, i.title, i.time, i.job, CONCAT(c.first_name," ",c.last_name) AS author
        FROM mdt_incidents i
        LEFT JOIN characters c ON c.id = i.cid
        WHERE i.job = ?
    ]],
    { job })

    return result
end)

RPC.register("np-mdt:searchIncidents", function(src, pId)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT i.id, i.title, i.time, i.job, CONCAT(c.first_name," ",c.last_name) AS author
        FROM mdt_incidents i
        LEFT JOIN characters c ON c.id = i.cid
        WHERE i.id = ? AND i.job = ?
    ]],
    { tonumber(pId), job })

    return result
end)

RPC.register("np-mdt:getIncidentData", function(src, pId)
    local incident = MySQL.single.await([[
        SELECT *
        FROM mdt_incidents
        WHERE id = ?
    ]],
    { tonumber(pId) })

    incident.tags = json.decode(incident.tags)
    incident.officers = json.decode(incident.officers)
    incident.civilians = json.decode(incident.civilians)
    incident.evidence = json.decode(incident.evidence)
    incident.charges = json.decode(incident.associated.charges)
    incident.associated = json.decode(incident.associated)

    for i, v in ipairs(incident.associated) do
        local name = MySQL.scalar.await([[
            SELECT CONCAT(first_name," ",last_name)
            FROM characters
            WHERE id = ?
        ]],
        { v.cid })

        incident.associated[i].name = name
    end

    return incident, incident.associated
end)

RPC.register("np-mdt:incidentSearchPerson", function(src, pName)
    local queryData = string.lower("%" .. pName .. "%")
    local result = MySQL.query.await([[
        SELECT c.id, c.first_name, c.last_name, c.gender, p.image
        FROM characters c
        LEFT JOIN mdt_profiles p ON p.cid = c.id
        WHERE LOWER(c.first_name) LIKE ? OR LOWER(c.id) LIKE ? OR LOWER(c.last_name) LIKE ? OR CONCAT(LOWER(c.first_name), " ", LOWER(c.last_name), " ", LOWER(c.id)) LIKE ?
        ORDER BY c.first_name DESC
    ]],
    { queryData, queryData, queryData, queryData })

    for i, v in pairs(result) do
		result[i].image = profilePic(v.gender, v.image)
	end

    return result
end)

RPC.register("np-mdt:getPenalCode", function(src)
    return penalCodeCategorys, penalCode, exports["np-base"]:getChar(src, "job")
end)

RegisterServerEvent("np-mdt:saveIncident")
AddEventHandler("np-mdt:saveIncident", function(data)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")

    if data.ID ~= 0 then
        MySQL.update.await([[
            UPDATE mdt_incidents
            SET cid = ?, title = ?, details = ?, tags = ?, officers = ?, civilians = ?, evidence = ?, associated = ?, time = ?
            WHERE id = ?
        ]],
        { cid, data.title, data.information, json.encode(data.tags), json.encode(data.officers), json.encode(data.civilians), json.encode(data.evidence), json.encode(data.associated), data.time, data.ID })
    else
        MySQL.insert.await([[
            INSERT INTO mdt_incidents (cid, title, details, tags, officers, civilians, evidence, associated, time)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, data.title, data.information, json.encode(data.tags), json.encode(data.officers), json.encode(data.civilians), json.encode(data.evidence), json.encode(data.associated), data.time })
    end
end)

RegisterServerEvent("np-mdt:removeIncidentCriminal")
AddEventHandler("np-mdt:removeIncidentCriminal", function(cid, incident)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")

    local result = MySQL.scalar.await([[
        SELECT associated
        FROM mdt_incidents
        WHERE id = ?
    ]],
    { incident })

    local criminal_name = ""
    local result = json.decode(result)

    for i, v in ipairs(result) do
        if v.cid == cid then
            criminal_name = MySQL.scalar.await([[
                SELECT CONCAT(first_name," ",last_name)
                FROM characters
                WHERE id = ?
            ]],
            { cid })

            table.remove(result, i)
        end
    end

    TriggerEvent("np-mdt:newLog", name .. ", Removed a criminal from an incident, incident ID: " .. incident .. ", Criminal Citizen Id: " .. cid .. ", Name: " .. criminal_name, "police")
    TriggerEvent("np-mdt:newLog", name .. ", Removed a criminal from an incident, incident ID: " .. incident .. ", Criminal Citizen Id: " .. cid .. ", Name: " .. criminal_name, "doj")

    MySQL.update.await([[
        UPDATE mdt_incidents
        SET associated = ?
        WHERE id = ?
    ]],
    { json.encode(result), incident })
end)

RegisterServerEvent("np-mdt:deleteIncident")
AddEventHandler("np-mdt:deleteIncident", function(pId, pTime)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_incidents
        WHERE id = ?
    ]],
    { pId })

    TriggerEvent("np-mdt:newLog", "A Incident was deleted by " .. name .. " with the ID (" .. pId .. ")", job, pTime)
end)

--[[

    Reports

]]

RPC.register("np-mdt:searchReports", function(src, pData)
    local job = getJob(src)

    local string = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT r.id, r.title, r.type, r.time, CONCAT(c.first_name," ",c.last_name) AS author
        FROM mdt_reports r
        LEFT JOIN characters c ON c.id = r.cid
        WHERE (LOWER(r.type) LIKE ? OR LOWER(r.title) LIKE ? OR LOWER(r.id) LIKE ? OR CONCAT(LOWER(r.type), " ", LOWER(r.title), " ", LOWER(r.id)) LIKE ?) AND r.job = ?
    ]],
    { string, string, string, string, job })

    return result
end)

RPC.register("np-mdt:getReportData", function(src, pId)
    local report = MySQL.single.await([[
        SELECT *
        FROM mdt_reports
        WHERE id = ?
    ]],
    { pId })

    report.tags = json.decode(report.tags)
    report.gallery = json.decode(report.gallery)
    report.officers = json.decode(report.officers)
    report.civilians = json.decode(report.civilians)

    return report
end)

RegisterNetEvent("np-mdt:newReport", function(pData)
    local src = source

    if pData.title == "" then return end

    local cid = exports["np-base"]:getChar(src, "id")
    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    if pData.existing then
        MySQL.update.await([[
            UPDATE mdt_reports
            SET cid = ?, title = ?, type = ?, detail = ?, tags = ?, gallery = ?, officers = ?, civilians = ?, time = ?
            WHERE id = ?
        ]],
        { cid, pData.title, pData.type, pData.detail, json.encode(pData.tags), json.encode(pData.gallery), json.encode(pData.officers), json.encode(pData.civilians), pData.time, pData.id })

        TriggerEvent("np-mdt:newLog", "A report was updated by " .. name .. " with the title (" .. pData.title .. ") and ID (" .. pData.id .. ")", job, pData.time)
    else
        local insertId = MySQL.insert.await([[
            INSERT INTO mdt_reports (cid, title, type, detail, tags, gallery, officers, civilians, job, time)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, pData.title, pData.type, pData.detail, json.encode(pData.tags), json.encode(pData.gallery), json.encode(pData.officers), json.encode(pData.civilians), job, pData.time })

        if insertId and insertId > 0 then
            TriggerClientEvent("np-mdt:reportComplete", src, insertId)
            TriggerEvent("np-mdt:newLog", "A new report was created by " .. name .. " with the title (" .. pData.title .. ") and ID (" .. insertId .. ")", job, pData.time)
        end
    end
end)

RegisterNetEvent("np-mdt:deleteReport", function(pId, pTime)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_reports
        WHERE id = ?
    ]],
    { pId })

    TriggerEvent("np-mdt:newLog", "A Report was deleted by " .. name .. " with the ID (" .. pId .. ")", job, pTime)
end)

--[[

    BOLOs

]]

RPC.register("np-mdt:searchBolos", function(src, pData)
    local job = getJob(src)

    local string = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT b.id, b.title, b.time, CONCAT(c.first_name," ",c.last_name) AS author
        FROM mdt_bolos b
        LEFT JOIN characters c ON c.id = b.cid
        WHERE (LOWER(b.plate) LIKE ? OR LOWER(b.title) LIKE ? OR CONCAT(LOWER(b.plate), " ", LOWER(b.title)) LIKE ?) AND b.job = ?
    ]],
    { string, string, string, job })

    return result
end)

RPC.register("np-mdt:getBoloData", function(src, pId)
    local bolo = MySQL.single.await([[
        SELECT id, title, plate, owner, individual, detail, tags, gallery, officers
        FROM mdt_bolos
        WHERE id = ?
    ]],
    { pId })

    bolo.tags = json.decode(bolo.tags)
    bolo.gallery = json.decode(bolo.gallery)
    bolo.officers = json.decode(bolo.officers)

    return bolo
end)

RegisterServerEvent("np-mdt:newBolo", function(data)
    local src = source

    if data.title == "" then return end

    local cid = exports["np-base"]:getChar(src, "id")
    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    if data.id ~= nil and data.id ~= 0 then
        MySQL.update.await([[
            UPDATE mdt_bolos
            SET cid = ?, title = ?, plate = ?, owner = ?, individual = ?, detail = ?, tags = ?, gallery = ?, officers = ?, time = ?
            WHERE id = ?
        ]],
        { cid, data.title, data.plate, data.owner, data.individual, data.detail, json.encode(data.tags), json.encode(data.gallery), json.encode(data.officers), data.time, data.id })

        TriggerEvent("np-mdt:newLog", "A BOLO was updated by " .. name .. " with the title (" .. data.title .. ") and ID (" .. data.id .. ")", job, data.time)
    else
        local insertId = MySQL.insert.await([[
            INSERT INTO mdt_bolos (cid, title, plate, owner, individual, detail, tags, gallery, officers, job, time)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        ]],
        { cid, data.title, data.plate, data.owner, data.individual, data.detail, json.encode(data.tags), json.encode(data.gallery), json.encode(data.officers), job, data.time})

        if insertId and insertId > 0 then
            TriggerClientEvent("np-mdt:boloComplete", src, insertId)
            TriggerEvent("np-mdt:newLog", "A new BOLO was created by " .. name .. " with the title (" .. data.title .. ") and ID (" .. insertId .. ")", job, data.time)
        end
    end
end)

RegisterServerEvent("np-mdt:deleteBolo", function(id)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_bolos
        WHERE id = ?
    ]],
    { id })

    TriggerEvent("np-mdt:newLog", "A BOLO was deleted by " .. name .. " with the ID (" .. id .. ")", job)
end)

--[[

    DMV

]]

RPC.register("np-mdt:searchVehicles", function(src, pPlate)
    local plate = string.lower("%" .. pPlate .. "%")

    local result = MySQL.query.await([[
        SELECT v.id, v.cid, v.plate, v.model, g.state, d.modifications, m.image, m.code5, m.stolen, CONCAT(c.first_name," ",c.last_name) AS owner
        FROM vehicles v
        LEFT JOIN vehicles_garage g ON g.vid = v.id
        LEFT JOIN vehicles_metadata d ON d.vid = v.id
        LEFT JOIN mdt_vehicles m ON m.plate = v.plate
        LEFT JOIN characters c ON c.id = v.cid
        WHERE LOWER(v.plate) LIKE ?
    ]],
    { plate })

    local vehicles = {}

    for i, v in ipairs(result) do
        local _vehicle = {
            id = v.id,
            dbid = v.id,
            plate = v.plate,
            model = v.model,
            owner = v.owner,
            image = "img/not-found.jpg",
            color1 = 0,
            color2 = 0,
            code = false,
            stolen = false,
            bolo = false
        }

        if v.code5 ~= nil and v.code5 == 1 then _vehicle.code5 = true end
        if v.stolen ~= nil and v.stolen == 1 then _vehicle.stolen = true end

        if v.image and v.image ~= nil and v.image ~= "" then
            _vehicle.image = v.image
        end

        if v.modifications then
            local _modifications = json.decode(v.modifications)
            if _modifications["colors"] then
                _vehicle.color1 = _modifications["colors"][1]
                _vehicle.color2 = _modifications["colors"][2]
            end
        end

        local bolo = MySQL.scalar.await([[
            SELECT id
            FROM mdt_bolos
            WHERE plate = ?
            LIMIT 1
        ]],
        { v.plate })

        if bolo then
            _vehicle.bolo = true
        end

        table.insert(vehicles, _vehicle)
    end

    return vehicles
end)

RPC.register("np-mdt:getVehicleData", function(src, pPlate)
    local result = MySQL.query.await([[
        SELECT v.id, v.cid, v.plate, v.model, g.state, d.modifications, m.notes, m.image, m.code5, m.stolen, CONCAT(c.first_name," ",c.last_name) AS owner
        FROM vehicles v
        LEFT JOIN vehicles_garage g ON g.vid = v.id
        LEFT JOIN vehicles_metadata d ON d.vid = v.id
        LEFT JOIN mdt_vehicles m ON m.plate = v.plate
        LEFT JOIN characters c ON c.id = v.cid
        WHERE v.plate = ?
    ]],
    { pPlate })

    local vehicle = {
        id = result[1].id,
        dbid = result[1].id,
        plate = result[1].plate,
        model = result[1].model,
        owner = result[1].owner,
        notes = result[1].notes,
        image = "img/not-found.jpg",
        color1 = 0,
        color2 = 0,
        code5 = false,
        stolen = false,
        bolo = false
    }

    if result[1].code5 and result[1].code5 == 1 then vehicle.code5 = true end
    if result[1].stolen and result[1].stolen == 1 then vehicle.stolen = true end

    if result[1].image and result[1].image ~= nil and result[1].image ~= "" then
        vehicle.image = result[1].image
    end

    if result[1].modifications then
        local _modifications = json.decode(result[1].modifications)
        if _modifications["colors"] then
            vehicle.color1 = _modifications["colors"][1]
            vehicle.color2 = _modifications["colors"][2]
        end
    end

    local bolo = MySQL.scalar.await([[
        SELECT id
        FROM mdt_bolos
        WHERE plate = ?
        LIMIT 1
    ]],
    { result[1].plate })

    if bolo then
        vehicle.bolo = true
    end

    return vehicle
end)

RegisterNetEvent("np-mdt:saveVehicleInfo", function(dbid, plate, image, notes)
	local src = source

    if dbid == 0 or plate == "" then return end

    if not image or imagev == "" then imageurl = "" end
	if not notes or notes == "" then notes = "" end

    local result = MySQL.scalar.await([[
        SELECT id
        FROM mdt_vehicles
        WHERE plate = ?
    ]],
    { plate })

    if result then
		MySQL.update.await([[
            UPDATE mdt_vehicles
            SET notes = ?, image = ?
            WHERE plate = ?
        ]],
        { notes, image, plate })
	else
		MySQL.insert.await([[
            INSERT INTO mdt_vehicles (plate, notes, image)
            VALUES (?, ?, ?, ?, ?)
        ]],
        { plate, notes, image })
	end
end)

RegisterNetEvent("np-mdt:knownInformation", function(dbid, type, status, plate)
    local src = source

    local result = MySQL.scalar.await([[
        SELECT id
        FROM mdt_vehicles
        WHERE plate = ?
    ]],
    { plate })

    if result then
		MySQL.update.await([[
            UPDATE mdt_vehicles
            SET ?? = ?
            WHERE plate = ?
        ]],
        { type, status, plate })
	else
        MySQL.insert.await([[
            INSERT INTO mdt_vehicles (plate, notes, image, ??)
            VALUES (?, ?, ?, ?)
        ]],
        { type, plate, "", "", status })
	end
end)

--[[

    Weapons

]]

RPC.register("np-mdt:searchWeapon", function(src, pData)
    local query = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT w.id, w.cid, w.serial, w.image, CONCAT(c.first_name," ",c.last_name) AS owner
        FROM mdt_weapons w
        LEFT JOIN characters c ON c.id = w.cid
        WHERE LOWER(w.serial) LIKE ?
    ]],
    { query })

    for i, v in ipairs(result) do
        if v.image == nil or v.image == "" then
            result[i].image = "img/not-found.jpg"
        end
    end

    return result
end)

RPC.register("np-mdt:getWeaponData", function(src, pSerial)
    local result = MySQL.query.await([[
        SELECT w.id, w.serial, w.brand, w.type, w.notes, w.image, CONCAT(c.first_name," ",c.last_name) AS owner
        FROM mdt_weapons w
        LEFT JOIN characters c ON c.id = w.cid
        WHERE w.serial = ?
    ]],
    { pSerial })

    if result[1].brand == nil then
        result[1].brand = ""
    end

    if result[1].type == nil then
        result[1].type = ""
    end

    if result[1].notes == nil then
        result[1].notes = ""
    end

    if result[1].image == nil or result[1].image == "" then
        result[1].image = "img/not-found.jpg"
    end

    return result[1]
end)

RegisterNetEvent("np-mdt:addWeapon", function(pCid, pSerial)
	local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    local insertId = MySQL.insert.await([[
        INSERT INTO mdt_weapons (cid, serial)
        VALUES (?, ?)
    ]],
    { pCid, pSerial })

    if insertId and insertId > 0 then
        TriggerEvent("np-mdt:newLog", "A new Weapon was created by " .. name .. " with the serial (" .. pSerial .. ") and ID (" .. insertId .. ")", job)
    end
end)

RegisterNetEvent("np-mdt:saveWeapon", function(pSerial, pImage, pBrand, pType, pNotes)
	local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    MySQL.update.await([[
        UPDATE mdt_weapons
        SET brand = ?, type = ?, notes = ?, image = ?
        WHERE serial = ?
    ]],
    { pBrand, pType, pNotes, pImage, pSerial })

    TriggerEvent("np-mdt:newLog", "A Weapon was updated by " .. name .. " with the serial (" .. pSerial .. ")", job)
end)

--[[

    Missing

]]

RPC.register("np-mdt:searchMissing", function(src, pData)
    local querry = string.lower("%" .. pData .. "%")

    local result = MySQL.query.await([[
        SELECT m.id, m.cid, m.last_seen, m.image, CONCAT(c.first_name," ",c.last_name) AS name
        FROM mdt_missing m
        LEFT JOIN characters c ON c.id = m.cid
        WHERE LOWER(c.first_name) LIKE ? OR LOWER(c.id) LIKE ? OR LOWER(c.last_name) LIKE ? OR CONCAT(LOWER(c.first_name), " ", LOWER(c.last_name), " ", LOWER(c.id)) LIKE ? OR LOWER(m.id) LIKE ?
    ]],
    { querry, querry, querry, querry, querry })

    for i, v in ipairs(result) do
        if v.image == nil or v.image == "" then
            result[i].image = "img/not-found.jpg"
        end

        if v.last_seen == nil or v.last_seen == "" then
            result[i].last_seen = ""
        end
    end

    return result
end)

RPC.register("np-mdt:getMissingData", function(src, pId)
    local result = MySQL.query.await([[
        SELECT m.id, m.cid, m.last_seen, m.notes, m.image, m.date, CONCAT(c.first_name," ",c.last_name) AS name
        FROM mdt_missing m
        LEFT JOIN characters c ON c.id = m.cid
        WHERE m.id = ?
    ]],
    { pId })

    if result[1].last_seen == nil then
        result[1].last_seen = ""
    end

    if result[1].notes == nil then
        result[1].notes = ""
    end

    if result[1].image == nil or result[1].image == "" then
        result[1].image = "img/not-found.jpg"
    end

    return result[1]
end)

RegisterNetEvent("np-mdt:missingCitizen", function(pCid, pTime)
	local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    local insertId = MySQL.insert.await([[
        INSERT INTO mdt_missing (cid, date)
        VALUES (?, ?)
    ]],
    { pCid, pTime })

    if insertId and insertId > 0 then
        TriggerEvent("np-mdt:newLog", "A new Missing Citizen was created by " .. name .. " with the ID (" .. insertId .. ")", job)
    end
end)

RegisterNetEvent("np-mdt:saveMissing", function(pId, pLastSeen, pImage, pNotes)
	local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    MySQL.update.await([[
        UPDATE mdt_missing
        SET last_seen = ?, image = ?, notes = ?
        WHERE id = ?
    ]],
    { pLastSeen, pImage, pNotes, pId })

    TriggerEvent("np-mdt:newLog", "A Missing Citizen was updated by " .. name .. " with the ID (" .. pId .. ")", job)
end)

RegisterServerEvent("np-mdt:deleteMissing", function(pId, pTime)
    local src = source

    local name = exports["np-base"]:getChar(src, "first_name") .. " " .. exports["np-base"]:getChar(src, "last_name")
    local job = getJob(src)

    MySQL.update.await([[
        DELETE FROM mdt_missing
        WHERE id = ?
    ]],
    { pId })

    TriggerEvent("np-mdt:newLog", "A Missing Citizen was deleted by " .. name .. " with the ID (" .. pId .. ")", job)
end)

--[[

    Logs

]]

RegisterServerEvent("np-mdt:newLog")
AddEventHandler("np-mdt:newLog", function(text, job, time)
    if not time then
        time = os.time() * 1000
    end

    MySQL.insert.await([[
        INSERT INTO mdt_logs (text, job, time)
        VALUES (?, ?, ?)
    ]],
    { text, job, time })
end)

RPC.register("np-mdt:getAllLogs", function(src)
    local job = getJob(src)

    local result = MySQL.query.await([[
        SELECT *
        FROM mdt_logs
        WHERE job = ? OR job IS NULL
        ORDER BY id DESC
        LIMIT 500
    ]],
    { job })

    return result
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(3000)

    local _categorys = MySQL.query.await([[
        SELECT *
        FROM mdt_penalcode_categorys
    ]])

    for i, v in ipairs(_categorys) do
        penalCode[v.cid] = {}
        penalCodeCategorys[v.cid] = v.category

        local _penalcode = MySQL.query.await([[
            SELECT *
            FROM mdt_penalcode
            WHERE category = ?
            ORDER BY type ASC
        ]],
        { v.cid })

        for i2, v2 in ipairs(_penalcode) do
            local color = "green"
            local class = "Infração"

            if v2.type == 1 then
                color = "orange"
                class = "Contravenção"
            elseif v2.type == 2 then
                color = "red"
                class = "Crime"
            end

            table.insert(penalCode[v.cid], {
                id = v2.id,
                color = color,
                title = v2.label,
                class = class,
                months = v2.sentence,
                fine = v2.fine
            })
        end
    end
end)