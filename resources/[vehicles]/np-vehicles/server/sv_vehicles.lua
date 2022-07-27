--[[

    Variables

]]

local activeVehicles = {}




--[[

    Functions

]]

function getVehicle(id)
    local vehicle = MySQL.query.await([[
        SELECT v1.id, v1.cid, v1.plate, v1.model, v1.type, v2.fuel, v2.body_damage, v2.engine_damage, v2.modifications, v2.fakePlate, v2.harness, v3.state, v3.garage, v3.coords, v4.price AS payment_price, v4.left AS payment_left, DATEDIFF(FROM_UNIXTIME(UNIX_TIMESTAMP()), FROM_UNIXTIME(v4.last)) AS payment_last
        FROM vehicles v1
        INNER JOIN vehicles_metadata v2 ON v2.vid = v1.id
        INNER JOIN vehicles_garage v3 ON v3.vid = v1.id
        INNER JOIN vehicles_payments v4 ON v4.vid = v1.id
        WHERE id = ?
    ]],
    { id })

    if not vehicle[1] then return end

    return vehicle[1]
end

function updateVehicle(id, type, var, data)
    if not id or not type or not var or not data then return false end

    local _id = ""
    local table = ""
    if type == "vehicles" then
        table = "vehicles"
        _id = "id"
    elseif type == "garage" then
        table = "vehicles_garage"
        _id = "vid"
    elseif type == "metadata" then
        table = "vehicles_metadata"
        _id = "vid"
    elseif type == "payments" then
        table = "vehicles_payments"
        _id = "vid"
    end

    if table == "" or _id == "" then return false end

    local affectedRows = MySQL.update.await([[
        UPDATE ??
        SET ?? = ?
        WHERE ?? = ?
    ]],
    { table, var, data, _id, id })

    if not affectedRows or affectedRows < 1 then return false end

    return true
end

function selectVehicle(id, type, var)
    if not id or not type or not var then return false end

    local _id = ""
    local table = ""
    if type == "vehicles" then
        table = "vehicles"
        _id = "id"
    elseif type == "garage" then
        table = "vehicles_garage"
        _id = "vid"
    elseif type == "metadata" then
        table = "vehicles_metadata"
        _id = "vid"
    elseif type == "payments" then
        table = "vehicles_payments"
        _id = "vid"
    end

    if table == "" or _id == "" then return false end

    local result = MySQL.scalar.await([[
        SELECT ??
        FROM ??
        WHERE ?? = ?
    ]],
    { var, table, _id, id })

    return result
end

function randomPlate()
    for i = 1, 1000 do
        local characterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local keyLength = 8
        local plate = ""

        for i2 = 1, keyLength do
            local rand = math.random(#characterSet)
            plate = plate .. string.sub(characterSet, rand, rand)
        end

        local exist = MySQL.scalar.await([[
            SELECT id
            FROM vehicles
            WHERE plate = ?
        ]],
        { plate })

        if not exist then
            return plate
        end
    end
end

function getVehicleMetadata(vid, data)
    local result = MySQL.scalar.await([[
        SELECT ??
        FROM vehicles_metadata
        WHERE vid = ?
    ]],
    { data, vid })

    return result
end

function payVehicle(vid, src)
    if not vid or not src then return false end

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return false end

    local price = MySQL.scalar.await([[
        SELECT price
        FROM vehicles_payments
        WHERE vid = ?
    ]],
    { vid })

    if not price then return false end

    local accountId = exports["np-base"]:getChar(src, "bankid")
    local bank = exports["np-financials"]:getBalance(accountId)
    if bank < price then
        TriggerClientEvent("DoLongHudText", src, "You dont have $" .. price .. " in your bank account", 2)
        return false
    end

    local plate = MySQL.scalar.await([[SELECT plate FROM vehicles WHERE id = ?]],{vid})

    local comment = "Finance payment from vehicle " .. plate
    local success, message = exports["np-financials"]:transaction(accountId, 2, price, comment, cid, 6)
    if not success then
        TriggerClientEvent("DoLongHudText", src, message)
        return false
    end

    local affectedRows = MySQL.update.await([[
        UPDATE vehicles_payments
        SET vehicles_payments.left = vehicles_payments.left - 1, vehicles_payments.last = vehicles_payments.last + 604800
        WHERE vid = ?
    ]],
    { vid })

    if not affectedRows or affectedRows < 1 then return false end

    return true
end

function insertVehicle(src, model, type, price, financed, out, _cid)
    if not src or not model or not type or not price then return false end

    local cid = false
    if src == 0 then
        cid = _cid
    else
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return false end

    local plate = randomPlate()

    local insertId = MySQL.insert.await([[
        INSERT INTO vehicles (cid, plate, model, type)
        VALUES (?, ?, ?, ?)
    ]],
    { cid, plate, model, type })

    if not insertId or insertId == 0 then return false end

    local vid = insertId

    local left = 0
    if financed then
        left = 9
    end

    local state = "In"
    if out then
        state = "Out"
    end

    local success = MySQL.transaction.await({
        {
            ["query"] = "INSERT INTO vehicles_garage (vid, state) VALUES (?, ?)",
            ["values"] = { vid, state },
        },
        {
            ["query"] = "INSERT INTO vehicles_metadata (vid) VALUES (?)",
            ["values"] = { vid },
        },
        {
            ["query"] = "INSERT INTO vehicles_payments (vid, vehicles_payments.price, vehicles_payments.left, vehicles_payments.last) VALUES (?, ?, ?, UNIX_TIMESTAMP())",
            ["values"] = { vid, price, left },
        },
    })

    if not success then
        MySQL.query.await([[
            DELETE FROM vehicles
            WHERE id = ?
        ]],
        { vid })

        return false
    end

    return vid
end

--[[

    Exports

]]

exports("getVehicle", getVehicle)
exports("updateVehicle", updateVehicle)
exports("selectVehicle", selectVehicle)
exports("payVehicle", payVehicle)
exports("insertVehicle", insertVehicle)

--[[

    RPCs

]]

RPC.register("np-vehicles:getVehicle", function(src, id)
    return getVehicle(id)
end)

RPC.register("np-vehicles:updateVehicle", function(src, id, type, var, data)
    return updateVehicle(id, type, var, data)
end)

RPC.register("np-vehicles:selectVehicle", function(src, id, type, var)
    return selectVehicle(id, type, var)
end)

RPC.register("np-vehicles:GetVehicleMetadata", function(src, vid, data)
    return getVehicleMetadata(vid, data)
end)

RPC.register("np-vehicles:ownedVehiclesModels", function(src)
    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local _vehicles = MySQL.query.await([[
        SELECT model
        FROM vehicles
        WHERE cid = ?
    ]],
    { cid })

    local vehicles = {}
    for i, v in ipairs(_vehicles) do
        table.insert(vehicles, v.model)
    end

    return vehicles
end)