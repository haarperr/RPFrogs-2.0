
RegisterServerEvent('np-fishing:cashcheck')
AddEventHandler('np-fishing:cashcheck', function()
    local src = source
    local cash = exports["np-financials"]:getCash(src)

  if cash >= 0 then
    if exports["np-financials"]:updateCash(src, "-", 0) then
        TriggerClientEvent('np-fishing:select_zone_6')
    else

    end
end
end)