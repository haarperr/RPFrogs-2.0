-- {
--     ["active"] = true,
--     ["model"] = -222270721,
--     ["coords"] = vector3(256.82, 220.19, 106.28),
--     ["lock"] = 1,
--     ["automatic"] = {
--         --["distance"] = 1.0,
--         --["rate"] = 1.0,
--     },
--     ["access"] = {
--         ["cid"] = { 1 },
--         ["job"] = { "police" },
--         ["groups"] = {
--             ["police"] = 10,
--         },
--         ["item"] = {},
--     }
--     ["keyFob"] = true,
-- },

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    TriggerClientEvent("np-doors:initial-lock-state", -1, DOORS)
end)