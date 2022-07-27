--[[

    Variables

]]

local BlipHandlers = {}

--[[

    Functions

]]

function CreateBlipHandler(pServerId, pJob, pCallSign)
	local serverId = pServerId
	local callsign = pCallSign
	local job = pJob

	local settings = GetBlipSettings(job, callsign)

	local handler = EntityBlip:new("player", serverId, settings)

	handler:enable(true)

	BlipHandlers[serverId] = handler
end

function DeleteBlipHandler(pServerId)
	BlipHandlers[pServerId]:disable()
	BlipHandlers[pServerId] = nil
end

function GetBlipSettings(pJobId, pCallSign)
	local settings = {}

	settings.short = true
	settings.sprite = 1
	settings.category = 7

	if pJobId == "state_police" then
		settings.color = 29
        settings.text = ("Trooper | %s"):format(pCallSign)
    elseif pJobId == "park_ranger" then
		settings.color = 25
        settings.text = ("Ranger | %s"):format(pCallSign)
    elseif pJobId == "doc" then
		settings.color = 38
        settings.text = ("DOC | %s"):format(pCallSign)
	elseif pJobId == "cid" then
		settings.color = 63
        settings.text = ("Detetive | %s"):format(pCallSign)
    elseif pJobId == "doctor" then
        settings.color = 19
		settings.text = ("Doctor | %s"):format(pCallSign)
    elseif exports["np-jobs"]:getJob(pJobId, "is_police") then
        settings.color = 3
        settings.text = ("Officer | %s"):format(pCallSign)
    elseif exports["np-jobs"]:getJob(pJobId, "is_medic") then
        settings.color = 23
        settings.text = ("Paramedic | %s"):format(pCallSign)
    end

	return settings
end

--[[

    Events

]]

RegisterNetEvent("np:infinity:player:coords")
AddEventHandler("np:infinity:player:coords", function(pCoords)
	for serverId, handler in pairs(BlipHandlers) do
		if handler and handler.mode == "coords" and pCoords[serverId] then
			handler:onUpdateCoords(pCoords[serverId])

			if handler:entityExistLocally() then
				handler:onModeChange("entity")
			end
		end
	end
end)

RegisterNetEvent("np-jobs:jobChanged")
AddEventHandler("np-jobs:jobChanged", function(pJob)
    TriggerServerEvent("e-blips:updateBlips", pJob, true)
end)

RegisterNetEvent("e-blips:updateAfterPedChange")
AddEventHandler("e-blips:updateAfterPedChange", function()
	local pJob = exports["np-base"]:getChar("job")
	TriggerServerEvent("e-blips:updateBlips", pJob, false)
end)

RegisterNetEvent("e-blips:setHandlers")
AddEventHandler("e-blips:setHandlers", function(pHandlers)
	local serverId = GetPlayerServerId(PlayerId())

	for _, pData in pairs(pHandlers) do
		if pData then
			CreateBlipHandler(pData.netId, pData.job, pData.callsign)
		end
	end
end)

RegisterNetEvent("e-blips:deleteHandlers")
AddEventHandler("e-blips:deleteHandlers", function()
	for serverId, pData in pairs(BlipHandlers) do
		if pData then
			DeleteBlipHandler(serverId)
		end
	end

	BlipHandlers = {}
end)

RegisterNetEvent("e-blips:addHandler")
AddEventHandler("e-blips:addHandler", function(pData)
	if pData then
		CreateBlipHandler(pData.netId, pData.job, pData.callsign)
	end
end)

RegisterNetEvent("e-blips:removeHandler")
AddEventHandler("e-blips:removeHandler", function(pServerId)
	if BlipHandlers[pServerId] then
		DeleteBlipHandler(pServerId)
	end
end)