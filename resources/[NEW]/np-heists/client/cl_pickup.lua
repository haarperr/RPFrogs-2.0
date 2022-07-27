local pickupLocation = vector3(436.36608886719, 2996.1928710938, 41.283821105957)
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distanceCheckPickup = GetDistanceBetweenCoords(playerCoords, 436.36608886719, 2996.1928710938, 41.283821105957, false)
        if distanceCheckPickup <= 1.0 then
            if IsControlPressed(0, 38) then
                  HasItemPickup()
            end
        end
        Citizen.Wait(1000)
    end
end)

function GetRandomString(lenght)
  local chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  local randomString, stringLenght = '', lenght or 10
  local charTable = {}

  for char in chars:gmatch"." do
      table.insert(charTable, char)
  end

  for i = 1, stringLenght do
      randomString = randomString .. charTable[math.random(1, #charTable)]
  end
  return randomString
end

AddEventHandler("np-inventory:itemUsed", function(item, metadata)
    if item ~= "heistlaptop3" then return end
    print(item)
    local metaData = json.decode(metadata)
end)

AddEventHandler("np-inventory:itemUsed", function(item, metadata) --metadata
    if item ~= "thermitecharge" then return end
    if AttemptJewelryStoreThermite() then return end
  end)

AddEventHandler("np-inventory:itemUsed", function(item, metadata, inventoryName, slot) --metadata
    if item ~= "heistlaptop3" then return end
    usedItemId = item
    usedItemSlot = slot
    usedItemMetadata = json.decode(metadata)

    print(usedItemMetadata._uses)
  end)

function HasItemPickup()
    local cid = exports["isPed"]:isPed("cid")
    local hasPickup = RPC.execute("blackmarket:hasItemPickup", cid)
    if not hasPickup then TriggerEvent("DoLongHudText", "You don't have a pickup!") return end
    local items = RPC.execute("blackmarket:getPickupItems", cid)
    local result = RPC.execute("blackmarket:resetHasPickUp", cid)
    if not result then return end
    local pickupitem
    for i = 1, #items do
        pickupitem = items[i]["itemid"]
        if pickupitem == "heistlaptop3" then
        TriggerEvent("player:receiveItem", pickupitem, 1, {
            id = GetRandomString(),
            _hideKeys = { "_uses","id" },
            _uses = 3,
        })
        else
        TriggerEvent("player:receiveItem", pickupitem, 1, false ,items[i]["information"])
        end
    end
    TriggerEvent("DoLongHudText", "Got yo shit", 1)
end

AddEventHandler("np-heists:laptopPurchase", function()
    --local exp = RPC.execute("np-heists:hacks:getExperience")
    local items = {
      {
        action = "np-heists:context:laptopPurchase",
        title = "Practice Makes Perfect",
        description = "",
        key = 1,
        disabled = true,
      },
      {
        action = "np-heists:context:laptopPurchase",
        title = "Green Laptop (100RC)",
        description = "Useful for Fleecas",
        key = { item = "heistlaptop3", price = 100 },
        disabled = false
      },
      {
        action = "np-heists:context:laptopPurchase",
        title = "Blue Laptop (250RC)",
        description = "Useful for Paleto",
        key = { item = "heistlaptop2", price = 250 },
        disabled = false
      },
      {
        action = "np-heists:context:laptopPurchase",
        title = "Red Laptop (500RC)",
        description = "Useful for Upper Vault (City Bank)",
        key = { item = "heistlaptop4", price = 500 },
        disabled = false
      },
      {
        action = "np-heists:context:laptopPurchase",
        title = "Gold Laptop (1500RC)",
        description = "Useful for Lower Vault (City Bank)",
        key = { item = "heistlaptop1", price = 1500 },
        disabled = true, -- exp < 7500,
      },
      {
        action = "np-heists:context:laptopPurchase",
        title = "Gold Dongle (100RC)",
        description = "Useful for acquiring other tools",
        key = { item = "heistusb3", price = 100 },
        disabled = false
      },
    }
    exports["np-ui"]:showContextMenu(items)
end)

--[[ RegisterNUICallback("np-heists:context:laptopPurchase", function(data, cb)
    print("w")
    print(data.key.price, data.key.item)
    cb({ data = {}, meta = { ok = true, message = "" }})
    local character_id = exports["isPed"]:isPed("cid")
    local shungite, guinea = RPC.execute("phone:getCryptoBalance", character_id)
    if shungite == nil or shungite == 0 then return end
    if shungite < data.key.price then TriggerEvent("DoLongHudText", "You don't have enough RC!", 2) return end
    local success = RPC.execute("blackmarket:buyProduct", character_id, data.key.price, data.key.item)
    if not success then TriggerEvent("DoLongHudText", "Could not complete purchase.", 2) return end
    TriggerEvent("DoLongHudText", "You know where to go", 1)
    addPickUpBlip()
end) ]]


RegisterNUICallback("np-heists:context:laptopPurchase", function(data, cb)
    cb({ data = {}, meta = { ok = true, message = "" }})
    local character_id = exports["isPed"]:isPed("cid")
    local success, message = RPC.execute("phone:getCrypto", character_id)
    if not success then
      TriggerEvent("DoLongHudText", "Could not complete purchase.", 2)
      return
    end
    local found = nil
    for _, v in pairs(message) do
      if tonumber(v.cryptoid) == 1 then
        found = v
      end
    end
    if found == nil then
      TriggerEvent("DoLongHudText", "Wallet not found.", 2)
      -- add wallet since not found
      RPC.execute("phone:generateWallet")
      -- ^^ make it so whenever you create char make wallet
      return
    end
    if tonumber(found.cryptoamount) < data.key.price then
      TriggerEvent("DoLongHudText", "Not enough RC.", 2)
      return
    end
    RPC.execute("heists:addPickupItem", character_id, data.key.price, data.key.item)
    TriggerEvent("DoLongHudText", "You know where to go", 1)
    addPickUpBlip()
  end)