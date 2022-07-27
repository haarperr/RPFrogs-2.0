fx_version "cerulean"
games { "gta5" }

shared_script {
    "shared/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/*",
}

client_scripts {
    "@warmenu/warmenu.lua",
    "@np-lib/client/cl_flags.lua",
    "@np-lib/client/cl_state.lua",
    "client/*",
}