local hackAnimDict = "anim@heists@ornate_bank@hack"
local trolleyConfig = nil
local thermiteTimeMultiplier = 1.0
local panelTimeMultiplier = 1.0

function GetTrolleyConfig(name)
    if not trolleyConfig then
        trolleyConfig = RPC.execute("heists:getTrolleySpawnConfig")
    end
    return trolleyConfig[name]
end

local function loadDicts()
    RequestAnimDict(hackAnimDict)
    RequestModel("hei_prop_hst_laptop")
    RequestModel("hei_p_m_bag_var22_arm_s")
    RequestModel("hei_prop_heist_card_hack_02")
    while not HasAnimDictLoaded(hackAnimDict)
        or not HasModelLoaded("hei_prop_hst_laptop")
        or not HasModelLoaded("hei_p_m_bag_var22_arm_s")
        or not HasModelLoaded("hei_prop_heist_card_hack_02") do
        Wait(0)
    end
end

function ChangeDoorHeading(door, toHeading, frameCount)
    Citizen.CreateThread(function()
        frameCount = frameCount or 60
        FreezeEntityPosition(door, true)
        local current = GetEntityHeading(door)
        if not current or not toHeading or math.abs(current - toHeading) < 1 then return end
        local diff = math.abs(current - toHeading)
        local degPer = diff / frameCount
        local count = 0
        SetEntityCollision(door, false, false)
        while count <= frameCount do
            count = count + 1
            if current > toHeading then
                SetEntityHeading(door, current - (degPer * count))
            else
                SetEntityHeading(door, current + (degPer * count))
            end
            Wait(0)
        end
        SetEntityHeading(door, toHeading)
        FreezeEntityPosition(door, true)
        Wait(0)
        SetEntityCollision(door, true, true)
    end)
end

exports("panelMultiplier", function (value)
  panelTimeMultiplier = value
end)

local minigameResult = nil
local minigameUICallbackUrl = "np-ui:heistsPanelMinigameResult"
RegisterUICallback(minigameUICallbackUrl, function(data, cb)
    minigameResult = data.result
    print(json.encode(data))
    cb({ data = {}, meta = { ok = true, message = "done" } })
end)
function UseBankPanel(panelCoords, panelHeading, location, withholdEmail)
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply)
    local p = promise:new()

    ClearPedTasksImmediately(ply)
    Wait(0)
    TaskGoStraightToCoord(ply, panelCoords, 2.0, -1, panelHeading)
    loadDicts()
    Wait(0)
    while GetIsTaskActive(ply, 35) do
        Wait(0)
    end
    ClearPedTasksImmediately(ply)
    Wait(0)
    SetEntityHeading(ply, panelHeading)
    Wait(0)
    TaskPlayAnimAdvanced(ply, hackAnimDict, "hack_enter", panelCoords, 0, 0, 0, 1.0, 0.0, 8300, 0, 0.3, false, false, false)
    Wait(0)
    SetEntityHeading(ply, panelHeading)
    while IsEntityPlayingAnim(ply, hackAnimDict, "hack_enter", 3) do
        Wait(0)
    end
    local laptop = CreateObject(`hei_prop_hst_laptop`, GetOffsetFromEntityInWorldCoords(ply, 0.2, 0.6, 0.0), 1, 1, 0)
    Wait(0)
    SetEntityRotation(laptop, GetEntityRotation(ply, 2), 2, true)
    PlaceObjectOnGroundProperly(laptop)
    Wait(0)
    TaskPlayAnim(ply, hackAnimDict, "hack_loop", 1.0, 0.0, -1, 1, 0, false, false, false)

    Wait(1000)

    local gameDuration = 5000
    local gameRoundsTotal = 4
    local numberOfShapes = 4
    local minigameHackExp = 10
    if location == "paleto" then
      gameRoundsTotal = 6
      numberOfShapes = 4
      gameDuration = 5000
      minigameHackExp = 100
    end
    if location == "vault_upper" then
      gameRoundsTotal = 5
      numberOfShapes = 5
      gameDuration = 5000
      minigameHackExp = 1000
    end
    if location == "vault_lower" then
      gameRoundsTotal = 6
      numberOfShapes = 6
      gameDuration = 5000
      minigameHackExp = 10000
    end
    -- local isPublic = exports['np-config']:IsPublic()
    -- if isPublic and location == "vault_lower" then
    --   gameRoundsTotal = 8
    --   numberOfShapes = 5
    --   gameDuration = 6000
    -- end
    exports["np-ui"]:openApplication("minigame-captcha", {
        gameFinishedEndpoint = minigameUICallbackUrl,
        gameDuration = gameDuration * panelTimeMultiplier,
        gameRoundsTotal = gameRoundsTotal,
        numberOfShapes = numberOfShapes,
    })

    TriggerEvent("client:newStress", true, 500)

    Citizen.CreateThread(function()
        while minigameResult == nil do
            Citizen.Wait(1000)
            -- minigameResult = true
        end
        if minigameResult and not withholdEmail then
          Citizen.CreateThread(function()
            Citizen.Wait(2500)
            TriggerEvent(
              'phone:emailReceived',
              'Dark Market',
              '#A-1001',
              'Nice! You bypassed the captcha. Give me a few moments to open the door!'
            )
          end)
        end
        if minigameResult then
          TriggerServerEvent("np-heists:hack:success", minigameHackExp)
        end
        p:resolve(minigameResult)
        minigameResult = nil
        Sync.DeleteObject(laptop)
        ClearPedTasksImmediately(ply)
    end)

    return p
end

UTK = {}
function Loot(currentgrab)
    TriggerEvent("client:newStress", true, 500)
    Grab2clear = false
    Grab3clear = false
    UTK.grabber = true
    Trolley = nil
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    if currentgrab == "cash" then
        Trolley = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, `np_prop_ch_cash_trolly_01c`, false, false, false) --GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, 269934519, false, false, false)
    else
        Trolley = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, `np_prop_gold_trolly_01c`, false, false, false)
        model = "np_prop_gold_bar_01a"
    -- elseif currentgrab == 5 then
    --     Trolley = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.0, 881130828, false, false, false)
    --     model = "ch_prop_vault_dimaondbox_01a"
    end
    local CashAppear = function()
        local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(0)
        end
        local grabobj = CreateObject(grabmodel, pedCoords, true)

        FreezeEntityPosition(grabobj, true)
        SetEntityInvincible(grabobj, true)
        SetEntityNoCollisionEntity(grabobj, ped)
        SetEntityVisible(grabobj, false, false)
        AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
        local startedGrabbing = GetGameTimer()

        Citizen.CreateThread(function()
            while GetGameTimer() - startedGrabbing < 37000 do
                Citizen.Wait(0)
                DisableControlAction(0, 73, true)
                if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
                    if not IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, true, false)
                    end
                end
                if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                        -- if currentgrab < 4 then
                        --     TriggerServerEvent("utk_oh:rewardCash")
                        -- elseif currentgrab == 4 then
                        --     TriggerServerEvent("utk_oh:rewardGold")
                        -- elseif currentgrab == 5 then
                        --     TriggerServerEvent("utk_oh:rewardDia")
                        -- end
                    end
                end
            end
            Sync.DeleteObject(grabobj)
        end)
    end
    local emptyobj = `np_prop_gold_trolly_01c_empty`

    if IsEntityPlayingAnim(Trolley, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
        return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(0)
    end
    local timeout = 1200
    while not NetworkHasControlOfEntity(Trolley) and timeout > 0 do
        Citizen.Wait(0)
        NetworkRequestControlOfEntity(Trolley)
        timeout = timeout - 1
    end
    if timeout < 0 then
      TriggerEvent('DoLongHudText', 'Could not get entity control.', 2)
      Sync.DeleteObject(Trolley)
      Wait(5000)
      return
    end
    GrabBag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    Grab1 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(ped, Grab1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(GrabBag, Grab1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    -- SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(Grab1)
    Citizen.Wait(1500)
    CashAppear()
    if not Grab2clear then
        Grab2 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
        NetworkAddEntityToSynchronisedScene(Trolley, Grab2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab2)
        Citizen.Wait(37000)
    end
    if not Grab3clear then
        Grab3 = NetworkCreateSynchronisedScene(GetEntityCoords(Trolley), GetEntityRotation(Trolley), 2, false, false, 1065353216, 0, 1.3)
        NetworkAddPedToSynchronisedScene(ped, Grab3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
        NetworkAddEntityToSynchronisedScene(GrabBag, Grab3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
        NetworkStartSynchronisedScene(Grab3)
        NewTrolley = CreateObject(emptyobj, GetEntityCoords(Trolley) + vector3(0.0, 0.0, - 0.985), true, false, false)
        SetEntityRotation(NewTrolley, GetEntityRotation(Trolley))
        Sync.DeleteObject(Trolley)
        while DoesEntityExist(Trolley) do
            Citizen.Wait(0)
            DeleteEntity(Trolley)
        end
        PlaceObjectOnGroundProperly(NewTrolley)
        SetEntityAsMissionEntity(NewTrolley, 1, 1)
        Citizen.SetTimeout(5000, function()
            Sync.DeleteObject(NewTrolley)
            while DoesEntityExist(NewTrolley) do
              Citizen.Wait(0)
              DeleteEntity(NewTrolley)
            end
        end)
    end
    Citizen.Wait(1800)
    if DoesEntityExist(GrabBag) then
        Sync.DeleteEntity(GrabBag)
    end
    -- SetPedComponentVariation(ped, 5, 45, 0, 0)
    RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
    SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
end

function LoopSkill(count)
    local loopCount = 0
    while loopCount < count do
        loopCount = loopCount + 1
        local finished = exports["np-ui"]:taskBarSkill(math.random(1000, 4000), math.random(7, 12))
        if finished ~= 100 then
            TriggerEvent("client:newStress", true, 200 * math.max(1, loopCount))
            return false
        end
        Wait(100)
    end
    TriggerEvent("client:newStress", true, 200 * loopCount)
    return true
end

-- Thermite
function ThermiteLocations(curLoc)
  local loc = { x, y, z, h }
  local ptfx
  local rotplus = 0
  if curLoc == "vault_upper_first_door" then
      loc.x = 257.40
      loc.y = 220.20
      loc.z = 106.35
      loc.h = 336.48
      ptfx = vector3(257.39, 221.20, 106.29)
  elseif curLoc == "vault_upper_inner_door_1" then
      loc.x = 252.95
      loc.y = 220.70
      loc.z = 101.76
      loc.h = 160
      ptfx = vector3(252.985, 221.70, 101.72)
      rotplus = 170.0
  elseif curLoc == "vault_upper_inner_door_2" then
      loc.x = 261.65
      loc.y = 215.60
      loc.z = 101.76
      loc.h = 252
      ptfx = vector3(261.68, 216.63, 101.75)
      rotplus = 270.0
  elseif curLoc == "bobcat_security_entry" then
      loc.x = 882.1626
      loc.y = -2258.358
      loc.z = 30.41816
      loc.h = 175.89
      ptfx = vector3(882.25,-2257.26,32.63)
  elseif curLoc == "bobcat_security_inner_1" then
      loc.x = 880.4458
      loc.y = -2264.525
      loc.z = 30.45313
      loc.h = 178.62
      ptfx = vector3(880.6,-2263.45,32.60)
  end
  return loc, ptfx, rotplus
end

exports("thermiteMultiplier", function (value)
  thermiteTimeMultiplier = value
end)

local thermiteMinigameResult = nil
local thermiteMinigameUICallbackUrl = "np-ui:heistsThermiteMinigameResult"
RegisterUICallback(thermiteMinigameUICallbackUrl, function(data, cb)
  thermiteMinigameResult = data.result
  print(thermiteMinigameResult)
  print('hit hard')
  cb({ data = {}, meta = { ok = true, message = "done" } })
end)
function ThermiteCharge(loc, ptfx, rotplus, gameSettings)
  local p = promise:new()
  Citizen.CreateThread(function()
    RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
    RequestModel("hei_p_m_bag_var22_arm_s")
    while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge") and not HasModelLoaded("hei_p_m_bag_var22_arm_s") do
      Citizen.Wait(0)
    end
    local ped = PlayerPedId()
    SetEntityHeading(ped, loc.h)
    Citizen.Wait(100)
    local rotx, roty, rotz = table.unpack(vec3(GetEntityRotation(PlayerPedId())))
    local bagscene = NetworkCreateSynchronisedScene(loc.x, loc.y, loc.z, rotx, roty, rotz + rotplus, 2, false, false, 1065353216, 0, 1.3)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), loc.x, loc.y, loc.z,  true,  true, false)
    SetEntityCollision(bag, false, true)
    NetworkAddPedToSynchronisedScene(ped, bagscene, "anim@heists@ornate_bank@thermal_charge", "thermal_charge", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, bagscene, "anim@heists@ornate_bank@thermal_charge", "bag_thermal_charge", 4.0, -8.0, 1)
    local curVar = GetPedDrawableVariation(ped, 5)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
    NetworkStartSynchronisedScene(bagscene)
    Citizen.Wait(1500)
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local bomba = CreateObject(GetHashKey("hei_prop_heist_thermite"), x, y, z + 0.2,  true,  true, true)
    SetEntityCollision(bomba, false, true)
    AttachEntityToEntity(bomba, ped, GetPedBoneIndex(ped, 28422), 0, 0, 0, 0, 0, 200.0, true, true, false, true, 1, true)
    Citizen.Wait(4000)
    DeleteObject(bag)
    if curVar > 0 then
      SetPedComponentVariation(ped, 5, curVar, 0, 0)
    end
    DetachEntity(bomba, 1, 1)
    FreezeEntityPosition(bomba, true)
    NetworkStopSynchronisedScene(bagscene)

    if gameSettings then
      gameSettings.gameTimeoutDuration = gameSettings.gameTimeoutDuration * thermiteTimeMultiplier
      exports["np-ui"]:openApplication("memorygame", gameSettings)
    else
      exports["np-ui"]:openApplication("memorygame", {
        gameFinishedEndpoint = thermiteMinigameUICallbackUrl,
        gameTimeoutDuration = 17000 * thermiteTimeMultiplier,
      })
    end

    thermiteMinigameResult = nil
    while thermiteMinigameResult == nil do
      Citizen.Wait(1000)
      -- thermiteMinigameResult = true
  
    end
    if thermiteMinigameResult then
      TriggerServerEvent("fx:ThermiteChargeEnt", NetworkGetNetworkIdFromEntity(bomba))
      TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 8.0, 8.0, 1000, 36, 1, 0, 0, 0)
      TaskPlayAnim(ped, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_loop", 8.0, 8.0, 6000, 49, 1, 0, 0, 0)
      Citizen.Wait(2000)
      ClearPedTasks(ped)
      Citizen.Wait(2000)
    end
    if thermiteMinigameResult then
      Citizen.Wait(9000)
    end
    Sync.DeleteObject(bomba)
    p:resolve(thermiteMinigameResult)
    thermiteMinigameResult = nil
  end)
  return p
end

AddEventHandler("np-ui:application-closed", function(name)
  if name ~= "memorygame" then return end
  Citizen.CreateThread(function()
    Citizen.Wait(2500)
    if thermiteMinigameResult == nil then
      thermiteMinigameResult = false
    end
  end)
end)

-- cleaning
local billsCleaningStuff = {
  ["band"] = { extra = 5, price = 300 },
  ["markedbills"] = { extra = 8, price = 250 },
  ["rollcash"] = { extra = 15, price = 30 },
}
AddEventHandler("money:clean", function(pRandomChance)
  local payment = 0
  for typ, conf in pairs(billsCleaningStuff) do
    local randomAmount = math.random(4, 12)
    local randomChance = pRandomChance and pRandomChance or 0.4
    local totalAmount = randomAmount + conf.extra
    if math.random() < randomChance and exports["np-inventory"]:hasEnoughOfItem(typ, totalAmount, false) then
      TriggerEvent("inventory:removeItem", typ, totalAmount)
      payment = payment + (conf.price * totalAmount)
      payment = payment + math.random(10, 35)
    end
  end
  if payment ~= 0 then
    TriggerServerEvent('complete:job', payment, 'a' .. tostring(math.random(1, 10)))
  end
end)

local minigamePracResult = nil
local minigamePracUICallbackUrl = "np-ui:heistsPanelMinigameResultPrac"
RegisterNUICallback(minigamePracUICallbackUrl, function(data, cb)
  minigamePracResult = data.success
  cb({ data = {}, meta = { ok = true, message = "done" } })
end)
local practiceAttempts = 0
AddEventHandler("np-inventory:itemUsed", function(item)
  if item ~= "heistlaptopprac" then return end
  -- practiceAttempts = practiceAttempts + 1
  -- if practiceAttempts == 5 then
  --   TriggerEvent("inventory:removeItem", item, 1)
  --   practiceAttempts = 0
  -- end
  exports["np-ui"]:openApplication("minigame-captcha", {
    gameFinishedEndpoint = minigamePracUICallbackUrl,
    gameDuration = 5000,
    gameRoundsTotal = 1,
    numberOfShapes = 4,
  })
  TriggerEvent("client:newStress", true, 500)
  while minigamePracResult == nil do
    Wait(1000)
  end
  if minigamePracResult then
    TriggerServerEvent("np-heists:hack:success", 1)
  end
end)

AddEventHandler("np-heists:purchasePracticeLaptop", function()
  RPC.execute("np-heists:purchasePracticeLaptop")
end)
