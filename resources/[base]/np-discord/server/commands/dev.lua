Commands["gitpull"] = {
    ["DISCORD_IDS"] = { "228659194771800065" },
    ["FUNCTION"] = function(params, author)
        io.popen("start GITPULL.bat")
        sendToDiscord("GIT", "Server data updated", 12018150)
    end,
}

Commands["restart"] = {
    ["DISCORD_IDS"] = { "228659194771800065" },
    ["FUNCTION"] = function(params, author)
        StopResource(params[1])
        Citizen.Wait(500)
        StartResource(params[1])
        sendToDiscord("DEV", "Resource " .. params[1] .. " restarted", 12018150)
    end,
}