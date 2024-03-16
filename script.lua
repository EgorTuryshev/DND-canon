dofile("scripts/forts.lua")

local RPdebug = true

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
    LogDebug("exception mark3")
    if projectile ~= "invalid" then
        DestroyProjectile(projectileNodeId)
    end
end

function SpawnRandomProjectile(origProjectileId, origWeaponId, teamId, pos, velocity, age)
    local selectedShell = GetRandomIntegerLocal(1, 2)
    local proj = "machinegun"
    --if selectedShell == 2 then
    --    proj = "shell20"
    --end
  
    local origname = GetNodeProjectileSaveName(origProjectileId)
    local origgravity,projgravity,speedmultiplier,inverser = math.max(math.abs(GetProjectileTypeGravity(origname,teamId)),50),math.abs(GetProjectileTypeGravity(proj,teamId))

    if origgravity ~= projgravity and projgravity > 10 and GetProjectileParamString(proj,teamId,"ProjectileType","mortar") ~= PROJECTILE_TYPE_MISSILE then
        if origgravity > projgravity then
            inverser = origgravity/projgravity
            speedmultiplier = projgravity/origgravity
            local formula = 1/inverser^0.75
            LogDebug("vel, origgrav, projgrav, form, 1-form: " .. velocity.." "..origgravity.." "..projgravity.." "..(formula).." "..(1-formula))
            velocity = Vec3(velocity.x*((formula)+speedmultiplier*(1-formula)),velocity.y*((formula)+speedmultiplier*(1-formula)))
            LogDebug("velocity, speedmult: " .. velocity.." "..speedmultiplier)
        else
            inverser = projgravity/origgravity
            speedmultiplier = origgravity/projgravity
            local formula = 1/inverser^1.25
            LogDebug("vel, origgrav, projgrav, form, 1-form: " .. velocity.." "..origgravity.." "..projgravity.." "..(formula).." "..(1-formula))
            velocity = Vec3(velocity.x*((1-formula)+speedmultiplier/(formula)),velocity.y*((1-formula)+speedmultiplier/(formula)))
            LogDebug("velocity, speedmult: " .. velocity.." "..speedmultiplier)
        end
    end

    LogDebug("exception mark1")

    local projectileId = dlc2_CreateProjectile(proj, proj, teamId, pos, velocity, age)
    LogDebug("exception mark2")

    if origWeaponId > 0 then
        NoColProjectileEnd(projectileId,0)
    else
        SetNodeProjectileAgeTrigger(projectileId,0.1)
    end
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

function LogDebug(s) if RPdebug then Log(s) end end

function NoColProjectileEnd(id,timesrepeated)
    if not NodeExists(id) then return end
    timesrepeated = timesrepeated+1
    local pos,vel = NodePosition(id),NodeVelocity(id)
    local ray = CastRay(pos,pos+Vec3(vel.x/100,vel.y/100),0,0)
    if ray == RAY_HIT_DEVICE then ScheduleCall(0,NoColProjectileEnd,id,timesrepeated)
    else SetNodeProjectileAgeTrigger(id,0.04*timesrepeated) end
end

function Load()
    ProtectedFunction(Loadpcall)
end

function Loadpcall()

end
