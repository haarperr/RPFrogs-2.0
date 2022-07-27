let AmmosAmount = {
    "pistolammo": 5,
    "subammo": 10,
    "shotgunammo": 10,
    "rifleammo": 10,
    "heavyammo": 10,
    "taserammo": 1,
    "rubberslugs": 5,

    "pistolammoPD": 5,
    "subammoPD": 10,
    "shotgunammoPD": 10,
    "rifleammoPD": 10,
};

let MaxAmmo = {
    "-820634585": 3, // Taser

    "148457251": 15, // Browning
    "-2012211169": 15, // DB9
    "-120179019": 15 // Glock
};

RegisterServerEvent("np-inventory:ammo")
onNet("np-inventory:ammo", async (originInventory, targetInventory, originSlot, targetSlot, originItemId, targetItemId, originItemInfo, targetItemInfo) => {
    let src = source
    let player = exports["np-base"].getChar(src, "id")

    let information = JSON.parse(targetItemInfo)

    if (MaxAmmo[targetItemId] && information["ammo"] >= MaxAmmo[targetItemId]) {
        emitNet("np-inventory:log", src, "Gun is loaded");
        return
    }

    let ammo = 0
    if (AmmosAmount[originItemId]) {
        ammo = AmmosAmount[originItemId]
    }

    information["ammo"] = information["ammo"] + ammo
    if (MaxAmmo[targetItemId] && information["ammo"] > MaxAmmo[targetItemId]) {
        information["ammo"] = MaxAmmo[targetItemId]
    }

    information = JSON.stringify(information)

    exports.oxmysql.update(`UPDATE inventory SET information='${information}' WHERE name='${targetInventory}' AND item_id='${targetItemId}' AND slot='${targetSlot}'`, {}, function () {
        exports.oxmysql.query(`DELETE FROM inventory WHERE name='${originInventory}' AND item_id='${originItemId}' AND slot='${originSlot}' LIMIT 1`, {}, function () {
            emit("server-request-update-src", player, src);
        })
    });
});