ELEVATORS = ELEVATORS or {}

ELEVATORS[#ELEVATORS + 1] = {
    ["access"] = {
        ["job"] = { "is_medic", "is_police" },
    },
    ["floors"] = {
        {
            ["name"] = "Level 1",
            ["description"] = "Garage Floor",
            ["locked"] = false,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(344.73, -584.74, 29.14),
                    ["radius"] = 0.15,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(346.07, -581.03, 29.14),
                    ["radius"] = 0.15,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(341.07, -582.52, 29.13),
                    ["radius"] = 0.15,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(339.74, -586.22, 29.13),
                    ["radius"] = 0.15,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(344.41, -586.29, 28.8, 255.26),
                ["onArriveEvent"] = false,
            },
        },
        {
            ["name"] = "Level 2",
            ["description"] = "Main Floor",
            ["locked"] = false,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(331.97, -597.19, 43.62),
                    ["radius"] = 0.15,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(330.01, -602.68, 43.62),
                    ["radius"] = 0.15,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(325.62, -603.43, 43.62),
                    ["radius"] = 0.15,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(331.98, -595.47, 43.29, 75.03),
                ["onArriveEvent"] = false,
            },
        },
        {
            ["name"] = "Level 3",
            ["description"] = "Helipad",
            ["locked"] = true,
            ["zones"] = {
                {
                    ["type"] = "box",
                    ["target"] = true,
                    ["center"] = vector3(338.25, -583.72, 74.16),
                    ["width"] = 3.0,
                    ["length"] = 0.2,
                    ["options"] = {
                        ["heading"] = 339,
                        ["minZ"] = 73.16,
                        ["maxZ"] = 75.36,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(338.55, -583.93, 74.17, 258.54),
                ["onArriveEvent"] = false,
            },
        },
    },
}