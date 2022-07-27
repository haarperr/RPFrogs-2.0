fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files {
    "html/index.html",
    "html/script.js",
    "html/style.css",
    "html/doorL1.png",
    "html/doorL2.png",
    "html/doorR1.png",
    "html/doorR2.png",
    "html/hood.png",
    "html/trunk.png",
    "html/seat.png",
    "html/windowL1.png",
    "html/windowL2.png",
    "html/windowR1.png",
    "html/windowR2.png",
    "html/buttonOff.png",
    "html/buttonOn.png",
    "html/buttonHover.png",
    "html/engine.png",
}

shared_scripts {
    "shared/*",
}

server_scripts {
    "server/*",
}

client_scripts {
    "@np-sync/client/cl_lib.lua",
    "client/*",
}