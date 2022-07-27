--[[

    Variables

]]

local Events = {}

--[[

    Events

]]

AddEventHandler("cron:runAt", function(pH, pM, pCb)
    table.insert(Events, {
        h = pH,
        m = pM,
        cb = pCb,
    })
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(20000)

        local timestamp = os.time()

	    local h = tonumber(os.date("%H", timestamp))
	    local m = tonumber(os.date("%M", timestamp))

        for i, v in ipairs(Events) do
            if v.executed == nil and v.h == h and v.m == m then
                Events[i].executed = true
                Events[i].cb()
            end
        end
    end
end)