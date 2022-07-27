Citizen.CreateThread(function()
    GetInventoryItems()
 --   GetEngineSound()
--    GetAddonVehicles()
end)

function ToggleDevMode(Bool)
    TriggerEvent('np-admin_newest:client:ToggleDevmode', Bool)
    if Bool then
        while Bool do
            Wait(200)
            SetPlayerInvincible(PlayerId(), true)
        end
        SetPlayerInvincible(PlayerId(), false)
    end
end

-- Other

function DebugLog(Message)
    if Config.MenuDebug then
        print('[DEBUG]: ', Message)
    end
end

function UpdateMenu()
    local Bans = GetBans()
    local Players = GetPlayers()
    SendNUIMessage({
        Action = 'Update',
        Bans = Bans,
        AllPlayers = Players,
        AdminItems = Config.AdminMenus,
        Favorited = Config.FavoritedItems,
        PinnedPlayers = Config.PinnedTargets,
        MenuSettings = Config.AdminSettings
    })
end

function SetKvp(Name, Data, Type)
    SetResourceKvp(Name, Data)
    RefreshMenu(Type)
end

function RefreshMenu(Type)
    if Type == 'Favorites' then
        -- Favorites
        if GetResourceKvpString("np-adminmenu-favorites") == nil or GetResourceKvpString("np-adminmenu-favorites") == "[]" then
            Config.FavoritedItems = GenerateFavorites()
            SetResourceKvp("np-adminmenu-favorites", json.encode(Config.FavoritedItems))
        else
            Config.FavoritedItems = json.decode(GetResourceKvpString("np-adminmenu-favorites"))
        end
    elseif Type == 'Targets' then
        if GetResourceKvpString("np-adminmenu-pinned_targets") == nil or GetResourceKvpString("np-adminmenu-pinned_targets") == "[]" then
            Config.PinnedTargets = GeneratePinnedPlayers()
            SetResourceKvp("np-adminmenu-pinned_targets", json.encode(Config.PinnedTargets))    
        else
            Config.PinnedTargets = json.decode(GetResourceKvpString("np-adminmenu-pinned_targets"))
        end
    elseif Type == 'Settings'then
        if GetResourceKvpString("np-adminmenu-settings") == nil or GetResourceKvpString("np-adminmenu-settings") == "[]" then
            Config.AdminSettings = GenerateAdminSettings()
            SetResourceKvp("np-adminmenu-settings", json.encode(Config.AdminSettings))
        else
            Config.AdminSettings = json.decode(GetResourceKvpString("np-adminmenu-settings"))
        end
    elseif Type == 'All' then
        if GetResourceKvpString("np-adminmenu-favorites") == nil or GetResourceKvpString("np-adminmenu-favorites") == "[]" then
            Config.FavoritedItems = GenerateFavorites()
            SetResourceKvp("np-adminmenu-favorites", json.encode(Config.FavoritedItems))
        else
            Config.FavoritedItems = json.decode(GetResourceKvpString("np-adminmenu-favorites"))
        end
        if GetResourceKvpString("np-adminmenu-pinned_targets") == nil or GetResourceKvpString("np-adminmenu-pinned_targets") == "[]" then
            Config.PinnedTargets = GeneratePinnedPlayers()
            SetResourceKvp("np-adminmenu-pinned_targets", json.encode(Config.PinnedTargets))    
        else
            Config.PinnedTargets = json.decode(GetResourceKvpString("np-adminmenu-pinned_targets"))
        end
        if GetResourceKvpString("np-adminmenu-settings") == nil or GetResourceKvpString("np-adminmenu-settings") == "[]" then
            Config.AdminSettings = GenerateAdminSettings()
            SetResourceKvp("np-adminmenu-settings", json.encode(Config.AdminSettings))
        else
            Config.AdminSettings = json.decode(GetResourceKvpString("np-adminmenu-settings"))
        end
    end
    UpdateMenu()
end

-- Get

function IsPlayerAdmin() 
    local Promise = promise:new()
    local IsAdmin = RPC.execute('np-admin_newest:getPermission')
    if not IsAdmin then
         return 
    end

    return Promise
end

function GetPlayersInArea(Coords, Radius)
	local Prom = promise:new()

    local Coords, Radius = RPC.execute("np-admin_newest:getActivePlayers")
    if not Coords or Radius then 
        return
    end

    Promise:resolve(Players)

	return Citizen.Await(Prom)
end

function GetPlayers()
    local Promise = promise:new()

    local Players = RPC.execute("np-admin_newest:getPlayers")
    if not Players then 
        return
    end

    Promise:resolve(Players)

    return Citizen.Await(Promise)
end

function GetBans()
    local Promise = promise:new()

    local Bans = RPC.execute("np-admin_newest:getBans")
    if not Bans then 
        return
    end

    Promise:resolve(Bans)

    local Bans = Citizen.Await(Promise)
    local BanList = {}

    for k, v in pairs(Bans) do
        table.insert(BanList, {
            Text = ("%s (%s)"):format(v.name, v.steam),
            Steam = v.steam,
            BanId = v.id,
        })
    end

    return BanList
end

function GetInventoryItems()
    local items = exports["np-inventory"]:getFullItemList()
    for k, v in pairs(items) do
        table.insert(Inventory, {
            Text = k
        });
    end
    return Inventory
end

--function GetJobs()
 --   local Jobs = exports["np-jobmanager"]:JobsList()
 --   local JobList = {}
 --   for k, v in pairs(Jobs) do
  --      table.insert(JobList, {
 --           Text = k,
  --          Name = ' ['..v.name..']',
   --     })
  --  end
  --  return JobList
--end

--function GetEngineSound()
 --   local soundList = RPC.execute("np-vehicleSync:GetSoundslist")
 --       for k, v in pairs(soundList) do
 --           table.insert(EngineSoundList, {
 --               Text = v,
 --               mod = ' ['..k..']',
 --           })
--        end
--    return EngineSoundList
--end


-- Generate
function GenerateFavorites()
    local Retval = {}
    for _, Menu in pairs(Config.AdminMenus) do
        for k, v in pairs(Menu.Items) do
            Retval[v.Id] = false
        end
    end
    return Retval
end

function GeneratePinnedPlayers()
    local Retval = {}
    local Players = GetPlayers()
    for k, v in pairs(Players) do
        Retval[v.License] = false
    end
    return Retval
end

function GenerateAdminSettings()
    local Retval = {}
    -- Default Size
    Retval['DefaultSize'] = "Small"
    -- Tooltips
    Retval['Tooltips'] = true
    -- Bind Open
    Retval['BindOpen'] = true

    return Retval
end

function DeletePlayerBlips()
    -- local BlipData = Mercy.Functions.GetAllBlipsData('Blips')
    -- for k, v in pairs(BlipData) do
    --     local BlipName = string.sub(k, 1, 10)
    --     if BlipName == 'admin-blip' then
    --         Mercy.Functions.RemoveBlip(k)
    --     end
    -- end
end

function DrawText3D(Coords, Text)
    local OnScreen, _X, _Y = World3dToScreen2d(Coords.x, Coords.y, Coords.z)
    SetTextScale(0.3, 0.3)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextColour(255, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(Text)
    DrawText(_X, _Y)
end

function teleportMarker()
    
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)
        
        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
            
            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)
            
            if foundGround then
                SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
                
                break
            end
            Citizen.Wait(5)
        end
    else
        TriggerEvent("DoLongHudText", 'Failed to find marker.', 2)
    end
end

-- Wild attack

local attackAnimalHashes = {
    GetHashKey("a_c_chimp"),
    GetHashKey("a_c_rottweiler"),
    GetHashKey("a_c_coyote")
}
local animalGroupHash = GetHashKey("Animal")
local playerGroupHash = GetHashKey("PLAYER")

function startWildAttack()
    -- Consts
    local playerPed = PlayerPedId()
    local animalHash = attackAnimalHashes[math.random(#attackAnimalHashes)]
    local coordsBehindPlayer = GetOffsetFromEntityInWorldCoords(playerPed, 100, -15.0, 0)
    local playerHeading = GetEntityHeading(playerPed)
    local belowGround, groundZ, vec3OnFloor = GetGroundZAndNormalFor_3dCoord(coordsBehindPlayer.x, coordsBehindPlayer.y, coordsBehindPlayer.z)

    -- Requesting model
    RequestModel(animalHash)
    while not HasModelLoaded(animalHash) do
        Wait(5)
    end
    SetModelAsNoLongerNeeded(animalHash)

    -- Creating Animal & setting player as enemy
    local animalPed = CreatePed(1, animalHash, coordsBehindPlayer.x, coordsBehindPlayer.y, groundZ, playerHeading, true, false)
    SetPedFleeAttributes(animalPed, 0, 0)
    SetPedRelationshipGroupHash(animalPed, animalGroupHash)
    TaskSetBlockingOfNonTemporaryEvents(animalPed, true)
    TaskCombatHatedTargetsAroundPed(animalPed, 30.0, 0)
    ClearPedTasks(animalPed)
    TaskPutPedDirectlyIntoMelee(animalPed, playerPed, 0.0, -1.0, 0.0, 0)
    SetRelationshipBetweenGroups(5, animalGroupHash, playerGroupHash)
    SetRelationshipBetweenGroups(5, playerGroupHash, animalGroupHash)
end

-- Drunk
local DRUNK_ANIM_SET = "move_m@drunk@verydrunk"

local DRUNK_DRIVING_EFFECTS = {
    1, -- brake
    7, --turn left + accelerate
    8, -- turn right + accelerate
    23, -- accelerate
    4, -- turn left 90 + braking
    5, -- turn right 90 + braking
}

local function getRandomDrunkCarTask()
    math.randomseed(GetGameTimer())

    return DRUNK_DRIVING_EFFECTS[math.random(#DRUNK_DRIVING_EFFECTS)]
end

-- NOTE: We might want to check if a player already has an effect
function drunkThread()
    local playerPed = PlayerPedId()
    local isDrunk = true

    RequestAnimSet(DRUNK_ANIM_SET)
    while not HasAnimSetLoaded(DRUNK_ANIM_SET) do
        Wait(5)
    end

    SetPedMovementClipset(playerPed, DRUNK_ANIM_SET)
    ShakeGameplayCam("DRUNK_SHAKE", 3.0)
    SetPedIsDrunk(playerPed, true)
    SetTransitionTimecycleModifier("spectator5", 10.00)

    CreateThread(function()
        while isDrunk do
            local vehPedIsIn = GetVehiclePedIsIn(playerPed)
            local isPedInVehicleAndDriving = (vehPedIsIn ~= 0) and (GetPedInVehicleSeat(vehPedIsIn, -1) == playerPed)

            if isPedInVehicleAndDriving then
                local randomTask = getRandomDrunkCarTask()
                TaskVehicleTempAction(playerPed, vehPedIsIn, randomTask, 500)
            end

            Wait(5000)
        end
    end)

    Wait(30 * 1000)
    isDrunk = false
    SetTransitionTimecycleModifier("default", 10.00)
    StopGameplayCamShaking(true)
    ResetPedMovementClipset(playerPed)
    RemoveAnimSet(DRUNK_ANIM_SET)
end

function GetVehicleInDirection(entFrom, coordFrom, coordTo)
    local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    
    if (IsEntityAVehicle(vehicle)) then
        return vehicle
    end
end

function DeleteGivenVehicle(veh, timeoutMax)
    local timeout = 0
    
    SetEntityAsMissionEntity(veh, true, true)
    DeleteVehicle(veh)
    
    if (DoesEntityExist(veh)) then
        TriggerEvent("DoLongHudText", "Failed to delete vehicle, trying again...")
        
        -- Fallback if the vehicle doesn't get deleted
        while (DoesEntityExist(veh) and timeout < timeoutMax) do
            DeleteVehicle(veh)
            
            -- The vehicle has been banished from the face of the Earth!
            if (not DoesEntityExist(veh)) then
                TriggerEvent("DoLongHudText", "Vehicle deleted.")
            end
            
            -- Increase the timeout counter and make the system wait
            timeout = timeout + 1
            Citizen.Wait(500)
            
            -- We've timed out and the vehicle still hasn't been deleted.
            if (DoesEntityExist(veh) and (timeout == timeoutMax - 1)) then
                TriggerEvent("DoLongHudText", "Failed.")
            end
        end
    else
        TriggerEvent("DoLongHudText", "Vehicle deleted.")
    end
end