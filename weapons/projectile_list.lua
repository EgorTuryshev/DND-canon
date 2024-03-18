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
    shell1.DndProjectile = true
    Projectiles[#Projectiles+1] = shell1

    shell20 = DeepCopy(howitzer)
    shell20.SaveName = "shell20"
    shell20.ProjectileDamage = 750
    shell20.AntiAirHitpoints = 110
    shell20.Impact = 500000
    shell20.ProjectileSprite = path.. "/weapons/sprites/shell20.png"
    shell20.ProjectileThickness = 10.0
    shell20.ProjectileShootDownRadius = 60
    shell20.DndProjectile = true
    Projectiles[#Projectiles+1] = shell20
end


for i, v in ipairs(Projectiles) do
    if v.DndProjectile then
       local nocol = DeepCopy(v)
       nocol.SaveName = v.SaveName .. "_nocol"
       nocol.CollidesWithProjectiles = false
       nocol.ProjectileIncendiary = false
       nocol.AlwaysPassDevices = true
       nocol.WeaponDamageBonus = 0
       nocol.EMPDuration = 0
       nocol.ProjectileDamage = 0
       nocol.DndProjectile = false
       if not nocol.DamageMultiplier then nocol.DamageMultiplier = {} end
       if not nocol.Effects then nocol.Effects = {} end
       if not nocol.Effects.Impact then nocol.Effects.Impact = {} end
       nocol.DamageMultiplier[#nocol.DamageMultiplier + 1] = { SaveName = "weapon", Direct = 0 }
       nocol.Effects.Impact.device = {
           Effect = nil,
           Terminate = false,
           Splash = false
       }
       nocol.Effects.Age = { ["t500"] = { Projectile = { Count = 1, Type = v.SaveName }, Splash = false } }
       Projectiles[#Projectiles+1] = nocol
   end
end    