NPX = NPX or {}
NPX.Admin = NPX.Admin or {}
NPX._Admin = NPX._Admin or {}
NPX._Admin.Players = {}
NPX._Admin.DiscPlayers = {}

local Players = {}

SpectateData = {}

RegisterCommand('newmenu', function(source, args, RawCommand)
    TriggerClientEvent('np-admin:try-open-menu', source,  true)
end)

RPC.register('np-admin:getActivePlayers', function(Radius)
	local ActivePlayers = {}
	local Coords, Radius = Coords ~= nil and vector3(Coords.x, Coords.y, Coords.z) or GetEntityCoords(GetPlayerPed(Source)), Radius ~= nil and Radius or 5.0
	for k, v in pairs(exports["np-base"]:getUsers()) do
		local Player = exports["np-base"]:getUser(v)
		if Player ~= nil then
			local TargetCoords = GetEntityCoords(GetPlayerPed(v))
			local TargetDistance = #(TargetCoords - Coords)
			if TargetDistance <= Radius then
				local ReturnData = {}
				ReturnData['ServerId'] = Player.PlayerData.source
				ReturnData['Name'] = GetPlayerName(Player.PlayerData.source)
				table.insert(ActivePlayers, ReturnData)
			end
		end
	end
	return ActivePlayers
end)

RPC.register('np-admin:getPermission', function()
    return true
end)

RPC.register('np-admin:getBans', function()
    local BanList = {}
    local q = [[SELECT * FROM users_bans]]

    exports.oxmysql:execute(q, function(result)
        if not result then result = BanList  return else print("no bans found.") end
    end)
    return BanList
 end)
 
 RPC.register('np-admin:getPlayers', function()
    local src = source
    local user = exports["np-base"]:getUser(src)
    local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { 
        ServerId = source, 
        Steam = stid, 
        comid = scomid, 
        Name = ply, 
        hexid = user:getVar("hexid"), 
        ip = ip, 
        rank = NPX.Admin:GetPlayerRank(user), 
        License = licenseid, 
        ping = ping
    }
    table.insert(Players, data)
    TriggerClientEvent("np-admin:AddPlayer", -1, data )
    NPX.Admin.AddAllPlayers()
    Citizen.Wait(550)
    return Players
 end)

 RPC.register('np-admin:getChardata', function(License)
    for LicenseId, veee in pairs(License) do
        local TPlayer = exports["np-base"]:getModule("Player"):GetUserFromIdentifier(LicenseId)
        local cid = TPlayer:getCurrentCharacter().id
        local TSteam = TPlayer:getVar("hexid")
        local PlayerCharInfo = {}
        local PlayerCharInfo = {}
        PlayerCharInfo.Name = GetPlayerName(TPlayer)
        PlayerCharInfo.Steam = TSteam
        PlayerCharInfo.CharName = TPlayer.PlayerData.charinfo.firstname..' '..TPlayer.PlayerData.charinfo.lastname
        PlayerCharInfo.Source = TPlayer.PlayerData.source
        PlayerCharInfo.cid = cid
        return PlayerCharInfo
    end
end)

-- [ Events ] --

-- Spectate

RegisterNetEvent('np-admin:startSpectate', function(ServerId)
    local src = source
    if pAllowed(src, "Admin Check") ~= "user" then
        -- Check if Person exists
        local Target = GetPlayerPed(ServerId)
        if not Target then
            TriggerClientEvent('DoLongHudText', src, 'Player not found, leaving spectate..', '2')
        end

        -- Make Check for Spectating
        local SteamIdentifier = Mercy.Functions.GetIdentifier(src, "steam")
        if SpectateData[SteamIdentifier] ~= nil then
            SpectateData[SteamIdentifier]['Spectating'] = true
        else
            SpectateData[SteamIdentifier] = {}
            SpectateData[SteamIdentifier]['Spectating'] = true
        end

        local tgtCoords = GetEntityCoords(Target)
        TriggerClientEvent('np-admin:specPlayer', src, ServerId, tgtCoords)
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent('np-admin:stopSpectate', function()
    local src = source
    if pAllowed(src, "Admin Check") ~= "user" then
        local SteamIdentifier = Mercy.Functions.GetIdentifier(src, "steam")
        if SpectateData[SteamIdentifier] ~= nil and SpectateData[SteamIdentifier]['Spectating'] then
            SpectateData[SteamIdentifier]['Spectating'] = false
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

-- Other

RegisterNetEvent("np-admin:toggleBlips", function()
    local Players = exports["np-base"]:getUsers()
    local BlipData = {}
    for k, v in pairs(Players) do
        local Player = exports["np-base"]:getUser(v)
        local NewPlayer = {}
        NewPlayer.ServerId = v
        NewPlayer.Name = Player.PlayerData.name
        NewPlayer.Coords = GetEntityCoords(GetPlayerPed(v))
        table.insert(BlipData, NewPlayer)
    end
    TriggerClientEvent('np-admin:UpdatePlayerBlips', -1, BlipData)
end)

RegisterNetEvent("np-admin:banPlayer", function(ServerId, Expires, Reason)
    local src = source
    if not AdminCheck(src) then return end
    local Expiring, ExpireDate = GetBanTime(Expires)
    MySQL.Async.insert('INSERT INTO bans (name, admin, ip, steam_id, license, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
        GetPlayerName(ServerId),
        -- Mercy.Functions.GetIdentifier(ServerId, 'license'),
        -- Mercy.Functions.GetIdentifier(ServerId, 'discord'),
        ip = GetPlayerEndpoint(ServerId),
        Reason,
        ExpireDate,
        GetPlayerName(src)
    })
    local ExpireHours = tonumber(Expiring['hour']) < 10 and "0"..Expiring['hour'] or Expiring['hour']
    local ExpireMinutes = tonumber(Expiring['min']) < 10 and "0"..Expiring['min'] or Expiring['min']
    if Expires == "Permanent" then
        DropPlayer(ServerId, '\n🔰 You are permanently banned.'..'\n🛑 Reason:'..Reason)
    else
        DropPlayer(ServerId, '\n🔰 You are banned.' .. '\n🛑 Reason: ' .. Reason .. "\n\n⏰Ban expires on " .. Expiring['day'] .. '/' .. Expiring['month'] .. '/' .. Expiring['year'] .. ' '..ExpireHours..':'..ExpireMinutes..'.')
    end
    TriggerClientEvent('DoLongHudText', src, 'Successfully banned '..GetPlayerName(ServerId)..' for '..Reason)
end)

RegisterNetEvent("np-admin:toggleGodmode", function(ServerId)
    TriggerClientEvent('np-admin:toggleGodmode', ServerId)
end)

RegisterNetEvent("np-admin:flingPlayer", function(ServerId)
    if pAllowed(src, "kickPlayer") ~= "user" then
        TriggerClientEvent('np-admin:flingPlayer', ServerId)
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)


RegisterNetEvent("np-admin:kickPlayer", function(ServerId, Reason)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "kickPlayer") ~= "user" then
        DropPlayer(ServerId, Reason)
        TriggerClientEvent('DoLongHudText', src, 'Successfully kicked player.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end

end)

RegisterNetEvent("admin:searchInventory", function(tSrc)
    local pSrc = source
    local user = exports["np-base"]:getUser(tSrc)
    local cid = user:getCurrentCharacter().id

    local pName = GetPlayerName(pSrc)
    local tName = GetPlayerName (tSrc)

    if pAllowed(pSrc, "searchInventory") ~= "user" then
        TriggerClientEvent("server-inventory-open", pSrc, "1", 'ply-'..cid)
        local info = pName .. " Searched " ..tName
    end
end)

RegisterNetEvent("np-admin:giveItem", function(ServerId, ItemName, ItemAmount)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "giveItem") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        if TPlayer ~= nil then
            local info =  "Item Name: " ..string.upper(ItemName) .. " Item Amount: " ..ItemAmount
            TriggerClientEvent('player:receiveItem', ServerId, ItemName, ItemAmount)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin:chatSay", function(message)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "chatSay") ~= "user" then
        TriggerClientEvent('chatMessage', -1, 'Server', 1, message)
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin:requestJob", function(ServerId, JobName)
    local jobs = exports["np-base"]:getModule("JobManager")
    
    if pAllowed(ServerId, "requestJob") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        if TPlayer ~= nil then
            jobs:SetJob(TPlayer, tostring(JobName))
        --     if jobName == "police" then
        --         TriggerEvent("attemptduty", ServerId)
        --     elseif jobName == "ems" then 
        --         TriggerEvent("attemptdutym", ServerId)
        --     elseif jobName == "doctor" then
        --         TriggerClientEvent("isDoctor", ServerId)
        --         Wait(1000)
        --         TriggerEvent("isDoctor", ServerId)
        --     elseif jobName == "judge" then
        --         TriggerClientEvent("isJudge", ServerId)
        --         Wait(1000)
        --         TriggerEvent("isJudge", ServerId)
        --     else
        --         TriggerEvent("jobssystem:jobs", ServerId, jobName)
        --     end
        --     -- TriggerClientEvent('DoLongHudText', ServerId, 'Successfully set player as '..JobName..'.')
        end
    else
        TriggerClientEvent('DoLongHudText', ServerId, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin:setFoodDrink", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "setFoodDrink") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        if ServerId ~= nil then

            TriggerClientEvent('inv:wellfedwater', ServerId)
            TriggerClientEvent('inv:wellfed', ServerId)
            TriggerClientEvent('hud:client:UpdateNeeds', ServerId, 100, 100)

            TriggerClientEvent('DoLongHudText', src, 'Successfully gave player food and water.')
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin:removeStress", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "removeStress") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)

        TriggerClientEvent('DoLongHudText', src, 'Successfully removed stress of player.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin:setArmor", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "setArmor") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        SetPedArmour(GetPlayerPed(ServerId), 200)

        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player Armor.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin:resetSkin", function(ServerId)
    local Player = exports["np-base"]:getUser(ServerId)
    local cid = user:getCurrentCharacter().id
    local result = MySQL.Sync.fetchAll('SELECT * FROM character_face WHERE cid = ? AND active = ?', { cid, 1 })
    if result[1] ~= nil then
        TriggerClientEvent("np-clothes:loadSkin", ServerId, false, result[1].model, result[1].skin)
    else
        TriggerClientEvent("np-clothes:loadSkin", ServerId, true)
    end
end)

RegisterNetEvent("np-admin:setModel", function(ServerId, Model)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        TriggerClientEvent('np-admin:setModel', ServerId, Model)
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin:reviveInDistance", function()
    local src = source
    local Coords, Radius = GetEntityCoords(GetPlayerPed(src)), 5.0
	for k, v in pairs(exports["np-base"]:getUsers()) do
		local Player = exports["np-base"]:getUser(v)
		if Player ~= nil then
			local TargetCoords = GetEntityCoords(GetPlayerPed(v))
			local TargetDistance = #(TargetCoords - Coords)
			if TargetDistance <= Radius then
                TriggerClientEvent('hospital:client:Revive', v, true)
			end
		end
	end
end)

RegisterNetEvent("np-admin:reviveTarget", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "reviveTarget") ~= "user" then
        
        TriggerEvent("reviveGranted")
        TriggerClientEvent("Hospital:HealInjuries", ServerId, true) 
        TriggerEvent("ems:healplayer")
        TriggerClientEvent("heal", ServerId)
        TriggerClientEvent('DoLongHudText', src, 'Successfully revived player.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end

end)

RegisterNetEvent("np-admin:openClothing", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "openClothing") ~= "user" then
        TriggerClientEvent("raid_clothes:openClothing", ServerId, true, true)
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player clothing menu.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

RegisterNetEvent("np-admin:openOutfits", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "openOutfits") ~= "user" then
        TriggerClientEvent("hotel:outfit", ServerId, 4)
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player outfit menu.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

RegisterNetEvent("np-admin:openBarber", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "openBarber") ~= "user" then
        TriggerClientEvent("raid_clothes:openBarber", ServerId, false)
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player Barber menu.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

RegisterNetEvent("np-admin:openTattoo", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "openTattoo") ~= "user" then
        TriggerEvent("raid_clothes:hasEnough", ServerId, "tattoo_shop", true)
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player Tattoo menu.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

RegisterNetEvent("np-admin:teleportPlayer", function(ServerId, Type)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    local Msg = ""
    if pAllowed(src, "Admin Check") ~= "user" then
        if Type == 'Goto' then
            Msg = 'teleported to'
            local TCoords = GetEntityCoords(GetPlayerPed(ServerId))
            TriggerClientEvent('np-admin/client/teleport-player', src, TCoords)
        elseif Type == 'Bring' then
            Msg = 'brought'
            local Coords = GetEntityCoords(GetPlayerPed(src))
            TriggerClientEvent('np-admin/client/teleport-player', ServerId, Coords)
        end
        TriggerClientEvent('DoLongHudText', src, 'Successfully '..Msg..' player.', '1')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

RegisterNetEvent("Admin:Money:state", function(ServerId, Type, state, amount)
    local Player = exports["np-base"]:getUser(ServerId)
    local pAccount = Player:getBankId()
    local Msg = ""
    if pAllowed(ServerId, "Admin Check") ~= "user" then
        if Type == "Bank" then  
            exports["np-financials"]:updateBalance(pAccount, 1, amount)
            TriggerClientEvent('DoLongHudText', src, 'Successfully added money to player ' .. ServerId .. ' at '..Type , '1')
        else
            exports["np-financials"]:updateCash(ServerId, 1, amount)
        end

    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

function pAllowed(pSrc, pTrigger)
    local user = exports["np-base"]:getUser(pSrc)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(pSrc)
    print("Checking Perms | Admin Menu | Trigger: " .. pTrigger .. " | Source Steam Hex: " ..hexId.. " Steam Name: "..pName)

    exports.oxmysql:execute("SELECT `rank` FROM users WHERE hex_id = ?", {hexId}, function(data)
        pRank = data[1].rank

        if pRank == "user" then
            LogInfo = "Admin Menu | Trigger: " .. pTrigger
            -- exports['np-base']:DiscordLog("", pSrc, "Trigger-Event-Admin", "Triggering Events", LogInfo)
            DropPlayer(pSrc, "[np-anticheat] | Ban Reason: Triggering Events")
            return
        end

    end)

    Citizen.Wait(100)
    return pRank
end


function NPX.Admin.AddAllPlayers(self)
    --local Players = GetPlayers()

    for i, _PlayerId in pairs(GetPlayers()) do
        
        local licenses
        local identifiers, steamIdentifier = GetPlayerIdentifiers(_PlayerId)
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end
        for _, v in pairs(identifiers) do
            if string.find(v, "license") then
                licenses = v
                break
            end
        end
        local ip = GetPlayerEndpoint(_PlayerId)
        local licenseid = licenses:gsub("license:", "")
        local ping = GetPlayerPing(_PlayerId)
        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(_PlayerId)
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = tonumber(_PlayerId), steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping }

        TriggerClientEvent("np-admin:AddAllPlayers", source, data)

    end
end

function NPX.Admin.GetRanks(self)
    return NPX._Admin.Ranks
end

function NPX.Admin.GetRankData(self, rank)
    if not rank then return false end

    rank = tostring(rank)
    if not rank then return false end

    return self:GetRanks()[rank] and self:GetRanks()[rank] or false
end

function GetPlayerRank(self, user)
    if not IsDuplicityVersion() then
        return exports["np-base"]:getModule("LocalPlayer"):getVar("rank")
    else
        if not user then return false end

        local rank = user:getVar("rank")
        return rank and rank or false
    end
end

function AdminCheck(ServerId)
    local Player = exports["np-base"]:getUser(ServerId)
    local Promise = promise:new()
    if Player ~= nil then
        if pAllowed(pSrc, "Admin Check") ~= "user" then
            Promise:resolve(true)
        else
            Promise:resolve(false)
        end
    end
    return Promise
end

function GetBanTime(Expires)
    local Time = os.time()
    local Expiring = nil
    local ExpireDate = nil
    if Expires == '1 Hour' then
        Expiring = os.date("*t", Time + 3600)
        ExpireDate = tonumber(Time + 3600)
    elseif Expires == '6 Hours' then
        Expiring = os.date("*t", Time + 21600)
        ExpireDate = tonumber(Time + 21600)
    elseif Expires == '12 Hours' then
        Expiring = os.date("*t", Time + 43200)
        ExpireDate = tonumber(Time + 43200)
    elseif Expires == '1 Day' then
        Expiring = os.date("*t", Time + 86400)
        ExpireDate = tonumber(Time + 86400)
    elseif Expires == '3 Days' then
        Expiring = os.date("*t", Time + 259200)
        ExpireDate = tonumber(Time + 259200)
    elseif Expires == '1 Week' then
        Expiring = os.date("*t", Time + 604800)
        ExpireDate = tonumber(Time + 604800)
    elseif Expires == 'Permanent' then
        Expiring = os.date("*t", Time + 315360000) -- 10 Years
        ExpireDate = tonumber(Time + 315360000)
    end
    return Expiring, ExpireData
end


function NPX.Admin.AddAllPlayers(self)
    --local Players = GetPlayers()

    for i, _PlayerId in pairs(GetPlayers()) do
        
        local licenses
        local identifiers, steamIdentifier = GetPlayerIdentifiers(_PlayerId)
        for _, v in pairs(identifiers) do
            if string.find(v, "steam") then
                steamIdentifier = v
                break
            end
        end
        for _, v in pairs(identifiers) do
            if string.find(v, "license") then
                licenses = v
                break
            end
        end
        local ip = GetPlayerEndpoint(_PlayerId)
        local licenseid = licenses:gsub("license:", "")
        local ping = GetPlayerPing(_PlayerId)
        local stid = HexIdToSteamId(steamIdentifier)
        local ply = GetPlayerName(_PlayerId)
        local scomid = steamIdentifier:gsub("steam:", "")
        local data = { src = tonumber(_PlayerId), steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping }

        TriggerClientEvent("np-admin:AddAllPlayers", source, data)

    end
end

function NPX.Admin.AddPlayerS(self, data)
    NPX._Admin.Players[data.src] = data
end

AddEventHandler("playerDropped", function()
	local licenses
    local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            licenses = v
            break
        end
    end

    local stid = HexIdToSteamId(steamIdentifier)
    local ply = GetPlayerName(source)
    local ip = GetPlayerEndpoint(source)
    local scomid = steamIdentifier:gsub("steam:", "")
    local licenseid = licenses:gsub("license:", "")
    local ping = GetPlayerPing(source)
    local data = { src = source, steamid = stid, comid = scomid, name = ply, ip = ip, license = licenseid, ping = ping}

    TriggerClientEvent("np-admin:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("np-admin:RemoveRecent", -1, data)
end)

function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end