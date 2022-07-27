local scenes = {}

RPC.register("np-scenes:getScenes", function(src)
    return scenes
end)

function UpdateAllScenes()
    scenes = {}

    local result = MySQL.query.await([[
        SELECT *
        FROM scenes
    ]])

    for _, v in pairs(result) do
        local newCoords = json.decode(v.coords)
        scenes[#scenes+1] = {
            id = v.id,
            text = v.text,
            color = v.color,
            viewdistance = v.viewdistance,
            expiration = v.expiration,
            fontsize = v.fontsize,
            fontstyle = v.fontstyle,
            coords = vector3(newCoords.x, newCoords.y, newCoords.z),
        }
    end

    TriggerClientEvent("np-scenes:client:UpdateAllScenes", -1, scenes)
end

function DeleteExpiredScenes()
    MySQL.update.await([[
        DELETE FROM scenes
        WHERE date_deletion < NOW()
    ]])

    UpdateAllScenes()
end

RegisterNetEvent("np-scenes:server:DeleteScene", function(id)
    MySQL.update.await([[
        DELETE FROM scenes
        WHERE id = ?
    ]],
    { id })

    UpdateAllScenes()
end)

RegisterNetEvent("np-scenes:server:CreateScene", function(sceneData)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local insertId = MySQL.insert.await([[
        INSERT INTO scenes (creator, text, color, viewdistance, expiration, fontsize, fontstyle, coords, date_creation, date_deletion)
        VALUES (? ,?, ?, ?, ?, ?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL ? HOUR))
    ]],
    { cid, sceneData.text, sceneData.color, sceneData.viewdistance, sceneData.expiration, sceneData.fontsize, sceneData.fontstyle, json.encode(sceneData.coords), sceneData.expiration })

    if not insertId or insertId < 1 then
        return false, "Database insert error"
    end

    UpdateAllScenes()
end)

Citizen.CreateThread(function()
    UpdateAllScenes()

    while true do
        DeleteExpiredScenes()
        Wait(Config.AuditInterval)
    end
end)