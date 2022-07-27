--[[

    Functions

]]

function Apart.FindCurrentRoom(roomType)
    local name = ""

    if roomType == 1 then
        name = "np_apartments_room"
    elseif roomType == 2 then
        name = "v_int_16_mid"
    elseif roomType == 3 then
        name = "v_int_16_high"
    elseif roomType == 111 then
        name = "v_int_72_l"
    end

    return name
end

function Apart.FindApartmentGivenNumber(roomNumberSent)
    local roomType = 0
    local roomNumber = 0
    Apart.plyCoords = GetEntityCoords(PlayerPedId())

    for i=1,3 do
        if type(Apart.Locations[i]) == type(vector3(0.0,0.0,0.0)) then
            if #(Apart.Locations[i]-Apart.plyCoords) < 9.0 then
                roomType = i
            end
        else
            local dist = 3
            for k,v in pairs(Apart.Locations[i]) do
                local d = #(v-Apart.plyCoords)
                if d < 2.0 and d < dist then
                    dist = d
                    roomNumber = k
                    roomType = i
                end
            end
            if roomNumber ~= 0 then break end
        end
    end

    if roomType == 0 then
        TriggerEvent("DoLongHudText","Invalid location",2)
        return false,false
    else
        if roomNumberSent == 0 or roomNumberSent == nil then
            if roomNumber == 0 then
                TriggerEvent("DoLongHudText","Invalid input given , add a room number to enter",2)
                return false,false
            else
                --print("entering Found room : "..roomNumber.." of type "..roomType)
                return roomNumber,roomType
            end
        else
            roomNumber = roomNumberSent
            --print("entering room with number: "..roomNumber.." of type "..roomType)
            return roomNumber,roomType
        end
    end

    return false,false
end




