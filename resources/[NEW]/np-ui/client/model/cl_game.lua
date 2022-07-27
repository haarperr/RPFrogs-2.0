-- PRE SPAWN
local charSpawned = false

local pedId, plyId = PlayerPedId(), PlayerId()

function GetPed()
    return pedId
end
function GetPlayer()
    return plyId
end

Citizen.CreateThread(function()
    while not charSpawned do
        DisplayRadar(0)
        Citizen.Wait(0)
    end
end)

-- CHAR SPAWN
function getCharacterInfo()
    local characterId = exports["isPed"]:isPed("cid")
    local firstName = exports["isPed"]:isPed("firstname")
    local lastName = exports["isPed"]:isPed("lastname")
    local phoneNumber = exports["isPed"]:isPed("phone_number")

    return characterId, firstName, lastName, phoneNumber
end

function sendCharacterData()
    Citizen.CreateThread(function()
        local characterId, firstName, lastName, phoneNumber = getCharacterInfo()
        if not characterId then return end
        -- local hasBankAccount, bankAccountId = RPC.execute("GetDefaultBankAccount", characterId, true)
        local character = {
            id = characterId,
            first_name = firstName,
            job = "",
            last_name = lastName,
            number = tostring(phoneNumber),
            bank_account_id = -1,
            server_id = GetPlayerServerId(PlayerId()) -- in game session id
        }
        SendUIMessage({ source = "np-nui", app = "character", data = character });

        Citizen.Wait(5000)

        TriggerEvent('np-ui:phoneReady')
        TriggerServerEvent('np-ui:phoneReady')
    end)
end

RegisterNetEvent("np-spawn:characterSpawned")
AddEventHandler("np-spawn:characterSpawned", function()
    charSpawned = true
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        sendCharacterData()
        sendAppEvent("hud", {
            display = true,
        })
        startHealthArmorUpdates()
    end)
end)

-- DISABLE BLIND FIRING
Citizen.CreateThread(function()
    while true do
        if IsPedInCover(GetPed(), 0) and not IsPedAimingFromCover(GetPed()) then
            DisablePlayerFiring(GetPed(), true)
        end
        Citizen.Wait(0)
    end
end)

AddEventHandler("np-ui:hud:values", function(values)
  sendAppEvent("hud", {
      food = values["hunger"],
      oxygen = values["oxygen"],
      oxygenShow = values["oxygen"] ~= 25,
      stress = values["stress"],
      water = values["water"],
  })
  SendNUIMessage({
    type = "updateStatusHud",
    hasParachute = currentValues["parachute"],
    varSetHealth = currentValues["health"],
    varSetArmor = lerp(0,100, rangePercent(0,60,currentValues["armor"])),
    varSetHunger = currentValues["hunger"],
    varSetThirst = currentValues["thirst"],
    varSetOxy = currentValues["oxy"],
    varSetStress = currentValues["stress"],
    colorblind = colorblind,
    varSetVoice = currentValues["voice"],
    varDev = currentValues["dev"],
    varDevDebug = currentValues["devdebug"],
    varCrosshair = currentValues["crosshair"],
  })
  currentValues["parachute"] = HasPedGotWeapon(get_ped, `gadget_parachute`, false)
  currentValues["crosshair"] = IsPedArmed(get_ped, 7)

  if currentValues["crosshair"] then
    if GetFollowPedCamViewMode() == 4 and get_ped_veh == 0 then
      currentValues["crosshair"] = false
    end
    if get_ped_veh ~= 0 and ((GetFollowVehicleCamViewMode() ~= 4 and GetFollowPedCamViewMode() ~= 4) or not IsPedDoingDriveby(get_ped)) then
      currentValues["crosshair"] = false
    end
  end
end)
