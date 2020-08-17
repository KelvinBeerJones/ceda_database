--Example scripts

--select * 
--from person
--where family_name LIKE 'B%' AND title = 'Prof.';

--select *
--from m2m_person_religion mmpr 
--where person_id in (select id from person where family_name LIKE 'B%');

-- Example, in place of SELECT line type, update person [or DELETE]

--set title = 'Prof'
--where title = 'Prof.'


-- read in csv
-- create a blank string variable sql_output = ""
-- loop through the data
-- append to sql_output for each row, e.g. sql_outut += "UPDATE data dnkdjf"
-- once finished looping, write sql_output to file


-- data cleaning July 2020

-- Delete 51 records from m2m_person_ceda that have a ceda start_date > 1871 becauase this is the ends date of the project. 
DELETE
FROM m2m_person_ceda
WHERE first_year > 1871;

-- The records to delete from the person table are in CSV \DataShare\data\data-cleaning\supplementary_cleaning\July 2020\delete_ceda_records_past_1871
DELETE
FROM person
WHERE ID = 583 
	OR ID = 1496 
	OR ID = 69 
	OR ID = 75 
	OR ID = 76 
	OR ID = 143 
	OR ID = 193 
	OR ID = 269 
	OR ID = 315 
	OR ID = 357 
	OR ID = 360 
	OR ID = 388
	OR ID = 456 
	OR ID = 528 
	OR ID = 550 
	OR ID = 737 
	OR ID = 877 
	OR ID = 889 
	OR ID = 972 
	OR ID = 1023 
	OR ID = 1032 
	OR ID = 1094 
	OR ID = 1116 
	OR ID = 1146 
	OR ID = 1191
	OR ID = 1199 
	OR ID = 1378 
	OR ID = 1644 
	OR ID = 1653 
	OR ID = 1803 
	OR ID = 2031 
	OR ID = 2107 
	OR ID = 2119 
	OR ID = 891 
	OR ID = 1787 
	OR ID = 360 
	OR ID = 1633 
	OR ID = 2247
	OR ID = 673 
	OR ID = 2079 
	OR ID = 1623 
	OR ID = 1956 
	OR ID = 2241 
	OR ID = 809 
	OR ID = 1576 
	OR ID = 1133 
	OR ID = 1436 
	OR ID = 1906 
	OR ID = 820 
	OR ID = 429 
	OR ID = 633 
	OR ID = 1688
	OR ID = 2080;


--test
SELECT *
FROM m2m_person_ceda mmpc 
WHERE first_year > 1871;

-- Make  ceda last-year = first_year where last_year is not known (183 records). This allows the person to appear in the known start_year and does not show them in any subsequent years.
UPDATE m2m_person_ceda
SET last_year = first_year
WHERE last_year IS NULL AND first_year IS NOT NULL;

--This update has been run, test. 
SELECT * FROM m2m_person_ceda
WHERE last_year IS NULL AND first_year IS NOT NULL;

-- Make  ceda last_year = 1871 where last_year > 1871 (1451 records). This is because the Project end date is 1871
UPDATE m2m_person_ceda
SET last_year = '1871'
WHERE last_year > '1871';

--test
SELECT *
FROM m2m_person_ceda mmpc
WHERE last_year > '1871';

-- standardise first_names unknown to 'x' (Join first_names to family_name results in NULL if first_names = NULL (129 records) 
--and 4 records have X where x has also been used by donor.
UPDATE person
SET first_names = 'x'
WHERE first_names ISNULL;

-- This update has been run, test
SELECT id, family_name, first_names 
From person p 
Where first_names ISNULL;

SELECT id, family_name, first_names 
From person p 
Where family_name ISNULL;

SELECT id, family_name, first_names 
From person p 
Where family_name = 'X';

--These duplicate entries in m2m_person_ceda were resolved and duplicates removed
--person_id	23, 151, 403, 419, 732, 831, 853, 967, 1290, 1873 

--Test (only 1 entry per ceda per person allowed)
SELECT *
FROM m2m_person_ceda 
WHERE person_id =23;

--Find out name of person and investigate duplicates, identify rogue record to be deleted.
SELECT *
FROM person p 
WHERE id = 23;

SELECT *
FROM m2m_person_ceda 
WHERE id = 2927;

--William Aldam died 1848, delete duplicate ceda entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2927; 

--James Bell died 1862, delete duplicate ceda entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2917;

--Henry Christie in APS twice delete 1864 entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2906;

-- William Clay in APS twice, delete 1855 entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2904;

--Charles Henry Fox in APS twice, delete 1885 entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2810;

--Charles Grey in APS twice, delete 1898 entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2811;

--John Gurney in APS twice, delete 1867 entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2812;

--Thomas Hodgkin in APS twice, delete 1862 entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2813;

--Edward Martin in APS twice, delete 1847 entry
DELETE
FROM m2m_person_ceda 
WHERE id = 2815;

--Andrew Smith in APS twice, delete 1872 wntry
DELETE
FROM m2m_person_ceda 
WHERE id = 2816;

-- test for records with the same name in m2m_person_ceda. 
select person_id, ceda_id 
from m2m_person_ceda mmpc 
group by person_id, ceda_id 
having count(*) > 1;

--delete 220 persons not in ceda, outside the cope of the project
DELETE
FROM person
WHERE person.id NOT IN
    (SELECT m2m_person_ceda.person_id 
     FROM m2m_person_ceda);
    
--test
SELECT *
    FROM person
WHERE person.id NOT IN
    (SELECT m2m_person_ceda.person_id 
     FROM m2m_person_ceda);


-- remove unwanted blank space from end of field
update person 
set first_names = substr(first_names, 1, length(first_names) - 1)
where first_names like '% ';

update person 
set family_name = substr(family_name, 1, length(family_name) - 1)
where family_name like '% ';

update person 
set family_name = substr(family_name, 1, length(family_name) - 1)
where family_name like '% ';

--test
select substr(first_names, 1, length(first_names) - 1), first_names from person p
where first_names like '% ';

select substr(family_name, 1, length(family_name) - 1), family_name from person p
where family_name like '% ';

select substr(family_name, 1, length(family_name) - 1), family_name from person p
where family_name like '% ';

-- resolve duplicate entries in m2m_person_ceda (24 records, 3 deletions and 21 add (2 or mrs) to last_name)

-- find duplicates in m2m_person_ceda

select count(*), name from vw_person_gephi vpg 
group by name
having count(*) > 1;

--2673	Alexander Grace	APS	1863	1867
--2674	Alexander Grace	APS	1862	1862

--find duplicates in person

SELECT *
FROM person p 
WHERE first_names = 'Alexander' AND family_name = 'Grace';

--Delete m2m_person_ceda and person_id 2674 and update person_id 2673

Update m2m_person_ceda
Set first_year = 1862
Where person_id = 2673;

DELETE 
from m2m_person_ceda 
where person_id = 2674;

DELETE
FROM person 
WHERE id = 2674;

--2349	Ann Gibson	APS	1860	1863
--2350	Ann Gibson	APS	1865	1865

--Delete m2m_person_ceda and person_id 2350and update person_id 2349

SELECT *
FROM person p 
WHERE first_names = 'Ann' AND family_name = 'Gibson';

Update m2m_person_ceda
Set last_year = 1865
Where person_id = 2349;

DELETE 
from m2m_person_ceda 
where person_id = 2350;

DELETE 
FROM person 
WHERE id = 2350;

--1714	Alexander Robertson	ASL	1864	1868
--1715	Alexander Robertson	ASL	1867	1870

--1117	Richard King	ESL	1844	1871
--1117	Richard King	ASL	1866	1871
--1117	Richard King	AI	1866	1871
--1117	Richard King	APS	1838	1871
--3153	Richard King	APS	1838	1850

--Delete m2m_person_ceda and person_id 3358 and update person_id 2484

SELECT *
FROM person p 
WHERE first_names = 'Richard' AND family_name = 'King';

DELETE 
from m2m_person_ceda 
where person_id = 3153;

DELETE
FROM person 
WHERE id = 3153;

--2484	x Thompson	APS	1857	1861
--3358	x Thompson	APS	1862	1862

--Delete m2m_person_ceda and person_id 3358 and update person_id 2484

SELECT *
FROM person p 
WHERE first_names = 'x' AND family_name = 'Thompson';

Update person
Set family_name = 'Thompson Mrs'
Where id = 3358;

-- Make person_id 1715 = 'Robertson (2)'


Update person
Set family_name = 'Robertson (2)'
Where id = 1715;

--2395	Benjamin Jowett	APS	1852	1867
--2723	Benjamin Jowett	APS	1851	1859

SELECT *
FROM person p 
WHERE first_names = 'Benjamin' AND family_name = 'Jowett';

Update person
Set family_name = 'Jowett (2)'
Where id = 2395;

--2427	Edward Priestman	APS	1866	1866
--3252	Edward Priestman	APS	1854	1867

SELECT *
FROM person p 
WHERE first_names = 'Edward' AND family_name = 'Priestman';

Update person
Set family_name = 'Priestman (2)'
Where id = 2427;

--2385	Elizabeth Howard	APS	1860	1867
--2386	Elizabeth Howard	APS	1851	1865

SELECT *
FROM person p 
WHERE first_names = 'Elizabeth' AND family_name = 'Howard';

Update person
Set family_name = 'Howard (2)'
Where id = 2385;

--2476	F Taylor	APS	1861	1861
--2477	F Taylor	APS	1865	1865

SELECT *
FROM person p 
WHERE first_names = 'F' AND family_name = 'Taylor';

Update person
Set family_name = 'Taylor (2)'
Where id = 2477;

--410	James Clark	ESL	1844	1870
--2623	James Clark	APS	1860	1866

SELECT *
FROM person p 
WHERE first_names = 'James' AND family_name = 'Clark';

Update person
Set family_name = 'Clark (2)'
Where id = 2623;

--88	John Bailey	ASL	1863	1863
--87	John Bailey	APS	1860	1860

SELECT *
FROM person p 
WHERE first_names = 'John' AND family_name = 'Bailey';

Update person
Set family_name = 'Bailey (2)'
Where id = 88;

--152	John Bell	ESL	1852	1855
--152	John Bell	APS	1838	1855
--2523	John Bell	APS	1838	1840
--2523	John Bell	QCA	1837	1839

SELECT *
FROM person p 
WHERE first_names = 'John' AND family_name = 'Bell';

Update person
Set family_name = 'Bell (2)'
Where id = 152;

--2690	John Harford	APS	1838	1851
--3096	John Harford	APS	1852	1855

SELECT *
FROM person p 
WHERE first_names = 'John' AND family_name = 'Harford';

Update person
Set family_name = 'Harford (2)'
Where id = 3096;

--1179	John Lee	ASL	1865	1866
--2403	John Lee	APS	1851	1865

SELECT *
FROM person p 
WHERE first_names = 'John' AND family_name = 'Lee';

Update person
Set family_name = 'Lee (2)'
Where id = 1179;

--2471	Joseph Sturge	APS	1838	1866
--2513	Joseph Sturge	QCA	1842	1847

SELECT *
FROM person p 
WHERE first_names = 'Joseph' AND family_name = 'Sturge';

Update person
Set family_name = 'Sturge (Mrs)'
Where id = 2471;

--3407	Levi Wood	APS	1860	1866
--3408	Levi Wood	APS	1862	1862

SELECT *
FROM person p 
WHERE first_names = 'Levi' AND family_name = 'Wood';

Update person
Set family_name = 'Wood (2)'
Where id = 3408;

--1198	Malcolm Lewin	ESL	1850	1869
--3162	Malcolm Lewin	APS	1856	1867

SELECT *
FROM person p 
WHERE first_names = 'Malcolm' AND family_name = 'Lewin';

Update person
Set family_name = 'Lewin (2)'
Where id = 3162;

--2397	Robert Jowett	APS	1852	1862
--2725	Robert Jowett	APS	1851	1859

SELECT *
FROM person p 
WHERE first_names = 'Robert' AND family_name = 'Jowett';

Update person
Set family_name = 'Jowett (2)'
Where id = 2397;

--2898	S Allen	APS	1855	1863
--2899	S Allen	APS	1860	1867

SELECT *
FROM person p 
WHERE first_names = 'S' AND family_name = 'Allen';

Update person
Set family_name = 'Allen (2)'
Where id = 2899;

--2539	Thomas Jun Norton	QCA	1837	1839
--2756	Thomas Jun Norton	APS	1839	1840

SELECT *
FROM person p 
WHERE first_names = 'Thomas' AND family_name = 'Norton';

Update person
Set family_name = 'Norton (2)'
Where id = 2756;

--2027	W Thompson	ESL	1866	1866
--2483	W Thompson	APS	1860	1862

SELECT *
FROM person p 
WHERE first_names = 'W' AND family_name = 'Thompson';

Update person
Set family_name = 'Thompson (2)'
Where id = 2027;

--2287	x Beaumont	APS	1862	1862
--2929	x Beaumont	APS	1847	1849

SELECT *
FROM person p 
WHERE first_names = 'x' AND family_name = 'Beaumont';

Update person
Set family_name = 'Beaumont (2)'
Where id = 2287;

--408	x Clark	ESL	1843	1848
--2983	x Clark	APS	1860	1863

SELECT *
FROM person p 
WHERE first_names = 'x' AND family_name = 'Clark';

Update person
Set family_name = 'Clark (2)'
Where id = 2983;

--3414	x Wright	APS	1860	1861
--3415	x Wright	APS	1839	1850

SELECT *
FROM person p 
WHERE first_names = 'x' AND family_name = 'Wright';

Update person
Set family_name = 'Wright (2)'
Where id = 3414;


select count(*), "Source" 
from vw_ceda_membership_gephi vcmg 
group by "Source" 
having count(*) > 1
order by count(*) desc;

select * from vw_ceda_membership_gephi;

select count(*), name from vw_person_gephi vpg 
group by name
having count(*) > 1;





