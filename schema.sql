/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id integer NOT NULL,
	name varchar(32),
	date_of_birth date,
	escape_attempts integer,
	neutered boolean,
	weight_kg decimal,
	PRIMARY KEY (id)
);

ALTER TABLE animals
ADD species varchar(32);

CREATE TABLE owners
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    full_name text NOT NULL,
    age integer,
    PRIMARY KEY (id)
);

CREATE TABLE species
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    name text,
    PRIMARY KEY (id)
);

ALTER TABLE animals DROP COLUMN IF EXISTS species;
ALTER TABLE animals ADD COLUMN species_id bigint;
ALTER TABLE animals ADD CONSTRAINT fk_species
FOREIGN KEY ( species_id )REFERENCES species(id)
ON DELETE CASCADE;
ALTER TABLE animals ADD COLUMN owners_id bigint;
ALTER TABLE animals ADD CONSTRAINT fk_owners
FOREIGN KEY ( owners_id )REFERENCES owners(id)
ON DELETE CASCADE;

CREATE TABLE vets
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    name text,
    age integer,
    date_of_graduation date,
    PRIMARY KEY (id)
);

CREATE TABLE specializations
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    species_id bigint,
    vets_id bigint,
    CONSTRAINT fk_species
    FOREIGN KEY ( species_id )REFERENCES species(id)
    ON DELETE CASCADE,
	CONSTRAINT fk_vets
    FOREIGN KEY ( vets_id )REFERENCES vets(id)
    ON DELETE CASCADE,
    PRIMARY KEY (id)
);

CREATE TABLE visits
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    animals_id bigint,
    vets_id bigint,
    CONSTRAINT fk_animals
    FOREIGN KEY ( animals_id )REFERENCES animals(id)
    ON DELETE CASCADE,
	CONSTRAINT fk_vets
    FOREIGN KEY ( vets_id )REFERENCES vets(id)
    ON DELETE CASCADE,
    PRIMARY KEY (id)
);

ALTER TABLE visits ADD COLUMN visits_date date;