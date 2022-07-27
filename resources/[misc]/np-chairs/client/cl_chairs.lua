--[[

    Variables

]]

local ChairZones = {
    -- Townhall
    {vector3(-569.06, -193.6, 38.22), 0.4, 0.4, { zOffset=0.5, name="townhalloffice1", heading=201.8, minZ=37.55, maxZ=38.12}},
    {vector3(-522.21, -195.98, 38.22), 0.4, 0.4, { zOffset=0.45, name="townhalloffice2", heading=298.5, minZ=37.55, maxZ=38.12}},
    {vector3(-1816.51, 444.74, 128.44), 0.4, 0.6, { zOffset=0.55, name="manor1", heading=358.9, minZ=127.44, maxZ=128.44}},
    {vector3(-1818.7, 444.54, 128.42), 0.4, 0.6, { zOffset=0.55, name="manor2", heading=308, minZ=127.42, maxZ=128.44}},

    --Prison
    { vector3(1790.956, 2557.24, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1790.214, 2557.24, 45.347), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1789.472, 2557.24, 45.349), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1788.729, 2557.24, 45.352), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1790.962, 2555.24, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1790.243, 2555.24, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1789.523, 2555.24, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1788.803, 2555.24, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1791.144, 2548.95, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1790.427, 2548.95, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1789.711, 2548.95, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1788.995, 2548.95, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1791.162, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1790.438, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1789.714, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1788.989, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2545.555, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2546.236, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2546.922, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2547.608, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2548.294, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2548.988, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2549.666, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1787.30, 2550.352, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2545.534, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2546.223, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2546.913, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2547.602, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2548.292, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2548.981, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2549.675, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1785.41, 2550.365, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2545.539, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2546.224, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2546.909, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2547.594, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2548.279, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2548.964, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2549.649, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1783.15, 2550.334, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2545.537, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2546.227, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2546.916, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2547.606, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2548.296, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2548.985, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2549.675, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.24, 2550.365, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1776.682, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1777.384, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1778.085, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1778.787, 2547.00, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=0.0, minZ=44.67, maxZ=45.87} },
    { vector3(1776.668, 2548.93, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1777.372, 2548.93, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1778.077, 2548.93, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1778.782, 2548.93, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=180.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.69, 2555.542, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.69, 2556.227, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.69, 2556.913, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1781.69, 2557.598, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=90.0, minZ=44.67, maxZ=45.87} },
    { vector3(1779.83, 2557.573, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1779.83, 2556.902, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1779.83, 2556.235, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1779.83, 2555.559, 45.344), 0.5, 0.5, { zOffset=0.175, name="prisoncafeteria", heading=270.0, minZ=44.67, maxZ=45.87} },
    { vector3(1752.946, 2539.704, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1753.546, 2540.105, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1754.145, 2540.406, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1754.744, 2540.802, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1755.343, 2541.108, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1755.943, 2541.504, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1756.542, 2541.805, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1757.141, 2542.106, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1756.314, 2543.694, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1755.695, 2543.393, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1755.077, 2543.091, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1754.458, 2542.699, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1753.839, 2542.397, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1753.221, 2541.995, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1752.602, 2541.694, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.983, 2541.392, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1749.814, 2545.707, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1750.412, 2546.006, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.015, 2546.306, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.608, 2546.706, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1752.206, 2547.005, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1752.804, 2547.305, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1753.402, 2547.704, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1754.005, 2548.004, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1753.104, 2549.598, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1752.502, 2549.295, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.901, 2548.992, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.355, 2548.594, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1750.699, 2548.296, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1750.098, 2547.897, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1749.497, 2547.595, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1748.896, 2547.291, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1747.661, 2549.403, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1748.265, 2549.804, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1748.858, 2550.105, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1749.456, 2550.406, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1750.054, 2550.807, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1750.652, 2551.108, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.255, 2551.509, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.848, 2551.809, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=30.0, minZ=44.67, maxZ=45.87} },
    { vector3(1746.774, 2550.996, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1747.386, 2551.395, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1747.998, 2551.695, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1748.615, 2552.099, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1749.222, 2552.393, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1749.833, 2552.798, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1750.445, 2553.092, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
    { vector3(1751.057, 2553.496, 45.344), 0.5, 0.5, { zOffset=0.3, name="prisoncafeteria", heading=210.0, minZ=44.67, maxZ=45.87} },
}

local previousPosition = nil
local isSitting = false

--[[

    Functions

]]

function chairSit(chairPosition, cancel)
    local ped = PlayerPedId()
    if isSitting then
        if cancel then
            TriggerEvent("animation:cancel")
        end

        Wait(1500)
        if previousPosition ~= nil and IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT") then
            SetEntityCoords(ped, previousPosition.x, previousPosition.y, previousPosition.z, 0, 0, 0, false)
        end
        previousPosition = nil
        isSitting = false
        TriggerEvent("np-polychair:stopSitting")
    else
        if chairPosition == nil then return end
        --Save old location
        previousPosition = GetEntityCoords(ped)
        --Set player position to chair
        local zone = ChairZones[chairPosition]
        local pos = zone[1]
        local heading = (zone[4].heading) * 1.0
        SetEntityHeading(ped, heading)

        isSitting = true

        local zOffset = zone[4].zOffset
        if zone[4].data then
            local dict = zone[4].data.dict
            local anim = zone[4].data.anim
            loadAnimDict(dict)
            TaskPlayAnimAdvanced(ped, dict, anim, pos.x, pos.y, pos.z - zOffset, 0.0, 0.0, heading + 0.0, 8.0, 8.0, -1, 1, 0, 1, 0)
        else
            TaskStartScenarioAtPosition(ped, "PROP_HUMAN_SEAT_CHAIR_UPRIGHT", pos.x, pos.y, pos.z - zOffset, heading, -1, true, true)
        end
        TriggerEvent("np-polychair:startSitting")
    end
    exports["np-flags"]:SetPedFlag(ped, "isSittingOnChair", isSitting)
end

--[[

    Events

]]

AddEventHandler("np-polychair:chairSit", function(pParameters, pEntity, pContext)
    chairSit(pParameters.chairPosition, true)
end)

AddEventHandler("np-emotes:sitOnChair", function(pArgs, pEntity, pContext)
    chairSit(nil, true)
end)

AddEventHandler("turnoffsitting", function()
	chairSit(nil, false)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    for idx, polyTarget in ipairs(ChairZones) do
        exports["np-polytarget"]:AddBoxZone("np-polychair:chair_" .. tostring(idx) .. "-" .. tostring(polyTarget[4].name), polyTarget[1], polyTarget[2], polyTarget[3], polyTarget[4])
    end
end)

Citizen.CreateThread(function()
    for idx ,polyTarget in ipairs(ChairZones) do
        exports["np-eye"]:AddPeekEntryByPolyTarget("np-polychair:chair_" .. tostring(idx) .. "-".. tostring(polyTarget[4].name), {{
            event = "np-polychair:chairSit",
            id = "poly_chair_" .. tostring(idx) .. "_" .. tostring(polyTarget[4].name),
            icon = "chair",
            label = "sit",
            parameters = {chairPosition = idx, chairName = polyTarget[4].name}
        }}, { distance = { radius = 3.0 }})
    end
end)