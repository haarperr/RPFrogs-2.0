--[[

    Variables

]]

MenuData = {
    ems_sign_in = {
        {
            title = "EMS",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "ems" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
        {
            title = "Doctor",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "doctor" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
    lspd_sign_in = {
        {
            title = "Police Officer",
            description = "Log in or out of service",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "police" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
    },
    sasp_sign_in = {
        {
            title = "State Trooper",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "state_police" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
    },
    sheriff_sign_in = {
        {
            title = "Sheriff Officer",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "sheriff" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
    },
    park_rangers_sign_in = {
        {
            title = "Park Ranger",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "park_ranger" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
    },
    doc_services_sign_in = {
        {
            title = "Department of Corrections Officer",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "doc" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
    },
    public_services_sign_in = {
        {
            title = "Mayor",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "mayor" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
        {
            title = "Judge",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "judge" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
        {
            title = "District Attorney",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "district attorney" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
        {
            title = "Public Defender",
            description = "Sign in or sign out",
            children = {
                { title = "Sign In", action = "np-signin:handler", params = { sign_in = true, job = "defender" } },
                { title = "Sign Out", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
    },
    taco_shop_sign_in = {
        {
            title = "Taco Shop",
            description = "Log in or out of service",
            children = {
                { title = "On Duty", action = "np-signin:handler", params = { sign_in = true, job = "taco_shop" } },
                { title = "Off Duty", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
    bs_sign_in = {
        {
            title = "BurgerShot",
            description = "Log in or out of service",
            children = {
                { title = "Clock In", action = "np-signin:handler", params = { sign_in = true, job = "burgershot" } },
                { title = "Clock Out", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
    vanilla_unicorn_sign_in = {
        {
            title = "Vanilla Unicorn",
            description = "Log in or out of service",
            children = {
                { title = "On Duty", action = "np-signin:handler", params = { sign_in = true, job = "vanilla_unicorn" } },
                { title = "Off Duty", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
    yb14_sign_in = {
        {
            title = "Young Boys Drip",
            description = "Log in or out of service",
            children = {
                { title = "On Duty", action = "np-signin:handler", params = { sign_in = true, job = "yb14" } },
                { title = "Off Duty", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
    cid_sign_in = {
        {
            title = "investigator Criminal",
            description = "Log in or out of service",
            children = {
                { title = "On Duty", action = "np-signin:handler", params = { sign_in = true, job = "cid" } },
                { title = "Off Duty", action = "np-signin:handler", params = { sign_off = true } }
            }
        },
    },
    bennys_sign_in = {
        {
            title = "Benny's Original Motor Works",
            description = "Log in or out of service",
            children = {
                { title = "On Duty", action = "np-signin:handler", params = { sign_in = true, job = "bennys" } },
                { title = "Off Duty", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
    fire_department_sign_in = {
        {
            title = "Los Santos Fire Department",
            description = "Log in or out of service",
            children = {
                { title = "On Duty", action = "np-signin:handler", params = { sign_in = true, job = "fire_department" } },
                { title = "Off Duty", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
    drusillas_sign_in = {
        {
            title = "Drusilla's Restaurant",
            description = "Log in or out of service",
            children = {
                { title = "On Duty", action = "np-signin:handler", params = { sign_in = true, job = "drusillas" } },
                { title = "Off Duty", action = "np-signin:handler", params = { sign_off = true } },
            }
        },
    },
}

--[[

    Threads

]]

Citizen.CreateThread(function()
    SetScenarioTypeEnabled("WORLD_VEHICLE_STREETRACE", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON_DIRT_BIKE", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_SALTON", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_NEXT_TO_CAR", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_CAR", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_POLICE_BIKE", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_SMALL", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MILITARY_PLANES_BIG", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_MECHANIC", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_EMPTY", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BUSINESSMEN", false)
    SetScenarioTypeEnabled("WORLD_VEHICLE_BIKE_OFF_ROAD_RACE", false)

    -- MRPD
    exports["np-polytarget"]:AddBoxZone("job_sign_in", vector3(441.83, -982.05, 30.69), 0.5, 0.35, {
        heading = 12,
        minZ = 30.79,
        maxZ = 30.84,
        data = {
            job = "lspd_sign_in",
        },
    })

    -- DOC
    exports["np-polytarget"]:AddCircleZone("job_sign_in",vector3(1841.6, 2574.13, 45.81), 0.28, {
        useZ = true,
        data = {
            job = "doc_services_sign_in",
        },
    })

    -- EMS Pillbox
    exports["np-polytarget"]:AddBoxZone("job_sign_in", vector3(310.24, -597.54, 43.28), 0.35, 0.25, {
        heading = 331,
        minZ = 43.28,
        maxZ = 43.33,
        data = {
            job = "ems_sign_in",
        },
    })

    -- Taco Shop
    exports["np-polytarget"]:AddCircleZone("job_sign_in",vector3(429.19, -1913.8, 25.47), 0.3, {
        useZ = true,
        data = {
            job = "taco_shop_sign_in",
        },
    })

    -- BS 

    exports["np-polytarget"]:AddCircleZone("job_sign_in",vector3(-1191.46, -900.57, 14.873), 0.3, {
        useZ = true,
        data = {
            job = "bs_sign_in",
        },
    })

    -- Vanilla
    exports["np-polytarget"]:AddCircleZone("job_sign_in",vector3(95.85, -1292.75, 29.26), 0.3, {
        useZ = true,
        data = {
            job = "vanilla_unicorn_sign_in",
        },
    })

    -- Young Boys
    -- exports["np-polytarget"]:AddBoxZone("job_sign_in", vector3(71.76, -1392.47, 29.38), 0.45, 1.6, {
    --     heading=0,
    --     minZ=28.38,
    --     maxZ=30.58,
    --     data = {
    --         job = "yb14_sign_in",
    --     },
    -- })

    -- CID VBPD
    exports["np-polytarget"]:AddCircleZone("job_sign_in",vector3(-1087.07, -814.18, 19.55), 0.3, {
        useZ = true,
        data = {
            job = "cid_sign_in",
        },
    })

    -- FIRE DEPARTMENT
    exports["np-polytarget"]:AddCircleZone("job_sign_in",vector3(-653.74, -87.25, 38.94), 0.25, {
        useZ = true,
        data = {
            job = "fire_department_sign_in",
        },
    })

    -- DRUSILLAS
    exports["np-polytarget"]:AddBoxZone("job_sign_in", vector3(-1342.46, -1060.77, 7.39), 1.2, 0.8, {
        heading=0,
        minZ=7.19,
        maxZ=7.39,
        data = {
            job = "drusillas_sign_in",
        },
    })
end)