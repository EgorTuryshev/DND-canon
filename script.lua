dofile("scripts/forts.lua")

local RPdebug = true

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    if weaponId ~= -1 then
        ProtectedFunction(OnWeaponFiredpcall,teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    end
end

function OnWeaponFiredpcall(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)

    local name = GetNodeProjectileSaveName(projectileNodeId)
    local velocity = NodeVelocity(projectileNodeId)
    local pos = NodePosition(projectileNodeId)
    local age = GetNodeProjectileTimeRemaining(projectileNodeId)
    local agetrigger = GetNodeProjectileAgeTrigger(projectileNodeId)

    if data.AgeTriggers[projectileNodeIdFrom] then
        SetNodeProjectileAgeTrigger(projectileNodeId,data.AgeTriggers[projectileNodeIdFrom])
    end
    if name:find("nocol") or GetNodeProjectileSaveName(projectileNodeIdFrom):find("nocol") then return end

    local projectile = SpawnRandomProjectile(projectileNodeId, weaponId, teamId, pos, velocity, age, agetrigger)
    if projectile ~= "invalid" then
        DestroyProjectile(projectileNodeId)
    end
end

function SpawnRandomProjectile(origProjectileId, origWeaponId, teamId, pos, velocity, age, agetrigger)
    local selectedShell = GetRandomIntegerLocal(1, 2)
    local proj = "shell1"
    if selectedShell == 2 then
        proj = "shell20"
    end
    local projectileId = dlc2_CreateProjectile(proj.."_nocol", proj, teamId, pos, velocity, age)
    if origWeaponId > 0 then
        NoColProjectileEnd(projectileId,0)
    else
        SetNodeProjectileAgeTrigger(projectileId,0.1)
    end
    if agetrigger and agetrigger > 0 then
        data.AgeTriggers[projectileId] = agetrigger
    end
    return projectileId
end

function NoColProjectileEnd(id,timesrepeated)
    if not NodeExists(id) then return end
    timesrepeated = timesrepeated+1
    local pos,vel = NodePosition(id),NodeVelocity(id)
    local ray = CastRay(pos,pos+Vec3(vel.x/100,vel.y/100),0,0)
    if ray == RAY_HIT_DEVICE then
        ScheduleCall(0,NoColProjectileEnd,id,timesrepeated)
        if data.AgeTriggers[id] then
            data.AgeTriggers[id] = data.AgeTriggers[id]-0.04*timesrepeated+0.02
        end
    else SetNodeProjectileAgeTrigger(id,0.04*timesrepeated) end
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

function LogDebug(s) if RPdebug then Log(s) end end

function Load()
    ProtectedFunction(Loadpcall)
end

function Loadpcall()
    if not data.AgeTriggers then data.AgeTriggers = {} end
end
