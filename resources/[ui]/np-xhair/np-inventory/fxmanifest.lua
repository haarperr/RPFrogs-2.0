fx_version "cerulean"
games { "gta5" }

ui_page "nui/ui.html"

files {
    "nui/ui.html",
    "nui/pricedown.ttf",
    "nui/default.png",
    "nui/background.png",
    "nui/weight-hanging-solid.png",
    "nui/hand-holding-solid.png",
    "nui/search-solid.png",
    "nui/invbg.png",
    "nui/styles.css",
    "nui/scripts.js",
    "nui/debounce.min.js",
    "nui/loading.gif",
    "nui/loading.svg",
    "nui/icons/*",
}

shared_scripts {
    "@np-lib/shared/sh_util.lua",
    "@np-lib/shared/sh_cacheable.js",
    "shared/sh_*.*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "server/sv_clean.js",
    "server/sv_shops.js",
    "server/sv_main.js",
    "server/sv_*.*",
}

client_scripts {
    "@PolyZone/client.lua",
    "@np-lib/client/cl_rpc.js",
    "@np-lib/client/cl_rpc.lua",
    "client/cl_main.js",
    "client/cl_*.*",
}

export "taskBar"
export "closeGuiFail"