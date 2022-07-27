fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files {
	"html/*.html",
	"html/*.js",
	"html/*.css",
}

shared_scripts {
	"@np-lib/shared/sh_util.lua",
	"shared/*",
}

server_scripts {
	"@np-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
	"@np-lib/client/cl_rpc.lua",
	"client/*",
}