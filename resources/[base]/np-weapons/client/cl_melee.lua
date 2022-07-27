--[[

    Variables

]]

local modifiedWeapons = {
    ["weapon_unarmed"] = 0.5,
    ["-1024456158"] = 0.25, -- BAT
    ["3638508604"] = 0.25, -- KNUCLE
    ["2343591895"] = 0.25, -- FLASHLIGHT
    ["1737195953"] = 0.25, -- NIGHTSTICK

}

local meleeEffects = {
    ["weapon_unarmed"] = "knockdownlowhp",
    ["-1024456158"] = "knockdown", -- BAT
    ["3638508604"] = "knockdown", -- KNUCLE
    ["1737195953"] = "knockdown", -- NIGHTSTICK
    ["1064738331"] = "knockdown", -- BRICK
    ["-828058162"] = "knockdownlowhp", -- SHOES
    ["-691061592"] = "knockdownlowhp", -- BOOK
}

local CrashHash = -1553120962
local FallHash = -842959696
local RamHash = 133987706
local GrenadeHash = -1813897027
local cashHash = 571920712
local RecentlyRiding = false
local IsKnockedDown = false

--[[

    Functions

]]

function DoFlashBang()
    StartScreenEffect("Dont_tazeme_bro", 0, true)
    TriggerEvent('InteractSound_CL:PlayOnOne','flashbang', 0.05)
    ShakeGameplayCam("HAND_SHAKE",2.0)
    SetRunSprintMultiplierForPlayer(PlayerId(), 0.5)
    Wait(12500)
    ShakeGameplayCam("HAND_SHAKE",0.0)
    StopScreenEffect("Dont_tazeme_bro")
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.00)
    StopGameplayCamShaking()
end

function ProcessHitByCash(pAttacker)
    TriggerServerEvent("np-weapons:attackedByCash", pAttacker)
end

function PerformEffect(effect, ped, time)
    local ped = PlayerPedId()

    if effect == "knockdown" then
        if time <= 0.0 then
            return
        end

        if not IsKnockedDown then
            IsKnockedDown = true

            Citizen.CreateThread(function()
                while IsKnockedDown do
                    SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
                    Citizen.Wait(50)
                end
            end)

            Citizen.Wait(time)

            IsKnockedDown = false
        end
    end
end

function map_range(s, a1, a2, b1, b2)
    return b1 + (s - a1) * (b2 - b1) / (a2 - a1)
end

--[[

    Events

]]

AddEventHandler("DamageEvents:EntityDamaged", function(victim, attacker, pWeapon, isMelee)
    local playerPed = PlayerPedId()

    if victim ~= playerPed then
        return
    end

    if pWeapon == GrenadeHash then
        DoFlashBang()
        return
    end

    if pWeapon == cashHash then
        ProcessHitByCash(GetPlayerServerId(NetworkGetPlayerIndexFromPed(attacker)))
        return
    end

    for weapon, effect in pairs(meleeEffects) do
        local hash = GetHashKey(weapon)

        if (pWeapon == hash or pWeapon == tostring(weapon)) and effect == "knockdown" then
            local health = GetEntityHealth(PlayerPedId())
            local time = map_range(health, 0.0, 200.0, 3000, 0)
            PerformEffect(effect, ped, time)
            break
      end

        if (pWeapon == hash or pWeapon == tostring(weapon)) and effect == "knockdownlowhp" then
            local health = GetEntityHealth(PlayerPedId())
            local time = map_range(health, 0.0, 150.0, 500, 0)
            PerformEffect("knockdown", ped, time)
            break
        end
    end
end)

--[[

    Thrads

]]

Citizen.CreateThread(function()
    for weapon, modifier in pairs(modifiedWeapons) do
        if tonumber(weapon) then
            SetWeaponDamageModifier(tonumber(weapon), modifier)
        else
            local hash = GetHashKey(weapon)
            SetWeaponDamageModifier(hash, modifier)
        end
    end

    while true do
        Wait(5000)

        SetWeaponDamageModifier(-1813897027, 0.001)

        local ped = PlayerPedId()
        local model = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))

        RecentlyRiding = ((IsThisModelABike(model) or IsThisModelAQuadbike(model) or IsThisModelABicycle(model)) and not (RecentlyRiding and IsEntityInAir(ped) and IsPedRagdoll(ped) and IsPedFalling(ped)))

        if RecentlyRiding then
            SetWeaponDamageModifier(CrashHash, 1.0)
            SetWeaponDamageModifier(FallHash, 1.0)
            SetWeaponDamageModifier(RamHash, 1.0)
        end
    end
end)