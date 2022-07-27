RegisterNetEvent('np-admin:try-open-menu', function(OnPress)
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
end)

RegisterNetEvent('np-admin:forceClose', function()
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
    local CharData = RPC.execute('np-admin:getChardata', Data.License)
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
    if not IsPlayerAdmin() then return end
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

LastVehicle = nil
RegisterNetEvent("np-adminmenu:runSpawnCommand")
AddEventHandler("np-adminmenu:runSpawnCommand", function(model, livery)
    Citizen.CreateThread(function()
            
            local hash = GetHashKey(model)
            
            if not IsModelAVehicle(hash) then return end
            if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
            
            RequestModel(hash)
            
            while not HasModelLoaded(hash) do
                Citizen.Wait(0)
            end
            
            local localped = PlayerPedId()
            local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.5, 5.0, 0.0)
            
            local heading = GetEntityHeading(localped)
            local vehicle = CreateVehicle(hash, coords, heading, true, false)
            
            SetVehicleModKit(vehicle, 0)
            SetVehicleMod(vehicle, 11, 3, false)
            SetVehicleMod(vehicle, 12, 2, false)
            SetVehicleMod(vehicle, 13, 2, false)
            SetVehicleMod(vehicle, 15, 3, false)
            SetVehicleMod(vehicle, 16, 4, false)
            
            
            if model == "pol1" then
                SetVehicleExtra(vehicle, 5, 0)
            end
            
            if model == "police" then
                SetVehicleWheelType(vehicle, 2)
                SetVehicleMod(vehicle, 23, 10, false)
                SetVehicleColours(vehicle, 0, false)
                SetVehicleExtraColours(vehicle, 0, false)
            end
            
            if model == "pol7" then
                SetVehicleColours(vehicle, 0)
                SetVehicleExtraColours(vehicle, 0)
            end
            
            if model == "pol5" or model == "pol6" then
                SetVehicleExtra(vehicle, 1, -1)
            end
            
            
            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerEvent("keys:addNew", vehicle, plate)
            TriggerServerEvent('garages:addJobPlate', plate)
            SetModelAsNoLongerNeeded(hash)
            TaskWarpPedIntoVehicle(localped, vehicle, -1)
            
            SetVehicleDirtLevel(vehicle, 0)
            SetVehicleWindowTint(vehicle, 0)
            
            if livery ~= nil then
                SetVehicleLivery(vehicle, tonumber(livery))
            end
            LastVehicle = vehicle
    end)
end)