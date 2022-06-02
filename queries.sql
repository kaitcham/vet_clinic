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

--Who was the last animal seen by William Tatcher?
SELECT animals.name, visits_date FROM visits
JOIN animals ON animals_id = animals.id
JOIN vets ON vets_id = vets.id
WHERE vets.name = 'William Tatcher' ORDER BY visits_date DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT(animals_id) FROM visits
JOIN vets ON vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM specializations
JOIN species ON specializations.species_id = species.id
FULL JOIN vets ON specializations.vets_id = vets.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON  visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND visits_date BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?
SELECT animals.name, COUNT(animals_id) AS numberOfVisits FROM visits
JOIN animals ON animals_id = animals.id
GROUP BY animals.name
ORDER BY numberOfVisits DESC LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT animals.name,visits_date FROM visits
JOIN animals ON animals_id = animals.id
JOIN vets ON vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits_date LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit
SELECT animals.name, vets.name, visits_date FROM visits
JOIN animals ON animals_id = animals.id
JOIN vets ON vets_id = vets.id
ORDER BY visits_date DESC LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, COUNT(vets.name) AS num_of_visits
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vets_id
JOIN visits
ON vets.id = visits.vets_id
WHERE specializations.species_id IS NULL
GROUP BY vets.name ORDER BY COUNT(vets.name) DESC;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(species.name) AS SpeciesVisit FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN species ON  animals.species_id = species.id
JOIN vets ON  visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name ORDER BY SpeciesVisit DESC LIMIT 1;