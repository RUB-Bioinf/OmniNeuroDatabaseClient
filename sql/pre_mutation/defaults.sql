create table assay
(
    id   serial not null
        constraint assay_pkey
            primary key,
    name text   not null
);

create unique index assay_id_uindex
    on assay (id);

create unique index assay_name_uindex
    on assay (name);

INSERT INTO public.assay (id, name)
VALUES (0, 'NPC1ab');
INSERT INTO public.assay (id, name)
VALUES (1, 'NPC1a');
create table cell_type
(
    id   serial not null
        constraint cell_type_pkey
            primary key,
    name text   not null
);

create unique index cell_type_id_uindex
    on cell_type (id);

create unique index cell_type_name_uindex
    on cell_type (name);

INSERT INTO public.cell_type (id, name)
VALUES (0, 'primary');
create table comment
(
    id            serial  not null
        constraint comment_pkey
            primary key,
    text          text,
    experiment_id integer not null
        constraint comment_experiment_id_fk
            references experiment
);

create unique index comment_id_uindex
    on comment (id);


create table compound
(
    id     serial not null
        constraint compound_pkey
            primary key,
    name   text   not null,
    cas_no text
);

create unique index compound_id_uindex
    on compound (id);

create unique index compound_cas_no_uindex
    on compound (cas_no);

INSERT INTO public.compound (id, name, cas_no)
VALUES (0, 'Paraquat dichloride hydrate', '75365-73-0');
INSERT INTO public.compound (id, name, cas_no)
VALUES (4, 'Domoic acid', '14277-97-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (5, '1-Methyl-4-phenylpyridinium iodide', '36913-39-0');
INSERT INTO public.compound (id, name, cas_no)
VALUES (1, 'Triethyltin bromide', '2767-54-6');
INSERT INTO public.compound (id, name, cas_no)
VALUES (7, 'Terbutaline hemisulfate', '23031-32-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (8, 'Parathion-methyl', '298-00-0');
INSERT INTO public.compound (id, name, cas_no)
VALUES (9, '(-)-Nicotine', '54-11-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (10, 'Chlorpyrifos-oxon', '5598-15-2');
INSERT INTO public.compound (id, name, cas_no)
VALUES (11, 'Pymetrozine', '123312-89-0');
INSERT INTO public.compound (id, name, cas_no)
VALUES (15, 'beta-Cyfluthrin', '68359-37-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (16, 'Trichlorfon', '52-68-6');
INSERT INTO public.compound (id, name, cas_no)
VALUES (17, 'Thiamezhoxam', '153719-23-4');
INSERT INTO public.compound (id, name, cas_no)
VALUES (18, 'Tri-o-tolyl phosphate', '78-30-8');
INSERT INTO public.compound (id, name, cas_no)
VALUES (19, 'Acetamiprid', '160430-64-8');
INSERT INTO public.compound (id, name, cas_no)
VALUES (20, 'Imidacloprid', '138261-41-3');
INSERT INTO public.compound (id, name, cas_no)
VALUES (21, 'Flufenacet', '142459-58-3');
INSERT INTO public.compound (id, name, cas_no)
VALUES (22, 'Dimethoate', '60-51-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (23, 'Clothianidin', '210880-92-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (24, 'Tris(2-Chloroisopropyl)phosphate', '13674-84-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (25, 'Tris(1,3-dichloro-2-propyl) phosphate', '13674-87-8');
INSERT INTO public.compound (id, name, cas_no)
VALUES (26, 'Manganese(II) chloride', '7773-01-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (27, 'Lead(II) acetate trihydrate', '6080-56-4');
INSERT INTO public.compound (id, name, cas_no)
VALUES (28, 'PBDE 99', '60348-60-9');
INSERT INTO public.compound (id, name, cas_no)
VALUES (30, 'Diazinon', '333-41-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (31, 'Methimazole', '60-56-0');
INSERT INTO public.compound (id, name, cas_no)
VALUES (32, 'Carbaryl', '63-25-2');
INSERT INTO public.compound (id, name, cas_no)
VALUES (33, 'Deltamethrin', '52918-63-5');
INSERT INTO public.compound (id, name, cas_no)
VALUES (34, 'Acrylamide', '79-06-1');
INSERT INTO public.compound (id, name, cas_no)
VALUES (35, 'Dinotefuran', '165252-70-0');
INSERT INTO public.compound (id, name, cas_no)
VALUES (36, 'Aldicarb', '116-06-3');
INSERT INTO public.compound (id, name, cas_no)
VALUES (37, 'Heptadecafluorooctanesulfonic acid potassium salt', '2795-39-3');
INSERT INTO public.compound (id, name, cas_no)
VALUES (38, 'Chlorpyrifos-methyl', '5598-13-0');

create table concentration
(
    id         serial            not null
        constraint concentration_pkey
            primary key,
    value      double precision  not null,
    control_id integer default 0 not null
        constraint concentration_control_id_fk
            references control
);

create unique index concentration_id_uindex
    on concentration (id);


create table control
(
    id      serial not null
        constraint control_pkey
            primary key,
    name    text   not null,
    acronym text
);

create unique index control_id_uindex
    on control (id);

create unique index control_name_uindex
    on control (name);

INSERT INTO public.control (id, name, acronym)
VALUES (1, 'Solvent control (SC)', 'SC');
INSERT INTO public.control (id, name, acronym)
VALUES (2, 'Positive control (PC)', 'PC');
INSERT INTO public.control (id, name, acronym)
VALUES (3, 'Background (BG)', 'BG');
INSERT INTO public.control (id, name, acronym)
VALUES (4, 'Lysis control (LC)', 'LC');
INSERT INTO public.control (id, name, acronym)
VALUES (0, 'No control', null);
INSERT INTO public.control (id, name, acronym)
VALUES (5, 'Background BrdU (BGBrdU)', 'BGBrdU');
create table country
(
    id   serial not null
        constraint country_pkey
            primary key,
    name text   not null,
    iso  text
);

create unique index country_id_uindex
    on country (id);

INSERT INTO public.country (id, name, iso)
VALUES (2, 'Germany', 'DE');
INSERT INTO public.country (id, name, iso)
VALUES (3, 'Italy', 'IT');
INSERT INTO public.country (id, name, iso)
VALUES (4, 'United States of America', 'US');
INSERT INTO public.country (id, name, iso)
VALUES (5, 'Switzerland', 'CH');
create table department
(
    id         serial  not null
        constraint source_lab_pkey
            primary key,
    name       text    not null,
    country_id integer not null
        constraint source_lab_country_id_fk
            references country
);

alter table department
    owner to nilfoe;

create unique index source_lab_id_uindex
    on department (id);

INSERT INTO public.department (id, name, country_id)
VALUES (1, 'IUF', 2);
create table endpoint
(
    id   serial not null
        constraint endpoint_pkey
            primary key,
    name text   not null
);

create unique index endpoint_id_uindex
    on endpoint (id);

create unique index endpoint_name_uindex
    on endpoint (name);

INSERT INTO public.endpoint (id, name)
VALUES (1, 'Proliferation (BrdU)');
INSERT INTO public.endpoint (id, name)
VALUES (2, 'Proliferation Area');
INSERT INTO public.endpoint (id, name)
VALUES (3, 'Cytotoxicity 120h');
INSERT INTO public.endpoint (id, name)
VALUES (4, 'Viabillity 120h');
INSERT INTO public.endpoint (id, name)
VALUES (5, 'Viabillity 120h prol');
INSERT INTO public.endpoint (id, name)
VALUES (6, 'Cytotoxicity 48h prol');
create table experiment
(
    id              serial  not null
        constraint experiment_pkey
            primary key,
    timestamp       bigint,
    name            text    not null,
    project_id      integer not null
        constraint experiment_project_id_fk
            references project,
    workgroup_id    integer
        constraint experiment_workgroup_id_fk
            references workgroup,
    individual_id   integer not null
        constraint experiment_individual_id_fk
            references individual,
    compound_id     integer not null
        constraint experiment_compound_id_fk
            references compound,
    cell_type_id    integer not null
        constraint experiment_cell_type_id_fk
            references cell_type,
    assay_id        integer not null
        constraint experiment_assay_id_fk
            references assay,
    plate_format_id integer
        constraint experiment_plate_format_id_fk
            references plate_format
);

alter table experiment
    owner to nilfoe;

create unique index experiment_id_uindex
    on experiment (id);


create table individual
(
    id         serial            not null
        constraint individual_pkey
            primary key,
    name       text,
    sex_id     integer default 0 not null
        constraint individual_sex_id_fk
            references sex,
    species_id integer           not null
        constraint individual_species_id_fk
            references species
);

create unique index individual_id_uindex
    on individual (id);

INSERT INTO public.individual (id, name, sex_id, species_id)
VALUES (32, '385.0', 0, 0);
INSERT INTO public.individual (id, name, sex_id, species_id)
VALUES (33, '062', 0, 0);
INSERT INTO public.individual (id, name, sex_id, species_id)
VALUES (34, '', 0, 0);
INSERT INTO public.individual (id, name, sex_id, species_id)
VALUES (35, '745.0', 0, 0);
INSERT INTO public.individual (id, name, sex_id, species_id)
VALUES (36, '398.0', 0, 0);
create table initiator
(
    id         serial not null
        constraint initiator_pkey
            primary key,
    name       text   not null,
    country_id integer
        constraint initiator_country_id_fk
            references country
);

create unique index initiator_id_uindex
    on initiator (id);

INSERT INTO public.initiator (id, name, country_id)
VALUES (0, 'EFSA', 3);
create table leader
(
    id   serial not null,
    name text   not null
);

alter table leader
    owner to nilfoe;

create unique index leader_id_uindex
    on leader (id);

create unique index leader_name_uindex
    on leader (name);

INSERT INTO public.leader (id, name)
VALUES (1, 'Prof. Dr. Ellen Fritsche');
create table outlier_type
(
    id   serial not null
        constraint outlier_type_pk
            primary key,
    name text   not null
);

alter table outlier_type
    owner to nilfoe;

create unique index outlier_type_id_uindex
    on outlier_type (id);

create unique index outlier_type_name_uindex
    on outlier_type (name);

INSERT INTO public.outlier_type (id, name)
VALUES (1, 'Flagged Outlyer');
INSERT INTO public.outlier_type (id, name)
VALUES (2, 'Flagged Plausible');
INSERT INTO public.outlier_type (id, name)
VALUES (3, 'Confirmed Outlier');
INSERT INTO public.outlier_type (id, name)
VALUES (4, 'Confirmed Plausible');
INSERT INTO public.outlier_type (id, name)
VALUES (0, 'Unchecked');
create table plate_format
(
    id   serial not null
        constraint plate_format_pkey
            primary key,
    name text   not null
);

create unique index plate_format_id_uindex
    on plate_format (id);

create unique index plate_format_name_uindex
    on plate_format (name);

INSERT INTO public.plate_format (id, name)
VALUES (0, '96 well');
create table project
(
    id           serial not null
        constraint project_pkey
            primary key,
    name         text   not null,
    initiator_id integer
        constraint project_initiator_id_fk
            references initiator
);

create unique index project_id_uindex
    on project (id);

INSERT INTO public.project (id, name, initiator_id)
VALUES (0, 'EFSA DNT2', 0);
create table response
(
    id               serial           not null
        constraint measurement_pkey
            primary key,
    value            double precision not null,
    timestamp        integer          not null,
    endpoint_id      integer          not null
        constraint response_endpoint_id_fk
            references endpoint,
    concentration_id integer
        constraint response_concentration_id_fk
            references concentration,
    experiment_id    integer          not null
        constraint response_experiment_id_fk
            references experiment,
    outlier_type_id  integer          not null
        constraint responce_outlier_type_id_fk
            references outlier_type
);

alter table response
    owner to nilfoe;

create unique index measurement_id_uindex
    on response (id);


create table sex
(
    id    serial not null
        constraint sex_pkey
            primary key,
    label text   not null
);

create unique index sex_id_uindex
    on sex (id);

create unique index sex_label_uindex
    on sex (label);

INSERT INTO public.sex (id, label)
VALUES (0, 'undefined');
INSERT INTO public.sex (id, label)
VALUES (1, 'male');
INSERT INTO public.sex (id, label)
VALUES (2, 'female');
create table species
(
    id   serial not null
        constraint species_pkey
            primary key,
    name text   not null
);

create unique index species_id_uindex
    on species (id);

create unique index species_name_uindex
    on species (name);

INSERT INTO public.species (id, name)
VALUES (0, 'human');
INSERT INTO public.species (id, name)
VALUES (1, 'mouse');
INSERT INTO public.species (id, name)
VALUES (2, 'rat');
create table workgroup
(
    id            serial  not null
        constraint workgroup_pk
            primary key,
    name          text    not null,
    leader_id     integer not null
        constraint workgroup_leader_id_fk
            references leader (id),
    department_id integer not null
        constraint workgroup_department_id_fk
            references department
);

alter table workgroup
    owner to nilfoe;

create unique index workgroup_id_uindex
    on workgroup (id);

INSERT INTO public.workgroup (id, name, leader_id, department_id)
VALUES (2, 'AG Fritsche', 1, 1);