SELECT *
FROM person p 
WHERE family_name = "Buxton";

SELECT *
FROM person p 
WHERE first_names = "Abram Rawlinson";

SELECT * 
FROM m2m_person_religion mmpr 
WHERE person_id =2518;

SELECT *
FROM m2m_person_ceda mmpc 
WHERE person_id = 2518;

DELETE FROM m2m_person_religion 
WHERE person_id = 2309;

SELECT *
FROM vw_5_person1_person2 vpp 
WHERE Source = "William Fowler" OR Target = "William Fowler";


-- delete Thomas Fowell Buxton and Edward North Buxton, Charles Buxton, Edmund Buxton and Miss Buxton from Quakers and Quaker relationships.

SELECT *
FROM person p 
WHERE family_name = "Barclay";

-- 322, 2309, 2607, 2965 and 2966 Person_id 

SELECT *
FROM m2m_person_religion mmpr 
WHERE person_id = 322
OR person_id = 2309 
OR person_id =2607 
OR person_id =2965 
OR person_id =2966;

DELETE
FROM m2m_person_person 
WHERE person1_id = 2309 OR 
person1_id = 322 OR 
person1_id = 2607 OR 
person1_id = 2965 OR 
person1_id = 2966;

SELECT *
FROM m2m_person_ceda mmpc 
WHERE person_id = 2518;


DELETE 
FROM m2m_person_religion 
WHERE id = 61
OR id = 424;

SELECT *
FROM m2m_person_religion mmpr 
WHERE person_id = 2518;


SELECT *
FROM person p 
WHERE family_name  = "Treffry";

SELECT *
FROM m2m_person_person mmpp 
WHERE person1_id = 2485 OR
person1_id = 2845 OR
person2_id = 2845 OR
person2_id = 2485;

SELECT *
FROM person p 
WHERE family_name = "Hodgkin";

SELECT *
FROM vw_5_person1_person2 vpp 
WHERE "Source" = "Thomas (1) Hodgkin" OR 
Target = "Thomas (1) Hodgkin";








