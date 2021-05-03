-- Changes to m2m_person_religion table from QFHS data on relationships which identified persons who are not Quaker

-- Start = 649 Quakers - 6 Not Quaker - 50 duplicates = 593 Quakers in the database after this exercise (check)

-- 6 persons are not Quaker (but they remain as persons):

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

-- Delete duplicate records (The datbase is undirected) 
--and a record where Jack is related to John is not required if there is another record: John is related to Jack)

--DELETE
--FROM m2m_person_person
--WHERE EXISTS (SELECT 1 FROM m2m_person_person t2
              WHERE t2.name2 = m2m_person_person.person1_id AND
                    t2.name1 = m2m_person_person.person1_2d) AND
      name1 >= name2;

