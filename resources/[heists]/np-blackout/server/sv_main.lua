function BlackoutTimer()
    local timer = CONFIG.BlackoutCooldown
    repeat 
        Citizen.Wait(1000)
        timer = timer - 1
    until timer == 0
    CONFIG.BlackoutStatus = false
    --Make Chatmassage for everyone because powerplant up again
    TriggerClientEvent('chatMessage', -1, "^1[LS Water & Power]", {255, 0, 0}, "City power has been restored!")
    TriggerClientEvent("sp34r:client:blackout", -1, CONFIG.BlackoutStatus)
end



AddEventHandler('explosionEvent', function(sender, ev)
    if ev.explosionType == 2 then
        if #(CONFIG.PowerPlantCoord - vector3(ev.posX, ev.posY, ev.posZ)) < 3.0 then
            if not CONFIG.BlackoutStatus then
                CONFIG.BlackoutStatus = true
                for k, v in pairs(CONFIG.BlackoutExplosion) do
                    Citizen.Wait(1000)
                    TriggerClientEvent("particle:explosion:coord", -1, v)
                end
                --Make chatmassage for everyone because powerplant down
                TriggerClientEvent('chatMessage', -1, "^1[LS Water & Power]", {255, 0, 0}, "City power is currently out, we're working on restoring it!")
                TriggerClientEvent("sp34r:client:blackout", -1, CONFIG.BlackoutStatus)
                BlackoutTimer()
            end
        end
    end
end)

RegisterServerEvent("sp34r:server:blackout")
AddEventHandler("sp34r:server:blackout",function()
    local src = source 
    TriggerClientEvent("sp34r:client:blackout", -1, CONFIG.BlackoutStatus)
end)