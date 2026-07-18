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

local BaseGene = require(script.Parent.BaseGene)

local mathRandom = math.random

local mathRound = math.round

local mathSqrt = math.sqrt

local mathLog = math.log

local mathCos = math.cos

local mathPi = math.pi

local safeMaximumValue = 4.5e15

local safeMinimumValue = -4.5e15

local IntegerGene = {}

IntegerGene.__index = IntegerGene

setmetatable(IntegerGene, BaseGene)

function IntegerGene.new(parameterDictionary)

	parameterDictionary = parameterDictionary or {}

	local value = parameterDictionary.value or 0
	
	local mutationProbability = parameterDictionary.mutationProbability or 0
	
	local maximumValue = parameterDictionary.maximumValue or safeMaximumValue
	
	local minimumValue = parameterDictionary.minimumValue or safeMinimumValue
	
	local mutationStepSize = parameterDictionary.mutationStepSize or 1
	
	local mutationMode = parameterDictionary.mutationMode or "Local"
	
	value = math.clamp(value, minimumValue, maximumValue)
	
	parameterDictionary.type = "Integer"
	
	local NewIntegerGene = BaseGene.new(parameterDictionary)

	setmetatable(NewIntegerGene, IntegerGene)
	
	NewIntegerGene.maximumValue = maximumValue
	
	NewIntegerGene.minimumValue = minimumValue
	
	NewIntegerGene.mutationStepSize = mutationStepSize
	
	NewIntegerGene.mutationMode = mutationMode

	return NewIntegerGene

end

function IntegerGene:mutate(forceMutate)
	
	if (not forceMutate) and (self.mutationProbability <= mathRandom()) then return end
	
	local mutationValue = self.value
	
	local maximumValue = self.maximumValue
	
	local minimumValue = self.minimumValue
	
	local mutationMode = self.mutationMode
	
	if (mutationMode == "Local") then
		
		local isMutatedForward = (mathRandom() < 0.5)
		
		local direction = (isMutatedForward and 1) or -1
		
		local noiseValue = direction * self.mutationStepSize
		
		mutationValue = mutationValue + noiseValue
		
	elseif (mutationMode == "Global") then
		
		local range = maximumValue - minimumValue
		
		mutationValue = minimumValue + (mathRandom() * range)
		
		mutationValue = mathRound(mutationValue)
		
	else
		
		error("Invalid mutation mode.")
		
	end
	
	mutationValue = math.clamp(mutationValue, minimumValue, maximumValue)

	self.value = mutationValue

end

return IntegerGene
