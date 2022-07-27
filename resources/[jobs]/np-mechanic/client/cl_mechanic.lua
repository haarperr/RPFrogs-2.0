--[[

    Variables

]]



--[[

    Functions

]]

function isChargeActive(pEntity, pContext)
    return exports["np-base"]:getChar("job") == "bennys"
end

function isInGroup(pEntity, pContext)
    return exports["np-groups"]:GroupRank("bennys") > 0
end

--[[

    Events

]]

AddEventHandler("np-mechanic:sign", function()
    TriggerEvent("np-signin:peekAction", nil, nil, { zones = { job_sign_in = { job = "bennys_sign_in" } } })
end)

AddEventHandler("np-mechanic:storage", function()
    TriggerEvent("server-inventory-open", "1", "bennys_stash")
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    exports["np-npcs"]:RegisterNPC({
        id = "bennys",
        name = "bennys",
        pedType = 4,
        model = "ig_benny",
        networked = false,
        distance = 50.0,
        position = {
            coords = vector3(-196.71, -1319.82, 30.09),
            heading = 90.00,
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
        },
        scenario = "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT_FACILITY",
    })

    exports["np-eye"]:AddPeekEntryByFlag({ "isNPC" }, {
        {
            id = "bennys_sign",
            label = "Sign In/Out",
            icon = "pager",
            event = "np-mechanic:sign",
        }
    }, { distance = { radius = 2.5 }, npcIds = { "bennys" }, isEnabled = isInGroup })

    exports["np-eye"]:AddPeekEntryByFlag({ "isNPC" }, {
        {
            id = "bennys_shop",
            label = "Vehicle Parts",
            icon = "tools",
            event = "np-npcs:ped:keeper",
            parameters = { "321" }
        }
    }, { distance = { radius = 2.5 }, npcIds = { "bennys" }, isEnabled = isChargeActive })

    exports["np-polytarget"]:AddBoxZone("np-mechanic-storage", vector3(-199.45, -1319.17, 31.09), 0.65, 1.8, {
        heading=0,
        minZ=30.09,
        maxZ=31.14,
    })

    exports["np-eye"]:AddPeekEntryByPolyTarget("np-mechanic-storage", {{
        event = "np-mechanic:storage",
        id = "bennys_storage",
        icon = "box-open",
        label = "Storage",
    }}, { distance = { radius = 3.5 }, isEnabled = isChargeActive })
end)