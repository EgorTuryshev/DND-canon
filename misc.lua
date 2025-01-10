-- Вспомогательная функция: получаем float в [0, 1)
-- за счёт деления случайного целого на 1,000,000
local function GetRandomFloat01(tag)
    return GetRandomFloat(0, 1, tag)
end

-- Генерация следующего псевдо-сбалансированного значения
-- с учётом "средней удачи" по пулу
function ContinueBalancedPool(currentPool)
    local fullRange = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20}
    
    -- Порог, до которого кидаем честно
    local FREE_ROLLS = 2  
    if #currentPool < FREE_ROLLS then
        table.insert(currentPool, GetRandomInteger(1, 20, "dice_uniform_start"))
        return currentPool
    end
    
    -- Считаем meanValue (скользящее среднее тоже можно)
    local sum = 0
    for i = 1, #currentPool do
        sum = sum + currentPool[i]
    end
    local meanValue = sum / #currentPool
    
    -- Настраиваем параметры "баланса"
    local k = 0.15       -- Сила коррекции
    local p = 0.01      -- Подмес "честного" рандома
    local base = 0.2   -- Минимальный уровень веса для снижения "гауссовского" распределения

    -- Считаем веса
    local weights = {}
    local totalWeight = 0
    for _, x in ipairs(fullRange) do
        local diff = math.abs(meanValue - x)
        local wBal = math.exp(-k * diff)
        local w = p*1 + (1-p)*(base + wBal)
        weights[x] = w
        totalWeight = totalWeight + w
    end

    -- Log("TW: " .. tostring(totalWeight))

    local rand = GetRandomFloat01("dice_weighted_select") * totalWeight
    -- Log("Rand: " .. tostring(rand))
    local cumulative = 0
    local newValue = 1
    for _, x in ipairs(fullRange) do
        cumulative = cumulative + weights[x]
        if rand <= cumulative then
            newValue = x
            break
        end
    end

    -- Собираем новый пул
    local newPool = {}
    if #currentPool >= 100 then
        for i = 2, #currentPool do
            table.insert(newPool, currentPool[i])
        end
    else
        for i = 1, #currentPool do
            table.insert(newPool, currentPool[i])
        end
    end
    table.insert(newPool, newValue)

    return newPool
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