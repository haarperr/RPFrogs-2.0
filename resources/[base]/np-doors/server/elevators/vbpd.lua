ELEVATORS = ELEVATORS or {}

ELEVATORS[#ELEVATORS + 1] = {
    ["access"] = {
        ["job"] = { "is_medic", "is_police" },
    },
    ["floors"] = {
        {
            ["name"] = "Level 1",
            ["description"] = "Garage Floor",
            ["locked"] = true,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-1095.05, -808.37, 3.85),
                    ["radius"] = 0.25,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-1157.07, -857.08, 3.85),
                    ["radius"] = 0.25,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(-1093.37, -808.34, 3.76, 122.89),
                ["onArriveEvent"] = false,
            },
        },
        {
            ["name"] = "Level 2",
            ["description"] = "Main Floor",
            ["locked"] = true,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-1096.75, -829.69, 19.5),
                    ["radius"] = 0.25,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-1090.61, -848.3, 13.78),
                    ["radius"] = 0.25,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(-1098.52, -829.87, 19.31, 311.22),
                ["onArriveEvent"] = false,
            },
        },
        {
            ["name"] = "Level 3",
            ["description"] = "Helipad",
            ["locked"] = true,
            ["zones"] = {
                {
                    ["type"] = "circle",
                    ["target"] = true,
                    ["center"] = vector3(-1108.0, -832.19, 37.86),
                    ["radius"] = 0.25,
                    ["options"] = {
                        ["useZ"] = true,
                    },
                },
            },
            ["teleport"] = {
                ["coords"] = vector4(-1107.41, -832.16, 37.68, 220.66),
                ["onArriveEvent"] = false,
            },
        },
    },
}