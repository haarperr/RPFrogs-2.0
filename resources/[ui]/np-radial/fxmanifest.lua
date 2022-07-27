fx_version "cerulean"
games { "gta5" }

ui_page "html/ui.html"

files {
    "html/ui.html",
    "html/js/*.js",
    "html/css/*.css",
    "html/webfonts/*.eot",
    "html/webfonts/*.svg",
    "html/webfonts/*.ttf",
    "html/webfonts/*.woff",
    "html/webfonts/*.woff2",
}

shared_scripts {
    "@np-lib/shared/sh_models.lua",
    "@np-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "server/*",
}

client_scripts {
    "@np-lib/client/cl_state.lua",
    "client/*",
    "client/entries/*",
}