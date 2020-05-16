# Digital Historical Data Toolkit

## Introduction

Build sql database to receive social data files extracted from Catalogues and indexes of large national archives.

A dataset was obtained from the archives of the Royal Anthropological Institute (RAI) in London, comprising social data of over 2000 persons regarded as involved in the early development of the institution of anthropolgy in Britain, before 1871. This dataset became the initial dataset for the Project

Repo clean_rai_data is private - the data is proprietary

Additional data was extracted from the microfilm records at the RAI archives of over 1000 subscribers and officers of the Aborigines Protection Society of London, from 1837.

Repo clean_aps_data is private - the data is proprietary

Additional data was extracted from the manuscript records of the Society of Friends (Quakers) in Britain, London, comprising 83 Quakers concerned with the origins of the institutionalisation of anthropology (ethnology) in Britain. 

repo clean_qlg_data is private - the data is proprietary

The repo clean_kbj_data is private - the csv files here combine the cleaned csv files from clean_aps_data and clean_qlg_data to bring all of my own research data to one place. 

## Authority Structure

The database records created from the initial dataset clean_rai_data form the initial authority index.

My own research at RAI and Society of Friends gathered data that provides updates to some of the initial data set records. Where the initial dataset records already contain a family_name and / or first_names, then the initial dataset record form the authority index. Name styles in clean_kbj_data are not taken up into the database if names are already present in the database.   

My own research clean_kbj_data also produced over 1000 new records, and when added to the initial dataset then the family_name and first_names in clean_kbj_clean are used to extend the authority index.

Later reasearh into family connections will produce more new records, and the authority index will then extend following the heirarchical strucure set out here. 

##  The Database

An sql database was designed and built using the DBeaver scripting engine to create the tables.

[Database ERDiagram] (https://github.com/KelvinBeerJones/ceda-database/blob/9fa090f2859aa41e90368458ab4fe8e95135ff9b/ERDiagram.png)


## Convert RAI to sql

DBeaver scripting tool was used to create the tables set out in the ERDiagram.

(convert_rai_to_sql/create_tables.sql)

1. xxx
1. xxx

## Query scripts

xxxxxx

## Contact info:

xxxxxx





