--[[

    Variables

]]

local isOpen = false

local currentJob = "unemployed"

local tablet = 0
local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local tabletAnim = "base"
local tabletProp = `prop_cs_tablet`
local tabletBone = 60309
local tabletOffset = vector3(0.03, 0.002, -0.0)
local tabletRot = vector3(10.0, 160.0, 0.0)

local classlist = {
    [0] = "Compact",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupe",
    [4] = "Muscle",
    [5] = "Sport Classic",
    [6] = "Sport",
    [7] = "Super",
    [8] = "Motorbike",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Van",
    [13] = "Bike",
    [14] = "Boat",
    [15] = "Helicopter",
    [16] = "Plane",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Train"
}

local ColorNames = {
    [0] = "Metallic Black",
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
    [17] = "Util Dark silver",
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
    [144] = "hunter green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
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

local ColorInformation = {
    [0] = "black",
    [1] = "black",
    [2] = "black",
    [3] = "darksilver",
    [4] = "silver",
    [5] = "bluesilver",
    [6] = "silver",
    [7] = "darksilver",
    [8] = "silver",
    [9] = "bluesilver",
    [10] = "darksilver",
    [11] = "darksilver",
    [12] = "matteblack",
    [13] = "gray",
    [14] = "lightgray",
    [15] = "black",
    [16] = "black",
    [17] = "darksilver",
    [18] = "silver",
    [19] = "utilgunmetal",
    [20] = "silver",
    [21] = "black",
    [22] = "black",
    [23] = "darksilver",
    [24] = "silver",
    [25] = "bluesilver",
    [26] = "darksilver",
    [27] = "red",
    [28] = "torinored",
    [29] = "formulared",
    [30] = "blazered",
    [31] = "gracefulred",
    [32] = "garnetred",
    [33] = "desertred",
    [34] = "cabernetred",
    [35] = "candyred",
    [36] = "orange",
    [37] = "gold",
    [38] = "orange",
    [39] = "red",
    [40] = "mattedarkred",
    [41] = "orange",
    [42] = "matteyellow",
    [43] = "red",
    [44] = "brightred",
    [45] = "garnetred",
    [46] = "red",
    [47] = "red",
    [48] = "darkred",
    [49] = "darkgreen",
    [50] = "racingreen",
    [51] = "seagreen",
    [52] = "olivegreen",
    [53] = "green",
    [54] = "gasolinebluegreen",
    [55] = "mattelimegreen",
    [56] = "darkgreen",
    [57] = "green",
    [58] = "darkgreen",
    [59] = "green",
    [60] = "seawash",
    [61] = "midnightblue",
    [62] = "darkblue",
    [63] = "saxonyblue",
    [64] = "blue",
    [65] = "blue",
    [66] = "blue",
    [67] = "diamondblue",
    [68] = "blue",
    [69] = "blue",
    [70] = "brightblue",
    [71] = "purpleblue",
    [72] = "blue",
    [73] = "ultrablue",
    [74] = "brightblue",
    [75] = "darkblue",
    [76] = "midnightblue",
    [77] = "blue",
    [78] = "blue",
    [79] = "lightningblue",
    [80] = "blue",
    [81] = "brightblue",
    [82] = "mattedarkblue",
    [83] = "matteblue",
    [84] = "matteblue",
    [85] = "darkblue",
    [86] = "blue",
    [87] = "lightningblue",
    [88] = "yellow",
    [89] = "yellow",
    [90] = "bronze",
    [91] = "yellow",
    [92] = "lime",
    [93] = "champagne",
    [94] = "beige",
    [95] = "darkivory",
    [96] = "brown",
    [97] = "brown",
    [98] = "lightbrown",
    [99] = "beige",
    [100] = "brown",
    [101] = "brown",
    [102] = "beechwood",
    [103] = "beechwood",
    [104] = "chocoorange",
    [105] = "yellow",
    [106] = "yellow",
    [107] = "cream",
    [108] = "brown",
    [109] = "brown",
    [110] = "brown",
    [111] = "white",
    [112] = "white",
    [113] = "beige",
    [114] = "brown",
    [115] = "brown",
    [116] = "beige",
    [117] = "steel",
    [118] = "blacksteel",
    [119] = "aluminium",
    [120] = "chrome",
    [121] = "wornwhite",
    [122] = "offwhite",
    [123] = "orange",
    [124] = "lightorange",
    [125] = "green",
    [126] = "yellow",
    [127] = "blue",
    [128] = "green",
    [129] = "brown",
    [130] = "orange",
    [131] = "white",
    [132] = "white",
    [133] = "darkgreen",
    [134] = "white",
    [135] = "pink",
    [136] = "pink",
    [137] = "pink",
    [138] = "orange",
    [139] = "green",
    [140] = "blue",
    [141] = "blackblue",
    [142] = "blackpurple",
    [143] = "blackred",
    [144] = "darkgreen",
    [145] = "purple",
    [146] = "darkblue",
    [147] = "black",
    [148] = "purple",
    [149] = "darkpurple",
    [150] = "red",
    [151] = "darkgreen",
    [152] = "olivedrab",
    [153] = "brown",
    [154] = "tan",
    [155] = "green",
    [156] = "silver",
    [157] = "blue",
    [158] = "black",
}

--[[

    Main

]]

function EnableGUI(enable)
    local job = exports["np-base"]:getChar("job")
    if job == "judge" or job == "defender" or job == "district attorney" then
        job = "doj"
    end

    local jobRank = RPC.execute("np-groups:rankInfos", job, exports["np-groups"]:GroupRank(job))

    if enable then
        SendNUIMessage({type = "bulletin", data = RPC.execute("np-mdt:dashboardBulletin")})
        SendNUIMessage({type = "dispatchmessages", data = RPC.execute("np-mdt:dashboardMessages")})
        local police, sheriff, state_police, park_ranger, ems, doj = RPC.execute("np-mdt:getActiveUnits")
        SendNUIMessage({type = "getActiveUnits", police = police, sheriff = sheriff, state_police = state_police, park_ranger = park_ranger, ems = ems, doj = doj})
        SendNUIMessage({type = "UpdatePoliceRoster", data = "https://docs.google.com/spreadsheets/d/e/2PACX-1vTrVQF_Wx6FezBcdsYPfY85KMshLzNwyWkLwTNTsFlWI-2MM2xDCLX3IykF76tOtYlwi8LQkNcwiy-x/pubhtml"})
        SendNUIMessage({type = "UpdateEMSRoster", data = ""})
        SendNUIMessage({type = "warrants", data = RPC.execute("np-mdt:getWarrants")})
        SendNUIMessage({type = "calls", data = RPC.execute("np-mdt:getCalls")})
    end

    SetNuiFocus(enable, enable)
    SendNUIMessage({
        type = "show",
        enable = enable,
        job = job,
        isAdmin = jobRank.hire
    })

    isOpen = enable
    TriggerEvent("np-mdt:animation")
end

function RefreshGUI()
    local job = exports["np-base"]:getChar("job")
    if job == "judge" or job == "defender" or job == "district attorney" then
        job = "doj"
    end

    local jobRank = RPC.execute("np-groups:rankInfos", job, exports["np-groups"]:GroupRank(job))

    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "show",
        enable = false,
        job = job,
        isAdmin = jobRank.hire
    })

    isOpen = false
end

AddEventHandler("np-mdt:publicRecords", function()
    isOpen = true

    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "PublicRecords",
        settings = {
            ["AllowImageChange"] = false
        }
    })

    TriggerEvent("np-mdt:animation")

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    local zone = tostring(GetNameOfZone(x, y, z))
    local area = GetLabelText(zone)
    local playerStreetsLocation = area

    if not zone then zone = "UNKNOWN" end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. ", " .. intersectStreetName .. ", " .. area
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. ", " .. area
    else
        playerStreetsLocation = area
    end

    local fullName = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name")

    SendNUIMessage({
        type = "data",
        name = "Welcome, " .. fullName,
        location = playerStreetsLocation,
        fullname = fullName
    })
end)

RegisterNetEvent("np-mdt:open")
AddEventHandler("np-mdt:open", function()
    open = true
    EnableGUI(open)

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))

    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)
    local zone = tostring(GetNameOfZone(x, y, z))
    local area = GetLabelText(zone)
    local playerStreetsLocation = area

    if not zone then zone = "UNKNOWN" end

    if intersectStreetName ~= nil and intersectStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. ", " .. intersectStreetName .. ", " .. area
    elseif currentStreetName ~= nil and currentStreetName ~= "" then
        playerStreetsLocation = currentStreetName .. ", " .. area
    else
        playerStreetsLocation = area
    end

    local fullName = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name")

    SendNUIMessage({
        type = "data",
        name = "Welcome, " .. fullName,
        location = playerStreetsLocation,
        fullname = fullName
    })
end)

AddEventHandler("np-mdt:animation", function()
    if not isOpen then return end

    -- Animation
    RequestAnimDict(tabletDict)
    while not HasAnimDictLoaded(tabletDict) do Citizen.Wait(100) end

    -- Model
    RequestModel(tabletProp)
    while not HasModelLoaded(tabletProp) do Citizen.Wait(100) end

    local plyPed = PlayerPedId()
    local tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
    local tabletBoneIndex = GetPedBoneIndex(plyPed, tabletBone)

    TriggerEvent("actionbar:setEmptyHanded")
    AttachEntityToEntity(tabletObj, plyPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
    SetModelAsNoLongerNeeded(tabletProp)

    CreateThread(function()
        while isOpen do
            Wait(0)
            if not IsEntityPlayingAnim(plyPed, tabletDict, tabletAnim, 3) then
                TaskPlayAnim(plyPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
        ClearPedSecondaryTask(plyPed)

        Citizen.Wait(250)

        DetachEntity(tabletObj, true, false)
        DeleteEntity(tabletObj)

        return
    end)
end)

RegisterNUICallback("escape", function(data, cb)
    open = false
    EnableGUI(open)
    cb(true)
end)

RegisterNetEvent("np-mdt:exitMDT")
AddEventHandler("np-mdt:exitMDT", function()
    open = false
    EnableGUI(open)
end)

--[[

    Bulletins

]]

RegisterNetEvent("np-mdt:dashboardbulletin")
AddEventHandler("np-mdt:dashboardbulletin", function(sentData)
    SendNUIMessage({
        type = "bulletin",
        data = sentData
    })
end)

RegisterNUICallback("newBulletin", function(data, cb)
    TriggerServerEvent("np-mdt:newBulletin", data.title, data.info, data.time)
    cb(true)
end)

RegisterNetEvent("np-mdt:newBulletin")
AddEventHandler("np-mdt:newBulletin", function(ignoreId, sentData, job)
    if ignoreId == GetPlayerServerId(PlayerId()) then return end

    if job == currentJob then
        SendNUIMessage({
            type = "newBulletin",
            data = sentData
        })
    end
end)

RegisterNUICallback("deleteBulletin", function(data, cb)
    TriggerServerEvent("np-mdt:deleteBulletin", data.id)
    cb(true)
end)

RegisterNetEvent("np-mdt:deleteBulletin")
AddEventHandler("np-mdt:deleteBulletin", function(ignoreId, sentData, job)
    if ignoreId == GetPlayerServerId(PlayerId()) then return end

    if job == currentJob then
        SendNUIMessage({
            type = "deleteBulletin",
            data = sentData
        })
    end
end)

--[[

    Messages

]]

RegisterNetEvent("np-mdt:dashboardMessages")
AddEventHandler("np-mdt:dashboardMessages", function(sentData)
    SendNUIMessage({
        type = "dispatchmessages",
        data = sentData
    })
end)

RegisterNUICallback("refreshDispatchMsgs", function(data, cb)
    TriggerServerEvent("np-mdt:refreshDispatchMsgs")
    cb(true)
end)

RegisterNUICallback("dispatchMessage", function(data, cb)
    TriggerServerEvent("np-mdt:sendMessage", data.message, data.time)
    cb(true)
end)

RegisterNetEvent("np-mdt:dashboardMessage")
AddEventHandler("np-mdt:dashboardMessage", function(sentData, job)
    if currentJob == job then
        SendNUIMessage({
            type = "dispatchmessage",
            data = sentData
        })
    end
end)

--[[

    Units

]]

RegisterNetEvent("np-mdt:getActiveUnits")
AddEventHandler("np-mdt:getActiveUnits", function(police, bcso, sahp, sasp, doc, sapr, pa, ems)
    SendNUIMessage({
        type = "getActiveUnits",
        police = police,
        bcso = bcso,
        sast = sahp,
        sasp = sasp,
        doc = doc,
        sapr = sapr,
        pa = pa,
        ems = ems
    })
end)

RegisterNUICallback("setWaypointU", function(data, cb)
    TriggerServerEvent("np-mdt:setWaypoint:unit", data.cid)
    cb(true)
end)

RegisterNetEvent("np-mdt:setWaypoint:unit")
AddEventHandler("np-mdt:setWaypoint:unit", function(sentData)
    TriggerEvent("DoLongHudText", "GPS marked!")
    SetNewWaypoint(sentData.x, sentData.y)
end)

RegisterNUICallback("setRadio", function(data, cb)
    TriggerServerEvent("np-mdt:setRadioTo", data.cid, data.newradio)
    cb(true)
end)

RegisterNetEvent("np-mdt:setRadio")
AddEventHandler("np-mdt:setRadio", function(radio, name)
    if radio then
        if (not exports["np-inventory"]:hasEnoughOfItem("radio",1,false) and not exports["np-inventory"]:hasEnoughOfItem("pdradio",1,false)) then
            TriggerEvent("DoLongHudText", "Missing radio, " .. name .. " tried to set your radio frequency.", 2)
            return
        end

        exports["np-voice"]:SetRadioFrequency(radio)
        TriggerEvent("DoLongHudText", "Your radio frequency has been set to " .. radio .. " MHz, by " .. name)
    end
end)

RegisterNUICallback("setCallsign", function(data, cb)
    TriggerServerEvent("np-mdt:setCallsign", data.cid, data.newcallsign)
    cb(true)
end)

RegisterNUICallback("toggleDuty", function(data, cb)
    -- TriggerServerEvent("np-mdt:toggleDuty", data.cid, data.status)
    cb(true)
end)

--[[

    Calls

]]

RegisterNetEvent("dispatch:clNotify")
AddEventHandler("dispatch:clNotify", function(sNotificationData, sNotificationId)
    sNotificationData.callId = sNotificationId
    SendNUIMessage({
        type = "call",
        data = sNotificationData
    })
end)

RegisterNUICallback("removeCall", function(data, cb)
    TriggerServerEvent("np-mdt:removeCall", data.callid)

    cb(true)
end)

RegisterNetEvent("np-mdt:removeCall", function(pCallId)
    SendNUIMessage({
        type = "removeCall",
        callid = pCallId
    })
end)

RegisterNUICallback("setWaypoint", function(data, cb)
    local call = RPC.execute("np-dispatch:getCall", data.callid)

    if call then
        TriggerEvent("DoLongHudText", "GPS Marked!")
        SetNewWaypoint(call.origin.x, call.origin.y)
    end

    cb(true)
end)

RegisterNUICallback("callAttach", function(data, cb)
    TriggerServerEvent("np-mdt:callAttach", data.callid)

    cb(true)
end)

RegisterNetEvent("np-mdt:callAttach")
AddEventHandler("np-mdt:callAttach", function(callid, sentData)
    SendNUIMessage({
        type = "callAttach",
        callid = callid,
        data = tonumber(sentData)
    })
end)

RegisterNUICallback("callDetach", function(data, cb)
    TriggerServerEvent("np-mdt:callDetach", data.callid)

    cb(true)
end)

RegisterNetEvent("np-mdt:callDetach")
AddEventHandler("np-mdt:callDetach", function(callid, sentData)
    SendNUIMessage({
        type = "callDetach",
        callid = callid,
        data = tonumber(sentData)
    })
end)

RegisterNUICallback("attachedUnits", function(data, cb)
    local units, callid = RPC.execute("np-mdt:attachedUnits", data.callid)

    SendNUIMessage({
        type = "attachedUnits",
        data = units,
        callid = data.callid
    })

    cb(true)
end)

RegisterNUICallback("callDragAttach", function(data, cb)
    TriggerServerEvent("np-mdt:callDragAttach", data.callid, data.cid)

    cb(true)
end)

RegisterNUICallback("callDispatchDetach", function(data, cb)
    TriggerServerEvent("np-mdt:callDispatchDetach", tonumber(data.callid), tonumber(data.cid))

    cb(true)
end)

RegisterNUICallback("setDispatchWaypoint", function(data, cb)
    TriggerServerEvent("np-mdt:setDispatchWaypoint", tonumber(data.callid), tonumber(data.cid))

    cb(true)
end)

RegisterNUICallback("dispatchNotif", function(data, cb)
    cb(true)
end)

RegisterNUICallback("getCallResponses", function(data, cb)
    TriggerServerEvent("np-mdt:getCallResponses", data.callid)

    cb(true)
end)

RegisterNetEvent("np-mdt:getCallResponses")
AddEventHandler("np-mdt:getCallResponses", function(sentData, sentCallId)
    SendNUIMessage({
        type = "getCallResponses",
        data = sentData,
        callid = sentCallId
    })
end)

RegisterNUICallback("sendCallResponse", function(data, cb)
    TriggerServerEvent("np-mdt:sendCallResponse", data.message, data.time, data.callid)

    cb(true)
end)

RegisterNetEvent("np-mdt:sendCallResponse")
AddEventHandler("np-mdt:sendCallResponse", function(message, time, callid, name)
    SendNUIMessage({
        type = "sendCallResponse",
        message = message,
        time = time,
        callid = callid,
        name = name
    })
end)

--[[

    Warrants

]]

RegisterNetEvent("np-mdt:dashboardWarrants")
AddEventHandler("np-mdt:dashboardWarrants", function(sentData)
    SendNUIMessage({
        type = "warrants",
        data = sentData
    })
end)

--[[

    Profiles

]]

RegisterNUICallback("getAllProfiles", function(data, cb)
    local is_police = exports["np-jobs"]:getJob(false, "is_police")
    local is_doj = exports["np-jobs"]:getJob(false, "is_doj")

    SendNUIMessage({
        type = "profiles",
        data = RPC.execute("np-mdt:searchProfile", ""),
        isLimited = (is_police == false and is_doj == false)
    })

    cb(true)
end)

RegisterNUICallback("searchProfiles", function(data, cb)
    local is_police = exports["np-jobs"]:getJob(false, "is_police")
    local is_doj = exports["np-jobs"]:getJob(false, "is_doj")

    SendNUIMessage({
        type = "profiles",
        data = RPC.execute("np-mdt:searchProfile", data.name),
        isLimited = (is_police == false and is_doj == false)
    })

    cb(true)
end)

RegisterNUICallback("getProfileData", function(data, cb)
    local is_police = exports["np-jobs"]:getJob(false, "is_police")
    local is_doj = exports["np-jobs"]:getJob(false, "is_doj")
    local isLimited = (is_police == false and is_doj == false)

    local ProfileData = RPC.execute("np-mdt:getProfileData", data.id)
    if not isLimited then
        local vehicles = ProfileData["vehicles"]
        for i = 1, #vehicles do
            ProfileData["vehicles"][i]["plate"] = string.upper(ProfileData["vehicles"][i]["plate"])
            local tempModel = vehicles[i]["model"]
            if tempModel and tempModel ~= "Unknown" then
                local DisplayNameModel = GetDisplayNameFromVehicleModel(tempModel)
                local LabelText = GetLabelText(DisplayNameModel)
                if LabelText == "NULL" then LabelText = DisplayNameModel end
                ProfileData["vehicles"][i]["model"] = LabelText
            end
        end
    end

    SendNUIMessage({
        type = "profileData",
        data = ProfileData,
        isLimited = isLimited
    })

    cb(true)
end)

RegisterNUICallback("saveProfile", function(data, cb)
    TriggerServerEvent("np-mdt:saveProfile", data.pfp, data.description, data.id, data.fName, data.sName)
    cb(true)
end)

RegisterNUICallback("updateLicence", function(data, cb)
    TriggerServerEvent("np-mdt:updateLicense", data.cid, data.type, data.status)
    cb(true)
end)

RegisterNUICallback("newTag", function(data, cb)
    TriggerServerEvent("np-mdt:newTag", data.id, data.tag)
    cb(true)
end)

RegisterNUICallback("removeProfileTag", function(data, cb)
    TriggerServerEvent("np-mdt:removeProfileTag", data.cid, data.text)
    cb(true)
end)

RegisterNUICallback("addGalleryImg", function(data, cb)
    TriggerServerEvent("np-mdt:addGalleryImg", data.cid, data.URL)
    cb(true)
end)

RegisterNUICallback("removeGalleryImg", function(data, cb)
    TriggerServerEvent("np-mdt:removeGalleryImg", data.cid, data.URL)
    cb(true)
end)

RegisterNUICallback("searchHouse", function(data, cb)
    local houseInfo = exports["np-housing"]:getHouse(data.house_id)
    TriggerEvent("DoLongHudText", "GPS marcado!")
    SetNewWaypoint(houseInfo["pos"].x, houseInfo["pos"].y)
    cb(true)
end)

RegisterNUICallback("dnaEdit", function(data, cb)
    TriggerServerEvent("np-mdt:dnaEdit", data.cid, data.dna)

    cb(true)
end)

--[[

    Incidents

]]

RegisterNUICallback("getAllIncidents", function(data, cb)
    SendNUIMessage({
        type = "incidents",
        data = RPC.execute("np-mdt:getAllIncidents")
    })

    cb(true)
end)

RegisterNUICallback("searchIncidents", function(data, cb)
    SendNUIMessage({
        type = "incidents",
        data = RPC.execute("np-mdt:searchIncidents", data.incident)
    })

    cb(true)
end)

RegisterNUICallback("getIncidentData", function(data, cb)
    local sentData, sentConvictions = RPC.execute("np-mdt:getIncidentData", data.id)

    SendNUIMessage({
        type = "incidentData",
        data = sentData,
        convictions = sentConvictions
    })

    cb(true)
end)

RegisterNUICallback("incidentSearchPerson", function(data, cb)
    SendNUIMessage({
        type = "incidentSearchPerson",
        data = RPC.execute("np-mdt:incidentSearchPerson", data.name)
    })

    cb(true)
end)

RegisterNUICallback("getPenalCode", function(data, cb)
    local titles, penalcode, job = RPC.execute("np-mdt:getPenalCode")

    SendNUIMessage({
        type = "getPenalCode",
        titles = titles,
        penalcode = penalcode,
        job = job
    })

    cb(true)
end)

RegisterNUICallback("saveIncident", function(data, cb)
    TriggerServerEvent("np-mdt:saveIncident", data)
    cb(true)
end)

RegisterNUICallback("removeIncidentCriminal", function(data, cb)
    TriggerServerEvent("np-mdt:removeIncidentCriminal", data.cid, data.incidentId)
    cb(true)
end)

RegisterNUICallback("deleteIncident", function(data, cb)
    TriggerServerEvent("np-mdt:deleteIncident", data.id, data.time)
end)

--[[

    Reports

]]

RegisterNUICallback("getAllReports", function(data, cb)
    SendNUIMessage({
        type = "reports",
        data = RPC.execute("np-mdt:searchReports", "")
    })

    cb(true)
end)

RegisterNUICallback("searchReports", function(data, cb)
    SendNUIMessage({
        type = "reports",
        data = RPC.execute("np-mdt:searchReports", data.name)
    })

    cb(true)
end)

RegisterNUICallback("getReportData", function(data, cb)
    SendNUIMessage({
        type = "reportData",
        data = RPC.execute("np-mdt:getReportData", data.id)
    })

    cb(true)
end)

RegisterNUICallback("newReport", function(data, cb)
    TriggerServerEvent("np-mdt:newReport", data)
    cb(true)
end)

RegisterNetEvent("np-mdt:reportComplete")
AddEventHandler("np-mdt:reportComplete", function(sentData)
    SendNUIMessage({
        type = "reportComplete",
        data = sentData
    })
end)

RegisterNUICallback("deleteReport", function(data, cb)
    TriggerServerEvent("np-mdt:deleteReport", data.id, data.time)
end)

--[[

    BOLOs

]]

RegisterNUICallback("getAllBolos", function(data, cb)
    SendNUIMessage({
        type = "bolos",
        data = RPC.execute("np-mdt:searchBolos", "")
    })

    cb(true)
end)

RegisterNUICallback("searchBolos", function(data, cb)
    SendNUIMessage({
        type = "bolos",
        data = RPC.execute("np-mdt:searchBolos", data.searchVal)
    })

    cb(true)
end)

RegisterNUICallback("getBoloData", function(data, cb)
    SendNUIMessage({
        type = "boloData",
        data = RPC.execute("np-mdt:getBoloData", data.id)
    })

    cb(true)
end)

RegisterNUICallback("newBolo", function(data, cb)
    TriggerServerEvent("np-mdt:newBolo", data)
    cb(true)
end)

RegisterNetEvent("np-mdt:boloComplete", function(sentData)
    SendNUIMessage({
        type = "boloComplete",
        data = sentData
    })
end)

RegisterNUICallback("deleteBolo", function(data, cb)
    TriggerServerEvent("np-mdt:deleteBolo", data.id)
    cb(true)
end)

RegisterNUICallback("deleteICU", function(data, cb)
    TriggerServerEvent("np-mdt:deleteICU", data.id)
    cb(true)
end)

--[[

    DMV

]]

RegisterNUICallback("getAllVehicles", function(data, cb)
    local sentData = RPC.execute("np-mdt:searchVehicles", "")

    for i, v in ipairs(sentData) do
        sentData[i].color = ColorInformation[v.color1]
        sentData[i].colorName = ColorNames[v.color1]
        sentData[i].model = GetLabelText(GetDisplayNameFromVehicleModel(v.model))
    end

    SendNUIMessage({
        type = "searchedVehicles",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("searchVehicles", function(data, cb)
    local sentData = RPC.execute("np-mdt:searchVehicles", data.name)

    for i, v in ipairs(sentData) do
        sentData[i].color = ColorInformation[v.color1]
        sentData[i].colorName = ColorNames[v.color1]
        sentData[i].model = GetLabelText(GetDisplayNameFromVehicleModel(v.model))
    end

    SendNUIMessage({
        type = "searchedVehicles",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("getVehicleData", function(data, cb)
    local sentData = RPC.execute("np-mdt:getVehicleData", data.plate)

    sentData["color"] = ColorInformation[sentData["color1"]]
    sentData["colorName"] = ColorNames[sentData["color1"]]
    sentData["model"] = GetLabelText(GetDisplayNameFromVehicleModel(sentData["model"]))
    sentData["class"] = classlist[GetVehicleClassFromName(sentData["model"])]

    SendNUIMessage({
        type = "getVehicleData",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("saveVehicleInfo", function(data, cb)
    TriggerServerEvent("np-mdt:saveVehicleInfo", data.dbid, data.plate, data.imageurl, data.notes)

    cb(true)
end)

RegisterNUICallback("knownInformation", function(data, cb)
    TriggerServerEvent("np-mdt:knownInformation", data.dbid, data.type, data.status, data.plate)

    cb(true)
end)

--[[

    Weapons

]]

RegisterNUICallback("getAllWeapons", function(data, cb)
    local sentData = RPC.execute("np-mdt:searchWeapon", "")

    SendNUIMessage({
        type = "searchedWeapons",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("searchWeapon", function(data, cb)
    local sentData = RPC.execute("np-mdt:searchWeapon", data.name)

    SendNUIMessage({
        type = "searchedWeapons",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("getWeaponData", function(data, cb)
    local sentData = RPC.execute("np-mdt:getWeaponData", data.serialnumber)

    SendNUIMessage({
        type = "getWeaponData",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("newWeapon", function(data, cb)
    TriggerServerEvent("np-mdt:addWeapon", data.id, data.serialnumber)

    cb(true)
end)

RegisterNUICallback("saveWeaponInfo", function(data, cb)
    TriggerServerEvent("np-mdt:saveWeapon", data.serialnumber, data.imageurl, data.brand, data.type, data.notes)

    cb(true)
end)

--[[

    Missing

]]

RegisterNUICallback("getAllMissing", function(data, cb)
    local sentData = RPC.execute("np-mdt:searchMissing", "")

    SendNUIMessage({
        type = "searchedMissing",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("searchMissing", function(data, cb)
    local sentData = RPC.execute("np-mdt:searchMissing", data.name)

    SendNUIMessage({
        type = "searchedMissing",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("getMissingData", function(data, cb)
    local sentData = RPC.execute("np-mdt:getMissingData", data.id)

    SendNUIMessage({
        type = "getMissingData",
        data = sentData
    })

    cb(true)
end)

RegisterNUICallback("missingCitizen", function(data, cb)
    TriggerServerEvent("np-mdt:missingCitizen", data.cid, data.time)

    cb(true)
end)

RegisterNUICallback("saveMissingInfo", function(data, cb)
    TriggerServerEvent("np-mdt:saveMissing", data.id, data.last_seen, data.imageurl, data.notes)

    cb(true)
end)

RegisterNUICallback("deleteMissing", function(data, cb)
    TriggerServerEvent("np-mdt:deleteMissing", data.id, data.time)

    cb(true)
end)

--[[

    Logs

]]

RegisterNUICallback("getAllLogs", function(data, cb)
    SendNUIMessage({
        type = "getAllLogs",
        data = RPC.execute("np-mdt:getAllLogs")
    })

    cb(true)
end)

--[[

    Misc

]]

RegisterNetEvent("clientcheckLicensePlate")
AddEventHandler("clientcheckLicensePlate", function(pDummy, pEntity)
    local licensePlate = GetVehicleNumberPlateText(pEntity)
    if licensePlate == nil then
    	TriggerEvent("DoLongHudText", "Can not target vehicle", 2)
    else
        EnableGUI(true)

        Citizen.Wait(250)

        SendNUIMessage({
            type = "checkPlate",
            plate = licensePlate
        })
    end
end)