RPC.register("heists:cocaine_paynow",function(pSource)

    -- this works all the way to this point just gotta be written 
    print("cocaine_paynow")
    TriggerClientEvent("cocaine_payment_accepted")
end)

RPC.register("heists:cocaine_start_vehicle",function(pSource)
    print("cocaine_start_vehicle")
end)

RPC.register("heists:cocaine_dump_vehicle",function(pSource,x,y,z)
    print("cocaine_dump_vehicle",x.param,y.param,z.param)
end)