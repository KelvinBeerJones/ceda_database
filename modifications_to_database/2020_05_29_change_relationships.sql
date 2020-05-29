

-- code to delete no longer required tables

DROP TABLE if exists marriage;

DROP TABLE if exists m2m_marriage_child;

--code to build nnew tables for relationships between persi=ons

CREATE table if not exists sl_person_relationship_types(
id integer primary key,
name varchar (255),
notes text);

insert into sl_person_relationship_types (id, name) 
values (1, "parent/child"), (2, "siblings"), (3, "marriage");


CREATE table if not exists m2m_person_person(
id integer primary key,
relationship_type_id integer,
person1_id integer,
person2_id integer,

foreign key (relationship_type_id) references sl_person_relationship_types (id),
foreign key (person1_id) references person (id),
foreign key (person2_id) references person (id));

CREATE table if not exists sl_person_data_source(
id integer primary key,
name varchar (255),
notes text);

insert into sl_person_data_source (id, name) 
values (1, "RAI"), (2, "QCA"), (3, "APS");