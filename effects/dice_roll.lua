-- how long the effect can last, even if component effects are still going
LifeSpan = 2

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
					{ texture = path .. "/effects/media/anim1.png" },
					{ texture = path .. "/effects/media/anim2.png" },
					{ texture = path .. "/effects/media/anim3.png" },
                    { texture = path .. "/effects/media/anim4.png" },
					{ texture = path .. "/effects/media/anim5.png" },
					{ texture = path .. "/effects/media/anim6.png" },
                    { texture = path .. "/effects/media/anim7.png" },
					{ texture = path .. "/effects/media/anim8.png" },
					{ texture = path .. "/effects/media/anim9.png" },
                    { texture = path .. "/effects/media/anim10.png" },
					{ texture = path .. "/effects/media/anim11.png" },
					{ texture = path .. "/effects/media/anim12.png" },
                    { texture = path .. "/effects/media/anim13.png" },
					{ texture = path .. "/effects/media/anim14.png" },
					{ texture = path .. "/effects/media/anim15.png" },
                    { texture = path .. "/effects/media/anim16.png" },
					{ texture = path .. "/effects/media/anim17.png" },
					{ texture = path .. "/effects/media/anim18.png" },
                    { texture = path .. "/effects/media/anim19.png" },
					{ texture = path .. "/effects/media/anim20.png" },
					{ texture = path .. "/effects/media/anim4.png", colour = { 1, 1, 1, 0 }, duration = 2 },

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
		TimeToLive = 2,
		InitialSize = 3,
		ExpansionRate = 0,
		Angle = -90,
		AngleMaxDeviation = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
	},
}
