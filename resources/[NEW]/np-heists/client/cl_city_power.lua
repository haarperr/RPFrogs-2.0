local powerPanelHash = -1094431857
local powerPanelCoords = vector3(712.336, 166.227, 79.75325)
local isPowerOut = false
local inPlant = false
local inGeneratorSpot = false

AddEventHandler("np:target:changed", function(pEntity, pEntityType)
    if not pEntity then
        return
    end
    local model = GetEntityModel(pEntity)
    if model == powerPanelHash and #(powerPanelCoords - GetEntityCoords(PlayerPedId())) < 3.0 then
        print(IsExplosionInArea(2, powerPanelCoords))
        TriggerEvent("DoLongHudText", "Be a real shame if this exploded...", 1, 2500)
    end
end)

local entranceDoorCoords = {
    ["front_door"] = {
        coords = vector3(735.1982421875, 132.41223144531, 80.906539916992),
        heading = 0,
    },
}
AddEventHandler("np-inventory:itemUsed", function(item)
    if item ~= "lockpick" then return end
    activeEntranceDoor = nil
    local playerCoords = GetEntityCoords(PlayerPedId())
    for door, conf in pairs(entranceDoorCoords) do
        if #(playerCoords - conf.coords) < 1.0 then
            activeEntranceDoor = door
        end
    end
    if activeEntranceDoor == nil then return end

    
    TriggerServerEvent("dispatch:svNotify", {
        dispatchCode = "10-37",
        origin = entranceDoorCoords[activeEntranceDoor].coords,
    })

    local skillComplete = LoopSkill(5)
    if not skillComplete then
        TriggerEvent("inventory:removeItem", "lockpick", 1)
        return
    end

    RPC.execute("np-heists:cityPowerDoorOpen", activeEntranceDoor)
end)


RegisterNetEvent('np-heists:checkThings')
AddEventHandler('np-heists:checkThings', function()
    Citizen.CreateThread(function()
        while inPlant do
            Citizen.Wait(1)
            -- print(IsExplosionInArea(2, powerPanelCoords))
            local explosion = IsExplosionInRadius(powerPanelCoords.x, powerPanelCoords.y, powerPanelCoords.z, 10)
            if explosion then
                -- print('hoe ass bitch ', explosion)
                -- print('hi')
                RPC.execute('np-heists:cityPowerExplosion')
                break
            end
        end
    end)
end)

RegisterNetEvent('np-heists:addExplosion')
AddEventHandler('np-heists:addExplosion', function(coords)
    for k,v in pairs(coords) do
        Explosion(v, 29, 10.0, true, false, true)
        Citizen.Wait(300)
    end
end)


IsExplosionInRadius = (function(x, y, z, radius)
    local coords = {x = x + radius, y = y + radius, z = z + radius}
    local _coords = {x = x - radius, y = y - radius, z = z - radius}
    return IsExplosionActiveInArea(-1, coords.x, coords.y, coords.z, _coords.x, _coords.y, _coords.z)
end)

Explosion = (function(coords, explosionType, damage, audible, invisble, shake)
    AddExplosion(coords, explosionType, damage, audible, invisible, shake)
end)

RegisterNetEvent("sv-heists:cityPowerState", function(pIsPowerOn)
  print('sup hoe')
  isPowerOut = not pIsPowerOn
  TriggerEvent("weather:blackout", true)
  if not isPowerOut then print('not working') return end
  if not inGeneratorSpot then print('not working2') return end
  Wait(1000)
  print('hi')
  TriggerEvent("chatMessage", "^2[State Alert]", {100, 100, 100}, "Power outage detected. Backup generators will enable momentarily.")
  Wait(3500)
  for i = 1, 5 do
    Citizen.Wait(200)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS")
  end
  TriggerEvent("weather:blackout", false)
end)

AddEventHandler("np-polyzone:enter", function(pZone)
    print('hi')
  if pZone ~= "power_generator" then return end
  inGeneratorSpot = true
  if not isPowerOut then return end
  TriggerEvent("weather:blackout", false)
end)
AddEventHandler("np-polyzone:exit", function(pZone)
  if pZone ~= "power_generator" then return end
  inGeneratorSpot = false
  if not isPowerOut then return end
  TriggerEvent("weather:blackout", true)
end)


AddEventHandler("np-polyzone:enter", function(pZone)
  print('hi')
if pZone ~= "powerplant" then return end
inPlant = true
TriggerEvent('np-heists:checkThings')
end)
AddEventHandler("np-polyzone:exit", function(pZone)
if pZone ~= "powerplant" then return end
inPlant = false
end)

Citizen.CreateThread(function()
  RPC.execute("np-casino:getCurrentInteriorSetName")
  local data = RPC.execute("np-heists:getVaultLowerState")
  isPowerOut = not data.cityPowerState
  print('testing')
  TriggerEvent("weather:blackout", false)
end)

Citizen.CreateThread(function()
  -- hospital
  exports["np-polyzone"]:AddBoxZone("power_generator", vector3(333.23, -585.39, 43.28), 45.4, 62.8, {
    heading=339,
    minZ=41.88,
    maxZ=45.68,
  })
  -- mrpd
  exports["np-polyzone"]:AddBoxZone("power_generator", vector3(455.67, -992.97, 30.68), 50.0, 65.0, {
    heading=0,
    minZ=16.68,
    maxZ=43.88,
  })

  exports["np-polyzone"]:AddBoxZone("powerplant", vector3(717.39, 139.71, 80.75), 59.6, 71.0, {
    name="powerplant",
    heading=340,
  })


  -- court house
  exports["np-polyzone"]:AddPolyZone("power_generator", {
    vector2(-506.07803344727, -201.79862976074),
    vector2(-517.03790283203, -208.71363830566),
    vector2(-521.68615722656, -199.80276489258),
    vector2(-524.96588134766, -193.96635437012),
    vector2(-536.9501953125, -196.93641662598),
    vector2(-572.33013916016, -217.36175537109),
    vector2(-581.67498779297, -201.17190551758),
    vector2(-565.53167724609, -189.98175048828),
    vector2(-547.07885742188, -179.37126159668),
    vector2(-521.140625, -164.91171264648),
    vector2(-515.97747802734, -173.89521789551),
    vector2(-511.50854492188, -182.61334228516),
    vector2(-516.35174560547, -185.52281188965),
  }, {})
  -- prison
  exports["np-polyzone"]:AddPolyZone("power_generator", {
    vector2(1778.1744384766, 2503.4338378906),
    vector2(1762.9940185547, 2501.5783691406),
    vector2(1741.4533691406, 2489.1787109375),
    vector2(1739.9338378906, 2482.9553222656),
    vector2(1749.7613525391, 2466.5795898438),
    vector2(1774.8541259766, 2481.033203125),
    vector2(1785.3967285156, 2492.5827636719),
  }, {})

  -- Hades
  exports["np-polyzone"]:AddPolyZone("power_generator", {
    vector2(-821.05737304688, 259.58108520508),
    vector2(-814.60864257812, 242.36331176758),
    vector2(-804.69018554688, 243.87649536133),
    vector2(-805.27575683594, 267.29306030273),
    vector2(-819.13610839844, 269.33633422852),
    vector2(-819.60180664062, 266.56787109375),
    vector2(-836.17895507812, 269.31958007812),
    vector2(-838.66845703125, 256.46215820312),
    vector2(-818.04449462891, 253.46583557129)
  }, {})
end)
