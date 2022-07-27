RegisterNetEvent("evidence:bleeding", function(corpse)
    if not Ped.characterDNA or Ped.isInVehicle and not corpse then return end

    local currentCoords = vector3(Ped.coords.x, Ped.coords.y, Ped.coords.z - 0.7)

    if WaterTest(currentCoords) and not corpse then return end

    local meta = {
        ["type"] = "blood",
        ["identifier"] = Ped.characterDNA or "FADED",
        ["text"] = "Sangue",
        ["Tipo de Evidencia"] = "Sangue",
        ["DNA"] = "Não analisado",
        ["_hideKeys"] = { "type", "identifier", "text" },
    }

    TriggerEvent("np-evidence:dropEvidence", currentCoords, meta)
end)

-- RegisterNetEvent("evidence:drugs", function(drugType)
--     if not Ped.characterDNA then return end

--     local currentCoords = vector3(Ped.coords.x, Ped.coords.y, Ped.coords.z - 0.7)

--     local identifier = drugType .. "-" .. Ped.characterDNA .. math.floor((math.random() * 100000))

--     local meta = {
--         ["evidenceType"] = "drugs",
--         ["identifier"] = identifier,
--         ["other"] = "Drug Sales/Use",
--     }

--     TriggerEvent("np-evidence:dropEvidence", currentCoords, meta)
-- end)