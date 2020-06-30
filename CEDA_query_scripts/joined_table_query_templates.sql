--Example of selecting data from 3 tables. To find the members of a club the person, 
--club and m2m_person_club table are needed. This is because the 2m2_person_club table contains the foreign keys that link
--the club table to the person table. 

-- The templates below address all tables linked to the person table

-- list all people in one club
SELECT * FROM m2m_person_club WHERE club_id = 13;

--count members of every club	
	
SELECT m2m_person_club.club_id,
		club.name AS club_name,
		COUNT(m2m_person_club.person_id) AS total_members
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, club, m2m_person_club
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_club.person_id 
		AND club.id = m2m_person_club.club_id
GROUP BY m2m_person_club.club_id
ORDER BY total_members DESC;

--list all members of one club, CLUB = Athaneum
-- first choose the columns to show in output table by SELECT
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   club.name as 'club_name' 
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, club, m2m_person_club
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_club.person_id 
		AND club.id = m2m_person_club.club_id
-- Filter the search to output the chosen columns.
		AND club.id = 2;
	
--count all memebrs of aAthanaeum club	
	
SELECT COUNT(*) AS total_members_athaneum
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, club, m2m_person_club
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_club.person_id 
		AND club.id = m2m_person_club.club_id
-- Filter the search to output the chosen columns.
		AND club.id = 2;

	

	
	
	
--LOCATION = London	
-- first choose the columns to show in output table by SELECT
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   location.name as 'location' 
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, location, m2m_person_location
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_location.person_id 
		AND location.id = m2m_person_location.location_id
-- Filter the search to output the chosen columns.
		AND location.id = 1;	
	
		
--OCCUPATION = Academic	
-- first choose the columns to show in output table by SELECT
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   occupation.name as 'occupation' 
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, occupation, m2m_person_occupation
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_occupation.person_id 
		AND occupation.id = m2m_person_occupation.occupation_id
-- Filter the search to output the chosen columns.
		AND occupation.id = 7;		

	
--RELIGION = Quaker	* NOTE: There is no data yet for this query!
-- first choose the columns to show in output table by SELECT
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   religion.name as 'religion' 
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, religion, m2m_person_religion
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_religion.person_id 
		AND religion.id = m2m_person_religion.religion_id
-- Filter the search to output the chosen columns.
		AND religion.id = 1;		
		

	
--SOCIETY = Royal College of Surgeons
-- first choose the columns to show in output table by SELECT
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   society.name as 'society' 
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, society, m2m_person_society
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_society.person_id 
		AND society.id = m2m_person_society.society_id
-- Filter the search to output the chosen columns.
		AND society.id = 2;		
		
		
--SUFFIX = Fellow of the Royal College of Surgeons
-- first choose the columns to show in output table by SELECT
SELECT person.id,
	   person.family_name,
	   person.first_names,
	   suffix.name as 'suffix' 
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, suffix, m2m_person_suffix
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_suffix.person_id 
		AND suffix.id = m2m_person_suffix.suffix_id
-- Filter the search to output the chosen columns.
		AND suffix.id = 4;		
		





-- find persons not in a ceda. This is important becuase the database is not for non-members!

	
SELECT id, family_name, first_names 
FROM person
WHERE person.id NOT IN
    (SELECT m2m_person_ceda.person_id 
     FROM m2m_person_ceda);

SELECT *
FROM m2m_person_ceda
WHERE first_year > 1871	 