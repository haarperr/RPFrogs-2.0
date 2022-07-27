RegisterNetEvent("DoLongHudText")
AddEventHandler("DoLongHudText", function(text,color)
    if not color then 
        color = 1 
    end

    SendNUIMessage({
        runProgress = true,
        colorsent = color,
        textsent = text,
        fadesent = 12000
    })
end)

RegisterNetEvent("DoShortHudText")
AddEventHandler("DoShortHudText", function(text,color)
    if not color then
        color = 1
    end

    SendNUIMessage({
        runProgress = true,
        colorsent = color,
        textsent = text,
        fadesent = 10000
    })
end)
