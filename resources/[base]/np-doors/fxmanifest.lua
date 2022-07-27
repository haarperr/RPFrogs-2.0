fx_version "cerulean"
games { "gta5" }

shared_script {
    "@np-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "@np-lib/server/sv_rpc.lua",
    "server/doors/*",
    "server/elevators/*",
    "server/*",
}

client_scripts {
    "@np-lib/client/cl_rpc.lua",
    "@np-lib/client/cl_polyhooks.lua",
    "client/*",
}