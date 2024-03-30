-- how long the effect can last, even if component effects are still going
LifeSpan = 15

-- list of (potentially animated) sprites. be careful of duplicate names.
Sprites =
{
	{
		Name = "counter",
		States =
		{
			Normal =
			{
				Frames =
				{
					-- the last frame is blank to prevent looping
					{ texture = path .. "/effects/media/anim_15.png" },
					{ texture = path .. "/effects/media/anim_14.png" },
					{ texture = path .. "/effects/media/anim_13.png" },
					{ texture = path .. "/effects/media/anim_12.png" },
					{ texture = path .. "/effects/media/anim_11.png" },
					{ texture = path .. "/effects/media/anim_10.png" },
					{ texture = path .. "/effects/media/anim_9.png" },
					{ texture = path .. "/effects/media/anim_8.png" },
					{ texture = path .. "/effects/media/anim_7.png" },
					{ texture = path .. "/effects/media/anim_6.png" },
					{ texture = path .. "/effects/media/anim_5.png" },
					{ texture = path .. "/effects/media/anim_4.png" },
					{ texture = path .. "/effects/media/anim_3.png" },
					{ texture = path .. "/effects/media/anim_2.png" },
					{ texture = path .. "/effects/media/anim_1.png" },
					{ texture = path .. "/effects/media/anim_4.png", colour = { 1, 1, 1, 0 }, duration = 2 },

					duration = 1,
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
		LocalPosition = { x = 0, y = 0, z = -50 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "counter", -- defined above
		Additive = false,
		TimeToLive = 15,
		InitialSize = 1,
		ExpansionRate = 0,
		Angle = 0,
		AngleMaxDeviation = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
	},
}
