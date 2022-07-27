
RegisterServerEvent('np-rentals:attemptPurchase')
AddEventHandler('np-rentals:attemptPurchase', function(car)
	local src = source
    local cash = exports["np-financials"]:getCash(src)

    if car == "bison" then
        if cash >= 500 then
            if exports["np-financials"]:updateCash(src, "-", cash) then
                TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            else
                TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
            end
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "futo" then
        if cash >= 450 then
            if exports["np-financials"]:updateCash(src, "-", cash) then
                TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            else
                TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
            end
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "buffalo" then
        if cash >= 750 then
            if exports["np-financials"]:updateCash(src, "-", cash) then
                TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            else
                TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
            end
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "jackal" then
        if cash >= 625 then
            if exports["np-financials"]:updateCash(src, "-", cash) then
                TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            else
                TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
            end
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "youga" then
        if cash >= 400 then
            if exports["np-financials"]:updateCash(src, "-", cash) then
                TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            else
                TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
            end
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "faggio" then
        if cash >= 350 then
            if exports["np-financials"]:updateCash(src, "-", cash) then
                TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            else
                TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
            end
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    end
end)


--// Post OP Server Side
RegisterServerEvent('np-civjobs:post-op-payment')
AddEventHandler('np-civjobs:post-op-payment', function()
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local payment = math.random(325, 450)
     exports["np-financials"]:updateCash(src, "+", payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the delivery and got $'..payment , 1)
end)

--// Water & Power Server Side
RegisterServerEvent('np-civjobs:water-power-payme')
AddEventHandler('np-civjobs:water-power-payme', function()
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local payment = math.random(200, 375)
     exports["np-financials"]:updateCash(src, "+", payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the delivery and got $'..payment , 1)
end)

--// Chicken Server Side

 local DISCORD_WEBHOOK5 = "https://canary.discord.com/api/webhooks/965294258431074374/GNn_Rdszv-RRqYt-4QhvYi4Ni3E8BOgeZLumrb8Ohm2ko3hAhRp-lEwKWNKCvvsjYiQn"
local DISCORD_NAME5 = "Chicken Selling Logs"

 local STEAM_KEY = "D01BB33086A760AE0098638CB73C7224"
 local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png"
 PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

local cachedData = {}

RegisterNetEvent('chickensell:log')
AddEventHandler('chickensell:log', function()
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local pName = GetPlayerName(source)
    local pDiscord = GetPlayerIdentifiers(src)[3]
    local DISCORD_NAME5 = "Chicken Selling Logs"
    local STEAM_KEY = "D01BB33086A760AE0098638CB73C7224"
    local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png"
    local LogData = {
        {
           ['description'] = string.format("`%s`\n\n`• Server Id: %s`\n\n━━━━━━━━━━━━━━━━━━\n`• Steam: %s`\n\n`• Discord: %s`\n━━━━━━━━━━━━━━━━━━", "is selling chickens!", src, pDiscord),
            ['color'] = 2317994,
            ['author'] = {
                ['name'] = "Steam Name: "..pName
            },
        }
    }

    PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('chickenpayment:pay')
AddEventHandler('chickenpayment:pay', function(money)
    local source = source
    local player = GetPlayerName(source)
    
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    if money ~= nil then
        user:addMoney(money)
        TriggerEvent("chickensell:log")
	end
end)

RegisterServerEvent('burgershot:receipt:payment')
AddEventHandler('burgershot:receipt:payment', function()
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    user:addMoney(math.random(200, 350))
end)



 function sendToDiscord5(name, message, color)
     local connect = {
       {
         ["color"] = color,
         ["title"] = "**".. name .."**",
         ["description"] = message,
       }
     }
     PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
 end

--// Fishing Server Side

RegisterServerEvent('np-fishing:PayPlayer')
AddEventHandler('np-fishing:PayPlayer', function(money)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
  exports["np-financials"]:updateCash(src, "+", money+15)
end)

--// np-sanitation Server Side

RegisterNetEvent('np-sanitation:pay')
AddEventHandler('np-sanitation:pay', function(jobStatus)
    local _source = source
    local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")

            local randomMoney = math.random(700, 1000) -- $700 - $1000 Per San Run
            exports["np-financials"]:updateCash(_source, "+", randomMoney)

end)

RegisterNetEvent('np-sanitation:reward')
AddEventHandler('np-sanitation:reward', function(rewardStatus)
    local _source = source
    local matherino = math.random(0, 6)
    if rewardStatus then
        if matherino > 4 then
            TriggerClientEvent('player:receiveItem', _source, 'plastic', math.random(1,5))
            TriggerClientEvent('player:receiveItem', _source, 'rubber', math.random(1,5))
        end
    else
    end
end)

--// Mining Server Side



RegisterServerEvent('np-civjobs:sell-gem-cash')
AddEventHandler('np-civjobs:sell-gem-cash', function(amount)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local cash = math.random(20, 150) * amount
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You were paid $'..cash, 1)
end)

RegisterServerEvent('np-civjobs:sell-stone-cash')
AddEventHandler('np-civjobs:sell-stone-cash', function(amount)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local cash = math.random(20, 150) * amount
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You were paid $'..cash, 1)
end)

RegisterServerEvent('np-civjobs:sell-coal-cash')
AddEventHandler('np-civjobs:sell-coal-cash', function(amount)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local cash = math.random(15, 25) * amount
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You were paid $'..cash, 1)
end)

RegisterServerEvent('np-civjobs:sell-diamond-cash')
AddEventHandler('np-civjobs:sell-diamond-cash', function(amount)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local cash = math.random(5, 25) * amount
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You were paid $'..cash, 1)
end)

RegisterServerEvent('np-civjobs:sell-sapphire-cash')
AddEventHandler('np-civjobs:sell-sapphire-cash', function(amount)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local cash = math.random(25, 30) * amount
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You were paid $'..cash, 1)
end)

RegisterServerEvent('np-civjobs:sell-ruby-cash')
AddEventHandler('np-civjobs:sell-ruby-cash', function(amount)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    local cash = math.random(250, 800) * amount
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You were paid $'..cash, 1)
end)

--// Hunting Server Side

RegisterServerEvent('np-hunting:skinReward')
AddEventHandler('np-hunting:skinReward', function()
  local _source = source
  
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
  local randomAmount = math.random(1,30)
  if randomAmount > 1 and randomAmount < 15 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass1', 1)
  elseif randomAmount > 15 and randomAmount < 23 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass2', 1)
  elseif randomAmount > 23 and randomAmount < 29 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass3', 1)
  else 
    TriggerClientEvent('player:receiveItem', _source, "huntingcarcass4", 1)
  end
end)

RegisterServerEvent('np-hunting:removeBait')
AddEventHandler('np-hunting:removeBait', function()
  local _source = source
  
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
  TriggerClientEvent('inventory:removeItem', _source, "huntingbait", 1)
end)

RegisterServerEvent('complete:job')
AddEventHandler('complete:job', function(totalCash)
  local _source = source
  
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
  user:addMoney(totalCash)
  TriggerEvent('np-base:huntingLog', _source, totalCash)
end)

--// Rentals Server Side


RegisterServerEvent('np-rentals:attemptPurchase')
AddEventHandler('np-rentals:attemptPurchase', function(car)
	local src = source
	local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    if car == "bison" then
        if user:getCash() >= 15000 then
            user:removeMoney(15000)
            TriggerClientEvent('np-rentals:vehiclespawn', source, car)
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    end
end)


RegisterServerEvent('np-rentals:attemptPurchase')
AddEventHandler('np-rentals:attemptPurchase', function(car)
	local src = source
	local user = exports["np-base"]:getUser(src)
    local cid = exports["np-base"]:getChar(src, "id")
    if car == "bison" then
        if user:getCash() >= 500 then
            user:removeMoney(500)
            TriggerClientEvent('np-rentals:vehiclespawn', source, car)
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "futo" then
        if user:getCash() >= 450 then
            TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            user:removeMoney(450)
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "buffalo" then
        if user:getCash() >= 750 then
            TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            user:removeMoney(750)
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "jackal" then
        if user:getCash() >= 625 then
            TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            user:removeMoney(625)
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "youga" then
        if user:getCash() >= 400 then
            TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            user:removeMoney(400)
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "faggio" then
        if user:getCash() >= 350 then
            TriggerClientEvent('np-rentals:vehiclespawn', source, car)
            user:removeMoney(350)
        else
            TriggerClientEvent('np-rentals:attemptvehiclespawnfail', source)
        end
    end
end)

-- Diving Job

RegisterServerEvent('np-scuba:checkAndTakeDepo')
AddEventHandler('np-scuba:checkAndTakeDepo', function()
local src = source
local user = exports["np-base"]:getUser(src)
local cid = exports["np-base"]:getChar(src, "id")
if user:getCash() >= 400 then
    TriggerClientEvent('getDiveingjob',src)
    user:removeMoney(400)
else
    TriggerClientEvent('DoShortHudText',src, 'Not enough you need 400 $!',2)
    return end
end)

-- RegisterServerEvent('np-scuba:returnDepo')
-- AddEventHandler('np-scuba:returnDepo', function()
-- local src = source
-- local user = exports["np-base"]:getUser(src)
--     user:addMoney(200)
-- end)


RegisterServerEvent('np-scuba:findTreasure')
AddEventHandler('np-scuba:findTreasure', function()
local source = source
    local roll = math.random(1,8)
    print(roll)
    if roll == 1 then
        TriggerClientEvent('player:receiveItem', source, "corpsefeet", math.random(2,5))
    end
    if roll == 2 then
        TriggerClientEvent('player:receiveItem', source, 'stolen8ctchain', math.random(2,6))
    end
    if roll == 3 then
        TriggerClientEvent('player:receiveItem', source, 'stolen2ctchain', math.random(2,5))
    end
    if roll == 5 then
        TriggerClientEvent('player:receiveItem', source, "copper", math.random(1,2))
    end
    if roll == 6 then
        TriggerClientEvent('player:receiveItem', source, "lockpick", math.random(1,2))
    end
    if roll == 7 then
        TriggerClientEvent('player:receiveItem', source, "russian", math.random(1,1))
    end
    if roll == 8 then
        TriggerClientEvent('player:receiveItem', source, "ruby", math.random(1,3))
    end
    if roll == 9 then
        TriggerClientEvent('player:receiveItem', source, "jadeite", math.random(1,3))
    end
    if roll == 10 then
        TriggerClientEvent('player:receiveItem', source, "oxy", math.random(1,3))
    end
    if roll == 11 then -- 5% chance 
        if math.random(1,100) >= 95 then
            TriggerClientEvent('DoShortHudText',src, 'You see something shining in the water',2)
            TriggerClientEvent('player:receiveItem', source, "heistusb1", 1)
        else
            TriggerClientEvent('player:receiveItem', source, "femaleseed", math.random(1,2))
    end  
        end
    if roll == 12 then
        TriggerClientEvent('player:receiveItem', source, "goldbar", math.random(1,2))
    end
    
end)

RegisterServerEvent('np-scuba:paySalvage')
AddEventHandler('np-scuba:paySalvage', function(money)
 local src = source
  local user = exports["np-base"]:getUser(src)
  local cid = exports["np-base"]:getChar(src, "id")
    if money ~= nil then
        user:addMoney(tonumber(money))
    end
end)

RegisterServerEvent('np-scuba:makeGold')
AddEventHandler('np-scuba:makeGold', function()
 local source = source
 TriggerClientEvent('inventory:removeItem', source, 'umetal', 10)
 TriggerClientEvent("player:receiveItem", source, "goldbar", 1)
end)