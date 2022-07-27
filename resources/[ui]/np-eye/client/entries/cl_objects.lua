local Entries = {}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isCementMixer" },
    data = {
        {
            id = "brick",
            label = "get brick",
            icon = "cube",
            event = "np-inventory:getBrick",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isYogaMat" },
    data = {
        {
            id = "yoga",
            label = "Yoga",
            icon = "circle",
            event = "np-healthcare:yoga",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return IsEntityTouchingEntity(PlayerPedId(), pEntity)
        end
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isExercise" },
    data = {
        {
            id = "weights",
            label = "lift weight",
            icon = "dumbbell",
            event = "np-healthcare:exercise",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.2 },
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isSmokeMachineTrigger" },
    data = {
        {
            id = "smoke_machine",
            label = "cigarette shop",
            icon = "circle",
            event = "np-stripclub:smokemachine",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.2 },
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { 269934519 },
    data = {
        {
            id = 'trolleygrab',
            label = "Grab it!",
            icon = "hand-holding",
            event = "lootCash1",
            parameters = { type = "cash" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
  }

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isFuelPump" },
    data = {
        {
            id = "jerrycan_refill",
            label = "fill gallon",
            icon = "gas-pump",
            event = "vehicle:refuel:showMenu",
            parameters = { isJerryCan = true }
        }
    },
    options = {
        distance = { radius = 1.5 },
        isEnabled = function(pEntity, pContext)
            return HasWeaponEquipped(GetHashKey("WEAPON_PetrolCan"))
        end
    }
}

-- Entries[#Entries + 1] = {
--     type = "flag",
--     group = { "isVendingMachine" },
--     data = {
--         {
--             id = "vending_machine",
--             label = "Vending Machine",
--             icon = "shopping-basket",
--             event = "shops:vendingMachine",
--             parameters = {}
--         }
--     },
--     options = {
--         distance = { radius = 1.5 }
--     }
-- }

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isChair" },
    data = {
        {
            id = "sit_on_chair",
            label = "Sit",
            icon = "chair",
            event = "np-emotes:sitOnChair",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isATM" },
    data = {
        {
            id = "use_atm",
            label = "Use ATM",
            icon = "credit-card",
            event = "financial:openUI",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isWeedPlant" },
    data = {
        {
            id = "weed",
            label = "Check",
            icon = "cannabis",
            event = "np-weed:checkPlant",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 7.0 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isLrgWeedPlant" },
    data = {
        {
            id = "weed2",
            label = "harvest",
            icon = "hand-paper",
            event = "np-weed:pickPlant",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 7.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { -654402915, -1034034125 },
    data = {
        {
            id = 'vending_food',
            label = "Buy your self a nice snack!",
            icon = "cookie-bite",
            event = "shops:food",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { 690372739, -1318035530, -2015792788 },
    data = {
        {
            id = 'vending_coffee',
            label = "Make a nice cup of Coffee!",
            icon = "mug-hot",
            event = "shops:coffee",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'model',
    group = { 1114264700, -504687826, 992069095, -1741437518, -1317235795, 1099892058 },
    data = {
        {
            id = 'vending_drink',
            label = "Drink a Refreshing Can of Soda!",
            icon = "wine-bottle",
            event = "shops:drink",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

RegisterNetEvent('shops:coffee')
AddEventHandler('shops:coffee', function()
	TriggerEvent("server-inventory-open", "38", "Shop");
	Wait(1000)
end)

RegisterNetEvent('shops:drink')
AddEventHandler('shops:drink', function()
	TriggerEvent("server-inventory-open", "36", "Shop");
	Wait(1000)
end)

RegisterNetEvent('shops:food')
AddEventHandler('shops:food', function()
	TriggerEvent("server-inventory-open", "37", "Shop");
	Wait(1000)
end)

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == "flag" then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == "model" then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == "entity" then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == "polytarget" then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)