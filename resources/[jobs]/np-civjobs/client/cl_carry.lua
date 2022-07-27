
RegisterNetEvent('np-fishing:start')
AddEventHandler('np-fishing:start', function()
    if exports['np-inventory']:hasEnoughOfItem('fishingrod', 1) then
        TriggerEvent('DoLongHudText', 'Select A Zone', 1)
        TriggerEvent('np-civjobs:fishing_select_zone')
    else
        TriggerEvent('DoLongHudText', 'You are not equipped to go and fish come back when you are', 2)
    end
end)

RegisterNetEvent('np-fishing:stop')
AddEventHandler('np-fishing:stop', function()
    fishinglocation1active = false
    fishinglocation2active = false
    fishinglocation3active = false
    fishinglocation4active = false
    fishinglocation5active = false
    TriggerEvent('DoLongHudText', 'Clocked Out', 1)
end)

--//Start fishing with rod

RegisterNetEvent('np-fishing:start-fishing')
AddEventHandler('np-fishing:start-fishing', function()
    if poleTimer == 0 and fishinglocation1active or fishinglocation2active or fishinglocation3active or fishinglocation4active or fishinglocation5active then 
        TryToFish()
    else
        TriggerEvent('DoLongHudText', 'This isnt your zone or you are not clocked into fishing', 2)
    end
end)


DrawBusySpinner = function(text)
    SetLoadingPromptTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    ShowLoadingPrompt(3)
end

TryToFish = function()
    if IsPedSwimming(PlayerPedId()) then return TriggerEvent("DoLongHudText","You haven't quite learned how to multitask yet",2) end
    if IsPedInAnyVehicle(PlayerPedId()) then return TriggerEvent("DoLongHudText","Exit your vehicle first to start fishing!",2) end
    local waterValidated, castLocation = IsInWater()

    if waterValidated then
        local fishingRod = GenerateFishingRod(PlayerPedId())
        poleTimer = 5
        if baitTimer == 0 then
            CastBait(fishingRod, castLocation)
        end
    else
        TriggerEvent("DoLongHudText","You need to aim towards the fish!",2)
    end
end

GenerateFishingRod = function(ped)
    local pedPos = GetEntityCoords(ped)
    local fishingRodHash = `prop_fishing_rod_01`
    WaitForModel(fishingRodHash)
    rodHandle = CreateObject(fishingRodHash, pedPos, true)
    AttachEntityToEntity(rodHandle, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
    SetModelAsNoLongerNeeded(fishingRodHash)
    return rodHandle
end

WaitForModel = function(model)
    if not IsModelValid(model) then
        return
    end
    if not HasModelLoaded(model) then
        RequestModel(model)
    end
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0
                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end
                if settings["flag"] then
                    flag = settings["flag"]
                end
                if settings["playbackRate"] then

                    playbackRate = settings["playbackRate"]

                end
                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

CastBait = function(rodHandle, castLocation)
    baitTimer = 5
    local startedCasting = GetGameTimer()
    while not IsControlJustPressed(0, 47) do
        Citizen.Wait(5)
        DisableControlAction(0, 311, true)
        DisableControlAction(0, 157, true)
        DisableControlAction(0, 158, true)
        DisableControlAction(0, 160, true)
        DisableControlAction(0, 164, true)
        if GetGameTimer() - startedCasting > 5000 then
            TriggerEvent("DoLongHudText","You need to cast the bait",2)
            if DoesEntityExist(rodHandle) then
                DeleteEntity(rodHandle)
            end
            return 

        end
    end
    PlayAnimation(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", {
        ["flag"] = 48
    })
    while IsEntityPlayingAnim(PlayerPedId(), "mini@tennis", "forehand_ts_md_far", 3) do
        Citizen.Wait(0)
    end
    PlayAnimation(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", {
        ["flag"] = 11
    })   
    local startedBaiting = GetGameTimer()
    local randomBait = math.random(10000, 30000)
    DrawBusySpinner("Waiting for a fish to bite...")
    DisableControlAction(0, 311, true)
    DisableControlAction(0, 157, true)
    DisableControlAction(0, 158, true)
    DisableControlAction(0, 160, true)
    DisableControlAction(0, 164, true)
    local interupted = false
    Citizen.Wait(1000)
    while GetGameTimer() - startedBaiting < randomBait do
        Citizen.Wait(5)
        if not IsEntityPlayingAnim(PlayerPedId(), "amb@world_human_stand_fishing@idle_a", "idle_c", 3) then
            interupted = true
            break
        end
    end
    RemoveLoadingPrompt()
    if interupted then
        ClearPedTasks(PlayerPedId())
        CastBait(rodHandle, castLocation)
        return
    end

    local caughtFish = TryToCatchFish()
    local amount = math.random(1, 3)
    ClearPedTasks(PlayerPedId())
    if caughtFish then
        if amount == 1 then
            TriggerEvent("player:receiveItem",'fishingbass', math.random(1,2))
            TriggerEvent("DoLongHudText","You caught a bass!",1)
            local shark = math.random(1, 5)
            if shark == 1 then 
                TriggerEvent("player:receiveItem",'fishingshark', math.random(1,2))
                TriggerEvent("DoLongHudText","You caught a shark!",1)
            end
        elseif amount == 2 then
            TriggerEvent("player:receiveItem",'fishingsockeyesalmon', math.random(1,2))
            TriggerEvent("DoLongHudText","You caught a salmon!",1)
            local dolphin = math.random(1, 5)
            if dolphin == 1 then 
                TriggerEvent("player:receiveItem",'fishingdolphin', math.random(1,2))
                TriggerEvent("DoLongHudText","You caught a dolphin!",1)
            end
        elseif amount == 3 then
            TriggerEvent("player:receiveItem",'fishingmackerel', math.random(1,2))
            TriggerEvent("DoLongHudText","You caught a mackerel!",1)
            local shrimp = math.random(1, 5)
            if shrimp == 1 then 
                TriggerEvent("player:receiveItem",'fishingwhale', math.random(1,2))
                TriggerEvent("DoLongHudText","You caught a whale!",1)
            end
        end
    else
        TriggerEvent("DoLongHudText","The fish got loose!",2)
    end
	if DoesEntityExist(rodHandle) then
        DeleteEntity(rodHandle)
    end
    Citizen.Wait(1500)
    local rodHandle = GenerateFishingRod(PlayerPedId())
    CastBait(rodHandle, castLocation)
end

TryToCatchFish = function()
    local minigameSprites = {
        ["powerDict"] = "custom",
        ["powerName"] = "bar",
        ["tennisDict"] = "tennis",
        ["tennisName"] = "swingmetergrad"
    }

    while not HasStreamedTextureDictLoaded(minigameSprites["powerDict"]) and not HasStreamedTextureDictLoaded(minigameSprites["tennisDict"]) do
        RequestStreamedTextureDict(minigameSprites["powerDict"], false)
        RequestStreamedTextureDict(minigameSprites["tennisDict"], false)
        Citizen.Wait(5)
    end
    local swingOffset = 0.1
    local swingReversed = false
    local DrawObject = function(x, y, width, height, red, green, blue)
        DrawRect(x + (width / 2.0), y + (height / 2.0), width, height, red, green, blue, 150)
    end
    while true do
        Citizen.Wait(5)
        TriggerEvent('DoLongHudText', 'Press [E] in the green area.')
        DrawSprite(minigameSprites["powerDict"], minigameSprites["powerName"], 0.5, 0.4, 0.01, 0.2, 0.0, 255, 0, 0, 255)
        DrawObject(0.49453227, 0.3, 0.010449, 0.03, 0, 255, 0)
        DrawSprite(minigameSprites["tennisDict"], minigameSprites["tennisName"], 0.5, 0.4 + swingOffset, 0.018, 0.002, 0.0, 0, 0, 0, 255)
        if swingReversed then
            swingOffset = swingOffset - 0.001
        else
            swingOffset = swingOffset + 0.001
        end
        if swingOffset > 0.1 then
            swingReversed = true
        elseif swingOffset < -0.1 then
            swingReversed = false
        end
        if IsControlJustPressed(0, 38) then
            swingOffset = 0 - swingOffset
            extraPower = (swingOffset + 0.1) * 250 + 1.0
            if extraPower >= 45 then
                return true
            else
                return false
            end
        end
    end
    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["powerDict"])
    SetStreamedTextureDictAsNoLongerNeeded(minigameSprites["tennisDict"])
end

poleTimer = 0
baitTimer = 0

function timerCount()
    if poleTimer ~= 0 then
        poleTimer = poleTimer - 1
    end
    if baitTimer ~= 0 then
        baitTimer = baitTimer - 1
    end
    SetTimeout(1000, timerCount)
end

local rodHandle = ""
timerCount()

IsInWater = function()
    local startedCheck = GetGameTimer()
    local ped = PlayerPedId()
    local pedPos = GetEntityCoords(ped)
    local forwardVector = GetEntityForwardVector(ped)
    local forwardPos = vector3(pedPos["x"] + forwardVector["x"] * 10, pedPos["y"] + forwardVector["y"] * 10, pedPos["z"])
    local fishHash = `a_c_fish`
    WaitForModel(fishHash)
    local waterHeight = GetWaterHeight(forwardPos["x"], forwardPos["y"], forwardPos["z"])
    local fishHandle = CreatePed(1, fishHash, forwardPos, 0.0, false)
    SetEntityAlpha(fishHandle, 0, true)
    TriggerEvent("DoLongHudText","Checking Fishing Location",1)
    while GetGameTimer() - startedCheck < 3000 do
        Citizen.Wait(0)
    end
    RemoveLoadingPrompt()
    local fishInWater = IsEntityInWater(fishHandle)
    DeleteEntity(fishHandle)
    SetModelAsNoLongerNeeded(fishHash)
    TriggerEvent("DoLongHudText", "[G] - To Cast")
    return fishInWater, fishInWater and vector3(forwardPos["x"], forwardPos["y"], waterHeight) or false
end

--// Polyzones

RoyalZoneFishing1 = false
fishinglocation1active = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("fishing_zone_1", vector3(1641.0, 3881.09, 37.92), 250.6, 35.4, {
        name="fishing_zone_1",
        heading=305,
        debugPoly=false
    })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "fishing_zone_1" and fishinglocation1active then
        RoyalZoneFishing1 = true     
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "fishing_zone_1" and fishinglocation1active then
        RoyalZoneFishing1 = false  
    end
end)

-- Zone 2

RoyalZoneFishing2 = false
fishinglocation2active = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("fishing_zone_2", vector3(1306.75, 4252.16, 33.91), 75, 6.6, {
        name="fishing_zone_2",
        heading=350,
        --debugPoly=true,
        minZ=32.71,
        maxZ=36.71
    })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "fishing_zone_2" and fishinglocation2active then
        RoyalZoneFishing2 = true     
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "fishing_zone_2" and fishinglocation2active then
        RoyalZoneFishing2 = false  
    end
end)

-- Zone 3

RoyalZoneFishing3 = false
fishinglocation3active = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("fishing_zone_3", vector3(714.04, 4122.83, 35.78), 75, 67.0, {
        name="fishing_zone_3",
        heading=0,
        --debugPoly=true
    })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "fishing_zone_3" and fishinglocation3active then
        RoyalZoneFishing3 = true     
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "fishing_zone_3" and fishinglocation3active then
        RoyalZoneFishing3 = false  
    end
end)

-- Zone 4

RoyalZoneFishing4 = false
fishinglocation4active = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("fishing_zone_4", vector3(-187.49, 4139.61, 34.98), 75, 25.2, {
        name="fishing_zone_4",
        heading=320,
        --debugPoly=true
    })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "fishing_zone_4" and fishinglocation4active then
        RoyalZoneFishing4 = true     
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "fishing_zone_4" and fishinglocation4active then
        RoyalZoneFishing4 = false  
    end
end)

-- Zone 5

RoyalZoneFishing5 = false
fishinglocation5active = false

Citizen.CreateThread(function()
    exports["np-polyzone"]:AddBoxZone("fishing_zone_5", vector3(397.93, 3624.15, 33.21), 75, 19.8, {
        name="fishing_zone_5",
        heading=265,
        -- debugPoly=true,
        minZ=31.21,
        maxZ=35.21
    })
end)

RegisterNetEvent('np-polyzone:enter')
AddEventHandler('np-polyzone:enter', function(name)
    if name == "fishing_zone_5" and fishinglocation5active then
        RoyalZoneFishing5 = true     
    end
end)

RegisterNetEvent('np-polyzone:exit')
AddEventHandler('np-polyzone:exit', function(name)
    if name == "fishing_zone_5" and fishinglocation5active then
        RoyalZoneFishing5 = false  
    end
end)


--// Sell Fish

RegisterNetEvent('np-fishing:sell')
AddEventHandler('np-fishing:sell', function()
    TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Bass",
            txt = "Sell Bass",
            params = {
                event = "fishing:sell1",
            }
        },
        {
            id = 2,
            header = "Salmon",
            txt = "Sell Salmon",
            params = {
                event = "fishing:sell2",
            }
        },
        {
            id = 3,
            header = "Mackerel",
            txt = "Sell Mackerel",
            params = {
                event = "fishing:sell3",
            }
        },
        {
            id = 4,
            header = "Shark",
            txt = "Sell Shark",
            params = {
                event = "fishing:sell4",
            }
        },
        {
            id = 5,
            header = "Dolphin",
            txt = "Sell Dolphin",
            params = {
                event = "fishing:sell5",
            }
        },
        {
            id = 6,
            header = "Whale",
            txt = "Sell Whale",
            params = {
                event = "fishing:sell6",
            }
        },
    })
end)

RegisterNetEvent("fishing:sell1")
AddEventHandler("fishing:sell1", function()
	if exports["np-inventory"]:getQuantity("fishingbass") >= 1 then
		playerAnim()
        local fishToSell = exports["np-inventory"]:getAmountOfItem("fishingbass")
		local finished = exports["np-taskbar"]:taskBar(1000*fishToSell, "Selling Bass",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("fishingbass") >= 1 then
                if exports["np-inventory"]:hasEnoughOfItem("fishingbass",fishToSell,false) then
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerEvent('inventory:removeItem', 'fishingbass', fishToSell)
                    TriggerServerEvent('np-fishing:PayPlayer', 18*fishToSell)
                end
			else
                TriggerEvent('DoLongHudText', 'Might want to try again you do not have a bass in your pockets', 2)
			end
		end
	else
        TriggerEvent('DoLongHudText', 'You do not have enough bass to sell!', 2)
	end
end)

RegisterNetEvent("fishing:sell2")
AddEventHandler("fishing:sell2", function()
    if exports["np-inventory"]:getQuantity("fishingsockeyesalmon") >= 1 then
		playerAnim()
        local fishToSell = exports["np-inventory"]:getAmountOfItem("fishingsockeyesalmon")
		local finished = exports["np-taskbar"]:taskBar(1000*fishToSell, "Selling Salmon",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("fishingsockeyesalmon") >= 1 then
                if exports["np-inventory"]:hasEnoughOfItem("fishingsockeyesalmon",fishToSell,false) then
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerEvent('inventory:removeItem', 'fishingsockeyesalmon', fishToSell)
                    TriggerServerEvent('np-fishing:PayPlayer', 35*fishToSell)
                end
			else
                TriggerEvent('DoLongHudText', 'Might want to try again you do not have a salmon in your pockets', 2)
			end
		end
	else
        TriggerEvent('DoLongHudText', 'You do not have enough bass to sell!', 2)
	end
end)

RegisterNetEvent("fishing:sell3")
AddEventHandler("fishing:sell3", function()
    if exports["np-inventory"]:getQuantity("fishingmackerel") >= 1 then
		playerAnim()
        local fishToSell = exports["np-inventory"]:getAmountOfItem("fishingmackerel")
		local finished = exports["np-taskbar"]:taskBar(1500*fishToSell, "Selling Mackerel",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("fishingmackerel") >= 1 then
                if exports["np-inventory"]:hasEnoughOfItem("fishingmackerel",fishToSell,false) then
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerEvent('inventory:removeItem', 'fishingmackerel', fishToSell)
                    TriggerServerEvent('np-fishing:PayPlayer', 55*fishToSell)
                end
			else
                TriggerEvent('DoLongHudText', 'Might want to try again you do not have a mackerel in your pockets', 2)
			end
		end
	else
        TriggerEvent('DoLongHudText', 'You do not have enough mackerel to sell!', 2)
	end
end)

RegisterNetEvent("fishing:sell4")
AddEventHandler("fishing:sell4", function()
    if exports["np-inventory"]:getQuantity("fishingshark") >= 1 then
		playerAnim()
        local fishToSell = exports["np-inventory"]:getAmountOfItem("fishingshark")
		local finished = exports["np-taskbar"]:taskBar(10000*fishToSell, "Selling Shark",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("fishingshark") >= 1 then
                if exports["np-inventory"]:hasEnoughOfItem("fishingshark",fishToSell,false) then
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerEvent('inventory:removeItem', 'fishingshark', fishToSell)
                    TriggerServerEvent('np-fishing:PayPlayer', 375*fishToSell)
                end
			else
                TriggerEvent('DoLongHudText', 'Might want to try again you do not have a shark in your pockets', 2)
			end
		end
	else
        TriggerEvent('DoLongHudText', 'You do not have enough shark to sell!', 2)
	end
end)

RegisterNetEvent("fishing:sell5")
AddEventHandler("fishing:sell5", function()
    if exports["np-inventory"]:getQuantity("fishingdolphin") >= 1 then
		playerAnim()
        local fishToSell = exports["np-inventory"]:getAmountOfItem("fishingdolphin")
		local finished = exports["np-taskbar"]:taskBar(10000*fishToSell, "Selling Dolphin",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("fishingdolphin") >= 1 then
                if exports["np-inventory"]:hasEnoughOfItem("fishingdolphin",fishToSell,false) then
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerEvent('inventory:removeItem', 'fishingdolphin', fishToSell)
                    TriggerServerEvent('np-fishing:PayPlayer', 575*fishToSell)
                end
			else
                TriggerEvent('DoLongHudText', 'Might want to try again you do not have a dolphin in your pockets', 2)
			end
		end
	else
        TriggerEvent('DoLongHudText', 'You do not have enough dolphin to sell!', 2)
	end
end)

RegisterNetEvent("fishing:sell6")
AddEventHandler("fishing:sell6", function()
    if exports["np-inventory"]:getQuantity("fishingwhale") >= 1 then
		playerAnim()
        local fishToSell = exports["np-inventory"]:getAmountOfItem("fishingwhale")
		local finished = exports["np-taskbar"]:taskBar(10000*fishToSell, "Selling Whale",true,false,playerVeh)
		if finished == 100 then
			if exports["np-inventory"]:getQuantity("fishingwhale") >= 1 then
                if exports["np-inventory"]:hasEnoughOfItem("fishingwhale",fishToSell,false) then
                    ClearPedTasksImmediately(PlayerPedId())
                    TriggerEvent('inventory:removeItem', 'fishingwhale', fishToSell)
                    TriggerServerEvent('np-fishing:PayPlayer', 900*fishToSell)
                end
			else
                TriggerEvent('DoLongHudText', 'Might want to try again you do not have a whale in your pockets', 2)
			end
		end
	else
        TriggerEvent('DoLongHudText', 'You do not have enough whale to sell!', 2)
	end
end)


-- Fishing Select Zones

RegisterNetEvent('np-civjobs:fishing_select_zone')
AddEventHandler('np-civjobs:fishing_select_zone', function()
    TriggerEvent('np-context:sendMenu', {
        {
            id = 1,
            header = "Select Fishing Zone",
            txt = ""
        },
        {
            id = 2,
            header = "Fishing Zone 1",
            txt = "Sandy Shores",
            url = "https://cdn.discordapp.com/attachments/901123512503267349/918934982393737246/unknown.png",
            params = {
                event = "np-fishing:select_zone_1"
            }
        },
        {
            id = 3,
            header = "Fishing Zone 2",
            txt = "Sandy Shores",
            url = "https://cdn.discordapp.com/attachments/878754358060257320/918936121973563463/unknown.png",
            params = {
                event = "np-fishing:select_zone_2"
            }
        },
        {
            id = 4,
            header = "Fishing Zone 3",
            txt = "Sandy Shores",
            url = "https://cdn.discordapp.com/attachments/901123512503267349/918937340439822416/unknown.png",
            params = {
                event = "np-fishing:select_zone_3"
            }
        },
        {
            id = 5,
            header = "Fishing Zone 4",
            txt = "Sandy Shores",
            url = "https://cdn.discordapp.com/attachments/901123512503267349/918937816136831046/unknown.png",
            params = {
                event = "np-fishing:select_zone_4"
            }
        },
        {
            id = 6,
            header = "Fishing Zone 5",
            txt = "Sandy Shores",
            url = "https://cdn.discordapp.com/attachments/918937429422010400/918939159035531304/unknown.png",
            params = {
                event = "np-fishing:select_zone_5"
            }
        },
    })
end)

RegisterNetEvent('np-fishing:select_zone_1')
AddEventHandler('np-fishing:select_zone_1', function()
    fishinglocation1active = true
    SetNewWaypoint(1587.6922607422, 3841.8198242188)
    TriggerEvent('DoLongHudText', 'Your GPS was updated go to the area and fish', 1)
end)

RegisterNetEvent('np-fishing:select_zone_2')
AddEventHandler('np-fishing:select_zone_2', function()
    fishinglocation2active = true
    SetNewWaypoint(1311.7054443359, 4279.0419921875)
    TriggerEvent('DoLongHudText', 'Your GPS was updated go to the area and fish', 1)
end)

RegisterNetEvent('np-fishing:select_zone_3')
AddEventHandler('np-fishing:select_zone_3', function()
    fishinglocation3active = true
    SetNewWaypoint(714.23736572266, 4148.9936523438)
    TriggerEvent('DoLongHudText', 'Your GPS was updated go to the area and fish', 1)
end)

RegisterNetEvent('np-fishing:select_zone_4')
AddEventHandler('np-fishing:select_zone_4', function()
    fishinglocation4active = true
    SetNewWaypoint(-183.74505615234, 4140.6328125)
    TriggerEvent('DoLongHudText', 'Your GPS was updated go to the area and fish', 1)
end)

RegisterNetEvent('np-fishing:select_zone_5')
AddEventHandler('np-fishing:select_zone_5', function()
    fishinglocation5active = true
    SetNewWaypoint(413.43298339844, 3622.5363769531)
    TriggerEvent('DoLongHudText', 'Your GPS was updated go to the area and fish', 1)
end)