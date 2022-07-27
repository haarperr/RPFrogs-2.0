VehiclesConfig = {
    {
        ["Job"] = "ems",
        ["Label"] = "Vehicles EMS",
        ["Spawn"] = vector4(337.15, -579.9, 28.8, 337.03),
        ["Garage"] = "Hospital",

        ["Vehicles"] = {
            { name = "Ambulance Speedo", model = "emsnspeedo", price = 5000, first_free = true },
            { name = "Ambulance", model = "ambulance", price = 5000, first_free = true, image = "https://i.imgur.com/huqyyKL.png" },
            { name = "Fire Truck", model = "firetruk", price = 15000, image = "https://i.imgur.com/jZ9Ol3e.png" },
            { name = "Lifeguard", model = "lguard", price = 10000, image = "https://i.imgur.com/BOFkRrj.png" },
        },

        ["NPC"] = {
            id = "ems_vehicles",
            name = "EMS Vehicles",
            pedType = 4,
            model = "s_m_m_paramedic_01",
            networked = false,
            distance = 50.0,
            position = {
                coords = vector3(341.23, -579.11, 27.8),
                heading = 124.3,
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
                ["isEmsVehicleSeller"] = true,
            },
            scenario = "WORLD_HUMAN_AA_COFFEE",
        },
    },
    {
        ["Job"] = "fire_department",
        ["Label"] = "Vehicles LSFD",
        ["Spawn"] = vector4(-636.3, -113.46, 38.1, 82.42),
        ["Garage"] = "LSFD",

        ["Vehicles"] = {
            { name = "LSFD1", model = "lsfd", price = 5000, first_free = true },
            { name = "LSFD2", model = "lsfd2", price = 5000, first_free = true },
            { name = "LSFD3", model = "lsfd3", price = 5000, first_free = true },
            { name = "LSFD4", model = "lsfd4", price = 5000, first_free = true },
            { name = "LSFD5", model = "lsfd5", price = 5000, first_free = true },
            { name = "LSFDTRUCK1", model = "lsfdtruck", price = 5000, first_free = true },
            { name = "LSFDTRUCK2", model = "lsfdtruck2", price = 5000, first_free = true },
            { name = "LSFDTRUCK3", model = "lsfdtruck3", price = 5000, first_free = true },
        },

        ["NPC"] = {
            id = "lsfd_vehicles",
            name = "LSFD Vehicles",
            pedType = 4,
            model = "s_m_y_fireman_01",
            networked = false,
            distance = 50.0,
            position = {
                coords = vector3(-635.59, -117.36, 37.05),
                heading = 42.63,
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
                ["isEmsVehicleSeller"] = true,
            },
            scenario = "WORLD_HUMAN_AA_COFFEE",
        },
    },
}