triggered = false;
AddEventHandler("playerSpawned", function()
    if not triggered then 
        triggered = true;
        Citizen.Wait((1000 * 20)); -- Wait 20 seconds
        TriggerServerEvent('npapi:PlayerLoaded');
    end
end)