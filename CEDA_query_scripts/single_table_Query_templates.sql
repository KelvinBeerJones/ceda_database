-- Single Table Quety Templates have the form - SELECT FROM WHERE

-- Example_1 (Find all persons where first names are not known)

SELECT *
FROM person
WHERE 
family_name NOTNULL AND
first_names IS NULL;

-- Example 2 (list all records added by kbj)

SELECT * 
FROM person
WHERE id > "2260";


-- Example 3 Combine Last and first names into a single column

SELECT (first_names || " " || family_name) AS full_name, 
		birth_year
FROM person;

-- Example 4 get all records for one family

SELECT *
FROM person
WHERE family_name IS "Campbell";

-- Example 5 get all records from person table

SELECT id, family_name, first_names, birth_year 
FROM person
WHERE family_name NOTNULL; 


--list all records where first_year > 1871 (and delete)

SELECT *
FROM m2m_person_ceda
WHERE first_year > 1871;

SELECT *
FROM person
WHERE data_source_id = '3';


