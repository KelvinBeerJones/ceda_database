-- These supplementary views enforce the rule IFNULL then 'NA' and to use the NON NULL views to construct new Quaker tuples tables (SOURDE) and (TARGET)

-- The views scripted here can be differentiated from others because they use the naming convention vw_hddt_
-- The script for views using the naming convention vw_1_ (etc) are scripted at <CEDA_dev,db> HDDT numeric_view_sets
-- The supplementary views here became necessary when in Jupyter Notebooks it was shown that columns containing 'NULL' 
-- would cause all data in the column to be rendered as decimal, this was inspite of the sql tables having been previously set to render 'NULL' as 'NA'.


-- To overcome this LNB rendering issue we first make a new basic view of person_table without ID column, 
-- with first_names and last_name joined AS Name, and IF NULL AS 'NA' throughout.

-- There are 3 sets of views:

-- 1 Persons - 3 named vw_hddt_person_ to produce person files in SOURCE format
-- 2 Quakers - 3 named vw_hddt_Person1, person2 and person1 and person2. These produce a SOURCE and TARGET file in SNA format. 
-- 3 Quaker person_person relationships.
-- 4 Quaker person_person relationships by type 'distant', 'close' and 'immediate'
-- 5 ceda as TUPLES - 'SOURCE' and 'TARGET'
-- 6 Bigraph views Non CEDA
-- 7 All Tuples (SOURCES) and (TARGETS)

--------------------------------------------------------------------------------------------------------------------------------------

-- set 1 - persons

DROP VIEW [vw_hddt_person_table];

CREATE VIEW [vw_hddt_person_table]
AS
SELECT (first_names || " " || family_name) AS Name, 
IFNULL(title,'NA') AS title, 
IFNULL(gender_id,'NA') AS gender_id, 
IFNULL(birth_year,'NA') AS birth_year, 
IFNULL(death_year,'NA') AS death_year, 
data_source_id, 
notes
FROM person;

SELECT COUNT (*) FROM vw_hddt_person_table;


-- we can then make a new 'Names' table from vw_hddt_person_table above
DROP VIEW [vw_hddt_person_name];

CREATE VIEW vw_hddt_person_name
AS 
SELECT DISTINCT Name
FROM vw_hddt_person_table;

SELECT COUNT (*) FROM vw_hddt_person_name;



DROP VIEW [vw_hddt_person_donor];

CREATE VIEW [vw_hddt_person_donor]
AS
SELECT (first_names || " " || family_name) AS Name, 
data_source_id
FROM person;

SELECT COUNT (*) FROM vw_hddt_person_donor;


DROP VIEW [vw_hddt_person_with_data_source];

CREATE VIEW [vw_hddt_person_with_data_source] 
AS 
SELECT (first_names || " " || family_name) AS Name, 
		IFNULL(name,'NA') AS data_source
FROM person
LEFT JOIN sl_person_data_source
ON person.data_source_id = sl_person_data_source.id;

SELECT COUNT (*) FROM vw_hddt_person_with_data_source;




-- Then a person (or SOURCE) view can be made with attributes, also from the person_table
DROP VIEW [vw_hddt_person_attributes];

CREATE VIEW [vw_hddt_person_attributes]
AS 
SELECT Name, birth_year, death_year
FROM vw_hddt_person_table;

SELECT COUNT (*) FROM vw_hddt_person_attributes;

-----------------------------------------------------------------------------------------------------------------------------------------------
-- Set 2 Quakers

--add religion to the person_table Name attributes (no person has 2 religions)
DROP VIEW [vw_hddt_person_attributes_religion];

CREATE VIEW [vw_hddt_person_attributes_religion] 
AS 
SELECT (first_names || " " || family_name) AS Name, 
	IFNULL(birth_year,'NA') AS birth_year, 
	IFNULL(death_year,'NA') AS death_year, 
	IFNULL(religion_id,'NA') AS religion_1_quaker
FROM person
LEFT JOIN m2m_person_religion
ON person.id = m2m_person_religion.person_id;
SELECT COUNT (*) FROM vw_hddt_person_attributes_religion;


-- get Quakers only from vw_hddt_person_attributes_religion
DROP VIEW [vw_hddt_quakers];

CREATE VIEW [vw_hddt_quakers]
AS 
SELECT Name, 
	IFNULL(birth_year,'NA') AS birth_year, 
	IFNULL(death_year,'NA') AS death_year
FROM vw_hddt_person_attributes_religion 
WHERE religion_1_quaker = 1;
SELECT COUNT (*) FROM vw_hddt_quakers;	

--------------------------------------------------------------------------------------------------------------------------------------------------
-- Set 3 Quakers person - person relationships. This is a 3 part build!

-- this view contributes to person1_person2 DO NOT DELETE
DROP VIEW vw_hddt_person1;

Create VIEW vw_hddt_person1
AS
SELECT
		m2m_person_person.id,
		m2m_person_person.relationship_type_id, 
		m2m_person_person.person1_id,
		(person.first_names || " " || person.family_name) AS person1_name 
FROM m2m_person_person, person
WHERE m2m_person_person.person1_id = person.id;
SELECT COUNT (*) FROM vw_hddt_person1


--this view contributes to person1_person2 DO NOT DELETE
DROP VIEW vw_hddt_person2;

Create VIEW vw_hddt_person2
AS
SELECT
		m2m_person_person.id,
		m2m_person_person.person2_id,
		(person.first_names || " " || person.family_name) AS person2_name 
FROM m2m_person_person, person
WHERE m2m_person_person.person2_id = person.id;
SELECT COUNT (*) FROM vw_hddt_person2


-- This view combines person1 with person2
DROP VIEW vw_hddt_person1_person2;

CREATE VIEW vw_hddt_person1_person2
AS
SELECT
	vw_5_person1.person1_name AS "Source",
	vw_5_person2.person2_name AS "Target",
	vw_5_person1.relationship_type_id AS "relationship_type_id"
FROM vw_5_person1
LEFT JOIN vw_5_person2
ON vw_5_person1.id = vw_5_person2.id; 
SELECT COUNT (*) FROM vw_hddt_person1_person2;


------------------------------------------------------------------------------------------------------------------------------------------
--Set 4 Quaker person_person relationships by type

               
-- These three views capture each relationship type               
DROP VIEW vw_hddt_person_person_distant;

CREATE VIEW vw_hddt_person_person_distant
AS
SELECT 'Source', Target, relationship_type_id AS 'distant'
FROM vw_5_person1_person2
WHERE vw_5_person1_person2.relationship_type_id = 1;
SELECT COUNT (*) FROM vw_hddt_person_person_distant;


DROP VIEW vw_hddt_person_person_close;

CREATE VIEW vw_hddt_person_person_close
AS
SELECT 'Source', Target, relationship_type_id AS 'close'
FROM vw_5_person1_person2
WHERE vw_5_person1_person2.relationship_type_id = 2;
SELECT COUNT (*) FROM vw_hddt_person_person_close;

DROP VIEW vw_hddt_person_person_immediate;

CREATE VIEW vw_hddt_person_person_immediate
AS
SELECT 'Source', Target, relationship_type_id AS 'immediate'
FROM vw_5_person1_person2
WHERE vw_5_person1_person2.relationship_type_id = 3;               
SELECT COUNT (*) FROM vw_hddt_person_person_immediate;



---------------------------------------------------------------------------------------------------------------------------------------
--Set 5 ceda as TUPLES - 'SOURCE' and 'TARGET'


DROP VIEW vw_hddt_ceda_tuples; 

CREATE VIEW IF NOT EXISTS vw_hddt_ceda_tuples as 
SELECT (p.first_names || " " || p.family_name) AS Source, c.name AS Target 
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id; 
SELECT COUNT (*) FROM vw_hddt_ceda_tuples; 

--additional test
SELECT * 
FROM vw_hddt_ceda_tuples
WHERE vw_hddt_ceda_tuples.Target = 'QCA';



DROP VIEW [vw_hddt_ceda_tuples_attributes]; 

CREATE VIEW vw_hddt_ceda_tuples_attributes
AS 
SELECT (first_names || " " || family_name) AS 'Source',
       ceda.name AS Target,
       m2m_person_ceda.first_year AS first_year,
       m2m_person_ceda.last_year AS last_year, 
       IFNULL(birth_year,'NA') AS birth_year, 
		IFNULL(death_year, 'NA') AS death_year
FROM person
INNER JOIN m2m_person_ceda
                ON m2m_person_ceda.person_id = person.id
LEFT JOIN ceda 
                ON ceda.id = m2m_person_ceda.ceda_id 
WHERE 
                m2m_person_ceda.first_year IS NOT NULL
                AND
                m2m_person_ceda.last_year IS NOT NULL;
 SELECT COUNT (*) FROM vw_hddt_ceda_tuples_attributes;              
               
     
     
DROP VIEW [vw_hddt_ceda_name_attributes]; 

CREATE VIEW vw_hddt_ceda_name_attributes
AS 
SELECT (first_names || " " || family_name) AS 'Name',
		IFNULL(m2m_person_religion.religion_id,'NA') AS quaker,
       m2m_person_ceda.first_year AS first_year,
       m2m_person_ceda.last_year AS last_year, 
       IFNULL(birth_year,'NA') AS birth_year, 
		IFNULL(death_year, 'NA') AS death_year
FROM person
INNER JOIN m2m_person_ceda
ON m2m_person_ceda.person_id = person.id
LEFT JOIN m2m_person_religion
ON m2m_person_religion.person_id = person.id
WHERE m2m_person_ceda.first_year IS NOT NULL AND m2m_person_ceda.last_year IS NOT NULL;    
SELECT COUNT (*) FROM vw_hddt_ceda_name_attributes;     
     
     
-- quakers in the CEDA
DROP VIEW [vw_hddt_quakers_ceda_tuples]; 

CREATE VIEW vw_hddt_quakers_ceda_tuples
AS 
SELECT (first_names || " " || family_name) AS 'Source',
       ceda.name AS Target,
       IFNULL(religion.name,'NA') AS religion_name,
       m2m_person_ceda.first_year AS first_year,
       m2m_person_ceda.last_year AS last_year      
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
 SELECT COUNT (*) FROM vw_hddt_quakers_ceda_tuples;           
 ----------------------------------------------------------------------------------------------------------------------------------
 -- Set 6 Bigraph views Non CEDA
 
 DROP VIEW vw_hddt_society_tuples; 

CREATE VIEW vw_hddt_society_tuples as 
SELECT (p.first_names || " " || p.family_name) AS Source, s.name AS Target  
FROM m2m_person_society m, person p, society s 
WHERE m.person_id = p.id AND m.society_id = s.id;
SELECT COUNT (*) FROM vw_hddt_society_tuples;


DROP VIEW vw_hddt_club_tuples; 

CREATE VIEW vw_hddt_club_tuples as 
SELECT (p.first_names || " " || p.family_name) AS Source, c.name AS Target  
FROM m2m_person_club m, person p, club c 
WHERE m.person_id = p.id AND m.club_id = c.id;           
SELECT COUNT (*) FROM vw_hddt_club_tuples;             


DROP VIEW vw_hddt_location_tuples; 

CREATE VIEW IF NOT EXISTS vw_hddt_location_tuples as 
SELECT (p.first_names || " " || p.family_name) AS Source, l.name AS Target  
FROM m2m_person_location m, person p, location l 
WHERE m.person_id = p.id AND m.location_id = l.id;
SELECT COUNT (*) FROM vw_hddt_location_tuples; 


DROP VIEW vw_hddt_occupation_tuples; 

CREATE VIEW IF NOT EXISTS vw_hddt_occupation_tuples as 
SELECT (p.first_names || " " || p.family_name) AS Source, o.name AS Target  
FROM m2m_person_occupation m, person p, occupation o 
WHERE m.person_id = p.id AND m.occupation_id = o.id;
SELECT COUNT (*) FROM vw_hddt_occupation_tuples; 


DROP VIEW vw_hddt_religion_tuples; 

CREATE VIEW vw_hddt_religion_tuples as 
SELECT (p.first_names || " " || p.family_name) AS Source, r.name AS Target  
FROM m2m_person_religion m, person p, religion r 
WHERE m.person_id = p.id AND m.religion_id = r.id; 
SELECT COUNT (*) FROM vw_hddt_religion_tuples;

----------------------------------------------------------------------------------------------------------------------------------------------

-- Set 7 All tuples


DROP VIEW vw_hddt_all_bigraph_tuples;

CREATE VIEW vw_hddt_all_bigraph_tuples
AS 
SELECT * FROM vw_hddt_ceda_tuples
UNION
SELECT * FROM vw_hddt_society_tuples
UNION
SELECT * FROM vw_hddt_club_tuples
UNION
SELECT * FROM vw_hddt_location_tuples
UNION
SELECT * FROM vw_hddt_occupation_tuples
UNION
SELECT * FROM vw_hddt_religion_tuples;
SELECT COUNT (*) FROM vw_hddt_all_bigraph_tuples;



DROP VIEW [vw_hddt_bigraph_nodes];

CREATE VIEW [vw_hddt_bigraph_nodes]
AS
SELECT name AS Name FROM ceda
UNION
SELECT name AS Name FROM club
UNION
SELECT name AS Name FROM society
UNION
SELECT name AS Name FROM religion
UNION
SELECT name AS Name FROM occupation
UNION
SELECT name AS Name FROM location;
SELECT COUNT (*) FROM vw_hddt_bigraph_nodes;



-- combine persons with bigraph data
DROP VIEW vw_hddt_all_names_and_nodes; 

CREATE VIEW vw_hddt_all_names_and_nodes 
AS
SELECT Name FROM vw_hddt_person_name
UNION
SELECT Name FROM vw_hddt_bigraph_nodes;
SELECT COUNT (*) FROM vw_hddt_all_names_and_nodes ;

-- END
