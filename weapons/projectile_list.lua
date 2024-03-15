howitzer = FindProjectile("howitzer")

if howitzer then
    shell1 = DeepCopy(howitzer)
    shell1.SaveName = "shell1"
    shell1.ProjectileDamage = 750
	shell1.AntiAirHitpoints = 110
    shell1.Impact = 500000
    shell1.ProjectileSprite = path.. "/weapons/sprites/shell1.png"
	shell1.ProjectileThickness = 10.0
    shell1.ProjectileShootDownRadius = 60
end
table.insert(Projectiles, shell1)

if howitzer then
    shell20 = DeepCopy(howitzer)
    shell20.SaveName = "shell20"
    shell20.ProjectileDamage = 750
	shell20.AntiAirHitpoints = 110
    shell20.Impact = 500000
    shell20.ProjectileSprite = path.. "/weapons/sprites/shell20.png"
	shell20.ProjectileThickness = 10.0
    shell20.ProjectileShootDownRadius = 60
end
table.insert(Projectiles, shell20)