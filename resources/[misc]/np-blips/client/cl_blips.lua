--[[

    Variables

]]

local Config = {
    ["clothing"] = {
        ["text"] = "Clothing Shop",
        ["sprite"] = 73,
        ["scale"] = 0.6,
        ["colour"] = 2,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(1692.16, 4822.06, 42.06) },
            { ["pos"] = vector3(-710.38, -153.34, 37.42) },
            { ["pos"] = vector3(-1191.46, -770.67, 17.32) },
            { ["pos"] = vector3(423.71, -807.34, 29.49) },
            { ["pos"] = vector3(-162.12, -303.49, 39.73) },
            { ["pos"] = vector3(77.17, -1391.83, 29.38) },
            { ["pos"] = vector3(-820.24, -1074.56, 11.33) },
            { ["pos"] = vector3(-1451.41, -236.7, 49.8) },
            { ["pos"] = vector3(2.7, 6512.82, 31.88) },
            { ["pos"] = vector3(617.2, 2762.5, 42.09) },
            { ["pos"] = vector3(1197.9, 2708.73, 38.22) },
            { ["pos"] = vector3(-3173.26, 1045.35, 20.86) },
            { ["pos"] = vector3(-1099.3, 2709.9, 19.12) },
            { ["pos"] = vector3(122.81, -222.09, 54.56) },
        },
    },
    ["barber"] = {
        ["text"] = "Barber Shop",
        ["sprite"] = 71,
        ["scale"] = 0.6,
        ["colour"] = 48,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(1931.27, 3730.69, 32.84) },
            { ["pos"] = vector3(-277.51, 6227.35, 31.7) },
            { ["pos"] = vector3(1213.32, -473.15, 66.21) },
            { ["pos"] = vector3(-33.67, -153.46, 57.08) },
            { ["pos"] = vector3(137.73, -1707.2, 29.29) },
            { ["pos"] = vector3(-813.86, -184.15, 37.57) },
            { ["pos"] = vector3(-1281.76, -1117.41, 6.99) },
        },
    },
    ["tattoo"] = {
        ["text"] = "Tattoo Shop",
        ["sprite"] = 75,
        ["scale"] = 0.6,
        ["colour"] = 27,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(1323.0, -1652.8, 52.28) },
            { ["pos"] = vector3(-1154.29, -1426.76, 4.95) },
            { ["pos"] = vector3(323.34, 180.65, 103.59) },
            { ["pos"] = vector3(-3170.18, 1076.27, 20.83) },
        },
    },
    ["bank"] = {
        ["text"] = "Bank",
        ["sprite"] = 108,
        ["scale"] = 0.7,
        ["colour"] = 0,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(1175.8, 2706.82, 38.09) },
            { ["pos"] = vector3(-2962.62, 482.18, 15.7) },
            { ["pos"] = vector3(242.22, 224.99, 106.29) },
            { ["pos"] = vector3(-1213.29, -331.08, 37.78) },
            { ["pos"] = vector3(-351.63, -49.67, 49.04) },
            { ["pos"] = vector3(313.58, -278.91, 53.92) },
            { ["pos"] = vector3(149.22, -1040.5, 29.37) },
            { ["pos"] = vector3(-107.316, 6466.564, 32.168) },
        },
    },
    ["gas"] = {
        ["text"] = "Fuel Station",
        ["sprite"] = 361,
        ["scale"] = 0.7,
        ["colour"] = 0,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(49.41, 2778.79, 58.04) },
            { ["pos"] = vector3(263.89, 2606.46, 44.98) },
            { ["pos"] = vector3(1039.95, 2671.13, 39.55) },
            { ["pos"] = vector3(1207.26, 2660.17, 37.89) },
            { ["pos"] = vector3(2539.68, 2594.19, 37.94) },
            { ["pos"] = vector3(2679.85, 3263.94, 55.24) },
            { ["pos"] = vector3(2005.05, 3773.88, 32.40) },
            { ["pos"] = vector3(1687.15, 4929.39, 42.07) },
            { ["pos"] = vector3(1701.31, 6416.02, 32.76) },
            { ["pos"] = vector3(179.85, 6602.83, 31.86) },
            { ["pos"] = vector3(-94.46, 6419.59, 31.48) },
            { ["pos"] = vector3(-2554.99, 2334.40, 33.07) },
            { ["pos"] = vector3(-1800.37, 803.66, 138.65) },
            { ["pos"] = vector3(-1437.62, -276.74, 46.20) },
            { ["pos"] = vector3(-2096.24, -320.28, 13.16) },
            { ["pos"] = vector3(-724.61, -935.16, 19.21) },
            { ["pos"] = vector3(-526.01, -1211.00, 18.18) },
            { ["pos"] = vector3(-70.21, -1761.79, 29.53) },
            { ["pos"] = vector3(265.64,-1261.30, 29.29) },
            { ["pos"] = vector3(819.65,-1028.84, 26.40) },
            { ["pos"] = vector3(1208.95,-1402.56, 35.22) },
            { ["pos"] = vector3(1181.38,-330.84, 69.31) },
            { ["pos"] = vector3(620.84, 269.10, 103.08) },
            { ["pos"] = vector3(2581.32, 362.03, 108.46) },
            { ["pos"] = vector3(1785.36, 3330.37, 41.38) },
            { ["pos"] = vector3(-319.53, -1471.51, 30.54) },
            { ["pos"] = vector3(-66.58, -2532.56, 6.14) },
        },
    },
    ["pd"] = {
        ["text"] = "Police Department",
        ["sprite"] = 60,
        ["scale"] = 0.75,
        ["colour"] = 3,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(425.13, -979.55, 30.71) },
            { ["pos"] = vector3(1856.91, 3689.50, 34.26) },
            { ["pos"] = vector3(-450.06, 6016.57, 31.71) },
        },
    },
    ["hospital"] = {
        ["text"] = "Hospital",
        ["sprite"] = 61,
        ["scale"] = 0.75,
        ["colour"] = 2,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(357.43, -593.36, 28.79) },
        },
    },
    ["market"] = {
        ["text"] = "Shop",
        ["sprite"] = 52,
        ["scale"] = 0.7,
        ["colour"] = 2,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(373.87, 325.89, 102.56) },
            { ["pos"] = vector3(2557.45, 382.28, 107.62) },
            { ["pos"] = vector3(-3038.93, 585.95, 6.90) },
            { ["pos"] = vector3(-3241.92, 1001.46, 11.83) },
            { ["pos"] = vector3(547.43, 2671.71, 41.15) },
            { ["pos"] = vector3(1961.46, 3740.67, 31.34) },
            { ["pos"] = vector3(2678.91, 3280.67, 54.24) },
            { ["pos"] = vector3(1729.21, 6414.13, 34.03) },
            { ["pos"] = vector3(1135.80, -982.28, 45.41) },
            { ["pos"] = vector3(-1222.91, -906.98, 11.32) },
            { ["pos"] = vector3(-1487.55, -379.10, 39.16) },
            { ["pos"] = vector3(-2968.24, 390.91, 14.04) },
            { ["pos"] = vector3(1166.02, 2708.93, 37.15) },
            { ["pos"] = vector3(1392.56, 3604.68, 33.98) },
            { ["pos"] = vector3(25.72, -1346.96, 28.49) },
            { ["pos"] = vector3(-48.51, -1757.51, 28.42) },
            { ["pos"] = vector3(1163.37, -323.80, 68.20) },
            { ["pos"] = vector3(-707.50, -914.26, 18.21) },
            { ["pos"] = vector3(-1820.52, 792.51, 137.11) },
            { ["pos"] = vector3(1698.38, 4924.40, 41.06) },
        },
    },
    ["ammunation"] = {
        ["text"] = "Ammunation",
        ["sprite"] = 110,
        ["scale"] = 0.7,
        ["colour"] = 17,

        ["default"] = true,

        ["blips"] = {
            { ["pos"] = vector3(-662.10, -935.30, 20.81) },
            { ["pos"] = vector3(810.20, -2157.30, 28.61) },
            { ["pos"] = vector3(1693.40, 3759.50, 33.71) },
            { ["pos"] = vector3(-330.20, 6083.80, 30.41) },
            { ["pos"] = vector3(252.30, -50.00, 68.91) },
            { ["pos"] = vector3(22.00, -1107.20, 28.81) },
            { ["pos"] = vector3(2567.60, 294.30, 107.71) },
            { ["pos"] = vector3(-1117.50, 2698.60, 17.51) },
            { ["pos"] = vector3(842.40, -1033.40, 27.11) },
            { ["pos"] = vector3(-1306.20, -394.00, 35.61) },
        },
    },
    ["garage"] = {
        ["default"] = true,
        ["custom"] = true,

        ["blips"] = {
            { ["text"] = "Garage A", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(469.819, -73.265, 77.032) },
            { ["text"] = "Garage B", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-314.82, -755.182, 33.542) },
            { ["text"] = "Garage Apartments", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-297.86, -982.94, 30.644) },
            { ["text"] = "Garage D", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(397.78, -1341.37, 30.947) },
            { ["text"] = "Garage E", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(598.77, 90.707, 92.829) },
            { ["text"] = "Garage F", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(641.53, 205.42, 97.186) },
            { ["text"] = "Garage G", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(82.359, 6418.95, 31.479) },
            { ["text"] = "Garage H", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-794.57, -2020.84, 8.943) },
            { ["text"] = "Garage I", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-669.15, -2001.75, 7.539) },
            { ["text"] = "Garage J", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-606.86, -2236.76, 6.077) },
            { ["text"] = "Garage K", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-166.60, -2143.93, 16.839) },
            { ["text"] = "Garage L", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-38.92, -2097.26, 16.704) },
            { ["text"] = "Garage M", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(70.17, -2004.41, 18.0169) },
            { ["text"] = "Garage O", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-70.17, -2004.41, 18.016) },
            { ["text"] = "Garage P", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-338.31, 266.79, 85.741) },
            { ["text"] = "Garage Q", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(278.25, -333.51, 44.919) },
            { ["text"] = "Garage R", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(66.21, 13.70, 69.047) },
            { ["text"] = "Garage S", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(286.67, 79.613, 94.362) },
            { ["text"] = "Garage T", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(217.73, -796.49, 30.780) },
            { ["text"] = "Garage Casino", ["sprite"] = 357, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(886.14, -0.88, 78.76) }
        },
    },
    ["misc"] = {
        ["default"] = true,
        ["custom"] = true,

        ["blips"] = {
            { ["text"] = "Butch's Bike Shop", ["sprite"] = 226, ["scale"] = 0.7, ["colour"] = 38, ["pos"] = vector3(156.17, -1724.81, 28.25) },
            { ["text"] = "Premium Deluxe Motorsport", ["sprite"] = 326, ["scale"] = 0.7, ["colour"] = 7, ["pos"] = vector3(-33.737, -1102.322, 26.422) },
            { ["text"] = "Benny's Original Motorworks", ["sprite"] = 446, ["scale"] = 0.7, ["colour"] = 5,  ["pos"] = vector3(-211.55, -1324.55, 30.90) },
            { ["text"] = "Prison", ["sprite"] = 60, ["scale"] = 0.8, ["colour"] = 3, ["pos"] = vector3(1679.049, 2513.711, 45.565) },
            { ["text"] = "Smoke On The Water", ["sprite"] = 469, ["scale"] = 0.7, ["colour"] = 25, ["pos"] = vector3(-1171.17, -1571.09, 3.67) },
            { ["text"] = "Taco Shop", ["sprite"] = 79, ["scale"] = 0.7, ["colour"] = 25, ["pos"] = vector3(409.89, -1915.49, 25.11) },
            { ["text"] = "Food Supplier", ["sprite"] = 628, ["scale"] = 0.7, ["colour"] = 5, ["pos"] = vector3(-72.07, -1821.95, 26.94) },
            { ["text"] = "Trading Card Vendor", ["sprite"] = 614, ["scale"] = 0.7, ["colour"] = 50, ["pos"] = vector3(256.66, -1598.44, 30.54) },
            { ["text"] = "Hardoak Farm", ["sprite"] = 477, ["scale"] = 0.7, ["colour"] = 52, ["pos"] = vector3(1551.88, 2203.65, 78.76) },
            { ["text"] = "Burgershot", ["sprite"] = 106, ["scale"] = 0.7, ["colour"] = 61, ["pos"] = vector3(-1182.76, -883.53, 13.76) },
            { ["text"] = "WineTime Winery", ["sprite"] = 93, ["scale"] = 0.7, ["colour"] = 3, ["pos"] = vector3(-1880.50, 2090.27, 140.99) },
            { ["text"] = "Apartments", ["sprite"] = 475, ["scale"] = 0.7, ["colour"] = 21, ["pos"] = vector3(-260.40, -973.67, 31.22) },
            { ["text"] = "Boat House - Fishing", ["sprite"] = 11, ["scale"] = 0.7, ["colour"] = 21, ["pos"] = vector3(1531.45, 3776.94, 34.5616) },
            { ["text"] = "Recycling Yard - Sanitation", ["sprite"] = 67, ["scale"] = 0.7, ["colour"] = 21, ["pos"] = vector3(-335.65713500977, -1564.6812744141, 24.9326171875) },
        },
    },
}

--[[

    Events

]]

AddEventHandler("np-blips:update", function(pType, pInit)
    if not pType or not Config[pType] then return end

    local blips = exports["storage"]:tryGet("table", "np-blips")

    if pInit ~= true then
        blips[pType] = not blips[pType]
        exports["storage"]:set(blips, "np-blips")
    end

    local show = blips[pType]
    local typeData = Config[pType]
    local typeBlips = typeData["blips"]

    if typeData["custom"] then
        TriggerEvent("np-blips:updateMisc", pType, show)
        return
    end

    for i, v in ipairs(typeBlips) do
        if show then
            v["blip"] = AddBlipForCoord(v["pos"])
            SetBlipSprite(v["blip"], typeData["sprite"])
            SetBlipScale(v["blip"], typeData["scale"])
            SetBlipAsShortRange(v["blip"], true)
            SetBlipColour(v["blip"], typeData["colour"])
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(typeData["text"])
            EndTextCommandSetBlipName(v["blip"])
        else
            if v["blip"] ~= nil then
                RemoveBlip(v["blip"])
            end
        end
    end
end)

AddEventHandler("np-blips:updateMisc", function(pType, show)
    local typeData = Config[pType]
    local typeBlips = typeData["blips"]

    for i, v in ipairs(typeBlips) do
        if show then
            v["blip"] = AddBlipForCoord(v["pos"])
            SetBlipSprite(v["blip"], v["sprite"])
            SetBlipScale(v["blip"], v["scale"])
            SetBlipAsShortRange(v["blip"], true)
            SetBlipColour(v["blip"], v["colour"])
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v["text"])
            EndTextCommandSetBlipName(v["blip"])
        else
            if v["blip"] ~= nil then
                RemoveBlip(v["blip"])
            end
        end
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local update = false
    local blips = exports["storage"]:tryGet("table", "np-blips")

    if blips then
        for k, v in pairs(blips) do
            if Config[k] == nil then
                blips[k] = nil
                update = true
            end
        end
        for k, v in pairs(Config) do
            if blips[k] == nil then
                blips[k] = v.default
                update = true
            end
        end
    else
        update = true
        blips = {}

        for k, v in pairs(Config) do
            blips[k] = v.default
        end
    end

    if update then
        exports["storage"]:set(blips, "np-blips")
    end

    for k, v in pairs(Config) do
        TriggerEvent("np-blips:update", k, true)
    end
end)