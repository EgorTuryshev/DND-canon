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
					{ texture = path .. "/effects/media/dice_1.png" },
					{ texture = path .. "/effects/media/dice_2.png" },
					{ texture = path .. "/effects/media/dice_3.png" },
					{ texture = path .. "/effects/media/dice_4.png" },
					{ texture = path .. "/effects/media/dice_5.png" },
					{ texture = path .. "/effects/media/dice_6.png" },
					{ texture = path .. "/effects/media/dice_7.png" },
					{ texture = path .. "/effects/media/dice_8.png" },
					{ texture = path .. "/effects/media/dice_9.png" },
					{ texture = path .. "/effects/media/dice_10.png" },
					{ texture = path .. "/effects/media/dice_11.png" },
					{ texture = path .. "/effects/media/dice_12.png" },
					{ texture = path .. "/effects/media/dice_13.png" },
					{ texture = path .. "/effects/media/dice_14.png" },
					{ texture = path .. "/effects/media/dice_15.png" },
					{ texture = path .. "/effects/media/dice_16.png" },
					{ texture = path .. "/effects/media/dice_17.png" },
					{ texture = path .. "/effects/media/dice_18.png" },
					{ texture = path .. "/effects/media/dice_19.png" },
					{ texture = path .. "/effects/media/dice_20.png" },
					{ texture = path .. "/effects/media/dice_21.png" },
					{ texture = path .. "/effects/media/dice_22.png" },
					{ texture = path .. "/effects/media/dice_23.png" },
					{ texture = path .. "/effects/media/dice_24.png" },
					{ texture = path .. "/effects/media/dice_25.png" },
					{ texture = path .. "/effects/media/dice_26.png" },
					{ texture = path .. "/effects/media/dice_27.png" },
					{ texture = path .. "/effects/media/dice_28.png" },
					{ texture = path .. "/effects/media/dice_29.png" },
					{ texture = path .. "/effects/media/dice_30.png" },
					{ texture = path .. "/effects/media/dice_31.png" },
					{ texture = path .. "/effects/media/dice_32.png" },
					{ texture = path .. "/effects/media/dice_33.png" },
					{ texture = path .. "/effects/media/dice_34.png" },
					{ texture = path .. "/effects/media/dice_35.png" },

					{ texture = path .. "/effects/media/dice_1.png", colour = { 1, 1, 1, 0 }, duration = 2 },

					duration = 0.0416666666666667,
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
		LocalPosition = { x = 0, y = 100, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "dice_roll", -- defined above
		Additive = false,
		TimeToLive = 1.5,
		InitialSize = 1,
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
