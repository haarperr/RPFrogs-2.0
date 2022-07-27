DOORS = DOORS or {}

-- Front Doors Left
DOORS[3001] = {
    ["active"] = true,
    ["model"] = 2059227086,
    ["coords"] = vector3(-39.25, -1108.71, 26.72),
    ["lock"] = 0,
    ["automatic"] = {},
    ["access"] = {
        ["groups"] = {
            ["pdm"] = 1,
        },
    },
    ["double"] = 3002,
}

-- Front Doors Right
DOORS[3002] = {
    ["active"] = true,
    ["model"] = 1417577297,
    ["coords"] = vector3(-37.33, -1108.87, 26.72),
    ["lock"] = 0,
    ["automatic"] = {},
    ["access"] = {
        ["groups"] = {
            ["pdm"] = 1,
        },
    },
    ["double"] = 3001,
}

-- Left Doors Left
DOORS[3003] = {
    ["active"] = true,
    ["model"] = 1417577297,
    ["coords"] = vector3(-60.55, -1094.75, 26.89),
    ["lock"] = 0,
    ["automatic"] = {},
    ["access"] = {
        ["groups"] = {
            ["pdm"] = 1,
        },
    },
    ["double"] = 3004,
}

-- Left Doors Right
DOORS[3004] = {
    ["active"] = true,
    ["model"] = 2059227086,
    ["coords"] = vector3(-59.54, -1093.38, 26.89),
    ["lock"] = 0,
    ["automatic"] = {},
    ["access"] = {
        ["groups"] = {
            ["pdm"] = 1,
        },
    },
    ["double"] = 3003,
}

-- Manager
DOORS[3005] = {
    ["active"] = true,
    ["model"] = -2051651622,
    ["coords"] = vector3(-31.72, -1101.85, 26.57),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["groups"] = {
            ["pdm"] = 3,
        },
    },
}

-- Owner
DOORS[3006] = {
    ["active"] = true,
    ["model"] = -2051651622,
    ["coords"] = vector3(-33.81, -1107.58, 26.57),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["groups"] = {
            ["pdm"] = 4,
        },
    },
}