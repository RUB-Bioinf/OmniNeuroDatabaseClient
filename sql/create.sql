-- auto-generated definition
CREATE TABLE country
(
  id   SERIAL NOT NULL
    CONSTRAINT country_pkey
    PRIMARY KEY,
  name TEXT   NOT NULL,
  iso  TEXT
);
CREATE UNIQUE INDEX country_id_uindex
  ON country (id);

-- auto-generated definition
CREATE TABLE species
(
  id   SERIAL NOT NULL
    CONSTRAINT species_pkey
    PRIMARY KEY,
  name TEXT   NOT NULL
);
CREATE UNIQUE INDEX species_id_uindex
  ON species (id);
CREATE UNIQUE INDEX species_name_uindex
  ON species (name);

-- auto-generated definition
CREATE TABLE sex
(
  id    SERIAL NOT NULL
    CONSTRAINT sex_pkey
    PRIMARY KEY,
  label TEXT   NOT NULL
);
CREATE UNIQUE INDEX sex_id_uindex
  ON sex (id);
CREATE UNIQUE INDEX sex_label_uindex
  ON sex (label);

-- auto-generated definition
CREATE TABLE comment
(
  id   SERIAL NOT NULL
    CONSTRAINT comment_pkey
    PRIMARY KEY,
  text TEXT
);
CREATE UNIQUE INDEX comment_id_uindex
  ON comment (id);

-- auto-generated definition
CREATE TABLE cell_type
(
  id   SERIAL NOT NULL
    CONSTRAINT cell_type_pkey
    PRIMARY KEY,
  name TEXT   NOT NULL
);
CREATE UNIQUE INDEX cell_type_id_uindex
  ON cell_type (id);
CREATE UNIQUE INDEX cell_type_name_uindex
  ON cell_type (name);

-- auto-generated definition
CREATE TABLE assay
(
  id   SERIAL NOT NULL
    CONSTRAINT assay_pkey
    PRIMARY KEY,
  name TEXT   NOT NULL
);
CREATE UNIQUE INDEX assay_id_uindex
  ON assay (id);
CREATE UNIQUE INDEX assay_name_uindex
  ON assay (name);

-- auto-generated definition
CREATE TABLE control
(
  id      SERIAL NOT NULL
    CONSTRAINT control_pkey
    PRIMARY KEY,
  name    TEXT   NOT NULL,
  ccronym TEXT
);
CREATE UNIQUE INDEX control_id_uindex
  ON control (id);
CREATE UNIQUE INDEX control_name_uindex
  ON control (name);

-- auto-generated definition
CREATE TABLE plate_format
(
  id   SERIAL NOT NULL
    CONSTRAINT plate_format_pkey
    PRIMARY KEY,
  name TEXT   NOT NULL
);
CREATE UNIQUE INDEX plate_format_id_uindex
  ON plate_format (id);
CREATE UNIQUE INDEX plate_format_name_uindex
  ON plate_format (name);

-- auto-generated definition
CREATE TABLE compound
(
  id     SERIAL NOT NULL
    CONSTRAINT compound_pkey
    PRIMARY KEY,
  name   TEXT   NOT NULL,
  cas_no TEXT
);
CREATE UNIQUE INDEX compound_id_uindex
  ON compound (id);

-- auto-generated definition
CREATE TABLE endpoint
(
  id   SERIAL NOT NULL
    CONSTRAINT endpoint_pkey
    PRIMARY KEY,
  name TEXT   NOT NULL
);
CREATE UNIQUE INDEX endpoint_id_uindex
  ON endpoint (id);
CREATE UNIQUE INDEX endpoint_name_uindex
  ON endpoint (name);

-- auto-generated definition
CREATE TABLE initiator
(
  id         SERIAL NOT NULL
    CONSTRAINT initiator_pkey
    PRIMARY KEY,
  name       TEXT   NOT NULL,
  country_id INTEGER
    CONSTRAINT initiator_country_id_fk
    REFERENCES country
);
CREATE UNIQUE INDEX initiator_id_uindex
  ON initiator (id);

-- auto-generated definition
CREATE TABLE project
(
  id           SERIAL NOT NULL
    CONSTRAINT project_pkey
    PRIMARY KEY,
  name         TEXT   NOT NULL,
  initiator_id INTEGER
    CONSTRAINT project_initiator_id_fk
    REFERENCES initiator
);
CREATE UNIQUE INDEX project_id_uindex
  ON project (id);

-- auto-generated definition
CREATE TABLE source_lab
(
  id         SERIAL  NOT NULL
    CONSTRAINT source_lab_pkey
    PRIMARY KEY,
  name       TEXT    NOT NULL,
  country_id INTEGER NOT NULL
    CONSTRAINT source_lab_country_id_fk
    REFERENCES country
);
CREATE UNIQUE INDEX source_lab_id_uindex
  ON source_lab (id);

-- auto-generated definition
CREATE TABLE individual
(
  id         SERIAL            NOT NULL
    CONSTRAINT individual_pkey
    PRIMARY KEY,
  name       TEXT,
  sex_id     INTEGER DEFAULT 0 NOT NULL
    CONSTRAINT individual_sex_id_fk
    REFERENCES sex,
  species_id INTEGER           NOT NULL
    CONSTRAINT individual_species_id_fk
    REFERENCES species
);
CREATE UNIQUE INDEX individual_id_uindex
  ON individual (id);

-- auto-generated definition
CREATE TABLE concentration
(
  id         SERIAL            NOT NULL
    CONSTRAINT concentration_pkey
    PRIMARY KEY,
  value      DOUBLE PRECISION  NOT NULL,
  control_id INTEGER DEFAULT 0 NOT NULL
    CONSTRAINT concentration_control_id_fk
    REFERENCES control
);
CREATE UNIQUE INDEX concentration_id_uindex
  ON concentration (id);

-- auto-generated definition
CREATE TABLE experiment
(
  id              SERIAL  NOT NULL
    CONSTRAINT experiment_pkey
    PRIMARY KEY,
  timestamp       INTEGER,
  name            TEXT    NOT NULL,
  project_id      INTEGER NOT NULL
    CONSTRAINT experiment_project_id_fk
    REFERENCES project,
  lab_id          INTEGER
    CONSTRAINT experiment_source_lab_id_fk
    REFERENCES source_lab,
  individual_id   INTEGER NOT NULL
    CONSTRAINT experiment_individual_id_fk
    REFERENCES individual,
  comment_id      INTEGER
    CONSTRAINT experiment_comment_id_fk
    REFERENCES comment,
  compound_id     INTEGER NOT NULL
    CONSTRAINT experiment_compound_id_fk
    REFERENCES compound,
  cell_type_id    INTEGER NOT NULL
    CONSTRAINT experiment_cell_type_id_fk
    REFERENCES cell_type,
  assay_id        INTEGER NOT NULL
    CONSTRAINT experiment_assay_id_fk
    REFERENCES assay,
  plate_format_id INTEGER
    CONSTRAINT experiment_plate_format_id_fk
    REFERENCES plate_format
);
CREATE UNIQUE INDEX experiment_id_uindex
  ON experiment (id);

-- auto-generated definition
CREATE TABLE measurement
(
  id               SERIAL           NOT NULL
    CONSTRAINT measurement_pkey
    PRIMARY KEY,
  value            DOUBLE PRECISION NOT NULL,
  timestamp        INTEGER          NOT NULL,
  endpoint_id      INTEGER          NOT NULL
    CONSTRAINT measurement_endpoint_id_fk
    REFERENCES endpoint,
  concentration_id INTEGER
    CONSTRAINT measurement_concentration_id_fk
    REFERENCES concentration,
  experiment_id    INTEGER          NOT NULL
    CONSTRAINT measurement_experiment_id_fk
    REFERENCES experiment
);
CREATE UNIQUE INDEX measurement_id_uindex
  ON measurement (id);
