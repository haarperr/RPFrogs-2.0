fx_version "cerulean"
games { "gta5" }

dependencies {
    "PolyZone"
}

shared_script {
    "shared/*",
}

server_scripts {
    "@np-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "config.lua",
    "@PolyZone/client.lua",
    "@PolyZone/BoxZone.lua",
    "@PolyZone/CircleZone.lua",
    "@PolyZone/ComboZone.lua",
    "@PolyZone/EntityZone.lua",
    "@np-lib/client/cl_rpc.lua",
    "client/*",
}

export "getModule"