--[[

    Functions

]]

function getLicenses(src, cid, names)
    if not src then return {} end

    if not cid then
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return {} end

    local _licenses = MySQL.scalar.await([[
        SELECT licenses
        FROM characters
        WHERE id = ?
    ]],
    { cid })

    _licenses = json.decode(_licenses)

    local newLicense = false
    for k, v in pairs(LICENSES) do
        if not _licenses[k] and not v["hidden"] then
            _licenses[k] = v["default"]
            newLicense = true
        end
    end

    if newLicense then
        MySQL.update.await([[
            UPDATE characters
            SET licenses = ?
            WHERE id = ?
        ]],
        { json.encode(_licenses), cid })
    end

    if names then
        local _templicenses = {}

        for k, v in pairs(_licenses) do
            _templicenses[licenseName(k)] = v
        end

        _licenses = _templicenses
    end

    return _licenses
end

function hasLicense(src, license, cid)
    if not src then return false end

    if not cid then
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return false end

    local licenses = getLicenses(src, cid)

    local hasLicense = false
    for k, v in pairs(licenses) do
        if k == license then
            hasLicense = (v == 1)
            break
        end
    end

    return hasLicense
end

function updateLicense(src, license, status, cid)
    if not src then return false end

    if not cid then
        cid = exports["np-base"]:getChar(src, "id")
    end

    if not cid then return false end

    local licenses = getLicenses(src, cid)

    for k, v in pairs(licenses) do
        if k == license then
            licenses[license] = status
            break
        end
    end

    MySQL.update.await([[
        UPDATE characters
        SET licenses = ?
        WHERE id = ?
    ]],
    { json.encode(licenses), cid })

    return true
end

--[[

    Events

]]

exports("getLicenses", getLicenses)
exports("hasLicense", hasLicense)
exports("updateLicense", updateLicense)

--[[

    RPCs

]]

RPC.register("np-licenses:getLicenses", function(src, cid, names)
    return getLicenses(src, cid, names)
end)

RPC.register("np-licenses:hasLicense", function(src, license, cid)
    return hasLicense(src, license, cid)
end)

RPC.register("np-licenses:updateLicense", function(src, license, status, cid)
    return updateLicense(src, license, status, cid)
end)