--[[

    Variables

]]

local Checking, Ack, Ghosted, Zone, IsSpeeding = {}, {}, {}, nil, false

local isRacing = false
SetLocalPlayerAsGhost(false)
SetGhostedEntityAlpha(254)

local nosActive = false

--[[

    Functions

]]

function startBubblePopper(pRace)
    if not pRace.bubblePopper and not pRace.nosPhasing then return end

    -- print("Starting Race", json.encode(pRace))

    isRacing = true

    local playerIds = {}
    local playerPed = PlayerPedId()

    local serverId = GetPlayerServerId(PlayerId())

    for _, player in pairs(pRace.players) do
        if serverId ~= player.id then
            playerIds[player.id] = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(player.id)), false)
        end
    end

    -- print("Starting vehicle tracking...")

    local ghosted = false
    local forceOff = false

    -- Tracks nearby players
    Citizen.CreateThread(function()
        while isRacing do
            forceOff = false
            playerPed = PlayerPedId()
            local otherVehicles = GetGamePool("CVehicle")
            local myCoords = GetEntityCoords(playerPed)

            for _, vehicle in ipairs(otherVehicles) do
                local ped = GetPedInVehicleSeat(vehicle, -1)
                if ped ~= 0 and ped ~= playerPed and not playerIds[GetPlayerServerId(NetworkGetPlayerIndexFromPed(ped))] and IsPedAPlayer(ped) then
                    local dist = #(myCoords - GetEntityCoords(vehicle))
                    if dist < 35.0 then
                        forceOff = true -- Some other vehicle is too close, disable ghost mode
                    end
                end
            end

            for playerId, _ in pairs(playerIds) do
                playerIds[playerId] = GetVehiclePedIsIn(GetPlayerPed(GetPlayerFromServerId(playerId)), false)
            end
            Wait(1000)
        end
    end)

    Citizen.CreateThread(function()
        while isRacing do
            Wait(0) -- Update time, this will determine how fast we should disable when ramming someone, should be LOW

            local inRange = false
            local toClose = false
            local myCoords = GetEntityCoords(playerPed)
            local myVehicle = GetVehiclePedIsIn(playerPed, false)
            if myVehicle ~= 0 then
                if pRace.nosPhasing then
                    if (not ghosted) and nosActive and (not forceOff) then
                        -- print("NOS Active, ghosting", ghosted, nosActive, forceOff)
                        SetLocalPlayerAsGhost(true)
                        ghosted = true
                    elseif ghosted and ((not nosActive) or forceOff) then
                        -- print("NOS Inactive or forced off, unghosting", ghosted, nosActive, forceOff)
                        SetLocalPlayerAsGhost(false)
                        ghosted = false
                    end
                end

                if pRace.bubblePopper then
                    local myVelocity = GetEntityVelocity(myVehicle)
                    for _, vehicle in pairs(playerIds) do
                        local innerBubbleThreshold = 10.0
                        local dist = #(myCoords - GetEntityCoords(vehicle))
                        if dist < 25.0 then
                            inRange = true -- At least one vehicle close enough, enable ghost mode
                            local relativeVelocity = #(GetEntityVelocity(vehicle) - myVelocity)
                            innerBubbleThreshold = math.max(6.0, math.min(10.0, relativeVelocity + 3.0))
                        end
                        if dist < innerBubbleThreshold then
                            toClose = true -- At least one vehicle inside of us, disable ghost mode
                        end
                    end

                    if inRange and not toClose and not ghosted then
                        SetLocalPlayerAsGhost(true)
                        ghosted = true
                        --print("In range, ghosting")
                    end

                    local nosCheck = (not pRace.nosPhasing or not nosActive)

                    if (toClose or forceOff) and ghosted and nosCheck then
                        SetLocalPlayerAsGhost(false)
                        ghosted = false
                        --print("To close, disabling")
                    end

                    if not inRange and not toClose and ghosted and nosCheck then
                        SetLocalPlayerAsGhost(false)
                        ghosted = false
                        --print("Nobody in range and not to close, disabling")
                    end
                end
            elseif ghosted then
                -- print("out of vehicle, disabling")
                SetLocalPlayerAsGhost(false)
                ghosted = false
            end
        end
        SetLocalPlayerAsGhost(false)
        ghosted = false
    end)
end








--[[

    Events

]]

AddEventHandler("baseevents:vehicleSpeeding", function (isSpeeding)
    IsSpeeding = isSpeeding

    if not isSpeeding then return end

    Ghosted = {}

    Citizen.CreateThread(function ()
        while IsSpeeding and Zone do
            for vehicle, enabled in pairs(Checking) do

                if not enabled then goto continue end

                local coord = GetEntityCoords(vehicle)

                local inside = Zone:isPointInside(coord)

                if inside and not Ghosted[vehicle] then
                    NetworkConcealEntity(vehicle, true)
                    Ghosted[vehicle] = true
                    if Config.antiGhostYeetVehicles then
                        TriggerEvent("np-density:yeet", vehicle)
                    end
                elseif not inside and Ghosted[vehicle] then
                    NetworkConcealEntity(vehicle, false)
                    Ghosted[vehicle] = false
                end

                ::continue::
            end

            Citizen.Wait(IsSpeeding and 0 or 50)
        end

        for vehicle, _ in pairs(Ghosted) do
            NetworkConcealEntity(vehicle, false)
        end
    end)
end)

AddEventHandler("baseevents:enteredVehicle", function (playerVehicle)
    Zone = EntityZone:Create(playerVehicle, { scale = { Config.antiGhostScaleX, Config.antiGhostScaleY, 5.0 }, debugPoly = Config.antiGhostDebug })

    Ack, Checking, Ghosted = {}, {}, {}

    Citizen.CreateThread(function ()
        local playerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        while Zone do
            local vehicles = GetGamePool("CVehicle")

            for _, vehicle in ipairs(vehicles) do
                if vehicle ~= playerVehicle and not Ack[vehicle] and not Checking[vehicle] then
                    local driver = GetPedInVehicleSeat(vehicle, -1)

                    local isPlayer = driver ~= 0 and IsPedAPlayer(driver)

                    if not isPlayer then
                        Checking[vehicle] = true
                    end
                end
            end

            Citizen.Wait(IsSpeeding and 0 or 50)
        end
    end)

    Citizen.CreateThread(function ()
        local prevCoords = {}

        while Zone do
            local idle = 500

            for vehicle, v in pairs(Checking) do
                Ack[vehicle] = (Ack[vehicle] or 0) + 1

                if Ack[vehicle] > 5 then
                    Checking[vehicle] = nil
                end
            end

            for vehicle, checks in pairs(Ack) do
                if not DoesEntityExist(vehicle) then
                    Ack[vehicle] = nil

                    Ghosted[vehicle] = nil

                    Checking[vehicle] = nil

                    goto continue
                end

                if checks > 5 then
                    local coords = GetEntityCoords(vehicle)

                    if not prevCoords[vehicle] then prevCoords[vehicle] = coords end

                    local change = #(prevCoords[vehicle] - coords)

                    if change > 100.0 then
                        Ack[vehicle] = 0
                        Checking[vehicle] = true
                    end

                    if Ghosted[vehicle] and not Checking[vehicle] and not Zone:isPointInside(coords) then
                        NetworkConcealEntity(vehicle, false)
                        Ghosted[vehicle] = false
                    end

                    prevCoords[vehicle] = coords
                end

                ::continue::
            end

            Citizen.Wait(idle)
        end
    end)
end)

AddEventHandler("baseevents:leftVehicle", function ()
    if Zone == nil then return end

    Zone:destroy()

    Zone = nil
end)

AddEventHandler("np-density:yeet", function (vehicle)
    local vin = exports["np-vehicles"]:GetVehicleIdentifier(vehicle)

    if vin then return end

    exports["np-sync"]:SyncedExecution("DeleteEntity", vehicle)
end)

AddEventHandler("noshud", function(_nos, _nosEnabled)
    nosActive = _nosEnabled
end)

AddEventHandler("mkr_racing:api:currentRace", function(currentRace)
    isRacing = currentRace ~= nil
    if isRacing then
        startBubblePopper(currentRace)
    end
end)

AddEventHandler("np-config:configLoaded", function (pId)
    if (pId ~= "np-density") then return end

    if Zone == nil then return end

    local playerVehicle = Zone.entity

    Citizen.Wait(1000)

    Zone:destroy()

    Zone = EntityZone:Create(playerVehicle, { scale = { Config.antiGhostScaleX, Config.antiGhostScaleY, 5.0 }, debugPoly = Config.antiGhostDebug })
end)