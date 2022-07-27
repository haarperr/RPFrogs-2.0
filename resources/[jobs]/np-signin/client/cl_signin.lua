AddEventHandler("np-signin:peekAction", function(pArgs, pEntity, pContext)
    local data = pContext.zones and pContext.zones["job_sign_in"]

    if not data then return end

    exports["np-context"]:showContext(MenuData[data.job])
end)

AddEventHandler("np-signin:handler", function(params)
    if params.sign_in then
        TriggerServerEvent("np-signin:duty", params.job)
    elseif params.sign_off then
        TriggerServerEvent("np-jobs:changeJob", "unemployed")
    end
end)