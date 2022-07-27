fx_version "cerulean"
games { "gta5" }

lua54 "yes"

resource_type "gametype" { name = "np" }

server_scripts {
    "server/sv_variables.lua",
    "server/sv_init.lua",
    "server/sv_cron.lua",
    "server/sv_restart.lua",
}

client_scripts {
    "client/cl_variables.lua",
    "client/cl_init.lua",
}

export "getModule"