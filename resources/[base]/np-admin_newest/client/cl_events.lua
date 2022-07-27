local BlipsEnabled, NamesEnabled, GodmodeEnabled, AllPlayerBlips = false, false, false, {}

RegisterNetEvent("Admin:Godmode", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:toggleGodmode', Result['player'])
    end
end)

RegisterNetEvent('Admin:Toggle:Noclip', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        SendNUIMessage({
            Action = "SetItemEnabled",
            Name = 'noclip',
            State = not noClipEnabled
        })
        if noClipEnabled then
            toggleFreecam(false)
        else
            toggleFreecam(true)
        end
    end
end)

RegisterNetEvent('Admin:Fix:Vehicle', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), true))
        end 
    end
end)

RegisterNetEvent('Admin:Delete:Vehicle', function(Result)
    local ped = PlayerPedId()

    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
            local pos = GetEntityCoords(ped)
            
            if (IsPedSittingInAnyVehicle(ped)) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                
                if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    DeleteGivenVehicle(vehicle, numRetries)
                else
                    TriggerEvent("DoLongHudText", "You must be in the driver's seat!")
                end
            else
                local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, distanceToCheck, 0.0)
                local vehicle = GetVehicleInDirection(ped, pos, inFrontOfPlayer)
                
                if (DoesEntityExist(vehicle)) then
                    DeleteGivenVehicle(vehicle, numRetries)
                else
                    TriggerEvent("DoLongHudText", "You must be in or near a vehicle to delete it.")
                end
            end
        end
    end
end)

-- RegisterNetEvent('Admin:Spawn:Vehicle', function(Result)
--     if IsPlayerAdmin() then
--         SendNUIMessage({
--             Action = 'Close',
--         })
--         TriggerEvent('np-adminmenu:runSpawnCommand', Result['model'])
--     end
-- end)

RegisterNetEvent('Admin:Sound:Vehicle', function(Result)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        -- if not veh then
            ForceVehicleEngineAudio(veh, Result['sound'])
    end
end)

RegisterNetEvent('Admin:Teleport:Marker', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        teleportMarker()
    end
end)

RegisterNetEvent('Admin:Open:bennys', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerEvent('np-admin_newest:bennys')
    end
end)

RegisterNetEvent('Admin:Teleport:Coords', function(Result)
    if IsPlayerAdmin() then
        if Result['x-coord'] ~= '' and Result['y-coord'] ~= '' and Result['z-coord'] ~= '' then
            SendNUIMessage({
                Action = 'Close',
            })
            SetEntityCoords(PlayerPedId(), tonumber(Result['x-coord']), tonumber(Result['y-coord']), tonumber(Result['z-coord']))
        end
    end
end)

RegisterNetEvent('Admin:Teleport', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-admin_newest:teleportPlayer', Result['player'], Result['type'])
    end
end)

RegisterNetEvent("Admin:Chat:Say", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:chatSay', Result['message'])
    end
end)

RegisterNetEvent("Admin:Money:state", function(Result)
    print(json.encode(Result))
    if IsPlayerAdmin() then
        TriggerServerEvent('Admin:Money:state', Result['player'], Result['type'], Result['state'], Result['amount'])
    end
end)

RegisterNetEvent('Admin:Open:Clothing', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-admin_newest:openClothing', Result['player'])
    end
end)

RegisterNetEvent('Admin:Open:Barber', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-admin_newest:openBarber', Result['player'])
    end
end)

RegisterNetEvent('Admin:Open:Tattoo', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-admin_newest:openTattoo', Result['player'])
    end
end)

RegisterNetEvent('Admin:Open:Outfits', function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent('np-admin_newest:openOutfits', Result['player'])
    end
end)

RegisterNetEvent('Admin:Revive', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:reviveTarget', Result['player'])
    end
end)

RegisterNetEvent('Admin:Remove:Stress', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:removeStress', Result['player'])
    end
end)

RegisterNetEvent('Admin:Change:Model', function(Result)
    if IsPlayerAdmin() and Result['model'] ~= '' then
        local Model = GetHashKey(Result['model'])
        if IsModelValid(Model) then
            TriggerServerEvent('np-admin_newest:setModel', Result['player'], Model)
        end
    end
end)

RegisterNetEvent('Admin:Reset:Model', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:resetSkin', Result['player'])
    end
end)

RegisterNetEvent('Admin:Armor', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:setArmor', Result['player'])
    end
end)

RegisterNetEvent('Admin:Food:Drink', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:setFoodDrink', Result['player'])
    end
end)

RegisterNetEvent('Admin:Request:Job', function(Result)
    if IsPlayerAdmin() then
        if Result['job'] ~= '' then
            TriggerServerEvent('np-admin_newest:requestJob', Result['player'], Result['job'])
        end
    end
end)

RegisterNetEvent("Admin:Drunk", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:drunk', Result['player'])
    end
end)

RegisterNetEvent("Admin:Animal:Attack", function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:animalAttack', Result['player'])
    end
end)

RegisterNetEvent('Admin:Set:Fire', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:setFire', Result['player'])
    end
end)

RegisterNetEvent('Admin:Fling:Player', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:flingPlayer', Result['player'])
    end
end)

RegisterNetEvent('Admin:GiveItem', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:giveItem', Result['player'], Result['item'], Result['amount'])
    end
end)

RegisterNetEvent('Admin:Ban', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:banPlayer', Result['player'], Result['expire'], Result['reason'])
    end
end)

RegisterNetEvent('Admin:Kick', function(Result)
    if IsPlayerAdmin() then
        TriggerServerEvent('np-admin_newest:kickPlayer', Result['player'], Result['reason'])
    end
end)

RegisterNetEvent("Admin:Copy:Coords", function(Result)
    if IsPlayerAdmin() then
        local CoordsType = Result['type']
        local CoordsLayout = nil

        local Coords = GetEntityCoords(PlayerPedId())
        local Heading = GetEntityHeading(PlayerPedId())
        local X = roundDecimals(Coords.x, 2)
        local Y = roundDecimals(Coords.y, 2)
        local Z = roundDecimals(Coords.z, 2)
        local H = roundDecimals(Heading, 2)
        if CoordsType == 'vector3(0.0, 0.0, 0.0)' then
            CoordsLayout = 'vector3('..X..', '..Y..', '..Z..')'
        elseif CoordsType == 'vector4(0.0, 0.0, 0.0, 0.0)' then
            CoordsLayout = 'vector4('..X..', '..Y..', '..Z..', '..H..')'
        elseif CoordsType == '0.0, 0.0, 0.0' then
            CoordsLayout = ''..X..', '..Y..', '..Z..''
        elseif CoordsType == '0.0, 0.0, 0.0, 0.0' then
            CoordsLayout = ''..X..', '..Y..', '..Z..', '..H..''
        elseif CoordsType == 'X = 0.0, Y = 0.0, Z = 0.0' then
            CoordsLayout = 'X = '..X..', Y = '..Y..', Z = '..Z..''
        elseif CoordsType == 'x = 0.0, y = 0.0, z = 0.0' then
            CoordsLayout = 'x = '..X..', y = '..Y..', z = '..Z..''
        elseif CoordsType == 'X = 0.0, Y = 0.0, Z = 0.0, H = 0.0' then
            CoordsLayout = 'X = '..X..', Y = '..Y..', Z = '..Z..', H = '..H
        elseif CoordsType == 'x = 0.0, y = 0.0, z = 0.0, h = 0.0' then
            CoordsLayout = 'x = '..X..', y = '..Y..', z = '..Z..', h = '..H
        elseif CoordsType == '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0' then
            CoordsLayout = '["X"] = '..X..', ["Y"] = '..Y..', ["Z"] = '..Z
        elseif CoordsType == '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0' then
            CoordsLayout = '["x"] = '..X..', ["y"] = '..Y..', ["z"] = '..Z
        elseif CoordsType == '["X"] = 0.0, ["Y"] = 0.0, ["Z"] = 0.0, ["H"] = 0.0' then
            CoordsLayout = '["X"] = '..X..', ["Y"] = '..Y..', ["Z"] = '..Z..', ["H"] = '..H
        elseif CoordsType == '["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0, ["h"] = 0.0' then
            CoordsLayout = '["x"] = '..X..', ["y"] = '..Y..', ["z"] = '..Z..', ["h"] = '..H
        end
        SendNUIMessage({
			Action = 'copyCoords',
			Coords = CoordsLayout
		})
    end
end)

RequestScriptAudioBank('dlc_nikez_general/general_general', 0)

RegisterNetEvent("Admin:Fart:Player", function(Result)
    if IsPlayerAdmin() then
        PlaySoundFrontend(-1, Result['fart'], "dlc_nikez_general", 0, "general_general")
    end
end)

RegisterNetEvent('Admin:Toggle:PlayerBlips', function()
    if not IsPlayerAdmin() then return end

    BlipsEnabled = not BlipsEnabled

    TriggerServerEvent('np-admin_newest:toggleBlips')

    SendNUIMessage({
        Action = "SetItemEnabled",
        Name = 'playerblips',
        State = BlipsEnabled
    })

    if not BlipsEnabled then
        DeletePlayerBlips()
    end
end)

RegisterNetEvent('Admin:Toggle:PlayerNames', function()
    if not IsPlayerAdmin() then return end

    NamesEnabled = not NamesEnabled

    SendNUIMessage({
        Action = "SetItemEnabled",
        Name = 'playernames',
        State = NamesEnabled
    })

    if NamesEnabled then
        local Players = GetPlayersInArea(nil, 15.0)

        Citizen.CreateThread(function()
            while NamesEnabled do
                Citizen.Wait(2000)
                Players = GetPlayersInArea(nil, 15.0)
            end
        end)

        Citizen.CreateThread(function()
            while NamesEnabled do
                for k, v in pairs(Players) do
                    local Ped = GetPlayerPed(GetPlayerFromServerId(tonumber(v['ServerId'])))
                    local PedCoords = GetPedBoneCoords(Ped, 0x796e)
                    local PedHealth = GetEntityHealth(Ped) / GetEntityMaxHealth(Ped) * 100
                    local PedArmor = GetPedArmour(Ped)
                    
                    DrawText3D(vector3(PedCoords.x, PedCoords.y, PedCoords.z + 0.5), ('[%s] - %s ~n~Health: %s - Armor: %s'):format(v['ServerId'], v['Name'], math.floor(PedHealth), math.floor(PedArmor)))
                end
                
                Citizen.Wait(1)
            end
        end)
    end
end)

RegisterNetEvent('Admin:Toggle:Spectate', function(Result)
    if not IsPlayerAdmin() then return end

    if not isSpectateEnabled then
        TriggerServerEvent('np-admin_newest:startSpectate', Result['player'])
    else
        toggleSpectate(storedTargetPed)
        preparePlayerForSpec(false)
        TriggerServerEvent('np-admin_newest:stopSpectate')
    end
end)

RegisterNetEvent("Admin:OpenInv", function(Result)
    if IsPlayerAdmin() then
        SendNUIMessage({
            Action = 'Close',
        })
        TriggerServerEvent("admin:searchInventory", Result['player'])
    end
end)

-- [ Triggered Events ] --

RegisterNetEvent("np-admin_newest:toggleGodmode", function()
    GodmodeEnabled = not GodmodeEnabled

    local Msg = GodmodeEnabled and 'enabled.' or 'disabled.'
    local MsgType = GodmodeEnabled and '1' or '2'
    TriggerEvent('DoLongHudText', 'Godmode '.. Msg, MsgType)


    if GodmodeEnabled then
        while GodmodeEnabled do
            Wait(0)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end)

RegisterNetEvent('np-admin_newest:teleportPlayer', function(Coords)
    local Entity = PlayerPedId()    
    SetPedCoordsKeepVehicle(Entity, Coords.x, Coords.y, Coords.z)
end)

RegisterNetEvent('np-admin_newest:setModel', function(Model)
    LoadModel(Model)
    SetPlayerModel(PlayerId(), Model)
    SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 0)
end)

RegisterNetEvent('np-admin_newest:armorUp', function()
    SetPedArmour(PlayerPedId(), 100.0)
end)

RegisterNetEvent("np-admin_newest/client/play-sound", function(Sound)
    local Soundfile = nil
    if Sound == 'Fart' then
        Soundfile = 'FartNoise2'
    elseif Sound == 'Wet Fart' then
        Soundfile = 'FartNoise'
    end
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 5, Soundfile, 0.3)
end)

RegisterNetEvent('np-admin_newest:flingPlayer', function()
    local Ped = PlayerPedId()
    if GetVehiclePedIsUsing(Ped) ~= 0 then
        ApplyForceToEntity(GetVehiclePedIsUsing(Ped), 1, 0.0, 0.0, 100000.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
    else
        ApplyForceToEntity(Ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
    end
end)

RegisterNetEvent('np-admin_newest:DeletePlayerBlips', function()
    if not IsPlayerAdmin() then return end
    DeletePlayerBlips()
end)

RegisterNetEvent('np-admin_newest:UpdatePlayerBlips', function(BlipData)
    if not IsPlayerAdmin() then return end
    
    local ServerId = GetPlayerServerId(PlayerId())
    for k, v in pairs(BlipData) do
        if tonumber(v.ServerId) ~= tonumber(ServerId) then
            local PlayerPed = GetPlayerPed(v.ServerId)
            local PlayerBlip = AddBlipForEntity(PlayerPed) 
            SetBlipSprite(PlayerBlip, 1)
            SetBlipColour(PlayerBlip, 0)
            SetBlipScale(PlayerBlip, 0.75)
            SetBlipAsShortRange(PlayerBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('['..v.ServerId..'] '..v.Name)
            EndTextCommandSetBlipName(PlayerBlip)
            table.insert(AllPlayerBlips, PlayerBlip)
        end
    end
end)

RegisterNetEvent("np-admin_newest:drunk", function()
    drunkThread()
end)

RegisterNetEvent("np-admin_newest:animalAttack", function()
    startWildAttack()
end)

RegisterNetEvent("np-admin_newest:setFire", function()
    local playerPed = PlayerPedId()
    StartEntityFire(playerPed)
end)

RegisterNetEvent("np-admin_newest:RemovePlayer")
AddEventHandler("np-admin_newest:RemovePlayer", function(src)
    local data = NPX._Admin.Players[src]
    NPX._Admin.DiscPlayers[src] = data
    NPX._Admin.Players[src] = nil
end)

RegisterNetEvent("np-admin_newest:AddPlayer")
AddEventHandler("np-admin_newest:AddPlayer", function(player)
    NPX._Admin.Players[player.source] = player
end)

