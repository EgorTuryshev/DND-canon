-- Important Line!
-- Position for roll ending effect for both teams (angular distance of a hardpoint)
RollEffectAngularDistance = 200

-- Sinewave parameters for drunk projectile (not convenient)
DeltaTimeBetweenCalls = 0.12 -- How frequently script is changing positions. Is 3 physics frames for lag reduce
SinPhaseShift = 0.02 -- Phase offset for the sinewave (not used currently)
SinFrequencyModifier = 3 -- How frequently the projectile does ∿∿wObBlE∿∿
SinAmplitudeModifier = 3 -- How deep is the Sinewave motion
TimeToMaxSin = 3 -- Time interval of how fast the projectile reaches max amplitude point in seconds. Why this exists? IDK. Nobody really does.
Reload = 35

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