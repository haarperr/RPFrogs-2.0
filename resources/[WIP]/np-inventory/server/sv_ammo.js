let AmmosAmount = {
    "pistolammo": 12,
    "subammo": 12,
    "shotgunammo": 12,
    "rifleammo": 12,
    "heavyammo": 12,
    "taserammo": 3,
    "rubberslugs": 5,

    "pistolammoPD": 12,
    "subammoPD": 12,
    "shotgunammoPD": 12,
    "rifleammoPD": 12,
};

let MaxAmmo = {
    "-820634585": 3, // Taser

    "148457251": 150, // Browning
    "-2012211169": 150, // DB9
    "-120179019": 150 // Glock
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