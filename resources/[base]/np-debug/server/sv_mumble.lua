RPC.register("np-debug:getInfosServer", function(src, pTarget)
    local data = {}

    if GetPlayerPing(pTarget) > 0 then
        data = RPC.execute(pTarget, "np-debug:getInfosClient")
    end

	return data
end)