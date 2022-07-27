--[[

    Variables

]]

listening = false
currentVehicle = nil
local spawnedvehicles = {}

--[[

    Functions

]]

local function despawnVehicles()
	for i, v in ipairs(spawnedvehicles) do
		Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v))
	end
end

local function spawnVehicles(shop)
	despawnVehicles()

	local _spawns = RPC.execute("np-carshop:getDisplay", shop)

	for i, v in ipairs(_spawns) do
		local model = GetHashKey(v["model"])

        RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model, v["pos"]["x"], v["pos"]["y"], v["pos"]["z"] - 1.0, v["pos"]["w"], false, false)

		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh, true)
		FreezeEntityPosition(veh, true)
		SetVehicleNumberPlateText(veh, i .. string.upper(shop))
		SetVehicleDoorsLocked(veh, 3)

        table.insert(spawnedvehicles, veh)

		exports["np-flags"]:SetVehicleFlag(veh, "isCarShopVehicle", true)
	end
end

local function listenForKeypress()
    listening = true

    Citizen.CreateThread(function()
        while listening do
            if IsControlJustReleased(0, 38) and not inTheShop then
				OpenCarShop(exports["np-base"]:getVar("carshop"), false)
            end
            Wait(0)
        end
    end)
end

local function getCurrentVehicle(pEntity, pShop)
	local vehiclePos = GetEntityCoords(pEntity)

	local index = false
	for i, v in ipairs(Config[pShop]["Spawns"]) do
		if #(vehiclePos - v["pos"]["xyz"]) < 1.0 then
			index = i
			break
		end
	end

	currentVehicle = index
end

function getTestDriveLocation(shop)
	return Config[shop]["TestDrive"]
end

--[[

	Exports

]]

exports("getTestDriveLocation", getTestDriveLocation)

--[[

    Events

]]

AddEventHandler("np-polyzone:enter", function(name)
	if not Config["Zones"][name] then return end

	if string.find(name, "catalog") then
		exports["np-interaction"]:showInteraction("[E] Showroom")
		listenForKeypress()
	else
		exports["np-base"]:setVar("carshop", name)
		spawnVehicles(name)
	end
end)

AddEventHandler("np-polyzone:exit", function(name)
	if not Config["Zones"][name] then return end

	if string.find(name, "catalog") then
		exports["np-interaction"]:hideInteraction()
		listening = false
	else
		exports["np-base"]:setVar("carshop", nil)
		despawnVehicles()
	end
end)

AddEventHandler("np-carshop:check", function(pParams, pEntity, pContext)
    local shop = exports["np-base"]:getVar("carshop")
	if not shop then return end

	getCurrentVehicle(pEntity, shop)
	if not currentVehicle then return end

	local info = RPC.execute("np-carshop:getInformations", shop, currentVehicle)
	if not info then return end

	local baseprice = info.price
	local commissionprice = math.floor(baseprice * info.commission / 100)
	local tax = RPC.execute("np-financials:priceWithTax", baseprice, "Vehicles")

	local finalprice = math.floor(baseprice + commissionprice + tax.tax)

	local infos = {
		{ title = "Vehicle Name", description = GetLabelText(GetDisplayNameFromVehicleModel(info.model)) },
		{ title = "Class", description = exports["np-vehicles"]:GetVehicleTier(pEntity) },
		{ title = "Price", description = "$" .. tax.total .. " Incl. " .. tax.porcentage .. "% tax" },
		{ title = "Stock", description = info.stock },
	}

	if exports["np-groups"]:GroupRank(shop) > 0 then
		table.insert(infos, { title = "PDM Information:", description = ""})
		table.insert(infos, { title = "Commission Percentage", description = "%" .. info.commission} )
		table.insert(infos, { title = "Base Price", description = "$" .. baseprice} )
		table.insert(infos, { title = "Commission", description = "$" .. commissionprice} )
		table.insert(infos, { title = "Taxes", description = "$" .. tax.tax} )
	end

	local data = {}

    for i, v in ipairs(infos) do
		table.insert(data, {
            title = v.title,
            description = v.description,
        })
    end

    exports["np-context"]:showContext(data)
end)

AddEventHandler("np-carshop:change", function(pParams, pEntity, pContext)
	local shop = exports["np-base"]:getVar("carshop")
	if not shop then return end

	getCurrentVehicle(pEntity, shop)
	if not currentVehicle then return end

	OpenCarShop(shop, true)
end)

RegisterNetEvent("np-carshop:updateDisplay")
AddEventHandler("np-carshop:updateDisplay", function(shop)
	if exports["np-base"]:getVar("carshop") and exports["np-base"]:getVar("carshop") == shop then
		spawnVehicles(shop)
	end
end)

AddEventHandler("np-carshop:commission", function(pParams, pEntity, pContext)
	local shop = exports["np-base"]:getVar("carshop")
	if not shop then return end

	getCurrentVehicle(pEntity, shop)
	if not currentVehicle then return end

	local input = exports["np-input"]:showInput({
		{
            icon = "percentage",
            label = "Commission",
            name = "commission",
        },
	})

	if input["commission"] then
		local comission = tonumber(input["commission"])
		if not comission then
			TriggerEvent("", "Commission must be 1-30", 2)
			return
		end

		if comission < 1 or comission > 30 then
			TriggerEvent("DoLongHudText", "Commission must be 1-30", 2)
			return
		end

		TriggerServerEvent("np-carshop:commission", shop, currentVehicle, comission)
	end
end)

AddEventHandler("np-carshop:testdrive", function(pParams, pEntity, pContext)
	local shop = exports["np-base"]:getVar("carshop")
	if not shop then return end

	getCurrentVehicle(pEntity, shop)
	if not currentVehicle then return end

	local model = pContext.model
	local pos = getTestDriveLocation(shop)

	local vehicle = exports["np-vehicles"]:spawnVehicle(model, pos, false, "TD" .. shop, 100, false, false, false, false, false, true)

	exports["np-flags"]:SetVehicleFlag(vehicle, "isTestDriveVehicle", true)
end)

AddEventHandler("np-carshop:testdriveReturn", function(pParams, pEntity, pContext)
	Sync.DeleteVehicle(pEntity)
    Sync.DeleteEntity(pEntity)
end)

AddEventHandler("np-carshop:sell", function(pParams, pEntity, pContext)
	local shop = exports["np-base"]:getVar("carshop")
	if not shop then return end

	getCurrentVehicle(pEntity, shop)
	if not currentVehicle then return end

	local plate = exports["np-vehicles"]:GetVehiclePlate(pEntity)

	TriggerServerEvent("np-carshop:sell", plate, shop, currentVehicle)
end)

AddEventHandler("np-carshop:buy", function(pParams, pEntity, pContext)
	local shop = exports["np-base"]:getVar("carshop")
	if not shop then return end

	getCurrentVehicle(pEntity, shop)
	if not currentVehicle then return end

	local info = RPC.execute("np-carshop:getInformations", shop, currentVehicle)
	if not info then return end

	local baseprice = info.price
	local commissionprice = math.floor(baseprice * info.commission / 100)
	local tax = RPC.execute("np-financials:priceWithTax", baseprice, "Vehicles")
	local financing = math.floor(baseprice / 10)
	local finalprice = math.floor(baseprice + commissionprice + tax.tax)
	local downpayment = math.floor(commissionprice + tax.tax + financing)

	local vehicle = GetLabelText(GetDisplayNameFromVehicleModel(info.model))
	if vehicle == "NULL" then vehicle = GetDisplayNameFromVehicleModel(info.model) end

	local groupname = exports["np-groups"]:GroupName(shop)

	local document = {
        headerTitle = "Vehicle Purchase",
        headerSubtitle = "Vehicle financing agreement.",
        elements = {
            { label = "SELLER", type = "input", value = info.seller.name, can_be_emtpy = false, can_be_edited = false },
			{ label = "SHOP", type = "input", value = groupname, can_be_emtpy = false, can_be_edited = false },
			{ label = "VEHICLE", type = "input", value = vehicle, can_be_emtpy = false, can_be_edited = false },
			{ label = "Price TOTAL", type = "input", value = "$" .. finalprice, can_be_emtpy = false, can_be_edited = false },
			{ label = "INITIAL PAYMENT", type = "input", value = "$" .. downpayment .. " Incl. " .. tax.porcentage .. "% tax", can_be_emtpy = false, can_be_edited = false },
			{ label = "FINANCING", type = "input", value = "10x $" .. financing, can_be_emtpy = false, can_be_edited = false },
			{ label = "TERMS", type = "textarea", value = "By signing this, you must be sure that in case you do not pay " .. groupname .. " will confiscate your vehicle.", can_be_emtpy = false, can_be_edited = false },
        },
		group = "pdm",
		callback = {
			event = "np-carshop:buycallback",
			params = {
				shop = shop,
				model = info.model,
				name = vehicle,
				seller = info.seller.sid,
				sellername = info.seller.name,
				downpayment = downpayment,
				commission = commissionprice,
				finalprice = finalprice,
				tax = tax.tax,
				financing = financing,
				buyer = exports["np-base"]:getChar("first_name") .. " " .. exports["np-base"]:getChar("last_name")
			},
		},
    }

	TriggerEvent("np-documents:CreateNewForm", document)
end)

AddEventHandler("np-carshop:buycallback", function(pParams)
	TriggerServerEvent("np-carshop:buy", pParams)
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(1000)

	for k, v in pairs(Config) do
		if k ~= "Vehicles" and k ~= "Zones" then
			v["Init"]()

			Config["Zones"][k] = true
			Config["Zones"][k .. "catalog"] = true
		end
	end

	local peeks = {
		{
			group = { "isCarShopVehicle" },
			data = {
				{
					id = "carshop_check",
					label = "Vehicle Information",
					icon = "search-dollar",
					event = "np-carshop:check",
					parameters = {}
				},
			},
			options = {
				distance = { radius = 2.5 }
			},
		},
		{
			group = { "isCarShopVehicle" },
			data = {
				{
					id = "carshop_buy",
					label = "buy vehicle",
					icon = "dollar-sign",
					event = "np-carshop:buy",
					parameters = {}
				},
			},
			options = {
				distance = { radius = 2.5 },
				isEnabled = function(pEntity, pContext)
					local _plate = exports["np-vehicles"]:GetVehiclePlate(pEntity)

					return RPC.execute("np-carshop:forSale", _plate)
				end,
			},
		},
		{
			group = { "isCarShopVehicle" },
			data = {
				{
					id = "carshop_change",
					label = "Change Vehicle",
					icon = "exchange-alt",
					event = "np-carshop:change",
					parameters = {}
				},
				{
					id = "carshop_commission",
					label = "Change Commission",
					icon = "percentage",
					event = "np-carshop:commission",
				},
			},
			options = {
				distance = { radius = 2.5 },
				isEnabled = function(pEntity, pContext)
					local _shop = exports["np-base"]:getVar("carshop")
					local _rank = exports["np-groups"]:GroupRank(_shop)

					return _rank > 0
				end,
			},
		},
		{
			group = { "isCarShopVehicle" },
			data = {
				{
					id = "carshop_sell",
					label = "sell vehicle",
					icon = "dollar-sign",
					event = "np-carshop:sell",
					parameters = {}
				},
			},
			options = {
				distance = { radius = 2.5 },
				isEnabled = function(pEntity, pContext)
					local _shop = exports["np-base"]:getVar("carshop")
					local _rank = exports["np-groups"]:GroupRank(_shop)
					local _plate = exports["np-vehicles"]:GetVehiclePlate(pEntity)

					return _rank > 0 and not RPC.execute("np-carshop:forSale", _plate)
				end,
			},
		},
		{
			group = { "isCarShopVehicle" },
			data = {
				{
					id = "carshop_testdrive",
					label = "Test Drive",
					icon = "car",
					event = "np-carshop:testdrive",
					parameters = {}
				},
			},
			options = {
				distance = { radius = 2.5 },
				isEnabled = function(pEntity, pContext)
					local _shop = exports["np-base"]:getVar("carshop")
					local _rank = exports["np-groups"]:GroupRank(_shop)

					return _rank >= 3
				end,
			},
		},
		{
			group = { "isTestDriveVehicle" },
			data = {
				{
					id = "carshop_testdrivereturn",
					label = "return vehicle",
					icon = "car",
					event = "np-carshop:testdriveReturn",
					parameters = {}
				},
			},
			options = {
				distance = { radius = 2.5 },
				isEnabled = function(pEntity, pContext)
					local shop = exports["np-base"]:getVar("carshop")
					if not shop then
						return false
					end

					local rank = exports["np-groups"]:GroupRank(shop)
					if rank < 3 then
						return false
					end

					return #(GetEntityCoords(pEntity) - exports["np-carshop"]:getTestDriveLocation(shop)["xyz"]) < 3.0
				end,
			},
		},
	}

	for i, v in ipairs(peeks) do
		exports["np-eye"]:AddPeekEntryByFlag(v.group, v.data, v.options)
	end
end)