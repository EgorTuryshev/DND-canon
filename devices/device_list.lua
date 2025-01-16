dofile("scripts/forts.lua")

table.insert(Sprites, DetailSprite("hud-detail-increment-module", "HUD-Details-Increment_Module", path))
table.insert(Sprites, ButtonSprite("hud-increment-module-icon", "HUD/HUD_Increment_Module", nil, ButtonSpriteBottom, nil, nil, path))

table.insert(Devices,
{
	Enabled = true,
	SaveName = "increment_module",
	FileName = path .. "/devices/incrementmodule/increment_module.lua",
	Icon = "hud-increment-module-icon",
	Detail = "hud-detail-increment-module",
	--Prerequisite = "upgrade",
	BuildTimeComplete = 110.0,
	ScrapPeriod = 12,
	MetalCost = 400,
	EnergyCost = 5000,
	MetalRepairCost = 300,
	EnergyRepairCost = 2500,
	MetalReclaimMin = 0.1,
	MetalReclaimMax = 0.5,
	EnergyReclaimMin = 0.1,
	EnergyReclaimMax = 0.5,
	PopulationCap = 4,
	MaxUpAngle = StandardMaxUpAngle,
	BuildOnGroundOnly = false,
	SelectEffect = "ui/hud/devices/ui_devices",
})