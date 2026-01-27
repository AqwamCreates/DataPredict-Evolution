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

local mathRandom = math.random

local OrdinalGene = {}

function OrdinalGene.new(parameterDictionary)

	parameterDictionary = parameterDictionary or {}

	local self = setmetatable({}, OrdinalGene)

	local value = parameterDictionary.value or parameterDictionary[1] or 0

	local mutationChance = parameterDictionary.mutationChance or parameterDictionary[2] or 0

	local mutationChoiceArray =  parameterDictionary.mutationChoiceArray or parameterDictionary[3] or {value}

	local numberOfMutationChoices = #mutationChoiceArray

	local mutationWeightArray = parameterDictionary.mutationWeightArray or parameterDictionary[4] or table.create(numberOfMutationChoices, 1)

	self.value = value

	self.mutationChance = mutationChance

	self.mutationChoiceArray = mutationChoiceArray

	self.mutationWeightArray = mutationWeightArray

	return self

end

function OrdinalGene:mutate(forceMutate)

	if (not forceMutate) and (self.mutationChance <= mathRandom()) then return end

	local mutationChoiceArray = self.mutationChoiceArray
	
	local mutationWeightArray = self.mutationWeightArray
	
	local arrayIndex = table.find(mutationChoiceArray, self.value)
	
	if (not arrayIndex) then
		
		self.value = mutationChoiceArray[mathRandom(#mutationChoiceArray)]
		
		return
		
	end
	
	local arrayIndexMinusOne = arrayIndex - 1
	
	local arrayIndexPlusOne = arrayIndex + 1
		
	local arrayIndexMinusOneMutationWeight = mutationWeightArray[arrayIndex - 1]
	
	local arrayIndexMutationWeight = mutationWeightArray[arrayIndex]
	
	local arrayIndexPlusOneMutationWeight = mutationWeightArray[arrayIndex + 1]
	
	local totalWeight = arrayIndexMinusOneMutationWeight + arrayIndexPlusOneMutationWeight + arrayIndexMutationWeight

	local randomPoint = mathRandom() * totalWeight

	local neighbourIndexArray = {}
	local neighbourWeightArray = {}

	if (arrayIndex > 1) then
		
		table.insert(neighbourIndexArray, arrayIndexMinusOne)
		
		table.insert(neighbourWeightArray, mutationWeightArray[arrayIndexMinusOne])
		
	end

	table.insert(neighbourIndexArray, arrayIndex)
	
	table.insert(neighbourWeightArray, mutationWeightArray[arrayIndex])

	if (arrayIndex < #mutationChoiceArray) then
		
		table.insert(neighbourIndexArray, arrayIndexPlusOne)
		
		table.insert(neighbourWeightArray, mutationWeightArray[arrayIndexPlusOne])
		
	end

	local totalWeight = 0
	
	for _, weight in ipairs(neighbourWeightArray) do totalWeight = totalWeight + weight end

	local randomPoint = mathRandom() * totalWeight
	
	local accumulatedWeight = 0

	for i, weight in ipairs(neighbourWeightArray) do
		
		accumulatedWeight = accumulatedWeight + weight
		
		if (randomPoint <= accumulatedWeight) then
			
			self.value = mutationChoiceArray[neighbourIndexArray[i]]
			
			break
			
		end
		
	end
	
end

return OrdinalGene
