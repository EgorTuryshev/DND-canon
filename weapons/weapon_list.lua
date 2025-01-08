dofile("scripts/type.lua")
local howitzer = FindWeapon("howitzer")
if howitzer then
    table.insert(Sprites, ButtonSprite("hud-dndanon-icon", "HUD/HUD-dndanon", nil, ButtonSpriteBottom, nil, nil, path))
	table.insert(Sprites, DetailSprite("hud-detail-dndanon", "dndanon", path))
    table.insert(Weapons, IndexOfWeapon("howitzer") + 1,
        InheritType(FindWeapon("howitzer"),nil,
            {
                SaveName = "dndanon",
                FileName = path .. "/weapons/dndanon.lua",
                Icon = "hud-dndanon-icon",
				Detail = "hud-detail-dndanon",
                MetalCost = 1000,
                EnergyCost = 10000,
				BuildTimeComplete = 140,
                Prerequisite = "munitions",
                Enabled = true,
				PopulationCap = 4
            }
        )
    )
end

local unluckStorm = FindWeapon("minigun")
if unluckStorm then
	table.insert(Weapons,
		InheritType(FindWeapon("minigun"),nil,
			{	
				SaveName = "unluckStorm",
				FileName = path .. "/weapons/unluck_storm.lua",
				MetalCost = 0,
				EnergyCost = 0,
				BuildTimeComplete = 0.0,
				Prerequisite = nil,
				Enabled = false,
				dlc2_BuildAnywhere = true,
				RequiresSpotterToFire = false,
				AnimationScript = nil,
				BuildOnGroundOnly = true,
			}
		)
	)
end