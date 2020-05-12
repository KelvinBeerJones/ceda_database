
-- Enable foreign key support
PRAGMA foreign_keys = ON;

-- Delete null values from tables
delete from club where name IS NULL;
delete from occupation where name IS NULL;
delete from location where name IS NULL;
delete from society where name IS NULL;
delete from suffix where name IS NULL;
delete from sl_title where name IS NULL;