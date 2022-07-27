fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files {
	"html/*.html",
	"html/*.css",
	"html/*.js",
	"html/images/*.png",
	"html/fonts/roboto/*.woff",
	"html/fonts/roboto/*.woff2",
	"html/fonts/justsignature/JustSignature.woff",
}

shared_scripts {
    "shared/*",
}

server_scripts {
	"server/*",
}

client_scripts {
	"@np-lib/client/cl_animTask.lua",
    "client/*",
}