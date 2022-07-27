--[[

    Variables

]]

local clientInventory = {}
local PreviousItemCheck = {}
local justUsed = false
local retardCounter = 0
local lastCounter = 0

local LastUsedItem = 0
local LastUsedItemId = "ciggy"

local validWaterItem = {
    ["oxygentank"] = true,
    ["water"] = true,
    ["vodka"] = true,
    ["beer"] = true,
    ["whiskey"] = true,
    ["coffee"] = true,
    ["fishtaco"] = true,
    ["taco"] = true,
    ["burrito"] = true,
    ["churro"] = true,
    ["hotdog"] = true,
    ["greencow"] = true,
    ["donut"] = true,
    ["eggsbacon"] = true,
    ["icecream"] = true,
    ["mshake"] = true,
    ["sandwich"] = true,
    ["hamburger"] = true,
    ["cola"] = true,
    ["jailfood"] = true,
    ["bleederburger"] = true,
    ["heartstopper"] = true,
    ["torpedo"] = true,
    ["meatfree"] = true,
    ["moneyshot"] = true,
    ["fries"] = true,
    ["slushy"] = true,
    ["frappuccino"] = true,
    ["latte"] = true,
    ["cookie"] = true,
    ["muffin"] = true,
    ["chocolate"] = true,

}

--[[

    Functions

]]

function GetItemInfo(checkslot)
    for i,v in pairs(clientInventory) do
        if (tonumber(v.slot) == tonumber(checkslot)) then
            local info = {["information"] = v.information,["id"] = v.id, ["quality"] = v.quality }
            return info
        end
    end
    return "Sem informação.";
end

function getQuantity(itemid, checkQuality, metaInformation)
    local amount = 0
    for i,v in pairs(clientInventory) do
        local qCheck = not checkQuality or v.quality > 0
        if v.item_id == itemid and qCheck then
            if metaInformation then
                local totalMetaKeys = 0
                local metaFoundCount = 0
                local itemMeta = json.decode(v.information)
                for metaKey, metaValue in pairs(metaInformation) do
                    totalMetaKeys = totalMetaKeys + 1
                    if itemMeta[metaKey] and itemMeta[metaKey] == metaValue then
                        metaFoundCount = metaFoundCount + 1
                    end
                end
                if totalMetaKeys <= metaFoundCount then
                    amount = amount + v.amount
                end
            else
                amount = amount + v.amount
            end
        end
    end
    return amount
end

function hasEnoughOfItem(itemid, amount, shouldReturnText, checkQuality, metaInformation)
    if shouldReturnText == nil then shouldReturnText = true end
    if itemid == nil or itemid == 0 or amount == nil or amount == 0 then
        if shouldReturnText then
            TriggerEvent("DoLongHudText","Ik lijk niet te hebben " .. itemid .. " op mij.",2)
        end
        return false
    end
    amount = tonumber(amount)
    local slot = 0
    local found = false

    if getQuantity(itemid, checkQuality, metaInformation) >= amount then
        return true
    end
    if (shouldReturnText) then
       -- TriggerEvent("DoLongHudText","You dont have this item",2)
    end
    return false
end

function isValidUseCase(itemID, isWeapon)
    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)

    if playerVeh ~= 0 then
        local model = GetEntityModel(playerVeh)
        if IsThisModelACar(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
            if IsEntityInAir(playerVeh) then
                Wait(1000)
                if IsEntityInAir(playerVeh) then
                    TriggerEvent("DoLongHudText", "Het lijkt erop dat je vliegt.", 2)
                    return false
                end
            end
        end
    end

    if not validWaterItem[itemID] and not isWeapon then
        if IsPedSwimming(player) then
            local targetCoords = GetEntityCoords(player, 0)
            Wait(700)
            local plyCoords = GetEntityCoords(player, 0)
            if #(targetCoords - plyCoords) > 1.3 then
                TriggerEvent("DoLongHudText", "Kan dit niet gebruiken terwijl je zwemt.", 2)
                return false
            end
        end

        if IsPedSwimmingUnderWater(player) then
            TriggerEvent("DoLongHudText", "U kunt dit niet gebruiken zoals ondergedompeld.", 2)
            return false
        end
    end

    return true
end

function checkForItems()
    local items = {
        "mobilephone",
        "radio",
        "civradio",
        "megaphone",
        "custommiscitem",
        "musicwalkman",
    }

    for _, item in ipairs(items) do
        local quantity = getQuantity(item)
        local hasItem = quantity >= 1

        if hasItem and not PreviousItemCheck[item] then
            PreviousItemCheck[item] = true
            TriggerEvent("np-inventory:itemCheck", item, true, quantity)
        elseif not hasItem and PreviousItemCheck[item] then
            PreviousItemCheck[item] = false
            TriggerEvent("np-inventory:itemCheck", item, false, quantity)
        end
    end
end

function checkForAttachItem()
    local AttatchItems = {
        "stolentv",
        "stolenmusic",
        "stolencoffee",
        "stolenmicrowave",
        "stolencomputer",
        "stolenart",
    }

    local RepairItems = {
        "sfixbrake","sfixaxle","sfixradiator","sfixclutch","sfixtransmission","sfixelectronics","sfixinjector","sfixtire","sfixbody","sfixengine",
        "afixbrake","afixaxle","afixradiator","afixclutch","afixtransmission","afixelectronics","afixinjector","afixtire","afixbody","afixengine",
        "bfixbrake","bfixaxle","bfixradiator","bfixclutch","bfixtransmission","bfixelectronics","bfixinjector","bfixtire","bfixbody","bfixengine",
        "cfixbrake","cfixaxle","cfixradiator","cfixclutch","cfixtransmission","cfixelectronics","cfixinjector","cfixtire","cfixbody","cfixengine",
        "dfixbrake","dfixaxle","dfixradiator","dfixclutch","dfixtransmission","dfixelectronics","dfixinjector","dfixtire","dfixbody","dfixengine",
    }

    local itemToAttach = "none"
    for k,v in pairs(AttatchItems) do
        if getQuantity(v) >= 1 then
            itemToAttach = v
            break
        end
    end

    if itemToAttach == "none" then
        for k,v in pairs(RepairItems) do
            if getQuantity(v) >= 1 then
                itemToAttach = "engine"
                break
            end
        end
    end

    TriggerEvent("animation:carry", itemToAttach, true)
end

function GetCurrentWeapons()
    local returnTable = {}
    for i,v in pairs(clientInventory) do
        if (tonumber(v.item_id)) then
            local t = { ["hash"] = v.item_id, ["id"] = v.id, ["information"] = v.information, ["name"] = v.item_id, ["slot"] = v.slot }
            returnTable[#returnTable+1]=t
        end
    end
    if returnTable == nil then
        return {}
    end
    return returnTable
end

function TaskItem(dictionary, animation, typeAnim, timer, message, func, remove, itemid, playerVeh, itemreturn, itemreturnid, quality)
    loadAnimDict(dictionary)
    TaskPlayAnim(PlayerPedId(), dictionary, animation, 8.0, 1.0, -1, typeAnim, 0, 0, 0, 0)

    local timer = tonumber(timer)
    if timer > 0 then
        local finished = exports["np-taskbar"]:taskBar(timer, message, true, false, playerVeh)
        if finished == 100 or timer == 0 then
            TriggerEvent(func, quality)

            if remove then
                TriggerEvent("inventory:removeItem", itemid, 1)
            end

            if itemreturn then
                TriggerEvent("player:receiveItem", itemreturnid, 1)
            end
        end
    else
        TriggerEvent(func)
    end

    ClearPedSecondaryTask(PlayerPedId())
end

function AttachPropAndPlayAnimation(dictionary, animation, typeAnim, timer, message, func, remove, itemid, vehicle, prop)
    if prop then
        TriggerEvent("attachItem", prop)
    end

    TaskItem(dictionary, animation, typeAnim, timer, message, func, remove, itemid, vehicle)

    if prop then
        TriggerEvent("destroyProp")
    end
end

--[[

    Exports

]]

exports("GetItemInfo", GetItemInfo)
exports("getQuantity", getQuantity)
exports("hasEnoughOfItem", hasEnoughOfItem)
exports("GetCurrentWeapons", GetCurrentWeapons)
exports("TaskItem", TaskItem)
exports("AttachPropAndPlayAnimation", AttachPropAndPlayAnimation)

--[[

    Events

]]

RegisterNetEvent("current-items")
AddEventHandler("current-items", function(inv)
    clientInventory = inv
    checkForItems()
    checkForAttachItem()
    TriggerEvent("AttachWeapons")
end)

RegisterNetEvent("RunUseItem")
AddEventHandler("RunUseItem", function(itemid, slot, inventoryName, isWeapon, passedItemInfo)
    if itemid == nil then return end

    local ItemInfo = GetItemInfo(slot)

    LastUsedItem = ItemInfo.id
    LastUsedItemId = itemid

    if ItemInfo.quality == nil then return end
    if ItemInfo.quality < 1 then
        TriggerEvent("DoLongHudText","Dit item is kapot",2)
        if isWeapon then
            TriggerEvent("brokenWeapon")
        end
        return
    end

    if justUsed then
        retardCounter = retardCounter + 1
        if retardCounter > 10 and retardCounter > lastCounter + 5 then
            lastCounter = retardCounter
            TriggerServerEvent("exploiter", "Geprobeerd om te gebruiken " .. retardCounter .. " Items in <500ms")
        end
        return
    end

    justUsed = true

    if (not hasEnoughOfItem(itemid,1,false)) then
        TriggerEvent("DoLongHudText","Het lijkt erop dat je dit item niet hebt...?",2)
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if itemid == "-72657034" then
        TriggerEvent("equipWeaponID", itemid, ItemInfo.information, ItemInfo.id)
        TriggerEvent("inventory:removeItem",itemid, 1)
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if not isValidUseCase(itemid, isWeapon) then
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if itemid == nil then
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if isWeapon then
        if tonumber(ItemInfo.quality) > 0 then
            TriggerEvent("equipWeaponID", itemid, ItemInfo.information, ItemInfo.id)
        end
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        Wait(1500)
        TriggerEvent("AttachWeapons")
        return
    end

    if itemid == "knuckle_chain" then
        if tonumber(ItemInfo.quality) > 0 then
            local katanaInfo = json.decode(ItemInfo.information)
            katanaInfo.componentVariant = "2"
            local hiddenKeys = katanaInfo._hideKeys or {}
            hiddenKeys[#hiddenKeys + 1] = "componentVariant"
            katanaInfo._hideKeys = hiddenKeys
            TriggerEvent("equipWeaponID","3638508604",json.encode(katanaInfo),ItemInfo.id)
        end
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    TriggerEvent("hud-display-item", itemid, "Used")

    Wait(800)

    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)

    local remove = false

    if (itemid == "custommiscitem") then
        -- local info = json.decode(ItemInfo.information)

        -- if info["_type"] == "tvbox" then
        --     TriggerEvent("DoLongHudText", "Essa TV Box esta quebrada! Quem te vendeu isso?")
        -- end
    end

    if (itemid == "idcard") then
        TriggerServerEvent("np-idcard:show", json.decode(ItemInfo.information))
    end

    if (itemid == "pdbadge") then
        TriggerServerEvent("np-police:showBadge", json.decode(ItemInfo.information))
    end

    if (itemid == "weedq") then
        local finished = exports["np-taskbar"]:taskBar(1000,"Ik rol die Jonko",false,false,playerVeh)
        if (finished == 100) then
            CreateCraftOption("joint", 999, true)
        end
    end

    if (itemid == "disabler") then
        local finished = exports["np-taskbar"]:taskBar(500,"Opstarten",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("boosting:DisablerUsed")
        end
    end
    
    if (itemid == "heistpadyacht" or itemid == "pixellaptop") then
        local finished = exports["np-taskbar"]:taskBar(1000,"Verbinding maken met netwerk...",false,false,playerVeh)
        if (finished == 100) then
            Wait(200)
            TriggerEvent("np-boosting:openLaptop")
        end
    end

    if (itemid == "codein") then
        CreateCraftOption("lean", 10, true)
    end

    if (itemid == "anfetamina") then
        CreateCraftOption("1gmeta", 10, true)
    end

    if (itemid == "nitrous") then
        TriggerEvent("carmod:nos")
    end

    if (itemid == "nitrous") then
        local currentVehicle = GetVehiclePedIsIn(player, false)

        if currentVehicle == nil or currentVehicle == 0 then
            TriggerEvent("attachItem","nosbottle")
            TaskItem("amb@code_human_wander_idles@male@idle_a", "idle_b_rubnose", 49, 2800, "Sniff Sniff", "hadnitrous", false, itemid, playerVeh)
            TriggerEvent("destroyProp")
        elseif not IsToggleModOn(currentVehicle, 18) then
            TriggerEvent("DoLongHudText","You need a Turbo to use NOS!", 2)
        else
            local finished = 0
            local cancelNos = false
            Citizen.CreateThread(function()
                while finished ~= 100 and not cancelNos do
                    Citizen.Wait(100)
                    if GetEntitySpeed(GetVehiclePedIsIn(player, false)) > 11 then
                        exports["np-taskbar"]:closeGuiFail()
                        cancelNos = true
                    end
                end
            end)
            finished = exports["np-taskbar"]:taskBar(20000,"Nitrous")
            if (finished == 100 and not cancelNos) then
                TriggerEvent("NosStatus")
                TriggerEvent("vehicle:addNos", "large")
                TriggerEvent("noshud", 100, false)
                remove = true
            else
                TriggerEvent("DoLongHudText","You can't drive and hook up nos at the same time.",2)
            end
        end
    end

    if (itemid == "lighter") then
        TriggerEvent("animation:PlayAnimation","lighter")
        local finished = exports["np-taskbar"]:taskBar(2000,"Het vuur aansteken",false,false,playerVeh)
    end

    if (itemid == "joint") then
        local finished = exports["np-taskbar"]:taskBar(2000,"Jonko roken sahbi",false,false,playerVeh)
        if (finished == 100) then
            Wait(200)

            if math.random(100) <= 5 then
                TriggerEvent("player:receiveItem","femaleseed",1)
            end

            if math.random(100) <= 2 then
                TriggerEvent("player:receiveItem","maleseed",1)
            end

            TriggerEvent("animation:PlayAnimation", "weed")
            TriggerEvent("Evidence:StateSet",3,600)
            TriggerEvent("Evidence:StateSet",4,600)
            TriggerEvent("fx:run", "weed", 180, -1, false)
            remove = true
        end
    end

    if (itemid == "lean") then
        TriggerEvent("animation:PlayAnimation","drink")
        local finished = exports["np-taskbar"]:taskBar(3000,"Sipping Lean 🥤",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("Evidence:StateSet",2,1200)
            TriggerEvent("Evidence:StateSet",24,1200)
            TriggerEvent("fx:run", "metamorphine", 160, -1, true)
            remove = true
        end
    end

    if (itemid == "water") then
        TriggerEvent("animation:PlayAnimation","drink")
        local finished = exports["np-taskbar"]:taskBar(3000,"Hydrating",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent('np-hud:ChangeThirst', 30)
            remove = true
        end
    end

    if (itemid == "sandwich") then
        TriggerEvent("animation:PlayAnimation","eat")
        local finished = exports["np-taskbar"]:taskBar(3000,"Eating",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent('np-hud:ChangeHunger', 10)
            remove = true
        end
    end

    if (itemid == "armor" or itemid == "pdarmor") then
        local finished = exports["np-taskbar"]:taskBar(5000,"Applying Vest",true,false,playerVeh)
        if (finished == 100) then
            SetPlayerMaxArmour(PlayerId(), 60)

            local wasBeatdown = exports["np-police"]:getBeatmodeDebuff()

            if not wasBeatdown then
                SetPedArmour(player, 60)
                TriggerEvent("UseBodyArmor")
                remove = true
            else
                TriggerEvent("DoLongHudText","You are dead bozo")
            end
        end
    end

    if (itemid == "binoculars") then
        TriggerEvent("binoculars:Activate")
    end

    if (itemid == "camera") then
        TriggerEvent("camera:Activate")
    end

    if (itemid == "megaphone") then
        TriggerEvent("np-usableprops:megaphone")
    end

    if (itemid == "lockpick") then
        TriggerEvent("np-inventory:lockpick", false, inventoryName, slot)
    end

    if (itemid == "ciggy") then
        local finished = exports["np-taskbar"]:taskBar(1000,"Lighting One Up",false,false,playerVeh)
        if (finished == 100) then
            Wait(300)
            TriggerEvent("animation:PlayAnimation","smoke")
        end
    end

    if (itemid == "cigar") then
        local finished = exports["np-taskbar"]:taskBar(1000,"Lighting One Up",false,false,playerVeh)
        if (finished == 100) then
            Wait(300)
            TriggerEvent("animation:PlayAnimation","cigar")
        end
    end

    if (itemid == "phonebox") then
        local finished = exports["np-taskbar"]:taskBar(5000,"Opening Box",false,false,playerVeh)
        if (finished == 100) then
            Wait(300)
            TriggerEvent("player:receiveItem", "mobilephone", 1)
            TriggerEvent("player:receiveItem", "phoneboxempty", 1)
            TriggerEvent("animation:PlayAnimation","cigar")
            TriggerEvent("inventory:removeItem","phonebox", 1)
        end
    end

    if (itemid == "1gcocaine") then
        TriggerEvent("attachItemObjectnoanim","drugpackage01")
        TriggerEvent("Evidence:StateSet",2,1200)
        TriggerEvent("Evidence:StateSet",6,1200)
        TaskItem("anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 49, 5000, "Cheirando Cocaína", "hadcocaine", true,itemid,playerVeh)
    end

    
    if (itemid == "heistlaptop2") then
        TriggerEvent("np-paleto:distcheck")
        
    end

    if (itemid == "thermitecharge") then
        TriggerEvent("ghost:ThermiteFirstDoor")
        TriggerEvent("dark-vaultrob:upper:thermitedoors")
      end

    if (itemid == "heistlaptop1") then
        TriggerEvent("dark-vaultrob:lower:firstdoor")
        
    end

    if (itemid == "heistlaptop4") then
        TriggerEvent('np-jewel:distcheck')
    end

    if (itemid == "whitewineglass") or (itemid == "redwineglass") then
        TriggerEvent("Evidence:StateSet",27,6000)
        SetPedArmour(player, GetPedArmour(player) + 20)
        TriggerEvent("np-hud:updateStress",false,200)
    end

    if (itemid == "miningpickaxe") then
        TriggerEvent("np-start-mining")
    end


    if (itemid == "heistlaptop3") then
        TriggerEvent("np-fleeca:distcheck")
    end

    if (itemid == "mobilephone" or itemid == "stoleniphone" or itemid == "stolens8" or itemid == "stolennokia" or itemid == "stolenpixel3" or itemid == "assphone" or itemid == "boomerphone") then
        TriggerEvent("phoneGui")
    end

    if (itemid == "heistlaptop4") then
        TriggerEvent("dark-vaultrob:upper:heistlaptop4")
    end
 

    if (itemid == "1gmeta") then
        TriggerEvent("attachItemObjectnoanim","crackpipe01")
        TriggerEvent("Evidence:StateSet",2,1200)
        TriggerEvent("Evidence:StateSet",6,1200)
        TaskItem("switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 49, 5000, "Using Meth", "hadcrack", true,itemid,playerVeh)
    end

    if (itemid == "IFAK") then
        TaskItem("amb@world_human_clipboard@male@idle_a", "idle_c", 49,2000,"Using IFAK","healed:useOxy",true,itemid,playerVeh)
    end

    if (itemid == "bandage" or itemid == "custombandageitem") then
        print("i am using this bandage")
        TaskItem("amb@world_human_clipboard@male@idle_a", "idle_c", 49,10000,"Healing","healed:minors",true,itemid,playerVeh)
    end

    if (itemid == "bandagelarge") then
        TriggerEvent("inventory:DegenLastUsedItem", 33)
        TaskItem("amb@world_human_clipboard@male@idle_a","idle_c", 49,10000, "Healing", "healed:minors",false,itemid,playerVeh)
        Citizen.CreateThread(function()
            Wait(32000)
            TriggerEvent("healed:minors")
            Wait(32000)
            TriggerEvent("healed:minors")
        end)
    end
    TriggerEvent("np-inventory:itemUsed", itemid, passedItemInfo, inventoryName, slot, ItemInfo.id)
    TriggerServerEvent("np-inventory:itemUsed", itemid, passedItemInfo, inventoryName, slot, ItemInfo.id)

    if remove then
        TriggerEvent("inventory:removeItem", itemid, 1)
    end

    Wait(500)
    retardCounter = 0
    justUsed = false
end)

RegisterNetEvent("inventory:wepDropCheck")
AddEventHandler("inventory:wepDropCheck", function()
    local weapon = GetSelectedPedWeapon(PlayerPedId())
    if not hasEnoughOfItem(tostring(weapon), 1, false) then
        SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end
end)

RegisterNetEvent("inventory:DegenLastUsedItem")
AddEventHandler("inventory:DegenLastUsedItem", function(percent)
    local cid = exports["np-base"]:getChar("id")
    TriggerServerEvent("inventory:degItem", LastUsedItem, percent, LastUsedItemId, cid)
end)

if (itemid == "advlockpick") then

    local myJob = exports["isPed"]:isPed("myJob")
    if myJob ~= "news" then
        TriggerEvent("inv:lockPick", false, inventoryName, slot, "advlockpick")
    else
        TriggerEvent("DoLongHudText","Nice news reporting, you shit lord idiot.")
    end

end