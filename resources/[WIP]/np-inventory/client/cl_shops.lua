--[[

    Variables

]]

local listening = false

local Shops = {
    -- {
    --     text = "[E] Olhar para comida",
    --     action = function()
    --         TriggerEvent("server-inventory-open", "22", "Shop");
    --     end,

    --     center = vector3(1776.15, 2640.95, 45.59),
    --     radius = 3.0,

    --     isEnabled = function()
    --         return true
    --     end,
    -- },
}

--[[

    Functions

]]

local function listenForKeypress(shopId)
    listening = true

    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) then
                listening = false
                exports["np-interaction"]:hideInteraction()

                Shops[shopId].action()
            end

            Citizen.Wait(1)
        end
    end)
end

--[[

    Events

]]

AddEventHandler("np-polyzone:enter", function(zone, data)
    if zone ~= "np-inventory:shops" then return end

    local shopId = data.shopId

    if Shops[shopId].isEnabled() then
        exports["np-interaction"]:showInteraction(Shops[shopId].text)
	    listenForKeypress(shopId)
    end
end)

AddEventHandler("np-polyzone:exit", function(zone, data)
    if zone ~= "np-inventory:shops" then return end

	exports["np-interaction"]:hideInteraction()
    exports["np-taskbar"]:taskCancel();
	listening = false
end)


--[[

    Threads

]]

Citizen.CreateThread(function()
	for shopId, shop in ipairs(Shops) do
        local options = {
            useZ = true,
            data = {
                shopId = shopId
            }
        }

        exports["np-polyzone"]:AddCircleZone("np-inventory:shops", shop.center, shop.radius, options)
    end
end)