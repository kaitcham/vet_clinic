/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name ='Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT species FROM animals;
COMMIT;
SELECT species FROM animals;
BEGIN;
TRUNCATE animals;
ROLLBACK;
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 1;
COMMIT;
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT Min(weight_kg) FROM animals;
SELECT MAX(weight_kg) FROM animals;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

-- What animals belong to Melody Pond?
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

--How many animals are there per species?
SELECT COUNT(animals.id), species.name FROM  animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.
SELECT animals.name, owners.full_name, FROM animals JOIN owners ON animals.owners_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

--Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) AS numberOfAnimals FROM owners JOIN animals ON owners.id = animals.owners_id
GROUP BY owners.full_name ORDER BY numberOfAnimals DESC LIMIT 1;