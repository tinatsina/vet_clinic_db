-- Code for creatuing the database

CREATE TABLE animals(
id int primary key not null,
name varchar(50) not null,
date_of_birth date not null,
escape_attempts int not null,
neutered boolean not null,
weight_kg real not null);

/************************************/
/******** DAY TWO ASSIGNMENTS *******/
/************************************/

ALTER TABLE animals ADD species varchar(64);

/************************************/
/******* DAY THREE ASSIGNMENTS ******/
/************************************/

 create table owners (
  id SERIAL,
  full_name varchar(32),
  age int,
  PRIMARY KEY (id)
);

create table species (
	id SERIAL,
	name varchar(32),
	PRIMARY KEY (id)
);

alter table animals
add column species_id int references species(id)
on delete cascade;
select * from animals;

alter table animals
add column owner_id int references owners(id)
on delete cascade;
select * from animals;

