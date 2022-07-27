-- --[[

--     Variables

-- ]]

-- local INPUT_AIM = 0
-- local INPUT_AIM = 0
-- local UseFPS = false
-- local justpressed = 0
-- local disable = 0

-- --[[

--     Threads

-- ]]

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)


--         if IsControlPressed(0, INPUT_AIM) then
--             justpressed = justpressed + 1
--         end

--         if IsControlJustReleased(0, INPUT_AIM) then
--         	if justpressed < 15 then
--         		UseFPS = true
--         	end

--             justpressed = 0
--         end

--         if GetFollowPedCamViewMode() == 1 or GetFollowVehicleCamViewMode() == 1 then
--         	Citizen.Wait(1)
--         	SetFollowPedCamViewMode(0)
--         	SetFollowVehicleCamViewMode(0)
--         end


--         if UseFPS then
--         	if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(4)
--         		SetFollowVehicleCamViewMode(4)
--         	else
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(0)
--         		SetFollowVehicleCamViewMode(0)
--         	end

--             UseFPS = false
--         end


--         if IsPedArmed(ped,1) or not IsPedArmed(ped,7) then
--             if IsControlJustPressed(0, 24) or IsControlJustPressed(0, 141) or IsControlJustPressed(0, 142) or IsControlJustPressed(0, 140)  then
--                disable = 50
--             end
--         end

--         if disable > 0 then
--             disable = disable - 1

--             DisableControlAction(0, 24)
--             DisableControlAction(0, 140)
--             DisableControlAction(0, 141)
--             DisableControlAction(0, 142)
--         end
--     end
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)

--         if IsPedArmed(PlayerPedId(), 6) then
--             DisableControlAction(1, 140, true)
--             DisableControlAction(1, 141, true)
--             DisableControlAction(1, 142, true)
--         end
--     end
-- end)

-- local UseFPS = false
-- local UseNear = false
-- local UseMed = false
-- local UseFar = false
-- local justpressed = 0
-- local disable = 0

-- --create a script that cycles through the fivem camera modes
-- Citizen.CreateThread(function ()
--     while true do
--         Citizen.Wait(0)

--         if IsControlPressed(0, INPUT_AIM) then
--             justpressed = justpressed + 1
--         end

--         if IsControlJustReleased(0, INPUT_AIM) then
--             if justpressed == 1 then
--                 UseFPS = true
--             end
--             if justpressed == 2 then
--                 UseNear = true
--             end
--             if justpressed == 3 then
--                 UseMed = true
--             end
--             if justpressed == 4 then
--                 UseFar = true
--             end

--             justpressed = 0
--         end

--         if UseFPS then
--         	if GetFollowPedCamViewMode() == 2 or GetFollowVehicleCamViewMode() == 2 then
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(4)
--         		SetFollowVehicleCamViewMode(4)
--                 justpressed = 1
--                 Citizen.Trace("Set Follow Ped Cam View Mode to First Person\n")
--         	else
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(0)
--         		SetFollowVehicleCamViewMode(0)
--                 Citizen.Trace("Error: Set Follow Ped Cam View Mode to First Person\n")
--         	end

--             UseFPS = false
--         end

--         if UseNear then
--         	if GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4 then
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(0)
--         		SetFollowVehicleCamViewMode(0)
--                 justpressed = 2
--                 Citizen.Trace("Set Follow Ped Cam View Mode to Near\n")
--         	else
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(0)
--         		SetFollowVehicleCamViewMode(0)
--                 Citizen.Trace("Error: Set Follow Ped Cam View Mode to First Person\n")
--         	end

--             UseNear = false
--         end

--         if UseMed then
--         	if GetFollowPedCamViewMode() == 0 or GetFollowVehicleCamViewMode() == 0 then
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(1)
--         		SetFollowVehicleCamViewMode(1)
--                 justpressed = 3
--                 Citizen.Trace("Set Follow Ped Cam View Mode to Medium\n")
--         	else
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(0)
--         		SetFollowVehicleCamViewMode(0)
--                 Citizen.Trace("Error: Set Follow Ped Cam View Mode to First Person\n")
--         	end

--             UseMed = false
--         end

--         if UseFar then
--         	if GetFollowPedCamViewMode() == 1 or GetFollowVehicleCamViewMode() == 1 then
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(2)
--         		SetFollowVehicleCamViewMode(2)
--                 justpressed = 4
--                 Citizen.Trace("Set Follow Ped Cam View Mode to Far\n")
--         	else
--         		Citizen.Wait(0)

--         		SetFollowPedCamViewMode(0)
--         		SetFollowVehicleCamViewMode(0)
--                 Citizen.Trace("Error: Set Follow Ped Cam View Mode to First Person\n")
--         	end

--             UseFar = false
--         end

--         if justpressed == 5 then
--             justpressed = 0
--         end

--         if IsPedArmed(ped,1) or not IsPedArmed(ped,7) then
--             if IsControlJustPressed(0, 24) or IsControlJustPressed(0, 141) or IsControlJustPressed(0, 142) or IsControlJustPressed(0, 140)  then
--                disable = 50
--             end
--         end

--         if disable > 0 then
--             disable = disable - 1

--             DisableControlAction(0, 24)
--             DisableControlAction(0, 140)
--             DisableControlAction(0, 141)
--             DisableControlAction(0, 142)
--         end
--     end    
-- end)

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(0)

--         if IsPedArmed(PlayerPedId(), 6) then
--             DisableControlAction(1, 140, true)
--             DisableControlAction(1, 141, true)
--             DisableControlAction(1, 142, true)
--         end
--     end
-- end)

