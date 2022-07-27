fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "shared/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*",
}

client_scripts {
    "@np-lib/client/cl_state.lua",
    "client/*",
}