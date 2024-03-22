LifeSpan = 1

Sprites =
{
	{
		Name = "roll_18",
		States =
		{
			Normal =
			{
				Frames =
				{
					{ texture = path .. "/effects/media/anim_18.png"},

					duration = 1,
					blendColour = false,
					blendCoordinates = false,
				},
                NextState = "Normal",
			},
		},
	},
}

Effects =
{
	{
		Type = "sprite",
		PlayForEnemy = true,
		TimeToTrigger = 0,
		LocalPosition = { x = -120, y = 40, z = 0 },
		LocalVelocity = { x = 0, y = 30, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0.0,
		Sprite = "roll_18",
		Additive = false,
		TimeToLive = 1,
		InitialSize = 4,
		ExpansionRate = 0,
		Angle = -22.5,
		AngleMaxDeviation = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
	},
}