fx_version "cerulean"
games { "gta5" }

shared_script {
    "shared/*",
}

server_scripts {
    "@np-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@np-lib/client/cl_rpc.lua",
    "client/*",
}