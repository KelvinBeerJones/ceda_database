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


--This VIEW lists all 3145 persons (NODES) in the database with their person attributes (From the person table) .
CREATE VIEW [vw_person]
AS
SELECT id, family_name, first_names, (first_names || " " || family_name) AS name, title, gender_id, birth_year, death_year, data_source_id, notes
FROM person;

SELECT * FROM vw_person;

SELECT count(*) FROM vw_person vp; 

--this view is vw_person in Gephi format
CREATE VIEW [vw_person_gephi]
AS
SELECT id, (first_names || " " || family_name) AS name, title, gender_id, birth_year, death_year, data_source_id, notes
FROM person;

SELECT * FROM vw_person_gephi;

SELECT count(*) FROM vw_person vp; 


--This view lists all possible social group NODES in the database (514)
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


--this view shows all members of each CEDA (Some persons are members of more than one)
CREATE VIEW IF NOT EXISTS vw_ceda_membership as 
SELECT m.person_id, p.family_name, p.first_names, m.ceda_id, c.name, m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id AND m.first_year is not null and m.last_year is not null;

SELECT * FROM vw_ceda_membership;

SELECT count(*) FROM vw_ceda_membership vcm;

--This view shows 3946 vw_ceda_memberships in Gephi format
CREATE VIEW IF NOT EXISTS vw_ceda_membership_gephi as 
SELECT m.person_id AS ID, (p.first_names || " " || p.family_name) AS Source, c.name AS Target, m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id and m.last_year;

SELECT * FROM vw_ceda_membership_gephi;

SELECT count(*) FROM vw_ceda_membership_gephi;


--The following 5 sets make up all group memberships in Gephi format.
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


DROP VIEW vw_all_memberships_gephi;


-- UNION the views above to make one all sociaties view
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



-- end