# Rapport Afleidingskanaal van de Leie (AKL) vispasseerbaarheid

De sluisstuwcomplexen in Balgerhoeke en Schipdonk vormen een barrière voor paling, karperachtigen en andere vissoorten. Hier wordt onderzocht in welke mate deze barrières een effect hebben op aanwezige populaties, of vissen kunnen passeren en of voorzieningen voor passage zouden kunnen werken. 

## Folderstructuur

* code
	* functions
		* f.dispersie: determine data dispersion in 2D-plane
		* f.dominant.species: select dominant species and classify non-dominant species as "other"
		* f.map: overleaf plots
		* f.pairwise.adonis: pairwise permanova analysis
		* f.plot.habitat.spatial: kriging of habitats
		* f.read_excel_allsheets: read in excel files
		* f.run.chi.squared: run chi-squared tests
		* f.select.envfit: select environmental covariates in ordination
		* f.transformation: transform data
	* not_functions
 		* libraries: read in all the libraries and give an overview of the versions
   		* add.refs: add additional information related to the publication of the report
     	* download.from.zenedo: in case the folder data is missing download the necessary files from zenedo and store them automatically in the correct folder 
* data (data is stored on [Zenodo](https://doi.org/10.5281/zenodo.17017617))
	* abiotiek
		* extern
			* coordinaten: coordinaten_waterinfo: coordinates of measuring stations
			* metingen: all used environmental stations
	* vis
		* extern
			* ruw: dataset as provided by data-responsible
			* verwerkt_in_excel
				* data balgerhoeke 2023: corrections made to original data
				* maximale_vislengtes		
* media: pictures for report (media is stored on [Zenodo](https://doi.org/10.5281/zenodo.17017617))
* output: created pdf's
* gitignore
* _bookdown
* 000_abstract
* 01_inleiding
* 002_doelstelling
* 02_materiaal_en_methoden
* 03_resultaten
* 04_discussie
* cover
* index
* LICENSE
* rapport-akl-vispasseerbaarheid
* README
* references
* zzz_references_and_appendix

 
