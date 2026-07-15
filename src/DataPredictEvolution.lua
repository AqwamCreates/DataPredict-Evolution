--[[

	--------------------------------------------------------------------

	Aqwam's Evolution Library (DataPredict Evolution)

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

local Genetic = script.Genetic

local Genes = Genetic.Genes

local Selectors = Genetic.Selectors

AqwamGeneticEvolutionLibrary.Genetic = {

	Genes = {

		ContinuousGene = require(Genes.ContinuousGene),

		DiscreteGene = require(Genes.DiscreteGene),

		LocalOrdinalGene = require(Genes.LocalOrdinalGene),

		GlobalOrdinalGene = require(Genes.GlobalOrdinalGene),

	},
	
	Selectors = {
		
		TournamentSelector = require(Selectors.TournamentSelector),
		
		RouletteWheel = require(Selectors.RouletteWheel),
		
	},
	
	Chromosome = require(Genetic.Chromosome),
	
	PetriDish = require(Genetic.PetriDish),

}

return AqwamGeneticEvolutionLibrary
