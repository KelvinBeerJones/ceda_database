-- STNGQ Queries

-- SELECT FROM WHERE

-- From these SELECT queries I have been able to find out that:
-- 782 people joined the ESL (Example-1).
-- 762 left the ESL (Example_2). 
-- This means that 20 people must have joined but don't have a leaving date. (Example_9) returned 19.
-- I can find out for any CEDA the people who can be differentiated by title (Example_3). Or Gender.
-- I can find out how many ESL joiners were born before 1800 (Example_10) returns 96.
-- I can do housekeeping of data, e.g. find all persons where their first names are not known. (Example_4) returns 129
-- I can find the years in which people joined the ESL (Example_5). 
-- I could prove that the ESL joiners, 782 (from Example_1) all joined between 1843 and 1871 (Example_6). 
--           "I know that the ESL was formed in 1843 and dissolved in 1871."
-- I tested the COUNT function (Example_7) and correctly counted the members of the ESL at 782.
-- I can make a table of all the joiners in any year (Example 8)
-- I can find out how many people joined the ESL but never left (Example 9)
-- I can find out how many joiners to the ESL were born before 1800 (Example 10)
-- I can combine last_name and first_names to make a single string called 'full_name' (Example 11)
-- I can select data from the person table for any given year. (I can construct a loop here to run through all years) (Example 12)





-- Example_1 (find all members of the Ethnological Society of London)

SELECT family_name, first_names, esl_join_year
FROM person
WHERE esl_join_year IS NOT NULL
ORDER BY esl_join_year;

-- ISSUE How do I add a new column to the results table = Year joined? 




-- Example_2 (find all members who left the Ethnological Society of London)

SELECT *
FROM person
WHERE esl_left_year > 1800;

-- NOTE above query is correct but there are blank cells! (Should be NULL)

-- ISSUE This SELECT attempts to answer the ISSUE from Example_1




-- Example_3 (find all Dr in the Ethnological Society of London)

SELECT *
FROM person
WHERE title_id = 21 AND
	esl_join_year NOTNULL ;




-- Example_4 (Find all persons where first names are not known)

SELECT *
FROM person
WHERE 
family_name NOTNULL AND
first_names IS NULL;




-- Example_5 (List years in which people joined Ethnological Society of London) 

SELECT DISTINCT(esl_join_year)
FROM person
ORDER BY(esl_join_year);



-- Example_6 (list people who joined Ethnological Society of London between range of years)

SELECT * 
FROM person
WHERE esl_join_year >= 1843 AND esl_join_year <= 1871;




--Example_7 (Find out how many people joined the Ethnological Society of London between range of years)

SELECT COUNT(id)
FROM person
WHERE esl_join_year >= 1843 AND esl_join_year <= 1871;

-- ISSUE I now know that 782 people joined the ESL and the year in which they joined.





--Example_8 How to script - show number of joiners in each year? e.g. 1843 = 100, 1844 = 150, 1845 = 42

SELECT DISTINCT(esl_join_year),
COUNT(*) AS 'No_of_joiners'
FROM person
WHERE esl_join_year IS NOT NULL
GROUP BY esl_join_year
HAVING COUNT(*) > 20
ORDER BY(esl_join_year);

-- check out HAVING!



-- Example_9 How many people joined the ESL but never left?

SELECT family_name, first_names
FROM person
WHERE esl_join_year NOTNULL AND esl_left_year ISNULL;




--Example_10 How many people who joined the ESL were born before 1800?

SELECT family_name, first_names, birth_year
FROM person
WHERE esl_join_year NOTNULL AND birth_year < 1800;




-- Example 11 Combine Last and first names into a single column

SELECT (first_names || " " || family_name) AS full_name, 
		birth_year
FROM person;




-- Example 12 get data from person table for any specific year

SELECT id, esl_join_year, esl_left_year
FROM person
WHERE 1845 BETWEEN esl_join_year AND esl_left_year;

-- Example 13 get all records for one family

SELECT *
FROM person
WHERE family_name IS "Campbell";

-- Example 14 get all records from person table

SELECT id, family_name, first_names, birth_year 
FROM person
WHERE family_name NOTNULL; 




