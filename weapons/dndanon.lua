dofile("mods/dlc1_weapons/weapons/howitzer.lua")
dofile("scripts/device_utility.lua")

Sprites = {}
--FireDelay = 3
Projectile = "shell1"
FireEffect = "mods/dlc1_weapons/effects/fire_howitzer.lua"
ShellEffect = "mods/dlc1_weapons/effects/shell_eject_howitzer.lua"
ConstructEffect = "effects/device_upgrade.lua"
CompleteEffect = "effects/device_complete.lua"
DestroyEffect = "mods/dlc1_weapons/effects/howitzer_explode.lua"
ReloadEffect = "mods/dlc1_weapons/effects/reload_howitzer.lua"
WeaponMass = 600
MinFireAngle = 0
MaxFireAngle = 85
Hitpoints = 450
DeviceSplashDamage = 1000
DeviceSplashMaxRadius = 1000
StructureSplashDamage = 1000
ProjectileSplashDamageMaxRadius = 1000
MetalFireCost = 120
EnergyFireCost = 6500
Recoil = 2000000

--[[ FireStdDev = 0.005
FireStdDevAuto = 0.005
RoundsEachBurst = 5
RoundPeriod = 0.1
RetriggerFireEffect = true ]]

Sprites = 
{
    {
        Name = "dndanon-base",
        States = 
        {
            Normal = 
            {
                Frames = 
                {
                    { texture = path .. "/weapons/sprites/base.png"},
                    mipmap = true
                }
            },
        }
    },
    {
        Name = "dndanon-head",
        States = 
        {
            Normal = 
            {
                Frames = 
                {
                    { texture = path .. "/weapons/sprites/head.png"},
                    mipmap = true
                }
            },
        }
    },
	{
        Name = "dndanon-barrel",
        States = 
        {
            Normal = 
            {
                Frames = 
                {
                    { texture = path .. "/weapons/sprites/barrel.png"},
                    mipmap = true
                }
            },
        }
    }
}

BarrelLength = 103.875
BarrelRecoilLimit = -0.65
BarrelRecoilSpeed = -7
BarrelReturnForce = 0.4
Root = 
{
    Name = "Howitzer",
    Sprite = "dndanon-base",
    UserData = 0,
    Angle = 0,
    Pivot = { 0, -0.46 },
    -- PivotOffset = { 0, -0.05 },
    ChildrenBehind = 
    {
        {
            Sprite = "dndanon-head",
            Name = "Head",
            UserData = 50,
            Angle = 0,
            Pivot = {-0.175, -0.29245283018867924},
            PivotOffset = {0.02861952861952862, -0.0982532751091703},
			
			ChildrenBehind =
			{
				{
					Name = "Barrel",
					Angle = 0,
					Pivot ={0.85, 0.07275109170305677},
					PivotOffset = { 0.0, 0 },
					Sprite = "dndanon-barrel",
					UserData = 100,
				},
				{
					Name = "Hardpoint0",
					Angle = 90,
					Pivot = {0.37542087542087543, 0.03275109170305677},
					PivotOffset = { 0, 0 },
				},
				{
					Name = "Chamber",
					Angle = 0,
					Pivot = {-0.43265993265993263, -0.39082969432314413},
					PivotOffset = { 0, 0 },
				},
				
			},
        },
        {
            Name = "Icon",
            Pivot = { 0, 0.5 }
        }
    },
}