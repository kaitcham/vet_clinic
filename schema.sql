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