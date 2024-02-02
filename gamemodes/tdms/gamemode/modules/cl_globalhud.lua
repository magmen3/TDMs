

function GM:HUDShouldDraw(name)
    local poop = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudCrosshair"] = true,
        ["CHudDamageIndicator"] = true,
        ["CHudDeathNotice"] = true,
        ["CHudHintDisplay"] = true,
        ["CHudPickupHistory"] = true,
        ["CHudWeaponSelection"] = true,
        ["CHudZoom"] = true
    }

    if poop[name] then
        return false
    end

    return self.BaseClass:HUDShouldDraw(name)
end
