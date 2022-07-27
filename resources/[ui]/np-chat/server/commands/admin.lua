Commands["menu"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("np:openmodmenu", source)
    end,
    ["suggestion"] = {
        ["help"] = "Open admin menu",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "trusted", "moderator", "admin", "spec", "dev", "owner" },
    },
}

Commands["pzcreate"] = {
    ["function"] = function(source, args)
        local zoneType = args[1]

        if zoneType == nil then
            TriggerEvent("chat:addMessage", {
                color = { 255, 0, 0},
                multiline = true,
                args = {"Me", "Please add zone type to create (poly, circle, box)!"}
            })
            return
        end

        if zoneType ~= "poly" and zoneType ~= "circle" and zoneType ~= "box" then
            TriggerEvent("chat:addMessage", {
                color = { 255, 0, 0},
                multiline = true,
                args = {"Me", "Zone type must be one of: poly, circle, box"}
            })
            return
        end

        local name = args[2]

        if name == nil or name == "" then
            TriggerEvent("chat:addMessage", {
                color = { 255, 0, 0},
                multiline = true,
                args = {"Me", "Please add a name!"}
            })
            return
        end

        TriggerClientEvent("polyzone:pzcreate", source, zoneType, name, args)
    end,
    ["suggestion"] = {
        ["help"] = "Starts creation of a zone for PolyZone of one of the available types: circle, box, poly",
        ["params"] = {
            { name="type", help="Zone Type (required)"},
            { name="name", help="Zone Name (required)"},
        },
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["pzadd"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("polyzone:pzadd", source)
    end,
    ["suggestion"] = {
        ["help"] = "Adds point to zone.",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["pzundo"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("polyzone:pzundo", source)
    end,
    ["suggestion"] = {
        ["help"] = "Undoes the last point added.",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["pzfinish"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("polyzone:pzfinish", source)
    end,
    ["suggestion"] = {
        ["help"] = "Finishes and prints zone.",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["pzlast"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("polyzone:pzlast", source)
    end,
    ["suggestion"] = {
        ["help"] = "Starts creation of the last zone you finished (only works on BoxZone and CircleZone)",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["pzcancel"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("polyzone:pzcancel", source)
    end,
    ["suggestion"] = {
        ["help"] = "Cancel zone creation.",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["pzcomboinfo"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("polyzone:pzcomboinfo", source)
    end,
    ["suggestion"] = {
        ["help"] = "Prints some useful info for all created ComboZones",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["door"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("np-doors:add", source)
    end,
    ["suggestion"] = {
        ["help"] = "add door",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["p"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("SaveCommand", source, args)
    end,
    ["suggestion"] = {
        ["help"] = "save pos",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}

Commands["po"] = {
    ["function"] = function(source, args)
        TriggerClientEvent("coordOffset", source, args)
    end,
    ["suggestion"] = {
        ["help"] = "save pos offset",
    },
    ["condition"] = {
        ["type"] = "ADMIN",
        ["params"] = { "dev" },
    },
}