Conditions = {
    ["ALL"] = function(src, params, infos)
        return true
    end,
    ["JOB"] = function(src, params, infos)
        if has_value(params["jobs"], infos["job"]) then
            if params["jobrank"] then
                if infos["jobrank"] >= params["jobrank"] then
                    return true
                else
                    return false
                end
            else
                return true
            end
        else
            return false
        end
    end,
    ["ADMIN"] = function(src, params, infos)
        if infos["rank"] then
            if has_value(params, infos["rank"]) then
                return true
            else
                return false
            end
        else
            return false
        end
    end,
}