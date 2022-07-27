local nightVisionActive = false
local prevPropIdx = 0
local prevPropTextureIdx = 0
local supportedModels = {
  [`mp_f_freemode_01`] = 124,
  [`mp_m_freemode_01`] = 126,
}
local nvgItems = {
  ["nightvisiongoggles"] = true,
  ["nightvisiongogglespd"] = true,
}

local myJob = "unemployed"
RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job)
    myJob = job
end)

AddEventHandler("np-inventory:itemUsed", function(item)
  if not nvgItems[item] then return end
  local sm = supportedModels[GetEntityModel(PlayerPedId())]
  if sm then
    TriggerEvent("animation:PlayAnimation", "hairtie")
    Wait(1000)
  end
  nightVisionActive = not nightVisionActive
  SetNightvision(nightVisionActive)
  if not sm then return end
  if nightVisionActive then
    prevPropIdx = GetPedPropIndex(PlayerPedId(), 0)
    prevPropTextureIdx = GetPedPropTextureIndex(PlayerPedId(), 0)
    SetPedPropIndex(PlayerPedId(), 0, sm, 0, true)
  else
    ClearPedProp(PlayerPedId(), 0)
    SetPedPropIndex(PlayerPedId(), 0, prevPropIdx, prevPropTextureIdx, true)
  end
end)

--

local grappleGunHash = 100416529
local grappleGunTintIndex = 2
local grappleGunSuppressor = `COMPONENT_AT_AR_SUPP_02`
local grappleGunEquipped = false
local shownGrappleButton = false
local grappleGunItems = {
  ["grapplegun"] = true,
  ["grapplegunpd"] = true,
}
CAN_GRAPPLE_HERE = true
AddEventHandler("np-inventory:itemUsed", function(item)
  if not grappleGunItems[item] then return end
  if item == "grapplegun" and myJob == "police" then return end
  grappleGunEquipped = not grappleGunEquipped
  if grappleGunEquipped then
    GiveWeaponToPed(PlayerPedId(), grappleGunHash, 0, 0, 1)
    GiveWeaponComponentToPed(PlayerPedId(), grappleGunHash, grappleGunSuppressor)
    SetPedWeaponTintIndex(PlayerPedId(), grappleGunHash, item ~= "grapplegun" and 5 or 2)
    SetPedAmmo(PlayerPedId(), grappleGunHash, 0)
    SetAmmoInClip(PlayerPedId(), grappleGunHash, 0)
  else
    RemoveWeaponFromPed(PlayerPedId(), grappleGunHash)
  end
  local ply = PlayerId()
  Citizen.CreateThread(function()
    while grappleGunEquipped do
      Wait(500)
      local veh = GetVehiclePedIsIn(PlayerPedId(), false)
      if (veh and veh ~= 0) or GetSelectedPedWeapon(PlayerPedId()) ~= grappleGunHash then
        grappleGunEquipped = false
        RemoveWeaponFromPed(PlayerPedId(), grappleGunHash)
      end
    end
  end)
  Citizen.CreateThread(function ()
    while grappleGunEquipped do
      local freeAiming = IsPlayerFreeAiming(ply)
      local hit, pos, _, _ = GrappleCurrentAimPoint(40)
      if not shownGrappleButton and freeAiming and hit == 1 and CAN_GRAPPLE_HERE then
        shownGrappleButton = true
        exports["np-ui"]:showInteraction("[E] Grapple!")
      elseif shownGrappleButton and ((not freeAiming) or hit ~= 1 or (not CAN_GRAPPLE_HERE)) then
        shownGrappleButton = false
        exports["np-ui"]:hideInteraction("[E] Grapple!")
      end
      Wait(250)
    end
  end)
  Citizen.CreateThread(function()
    while grappleGunEquipped do
      local freeAiming = IsPlayerFreeAiming(ply)
      if IsControlJustReleased(0, 51) and freeAiming and grappleGunEquipped and CAN_GRAPPLE_HERE then
        local hit, pos, _, _ = GrappleCurrentAimPoint(40)
        if hit == 1 then
          grappleGunEquipped = false
          -- local area = {
          --   radius = 10.0,
          --   target = GetEntityCoords(PlayerPedId()),
          --   type = 1,
          -- }
          -- local event = {
          --   server = false,
          --   inEvent = "InteractSound_CL:PlayOnOne",
          --   outEvent = "InteractSound_CL:StopLooped",
          -- }
          -- TriggerServerEvent("infinity:playSound", event, area, "grapple-shot", 0.75)
          -- Citizen.Wait(1000)
          local grapple = Grapple.new(pos, { waitTime = 1.5 })
          grapple.activate()
          Citizen.Wait(1000)
          RemoveWeaponFromPed(PlayerPedId(), grappleGunHash)
          TriggerEvent("inventory:DegenLastUsedItem", 25)
          shownGrappleButton = false
          exports["np-ui"]:hideInteraction("[E] Grapple!")
        end
      end
      Citizen.Wait(0)
    end
  end)
end)

--
RegisterNUICallback("np-ui:heists:casinoSecurityCase", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = "done" } })
  TriggerEvent("DoLongHudText", "Access Code incorrect", 2)
end)
AddEventHandler("np-inventory:itemUsed", function(item)
  if item ~= "casinoblueprintscase" then return end
  exports['np-ui']:openApplication('textbox', {
    callbackUrl = 'np-ui:heists:casinoSecurityCase',
    key = "1",
    items = {
      {
        icon = "user-secret",
        label = "Access Code",
        name = "code",
      },
    },
    show = true,
  })
end)
