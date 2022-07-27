AddEventHandler("np-evidence:analyze", function(pParameters, pEntity, pContext)
    if pParameters.actionId == 1 then
        TriggerEvent("inventory-open-container", "analyze_evidence", 1, 1)
    elseif pParameters.actionId == 2 then
        TriggerEvent("dpemotes:e", {"parkingmeter"})
        local finished = exports["np-taskbar"]:taskBar(15000, "Analyzing")
        TriggerEvent("dpemotes:e", {"c"})
        if finished == 100 then
            TriggerServerEvent("np-evidence:analyze")
        end
    end
end)

AddEventHandler("np-evidence:dnaSwab", function(pArgs, pEntity)
	TriggerEvent("dpemotes:e", {"parkingmeter"})
    local finished = exports["np-taskbar"]:taskBar(15000, "collecting DNA")
	TriggerEvent("dpemotes:e", {"c"})
    if finished == 100 then
		TriggerServerEvent("np-evidence:dnaSwab", GetPlayerServerId(NetworkGetPlayerIndexFromPed(pEntity)))
	end
end)









Citizen.CreateThread(function()
    exports["np-polytarget"]:AddBoxZone("analyze_evidence", vector3(483.62, -988.59, 30.69), 0.55, 0.75, {
        heading = 0,
        minZ=30.69,
        maxZ=31.49
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("analyze_evidence", {{
        event = "np-evidence:analyze",
        id = "analyze_evidence_inventory",
        icon = "hand-paper",
        label = "Insert Evidence",
        parameters = { actionId = 1 }
    }}, { distance = { radius = 3.5 } })

    exports["np-eye"]:AddPeekEntryByPolyTarget("analyze_evidence", {{
        event = "np-evidence:analyze",
        id = "analyze_evidence_action",
        icon = "search",
        label = "Analyze Evidence",
        parameters = { actionId = 2 }
    }}, { distance = { radius = 3.5 } })

end)