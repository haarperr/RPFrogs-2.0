--[[

    Variables

]]

local data = {}
local hasTvBox = false

--[[

    Functions

]]

function isPlaying(pEntity)
    local entityCoords = GetEntityCoords(pEntity)
    for k, v in pairs(data) do
        if v["Coords"] == entityCoords then
            return true
        end
    end
    return false
end

function GenerateId(length, usecapital, usenumbers)
    local result = ""

    for i = 1, length do
        local randomised = string.char(math.random(97, 122))
        if usecapital then
            if math.random(1, 2) == 1 then
                randomised = randomised:upper()
            end
        end
        if usenumbers then
            if math.random(1, 2) == 1 then
                randomised = tostring(math.random(0, 9))
            end
        end
        result = result .. randomised
    end

    return result
end

function VolumeCheck(id)
    if data[id]["DUI"] then
        if data[id]["ActualVolume"] ~= data[id]["Volume"] then
            local duiLong = data[id]["DUI"]["Long"]

            SendDuiMouseMove(duiLong, 75, 700)
            Wait(250)
            SendDuiMouseMove(duiLong, 95 + math.ceil(data[id]["Volume"] * 5), 702)
            Wait(5)
            SendDuiMouseDown(duiLong, "left")
            Wait(7)
            SendDuiMouseUp(duiLong, "left")

            SendDuiMouseMove(duiLong, 75, 500)

            data[id]["ActualVolume"] = data[id]["Volume"]
        end
    end
end

function CreateVideo(id, url, object, coords, scale, offset, time, volume)
    if data[id] then
        if data[id]["DUI"] then
            DestroyDui(data[id]["DUI"]["Long"])
        end
        data[id] = nil
        Wait(500)
    end

    local distance = 10.0

    for k, v in pairs(Config["Objects"]) do
        if v["Object"] == object then
            Distance = v["Distance"]
            break
        end
    end

    data[id] = {
        ["URL"] = url,
        ["Time"] = time,
        ["Started"] = math.ceil(GetGameTimer() / 1000) + 1,
        ["Object"] = object,
        ["Coords"] = coords,
        ["Offset"] = offset,
        ["Scale"] = scale,
        ["Volume"] = volume,
        ["ActualVolume"] = 0,
        ["Distance"] = Distance
    }
end

--[[

    Events

]]

AddEventHandler("np-inventory:itemCheck", function (item, state, quantity)
--if item ~= "custommiscitem" then return end

    if exports["np-inventory"]:hasEnoughOfItem("custommiscitem", 1) then
        if not hasTvBox then
            hasTvBox = true
        end
    else
        if hasTvBox then
            hasTvBox = false
        end
    end
end)

AddEventHandler("np-tvbox:start", function(pArgs, pEntity)
    local pEntityCoords = GetEntityCoords(pEntity)

    for k, v in pairs(Config["Objects"]) do
        local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey(v["Object"]))
        if DoesEntityExist(obj) and obj == pEntity then
            TriggerServerEvent("np-tv:add", "lL5RPnXyklk", v["Object"], pEntityCoords, v["Scale"], v["Offset"])
            break
        end
    end
end)

AddEventHandler("np-tvbox:change", function(pArgs, pEntity)
    local pEntityCoords = GetEntityCoords(pEntity)

    local input = exports["np-input"]:showInput({
        {
            icon = "edit",
            label = "Youtube ID (Exemplo: lL5RPnXyklk)",
            name = "url",
        },
    })

    if input["url"] then
        for k, v in pairs(Config["Objects"]) do
            local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 5.0, GetHashKey(v["Object"]))
            if DoesEntityExist(obj) and obj == pEntity then
                TriggerServerEvent("np-tv:add", input["url"], v["Object"], pEntityCoords, v["Scale"], v["Offset"])
                break
            end
        end
    end
end)

AddEventHandler("np-tvbox:sync", function(pArgs, pEntity)
    local pEntityCoords = GetEntityCoords(pEntity)

    for k, v in pairs(data) do
        if v["Coords"] == pEntityCoords then
            if v["DUI"] then
                SetDuiUrl(v["DUI"]["Long"], Config["URL"]:format(v["URL"], (math.floor(GetGameTimer() / 1000) + v["Time"]) - v["Started"]))
            end
        end
    end
end)

AddEventHandler("np-tvbox:volume", function(pArgs, pEntity)
    local pEntityCoords = GetEntityCoords(pEntity)

    local input = exports["np-input"]:showInput({
        {
            icon = "volume-up",
            label = "Volume (0-10)",
            name = "volume",
        },
    })

    if input["volume"] then
        local volume = tonumber(input["volume"])
        if not volume or volume < 0 or volume > 10 then
            TriggerEvent("DoLongHudText", "invalid value", 2)
            return
        end

        for k, v in pairs(data) do
            if v["Coords"] == pEntityCoords then
                if volume == 1 then volume = 1.5 end
                TriggerServerEvent("np-tv:setvolume", k, volume)
                break
            end
        end
    end
end)

AddEventHandler("np-tvbox:destroy", function(pArgs, pEntity)
    local pEntityCoords = GetEntityCoords(pEntity)

    for k, v in pairs(data) do
        if v["Coords"] == pEntityCoords then
            TriggerServerEvent("np-tv:destroy", k)
            break
        end
    end
end)

RegisterNetEvent("np-tv:update", function(players)
    for k, v in pairs(players) do
        if v ~= nil then
            CreateVideo(k, v["URL"], v["Object"], v["Coords"], v["Scale"], v["Offset"], v["Time"], v["Volume"])

            if v["Duration"] then
                data[k]["Duration"] = v["Duration"]
            end
        end
    end
end)

RegisterNetEvent("np-tv:updatevolume", function(id, volume)
    if data[id] then
        data[id]["Volume"] = volume
    end
end)

RegisterNetEvent("np-tv:delete", function(id)
    if data[id] then
        if data[id]["DUI"] then
            DestroyDui(data[id]["DUI"]["Long"])
        end
        data[id] = nil
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-eye"]:AddPeekEntryByFlag({ "isTelevision" }, {
        {
            id = "tvbox-start",
            label = "Start TV",
            icon = "tv",
            event = "np-tvbox:start",
            parameters = {}
        }
    }, { distance = { radius = 2.5 }, isEnabled = function(pEntity, pContext) return hasTvBox and not isPlaying(pEntity) end })

    exports["np-eye"]:AddPeekEntryByFlag({ "isTelevision" }, {
        {
            id = "tvbox-change",
            label = "Edit",
            icon = "edit",
            event = "np-tvbox:change",
            parameters = {}
        }
    }, { distance = { radius = 2.5 }, isEnabled = isPlaying })

    exports["np-eye"]:AddPeekEntryByFlag({ "isTelevision" }, {
        {
            id = "tvbox-sync",
            label = "Sync",
            icon = "sync",
            event = "np-tvbox:sync",
            parameters = {}
        }
    }, { distance = { radius = 2.5 }, isEnabled = isPlaying })

    exports["np-eye"]:AddPeekEntryByFlag({ "isTelevision" }, {
        {
            id = "tvbox-volume",
            label = "Volume",
            icon = "volume-up",
            event = "np-tvbox:volume",
            parameters = {}
        }
    }, { distance = { radius = 2.5 }, isEnabled = isPlaying })

    exports["np-eye"]:AddPeekEntryByFlag({ "isTelevision" }, {
        {
            id = "tvbox-stop",
            label = "Turn Off",
            icon = "power-off",
            event = "np-tvbox:destroy",
            parameters = {}
        }
    }, { distance = { radius = 2.5 }, isEnabled = isPlaying })
end)

Citizen.CreateThread(function()
    while true do
        Wait(500)

        for k, v in pairs(data) do
            Wait(100)
            local obj = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), v["Distance"], GetHashKey(v["Object"]))

            if v ~= nil then
                local obj = GetClosestObjectOfType(v["Coords"], v["Distance"], GetHashKey(v["Object"]))
                if DoesEntityExist(obj) then
                    Wait(2500)
                    while #(GetEntityCoords(PlayerPedId()) - v["Coords"]) <= v["Distance"] and data[k] ~= nil and DoesEntityExist(obj) do
                        VolumeCheck(k)
                        Wait(500)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local SFHandle = RequestScaleformMovie("generic_texture_renderer")
    while not HasScaleformMovieLoaded(SFHandle) do Wait(1000) end

    TriggerServerEvent("np-tv:fetch")

    while true do
        Wait(500)

        for k, v in pairs(data) do
            Wait(0)
            if v ~= nil then
                local obj = GetClosestObjectOfType(v["Coords"], v["Distance"], GetHashKey(v["Object"]))
                if DoesEntityExist(obj) then
                    if #(GetEntityCoords(PlayerPedId()) - v["Coords"]) <= v["Distance"] then
                        if SFHandle ~= nil then
                            local duiLong = CreateDui(Config["URL"]:format(v["URL"], (math.floor(GetGameTimer() / 1000) + v["Time"]) - v["Started"]), 1280, 720)
                            local dui = GetDuiHandle(duiLong)

                            local txd, txn = GenerateId(25, true, false), GenerateId(25, true, false)
                            CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd(txd), txn, dui)

                            v["DUI"] = {
                                ["Long"] = duiLong,
                                ["Obj"] = dui,
                            }

                            v["Texture"] = {
                                ["txd"] = txd,
                                ["txn"] = txn,
                            }

                            PushScaleformMovieFunction(SFHandle, "SET_TEXTURE")
                            PushScaleformMovieMethodParameterString(v["Texture"]["txd"])
                            PushScaleformMovieMethodParameterString(v["Texture"]["txn"])

                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(1920)
                            PushScaleformMovieFunctionParameterInt(1080)

                            PopScaleformMovieFunctionVoid()

                            while #(GetEntityCoords(PlayerPedId()) - v["Coords"]) <= v["Distance"] and DoesEntityExist(obj) and data[k] ~= nil do
                                Wait(0)

                                if v["Duration"] then
                                    if (math.ceil(GetGameTimer() / 1000) - v["Started"]) > v["Duration"] then
                                        DestroyDui(v["DUI"]["Long"])
                                        data[k] = nil
                                        break
                                    end
                                end
                                DrawScaleformMovie_3dNonAdditive(SFHandle, GetOffsetFromEntityInWorldCoords(obj, v["Offset"]), 0.0, GetEntityHeading(obj) * -1, 0.0, 2, 2, 2, v["Scale"] * 1, v["Scale"] * (9 / 16), 1, 2)
                            end

                            if data[k] then
                                -- destroy browser (we are no longer close to the tv)
                                DestroyDui(v["DUI"]["Long"])

                                v["DUI"] = {}
                                v["Texture"] = {}
                            end
                        end
                    end
                end
            end
        end
    end
end)