--Use this script to convert all blank data items to NULL. m2m tables are not included because they are only bridging tables.

UPDATE person
SET id = NULL
WHERE id = '';

UPDATE person
SET family_name = NULL
WHERE family_name = '';

UPDATE person
SET first_names = NULL
WHERE first_names = '';

UPDATE person
SET title_id = NULL
WHERE title_id = '';

UPDATE person
SET gender_id = NULL
WHERE gender_id = '';

UPDATE person
SET birth_year = NULL
WHERE birth_year = '';

UPDATE person
SET death_year = NULL
WHERE death_year = '';

UPDATE person
SET esl_join_year = NULL
WHERE esl_join_year = '';

UPDATE person
SET esl_left_year = NULL
WHERE esl_left_year = '';

UPDATE person
SET asl_join_year = NULL
WHERE asl_join_year = '';

UPDATE person
SET asl_left_year = NULL
WHERE asl_left_year = '';

UPDATE person
SET ai_join_year = NULL
WHERE ai_join_year = '';

UPDATE person
SET ai_left_year = NULL
WHERE ai_left_year = '';

UPDATE person
SET aps_join_year = NULL
WHERE aps_join_year = '';

UPDATE person
SET aps_left_year = NULL
WHERE aps_left_year = '';

UPDATE person
SET las_join_year = NULL
WHERE las_join_year = '';

UPDATE person
SET las_left_year = NULL
WHERE las_left_year = '';

UPDATE person
SET notes = NULL
WHERE notes = '';

UPDATE address
SET id = NULL
WHERE id = '';

UPDATE address
SET house_name = NULL
WHERE house_name = '';


UPDATE address
SET street = NULL
WHERE street = '';


UPDATE address
SET town = NULL
WHERE town = '';


UPDATE address
SET city = NULL
WHERE city = '';

UPDATE address
SET country = NULL
WHERE country = '';


UPDATE address
SET county = NULL
WHERE county = '';


UPDATE address
SET notes = NULL
WHERE notes = '';

UPDATE club
SET id = NULL
WHERE id = '';


UPDATE club
SET name = NULL
WHERE name = '';


UPDATE club
SET notes = NULL
WHERE notes = '';


UPDATE location
SET id = NULL
WHERE id = '';


UPDATE location
SET name = NULL
WHERE name = '';


UPDATE location
SET notes = NULL
WHERE notes = '';


UPDATE marriage
SET id = NULL
WHERE id = '';


UPDATE marriage
SET wife_id = NULL
WHERE wife_id = '';


UPDATE marriage
SET husband_id = NULL
WHERE husband_id = '';


UPDATE marriage
SET year_start = NULL
WHERE year_start = '';


UPDATE marriage
SET year_end = NULL
WHERE year_end = '';


UPDATE marriage
SET notes = NULL
WHERE notes = '';


UPDATE occupation
SET id = NULL
WHERE id = '';


UPDATE occupation
SET name = NULL
WHERE name = '';


UPDATE occupation
SET notes = NULL
WHERE notes = '';


UPDATE religion
SET id = NULL
WHERE id = '';


UPDATE religion
SET name = NULL
WHERE name = '';


UPDATE religion
SET notes = NULL
WHERE notes = '';


UPDATE sl_address_type
SET id = NULL
WHERE id = '';


UPDATE sl_address_type
SET name = NULL
WHERE name = '';


UPDATE sl_address_type
SET notes = NULL
WHERE notes = '';


UPDATE sl_gender
SET id = NULL
WHERE id = '';


UPDATE sl_gender
SET name = NULL
WHERE name = '';


UPDATE sl_gender
SET notes = NULL
WHERE notes = '';


UPDATE sl_title
SET id = NULL
WHERE id = '';


UPDATE sl_title
SET name = NULL
WHERE name = '';


UPDATE sl_title
SET notes = NULL
WHERE notes = '';


UPDATE society
SET id = NULL
WHERE id = '';


UPDATE society
SET name = NULL
WHERE name = '';

UPDATE society
SET notes = NULL
WHERE notes = '';


UPDATE suffix
SET id = NULL
WHERE id = '';


UPDATE suffix
SET name = NULL
WHERE name = '';


UPDATE suffix
SET notes = NULL
WHERE notes = '';
