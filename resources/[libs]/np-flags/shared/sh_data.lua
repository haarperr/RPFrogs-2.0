Flags = {}

local curVehicleFlag = 1
local function prevVehicleFlag()
    curVehicleFlag = curVehicleFlag * 2
    return curVehicleFlag / 2
end

Flags["VehicleFlags"] = {
    isPlayerVehicle = prevVehicleFlag(),
    isStolenVehicle = prevVehicleFlag(),
    isScrapVehicle = prevVehicleFlag(),
    isHotwiredVehicle = prevVehicleFlag(),
    isTowingVehicle = prevVehicleFlag(),
    isCarShopVehicle = prevVehicleFlag(),
    isTestDriveVehicle = prevVehicleFlag(),
}

local curPedFlag = 1
local function prevPedFlag()
    curPedFlag = curPedFlag * 2
    return curPedFlag / 2
end

Flags["PedFlags"] = {
    isDead = prevPedFlag(),
    isCuffed = prevPedFlag(),
    isRobbing = prevPedFlag(),
    isEscorting = prevPedFlag(),
    isEscorted = prevPedFlag(),
    isBlindfolded = prevPedFlag(),
    isInTrunk = prevPedFlag(),
    isInBeatMode = prevPedFlag(),
    isInsideVanillaUnicorn = prevPedFlag(),
    isNPC = prevPedFlag(),
    isJobEmployer = prevPedFlag(),
    isSittingOnChair = prevPedFlag(),
    isPoledancing = prevPedFlag(),
    isPawnBuyer = prevPedFlag(),
    isIllegalMedic = prevPedFlag(),
    isSmeltingGuy = prevPedFlag(),
    isVehicleSpawner = prevPedFlag(),
    isBoatRenter = prevPedFlag(),
    isMethDude = prevPedFlag(),
    isBankAccountManager = prevPedFlag(),
    isShopKeeper = prevPedFlag(),
    isWeaponShopKeeper = prevPedFlag(),
    isToolShopKeeper = prevPedFlag(),
    isSportShopKeeper = prevPedFlag(),
    isCasinoChipSeller = prevPedFlag(),
    isCarRenter = prevPedFlag(),
    isBicycleShop = prevPedFlag(),
    isBoatShop = prevPedFlag(),
    isEmsVehicleSeller = prevPedFlag(),
    isPoliceVehicleSeller = prevPedFlag(),
    isPetshopSeller = prevPedFlag(),
    isWeedShopKeeper = prevPedFlag(),
}

Flags["ObjectFlags"] = {}