fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files {
    "html/*.html",
    "html/*.js",
    "html/*.css",
}

client_scripts {
    "cl_*.lua",
}

exports {
    "DrawNotify",
    "Clear"
}