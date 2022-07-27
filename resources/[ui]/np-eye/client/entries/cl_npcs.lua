local Entries = {}

local ravi = {"Right On!", "You're telling me!", "I hear you!"}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isBankAccountManager" },
    data = {
        {
            id = "bank_paycheck_collect",
            label = "Collect Check",
            icon = "money-check-alt",
            event = "np-npcs:ped:paycheckCollect",
            parameters = {}
        }

    },
    options = {
        distance = { radius = 3.5 }
    }
}
Entries[#Entries + 1] = {
    type = "flag",
    group = { "isJobEmployer" },
    data = {
        {
            id = "jobs_employer_checkIn",
            label = "enter service",
            icon = "circle",
            event = "jobs:checkIn",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function()
            return CurrentJob == "unemployed"
        end
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isJobEmployer" },
    data = {
        {
            id = "jobs_employer_paycheck",
            label = "Collect Pay",
            icon = "circle",
            event = "jobs:getPaycheck",
            parameters = {}
        },
        {
            id = "jobs_employer_checkOut",
            label = "leave service",
            icon = "circle",
            event = "jobs:checkOut",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 },
        isEnabled = function(pEntity, pContext)
            return pContext.job.id == CurrentJob
        end
    }
}

-- Entries[#Entries + 1] = {
--     type = "flag",
--     group = { "isShopKeeper" },
--     data = {
--         {
--             id = "shopkeeper",
--             label = "Shop",
--             icon = "shopping-basket",
--             event = "np-npcs:ped:keeper",
--             parameters = { "2" }
--         }
--     },
--     options = {
--         distance = { radius = 2.5 }
--     }
-- }

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isShopKeeper" },
    data = {
        {
            id = "shopkeeper",
            label = "Shop",
            icon = "shopping-basket",
            event = "np-npcs:ped:keeper:menu",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 3.0 }
    }
}


Entries[#Entries + 1] = {
    type = "flag",
    group = { "isWeaponShopKeeper" },
    data = {
        {
            id = "weaponshop_keeper",
            label = "Buy",
            icon = "circle",
            event = "np-npcs:ped:keeper",
            parameters = { "5" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isToolShopKeeper" },
    data = {
        {
            id = "toolshop_keeper",
            label = "Tool Shop",
            icon = "toolbox",
            event = "np-npcs:ped:keeper",
            parameters = { "4" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isSportShopKeeper" },
    data = {
        {
            id = "sportshop_keeper",
            label = "buy equipment",
            icon = "circle",
            event = "np-npcs:ped:keeper",
            parameters = { "34" }
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isIllegalMedic" },
    data = {
        {
            id = "illegal_medic_revive",
            label = "be revived ($200)",
            icon = "cross",
            event = "np-death:illegal_revive"
        },
        {
            id = "illegal_medic_heal",
            label = "Heal ($150)",
            icon = "cross",
            event = "np-death:illegal_heal"
        },

    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isPawnBuyer" },
    data = {
        {
            id = "pawn_give_items",
            label = "Purchase",
            icon = "circle",
            event = "np-pawnshop:buy",
            parameters = {}
        },
        {
            id = "pawn_sell_items",
            label = "Sell",
            icon = "circle",
            event = "np-pawnshop:sell",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 2.5 }
    }
}

Entries["purchasemethkey"] = {
  type = "flag",
  group = { "isMethDude" },
  data = {
      {
          label = "Purchase Lab Key",
          icon = "key",
          event = "np-meth:purchaseMethLabKey",
          parameters = {}
      },
  },
  options = {
      distance = { radius = 2.5 }
  }


}
Entries[#Entries + 1] = {
    type = "flag",
    group = { "isNPC" },
    data = {
        {
            id = "supply",
            label = "deliveries",
            icon = "circle",
            event = "np-tacoshop:supplyStation",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"hunting_market"}
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isNPC" },
    data = {
        {
            id = "sanitation_guy",
            label = "Sanitation",
            icon = "trash",
            event = "np-jobs:garbagestart:menu",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"sanguy"}
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isNPC" },
    data = {
        {
            id = "fishguy",
            label = "Fishing",
            icon = "fish",
            event = "np-civjobs:fishing_select_zone",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"fishguy"}
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isNPC" },
    data = {
        {
            id = "fishsellguy",
            label = "Sell Fish",
            icon = "fish",
            event = "np-fishing:tshop",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 2.5 },
        npcIds = {"fishsellguy"}
    }
}

Entries[#Entries + 1] = {
    type = "flag",
    group = { "isNPC" },
    data = {
        {
            id = "SmeltingGuy",
            label = "Refinery",
            icon = "mountain",
            event = "np-jobs:smelting:menu",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 6.5 },
        npcIds = {"SmeltingGuy"}
    }
}



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


RegisterNetEvent('np-npcs:ped:keeper:menu')
AddEventHandler('np-npcs:ped:keeper:menu', function()
    local data = {
        {
            title = "24/7 Store",
            description = ravi[math.random(1, #ravi)] -- randomises between Ravi's 3 Phrases
        },
        {
            title = "Shop Goods",
            children = {
                {
                    title = "General Goods",
                    description = "Buy your general goods here",
                    action = "np-npcs:ped:keeper:general"
                },
                {
                    title = "Ingredients",
                    description = "Buy your ingredients here",
                    action = "np-npcs:ped:keeper:ingredients"
                },
                
            },
        },
    }
        exports["np-context"]:showContext(data)
end)

AddEventHandler("np-npcs:ped:keeper:general", function()
    TriggerEvent("server-inventory-open", "2", "Shop")
end)

AddEventHandler("np-npcs:ped:keeper:ingredients", function()
    TriggerEvent("server-inventory-open", "232", "Shop")
end)

