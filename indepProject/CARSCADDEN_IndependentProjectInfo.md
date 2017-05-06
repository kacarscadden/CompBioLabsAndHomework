# Constructing phylogenetic trees and calculating interaction niche breadth estimates in R

Kelly Carscadden 2017

## Central question:
How do different estimates of species' interaction niche breadth (the number or diversity of 'resource' species with which they interact) compare? Does considering the phylogenetic diversity of the 'resource' species change how wide a focal species' NB is considered to be? 

## Context:
Niche breadth is some measure of the range or diversity of resources a species uses or conditions it tolerates. Niche breadth is involved in numerous aspects of species' ecology and evolution including community assembly, species' vulnerability, and diversification, and because niche breadth is invoked across a wide body of literature, there are numerous ways of measuring a species' niche breadth. It remains unknown how many of these measures compare (particularly the more complex ones, which I aim to tackle next).

## Methods:
### Niche breadth estimators
Existing niche breadth measures vary in several ways, and I focus on three simpler examples of metrics here: 

 1. Species Richness
 2. Simpson's Diversity
 3. Phylogenetic Diversity

Richness is the count of the number of 'resource' species with which a focal species interacts. Simpson's diversity considers also how evenly these resource species are used (therefore relying upon information about the frequency or intensity of interaction, rather than data on only the presence/absence of an interaction). Lastly, phylogenetic diversity incorporates information on how distinct the resource species are expected to be, based on their evolutionary history. That is, a focal species interacting with 5 resource species that are all closely related to each other would have a lower interaction niche breadth than a focal species interacting with 5 distantly related species.

In the future, I aim to expand my comparisons to a broader swath of niche breadth metrics, encompassing a greater diversity of the literature that draws upon the niche breadth concept.

### My approach
Comparing niche breadth estimators requires numerous types of data (particularly since I hope to expand the number of metrics compared, in the future). I began by finding a species interaction network dataset that recorded the frequency of interactions. From the list of resource species, I wrote an R script to search [GenBank](https://www.ncbi.nlm.nih.gov/nuccore) for sequence data, parse and align the sequences, and construct a phylogenetic tree for the resource species that had sequence data. 

After constructing the tree, I pared down the interaction network to eliminate any plant species I could not include in the tree (for lack of sequence data). I then calculated the phylogenetic diversity of resource species used by each focal species in the network. I compared this measure to calculated richness and Simpson's diversity using Spearman's rank correlation and visualized the relationship using scatterplots.

### About the data
#### Attribution for network data (described below), main text and data file (Supporting Information): 
[Vizentin-Bugoni, J., Maruyama, P. K., Debastiani, V. J., Duarte, L. D. S., Dalsgaard, B. & Sazima, M. (2016) Influences of sampling effort on detected patterns and structuring processes of a Neotropical plant–hummingbird network. _Journal of Animal Ecology_, __85__, 262-272.](http://onlinelibrary.wiley.com/doi/10.1111/1365-2656.12459/full)

#### Vizentin-Bugoni et al. 2016 aims and methods, in brief
Vizentin-Bugoni et al. (2016) examined how differences in sampling effort alter estimates of species' interaction network structure. They also assessed how species traits (morphological and phenological similarity) and abundances impact how frequently focal and resource species interact.

They recorded plant-hummingbird interactions along transects in the Brazilian Atlantic Rainforest (2716 hours of observation total, over 12000 m of trails, for several days a month from Sept 2011 to Aug 2013). A minimum of 3 of each hummingbird-associated focal plant was observed, where a hummingbird 'visit' was defined by birds touching plant stigma and anthers. Supplementary information was taken: native flowering species in the area, monthly presence or absence of open flowers of focal hummingbird-associated plant species and hummingbirds (phenological traits and abundances), corolla depth and bill length (morphological traits, where hummingbird measures were from museum collections).  

From the interaction frequencies, they created 50 bipartite plant-hummingbird interaction networks by taking hourly time slices of their data (e.g., the 1st network includes only observations made in the first sampling hour...the 50th includes all observations within 50 hours of observation) to represent a sampling effort gradient. For each network, they calculated a series of network structure metrics (e.g., connectance, specialization), compared the output to null model randomizations, and used sample-based rarefaction to ensure the order of observations was not driving results. They created probability matrices from morphological traits, phenology, and abundance (and combinations thereof) and employed likelihood and model selection to determine how these characteristics predict bipartite interaction frequencies. Again, they looked at whether this relationship changed with sampling effort.  

#### Details of the dataset
Format, type, size: csv sheets (62 kb total). NOTE, data is not provided by time slice, only in aggregate  

 1. network (number of interactions for 55 plant sp x 9 bird sp)  
 2. plant abundances (55 plant sp x 4 columns: sp name, acronym, number of flowers, relative abundances)  
 3. bird abundances (9 sp x 5 columns: sp name, acronym, contacts in transects, frequency of occurrence, relative frequency)  
 4. plant phenology (presence/absence data for 55 plant sp x 24 months)  
 5. bird phenology (presence/absence data for 9 bird sp x 24 months)  
 6. corolla depth (55 plant sp x 5 columns: sp acronym, min depth (cm), max depth (cm), sd(depth), number of samples)  
 7. bill length (9 bird sp x 6 columns:  sp acronym, mean bill length, sd(bill length), number of samples, tongue extension (cm), bill and tongue (cm))  
 
NOTE - my analyses rely upon 2 of these data sheets: the plant abundance data sheet (where complete plant names are provided) and the interaction network. In future analyses, I aim to incorporate the other data provided (traits, background availability of resource species) to compare other types of niche breadth measures. 

#### Anticipated challenges  
I anticipated parsing and subsetting would be major components of this assignment. Plant species names contain author names in different formats, sequence data is often provided with multiple gene sequences under the same accession number, and had to remove plant species from the interaction network if I could not find corresponding sequence data. I invested time learning how to web scrape and use existing functions to interact with GenBank's API that makes sequence data available. Sequence data is returned in lists, so much of the challenge was also learning how to deal with list format data. 


## Results and conclusions from my analyses

I constructed a phylogenetic tree of plant species from Vizentin-Bugoni et al. 2016 based on matK (a chloroplast gene). Ultimately 27 of 55 focal species (plus 2 outgroup species, for a total of 29 plant species) were included in the tree. The remainder lacked matK data. In future, I aim to incorporate other genes to add further species and make the relationships in the tree more robust. This is a simple tree that suffices for my purposes of assessing interaction breadth. Note, multiple trees are plotted in the provided script (pictured here is after polytomies have been resolved).

![Figure 1](https://github.com/kacarscadden/CompBioLabsAndHomework/blob/master/indepProject/plantMatKphylo_rooted_noEdgeLen.jpeg)

There was reasonable variation among the focal hummingbird species in their interaction breadth, regardless of the method used to estimate interaction breadth. The three measures (Species Richness, Simpson's Diversity, and Faith's Phylogenetic Diversity) yielded highly correlated estimates of interaction breadth (all Spearman's rho > 0.9, all p<0.05; Figs. 2-4). A caution: with 9 focal hummingbird species, the sample size is small (the points in the plots that follow represent the bird species). These results suggest these different measures of interaction niche breadth are redundant in the species studied and that phylogenetic diversity of the resources does not fundamentally change a focal species' niche breadth estimate. I believe other measures of niche breadth (e.g., those considering the background availability of resources) may be more distinct from the three investigated here, since they estimate niche breadth as a species' choosiness.

![Figure 2](https://github.com/kacarscadden/CompBioLabsAndHomework/blob/master/indepProject/PD_SR.jpeg)

![Figure 3](https://github.com/kacarscadden/CompBioLabsAndHomework/blob/master/indepProject/PD_Simpson.jpeg)

![Figure 4](https://github.com/kacarscadden/CompBioLabsAndHomework/blob/master/indepProject/SR_Simpson.jpeg)