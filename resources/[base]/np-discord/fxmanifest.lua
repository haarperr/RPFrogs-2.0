fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "@np-lib/shared/sh_util.lua",
    "@np-lib/shared/sh_ids.lua",
    "shared/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*",
    "server/commands/*",
}

client_scripts {
    "client/*",
}