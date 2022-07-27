fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "@np-lib/shared/sh_util.lua",
    "shared/*.*"
}

server_scripts {
    "server/*.*"
}

client_scripts {
    "@np-lib/client/cl_flags.lua",
    "@np-lib/client/cl_rpc.lua",
    "client/classes/*.*",
    "client/*.*",
}