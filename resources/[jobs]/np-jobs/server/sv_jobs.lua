--[[

    Events

]]

RegisterNetEvent("np-jobs:changeJob")
AddEventHandler("np-jobs:changeJob", function(job, _src)
    if not job or not JOBS[job] then return end

    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local currentjob = exports["np-base"]:getChar(src, "job")
    if currentjob == job then return end

    MySQL.update.await([[
        UPDATE characters
        SET job = ?
        WHERE id = ?
    ]],
    { job, cid })

    exports["np-base"]:setChar(src, "job", job)
    TriggerClientEvent("np-base:setChar", src, "job", job)

    TriggerClientEvent("np-jobs:jobChanged", src, job)
    TriggerEvent("np-chat:buildCommands", src)

    TriggerClientEvent("DoLongHudText", src, job ~= "unemployed" and "10-41 and Restocked: " .. jobName(job) or "Showing you 10-42")
end)

RegisterNetEvent("np-jobs:paycheck")
AddEventHandler("np-jobs:paycheck", function(log, amount, _src)
    local src = source

    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local tax = exports["np-financials"]:priceWithTax(amount, "Income")

    exports["np-financials"]:updateBalance(2, "+", amount - tax["tax"])
    exports["np-financials"]:addTax("Income", tax["tax"])

    MySQL.update.await([[
        UPDATE characters
        SET paycheck = paycheck + ?
        WHERE id = ?
    ]],
    { amount - tax["tax"], cid })

    TriggerClientEvent("DoLongHudText", src, "Your paycheck of $" .. amount .. " with $" .. tax["tax"] .. " in taxes was deposited in the bank.")
end)

RegisterNetEvent("np-jobs:paycheckPickup")
AddEventHandler("np-jobs:paycheckPickup", function()
    local src = source

    local src = source
    if _src then src = _src end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local paycheck = MySQL.scalar.await([[
        SELECT paycheck
        FROM characters
        WHERE id = ?
    ]],
    { cid })

    if paycheck and paycheck > 0 then
        local accountId = exports["np-base"]:getChar(src, "bankid")
        local success, message = exports["np-financials"]:transaction(2, accountId, paycheck, "Payslip", 0, 4)
        if not success then
            TriggerClientEvent("DoLongHudText", src, message)
            return
        end

        MySQL.update.await([[
            UPDATE characters
            SET paycheck = 0
            WHERE id = ?
        ]],
        { cid })

        TriggerClientEvent("DoLongHudText", src, "Your paycheck of $" .. paycheck .. " has been transferred to your account.")
    else
        TriggerClientEvent("DoLongHudText", src, "You don't have a paycheck!", 2)
    end
end)

RegisterNetEvent("SpawnEventsServer")
AddEventHandler("SpawnEventsServer", function()
    local src = source

    local job = exports["np-base"]:getChar(src, "job")
    if not job then return end

    TriggerClientEvent("np-jobs:jobChanged", src, job)
    TriggerEvent("np-chat:buildCommands", src)
end)

--[[

    RPCs

]]

RPC.register("np-jobs:getJobs", function(src)
    return JOBS
end)

RPC.register("np-jobs:count", function(src, job)
    return exports["np-base"]:JobCount(job)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    local _jobs = MySQL.query.await([[
        SELECT *
        FROM jobs
    ]])

    for i, v in ipairs(_jobs) do
        JOBS[v.job] = v
    end
end)