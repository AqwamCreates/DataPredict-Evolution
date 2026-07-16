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

local AqwamEvolutionLibrary = {}

local Genetic = script.Genetic

local Genes = Genetic.Genes

local Selectors = Genetic.Selectors

AqwamEvolutionLibrary.Genetic = {

	Genes = {

		ContinuousGene = require(Genes.ContinuousGene),
		
		IntegerGene = require(Genes.IntegerGene),

		DiscreteGene = require(Genes.DiscreteGene),

	},
	
	Selectors = {
		
		RandomSelector = require(Selectors.RandomSelector),
		
		TournamentSelector = require(Selectors.TournamentSelector),
		
		RankSelector = require(Selectors.RankSelector),
		
		RouletteWheelSelector = require(Selectors.RouletteWheelSelector),
		
	},
	
	Chromosome = require(Genetic.Chromosome),
	
	PetriDish = require(Genetic.PetriDish),

}

return AqwamEvolutionLibrary
