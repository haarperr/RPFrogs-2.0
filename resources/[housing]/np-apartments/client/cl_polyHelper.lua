--[[

    Variables

]]

Apart.poly = {}
Apart.poly.zones = {[1] = {},[2] = {},[3] = {}}
Apart.poly.DefaultLength = 1.4
Apart.poly.DefaultWidth = 1.4
local listening = false
local typeVector = type(vector3(0.0,0.0,0.0))
local globalLocNumber = nil
local globalNumber = nil

--[[

    Functions

]]

function createZone(apartmentLocNumber,apartmentNumber)
    local options = {heading = 340, minZ = 0.0, maxZ = 0.0, data = {}}
    options.data = {
        LocNumber = apartmentLocNumber,
        apartmentNum = apartmentNumber
    }

    local boxCenter = Apart.Locations[1][1]

    local length = Apart.poly.DefaultLength
    local width = Apart.poly.DefaultWidth

    if type(Apart.Locations[apartmentLocNumber]) == typeVector then
        boxCenter = Apart.Locations[apartmentLocNumber]
        length = 2.5
        width = 2.5
    else
        boxCenter = Apart.Locations[apartmentLocNumber][apartmentNumber]
    end

    options.minZ = boxCenter.z-1.0
    options.maxZ = boxCenter.z+1.0

    local zone = BoxZone:Create(boxCenter, length, width, options)

    zone:onPlayerInOut(function(isPointInside, point,moreData)
        if not isPointInside then
            polyHelperExit(zone.data.LocNumber,zone.data.apartmentNum)
        else
            polyHelperEnter(zone.data.LocNumber,zone.data.apartmentNum)
        end
    end, 500)

    Apart.poly.zones[apartmentLocNumber][apartmentNumber] = zone

end

function polyHelperExit(apartmentLocNumber,apartmentNumber)
    listening = false
    exports["np-interaction"]:hideInteraction()
end

function polyHelperEnter(apartmentLocNumber,apartmentNumber)
    if listening then return end
    listening = true
    -- exports["np-interaction"]:showInteraction(getInteractionMessage(apartmentLocNumber,apartmentNumber))
    exports["np-interaction"]:showInteraction("[H] Enter")
    listen(apartmentLocNumber,apartmentNumber)
end

function listen(apartmentLocNumber,apartmentNumber)
    Citizen.CreateThread(function()
        while listening do
            globalLocNumber = apartmentLocNumber
            globalNumber = apartmentNumber
            Wait(0)
        end

        globalLocNumber = nil
        globalNumber = nil
    end)
end

function getInteractionMessage(apartmentLocNumber,apartmentNumber)
    if apartmentLocNumber == Apart.currentRoomType and apartmentNumber == Apart.currentRoomNumber then
        if Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] then
            return "[H] Enter; [G] for more."
        else
            return "[H] Enter; [G] for more."
        end
    end

    if Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] ~= nil and Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] == false then
        return "[H] Enter"
    end
end

function destroyAllLockedZones()
    for i=1,#Apart.currentRoomLocks do
        if type(Apart.currentRoomLocks[i]) ~= typeVector then
            for k,v in pairs(Apart.poly.zones[i]) do
                local pass = true
                if i == Apart.currentRoomType and k == Apart.currentRoomNumber then pass = false end

                if Apart.currentRoomLocks[i][k] and pass then
                    v:destroy()
                    Apart.poly.zones[i][k] = nil
                end
            end
        end
    end
end

function createNewUnlockZones()
    for i=1,#Apart.currentRoomLocks do
        if type(Apart.currentRoomLocks[i]) ~= typeVector then
            for k,v in pairs(Apart.currentRoomLocks[i]) do
                if Apart.poly.zones[i][k] == nil then
                    if not Apart.currentRoomLocks[i][k] then
                        createZone(i,k)
                    end
                end
            end
        end
    end
end

--[[

    Events

]]

RegisterNetEvent("np-binds:keyEvent")
AddEventHandler("np-binds:keyEvent", function(name,onDown)
    if onDown then return end
    if not listening then return end

    -- if name == "housingSecondary" then
    --     if apartmentLocNumber == Apart.currentRoomType and apartmentNumber == Apart.currentRoomNumber then
    --         Apart.locksMotel(apartmentLocNumber,apartmentNumber)
    --         exports["np-interaction"]:hideInteraction()
    --         exports["np-interaction"]:showInteraction(getInteractionMessage(apartmentLocNumber,apartmentNumber))
    --     end
    -- end

    if name == "housingMain" then
        listening = false
        exports["np-interaction"]:hideInteraction()
        TriggerEvent("apartments:enterMotel",apartmentNumber, apartmentLocNumber)
    end
end)