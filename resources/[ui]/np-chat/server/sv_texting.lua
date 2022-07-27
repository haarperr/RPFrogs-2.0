RegisterNetEvent("np-chat:texting", function(toggle)
    local src = source
    TriggerClientEvent("np-chat:texting", -1, src, toggle)
end)