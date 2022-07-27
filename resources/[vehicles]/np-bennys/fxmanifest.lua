fx_version "cerulean"
games { "gta5" }

ui_page "core/client/ui/html/index.html"

files {
    "core/client/ui/html/index.html",
    "core/client/ui/html/css/menu.css",
    "core/client/ui/html/js/ui.js",
    "core/client/ui/html/imgs/logo.png",
    "core/client/ui/html/sounds/wrench.ogg",
    "core/client/ui/html/sounds/respray.ogg"
}

shared_scripts {
    "@np-lib/shared/sh_util.lua",
}

server_scripts {
    "@np-lib/server/sv_rpc.lua",
    "core/_config/cfg_vehicleCustomisation.lua",
    "core/server/sv_bennys.lua",
}

client_scripts {
    "@np-lib/client/cl_rpc.lua",
    "core/_config/cfg_vehicleCustomisation.lua",
    "core/_config/cfg_vehiclePresets.lua",
    "core/client/ui/cl_ui.lua",
    "core/client/cl_*.lua",
}