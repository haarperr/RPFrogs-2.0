--[[

    RPCs

]]

RPC.register("np-vehicles:addFakePlate", function(src, vid)
    local plate = randomPlate()

    MySQL.update.await([[
        UPDATE vehicles_metadata
        SET fakePlate = ?
        WHERE vid = ?
    ]],
    { plate, vid })

    TriggerClientEvent("inventory:removeItem", src, "fakeplate", 1)

    return plate
end)

RPC.register("np-vehicles:removeFakePlate", function(src, vid)
    MySQL.update.await([[
        UPDATE vehicles_metadata
        SET fakePlate = NULL
        WHERE vid = ?
    ]],
    { vid })

    local plate = MySQL.scalar.await([[
        SELECT plate
        FROM vehicles
        WHERE id = ?
    ]],
    { vid })

    TriggerClientEvent("player:receiveItem", src, "fakeplate", 1)

    return plate
end)