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