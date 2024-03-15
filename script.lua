dofile("scripts/forts.lua")

local weaponfired
function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    if not weaponfired then
        Log("fired weapon")
        weaponfired = true
    end
    if weaponId ~= -1 then
        ProtectedFunction(OnWeaponFiredpcall,teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    end
end

function OnWeaponFiredpcall(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)

    local velocity = NodeVelocity(projectileNodeId)
    local pos = NodePosition(projectileNodeId)
    local age = GetNodeProjectileTimeRemaining(projectileNodeId)

    local projectile = SpawnRandomProjectile(projectileNodeId, weaponId, teamId, pos, velocity, age)

    if projectile ~= "invalid" then
        LogW(RGBAtoHex(255, 200, 100, 255, true).."Old Projectile Destroyed")
        DestroyProjectile(projectileNodeId)
    end
end

function SpawnRandomProjectile(origProjectileId, origWeaponId, teamId, pos, velocity, age)
    local selectedShell = GetRandomIntegerLocal(1, 2)
    local shell = "shell1"
    if selectedShell == 2 then
        shell = "shell20"
    end

    local projectileId = dlc2_CreateProjectile(shell, "", teamId, pos, velocity, age)

    return projectileId
end

function ProtectedFunction(func,...)
    local success,output = pcall(func,unpack(arg))
    if not success then
        LogW(RGBAtoHex(255, 200, 100, 255, true)..str.ErrorMessage)
        Log("Error: "..output)
    end
end

function RGBAtoHex(r, g, b, a, UTF16)
    local hex = string.format("%02X%02X%02X%02X", r, g, b, a)
    if UTF16 == true then return L"[HL=" .. towstring(hex) .. L"]" else return "[HL=" .. hex .. "]" end
end