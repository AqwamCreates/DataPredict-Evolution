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

local AqwamGeneticEvolutionLibrary = {}

local Genes = script.Genes

AqwamGeneticEvolutionLibrary.Genes = {
	
	ContinuousGene = require(Genes.ContinuousGene),
	
	DiscreteGene = require(Genes.DiscreteGene),
	
	LocalOrdinalGene = require(Genes.LocalOrdinalGene),
	
	GlobalOrdinalGene = require(Genes.GlobalOrdinalGene),
	
}

return AqwamGeneticEvolutionLibrary
