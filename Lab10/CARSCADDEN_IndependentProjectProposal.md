### Assignment 10: Defining an independent project

#### Basic Information
Author: Kelly Carscadden
Date: Apr 16, 2017
Source file for lab: [on Sam Flaxman's Github](https://github.com/flaxmans/CompBio_on_git/blob/master/Assignments/10_independent_project_Step1.md)
Attribution for network data (described below), main text and data file (Supporting Information): [Vizentin-Bugoni, J., Maruyama, P. K., Debastiani, V. J., Duarte, L. D. S., Dalsgaard, B. & Sazima, M. (2016) Influences of sampling effort on detected patterns and structuring processes of a Neotropical plant–hummingbird network. _Journal of Animal Ecology_, __85__, 262-272.](http://onlinelibrary.wiley.com/doi/10.1111/1365-2656.12459/full)

#### Brief summary of Vizentin-Bugoni et al. 2016 

 1. Study goals
Vizentin-Bugoni et al. (2016) sought to determine how differences in sampling effort impact our understanding of species' (bipartite) interaction network structure. In addition, they evaluated how pairwise interaction frequency is influenced by species' traits (morphological and phenological similarity) and abundances. 

 2. Methodology used
	 2. Data collection
	 They recorded plant-hummingbird interactions along transects in the Brazilian Atlantic Rainforest (2716 hours of observation total, over 12000 m of trails, for several days a month from Sept 2011 to Aug 2013). A minimum of 3 of each hummingbird-associated focal plant was observed, where a hummingbird 'visit' was defined by birds touching plant stigma and anthers. Supplementary information was taken: native flowering species in the area, monthly presence or absence of open flowers of focal hummingbird-associated plant species and hummingbirds (phenological traits and abundances), corolla depth and bill length (morphological traits, where hummingbird measures were from museum collections). 
	 
	 3. Data analysis
	 From the interaction frequencies, they created 50 bipartite plant-hummingbird interaction networks by taking hourly time slices of their data (e.g., the 1st network includes only observations made in the first sampling hour...the 50th includes all observations within 50 hours of observation) to represent a sampling effort gradient. For each network, they calculated a series of network structure metrics (e.g., connectance, specialization), compared the output to null model randomizations, and used sample-based rarefaction to ensure the order of observations was not driving results.  
	 
	 They created probability matrices from morphological traits, phenology, and abundance (and combinations thereof) and employed likelihood and model selection to determine how these characteristics predict bipartite interaction frequencies. Again, they looked at whether this relationship changed with sampling effort.  

 3. Data description and anticipated challenges
	 4. Format, type, size: csv sheets (62 kb total). NOTE, data is not provided by time slice, only in aggregate
		 5. network (number of interactions for 55 plant sp x 9 bird sp)
		 6. plant abundances (55 plant sp x 4 columns: sp name, acronym, number of flowers, relative abundances)
		 7. bird abundances (9 sp x 5 columns: sp name, acronym, contacts in transects, frequency of occurrence, relative frequency)
		 8. plant phenology (presence/absence data for 55 plant sp x 24 months)
		 9. bird phenology (presence/absence data for 9 bird sp x 24 months)
		 10. corolla depth (55 plant sp x 5 columns: sp acronym, min depth (cm), max depth (cm), sd(depth), number of samples)
		 11. bill length (9 bird sp x 6 columns:  sp acronym, mean bill length, sd(bill length), number of samples, tongue extension (cm), bill and tongue (cm))
	 
	 2.  Anticipated challenges
		 1. Inherent in provided data
	 Phenology files have text above the header; column names include spaces, parentheses, plus signs;  month names are not linked to years in phenology data (so month labels are not unique); species names contain author names in different formats (so so parsing is not straightforward); some plant species names are not precise (e.g., to genus level or listed as 'cf' a similar species)  
		 2. Given my planned analyses (described below)
	Finding sequence data for plants not identified to species; finding an appropriate gene (e.g., MatK) for which data will be consistently available across all focal plant species.


#### Planned analyses (using available data for different aims than the original authors)  

##### Ecological motivation
The concept of niche breadth (the range of conditions a species tolerates) is at the core of much ecological theory and is relevant to numerous areas of inquiry, from community assembly to patterns of speciation to species' responses to environmental change. As a result, many vastly different ways of measuring niche breadth have been proposed, and it remains unclear how these metrics compare.

The ideal dataset for testing these metrics includes detailed information on species interactions, traits, and phylogenetic data, but such datasets are scarce.  

##### Coding challenge
I aim to construct a preliminary phylogeny based on the plant species list from Vizentin-Bugoni et al. 2016 and use this in conjunction with the published dataset to calculate hummingbird niche breadth based on the richness, variance, Simpson diversity, phylogenetic diversity, proportional similarity (plants visited compared to those available, using frequency data), resource relative range (plants visited compared to those available, using presence/absence of interaction), and trait width (based on frequency of interactions and functional differences between plant species) of the plant species they visit.

This involves:

 1. Parsing data - e.g., making plant species names match those in genbank (removing authors)
 2. Writing an R script to search genbank for accessions of my focal plant species, for a given gene (i.e., developing web-searching and scraping code skills)
 3. Constructing a basic phylogenetic tree of focal plant taxa (I have code for very preliminary alignments and trees and want to build on this to make it more robust or incorporate multiple genes)
 4. Writing code to measure niche breadth (which will require tallying plant species interacting with each hummingbird species, manipulating trait data, and calculating phylogenetic diversity for each focal hummingbird species).
 5. Visualizing the results - plotting the niche breadth estimate from each of the 7 metrics, for a focal hummingbird species (using ordination)

