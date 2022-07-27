TriggerServerEvent("sp34r:server:blackout")

RegisterNetEvent('sp34r:client:blackout')
AddEventHandler('sp34r:client:blackout', function(blackout)
    SetArtificialLightsStateAffectsVehicles(false)
    SetArtificialLightsState(blackout)
end)

RegisterNetEvent("particle:explosion:coord")
AddEventHandler("particle:explosion:coord", function(position)
  -- local i = 0
  -- local try = {
  --   -- [6] = true,
  --   -- [9] = true,
  --   -- [15] = true,
  --   [29] = true,
  --   [37] = true,
  -- --   [49] = true,
  -- --   [50] = true,
  -- --   [59] = true,
  -- --   [60] = true,
  -- }
  -- while i < 100 do
  --   if try[i] == true then
  --     AddExplosion(position, i, 5.0, 1, 0, 1)
  --     print(i)
  --     Wait(2500)
  --   end
  --   i = i + 1
  -- end
  AddExplosion(position, 29, 5.0, 1, 0, 1, 1)
  Wait(500)
  StopFireInRange(position, 5.0)
end)
