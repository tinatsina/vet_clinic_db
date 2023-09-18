-- Code for creatuing the database

CREATE TABLE animals(
id int primary key not null,
name varchar(50) not null,
date_of_birth date not null,
escape_attempts int not null,
neutered boolean not null,
weight_kg real not null);
