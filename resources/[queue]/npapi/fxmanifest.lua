fx_version 'cerulean'
game 'gta5'

author 'Vopori'
description 'Rewritten NP Discord API For RPFrogs 2.0'
version '1.6'
url 'https://github.com/podori'

client_scripts {
	'client.lua',
}

server_scripts {
	'config.lua',
	"server.lua", 
	
}

server_exports { 
	"GetDiscordRoles",
	"GetRoleIdFromRoleName",
	"GetDiscordAvatar",
	"GetDiscordName",
	"GetDiscordEmail",
	"IsDiscordEmailVerified",
	"GetDiscordNickname",
	"GetGuildIcon",
	"GetGuildSplash",
	"GetGuildName",
	"GetGuildDescription",
	"GetGuildMemberCount",
	"GetGuildOnlineMemberCount",
	"GetGuildRoleList",
	"ResetCaches",
	"CheckEqual"
} 
