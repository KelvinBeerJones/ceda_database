--Tables marriage and m2m_marriage_child are to be replaced by a many to many person to person table and a select list 
--which will contain 'relationships' which can be familial or any other type of person to person relationship.

-- First task - revise person to person relationships (including familial relationships)

--remove unwanted tables

DROP TABLE if exists marriage;

DROP TABLE if exists m2m_marriage_child;

--create the select list that the new table depends on

CREATE table if not exists sl_person_relationship_types(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
name varchar (255),
notes text);

insert into sl_person_relationship_types (id, name) 
values (1, "immediate_family"), (2, "extended_family"), (3, "remote_family"), (4, "other_relationship");

--create table for relationships between persons

CREATE table if not exists m2m_person_person(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
relationship_type_id integer,
person1_id integer,
person2_id integer,

foreign key (relationship_type_id) references sl_person_relationship_types (id),
foreign key (person1_id) references person (id),
foreign key (person2_id) references person (id));

--end of first task

--second task - Create new select list for data sources

CREATE table if not exists sl_person_data_source(
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
name varchar (255),
notes text);

insert into sl_person_data_source (id, name) 
values (1, "RAI"), (2, "QCA"), (3, "APS");



-- third task - create table for ceda, transfer data (dates) from esl, asl, ai, aps and las join_year and left_year to the new ceda table.
--Then delete old fields from person table. (there is a new field = "QCA")


CREATE table if not exists ceda (
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
name varchar (255),
notes text);

insert into ceda (id, name) 
values (1, "QCA"), (2, "APS"), (3, "ESL"), (4, "ASL"), (5, "LAS"), (6, "AI");

--create m2m relationship between person and ceda

CREATE table if not exists m2m_person_ceda (
id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
person_id INTEGER,
ceda_id INTEGER,
first_year INTEGER,
last_year INTEGER,
notes text, 

foreign key (person_id) references person (id),
foreign key (ceda_id) references ceda (id));

--select queries to copy all dates entries (except birth and death) in person records to the m2m table. 
--Output the following to csv and use csv scripts to populate the table

INSERT INTO m2m_person_ceda (person_id, ceda_id, first_year, last_year) 
SELECT id, 3, esl_join_year, esl_left_year
FROM person
WHERE esl_join_year IS NOT NULL AND esl_left_year IS NOT NULL;

INSERT INTO m2m_person_ceda (person_id, ceda_id, first_year, last_year) 
SELECT id, 4, asl_join_year, asl_left_year
FROM person
WHERE asl_join_year IS NOT NULL AND asl_left_year IS NOT NULL;

INSERT INTO m2m_person_ceda (person_id, ceda_id, first_year, last_year) 
SELECT id, 6, ai_join_year, ai_left_year
FROM person
WHERE ai_join_year IS NOT NULL AND ai_left_year IS NOT NULL;

INSERT INTO m2m_person_ceda (person_id, ceda_id, first_year, last_year) 
SELECT id, 2, aps_join_year, aps_left_year
FROM person
WHERE aps_join_year IS NOT NULL AND aps_left_year IS NOT NULL;

INSERT INTO m2m_person_ceda (person_id, ceda_id, first_year, last_year) 
SELECT id, 5, las_join_year, las_left_year
FROM person
WHERE las_join_year IS NOT NULL AND las_left_year IS NOT NULL;


-- original data cells had some blank cells, set these to NULL

UPDATE m2m_person_ceda SET first_year = NULL WHERE first_year = ' ';
UPDATE m2m_person_ceda SET last_year = NULL WHERE last_year = ' ';

--18 records have zero in last_year field. This should be NULL. E.g.:
--person_id	family_name	first_names	ceda_id	name	first_year	last_year
--1018	Husband	Frank J 3	ESL	1862	0
--437	Coke	James	3	ESL	1867	0
--741	French	Sydney	3	ESL	1868	0

UPDATE m2m_person_ceda SET first_year = NULL WHERE first_year = '0';
UPDATE m2m_person_ceda SET last_year = NULL WHERE last_year = '0';

--next issue. How to generate 'nodes' and 'edges' tables from the view? (NetworkX in Notebooks may be able to make from View, and Gephi may be able to discern these from a single GEFX file) 
--Test to determione best solution. 


-- when above data relocation has been verified drop these columns from the person_table


-- 1/6 - disable foreign key constraint check
PRAGMA foreign_keys=off;
-- 2/6 - Drop columns and add new data_source_id column
CREATE TABLE IF NOT EXISTS person_temp (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    family_name VARCHAR (255),
    first_names VARCHAR (255),
    title_id INTEGER,
    gender_id INTEGER,
    birth_year INTEGER,
    death_year INTEGER,
    data_source_id INTEGER,
    notes text,

    FOREIGN KEY (title_id) REFERENCES sl_title (id) ON DELETE SET NULL
    FOREIGN KEY (gender_id) REFERENCES sl_gender (id) ON DELETE SET NULL
    FOREIGN KEY (data_source_id) REFERENCES sl_person_data_source (id) ON DELETE SET NULL
);
-- 3/6 - copy data from the current table to the temp table
INSERT INTO person_temp(id, family_name, first_names, title_id, gender_id, birth_year, death_year, notes)
SELECT id, family_name, first_names, title_id, gender_id, birth_year, death_year, notes
FROM person;
-- 4/6 - drop the current table
DROP TABLE person;
-- 5/6 - rename the temp table to the original table name
ALTER TABLE person_temp RENAME TO person;
-- 6/6 - enable foreign key constraint check
PRAGMA foreign_keys=on;


-- Set all current records to "RAI" for the new data_source_id field
UPDATE person
SET data_source_id = 1;


--write a 'VIEW' that will dispaly a table of all ceda memberships. Then export the data to csv in a dhdt project folder. 
--(The csv can then be manuipuated in Python Notebooks. Use NetworkX in Notebooks to create a GEFX file for Gephi.)

CREATE VIEW IF NOT EXISTS vw_ceda_membership as 
SELECT m.person_id,p.family_name, p.first_names, m.ceda_id, c.name, m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id and m.first_year is not null and m.last_year is not null;


--end

