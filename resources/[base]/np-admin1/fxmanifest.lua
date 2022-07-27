fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files({
    "html/index.html",
    "html/script.js",
    "html/styles.css"
})

client_script "@warmenu/warmenu.lua"
server_script "@oxmysql/lib/MySQL.lua"

client_script "@np-lib/client/cl_infinity.lua"
server_script "@np-lib/server/sv_infinity.lua"

shared_script "@np-lib/shared/sh_ids.lua"
server_script "@np-lib/server/sv_character.lua"

server_script "shared/sh_admin.lua"
server_script "shared/sh_commands.lua"
server_script "shared/sh_ranks.lua"

client_script "shared/sh_admin.lua"

client_script "client/cl_menu.lua"

client_script "shared/sh_commands.lua"
client_script "shared/sh_ranks.lua"

server_script "server/sv_db.lua"
server_script "server/sv_admin.lua"
server_script "server/sv_commands.lua"

client_script "client/cl_admin.lua"
client_script "client/cl_noclip.lua"
