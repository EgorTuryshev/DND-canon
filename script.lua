dofile("scripts/forts.lua")
dofile(path .. "/globals.lua")
dofile(path .. "/misc.lua")

Team1Pool = {}
Team2Pool = {}

function OnWeaponFired(teamId, saveName, weaponId, projectileNodeId, projectileNodeIdFrom)
    if(IsProjectileSin(GetNodeProjectileSaveName(projectileNodeId))) then
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
    local roll
    if teamId%100 == 1 then
		roll = Team1Pool[1]
        Team1Pool = ContinueBalancedPool(Team1Pool)
	elseif teamId%100 == 2 then
		roll = Team2Pool[1]
        Team2Pool = ContinueBalancedPool(Team2Pool)
	end
    --roll = 20
    local variations = ProjectileVariations[roll]
    local selectedIndex = GetRandomInteger(1, #variations, "variation roll")
    local proj = variations[selectedIndex]
    --proj = "shellTriple"

    local projectileId = dlc2_CreateProjectile(proj.."_nocol", proj, teamId, pos, velocity, age)
    SpawnEffect(path .. "/effects/roll_" .. roll .. ".lua", GetRollEffectPos(origWeaponId))

    local functionName = "DoShell_" .. roll .. "_Script"
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
    local velocity = NodeVelocity(nodeId)
    local pos = NodePosition(nodeId)
    local name = GetNodeProjectileSaveName(nodeId)
    if IsShellNumberGreater(name,12) then
        --Log(tostring(teamId))
        dlc2_CreateProjectile("effectShellSmoke", "", teamId, pos, Vec3(0,0), 0)
    end

    if IsShellNumberGreater(name,15) then
        dlc2_CreateProjectile("effectShellMagnet", "", teamId,pos, Vec3(0,0), 0)
    end

    if (IsShellNumberBelowOrEqual(name,6)) and destroyType == 2 then
        
        local age = GetNodeProjectileTimeRemaining(nodeId)
        if teamId%100 == 1 then
            teamId = 2
        else
            teamId = 1
        end
        CreateDeviation(-180, name, teamId, pos, velocity, age, nodeId)
    --[[elseif name == "shell17" and destroyType == 5 and teamId ~= damagedTeamId then
        DeleteBeforeDestroyMinigame(damagedTeamId)--]]
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

function DeleteBeforeDestroyMinigame(teamId)  --Currently unused
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

function Load()
    if not data.AgeTriggers then data.AgeTriggers = {} end
    TP1 = {}
    TP2 = {}
    for _ = 1, 100 do
        Team1Pool = ContinueBalancedPool(Team1Pool)
        Team2Pool = ContinueBalancedPool(Team2Pool)
        table.insert(TP1, GetRandomInteger(1, 20, "dice_uniform_start"))
        table.insert(TP2, GetRandomInteger(1, 20, "dice_uniform_start"))
    end
    Log(table.concat(Team1Pool, ", "))
    Log(table.concat(Team2Pool, ", "))

    local sumTeam1 = 0
    local sumTeam2 = 0
    local sumTest1 = 0
    local sumTest2 = 0

    for i = 1, 100 do
        sumTeam1 = sumTeam1 + Team1Pool[i]
        sumTeam2 = sumTeam2 + Team2Pool[i]
        sumTest1 = sumTest1 + TP1[i]
        sumTest2 = sumTest2 + TP2[i]
    end

    Log(tostring(sumTeam1))
    Log(tostring(sumTeam2))

    Log(tostring(sumTest1))
    Log(tostring(sumTest2))

    EnableWeapon("unluckStorm", false, 1)
	EnableWeapon("unluckStorm", false, 2)
    if Projectiles then
        for i = #Projectiles, 1, -1 do
            local proj = Projectiles[i]
            if proj then
                DestroyProjectile(proj)
                table.remove(Projectiles, i)
            end
        end
    end

    for key in pairs(data.AgeTriggers) do
        data.AgeTriggers[key] = nil
    end
end