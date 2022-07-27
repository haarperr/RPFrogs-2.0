--[[

    Variables

]]

local pawnshoptime = false

--[[

    Events

]]

RegisterNetEvent("np-weathersync:currentTime", function(pHour, pMinute)
    if (pHour > 15 or pHour < 7) and not pawnshoptime then
		TriggerServerEvent("np-pawnshop:requestLocation")
	elseif (pHour <= 15 and pHour >= 7) and pawnshoptime then
		TriggerEvent("np-npcs:set:position", "pawnshop", vector3(0, 0, -100), 0)
      --  TriggerServerEvent("np-pawnshop:requestLocation")
	end
end)

AddEventHandler("np-pawnshop:buy", function()
    TriggerEvent("server-inventory-open", "777", "Shop")
end)

AddEventHandler("np-pawnshop:sell", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
    local npcCoords = GetEntityCoords(pEntity)
    local finished = exports["np-taskbar"]:taskBar(3000, "Selling, don't move.")
    if finished == 100 then
        if #(GetEntityCoords(PlayerPedId()) - npcCoords) < 2.0 then
            TriggerServerEvent("np-pawnshop:sell")
        else
            TriggerEvent("DoLongHudText", "You moved away.", 2)
        end
    end
end)