--[[

    Variables

]]

local Config = {
    CallCopsPercent = 5,
    randomReject = 3,
    randomRobGang = 2,
    PercentBargain = 3,
    thiefshooting = 1,
 
	
    ThiefNpc = {
        "csb_ortega",
        "csb_ramp_gang",
        "g_m_importexport_01",
        "g_m_y_famca_01",
        "g_m_y_ballaeast_01",
        "g_m_y_ballaorig_01",
        "g_m_y_ballasout_01",
        "g_m_y_famdnf_01",
        "g_m_y_famfor_01",
        "g_m_y_korean_01",
        "g_m_y_lost_01",
        "g_m_y_lost_02",
        "g_m_y_lost_03",
        "g_m_y_mexgoon_01",
        "g_m_y_mexgoon_02",
        "g_m_y_mexgoon_03",
        "g_m_y_pologoon_01",
        "g_m_y_pologoon_02",
        "g_m_y_salvaboss_01",
        "g_m_y_salvagoon_01",
        "g_m_m_armgoon_01",
    },

	BlacklistNpc = {
		-1533126372,
		-183807561,
		-1467815081,
		959218238,
		-472287501,
		-1337836896,
	}
}

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168,["F11"] = 344, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local selldrugs = false
local menuOpen = false
local commandsell = false
local selling = false
local sell = false
local checkdistance = false
local IsSell = false
local coords = {}
local bargain = true
local thief = false
local currentped = nil
local ShowingNotification = false
local SellCooldown = GetGameTimer()
local AntiSpam = GetGameTimer()

--[[

    Functions

]]

function ShowFloatingHelpNotification(msg, coords)
    AddTextEntry("FloatingHelpNotification", msg)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp("FloatingHelpNotification")
    EndTextCommandDisplayHelp(2, false, false, -1)
end

function loadDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function loaddict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function playerAnim(playerPed, animDictionary, animationName, time)
    if (DoesEntityExist(playerPed) and not IsEntityDead(playerPed)) then
        loaddict(animDictionary)
        TaskPlayAnim(playerPed, animDictionary, animationName, 8.0, -8.0, time, 49, 1, false, false, false)
    end
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

function SellDrug(ped)
	local playerPed = PlayerPedId()
	oldped = ped
	local randomCallPolice = math.random(1, Config.CallCopsPercent)
	SetEntityAsMissionEntity(oldped, true, false)

    if randomCallPolice == Config.CallCopsPercent then
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)

        Citizen.Wait(3000)

        SetPedAsNoLongerNeeded(oldped)
		playerAnim(oldped,"cellphone@","cellphone_call_listen_base", 5000)
		phone = CreateObject(GetHashKey("prop_npc_phone_02"), x, y, z+0.9,  true,  true, true)
		AttachEntityToEntity(phone, oldped, GetPedBoneIndex(oldped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

        Citizen.Wait(5000)

        DetachEntity(phone, 1, 1)
		DeleteObject(phone)

        local plyPos = GetEntityCoords(PlayerPedId(),  true)
        local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
		local player = PlayerPedId()

        if not IsPedDeadOrDying(ped) then
		    TriggerEvent('civilian:alertPolice', 8.0, 'drugsale', 0)
		end
	else
		local randomRejectPed = math.random(1, Config.randomReject)

        if randomRejectPed == Config.randomReject then
			Citizen.Wait(1200)
			SetEntityAsMissionEntity(oldped, true, false)
	        playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
        else
	        TaskGotoEntityAiming(oldped, playerPed, 0.05, 7.0)
	        local vehicle = GetVehiclePedIsIn(playerPed, false)
	        checkdistance = true
	        oldped = ped
	        selling = true
        end

        SetPedAsNoLongerNeeded(oldped)
	end
end

function SellDrugInCar(ped)
	local playerPed = PlayerPedId()
	local cars = {"Compacts", "Sedans", "SUVs", "Coupes", "Muscle", "Sport Classics", "Sports", "Super", "Motorcycle", "Off-road", "Industrial", "Utility", "Vans", "Cycles", "Boats", "Helicopters", "Planes", "Service", "Emergency", "Military", "Commercial", "Trains"}
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local vehicleClass = GetVehicleClass(vehicle)
	local vehicleStringClass = cars[vehicleClass + 1]

    oldped = ped

    playerAnim(playerPed,"rcmnigel1c","hailing_whistle_waive_a", 1000)
	SetEntityAsMissionEntity(oldped, true, false)

    local randomCallPolice = math.random(1, Config.CallCopsPercent)
	if randomCallPolice == Config.CallCopsPercent then
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)

        Citizen.Wait(1200)

        SetPedAsNoLongerNeeded(oldped)
		playerAnim(oldped,"cellphone@","cellphone_call_listen_base", 5000)
		phone = CreateObject(GetHashKey("prop_npc_phone_02"), x, y, z+0.9,  true,  true, true)
		AttachEntityToEntity(phone, oldped, GetPedBoneIndex(oldped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

        Citizen.Wait(5000)

        DetachEntity(phone, 1, 1)
		DeleteObject(phone)

        local plyPos = GetEntityCoords(PlayerPedId(),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
		local player = PlayerPedId()

        if not IsPedDeadOrDying(ped) then
		    TriggerEvent('civilian:alertPolice', 8.0, 'drugsale', 0)
		end
	else
		local randomRejectPed = math.random(1, Config.randomReject)
		if randomRejectPed == Config.randomReject then
			SetEntityAsMissionEntity(oldped, true, false)
		    playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
		    Citizen.Wait(4000)
        else
	        local vehicle = GetVehiclePedIsIn(playerPed, false)
		    SetEntityAsMissionEntity(ped, true, false)
		    TaskGotoEntityAiming(ped, playerPed, 0.2, 7.0)
		    checkdistance = true
		    selling = true
		    IsSell = true
		    oldped = ped
		end

        SetPedAsNoLongerNeeded(oldped)
	end
end

function DrugSell(ped, oldped)
	selling = true
	checkdistance = false

    local playerPed = PlayerPedId()
	local elements = {}

    if ped ~= oldped then
		oldped = ped
		IsSell = true
		TaskStandStill(ped, 100.0)
		TriggerServerEvent("np-drugs:offer", ped)
	end
end

function OfferStart(ped, item, price, labels, amount)
	SetEntityAsMissionEntity(ped, true, false)
	FreezeEntityPosition(oldped, false)
	local player = PlayerPedId()
	sell = true
	oldped = ped

    while true do
		Citizen.Wait(1)

        if sell then
			local pos = GetEntityCoords(ped)
			pos1 = GetEntityCoords(ped)
			local player = PlayerPedId()
			local playerPed = PlayerPedId()
			IsPedHeadtrackingEntity(ped, playerPed)
			local vehicle = GetVehiclePedIsIn(player, false)
			local playerloc = GetEntityCoords(player, 0)
			local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc["x"], playerloc["y"], playerloc["z"], true)

            if distance > 3 or Config.SellInCar and IsPedInVehicle(player, vehicle, true) and distance > 7 then
				sell = false
				IsSell = false
                ShowingNotification = false
                exports["np-interaction"]:hideInteraction()
				SetPedAsNoLongerNeeded(oldped)
				selling = false
				FreezeEntityPosition(ped, false)
				return
			end

            if ped ~= 0 and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then
			    if not ShowingNotification then
                    ShowingNotification = true
                    exports["np-interaction"]:showInteraction("[N] accept [L] Negotiate [G] Refuse")
                end
			    local playerX, playerY, playerZ = table.unpack(GetEntityCoords(ped))
			    ShowFloatingHelpNotification(("I'll give you " .. price .. "$ for " .. amount .. " "  .. labels), vector3(playerX, playerY, playerZ))
		    end

            if bargain == true and IsControlJustPressed(1, 182) and GetGameTimer() > SellCooldown then
		        local randomBargain = math.random(1, Config.PercentBargain)
		        if randomBargain == Config.PercentBargain then
		            price = math.floor(price * 1.05)
		            bargain = false
		        else
		            playerAnim(oldped,"gestures@m@standing@casual","gesture_no_way", 1000)
		            bargain = true
		            sell = false
		            SetPedAsNoLongerNeeded(oldped)
		            selling = false
		            FreezeEntityPosition(oldped, false)
		            IsSell = false
                    ShowingNotification = false
                    exports["np-interaction"]:hideInteraction()
		            bargain = true
		            break
	            end
            end

            if IsControlJustPressed(1, 306) and GetGameTimer() > SellCooldown then
				SellCooldown = GetGameTimer() + 60000
				SetEntityAsMissionEntity(ped)
				TaskStandStill(ped, 100.0)
				TriggerServerEvent("np-drugs:selling", item, price, amount, ped)
				selling = false
				sell = false
				IsSell = false
                ShowingNotification = false
                exports["np-interaction"]:hideInteraction()
				FreezeEntityPosition(oldped, false)
				bargain = true
				break
			elseif IsControlJustPressed(1, 113) then
				sell = false
				SetPedAsNoLongerNeeded(oldped)
				selling = false
				FreezeEntityPosition(oldped, false)
				IsSell = false
                ShowingNotification = false
                exports["np-interaction"]:hideInteraction()
				bargain = true
				break
			end
		end
	end
end

function robStart(ped, item, amount)
	while true do
		Citizen.Wait(1)

        if not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then
		    local playerheadingrob = GetEntityHeading(PlayerPedId())
			local playerlocationrob = GetEntityForwardVector(PlayerPedId())
			local playerCoordsrob = GetEntityCoords(PlayerPedId())
			local xhr, yhr, zhr   = table.unpack(playerCoordsrob + playerlocationrob * 1.0)

            SetEntityHeading(oldped, playerheadingrob+180.0)

            local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed) then
				local _veh = GetVehiclePedIsIn(playerPed, false)

                TaskLeaveVehicle(playerPed, _veh, 256)

				while IsPedInAnyVehicle(playerPed, false) do
					Citizen.Wait(0)
				end
			end

		    if IsPedArmed(playerPed, 7) then
			    ClearPedTasks(playerPed)
			    local player = PlayerPedId()
			    sell = false
			    selling = false
			    FreezeEntityPosition(ped, false)
			    ClearPedTasks(ped)
			    IsSell = false
                ShowingNotification = false
                exports["np-interaction"]:hideInteraction()
			    bargain = true
			    Citizen.Wait(2000)
			    TaskShootAtEntity(ped, player, 5000, "FIRING_PATTERN_FULL_AUTO")
			    break
		    else
		        local playerX, playerY, playerZ = table.unpack(GetEntityCoords(ped))

		        if not ShowingNotification then
                    ShowingNotification = true
                    exports["np-interaction"]:showInteraction("[N] Give [G] Run away")
                end

                ShowFloatingHelpNotification("Give me those drugs, fuck!", vector3(playerX, playerY, playerZ))

                if IsControlJustPressed(1, 306) then
				    local x,y,z = table.unpack(GetEntityCoords(playerPed))
				    playerAnim(playerPed,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
				    Citizen.Wait(1000)
				    drug = CreateObject(GetHashKey("prop_weed_bottle"), x, y, z+0.9,  true,  true, true)
				    AttachEntityToEntity(drug, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.014, 100.0, 0.0, 135.0, true, true, false, true, 1, true)
				    Citizen.Wait(1000)
				    playerAnim(playerPed,"mp_common","givetake1_a", 1800)
				    Citizen.Wait(1000)
				    DetachEntity(drug, 1, 1)
				    DeleteObject(drug)
				    TriggerServerEvent("np-drugs:robgive", item, amount)
				    FreezeEntityPosition(ped, false)
				    ClearPedTasks(ped)
				    TaskSmartFleePed(ped, playerPed, 100.0, -1, false, true)
				    Citizen.Wait(100)
				    sell = false
				    selling = false
				    IsSell = false
                    ShowingNotification = false
                    exports["np-interaction"]:hideInteraction()
				    bargain = true
				    break
			    elseif IsControlJustPressed(1, 113) then
				    local player = PlayerPedId()
				    local randomthiefshooting = math.random(1, Config.thiefshooting)

                    if randomthiefshooting == Config.thiefshooting then
					    ClearPedTasks(playerPed)
					    sell = false
					    selling = false
					    FreezeEntityPosition(ped, false)
					    ClearPedTasks(ped)
					    IsSell = false
                        ShowingNotification = false
                        exports["np-interaction"]:hideInteraction()
					    bargain = true
					    Citizen.Wait(3000)
					    TaskShootAtEntity(ped, player, 6000, "FIRING_PATTERN_FULL_AUTO")
					    Citizen.Wait(6000)
					    TaskSmartFleePed(ped, playerPed, 100.0, -1, false, true)
					    break
				    else
				        ClearPedTasks(playerPed)
				        sell = false
				        selling = false
				        IsSell = false
                        ShowingNotification = false
                        exports["np-interaction"]:hideInteraction()
				        bargain = true
				        FreezeEntityPosition(ped, false)
				        ClearPedTasks(ped)
				        Citizen.Wait(2000)
				        TaskSmartFleePed(ped, playerPed, 100.0, -1, false, true)
				        break
				    end
			    end
			end
		end
	end
end

--[[

	EXPORTS

]]

exports("isSelling", function()
	return selldrugs
end)

--[[

    Events

]]

RegisterNetEvent("np-drugs:startSell")
AddEventHandler("np-drugs:startSell", function()
    if commandsell == false then
    	commandsell = true
    	selldrugs = true
    	TriggerEvent("DoLongHudText", "you started selling.")
    else
		if thief == false and selling == false then
			oldped = ped
			TriggerEvent("DoLongHudText", "You stopped selling, wait 1 minute to start again")
			selldrugs = false
			selling = false
			sell = false
			IsSell = false
            ShowingNotification = false
            exports["np-interaction"]:hideInteraction()
			checkdistance = false
			bargain = true
			FreezeEntityPosition(oldped, false)
			SetPedAsNoLongerNeeded(oldped)
			Wait(60000)
			commandsell = false
		    return
		else
			TriggerEvent("DoLongHudText", "You cannot stop selling during this event.")
		end
	end
end)

RegisterNetEvent("np-drugs:c_startoffers")
AddEventHandler("np-drugs:c_startoffers", function(ped, item, price, labels, amount)
	for i, model in pairs(Config.ThiefNpc) do
	    if GetEntityModel(ped) == GetHashKey(model) then
		    thief = true

            local randomRobGang= math.random(1, Config.randomRobGang)

            if randomRobGang == Config.randomRobGang then
			    DecorSetBool(ped, "ScriptedPed", true)

				local playerPed = PlayerPedId()
			    thief = true
			    local playerheadingrob = GetEntityHeading(PlayerPedId())
			    local playerlocationrob = GetEntityForwardVector(PlayerPedId())
			    local playerCoordsrob = GetEntityCoords(PlayerPedId())
			    local weapon = -120179019
			    local xhr, yhr, zhr   = table.unpack(playerCoordsrob + playerlocationrob * 1.0)

                if not IsPedInAnyVehicle(playerPed, true) then
			        SetEntityCoords(ped, xhr-0.7, yhr+0.3, zhr-0.7)
			        SetEntityHeading(ped, playerheadingrob+180.0)
			    end

                Citizen.Wait(100)

                playerAnim(playerPed,"random@mugging3","handsup_standing_base", -1)
			    SetEntityAsMissionEntity(ped, true, false)
			    FreezeEntityPosition(ped, false)
			    pos = GetEntityCoords(ped, true)
			    rot = GetEntityHeading(ped)
			    SetPedCombatAttributes(ped, 46, true)
			    GiveWeaponToPed(ped, weapon, 40, false, true)
			    SetCurrentPedWeapon(ped, -120179019, true)
			    SetPedAmmo(ped, -120179019, math.random(20, 100))
			    playAnim("reaction@intimidation@1h")
			    TaskPlayAnimAdvanced(ped, "reaction@intimidation@1h", "intro", pos, 0, 0, rot, 8.0, 3.0, -1, 50, 0.325, 0, 0)

                Citizen.Wait(2000)

                playerAnim(ped,"random@countryside_gang_fight","biker_02_stickup_loop", -1)
			    robStart(ped, item, amount)
		    else
			    thief = true
			    price = math.floor(price * 1.1)
			    OfferStart(ped, item, price, labels, amount)
		    end
	    end
    end

    if thief == false then
	    OfferStart(ped, item, price, labels, amount)
	end
end)

RegisterNetEvent("np-drugs:canceloffers")
AddEventHandler("np-drugs:canceloffers", function(ped)
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	Citizen.Wait(3000)
	IsSell = false
    ShowingNotification = false
    exports["np-interaction"]:hideInteraction()
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped)
    SetPedAsNoLongerNeeded(ped)
    selling = false
end)

RegisterNetEvent("np-drugs:client:sell")
AddEventHandler("np-drugs:client:sell", function(ped)
	IsSell = true

	DecorSetBool(ped, "ScriptedPed", true)

    local player = PlayerPedId()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	local xp,yo,zp = table.unpack(GetEntityCoords(ped))
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local playerheadingsell = GetEntityHeading(PlayerPedId())
	local playerlocation = GetEntityForwardVector(PlayerPedId())
	local playerCoords = GetEntityCoords(PlayerPedId())

    if IsPedInVehicle(player, vehicle, true) then
	    playerAnim(playerPed,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
	    playerAnim(ped,"amb@world_human_smoking@male@male_a@enter","enter", 2000)

        Citizen.Wait(1000)

        drug = CreateObject(GetHashKey("prop_weed_bottle"), x, y, z+0.9,  true,  true, true)
	    AttachEntityToEntity(drug, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.014, 100.0, 0.0, 135.0, true, true, false, true, 1, true)
	    moneyped = CreateObject(GetHashKey("bkr_prop_money_sorted_01"), xp, yp, zp+0.9,  true,  true, true)
	    AttachEntityToEntity(moneyped, ped, GetPedBoneIndex(ped, 64016), 0.020, -0.05, -0.014, 100.0, 130.0, 135.0, true, true, false, true, 1, true)

        Citizen.Wait(1000)

        playerAnim(playerPed,"mp_common","givetake1_a", 1800)
	    playerAnim(ped,"mp_common","givetake1_a", 1800)

        Citizen.Wait(800)

        AttachEntityToEntity(drug, ped, GetPedBoneIndex(ped, 64016), 0.020, -0.05, -0.014, 100.0, 0.0, 135.0, true, true, false, true, 1, true)
	    AttachEntityToEntity(moneyped, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.014, 130.0, 0.0, 135.0, true, true, false, true, 1, true)

        Citizen.Wait(1000)

        DetachEntity(moneyped, 1, 1)
	    DeleteObject(moneyped)
	    DetachEntity(drug, 1, 1)
	    DeleteObject(drug)
	    SetPedAsNoLongerNeeded(oldped)
	    FreezeEntityPosition(oldped, false)
	    IsSell = false
        ShowingNotification = false
        exports["np-interaction"]:hideInteraction()
	else
	    IsSell = true
	    local xh, yh, zh   = table.unpack(playerCoords + playerlocation * 1.0)
	    SetEntityCoords(ped, xh, yh, zh-0.7)
	    SetEntityHeading(ped, playerheadingsell+210.0)

        Citizen.Wait(500)

	    FreezeEntityPosition(oldped, true)
	    playerAnim(playerPed,"amb@world_human_smoking@male@male_a@enter","enter", 2000)
	    playerAnim(ped,"amb@world_human_smoking@male@male_a@enter","enter", 2000)

	    Citizen.Wait(1000)

        drug = CreateObject(GetHashKey("prop_weed_bottle"), x, y, z+0.9,  true,  true, true)
	    AttachEntityToEntity(drug, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.014, 100.0, 0.0, 135.0, true, true, false, true, 1, true)
	    moneyped = CreateObject(GetHashKey("bkr_prop_money_sorted_01"), xp, yp, zp+0.9,  true,  true, true)
	    AttachEntityToEntity(moneyped, ped, GetPedBoneIndex(ped, 64016), 0.020, -0.05, -0.014, 50.0, 130.0, 135.0, true, true, false, true, 1, true)

	    Citizen.Wait(1000)

	    playerAnim(playerPed,"mp_common","givetake1_a", 1800)
	    playerAnim(ped,"mp_common","givetake1_a", 1800)

	    Citizen.Wait(800)

	    AttachEntityToEntity(drug, ped, GetPedBoneIndex(ped, 64016), 0.020, -0.05, -0.014, 100.0, 0.0, 135.0, true, true, false, true, 1, true)
	    AttachEntityToEntity(moneyped, playerPed, GetPedBoneIndex(playerPed, 64016), 0.020, -0.05, -0.014, 50.0, 130.0, 135.0, true, true, false, true, 1, true)

	    Citizen.Wait(1000)

        DetachEntity(moneyped, 1, 1)
		DeleteObject(moneyped)
		DetachEntity(drug, 1, 1)
		DeleteObject(drug)
		SetPedAsNoLongerNeeded(oldped)
		FreezeEntityPosition(oldped, false)
		IsSell = false
        ShowingNotification = false
        exports["np-interaction"]:hideInteraction()
	end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    while true do
		playerPed = PlayerPedId()
		coords = GetEntityCoords(PlayerPedId())
        Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

        if selldrugs then
			local handle, ped = FindFirstPed()
			repeat
				success, ped = FindNextPed(handle)

                local playerPed = PlayerPedId()
				local vehicle = GetVehiclePedIsIn(playerPed, false)
				local pos = GetEntityCoords(ped)
				local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords["x"], coords["y"], coords["z"], true)

                if DecorGetInt(ped, "NPC_ID") == 0 and not DecorExistOn(ped, "ScriptedPed") and not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) then
					local pedType = GetPedType(ped)
					local pedRelationship = GetPedRelationshipGroupHash(ped)

					if pedType ~= 28 and not IsPedAPlayer(ped) and not has_value(Config.BlacklistNpc, pedRelationship) then
						currentped = pos

                        if GetGameTimer() > SellCooldown and distance <= 3 and not selling and ped ~= playerPed and ped ~= oldped or IsPedInVehicle(playerPed, vehicle, true) and distance <= 7 and not selling and ped ~= playerPed and ped ~= oldped then
						    local playerX, playerY, playerZ = table.unpack(GetEntityCoords(ped))

                            ShowFloatingHelpNotification("~INPUT_REPLAY_ENDPOINT~ Sell", vector3(playerX, playerY, playerZ))

                            if IsControlJustPressed(1, 306) and GetGameTimer() > AntiSpam then
						        AntiSpam = GetGameTimer() + 500

								if IsPedInAnyVehicle(playerPed, true) then
							        oldped = ped
							        local playerVeh = GetVehiclePedIsIn(playerPed, false)
							        RollDownWindow(playerVeh, 0)
							        SellDrugInCar(ped)
						        else
							        thief = false
							        oldped = ped
							        SellDrug(ped)
						        end
					        end
					    end
				    end
			    end
		    until not success
            EndFindPed(handle)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

        local pos = GetEntityCoords(oldped)
		local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords["x"], coords["y"], coords["z"], true)

        if checkdistance then
			local playerPed = PlayerPedId()
			local player = PlayerPedId()

            SetEntityAsMissionEntity(oldped, true, false)
			TaskGotoEntityAiming(oldped, playerPed, 0.15, 7.0)

            if distance <= 2 then
				local playerheadingveh = GetEntityHeading(PlayerPedId())
				local playerlocationveh = GetEntityForwardVector(PlayerPedId())
				local playerCoordsveh = GetEntityCoords(PlayerPedId())
				local xhr, yhr, zhr   = table.unpack(playerCoordsveh + playerlocationveh * 1.0)

                if IsPedInVehicle(player, vehicle, true) then
				    ClearPedTasks(oldped)
				    SetPedAsNoLongerNeeded(oldped)
				    Citizen.Wait(2000)
				    SetEntityHeading(oldped, playerheadingveh+260)
				    DrugSell(oldped)
			    else
				    ClearPedTasks(oldped)
				    SetPedAsNoLongerNeeded(oldped)
				    DrugSell(oldped)
				end
			end
	    end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

        local playerPed = PlayerPedId()

		if IsSell then
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, Keys["W"], true) -- W
			DisableControlAction(0, Keys["A"], true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys["R"], true) -- Reload
			DisableControlAction(0, Keys["SPACE"], true) -- Jump
			DisableControlAction(0, Keys["Q"], true) -- Cover
			DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
			DisableControlAction(0, Keys["F"], true) -- Also "enter"?
			DisableControlAction(0, Keys["U"], true) -- Also "enter"?

			DisableControlAction(0, Keys["F1"], true) -- Disable phone
			DisableControlAction(0, Keys["F2"], true) -- Inventory
			DisableControlAction(0, Keys["F3"], true) -- Animations
			DisableControlAction(0, Keys["F6"], true) -- Job
			DisableControlAction(0, Keys["X"], true) -- Job
			DisableControlAction(0, Keys["G"], true) -- Job
			DisableControlAction(0, Keys["F11"], true) -- Job
			DisableControlAction(0, Keys["F9"], true) -- Job

			DisableControlAction(0, Keys["V"], true) -- Disable changing view
			DisableControlAction(0, Keys["C"], true) -- Disable looking behind
			DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
			DisableControlAction(2, Keys["P"], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)