Commands["emotes"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("dpemotes:emotes", source)
    end,
    ["suggestion"] = {
        ["help"] = "Open emotes menu.",
    },
    ["condition"] = {
        ["type"] = "ALL",
        ["params"] = {},
    },
}

Commands["e"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("dpemotes:e", source, args)
    end,
    ["suggestion"] = {
        ["help"] = "Play an emote.",
        ["params"] = {
            { name="emotename", help="Use /emotes to see all emotes."},
        },
    },
    ["condition"] = {
        ["type"] = "ALL",
        ["params"] = {},
    },
}

Commands["emotebinds"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("dpemotes:binds", source)
    end,
    ["suggestion"] = {
        ["help"] = "Check your currently bound emotes.",
    },
    ["condition"] = {
        ["type"] = "ALL",
        ["params"] = {},
    },
}

Commands["emotebind"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("dpemotes:bind", source, args)
    end,
    ["suggestion"] = {
        ["help"] = "Bind an emote.",
        ["params"] = {
            { name="key", help="num4, num5, num6, num7. num8, num9. Numpad 4-9!"},
            { name="emotename", help="Use /emotes to see all emotes."},
        },
    },
    ["condition"] = {
        ["type"] = "ALL",
        ["params"] = {},
    },
}