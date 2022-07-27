local activeKeypad = nil
local keypadCoords = {
    ["first_door"] = {
        coords = vector3(261.43, 223.13, 106.29),
        heading = 259.94,
    },
    ["vault_door"] = {
        coords = vector3(253.64, 228.17, 101.69),
        heading = 62.71,
    },
}
local activeEntranceDoor = nil
local entranceDoorCoords = {
    ["ground_floor"] = {
        coords = vector3(256.31155395508, 220.65788269043, 106.4295425415),
        heading = 0,
    },
    ["second_floor"] = {
        coords = vector3(266.36236572266, 217.56977844238, 110.43280792236),
        heading = 0,
    },
}

function VaultUpperCanUsePanel()
    local playerCoords = GetEntityCoords(PlayerPedId())
    for keypad, conf in pairs(keypadCoords) do
        if #(playerCoords - conf.coords) < 1.0 then
            activeKeypad = keypad
            return true
        end
    end
    activeKeypad = nil
    return false
end
function VaultUpperUsePanel(laptopId)
    local canOpen, message = RPC.execute("heists:vaultUpperDoorAttempt", activeKeypad, laptopId)
    if not canOpen then
        TriggerEvent("DoLongHudText", message, 2)
        return
    end

    if activeKeypad == "vault_door" then
        TriggerServerEvent("dispatch:svNotify", {
            dispatchCode = "10-90B",
            origin = keypadCoords[activeKeypad].coords,
        })
    end

    local active = keypadCoords[activeKeypad]
    local success = Citizen.Await(UseBankPanel(active.coords, active.heading, "vault_upper", activeKeypad == "first_door"))

    if not success then
        RPC.execute("np-heists:vaultUpperPanelFail")
        return
    end
  
    TriggerEvent("inventory:removeItemByMetaKV", "heistlaptop4", 1, "id", laptopId)

    local goldStatus = RPC.execute("heists:vaultUpperDoorOpen", activeKeypad)
    if activeKeypad ~= "vault_door" then 
      return 
    end

    Citizen.CreateThread(function()
      local trolleyNames = {
        "vault_upper_cash_1",
        "vault_upper_cash_2",
        "vault_upper_cash_3",
    }
      for _, v in pairs(trolleyNames) do
          local trolleyConfig = GetTrolleyConfig(v)
          print('hi')
          SpawnTrolley(trolleyConfig.cashCoords, goldStatus[v], trolleyConfig.cashHeading)
      end
  end)
end

AddEventHandler("heists:vaultUpperTrolleyGrab", function(loc, type)
    local canGrab = RPC.execute("np-heists:vaultUpperCanGrabTrolley", loc, type)
    if canGrab then
        Loot(type)
        TriggerEvent("DoLongHudText", "You discarded the counterfeit items", 1)
        RPC.execute("np-heists:payoutTrolleyGrab", loc, type)
    else
        TriggerEvent("DoLongHudText", "You can't do that yet...", 2)
    end
end)

local vaultUpperDoors = {
  ["vault_upper_first_door"] = true,
  ["vault_upper_inner_door_1"] = true,
  ["vault_upper_inner_door_2"] = true,
}
local bobcatSecurityDoors = {
  ["bobcat_security_entry"] = true,
  ["bobcat_security_inner_1"] = true,
}
AddEventHandler("np-inventory:itemUsed", function(item)
  if item ~= "thermitecharge" then return end
  if AttemptJewelryStoreThermite() then return end
  local locations = {
    "vault_upper_first_door",
    "vault_upper_inner_door_1",
    "vault_upper_inner_door_2",
    "bobcat_security_entry",
    "bobcat_security_inner_1",
  }
  local playerCoords = GetEntityCoords(PlayerPedId())
  local foundLoc, foundPtfx, foundRotplus = nil, nil, nil
  local foundLocationName = nil
  for _, val in pairs(locations) do
    local loc, ptfx, rotplus = ThermiteLocations(val)
    if #(playerCoords - vector3(loc.x, loc.y, loc.z)) < 1.5 then
      foundLoc = loc
      foundPtfx = ptfx
      foundRotplus = rotplus
      foundLocationName = val
    end
  end
  if not foundLoc then
    TriggerEvent("DoLongHudText", "Nothing to burn!", 2)
    return
  end
  if foundLocationName == "vault_upper_first_door" then
    local canHitVault = RPC.execute("heists:vault:canBeHit")
    if not canHitVault then
      TriggerEvent("DoLongHudText", "Door was recently hit", 2)
      return
    end
  end
  TriggerEvent("inventory:removeItem", "thermitecharge", 1)
  if vaultUpperDoors[foundLocationName] then
    TriggerServerEvent("dispatch:svNotify", {
      dispatchCode = "10-90B",
      origin = foundLoc,
    })
    local thermiteMinigameUICallbackUrl = "np-ui:heistsThermiteMinigameResult"
    local gameSettings = {
      resourceName = "np-heists",
      gameFinishedEndpoint = thermiteMinigameUICallbackUrl,
      gameTimeoutDuration = 15000,
      coloredSquares = 18,
      gridSize = 7,
    }
  end
  if bobcatSecurityDoors[foundLocationName] then
    TriggerServerEvent("dispatch:svNotify", {
      dispatchCode = "10-90F",
      origin = foundLoc,
    })
  end
  local success = Citizen.Await(ThermiteCharge(foundLoc, foundPtfx, foundRotplus, gameSettings))
  if vaultUpperDoors[foundLocationName] and success then
    RPC.execute("heists:vaultUpperDoorOpen", foundLocationName)
    TriggerServerEvent("dispatch:svNotify", {
      dispatchCode = "10-90B",
      origin = foundLoc,
    })
  end
  if bobcatSecurityDoors[foundLocationName] and success then
    RPC.execute("heists:bobcatDoorOpen", foundLocationName)
  end
end)

-- interior unloading issue
Citizen.CreateThread(function()
  local wasInVaultRoom = false
  while true do
    local idle = 2500
    local ped = PlayerPedId()
    local interior = GetInteriorFromEntity(ped)
    local roomHash = GetRoomKeyFromEntity(ped)
    if
      (interior == 139265 and roomHash == 913797866)
      or (wasInVaultRoom and interior == 0 and roomHash == 0)
    then
      CAN_GRAPPLE_HERE = false
      wasInVaultRoom = true
      idle = 100
      ForceRoomForEntity(ped, 139265, 913797866)
      ForceRoomForGameViewport(139265, 913797866)
    else
      CAN_GRAPPLE_HERE = true
      wasInVaultRoom = false
      idle = 2500
    end
    Citizen.Wait(idle)
  end
end)

-- AddEventHandler("np-inventory:itemUsed", function(item)
--   if item ~= "lockpick" then return end

--   activeEntranceDoor = nil
--   local playerCoords = GetEntityCoords(PlayerPedId())
--   for door, conf in pairs(entranceDoorCoords) do
--     if #(playerCoords - conf.coords) < 2.0 then
--       activeEntranceDoor = door
--     end
--   end
--   if activeEntranceDoor == nil then return end

--   TriggerServerEvent("dispatch:svNotify", {
--     dispatchCode = "10-90C",
--     origin = entranceDoorCoords[activeEntranceDoor].coords,
--   })

--   local skillComplete = LoopSkill(5)
--   if not skillComplete then
--     TriggerEvent("inventory:removeItem", "lockpick", 1)
--     return
--   end

--   RPC.execute("heists:vaultUpperDoorOpen", activeEntranceDoor)
-- end)
