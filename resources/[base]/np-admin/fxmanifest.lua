fx_version 'cerulean'
game 'gta5'

description 'Admin Menu'

ui_page "nui/index.html"

client_scripts {
    "@np-lib/client/cl_infinity.lua",
    "@np-lib/client/cl_polyhooks.lua",
    "@np-lib/client/cl_rpc.lua",
    "@np-lib/client/cl_vehicles.lua",
    "@np-lib/client/cl_ui.lua",
    "@np-lib/client/cl_flags.lua",
    "@np-lib/client/cl_polyhooks.lua",
    'client/cl_*.lua',
}

shared_script {
    "@np-base/client/cl_variables.lua",
    "@np-lib/shared/sh_ids.lua",
    "@np-lib/shared/sh_util.lua",
    'shared/sh_*.lua',
}

server_scripts {
    "@np-lib/server/sv_character.lua",
    "@np-lib/server/sv_infinity.lua",
    "@np-lib/server/sv_rpc.lua",
    "@oxmysql/lib/MySQL.lua",
    'server/sv_*.lua',
}

files {
    "nui/index.html",
    "nui/js/*.js",
    "nui/css/*.css",
    "nui/webfonts/*.css",
    "nui/webfonts/*.otf",
    "nui/webfonts/*.ttf",
    "nui/webfonts/*.woff2",
}

dependencies {
    'oxmysql',
}

lua54 'yes'