RegisterServerEvent('reviveGranted')
AddEventHandler('reviveGranted', function(t)
	TriggerClientEvent('reviveFunction', t)
end)

RegisterServerEvent('trycpr')
AddEventHandler('trycpr', function()
	local user = exports["np-base"]:getUser(src)
    local price = 1000
    if user:getCash() >= price then
        user:removeMoney(price)
        TriggerClientEvent('trycpr', source)
    else
        TriggerClientEvent('DoLongHudText', source, "You can't afford that CPR", 2)
    end
end)

RegisterServerEvent('serverCPR')
AddEventHandler('serverCPR', function()
	TriggerClientEvent('revive', source)
end)