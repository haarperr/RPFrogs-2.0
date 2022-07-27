AddEventHandler("np-companions:showPetshop", function(pArgs, pEntity, pContext)
    local data = {}

    for _, pet in ipairs(pArgs["Pets"]) do
        pet.type = pArgs["Type"]
        pet.department = pArgs["Department"]

        table.insert(data, {
            title = pet.name,
            description = "$" .. pet.price,
            children = {
                { title = "Confirm Purchase", action = "np-pets:purchasePet", params = pet },
            },
        })
    end

    exports["np-context"]:showContext(data)
end)

AddEventHandler("np-pets:purchasePet", function(params)
    local input = exports["np-input"]:showInput({
        {
            icon = "paw",
            label = "animal name",
            name = "name",
        }
    })

    if input["name"] then
        TriggerServerEvent("np-pets:purchasePet", params, input["name"])
    end
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    for i, v in ipairs(PetshopConfig) do
        exports["np-npcs"]:RegisterNPC(v["NPC"])

        local group = { "isPetshopSeller" }

        local data = {
            {
                id = "petshop_" .. i,
                label = v["Label"],
                icon = "paw",
                event = "np-companions:showPetshop",
                parameters = v,
            }
        }

        local options = {
            distance = { radius = 2.5 },
            isEnabled = function()
                return exports["np-base"]:getChar("job") == v["Job"]
            end
        }

        exports["np-eye"]:AddPeekEntryByFlag(group, data, options)
    end
end)