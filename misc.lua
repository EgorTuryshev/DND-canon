-- ГСЧ? Где!?
function ContinueBalancedPool(currentPool)
    table.insert(currentPool, GetRandomInteger(1, 20, "dice_roll"))
    if #currentPool >= RngPoolLength then
        table.remove(currentPool, 1)
    end
end

function GetPlayerNumber(teamId)
    return (teamId < 100) and teamId or math.floor(teamId / 100)
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

function IsProjectileSin(shellName)
    local shellNumber = tonumber(string.match(shellName, "^shell(%d+)$"))
    if not shellNumber then return false end

    for _, config in ipairs(ProjectileConfigs) do
        -- Проверяем, входит ли номер в диапазон и имеет ли isSin = true
        if shellNumber >= config.range[1] and shellNumber <= config.range[2] and config.isSin == true then
            return true
        end
    end

    return false
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

function Vec3MultiplyScalar(vec, scalar)
    return {x = vec.x * scalar, y = vec.y * scalar, z = vec.z * scalar}
end

function VelocityByDeviationAngle(deviationAngleDegree, velocity)
	local rad = math.pi / 180
	local sin_angle = math.sin(deviationAngleDegree * rad)
	local cos_angle = math.cos(deviationAngleDegree * rad)

	return Vec3(velocity.x * cos_angle - velocity.y * sin_angle, velocity.x * sin_angle + velocity.y * cos_angle)
end

function IsShellNumberBelowOrEqual(name, number)

    for i = 1,number do
        if name == "shell" .. i then
            return true
        end
    end
    return false
end

function IsShellNumberGreater(name, number)
    for i = number+1, 20 do
        if name == "shell" .. i then
            return true
        end
    end
    return false
end

function SetProjectileVelocity(nodeId, teamId, velocity)
    local projCurrentVelocity = NodeVelocity(nodeId)
    local projMass = GetProjectileParamInt(GetNodeProjectileSaveName(nodeId), teamId, "ProjectileMass", 1)
    dlc2_ApplyForce(nodeId, Vec3MultiplyScalar(velocity - projCurrentVelocity, projMass / data.updateDelta))
end