dofile("scripts/type.lua")
local howitzer = FindProjectile("howitzer")

local buffArray = {0.6, 0.8, 1, 1.3, 1.67}

if howitzer then
    
    for i = 1, 10 do
        local newShell = DeepCopy(howitzer)
        local buffIndex = 1
        if i > 6 then buffIndex = 2 end
        if i > 9 then buffIndex = 3 end
        
        newShell.SaveName = "shell" .. i
        newShell.ProjectileDamage = newShell.ProjectileDamage*buffArray[3]
        newShell.AntiAirHitpoints = newShell.AntiAirHitpoints*buffArray[buffIndex]
        newShell.Impact = newShell.Impact*buffArray[buffIndex]
        newShell.ProjectileSplashDamage = newShell.ProjectileSplashDamage*buffArray[buffIndex]
        newShell.ProjectileSplashDamageMaxRadius = newShell.ProjectileSplashDamageMaxRadius*buffArray[buffIndex]
        newShell.ProjectileSprite = path.. "/weapons/sprites/shell" .. i .. ".png"
        newShell.ProjectileThickness = 10.0
        newShell.ProjectileShootDownRadius = 60
        newShell.DndProjectile = true
        newShell.CollidesWithLike = false

        if i <9 then
            newShell.DestroyShields = false
            newShell.DeflectedByShields = true
            newShell.MomentumThreshold =
                {
                    ["armour"] = { Reflect = 1000000, Penetrate = 4000 },
                    ["door"] = { Reflect = 1000000, Penetrate = 4000 },
                }
        end
        Projectiles[#Projectiles+1] = newShell
    end

    for i = 11, 19 do
        local newShell = DeepCopy(howitzer)
        local buffIndex = 3
        if i > 11 then buffIndex = 4 end
        if i > 14 then buffIndex = 5 end
  
        newShell.SaveName = "shell" .. i
        newShell.ProjectileDamage = newShell.ProjectileDamage*buffArray[buffIndex]
        newShell.AntiAirHitpoints = newShell.AntiAirHitpoints*buffArray[buffIndex]
        newShell.Impact = newShell.Impact*buffArray[buffIndex]
        newShell.ProjectileSplashDamage = newShell.ProjectileSplashDamage*buffArray[3]
        newShell.ProjectileSplashDamageMaxRadius = newShell.ProjectileSplashDamageMaxRadius*buffArray[buffIndex]
        newShell.ProjectileSprite = path.. "/weapons/sprites/shell" .. i .. ".png"
        newShell.ProjectileThickness = 10.0
        newShell.ProjectileShootDownRadius = 60
        newShell.DndProjectile = true
        newShell.CollidesWithLike = false
        
        if i>15 then
            newShell.ProjectileIncendiary = true
            newShell.IncendiaryRadius = 100
            newShell.IncendiaryRadiusHeated = 200
            newShell.AlwaysIncendiary = true
            newShell.incendiaryOffset = 100
        end
        
        if i>16 then
            newShell.EMPRadius = 150
            newShell.EMPDuration = 10
            newShell.EnemyCanTeleport = false
        end

        if i>18 then
            newShell.AntiAirHitpoints = newShell.AntiAirHitpoints*3
        end


        Projectiles[#Projectiles+1] = newShell
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
    fireball.ProjectileSprite = path.. "/weapons/sprites/shell20.png"
    fireball.ProjectileThickness = 10.0
    fireball.ProjectileShootDownRadius = 60
    fireball.ProjectileIncendiary = true
    fireball.IncendiaryRadius = 700
    fireball.AlwaysIncendiary = true
    fireball.DndProjectile = true
    fireball.CollidesWithLike = false
    Projectiles[#Projectiles+1] = fireball
end

local unluckMarker = DeepCopy(FindProjectile("ol_marker_sweep"))
if unluckMarker then
	unluckMarker.SaveName = "unluckMarker"
    unluckMarker.DndProjectile = true
    unluckMarker.Projectile =
	{
		Root =
		{
			Name = "Root",
			Angle = 0,
			Sprite = path.. "/weapons/sprites/shell20.png",
			PivotOffset = {0, 0},
			Scale = 4.0,
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


local EffectShellFire = DeepCopy(FindProjectile("shrapnel"))
EffectShellFire.SaveName = "EffectShellFire"
EffectShellFire.ProjectileDamage = 0
EffectShellFire.Impact = 0
EffectShellFire.DndProjectile = false
EffectShellFire.ProjectileIncendiary = true
EffectShellFire.IncendiaryRadius = 70
EffectShellFire.IncendiaryRadiusHeated = 140
EffectShellFire.AlwaysIncendiary = true
Projectiles[#Projectiles+1] = EffectShellFire

local EffectShellSmoke = DeepCopy(FindProjectile("smokebomb"))
EffectShellSmoke.SaveName = "EffectShellSmoke"
EffectShellSmoke.ProjectileDamage = 0
EffectShellSmoke.DndProjectile = false
EffectShellSmoke.MaxAge = 15
Projectiles[#Projectiles+1] = EffectShellSmoke

local EffectShellEMP = DeepCopy(FindProjectile("shrapnel"))
EffectShellEMP.SaveName = "EffectShellEMP"
EffectShellEMP.ProjectileDamage = 0
EffectShellEMP.DndProjectile = false
EffectShellEMP.EMPRadius = 150
EffectShellEMP.EMPDuration = 10
Projectiles[#Projectiles+1] = EffectShellEMP


if moonshot then
	local EffectShellMagnet = DeepCopy(FindProjectile("magneticfield"))
	EffectShellMagnet.SaveName = "EffectShellMagnet"
    EffectShellMagnet.FieldRadius = 200.0
    EffectShellMagnet.MagneticModifierFriendly = 0
    EffectShellMagnet.MagneticModifierEnemy = 0.5
    EffectShellMagnet.FieldIntersectionNearest = false
    EffectShellMagnet.FieldStrengthMax = 500
    EffectShellMagnet.FieldStrengthFalloffPower = 0.5
    EffectShellMagnet.FieldType = 2
	EffectShellMagnet.MaxAge = 4
	EffectShellMagnet.Gravity = 0
	Projectiles[#Projectiles+1] = EffectShellMagnet
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


---@type Projectile
local myNewProjectile = {
    SaveName = "cannon",
    ProjectileType = "mortar",
    ProjectileSprite = "weapons/media/bullet",
    ProjectileSpriteMipMap = false,
    DrawBlurredProjectile = true,
    ProjectileMass = 16,
    ProjectileDrag = 0,
    Impact = 20000,
    DestroyShields = true,
    DeflectedByShields = false,
    PassesThroughMaterials = false,
    ExplodeOnTouch = false,
    ProjectileThickness = 10.0,
    ProjectileShootDownRadius = 60,
    BeamTileRate = 0.02,
    BeamScrollRate = 0.0,
    ProjectileDamage = 700.0,
    ProjectileSplashDamage = 30.0,
    ProjectileSplashDamageMaxRadius = 200.0,
    ProjectileSplashMaxForce = 10000,
    SpeedIndicatorFactor = 0.25,

    TrailEffect = "effects/cannon_trail.lua",

    Effects =
    {
        Impact =
        {
            ["device"] = "effects/impact_heavy.lua",
            ["foundations"] = "effects/impact_heavy_ground.lua",
            ["rocks01"] = "effects/impact_heavy_ground.lua",
            ["bracing"] = "effects/impact_heavy.lua",
            ["armour"] = "effects/impact_heavy.lua",
            ["door"] = "effects/impact_heavy.lua",
            ["default"] = "effects/impact_heavy.lua",
        },
        Deflect =
        {
            ["armour"] = "effects/armor_ricochet.lua",
            ["door"] = "effects/armor_ricochet.lua",
            ["shield"] = "effects/energy_shield_ricochet.lua",
        },
    },
    MomentumThreshold =
    {
        ["armour"] = { Reflect = 0, Penetrate = 4000 },
        ["door"] = { Reflect = 0, Penetrate = 4000 },
    },
    -- MaxAge = number,
    -- MinAge = number,
    -- DamageMultiplier = object,
    -- WeaponDamageBonus = number,
    -- ImpactMomentumLimit = number,
    -- DeflectedByTerrain = boolean,
    -- CollidesWithBeams = boolean,
    -- ExpiresOnFreeFall = boolean,
    -- PenetrationDamage = number,
    -- PenetrationSpeedMultiplier = number,
    -- ProjectileIncendiary = boolean,
    -- AntiAirDamage = number,
    -- Projectile = object,
    -- IgnitesBackgroundMaterials = boolean,
    -- DisableShields = boolean,
    -- EMPSensitivity = number,
    -- EnemyCanTeleport = boolean,
    -- EMPMissileProbabilityOfCircling = number,
    -- IncendiaryOffset = number,
    -- IncendiaryRadius = number,
    -- AlwaysIncendiary = boolean,
    -- Missile = object,
    -- IncendiaryRadiusHeated = number,
    -- FlipSpriteFacingLeft = boolean,
    -- AntiAirHitpoints = number,
    -- ImpactSize = number,
    -- BeamOcclusionDistanceWater = number,
    -- BeamOcclusionDistance = number,
    -- IgnitesBackgroundMaterialsPassing = boolean,
    -- IgnitesBackgroundMaterialsPassingSource = boolean,
    -- ProjectileShootDownRadiusBeamWidth = number,
    -- CollisionLookaheadDist = number,
    -- DrawFromAge = number,
    -- EMPOffset = number,
    -- Gravity = number,
    -- EMPRadius = number,
    -- EMPDuration = number,
    -- MinPenetration = number,
    -- MagneticModifierEnemy = number,
    -- FieldRadius = number,
    -- FieldType = number,
    -- FieldCreatesImpactProjectile = boolean,
    -- CollidesWithBackgroundMaterials = boolean,
    -- CollidesWithLike = boolean,
    -- ProjectileSplashOffset = number,
    -- CollidesWithLikeTag = string,
    -- DetonatesOnExpiry = boolean,
    -- MagneticModifierFriendly = number,
    -- CanBeShotDown = boolean,
    -- FieldIntersectionNearest = boolean,
    -- RayOffset = number,
    -- RayIncendiaryRadius = number,
    -- RayStopAtForeground = boolean,
    -- RayExcludeBackground = boolean,
    -- RayDamage = number,
    -- RayLength = number,
    -- CollidesWithConstruction = boolean,
    -- RayDamageLimit = number,
    -- CollidesWithProjectiles = boolean,
    -- CollidesWithStructure = boolean,
    -- FieldStrengthMax = number,
    -- FieldStrengthFalloffPower = number,
    -- DecoyMinTargetAge = number,
    -- Additive = boolean,
    -- ScattershotNoTrajectory = boolean,
    -- dlc2_Bombs = object,
    -- StructureSplashDamage = number,
    -- IncendiaryOnPenetration = boolean,
    -- StructureSplashDamageMaxRadius = number,
    -- IncendiaryOnDeviceCollision = boolean,
    -- ProjectileIncendiaryDevicePlatform = boolean,
    -- dlc2_orbital = object,
    -- DoesNotReflectDuringFadeOut = boolean,
    -- BeamCollisionThickness = string,
    -- BeamDamage = string,
    -- BeamThickness = string,
    -- Beam = object,
    -- dlc2_control = object

}

table.insert(Projectiles, myNewProjectile)

