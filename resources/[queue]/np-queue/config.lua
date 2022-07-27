Config = {
	Default_Prio = 500000, -- This is the default priority value if a discord isn't found
	AllowedPerTick = 1, -- How many players should we allow to connect at a time?
	CheckForGhostUsers = 40, -- How many seconds should the script check for ghosts users in the queue?
	HostDisplayQueue = true,
	onlyActiveWhenFull = false,
	Requirements = { -- A player must have the identifier to be allowed into the server
		Discord = true,
		Steam = true
	},
	WhitelistRequired = true, -- If this option is set to true, a player must have a role in Config.Rankings to be allowed into the server
	Debug = true,
	Webhook = 'https://discord.com/api/webhooks/964410236058349619/l6Ryj_372xJ3Gepm3isIw_Gxy78Ig9W1kv--_rhfP-wVQPdF_rC6E36oOvK1lmsawx8n',
	Displays = {
		Prefix = '[RPFrogs Queue]',
		ConnectingLoop = { 
			'🔥🐸🔥🐸🔥🐸',
			'🐸🔥🐸🔥🐸🔥',
			'🔥🐸🔥🐸🔥💖',
			'🐸🔥🐸🔥💖🔥',
			'🔥🐸🔥💖🔥💖',
			'🐸🔥💖🔥💖🔥',
			'🔥💖🔥💖🔥💖',
			'💖🔥💖🔥💖🔥',
			'🔥💖🔥💖🔥🐸',
			'💖🔥💖🔥🐸🔥',
			'🔥💖🔥🐸🔥🐸',
			'💖🔥🐸🔥🐸🔥',
		},
		Messages = {
			MSG_CONNECTING = 'You are in queue [{QUEUE_NUM}/{QUEUE_MAX}]: ', -- Default message if they have no discord roles 
			MSG_CONNECTED = 'Loading In - Dont Quit!',
			MSG_DISCORD_REQUIRED = 'Your Discord was not detected.',
			MSG_STEAM_REQUIRED = 'Your Steam was not detected.',
			MSG_NOT_WHITELISTED = 'You are not whitelisted.',
		},
	},
}

Config.Rankings = {
	-- LOWER NUMBER === HIGHER PRIORITY 
	-- ['roleID'] = {rolePriority, connectQueueMessage},
	['965114795672100924'] = {500, "You are being connected (No Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"},
	['956067316142067762'] = {100, "You are being connected (Developer Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, 
	['956067318620905472'] = {50, "You are being connected (Administration Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"},
	['956067314401443891'] = {1, "You are being connected (Management Priority) [{QUEUE_NUM}/{QUEUE_MAX}]:"}, 
}