RegisterNetEvent('np-admin_new:try-open-menu', function(OnPress)
    if not OnPress or not IsPlayerAdmin() then return end
    local Bans = GetBans()
    local Players = GetPlayers()
    print(json.encode(Players))
    SetCursorLocation(0.87, 0.15)
    SetNuiFocus(true, true)
    SendNUIMessage({
        Action = 'Open',
        Debug = Config.MenuDebug,
        Bans = Bans,
        AllPlayers = Players,
        AdminItems = Config.AdminMenus,
        Favorited = Config.FavoritedItems,
        PinnedPlayers = Config.PinnedTargets,
        MenuSettings = Config.AdminSettings
    })
end)

RegisterNetEvent('np-admin_new:forceClose', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        Action = 'Close',
    })
end)

RegisterNUICallback('Admin/ToggleFavorite', function(Data, Cb)
    Config.FavoritedItems[Data.Id] = Data.Toggle
    SetKvp("np-adminmenu-favorites", json.encode(Config.FavoritedItems), "Favorites")
    Cb('Ok')
end)

RegisterNUICallback('Admin/TogglePinnedTarget', function(Data, Cb)
    Config.PinnedTargets[Data.Id] = Data.Toggle
    SetKvp("np-adminmenu-pinned_targets", json.encode(Config.PinnedTargets), "Targets")
    Cb('Ok')
end)

RegisterNUICallback('Admin/ToggleSetting', function(Data, Cb)
    Config.AdminSettings[Data.Id] = Data.Toggle
    SetKvp("np-adminmenu-settings", json.encode(Config.AdminSettings), "Settings")
    Cb('Ok')
end)

RegisterNUICallback('Admin/GetCharData', function(Data, Cb)
    local CharData = RPC.execute('np-admin_new:getChardata', Data.License)
end)

RegisterNUICallback("Admin/Close", function(Data, Cb)
   SetNuiFocus(false, false)
   Cb('Ok')
end)

RegisterNUICallback("Admin/DevMode", function(Data, Cb)
    local Bool = Data.Toggle
    ToggleDevMode(Bool)
    Cb('Ok')
end)

RegisterNUICallback('Admin/TriggerAction', function(Data, Cb) 
    if IsPlayerAdmin() then
        if Data.EventType == nil then Data.EventType = 'Client' end
        if Data.Event ~= nil and Data.EventType ~= nil then
            if Data.EventType == 'Client' then
                TriggerEvent(Data.Event, Data.Result)
            else
                TriggerServerEvent(Data.Event, Data.Result)
            end
        end
    end
    Cb('Ok')
end)

RegisterCommand("+addAdminMenu", function()
    if not OnPress or not IsPlayerAdmin() then return end
    local Bans = GetBans()
    local Players = GetPlayers()
    SetCursorLocation(0.87, 0.15)
    SetNuiFocus(true, true)
    SendNUIMessage({
        Action = 'Open',
        Debug = Config.MenuDebug,
        Bans = Bans,
        AllPlayers = Players,
        AdminItems = Config.AdminMenus,
        Favorited = Config.FavoritedItems,
        PinnedPlayers = Config.PinnedTargets,
        MenuSettings = Config.AdminSettings
    })
end, false)
RegisterCommand("-addAdminMenu", function() end, false)

Citizen.CreateThread(function()
    exports["np-keybinds"]:registerKeyMapping("", "Admin", "Open Menu", "+addAdminMenu", "-addAdminMenu")
end)

-- MADE A VEHICLE GOD MODE SCRIPT BECAUSE YEAH (BLACKPOOL)

local vehGod = false
local lastVehicle = 0
RegisterCommand("vehgodmode", function(source, args, rawCommand)
    vehGod = not vehGod
    lastVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleFixed(lastVehicle)
    if IsPlayerAdmin then
        if lastVehicle ~= 0 then
            print("Got vehicle: "..lastVehicle)
            while vehGod do
                Wait(0)
                local currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                if currentVehicle == lastVehicle then
                    SetEntityInvincible(currentVehicle, true)
                    SetEntityProofs(currentVehicle, true, true, true, true, true, true, true, true)
                    SetVehicleTyresCanBurst(currentVehicle, false)
                    SetVehicleCanBreak(currentVehicle, false)
                    SetVehicleCanBeVisiblyDamaged(currentVehicle, false)
                    SetEntityCanBeDamaged(currentVehicle, false)
                    SetVehicleExplodesOnHighExplosionDamage(currentVehicle, false)
                    SetFlyThroughWindscreenParams(999, 1.0, 1.0, 1.0)
                    lastVehicle = currentVehicle
                    -- Setting gotmode if lastVehicle == current vehicle
                elseif currentVehicle ~= lastVehicle then
                    SetEntityInvincible(lastVehicle, false)
                    SetEntityProofs(lastVehicle, false, false, false, false, false, false, false, false)
                    SetVehicleTyresCanBurst(lastVehicle, true)
                    SetVehicleCanBreak(lastVehicle, true)
                    SetVehicleCanBeVisiblyDamaged(lastVehicle, true)
                    SetEntityCanBeDamaged(lastVehicle, true)
                    SetVehicleExplodesOnHighExplosionDamage(lastVehicle, true)
                    SetFlyThroughWindscreenParams(45.0, 1.0, 1.0, 1.0)
                    currentVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    -- print('PauseChampion')
                    -- Waiting for the ped to enter a vehicle or re-enter old vehicle
                    if currentVehicle ~= 0 then
                        print('Set to new vehicle')
                        lastVehicle = currentVehicle -- set lastveh to new vehicle
                    end
                    Wait(500)
                end
            end
        else
            print('^1Not in a vehicle') -- if ped not in vehicle then
            vehGod = false
        end
        lastVehicle = 0
        print('Exited Godmode')
    else
        print('^1You are not an admin')
    end
end, false)