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