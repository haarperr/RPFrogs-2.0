function startCall(phoneNumber, callerID, receiverID)
    TriggerClientEvent("np:voice:phone:call:start", callerID, receiverID, phoneNumber)
    TriggerClientEvent("np:voice:phone:call:start", receiverID, callerID, phoneNumber)
end

function endCall(phoneNumber, callerID, receiverID)
    TriggerClientEvent("np:voice:phone:call:end", callerID, receiverID, phoneNumber)
    TriggerClientEvent("np:voice:phone:call:end", receiverID, callerID, phoneNumber)
end

RegisterServerEvent("np:voice:server:phone:startCall")
AddEventHandler("np:voice:server:phone:startCall", startCall)

RegisterServerEvent("np:voice:server:phone:endCall")
AddEventHandler("np:voice:server:phone:endCall", endCall)