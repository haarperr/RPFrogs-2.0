fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "@np-lib/shared/sh_ids.lua",
    "shared/*",
}

server_scripts {
    "@np-lib/server/sv_infinity.lua",
    "server/*",
}

client_scripts {
    "@warmenu/warmenu.lua",
    "@np-lib/client/cl_infinity.lua",
    "client/*",
}