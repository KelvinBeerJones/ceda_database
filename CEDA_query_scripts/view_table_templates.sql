-- view data falls into 4 separate types, 
--SOURCE NODES and TARGET NODES, 
--SOCIAL EDGES and DYNAMIC EDGES these make the relationships between SOURCE NODES and TARGET NODES).

--SOURCE NODES (are always persons) and views are made only from the person_table and can include ATTRIBUTES. SOURCE NODES views always take the form - a 'name' 
--made by joining 'first_names' and 'family_name'. ATTRIBUTES taken from the person_table can then be added (See vw_person and vw_person_gephi)

-- TARGET NODES (are always social groups including ceda) they are the social groups in which person are members - societies, clubs etc (vw_nodes list all TARGET NODES). 

-- DYNAMIC EDGES views are always made from the m2m_person_ceda table where the SOURCE is the name (see SOURCE NODES view above), 
--and a TARGET which is a ceda (see TARGET NODES above). Persons can be in more than one CEDA.
-- ATTRIBUTES are usually added, first_date and last_date and these ATTRIBUTES together make the dynamic graph in gephi. 
--(see vw_ceda_membership and vw_ceda_membership_gephi).

--SOCIAL EDGES views are made from the person table (allpersons), joined to the m2m_person_xxx tables where the SOURCE is the name (see SOURCE NODES view above),
--and a target which is a social group (see TARGET NODES above) and joined to the social group table (to collect the entity name). 
--ATTRIBUTES are not added.
--(see vw_club and vw_club_gephi)

--To substitute for NULL in a field use: select id, family_name, IFNULL(title, 'xxx') from person p


--This VIEW lists all 3145 persons (NODES) in the database with their person attributes (From the person table) .

----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- this is a primary view of the database. It returns all 3145 members of the ceda with all null fileds filled in with "NA" (Other views can be LEFT JOINED to this view)
DROP VIEW [vw_person];

CREATE VIEW [vw_person]
AS
SELECT id, (first_names || " " || family_name) AS name, 
IFNULL(title,'NA') AS title, IFNULL(gender_id,'NA') AS gender_id, IFNULL(birth_year,'NA') AS birth_year, IFNULL(death_year,'NA') AS death_year, data_source_id, notes
FROM person;

SELECT * FROM vw_person;

SELECT count(*) FROM vw_person vp; 


---------------------------------------------------------------------------------------------------------------------------------------------------------------

--this view is vw_person in Gephi format (with joined names only) this view is the nodes table for persons.(To which other nodes can be added manually into the generated csv file.)

DROP VIEW [vw_person_gephi];

CREATE VIEW [vw_person_gephi]
AS
SELECT id, (first_names || " " || family_name) AS name, 
IFNULL(title,'NA'), IFNULL(gender_id,'NA'), IFNULL(birth_year,'NA'), IFNULL(death_year,'NA'), data_source_id, notes
FROM person;

SELECT * FROM vw_person_gephi;

SELECT count(*) FROM vw_person vp; 

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--This view collects all data for pandas (including ceda and non-ceda) 

DROP VIEW [vw_person_all_withceda];

CREATE VIEW [vw_person_all_withceda]
AS
SELECT (person.first_names || " " || person.family_name) AS person_name, person.gender_id, IFNULL(person.birth_year,'NA') AS birth_year, IFNULL(person.death_year,'NA') AS death_year, person.data_source_id,
	IFNULL(m2m_person_religion.religion_id,'NA') AS religion_id,
	IFNULL(m2m_person_society.society_id,'NA') AS society_id,
	IFNULL(m2m_person_club.club_id,'NA') AS club_id,
	IFNULL(m2m_person_occupation.occupation_id,'NA') AS occupation_id,
	IFNULL(m2m_person_location.location_id,'NA') AS location_id,
	IFNULL(m2m_person_ceda.ceda_id,'NA') AS ceda_id
FROM person
LEFT JOIN m2m_person_religion
ON person.id = m2m_person_religion.person_id
LEFT JOIN m2m_person_society
ON person.id = m2m_person_society.person_id
LEFT JOIN m2m_person_club
ON person.id = m2m_person_club.person_id
LEFT JOIN m2m_person_occupation
ON person.id = m2m_person_occupation.person_id
LEFT JOIN m2m_person_location
ON person.id = m2m_person_location.person_id
LEFT JOIN m2m_person_ceda
ON person.id = m2m_person_ceda.person_id;

SELECT * FROM vw_person_all_withceda;

SELECT count(*) FROM vw_person_all_withceda; 


---------------------------------------------------------------------------------------------------------------------------------------------------------

-- This view collects all non ceda data for pandas

DROP VIEW [vw_person_all_nonceda];

CREATE VIEW [vw_person_all_nonceda]
AS
SELECT (person.first_names || " " || person.family_name) AS person_name, person.gender_id, IFNULL(person.birth_year,'NA') AS birth_year, IFNULL(person.death_year,'NA') AS death_year, person.data_source_id,
	IFNULL(m2m_person_religion.religion_id,'NA') AS religion_id,
	IFNULL(m2m_person_society.society_id,'NA') AS society_id,
	IFNULL(m2m_person_club.club_id,'NA') AS club_id,
	IFNULL(m2m_person_occupation.occupation_id,'NA') AS occupation_id,
	IFNULL(m2m_person_location.location_id,'NA') AS location_id
FROM person
LEFT JOIN m2m_person_religion
ON person.id = m2m_person_religion.person_id
LEFT JOIN m2m_person_society
ON person.id = m2m_person_society.person_id
LEFT JOIN m2m_person_club
ON person.id = m2m_person_club.person_id
LEFT JOIN m2m_person_occupation
ON person.id = m2m_person_occupation.person_id
LEFT JOIN m2m_person_location
ON person.id = m2m_person_location.person_id;

SELECT * FROM vw_person_all_nonceda;

SELECT count(*) FROM vw_person_all_nonceda; 

-------------------------------------------------------------------------------------------------------------------------------------------------

--This view lists all possible non ceda NODES in the database by making a union of all non person tables id and name (514)

CREATE VIEW [vw_nodes]
AS
SELECT id, name FROM ceda
UNION
SELECT id, name FROM club
UNION
SELECT id, name FROM society
UNION
SELECT id, name FROM religion
UNION
SELECT id, name FROM occupation
UNION
SELECT id, name FROM location;

SELECT * FROM vw_nodes;

SELECT count(*) FROM vw_nodes; 

--------------------------------------------------------------------------------------------------------------------------------------------------------

--this view shows all members of each CEDA (Some persons are members of more than one)

DROP VIEW vw_ceda_membership;

CREATE VIEW IF NOT EXISTS vw_ceda_membership as 
SELECT m.person_id, (p.first_names || " " || p.family_name) AS person_name, IFNULL(p.birth_year,'NA') AS birth_year, m.ceda_id, c.name AS ceda_name, m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id AND m.first_year is not null and m.last_year is not null;

SELECT * FROM vw_ceda_membership;

SELECT count(*) FROM vw_ceda_membership vcm;

--------------------------------------------------------------------------------------------------------------------------------------------------
--This view selects only persons whose birth_year is known

DROP VIEW vw_ceda_membership_with_ages;

CREATE VIEW IF NOT EXISTS vw_ceda_membership_with_ages as 
SELECT m.person_id, (p.first_names || " " || p.family_name) AS person_name, p.birth_year AS birth_year, m.ceda_id, c.name AS ceda_name, m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id AND m.first_year is not null and m.last_year is not null and birth_year is not null;

SELECT * FROM vw_ceda_membership_with_ages;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

--This view shows 3946 vw_ceda_memberships in Gephi format

CREATE VIEW IF NOT EXISTS vw_ceda_membership_gephi as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, c.name AS Target, m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id and m.last_year;

SELECT * FROM vw_ceda_membership_gephi;

SELECT count(*) FROM vw_ceda_membership_gephi;

--------------------------------------------------------------------------------------------------------------------------------------------------------

--The following 6 sets make up all group memberships in Gephi format.

CREATE VIEW IF NOT EXISTS vw_religion_membership_gephi as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, r.name AS Target  
FROM m2m_person_religion m, person p, religion r 
WHERE m.person_id = p.id AND m.religion_id = r.id AND p.first_names IS NOT NULL;

SELECT * FROM vw_religion_membership_gephi;


CREATE VIEW vw_society_membership_gephi as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, s.name AS Target  
FROM m2m_person_society m, person p, society s 
WHERE m.person_id = p.id AND m.society_id = s.id AND p.first_names IS NOT NULL;

SELECT * FROM vw_society_membership_gephi;


CREATE VIEW vw_club_membership_gephi as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, c.name AS Target  
FROM m2m_person_club m, person p, club c 
WHERE m.person_id = p.id AND m.club_id = c.id AND p.first_names IS NOT NULL;

SELECT * FROM vw_club_membership_gephi;

CREATE VIEW IF NOT EXISTS vw_location_membership_gephi as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, l.name AS Target  
FROM m2m_person_location m, person p, location l 
WHERE m.person_id = p.id AND m.location_id = l.id AND p.first_names IS NOT NULL;

SELECT * FROM vw_location_membership_gephi;

CREATE VIEW IF NOT EXISTS vw_occupation_membership_gephi as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, o.name AS Target  
FROM m2m_person_occupation m, person p, occupation o 
WHERE m.person_id = p.id AND m.occupation_id = o.id AND p.first_names IS NOT NULL;

SELECT * FROM vw_occupation_membership_gephi;

CREATE VIEW IF NOT EXISTS vw_ceda_membership_gephi2 as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, c.name AS Target 
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id; 

------------------------------------------------------------------------------------------------------------------------------------

-- UNION the views above to make one all memberships view

CREATE VIEW vw_all_society_memberships_gephi
AS 
SELECT * FROM vw_club_membership_gephi vcmg 
UNION
SELECT * FROM vw_location_membership_gephi vlmg 
UNION
SELECT * FROM vw_occupation_membership_gephi vomg 
UNION
SELECT * FROM vw_religion_membership_gephi vrmg
UNION
SELECT * FROM vw_society_membership_gephi vsmg;

SELECT count(*) FROM vw_all_society_memberships_gephi;

SELECT * FROM vw_all_society_memberships_gephi;

-------------------------------------------------------------------------------------------------------------------------------------------

-- The following 5 code sets are TABLE views in non Gephi format.

CREATE VIEW [vw_religion] 
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
	
	SELECT * FROM vw_religion;


CREATE VIEW [vw_club] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   club.id,
	   club.name as 'club'
FROM person, club, m2m_person_club
WHERE person.id = m2m_person_club.person_id 
		AND club.id = m2m_person_club.club_id;
	
SELECT * FROM vw_club;


CREATE VIEW [vw_location] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   location.id,
	   location.name as 'location'
FROM person, location, m2m_person_location
WHERE person.id = m2m_person_location.person_id 
		AND location.id = m2m_person_location.location_id;
	
SELECT * FROM vw_location;

CREATE VIEW [vw_occupation] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   occupation.id,
	   occupation.name as 'occupation'
FROM person, occupation, m2m_person_occupation
WHERE person.id = m2m_person_occupation.person_id 
		AND occupation.id = m2m_person_occupation.occupation_id;
	

SELECT * FROM vw_occupation;


CREATE VIEW [vw_society] 
AS 
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   society.id,
	   society.name as 'society'
FROM person, society, m2m_person_society
WHERE person.id = m2m_person_society.person_id 
		AND society.id = m2m_person_society.society_id;
	

SELECT * FROM vw_society;

create view vw_person_nonullsyears as
select *
from vw_person vp
where birth_year != 'NA' AND death_year != 'NA';

DROP VIEW [vw_gephi_person_religion_ceda]; 

CREATE VIEW [vw_gephi_person_religion_ceda] 
AS 
SELECT 
                person.id as person_id,
                (first_names || " " || family_name) AS person_name,
               IFNULL(m2m_person_religion.religion_id,'NA') AS religion_id,
               IFNULL(religion.name,'NA') AS religion_name,
                m2m_person_religion.confirmed as religion_confirmed,
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

----------------------------------------------------------------------------------------------------------------------------------------

-- end