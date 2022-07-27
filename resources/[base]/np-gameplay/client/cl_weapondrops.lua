Citizen.CreateThread(function()
	while true do
        local pedPool = GetGamePool("CPed")

        for k, v in pairs(pedPool) do
            SetPedDropsWeaponsWhenDead(v, false)

            if Config.BlacklistedPeds[GetEntityModel(v)] and DecorGetInt(v, "NPC_ID") == 0 and not DecorExistOn(v, "ScriptedPed") then
                Sync.DeleteEntity(v)
            end
	    end

	    Citizen.Wait(500)
    end
end)