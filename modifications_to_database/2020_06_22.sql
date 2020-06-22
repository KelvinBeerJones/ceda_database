
-- Purpose of script: to change title in person table from a select list (so foreign key in person table) to a string
-- 3 steps:
    -- A: Add 'title' column to person table
    -- B: Populate title column with data based on title_id field and sl_title select list table
    -- C: Remove title_id column
    -- D: Drop sl_title table


-- A: Add 'title' column to person table
ALTER TABLE person
ADD title VARCHAR(255);



-- B: Populate title column with data based on title_id field and sl_title select list table
-- 1/3 - create a temporary view that lists the person id and title text               
CREATE view temp_title as
SELECT p.id as person_id, t.name as person_title
FROM person as p, sl_title as t
WHERE 
	p.title_id IS NOT NULL 
	AND
	p.title_id = t.id;
	
-- 2/3 - perform update on person table using temp view
UPDATE person as p
SET title = (select person_title from temp_title where p.id = person_id);

-- 3/3 - drop temp view
DROP VIEW temp_title;



-- C: Remove title_id column
-- 1/8 - drop views that use person table
DROP VIEW vw_ceda_membership;
-- 2/8 - disable foreign key constraint check
PRAGMA foreign_keys=off;
-- 3/8 - Drop columns and add new data_source_id column
CREATE TABLE IF NOT EXISTS person_temp (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    family_name VARCHAR (255),
    first_names VARCHAR (255),
    title VARCHAR(255),
    gender_id INTEGER,
    birth_year INTEGER,
    death_year INTEGER,
    data_source_id INTEGER,
    notes text,

    FOREIGN KEY (gender_id) REFERENCES sl_gender (id) ON DELETE SET NULL
    FOREIGN KEY (data_source_id) REFERENCES sl_person_data_source (id) ON DELETE SET NULL
);
-- 4/8 - copy data from the current table to the temp table
INSERT INTO person_temp(id, family_name, first_names, title, gender_id, birth_year, death_year, notes)
SELECT id, family_name, first_names, title, gender_id, birth_year, death_year, notes
FROM person;
-- 5/8 - drop the current table
DROP TABLE person;
-- 6/8 - rename the temp table to the original table name
ALTER TABLE person_temp RENAME TO person;
-- 7/8 - enable foreign key constraint check
PRAGMA foreign_keys=on;
-- 8/8 - add views back
CREATE VIEW IF NOT EXISTS vw_ceda_membership as 
SELECT m.person_id,p.family_name, p.first_names, m.ceda_id, c.name, m.first_year, m.last_year   
FROM m2m_person_ceda m, person p, ceda c 
WHERE m.person_id = p.id AND m.ceda_id = c.id and m.first_year is not null and m.last_year is not null;



-- D: Drop sl_title table
DROP TABLE sl_title;
