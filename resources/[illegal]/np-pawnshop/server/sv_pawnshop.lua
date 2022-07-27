--[[

    Variables

]]

local pawnshoptime = false

local pawnshopItems = {
    ["stolnerolexwatch"] = 500,
    ["stolen10ctchain"] = 350,
    ["stolenring"] = 150,
    ["stolenlaptop"] = 200,
}

local pawnshopLocations = {
    vector4(-201.27, -1568.08, 35.24, 139.31),
--   vector4(-225.39, -1637.76, 33.84, 1.9),
--    vector4(-151.99, -1442.87, 31.23, 231.95),
--    vector4(-82.9, -1399.7, 29.33, 182.9),
--    vector4(-25.64, -1491.26, 30.37, 138.23),
--    vector4(-49.52, -1535.37, 32.05, 232.08),
--   vector4(49.38, -1839.06, 24.44, 321.47),
--   vector4(206.22, -1851.73, 27.48, 137.56),
--   vector4(191.2, -2016.43, 18.31, 232.35),
--    vector4(286.93, -1945.32, 24.72, 46.7),
--    vector4(449.1, -1881.68, 26.9, 225.05),
--    vector4(532.21, -1806.0, 28.58, 268.45),
 --   vector4(456.23, -1737.23, 29.12, 61.34),
--    vector4(485.75, -1477.79, 29.3, 188.84),
 --   vector4(340.53, -1270.86, 32.01, 88.13),
 --   vector4(167.97, -1299.13, 29.38, 68.84),
--    vector4(145.04, -1655.48, 29.34, 219.17),
 --   vector4(208.8, -1688.47, 29.58, 125.01),
 --   vector4(285.95, -1726.89, 29.35, 226.86),
 --   vector4(355.52, -1869.88, 26.83, 39.12),
 --   vector4(419.92, -2063.93, 22.12, 48.46),
}

local currentLocation = vector4(-201.27, -1568.08, 35.24, 139.31)

--[[

    Events

]]

RegisterNetEvent("np-weathersync:server:time", function(pTime)
    local pHour = math.floor(pTime / 60)
    local pMinute = pTime % 60

    if pHour == 14 and pMinute == 59 and not pawnshoptime then
		pawnshoptime = true
        currentLocation = pawnshopLocations[math.random(#pawnshopLocations)]
	elseif pHour ~= 14 and pMinute ~= 59 and pawnshoptime then
		pawnshoptime = false
	end
end)

RegisterNetEvent("np-pawnshop:requestLocation")
RegisterNetEvent("np-pawnshop:requestLocation", function()
    local src = source
    TriggerClientEvent("np-npcs:set:position", src, "pawnshop", vector3(currentLocation[1], currentLocation[2], currentLocation[3] - 1), currentLocation[4])
end)

RegisterNetEvent("np-pawnshop:sell")
AddEventHandler("np-pawnshop:sell", function()
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local value = 0

    local inventory = exports["np-inventory"]:getInventory("ply-" .. cid)
    for i, v in ipairs(inventory) do
        local itemValue = pawnshopItems[v.item_id]

        if itemValue then
            TriggerEvent("server-remove-item", cid, v.item_id, v.amount)
            value = value + (itemValue * v.amount)
        end
    end

    if value == 0 then
        TriggerClientEvent("DoLongHudText", src, "You dont have anything to sell, your idiot!", 2)
    else
        exports["np-financials"]:updateCash(src, "+", value)
    end
end)