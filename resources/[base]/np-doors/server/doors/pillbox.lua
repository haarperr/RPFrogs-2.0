DOORS = DOORS or {}

-- Front Left
DOORS[2001] = {
    ["active"] = false,
    ["model"] = 661758796,
    ["coords"] = vector3(300.43, -582.62, 42.28),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2002,
}

-- Front Right
DOORS[2002] = {
    ["active"] = false,
    ["model"] = -487908756,
    ["coords"] = vector3(298.83, -587.04, 42.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2001,
}

-- Reception
DOORS[2003] = {
    ["active"] = false,
    ["model"] = 854291622,
    ["coords"] = vector3(313.48, -595.46, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Staff Only
DOORS[2004] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(309.13, -597.75, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Cloakroom
DOORS[2005] = {
    ["active"] = false,
    ["model"] = 854291622,
    ["coords"] = vector3(303.91, -596.58, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Restroom
DOORS[2006] = {
    ["active"] = false,
    ["model"] = 854291622,
    ["coords"] = vector3(298.95, -594.77, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Ward A Left
DOORS[2007] = {
    ["active"] = false,
    ["model"] = -434783486,
    ["coords"] = vector3(302.88, -581.05, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2008,
}

-- Ward A Right
DOORS[2008] = {
    ["active"] = false,
    ["model"] = -1700911976,
    ["coords"] = vector3(305.22, -582.31, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2007,
}

-- Closet
DOORS[2009] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(304.46, -572.62, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Laboratory
DOORS[2010] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(307.12, -569.57, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Surgery 1 Left
DOORS[2011] = {
    ["active"] = true,
    ["model"] = -434783486,
    ["coords"] = vector3(312.01, -571.34, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2012,
}

-- Surgery 1 Right
DOORS[2012] = {
    ["active"] = true,
    ["model"] = -1700911976,
    ["coords"] = vector3(314.42, -572.22, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2011,
}

-- Surgery 2 Left
DOORS[2013] = {
    ["active"] = true,
    ["model"] = -434783486,
    ["coords"] = vector3(317.84, -573.47, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2014,
}

-- Surgery 2 Right
DOORS[2014] = {
    ["active"] = true,
    ["model"] = -1700911976,
    ["coords"] = vector3(320.26, -574.35, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2013,
}

-- Surgery 3 Left
DOORS[2015] = {
    ["active"] = true,
    ["model"] = -434783486,
    ["coords"] = vector3(323.24, -575.43, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2016,
}

-- Surgery 3 Right
DOORS[2016] = {
    ["active"] = true,
    ["model"] = -1700911976,
    ["coords"] = vector3(325.52, -576.71, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2015,
}

-- Intense Care Left
DOORS[2017] = {
    ["active"] = false,
    ["model"] = -434783486,
    ["coords"] = vector3(318.48, -579.23, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2018,
}

-- Intense Care Right
DOORS[2018] = {
    ["active"] = false,
    ["model"] = -1700911976,
    ["coords"] = vector3(316.07, -578.35, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2017,
}

-- Ward B Left
DOORS[2019] = {
    ["active"] = false,
    ["model"] = -434783486,
    ["coords"] = vector3(326.55, -578.04, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2020,
}

-- Ward B Right
DOORS[2020] = {
    ["active"] = false,
    ["model"] = -1700911976,
    ["coords"] = vector3(325.67, -580.46, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2019,
}

-- Main Hall Left
DOORS[2021] = {
    ["active"] = false,
    ["model"] = -434783486,
    ["coords"] = vector3(324.24, -589.23, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2022,
}

-- Main Hall Right
DOORS[2022] = {
    ["active"] = false,
    ["model"] = -1700911976,
    ["coords"] = vector3(326.65, -590.11, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2021,
}

-- Restroom Men
DOORS[2023] = {
    ["active"] = false,
    ["model"] = 854291622,
    ["coords"] = vector3(329.28, -585.99, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Restroom Woman
DOORS[2024] = {
    ["active"] = false,
    ["model"] = 854291622,
    ["coords"] = vector3(328.70, -587.31, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- MRI
DOORS[2025] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(336.16, -580.14, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Diagnostics
DOORS[2026] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(340.78, -581.82, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Xray
DOORS[2027] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(346.77, -584.00, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Administration
DOORS[2028] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(339.00, -586.70, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Director Office
DOORS[2029] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(336.79, -593.07, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Ward C left
DOORS[2030] = {
    ["active"] = true,
    ["model"] = -434783486,
    ["coords"] = vector3(348.81, -586.4, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2031,
}

-- Ward C Right
DOORS[2031] = {
    ["active"] = true,
    ["model"] = -1700911976,
    ["coords"] = vector3(348.06, -588.65, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2030,
}

-- Private Room 369
DOORS[2032] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(357.49, -579.61, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Private Room 370
DOORS[2033] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(356.13, -583.36, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Patient Room 371
DOORS[2034] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(360.50, -589.00, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Dr Office 372
DOORS[2035] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(358.73, -593.88, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Dr Office 373
DOORS[2036] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(352.20, -594.15, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Private Room 374
DOORS[2037] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(350.83, -597.90, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Restroom Accessibility
DOORS[2038] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(345.52, -597.35, 43.43),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Treatment
DOORS[2039] = {
    ["active"] = true,
    ["model"] = 854291622,
    ["coords"] = vector3(347.4, -593.62, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Ward D Left
DOORS[2040] = {
    ["active"] = false,
    ["model"] = -434783486,
    ["coords"] = vector3(327.71, -592.61, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2041,
}

-- Ward D Right
DOORS[2041] = {
    ["active"] = false,
    ["model"] = -1700911976,
    ["coords"] = vector3(326.84, -595.04, 43.29),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2040,
}

-- Lower Front Left
DOORS[2042] = {
    ["active"] = false,
    ["model"] = 661758796,
    ["coords"] = vector3(356.53, -591.60, 27.79),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2043,
}

-- Lower Front Right
DOORS[2043] = {
    ["active"] = false,
    ["model"] = -487908756,
    ["coords"] = vector3(357.34, -589.39, 27.79),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2042,
}

-- Lower Reception
DOORS[2044] = {
    ["active"] = false,
    ["model"] = 854291622,
    ["coords"] = vector3(348.55, -585.16, 28.95),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
}

-- Lower Hallway 1 Left
DOORS[2045] = {
    ["active"] = false,
    ["model"] = -434783486,
    ["coords"] = vector3(345.79, -592.72, 28.95),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2046,
}

-- Lower Hallway 1 Right
DOORS[2046] = {
    ["active"] = false,
    ["model"] = -1700911976,
    ["coords"] = vector3(347.07, -590.57, 28.8),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2045,
}

-- Lower Hallway 2 Left
DOORS[2047] = {
    ["active"] = false,
    ["model"] = -434783486,
    ["coords"] = vector3(349.46, -583.95, 28.8),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2048,
}

-- Lower Hallway 2 Right
DOORS[2048] = {
    ["active"] = false,
    ["model"] = -1700911976,
    ["coords"] = vector3(350.22, -581.62, 28.8),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2047,
}

-- Ambulance Garage Left
DOORS[2049] = {
    ["active"] = true,
    ["model"] = -434783486,
    ["coords"] = vector3(338.88, -590.19, 28.8),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2050,
}

-- Ambulance Garage Right
DOORS[2050] = {
    ["active"] = true,
    ["model"] = -1700911976,
    ["coords"] = vector3(339.71, -587.74, 28.8),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2049,
}

-- Lower Backdoor Left
DOORS[2051] = {
    ["active"] = true,
    ["model"] = -1421582160,
    ["coords"] = vector3(320.68, -559.51, 28.75),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2052,
}

-- Lower Backdoor Right
DOORS[2052] = {
    ["active"] = true,
    ["model"] = 1248599813,
    ["coords"] = vector3(318.46, -560.66, 28.75),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["double"] = 2051,
}

-- Lower Garage Left
DOORS[2053] = {
    ["active"] = true,
    ["model"] = -820650556,
    ["coords"] = vector3(337.23, -564.27, 28.8),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["keyFob"] = true,
}

-- Lower Garage Right
DOORS[2054] = {
    ["active"] = true,
    ["model"] = -820650556,
    ["coords"] = vector3(330.08, -561.61, 28.8),
    ["lock"] = 1,
    ["automatic"] = {},
    ["access"] = {
        ["job"] = { "is_medic" },
    },
    ["keyFob"] = true,
}