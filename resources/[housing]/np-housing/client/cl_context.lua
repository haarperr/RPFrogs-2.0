MenuData = {
    property_check = {
        {
            title = "Property",
            description = "Property lost",
            children = {
                { title = "Yes", action = "np-housing:handler", params = { forfeit = true, type = "forfeit"} },
                { title = "No", action = "np-housing:handler", params = { forfeit = false, type = "forfeit" } },
            }
        }
    },
    crafting_check = {
        {
            title = "Crafting",
            description = "Remove Inventory",
            children = {
                { title = "Yes", action = "np-housing:handler", params = { remove = true, type = "removeInv"} },
                { title = "No", action = "np-housing:handler", params = { remove = false, type = "removeInv" } },
            }
        }
    },
    inventory_check = {
        {
            title = "inventory",
            description = "Remove Craft",
            children = {
                { title = "Yes", action = "np-housing:handler", params = { remove = true, type = "removeCraft"} },
                { title = "No", action = "np-housing:handler", params = { remove = false, type = "removeCraft" } },
            }
        }
    }
}
