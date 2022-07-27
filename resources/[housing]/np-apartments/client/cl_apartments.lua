--[[

    Variables

]]

Apart.currentRoomType = 1
Apart.currentRoomNumber = 1
Apart.defaultInfo = {Apart.currentRoomType,Apart.currentRoomNumber}
Apart.currentHotelInformation = nil
Apart.currentGarageNumber = 0

Apart.currentRoomLocks = {[1] = {},[2] = {},[3] = {}}
Apart.currentRoomLockDown = {[1] = {},[2] = {},[3] = {}}
Apart.plyCoords = nil

Apart.ClosestLocksObject = {}
Apart.Marker = false

local typeVector = type(vector3(0.0,0.0,0.0))

--[[

    Functions

]]

function Apart.buildSelfPoly()
    local inf = Apart.defaultInfo
    createZone(inf[1],inf[2])
    Apart.buildUnlocked()
end

function Apart.buildUnlocked()
    destroyAllLockedZones()
    createNewUnlockZones()
end

function Apart.enterMotel(roomNumber, roomType, isSpawn)
    local myjob = exports["np-base"]:getChar("job")

    if not isSpawn then
        TriggerEvent("dooranim")
        TriggerEvent("InteractSound_CL:PlayOnOne","DoorOpen", 0.7)
    end

    if roomNumber == nil then
        roomNumber = Apart.currentRoomNumber
        roomType = Apart.currentRoomType
    else
        Apart.currentRoomNumber = roomNumber
        Apart.currentRoomType = roomType
    end

    if not Apart.currentRoomLocks[roomType][roomNumber] and Apart.currentRoomLockDown[roomType][roomNumber] then
        if exports["np-jobs"]:getJob(myjob, "is_police") and myjob ~= "judge" then
            TriggerEvent("DoLongHudText", "Apartment on lockdown , only Police or DOJ may enter", 2)
            return
        end
    end

    local info = RPC.execute("GetMotelInformation", Apart.currentRoomType, Apart.currentRoomNumber)
    Apart.currentHotelInformation = info
    Apart.processBuildType(roomNumber,roomType,isSpawn)
end

function Apart.processBuildType(numMultiplier, roomType, isSpawn)
    DoScreenFadeOut(1)

    TriggerEvent("insideShell", true)

    local name = ""
    name = Apart.FindCurrentRoom(roomType)

    local isBuiltCoords = exports["np-build"]:getModule("func").buildRoom(name, numMultiplier, false)
    if isBuiltCoords then
        --DoScreenFadeIn(100)
        SetEntityInvincible(PlayerPedId(), false)
        FreezeEntityPosition(PlayerPedId(), false)

        if isSpawn then
            Apart.WakeFromBed()
        else
            TriggerEvent("InteractSound_CL:PlayOnOne", "DoorClose", 0.7)
        end

        DoScreenFadeIn(500)
    end
end

function Apart.WakeFromBed()
    local bedOffset = exports["np-build"]:getModule("func").getCurrentBed()
    if bedOffset ~= false then
        SetEntityCoords(PlayerPedId(), bedOffset.x, bedOffset.y, bedOffset.z-0.9)
        SetEntityHeading(PlayerPedId(), bedOffset.w+90)
        TriggerEvent("animation:PlayAnimation", "getup")
    end
end

function Apart.leaveApartment()
    TriggerEvent("dooranim")
    TriggerEvent("InteractSound_CL:PlayOnOne","DoorOpen", 0.7)

    Wait(330)

    if Apart.exitPoint[Apart.currentRoomType] == nil then
        exports["np-build"]:getModule("func").exitCurrentRoom(Apart.Locations[Apart.currentRoomType][Apart.currentRoomNumber])
    else
        if type(Apart.exitPoint[Apart.currentRoomType]) == typeVector then
            exports["np-build"]:getModule("func").exitCurrentRoom(Apart.exitPoint[Apart.currentRoomType])
        else
            local rnd = math.random(1,#Apart.exitPoint[Apart.currentRoomType])
            exports["np-build"]:getModule("func").exitCurrentRoom(Apart.exitPoint[Apart.currentRoomType][rnd])
        end
    end

    if type(Apart.Locations[Apart.currentRoomType]) == typeVector then

    else

    end

    Apart.currentRoomNumber = Apart.defaultInfo[2]
    Apart.currentRoomType = Apart.defaultInfo[1]
    Apart.currentHotelInformation = nil

    Citizen.Wait(100)

    TriggerEvent("dooranim")
    TriggerEvent("InteractSound_CL:PlayOnOne","DoorClose", 0.7)
end

function Apart.openHotelStash()
    local myjob = exports["np-base"]:getChar("job")
    if Apart.currentRoomLockDown[Apart.currentRoomType][Apart.currentRoomNumber] and (not exports["np-jobs"]:getJob(myjob, "is_police") and myjob ~= "judge") then
        TriggerEvent("DoLongHudText", "Apartment on lockdown , you may not open the stash", 2)
        return
    end

    if Apart.defaultInfo[1] == Apart.currentRoomType and Apart.defaultInfo[2] == Apart.currentRoomNumber then -- owner
        Apart.OpenStash()
    else -- not owner kek
        if Apart.currentRoomLockDown[Apart.currentRoomType][Apart.currentRoomNumber] and (exports["np-jobs"]:getJob(myjob, "is_police") or myjob == "judge") then
            Apart.OpenStash()
        end
    end
end

function Apart.OpenStash()
    local cid = exports["np-base"]:getChar("id")

    TriggerEvent("InteractSound_CL:PlayOnOne","StashOpen", 0.6)
    TriggerEvent("server-inventory-open", "1", "motel" .. Apart.currentHotelInformation.type .. "-" .. cid)
    TriggerEvent("actionbar:setEmptyHanded")
end

function Apart.logout()
    TransitionToBlurred(500)
    DoScreenFadeOut(500)
    Citizen.Wait(1000)
    exports["np-build"]:getModule("func").CleanUpArea()
    Citizen.Wait(1000)
    TriggerEvent("np-login:switchCharacter")

    Citizen.Wait(1000)
end

--[[

    Events

]]

RegisterNetEvent("apartments:apartmentSpawn")
AddEventHandler("apartments:apartmentSpawn", function(roomType, currentID)
    Apart.currentRoomType = roomType
    Apart.currentRoomNumber = currentID
    Apart.defaultInfo = {
        Apart.currentRoomType,
        Apart.currentRoomNumber,
    }
    Apart.buildSelfPoly()
end)

RegisterNetEvent("apartments:spawnIntoRoom")
AddEventHandler("apartments:spawnIntoRoom", function()
    Apart.enterMotel(nil, nil, true)
end)

RegisterNetEvent("apartments:enterMotel")
AddEventHandler("apartments:enterMotel", Apart.enterMotel)

RegisterNetEvent("apartments:leave")
AddEventHandler("apartments:leave", Apart.leaveApartment)

RegisterNetEvent("apartments:stash")
AddEventHandler("apartments:stash", Apart.openHotelStash)

RegisterNetEvent("apartments:Logout")
AddEventHandler("apartments:Logout", Apart.logout)

--[[

    Threads

]]

Citizen.CreateThread(function()
    -- TriggerServerEvent("apartment:serverApartmentSpawn",1,false)
    -- DoScreenFadeIn(1)
    -- Wait(3000)
    -- TriggerEvent("apartments:spawnIntoRoom",false)

    while true do
        Citizen.Wait(1)
        Apart.plyCoords = GetEntityCoords(PlayerPedId())
        Wait(2000)
    end
end)






























































function Apart.displayMarkers(isDisplaying)
    if not isDisplaying then Apart.Marker = false return end
    if Apart.Marker then return end
    if isDisplaying then Apart.Marker = true end

    local ownApartmentCoords = Apart.Locations[1][1]

    if type(Apart.Locations[Apart.defaultInfo[1]]) == typeVector then
        ownApartmentCoords = Apart.Locations[Apart.defaultInfo[1]]
    else
        ownApartmentCoords = Apart.Locations[Apart.defaultInfo[1]][Apart.defaultInfo[2]]
    end

    Citizen.CreateThread(function()
        while Apart.Marker do
            Apart.plyCoords = GetEntityCoords(PlayerPedId())
            local dist = #(ownApartmentCoords-Apart.plyCoords)
            if dist <= 20 then
                DrawMarker(20,ownApartmentCoords, 0, 0, 0, 0, 0, 0, 0.701,1.0001,0.3001, 0, 155, 255, 200, 0, 0, 0, 0)
            end

            for i=1,#Apart.currentRoomLocks do
                if type(Apart.currentRoomLocks[i]) ~= typeVector then
                    for k,v in pairs(Apart.currentRoomLocks[i]) do
                        if v == false and k ~= Apart.currentRoomNumber then
                            local dist = #(Apart.Locations[i][k]-Apart.plyCoords)
                            if dist <= 20 then
                                DrawMarker(20,Apart.Locations[i][k], 0, 0, 0, 0, 0, 0, 0.701,1.0001,0.3001, 255, 100, 100, 40, 0, 0, 0, 0)
                            end
                        end
                    end
                end
            end
            Wait(0)
        end
    end)
end

RegisterNetEvent("np-binds:keyEvent")
AddEventHandler("np-binds:keyEvent", function(name,onDown)
    if name ~= "PlayerList" then return end
    Apart.displayMarkers(onDown)
end)





function Apart.locksMotel()
    if Apart.currentRoomLockDown[Apart.currentRoomType][Apart.currentRoomNumber] then
        TriggerEvent("DoLongHudText","Apartment on lockdown , you may not change the lock",2)
        return
    end

    TriggerEvent("dooranim")
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 3.0, "keydoors", 0.4)
    TriggerServerEvent("apartments:ToggleLocks",Apart.currentRoomType,Apart.currentRoomNumber)
    Citizen.Wait(500)
end

RegisterNetEvent("apartments:locksMotel")
AddEventHandler("apartments:locksMotel", Apart.locksMotel)

--[[
    Functions below: Client update functions
    Description: below is logic for entering / exiting the motel
]]



RegisterNetEvent("apartments:apartmentLocks")
AddEventHandler("apartments:apartmentLocks", function(lockTable)
    Apart.currentRoomLocks = lockTable
    Apart.buildUnlocked()
end)

RegisterNetEvent("apartments:apartmentLockDown")
AddEventHandler("apartments:apartmentLockDown", function(lockdownTable)
    Apart.currentRoomLockDown = lockdownTable
end)










function leaveToGarage()

    TriggerEvent("dooranim")
    TriggerEvent("InteractSound_CL:PlayOnOne","DoorOpen", 0.7)
    Wait(330)

    exports["np-build"]:getModule("func").CleanUpArea()
    DoScreenFadeOut(1)

    Apart.currentGarageNumber = Apart.currentRoomNumber

    Apart.processBuildType(Apart.currentGarageNumber,111)

end

RegisterNetEvent("apartments:garage")
AddEventHandler("apartments:garage", leaveToGarage)


function garageToHouse()
    exports["np-build"]:getModule("func").CleanUpArea()
    Apart.processBuildType(Apart.currentGarageNumber,3)
    Apart.currentGarageNumber = 0
end

RegisterNetEvent("apartments:garageToHouse")
AddEventHandler("apartments:garageToHouse", garageToHouse)

function garageToWorld()

    exports["np-build"]:getModule("func").exitCurrentRoom(vector3(4.67, -724.85, 32.18))
    Apart.currentRoomNumber = Apart.defaultInfo[2]
    Apart.currentRoomType = Apart.defaultInfo[1]
    Apart.currentHotelInformation = nil
    Apart.currentGarageNumber = 0

    TriggerEvent("attachWeapons")
end

RegisterNetEvent("apartments:garageToWorld")
AddEventHandler("apartments:garageToWorld", garageToWorld)





--[[
    Functions below: Raid and /commands
    Description: events to handle /commands
]]


RegisterNetEvent("apartment:removeFromBuilding")
AddEventHandler("apartment:removeFromBuilding", function(roomNumber,buildType)
    if Apart.currentRoomType == buildType and Apart.currentRoomNumber == roomNumber then
        if exports["np-build"]:getModule("func").isInBuilding() then
            Apart.leaveApartment()
        end
    end
end)

RegisterNetEvent("apartment:attemptEntry")
AddEventHandler("apartment:attemptEntry", function(roomNumberSent)
    local roomNumber,roomType = Apart.FindApartmentGivenNumber(roomNumberSent)

    if not roomNumber and not roomType then return end

    local isValid = RPC.execute("IsValidRoom",roomType,roomNumber)

    if isValid then
        if Apart.currentRoomLocks[roomType][roomNumber] == false then
            Apart.enterMotel(roomNumber,roomType)
        else
            TriggerEvent("DoLongHudText","Apartamento está trancado",2)
        end
    end

end)


AddEventHandler("np-apartments:handler", function(data, cb)
    local eventData = data.key
    if eventData.forclose then
        Apart.func.getOwner(true)
    end
    cb({ data = {}, meta = { ok = true, message = "done" } })
end)


RegisterNetEvent("apartments:menuAction")
AddEventHandler("apartments:menuAction", function(action)
    if action == "lockdown" then
        TriggerEvent("apartment:lockdown")
    elseif action == "checkOwner" then
        Apart.func.getOwner()
    elseif action == "forfeit" then
        exports["np-context"]:showContext(MenuData["apartment_check"])
    end

end)

RegisterNetEvent("apartment:lockdown")
AddEventHandler("apartment:lockdown", function(roomNumberSent)
    local roomNumber,roomType = Apart.FindApartmentGivenNumber(roomNumberSent)

    if not roomNumber and not roomType then return end

    TriggerServerEvent("apartment:serverLockdown",roomNumber,roomType)

end)


RegisterNetEvent("apartment:ringBell")
AddEventHandler("apartment:ringBell", function(roomNumberSent)

    local roomNumber,roomType = Apart.FindApartmentGivenNumber(roomNumberSent)

    if not roomNumber and not roomType then return end

    local isValid = RPC.execute("IsValidRoom",roomType,roomNumber)

    if isValid then
        -- ring bell , need to talk with DW

    end

end)



function Apart.func.currentApartment()
    local result = ""
    if Apart.MaxRooms[Apart.defaultInfo[1]] == false then
        local coords = Apart.Locations[Apart.defaultInfo[1]][Apart.defaultInfo[2]]
        local streetName , crossingRoad = GetStreetNameAtCoord(coords.x,coords.y,coords.z)
        result = ""..GetStreetNameFromHashKey(streetName).." "..GetStreetNameFromHashKey(crossingRoad)
    end

    if Apart.MaxRooms[Apart.defaultInfo[1]] ~= false then
        result = Apart.info[Apart.defaultInfo[1]].apartmentStreet
    end

    local info = {
        roomType = Apart.defaultInfo[1],
        roomNumber = Apart.defaultInfo[2],
        streetName = result
    }

    return info
end


function Apart.func.upgradeApartment(apartmentTargetType)
    if apartmentTargetType <= Apart.defaultInfo[1] then return false, "Cannot downgrade" end
    if apartmentTargetType > #Apart.info then return false, "Not a valid Apartment" end
    local apartmentInfo = RPC.execute("getApartmentInformation")
    if apartmentInfo == nil then return false, "Failed to gather info" end

    local hasBankAccount, bankAccountId = RPC.execute("GetDefaultBankAccount", exports["np-base"]:getChar("id"))

    if hasBankAccount then
        local comment = "Upgraded from apartment type ["..Apart.defaultInfo[1].."] to apartment type ["..apartmentTargetType.."]"
        local success, message = RPC.execute("DoTransaction", bankAccountId, 1 , apartmentInfo[apartmentTargetType].apartmentPrice, comment, 1, 1)

        if success then

            local isComplete = RPC.execute("upgradeApartment",apartmentTargetType,Apart.defaultInfo[1],Apart.defaultInfo[2])
            local info = Apart.func.currentApartment()

            return isComplete, info
        else
            return false, message
        end
    else
        return false, "Failed to find bank account"
    end
end

function Apart.func.gpsApartment(housingName)



    local result = ""
    local coordsEnd = nil
    local found = false

    for i,_ in pairs(Apart.MaxRooms) do
        if Apart.MaxRooms[i] == false and not found then
            for k,v in pairs(Apart.Locations[i]) do
                local coords = v
                local streetName , crossingRoad = GetStreetNameAtCoord(coords.x,coords.y,coords.z)
                result = ""..GetStreetNameFromHashKey(streetName).." "..GetStreetNameFromHashKey(crossingRoad)
                if housingName == result then

                    coordsEnd = coords
                    found = true
                    break
                end
            end

            if Apart.info[i].apartmentStreet == housingName then
                found = true
                coordsEnd = Apart.Locations[i][1]
            end


        elseif Apart.MaxRooms[i] ~= false then
            result = Apart.info[i].apartmentStreet
            if housingName == result then
                found = true
                coordsEnd = Apart.Locations[i]
            end
        end
        if found then break end
    end

    if coordsEnd ~= nil and found then
        SetNewWaypoint(coordsEnd.x,coordsEnd.y)
    end

end


function Apart.func.getOwner(isForclose)
    local roomNumber,roomType = Apart.FindApartmentGivenNumber(roomNumberSent)

    if not roomNumber and not roomType then return end

    local isValid = RPC.execute("IsValidRoom",roomType,roomNumber)

    if isValid then
        if isForclose then
            RPC.execute("apartment:forclose",roomType,roomNumber)
        else
            RPC.execute("apartment:getOwner",roomType,roomNumber)
        end
    end
end
