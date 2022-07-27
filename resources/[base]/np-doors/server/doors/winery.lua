DOORS = DOORS or {}

DOORS[8001] = { -- Front Door
    ["active"] = true,
    ["model"] = 1077118233,
    ["coords"] = vector3(-1890.22, 2052.24, 141.32),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "winetime_winery" },
        ["groups"] = {
            ["winetime_winery"] = 1,
        },
    },

}

DOORS[8002] = { -- Front Door
    ["active"] = true,
    ["model"] = 1077118233,
    ["coords"] = vector3(-1887.90, 2051.38, 141.32),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "winetime_winery" },
        ["groups"] = {
            ["winetime_winery"] = 1,
        },
    },

}

DOORS[8003] = { -- Front Door
    ["active"] = true,
    ["model"] = 1077118233,
    ["coords"] = vector3(-1885.22, 2050.38, 141.30),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "winetime_winery" },
        ["groups"] = {
            ["winetime_winery"] = 1,
        },
    },

}

DOORS[8004] = { -- Front Door
    ["active"] = true,
    ["model"] = 1077118233,
    ["coords"] = vector3(-1887.54, 2051.24, 141.32),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "winetime_winery" },
        ["groups"] = {
            ["winetime_winery"] = 1,
        },
    },
}

DOORS[8005] = { -- Basement Door
    ["active"] = true,
    ["model"] = 534758478,
    ["coords"] = vector3(-1879.16, 2056.40, 141.14),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "winetime_winery" },
        ["groups"] = {
            ["winetime_winery"] = 1,
        },
    },
}

DOORS[8006] = { -- Fridge 1
    ["active"] = true,
    ["model"] = 988364535,
    ["coords"] = vector3(-1864.2130126953, 2061.2651367188, 141.14559936523),
    ["lock"] = 1,       
    ["automatic"] = {},
    ["double"] = 8007,
    ["access"] = {
        ["job"] = { "winetime_winery" },
        ["groups"] = {
            ["winetime_winery"] = 3,
        },
    },
}

DOORS[8007] = { -- Fridge 2
    ["active"] = true,
    ["model"] = -1141522158,
    ["coords"] = vector3(-1864.1999511719, 2059.8989257812, 141.14520263672),
    ["lock"] = 1,
    ["automatic"] = {},
    ["double"] = 8006,
    ["access"] = {
        ["job"] = { "winetime_winery" },
        ["groups"] = {
            ["winetime_winery"] = 3,
        },
    },
}