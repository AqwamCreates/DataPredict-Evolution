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

local Cell = {}

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

function Cell.new(parameterDictionary)

	parameterDictionary = parameterDictionary or {}

	local self = setmetatable({}, Cell)

	local chromosomeArray = parameterDictionary.chromosomeArray or parameterDictionary[1] or {}
	
	local activationFunction = parameterDictionary.activationFunction or parameterDictionary[2] or function(...) return ... end
	
	local mutationChance = parameterDictionary.mutationChance or parameterDictionary[3] or 0

	return self

end

function Cell:mutate(forceMutateCell, forceMutateChromosome)
	
	if (not forceMutateCell) and (self.mutationChance <= mathRandom()) then return end
	
	for i, Gene in ipairs(self.chromosomeArray) do Gene:mutate(forceMutateChromosome) end
	
end

function Cell:activate()
	
	local valueArray = {}
	
	for i, Chromosome in ipairs(self.chromosomeArray) do valueArray[i] = Chromosome.value end
	
	return self.activationFunction(table.unpack(valueArray))
	
end

function Cell:clone()
	
	return deepCopyValue(self)
	
end

function Cell:exchange(OtherCell, exchangeRate) -- Trades genetics.
	
	
	
end

function Cell:conjugate(OtherCell) -- Transfers a copy of its own chromosome (like bacteria conjugation).
	
	
	
end

function Cell:donate(OtherCell) -- Donates a random chromosome to another cell.
	
	
	
end

function Cell:split() -- Splits the chromosome count into half for reproduction.
	
	
	
end
	
return Cell
