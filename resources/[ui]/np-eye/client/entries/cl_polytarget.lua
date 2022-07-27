local Entries = {}

Entries[#Entries + 1] = {
    type = "polytarget",
    group = { "bar:grabDrink" },
    data = {
        {
            id = "bar:grabDrink",
            label = "get drink",
            icon = "cocktail",
            event = "np-stripclub:peekAction",
            parameters = { action = "grabDrink" }
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = "polytarget",
    group = { "bar:openFridge" },
    data = {
        {
            id = "bar:openFridge",
            label = "open fridge",
            icon = "circle",
            event = "np-stripclub:peekAction",
            parameters = { action = "openFridge" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = "polytarget",
    group = { "job_sign_in" },
    data = {
        {
            id = "job_sign_in",
            label = "enter service",
            icon = "circle",
            event = "np-signin:peekAction",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
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