dofile("scripts/type.lua")
local howitzer = FindWeapon("howitzer")
if howitzer then
    table.insert(Sprites, ButtonSprite("hud-dndanon-icon", "HUD/HUD-dndanon", nil, ButtonSpriteBottom, nil, nil, path))
    table.insert(Weapons, IndexOfWeapon("howitzer") + 1,
        InheritType(FindWeapon("howitzer"),nil,
            {
                SaveName = "dndanon",
                FileName = path .. "/weapons/dndanon.lua",
                Icon = "hud-dndanon-icon",
                MetalCost = 950,
                EnergyCost = 8500,
				BuildTimeComplete = 40,
                Prerequisite = "munitions",
                Enabled = true,
            }
        )
    )
end