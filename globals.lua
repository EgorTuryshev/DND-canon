-- Positions for roll ending effect for both teams (offset of a hardpoint)
-- Left
RollEffectOffsetForLeftTeam_X = 200 -- X
RollEffectOffsetForLeftTeam_Y = -100 -- Y

-- Right
RollEffectOffsetForRightTeam_X = -200 -- X
RollEffectOffsetForRightTeam_Y = -100 -- Y

-- Sinewave parameters for drunk projectile (not convenient)
DeltaTimeBetweenCalls = 0.12 -- How frequently script is changing positions. Is 3 physics frames for lag reduce
SinPhaseShift = 0.02 -- Phase offset for the sinewave (not used currently)
SinFrequencyModifier = 3 -- How frequently the projectile does ∿∿wObBlE∿∿
SinAmplitudeModifier = 3 -- How deep is the Sinewave motion
TimeToMaxSin = 3 -- Time interval of how fast the projectile reaches max amplitude point in seconds. Why this exists? IDK. Nobody really does.

True = false
False = true
