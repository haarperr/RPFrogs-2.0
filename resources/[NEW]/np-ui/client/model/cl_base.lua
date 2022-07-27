-- CLOSE APP
function SetUIFocus(hasKeyboard, hasMouse)
--  HasNuiFocus = hasKeyboard or hasMouse

  SetNuiFocus(hasKeyboard, hasMouse)

  -- TriggerEvent("np-voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
  -- TriggerEvent("np-binds:should-execute", not HasNuiFocus)
end

exports('SetUIFocus', SetUIFocus)

RegisterNUICallback("np-ui:closeApp", function(data, cb)
    SetUIFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

RegisterNUICallback("np-ui:applicationClosed", function(data, cb)
    TriggerEvent("np-ui:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

-- FORCE CLOSE
RegisterCommand("np-ui:force-close", function()
    SendUIMessage({source = "np-nui", app = "", show = false});
    SetUIFocus(false, false)
end, false)



local function restartUI(withMsg)
  SendUIMessage({ source = "np-nui", app = "main", action = "restart" });
  if withMsg then
    TriggerEvent("DoLongHudText", "You can also use 'ui-r' as a shorter version to restart!")
  end
  Wait(5000)
  SendUIMessage({ app = "hud", data = { display = true }, source = "np-nui" })
  local cj = exports["police"]:getCurrentJob()
  if cj ~= "unemployed" then
    TriggerEvent("np-jobmanager:playerBecameJob", cj)
  end
end
RegisterCommand("np-ui:restart", function() restartUI(true) end, false)
RegisterCommand("ui-r", function() restartUI() end, false)
RegisterNetEvent("np-ui:server-restart")
AddEventHandler("np-ui:server-restart", restartUI)

RegisterCommand("np-ui:debug:show", function()
    SendUIMessage({ source = "np-nui", app = "debuglogs", data = { display = true } });
end, false)

RegisterCommand("np-ui:debug:hide", function()
    SendUIMessage({ source = "np-nui", app = "debuglogs", data = { display = false } });
end, false)

RegisterNUICallback("np-ui:resetApp", function(data, cb)
    SetUIFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    sendCharacterData()
end)

RegisterNetEvent("np-ui:server-relay")
AddEventHandler("np-ui:server-relay", function(data)
    SendUIMessage(data)
end)

RegisterNetEvent("isJudge")
AddEventHandler("isJudge", function()
  sendAppEvent("character", { job = "judge" })
end)

RegisterNetEvent("isJudgeOff")
AddEventHandler("isJudgeOff", function()
  sendAppEvent("character", { job = nil })
end)

RegisterNetEvent("np-jobmanager:playerBecameJob")
AddEventHandler("np-jobmanager:playerBecameJob", function(job)
  sendAppEvent("character", { job = job })
end)



RegisterNUICallback("np-ui:targetSelectOption", function(data, cb)
  cb({ data = {}, meta = { ok = true, message = 'done' } })

  IsPeeking = false

  exports["np-ui"]:closeApplication("eye")

  Wait(100)

  local option = data.option
  local context = data.context or {}

  local event = option.event
  local target = data.entity or 0
  local parameters = option.parameters or {}

  TriggerEvent(event, parameters, target, context)
end)