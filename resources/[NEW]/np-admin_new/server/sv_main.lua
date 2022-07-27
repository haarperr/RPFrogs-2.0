NPX = NPX or {}
NPX.Admin = NPX.Admin or {}
NPX._Admin = NPX._Admin or {}
NPX._Admin.Players = {}
NPX._Admin.DiscPlayers = {}

local Players = {}

SpectateData = {}

RegisterCommand('newmenu', function(source, args, RawCommand)
    TriggerClientEvent('np-admin_new:try-open-menu', source,  true)
end)

RPC.register('np-admin_new:getActivePlayers', function(Radius)
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

RPC.register('np-admin_new:getPermission', function()
    return true
end)

RPC.register('np-admin_new:getBans', function()
    local BanList = {}
    local q = [[SELECT * FROM user_bans]]

    exports.ghmattimysql:execute(q, function(result)
        if not result then result = BanList  return else print("no bans found.") end
    end)
    return BanList
 end)
 
 RPC.register('np-admin_new:getPlayers', function()
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
    TriggerClientEvent("np-admin_new:AddPlayer", -1, data )
    NPX.Admin.AddAllPlayers()
    Citizen.Wait(550)
    return Players
 end)

 RPC.register('np-admin_new:getChardata', function(source, cb, License)
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

RegisterNetEvent('np-admin_new:startSpectate', function(ServerId)
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
        TriggerClientEvent('np-admin_new:specPlayer', src, ServerId, tgtCoords)
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent('np-admin_new:stopSpectate', function()
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

RegisterNetEvent("np-admin_new:toggleBlips", function()
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
    TriggerClientEvent('np-admin_new:UpdatePlayerBlips', -1, BlipData)
end)

RegisterNetEvent("np-admin_new:banPlayer", function(ServerId, Expires, Reason)
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

RegisterNetEvent("np-admin_new:toggleGodmode", function(ServerId)
    TriggerClientEvent('np-admin_new:toggleGodmode', ServerId)
end)

RegisterNetEvent("np-admin_new:flingPlayer", function(ServerId)
    TriggerClientEvent('np-admin_new:flingPlayer', ServerId)
end)

RegisterNetEvent("np-admin_new:playSound", function(ServerId, SoundId)
    TriggerClientEvent('np-admin_new:playSound', ServerId, SoundId)
end)

RegisterNetEvent("np-admin_new:kickPlayer", function(ServerId, Reason)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
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

    if pAllowed(pSrc, "Search") ~= "user" then
        TriggerClientEvent("server-inventory-open", pSrc, "1", 'ply-'..cid)
        local info = pName .. " Searched " ..tName
        exports["np-base"]:k_log(pSrc, "Searching", info)
    end
end)

RegisterNetEvent("np-admin_new:giveItem", function(ServerId, ItemName, ItemAmount)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        if TPlayer ~= nil then
            local info =  "Item Name: " ..string.upper(ItemName) .. " Item Amount: " ..ItemAmount
            TriggerClientEvent('player:receiveItem', pSrc, ItemName, ItemAmount)
            exports["np-base"]:k_log(pSrc, "Spawned:items", info)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin_new/server/request-job", function(ServerId, JobName)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        if TPlayer ~= nil then
            TPlayer.Functions.SetJob(JobName, 1, 'Admin-Menu-Give-Job')
            TriggerClientEvent('DoLongHudText', src, 'Successfully set player as '..JobName..'.')
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin_new:setFoodDrink", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        if ServerId ~= nil then
            TPlayer.Functions.SetMetaData('thirst', 100)
            TPlayer.Functions.SetMetaData('hunger', 100)
            TriggerClientEvent('hud:client:UpdateNeeds', ServerId, 100, 100)
            TPlayer.Functions.Save();
            TriggerClientEvent('DoLongHudText', src, 'Successfully gave player food and water.')
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin_new/server/remove-stress", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        TPlayer.Functions.SetMetaData('stress', 0)
        TPlayer.Functions.Save();
        TriggerClientEvent('DoLongHudText', src, 'Successfully removed stress of player.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin_new/server/set-armor", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        local TPlayer = exports["np-base"]:getUser(ServerId)
        SetPedArmour(GetPlayerPed(ServerId), 100)
        TPlayer.Functions.SetMetaData('armor', 100)
        TPlayer.Functions.Save();
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player Armor.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin_new:resetSkin", function(ServerId)
    local Player = exports["np-base"]:getUser(ServerId)
    local result = MySQL.Sync.fetchAll('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', { Player.PlayerData.citizenid, 1 })
    if result[1] ~= nil then
        TriggerClientEvent("qb-clothes:loadSkin", ServerId, false, result[1].model, result[1].skin)
    else
        TriggerClientEvent("qb-clothes:loadSkin", ServerId, true)
    end
end)

RegisterNetEvent("np-admin_new:setModel", function(ServerId, Model)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        TriggerClientEvent('np-admin_new:setModel', ServerId, Model)
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission..', '2')
    end
end)

RegisterNetEvent("np-admin_new:reviveInDistance", function()
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

RegisterNetEvent("np-admin_new:reviveTarget", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        TriggerClientEvent('hospital:client:Revive', ServerId, true)
        TriggerClientEvent('DoLongHudText', src, 'Successfully revived player.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end

end)

RegisterNetEvent("np-admin_new:openClothing", function(ServerId)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    if pAllowed(src, "Admin Check") ~= "user" then
        TriggerClientEvent('qb-clothing:client:openMenu', ServerId)
        TriggerClientEvent('DoLongHudText', src, 'Successfully gave player clothing menu.')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

RegisterNetEvent("np-admin_new:teleportPlayer", function(ServerId, Type)
    local src = source
    local Player = exports["np-base"]:getUser(src)
    local Msg = ""
    if pAllowed(src, "Admin Check") ~= "user" then
        if Type == 'Goto' then
            Msg = 'teleported to'
            local TCoords = GetEntityCoords(GetPlayerPed(ServerId))
            TriggerClientEvent('np-admin_new/client/teleport-player', src, TCoords)
        elseif Type == 'Bring' then
            Msg = 'brought'
            local Coords = GetEntityCoords(GetPlayerPed(src))
            TriggerClientEvent('np-admin_new/client/teleport-player', ServerId, Coords)
        end
        TriggerClientEvent('DoLongHudText', src, 'Successfully '..Msg..' player.', '1')
    else
        TriggerClientEvent('DoLongHudText', src, 'No permission.', '2')
    end
end)

function pAllowed(pSrc, pTrigger)
    local user = exports["np-base"]:getUser(pSrc)
    local hexId = user:getVar("hexid")
    local pName = GetPlayerName(pSrc)
    print("Checking Perms | Admin Menu | Trigger: " .. pTrigger .. " | Source Steam Hex: " ..hexId.. " Steam Name: "..pName)

    exports.ghmattimysql:execute("SELECT `rank` FROM users WHERE hex_id = ?", {hexId}, function(data)
        pRank = data[1].rank

        if pRank == "user" then
            LogInfo = "Admin Menu | Trigger: " .. pTrigger
            -- exports['np-base']:DiscordLog("https://discord.com/api/webhooks/888637988911861760/hBwvp2tKY0AMgXrZvU4dqQz3oP1szvKmI1D24sm4bidHm8JueiBmgMvgKDV8NE19w0p9", pSrc, "Trigger-Event-Admin", "Triggering Events", LogInfo)
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

        TriggerClientEvent("np-admin_new:AddAllPlayers", source, data)

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

        TriggerClientEvent("np-admin_new:AddAllPlayers", source, data)

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

    TriggerClientEvent("np-admin_new:RemovePlayer", -1, data )
    Wait(600000)
    TriggerClientEvent("np-admin_new:RemoveRecent", -1, data)
end)

function HexIdToSteamId(hexId)
    local cid = math.floor(tonumber(string.sub(hexId, 7), 16))
	local steam64 = math.floor(tonumber(string.sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math.floor(math.abs(6561197960265728 - steam64 - a) / 2)
	local sid = "STEAM_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end