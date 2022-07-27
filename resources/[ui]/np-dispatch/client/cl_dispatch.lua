--[[

    Variables

]]

local disableNotis, disableNotifSounds = false, false

local currentJob = "unemployed"
local daytime = false
local curWatchingPeds = {}

local tasksIdle = {
    [1] = "CODE_HUMAN_MEDIC_KNEEL",
    [2] = "WORLD_HUMAN_STAND_MOBILE",
}

local nextMeleeAction = GetCloudTimeAsInt()
local nextStabbingAction = GetCloudTimeAsInt()

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

local tenThirteenA = false
local tenThirteenB = false

local excludedWeapons = {
    [`WEAPON_FIREEXTINGUISHER`] = true,
    [`WEAPON_FLARE`] = true,
    [`WEAPON_PetrolCan`] = true,
    [`WEAPON_STUNGUN`] = true,
    [-2009644972] = true, -- paintball gun bruv
    [1064738331] = true, -- bricked
    [-828058162] = true, -- shoed
    [571920712] = true, -- cash
    [-1569615261] = true, -- cash
    [-691061592] = true, -- book
    [1834241177] = true, -- EMP Gun
    [-37975472] = true, -- Smoke Grenade
    [600439132] = true, -- Lime
}

--[[

    Functions

]]

function canPedBeUsed(ped, isGunshot, isSpeeder)
    -- if math.random(100) > 15 then
    --     return false
    -- end

    if ped == nil then
        return false
    end

    if isSpeeder == nil then
        isSpeeder = false
    end

    if ped == PlayerPedId() then
        return false
    end

    if GetEntityHealth(ped) < GetEntityMaxHealth(ped) then
        return false
    end

    if isSpeeder then
        if not IsPedInAnyVehicle(ped, false) then
            return false
        end
    end

    if `mp_f_deadhooker` == GetEntityModel(ped) then
        return false
    end

    local curcoords = GetEntityCoords(PlayerPedId())
    local startcoords = GetEntityCoords(ped)

    if #(curcoords - startcoords) < 10.0 then
        return false
    end

    if not HasEntityClearLosToEntity(PlayerPedId(), ped , 17) and not isGunshot then
        return false
    end

    if not DoesEntityExist(ped) then
        return false
    end

    if IsPedAPlayer(ped) then
        return false
    end

    if IsPedFatallyInjured(ped) then
        return false
    end

    if IsPedArmed(ped, 7) then
        return false
    end

    if IsPedInMeleeCombat(ped) then
        return false
    end

    if IsPedShooting(ped) then
        return false
    end

    if IsPedDucking(ped) then
        return false
    end

    if IsPedBeingJacked(ped) then
        return false
    end

    if IsPedSwimming(ped) then
        return false
    end

    if IsPedJumpingOutOfVehicle(ped) or IsPedBeingJacked(ped) then
        return false
    end

    local pedType = GetPedType(ped)
    if pedType ~= 4 and pedType ~= 5 then
        return false
    end

    return true
end

function getRandomNpc(basedistance, isGunshot)
    local basedistance = basedistance
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom

    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)
        if canPedBeUsed(ped, isGunshot) and distance < basedistance and distance > 2.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)

    return rped
end

function BringNpcs()
    for i = 1, #curWatchingPeds do
        if DoesEntityExist(curWatchingPeds[i]) then
            ClearPedTasks(curWatchingPeds[i])
            SetEntityAsNoLongerNeeded(curWatchingPeds[i])
        end
    end

    curWatchingPeds = {}

    local basedistance = 35.0
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom

    repeat
        local pos = GetEntityCoords(ped)
        local distance = #(playerCoords - pos)

        if canPedBeUsed(ped, false) and distance < basedistance and distance > 3.0 then
            if math.random(75) > 45 and #curWatchingPeds < 5 then
                TriggerEvent("TriggerAIRunning",ped)
                curWatchingPeds[#curWatchingPeds] = ped
            end
        end

        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)
end

function randomizeBlipLocation(pOrigin)
    local x = pOrigin.x
    local y = pOrigin.y
    local z = pOrigin.z
    local luck = math.random(2)
    y = math.random(35) + y
    if luck == 1 then
        x = math.random(35) + x
    end
    return {x = x, y = y, z = z}
end

function addDispatchBlip(data)
    local blip = nil

    if data.blipArea and data.blipArea >= 1 then
        local blipLocation = randomizeBlipLocation(data.blipLocation)
        blip = AddBlipForRadius(blipLocation.x, blipLocation.y, blipLocation.z, data.blipArea + 0.0)
        SetBlipAlpha(blip, 90)
    elseif data.blipLocation then
        blip = AddBlipForCoord(data.blipLocation.x, data.blipLocation.y, data.blipLocation.z)
        SetBlipScale(blip, 2.0)
        SetBlipAlpha(blip, 180)
    end

    if data.isImportant then
        SetBlipFlashesAlternate(blip,true)
    end

    SetBlipSprite(blip, data.blipSprite)
    SetBlipColour(blip, data.blipColor)

    SetBlipHighDetail(blip, 1)
    BeginTextCommandSetBlipName("STRING")
    local displayText = data.blipDescription
    AddTextComponentString(data.blipTenCode .. " | " .. data.blipDescription)
    EndTextCommandSetBlipName(blip)

    Citizen.CreateThread(function()
        Citizen.Wait(180000)
        RemoveBlip(blip)
    end)
end

function getCardinalDirectionFromHeading()
    local heading = GetEntityHeading(PlayerPedId())
    if heading >= 315 or heading < 45 then
        return "North Bound"
    elseif heading >= 45 and heading < 135 then
        return "West Bound"
    elseif heading >=135 and heading < 225 then
        return "South Bound"
    elseif heading >= 225 and heading < 315 then
        return "East Bound"
    end
end

function GetVehicleDescription()
    local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if not DoesEntityExist(currentVehicle) then return end

    local plate = GetVehicleNumberPlateText(currentVehicle)
    local make = GetDisplayNameFromVehicleModel(GetEntityModel(currentVehicle))
    local color1, color2 = GetVehicleColours(currentVehicle)

    if color1 == 0 then color1 = 1 end
    if color2 == 0 then color2 = 2 end
    if color1 == -1 then color1 = 158 end
    if color2 == -1 then color2 = 158 end

    if math.random(100) > 25 then
        plate = "Unknown"
    end

    local dir = getCardinalDirectionFromHeading()

    local vehicleData  = {
        model = make,
        plate = plate,
        firstColor = colors[color1],
        secondColor = colors[color2],
        heading = dir
    }

    return vehicleData
end

function GetStreetAndZone()
    local coords = GetEntityCoords(PlayerPedId())
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(coords.x, coords.y, coords.z)))
    local playerStreetsLocation = area
    if not zone then zone = "UNKNOWN" end
    if currentStreetName ~= nil and currentStreetName ~= "" then playerStreetsLocation = currentStreetName .. ", " ..area
    else playerStreetsLocation = area end
    return playerStreetsLocation
end

function AlertpersonRobbed()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-31B"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 2,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Armed Robbery",
        blipSprite = 458,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 2,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function DrugSale()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-34"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 2,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Sale of Narcotics",
        blipSprite = 514,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 2,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function DrugUse()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-56"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 2,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Drug Use",
        blipSprite = 140,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 2,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function CarCrash()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
    if currentVeh == 0 or GetVehicleNumberPlateText(currentVeh) == nil then currentVeh = GetVehiclePedIsIn(PlayerPedId(), true) end
    local vehicleData = GetVehicleDescription(currentVeh) or {}

    local dispatchCode = "10-50"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        model = vehicleData.model,
        plate = vehicleData.plate,
        priority = 3,
        firstColor = vehicleData.firstColor,
        secondColor = vehicleData.secondColor,
        heading = vehicleData.heading,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        blipSprite = 380,
        blipColor = 0,
        dispatchMessage = "Vehicle Accident",
        job = {"police", "ems"}
    })
end

function AlertDeath()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)

    local dispatchCode = "10-47"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Injured Person",
        blipSprite = 310,
        blipColor = 0,
        job = {"police", "ems"}
    })
end

function AlertPdof()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-32"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Armed Person",
        blipSprite = 110,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function AlertSuspicious()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-37"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Suspect",
        blipSprite = 362,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function AlertFight()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-10"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Disturbance",
        blipSprite = 311,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function AlertDeadlyWeapon()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-11"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Disturbance",
        blipSprite = 437,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function AlertGunShot()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())
    local vehicleData = GetVehicleDescription() or {}

    local dispatchCode = (not isInVehicle and "10-71A" or "10-71B")

    local _dispatchData = {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Shots Fired",
        blipSprite = 432,
        blipColor = 0,
        job = {"police"}
    }

    if dispatchCode == "10-71B" then
        _dispatchData.model = vehicleData.model
        _dispatchData.plate = vehicleData.plate
        _dispatchData.firstColor = vehicleData.firstColor
        _dispatchData.secondColor = vehicleData.secondColor
        _dispatchData.heading = vehicleData.heading
    end

    TriggerServerEvent("dispatch:svNotify", _dispatchData)

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function AlertCheckLockpick(object)
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)

    local dispatchCode = "10-60"

    local _dispatchData = {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Break-In",
        blipSprite = 255,
        blipColor = 1,
        job = {"police"}
    }

    if DoesEntityExist(object) then
        local plate = GetVehicleNumberPlateText(object)
        local model = GetDisplayNameFromVehicleModel(GetEntityModel(object))
        local firstColor, secondColor = GetVehicleColours(object)

        _dispatchData.dispatchMessage = "Carjacking"
        _dispatchData.model = model
        _dispatchData.plate = plate
        _dispatchData.firstColor = firstColor
        _dispatchData.secondColor = secondColor
    end

    TriggerServerEvent("dispatch:svNotify", _dispatchData)
end

function AlertCheckRobbery2()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-31A"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Breaking and Entering",
        blipSprite = 458,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

function AlertHousing(isAlarm)
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-31A"
    local dispatchMessage = "Breaking and Entering"

    if isAlarm then
        dispatchCode = "10-57"
        dispatchMessage = "home alarm"
    end

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = dispatchMessage,
        blipSprite = 458,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Evading Vehicle " .. dispatchCode,
            job = {"police"}
        })
    end
end

function AlertStore()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-31C"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Store Robbery",
        blipSprite = 458,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end


function AlertBank()
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId(), true)
    local isInVehicle = IsPedInAnyVehicle(PlayerPedId())

    local dispatchCode = "10-31C"

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = dispatchCode,
        firstStreet = locationInfo,
        gender = gender,
        priority = 3,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = "Bank Robbery",
        blipSprite = 458,
        blipColor = 0,
        job = {"police"}
    })

    Wait(math.random(5000,15000))

    if math.random(10) > 5 and IsPedInAnyVehicle(PlayerPedId()) and not isInVehicle then
        local vehicleData = GetVehicleDescription() or {}
        local currentPos = GetEntityCoords(PlayerPedId(), true)
        local locationInfo = GetStreetAndZone()

        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "CarEvading",
            relatedCode = dispatchCode,
            firstStreet = locationInfo,
            gender = gender,
            model = vehicleData.model,
            plate = vehicleData.plate,
            priority = 3,
            firstColor = vehicleData.firstColor,
            secondColor = vehicleData.secondColor,
            heading = vehicleData.heading,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "Vehicle Evading " .. dispatchCode,
            job = {"police"}
        })
    end
end

--[[

    Events

]]

RegisterNetEvent("np-jobs:jobChanged")
AddEventHandler("np-jobs:jobChanged", function(job)
    if exports["np-jobs"]:getJob(job, "is_police") then
        currentJob = "police"
    elseif exports["np-jobs"]:getJob(job, "is_medic") then
        currentJob = "ems"
    elseif exports["np-jobs"]:getJob(job, "is_doj") then
        currentJob = "doj"
    elseif currentJob ~= "unemployed" then
        currentJob =  "unemployed"
    end
end)

RegisterNetEvent("np-weathersync:currentTime", function(pHour, pMinute)
    if (pHour > 19 or pHour < 7) and daytime then
		daytime = false
	elseif (pHour <= 19 and pHour >= 7) and not daytime then
		daytime = true
	end
end)

RegisterNetEvent("np-dispatch:manageNotifs")
AddEventHandler("np-dispatch:manageNotifs", function(sentSetting)
    local wantedSetting = tostring(sentSetting)

    if wantedSetting == "on" then
        disableNotis = false
        disableNotifSounds = false
        TriggerClientEvent("DoLongHudText", "Dispatch enabled.")
    elseif wantedSetting == "off" then
        disableNotis = true
        disableNotifSounds = true
        TriggerClientEvent("DoLongHudText", "Dispatch disabled.")
    elseif wantedSetting == "mute" then
        disableNotis = false
        disableNotifSounds = true
        TriggerClientEvent("DoLongHudText", "Dispatch muted.")
    else
        TriggerClientEvent("DoLongHudText", 'Please choose to have dispatch as "on", "off" or "mute".', 2)
    end
end)

RegisterNetEvent("civilian:alertPolice")
AddEventHandler("civilian:alertPolice",function(basedistance, alertType, objPassed, isGunshot, isSpeeder)
    local coords = GetEntityCoords(PlayerPedId())
    local object = objPassed

    if daytime then
        basedistance = basedistance * 3.45
    else
        basedistance = basedistance * 8.2
    end

    if alertType == "personRobbed" then
        AlertpersonRobbed(object)
    end

    if isGunshot == nil then isGunshot = false end
    if isSpeeder == nil then isSpeeder = false end

    local nearNPC = getRandomNpc(basedistance,isGunshot,isSpeeder)
    local dst = 0

    if nearNPC then
        dst = #(coords - GetEntityCoords(nearNPC))
    end

    if alertType == "lockpick" and math.random(100) > 88 and currentJob ~= "police" then
        nearNPC = true
    end

    if nearNPC == nil and alertType ~= "robberyhouseMansion" and currentJob ~= "police" then
        return
    else
        if alertType == "robberyhouseMansion" and currentJob ~= "police" then
            alertType = "robberyhouse"
        end

        if not isSpeeder and alertType ~= "robberyhouse" then
            RequestAnimDict("amb@code_human_wander_texting@male@base")
            while not HasAnimDictLoaded("amb@code_human_wander_texting@male@base") do
                Citizen.Wait(0)
            end

            Citizen.Wait(1000)

            if GetEntityHealth(nearNPC) < GetEntityMaxHealth(nearNPC) then return end
            if not DoesEntityExist(nearNPC) then return end
            if IsPedFatallyInjured(nearNPC) then return end
            if IsPedInMeleeCombat(nearNPC) then return end

            ClearPedTasks(nearNPC)
            TaskPlayAnim(nearNPC, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
        end
    end

    local plyCoords = GetEntityCoords(PlayerPedId())
    local underground = false
    if plyCoords["z"] < -25 then
        underground = true
    end

    Citizen.Wait(math.random(5000))

    if alertType == "drugsale" and not underground then
        if dst > 12.0 and dst < 18.0 then
            DrugSale()
        end
    end

    if alertType == "druguse" and not underground then
        if dst > 12.0 and dst < 18.0 then
            DrugUse()
        end
    end

    if alertType == "carcrash" then
        CarCrash()
    end

    if alertType == "death" and not underground then
        AlertDeath()

        local roadtest2 = IsPointOnRoad(GetEntityCoords(PlayerPedId()), PlayerPedId())
        if roadtest2 then return end

        -- BringNpcs()
    end

    if alertType == "PDOF" and not underground and currentJob ~= "police" then
        if dst > 12.0 and dst < 18.0 then
            AlertPdof()
        end
    end

    if alertType == "Suspicious" then
        AlertSuspicious()
    end

    if alertType == "fight" and not underground then
        AlertFight()
    end

    if alertType == "deadlyweapon" and not underground and currentJob ~= "police" then
        AlertDeadlyWeapon()
    end

    if alertType == "gunshot" or alertType == "gunshotvehicle" then
        AlertGunShot()
    end

    if alertType == "lockpick" then
        if dst > 12.0 and dst < 18.0 then
            AlertCheckLockpick(object)
        end
    end

    if alertType == "housing" then
        AlertHousing()
    end

    if alertType == "robberyhouse" then
        AlertCheckRobbery2()
    end
end)

RegisterNetEvent("dispatch:clNotify")
AddEventHandler("dispatch:clNotify", function(sNotificationData, sNotificationId, sender)
    if sNotificationData == nil then return end

    if sender == GetPlayerServerId(PlayerId()) and sNotificationData["dispatchCode"] == "911" then
        SendNUIMessage({
            update = "newCall",
            callID = sNotificationId + math.random(1000, 9999),
            data = {
                dispatchCode = "911",
                priority = 1,
                dispatchMessage = "Sent 911 call",
                information = "Thank you for your emergency report. It has been sent and is being evaluated."
            },
            timer = 5000,
            isPolice = true
        })
    elseif sender == GetPlayerServerId(PlayerId()) and sNotificationData["dispatchCode"] == "311" then
        SendNUIMessage({
            update = "newCall",
            callID = sNotificationId + math.random(1000, 9999),
            data = {
                dispatchCode = "311",
                priority = 2,
                dispatchMessage = "Sent 311 call",
                information = "Thank you for your non emergency report. It has been sent and is being evaluated."
            },
            timer = 5000,
            isPolice = true
        })
    end

    local shouldAlert = false
    for i, v in ipairs(sNotificationData["job"]) do
        if v == currentJob then
            shouldAlert = true
            break
        end
    end

    if shouldAlert then
        if not disableNotis then
            if sNotificationData.origin ~= nil then
                if sNotificationData.originStatic == nil or not sNotificationData.originStatic then
                    sNotificationData.origin = randomizeBlipLocation(sNotificationData.origin)
                else
                    sNotificationData.origin = sNotificationData.origin
                end
            end

            PlaySound(-1, "Lose_1st", "GTAO_FM_Events_Soundset", 0, 0, 1)

            SendNUIMessage({
                update = "newCall",
                callID = sNotificationId,
                data = sNotificationData,
                timer = 5000,
                isPolice = (currentJob == "police")
            })

            addDispatchBlip({
                currentJob = currentJob,
                isImportant = sNotificationData.isImportant,
                blipTenCode = sNotificationData.dispatchCode == nil and "" or sNotificationData.dispatchCode,
                blipDescription = sNotificationData.dispatchMessage,
                blipLocation = sNotificationData.origin,
                blipSprite = sNotificationData.blipSprite,
                blipColor = sNotificationData.blipColor,
                blipArea = sNotificationData.blipArea,
                blipId = sNotificationData.callId,
                isTracker = sNotificationData.isTracker
            })
        end
    end
end)

RegisterNetEvent("np-dispatch:911")
AddEventHandler("np-dispatch:911", function(msg)
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId())

    TriggerEvent("animation:PlayAnimation", "phone")
    local finished = exports["np-taskbar"]:taskBar(math.random(2500, 4000), "calling 911")
    TriggerEvent("animation:PlayAnimation", "cancel")

    if finished == 100 then
        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "911",
            firstStreet = locationInfo,
            gender = gender,
            priority = 1,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "911 Call",
            name = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name"),
            number =  exports["np-base"]:getChar("phone"),
            job = {"police"},
            information = msg
        })
    end
end)

RegisterNetEvent("np-dispatch:311")
AddEventHandler("np-dispatch:311", function(source, args, rawCommand)
    local locationInfo = GetStreetAndZone()
    local gender = IsPedMale(PlayerPedId())
    local currentPos = GetEntityCoords(PlayerPedId())

    TriggerEvent("animation:PlayAnimation", "phone")
    local finished = exports["np-taskbar"]:taskBar(math.random(2500, 4000), "calling 311")
    TriggerEvent("animation:PlayAnimation", "cancel")

    if finished == 100 then
        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "311",
            firstStreet = locationInfo,
            gender = gender,
            priority = 1,
            origin = {
                x = currentPos.x,
                y = currentPos.y,
                z = currentPos.z
            },
            dispatchMessage = "311 Call",
            name = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name"),
            number =  exports["np-base"]:getChar("phone"),
            job = {"ems"},
            information = msg
        })
    end
end)

RegisterNetEvent("dispatch:getCallResponse")
AddEventHandler("dispatch:getCallResponse", function(message)
    SendNUIMessage({
        update = "newCall",
        callID = math.random(1000, 9999),
        data = {
            dispatchCode = "RSP",
            priority = 1,
            dispatchMessage = "Call Response",
            information = message
        },
        timer = 10000,
        isPolice = true
    })
end)

RegisterNetEvent("TriggerAIRunning")
AddEventHandler("TriggerAIRunning",function(p)
    local usingped = p
    local pedOwner = NetworkGetEntityOwner(usingped)

    if pedOwner == PlayerId() then
        DecorSetBool(usingped, "ScriptedPed", true)
    else
        TriggerServerEvent("np:peds:decor", GetPlayerServerId(pedOwner), PedToNet(usingped))
    end

    local nm1 = math.random(6,9) / 100
    local nm2 = math.random(6,9) / 100
    nm1 = nm1 + 0.3
    nm2 = nm2 + 0.3
    if math.random(10) > 5 then nm1 = 0.0 - nm1 end
    if math.random(10) > 5 then nm2 = 0.0 - nm2 end

    local moveto = GetOffsetFromEntityInWorldCoords(PlayerPedId(), nm1, nm2, 0.0)
    TaskGoStraightToCoord(usingped, moveto, 2.5, -1, 0.0, 0.0)
    SetPedKeepTask(usingped, true)

    local dist = #(moveto - GetEntityCoords(usingped))
    while dist > 3.5 and exports["np-base"]:getVar("dead") do
        TaskGoStraightToCoord(usingped, moveto, 2.5, -1, 0.0, 0.0)
        dist = #(moveto - GetEntityCoords(usingped))
        Citizen.Wait(100)
    end

    ClearPedTasksImmediately(ped)

    TaskLookAtEntity(usingped, PlayerPedId(), 5500.0, 2048, 3)

    TaskTurnPedToFaceEntity(usingped, PlayerPedId(), 5500)

    Citizen.Wait(3000)

    if math.random(3) == 2 then
        TaskStartScenarioInPlace(usingped, tasksIdle[2], 0, 1)
    elseif math.random(2) == 1 then
        TaskStartScenarioInPlace(usingped, tasksIdle[1], 0, 1)
    else
        TaskStartScenarioInPlace(usingped, tasksIdle[2], 0, 1)
        TaskStartScenarioInPlace(usingped, tasksIdle[1], 0, 1)
    end

    SetPedKeepTask(usingped, true)

    while exports["np-base"]:getVar("dead") do
        Citizen.Wait(1)
        if not IsPedFacingPed(usingped, PlayerPedId(), 15.0) then
            ClearPedTasksImmediately(ped)
            TaskLookAtEntity(usingped, PlayerPedId(), 5500.0, 2048, 3)
            TaskTurnPedToFaceEntity(usingped, PlayerPedId(), 5500)
            Citizen.Wait(3000)
        end
    end

    SetEntityAsNoLongerNeeded(usingped)
    ClearPedTasks(usingped)
    DecorSetBool(usingped, "ScriptedPed", false)
end)

AddEventHandler("gameEventTriggered", function (name, args)
    local isSelfAttacker = (args[2] == PlayerPedId() and true or false)
    local isMeleeAttack = (args[7] == `WEAPON_UNARMED` and true or false)

    -- Fist only attack (Fight in Progress)
    if name == "CEventNetworkEntityDamage" and isMeleeAttack and isSelfAttacker and GetCloudTimeAsInt() > nextMeleeAction then
        local victimIsPlayer = IsPedAPlayer(args[1])
        local alertPolice = victimIsPlayer or math.random(1, 100) < 30

        TriggerEvent("civilian:alertPolice",35.0,"fight",0)
        TriggerEvent("Evidence:StateSet",1,300)
        nextMeleeAction = GetCloudTimeAsInt() + 20000
    end

    -- Melee weapon attack (Deadly Weapon)
    if name == "CEventNetworkEntityDamage" and IsPedArmed(PlayerPedId(), 1) and isSelfAttacker and GetCloudTimeAsInt() > nextStabbingAction then
        TriggerEvent("civilian:alertPolice", 35.0, "deadlyweapon", 0)
        nextStabbingAction = GetCloudTimeAsInt() + 30000
    end
end)

RegisterNetEvent("police:tenThirteenA")
AddEventHandler("police:tenThirteenA", function()
    if tenThirteenA then return end

    local pos = GetEntityCoords(PlayerPedId(),  true)

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = "10-13A",
        firstStreet = GetStreetAndZone(),
        name = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name"),
        number = exports["np-base"]:getChar("phone"),
        priority = 1,
        isDead = true,
        dispatchMessage = "Officer Down",
        origin = {
            x = pos.x,
            y = pos.y,
            z = pos.z
        },
        job = {"police", "ems"}
    })

    Citizen.CreateThread(function()
        tenThirteenA = true
        Citizen.Wait(30000)
        tenThirteenA = false
    end)
end)

RegisterNetEvent("police:tenThirteenB")
AddEventHandler("police:tenThirteenB", function()
    if tenThirteenB then return end

    local pos = GetEntityCoords(PlayerPedId(),  true)

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = "10-13B",
        firstStreet = GetStreetAndZone(),
        name = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name"),
        number = exports["np-base"]:getChar("phone"),
        priority = 1,
        isDead = true,
        dispatchMessage = "Officer Down",
        origin = {
            x = pos.x,
            y = pos.y,
            z = pos.z
        },
        job = {"police", "ems"}
    })

    Citizen.CreateThread(function()
        tenThirteenB = true
        Citizen.Wait(30000)
        tenThirteenB = false
    end)
end)

RegisterNetEvent("police:tenForteenA")
AddEventHandler("police:tenForteenA", function()
    if tenThirteenA then return end

    local pos = GetEntityCoords(PlayerPedId(),  true)

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = "10-14A",
        firstStreet = GetStreetAndZone(),
        name = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name"),
        number = exports["np-base"]:getChar("phone"),
        priority = 1,
        isDead = true,
        dispatchMessage = "Medic Down",
        origin = {
            x = pos.x,
            y = pos.y,
            z = pos.z
        },
        job = {"police", "ems"}
    })

    Citizen.CreateThread(function()
        tenThirteenA = true
        Citizen.Wait(30000)
        tenThirteenA = false
    end)
end)

RegisterNetEvent("police:tenForteenB")
AddEventHandler("police:tenForteenB", function()
    if tenThirteenB then return end

    local pos = GetEntityCoords(PlayerPedId(),  true)

    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = "10-14B",
        firstStreet = GetStreetAndZone(),
        name = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name"),
        number = exports["np-base"]:getChar("phone"),
        priority = 1,
        isDead = true,
        dispatchMessage = "Medic Down",
        origin = {
            x = pos.x,
            y = pos.y,
            z = pos.z
        },
        job = {"police", "ems"}
    })

    Citizen.CreateThread(function()
        tenThirteenB = true
        Citizen.Wait(30000)
        tenThirteenB = false
    end)
end)

RegisterNetEvent("alert:houseRobbery")
AddEventHandler("alert:houseRobbery",function(isAlarm)
    AlertHousing(isAlarm)
end)

RegisterNetEvent("alert:storeRobbery")
AddEventHandler("alert:storeRobbery",function(isAlarm)
    AlertStore()
end)

RegisterNetEvent("alert:bankRobbery")
AddEventHandler("alert:bankRobbery",function(isAlarm)
    AlertBank()
end)

--[[

    Threads

]]

Citizen.CreateThread( function()
    local curw = GetSelectedPedWeapon(PlayerPedId())
    local armed = false
    local timercheck = 0

    while true do
        Citizen.Wait(50)

        local ped = PlayerPedId()

        if not armed then
            if IsPedArmed(ped, 7) and not IsPedArmed(ped, 1) then
                curw = GetSelectedPedWeapon(ped)
                armed = true
                timercheck = 15
            end
        end

        if armed then
            if `WEAPON_PetrolCan` == curw then
                TriggerEvent("Evidence:StateSet",9,1200)
            end

            if currentJob ~= "police" and IsPedShooting(ped) and not excludedWeapons[curw] then
                if IsPedCurrentWeaponSilenced(ped) then
                    AlertGunShot()
                elseif isInVehicle then
                    TriggerEvent("civilian:alertPolice", 550.0, "gunshot", 0, true)
                else
                    TriggerEvent("civilian:alertPolice", 550.0, "gunshot", 0, true)
                end

                Citizen.Wait(60000)
            end

            if timercheck == 0 then
                armed = false
            else
                timercheck = timercheck - 1
            end
        else
            Citizen.Wait(5000)
        end
    end
end)

Citizen.CreateThread( function()
    local origin = false

    while true do
        Citizen.Wait(1)

        local plyPos = GetEntityCoords(PlayerPedId(),  true)
        local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        local isInVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
        local curw = GetSelectedPedWeapon(PlayerPedId())

        local targetCoords = GetEntityCoords(PlayerPedId(), 0)

        if math.random(100) > 77 and currentJob ~= "police" and not isInVehicle and IsPedArmed(PlayerPedId(), 7) and not IsPedArmed(PlayerPedId(), 1) and not excludedWeapons[curw] and not origin then
            origin = true

            TriggerEvent("civilian:alertPolice",35.0,"PDOF",0)

            Citizen.Wait(60000)

            origin = false
        else
            if currentJob == "police" then
                Citizen.Wait(60000)
            else
                Citizen.Wait(5000)
            end
        end

    end
end)