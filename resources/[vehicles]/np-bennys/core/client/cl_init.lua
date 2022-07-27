Citizen.CreateThread(function()
    -- MRPD
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(452.12, -975.34, 25.7), 5.4, 13.2, {
        minZ = 24.7,
        maxZ = 27.7,
    })

    -- Pillbox Hospital
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(340.49, -570.61, 28.8), 7.4, 4.2, {
        minZ = 27.7,
        maxZ = 31.7,
        heading = 340,
    })

    -- Hub
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-34.12, -1054.31, 28.4), 6.0, 12.4, {
        minZ = 27.4,
        maxZ = 33.0,
        heading = 312,
    })

     -- Paleto
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(110.8, 6626.46, 31.89), 7.4, 8, {
        minZ = 30.0,
        maxZ = 36.0,
        heading = 44.0,
    })

     -- Boats
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-809.83, -1507.21, 14.4), 14.2, 13.4, {
        minZ = -0.4,
        maxZ = 6.8,
        heading = 291,
        data = { type = "boats" },
    })

     -- Planes
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-1652.52, -3143.0, 13.99), 10, 10, {
        minZ = 12.99,
        maxZ = 16.99,
        heading = 240,
        data = { type = "planes" },
    })

     -- Rex
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(2522.64, 2621.78, 37.96), 7.4, 5.8, {
        minZ = 36.96,
        maxZ = 39.96,
        heading = 270,
    })

    -- PDM
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-211.88, -1323.91, 30.89), 8.4, 6.6, {
        minZ=29.0,
        maxZ=35.0
    })
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-222.03, -1329.82, 30.89), 3.8, 7.0, {
        minZ=29.89,
        maxZ=33.49,
    })

    -- -- Bridge
    -- exports["np-polyzone"]:AddBoxZone("bennys", vector3(731.57, -1088.78, 22.17), 5.0, 11.2, {
    --     minZ=21.0,
    --     maxZ=28.0
    -- })

  -- Tuner
  exports["np-polyzone"]:AddBoxZone("bennys", vector3(135.88, -3030.85, 7.04), 9.8, 4.8, {
     -- debugPoly=true,
      heading=0,
     })

    -- -- Import
    -- exports["np-polyzone"]:AddBoxZone("bennys", vector3(-771.46, -233.66, 37.08), 7.4, 8, {
    --     minZ=36.0,
    --     maxZ=42.0
    -- })

    -- State Police
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(1862.73, 3703.74, 33.62), 7.0, 5.8, {
        heading=29,
        minZ=32.42,
        maxZ=36.42
    })

    -- Sheriff
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-473.54, 6011.97, 31.34), 8.2, 4.2, {
        heading=46,
        minZ=30.34,
        maxZ=33.74
    })

    -- Park Ranger
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(380.51, 802.85, 188.67), 4.2, 6.4, {
        heading=0,
        minZ=186.67,
        maxZ=190.67
    })

    -- Criminal Investagtion
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-1115.67, -807.11, 3.75), 8.0, 3.8, {
        heading=36,
        minZ=2.75,
        maxZ=5.75
    })

    -- Fire Department
    exports["np-polyzone"]:AddBoxZone("bennys", vector3(-637.76, -100.33, 38.0), 9.8, 4.8, {
        heading=340,
        minZ=37.0,
        maxZ=41.0
    })
end)
