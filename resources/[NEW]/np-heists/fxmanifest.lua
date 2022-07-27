fx_version 'cerulean'
games { 'gta5' }

dependencies {
  "mka-lasers"
}

client_scripts {
  '@np-errorlog/client/cl_errorlog.lua',
  '@np-sync/client/lib.lua',
  '@np-libh/client/cl_rpc.lua',
  '@np-libh/client/cl_ui.lua',
  '@np-libh/client/cl_animTask.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  '@mka-lasers/client/client.lua',
  '@mka-grapple/client.lua',
  'client/cl_*.lua',
}

shared_script {
  '@np-libh/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  'config.lua',
  '@np-libh/server/sv_rpc.lua',
  '@np-libh/server/sv_sql.lua',
  '@np-libh/server/sv_asyncExports.lua',
  'server/sv_*.lua',
}
