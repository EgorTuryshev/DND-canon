dofile("effects/device_explode_util.lua")
--  age (in seconds) at which the explosion actor deletes itself
--  make sure this exceedes the age of all effects
LifeSpan = 8
Sprites =
{
	{
		Name = "markerIdle",
				
		States =
		{
			Normal =  
			{  
				Frames =
				{
					{ texture = path .. "/weapons/sprites/shell20.png" },
					duration = 0.08,
					mipmap = true,
				},
				NextState = "Normal",
			},
		},
	}
}
Effects =
{	
	--flare sprite
	{
		Type = "sprite",
		TimeToTrigger = 0.0,
		LocalPosition = { x = 0, y = 10, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0,
		Sprite = "markerIdle",
		Additive = false,
		TimeToLive = 4,
		InitialSize = 4,
		ExpansionRate = 0,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 255 },
	},
	--flare smoke
	{
		Type = "sparks",
		TimeToTrigger = 0.0,
		TimeToStop = 4,
		TimeToLive = 4,
		SparkCount = 12,
		BurstPeriod = 0.16,
		SparksPerBurst = 1,
		LocalPosition = { x = -13, y = 10, z = -45 },
		Sprite = "effects/media/smoke.tga",

		Gravity = -981,

		NormalDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Mean = 0,
			StdDev = 15,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},
		
		Keyframes =							
		{
			{
				Angle = 0,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = 3,
				ScaleStdDev = 0.015,
				SpeedStretch = 0,
				SpeedMean = 0,
				SpeedStdDev = 0,
				Drag = 5,
				RotationMean = 0,
				RotationStdDev = 45,
				RotationalSpeedMean = 0,
				RotationalSpeedStdDev = 15,	
				AgeMean = 2,
				AgeStdDev = .025,
				AlphaKeys = { 0.5, 0.6 },
				ScaleKeys = { 0.4, 0.4 },
				colour = { 255, 255, 255, 200 },
			},
		},
	},
	--flare green smoke
	{
		Type = "sparks",
		TimeToTrigger = 0.0,
		TimeToLive = 4,
		TimeToStop = 4,
		SparkCount = 6,
		BurstPeriod = 0.16,
		SparksPerBurst = 1,
		LocalPosition = { x = -13, y = 10, z = -49 },
		Sprite = "effects/media/HowitzerParticles11.png",

		Gravity = -981,

		NormalDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Mean = 0,
			StdDev = 15,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},
		
		Keyframes =							
		{
			{
				Angle = 0,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = 2.0,
				ScaleStdDev = 0.015,
				SpeedStretch = 0,
				SpeedMean = 0,
				SpeedStdDev = 0,
				Drag = 5,
				RotationMean = 0,
				RotationStdDev = 45,
				RotationalSpeedMean = 0,
				RotationalSpeedStdDev = 15,	
				AgeMean = 1,
				AgeStdDev = .025,
				AlphaKeys = { 0.5, 0.6 },
				ScaleKeys = { 0.4, 0.4 },
				colour = { 150, 255, 100, 200 },
			},
		},
	},
	--flare white smoke
	{
		Type = "sparks",
		TimeToTrigger = 0.0,
		TimeToLive = 4,
		TimeToStop = 4,
		SparkCount = 6,
		BurstPeriod = 0.16,
		SparksPerBurst = 1,
		LocalPosition = { x = -13, y = 10, z = -50 },
		Sprite = "effects/media/glow03.tga",

		Gravity = -981,

		NormalDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Mean = 0,
			StdDev = 15,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},
		
		Keyframes =							
		{
			{
				Angle = 0,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = 0.8,
				ScaleStdDev = 0.015,
				SpeedStretch = 0,
				SpeedMean = 0,
				SpeedStdDev = 0,
				Drag = 5,
				RotationMean = 0,
				RotationStdDev = 45,
				RotationalSpeedMean = 0,
				RotationalSpeedStdDev = 15,	
				AgeMean = 0.5,
				AgeStdDev = .025,
				AlphaKeys = { 0.5, 0.6 },
				ScaleKeys = { 0.4, 0.4 },
				colour = { 255, 255, 255, 180 },
			},
		},
	},
	--mortar_air_burst effects below. (used in swarm explosions)
	{
		Type = "sprite",
		TimeToTrigger = 4.2,
		LocalPosition = { x = 0, y = 0, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0,
		Sprite = "effects/media/CloudLarge",
		Additive = false,
		TimeToLive = 1.5,
		InitialSize = 0.5,
		ExpansionRate = 200,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 0 },
	},
	{
	--SPARKS
		Type = "sparks",
		TimeToTrigger = 4.18,
		SparkCount = 8,
		LocalPosition = { x = 0, y = 0, z = -0.5 },	-- how to place the origin relative to effect position and direction (0, 0) 
		Texture = "effects/media/flame",

		Gravity = 250,						-- gravity applied to particle (981 is earth equivalent)
		
		EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Min = -180,						-- minimum angle in degrees (e.g. -180, 45, 0)
			Max = 180,						-- maximum angle in degrees (e.g. -180, 45, 0)
			StdDev = 5,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},

		Keyframes =							
		{
			{
				Angle = -180,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = 0.4,
				ScaleStdDev = 0.05,
				SpeedStretch = 0,
				SpeedMean = 1000,
				SpeedStdDev = 200,
				Drag = 3,
				RotationMean = 45,
				RotationStdDev = 10,
				RotationalSpeedMean = 10,
				RotationalSpeedStdDev = 5,
				AgeMean = 0.25,
				AgeStdDev = 0.05,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
			{
				Angle = 180,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = 0.4,
				ScaleStdDev = 0.05,
				SpeedStretch = 0,
				SpeedMean = 1000,
				SpeedStdDev = 200,
				Drag = 3,
				RotationMean = -45,
				RotationStdDev = -10,
				RotationalSpeedMean = 10,
				RotationalSpeedStdDev = 5,
				AgeMean = 0.25,
				AgeStdDev = 0.05,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
		},
	},
	{
	--DEBRIS
		Type = "sparks",
		TimeToTrigger = 4.2,
		SparkCount = 8,
		LocalPosition = { x = 0, y = 0, z = -0.25 },	-- how to place the origin relative to effect position and direction (0, 0) 
		Texture = "effects/media/debris",

		Gravity = 250,						-- gravity applied to particle (981 is earth equivalent)
		
		EvenDistribution =					-- distribute sparks evenly between two angles with optional variation
		{
			Min = -180,						-- minimum angle in degrees (e.g. -180, 45, 0)
			Max = 180,						-- maximum angle in degrees (e.g. -180, 45, 0)
			StdDev = 5,						-- standard deviation at each iteration in degrees (zero will make them space perfectly even)
		},

		Keyframes =							
		{
			{
				Angle = -180,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = 0.5,
				ScaleStdDev = 0.1,
				SpeedStretch = 0.2,
				SpeedMean = 1000,
				SpeedStdDev = 200,
				Drag = 3,
				RotationMean = 45,
				RotationStdDev = 10,
				RotationalSpeedMean = 10,
				RotationalSpeedStdDev = 5,
				AgeMean = 0.25,
				AgeStdDev = 0.05,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
			{
				Angle = 180,
				RadialOffsetMin = 0,
				RadialOffsetMax = 20,
				ScaleMean = 0.4,
				ScaleStdDev = 0.05,
				SpeedStretch = 0,
				SpeedMean = 1000,
				SpeedStdDev = 200,
				Drag = 3,
				RotationMean = -45,
				RotationStdDev = -10,
				RotationalSpeedMean = 10,
				RotationalSpeedStdDev = 5,
				AgeMean = 0.25,
				AgeStdDev = 0.05,
				AlphaKeys = { 0.1, 0.5 },
				ScaleKeys = { 0.1, 0.5 },
			},
		},
	},
	{
		Type = "sprite",
		TimeToTrigger = 4,
		LocalPosition = { x = 0, y = 0, z = 0 },
		LocalVelocity = { x = 0, y = 0, z = 0 },
		Acceleration = { x = 0, y = 0, z = 0 },
		Drag = 0,
		Sprite = "effects/media/AdditiveLarge",
		Additive = false,
		TimeToLive = 0.5,
		InitialSize = 1.0,
		ExpansionRate = 400,
		AngularVelocity = 0,
		RandomAngularVelocityMagnitude = 0,
		Colour1 = { 255, 255, 255, 255 },
		Colour2 = { 255, 255, 255, 0 },
	},
}