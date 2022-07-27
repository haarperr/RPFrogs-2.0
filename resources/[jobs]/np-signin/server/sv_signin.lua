RegisterNetEvent("np-signin:duty")
AddEventHandler("np-signin:duty", function(job)
    local src = source

    local currentJob = exports["np-base"]:getChar(src, "job")
    if currentJob == job then
        TriggerClientEvent("DoLongHudText", src, "You are already in service", 2)
        return
    end

    local permission = false
    local groupRank = 0

    if job == "doctor" then
        groupRank = exports["np-groups"]:getRank("ems", src)

        if groupRank >= 4  then
            permission = true
        end
    elseif job == "mayor" then
        groupRank = exports["np-groups"]:getRank("city_hall", src)

        if job == "mayor" and groupRank == 3  then
            permission = true
        end
    elseif job == "judge" or job == "district attorney" or job == "defender" then
        groupRank = exports["np-groups"]:getRank("doj", src)

        if job == "judge" and groupRank == 3  then
            permission = true
        elseif job == "district" and groupRank == 2  then
            permission = true
        elseif job == "defender" and groupRank == 1  then
            permission = true
        end
    else
        groupRank = exports["np-groups"]:getRank(job, src)

        if groupRank > 0 then
            permission = true
        end
    end

    if permission then
        TriggerEvent("np-jobs:changeJob", job, src)
    else
        TriggerClientEvent("DoLongHudText", src, "You are not whitelisted for this job", 2)
    end
end)