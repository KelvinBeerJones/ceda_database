SELECT * 
FROM person
WHERE id > "2260";

-- answer = 1159 new records. CORRECT

SELECT COUNT(*) 
FROM person
WHERE data_source_id = 1;

-- There are no data sources = 1

SELECT COUNT(id)
FROM person;

-- answer = 3419 total records CORRECT!

SELECT COUNT(*) AS total_quakers
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, religion, m2m_person_religion  
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_religion.person_id 
		AND religion.id = m2m_person_religion.religion_id
-- Filter the search to output the chosen columns.
		AND religion.id = 1;
		
-- answer = 651 Quakers. CORRECT
	
SELECT COUNT(*) AS total_aps
-- Second locate the tables where each of the chosen columns can be found in FROM
FROM person, ceda, m2m_person_ceda  
-- Join the tables together by linking the primary keys to theri respective foreign keys
WHERE person.id = m2m_person_ceda.person_id 
		AND ceda.id = m2m_person_ceda.ceda_id 
-- Filter the search to output the chosen columns.
		AND ceda.id = 2;
		
-- answer 1233 (1218 kbj there are a few data_source_id = 1 AND ceda.1d = 2 which we can count when data_source_id = 1 put in the 2260 records.
	