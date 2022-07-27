RegisterNetEvent("np-pets:purchasePet")
AddEventHandler("np-pets:purchasePet", function(params, name)
    local src = source

    local cid = exports["np-base"]:getChar(src, "id")
    if not cid then return end

    local cash = exports["np-financials"]:getCash(src)

    if params.price > cash then
        TriggerClientEvent("DoLongHudText", src, "You don't have$" .. params.price .. " On You", 2)
        return
    end

    if params.type == "k9" then
        TriggerClientEvent("np-pets:k9create", src, cid, params.model, params.deparment, name, math.random(0, params.variants))
    else
        TriggerClientEvent("np-pets:petCreate", src, cid, params.model, name, math.random(0, params.variants))
    end
end)