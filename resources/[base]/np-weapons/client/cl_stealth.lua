local StealthKills = {
    "ACT_stealth_kill_a",
    "ACT_stealth_kill_weapon",
    "ACT_stealth_kill_b",
    "ACT_stealth_kill_c",
    "ACT_stealth_kill_d",
    "ACT_stealth_kill_a_gardener"
}

Citizen.CreateThread(function()
    for _, killName in ipairs(StealthKills) do
        local hash = GetHashKey(killName)
        RemoveStealthKill(hash, false)
    end
end)