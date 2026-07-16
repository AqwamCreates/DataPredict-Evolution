--[[

	--------------------------------------------------------------------

	Aqwam's Derivative-Free Optimization Library (DataPredict Zero)

	Author: Aqwam Harish Aiman
	
	Email: aqwam.harish.aiman@gmail.com
	
	YouTube: https://www.youtube.com/channel/UCUrwoxv5dufEmbGsxyEUPZw
	
	LinkedIn: https://www.linkedin.com/in/aqwam-harish-aiman/
	
	--------------------------------------------------------------------
		
	By using this library, you agree to comply with our Terms and Conditions in the link below:
	
	https://github.com/AqwamCreates/DataPredict-Zero/blob/main/docs/TermsAndConditions.md
	
	--------------------------------------------------------------------
	
	DO NOT REMOVE THIS TEXT!
	
	--------------------------------------------------------------------

--]]

local mathRandom = math.random

local mathHuge = math.huge

local tableClone = table.clone

local Particle = {}

Particle.__index = Particle

local function deepCopyValue(original, copies)

	copies = copies or {}

	local originalType = type(original)

	local copy

	if (originalType == 'table') then

		if copies[original] then

			copy = copies[original]

		else

			copy = {}

			copies[original] = copy

			for originalKey, originalValue in next, original, nil do

				copy[deepCopyValue(originalKey, copies)] = deepCopyValue(originalValue, copies)

			end

			setmetatable(copy, deepCopyValue(getmetatable(original), copies))

		end

	else

		copy = original

	end

	return copy

end

function Particle.new(parameterDictionary)

	parameterDictionary = parameterDictionary or {}
	
	local dimensionSize = parameterDictionary.dimensionSize or 1
	
	local positionArray = tableClone(parameterDictionary.positionArray) or {}
	
	local velocityArray = tableClone(parameterDictionary.velocityArray) or {}
	
	local bestPositionArray = tableClone(parameterDictionary.bestPositionArray) or {}
	
	local bestScore = parameterDictionary.bestScore or -mathHuge
	
	local NewParticle = {}

	setmetatable(NewParticle, Particle)
	
	for i = 1, dimensionSize, 1 do
		
		local position = positionArray[i] or mathRandom()
		
		local velocity = velocityArray[i] or 0
		
		positionArray[i] = position
		
		velocityArray[i] = velocity
		
		bestPositionArray[i] = position
		
	end
	
	NewParticle.dimensionSize = dimensionSize

	NewParticle.positionArray = positionArray
	
	NewParticle.velocityArray = velocityArray
	
	NewParticle.bestPositionArray = bestPositionArray
	
	NewParticle.bestScore = bestScore

	return NewParticle

end

function Particle:updateVelocity(inertiaArray, cognitiveArray, socialArray)
	
	local dimensionSize = self.dimensionSize
	
	local velocityArray = self.velocityArray
	
	if (type(inertiaArray) ~= "table") then inertiaArray = table.create(dimensionSize, inertiaArray) end

	if (type(cognitiveArray) ~= "table") then cognitiveArray = table.create(dimensionSize, cognitiveArray) end
	
	if (type(socialArray) ~= "table") then socialArray = table.create(dimensionSize, socialArray) end
	
	for i = 1, dimensionSize, 1 do
		
		local inertia = inertiaArray[i] or 0
		
		local cognitive = cognitiveArray[i] or 0
		
		local social = socialArray[i] or 0
		
		local newVelocity = inertia + cognitive + social
		
		velocityArray[i] = newVelocity
		
	end
	
end

function Particle:move(minimumBoundArray, maximumBoundArray) -- The change in position of the particle is based on the space they have, hence the bound arrays should not be kept as internal particle properties.
	
	local dimensionSize = self.dimensionSize
	
	local positionArray = self.positionArray
	
	local velocityArray = self.velocityArray
	
	if (not minimumBoundArray) then minimumBoundArray = -mathHuge end
	
	if (not maximumBoundArray) then maximumBoundArray = mathHuge end
	
	if (type(minimumBoundArray) ~= "table") then minimumBoundArray = table.create(dimensionSize, minimumBoundArray) end
	
	if (type(maximumBoundArray) ~= "table") then maximumBoundArray = table.create(dimensionSize, maximumBoundArray) end
	
	for dimensionIndex = 1, dimensionSize, 1 do
		
		local position = positionArray[dimensionIndex]
		
		local velocity = velocityArray[dimensionIndex]
		
		local minimumBound = minimumBoundArray[dimensionIndex] or -mathHuge
		
		local maximumBound = maximumBoundArray[dimensionIndex] or mathHuge
		
		local newPosition = position + velocity
		
		newPosition = math.clamp(newPosition, minimumBound, maximumBound)
		
		positionArray[dimensionIndex] = newPosition
		
	end
	
end

function Particle:record(score)
	
	if (score < self.bestScore) then return false end
	
	self.bestPositionArray = tableClone(self.positionArray)
	
	self.bestScore = score
	
	return true
	
end

function Particle:clone()

	return deepCopyValue(self)

end

function Particle:__tostring()
	
	local numberOfPositions = #self.positionArray
	
	local text = "{"
	
	for positionIndex, positionValue in ipairs(self.positionArray) do
		
		text = text .. positionValue
		
		if (positionIndex < numberOfPositions) then text = text .. ", " end
		
	end
	
	return text .. "}"
	
end

function Particle:destroy()
	
	table.clear(self)
	
	setmetatable(self, nil)
	
	self = nil
	
end

return Particle
