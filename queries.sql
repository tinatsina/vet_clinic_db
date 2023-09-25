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
