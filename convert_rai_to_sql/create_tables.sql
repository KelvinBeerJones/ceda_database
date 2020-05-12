--This VSC script is used to build code for the SQL database which will then be populated from spreadsheet C:\Users\kelvi\Documents\University of Birmingham\UoB DataShare Folder\Data\RAI\5 Project Primary Data\SQL RAI Data.xlsx The resulting SQL database will become the project database. 

-- The primary key generated in the person table will become the unique identifier that comprises an authority index for the project. 

-- Subsequent datasets acquired from other donors will be grafted into the project database by the addition of new columns for each authority index primary key.

-- Each section of this script takes the form - drop any pre-existing version of the table; create a new version of the table; allocate FOREIGN keys.

-- Prerequisite tables appear first in the script because they generate those tables which need to be in place before 'persons' can be generated. for example - the 'person' table build will allocate 'title' and 'gender' to be FOREIGN keys and so the tables the FOREIGN keys point to must be in place before 'person' can be run. 

--The central table holds the unique characteristics of the people who will each become the nodes in later graph data apps. This central table is called 'person'. The object is to here create a unique record for each person, describe their unique characteristics.

-- The 'persons' table incudes unique biographical data and the dates each person joined and left one or more of the five CEDA organisations that bound the scope of the project (the members of the CEDA are the people this study has selected for analysis - infrequently this will include family and associates who are themselves not members of these organisations but whose social connectivity must be captured in later analysis of the CEDA)

-- After 'persons' the script shows each of the tables of social connections that each person may beong to. Any person can belong to any number. These tables take the form, m2m in the title (to indicate that the table mas many to many relationships - any person can be a member of any entity). 
 
-- One male and one female person can form a marriage each marriage has a defined duration. Each person can also become a child of any one marriage.  


--title
DROP TABLE IF EXISTS 'sl_title';
CREATE TABLE sl_title (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (255),
    notes TEXT
);

-- gender
DROP TABLE IF EXISTS 'sl_gender';
CREATE TABLE sl_gender (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (255),
    notes TEXT
);

-- address type (e.g. home, work, college, overseas posting etc.)
DROP TABLE IF EXISTS 'sl_address_type';
CREATE TABLE sl_address_type (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (255),
    notes TEXT
);

-- person  !!! Note, I replaced ',' with '_' at las,join_year = las_join_year
DROP TABLE IF EXISTS 'person';
CREATE TABLE person (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
    family_name VARCHAR (255),
    first_names VARCHAR (255),
    title_id INTEGER,     
    gender_id INTEGER,
    birth_year INTEGER,
    death_year INTEGER,
    esl_join_year INTEGER,
    esl_left_year INTEGER,
    asl_join_year INTEGER,
    asl_left_year INTEGER,
    ai_join_year INTEGER,
    ai_left_year INTEGER,
    aps_join_year INTEGER,
    aps_left_year INTEGER,
    las_join_year INTEGER,
    las_left_year INTEGER,
    notes text,
     
    FOREIGN KEY (title_id) REFERENCES sl_title (id) ON DELETE SET NULL
    FOREIGN KEY (gender_id) REFERENCES sl_gender (id) ON DELETE RESTRICT
);

--address
DROP TABLE IF EXISTS 'address';
CREATE TABLE address (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    house_name VARCHAR(255),
    street VARCHAR(255),
    town VARCHAR(255),
    city VARCHAR(255),
    county VARCHAR(255),
    country VARCHAR(255),
    notes TEXT
);

DROP TABLE IF EXISTS 'm2m_person_address';
CREATE TABLE m2m_person_address (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    address_id INTEGER,
    sl_address_type_id INTEGER,
    
FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (address_id) REFERENCES address (id) ON DELETE CASCADE
FOREIGN KEY (sl_address_type_id) REFERENCES sl_address_type (id) ON DELETE SET NULL
);

-- marriage
DROP TABLE IF EXISTS 'marriage';
CREATE TABLE marriage (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    wife_id INTEGER,
    husband_id INTEGER,
    year_start INTEGER,
    year_end INTEGER,
    notes TEXT,
    
FOREIGN KEY (wife_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (husband_id) REFERENCES person (id) ON DELETE CASCADE
);

-- marriage_child
DROP TABLE IF EXISTS 'm2m_marriage_child';
CREATE TABLE m2m_marriage_child (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    marriage_id INTEGER,
    child_id INTEGER,
    notes TEXT,
    
FOREIGN KEY (marriage_id) REFERENCES marriage (id) ON DELETE CASCADE
FOREIGN KEY (child_id) REFERENCES person (id) ON DELETE CASCADE
);

--location
DROP TABLE IF EXISTS 'location';
CREATE TABLE location (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    notes TEXT
);

DROP TABLE IF EXISTS 'm2m_person_location';
CREATE TABLE m2m_person_location (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    location_id INTEGER,
    
FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (location_id) REFERENCES location (id) ON DELETE CASCADE
);

--suffix
DROP TABLE IF EXISTS 'suffix';
CREATE TABLE suffix (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    notes TEXT
);

DROP TABLE IF EXISTS 'm2m_person_suffix';
CREATE TABLE m2m_person_suffix (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    suffix_id INTEGER,
    
FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (suffix_id) REFERENCES suffix (id) ON DELETE CASCADE
);

-- religion
DROP TABLE IF EXISTS 'religion';
CREATE TABLE religion (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR (255),
    notes TEXT
);

DROP TABLE IF EXISTS 'm2m_person_religion';
CREATE TABLE m2m_person_religion (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    religion_id INTEGER,
    
FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (religion_id) REFERENCES religion (id) ON DELETE CASCADE
);

--occupation
DROP TABLE IF EXISTS 'occupation';
CREATE TABLE occupation (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    notes TEXT
);

DROP TABLE IF EXISTS 'm2m_person_occupation';
CREATE TABLE m2m_person_occupation (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    occupation_id INTEGER,
    
FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (occupation_id) REFERENCES occupation (id) ON DELETE CASCADE
);

--club
DROP TABLE IF EXISTS 'club';
CREATE TABLE club (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    notes TEXT
);

DROP TABLE IF EXISTS 'm2m_person_club';
CREATE TABLE m2m_person_club (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    club_id INTEGER,
    
FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (club_id) REFERENCES club (id) ON DELETE CASCADE
);

--society
DROP TABLE IF EXISTS 'society';
CREATE TABLE society (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(255),
    notes TEXT
);

DROP TABLE IF EXISTS 'm2m_person_society';
CREATE TABLE m2m_person_society (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    person_id INTEGER,
    society_id INTEGER,
    
FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE
FOREIGN KEY (society_id) REFERENCES society (id) ON DELETE CASCADE
);

