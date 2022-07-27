


ControlForPursuitMode = 172	

local defaultHash, defaultHash2, defaultHash3, defaultHash4, defaultHash5 = "npolchal","npolvette","npolstang","polchar","npolvic"

local pursuitEnabled = false

local InPursuitModeAPlus = false

local InPursuitModeB = false

--     Citizen.CreateThread(function()
--         while true do
--             Citizen.Wait(0)
--             local ped = PlayerPedId()
--             if pursuitEnabled == true or InPursuitModeAPlus == true or InPursuitModeB == true then
--                 if not IsPedInAnyVehicle(ped, true) or IsPlayerDead(PlayerId()) then
--                     pursuitEnabled = false
--                     InPursuitModeAPlus = false
--                     InPursuitModeB = false
                    
--                     SelectedPursuitMode = SelectedPursuitMode
--                     SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
-- 				else
--     end
-- end
-- end
-- end)


	 -- [START]   Events for different modes


	RegisterNetEvent("police:Ghost:Pursuit:Mode:A") -- This is the first pursuit mdoe 
	AddEventHandler("police:Ghost:Pursuit:Mode:A",function()
		local ped = PlayerPedId()
		if (IsPedInAnyVehicle(PlayerPedId(), true)) then
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
			local Driver = GetPedInVehicleSeat(veh, -1)
			local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
			local First = 'A +'
		   if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)
		   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
					SetVehicleModKit(veh, 0)
					SetVehicleMod(veh, 46, 4, true)
					SetVehicleMod(veh, 11, 4, true)
					SetVehicleMod(veh, 12, 4, false)-- Disable if interceptors too fast lol ~ghost
					SetVehicleMod(veh, 13, 4, false)  -- Disable if interceptors too fast lol ~ghost
					ToggleVehicleMod(veh,  18, false)          
                    print('Ghost : Display Icon')
                    TriggerEvent('PursuitModeIcon:Enable:A+') -- Turns on pursuit mode icon on HUD 
					TriggerEvent('DoLongHudText', 'New Mode : ' ..First)
					PursuitEnabled = true
					SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.3970000)
					SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

                    SelectedPursuitMode = 35
                    SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
				else
                    print(First)
					TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
				end
		end
		end)



RegisterNetEvent("police:Ghost:Pursuit:B:Plus") -- Second Pursuit Mode
AddEventHandler("police:Ghost:Pursuit:B:Plus",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode1 = 'B +'
        
       if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)  -- Vehicle Checks
	   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
                SetVehicleModKit(veh, 0)
                SetVehicleMod(veh, 46, 4, true)
				SetVehicleMod(veh, 11, 4, true)
				SetVehicleMod(veh, 12, 4, true)-- Disable if interceptors too fast lol ~ghost
				SetVehicleMod(veh, 13, 4, true)  -- Disable if interceptors too fast lol ~ghost
                ToggleVehicleMod(veh,  18, true)          
                TriggerEvent('PursuitModeIcon:Enable:B+') -- Turns on pursuit mode icon on HUD 
				TriggerEvent('DoLongHudText', 'New Mode : ' ..mode1)
				PursuitEnabled = true
                SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4270000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.000000)

                SelectedPursuitMode = 50
                SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
            else
                print(mode1)
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
    end
    end)

	
RegisterNetEvent("police:Ghost:Pursuit:SPlusMode")  -- Final Pursuit Mode for now anyways 0_o
AddEventHandler("police:Ghost:Pursuit:SPlusMode",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		local mode2 = 'S +'
        
       if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3)  -- Vehicle Checks
	   or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
                SetVehicleModKit(veh, 0)
                SetVehicleMod(veh, 46, 4, true)
				SetVehicleMod(veh, 11, 4, true)
				SetVehicleMod(veh, 12, 4, true)-- Disable if interceptors too fast lol ~ghost
				SetVehicleMod(veh, 13, 4, true)  -- Disable if interceptors too fast lol ~ghost
                ToggleVehicleMod(veh,  18, true)          
                TriggerEvent('PursuitModeIcon:Enable:S+') -- Turns on pursuit mode icon on HUD
				TriggerEvent('DoLongHudText', 'New Mode : ' ..mode2)
				PursuitEnabled = true
                SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.4970000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 1.100000)

                SelectedPursuitMode = 100
                SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
            else
                print(mode2)
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
    end
    end)




	

RegisterNetEvent("police:pursuitmodeOff")
AddEventHandler("police:pursuitmodeOff",function()
    local ped = PlayerPedId()
	if (IsPedInAnyVehicle(PlayerPedId(), true)) then
		local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
		local Driver = GetPedInVehicleSeat(veh, -1)
        local fInitialDriveForce = GetVehicleHandlingFloat(veh, 'CHandlingData', 'fInitialDriveForce')
		if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
            print('Pursuit Disabled?')
               TriggerEvent('PursuitModeIcon:Disable')
               SetVehicleModKit(veh, 0)
               SetVehicleMod(veh, 46, 4, false)
			   SetVehicleMod(veh, 13, 4, false)
			   SetVehicleMod(veh, 12, 4, false)
			   SetVehicleMod(veh, 11, 4, false)
               ToggleVehicleMod(veh,  18, false)

				TriggerEvent("DoLongHudText","Pursuit Mode Disabled",2 )                
				InPursuitModeAPlus = false
                pursuitEnabled = false
                InPursuitModeB = false
				SetVehicleHandlingField(veh, 'CHandlingData', 'fInitialDriveForce', 0.305000)
				SetVehicleHandlingField(veh, 'CHandlingData', 'fDriveInertia', 0.850000)
                SelectedPursuitMode = 0
                SendNUIMessage({action = "pursuitmode", pursuitmode = SelectedPursuitMode})
            else
                TriggerEvent('DoLongHudText', 'You are not in a HEAT vehicle',2)
            end
        end
        end)


	 -- [END]   Events for different modes



	 Citizen.CreateThread( function() -- By ghost no NP code here : )
		while true do 
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)  
			if IsPedSittingInAnyVehicle(ped) and IsVehicleModel(veh,defaultHash) or IsVehicleModel(veh,defaultHash2) or IsVehicleModel(veh,defaultHash3) or IsVehicleModel(veh,defaultHash4) or IsVehicleModel(veh,defaultHash5) and exports["isPed"]:GroupRank("heat") >= 1 then
				if (IsDisabledControlJustPressed(0, ControlForPursuitMode)) and InPursuitModeAPlus == false then 
					if (not IsPauseMenuActive()) then 
					if exports["isPed"]:GroupRank("heat") >= 1 then
						if pursuitEnabled == false then
							pursuitEnabled = true
							TriggerEvent('police:Ghost:Pursuit:Mode:A')
							print(json.encode('Key pressed actiavte A+ Mode'))
	
	
							while pursuitEnabled == true do
								Citizen.Wait(15)
								if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
									print(json.encode('Already In A+ Mode New mode :   B +'))
									InPursuitModeAPlus = true
                                    pursuitEnabled = false
									TriggerEvent('police:Ghost:Pursuit:B:Plus') -- Event does not exist yet make one
	
								while InPursuitModeAPlus == true do 
									Citizen.Wait(15)
									if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
									InPursuitModeB = true
                                    InPursuitModeAPlus = false
									print(json.encode('Already In B Plus Mode New mode :   S +'))
									TriggerEvent('police:Ghost:Pursuit:SPlusMode') -- Event does not exist yet make one
	
									
									while InPursuitModeB == true do 
										Citizen.Wait(15)
										if (not IsPauseMenuActive()) and (IsDisabledControlJustPressed(0, ControlForPursuitMode)) then 
										 print(json.encode('Key pressed : Resetting back to default car handling'))
                                         InPursuitModeAPlus = false
                                         TriggerEvent('police:pursuitmodeOff')
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	end
	end
	end)