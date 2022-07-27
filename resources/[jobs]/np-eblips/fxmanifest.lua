fx_version "cerulean"
games { "gta5" }

shared_script {
    "shared/*",
}

server_scripts {
    "@np-lib/server/sv_rpc.lua",
    "@np-lib/server/sv_infinity.lua",
    "server/*",
}

client_scripts {
    "@np-lib/client/cl_rpc.lua",
    "@np-infinity/client/classes/blip.lua",
    "@np-lib/client/cl_infinity.lua",
    "client/*",
}