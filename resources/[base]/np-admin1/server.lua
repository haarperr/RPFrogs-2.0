players = {}

RegisterNetEvent('getallplayers')
AddEventHandler('getallplayers', function(source)
   if GetCurrentResourceName() == "np-admin" then
        for k in pairs (players) do
            players [k] = nil
        end
        
        for _, playerId in ipairs(GetPlayers()) do
            local name = GetPlayerName(playerId)
            table.insert(players, {name, playerId})
        end

        TriggerClientEvent('RecieveActivePlayers', -1, players)
        Citizen.Wait(10000)
    end
end)

RegisterServerEvent('np-adminmenu:sendAnnoucement')
AddEventHandler("np-adminmenu:sendAnnoucement", function(msg)
    TriggerClientEvent('chatMessage', -1, 'Admin', 1, msg)
end)

RegisterServerEvent("np-adminmenu:CheckInventory")
AddEventHandler("np-adminmenu:CheckInventory", function(target)
    local src = source
    if target ~= "" then
        local user = exports["np-base"]:getUser(tonumber(target))
        local char = user:getCurrentCharacter()
        TriggerClientEvent('np-adminmenu:CloseMouse', src)
        Wait(1)
        TriggerClientEvent("server-inventory-open", src, "1", "ply-"..char.id)
    else
        TriggerClientEvent('np-adminmenu:CloseMouse', src)
        TriggerClientEvent('DoLongHudText', src, 'You need to select someone to search!', 2)
    end
end)

RegisterServerEvent('admin:bringPlayer')
AddEventHandler('admin:bringPlayer', function(pSrc, target)
    local pTarget = tonumber(target)
    local coords = GetEntityCoords(GetPlayerPed(tonumber(pSrc)))
    TriggerClientEvent('np-admin:bringPlayer', pTarget, coords)
    TriggerClientEvent('DoLongHudText', tonumber(pSrc), 'Player Brought!')
end)

RegisterServerEvent('admin:teleportToPlayer')
AddEventHandler('admin:teleportToPlayer', function(target)
    local src = source
    local coords = GetEntityCoords(GetPlayerPed(target))
    TriggerClientEvent('np-admin:bringPlayer', src, coords)
    TriggerClientEvent('DoLongHudText', src, 'You teleported to this player.')
end)

RegisterCommand("menu1", function(source, args)
    local src = source
    local steamIdentifier = GetPlayerIdentifiers(src)[1]

    exports.oxmysql:execute('SELECT * FROM users WHERE `hex`= ?', {steamIdentifier}, function(data)
        if data[1].rank == "dev" or data[1].rank == "admin" or data[1].rank == "mod" then
            TriggerClientEvent('np:openmodmenu', src) 
        end
    end)
end)