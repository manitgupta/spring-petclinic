CREATE SEQUENCE IF NOT EXISTS vets_seq OPTIONS (sequence_kind = 'bit_reversed_positive');
CREATE TABLE IF NOT EXISTS vets (
  id INT64 DEFAULT (GET_NEXT_SEQUENCE_VALUE(SEQUENCE vets_seq)),
  first_name STRING(30),
  last_name STRING(30),
) PRIMARY KEY (id);
CREATE INDEX IF NOT EXISTS vets_last_name ON vets(last_name);

CREATE SEQUENCE IF NOT EXISTS specialties_seq OPTIONS (sequence_kind = 'bit_reversed_positive');
CREATE TABLE IF NOT EXISTS specialties (
  id INT64 DEFAULT (GET_NEXT_SEQUENCE_VALUE(SEQUENCE specialties_seq)),
  name STRING(80),
) PRIMARY KEY (id);
CREATE INDEX IF NOT EXISTS specialties_name ON specialties(name);

CREATE TABLE IF NOT EXISTS vet_specialties (
  vet_id INT64 NOT NULL,
  specialty_id INT64 NOT NULL,
  CONSTRAINT fk_vet_specialties_vets FOREIGN KEY (vet_id) REFERENCES vets (id),
  CONSTRAINT fk_vet_specialties_specialties FOREIGN KEY (specialty_id) REFERENCES specialties (id),
) PRIMARY KEY (vet_id, specialty_id);

CREATE SEQUENCE IF NOT EXISTS types_seq OPTIONS (sequence_kind = 'bit_reversed_positive');
CREATE TABLE IF NOT EXISTS types (
  id INT64 DEFAULT (GET_NEXT_SEQUENCE_VALUE(SEQUENCE types_seq)),
  name STRING(80),
) PRIMARY KEY (id);
CREATE INDEX IF NOT EXISTS types_name ON types(name);

CREATE SEQUENCE IF NOT EXISTS owners_seq OPTIONS (sequence_kind = 'bit_reversed_positive');
CREATE TABLE IF NOT EXISTS owners (
  id INT64 DEFAULT (GET_NEXT_SEQUENCE_VALUE(SEQUENCE owners_seq)),
  first_name STRING(30),
  last_name STRING(30),
  address STRING(255),
  city STRING(80),
  telephone STRING(20),
) PRIMARY KEY (id);
CREATE INDEX IF NOT EXISTS owners_last_name ON owners(last_name);

CREATE SEQUENCE IF NOT EXISTS pets_seq OPTIONS (sequence_kind = 'bit_reversed_positive');
CREATE TABLE IF NOT EXISTS pets (
  id INT64 DEFAULT (GET_NEXT_SEQUENCE_VALUE(SEQUENCE pets_seq)),
  name STRING(30),
  birth_date DATE,
  type_id INT64 NOT NULL,
  owner_id INT64,
  CONSTRAINT fk_pets_owners FOREIGN KEY (owner_id) REFERENCES owners (id),
  CONSTRAINT fk_pets_types FOREIGN KEY (type_id) REFERENCES types (id),
) PRIMARY KEY (id);
CREATE INDEX IF NOT EXISTS pets_name ON pets(name);

CREATE SEQUENCE IF NOT EXISTS visits_seq OPTIONS (sequence_kind = 'bit_reversed_positive');
CREATE TABLE IF NOT EXISTS visits (
  id INT64 DEFAULT (GET_NEXT_SEQUENCE_VALUE(SEQUENCE visits_seq)),
  pet_id INT64,
  visit_date DATE,
  description STRING(255),
  CONSTRAINT fk_visits_pets FOREIGN KEY (pet_id) REFERENCES pets (id),
) PRIMARY KEY (id);
