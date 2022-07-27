--[[

    Functions

]]

function AddLog(type, ...)
    if not LOGS[type] then
        print("LOGS " .. type .. " dont exist?")
        return
    end

    LOGS[type]["FUNCTION"](type, ...)
end

--[[

    Exports

]]

exports("AddLog", AddLog)