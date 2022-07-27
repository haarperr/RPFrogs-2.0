--local thermiteMinigameUICallbackUrl = "ThermiteResult"
--local gameSettings = {
 -- gameFinishedEndpoint = thermiteMinigameUICallbackUrl,
 -- gameTimeoutDuration = 15000,
 -- coloredSquares = 18,
  -- = 7,
--}
 -- local electricalBoxCoords = vector3(-596.04,-283.74,50.49)
--local electricalBoxHeading = 296.8
--local electricalBoxThermite = {
 -- x = electricalBoxCoords.x,
 -- y = electricalBoxCoords.y,
--z = electricalBoxCoords.z,
---h = electricalBoxHeading,
--}

RegisterCommand('testingmini', function()
 -- exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
  function() -- success
      print("success")
  end,
  function() -- failure
      print("failure")
  end)
    Citizen.CreateThread(function()
      local success = Citizen.Await(ThermiteCharge(electricalBoxThermite, nil, 0.0, gameSettings))
      if success then
        print('hi')
      end
    end)
end)


RegisterUICallback(thermiteMinigameUICallbackUrl, function(data, cb)
    thermiteMinigameResult = data.result
    print(thermiteMinigameResult)
    print('hit hard')
    cb({ data = {}, meta = { ok = true, message = "done" } })
  end)