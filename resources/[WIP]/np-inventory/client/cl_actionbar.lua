--[[

	Variables

]]

local focusTaken = false
local reDelayed = false
local prevupdate = 0
local cannotPullWeaponInAnimation = false
local CurrentSqlID = 0
local currentInformation = false
local UNARMED_HASH = `WEAPON_UNARMED`
local armed = false
local unholsteringactive = false
local lastWeaponDeg = 0
local shotRecently = false
local lastShot = 0
local isActionBarDisabled = false

local throwableWeapons = {
	["741814745"] = true,
	["-1600701090"] = true,
	["615608432"] = true,
	["1233104067"] = true,
	["2874559379"] = true,
	["126349499"] = true,
	["-73270376"] = true,
	["-1169823560"] = true,
	["2481070269"] = true,
	["-1813897027"] = true,
	["600439132"] = true,
	["1064738331"] = true,
	["-691061592"] = true,
	["600439132"] = true,
	["-828058162"] = true,
	["571920712"] = true,
	["-1569615261"] = true,
	["-37975472"] = true,
}

local ammoTypes = {
	["1788949567"] = 150, -- heavy ammo
	["1950175060"] = 36, -- pistol ammo
	["218444191"] = 60, -- rifle ammo
	["1285032059"] = 30, -- sniper ammo
	["-1878508229"] = 20, -- shotgun ammo
	["1820140472"] = 50, -- sub ammo
	["965225813"] = 30, -- nails ammo
	["-1575030772"] = 6, -- taser ammo
}

local excludedWeapons = {
	[`WEAPON_UNARMED`] = true,
	[`WEAPON_FIREEXTINGUISHER`] = true,
	[`WEAPON_FLARE`] = true,
	[`WEAPON_PetrolCan`] = true,
	[`WEAPON_STUNGUN`] = true,
	[-2009644972] = true, -- paintball gun bruv
	[1064738331] = true, -- bricked
	[-828058162] = true, -- shoed
	[571920712] = true, -- money
	[-691061592] = true, -- book
	[1834241177] = true, -- EMP Gun
	[1233104067] = true, -- Flare
	[600439132] = true, -- Lime
	[126349499] = true, -- Snowball
}

--[[

	Functions

]]

function actionBarDown()
	if focusTaken or reDelayed then return end

	TriggerEvent("inventory-bar", true)
end

function actionBarUp()
  	if focusTaken then return end

	reDelayed = true
  	TriggerEvent("inventory-bar", false)

  	Citizen.SetTimeout(2500, function()
		reDelayed = false
	end)
end

function AttachmentCheck(weaponhash)
	if exports["np-inventory"]:hasEnoughOfItem("weapon_silencer_assault", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_AR_SUPP` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_AR_SUPP_02` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0x3164BAB )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_silencer_pistol", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_PI_SUPP_02` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_PI_SUPP` )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_oil_silencer", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 1532150734 )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_scope", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_MEDIUM` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_MACRO` )
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, `COMPONENT_AT_SCOPE_SMALL` )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_uzi_extended", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0xE40F1CD2 )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_uzi_foldstock", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0x8FBBD54C )
	end

	if exports["np-inventory"]:hasEnoughOfItem("weapon_uzi_woodstock", 1, false, true) then
		GiveWeaponComponentToPed( PlayerPedId(), weaponhash, 0x722C6CA6 )
	end
end

function unholster1h(weaponHash, a, info)
	unholsteringactive = true

	local dict = "reaction@intimidation@1h"
	local anim = "intro"
	local ped = PlayerPedId()

	if exports["np-jobs"]:getJob(false, "is_police") then
		copunholster(weaponHash)

	    if weaponHash == 218362403 then
			SetPedWeaponTintIndex(ped, weaponHash, 6)
		end

	    if weaponHash == 3219281620 then
			GiveWeaponComponentToPed(PlayerPedId(), 3219281620, `COMPONENT_AT_PI_FLSH_02` )
	    end

	    if weaponHash == 736523883 then
        	GiveWeaponComponentToPed( ped, 736523883, `COMPONENT_AT_AR_FLSH` )
        	GiveWeaponComponentToPed( ped, 736523883, `COMPONENT_AT_SCOPE_MACRO_02` )
	    end

	    if weaponHash == -2084633992 then
        	GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_FLSH` )
        	GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_AR_AFGRIP` )
        	GiveWeaponComponentToPed( ped, -2084633992, `COMPONENT_AT_SCOPE_MEDIUM` )
		end

	    if weaponHash == 2024373456 then
        	GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_AR_FLSH` )
        	GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SIGHTS_SMG` )
        	GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_MUZZLE_01` )
        	GiveWeaponComponentToPed( ped, 2024373456, `COMPONENT_AT_SB_BARREL_02` )
	    end

	    if weaponHash == -86904375 then
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_AR_FLSH` )
	    	GiveWeaponComponentToPed( ped, -86904375, `COMPONENT_AT_SIGHTS` )
	    end

	    if weaponHash == -1075685676 then
	    	GiveWeaponComponentToPed( ped, -1075685676, `COMPONENT_AT_PI_FLSH_02` )
	    end

		if weaponHash == 1649403952 and info and info.componentVariant then
			local variants = {
			  	["1"] = 0xF605986F,
			}
			if variants[info.componentVariant] then
			  	GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
			end
		end

		if weaponHash == -1024456158 and info and info.componentVariant then
			local variants = {
				["1"] = 0xDF427E88,
				["2"] = 0x84276AFF,
				["3"] = 0x1122A82,
				["4"] = 0x12788BB7,
				["5"] = 0x475ECA83,
				["6"] = 0x2B65CEAD,
				["7"] = 0xFE52F3D7,
			}
			if variants[info.componentVariant] then
			  	GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
			end
		end

		AttachmentCheck(weaponHash)

	    Citizen.Wait(450)
		unholsteringactive = false
		cannotPullWeaponInAnimation = false

		return
	end

	RemoveAllPedWeapons(ped)

	if weaponHash ~= -538741184 and weaponHash ~= 615608432 then
		local animLength = GetAnimDuration(dict, anim) * 1000
	    loadAnimDict(dict)
	    TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
	    Citizen.Wait(900)
	    GiveWeaponToPed(ped, weaponHash, getAmmo(), 0, 1)
	    SetCurrentPedWeapon(ped, weaponHash, 1)
	else
		GiveWeaponToPed(ped, weaponHash, getAmmo(), 1, 0)
		SetCurrentPedWeapon(ped, weaponHash, 0)
	end

	if weaponHash == 218362403 then
		SetPedWeaponTintIndex(ped, weaponHash, 6)
	end

	if info and info.weaponTint then
		SetPedWeaponTintIndex(ped, weaponHash, info.weaponTint)
	end

	if weaponHash == 1692590063 and info and info.componentVariant then
	  	local variants = {
			["1"] = 0x6218EEB8,
			["2"] = 0xA4BF7400,
			["3"] = 0x3F2DA8E2, -- cursed katana, never use this one
			["4"] = 0x849233A6,
			["5"] = 0x83648BFB, -- Talon sword, don't use this
	  	}
	  	if variants[info.componentVariant] then
			GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
	  	end
	end

	if weaponHash == 1649403952 and info and info.componentVariant then
	  	local variants = {
			["1"] = 0xF605986F,
	  	}
	  	if variants[info.componentVariant] then
			GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
	  	end
	end

	if weaponHash == -1024456158 and info and info.componentVariant then
	  	local variants = {
			["1"] = 0xDF427E88,
			["2"] = 0x84276AFF,
			["3"] = 0x1122A82,
			["4"] = 0x12788BB7,
			["5"] = 0x475ECA83,
			["6"] = 0x2B65CEAD,
			["7"] = 0xFE52F3D7,
	  	}
	  	if variants[info.componentVariant] then
			GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
	  	end
	end

	if weaponHash == 3638508604 and info and info.componentVariant then
	  	local variants = {
			["1"] = 0xF3462F33,
			["2"] = 0xC613F685,
			["3"] = 0xEED9FD63,
			["4"] = 0x50910C31,
			["5"] = 0x9761D9DC,
			["6"] = 0x7DECFE30,
			["7"] = 0x3F4E8AA6,
			["8"] = 0x8B808BB,
			["9"] = 0xE28BABEF,
			["10"] = 0x7AF3F785,
	  	}
	  	if variants[info.componentVariant] then
			GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
	  	end
	end

	if weaponHash == 1317494643 and info and info.componentVariant then
	  	local variants = {
			["1"] = 0x904467BA,
	  	}
	  	if variants[info.componentVariant] then
			GiveWeaponComponentToPed(ped, weaponHash, variants[info.componentVariant])
	  	end
	end

    AttachmentCheck(weaponHash)
    Citizen.Wait(500)
    cannotPullWeaponInAnimation = false
    ClearPedTasks(ped)
    Citizen.Wait(1200)

    unholsteringactive = false
end

function copunholster(weaponHash)
	local dic = "reaction@intimidation@cop@unarmed"
	local anim = "intro"
	local ammoCount = 0

	loadAnimDict(dic)

	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped)

	TaskPlayAnim(ped, dic, anim, 10.0, 2.3, -1, 49, 1, 0, 0, 0 )

	Citizen.Wait(600)

	GiveWeaponToPed(ped, weaponHash, getAmmo(), 0, 1)

	SetCurrentPedWeapon(ped, weaponHash, 1)
	ClearPedTasks(ped)
end

function holster1h()
	unholsteringactive = true

	local dict = "reaction@intimidation@1h"
	local anim = "outro"

	if exports["np-jobs"]:getJob(false, "is_police") then
		copholster()
		Citizen.Wait(600)
		unholsteringactive = false
		cannotPullWeaponInAnimation = false
		return
	end

	local ped = PlayerPedId()
	prevupdate = 0
	local animLength = GetAnimDuration(dict, anim) * 1000
    loadAnimDict(dict)
    TaskPlayAnim(ped, dict, anim, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
    Citizen.Wait(animLength - 2200)

    SetCurrentPedWeapon(ped, UNARMED_HASH, 1)
    Citizen.Wait(300)
    RemoveAllPedWeapons(ped)
    ClearPedTasks(ped)
    Citizen.Wait(800)
	unholsteringactive = false
	cannotPullWeaponInAnimation = false
end

function copholster()
	local dic = "reaction@intimidation@cop@unarmed"
	local anim = "intro"
	local ammoCount = 0

	loadAnimDict(dic)

	local ped = PlayerPedId()
	prevupdate = 0

	TaskPlayAnim(ped, dic, anim, 10.0, 2.3, -1, 49, 1, 0, 0, 0)

	Citizen.Wait(600)
	SetCurrentPedWeapon(ped, UNARMED_HASH, 1)
	RemoveAllPedWeapons(ped)
	ClearPedTasks(ped)
end

function getAmmo()
	if not currentInformation then return 0 end

	local ammo = currentInformation["ammo"]

	if not ammo or type(ammo) ~= "number" then
		ammo = 0
	end

	return ammo
end

function updateAmmo(isForced)
	if prevupdate > 0 or not currentInformation then return end
	prevupdate = 5

	local ped = PlayerPedId()
	local hash = GetSelectedPedWeapon(ped)

	if hash == UNARMED_HASH then
		hash = lastUsedAmmoHash
	end
	lastUsedAmmoHash = hash

	local newammo = 0
	local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, hash)

	if type(ammoType) == "number" then
		newammo = GetPedAmmoByType(ped, ammoType)

		if newammo == nil then return end
		if isForced and newammo == 0 then return end

		currentInformation["ammo"] = newammo

		TriggerServerEvent("server-update-item-id", exports["np-base"]:getChar("id"), CurrentSqlID, currentInformation)
	end
end

function actionBarAmmo(hash, amount, addition)
	local ped = PlayerPedId()
	local weapons = GetSelectedPedWeapon(ped)

	if weapons == UNARMED_HASH then
		TriggerEvent("DoLongHudText", "Waar is je pistool, man?", 2)
		return
	end

	local curAmmo = GetPedAmmoByType(ped, hash)
	if not curAmmo then curAmmo = 0 end

	if curAmmo >= ammoTypes[tostring(hash)] then
		TriggerEvent("DoLongHudText", "Dat pistool is al geladen.", 2)
		return
	end

	local newammo = 0
	if addition then
	    newammo = tonumber(curAmmo) + tonumber(amount)
	else
		newammo = tonumber(curAmmo) - tonumber(amount)
	end

	if newammo > ammoTypes[tostring(hash)] then
		newammo = ammoTypes[tostring(hash)]
	elseif newammo < 0 then
		newammo = 0
	end

	MakePedReload(ped)
	SetPedAmmoByType(ped, hash, newammo)

	if currentInformation then
		currentInformation["ammo"] = newammo
		TriggerServerEvent("server-update-item-id", exports["np-base"]:getChar("id"), CurrentSqlID, currentInformation)
	end

    prevupdate = 0

	return true
end

function attemptToDegWeapon()
	if math.random(100) > 85 then
		local hasTimer = 99999
		hasTimer = (GetGameTimer() - lastWeaponDeg)

		if hasTimer >= 2000 then
			lastWeaponDeg = GetGameTimer()

			local cid = exports["np-base"]:getChar("id")
			local weapon = GetSelectedPedWeapon(PlayerPedId())

    		TriggerServerEvent("inventory:degItem", CurrentSqlID, math.random(3, 5), tostring(weapon), cid)
		end
	end
end

--[[

    Exports

]]

exports("disableActionBar", function(pState)
    isActionBarDisabled = pState
end)


--[[

	Events

]]

AddEventHandler("np-voice:focus:set", function(pState)
	focusTaken = pState
end)

RegisterNetEvent("equipWeaponID")
AddEventHandler("equipWeaponID", function(hash, newInformation, sqlID)
	if not exports["np-propattach"]:canPullWeaponHoldingEntity() then return end
	if cannotPullWeaponInAnimation  then return end

	local dead = exports["np-base"]:getVar("dead")
	if dead then return end

	if UNARMED_HASH == GetSelectedPedWeapon(PlayerPedId()) then
		armed = false
	end

	if armed then
		updateAmmo(true)
	end

	cannotPullWeaponInAnimation = true
	CurrentSqlID = sqlID
	currentInformation = json.decode(newInformation)

	TriggerEvent("evidence:bulletInformation", true and currentInformation.cartridge or "Scratched off data")

	SetPlayerCanDoDriveBy(PlayerId(), false)

	if armed then
		armed = false
		TriggerEvent("hud-display-item", tonumber(hash), "Holster")
		holster1h()
	else
		armed = true
		TriggerEvent("hud-display-item", tonumber(hash), "Equip")
		unholster1h(tonumber(hash), true, currentInformation)
	end

	if hash == "-72657034" then
		RemoveAllPedWeaponsP(PlayerPedId(),hash)
	end

	SetPedAmmo(PlayerPedId(),  `WEAPON_FIREEXTINGUISHER`, 10000)
	SetPedAmmo(PlayerPedId(),  `WEAPON_STICKYBOMB`, 1)
	SetPedAmmo(PlayerPedId(),  1233104067, 1)
	SetPedAmmo(PlayerPedId(),  -37975472, 1)

	if throwableWeapons[hash] then
		SetPedAmmo(PlayerPedId(),  tonumber(hash), 1)
	end

	SetPlayerCanDoDriveBy(PlayerId(), true)
	SetWeaponsNoAutoswap(true)
end)

RegisterNetEvent("actionbar:setEmptyHanded")
AddEventHandler("actionbar:setEmptyHanded", function()
	prevupdate = 0
	updateAmmo(true)
	Wait(500)
	SetCurrentPedWeapon(PlayerPedId(), UNARMED_HASH, true)
end)

RegisterNetEvent("brokenWeapon")
AddEventHandler("brokenWeapon", function()
	local dead = exports["np-base"]:getVar("dead")
	if dead then return end

	holster1h()
	armed = false

	SetPedAmmo(PlayerPedId(),  `WEAPON_FIREEXTINGUISHER`, 10000)
end)

--[[

	RPCs

]]

RPC.register("police:gsr", function()
	return shotRecently
end)

--[[

	Threads

]]

Citizen.CreateThread(function()
	exports["np-keybinds"]:registerKeyMapping("", "Player", "Action Bar", "+actionBar", "-actionBar", "TAB")
	RegisterCommand('+actionBar', actionBarDown, false)
	RegisterCommand('-actionBar', actionBarUp, false)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		HideHudComponentThisFrame(19) -- 19 : WEAPON_WHEEL
        HideHudComponentThisFrame(20) -- 20 : WEAPON_WHEEL_STATS
		HudWeaponWheelIgnoreSelection()  -- CAN'T SELECT WEAPON FROM SCROLL WHEEL
        DisableControlAction(0, 37, true)

		local ped = PlayerPedId()
		if IsPedShooting(ped) then
			local hash = GetSelectedPedWeapon(ped)
			local ammoType = Citizen.InvokeNative(0x7FEAD38B326B9F74, ped, hash)

			local newammo = GetPedAmmoByType(ped, ammoType)
			if newammo < 5 then updateAmmo() end

			attemptToDegWeapon()

			local weapon = tostring(hash)

			if weapon == "-37975472" then
				TriggerEvent("np-weapons:threwSmokeGrenade")
			end

			if throwableWeapons[weapon] then
				if hasEnoughOfItem(weapon,1,false) then
					TriggerEvent("inventory:removeItem", weapon, 1)
					Citizen.Wait(3000)
				end
			end

			if not excludedWeapons[hash] then
				lastShot = GetGameTimer()
				shotRecently = true
			end

			if hash == `WEAPON_FIREEXTINGUISHER` then
				local pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 3.0, 0.0)
				if GetNumberOfFiresInRange(pos,4.0) > 1 then
					local rnd = math.random(100)
					if rnd > 40 then TriggerServerEvent('fire:serverStopFire',pos.x,pos.y,pos.z,4.0) end
				end
			end
		end

		if unholsteringactive then
			DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		end

		prevupdate = prevupdate - 1

		if (IsControlJustReleased(0,157) or IsDisabledControlJustReleased(0,157)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",1)
		end

		if (IsControlJustReleased(0,158) or IsDisabledControlJustReleased(0,158)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",2)
		end

		if (IsControlJustReleased(0,160) or IsDisabledControlJustReleased(0,160)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",3)
		end

		if (IsControlJustReleased(0,164) or IsDisabledControlJustReleased(0,164)) and not focusTaken and not isActionBarDisabled then
			TriggerEvent("inventory-bind",4)
		end

		local selectedWeapon = GetSelectedPedWeapon(PlayerPedId())
		if UNARMED_HASH ~= selectedWeapon and 741814745 ~= selectedWeapon then
			DisplayAmmoThisFrame(true)
		end

		if IsPedPlantingBomb(ped) then
			if hasEnoughOfItem("741814745", 1, false) then
				TriggerEvent("inventory:removeItem", 741814745, 1)
				Citizen.Wait(3000)
			end
		end
	end

	if shotRecently and GetGameTimer() - lastShot >= 1200000 then shotRecently = false end
end)