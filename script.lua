dofile("scripts/forts.lua")
dofile(path .. "/globals.lua")

Shells = {"shell1", "shell2", "shell3", "shell4", "shell5", 
          "shell6", "shell7", "shell8", "shell9", "shell10",
          "shell11", "shell12", "shell13", "shell14", "shell15",
          "shell16", "shell17", "shell18", "shell19", "shell20", 
          "unluckMarker", "fireball"}

ShellScripts = {
    DoShell_1_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        ScheduleCall(0, ApplyDamageToDevice, origWeaponId, 10000)
    end,
    DoShell_2_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_3_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_4_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_5_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        dlc2_CreateProjectile("EffectShellEMP", "", teamId,Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        dlc2_CreateProjectile("EffectShellMagnet", "", teamId,Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        dlc2_CreateProjectile("EffectShellSmoke", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        dlc2_CreateProjectile("EffectShellFire", "", teamId, Vec3(pos.x, pos.y+50), Vec3(0,0), age)
        Log(tostring(pos))
        Log(tostring(pos.x))
        Log(tostring(pos.y))
    end,
    DoShell_6_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_7_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_8_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_9_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_10_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_11_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_12_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_13_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_14_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_15_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_16_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_17_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_18_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_19_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
    end,
    DoShell_20_Script = function (origWeaponId, proj, teamId, pos, velocity, age, projectileId)
        CreateDeviation(10, proj, teamId, pos, velocity, age, projectileId)
        CreateDeviation(-10, proj, teamId, pos, velocity, age, projectileId)
    end}

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    if(GetNodeProjectileSaveName(projectileNodeId) == "shell12") then
        KeepSinTrajectory(projectileNodeId, teamId, 0)
    end
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
    local selectedIndex = GetRandomInteger(1, #Shells, "dice roll")	

    selectedIndex = 17

    local proj = Shells[selectedIndex]

    local projectileId = dlc2_CreateProjectile(proj.."_nocol", proj, teamId, pos, velocity, age)

    local effect = selectedIndex > 20 and 20 or selectedIndex
    SpawnEffect(path .. "/effects/roll_" .. effect .. ".lua", GetRollEffectPos(origWeaponId))

    local functionName = "DoShell_" .. selectedIndex .. "_Script"
    if ShellScripts[functionName] then
        ShellScripts[functionName](origWeaponId, proj, teamId, pos, velocity, age, projectileId)
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

function OnProjectileDestroyed(nodeId, teamId, saveName, structureIdHit, destroyType)
    local damagedTeamId = GetStructureTeam(structureIdHit)

    local name = GetNodeProjectileSaveName(nodeId)
    if name == "shell6" and destroyType == 2 then
        local velocity = NodeVelocity(nodeId)
        local pos = NodePosition(nodeId)
        local age = GetNodeProjectileTimeRemaining(nodeId)
        if teamId%100 == 1 then
            teamId = 2
        else
            teamId = 1
        end
        CreateDeviation(-180, name, teamId, pos, velocity, age, nodeId)
    elseif name == "shell17" and destroyType == 5 and teamId ~= damagedTeamId then
        DeleteBeforeDestroyMinigame(damagedTeamId)
    end
end

function OnLinkHit(nodeIdA, nodeIdB, objectId, objectTeamId, objectSaveName, damage, pos)
	--summon orbital artillery strike
	if objectSaveName == "unluckMarker" then
		CallUnluckStorm(pos, objectTeamId, GetProjectileClientId(objectId))
	end
end

function OnDeviceHit(teamId, deviceId, saveName, newHealth, projectileNodeId, projectileTeamId, pos)
	--summon orbital artillery strike
	if GetNodeProjectileSaveName(projectileNodeId) == "unluckMarker" then
		CallUnluckStorm(pos, projectileTeamId, GetProjectileClientId(projectileNodeId))
    end
end

function OnWeaponFiredEnd(teamId, saveName, weaponId)
	--remove artillery source weapon once done firing
	if saveName == "unluckMarker" then
		DestroyDeviceById(weaponId)
	end
end

function Load()
    if not data.AgeTriggers then data.AgeTriggers = {} end
    EnableWeapon("unluckStorm", false, 1)
	EnableWeapon("unluckStorm", false, 2)
    -- need to do cleanup 
end
---------------------------------------------------------------------------------------------------------
function Vec3MultiplyScalar(vec, scalar)
    return {x = vec.x * scalar, y = vec.y * scalar, z = vec.z * scalar}
end

function VelocityByDeviationAngle(deviationAngleDegree, velocity)
	local rad = math.pi / 180
	local sin_angle = math.sin(deviationAngleDegree * rad)
	local cos_angle = math.cos(deviationAngleDegree * rad)

	return Vec3(velocity.x * cos_angle - velocity.y * sin_angle, velocity.x * sin_angle + velocity.y * cos_angle)
end

function SetProjectileVelocity(nodeId, teamId, velocity)
    local projCurrentVelocity = NodeVelocity(nodeId)
    local projMass = GetProjectileParamInt(GetNodeProjectileSaveName(nodeId), teamId, "ProjectileMass", 1)
    dlc2_ApplyForce(nodeId, Vec3MultiplyScalar(velocity - projCurrentVelocity, projMass / data.updateDelta))
end

function GetRollEffectPos(origWeaponId)
    local pos = GetWeaponHardpointPosition(origWeaponId)
    local angle = GetFireAngle(origWeaponId)

    return Vec3(pos.x + RollEffectAngularDistance * math.sin(angle), pos.y + RollEffectAngularDistance * math.cos(angle))
end

function KeepSinTrajectory(id, teamId, timesrepeated)
    if not NodeExists(id) then return end
    timesrepeated = timesrepeated + 1
    local velocity = NodeVelocity(id)
	local amplitude
    local time = timesrepeated * DeltaTimeBetweenCalls * SinFrequencyModifier-- + SinPhaseShift
	
	if timesrepeated * DeltaTimeBetweenCalls < TimeToMaxSin then
		amplitude = timesrepeated * DeltaTimeBetweenCalls * SinAmplitudeModifier
	else
		amplitude = TimeToMaxSin * SinAmplitudeModifier
	end
	
	local deviationAngle = math.sin(time) * amplitude
	
    local newVelocity = VelocityByDeviationAngle(deviationAngle,velocity)
    SetProjectileVelocity(id, teamId, newVelocity)
    ScheduleCall(DeltaTimeBetweenCalls, KeepSinTrajectory, id, teamId, timesrepeated)
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
	local deviation = dlc2_CreateProjectile(proj.."_nocol", proj, teamId, pos, VelocityByDeviationAngle(degreeAngle, velocity), age)	

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

function DeleteBeforeDestroyMinigame(teamId)
    local devices = GetDeviceCountSide(teamId)
    local selectedIndex = GetRandomInteger(0, devices, "destroyed device")
    local DeviceToDestroy = GetDeviceIdSide(teamId, selectedIndex)
    if DeviceCanBeDestroyedById(DeviceToDestroy) then
        SpawnEffect(path .. "/effects/counter.lua", GetDeviceCentrePosition(DeviceToDestroy))
        ScheduleCall(15, ApplyDamageToDevice, DeviceToDestroy, 10000)	
    else
        DeleteBeforeDestroyMinigame(teamId) -- there is actually a small chance of endless loop in case of empty fort
    end
end

function CallUnluckStorm(markerPOS, team, clientId)
	--get position to place weapon
	local extents = GetWorldExtents()
	local devicePOS = Vec3(0,-12000,0)
	--if neither team 1 or team 2 then assign one closest to the projectile
	if team%100 ~= 1 and team%100 ~= 2 then
		if markerPOS["x"] > 0 then
			team = 2
		else
			team = 1
		end
	end
	--switch sides for teams.
	if team%100 == 1 then
		devicePOS = Vec3(extents["MinX"] + 200, extents["MinY"] - 2000, 0)
	elseif team%100 == 2 then
		devicePOS = Vec3(extents["MaxX"] - 200, extents["MinY"] - 2000, 0)
	end
	--place weapon and fire
	EnableWeapon("unluckStorm", true, 1)
    EnableWeapon("unluckStorm", true, 2)
	local deviceId = dlc2_CreateFloatingDevice(team, "unluckStorm", devicePOS, 0.0)
	SetWeaponClientId(deviceId, clientId)
	ScheduleCall(2.5, FireWeapon, deviceId, markerPOS, 0.0, FIREFLAG_NORMAL)
	
	EnableWeapon("unluckStorm", false, 1)
    EnableWeapon("unluckStorm", false, 2)
	--continue to event OnWeaponFiredEnd to delete device
end