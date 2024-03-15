dofile("scripts/type.lua")
local howitzer = FindWeapon("howitzer")
if howitzer then
    table.insert(Weapons, IndexOfWeapon("howitzer") + 1,
        InheritType(FindWeapon("howitzer"),nil,
            {
                SaveName = "dndanon",
                FileName = path .. "/weapons/dndanon.lua",
                MetalCost = 1300,
                EnergyCost = 12000,
				BuildTimeComplete = 45,
                Prerequisite = "upgrade",
                Enabled = true,
            }
        )
    )
	if not howitzer.Upgrades then howitzer.Upgrades = {} end
    table.insert(howitzer.Upgrades,
    {
        Enabled = true,
        SaveName = "dndanon",
        MetalCost = 500,
        EnergyCost = 4000,
		MetalFireCost = 120,
		EnergyFirecost = 6500,
    })
end