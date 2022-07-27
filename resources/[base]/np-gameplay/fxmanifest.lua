fx_version "cerulean"
games { "gta5" }

shared_script {
    "shared/*",
}

server_scripts {
    "server/*",
}

client_scripts {
    "@np-sync/client/cl_lib.lua",
    "client/*",
}