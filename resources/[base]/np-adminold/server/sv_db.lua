--[[

    Variables

]]

Caue.Admin.DB = Caue.Admin.DB or {}

--[[

    Functions

]]

function Caue.Admin.DB.giveCar(self, src, model, cid)
    if not characterExist(cid) then
        TriggerClientEvent("DoLongHudText", src, "This CID dont exist", 2)
        return
    end

    local gived = exports["np-vehicles"]:insertVehicle(0, model, "car", 0, false, false, cid)
    if gived then
        TriggerClientEvent("DoLongHudText", src, "Vehicle " .. model .. " gived to CID " .. cid)
    else
        TriggerClientEvent("DoLongHudText", src, "Error?", 2)
    end
end

function Caue.Admin.SetRank(self, target, rank)
    local src = target:getVar("source")
    local hex = target:getVar("hexid")

    local affectedRows = MySQL.update.await([[
        UPDATE users
        SET users.rank = ?
        WHERE hex = ?
    ]],
    { rank, hex })

    if affectedRows and affectedRows ~= 0 then
        exports["np-base"]:setUser(src, "rank", rank)
        TriggerClientEvent("np-base:setVar", src, "rank", rank)

        Caue._Admin.Players[src]["rank"] = rank

        if Caue._Admin.CurAdmins[src] and rank == "user" then
            Caue._Admin.CurAdmins[src] = nil
            TriggerClientEvent("np-adminold:noLongerAdmin", src)
        end

        for k, v in pairs(Caue._Admin.CurAdmins) do
            TriggerClientEvent("np-adminold:updateData", k, src, "rank", rank)
        end
    end
end

function Caue.Admin.IsBanned(self, hex)
    local banned =  MySQL.scalar.await([[
        SELECT time
        FROM users_bans
        WHERE hex = ?
    ]],
    { hex })

    return banned and true or false
end

function Caue.Admin.Ban(self, hex, time, reason)
    if not time then time = 0 end

    if Caue.Admin:IsBanned(hex) then
        MySQL.update([[
            UPDATE users_bans
            SET time = ?, reason = ?
            WHERE hex = ?
        ]],
        { time, reason, hex })
    else
        MySQL.update([[
            INSERT INTO users_bans (hex, time, reason)
            VALUES (?, ?, ?)
        ]],
        { hex, time, reason })
    end
end

function Caue.Admin.DB.Unban(self, hex)
    MySQL.update([[
        DELETE FROM users_bans
        WHERE hex = ?
    ]],
    { hex })
end

--[[

    Events

]]

RegisterServerEvent("np-adminold:searchRequest")
AddEventHandler("np-adminold:searchRequest", function()

end)