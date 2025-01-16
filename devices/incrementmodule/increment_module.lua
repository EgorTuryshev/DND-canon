dofile(path .. "/globals.lua")

ConstructEffect = "effects/device_construct.lua"
CompleteEffect = "effects/device_complete.lua"
Scale = 1.0
SelectionOffset = { 0, -50 }
SelectionWidth = 45
SelectionHeight = 50
Mass = 100.0
HitPoints = 150.0
RepairFieldRadius = IncrementModuleRadius*0.8
RepairFieldPeriod = 99999999
EnergyProductionRate = -30.0
MetalProductionRate = 0.0
EnergyStorageCapacity = 0.0
MetalStorageCapacity = 0.0
DeviceSplashDamage = 70
DeviceSplashDamageMaxRadius = 150
DeviceSplashDamageDelay = 0.5
IncendiaryRadius = 200
StructureSplashDamage = 30
StructureSplashDamageMaxRadius = 100
DestroyEffect = "effects/battery_explode.lua"

Sprites =
{
	{
		Name = "increment_module_base",

		States =
		{
			Normal =
			{
				Frames =
				{
					{ texture = path .. "/devices/incrementmodule/base.tga" },
				},
			},
		},
	}
}
Root =
{
	Name = "Incrementator",
	Pivot = { 0, -0.259 },
	Sprite = "increment_module_base",
	Scale = 1
}
