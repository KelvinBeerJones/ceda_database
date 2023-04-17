-- Changes to m2m_person_religion table from QFHS data on relationships which identified persons who are not Quaker

-- Start = 649 Quakers - 6 Not Quaker - 50 duplicates = 593 Quakers in the database after this exercise (check)

-- 6 persons are not Quaker (but they remain as persons):

-- Delete duplicate records (The datebase holds undirected relationships) 
-- and so a record where Jack is related to John is not required if there is another record: John is related to Jack)

-- 585 Null records were present in the m2m_person_religion table 

--post exercise stats:

SELECT count(*) FROM person;
--answer = 3094 (was 3095, then minus William allen, see last code block)

SELECT count(*) FROM m2m_person_address;
--answer = 0 (no change)

SELECT count(*) FROM m2m_person_ceda;
--answer = 3983 (was 3982)

SELECT count(*) FROM m2m_person_club;
--answer = 323 (was 360, 37 missing)

SELECT count(*) FROM m2m_person_location;
--answer = 2061 (was 2261, 200 missing)

SELECT count(*) FROM m2m_person_occupation;
--answer = 1883 (was 2126, 243 missing)

SELECT count(*) FROM m2m_person_person;
--answer = 2093 (was 2112, 19 missing)

SELECT count(*) FROM m2m_person_religion;
--answer = 593 (no change)

SELECT count(*) FROM m2m_person_society;
--answer = 1238 (Was 1387, 149 missing)

SELECT count(*) FROM m2m_person_suffix;
--answer = 1461 (no change)


-- Delete NULL records
DELETE
FROM m2m_person_religion
WHERE religion_id IS NULL;


--DELETE duplicate records

DELETE 
FROM m2m_person_person
WHERE person1_id >= person2_id
	AND
	EXISTS (
			SELECT 1
			FROM m2m_person_person t2
      		WHERE t2.person1_id AND	t2.person2_id
            );

           
           
DELETE
FROM m2m_person_occupation 
WHERE id= 1246;


DELETE
FROM m2m_person_occupation 
WHERE id= 1247;
           
           
DELETE
FROM m2m_person_club 
WHERE id = 261;
           
     
           
 DELETE 
 FROM m2m_person_society  
 WHERE id = 1321;
           
           
 DELETE 
 FROM m2m_person_society
 Where id = 883;


--DELETE non Quakers
    
DELETE  
FROM m2m_person_religion
WHERE person_id = 2330
OR person_id = 2695
OR person_id = 2426
OR person_id = 2439
OR person_id = 2451
OR person_id = 2484;

--There are 50 duplicate persons who are assigned as Quakers, they must first be deleted from the m2m_person_religion table:

DELETE 
FROM m2m_person_religion
WHERE person_id = 2267
OR person_id = 2269
OR person_id = 2278
OR person_id = 2556
OR person_id = 2279
OR person_id = 2281
OR person_id = 2283
OR person_id = 2284
OR person_id = 2564
OR person_id = 2566
OR person_id = 2570
OR person_id = 2297
OR person_id = 2308
OR person_id = 2319
OR person_id = 2320
OR person_id = 2323
OR person_id = 2328
OR person_id = 2343
OR person_id = 2671
OR person_id = 2678
OR person_id = 2681
OR person_id = 2682
OR person_id = 2531
OR person_id = 2379
OR person_id = 2723
OR person_id = 2725
OR person_id = 2405
OR person_id = 2731
OR person_id = 2422
OR person_id = 2756
OR person_id = 2455
OR person_id = 2456
OR person_id = 2822
OR person_id = 2477
OR person_id = 2848
OR person_id = 2851
OR person_id = 2852
OR person_id = 2487
OR person_id = 2855
OR person_id = 777
OR person_id = 2272
OR person_id = 2537
OR person_id = 2539
OR person_id = 2666
OR person_id = 2287
OR person_id = 2436
OR person_id = 2609
OR person_id = 2655
OR person_id = 2703
OR person_id = 2533;

-- Once the m2m dependency has been removed, all of the 50 duplicate persons can be removed from the database altogether by delete from the person table:

-- There are 3145 persons - 50 = 3095 when this exercise is complete (check)

DELETE
FROM person
WHERE id = 2267
OR id = 2269
OR id = 2278
OR id = 2556
OR id = 2279
OR id = 2281
OR id = 2283
OR id = 2284
OR id = 2564
OR id = 2566
OR id = 2570
OR id = 2297
OR id = 2308
OR id = 2319
OR id = 2320
OR id = 2323
OR id = 2328
OR id = 2343
OR id = 2671
OR id = 2678
OR id = 2681
OR id = 2682
OR id = 2531
OR id = 2379
OR id = 2723
OR id = 2725
OR id = 2405
OR id = 2731
OR id = 2422
OR id = 2756
OR id = 2455
OR id = 2456
OR id = 2822
OR id = 2477
OR id = 2848
OR id = 2851
OR id = 2852
OR id = 2487
OR id = 2855
OR id = 777
OR id = 2272
OR id = 2537
OR id = 2539
OR id = 2666
OR id = 2287
OR id = 2436
OR id = 2609
OR id = 2655
OR id = 2703
OR id = 2533;

--checks

SELECT count(*) FROM m2m_person_religion;


DELETE 
FROM person
WHERE id = 2350
OR id = 2674;

--delete duplicate Quakers missed out above (50 + 2 = 52)
DELETE 
FROM m2m_person_religion
WHERE person_id = 2350
OR person_id = 2674;

--Delete 52 duplicate Quakers from all other m2m tables.
--m2m_person_address
--m2m_person_ceda
--m2m_person_club
--m2m_person_location
--m2m_person_occupation
--m2m_person_society
--m2m_person_suffix

--copy each of the above to lines into FROM in this DELETE and run for each m2m table

DELETE
FROM m2m_person_address
WHERE person_id = 2267
OR person_id = 2269
OR person_id = 2278
OR person_id = 2556
OR person_id = 2279
OR person_id = 2281
OR person_id = 2283
OR person_id = 2284
OR person_id = 2564
OR person_id = 2566
OR person_id = 2570
OR person_id = 2297
OR person_id = 2308
OR person_id = 2319
OR person_id = 2320
OR person_id = 2323
OR person_id = 2328
OR person_id = 2343
OR person_id = 2350
OR person_id = 2671
OR person_id = 2674
OR person_id = 2678
OR person_id = 2681
OR person_id = 2682
OR person_id = 2531
OR person_id = 2379
OR person_id = 2723
OR person_id = 2725
OR person_id = 2405
OR person_id = 2731
OR person_id = 2422
OR person_id = 2756
OR person_id = 2455
OR person_id = 2456
OR person_id = 2822
OR person_id = 2477
OR person_id = 2848
OR person_id = 2851
OR person_id = 2852
OR person_id = 2487
OR person_id = 2855
OR person_id = 777
OR person_id = 2272
OR person_id = 2537
OR person_id = 2539
OR person_id = 2666
OR person_id = 2287
OR person_id = 2436
OR person_id = 2609
OR person_id = 2655
OR person_id = 2703
OR person_id = 2533;

--delete records from m2m tables were person no longer exists

--m2m_person_ceda (3982 - 88 = 3894)
--m2m_person_club (360 - 36 = 324)
--m2m_person_location (2261 - 200 = 2061)
--m2m_person_occupation (2126 -241 = 1885)
--m2m_person_person (2112 - 7 (person2_id) = 2105)
--m2m_person_religion (593)
--m2m_person_society (1387 - 147 = 1240)
--m2m_person_suffix (1461 - 110 = 1351)


DELETE
FROM m2m_person_ceda
WHERE m2m_person_ceda.person_id NOT IN
    (SELECT id 
     FROM person);


DELETE
FROM m2m_person_club
WHERE m2m_person_club.person_id NOT IN
    (SELECT id 
     FROM person);    
    
DELETE
FROM m2m_person_location
WHERE m2m_person_location.person_id NOT IN
    (SELECT id 
     FROM person);  
    
    
DELETE
FROM m2m_person_occupation
WHERE m2m_person_occupation.person_id NOT IN
    (SELECT id 
     FROM person);     

DELETE
FROM m2m_person_person
WHERE m2m_person_person.person1_id NOT IN
    (SELECT id 
     FROM person);  
    
DELETE 
FROM m2m_person_person
WHERE m2m_person_person.person2_id NOT IN
    (SELECT id 
     FROM person);    
    
    
DELETE
FROM m2m_person_religion
WHERE m2m_person_religion.person_id NOT IN
    (SELECT id 
     FROM person);  
    
DELETE
FROM m2m_person_society
WHERE m2m_person_society.person_id NOT IN
    (SELECT id 
     FROM person);  
    
DELETE
FROM m2m_person_suffix 
WHERE m2m_person_suffix .person_id NOT IN
    (SELECT id 
     FROM person);  

-- delete 6 duplicate records in m2m_person1_person2 table
    
--check
    
DELETE
FROM person 
WHERE family_name = "Fox" AND first_names = "Thomas";
    
    
DELETE
FROM m2m_person_person  
WHERE person1_id = 2345 AND person2_id = 2660;
    
-- person1 2563 person 2 2763 delete person1_person2 id = 227  
-- person1 2618 person 2 2620 delete person1_person2 id = 3081
-- person1 2623 person 2 2625 delete person1_person2 id = 3116 
-- person1 2558 person 2 2771 delete person1_person2 id = 185
-- person1 2438 person 2 2787 delete person1_person2 id = 2330
-- person1 2345 person 2 2660 delete person1_person2 id = 1260

DELETE
FROM m2m_person_person
WHERE id = 227 OR id = 3081 OR id = 3116 OR id = 185 OR id = 2330 OR id = 1260;

-- delete person 28 William Allen from m2m_person_ceda record id 2925. He is not Quaker and cannot to in the QCA.
-- taken from old script 2021_08_25

DELETE
FROM m2m_person_ceda
WHERE m2m_person_ceda.id = 2925;

SELECT *
FROM person
WHERE family_name = 'Allen'; 

UPDATE person 
SET first_names = 'William (Capt.)'
WHERE id = 28;

