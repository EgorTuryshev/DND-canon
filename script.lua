dofile("scripts/forts.lua")
dofile(path .. "/globals.lua")
dofile(path .. "/misc.lua")

Team1Pools = {}
Team2Pools = {}

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
    local playerNumber = GetPlayerNumber(teamId) -- DO NOT USE playerNumber ANYWHERE ELSE PLS!!!
    -- can be bad with ai maps tho
    if teamId%100 == 1 then
		roll = Team1Pools[playerNumber][1]
        ContinueBalancedPool(Team1Pools[playerNumber])
	elseif teamId%100 == 2 then
        if teamId == 2 then
            playerNumber = 1
        end
		roll = Team2Pools[playerNumber][1]
        ContinueBalancedPool(Team2Pools[playerNumber])
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
    local teamCount = GetTeamCount()
    -- Заполняем пулы команд в соответствии с их составами (втч асимметричные)
    for i = 1, teamCount do
        local teamId = GetTeamId(i)
        local side = teamId % 100

        if side == 1 then
            table.insert(Team1Pools, {})
        elseif side == 2 then
            table.insert(Team2Pools, {})
        end
    end

    for _ = 1, RngPoolLength do
        for _, value in ipairs(Team1Pools) do
            ContinueBalancedPool(value)
        end
        for _, value in ipairs(Team2Pools) do
            ContinueBalancedPool(value)
        end
    end

    -- Log(table.concat(Team1Pools[1], ", "))
    -- Log(table.concat(Team2Pools[1], ", "))

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