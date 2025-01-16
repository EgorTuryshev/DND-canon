dofile(path .. "/globals.lua")

ConstructEffect = "effects/device_construct.lua"
CompleteEffect = "effects/device_complete.lua"
Scale = 1.0
SelectionOffset = { 0, -90 }
SelectionWidth = 45
SelectionHeight = 90
Mass = 100.0
HitPoints = 300.0
RepairFieldRadius = SpongeModuleRadius*0.8
RepairFieldPeriod = 99999999
EnergyProductionRate = 0.0
MetalProductionRate = -5.0
EnergyStorageCapacity = 0.0
MetalStorageCapacity = 0.0
DeviceSplashDamage = 50
DeviceSplashDamageMaxRadius = 150
DeviceSplashDamageDelay = 0.5
IncendiaryRadius = 200
StructureSplashDamage = 50
StructureSplashDamageMaxRadius = 100
DestroyEffect = "effects/battery_explode.lua"

Sprites =
{
	{
		Name = "sponge_module_base",

		States =
		{
			Normal =
			{
				Frames =
				{
					{ texture = path .. "/devices/spongemodule/base.tga" },
				},
			},
		},
	}
}
Root =
{
	Name = "Sponge",
	Pivot = { 0, -0.5 },
	Sprite = "sponge_module_base",
	Scale = 1
}
