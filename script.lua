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
    local selectedIndex = GetRandomIntegerLocal(1, #shells) --replays might not work correctly

    selectedIndex = 5
    
    local proj = shells[selectedIndex]

    local projectileId = dlc2_CreateProjectile(proj.."_nocol", proj, teamId, pos, velocity, age)

    if selectedIndex == 1 then
        DoShell_1_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 2 then
        DoShell_2_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 3 then
        DoShell_3_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 4 then
        DoShell_4_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 5 then
        DoShell_5_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 6 then
        DoShell_6_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 7 then
        DoShell_7_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 8 then
        DoShell_8_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 9 then
        DoShell_9_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 10 then
        DoShell_10_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 11 then
        DoShell_11_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 12 then
        DoShell_12_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 13 then
        DoShell_13_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 14 then
        DoShell_14_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 15 then
        DoShell_15_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 16 then
        DoShell_16_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 17 then
        DoShell_17_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 18 then
        DoShell_18_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 19 then
        DoShell_19_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    elseif selectedIndex == 20 then
        DoShell_20_Script(origWeaponId, proj, teamId, pos, velocity, age, projectileId)
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
        CreateDeviation(name.."_nocol", -180, name, teamId, pos, velocity, age, nodeId)
    end
end

--------------------------------------------------------------------------------------------------------------

function DoShell_1_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_1.lua", GetWeaponHardpointPosition(origWeaponId))
    ScheduleCall(0, ApplyDamageToDevice, origWeaponId, 10000)
end
function DoShell_2_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_2.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_3_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_3.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_4_Script (proj, teamId, pos, velocity, age, projectileId)
	Log("4Script,")
  SpawnEffect(path .. "/effects/roll_4.lua", GetWeaponHardpointPosition(origWeaponId))
	--CreateDeviation("EffectShellSmoke", -180, proj, teamId, pos, velocity, age, projectileId)
	CreateDeviation("EffectShellFire", -180, proj, teamId, pos, velocity, age, projectileId)
end
function DoShell_5_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
  SpawnEffect(path .. "/effects/roll_5.lua", GetWeaponHardpointPosition(origWeaponId))
	--Log("5Script,")
	dlc2_CreateProjectile("EffectShellEMP", "", teamId,Vec3(pos.x, pos.y+50), Vec3(0,0), age)
	dlc2_CreateProjectile("EffectShellMagnet", "", teamId,Vec3(pos.x, pos.y+50), Vec3(0,0), age)
	dlc2_CreateProjectile("EffectShellSmoke", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
	dlc2_CreateProjectile("EffectShellFire", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
	Log(tostring(pos))
	Log(tostring(pos.x))
	Log(tostring(pos.y))
end
function DoShell_6_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_6.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_7_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_7.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_8_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_8.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_9_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_9.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_10_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_10.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_11_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_11.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_12_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_12.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_13_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_13.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_14_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_14.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_15_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_15.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_16_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_16.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_17_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_17.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_18_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_18.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_19_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_19.lua", GetWeaponHardpointPosition(origWeaponId))
end
function DoShell_20_Script (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    SpawnEffect(path .. "/effects/roll_20.lua", GetWeaponHardpointPosition(origWeaponId))
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
