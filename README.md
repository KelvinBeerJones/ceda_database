# Historical Data Digital Toolkit and Database

#  #General Introduction

The Historical Data Digital Toolkit (HDDT) comprises a suite of open source technologies that work together efficiently without compromising the functionality of individual components. The Toolkit offers the digital historian the ability to link together the catalogue and index data from very large manuscript collections to interrogate, assimilate and visualise the rich social data (and especially social networks) implicit in the selectede manuscript collections. 

##  ##The HDDT components:

- SQLite database with tables compiled from data taken from a range of sources;
	- other databases
	- genealogical programmes
	- microfilm
	- archival research
	- excel

An entity relationship diagram can be viewed at [ERDiagram](https://github.com/KelvinBeerJones/ceda-database/blob/9fa090f2859aa41e90368458ab4fe8e95135ff9b/ERDiagram.png)

- VSC was used to build the HDDT database
- DBeaver was used to manage the data
- Jupyter Notebooks are used to interrogate the data using CSV data extracted from the HDDT database;
	- datashader
	- pandas
	- numpy
	- matplotlib
	- NetworkX (to generate input files for Gephi)
- Gephi is used to explore the integrated social networks that emerge from the final dataset, and especially time series analysis.  

##  ##The data used in development:

Data was kindly donated by the RAI archives (London)and the QFHS (London). Further data was obtained from my own research at RAI archives (London) and Friends House London Quaker Archives.

Data collected comprised of social data on circa 3000 persons known to have participated in the Centres for the Emergence of the Discipline of Anthropology in Britain:

-  Quaker Committee's that nurtured and developed the Aborigines Protection Society
-  The Aborigines Protection Society
-  The Ethnological Society of London
-  The Anthropological Society of London
-  The London Anthropological Society
-  The Anthropological Institute

## Authority Structure

The database records that were created from the initial dataset from the RAIform the Authority Index.

My own research at RAI and Society of Friends produced over 1000 new records, some of which potentially duplicated records in the initial (RAI) data set, but name variants were often used (e.g. John, Jack, J). Where the initial dataset records already contain a family_name and / or first_names, then the initial dataset record form the authority index.New data therefore had to be matched to a record in the Authority Index. This was a careful process informed by all of the known data on prospective match candidates. 

## sql database build scripts

[Script to build tables](convert_rai_to_sql/create_tables.sql)

1. The Person table is at the centre of the script.
1. Preceeding the person table in the script are the tables for the select lists that the Person table will need to make foreign keys when it is built: gender, address type and title
1. Following the Person table in the script are the social attributes tables, the many to many tables that link the attribute tables to the person table and the associated foreign key references. 

[Collect data from csv sheets](https://github.com/KelvinBeerJones/ceda-database/blob/master/convert_rai_to_sql/convert.py)

1. This script calls the csv sheet containing the data
1. The code loops through all supplied rows from CSV and builds a unique list of values in the specified data_list
1. The code then loops through each record and builds unique lists of data for each relevant column (e.g. locations, genders, etc)
1. The code builds SQL insert statements
1. It finally generates sql insert files (data extracted from the csv file by field for each record)

[Build database](https://github.com/KelvinBeerJones/ceda-database/blob/master/convert_rai_to_sql/insert_all.sh)

This code takes the insert files from convert.py and uses them to poulate the database

## Query scripts

Qurey Script logs comprise of sets of reusable queries. They can be run as is, with minor changes (such as where statement variables - <, >, =, etc), or copied and used to help write new queries. There are logs for single and joined table queries, family and date queries.

[Query templates](https://github.com/KelvinBeerJones/ceda-database/tree/master/CEDA_query_scripts)

end

## Contact info:

Kelvin Beer-Jones
PhD by Research
CAL, UoB
kgb650@student.bham.ac.uk





