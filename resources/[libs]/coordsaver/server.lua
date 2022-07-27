RegisterServerEvent("SaveCoords")
AddEventHandler("SaveCoords", function(name, x, y, z, h, text)
    local src = source

    file = io.open(name .. "-Coords.txt", "a")

    if file then
        file:write("vector4(" .. x .. ", " .. y .. ", " .. z .. ", " .. h .. "),\n")
    end

    file:close()

    TriggerClientEvent("DoLongHudText", src, "Position saved")
end)

RegisterServerEvent("SaveCoordsOffset")
AddEventHandler("SaveCoordsOffset", function(name, x, y, z, h, text)
    local src = source

    file = io.open(name .. "-CoordsOffset.txt", "a")

    if file then
        file:write("vector4(" .. x .. ", " .. y .. ", " .. z .. ", " .. h .. "),\n")
    end

    file:close()

    TriggerClientEvent("DoLongHudText", src, "Position saved")
end)