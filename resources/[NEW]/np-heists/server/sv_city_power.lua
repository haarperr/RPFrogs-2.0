CITY_POWER = true

COORDS = {
    [1] = vector3(700.40032958984, 165.79875183105, 80.950309753418),
    [2] = vector3(695.56195068359, 157.2021484375, 80.940277099609),
    [3] = vector3(694.6591796875, 148.23721313477, 80.956382751465),
    [4] = vector3(690.22113037109, 141.39617919922, 80.937797546387),
    [5] = vector3(685.00756835938, 124.48017120361, 80.950202941895),
    [6] = vector3(680.41333007813, 115.71054840088, 80.937759399414),
    [7] = vector3(678.99896240234, 106.57964324951, 80.914260864258),
    [8] = vector3(709.06201171875, 126.04109954834, 80.904342651367) 
}

RPC.register("np-heists:cityPowerDoorOpen",function(pSource,pDoor)
    print('hi2')
    TriggerClientEvent('np-doors:change-lock-state', -1, pDoor, false)
end)

RPC.register("np-heists:cityPowerExplosion", function(pSource)
    TriggerClientEvent('np-heists:addExplosion', -1, COORDS)
    CITY_POWER = false
    TriggerClientEvent('sv-heists:cityPowerState', -1, CITY_POWER)
    TriggerClientEvent('np-heists:cityPowerState', -1, CITY_POWER)
    TriggerClientEvent("chatMessage", -1, "^2[LS Water & Power]", {100, 100, 100}, "City power is currently out, we're working on restoring it!")
end)