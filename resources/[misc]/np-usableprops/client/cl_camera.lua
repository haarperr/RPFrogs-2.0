local fov_max = 40.0
local fov_min = 4 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 10.0 -- camera zoom speed
local speed_lr = 5.0 -- speed by which the camera pans left-right
local speed_ud = 5.0 -- speed by which the camera pans up-down
local currentTime = "00:00"
local camera = false
local fov = (fov_max + fov_min) * 0.5

RegisterNetEvent("np-weathersync:currentTime", function(hrs, mins)
  	if hrs < 10 then hrs = "0" .. hrs end
  	if mins < 10 then mins = "0" .. mins end

    currentTime = {
        [1] = hrs,
        [2] = mins
    }
end)

local keybindEnabled = false -- When enabled, binocular are available by keybind
local binocularKey = 108
local storeBinoclarKey = 177

-- THREADS--

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)

        local lPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(lPed)

        if camera then
            camera = true

            if not (IsPedSittingInAnyVehicle(lPed)) then
                Citizen.CreateThread(function()
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_PAPARAZZI", 0, 1)
                    PlayAmbientSpeech1(PlayerPedId(), "GENERIC_CURSE_MED", "SPEECH_PARAMS_FORCE")
                    TriggerEvent("evidence:trigger")
                end)
            end

            Wait(2000)

            SetTimecycleModifier("default")
            SetTimecycleModifierStrength(0.3)

            local scaleform = RequestScaleformMovie("security_cam")
            while not HasScaleformMovieLoaded(scaleform) do
                Citizen.Wait(10)
            end

            local lPed = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(lPed)
            local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)

            local plyPos = GetEntityCoords(PlayerPedId(), true)
            local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
            local street1 = GetStreetNameFromHashKey(s1)
            local street2 = GetStreetNameFromHashKey(s2)
            local zone = GetNameOfZone(plyPos.x, plyPos.y, plyPos.z)
            local playerZoneName = GetLabelText(zone)

            AttachCamToEntity(cam, lPed, 0.0, 0.0, 1.0, true)
            SetCamRot(cam, 0.0, 0.0, GetEntityHeading(lPed))
            SetCamFov(cam, fov)
            RenderScriptCams(true, false, 0, 1, 0)
            PushScaleformMovieFunction(scaleform, "SET_LOCATION")
            PushScaleformMovieFunctionParameterString(playerZoneName)
            PopScaleformMovieFunctionVoid()
            PushScaleformMovieFunction(scaleform, "SET_DETAILS")
            PushScaleformMovieFunctionParameterString(street1 .. " / " .. street2)
            PopScaleformMovieFunctionVoid()
            PushScaleformMovieFunction(scaleform, "SET_TIME")
            PushScaleformMovieFunctionParameterString(currentTime[1])
            PushScaleformMovieFunctionParameterString(currentTime[2])
            PopScaleformMovieFunctionVoid()

            while camera and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == vehicle) and
                IsPedUsingScenario(PlayerPedId(), "WORLD_HUMAN_PAPARAZZI") and true do
                TriggerEvent("disabledWeapons", true)

                if IsControlJustPressed(0, storeBinoclarKey) then -- Toggle camera
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    ClearPedTasks(PlayerPedId())
                    camera = false
                end

                local zoomvalue = (1.0 / (fov_max - fov_min)) * (fov - fov_min)
                CheckInputRotation(cam, zoomvalue)

                HandleZoom(cam)
                HideHUDThisFrame()

                DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)

                Citizen.Wait(1)
            end

            TriggerEvent("disabledWeapons", false)

            camera = false
            ClearTimecycleModifier()
            fov = (fov_max + fov_min) * 0.5
            RenderScriptCams(false, false, 0, 1, 0)
            SetScaleformMovieAsNoLongerNeeded(scaleform)
            DestroyCam(cam, false)
            SetNightvision(false)
            SetSeethrough(false)
        end
    end
end)

RegisterNetEvent("camera:Activate")
AddEventHandler("camera:Activate", function()
    TriggerServerEvent("phone:getServerTime")
    camera = not camera
    if not camera then
        TriggerEvent("animation:c")
    end
end)

function HideHUDThisFrame()
    HideHelpTextThisFrame()
    HideHudAndRadarThisFrame()
end

function CheckInputRotation(cam, zoomvalue)
    local rightAxisX = GetDisabledControlNormal(0, 220)
    local rightAxisY = GetDisabledControlNormal(0, 221)
    local rotation = GetCamRot(cam, 2)

    if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
        new_z = rotation.z + rightAxisX * -1.0 * (speed_ud) * (zoomvalue + 0.1)
        new_x = math.max(math.min(20.0, rotation.x + rightAxisY * -1.0 * (speed_lr) * (zoomvalue + 0.1)), -89.5)
        SetCamRot(cam, new_x, 0.0, new_z, 2)
        SetEntityHeading(PlayerPedId(), new_z)
    end
end

function HandleZoom(cam)
    local lPed = PlayerPedId()

    if not (IsPedSittingInAnyVehicle(lPed)) then
        if IsControlJustPressed(0, 241) then -- Scrollup
            fov = math.max(fov - zoomspeed, fov_min)
        end
        if IsControlJustPressed(0, 242) then
            fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov - current_fov) < 0.1 then
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov) * 0.05)
    else
        if IsControlJustPressed(0, 17) then -- Scrollup
            fov = math.max(fov - zoomspeed, fov_min)
        end
        if IsControlJustPressed(0, 16) then
            fov = math.min(fov + zoomspeed, fov_max) -- ScrollDown
        end
        local current_fov = GetCamFov(cam)
        if math.abs(fov - current_fov) < 0.1 then -- the difference is too small, just set the value directly to avoid unneeded updates to FOV of order 10^-5
            fov = current_fov
        end
        SetCamFov(cam, current_fov + (fov - current_fov) * 0.05) -- Smoothing of camera zoom
    end
end