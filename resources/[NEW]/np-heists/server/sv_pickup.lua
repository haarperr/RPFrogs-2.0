RPC.register("blackmarket:buyProduct", function(pSource, pCid, pPrice, pItem)
    print(pCid.param, pPrice.param, pItem.param)
    local information = {}

    if pItem.param == "heistlaptop1" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    elseif pItem.param == "heistlaptop2" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    elseif pItem.param == "heistlaptop3" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    elseif pItem.param == "heistlaptop4" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    end

    local data1 = Await(SQL.execute("INSERT INTO pickups (cid, itemid, information) VALUES (@cid, @itemid, @information)", {
        ["cid"] = pCid.param,
        ["itemid"] = pItem.param,
        ["information"] = json.encode(information)
    }))
    local data2 = Await(SQL.execute("UPDATE characters SET shungite = shungite - @price WHERE id = @cid", {
        ["price"] = pPrice.param,
        ["cid"] = pCid.param
    }))

    return true
end)

RPC.register("blackmarket:hasItemPickup", function(pSource, pCid)
    local data = Await(SQL.execute("SELECT COUNT(*) AS total FROM pickups WHERE cid = @cid", {
        ["cid"] = pCid.param
    }))
    local hasPickup

    if not data then hasPickup = false return hasPickup end

    if data[1].total > 0 then
    hasPickup = true
    else
    hasPickup = false
    end

    return hasPickup
end)

RPC.register("blackmarket:getPickupItems", function(pSource, pCid)
    local data = Await(SQL.execute("SELECT * FROM pickups WHERE cid = @cid", {
        ["cid"] = pCid.param
    }))
    return data
end)

RPC.register("blackmarket:resetHasPickUp", function(pSource, pCid)
    local data = Await(SQL.execute("DELETE FROM pickups WHERE cid = @cid", {
        ["cid"] = pCid.param
    }))
    return true
end)

RPC.register("phone:getCrypto", function(pSource, pCid)
    local data = Await(SQL.execute("SELECT * FROM user_crypto WHERE cryptocid = @cid", {
        ["cid"] = pCid.param
    }))

    if not data then return false, "" end

    return true, data
end)

RPC.register("heists:addPickupItem", function(pSource, pCid, pPrice, pItem)
    local information = {}

    if pItem.param == "heistlaptop1" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    elseif pItem.param == "heistlaptop2" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    elseif pItem.param == "heistlaptop3" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    elseif pItem.param == "heistlaptop4" then
        information = {
            _uses = "3",
            _hideKeys = {"_uses"}
        }
    end

    local data1 = Await(SQL.execute("INSERT INTO pickups (cid, itemid, information) VALUES (@cid, @itemid, @information)", {
        ["cid"] = pCid.param,
        ["itemid"] = pItem.param,
        ["information"] = json.encode(information)
    }))
    local data2 = Await(SQL.execute("UPDATE user_crypto SET cryptoamount = cryptoamount - @price WHERE cryptocid = @cid", {
        ["price"] = pPrice.param,
        ["cid"] = pCid.param
    }))

    return true
end)

--[[ RPC.register("heists:pickupPurchasedItems",function(pSource)

end)

RPC.register("heists:addPickupItem",function(pSource,pItem,pWalletId,pPrice)

end)

RPC.register("np-heists:hacks:getExperience",function(pSource)
    return 1500
end)

RPC.register("np-heists:banksAvailability",function(pSource)

end)

RPC.register("np-heists:purchasePracticeLaptop",function()

end) ]]