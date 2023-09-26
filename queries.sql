/*Queries that provide answers to the questions FROM all projects.*/

SELECT * FROM animals WHERE name like '%mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered is true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name like 'Agumon' or name like 'Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered is true;
SELECT * FROM animals WHERE not name='Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/******************************************************************/
/********************** QUERIES FROM DAY TWO **********************/
/******************************************************************/

-- Query 1
BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

-- Query 2
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is null;
COMMIT;
SELECT * FROM animals;

-- Query 3
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Query 4
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2020-01-01'::date;
savepoint first_deletion;
UPDATE animals SET weight_kg = (weight_kg*-1);
ROLLBACK to savepoint first_deletion;
UPDATE animals SET weight_kg = (weight_kg*-1) WHERE weight_kg < 0;
COMMIT;

-- Query 5

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, sum(escape_attempts) FROM animals GROUP BY neutered;

-- Query 6
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2020-12-31' GROUP BY species;

/******************************************************************/
/********************** QUERIES FROM DAY THREE ********************/
/******************************************************************/

select name from animals
inner join owners
on animals.owner_id = owners.id
where owners.full_name like 'Melody Pond%';

select animals.name from animals
inner join species
on animals.species_id = species.id
where species_id = 2;

select full_name,animals.name from owners
left join animals
on owners.id = animals.owner_id;

select species.name, count(animals.name)
from animals inner join species on animals.species_id = species.id
group by species.name;

select animals.name from animals
inner join owners on animals.owner_id = owners.id
where escape_attempts = 0
and owners.full_name like '%Dean Winchester';

select animals.name from animals
inner join owners on animals.owner_id = owners.id
where species_id = 1
and owners.full_name like '%Jennifer Orwell';

select owners.full_name from owners
left join animals on owners.id = animals.owner_id
group by owners.full_name
order by count(owners.full_name)
desc limit 1;

/************************************************************/
/**************** QUERIES FROM DAY THREE ********************/
/************************************************************/

select animals.name from animals 
inner join visits on animals.id = visits.animals_id 
where visits.vets_id = 1 
order by visits.date_of_visit 
asc limit 1;

select count(animals.name) from animals
inner join visits on animals.id = visits.animals_id
where vets_id = 3;

SELECT vets.name, specialization.species_id FROM vets 
left join specialization on vets.id = specialization.vets_id;

select name from animals
inner join visits on animals.id = visits.animals_id
where date_of_visit > '2020-04-01'
and date_of_visit < '2020-08-30'
and visits.vets_id = 3;

select animals.name from animals
inner join visits on animals.id = visits.animals_id
group by animals.name
order by count(*)
desc limit 1;

select animals.name from animals
inner join visits on animals.id = visits.animals_id
where visits.vets_id =2
and visits.date_of_visit =(select min(date_of_visit) from visits where visits.vets_id = 2);

SELECT animals.name, visits.vets_id, visits.date_of_visit
FROM animals INNER JOIN visits ON animals.id = visits.animals_id
WHERE visits.date_of_visit = (SELECT MAX(date_of_visit) FROM visits);

select
animals.name,
visits.vets_id,
visits.date_of_visit
from animals inner join visits on animals.id = visits.animals_id
where visits.date_of_visit = (select max(date_of_visit) from visits);

select count(visits.animals_id) from visits
inner join vets on visits.vets_id = vets.id
inner join animals on animals.id = visits.animals_id
inner join specialization on specialization.species_id = vets.id
where specialization.species_id != animals.species_id;

select animals.species_id, count (*)
from animals inner join visits on animals.id = visits.animals_id
where visits.vets_id = 2
group by animals.species_id
order by count(*) desc limit 1;

