-- how long the effect can last, even if component effects are still going
LifeSpan = 4

-- list of (potentially animated) sprites. be careful of duplicate names.
Sprites =
{
	{
		Name = "dice_roll",
		States =
		{
			Normal =
			{
				Frames =
				{
					-- the last frame is blank to prevent looping
					{ texture = path .. "/effects/media/anim_1.png" },
					{ texture = path .. "/effects/media/anim_20.png" },
					{ texture = path .. "/effects/media/anim_4.png" },
                    { texture = path .. "/effects/media/anim_16.png" },
					{ texture = path .. "/effects/media/anim_7.png" },
					{ texture = path .. "/effects/media/anim_10.png" },
                    { texture = path .. "/effects/media/anim_9.png" },
					{ texture = path .. "/effects/media/anim_13.png" },
					{ texture = path .. "/effects/media/anim_19.png" },
                    { texture = path .. "/effects/media/anim_5.png" },
					{ texture = path .. "/effects/media/anim_4.png", colour = { 1, 1, 1, 0 }, duration = 2 },

					duration = 0.1,
					blendColour = true,
					blendCoordinates = false,
				},
                NextState = "Normal",
			},
		},
	},
}

-- list of sub-effects that make up this effect
Effects =
{
	{
		Type = "sprite",
		PlayForEnemy = true,
		TimeToTrigger = 0,
		LocalPosition = { x = -40, y = -220, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "dice_roll", -- defined above
		Additive = false,
		TimeToLive = 1,
		InitialSize = 3,
		ExpansionRate = 0,
		Angle = -90,
		AngleMaxDeviation = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
	},
	{
		Type = "sound",
		TimeToTrigger = 0.0,
		LocalPosition = { x = 0, y = 0, z = 0 },
		Sound = path .. "/effects/media/Dnd-shoot.wav",
		Volume = 1,
	},
}
