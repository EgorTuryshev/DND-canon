dofile("mods/dlc1_weapons/weapons/howitzer.lua")
dofile("scripts/device_utility.lua")

Sprites = {}
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
Recoil = 3000000

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
                    { texture = path .. "/weapons/sprites/barrel.png"},
                    mipmap = true
                }
            },
        }
    }
}

local barrel = FindSpriteComponent(Root, "Barrel")
if barrel then
    barrel.Sprite = path .. "/weapons/sprites/barrel.png"
end
local base = FindSpriteComponent(Root, "Howitzer")
if base then
    base.Sprite = path .. "/weapons/sprites/base.png"
end

Root = 
{
    Name = "Howitzer",
    Sprite = "dndanon-base",
    UserData = 0,
    Angle = 0,
    Pivot = { 0, -0.46 },
    PivotOffset = { 0, -0.05 },
    ChildrenBehind = 
    {
        {
            Sprite = "dndanon-head",
            Name = "Head",
            UserData = 50,
            Angle = 0,
            Pivot = { 0.07, -0.37 },
            PivotOffset = { 0.2, -0.12 },
            ChildrenInFront = 
            {
                {
                    Pivot = { 0, 0},
                    Angle = 90,
                    Name = "Hardpoint0",
                    PivotOffset = { 0, 0 }
                },
                {
                    Pivot = { -0.05 , -0.5 },
                    Angle = 0,
                    Name = "Chamber",
                    PivotOffset = { 0, 0 },
                }
            },
        },
        {
            Name = "Icon",
            Pivot = { 0, 0.5 }
        }
    },
}