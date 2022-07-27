fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files {
	"html/*.html",
	"html/*.css",
	"html/*.js",
	"html/*.png",
}

shared_scripts {
	"shared/*",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server/*",
}

client_scripts {
	"client/*",
}