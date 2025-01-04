 --- forts API ---
dofile("scripts/type.lua")
dofile(path .. "/globals.lua")

local fragSplit = 
{
    Effect = "effects/mortar_air_burst.lua",
    Projectile = { Count = 30, Type = "shellShrapnel", Speed = 2000, StdDev = 1.0 },
    Offset = -120,
    Terminate = true,
}

local howitzer = FindProjectile("howitzer")

if howitzer then  
    local function createShell(i, config)
        local newShell = DeepCopy(howitzer)
        newShell.SaveName = "shell" .. i
        newShell.ProjectileDamage = newShell.ProjectileDamage * config.modificator
        newShell.AntiAirHitpoints = newShell.AntiAirHitpoints * config.antiAirHpMod
        newShell.Impact = newShell.Impact * config.modificator
        newShell.ProjectileSplashDamage = newShell.ProjectileSplashDamage * config.modificator
        newShell.ProjectileSplashDamageMaxRadius = newShell.ProjectileSplashDamageMaxRadius * config.modificator
        newShell.ProjectileSprite = path .. "/weapons/sprites/shell" .. i .. ".png"
        newShell.ProjectileThickness = 10.0
        newShell.ProjectileShootDownRadius = 60
        newShell.DndProjectile = true
        newShell.CollidesWithLike = false
        newShell.DestroyShields = config.shield.DestroyShields
        newShell.DeflectedByShields = config.shield.DeflectedByShields
        if config.shield.DeflectedByShields then
            newShell.MomentumThreshold =
            {
                ["armour"] = { Reflect = 1000000, Penetrate = 4000 },
                ["door"] = { Reflect = 1000000, Penetrate = 4000 },
            }
        end
        if config.modificator > 1 then
            newShell.DamageMultiplier = 
            {
                { SaveName = "bracing", Direct = 1, Splash = 4.8/config.modificator },
                { SaveName = "backbracing", Direct = config.modificator, Splash = 3.2/config.modificator }
            }
        end




        if config.isShrapnel then
            newShell.Effects = 
            {
                Impact = {
                    ["armour"] = fragSplit,
                    ["bracing"] = fragSplit,
                    ["default"] = fragSplit,
                },
                Deflect = {
                    ["armour"] = "effects/armor_ricochet.lua",
                    ["door"] = "effects/armor_ricochet.lua",
                    ["shield"] = "effects/energy_shield_ricochet.lua",
                },
                Age = {
                    --t200 = fragSplit,
                },
            }
        end
        Projectiles[#Projectiles + 1] = newShell
    end

    for _, config in ipairs(ProjectileConfigs) do
        for i = config.range[1], config.range[2] do
            createShell(i, config)
        end
    end
    
    local shell20 = DeepCopy(howitzer)
    shell20.SaveName = "shell20"
    shell20.ProjectileDamage = 750
    shell20.AntiAirHitpoints = 110
    shell20.Impact = 500000
    shell20.ProjectileSprite = path.. "/weapons/sprites/shell20.png"
    shell20.ProjectileThickness = 10.0
    shell20.ProjectileShootDownRadius = 60
    shell20.DndProjectile = true
    shell20.CollidesWithLike = false
    Projectiles[#Projectiles+1] = shell20

    local fireball = DeepCopy(howitzer)
    fireball.SaveName = "fireball"
    fireball.ProjectileDamage = 750
    fireball.AntiAirHitpoints = 110
    fireball.Impact = 500000
    fireball.ProjectileSprite = path.. "/weapons/sprites/fireball.png"
    fireball.ProjectileThickness = 10.0
    fireball.ProjectileShootDownRadius = 60
    fireball.ProjectileIncendiary = true
    fireball.IncendiaryRadius = 700
    fireball.AlwaysIncendiary = true
    fireball.DndProjectile = true
    fireball.CollidesWithLike = false
	fireball.TrailEffect = path.. "/effects/dice_trail.lua"
    Projectiles[#Projectiles+1] = fireball
end

local unluckMarker = DeepCopy(FindProjectile("ol_marker_sweep"))
if unluckMarker then
	unluckMarker.SaveName = "unluckMarker"
    unluckMarker.DndProjectile = true
    unluckMarker.CollidesWithProjectiles = false
    unluckMarker.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path.. "/weapons/sprites/shell20.png",
			PivotOffset = {0, 0},
			Scale = 2.5,
		}
	}
    unluckMarker.Effects =
	{
		Impact =
		{
			["default"] = path .. "/effects/marker_land.lua",
		},
		Deflect =
		{
			["default"] = "effects/bullet_bracing_hit.lua",
		},
	}
	unluckMarker.dlc2_orbital = nil
	Projectiles[#Projectiles+1] = unluckMarker
end

for i, v in ipairs(Projectiles) do
    if v.DndProjectile then
       local nocol = DeepCopy(v)
       nocol.SaveName = v.SaveName .. "_nocol"
       nocol.CollidesWithProjectiles = false
       nocol.ProjectileIncendiary = false
       nocol.AlwaysPassDevices = true
       nocol.WeaponDamageBonus = 0
       nocol.EMPDuration = 0
       nocol.ProjectileDamage = 0
       nocol.DndProjectile = false
       if not nocol.DamageMultiplier then nocol.DamageMultiplier = {} end
       if not nocol.Effects then nocol.Effects = {} end
       if not nocol.Effects.Impact then nocol.Effects.Impact = {} end
       nocol.DamageMultiplier[#nocol.DamageMultiplier + 1] = { SaveName = "weapon", Direct = 0 }
       nocol.Effects.Impact.device = {
           Effect = nil,
           Terminate = false,
           Splash = false
       }
       nocol.Effects.Age = { ["t500"] = { Projectile = { Count = 1, Type = v.SaveName }, Splash = false } }
       Projectiles[#Projectiles+1] = nocol
   end
end    

local shellShrapnel = DeepCopy(FindProjectile("sniper"))
    shellShrapnel.SaveName = "shellShrapnel"
    --shellShrapnel.ProjectileType = "mortar"
    shellShrapnel.ProjectileSprite = "weapons/media/bullet"
    shellShrapnel.ProjectileSpriteMipMap = false
    shellShrapnel.DrawBlurredProjectile = true
    --shellShrapnel.ProjectileMass = 16
    --shellShrapnel.ProjectileDrag = 0
    --shellShrapnel.Impact = 20000
    shellShrapnel.DisableShields = false
    shellShrapnel.DeflectedByShields = true
    shellShrapnel.PassesThroughMaterials = false
    --shellShrapnel.ExplodeOnTouch = false
    --shellShrapnel.ProjectileThickness = 4.0
    --shellShrapnel.ProjectileShootDownRadius = 60
    --shellShrapnel.BeamTileRate = 0.02
    --shellShrapnel.ProjectileDamage = 30.0
    --shellShrapnel.ProjectileSplashDamage = 20.0
    --shellShrapnel.ProjectileSplashDamageMaxRadius = 100.0
    --shellShrapnel.WeaponDamageBonus = 40
    --shellShrapnel.ProjectileSplashMaxForce = 10000
    --shellShrapnel.AntiAirHitpoints = 40
    --shellShrapnel.SpeedIndicatorFactor = 0.25
    shellShrapnel.TrailEffect = "mods/weapon_pack/effects/20mmcannon_trail.lua"
    shellShrapnel.Effects = 
    {
        Impact = 
        {
            ["default"] = "effects/impact_medium.lua",
        },
        Deflect = 
        {
            ["armour"] = { Effect = "effects/armor_ricochet.lua", Splash = false },
            ["door"] = { Effect = "effects/armor_ricochet.lua", Splash = false },
            ["shield"] = { Effect = "effects/energy_shield_ricochet.lua", Splash = false },
        },
    }
    --[[shellShrapnel.DamageMultiplier = 
    {
        { SaveName = "sandbags", Direct = 0.4, Splash = 0.4 },
        { SaveName = "armour", Direct = 0.7, Splash = 0.7 },
        { SaveName = "door", Direct = 0.5, Splash = 0.5 },
        { SaveName = "weapon", Direct = 1.0, Splash = 1.5 },
        { SaveName = "device", Direct = 3.0, Splash = 1.5 },
        { SaveName = "reactor", Direct = 0.3, Splash = 0.3 },
    }--]]
Projectiles[#Projectiles+1] = shellShrapnel

local effectShellFire = DeepCopy(FindProjectile("shrapnel"))
effectShellFire.SaveName = "effectShellFire"
effectShellFire.ProjectileDamage = 0
effectShellFire.Impact = 0
effectShellFire.DndProjectile = false
effectShellFire.ProjectileIncendiary = true
effectShellFire.IncendiaryRadius = 70
effectShellFire.IncendiaryRadiusHeated = 140
effectShellFire.AlwaysIncendiary = true
Projectiles[#Projectiles+1] = effectShellFire

local effectShellSmoke = DeepCopy(FindProjectile("smokebomb"))
effectShellSmoke.SaveName = "effectShellSmoke"
effectShellSmoke.ProjectileDamage = 0
effectShellSmoke.DndProjectile = false
effectShellSmoke.MaxAge = 15
Projectiles[#Projectiles+1] = effectShellSmoke

local effectShellEMP = DeepCopy(FindProjectile("shrapnel"))
effectShellEMP.SaveName = "effectShellEMP"
effectShellEMP.ProjectileDamage = 0
effectShellEMP.DndProjectile = false
effectShellEMP.EMPRadius = 150
effectShellEMP.EMPDuration = 10
Projectiles[#Projectiles+1] = effectShellEMP


if moonshot then
	local effectShellMagnet = DeepCopy(FindProjectile("magneticfield"))
	effectShellMagnet.SaveName = "effectShellMagnet"
    effectShellMagnet.FieldRadius = 200.0
    effectShellMagnet.MagneticModifierFriendly = 0
    effectShellMagnet.MagneticModifierEnemy = 0.5
    effectShellMagnet.FieldIntersectionNearest = false
    effectShellMagnet.FieldStrengthMax = 500
    effectShellMagnet.FieldStrengthFalloffPower = 0.5
    effectShellMagnet.FieldType = 2
	effectShellMagnet.MaxAge = 4
	effectShellMagnet.Gravity = 0
	Projectiles[#Projectiles+1] = effectShellMagnet
end

local unluckShell = DeepCopy(FindProjectile("howitzer"))
if unluckShell then
	unluckShell.SaveName = "unluckShell"
	unluckShell.ProjectileDamage = 100
	unluckShell.ProjectileSplashDamage = 90
	unluckShell.ProjectileSplashDamageMaxRadius = 130
	unluckShell.Gravity = unluckShell.Gravity * 1.35
	unluckShell.AntiAirHitpoints = 11
    unluckShell.DamageMultiplier = {}
    unluckShell.CollidesWithLike = false
    unluckShell.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Scale = 4,
			Sprite = path .. "/weapons/sprites/shell1.png",
		}
	}
	Projectiles[#Projectiles+1] = unluckShell
end

table.insert(Projectiles, myNewProjectile)