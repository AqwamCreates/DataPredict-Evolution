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

local BaseGene = {}

BaseGene.__index = BaseGene

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

function BaseGene.new(parameterDictionary)

	parameterDictionary = parameterDictionary or {}
	
	local NewBaseGene = {}

	setmetatable(NewBaseGene, BaseGene)

	NewBaseGene.value = parameterDictionary.value or 0
	
	NewBaseGene.type = parameterDictionary.type or "Base"

	NewBaseGene.mutationChance = parameterDictionary.mutationChance or 0

	return NewBaseGene

end

function BaseGene:clone()

	return deepCopyValue(self)

end

function BaseGene:__tostring()
	
	return tostring(self.value)
	
end

function BaseGene:destroy()
	
	table.clear(self)
	
	setmetatable(self, nil)
	
	self = nil
	
end

return BaseGene
