--[[

    Events

]]

RegisterNetEvent("np-npcs:location:fetch")
AddEventHandler("np-npcs:location:fetch", function()
    local src = source

    TriggerClientEvent("np-npcs:set:ped", src, Generic.NPCS)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    for i, v in ipairs(Generic.ShopKeeperLocations) do
        Generic.NPCS[#Generic.NPCS + 1] = {
            id = "shop_keeper_" .. i,
            name = "Shop Keeper",
            pedType = 4,
            model = "mp_m_shopkeep_01",
            networked = false,
            distance = 50.0,
            position = {
                coords = v.xyz,
                heading = v.w,
                random = false,
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ["isNPC"] = true,
                ["isShopKeeper"] = true,
            },
        }
    end
    
    for i, v in ipairs(Generic.WeaponShopLocations) do
        Generic.NPCS[#Generic.NPCS + 1] = {
            id = "ammunation_" .. i,
            name = "Weapon Shop",
            pedType = 4,
            model = "s_m_y_ammucity_01",
            networked = false,
            distance = 50.0,
            position = {
                coords = v.xyz,
                heading = v.w,
                random = false,
            },
            appearance = nil,
            settings = {
                { mode = "invincible", active = true },
                { mode = "ignore", active = true },
                { mode = "freeze", active = true },
            },
            flags = {
                ["isNPC"] = true,
                ["isWeaponShopKeeper"] = true,
            },
            scenario = "WORLD_HUMAN_GUARD_STAND",
        }
    end

end)