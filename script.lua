dofile("scripts/forts.lua")

local RPdebug = true

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    if weaponId ~= -1 and saveName == "dndanon" then
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
    local shells = {"shell1", "shell2", "shell3", "shell4", "shell5", 
                "shell6", "shell7", "shell8", "shell9", "shell10",
                "shell11", "shell12", "shell13", "shell14", "shell15",
                "shell16", "shell17", "shell18", "shell19", "shell20"}
    local selectedIndex = GetRandomIntegerLocal(1, #shells)

    --selectedIndex = 6
    
    local proj = shells[selectedIndex]

    local projectileId = dlc2_CreateProjectile(proj.."_nocol", proj, teamId, pos, velocity, age)

    if selectedIndex == 1 then
        DoShell_1_Script(origWeaponId)
    elseif selectedIndex == 6 then
        DoShell_6_Script(proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 20 then
        DoShell_20_Script(proj, teamId, pos, velocity, age, projectileId)
    end

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

function CreateDeviation(degreeAngle, proj, teamId, pos, velocity, age, origWeaponId)
	local rad = math.pi / 180
	local sin_angle = math.sin(degreeAngle * rad)
	local cos_angle = math.cos(degreeAngle * rad)
	
	local deviation = dlc2_CreateProjectile(proj.."_nocol", proj, teamId, pos, Vec3(velocity.x * cos_angle - velocity.y * sin_angle, velocity.x * sin_angle + velocity.y * cos_angle), age)	

    local agetrigger = GetNodeProjectileAgeTrigger(origWeaponId)

    if origWeaponId > 0 then
        NoColProjectileEnd(deviation,0)
    else
        SetNodeProjectileAgeTrigger(deviation,0.1)
    end
    if agetrigger and agetrigger > 0 then
        data.AgeTriggers[deviation] = agetrigger
    end
end

function OnProjectileDestroyed(nodeId, teamId, saveName, structureIdHit, destroyType)
    local name = GetNodeProjectileSaveName(nodeId)
    if name == "shell6" and destroyType == 2 then
        local velocity = NodeVelocity(nodeId)
        local pos = NodePosition(nodeId)
        local age = GetNodeProjectileTimeRemaining(nodeId)
        if teamId == 1 then
            teamId = 2
        else
            teamId = 1
        end
        CreateDeviation(-180, name, teamId, pos, velocity, age, nodeId)
    end
end

--------------------------------------------------------------------------------------------------------------

function DoShell_1_Script (origWeaponId)
    ScheduleCall(0, ApplyDamageToDevice, origWeaponId, 10000)
end
function DoShell_2_Script (proj, teamId, pos, velocity, age, projectileId)

end
function DoShell_3_Script (proj, teamId, pos, velocity, age, projectileId)

end
function DoShell_4_Script (proj, teamId, pos, velocity, age, projectileId)

end
function DoShell_5_Script (proj, teamId, pos, velocity, age, projectileId)

end
function DoShell_6_Script (proj, teamId, pos, velocity, age, projectileId)

end
function DoShell_20_Script (proj, teamId, pos, velocity, age, projectileId)
    CreateDeviation(10, proj, teamId, pos, velocity, age, projectileId)
    CreateDeviation(-10, proj, teamId, pos, velocity, age, projectileId)
end

--------------------------------------------------------------------------------------------------------------

function LogDebug(s) if RPdebug then Log(s) end end

function Load()
    ProtectedFunction(Loadpcall)
end

function Loadpcall()
    if not data.AgeTriggers then data.AgeTriggers = {} end
end
