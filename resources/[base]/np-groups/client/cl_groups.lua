--[[

    Functions

]]

function GroupName(group)
    local name = "Error Retrieving Name"
    local groups = exports["np-base"]:getChar("groups")

    if type(groups) ~= "table" then
        groups = {}
    end

    for i, v in ipairs(groups) do
        if v["group"] == group then
            name = v["name"]
            break
        end
    end

    return name
end

function GroupRank(group)
    local rank = 0
    local groups = exports["np-base"]:getChar("groups")

    if type(groups) ~= "table" then
        groups = {}
    end

    for i, v in ipairs(groups) do
        if v["group"] == group then
            rank = v["rank"]
            break
        end
    end

    return rank
end

function GroupRankInfo(group, info)
    local groups = exports["np-base"]:getChar("groups")

    if type(groups) ~= "table" then
        groups = {}
    end

    for i, v in ipairs(groups) do
        if v["group"] == group then
            if v["rankinfos"] then
                if info then
                    return v["rankinfos"][info]
                else
                    return v["rankinfos"]
                end
            else
                return
            end
        end
    end

    return
end

--[[

    Exports

]]

exports("GroupName", GroupName)
exports("GroupRank", GroupRank)
exports("GroupRankInfo", GroupRankInfo)