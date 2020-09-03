create table assay
(
    id   serial not null
        constraint assay_pkey
            primary key,
    name text   not null
);

alter table assay
    owner to nilfoe;

create unique index assay_id_uindex
    on assay (id);

create unique index assay_name_uindex
    on assay (name);

INSERT INTO public.assay (id, name)
VALUES (0, 'NPC1ab');
INSERT INTO public.assay (id, name)
VALUES (1, 'NPC1a');
INSERT INTO public.assay (id, name)
VALUES (2, 'NPC2-5');
INSERT INTO public.assay (id, name)
VALUES (3, 'UKN2');
INSERT INTO public.assay (id, name)
VALUES (4, 'UKN5');
INSERT INTO public.assay (id, name)
VALUES (5, 'UKN4');
INSERT INTO public.assay (id, name)
VALUES (6, 'NPC2');
create table cell_line
(
    id   serial not null
        constraint cell_line_pk
            primary key,
    name text   not null
);

alter table cell_line
    owner to nilfoe;

create unique index cell_line_id_uindex
    on cell_line (id);

create unique index cell_line_name_uindex
    on cell_line (name);

INSERT INTO public.cell_line (id, name)
VALUES (48, 'IPS11');
create table cell_type
(
    id   serial not null
        constraint cell_type_pkey
            primary key,
    name text   not null
);

alter table cell_type
    owner to nilfoe;

create unique index cell_type_id_uindex
    on cell_type (id);

create unique index cell_type_name_uindex
    on cell_type (name);

INSERT INTO public.cell_type (id, name)
VALUES (0, 'primary');
INSERT INTO public.cell_type (id, name)
VALUES (4, 'iPSCs');
INSERT INTO public.cell_type (id, name)
VALUES (5, 'iPSC derived 3D');
INSERT INTO public.cell_type (id, name)
VALUES (6, 'iPSC derived');
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

alter table comment
    owner to nilfoe;

create unique index comment_id_uindex
    on comment (id);


create table compound
(
    id               serial                         not null
        constraint compound_pkey
            primary key,
    name             text                           not null,
    cas_no           text,
    abbreviation     text                           not null,
    blinded          boolean          default false not null,
    molecular_weight double precision default 0
);

alter table compound
    owner to nilfoe;

create unique index compound_id_uindex
    on compound (id);

create unique index compound_cas_no_uindex
    on compound (cas_no);

create unique index compound_abbreviation_uindex
    on compound (abbreviation);

create unique index compound_name_uindex
    on compound (name);

INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (861, 'Sodium valproate', '1069-66-5', 'VPA', false, 166.19);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (33, 'Deltamethrin', '52918-63-5', 'DM', false, 505.2);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (821, 'Glycerol', '56-81-5', 'GCR', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (17, 'Thiamethoxam', '153719-23-4', 'TMX', false, 291.71);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (187, 'Malathion', '121-75-5', 'MLT', false, 330.36);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (16, 'Trichlorfon', '52-68-6', 'TCF', false, 257.44);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (28, 'PBDE 99', '60348-60-9', 'BDE', false, 564.69);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (185, 'Endosulfan sulfate', '1031-07-8', 'ESS', false, 442.92);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (883, 'Acetaminophen', '103-90-2', 'AAN', false, 151.1);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (822, 'Cymoxanil', '57966-95-7', 'CMX', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (823, 'Disulfoton', '298-04-4', 'DST', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (824, 'Octamethylcyclotetrasiloxane', '556-67-2', 'OCT', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (825, 'Spirodiclofen', '148477-71-8', 'SDF', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (826, 'D-Glucitol', '50-70-4', 'DGT', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (827, 'Fenamidone', '161326-34-7', 'FNM', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (828, 'Metaflumizone', '139968-49-3', 'MFM', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (830, 'Chlorpheniramine maleate', '113-92-8', 'CPAM', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (831, 'Methamidophos', '10265-92-6', 'MMP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (832, 'all-trans-Retinoic acid', '302-79-4', 'RA', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (833, 'Dexamethasone', '50-02-2', 'DEX', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (834, 'Famotidine', '76824-35-6', 'FMT', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (835, 'Tri-allate', '2303-17-5', 'TAL', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (836, 'Hexachlorophene', '70-30-4', 'HCP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (837, 'Bisphenol A', '80-05-7', 'BPA', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (838, 'Penicillin VK', '132-98-9', 'PEN', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (839, 'tau-Fluvalinate', '102851-06-9', 'TFV', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (840, '2-Ethylhexyl diphenyl phosphate', '1241-94-7', 'EDP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (841, 'Boscalid', '188425-85-6', 'BCL', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (842, 'Sodium benzoate', '532-32-1', 'SBZ', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (844, 'Metoprolol', '51384-51-1', 'MPL', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (845, '5,5-Diphenylhydantoin', '57-41-0', 'DPH', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (846, 'Chlorpyrifos', '2921-88-2', 'CPF', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (847, 'Ibuprofen', '15687-27-1', 'IBU', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (848, 'Maneb', '12427-38-2', 'MAB', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (849, 'tert-Butylphenyl diphenyl phosphate', '56803-37-3', 'BDP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (850, 'Cadmium chloride', '10108-64-2', 'CCL', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (851, 'Fipronil', '120068-37-3', 'FPN', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (852, 'Diethylene glycol', '111-46-6', 'DEG', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (853, 'Sodium chlorite', '7758-19-2', 'SCL', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (854, 'Mepiquat chloride', '24307-26-4', 'MQC', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (855, 'Doxylamine succinate', '562-10-7', 'DXS', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (856, 'Cypermethrin', '52315-07-8', 'CPM', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (857, 'Acephate', '30560-19-1', 'ACP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (858, 'Acibenzolar-S-methyl', '135158-54-2', 'ABM', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (859, 'Warfarin', '81-81-2', 'WAR', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (860, 'D-Mannitol', '69-65-8', 'MAN', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (862, 'Aspirin', '50-78-2', 'ASP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (863, 'Haloperidol', '52-86-8', 'HPD', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (864, 'Etofenprox', '80844-07-1', 'ETP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (865, 'Mancozeb', '8018-01-7', 'MNZ', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (866, 'Emamectin benzoate', '155569-91-8', 'EMB', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (867, 'Indoxacarb', '173584-44-6', 'IXC', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (868, 'Azinphos-methyl', '86-50-0', 'APM', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (869, 'Amoxicillin', '26787-78-0', 'AMX', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (870, 'Metformin', '657-24-9', 'MTF', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (871, 'Flubendiamide', '272451-65-7', 'FBD', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (872, 'Captopril', '62571-86-2', 'CAP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (873, 'Tributyltin chloride', '1461-22-9', 'TTC', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (874, 'Sodium L-glutamate hydrate', '6106-04-3', 'GLU', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (875, 'Chlorpromazine hydrochloride', '69-09-0', 'CPH', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (876, 'Topramezone', '210631-68-8', 'TPZ', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (877, 'Endosulfan', '115-29-7', 'EDS', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (32, 'Carbaryl', '63-25-2', 'CBR', false, 201.22);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (881, 'Buspirone', '36505-84-7', 'BSP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (882, 'Tebuconazole', '107534-96-3', 'TBN', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (22, 'Dimethoate', '60-51-5', 'DMT', false, 229.26);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (31, 'Methimazole', '60-56-0', 'MTM', false, 114.17);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3499, 'KG-501', '18228-17-6', 'KG-501', false, 377.72);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (20, 'Imidacloprid', '138261-41-3', 'ICP', false, 255.66);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2411, 'Penthiopyrad', '183675-82-3', 'PP', false, 359.41);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (39, 'Sodium (meta)arsenite', '7784-46-5', 'SA', false, 129.91);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (4, 'Domoic acid', '14277-97-5', 'DA', false, 311.33);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3500, 'Trimethyltin chloride', '1066-45-1', 'Kon-29', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1, 'Triethyltin bromide', '2767-54-6', 'TETB', false, 285.8);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1745, 'Butylated hydroxyanisole', '25013-16-5', 'Kon-04', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2018, 'Cytarabine hydrochloride', '69-74-9', 'Kon-02', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (30, 'Diazinon', '333-41-5', 'DZ', false, 304.35);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (23, 'Clothianidin', '210880-92-5', 'CTN', false, 249.68);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (21, 'Flufenacet', '142459-58-3', 'FFA', false, 363.33);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1744, 'S-Bioallethrin', '28434-00-6', 'Kon-03', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (35, 'Dinotefuran', '165252-70-0', 'DNF', false, 202.21);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (189, '1-Naphthol', '90-15-3', 'NT', false, 144.17);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2511, 'Reelin', '867021-12-3', 'Reelin', false, 163000);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3498, 'Limonin', '1180-71-8', 'Limonin', false, 470.51);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1757, 'Tetracycline', '60-54-8', 'Kon-18', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2430, 'Prostaglandin E2', '363-24-6', 'PGE2', false, 352.47);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1752, 'Ethylene Thiourea', '96-45-7', 'ETH', false, 102.16);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (36, 'Aldicarb', '116-06-3', 'ADC', false, 190.26);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2414, 'IWP2', '686770-61-6', 'IWP2', false, 466.6);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2429, 'Celecoxib', '169590-42-5', 'Celecoxib', false, 381.37);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1755, 'Methotrexate', '59-05-2', 'Kon-15', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2415, 'CHIR99021', '252917-06-9', 'CHIR99021', false, 501.8);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2436, 'SC79', '305834791', 'SC79', false, 364.78);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2439, 'Colivelin', '867021-83-8', 'Colivelin', false, 2645.13);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2438, 'Pioglitazone', '111025-46-8', 'Pioglitazone', false, 356.44);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2437, 'CP-673451', '343787-29-1', 'CP-673451', false, 417.5);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2433, 'LY294002', '154447-36-6', 'LY294002', false, 307.34);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2435, 'ANA-12', '219766-25-3', 'ANA-12', false, 407.49);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2434, 'SU-5402', '215543-92-3', 'SU-5402', false, 296.32);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2134, 'Perfluorooctanoic acid', '335-67-1', 'PFOA', false, 414.07);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (179, 'Tembotrione', '335104-84-2', 'TBT', false, 440.82);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3641, 'Olaparib', '763113-22-0', 'OLA', false, 434.46);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (27, 'Lead(II) acetate trihydrate', '6080-56-4', 'LAT', false, 379.33);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2512, 'db-cAMP', '16980-89-5', 'db-cAMP', false, 491.37);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (38, 'Chlorpyrifos-methyl', '5598-13-0', 'CPFM', false, 322.53);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1747, 'Allethrin', '584-79-2', 'Kon-07', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3638, 'Temozolomide', '85622-93-1', 'TMZ2', false, 194.1534);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (15, 'Cyfluthrin', '68359-37-5', 'Kon-14', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2408, 'beta-Cyfluthrin', '1820573-27-0', 'BCFT', false, 434.29);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1764, 'Aspartame', '22839-47-0', 'Kon-27', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3642, 'Vandetanib', '443913-73-3', 'VANDE', false, 475.35);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2427, 'Trijodthyronin', '1217676-14-6', 'T3', false, 693.39);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3565, 'Dimethylsulfoxide', '67-68-5', 'DMSO', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1760, 'Fluoxetine hydrochloride', '56296-78-7', 'Kon-22', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (188, 'Malaoxon', '1634-78-2', 'MLO', false, 314.29);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (10, 'Chlorpyrifos-oxon', '5598-15-2', 'CPFO', false, 334.52);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1743, 'Chloramben', '133-90-4', 'Kon-01', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1753, 'Ampicillin', '69-53-4', 'Kon-12', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1758, 'L-Ascorbic acid', '50-81-7', 'Kon-19', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (34, 'Acrylamide', '79-06-1', 'AAM', false, 71.08);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3643, 'Midostaurin', '120685-11-2', 'MIDO', false, 570.64);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1751, 'Sulfisoxazole', '127-69-5', 'Kon-11', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3644, 'Regorafenib', '755037-03-7', 'REGO', false, 482.82);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1759, 'Mifepristone', '84371-65-3', 'Kon-21', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3639, 'Copanlisib', '1032568-63-0', 'COPA', false, 480.52);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1749, 'Cyclophosphamide monohydrate', '6055-19-2', 'Kon-09', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1746, 'Cotinine', '486-56-6', 'Kon-06', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1756, 'Erythromycin', '114-07-8', 'Kon-16', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1742, '5-Azacytidine', '320-67-2', 'Kon-30', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1761, 'Phenol', '108-95-2', 'Kon-24', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1762, 'Triamcinolone', '124-94-7', 'Kon-25', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1741, 'Caffeine', '58-08-2', 'Kon-23', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1765, '6-Aminonicotinamide', '329-89-5', 'Kon-28', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1748, 'Galactosamine hydrochloride', '1772-03-8', 'Kon-08', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1763, 'Tributyltin methacrylate', '2155-70-6', 'Kon-26', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1739, 'Cytarabine', '147-94-4', 'Kon-05', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1754, 'Benomyl', '17804-35-2', 'Kon-13', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1766, 'Selegiline hydrochloride', '14611-52-0', 'Kon-20', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1740, 'alpha-Cypermethrin', '67375-30-8', 'Kon-17', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2428, 'U73122', '112648-68-7', 'U73122', false, 464.64);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (1750, 'Kepone', '143-50-0', 'Kon-10', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2431, 'Everolimus', '159351-69-6', 'Everolimus', false, 958.22);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2432, 'MHY 1485', '326914-06-1', 'MHY1485', false, 387.39);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3635, 'Cisplatin', '1566-27-1', 'CPL', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3636, 'Staurosporin', '62996-74-1', 'STA', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3637, 'PD153035', '183322-45-4', 'EGFRi', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3649, 'Dasatanib', '302962-49-8', 'DASA', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (26, 'Manganese(II) chloride', '7773-01-5', 'MC', false, 125.84);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2509, 'Sodium perchlorate', '7601-89-0', 'SPC', false, 122.44);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2581, 'Alpha-Endosulfan', '959-98-8', 'AES', false, 406.93);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (891, 'Isodecyl diphenyl phosphate', '29761-21-5', 'IDDP', false, 390.45);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (0, 'Paraquat dichloride hydrate', '75365-73-0', 'PQ', false, 257.16);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2718, 'Saccharin', '81-07-2', 'SCR', false, 183.18);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2442, 'NH3', '123-1-1', 'NH3', false, 473.5);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3647, 'Bosutinib', '380843-75-4', 'BOSU', false, 530.45);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2510, 'Rotenone', '83-79-4', 'RTN', false, 394.42);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3646, 'Trametinib', '871700-17-3', 'TRAM', false, 615.39);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (887, 'Triphenylphosphate', '115-86-6', 'TPHP2', false, 326.28);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2652, 'Methylazoxymethanol acetate', '592-62-1', 'MAM', false, 132.12);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2651, 'Methylmercury(II) chloride', '115-09-3', 'MMC', false, 251.08);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2653, 'Sodium Fluoride', '7681-49-4', 'NAF', false, 41.99);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (843, 'Triphenyl phosphates isopropylated', '68937-41-7', 'TPI', false, 452.52);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (879, 'Tris(methylphenyl) phosphate', '1330-78-5', 'TTP', false, 368.36);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3645, 'Dabrafenib', '1195765-45-7', 'DABRA', false, 519.56);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (880, '3,3'',5,5''-Tetrabromobisphenol A', '79-94-7', 'TBBPA', false, 543.88);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3648, 'Paracetamol', '103-90-2 ', 'PCM', false, 151.1);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2444, 'Epithelial growth factor', '123-1-2', 'EGF', false, 6200);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (11, 'Pymetrozine', '123312-89-0', 'PMT', false, 217.23);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2443, 'hPDGF', '123-1-3', 'hPDGF', false, 29500);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (18, 'Tri-o-tolyl phosphate', '78-30-8', 'TOTP', false, 368.36);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2413, 'DAPT', '208255-80-5', 'DAPT', false, 432.46);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (19, 'Acetamiprid', '160430-64-8', 'AAP', false, 222.67);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (190, 'Omethoate', '1113-02-6', 'OMT', false, 213.19);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2410, 'Bis-(2-butoxyethyl)phosphate', '??-??-?', 'BBOEP2', false, 297.31);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (37, 'Heptadecafluorooctanesulfonic acid potassium salt', '2795-39-3', 'PFOSK', false, 538.22);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2135, 'Narciclasine', '29477-83-6', 'NCC1', false, 307.3);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (178, 'Thiacloprid', '111988-49-9', 'TC', false, 252.728);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2582, 'Beta-Cypermethrin', '1224510-29-5', 'BCPM', false, 416.3021);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2508, 'Glufosinate-ammonium', '77182-82-2', 'GFA', false, 198.16);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (5, '1-Methyl-4-phenylpyridinium iodide', '36913-39-0', 'MPP', false, 297.13);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (9, '(-)-Nicotine', '54-11-5', 'NC', false, 162.23);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3484, 'Arsenic trioxide', '1327-53-3', 'ASO3', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3485, 'Sodium arsenate dibasic heptahydrate', '10048-95-0', 'NAAS', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3486, 'Carbamazepine', '298-46-4', 'CARBZ', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3487, 'Cocaine hydrochloride', '53-21-4', 'COC', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3488, 'Heroin hydrochloride monohydrate', '5893-91-4', 'HERO', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3489, 'Lindane', '58-89-9', 'LIND', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3490, 'Manganese (II) sulfate monohydrate', '10034-96-5', 'MNS', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3492, 'Methamphetamine hydrochloride', '51-57-0', 'METH', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (829, 'gamma-Cyhalothrin', '91465-08-6', 'CHT', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2441, 'Brain-derived neurotrophic factor', '218441-99-7', 'BDNF', false, 27000);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3493, 'MPTP1', '28289-54-5', 'MPTP', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3494, 'Morphine hydrochloride trihydrate', '6055-06-7', 'MORPH', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3495, 'PBDE 153', '68631-49-2', 'PBDE153', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3496, 'PCB 180', '35065-29-3', 'PCB180', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3497, 'Toluene', '108-88-3', 'TOL', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3491, '(+/-) MDMA hydrochloride', '64057-70-1', 'MDMA', false, 0);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (885, 'Tris(chloroethyl)phosphate', '115-96-8', 'TCEP2', false, 285.49);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (889, 'Tris(2-butoxyethyl)phosphate', '78-51-3', 'TBOEP2', false, 398.47);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (3640, 'Cabozantinib', '849217-68-1', 'CABO', false, 501.51);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (894, '2,2'',4,4''-Tetrabromodiphenyl ether', '5436-43-1', 'BDE-47', false, 485.79);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2136, 'Bisindolylamaleimide I', '133052-90-1', 'BIS-I', false, 412.491);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (8, 'Parathion-methyl', '298-00-0', 'PTM', false, 263.21);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (25, 'Tris(1,3-dichloro-2-propyl) phosphate', '13674-87-8', 'TDCPP', false, 430.9);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (24, 'Tris(2-Chloroisopropyl)phosphate', '13674-84-5', 'TCPP', false, 327.57);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (7, 'Terbutaline hemisulfate', '23031-32-5', 'TBH', false, 274.32);
INSERT INTO public.compound (id, name, cas_no, abbreviation, blinded, molecular_weight)
VALUES (2133, '(+/-)-Ketamine hydrochloride', '1867-66-9', 'KETA1', false, 274.19);
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

alter table concentration
    owner to nilfoe;

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

alter table control
    owner to nilfoe;

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
INSERT INTO public.control (id, name, acronym)
VALUES (6, 'Narciclasine', 'NARCI');
create table country
(
    id   serial not null
        constraint country_pkey
            primary key,
    name text   not null,
    iso  text
);

alter table country
    owner to nilfoe;

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
    id         serial not null
        constraint source_lab_pkey
            primary key,
    name       text   not null,
    country_id serial not null
        constraint source_lab_country_id_fk
            references country
);

alter table department
    owner to nilfoe;

create unique index source_lab_id_uindex
    on department (id);

INSERT INTO public.department (id, name, country_id)
VALUES (1, 'IUF – Leibniz Research Institute for Environmental Medicine', 2);
INSERT INTO public.department (id, name, country_id)
VALUES (2, 'In vitro toxicology and biomedicine ', 2);
create table detection_method
(
    id   serial not null
        constraint detection_method_pk
            primary key,
    name text   not null
);

alter table detection_method
    owner to nilfoe;

create unique index detection_method_id_uindex
    on detection_method (id);

create unique index detection_method_name_uindex
    on detection_method (name);

INSERT INTO public.detection_method (id, name)
VALUES (2, 'Cellomics');
INSERT INTO public.detection_method (id, name)
VALUES (1, 'Unknown');
INSERT INTO public.detection_method (id, name)
VALUES (4, 'MPR');
INSERT INTO public.detection_method (id, name)
VALUES (5, 'Omnisphero');
INSERT INTO public.detection_method (id, name)
VALUES (6, 'Manual');
create table endpoint
(
    id   serial not null
        constraint endpoint_pkey
            primary key,
    name text   not null
);

alter table endpoint
    owner to nilfoe;

create unique index endpoint_id_uindex
    on endpoint (id);

create unique index endpoint_name_uindex
    on endpoint (name);

INSERT INTO public.endpoint (id, name)
VALUES (1, 'Proliferation (BrdU)');
INSERT INTO public.endpoint (id, name)
VALUES (2, 'Proliferation Area');
INSERT INTO public.endpoint (id, name)
VALUES (6, 'Cytotoxicity of Proliferation');
INSERT INTO public.endpoint (id, name)
VALUES (4, 'Viabillity');
INSERT INTO public.endpoint (id, name)
VALUES (5, 'Viabillity of Proliferation');
INSERT INTO public.endpoint (id, name)
VALUES (3, 'Cytotoxicity');
INSERT INTO public.endpoint (id, name)
VALUES (8, 'Mean Migration Distance all Oligodendrocytes');
INSERT INTO public.endpoint (id, name)
VALUES (14, 'Mean Gradient Nuclei Positions');
INSERT INTO public.endpoint (id, name)
VALUES (15, 'Total Subneuritelength per Nucleus limited');
INSERT INTO public.endpoint (id, name)
VALUES (16, 'Skeleton Neurons');
INSERT INTO public.endpoint (id, name)
VALUES (17, 'Migration');
INSERT INTO public.endpoint (id, name)
VALUES (18, 'Mean Number Branchingpoints limited');
INSERT INTO public.endpoint (id, name)
VALUES (19, 'Number Nuclei');
INSERT INTO public.endpoint (id, name)
VALUES (20, 'Migration Distance');
INSERT INTO public.endpoint (id, name)
VALUES (21, 'Mean Subneurite Count limited');
INSERT INTO public.endpoint (id, name)
VALUES (22, 'Skeleton Oligos');
INSERT INTO public.endpoint (id, name)
VALUES (23, 'Mean Migration Distance all neurons');
INSERT INTO public.endpoint (id, name)
VALUES (24, 'Average Subneuritelength per Nucleus limited');
INSERT INTO public.endpoint (id, name)
VALUES (25, 'Neuronal Density Ring 1');
INSERT INTO public.endpoint (id, name)
VALUES (26, 'Neuronal Density Ring 2');
INSERT INTO public.endpoint (id, name)
VALUES (27, 'Neuronal Density Ring 3');
INSERT INTO public.endpoint (id, name)
VALUES (28, 'Neuronal Density Ring 4');
INSERT INTO public.endpoint (id, name)
VALUES (29, 'Neuronal Density Ring 5');
INSERT INTO public.endpoint (id, name)
VALUES (30, 'Neuronal Density Ring 6');
INSERT INTO public.endpoint (id, name)
VALUES (31, 'Neuronal Density Ring 7');
INSERT INTO public.endpoint (id, name)
VALUES (32, 'Neuronal Density Ring 8');
INSERT INTO public.endpoint (id, name)
VALUES (33, 'Neuronal Density Ring 9');
INSERT INTO public.endpoint (id, name)
VALUES (34, 'Neuronal Density Ring 10');
INSERT INTO public.endpoint (id, name)
VALUES (35, 'Neurite Area');
INSERT INTO public.endpoint (id, name)
VALUES (36, 'Selected Objects');
INSERT INTO public.endpoint (id, name)
VALUES (37, 'Valid Objects');
INSERT INTO public.endpoint (id, name)
VALUES (42, 'Viability UKN2');
INSERT INTO public.endpoint (id, name)
VALUES (43, 'Migration UKN2');
INSERT INTO public.endpoint (id, name)
VALUES (39, 'Neurite Area UKN5');
INSERT INTO public.endpoint (id, name)
VALUES (40, 'Valid Objects UKN4');
INSERT INTO public.endpoint (id, name)
VALUES (38, 'Selected Objects UKN5');
INSERT INTO public.endpoint (id, name)
VALUES (41, 'Selected Objects UKN4');
INSERT INTO public.endpoint (id, name)
VALUES (44, 'Valid Objects UKN5');
INSERT INTO public.endpoint (id, name)
VALUES (46, 'Neurite Area UKN4');
INSERT INTO public.endpoint (id, name)
VALUES (47, 'Percent Mean Migration Distance all neurons');
INSERT INTO public.endpoint (id, name)
VALUES (48, 'Percentage Neurons');
INSERT INTO public.endpoint (id, name)
VALUES (49, 'Percent Mean Migration Distance all Oligodendrocytes');
INSERT INTO public.endpoint (id, name)
VALUES (50, 'Cytotoxicity (NPC1ab)');
INSERT INTO public.endpoint (id, name)
VALUES (51, 'Cytotoxicity (NPC2-5)');
INSERT INTO public.endpoint (id, name)
VALUES (52, 'Viabilty UKN2');
INSERT INTO public.endpoint (id, name)
VALUES (54, 'Mean Neurite Area wo Nuclei');
INSERT INTO public.endpoint (id, name)
VALUES (55, 'Cytotoxicity (NPC2)');
create table experiment
(
    id                    serial           not null
        constraint experiment_pkey
            primary key,
    timestamp             bigint,
    name                  text             not null,
    project_id            integer          not null
        constraint experiment_project_id_fk
            references project,
    workgroup_id          integer
        constraint experiment_workgroup_id_fk
            references workgroup,
    individual_id         integer          not null
        constraint experiment_individual_id_fk
            references individual,
    compound_id           integer          not null
        constraint experiment_compound_id_fk
            references compound,
    cell_type_id          integer          not null
        constraint experiment_cell_type_id_fk
            references cell_type,
    assay_id              integer          not null
        constraint experiment_assay_id_fk
            references assay,
    plate_format_id       integer
        constraint experiment_plate_format_id_fk
            references plate_format,
    solvent_id            integer          not null
        constraint experiment_solvent_id_fk
            references solvent,
    solvent_concentration double precision not null,
    control_plate_id      text             not null,
    mutation_id           integer          not null
        constraint experiment_mutation_id_fk
            references mutation,
    cell_line_id          integer          not null
        constraint experiment_cell_line_id_fk
            references cell_line
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

alter table individual
    owner to nilfoe;

create unique index individual_id_uindex
    on individual (id);


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

alter table initiator
    owner to nilfoe;

create unique index initiator_id_uindex
    on initiator (id);

INSERT INTO public.initiator (id, name, country_id)
VALUES (0, 'EFSA', 3);
INSERT INTO public.initiator (id, name, country_id)
VALUES (1, 'BMBF', 2);
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
INSERT INTO public.leader (id, name)
VALUES (2, 'Marcel Leist');
create table mutation
(
    id   serial not null
        constraint mutation_pk
            primary key,
    name text   not null
);

alter table mutation
    owner to nilfoe;

create unique index mutation_id_uindex
    on mutation (id);

create unique index mutation_name_uindex
    on mutation (name);


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
create table passage
(
    id            serial  not null
        constraint passage_pk
            primary key,
    experiment_id integer not null
        constraint passage_experiment_id_fk
            references experiment,
    timestamp     bigint  not null,
    p             integer not null
);

alter table passage
    owner to nilfoe;

create unique index passage_id_uindex
    on passage (id);


create table plate_format
(
    id   serial not null
        constraint plate_format_pkey
            primary key,
    name text   not null
);

alter table plate_format
    owner to nilfoe;

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

alter table project
    owner to nilfoe;

create unique index project_id_uindex
    on project (id);

INSERT INTO public.project (id, name, initiator_id)
VALUES (0, 'EFSA DNT2', 0);
INSERT INTO public.project (id, name, initiator_id)
VALUES (1, 'EFSA DNT2 signaling', 0);
INSERT INTO public.project (id, name, initiator_id)
VALUES (2, 'VIP+', 1);
create table response
(
    id                  serial           not null
        constraint measurement_pkey
            primary key,
    value               double precision not null,
    timestamp           integer          not null,
    endpoint_id         integer          not null
        constraint response_endpoint_id_fk
            references endpoint,
    concentration_id    integer
        constraint response_concentration_id_fk
            references concentration,
    experiment_id       integer          not null
        constraint response_experiment_id_fk
            references experiment,
    outlier_type_id     integer          not null
        constraint responce_outlier_type_id_fk
            references outlier_type,
    well_id             integer          not null
        constraint response_well_id_fk
            references well,
    detection_method_id integer          not null
        constraint response_detection_method_id_fk
            references detection_method
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

alter table sex
    owner to nilfoe;

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
create table solvent
(
    id   serial not null
        constraint solvent_pk
            primary key,
    name text   not null
);

alter table solvent
    owner to nilfoe;

create unique index solvent_id_uindex
    on solvent (id);

create unique index solvent_name_uindex
    on solvent (name);

INSERT INTO public.solvent (id, name)
VALUES (1, 'DMSO');
INSERT INTO public.solvent (id, name)
VALUES (2, 'H2O');
INSERT INTO public.solvent (id, name)
VALUES (3, 'MEOH');
INSERT INTO public.solvent (id, name)
VALUES (-1, '<Unknown>');
INSERT INTO public.solvent (id, name)
VALUES (4, 'WATER');
INSERT INTO public.solvent (id, name)
VALUES (5, 'ETOH');
INSERT INTO public.solvent (id, name)
VALUES (6, 'BSA/DPBS');
INSERT INTO public.solvent (id, name)
VALUES (7, '20% ETOH IN H2O');
INSERT INTO public.solvent (id, name)
VALUES (8, '4MM HCL IN H2O');
INSERT INTO public.solvent (id, name)
VALUES (9, 'DPBS');
INSERT INTO public.solvent (id, name)
VALUES (10, 'PBS');
INSERT INTO public.solvent (id, name)
VALUES (11, 'B27+HFGF');
INSERT INTO public.solvent (id, name)
VALUES (12, '2,16');
create table species
(
    id   serial not null
        constraint species_pkey
            primary key,
    name text   not null
);

alter table species
    owner to nilfoe;

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
INSERT INTO public.species (id, name)
VALUES (3, 'unknown');
create table unblinded_compound_mapping
(
    id                   serial not null
        constraint unblinded_compound_mapping_pk
            primary key,
    name                 text   not null,
    unblinded_cas_number text   not null
        constraint unblinded_compound_mapping_compound_cas_no_fk
            references compound (cas_no)
);

alter table unblinded_compound_mapping
    owner to nilfoe;

create unique index unblinded_compound_mapping_id_uindex
    on unblinded_compound_mapping (id);

create unique index unblinded_compound_mapping_name_uindex
    on unblinded_compound_mapping (name);

INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1005, 'EPAPLT0164A01', '333-41-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1006, 'EPAPLT0164A02', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1007, 'EPAPLT0164A03', '147-94-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1008, 'EPAPLT0164A04', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1009, 'EPAPLT0164A05', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1010, 'EPAPLT0164A06', '67375-30-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1011, 'EPAPLT0164A07', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1012, 'EPAPLT0164A08', '58-08-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1013, 'EPAPLT0164A09', '320-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1014, 'EPAPLT0164A10', '133-90-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1015, 'EPAPLT0164A11', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1016, 'EPAPLT0164B01', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1017, 'EPAPLT0164B02', '2795-39-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1018, 'EPAPLT0164B04', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1019, 'EPAPLT0164B05', '165252-70-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1020, 'EPAPLT0164B06', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1021, 'EPAPLT0164B07', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1022, 'EPAPLT0164B08', '28434-00-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1023, 'EPAPLT0164B09', '121-75-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1024, 'EPAPLT0164B10', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1025, 'EPAPLT0164B11', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1026, 'EPAPLT0164C01', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1027, 'EPAPLT0164C02', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1028, 'EPAPLT0164C03', '25013-16-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1029, 'EPAPLT0164C04', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1030, 'EPAPLT0164C05', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1031, 'EPAPLT0164C06', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1032, 'EPAPLT0164C07', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1033, 'EPAPLT0164C08', '486-56-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1034, 'EPAPLT0164C09', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1035, 'EPAPLT0164C10', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1036, 'EPAPLT0164C11', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1037, 'EPAPLT0164D01', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1038, 'EPAPLT0164D02', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1039, 'EPAPLT0164D03', '584-79-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1040, 'EPAPLT0164D04', '1772-03-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1041, 'EPAPLT0164D05', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1042, 'EPAPLT0164D06', '6055-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1043, 'EPAPLT0164D07', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1044, 'EPAPLT0164D08', '111988-49-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1045, 'EPAPLT0164D09', '143-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1046, 'EPAPLT0164D10', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1047, 'EPAPLT0164D11', '127-69-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1048, 'EPAPLT0164E01', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1049, 'EPAPLT0164E02', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1050, 'EPAPLT0164E03', '96-45-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1051, 'EPAPLT0164E04', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1052, 'EPAPLT0164E05', '69-53-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1053, 'EPAPLT0164E06', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1054, 'EPAPLT0164E07', '142459-58-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1055, 'EPAPLT0164E08', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1056, 'EPAPLT0164E09', '17804-35-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1057, 'EPAPLT0164E10', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1058, 'EPAPLT0164E11', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1059, 'EPAPLT0164F01', '210880-92-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1060, 'EPAPLT0164F02', '68359-37-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1061, 'EPAPLT0164F03', '59-05-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1062, 'EPAPLT0164F04', '114-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1063, 'EPAPLT0164F05', '78-30-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1064, 'EPAPLT0164F06', '52-68-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1065, 'EPAPLT0164F07', '60-54-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1066, 'EPAPLT0164F08', '13674-87-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1067, 'EPAPLT0164F09', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1068, 'EPAPLT0164F10', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1069, 'EPAPLT0164F11', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (436, 'EPAPLT0157A05', '103-90-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (437, 'EPAPLT0157A09', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (438, 'EPAPLT0157A10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (439, 'EPAPLT0157A11', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (440, 'EPAPLT0157B01', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (441, 'EPAPLT0157B02', '1330-78-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (442, 'EPAPLT0157B04', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (443, 'EPAPLT0157B05', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (444, 'EPAPLT0157B07', '50-70-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (445, 'EPAPLT0157B08', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (446, 'EPAPLT0157B12', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (447, 'EPAPLT0157C01', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (448, 'EPAPLT0157C09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (449, 'EPAPLT0157C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (450, 'EPAPLT0157C12', '302-79-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (451, 'EPAPLT0157D01', '50-02-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (452, 'EPAPLT0157D02', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (453, 'EPAPLT0157D06', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (454, 'EPAPLT0157D07', '70-30-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (455, 'EPAPLT0157D08', '80-05-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (456, 'EPAPLT0157D09', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (457, 'EPAPLT0157D10', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (458, 'EPAPLT0157D11', '1241-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (459, 'EPAPLT0157D12', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (460, 'EPAPLT0157E01', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (461, 'EPAPLT0157E03', '68937-41-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (462, 'EPAPLT0157E04', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (463, 'EPAPLT0157E05', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (464, 'EPAPLT0157E11', '2921-88-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (465, 'EPAPLT0157E12', '15687-27-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (466, 'EPAPLT0157F01', '12427-38-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (467, 'EPAPLT0157F03', '56803-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (468, 'EPAPLT0157F04', '10108-64-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (469, 'EPAPLT0157G04', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (470, 'EPAPLT0157G05', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (471, 'EPAPLT0157G09', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (472, 'EPAPLT0157G10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (473, 'EPAPLT0157G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (474, 'EPAPLT0157G12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (475, 'EPAPLT0157H01', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (476, 'EPAPLT0157H05', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (477, 'EPAPLT0157H06', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (478, 'EPAPLT0157H07', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (479, 'EPAPLT0157H10', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (480, 'EPAPLT0157H11', '50-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (481, 'EPAPLT0158A02', '52-86-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (482, 'EPAPLT0158A03', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (483, 'EPAPLT0158A04', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (484, 'EPAPLT0158B01', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (485, 'EPAPLT0158C02', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (486, 'EPAPLT0158C04', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (487, 'EPAPLT0158D04', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (488, 'EPAPLT0158E01', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (489, 'EPAPLT0158E03', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (490, 'EPAPLT0158E04', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (491, 'EPAPLT0158F03', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (492, 'EPAPLT0158G01', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (493, 'EPAPLT0158G02', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (494, 'EPAPLT0158G03', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (495, 'EPAPLT0158G04', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (496, 'EPAPLT0158H01', '79-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (497, 'EPAPLT0158H02', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (498, 'EPAPLT0158H03', '107534-96-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (499, 'EPAPLT0162A05', '103-90-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (500, 'EPAPLT0162A09', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (501, 'EPAPLT0162A10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (502, 'EPAPLT0162A11', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (503, 'EPAPLT0162B01', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (504, 'EPAPLT0162B02', '1330-78-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (505, 'EPAPLT0162B04', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (506, 'EPAPLT0162B05', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (507, 'EPAPLT0162B07', '50-70-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (508, 'EPAPLT0162B08', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (509, 'EPAPLT0162B12', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (510, 'EPAPLT0162C01', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (511, 'EPAPLT0162C09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (512, 'EPAPLT0162C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (513, 'EPAPLT0162C12', '302-79-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (514, 'EPAPLT0162D01', '50-02-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (515, 'EPAPLT0162D02', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (516, 'EPAPLT0162D06', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (517, 'EPAPLT0162D07', '70-30-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (518, 'EPAPLT0162D08', '80-05-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (519, 'EPAPLT0162D09', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (520, 'EPAPLT0162D10', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (521, 'EPAPLT0162D11', '1241-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (522, 'EPAPLT0162D12', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (523, 'EPAPLT0162E01', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (524, 'EPAPLT0162E03', '68937-41-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (525, 'EPAPLT0162E04', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (526, 'EPAPLT0162E05', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (527, 'EPAPLT0162E11', '2921-88-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (528, 'EPAPLT0162E12', '15687-27-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (529, 'EPAPLT0162F01', '12427-38-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (530, 'EPAPLT0162F03', '56803-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (531, 'EPAPLT0162F04', '10108-64-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (532, 'EPAPLT0162G04', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (533, 'EPAPLT0162G05', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (534, 'EPAPLT0162G09', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (535, 'EPAPLT0162G10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (536, 'EPAPLT0162G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (537, 'EPAPLT0162G12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (538, 'EPAPLT0162H01', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (539, 'EPAPLT0162H05', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (540, 'EPAPLT0162H06', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (541, 'EPAPLT0162H07', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (542, 'EPAPLT0162H10', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (543, 'EPAPLT0162H11', '50-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (544, 'EPAPLT0163A02', '52-86-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (545, 'EPAPLT0163A03', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (546, 'EPAPLT0163A04', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (547, 'EPAPLT0163B01', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (548, 'EPAPLT0163C02', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (549, 'EPAPLT0163C04', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (550, 'EPAPLT0163D04', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (551, 'EPAPLT0163E01', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (552, 'EPAPLT0163E03', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (553, 'EPAPLT0163E04', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (554, 'EPAPLT0163F03', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (555, 'EPAPLT0163G01', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (556, 'EPAPLT0163G02', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (557, 'EPAPLT0163G03', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (558, 'EPAPLT0163G04', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (559, 'EPAPLT0163H01', '79-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (560, 'EPAPLT0163H02', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (561, 'EPAPLT0163H03', '107534-96-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (562, 'EPAPLT0172A05', '103-90-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (563, 'EPAPLT0172A09', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (564, 'EPAPLT0172A10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (565, 'EPAPLT0172A11', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (566, 'EPAPLT0172B01', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (567, 'EPAPLT0172B02', '1330-78-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (568, 'EPAPLT0172B04', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (569, 'EPAPLT0172B05', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (570, 'EPAPLT0172B07', '50-70-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (571, 'EPAPLT0172B08', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (572, 'EPAPLT0172C01', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (573, 'EPAPLT0172C09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (574, 'EPAPLT0172C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (575, 'EPAPLT0172C12', '302-79-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (576, 'EPAPLT0172D01', '50-02-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (577, 'EPAPLT0172D02', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (578, 'EPAPLT0172D06', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (579, 'EPAPLT0172D07', '70-30-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (580, 'EPAPLT0172D08', '80-05-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (581, 'EPAPLT0172D09', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (582, 'EPAPLT0172D10', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (583, 'EPAPLT0172D11', '1241-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (584, 'EPAPLT0172D12', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (585, 'EPAPLT0172E01', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (586, 'EPAPLT0172E03', '68937-41-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (587, 'EPAPLT0172E04', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (588, 'EPAPLT0172E05', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (589, 'EPAPLT0172E11', '2921-88-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (590, 'EPAPLT0172E12', '15687-27-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (591, 'EPAPLT0172F01', '12427-38-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (592, 'EPAPLT0172F03', '56803-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (593, 'EPAPLT0172F04', '10108-64-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (594, 'EPAPLT0172G04', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (595, 'EPAPLT0172G05', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (596, 'EPAPLT0172G09', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (597, 'EPAPLT0172G10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (598, 'EPAPLT0172G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (599, 'EPAPLT0172G12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (600, 'EPAPLT0172H01', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (601, 'EPAPLT0172H05', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (602, 'EPAPLT0172H06', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (603, 'EPAPLT0172H07', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (604, 'EPAPLT0172H10', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (605, 'EPAPLT0172H11', '50-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (606, 'EPAPLT0173A02', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (607, 'EPAPLT0173A03', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (608, 'EPAPLT0173A04', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (609, 'EPAPLT0173B01', '79-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (610, 'EPAPLT0173C01', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (611, 'EPAPLT0173C02', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (612, 'EPAPLT0173C04', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (613, 'EPAPLT0173C05', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (614, 'EPAPLT0173D02', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (615, 'EPAPLT0173D05', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (616, 'EPAPLT0173E01', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (617, 'EPAPLT0173E03', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (618, 'EPAPLT0173F01', '52-86-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (619, 'EPAPLT0173F03', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (620, 'EPAPLT0173G02', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (621, 'EPAPLT0173G03', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (622, 'EPAPLT0173G04', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (623, 'EPAPLT0173H02', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (624, 'EPAPLT0173H03', '107534-96-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (625, 'EPAPLT0174A05', '103-90-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (626, 'EPAPLT0174A09', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (627, 'EPAPLT0174A10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (628, 'EPAPLT0174A11', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (629, 'EPAPLT0174B01', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (630, 'EPAPLT0174B02', '1330-78-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (631, 'EPAPLT0174B04', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (632, 'EPAPLT0174B05', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (633, 'EPAPLT0174B07', '50-70-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (634, 'EPAPLT0174B08', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (635, 'EPAPLT0174C01', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (636, 'EPAPLT0174C09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (637, 'EPAPLT0174C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (638, 'EPAPLT0174C12', '302-79-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (639, 'EPAPLT0174D01', '50-02-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (640, 'EPAPLT0174D02', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (641, 'EPAPLT0174D06', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (642, 'EPAPLT0174D07', '70-30-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (643, 'EPAPLT0174D08', '80-05-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (644, 'EPAPLT0174D09', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (645, 'EPAPLT0174D10', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (646, 'EPAPLT0174D11', '1241-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (647, 'EPAPLT0174D12', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (648, 'EPAPLT0174E01', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (649, 'EPAPLT0174E03', '68937-41-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (650, 'EPAPLT0174E04', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (651, 'EPAPLT0174E05', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (652, 'EPAPLT0174E11', '2921-88-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (653, 'EPAPLT0174E12', '15687-27-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (654, 'EPAPLT0174F01', '12427-38-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (655, 'EPAPLT0174F03', '56803-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (656, 'EPAPLT0174F04', '10108-64-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (657, 'EPAPLT0174G04', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (658, 'EPAPLT0174G05', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (659, 'EPAPLT0174G09', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (660, 'EPAPLT0174G10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (661, 'EPAPLT0174G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (662, 'EPAPLT0174G12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (663, 'EPAPLT0174H01', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (664, 'EPAPLT0174H05', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (665, 'EPAPLT0174H06', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (666, 'EPAPLT0174H07', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (667, 'EPAPLT0174H10', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (668, 'EPAPLT0174H11', '50-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (669, 'EPAPLT0175A02', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (670, 'EPAPLT0175A03', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (671, 'EPAPLT0175A04', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (672, 'EPAPLT0175B01', '79-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (673, 'EPAPLT0175C01', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (674, 'EPAPLT0175C02', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (675, 'EPAPLT0175C04', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (676, 'EPAPLT0175C05', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (677, 'EPAPLT0175D02', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (678, 'EPAPLT0175D05', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (679, 'EPAPLT0175E01', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (680, 'EPAPLT0175E03', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (681, 'EPAPLT0175F01', '52-86-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (682, 'EPAPLT0175F03', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (683, 'EPAPLT0175G02', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (684, 'EPAPLT0175G03', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (685, 'EPAPLT0175G04', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (686, 'EPAPLT0175H02', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (687, 'EPAPLT0175H03', '107534-96-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (688, 'EPAPLT0176A05', '103-90-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (689, 'EPAPLT0176A09', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (690, 'EPAPLT0176A10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (691, 'EPAPLT0176A11', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (692, 'EPAPLT0176B01', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (693, 'EPAPLT0176B02', '1330-78-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (694, 'EPAPLT0176B04', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (695, 'EPAPLT0176B05', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (696, 'EPAPLT0176B07', '50-70-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (697, 'EPAPLT0176B08', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (698, 'EPAPLT0176C01', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (699, 'EPAPLT0176C09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (700, 'EPAPLT0176C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (701, 'EPAPLT0176C12', '302-79-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (702, 'EPAPLT0176D01', '50-02-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (703, 'EPAPLT0176D02', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (704, 'EPAPLT0176D06', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (705, 'EPAPLT0176D07', '70-30-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (706, 'EPAPLT0176D08', '80-05-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (707, 'EPAPLT0176D09', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (708, 'EPAPLT0176D10', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (709, 'EPAPLT0176D11', '1241-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (710, 'EPAPLT0176D12', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (711, 'EPAPLT0176E01', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (712, 'EPAPLT0176E03', '68937-41-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (713, 'EPAPLT0176E04', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (714, 'EPAPLT0176E05', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (715, 'EPAPLT0176E11', '2921-88-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (716, 'EPAPLT0176E12', '15687-27-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (717, 'EPAPLT0176F01', '12427-38-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (718, 'EPAPLT0176F03', '56803-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (719, 'EPAPLT0176F04', '10108-64-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (720, 'EPAPLT0176G04', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (721, 'EPAPLT0176G05', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (722, 'EPAPLT0176G09', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (723, 'EPAPLT0176G10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (724, 'EPAPLT0176G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (725, 'EPAPLT0176G12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (726, 'EPAPLT0176H01', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (727, 'EPAPLT0176H05', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (728, 'EPAPLT0176H06', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (729, 'EPAPLT0176H07', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (730, 'EPAPLT0176H10', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (731, 'EPAPLT0176H11', '50-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (732, 'EPAPLT0177A02', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (733, 'EPAPLT0177A03', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (734, 'EPAPLT0177A04', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (735, 'EPAPLT0177B01', '79-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (736, 'EPAPLT0177C01', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (737, 'EPAPLT0177C02', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (738, 'EPAPLT0177C04', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (739, 'EPAPLT0177C05', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (740, 'EPAPLT0177D02', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (741, 'EPAPLT0177D05', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (742, 'EPAPLT0177E01', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (743, 'EPAPLT0177E03', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (744, 'EPAPLT0177F01', '52-86-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (745, 'EPAPLT0177F03', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (746, 'EPAPLT0177G02', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (747, 'EPAPLT0177G03', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (748, 'EPAPLT0177G04', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (749, 'EPAPLT0177H02', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (750, 'EPAPLT0177H03', '107534-96-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (751, 'EPAPLT0178A05', '103-90-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (752, 'EPAPLT0178A09', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (753, 'EPAPLT0178A10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (754, 'EPAPLT0178A11', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (755, 'EPAPLT0178B01', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (756, 'EPAPLT0178B02', '1330-78-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (757, 'EPAPLT0178B04', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (758, 'EPAPLT0178B05', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (759, 'EPAPLT0178B07', '50-70-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (760, 'EPAPLT0178B08', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (761, 'EPAPLT0178C01', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (762, 'EPAPLT0178C09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (763, 'EPAPLT0178C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (764, 'EPAPLT0178C12', '302-79-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (765, 'EPAPLT0178D01', '50-02-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (766, 'EPAPLT0178D02', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (767, 'EPAPLT0178D06', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (768, 'EPAPLT0178D07', '70-30-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (769, 'EPAPLT0178D08', '80-05-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (770, 'EPAPLT0178D09', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (771, 'EPAPLT0178D10', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (772, 'EPAPLT0178D11', '1241-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (773, 'EPAPLT0178D12', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (774, 'EPAPLT0178E01', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (775, 'EPAPLT0178E03', '68937-41-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (776, 'EPAPLT0178E04', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (777, 'EPAPLT0178E05', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (778, 'EPAPLT0178E11', '2921-88-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (779, 'EPAPLT0178E12', '15687-27-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (780, 'EPAPLT0178F01', '12427-38-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (781, 'EPAPLT0178F03', '56803-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (782, 'EPAPLT0178F04', '10108-64-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (783, 'EPAPLT0178G04', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (784, 'EPAPLT0178G05', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (785, 'EPAPLT0178G09', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (786, 'EPAPLT0178G10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (787, 'EPAPLT0178G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (788, 'EPAPLT0178G12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (789, 'EPAPLT0178H01', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (790, 'EPAPLT0178H05', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (791, 'EPAPLT0178H06', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (792, 'EPAPLT0178H07', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (793, 'EPAPLT0178H10', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (794, 'EPAPLT0178H11', '50-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (795, 'EPAPLT0179A02', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (796, 'EPAPLT0179A03', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (797, 'EPAPLT0179A04', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (798, 'EPAPLT0179B01', '79-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (799, 'EPAPLT0179C01', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (800, 'EPAPLT0179C02', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (801, 'EPAPLT0179C04', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (802, 'EPAPLT0179C05', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (803, 'EPAPLT0179D02', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (804, 'EPAPLT0179D05', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (805, 'EPAPLT0179E01', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (806, 'EPAPLT0179E03', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (807, 'EPAPLT0179F01', '52-86-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (808, 'EPAPLT0179F03', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (809, 'EPAPLT0179G02', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (810, 'EPAPLT0179G03', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (811, 'EPAPLT0179G04', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (812, 'EPAPLT0179H02', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (813, 'EPAPLT0179H03', '107534-96-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1070, 'EPAPLT0164G01', '298-00-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1071, 'EPAPLT0164G02', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1072, 'EPAPLT0164G03', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1073, 'EPAPLT0164G04', '50-81-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1074, 'EPAPLT0164G05', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1075, 'EPAPLT0164G06', '5598-13-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1076, 'EPAPLT0164G07', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1077, 'EPAPLT0164G08', '60-56-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1078, 'EPAPLT0164G09', '14611-52-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1079, 'EPAPLT0164G10', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1080, 'EPAPLT0164G11', '335104-84-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1081, 'EPAPLT0164H01', '84371-65-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1082, 'EPAPLT0164H02', '56296-78-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1083, 'EPAPLT0164H03', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1084, 'EPAPLT0164H04', '108-95-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1085, 'EPAPLT0164H05', '124-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1086, 'EPAPLT0164H06', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1087, 'EPAPLT0164H07', '2155-70-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1088, 'EPAPLT0164H08', '153719-23-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1089, 'EPAPLT0164H09', '123312-89-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1090, 'EPAPLT0164H10', '22839-47-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1091, 'EPAPLT0164H11', '329-89-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1092, 'EPAPLT0165A01', '333-41-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1093, 'EPAPLT0165A02', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1094, 'EPAPLT0165A03', '147-94-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1095, 'EPAPLT0165A04', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1096, 'EPAPLT0165A05', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1097, 'EPAPLT0165A06', '67375-30-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1098, 'EPAPLT0165A07', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1099, 'EPAPLT0165A08', '5598-13-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1100, 'EPAPLT0165A09', '320-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1101, 'EPAPLT0165A10', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1102, 'EPAPLT0165A11', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1103, 'EPAPLT0165A12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1104, 'EPAPLT0165B01', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1105, 'EPAPLT0165B02', '84371-65-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1106, 'EPAPLT0165B04', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1107, 'EPAPLT0165B05', '78-30-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1108, 'EPAPLT0165B06', '124-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1109, 'EPAPLT0165B07', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1110, 'EPAPLT0165B08', '111988-49-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1111, 'EPAPLT0165B09', '13674-87-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1112, 'EPAPLT0165B10', '121-75-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1113, 'EPAPLT0165B11', '335104-84-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1114, 'EPAPLT0165B12', '329-89-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1115, 'EPAPLT0165C01', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1116, 'EPAPLT0165C02', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1117, 'EPAPLT0165C03', '25013-16-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1118, 'EPAPLT0165C04', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1119, 'EPAPLT0165C05', '108-95-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1120, 'EPAPLT0165C06', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1121, 'EPAPLT0165C07', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1122, 'EPAPLT0165C08', '58-08-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1123, 'EPAPLT0165C09', '60-56-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1124, 'EPAPLT0165C10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1125, 'EPAPLT0165C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1126, 'EPAPLT0165D01', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1127, 'EPAPLT0165D02', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1128, 'EPAPLT0165D03', '584-79-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1129, 'EPAPLT0165D04', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1130, 'EPAPLT0165D05', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1131, 'EPAPLT0165D06', '6055-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1132, 'EPAPLT0165D07', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1133, 'EPAPLT0165D08', '28434-00-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1134, 'EPAPLT0165D09', '143-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1135, 'EPAPLT0165D10', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1136, 'EPAPLT0165D11', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1137, 'EPAPLT0165E01', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1138, 'EPAPLT0165E02', '96-45-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1139, 'EPAPLT0165E03', '2795-39-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1140, 'EPAPLT0165E04', '1772-03-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1141, 'EPAPLT0165E05', '165252-70-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1142, 'EPAPLT0165E06', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1143, 'EPAPLT0165E07', '52-68-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1144, 'EPAPLT0165E08', '486-56-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1145, 'EPAPLT0165E09', '17804-35-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1146, 'EPAPLT0165E10', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1147, 'EPAPLT0165E11', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1148, 'EPAPLT0165F01', '210880-92-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1149, 'EPAPLT0165F02', '68359-37-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1150, 'EPAPLT0165F03', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1151, 'EPAPLT0165F04', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1152, 'EPAPLT0165F05', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1153, 'EPAPLT0165F06', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1154, 'EPAPLT0165F07', '60-54-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1155, 'EPAPLT0165F08', '153719-23-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1156, 'EPAPLT0165F09', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1157, 'EPAPLT0165F10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1158, 'EPAPLT0165F11', '22839-47-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1159, 'EPAPLT0165G01', '298-00-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1160, 'EPAPLT0165G02', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1161, 'EPAPLT0165G03', '59-05-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1162, 'EPAPLT0165G04', '114-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1163, 'EPAPLT0165G05', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1164, 'EPAPLT0165G06', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1165, 'EPAPLT0165G07', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1166, 'EPAPLT0165G08', '133-90-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1167, 'EPAPLT0165G09', '60-51-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1168, 'EPAPLT0165G10', '14611-52-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1169, 'EPAPLT0165G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1170, 'EPAPLT0165H01', '69-74-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1171, 'EPAPLT0165H02', '56296-78-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1172, 'EPAPLT0165H03', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1173, 'EPAPLT0165H04', '50-81-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1174, 'EPAPLT0165H05', '69-53-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1175, 'EPAPLT0165H06', '142459-58-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1176, 'EPAPLT0165H07', '2155-70-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1177, 'EPAPLT0165H08', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1178, 'EPAPLT0165H09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1179, 'EPAPLT0165H10', '123312-89-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1180, 'EPAPLT0165H11', '127-69-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1505, '1-Naphtol', '90-15-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1506, 'Chlorpyrifos Oxon', '5598-15-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1507, 'Domoic Acid', '14277-97-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1508, 'Endosulfan-sulfate', '1031-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1509, 'MDMA hydrochloride', '64057-70-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1510, 'Methylmercury', '115-09-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1511, 'Terbutaline hemisulfate salt', '23031-32-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1512, 'Diphenylhydantoin', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1513, 'Ketamine hydrochloride', '1867-66-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1514, 'Methylmercury chloride', '115-09-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1515, 'Sodium arsenate', '10048-95-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1516, 'Cocaine', '53-21-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1517, 'Chlorpromazine', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1518, 'Heptadecafluorooctane-sulfonic acid potassium salt', '2795-39-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1196, 'EPAPLT0166A01', '333-41-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1197, 'EPAPLT0166A02', '8018-01-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1198, 'EPAPLT0166A03', '147-94-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1199, 'EPAPLT0166A04', '91465-08-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1200, 'EPAPLT0166A05', '13674-84-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1201, 'EPAPLT0166A06', '67375-30-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1202, 'EPAPLT0166A07', '51384-51-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1203, 'EPAPLT0166A08', '5598-13-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1204, 'EPAPLT0166A09', '320-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1205, 'EPAPLT0166A10', '132-98-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1206, 'EPAPLT0166A11', '102851-06-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1207, 'EPAPLT0166A12', '52315-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1208, 'EPAPLT0166B01', '272451-65-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1209, 'EPAPLT0166B02', '84371-65-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1210, 'EPAPLT0166B04', '155569-91-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1211, 'EPAPLT0166B05', '78-30-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1212, 'EPAPLT0166B06', '124-94-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1213, 'EPAPLT0166B07', '135158-54-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1214, 'EPAPLT0166B08', '111988-49-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1215, 'EPAPLT0166B09', '13674-87-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1216, 'EPAPLT0166B10', '121-75-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1217, 'EPAPLT0166B11', '335104-84-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1218, 'EPAPLT0166B12', '329-89-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1219, 'EPAPLT0166C01', '1461-22-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1220, 'EPAPLT0166C02', '86-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1221, 'EPAPLT0166C03', '25013-16-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1222, 'EPAPLT0166C04', '6106-04-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1223, 'EPAPLT0166C05', '108-95-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1224, 'EPAPLT0166C06', '120068-37-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1225, 'EPAPLT0166C07', '81-81-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1226, 'EPAPLT0166C08', '58-08-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1227, 'EPAPLT0166C09', '60-56-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1228, 'EPAPLT0166C10', '24307-26-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1229, 'EPAPLT0166C11', '10265-92-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1230, 'EPAPLT0166D01', '36505-84-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1231, 'EPAPLT0166D02', '210631-68-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1232, 'EPAPLT0166D03', '584-79-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1233, 'EPAPLT0166D04', '173584-44-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1234, 'EPAPLT0166D05', '532-32-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1235, 'EPAPLT0166D06', '6055-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1236, 'EPAPLT0166D07', '161326-34-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1237, 'EPAPLT0166D08', '28434-00-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1238, 'EPAPLT0166D09', '143-50-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1239, 'EPAPLT0166D10', '7758-19-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1240, 'EPAPLT0166D11', '139968-49-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1241, 'EPAPLT0166E01', '80844-07-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1242, 'EPAPLT0166E02', '96-45-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1243, 'EPAPLT0166E03', '2795-39-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1244, 'EPAPLT0166E04', '1772-03-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1245, 'EPAPLT0166E05', '165252-70-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1246, 'EPAPLT0166E06', '556-67-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1247, 'EPAPLT0166E07', '52-68-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1248, 'EPAPLT0166E08', '486-56-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1249, 'EPAPLT0166E09', '17804-35-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1250, 'EPAPLT0166E10', '298-04-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1251, 'EPAPLT0166E11', '188425-85-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1252, 'EPAPLT0166F01', '210880-92-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1253, 'EPAPLT0166F02', '68359-37-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1254, 'EPAPLT0166F03', '62571-86-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1255, 'EPAPLT0166F04', '76824-35-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1256, 'EPAPLT0166F05', '657-24-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1257, 'EPAPLT0166F06', '111-46-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1258, 'EPAPLT0166F07', '60-54-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1259, 'EPAPLT0166F08', '153719-23-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1260, 'EPAPLT0166F09', '69-65-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1261, 'EPAPLT0166F10', '57966-95-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1262, 'EPAPLT0166F11', '22839-47-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1263, 'EPAPLT0166G01', '298-00-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1264, 'EPAPLT0166G02', '115-29-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1265, 'EPAPLT0166G03', '59-05-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1266, 'EPAPLT0166G04', '114-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1267, 'EPAPLT0166G05', '30560-19-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1268, 'EPAPLT0166G06', '148477-71-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1269, 'EPAPLT0166G07', '2303-17-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1270, 'EPAPLT0166G08', '133-90-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1271, 'EPAPLT0166G09', '60-51-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1272, 'EPAPLT0166G10', '14611-52-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1273, 'EPAPLT0166G11', '562-10-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1274, 'EPAPLT0166H01', '69-74-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1275, 'EPAPLT0166H02', '56296-78-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1276, 'EPAPLT0166H03', '26787-78-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1277, 'EPAPLT0166H04', '50-81-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1278, 'EPAPLT0166H05', '69-53-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1279, 'EPAPLT0166H06', '142459-58-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1280, 'EPAPLT0166H07', '2155-70-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1281, 'EPAPLT0166H08', '56-81-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1282, 'EPAPLT0166H09', '113-92-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1283, 'EPAPLT0166H10', '123312-89-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1284, 'EPAPLT0166H11', '127-69-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1285, 'EPAPLT0164B03', '1820573-27-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1286, 'EPAPLT0165B03', '1820573-27-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1287, 'EPAPLT0166B03', '1820573-27-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1519, 'Methylazoxymethanol acetate', '592-62-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1520, 'MPTP', '36913-39-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1521, 'MPP+', '36913-39-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1524, 'Paraquat dichloride hydrate', '75365-73-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1525, 'Perfluorooctanoic acid', '335-67-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1526, 'Sodium valproate', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1535, 'PFOA', '335-67-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1536, 'Chlorpromazine hydrochloride', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1537, 'PBDE153', '68631-49-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1538, 'PBDE47', '5436-43-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1539, 'PBDE99', '60348-60-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1540, 'PCB180', '35065-29-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1541, 'PFOS', '2795-39-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1542, 'Narciclasine', '29477-83-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1456, 'Acetamiprid', '160430-64-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1457, 'Arsenic trioxide', '1327-53-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1458, 'Sodium arsenate dibasic heptahydrate', '10048-95-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1459, 'Cadmium chloride', '10108-64-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1460, 'Carbamazepine', '298-46-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1461, 'Chlorpromazine hydrochloride*', '69-09-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1462, 'Chlorpyrifos', '2921-88-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1463, 'Chlorpyrifos oxon', '5598-15-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1464, 'Cocaine hydrochloride', '53-21-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1465, 'Dexamethasone', '50-02-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1466, '5,5-Diphenylhydantoin', '57-41-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1467, 'Domoic acid', '14277-97-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1468, 'Haloperidol', '52-86-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1469, 'Heroin hydrochloride monohydrate', '5893-91-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1470, 'Hexachlorophene', '70-30-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1471, 'Imidacloprid', '138261-41-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1472, '(±) Ketamine hydrochloride', '1867-66-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1473, 'Lead (II) acetate trihydrate', '6080-56-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1474, 'Lindane', '58-89-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1475, 'Methylazoxymethanol acetate (MAM)', '592-62-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1476, 'Maneb', '12427-38-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1477, 'Manganese (II) chloride', '7773-01-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1478, 'Manganese (II) sulfate monohydrate', '10034-96-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1479, '(±) MDMA hydrochloride', '64057-70-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1480, 'Methamphetamine hydrochloride', '51-57-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1481, 'Methylmercury chloride*', '115-09-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1482, 'MPTP1', '28289-54-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1483, 'MPP+ ', '36913-39-0');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1484, 'Morphine hydrochloride trihydrate', '6055-06-7');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1485, 'Nicotine', '54-11-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1486, 'PBDE 47', '5436-43-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1487, 'PBDE 99', '60348-60-9');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1488, 'PBDE 153', '68631-49-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1489, 'PCB 180', '35065-29-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1490, 'PFOA (Perfluorooctanoic acid)', '335-67-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1491, 'PFOS-K (Heptadecafluorooctane-sulfonic acid potassium salt)', '2795-39-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1492, 'Terbutaline hemisulfate salt*', '23031-32-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1493, 'Toluene', '108-88-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1494, 'all-trans-Retinoic acid', '302-79-4');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1495, 'Triethyl-tin bromide', '2767-54-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1496, 'Sodium valproate*', '1069-66-5');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1497, 'Aspirin', '50-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1498, 'Ibuprofen', '15687-27-1');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1499, 'Malaoxon', '1634-78-2');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1500, 'Omethoate', '1113-02-6');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1501, 'Endosulfan sulfate', '1031-07-8');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1502, '1-Naphthol', '90-15-3');
INSERT INTO public.unblinded_compound_mapping (id, name, unblinded_cas_number)
VALUES (1503, 'Narciclasin', '29477-83-6');
create table well
(
    id   serial not null
        constraint well_pk
            primary key,
    name text
);

alter table well
    owner to nilfoe;

create unique index well_id_uindex
    on well (id);

create unique index well_name_uindex
    on well (name);

INSERT INTO public.well (id, name)
VALUES (1, 'Unknown');
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
VALUES (2, 'Modern risk assessment and sphere biology', 1, 1);
INSERT INTO public.workgroup (id, name, leader_id, department_id)
VALUES (3, '???', 2, 2);