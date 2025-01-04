-- Important Line!
-- Position for roll ending effect for both teams (angular distance of a hardpoint)
RollEffectAngularDistance = 200

-- Sinewave parameters for drunk projectile (not convenient)
DeltaTimeBetweenCalls = 0.12 -- How frequently script is changing positions. Is 3 physics frames for lag reduce
SinPhaseShift = 0.02 -- Phase offset for the sinewave (not used currently)
SinFrequencyModifier = 3 -- How frequently the projectile does ∿∿wObBlE∿∿
SinAmplitudeModifier = 3 -- How deep is the Sinewave motion
TimeToMaxSin = 3 -- Time interval of how fast the projectile reaches max amplitude point in seconds. Why this exists? IDK. Nobody really does.

-- Piecewise function-like table for defining power of each range of d20 rolls
ProjectileConfigs = 
{
    {range = {1, 6}, modificator = 1, antiAirHpMod = 0.6, isShrapnel = false, shield = {DestroyShields = false, DeflectedByShields = true}, isSin = true},
    {range = {7, 9}, modificator = 1, antiAirHpMod = 0.8, isShrapnel = false, shield = {DestroyShields = false, DeflectedByShields = true}, isSin = true},
    {range = {10, 10}, modificator = 1, antiAirHpMod = 1, isShrapnel = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {11, 11}, modificator = 1, antiAirHpMod = 1, isShrapnel = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {12, 14}, modificator = 1.33, antiAirHpMod = 1.33, isShrapnel = false, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
    {range = {15, 19}, modificator = 1.67, antiAirHpMod = 1.67, isShrapnel = true, shield = {DestroyShields = true, DeflectedByShields = false}, isSin = false},
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
    [20] = {"shell20", "unluckMarker", "fireball"}
}