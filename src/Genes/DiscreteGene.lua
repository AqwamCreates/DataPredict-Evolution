--[[

	--------------------------------------------------------------------

	Aqwam's Genetic Evolution Library (DataPredict Genetics)

	Author: Aqwam Harish Aiman
	
	Email: aqwam.harish.aiman@gmail.com
	
	YouTube: https://www.youtube.com/channel/UCUrwoxv5dufEmbGsxyEUPZw
	
	LinkedIn: https://www.linkedin.com/in/aqwam-harish-aiman/
	
	--------------------------------------------------------------------
		
	By using this library, you agree to comply with our Terms and Conditions in the link below:
	
	https://github.com/AqwamCreates/DataPredict-Genetics/blob/main/docs/TermsAndConditions.md
	
	--------------------------------------------------------------------
	
	DO NOT REMOVE THIS TEXT!
	
	--------------------------------------------------------------------

--]]

local BaseGene = require(script.Parent.BaseGene)

local mathRandom = math.random

local DiscreteGene = {}

DiscreteGene.__index = DiscreteGene

setmetatable(DiscreteGene, BaseGene)

function DiscreteGene.new(parameterDictionary)

	parameterDictionary = parameterDictionary or {}

	local value = parameterDictionary.value or 0
	
	local mutationChance = parameterDictionary.mutationChance or 0

	local mutationChoiceArray =  parameterDictionary.mutationChoiceArray or {value}
	
	local numberOfMutationChoices = #mutationChoiceArray
	
	local mutationWeightArray = parameterDictionary.mutationWeightArray or table.create(numberOfMutationChoices, 1)
	
	parameterDictionary.type = "Discrete"

	local NewDiscreteGene = BaseGene.new(parameterDictionary)

	setmetatable(NewDiscreteGene, DiscreteGene)

	NewDiscreteGene.mutationChoiceArray = mutationChoiceArray

	NewDiscreteGene.mutationWeightArray = mutationWeightArray

	return NewDiscreteGene

end

function DiscreteGene:mutate(forceMutate)

	if (not forceMutate) and (self.mutationChance <= mathRandom()) then return end

	local mutationChoiceArray = self.mutationChoiceArray
	
	local mutationWeightArray = self.mutationWeightArray

	local totalWeight = 0

	for _, weight in ipairs(mutationWeightArray) do totalWeight = totalWeight + weight end

	local randomPoint = mathRandom() * totalWeight

	local accumulatedWeight = 0

	for i, weight in ipairs(mutationWeightArray) do

		accumulatedWeight = accumulatedWeight + weight

		if (randomPoint <= accumulatedWeight) then

			self.value = mutationChoiceArray[i]

			break

		end

	end

end

return DiscreteGene
