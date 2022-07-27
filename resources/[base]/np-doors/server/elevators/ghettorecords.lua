ELEVATORS = ELEVATORS or {}

ELEVATORS[#ELEVATORS + 1] = {
    ["access"] = {
        ["job"] = { "is_medic", "is_police" },
        ["groups"] = {
            ["ghettorecords"] = 1,
        },
    },
    ["floors"] = {
        {
            ["name"] = "Level 1",
            ["description"] = "Garage",
            ["locked"] = true,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-819.47, -706.6, 23.98),
                    ["radius"] = 0.17,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-819.46, -710.67, 23.98),
                    ["radius"] = 0.17,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(-817.78, -709.55, 23.79, 90.6),
                ["onArriveEvent"] = false,
            },
        },
        {
            ["name"] = "Level 2",
            ["description"] = "Principal",
            ["locked"] = false,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-819.45, -706.59, 28.25),
                    ["radius"] = 0.17,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-819.46, -710.65, 28.25),
                    ["radius"] = 0.17,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(-817.77, -709.54, 28.07, 86.1),
                ["onArriveEvent"] = false,
            },
        },
        {
            ["name"] = "Level 3",
            ["description"] = "Studio, Escritorio e Sala de Reunião",
            ["locked"] = false,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-819.42, -706.6, 32.54),
                    ["radius"] = 0.17,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-819.48, -710.65, 32.54),
                    ["radius"] = 0.17,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(-817.79, -709.5, 32.35, 94.03),
                ["onArriveEvent"] = false,
            },
        },
    },
}