-- TITLE - HDDT numeric view sets (all views begin with a numeric e.g vw_1_club)
-- For non numeric titled views see <CEDA_Dev.db> HDDT NULL_and_tuples_view_scripts

--There are 5 sets of views:

-- Set VIEW 1 (vw_1_) lists the full data record for persons and also the persons related to each of: club - location - occupation - religion - society. 
-- The person views show Names as separate fields (First, last) and also joined (first last in one field. 
-- A person table view also shows Quakers marked and another shows Quakers extracted .

-- There are 3094 persons including 592 quakers.

SELECT COUNT(*) FROM vw_1_person_table; 
--answer = 3094 - The complete person_table
SELECT COUNT(*) FROM vw_1_person_names; 
--answer = 3094 - The complete person_table with names joined in a single field
SELECT COUNT(*) FROM vw_1_person_with_quakers; 
--answer = 3094 - The complete person_table with religion joined (marks table with Quakers)
SELECT COUNT (*) FROM vw_1_quakers;
--answer = 592 - The complete person_table with religion but only showing Quakers
SELECT COUNT (*) FROM vw_1_religion;
--answer = 592 - The complete religion_table
SELECT COUNT (*) FROM vw_1_club;
--answer = 323 - The complete club_table
SELECT COUNT (*) FROM vw_1_location;
--answer = 2061 - The complete location_table
SELECT COUNT (*) FROM vw_1_occupation;
--answer = 1883 - The complete occupation_table
SELECT COUNT (*) FROM vw_1_society;
--answer = 1238 The complete society_table


-- Set VIEW 2 (vw_2_) This set shows all memberships of all entities by all persons (9989).


SELECT COUNT(*) FROM vw_2_person_person_relationships;
--answer = 2076
SELECT COUNT(*) FROM vw_2_religion_membership;
--answer = 592
SELECT COUNT(*) FROM vw_2_society_membership;
--answer = 1238
SELECT COUNT(*) FROM vw_2_club_membership;
--answer = 323
SELECT COUNT(*) FROM vw_2_location_membership;
--answer = 2061
SELECT COUNT(*) FROM vw_2_occupation_membership;
--answer = 1883
SELECT COUNT(*) FROM vw_2_ceda_membership;
--answer = 3892
SELECT COUNT(*) FROM vw_2_all_bipartite_memberships;
--answer = 9989
SELECT COUNT(*) FROM vw_2_all_bipartite_memberships_xceda;
--answer = 6097


-- Set VIEW 3 (vw_3_) This set produces two 'attribute' views where vw_3_all_names_attributes is a SOURCE file for SNA 
-- and vw_3_all_bipartite_attributes is a TARGET file for SNA. Both of these files depend on the two 'bipartite' views to compile.
-- The vw all_names shows the SOURCE (or person) data c/w id. 

SELECT COUNT(*) FROM vw_3_bipartite_names;
--answer = 3094
SELECT COUNT(*) FROM vw_3_bipartite_nodes; 
--answer = 514
SELECT COUNT (*) FROM vw_3_all_names;
--answer = 3608
SELECT COUNT (*) FROM vw_3_all_names_attributes;
--answer = 3608
SELECT COUNT (*) FROM vw_3_all_bipartite_attributes;
--answer = 9989


-- Set VIEW 4 (vw_4_) Shows only CEDA memberships, and an extract of the Quakers only.

SELECT COUNT(*) FROM vw_4_ceda_membership_dates;
--answer = 3892
 SELECT COUNT (*) From  vw_4_ceda_membership_quakers; 
--answer = 643


-- Set VIEW 4 (vw_4_) shows the person to person relationships.

SELECT COUNT (*) From  vw_5_person1;
--answer = 2080
SELECT COUNT (*) From  vw_5_person2;
--answer = 2089
SELECT COUNT (*) From  vw_5_person1_person2;
--answer = 2080



-- GLOSSARY

-- CEDA are the 5 societies identified by the RAI as founding societies for the formation of the discipline of anthropology in Britain 
--   (I add to this number the QCA to make a total of 6 studied in this project and the RAI have not collected data for the LAS). 
--   3892 CEDA memberships have been identified amongst the expanded CEDA (Some persons are members of more than one CEDA)  

-- CHECK THIS BREAKDOWN!
--   1. QCA - Quaker Committee on the Aborigines, (Formed 1830) 31 members.
--   2. APS - Aborigines Protection Society, 1171 members.
--   3. ESL - Ethnological Society of London, 748 members.
--   4. ASL - Anthropological Society of London, 1334 members.
--   5. LAS - London Anthropological Society,0 members included in this project.
--   6. AI - Anthropological Institute, 610 members.
--   All of the above were replaced by the Royal Anthropological Institute (London) 1871. 
--   (A section of the APS survived in part until it was absorbed into the Anti Slavery League 1909)

-- TIME STAMP All ceda memberships have been carefully timestamped to reflect first and last year observed as present 
--   in the archive materials related to the ceda's. 
--   a date cut off at not before 1830 and not after 1870 is applied.  

-- PERSONS are those indiviuals who make up all of the persons identified in the archive materials related to the CEDA. 
--   There are 3094 persons within this project and all are members of at least one CEDA.

-- QUAKERS 592 have ben identified amogst the cohort of 3094 persons.  
--   They hold 643 ceda memberships between them. There are 2080 person to person relationships amongst them.
--   Of these 249 are immediate, 524 are close and 1332 are remote.

-- GROUPS are bipartite social groups that some persons are members of or have been associated with. (see relevant tables) 
--   the groups are: 

--   address (0) Not used in this project
--   ceda (6)
--   club (68)
--   location (83)
--   occupation (93)
--   suffix (155) Not used in this project
--   religion (4) 1 = Quaker
--   society (260)
--   All Groups (in this project) = 514 (see vw_3)

-- NAMES are the persons and/or groups in graph data applications (Gephi). There are 3609 Names in the project (3095 persons and 514 groups).

-- TUPLES A pairing of two Names (labelled Source and Target). Commonly 'Source' = person and 'Target' = group'.
--   For example Source = 'John Doe' and target = 'London'. 

-- BIPARTITE RELATIONSHIPS - (TUPLES) where 'Source' = person name and 'Target' = group'. 
--   e.g. persons A,B and C are all 'doctors' (a group) but it is not assumed that there is any other relation ship between them (see relevant m2m tables)
--   The project accepts and analyses bipartite relationships:
--   m2m_person_address (0) Not used in this project
--   m2m_person_ceda (3894) (see vw_9)
--   m2m_person_club (323) (see vw_6)
--   m2m_person_location (2061) (see vw_7)
--   m2m_person_occupation (1883) (see vw_8)
--   m2m_person_religion (593) (see vw_4)
--   m2m_person_society (1238) (see vw_5)
--   m2m_person_suffix (1351) Not used in this project
--   All persons in bipartite relationships = 16090.  

-- BIPARTITE GRAPH (Bigraph) Data formatted to enable NetworkX (Jupyter Notebooks) to generate a GexF file for Gephi. 
--  In this project all graph data is BIPARTITE except for social network data.

-- SOCIAL NETWORK RELATIONSHIPS In this project this refers to family networks. These are studied for 593 Quakers only. 
--   There are 2099 m2m_person_person tuples.

--- SOCIAL NETWORK GRAPH (SNG) Data formatted to enable NetworkX (Jupyter Notebooks) to generate a GexF file for Gephi.
--   Shows the social connectivity between persons. (person to person relationships).
--   In this project this is only evident in the m2m_person_person table 
--   where family realtionships are marked as (1 - remote, 2 - extended and 3 - immediate).   

-- m2m_TABLE These tables show the bipartite relationships of PERSONS to GROUPS and also the social network relationships of PERSONS to PERSONS. 
--   The m2m_person_person table is the only m2m table that will not generate multiple records for any individual person 
--   because all relationships here are one to one. For all other m2m tables each person can have many to many relationships 
--   (e.g., a person can be a member of more than one club). 

-- ATTRIBUTES (e.g, Date of Birth) Can be added to a series of either NAMES or TUPLES, but only where the attribute is singlar. (Seee m2m_TABLE below).
--   (otherwise a view would return multiples records for one person e.g., 3 separate person records for a person who is a member of 3 clubs)
 
-- STATIC DATA All data that is not time stamped (birth and death years are not treated as time stamped in this project). 
--   This data will show (for example) that a person was a member of a society but granular data on dates of joining or leaving that society
--   have not been collected.

-- DYNAMIC DATA All CEDA memberships have time stamps as ATTRIBUTES and therefore all CEDA memberships can be viewed in a DYNAMIC BIPARTITE GRAPH
--   (Gephi functionality can be used to visualise the time period DYNAMIC DATA 1830 to 1870 in yearly incidences).
--   Note - Some person_table records contain birth and death year dates, but this data type is only captured for half of the persons. 
--   (The birth and death data is however useful when verifying a person records veracity.)

-- All data can then be sliced into 40 individual years (1830 - 1870 ) using TIME STAMP, giving a total dataset of 483880 datatpoints (9992 x 40). 
--   there are 3894 memberships of ceda's and 6098 memberships of all other groups (not suffix), making a total of 9992 bipartite relationships (see vw_10)
--   (inc,. 2099 social network relationships. 





--------------------------------------------------------------------------------------------------------------------------------------------

-- Notes:

--To substitute for NULL in a field use: select id, family_name, IFNULL(title, 'xxx') from person p


--------------------------------------------------------------------------------------------------------------------------------------------
DROP VIEW [vw_1_person_table];

CREATE VIEW [vw_1_person_table]
AS
SELECT id, first_names, family_name, 
IFNULL(title,'NA') AS title, IFNULL(gender_id,'NA') AS gender_id, IFNULL(birth_year,'NA') AS birth_year, IFNULL(death_year,'NA') AS death_year, data_source_id, notes
FROM person;

SELECT COUNT(*) FROM vw_1_person_table; 


DROP VIEW [vw_1_person_names];

CREATE VIEW [vw_1_person_names]
AS
SELECT id, (first_names || " " || family_name) AS Name, 
IFNULL(title,'NA') AS title, IFNULL(gender_id,'NA') AS gender_id, IFNULL(birth_year,'NA') AS birth_year, IFNULL(death_year,'NA') AS death_year, data_source_id, notes
FROM person;

SELECT COUNT(*) FROM vw_1_person_names; 



DROP VIEW [vw_1_person_with_quakers];

CREATE VIEW [vw_1_person_with_quakers]
AS
SELECT person.id, (person.first_names || " " || person.family_name) AS Name, person.gender_id, IFNULL(person.birth_year, 'NA') AS birth_year, IFNULL(person.death_year, 'NA') AS death_year, person.data_source_id,
	IFNULL(m2m_person_religion.religion_id, 'NA') AS religion_id
FROM person
LEFT JOIN m2m_person_religion
ON person.id = m2m_person_religion.person_id;

SELECT COUNT(*) FROM vw_1_person_with_quakers; 


DROP VIEW vw_1_quakers;

CREATE VIEW vw_1_quakers
AS
SELECT *
FROM vw_1_person_with_quakers
WHERE religion_id = 1; 

SELECT COUNT (*) FROM vw_1_quakers;




DROP VIEW [vw_1_religion];

CREATE VIEW [vw_1_religion] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   religion.id,
	   religion.name as 'religion',
	   m2m_person_religion.confirmed,
	   m2m_person_religion.notes AS 'notes'
	   -- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, religion, m2m_person_religion
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_religion.person_id 
		AND religion.id = m2m_person_religion.religion_id;
	
	SELECT COUNT (*) FROM vw_1_religion;

-- check, should this be 593?



DROP VIEW [vw_1_club]; 

CREATE VIEW [vw_1_club] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   club.id,
	   club.name as 'club'
FROM person, club, m2m_person_club
WHERE person.id = m2m_person_club.person_id 
		AND club.id = m2m_person_club.club_id;
	
SELECT COUNT (*) FROM vw_1_club;



DROP VIEW [vw_1_location]; 

CREATE VIEW [vw_1_location] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   location.id,
	   location.name as 'location'
FROM person, location, m2m_person_location
WHERE person.id = m2m_person_location.person_id 
		AND location.id = m2m_person_location.location_id;
	
SELECT COUNT (*) FROM vw_1_location;



DROP VIEW [vw_1_occupation]; 

CREATE VIEW [vw_1_occupation] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   occupation.id,
	   occupation.name as 'occupation'
FROM person, occupation, m2m_person_occupation
WHERE person.id = m2m_person_occupation.person_id 
		AND occupation.id = m2m_person_occupation.occupation_id;
	
SELECT COUNT (*) FROM vw_1_occupation;


DROP VIEW [vw_1_society]; 

CREATE VIEW [vw_1_society] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   society.id,
	   society.name as 'society'
FROM person, society, m2m_person_society
WHERE person.id = m2m_person_society.person_id 
		AND society.id = m2m_person_society.society_id;
	
SELECT COUNT (*) FROM vw_1_society;

---------------------------------------------------------------------------------------------------------------------------------------

DROP VIEW vw_2_person_person_relationships; 

CREATE VIEW vw_2_person_person_relationships as 
SELECT vw_5_person1.id, vw_5_person1.person1_id, vw_5_person1.person1_name, vw_5_person2.person2_id, vw_5_person2.person2_name 
FROM vw_5_person1
	JOIN vw_5_person2
WHERE vw_5_person1.id = vw_5_person2.id; 

SELECT COUNT(*) FROM vw_2_person_person_relationships;

-- This needs vw_5 first


DROP VIEW vw_2_religion_membership; 

CREATE VIEW vw_2_religion_membership as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, r.name AS Target  
FROM m2m_person_religion m, person p, religion r 
WHERE m.person_id = p.id AND m.religion_id = r.id; 

SELECT COUNT(*) FROM vw_2_religion_membership;



DROP VIEW vw_2_society_membership; 

CREATE VIEW vw_2_society_membership as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, s.name AS Target  
FROM m2m_person_society m, person p, society s 
WHERE m.person_id = p.id AND m.society_id = s.id;

SELECT COUNT(*) FROM vw_2_society_membership;



DROP VIEW vw_2_club_membership; 

CREATE VIEW vw_2_club_membership as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, c.name AS Target  
FROM m2m_person_club m, person p, club c 
WHERE m.person_id = p.id AND m.club_id = c.id;

SELECT COUNT(*) FROM vw_2_club_membership;



DROP VIEW vw_2_location_membership; 

CREATE VIEW IF NOT EXISTS vw_2_location_membership as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, l.name AS Target  
FROM m2m_person_location m, person p, location l 
WHERE m.person_id = p.id AND m.location_id = l.id;

SELECT COUNT(*) FROM vw_2_location_membership;



DROP VIEW vw_2_occupation_membership; 

CREATE VIEW IF NOT EXISTS vw_2_occupation_membership as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, o.name AS Target  
FROM m2m_person_occupation m, person p, occupation o 
WHERE m.person_id = p.id AND m.occupation_id = o.id;

SELECT COUNT(*) FROM vw_2_occupation_membership;



DROP VIEW vw_2_ceda_membership; 

CREATE VIEW IF NOT EXISTS vw_2_ceda_membership as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, c.name AS Target 
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id; 

SELECT COUNT(*) FROM vw_2_ceda_membership;



DROP VIEW vw_2_all_bipartite_memberships;

CREATE VIEW vw_2_all_bipartite_memberships
AS 
SELECT * FROM vw_2_ceda_membership
UNION
SELECT * FROM vw_2_religion_membership
UNION
SELECT * FROM vw_2_occupation_membership 
UNION
SELECT * FROM vw_2_location_membership
UNION
SELECT * FROM vw_2_club_membership 
UNION
SELECT * FROM vw_2_society_membership;

SELECT COUNT(*) FROM vw_2_all_bipartite_memberships;



DROP VIEW vw_2_all_bipartite_memberships_xceda;

CREATE VIEW vw_2_all_bipartite_memberships_xceda
AS 
SELECT * FROM vw_2_religion_membership
UNION
SELECT * FROM vw_2_occupation_membership 
UNION
SELECT * FROM vw_2_location_membership
UNION
SELECT * FROM vw_2_club_membership 
UNION
SELECT * FROM vw_2_society_membership;

SELECT COUNT(*) FROM vw_2_all_bipartite_memberships_xceda;



--------------------------------------------------------------------------------------------------------------------------------------

-- this view contributes to vw_3_all_names_attributes, DO NOT DELETE
DROP VIEW vw_3_bipartite_names;

CREATE VIEW vw_3_bipartite_names
AS
SELECT name AS Name, id
FROM vw_1_person_names;

SELECT COUNT(*) FROM vw_3_bipartite_names;


-- this view contributes to vw_3_all_bipartite_attributes, DO NOT DELETE
DROP VIEW [vw_3_bipartite_nodes];

CREATE VIEW [vw_3_bipartite_nodes]
AS
SELECT name AS Name, id FROM ceda
UNION
SELECT name AS Name, id FROM club
UNION
SELECT name AS Name, id FROM society
UNION
SELECT name AS Name, id FROM religion
UNION
SELECT name AS Name, id FROM occupation
UNION
SELECT name AS Name, id FROM location;

SELECT COUNT(*) FROM vw_3_bipartite_nodes; 



DROP VIEW vw_3_all_names; 

CREATE VIEW vw_3_all_names 
AS
SELECT Name, id FROM vw_3_bipartite_names
UNION
SELECT Name, id FROM vw_3_bipartite_nodes;

SELECT COUNT (*) FROM vw_3_all_names;




DROP VIEW vw_3_all_names_attributes;

CREATE VIEW vw_3_all_names_attributes
AS
SELECT vw_3_all_names.Name, 
	vw_1_person_with_quakers.religion_id, 
	vw_1_person_with_quakers.birth_year, vw_1_person_with_quakers.death_year,
	vw_1_person_with_quakers.gender_id, vw_1_person_with_quakers.data_source_id
FROM vw_3_all_names
LEFT JOIN vw_1_person_with_quakers
ON vw_1_person_with_quakers.Name = vw_3_all_names.Name;

SELECT COUNT (*) FROM vw_3_all_names_attributes;


-- This view needs vw_4_ceda_membership_dates first

DROP VIEW vw_3_all_bipartite_attributes;

CREATE VIEW vw_3_all_bipartite_attributes
AS
SELECT vw_2_all_bipartite_memberships."Source", vw_2_all_bipartite_memberships."Target", 
	vw_4_ceda_membership_dates.first_year, vw_4_ceda_membership_dates.last_year 
FROM vw_2_all_bipartite_memberships
LEFT JOIN vw_4_ceda_membership_dates
ON vw_2_all_bipartite_memberships."Source" = vw_4_ceda_membership_dates.first_year 
	AND vw_2_all_bipartite_memberships."Target" = vw_4_ceda_membership_dates.last_year ; 

SELECT COUNT (*) FROM vw_3_all_bipartite_attributes;


---------------------------------------------------------------------------------------------------------------------------

DROP VIEW vw_4_ceda_membership_dates;

CREATE VIEW IF NOT EXISTS vw_4_ceda_membership_dates as 
SELECT m.person_id, (p.first_names || " " || p.family_name) AS "Name", IFNULL(p.birth_year,'NA') AS birth_year, IFNULL(death_year, 'NA')
	AS death_year, m.ceda_id, c.name AS "Target", m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id AND m.first_year is not null and m.last_year is not null;


SELECT COUNT(*) FROM vw_4_ceda_membership_dates;



DROP VIEW vw_4_ceda_membership_dates_ai;

CREATE VIEW vw_4_ceda_membership_dates_ai 
AS
SELECT Name, birth_year, death_year, Target, first_year, last_year  
FROM vw_4_ceda_membership_dates
WHERE vw_4_ceda_membership_dates.Target ='AI';



DROP VIEW vw_4_ceda_membership_dates_ai_tuples;

CREATE VIEW vw_4_ceda_membership_dates_ai_tuples 
AS
SELECT Name AS 'Source', Target
FROM vw_4_ceda_membership_dates_ai
WHERE vw_4_ceda_membership_dates_ai.Target ='AI';



DROP VIEW vw_4_ceda_membership_dates_aps;

CREATE VIEW vw_4_ceda_membership_dates_aps 
AS
SELECT Name, birth_year, death_year, Target, first_year, last_year  
FROM vw_4_ceda_membership_dates
WHERE vw_4_ceda_membership_dates.Target ='APS';

DROP VIEW vw_4_ceda_membership_dates_aps_tuples;

CREATE VIEW vw_4_ceda_membership_dates_aps_tuples 
AS
SELECT Name AS 'Source', Target
FROM vw_4_ceda_membership_dates_aps
WHERE vw_4_ceda_membership_dates_aps.Target ='APS';



DROP VIEW vw_4_ceda_membership_dates_esl;

CREATE VIEW vw_4_ceda_membership_dates_esl 
AS
SELECT Name, birth_year, death_year, Target, first_year, last_year  
FROM vw_4_ceda_membership_dates
WHERE vw_4_ceda_membership_dates.Target ='ESL';


DROP VIEW vw_4_ceda_membership_dates_esl_tuples;

CREATE VIEW vw_4_ceda_membership_dates_esl_tuples 
AS
SELECT Name AS 'Source', Target
FROM vw_4_ceda_membership_dates_esl
WHERE vw_4_ceda_membership_dates_esl.Target ='ESL';



DROP VIEW vw_4_ceda_membership_dates_asl;

CREATE VIEW vw_4_ceda_membership_dates_asl 
AS
SELECT Name, birth_year, death_year, Target, first_year, last_year  
FROM vw_4_ceda_membership_dates
WHERE vw_4_ceda_membership_dates.Target ='ASL';

DROP VIEW vw_4_ceda_membership_dates_asl_tuples;

CREATE VIEW vw_4_ceda_membership_dates_asl_tuples 
AS
SELECT Name AS 'Source', Target 
FROM vw_4_ceda_membership_dates_asl 
WHERE vw_4_ceda_membership_dates_asl.Target ='ASL';




DROP VIEW [vw_4_ceda_membership_quakers]; 

CREATE VIEW vw_4_ceda_membership_quakers
AS 
SELECT 
                person.id as person_id,
                (first_names || " " || family_name) AS Name,
               IFNULL(m2m_person_religion.religion_id,'NA') AS religion_id,
               IFNULL(religion.name,'NA') AS religion_name,
                m2m_person_ceda.ceda_id,
                ceda.name AS ceda_name,
                m2m_person_ceda.first_year AS person_ceda_first_year,
                m2m_person_ceda.last_year AS person_ceda_last_year
FROM person
INNER JOIN m2m_person_religion
                ON m2m_person_religion.person_id = person.id
LEFT JOIN religion
                ON religion.id = m2m_person_religion.religion_id
INNER JOIN m2m_person_ceda
                ON m2m_person_ceda.person_id = person.id
LEFT JOIN ceda 
                ON ceda.id = m2m_person_ceda.ceda_id 
WHERE 
                m2m_person_ceda.first_year IS NOT NULL
                AND
                m2m_person_ceda.last_year IS NOT NULL;
               
 SELECT COUNT (*) From  vw_4_ceda_membership_quakers; 

--------------------------------------------------------------------------------------------------------------------------------------------------

--this view contributes to vw_5_person1_person2 DO NOT DELETE
DROP VIEW vw_5_person1;
Create VIEW vw_5_person1
AS
SELECT
		m2m_person_person.id,
		m2m_person_person.relationship_type_id, 
		m2m_person_person.person1_id,
		(person.first_names || " " || person.family_name) AS person1_name 
FROM m2m_person_person, person
WHERE m2m_person_person.person1_id = person.id;

SELECT COUNT (*) From  vw_5_person1;


--this view contributes to vw_5_person1_person2 DO NOT DELETE
DROP VIEW vw_5_person2;
Create VIEW vw_5_person2
AS
SELECT
		m2m_person_person.id,
		m2m_person_person.person2_id,
		(person.first_names || " " || person.family_name) AS person2_name 
FROM m2m_person_person, person
WHERE m2m_person_person.person2_id = person.id;

SELECT COUNT (*) From  vw_5_person2;



DROP VIEW vw_5_person1_person2;

CREATE VIEW vw_5_person1_person2
AS
SELECT
	vw_5_person1.person1_name AS "Source",
	vw_5_person2.person2_name AS "Target",
	vw_5_person1.relationship_type_id
FROM vw_5_person1
LEFT JOIN vw_5_person2
ON vw_5_person1.id = vw_5_person2.id; 

SELECT COUNT (*) From  vw_5_person1_person2;


------------------------------------------------------------------------------------------------------------------------------------

--this additional view may be helpful when data cleaning:

DROP VIEW [vw_6_person_all_withceda];

CREATE VIEW [vw_6_person_all_withceda]
AS
SELECT (person.first_names || " " || person.family_name) AS person_name, IFNULL(person.gender_id, 'NA') AS gender_id, IFNULL(person.birth_year,'NA') AS birth_year, IFNULL(person.death_year,'NA') AS death_year, person.data_source_id,
	IFNULL(m2m_person_ceda.ceda_id,'NA') AS ceda_id,
    IFNULL(m2m_person_religion.religion_id,'NA') AS religion_id,
    IFNULL(m2m_person_occupation.occupation_id,'NA') AS occupation_id,
	IFNULL(m2m_person_location.location_id,'NA') AS location_id,
	IFNULL(m2m_person_society.society_id,'NA') AS society_id,
	IFNULL(m2m_person_club.club_id,'NA') AS club_id
FROM person
LEFT JOIN m2m_person_ceda
ON person.id = m2m_person_ceda.person_id
LEFT JOIN m2m_person_religion
ON person.id = m2m_person_religion.person_id
LEFT JOIN m2m_person_occupation
ON person.id = m2m_person_occupation.person_id
LEFT JOIN m2m_person_location
ON person.id = m2m_person_location.person_id
LEFT JOIN m2m_person_society
ON person.id = m2m_person_society.person_id
LEFT JOIN m2m_person_club
ON person.id = m2m_person_club.person_id;

SELECT count(*) FROM vw_6_person_all_withceda; 

SELECT * FROM vw_6_person_all_withceda
WHERE person_name = 'Charles Cardale Babington';

SELECT count(religion_id) FROM vw_6_person_all_withceda
WHERE religion_id <> "NA"; 


-- end