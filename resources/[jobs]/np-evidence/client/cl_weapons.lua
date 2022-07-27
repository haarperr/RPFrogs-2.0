local excludedWeapons = {
    [`WEAPON_FIREEXTINGUISHER`] = true,
    [`WEAPON_PetrolCan`] = true,
    [-2009644972] = true, -- paintball gun bruv
    [1064738331] = true, -- bricked
    [-828058162] = true, -- shoed
    [571920712] = true, -- money
    [-691061592] = true, -- book
    [1834241177] = true, -- EMP Gun
    [600439132] = true, -- Lime
}

local weaponsAmmo = {
    ["148457251"] = "9×19mm", -- Browning
    ["-2012211169"] = "9x19mm", -- Diamondback DB9
    ["-1746263880"] = ".357 Magnum", -- Colt Python
    ["453432689"] = ".45 ACP", -- Colt 1911
    ["1075685676"] = "9×19mm", -- Beretta M9
    ["1593441988"] = "9×19mm", -- FN FNX-45
    ["-120179019"] = "9×19mm", -- Glock 18
    ["-1716589765"] = ".50 AP", -- Desert Eagle
    ["-134995899"] = "9×19mm", -- Mac-10
    ["584646201"] = "9×19mm", -- Glock 18C
    ["-942620673"] = ".45 ACP", -- Uzi
    ["736523883"] = "9x19mm", -- MP5
    ["1192676223"] = "5.56×45mm", -- M4
    ["-1768145561"] = "5.56×45mm", -- FN SCAR-L
    ["-1719357158"] = "7.62x51mm", -- Mk14
    ["100416529"] = "7.62x51mm", -- M24
    ["-1536150836"] = ".338 Lapua Magnum", -- AWM
    ["-90637530"] = "7.62x54R", -- Dragunov
    ["-1074790547"] = "7.62x39mm", -- AK-47
    ["497969164"] = "7.62x39mm", -- M70
    ["-275439685"] = "12x70mm", -- Saw-off Shotgun
    ["487013001"] = "12x70mm", -- IZh-81
    ["1432025498"] = "12x70mm", -- Remington 870
    ["171789620"] = "9x19mm", -- SIG MPX
    ["1649403952"] = "9×19mm", -- Draco NAK9
    ["-1472189665"] = ".32 ACP", -- Skorpion
}

local colors = {
    --[0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark Silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "Hunter Green",
    [145] = "Metallic Purple",
    [146] = "Metallic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Unknown",
}

local dropBulletCasing = function(pPed, pWeaponHash, pWeaponType, pIdentifier)
    local x, y, z = math.random(20)/10, math.random(20)/10, nil

    if (math.random(2) == 1) then
        y = (0 - y)
    end

    x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(pPed, x, y, -0.7 ))

    if Ped.isInVehicle then z = z + 0.7 end

    local meta = {
        ["type"] = "casing",
        ["identifier"] = pIdentifier or "FADED",
        ["text"] = "Capsula",
        ["Tipo de Evidencia"] = "Capsula de disparo",
        ["Calibre"] = weaponsAmmo[tostring(pWeaponHash)] or "NOT DEFINED",
        ["_hideKeys"] = { "type", "identifier", "text" },
    }

    TriggerEvent("np-evidence:dropEvidence", vector3(x, y, z), meta)
end

local dropImpactFragment = function(pPed, pDist, pWeaponHash, pWeaponType, pIdentifier)
    local startCoords = GetGameplayCamCoord()

    local endCoords = startCoords + (GetCameraForwardVectors() * pDist)

    local result = ShapeTestLosProbe(startCoords, endCoords, -1, pPed, 1)

    if not result.hit and not result.hitPosition then return end

    local meta = {
        ["type"] = "projectile",
        ["identifier"] = pIdentifier or "FADED",
        ["text"] = "Projétil",
        ["Tipo de Evidencia"] = "Projétil disparado",
        ["Calibre"] = weaponsAmmo[tostring(pWeaponHash)] or "NOT DEFINED",
        ["Estriamento"] = "Não analisado",
        ["_hideKeys"] = { "type", "identifier", "text" },
    }

    local isAVehicle = result.entityHit ~= 0 and IsEntityAVehicle(result.entityHit)

    if isAVehicle == 1 and math.random(4) > 1 then
        local r, g, b = GetVehicleColor(result.entityHit)
        local color1, color2 = GetVehicleColours(result.entityHit)

        if color1 == 0 then color1 = 1 end
        if color2 == 0 then color2 = 2 end
        if color1 == -1 then color1 = 158 end
        if color2 == -1 then color2 = 158 end

        meta = {
            ["type"] = "vehiclefragment",
            ["identifier"] = result.entityHit,
            ["text"] = "Fragmento de veículo",
            ["rgb"] = { ["r"] = r, ["g"] = g, ["b"] = b },
            ["Tipo de Evidencia"] = "Fragmento colorido de veículo",
            ["Cor Primária"] = colors[color1],
            ["Cor Secundária"] = colors[color2],
            ["_hideKeys"] = { "type", "identifier", "text", "rgb" },
        }
    end

    TriggerEvent("np-evidence:dropEvidence", result.hitPosition, meta, "p")
end

Citizen.CreateThread(function ()
    while true do
        local idle = 1000

        if not Ped.isArmed or excludedWeapons[Ped.weaponHash] then
            goto continue
        end

        idle = 0

        Ped.isShooting = IsPedShooting(Ped.handle)

        Ped.isAiming = IsPlayerFreeAiming(Ped.playerId)

        if not Ped.isShooting then goto continue end

        dropBulletCasing(Ped.handle, Ped.weaponHash, Ped.weaponType, Ped.weaponInfo)

        dropImpactFragment(Ped.handle, 150.0, Ped.weaponHash, Ped.weaponType, Ped.weaponInfo)

        idle = 100

        ::continue::

        Citizen.Wait(idle)
    end
end)