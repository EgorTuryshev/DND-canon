howitzer = FindProjectile("howitzer")
if howitzer then
    dndanon = DeepCopy(howitzer)
    dndanon.SaveName = "dndanon"
    dndanon.ProjectileDamage = 750
	dndanon.AntiAirHitpoints = 110
    dndanon.Impact = 500000
    dndanon.ProjectileSprite = path.. "/weapons/sprites/shell20.png"
	dndanon.ProjectileThickness = 10.0
    dndanon.ProjectileShootDownRadius = 60
end
table.insert(Projectiles, dndanon)