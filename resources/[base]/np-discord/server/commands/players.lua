Commands["players"] = {
    ["DISCORD_IDS"] = { "228659194771800065" },
    ["FUNCTION"] = function(params, author)
        local description = ""
        local players = GetPlayers()

        description = "**TOTAL:** " .. GetNumPlayerIndices()

        for i, v in ipairs(players) do
            description = description .. "\n[" .. v .. "] " .. GetPlayerName(v)
        end

        sendToDiscord("Players", description, 4620980)
    end,
}