RegisterServerEvent("np-police:cuff")
AddEventHandler("np-police:cuff", function(pTarget)
	local src = source

    TriggerClientEvent("np-police:getArrested", pTarget, src)
	TriggerClientEvent("np-police:cuffTransition", src)
end)

RegisterServerEvent("np-police:uncuff")
AddEventHandler("np-police:uncuff", function(pTarget)
	TriggerClientEvent("np-police:uncuff", pTarget)
end)

RegisterServerEvent("np-police:softcuff")
AddEventHandler("np-police:softcuff", function(pTarget)
    TriggerClientEvent("np-police:handCuffedWalking", pTarget)
end)

RPC.register("isPedCuffed", function(src, pTarget)
	local isCuffed = RPC.execute(pTarget, "isPlyCuffed")
	return isCuffed
end)