-- Position for roll ending effect for both teams (angular distance of a hardpoint)
RollEffectAngularDistance = 200

-- Sinewave parameters for drunk projectile (not convenient)
DeltaTimeBetweenCalls = 0.12 -- How frequently script is changing positions. Is 3 physics frames for lag reduce
SinPhaseShift = 0.02 -- Phase offset for the sinewave (not used currently)
SinFrequencyModifier = 3 -- How frequently the projectile does ∿∿wObBlE∿∿
SinAmplitudeModifier = 3 -- How deep is the Sinewave motion
TimeToMaxSin = 3 -- Time interval of how fast the projectile reaches max amplitude point in seconds. Why this exists? IDK. Nobody really does.

-- RNG parameters
RngPoolLength = 60 -- How long is the pre-generated pool for each player (team), 60 shots is enough in most cases
RngCorrectionStrength = 0.1 -- Currently not used

IncrementModuleRadius = 220
SpongeModuleRadius = 500

-- Piecewise function-like table for defining power of each range of d20 rolls
ProjectileConfigs = 
{
    {range = {1, 6}, modificator = 1, antiAirHpMod = 0.6, flameRadius = 0, shrapnelPower = 0, isEmpPortals = false, shield = {DestroyShields = false, DeflectedByShields = true}, isSin = true},
    {range = {7, 7}, modificator = 1, antiAirHpMod = 0.8, flameRadius = 0, shrapnelPower = 0, isEmpPortals = false, shield = {DestroyShields = false, DeflectedByShields = true}, isSin = true},
    {range = {8, 8}, modificator = 1, antiAirHpMod = 0.8, flameRadius = 0, shrapnelPower = 0, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = true},
    {range = {9, 9}, modificator = 1, antiAirHpMod = 1, flameRadius = 0, shrapnelPower = 0, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = true},
    {range = {10, 10}, modificator = 1, antiAirHpMod = 1, flameRadius = 0, shrapnelPower = 0, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {11, 11}, modificator = 1, antiAirHpMod = 1.25, flameRadius = 0, shrapnelPower = 0, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {12, 13}, modificator = 1, antiAirHpMod = 1.25, flameRadius = 0, shrapnelPower = 1, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {14, 14}, modificator = 1.25, antiAirHpMod = 1.25, flameRadius = 0, shrapnelPower = 1, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {15, 16}, modificator = 1.25, antiAirHpMod = 1.25, flameRadius = 120, shrapnelPower = 1, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {17, 17}, modificator = 1.5, antiAirHpMod = 1.5, flameRadius = 180, shrapnelPower = 1, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {18, 18}, modificator = 1.5, antiAirHpMod = 1.5, flameRadius = 180, shrapnelPower = 2, isEmpPortals = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {19, 19}, modificator = 1.5, antiAirHpMod = 1.5, flameRadius = 180, shrapnelPower = 2, isEmpPortals = true, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
}

-- Table for linking d20 roll with pool of projectiles for equally distributed chance
ProjectileVariations = 
{
    [1] = {"shell1"},
    [2] = {"shell2"},
    [3] = {"shell3"},
    [4] = {"shell4"},
    [5] = {"shell5"},
    [6] = {"shell6"},
    [7] = {"shell7"},
    [8] = {"shell8"},
    [9] = {"shell9"},
    [10] = {"shell10"},
    [11] = {"shell11"},
    [12] = {"shell12"},
    [13] = {"shell13"},
    [14] = {"shell14"},
    [15] = {"shell15"},
    [16] = {"shell16"},
    [17] = {"shell17"},
    [18] = {"shell18"},
    [19] = {"shell19"},
    [20] = {"shellTriple", "unluckMarker", "fireball"}
}

ShellScripts = {
    DoShell_1_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        ScheduleCall(0, ApplyDamageToDevice, origWeaponId, 10000)
    end,
    DoShell_2_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        dlc2_CreateProjectile("effectShellEMP", "", teamId,Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        dlc2_CreateProjectile("effectShellMagnet", "", (teamId % 100 == 1) and 2 or 1,Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        dlc2_CreateProjectile("effectShellSmoke", "", teamId, Vec3(pos.x, pos.y+150), Vec3(0,0), age)
        dlc2_CreateProjectile("effectShellFire", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        --Log(tostring((teamId % 100 == 1) and 2 or 1))
    end,
    DoShell_3_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        dlc2_CreateProjectile("effectShellEMP", "", teamId,Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        dlc2_CreateProjectile("effectShellSmoke", "", teamId, Vec3(pos.x, pos.y+150), Vec3(0,0), age)
        dlc2_CreateProjectile("effectShellFire", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
    end,
    DoShell_4_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        dlc2_CreateProjectile("effectShellSmoke", "", teamId, Vec3(pos.x, pos.y+150), Vec3(0,0), age)
        dlc2_CreateProjectile("effectShellFire", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
    end,
    DoShell_5_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        dlc2_CreateProjectile("effectShellFire", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
    end,
    DoShell_6_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_7_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_8_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_9_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_10_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_11_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_12_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_13_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_14_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_15_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_16_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_17_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_18_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_19_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_20_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        if proj == "shellTriple" then
            CreateDeviation(3, proj, teamId, pos, velocity, age, projectileId)
            CreateDeviation(-3, proj, teamId, pos, velocity, age, projectileId)
        end
    end}