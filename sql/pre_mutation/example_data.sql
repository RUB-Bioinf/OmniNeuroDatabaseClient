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

INSERT INTO public.comment (id, text, experiment_id)
VALUES (1, 'SOP', 1);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (2, 'SOP', 2);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (3, 'SOP', 4);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (4, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1', 5);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (5, 'SOP', 3);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (6, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1

Only high concentration, no low concentration', 6);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (7, 'SOP', 7);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (8, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1

no low concentration.', 8);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (9, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1

no low concentration.', 9);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (10, 'SOP', 12);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (11, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1', 13);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (12, 'SOP', 11);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (13, 'SOP', 10);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (14, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1

Only high concentration, no low concentration', 15);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (15, 'SOP', 14);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (16, 'SOP', 16);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (17, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1

no low concentration.', 17);
INSERT INTO public.comment (id, text, experiment_id)
VALUES (18, 'Comments

Plating Scheme on Page 198-200 in EFSA-DNT2 Nr. 1

no low concentration.', 18);
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

INSERT INTO public.concentration (id, value, control_id)
VALUES (280, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (282, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (281, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (283, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (284, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (285, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (287, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (286, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (288, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (290, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (289, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (291, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (292, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (294, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (293, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (296, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (295, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (297, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (300, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (298, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (302, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (299, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (301, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (304, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (303, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (305, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (306, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (308, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (307, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (309, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (310, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (314, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (311, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (313, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (315, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (312, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (318, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (317, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (316, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (319, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (322, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (321, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (320, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (323, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (324, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (325, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (326, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (328, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (327, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (329, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (330, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (331, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (333, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (332, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (334, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (337, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (336, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (335, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (338, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (339, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (341, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (340, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (343, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (344, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (342, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (347, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (348, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (349, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (346, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (345, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (350, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (351, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (352, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (353, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (354, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (355, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (357, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (356, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (360, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (359, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (358, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (361, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (362, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (363, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (366, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (365, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (364, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (368, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (367, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (370, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (371, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (374, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (369, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (373, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (372, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (375, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (377, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (379, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (380, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (376, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (378, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (381, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (382, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (383, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (385, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (386, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (387, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (388, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (389, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (384, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (390, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (391, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (392, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (393, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (394, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (395, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (396, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (397, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (399, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (398, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (402, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (400, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (403, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (401, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (404, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (406, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (405, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (407, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (408, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (411, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (410, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (412, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (409, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (414, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (415, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (413, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (416, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (417, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (418, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (420, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (421, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (419, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (422, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (423, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (424, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (425, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (427, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (426, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (428, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (430, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (429, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (432, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (431, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (436, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (434, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (437, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (433, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (439, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (435, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (438, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (441, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (440, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (442, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (444, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (443, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (445, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (446, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (447, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (448, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (449, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (450, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (452, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (451, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (453, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (455, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (457, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (456, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (454, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (458, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (459, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (460, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (461, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (462, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (463, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (465, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (466, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (464, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (467, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (469, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (468, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (472, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (473, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (471, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (470, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (474, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (477, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (475, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (476, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (478, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (479, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (480, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (481, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (482, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (483, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (484, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (485, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (486, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (487, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (488, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (490, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (489, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (491, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (492, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (493, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (494, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (497, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (495, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (496, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (498, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (499, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (500, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (501, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (503, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (502, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (505, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (504, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (506, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (507, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (508, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (509, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (510, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (511, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (512, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (513, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (515, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (514, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (517, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (516, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (518, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (519, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (520, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (521, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (522, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (523, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (524, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (525, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (526, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (527, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (528, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (530, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (529, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (531, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (532, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (533, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (534, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (535, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (536, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (537, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (538, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (539, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (540, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (541, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (542, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (543, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (544, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (545, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (546, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (547, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (548, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (549, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (550, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (551, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (552, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (553, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (554, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (555, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (556, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (557, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (558, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (1, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (4, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (3, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (2, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (6, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (5, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (7, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (8, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (10, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (9, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (12, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (11, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (13, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (16, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (14, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (15, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (18, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (19, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (20, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (17, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (21, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (22, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (23, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (24, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (25, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (26, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (27, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (28, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (30, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (31, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (32, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (33, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (34, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (35, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (29, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (36, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (37, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (40, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (39, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (38, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (41, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (42, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (43, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (45, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (44, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (46, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (47, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (48, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (49, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (51, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (52, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (53, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (50, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (54, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (55, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (56, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (57, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (58, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (59, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (61, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (60, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (62, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (63, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (64, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (66, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (67, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (65, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (69, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (68, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (70, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (71, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (72, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (73, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (74, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (75, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (76, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (77, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (78, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (79, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (80, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (81, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (82, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (84, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (85, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (83, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (86, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (88, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (87, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (89, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (91, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (90, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (92, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (93, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (94, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (95, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (96, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (97, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (99, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (100, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (101, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (102, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (98, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (103, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (105, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (104, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (106, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (107, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (108, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (111, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (110, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (109, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (112, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (113, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (114, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (116, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (115, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (117, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (118, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (119, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (120, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (121, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (122, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (123, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (125, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (126, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (124, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (127, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (128, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (129, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (131, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (132, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (130, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (133, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (134, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (136, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (135, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (139, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (140, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (138, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (137, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (141, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (142, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (143, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (145, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (144, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (147, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (146, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (148, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (149, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (150, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (151, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (152, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (153, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (154, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (155, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (157, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (156, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (158, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (159, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (160, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (161, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (164, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (163, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (162, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (165, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (166, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (167, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (168, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (170, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (169, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (171, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (173, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (174, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (175, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (176, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (172, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (177, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (178, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (179, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (180, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (182, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (183, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (181, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (185, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (184, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (186, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (188, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (189, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (187, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (190, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (191, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (192, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (194, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (195, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (193, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (196, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (197, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (198, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (199, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (200, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (201, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (202, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (204, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (205, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (206, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (203, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (207, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (208, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (209, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (212, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (213, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (211, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (210, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (214, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (215, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (216, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (217, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (218, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (219, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (220, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (222, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (221, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (223, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (224, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (226, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (225, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (228, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (229, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (230, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (231, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (232, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (227, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (233, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (235, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (234, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (237, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (238, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (236, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (241, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (240, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (239, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (243, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (242, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (244, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (245, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (246, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (247, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (248, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (249, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (250, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (251, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (252, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (253, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (254, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (255, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (256, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (257, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (258, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (259, 0.002, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (260, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (261, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (262, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (263, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (264, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (265, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (266, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (267, 0, 5);
INSERT INTO public.concentration (id, value, control_id)
VALUES (268, 0.0823045267489712, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (269, 0.7407407407407408, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (270, 0, 1);
INSERT INTO public.concentration (id, value, control_id)
VALUES (271, 0, 3);
INSERT INTO public.concentration (id, value, control_id)
VALUES (272, 0, 4);
INSERT INTO public.concentration (id, value, control_id)
VALUES (273, 6.666666666666667, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (274, 0.027434842249657063, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (275, 0.2469135802469136, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (276, 20, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (277, 2.2222222222222223, 0);
INSERT INTO public.concentration (id, value, control_id)
VALUES (278, 0, 2);
INSERT INTO public.concentration (id, value, control_id)
VALUES (279, 0, 5);
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

INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (1, 1542643086439, 'ELS47_PQ_NPC1ab_385.xlsx', 0, 2, 32, 0, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (2, 1542643086439, 'ELS45_PQ_NPC1ab_062.xlsx', 0, 2, 33, 0, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (3, 1542643086439, 'ELS48_TETB_NPC1ab_385.xlsx', 0, 2, 32, 1, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (4, 1542643086439, 'ELS46_TETB_NPC1ab_062.xlsx', 0, 2, 33, 1, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (5, 1540393086439, 'ELS15_DA_NPC1a_385.xlsx', 0, 2, 32, 4, 0, 1, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (6, 1540393086439, 'ELS16_TBH_NPC1a_385.xlsx', 0, 2, 32, 7, 0, 1, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (7, 1548086286439, 'ELS83_TBH_NPC1ab_062.xlsx', 0, 2, 33, 7, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (8, 1540393089294, 'ELS17_TETB_NPC1a_385.xlsx', 0, 2, 32, 1, 0, 1, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (9, 1540393090709, 'ELS18_MPP_NPC1a_385.xlsx', 0, 2, 32, 5, 0, 1, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (10, 1542634760833, 'ELS48_TETB_NPC1ab_385.xlsx', 0, 2, 32, 1, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (11, 1542634760833, 'ELS47_PQ_NPC1ab_385.xlsx', 0, 2, 32, 0, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (12, 1542634760833, 'ELS46_TETB_NPC1ab_062.xlsx', 0, 2, 33, 1, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (13, 1540384760833, 'ELS15_DA_NPC1a_385.xlsx', 0, 2, 32, 4, 0, 1, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (14, 1542634760833, 'ELS45_PQ_NPC1ab_062.xlsx', 0, 2, 33, 0, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (15, 1540384760833, 'ELS16_TBH_NPC1a_385.xlsx', 0, 2, 32, 7, 0, 1, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (16, 1548077960833, 'ELS83_TBH_NPC1ab_062.xlsx', 0, 2, 33, 7, 0, 0, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (17, 1540384763630, 'ELS17_TETB_NPC1a_385.xlsx', 0, 2, 32, 1, 0, 1, 0);
INSERT INTO public.experiment (id, timestamp, name, project_id, workgroup_id, individual_id, compound_id, cell_type_id,
                               assay_id, plate_format_id)
VALUES (18, 1540384764145, 'ELS18_MPP_NPC1a_385.xlsx', 0, 2, 32, 5, 0, 1, 0);
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

INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1082, 806531, 24, 1, 280, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1083, 80814, 24, 1, 280, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1084, 1020150, 24, 1, 281, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1085, 1378.7142857142858, 24, 2, 282, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1086, 1845.142857142857, 24, 2, 282, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1087, 836036, 24, 1, 283, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1088, 1014035, 24, 1, 281, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1089, 676345, 24, 1, 280, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1090, 790199, 24, 1, 280, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1091, 959688, 24, 1, 281, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1092, 1858, 24, 2, 282, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1093, 2258.1428571428573, 24, 2, 282, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1094, 1012650, 24, 1, 281, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1095, 700686, 24, 1, 280, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1096, 2076.5714285714284, 24, 2, 284, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1097, 1803.5, 24, 2, 284, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1098, 813142, 24, 1, 281, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1099, 755260, 24, 1, 283, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1100, 1403, 24, 2, 282, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1101, 769057, 24, 1, 283, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1102, 2229.214285714286, 24, 2, 284, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1103, 1921.357142857143, 24, 2, 284, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1104, 1905, 24, 2, 286, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1105, 80267, 24, 1, 287, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1106, 1978.7142857142858, 24, 2, 284, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1107, 986336, 24, 1, 285, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1108, 62111, 24, 1, 287, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1109, 933640, 24, 1, 288, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1110, 1655.357142857143, 24, 2, 286, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1111, 1476.142857142857, 24, 2, 286, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1112, 76028, 24, 1, 290, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1113, 904170, 24, 1, 288, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1114, 83939, 24, 1, 287, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1115, 620463, 24, 1, 285, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1116, 1136, 24, 2, 291, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1117, 71081, 24, 1, 287, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1118, 234332, 24, 1, 288, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1119, 56553, 24, 1, 290, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1120, 1696.7857142857142, 24, 2, 286, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1121, 467098, 24, 1, 289, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1122, 1360.5, 24, 2, 286, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1123, 56148, 24, 1, 290, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1124, 909994, 24, 1, 288, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1125, 75073, 24, 1, 287, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1126, 1523.2142857142858, 24, 2, 291, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1127, 730378, 24, 1, 285, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1128, 1958.7142857142858, 24, 2, 291, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1129, 1873.2142857142858, 24, 2, 291, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1130, 934119, 24, 1, 288, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1131, 55282, 24, 1, 290, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1132, 320367, 24, 1, 289, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1133, 75858, 24, 1, 290, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1134, 1216369, 24, 1, 292, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1135, 2614.3571428571427, 24, 2, 291, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1136, 776532, 24, 1, 285, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1137, 1021352, 24, 1, 292, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1138, 345172, 24, 1, 289, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1139, 118, 24, 2, 293, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1140, 62112, 24, 1, 294, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1141, 913706, 24, 1, 292, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1142, 913780, 24, 1, 292, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1143, 953367, 24, 1, 285, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1144, 118, 24, 2, 295, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1145, 1223157, 24, 1, 292, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1146, 887325, 24, 1, 294, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1147, 774470, 24, 1, 296, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1148, -57.5, 24, 2, 293, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1149, 162058, 24, 1, 289, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1150, -67.42857142857143, 24, 2, 293, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1151, 668068, 24, 1, 296, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1152, 1011692, 24, 1, 294, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1153, -57.5, 24, 2, 295, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1154, -67.42857142857143, 24, 2, 295, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1155, 849064, 24, 1, 294, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1156, 943072, 24, 1, 296, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1157, -100.07142857142857, 24, 2, 293, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1158, 416107, 24, 1, 289, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1159, 56.857142857142854, 24, 2, 293, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1160, 965141, 24, 1, 296, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1161, 936408, 24, 1, 294, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1162, -100.07142857142857, 24, 2, 295, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1163, 56.857142857142854, 24, 2, 295, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1164, 40693, 24, 1, 297, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1165, 1051220, 24, 1, 296, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1166, 42727, 24, 1, 297, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1167, 28305, 24, 1, 297, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1168, 927310, 24, 1, 300, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1169, 59298, 24, 1, 302, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1170, 917353, 24, 1, 300, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1171, 35920, 24, 1, 297, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1172, 812797, 24, 1, 298, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1173, 34114, 24, 1, 297, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1174, 816184, 24, 1, 300, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1175, 875615, 24, 1, 300, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1176, 28688, 24, 1, 302, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1177, 33017, 24, 1, 302, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1178, 905534, 24, 1, 300, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1179, 272826, 24, 1, 298, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1180, 32289, 24, 1, 302, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1181, 47232, 24, 1, 302, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1182, 988049, 24, 1, 304, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1183, 626351, 24, 1, 304, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1184, 533816, 24, 1, 298, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1185, 670904, 24, 1, 304, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1186, 887567, 24, 1, 304, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1187, 1160630, 24, 1, 305, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1188, 851711, 24, 1, 305, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1189, 315456, 24, 1, 303, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1190, 984803, 24, 1, 305, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1191, 1102573, 24, 1, 304, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1192, 632092, 24, 1, 298, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1193, 992698, 24, 1, 305, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1194, 287647, 24, 1, 303, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1195, 878093, 24, 1, 306, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1196, 1035927, 24, 1, 305, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1197, 913357, 24, 1, 298, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1198, 5790, 24, 5, 307, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1199, 814698, 24, 1, 306, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1200, 5515, 24, 5, 308, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1201, 318140, 24, 1, 303, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1202, 5746, 24, 5, 308, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1203, 459260, 24, 1, 309, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1204, 5450, 24, 5, 307, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1205, 5320, 24, 5, 307, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1206, 5085, 24, 5, 307, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1207, 6056, 24, 5, 307, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1208, 71024, 24, 1, 309, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1209, 6099, 24, 5, 308, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1210, 362966, 24, 1, 303, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1211, 344738, 24, 1, 303, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1212, 6630, 24, 5, 308, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1213, 6289, 24, 5, 308, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1214, 871024, 24, 1, 306, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1215, 941838, 24, 1, 310, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1216, 751072, 24, 1, 309, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1217, 847965, 24, 1, 309, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1218, 110580, 24, 1, 309, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1219, 3110, 24, 5, 314, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1220, 821553, 24, 1, 310, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1221, 439028, 24, 1, 310, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1222, 960206, 24, 1, 310, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1223, 709455, 24, 1, 310, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1224, 3110, 24, 5, 315, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1225, 44607, 24, 1, 313, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1226, 37070, 24, 1, 313, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1227, 31853, 24, 1, 313, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1228, 45443, 24, 1, 313, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1229, 33855, 24, 1, 313, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1230, 2967, 24, 5, 314, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1231, 3106, 24, 5, 314, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1232, 3042, 24, 5, 314, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1233, 3129, 24, 5, 314, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1234, 1148704, 24, 1, 311, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1235, 695448, 24, 1, 311, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1236, 893503, 24, 1, 311, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1237, 2967, 24, 5, 315, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1238, 3106, 24, 5, 315, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1239, 469720, 24, 1, 312, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1240, 3042, 24, 5, 315, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1241, 811577, 24, 1, 316, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1242, 834296, 24, 1, 317, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1243, 770050, 24, 1, 317, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1244, 795779, 24, 1, 317, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1245, 746222, 24, 1, 317, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1246, 686647, 24, 1, 317, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1247, 3110, 24, 5, 318, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1248, 133805, 24, 1, 311, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1249, 949051, 24, 1, 311, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1250, 2967, 24, 5, 318, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1251, 3106, 24, 5, 318, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1252, 3042, 24, 5, 318, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1253, 3129, 24, 5, 318, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1254, 37103, 24, 1, 319, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1255, 142827, 24, 1, 316, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1256, 751315, 24, 1, 316, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1257, 3129, 24, 5, 315, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1258, 364065, 24, 1, 312, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1259, 621363, 24, 1, 316, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1260, 55462, 24, 1, 319, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1261, 4180, 24, 5, 321, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1262, 4094, 24, 5, 321, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1263, 3676, 24, 5, 321, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1264, 31028, 24, 1, 319, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1265, 774015, 24, 1, 322, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1266, 680082, 24, 1, 316, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1267, 300923, 24, 1, 312, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1268, 3110, 24, 5, 323, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1269, 2967, 24, 5, 323, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1270, 787345, 24, 1, 322, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1271, 85582, 24, 1, 322, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1272, 843894, 24, 1, 322, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1273, 46228, 24, 1, 319, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1274, 55763, 24, 1, 319, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1275, 3541, 24, 5, 321, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1276, 3676, 24, 5, 321, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1277, 770604, 24, 1, 320, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1278, 287120, 24, 1, 320, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1279, 800748, 24, 1, 320, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1280, 624891, 24, 1, 320, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1281, 65072, 24, 1, 325, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1282, 70955, 24, 1, 325, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1283, 102584, 24, 1, 325, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1284, 881638, 24, 1, 322, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1285, 51903, 24, 1, 324, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1286, 3106, 24, 5, 323, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1287, 474513, 24, 1, 312, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1288, 3042, 24, 5, 323, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1289, 3129, 24, 5, 323, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1290, 41412, 24, 1, 324, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1291, 34897, 24, 1, 324, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1292, 36651, 24, 1, 324, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1293, 58311, 24, 1, 325, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1294, 4138, 24, 5, 326, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1295, 833080, 24, 1, 320, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1296, 4368, 24, 5, 326, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1297, 4258, 24, 5, 326, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1298, 4085, 24, 5, 326, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1299, 4230, 24, 5, 326, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1300, 100704, 24, 1, 325, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1301, 5136, 24, 5, 329, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1302, 131096, 24, 1, 327, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1303, 47985, 24, 1, 331, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1304, 92415, 24, 1, 327, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1305, 6019, 24, 5, 329, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1306, 5706, 24, 5, 329, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1307, 6036, 24, 5, 329, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1308, 5564, 24, 5, 329, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1309, 301959, 24, 1, 330, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1310, 78804, 24, 1, 327, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1311, 146330, 24, 1, 327, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1312, 182153, 24, 1, 327, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1313, 73901, 24, 1, 331, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1314, 47257, 24, 1, 331, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1315, 53446, 24, 1, 332, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1316, 43259, 24, 1, 332, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1317, 36342, 24, 1, 332, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1318, 39349, 24, 1, 332, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1319, 50332, 24, 1, 332, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1320, 4138, 24, 5, 333, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1321, 4368, 24, 5, 333, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1322, 4258, 24, 5, 333, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1323, 4085, 24, 5, 333, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1324, 4230, 24, 5, 333, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1325, 322786, 24, 1, 330, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1326, 299622, 24, 1, 330, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1327, 33801, 24, 1, 331, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1328, 61993, 24, 1, 331, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1329, 345379, 24, 1, 330, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1330, 323199, 24, 1, 330, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1331, 69187, 24, 1, 335, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1332, 75958, 24, 1, 335, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1333, 68035, 24, 1, 335, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1334, 111514, 24, 1, 335, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1335, 78580, 24, 1, 335, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1336, 93831, 24, 1, 336, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1337, 909057, 24, 1, 337, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1338, 2210, 24, 6, 339, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1339, 2215, 24, 6, 339, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1340, 2152, 24, 6, 339, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1341, 2174, 24, 6, 339, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1342, 2195, 24, 6, 339, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1343, 1853.4, 24, 2, 338, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1344, 1757.2, 24, 2, 338, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1345, 1517.8, 24, 2, 338, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1346, 1912, 24, 2, 338, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1347, 70767, 24, 1, 336, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1348, 71600, 24, 1, 336, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1349, 1817.9, 24, 2, 338, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1350, 680684, 24, 1, 337, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1351, 343237, 24, 1, 337, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1352, 575829, 24, 1, 337, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1353, 844012, 24, 1, 337, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1354, 2166, 24, 6, 340, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1355, 2164, 24, 6, 340, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1356, 2188, 24, 6, 340, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1357, 2213, 24, 6, 340, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1358, 2166, 24, 6, 340, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1359, 39602, 24, 1, 336, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1360, 65834, 24, 1, 336, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1361, 86395, 24, 1, 341, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1362, 69986, 24, 1, 341, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1363, 58939, 24, 1, 341, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1364, 70667, 24, 1, 341, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1365, 69575, 24, 1, 341, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1366, 1302.4, 24, 2, 344, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1367, 3192, 24, 6, 343, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1368, 3343, 24, 6, 343, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1369, 3105, 24, 6, 343, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1370, 3828, 24, 6, 343, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1371, 3774, 24, 6, 343, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1372, 1253.2, 24, 2, 344, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1373, 2199, 24, 6, 345, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1374, 1683.6, 24, 2, 346, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1375, 1960.8, 24, 2, 346, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1376, 1581.2, 24, 2, 346, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1377, 2877, 24, 2, 349, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1378, 2431.1, 24, 2, 349, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1379, 1508.0714285714284, 24, 2, 344, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1380, 1369.8, 24, 2, 344, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1381, 1499.1, 24, 2, 344, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1382, 2182, 24, 6, 348, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1383, 925781, 24, 1, 347, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1384, 704584, 24, 1, 347, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1385, 70257, 24, 1, 347, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1386, 560225, 24, 1, 347, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1387, 2165, 24, 6, 348, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1388, 2234.7, 24, 2, 349, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1389, 1496.1, 24, 2, 346, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1390, 2202, 24, 6, 345, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1391, 2198, 24, 6, 345, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1392, 2202, 24, 6, 345, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1393, 2196, 24, 6, 345, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1394, 159171, 24, 1, 342, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1395, 1691.8, 24, 2, 346, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1396, 2058, 24, 2, 349, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1397, 2217.5, 24, 2, 350, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1398, 2177, 24, 6, 348, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1399, 2339, 24, 6, 348, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1400, 1040112, 24, 1, 347, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1401, 2184, 24, 6, 348, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1402, 2107, 24, 2, 350, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1403, 2038.9, 24, 2, 349, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1404, 2166, 24, 6, 351, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1405, 275544, 24, 1, 342, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1406, 455402, 24, 1, 342, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1407, 2164, 24, 6, 351, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1408, 1885.5, 24, 2, 350, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1409, 2161, 24, 6, 354, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1410, 2143, 24, 6, 354, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1411, 1783, 24, 2, 350, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1412, 2248.5, 24, 2, 353, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1413, 2346.3, 24, 2, 353, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1414, 1780.3, 24, 2, 352, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1415, 2188, 24, 6, 351, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1416, 296224, 24, 1, 342, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1417, 2213, 24, 6, 351, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1418, 2166, 24, 6, 351, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1419, 1320.1, 24, 2, 352, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1420, 812.2, 24, 2, 352, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1421, 1311.5, 24, 2, 352, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1422, 1523.9, 24, 2, 352, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1423, 2199.6, 24, 2, 353, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1424, 2234.9, 24, 2, 350, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1425, 2145, 24, 6, 354, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1426, 554090, 24, 1, 355, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1427, 2128, 24, 6, 354, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1428, 2023.3, 24, 2, 353, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1429, 1589.5, 24, 2, 357, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1430, 3192, 24, 6, 356, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1431, 3343, 24, 6, 356, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1432, 3105, 24, 6, 356, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1433, 3828, 24, 6, 356, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1434, 3774, 24, 6, 356, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1435, 1349.4, 24, 2, 357, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1436, 2175.6, 24, 2, 353, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1437, 2161, 24, 6, 354, 15, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1438, 60788, 24, 1, 355, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1439, 508846, 24, 1, 355, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1440, 412990, 24, 1, 355, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1441, 1965.7, 24, 2, 357, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1442, 1955.8, 24, 2, 357, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1443, 2092.3, 24, 2, 357, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1444, 697.1, 24, 2, 361, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1445, 2272.6, 24, 2, 358, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1446, 2113.6, 24, 2, 358, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1447, 2380, 24, 2, 358, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1448, 731.9, 24, 2, 359, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1449, 524588, 24, 1, 355, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1450, 713.3, 24, 2, 359, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1451, 543, 24, 2, 359, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1452, 1995.1, 24, 2, 358, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1453, 749.9, 24, 2, 361, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1454, 723.8, 24, 2, 361, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1455, 947.2, 24, 2, 361, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1456, 934, 24, 2, 361, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1457, 2207, 24, 6, 362, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1458, 2190, 24, 6, 362, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1459, 2179, 24, 6, 362, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1460, 2193, 24, 6, 362, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1461, 2206, 24, 6, 362, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1462, 2047.2, 24, 2, 358, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1463, 488.2, 24, 2, 359, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1464, 512.8, 24, 2, 359, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1465, 1786.9, 24, 2, 366, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1466, 1498.9, 24, 2, 366, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1467, 1818, 24, 2, 366, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1468, 368064, 24, 1, 363, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1469, 2161, 24, 6, 364, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1470, 2143, 24, 6, 364, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1471, 1461, 24, 2, 365, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1472, 2217.1, 24, 2, 365, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1473, 1462.3, 24, 2, 365, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1474, 1748.3, 24, 2, 365, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1475, 1576.6, 24, 2, 365, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1476, 1823.8, 24, 2, 366, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1477, 1946.8, 24, 2, 366, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1478, 2390.9, 24, 2, 367, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1479, 1474.1, 24, 2, 368, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1480, 1304.8, 24, 2, 368, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1481, 2145, 24, 6, 364, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1482, 2128, 24, 6, 364, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1483, 274309, 24, 1, 363, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1484, 2161, 24, 6, 364, 13, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1485, 1379, 24, 2, 368, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1486, 1367.285714285714, 24, 2, 368, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1487, 2400.2, 24, 2, 367, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1488, 2026.5, 24, 2, 367, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1489, 2487.4, 24, 2, 367, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1490, 2352.4, 24, 2, 367, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1491, 1617.7, 24, 2, 370, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1492, 1344.4, 24, 2, 370, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1493, 1526.2, 24, 2, 370, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1494, 1724.6, 24, 2, 370, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1495, 1045, 24, 2, 370, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1496, 1419.7857142857142, 24, 2, 374, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1497, 311365, 24, 1, 363, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1498, 343043, 24, 1, 363, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1499, 431351, 24, 1, 363, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1500, 829.2, 24, 2, 372, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1501, 864.4, 24, 2, 372, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1502, 1488.9, 24, 2, 372, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1503, 1195.6, 24, 2, 372, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1504, 1221.4, 24, 2, 373, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1505, 1577.8, 24, 2, 373, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1506, 673.9, 24, 2, 373, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1507, 1554, 24, 2, 373, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1508, 1743.7857142857142, 24, 2, 374, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1509, 794644, 24, 1, 369, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1510, 636955, 24, 1, 369, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1511, 749282, 24, 1, 369, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1512, 628674, 24, 1, 369, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1513, 616437, 24, 1, 369, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1514, 1473.0714285714287, 24, 2, 374, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1515, 997, 24, 2, 374, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1516, 1120.2142857142858, 24, 2, 374, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1517, 1234, 24, 2, 373, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1518, 2463.8, 24, 2, 375, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1519, 2374.5, 24, 2, 375, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1520, 2113.1, 24, 2, 375, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1521, 2365.6, 24, 2, 375, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1522, 2356.8, 24, 2, 375, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1523, 745.5, 24, 2, 380, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1524, 1921.9, 24, 2, 379, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1525, 2010.3, 24, 2, 379, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1526, 1533.8, 24, 2, 379, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1527, 1797.7, 24, 2, 379, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1528, 2160, 24, 2, 379, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1529, 457.85714285714283, 24, 2, 377, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1530, 391.35714285714283, 24, 2, 377, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1531, 500.7857142857143, 24, 2, 377, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1532, 242, 24, 2, 377, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1533, 1034.5, 24, 2, 378, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1534, 868.6, 24, 2, 378, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1535, 799.9, 24, 2, 378, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1536, 790.4, 24, 2, 378, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1537, 1137.6, 24, 2, 378, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1538, 1081.7, 24, 2, 380, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1539, 668.1, 24, 2, 380, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1540, 1096.3, 24, 2, 380, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1541, 1023.7, 24, 2, 380, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1542, 392331, 24, 1, 376, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1543, 259762, 24, 1, 376, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1544, 295342, 24, 1, 376, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1545, -784, 24, 2, 382, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1546, 2106.3, 24, 2, 381, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1547, 481.57142857142856, 24, 2, 377, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1548, 2130.1, 24, 2, 381, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1549, -835, 24, 2, 382, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1550, -844.1, 24, 2, 382, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1551, -901.4, 24, 2, 382, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1552, -715, 24, 2, 382, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1553, 340007, 24, 1, 376, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1554, 338502, 24, 1, 376, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1555, 1849.7, 24, 2, 381, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1556, 2216.9, 24, 2, 381, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1557, 1951.3, 24, 2, 381, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1558, -665, 24, 2, 383, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1559, -804.9, 24, 2, 383, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1560, -870.5, 24, 2, 383, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1561, 118, 24, 2, 389, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1562, -57.5, 24, 2, 389, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1563, -67.42857142857143, 24, 2, 389, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1564, -860.5, 24, 2, 383, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1565, 1841.1, 24, 2, 388, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1566, 1709.6, 24, 2, 388, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1567, 1981.5, 24, 2, 388, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1568, 2546.5, 24, 2, 388, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1569, 2076.5714285714284, 24, 2, 386, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1570, 302846, 24, 1, 385, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1571, 366690, 24, 1, 385, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1572, 273129, 24, 1, 385, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1573, 1803.5, 24, 2, 386, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1574, 2422, 24, 2, 388, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1575, -464.7, 24, 2, 383, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1576, -100.07142857142857, 24, 2, 389, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1577, 106674, 24, 1, 384, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1578, 56.857142857142854, 24, 2, 389, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1579, 2229.214285714286, 24, 2, 386, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1580, 314419, 24, 1, 385, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1581, 265866, 24, 1, 385, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1582, 1921.357142857143, 24, 2, 386, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1583, -462.7, 24, 2, 390, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1584, 59917, 24, 1, 384, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1585, -620.7, 24, 2, 390, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1586, 1978.7142857142858, 24, 2, 386, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1587, -393.2, 24, 2, 390, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1588, -319.6, 24, 2, 390, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1589, 116694, 24, 1, 384, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1590, -364.7, 24, 2, 390, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1591, 1121.2142857142858, 24, 2, 393, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1592, 1792.5, 24, 2, 393, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1593, 2229.9285714285716, 24, 2, 393, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1594, 2397.0714285714284, 24, 2, 393, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1595, 92061, 24, 1, 384, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1596, 1985, 24, 2, 393, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1597, 217451, 24, 1, 384, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1598, 56686, 24, 1, 395, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1599, 118, 24, 2, 397, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1600, -57.5, 24, 2, 397, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1601, -67.42857142857143, 24, 2, 397, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1602, -100.07142857142857, 24, 2, 397, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1603, 56.857142857142854, 24, 2, 397, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1604, 4772, 24, 5, 399, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1605, 5750, 24, 5, 399, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1606, 5369, 24, 5, 399, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1607, 4909, 24, 5, 399, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1608, 5212, 24, 5, 399, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1609, 3110, 24, 5, 403, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1610, 2967, 24, 5, 403, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1611, 3106, 24, 5, 403, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1612, 3042, 24, 5, 403, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1613, 3129, 24, 5, 403, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1614, 71510, 24, 1, 400, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1615, 28010, 24, 1, 395, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1616, 16483, 24, 1, 395, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1617, 30925, 24, 1, 400, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1618, 54756, 24, 1, 400, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1619, 42447, 24, 1, 400, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1620, 58481, 24, 1, 400, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1621, 3110, 24, 5, 406, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1622, 2967, 24, 5, 406, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1623, 3106, 24, 5, 406, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1624, 3042, 24, 5, 406, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1625, 61012.6, 24, 1, 405, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1626, 61012.6, 24, 1, 405, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1627, 61012.6, 24, 1, 405, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1628, 3129, 24, 5, 406, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1629, 61012.6, 24, 1, 405, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1630, 61012.6, 24, 1, 405, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1631, 5790, 24, 5, 409, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1632, 5450, 24, 5, 409, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1633, 3081, 24, 5, 410, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1634, 3010, 24, 5, 410, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1635, 3057, 24, 5, 410, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1636, 2017.6, 24, 2, 411, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1637, 3045, 24, 5, 410, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1638, 3123, 24, 5, 410, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1639, 5320, 24, 5, 409, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1640, 5085, 24, 5, 409, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1641, 6056, 24, 5, 409, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1642, 2061.8, 24, 2, 411, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1643, 1532.9, 24, 2, 411, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1644, 4138, 24, 5, 413, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1645, 3110, 24, 5, 414, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1646, 2967, 24, 5, 414, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1647, 3106, 24, 5, 414, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1648, 3042, 24, 5, 414, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1649, 3129, 24, 5, 414, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1650, 3110, 24, 5, 417, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1651, 2967, 24, 5, 417, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1652, 3106, 24, 5, 417, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1653, 3042, 24, 5, 417, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1654, 3129, 24, 5, 417, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1655, 4368, 24, 5, 413, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1656, 1734.4, 24, 2, 411, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1657, 2030.7, 24, 2, 411, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1658, 4258, 24, 5, 413, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1659, 4085, 24, 5, 413, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1660, 4230, 24, 5, 413, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1661, 2204.5, 24, 2, 418, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1662, 1666.6, 24, 2, 418, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1663, 2178.9, 24, 2, 418, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1664, 4290, 24, 5, 419, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1665, 1914.6, 24, 2, 420, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1666, 1366.1, 24, 2, 420, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1667, 1481.3, 24, 2, 420, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1668, 1390.8, 24, 2, 420, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1669, 2025, 24, 2, 420, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1670, 3936, 24, 5, 419, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1671, 3765, 24, 5, 419, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1672, 3589, 24, 5, 419, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1673, 3406, 24, 5, 419, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1674, 2015.7, 24, 2, 418, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1675, 2255.6, 24, 2, 418, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1676, 4138, 24, 5, 424, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1677, 2187.6, 24, 2, 423, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1678, 4368, 24, 5, 424, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1679, 4258, 24, 5, 424, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1680, 4085, 24, 5, 424, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1681, 4230, 24, 5, 424, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1682, 1240.3, 24, 2, 423, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1683, 1954.9, 24, 2, 427, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1684, 2214.5, 24, 2, 423, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1685, 2188, 24, 6, 430, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1686, 1678, 24, 2, 427, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1687, 1523.3, 24, 2, 427, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1688, 2190, 24, 6, 430, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1689, 2120.3, 24, 2, 423, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1690, 2206.6, 24, 2, 423, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1691, 2179, 24, 6, 430, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1692, 2188, 24, 6, 430, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1693, 2178, 24, 6, 430, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1694, 1690.1, 24, 2, 427, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1695, 1699, 24, 2, 427, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1696, 2166, 24, 6, 431, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1697, 2164, 24, 6, 431, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1698, 2188, 24, 6, 431, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1699, 2213, 24, 6, 431, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1700, 2166, 24, 6, 431, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1701, 2210, 24, 6, 433, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1702, 2215, 24, 6, 433, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1703, 2152, 24, 6, 433, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1704, 3192, 24, 6, 436, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1705, 3343, 24, 6, 436, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1706, 3105, 24, 6, 436, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1707, 3828, 24, 6, 436, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1708, 3774, 24, 6, 436, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1709, 2964, 24, 6, 439, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1710, 3221, 24, 6, 439, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1711, 3033, 24, 6, 439, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1712, 2174, 24, 6, 433, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1713, 2195, 24, 6, 433, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1714, 2859, 24, 6, 439, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1715, 2034.5, 24, 2, 435, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1716, 2818, 24, 6, 439, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1717, 1896.6, 24, 2, 438, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1718, 2166, 24, 6, 440, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1719, 2161, 24, 6, 441, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1720, 1174.6, 24, 2, 435, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1721, 2143, 24, 6, 441, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1722, 2164, 24, 6, 440, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1723, 2282.8, 24, 2, 438, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1724, 2188, 24, 6, 440, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1725, 2145, 24, 6, 441, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1726, 2220.9, 24, 2, 435, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1727, 2128, 24, 6, 441, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1728, 2161, 24, 6, 441, 17, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1729, 2213, 24, 6, 440, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1730, 1795.9, 24, 2, 438, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1731, 1648.8, 24, 2, 438, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1732, 2170.3, 24, 2, 438, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1733, 2166, 24, 6, 440, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1734, 1915, 24, 2, 435, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1735, 1944.1, 24, 2, 435, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1736, 3192, 24, 6, 447, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1737, 1675.2, 24, 2, 446, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1738, 3343, 24, 6, 447, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1739, 3105, 24, 6, 447, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1740, 3828, 24, 6, 447, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1741, 2228.5, 24, 2, 448, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1742, 3774, 24, 6, 447, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1743, 1954, 24, 2, 446, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1744, 1805.7, 24, 2, 448, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1745, 2192, 24, 6, 449, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1746, 2177, 24, 6, 449, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1747, 1658.2, 24, 2, 446, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1748, 2180, 24, 6, 449, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1749, 2182, 24, 6, 449, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1750, 1958.8, 24, 2, 448, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1751, 1740.1, 24, 2, 448, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1752, 2178, 24, 6, 449, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1753, 1859.8, 24, 2, 446, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1754, 1980.7, 24, 2, 446, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1755, 2161, 24, 6, 453, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1756, 1591, 24, 2, 448, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1757, 2143, 24, 6, 453, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1758, 2145, 24, 6, 453, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1759, 2128, 24, 6, 453, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1760, 2161, 24, 6, 453, 18, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1761, 2099.4, 24, 2, 457, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1762, 2139.7, 24, 2, 457, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1763, 1433.2, 24, 2, 457, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1764, 1956, 24, 2, 458, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1765, 1684, 24, 2, 457, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1766, 2391.6, 24, 2, 457, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1767, 1614.4, 24, 2, 458, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1768, 1761.8, 24, 2, 458, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1769, 2117.4, 24, 2, 458, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1770, 1831.9, 24, 2, 458, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1771, 1636, 24, 2, 460, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1772, 1803.9, 24, 2, 460, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1773, 1739.8, 24, 2, 460, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1774, 1824.5, 24, 2, 460, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1775, 2373, 24, 2, 460, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1776, 1731.1, 24, 2, 461, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1777, 1615, 24, 2, 461, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1778, 1557.7, 24, 2, 461, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1779, 1895.1, 24, 2, 461, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1780, 2360, 24, 2, 461, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1781, 1006, 24, 2, 466, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1782, 1605.9, 24, 2, 466, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1783, 1655.9, 24, 2, 466, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1784, 1283.8, 24, 2, 466, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1785, 1588, 24, 2, 464, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1786, 2036.1, 24, 2, 464, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1787, 1674.1, 24, 2, 466, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1788, 1882.4, 24, 2, 464, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1789, -549.1, 24, 2, 473, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1790, -361.7, 24, 2, 473, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1791, -571.7, 24, 2, 473, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1792, -327.8, 24, 2, 473, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1793, -443.8, 24, 2, 473, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1794, 2028.2, 24, 2, 470, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1795, 2048.9, 24, 2, 470, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1796, 1773.1, 24, 2, 470, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1797, 2043.8, 24, 2, 470, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1798, 1714.7, 24, 2, 470, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1799, 4080, 24, 4, 474, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1800, 4390, 24, 4, 474, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1801, 3975, 24, 4, 474, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1802, 4210, 24, 4, 474, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1803, 4292, 24, 4, 474, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1804, 2945, 24, 4, 477, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1805, 2902, 24, 4, 477, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1806, 2975, 24, 4, 477, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1807, 3055, 24, 4, 477, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1808, 2860, 24, 4, 477, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1809, -31.3, 24, 2, 475, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1810, -320, 24, 2, 475, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1811, 3820, 24, 4, 478, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1812, 4779, 24, 4, 478, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1813, 4156, 24, 4, 478, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1814, 4456, 24, 4, 478, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1815, 4459, 24, 4, 478, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1816, 4117, 24, 4, 479, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1817, 4010, 24, 4, 479, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1818, 4593, 24, 4, 479, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1819, 4730, 24, 4, 479, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1820, 4185, 24, 4, 479, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1821, -156.3, 24, 2, 475, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1822, 4278, 24, 4, 481, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1823, 4133, 24, 4, 481, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1824, 4413, 24, 4, 481, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1825, 4608, 24, 4, 481, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1826, 4386, 24, 4, 481, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1827, 2894, 24, 4, 480, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1828, 2968, 24, 4, 480, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1829, 3117, 24, 4, 480, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1830, 3069, 24, 4, 480, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1831, 3130, 24, 4, 480, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1832, 4183, 24, 4, 483, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1833, 4207, 24, 4, 483, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1834, 4258, 24, 4, 483, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1835, 4448, 24, 4, 483, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1836, 4416, 24, 4, 483, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1837, 2607, 24, 4, 482, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1838, -313.1, 24, 2, 475, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1839, 2604, 24, 4, 482, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1840, 3318, 24, 4, 485, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1841, 2551, 24, 4, 484, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1842, 2604, 24, 4, 484, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1843, 2573, 24, 4, 484, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1844, 2568, 24, 4, 484, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1845, 2521, 24, 4, 484, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1846, 4615, 24, 4, 485, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1847, 2560, 24, 4, 482, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1848, 2544, 24, 4, 482, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1849, 2531, 24, 4, 482, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1850, 3215, 24, 4, 487, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1851, 3164, 24, 4, 487, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1852, 3264, 24, 4, 487, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1853, 3196, 24, 4, 487, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1854, 3372, 24, 4, 487, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1855, 4204, 24, 4, 485, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1856, 4293, 24, 4, 485, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1857, 3201, 24, 4, 486, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1858, 3135, 24, 4, 486, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1859, 4351, 24, 4, 485, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1860, 2098, 24, 3, 488, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1861, 3168, 24, 4, 486, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1862, 3205, 24, 4, 486, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1863, 3364, 24, 4, 486, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1864, 2080, 24, 3, 488, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1865, 2076, 24, 3, 488, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1866, 2072, 24, 3, 488, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1867, 3051, 24, 4, 489, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1868, 2831, 24, 4, 489, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1869, 3098, 24, 4, 489, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1870, 2976, 24, 4, 489, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1871, 3839, 24, 4, 490, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1872, 3124, 24, 4, 491, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1873, 3440, 24, 4, 491, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1874, 3253, 24, 4, 491, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1875, 3123, 24, 4, 491, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1876, 3311, 24, 4, 491, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1877, 4412, 24, 4, 490, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1878, 4464, 24, 4, 490, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1879, 4716, 24, 4, 490, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1880, 4241, 24, 4, 490, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1881, 2923, 24, 4, 489, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1882, 2032, 24, 3, 488, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1883, 2648, 24, 4, 493, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1884, 2600, 24, 4, 493, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1885, 2540, 24, 4, 493, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1886, 2483, 24, 4, 493, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1887, 4107, 24, 4, 494, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1888, 4307, 24, 4, 494, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1889, 2625, 24, 4, 493, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1890, 4158, 24, 4, 495, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1891, 4316, 24, 4, 495, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1892, 3745, 24, 4, 495, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1893, 3205, 24, 4, 497, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1894, 3170, 24, 4, 497, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1895, 4377, 24, 4, 494, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1896, 4351, 24, 4, 494, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1897, 4126, 24, 4, 494, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1898, 3396, 24, 4, 497, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1899, 3186, 24, 4, 497, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1900, 3347, 24, 4, 497, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1901, 4278, 24, 4, 495, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1902, 4607, 24, 4, 495, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1903, 3980, 24, 4, 498, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1904, 2043, 24, 3, 496, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1905, 4090, 24, 4, 498, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1906, 3551, 24, 4, 500, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1907, 4283, 24, 4, 499, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1908, 4403, 24, 4, 499, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1909, 4571, 24, 4, 500, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1910, 4296, 24, 4, 498, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1911, 2069, 24, 3, 496, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1912, 2074, 24, 3, 496, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1913, 2076, 24, 3, 496, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1914, 4150, 24, 4, 498, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1915, 3697, 24, 4, 498, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1916, 4457, 24, 4, 500, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1917, 4630, 24, 4, 499, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1918, 4492, 24, 4, 499, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1919, 4564, 24, 4, 500, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1920, 4179, 24, 4, 500, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1921, 2068, 24, 3, 496, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1922, 2852, 24, 4, 501, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1923, 2875, 24, 4, 501, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1924, 2720, 24, 4, 501, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1925, 4255, 24, 4, 499, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1926, 2748, 24, 4, 501, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1927, 2720, 24, 4, 501, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1928, 2646, 24, 4, 504, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1929, 3303, 24, 4, 505, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1930, 4126, 24, 4, 505, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1931, 4315, 24, 4, 505, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1932, 2079, 24, 3, 502, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1933, 2053, 24, 3, 502, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1934, 2075, 24, 3, 502, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1935, 4383, 24, 4, 505, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1936, 2776, 24, 4, 504, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1937, 2821, 24, 4, 504, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1938, 5140, 24, 4, 505, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1939, 2088, 24, 3, 502, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1940, 2728, 24, 4, 504, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1941, 2811, 24, 4, 504, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1942, 3192, 24, 4, 507, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1943, 3159, 24, 4, 507, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1944, 3081, 24, 4, 507, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1945, 3069, 24, 4, 507, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1946, 3275, 24, 4, 507, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1947, 3082, 24, 4, 506, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1948, 3066, 24, 4, 506, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1949, 2869, 24, 4, 506, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1950, 3069, 24, 4, 506, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1951, 3042, 24, 4, 506, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1952, 2068, 24, 3, 502, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1953, 3765, 24, 4, 509, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1954, 3327, 24, 4, 509, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1955, 3388, 24, 4, 509, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1956, 3569, 24, 4, 509, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1957, 3486, 24, 4, 509, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1958, 3664, 24, 4, 508, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1959, 4075, 24, 4, 508, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1960, 4032, 24, 4, 508, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1961, 4595, 24, 4, 508, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1962, 4399, 24, 4, 508, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1963, 3377, 24, 4, 511, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1964, 4295, 24, 4, 511, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1965, 4300, 24, 4, 511, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1966, 4086, 24, 4, 511, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1967, 3935, 24, 4, 511, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1968, 4180, 24, 4, 510, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1969, 4697, 24, 4, 510, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1970, 4422, 24, 4, 510, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1971, 4514, 24, 4, 510, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1972, 4596, 24, 4, 510, 12, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1973, 3473, 24, 4, 512, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1974, 3806, 24, 4, 512, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1975, 3409, 24, 4, 512, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1976, 3595, 24, 4, 512, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1977, 3437, 24, 4, 512, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1978, 4617, 24, 4, 515, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1979, 4371, 24, 4, 515, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1980, 2038, 24, 3, 513, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1981, 2066, 24, 3, 513, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1982, 3307, 24, 4, 514, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1983, 3950, 24, 4, 514, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1984, 4366, 24, 4, 514, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1985, 4594, 24, 4, 514, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1986, 4470, 24, 4, 514, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1987, 5004, 24, 4, 515, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1988, 4821, 24, 4, 515, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1989, 2058, 24, 3, 513, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1990, 2059, 24, 3, 513, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1991, 3909, 24, 4, 515, 10, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1992, 2029, 24, 3, 513, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1993, 3536, 24, 4, 516, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1994, 3612, 24, 4, 516, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1995, 3411, 24, 4, 516, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1996, 3793, 24, 4, 516, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1997, 3642, 24, 4, 516, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1998, 2190, 24, 3, 518, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1999, 2235, 24, 3, 518, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2000, 2237, 24, 3, 518, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2001, 2194, 24, 3, 518, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2002, 3685, 24, 4, 519, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2003, 2308, 24, 3, 518, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2004, 5170, 24, 4, 519, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2005, 4416, 24, 4, 519, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2006, 4924, 24, 4, 519, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2007, 2037, 24, 3, 520, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2008, 2060, 24, 3, 520, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2009, 2044, 24, 3, 520, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2010, 2063, 24, 3, 520, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2011, 2073, 24, 3, 520, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2012, 5209, 24, 4, 519, 11, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2013, 2085, 24, 3, 522, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2014, 2083, 24, 3, 522, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2015, 2082, 24, 3, 522, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2016, 2084, 24, 3, 522, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2017, 2073, 24, 3, 522, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2018, 2022, 24, 3, 523, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2019, 2100, 24, 3, 523, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2020, 2076, 24, 3, 523, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2021, 2085, 24, 3, 523, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2022, 2070, 24, 3, 523, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2023, 2030, 24, 3, 525, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2024, 2041, 24, 3, 525, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2025, 2045, 24, 3, 525, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2026, 2055, 24, 3, 525, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2027, 2024, 24, 3, 525, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2028, 2033, 24, 3, 527, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2029, 2061, 24, 3, 527, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2030, 2057, 24, 3, 527, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2031, 2062, 24, 3, 527, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2032, 2054, 24, 3, 527, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2033, 2035, 24, 3, 528, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2034, 2044, 24, 3, 528, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2035, 2051, 24, 3, 528, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2036, 2042, 24, 3, 528, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2037, 1984, 24, 3, 528, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2038, 2026, 24, 3, 530, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2039, 2050, 24, 3, 530, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2040, 2020, 24, 3, 530, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2041, 2057, 24, 3, 530, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2042, 2040, 24, 3, 530, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2043, 3699, 24, 4, 531, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2044, 3513, 24, 4, 531, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2045, 3554, 24, 4, 531, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2046, 3756, 24, 4, 531, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2047, 4062, 24, 4, 531, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2048, 3430, 24, 4, 532, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2049, 3402, 24, 4, 532, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2050, 3431, 24, 4, 532, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2051, 3429, 24, 4, 532, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2052, 3692, 24, 4, 532, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2053, 3654, 24, 4, 534, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2054, 3832, 24, 4, 534, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2055, 3739, 24, 4, 534, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2056, 3724, 24, 4, 534, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2057, 3941, 24, 4, 534, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2058, 2563, 24, 4, 535, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2059, 2484, 24, 4, 535, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2060, 2510, 24, 4, 535, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2061, 2536, 24, 4, 535, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2062, 2488, 24, 4, 535, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2063, 3081, 24, 4, 537, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2064, 3066, 24, 4, 537, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2065, 3083, 24, 4, 537, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2066, 3055, 24, 4, 537, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2067, 3237, 24, 4, 537, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2068, 3474, 24, 4, 538, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2069, 3530, 24, 4, 538, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2070, 3694, 24, 4, 538, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2071, 3069, 24, 4, 538, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2072, 3859, 24, 4, 538, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2073, 3440, 24, 4, 539, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2074, 3456, 24, 4, 539, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2075, 3581, 24, 4, 539, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2076, 3615, 24, 4, 539, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2077, 3632, 24, 4, 539, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2078, 3532, 24, 4, 541, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2079, 3515, 24, 4, 541, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2080, 3617, 24, 4, 541, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2081, 3474, 24, 4, 541, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2082, 4122, 24, 4, 541, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2083, 3618, 24, 4, 542, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2084, 3368, 24, 4, 542, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2085, 3433, 24, 4, 542, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2086, 3424, 24, 4, 542, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2087, 3887, 24, 4, 542, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2088, 3424, 24, 4, 544, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2089, 3610, 24, 4, 544, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2090, 3728, 24, 4, 544, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2091, 3463, 24, 4, 544, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2092, 3808, 24, 4, 544, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2093, 3366, 24, 4, 545, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2094, 3284, 24, 4, 545, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2095, 3821, 24, 4, 545, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2096, 3221, 24, 4, 545, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2097, 3440, 24, 4, 545, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2098, 4064, 24, 4, 546, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2099, 4088, 24, 4, 546, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2100, 4065, 24, 4, 546, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2101, 4176, 24, 4, 546, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2102, 4068, 24, 4, 546, 16, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2103, 4233, 24, 4, 547, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2104, 4113, 24, 4, 547, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2105, 4574, 24, 4, 547, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2106, 4342, 24, 4, 547, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2107, 4340, 24, 4, 547, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2108, 4119, 24, 4, 548, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2109, 3853, 24, 4, 548, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2110, 4093, 24, 4, 548, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2111, 4553, 24, 4, 548, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2112, 4233, 24, 4, 548, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2113, 4273, 24, 4, 549, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2114, 4104, 24, 4, 549, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2115, 4341, 24, 4, 549, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2116, 4430, 24, 4, 549, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2117, 4365, 24, 4, 549, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2118, 2601, 24, 4, 550, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2119, 2580, 24, 4, 550, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2120, 2518, 24, 4, 550, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2121, 2672, 24, 4, 550, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2122, 2497, 24, 4, 550, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2123, 3213, 24, 4, 551, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2124, 3175, 24, 4, 551, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2125, 3159, 24, 4, 551, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2126, 3157, 24, 4, 551, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2127, 3312, 24, 4, 551, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2128, 4314, 24, 4, 552, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2129, 4469, 24, 4, 552, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2130, 4908, 24, 4, 552, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2131, 4187, 24, 4, 552, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2132, 3992, 24, 4, 552, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2133, 4271, 24, 4, 553, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2134, 4086, 24, 4, 553, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2135, 4757, 24, 4, 553, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2136, 4180, 24, 4, 553, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2137, 3924, 24, 4, 553, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2138, 4674, 24, 4, 554, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2139, 4586, 24, 4, 554, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2140, 4314, 24, 4, 554, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2141, 4688, 24, 4, 554, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2142, 4821, 24, 4, 554, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2143, 3935, 24, 4, 555, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2144, 4350, 24, 4, 555, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2145, 4708, 24, 4, 555, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2146, 4288, 24, 4, 555, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2147, 4167, 24, 4, 555, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2148, 4096, 24, 4, 556, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2149, 4073, 24, 4, 556, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2150, 4509, 24, 4, 556, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2151, 4513, 24, 4, 556, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2152, 3675, 24, 4, 556, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2153, 3519, 24, 4, 557, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2154, 3266, 24, 4, 557, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2155, 3648, 24, 4, 557, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2156, 3371, 24, 4, 557, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2157, 3501, 24, 4, 557, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2158, 4807, 24, 4, 558, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2159, 4843, 24, 4, 558, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2160, 4479, 24, 4, 558, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2161, 4333, 24, 4, 558, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2162, 4782, 24, 4, 558, 14, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1, 806531, 24, 1, 1, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (2, 836036, 24, 1, 2, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (3, 80814, 24, 1, 1, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (4, 986336, 24, 1, 3, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (5, 1020150, 24, 1, 4, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (6, 2076.5714285714284, 24, 2, 6, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (7, 1803.5, 24, 2, 6, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (8, 1014035, 24, 1, 4, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (9, 959688, 24, 1, 4, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (10, 620463, 24, 1, 3, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (11, 676345, 24, 1, 1, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (12, 790199, 24, 1, 1, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (13, 730378, 24, 1, 3, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (14, 1012650, 24, 1, 4, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (15, 813142, 24, 1, 4, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (16, 2229.214285714286, 24, 2, 6, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (17, 1921.357142857143, 24, 2, 6, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (18, 776532, 24, 1, 3, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (19, 700686, 24, 1, 1, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (20, 755260, 24, 1, 2, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (21, 1378.7142857142858, 24, 2, 5, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (22, 769057, 24, 1, 2, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (23, 953367, 24, 1, 3, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (24, 1978.7142857142858, 24, 2, 6, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (25, 933640, 24, 1, 7, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (26, 1845.142857142857, 24, 2, 5, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (27, 904170, 24, 1, 7, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (28, 234332, 24, 1, 7, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (29, 80267, 24, 1, 8, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (30, 1858, 24, 2, 5, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (31, 62111, 24, 1, 8, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (32, 812797, 24, 1, 9, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (33, 909994, 24, 1, 7, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (34, 1136, 24, 2, 10, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (35, 1523.2142857142858, 24, 2, 10, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (36, 934119, 24, 1, 7, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (37, 272826, 24, 1, 9, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (38, 83939, 24, 1, 8, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (39, 76028, 24, 1, 12, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (40, 2258.1428571428573, 24, 2, 5, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (41, 56553, 24, 1, 12, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (42, 71081, 24, 1, 8, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (43, 533816, 24, 1, 9, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (44, 1958.7142857142858, 24, 2, 10, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (45, 467098, 24, 1, 11, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (46, 1873.2142857142858, 24, 2, 10, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (47, 632092, 24, 1, 9, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (48, 75073, 24, 1, 8, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (49, 56148, 24, 1, 12, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (50, 1403, 24, 2, 5, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (51, 55282, 24, 1, 12, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (52, 913357, 24, 1, 9, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (53, 62112, 24, 1, 13, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (54, 2614.3571428571427, 24, 2, 10, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (55, 320367, 24, 1, 11, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (56, 887325, 24, 1, 13, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (57, 75858, 24, 1, 12, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (58, 1216369, 24, 1, 14, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (59, 1148704, 24, 1, 16, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (60, 1011692, 24, 1, 13, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (61, 345172, 24, 1, 11, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (62, 118, 24, 2, 15, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (63, -57.5, 24, 2, 15, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (64, -67.42857142857143, 24, 2, 15, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (65, -100.07142857142857, 24, 2, 15, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (66, 56.857142857142854, 24, 2, 15, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (67, 849064, 24, 1, 13, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (68, 936408, 24, 1, 13, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (69, 695448, 24, 1, 16, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (70, 893503, 24, 1, 16, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (71, 133805, 24, 1, 16, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (72, 949051, 24, 1, 16, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (73, 1021352, 24, 1, 14, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (74, 913706, 24, 1, 14, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (75, 913780, 24, 1, 14, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (76, 1223157, 24, 1, 14, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (77, 774470, 24, 1, 17, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (78, 668068, 24, 1, 17, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (79, 943072, 24, 1, 17, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (80, 965141, 24, 1, 17, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (81, 1051220, 24, 1, 17, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (82, 40693, 24, 1, 20, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (83, 42727, 24, 1, 20, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (84, 28305, 24, 1, 20, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (85, 35920, 24, 1, 20, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (86, 927310, 24, 1, 19, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (87, 917353, 24, 1, 19, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (88, 816184, 24, 1, 19, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (89, 875615, 24, 1, 19, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (90, 905534, 24, 1, 19, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (91, 162058, 24, 1, 11, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (92, 416107, 24, 1, 11, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (93, 1160630, 24, 1, 23, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (94, 34114, 24, 1, 20, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (95, 59298, 24, 1, 22, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (96, 28688, 24, 1, 22, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (97, 33017, 24, 1, 22, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (98, 32289, 24, 1, 22, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (99, 47232, 24, 1, 22, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (100, 1905, 24, 2, 21, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (101, 1655.357142857143, 24, 2, 21, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (102, 1476.142857142857, 24, 2, 21, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (103, 1696.7857142857142, 24, 2, 21, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (104, 1360.5, 24, 2, 21, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (105, 878093, 24, 1, 26, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (106, 814698, 24, 1, 26, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (107, 770604, 24, 1, 25, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (108, 851711, 24, 1, 23, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (109, 315456, 24, 1, 24, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (110, 287647, 24, 1, 24, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (111, 318140, 24, 1, 24, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (112, 362966, 24, 1, 24, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (113, 984803, 24, 1, 23, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (114, 287120, 24, 1, 25, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (115, 800748, 24, 1, 25, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (116, 624891, 24, 1, 25, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (117, 833080, 24, 1, 25, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (118, 988049, 24, 1, 27, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (119, 626351, 24, 1, 27, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (120, 670904, 24, 1, 27, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (121, 887567, 24, 1, 27, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (122, 871024, 24, 1, 26, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (123, 1102573, 24, 1, 27, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (124, 909057, 24, 1, 28, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (125, 680684, 24, 1, 28, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (126, 343237, 24, 1, 28, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (127, 575829, 24, 1, 28, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (128, 844012, 24, 1, 28, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (129, 992698, 24, 1, 23, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (130, 344738, 24, 1, 24, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (131, 1035927, 24, 1, 23, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (132, 925781, 24, 1, 31, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (133, 704584, 24, 1, 31, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (134, 459260, 24, 1, 30, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (135, 71024, 24, 1, 30, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (136, 751072, 24, 1, 30, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (137, 847965, 24, 1, 30, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (138, 110580, 24, 1, 30, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (139, 811577, 24, 1, 35, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (140, 142827, 24, 1, 35, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (141, 751315, 24, 1, 35, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (142, 621363, 24, 1, 35, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (143, 680082, 24, 1, 35, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (144, 44607, 24, 1, 34, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (145, 70257, 24, 1, 31, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (146, 941838, 24, 1, 33, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (147, 469720, 24, 1, 32, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (148, 821553, 24, 1, 33, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (149, 560225, 24, 1, 31, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (150, 37070, 24, 1, 34, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (151, 31853, 24, 1, 34, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (152, 45443, 24, 1, 34, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (153, 51903, 24, 1, 36, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (154, 41412, 24, 1, 36, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (155, 34897, 24, 1, 36, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (156, 36651, 24, 1, 36, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (157, 118, 24, 2, 29, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (158, 33855, 24, 1, 34, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (159, 1040112, 24, 1, 31, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (160, 439028, 24, 1, 33, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (161, 5790, 24, 5, 37, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (162, 5450, 24, 5, 37, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (163, 5320, 24, 5, 37, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (164, 5085, 24, 5, 37, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (165, 6056, 24, 5, 37, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (166, 960206, 24, 1, 33, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (167, -57.5, 24, 2, 29, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (168, 53446, 24, 1, 38, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (169, 43259, 24, 1, 38, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (170, 36342, 24, 1, 38, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (171, 39349, 24, 1, 38, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (172, 50332, 24, 1, 38, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (173, 554090, 24, 1, 39, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (174, 60788, 24, 1, 39, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (175, 508846, 24, 1, 39, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (176, 709455, 24, 1, 33, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (177, 3110, 24, 5, 40, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (178, 2967, 24, 5, 40, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (179, 3106, 24, 5, 40, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (180, 364065, 24, 1, 32, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (181, 3042, 24, 5, 40, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (182, 834296, 24, 1, 42, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (183, 412990, 24, 1, 39, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (184, 524588, 24, 1, 39, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (185, 37103, 24, 1, 41, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (186, 55462, 24, 1, 41, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (187, -67.42857142857143, 24, 2, 29, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (188, 69187, 24, 1, 43, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (189, 75958, 24, 1, 43, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (190, 68035, 24, 1, 43, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (191, 111514, 24, 1, 43, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (192, 78580, 24, 1, 43, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (193, 31028, 24, 1, 41, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (194, 770050, 24, 1, 42, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (195, 3129, 24, 5, 40, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (196, 300923, 24, 1, 32, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (197, 795779, 24, 1, 42, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (198, 746222, 24, 1, 42, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (199, 686647, 24, 1, 42, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (200, 46228, 24, 1, 41, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (201, 55763, 24, 1, 41, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (202, -100.07142857142857, 24, 2, 29, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (203, 56.857142857142854, 24, 2, 29, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (204, 86395, 24, 1, 47, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (205, 69986, 24, 1, 47, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (206, 58939, 24, 1, 47, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (207, 70667, 24, 1, 47, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (208, 69575, 24, 1, 47, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (209, 65072, 24, 1, 46, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (210, 70955, 24, 1, 46, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (211, 102584, 24, 1, 46, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (212, 58311, 24, 1, 46, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (213, 100704, 24, 1, 46, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (214, 794644, 24, 1, 44, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (215, 636955, 24, 1, 44, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (216, 749282, 24, 1, 44, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (217, 628674, 24, 1, 44, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (218, 616437, 24, 1, 44, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (219, 3110, 24, 5, 45, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (220, 2967, 24, 5, 45, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (221, 3106, 24, 5, 45, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (222, 474513, 24, 1, 32, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (223, 3042, 24, 5, 45, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (224, 3129, 24, 5, 45, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (225, 774015, 24, 1, 51, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (226, 47985, 24, 1, 49, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (227, 73901, 24, 1, 49, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (228, 47257, 24, 1, 49, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (229, 33801, 24, 1, 49, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (230, 61993, 24, 1, 49, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (231, 1683.6, 24, 2, 54, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (232, 1960.8, 24, 2, 54, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (233, 1581.2, 24, 2, 54, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (234, 1496.1, 24, 2, 54, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (235, 1691.8, 24, 2, 54, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (236, 106674, 24, 1, 50, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (237, 59917, 24, 1, 50, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (238, 116694, 24, 1, 50, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (239, 92061, 24, 1, 50, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (240, 217451, 24, 1, 50, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (241, 787345, 24, 1, 51, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (242, 85582, 24, 1, 51, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (243, 843894, 24, 1, 51, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (244, 881638, 24, 1, 51, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (245, 4180, 24, 5, 53, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (246, 4094, 24, 5, 53, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (247, 3676, 24, 5, 53, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (248, 3541, 24, 5, 53, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (249, 301959, 24, 1, 52, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (250, 322786, 24, 1, 52, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (251, 299622, 24, 1, 52, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (252, 345379, 24, 1, 52, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (253, 3676, 24, 5, 53, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (254, 131096, 24, 1, 57, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (255, 92415, 24, 1, 57, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (256, 78804, 24, 1, 57, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (257, 146330, 24, 1, 57, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (258, 182153, 24, 1, 57, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (259, 1853.4, 24, 2, 56, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (260, 1757.2, 24, 2, 56, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (261, 1517.8, 24, 2, 56, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (262, 1780.3, 24, 2, 55, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (263, 1320.1, 24, 2, 55, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (264, 1912, 24, 2, 56, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (265, 93831, 24, 1, 59, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (266, 70767, 24, 1, 59, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (267, 71600, 24, 1, 59, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (268, 39602, 24, 1, 59, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (269, 4138, 24, 5, 58, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (270, 4368, 24, 5, 58, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (271, 4258, 24, 5, 58, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (272, 4085, 24, 5, 58, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (273, 4230, 24, 5, 58, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (274, 323199, 24, 1, 52, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (275, 65834, 24, 1, 59, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (276, 1817.9, 24, 2, 56, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (277, 812.2, 24, 2, 55, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (278, 1311.5, 24, 2, 55, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (279, 1523.9, 24, 2, 55, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (280, 71510, 24, 1, 60, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (281, 30925, 24, 1, 60, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (282, 54756, 24, 1, 60, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (283, 42447, 24, 1, 60, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (284, 58481, 24, 1, 60, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (285, 1302.4, 24, 2, 63, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (286, 1589.5, 24, 2, 62, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (287, 1349.4, 24, 2, 62, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (288, 1965.7, 24, 2, 62, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (289, 1955.8, 24, 2, 62, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (290, 2092.3, 24, 2, 62, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (291, 1253.2, 24, 2, 63, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (292, 2017.6, 24, 2, 66, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (293, 2061.8, 24, 2, 66, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (294, 1532.9, 24, 2, 66, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (295, 1734.4, 24, 2, 66, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (296, 2877, 24, 2, 65, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (297, 2030.7, 24, 2, 66, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (298, 1508.0714285714284, 24, 2, 63, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (299, 1369.8, 24, 2, 63, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (300, 697.1, 24, 2, 67, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (301, 749.9, 24, 2, 67, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (302, 723.8, 24, 2, 67, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (303, 947.2, 24, 2, 67, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (304, 934, 24, 2, 67, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (305, 1499.1, 24, 2, 63, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (306, 2431.1, 24, 2, 65, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (307, 2234.7, 24, 2, 65, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (308, 159171, 24, 1, 64, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (309, 2058, 24, 2, 65, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (310, 1914.6, 24, 2, 68, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (311, 1461, 24, 2, 69, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (312, 2217.1, 24, 2, 69, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (313, 2217.5, 24, 2, 70, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (314, 2107, 24, 2, 70, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (315, 1885.5, 24, 2, 70, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (316, 1366.1, 24, 2, 68, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (317, 1481.3, 24, 2, 68, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (318, 1390.8, 24, 2, 68, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (319, 2025, 24, 2, 68, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (320, 2038.9, 24, 2, 65, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (321, 275544, 24, 1, 64, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (322, 455402, 24, 1, 64, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (323, 296224, 24, 1, 64, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (324, 2210, 24, 6, 73, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (325, 2215, 24, 6, 73, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (326, 2152, 24, 6, 73, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (327, 2174, 24, 6, 73, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (328, 2195, 24, 6, 73, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (329, 2248.5, 24, 2, 72, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (330, 2346.3, 24, 2, 72, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (331, 2199.6, 24, 2, 72, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (332, 2023.3, 24, 2, 72, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (333, 2175.6, 24, 2, 72, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (334, 2187.6, 24, 2, 71, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (335, 1783, 24, 2, 70, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (336, 2234.9, 24, 2, 70, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (337, 1462.3, 24, 2, 69, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (338, 1748.3, 24, 2, 69, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (339, 1576.6, 24, 2, 69, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (340, 1240.3, 24, 2, 71, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (341, 2166, 24, 6, 75, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (342, 2164, 24, 6, 75, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (343, 2188, 24, 6, 75, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (344, 368064, 24, 1, 74, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (345, 274309, 24, 1, 74, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (346, 2213, 24, 6, 75, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (347, 2214.5, 24, 2, 71, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (348, 2120.3, 24, 2, 71, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (349, 2206.6, 24, 2, 71, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (350, 731.9, 24, 2, 76, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (351, 713.3, 24, 2, 76, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (352, 543, 24, 2, 76, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (353, 488.2, 24, 2, 76, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (354, 512.8, 24, 2, 76, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (355, 1474.1, 24, 2, 79, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (356, 1304.8, 24, 2, 79, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (357, 1786.9, 24, 2, 78, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (358, 2272.6, 24, 2, 77, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (359, 2113.6, 24, 2, 77, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (360, 2380, 24, 2, 77, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (361, 1995.1, 24, 2, 77, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (362, 2047.2, 24, 2, 77, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (363, 2166, 24, 6, 75, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (364, 311365, 24, 1, 74, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (365, 343043, 24, 1, 74, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (366, 431351, 24, 1, 74, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (367, 3192, 24, 6, 82, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (368, 2034.5, 24, 2, 81, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (369, 1174.6, 24, 2, 81, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (370, 2220.9, 24, 2, 81, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (371, 1915, 24, 2, 81, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (372, 1944.1, 24, 2, 81, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (373, 1498.9, 24, 2, 78, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (374, 1379, 24, 2, 79, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (375, 1367.285714285714, 24, 2, 79, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (376, 5515, 24, 5, 80, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (377, 1818, 24, 2, 78, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (378, 2228.5, 24, 2, 85, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (379, 2390.9, 24, 2, 84, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (380, 3343, 24, 6, 82, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (381, 3105, 24, 6, 82, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (382, 3828, 24, 6, 82, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (383, 2400.2, 24, 2, 84, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (384, 1805.7, 24, 2, 85, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (385, 1823.8, 24, 2, 78, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (386, 1946.8, 24, 2, 78, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (387, 5746, 24, 5, 80, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (388, 829.2, 24, 2, 86, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (389, 1958.8, 24, 2, 85, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (390, 2026.5, 24, 2, 84, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (391, 3774, 24, 6, 82, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (392, 392331, 24, 1, 83, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (393, 2487.4, 24, 2, 84, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (394, 1740.1, 24, 2, 85, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (395, 864.4, 24, 2, 86, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (396, 6099, 24, 5, 80, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (397, 1488.9, 24, 2, 86, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (398, 1591, 24, 2, 85, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (399, 2352.4, 24, 2, 84, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (400, 259762, 24, 1, 83, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (401, 295342, 24, 1, 83, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (402, 2182, 24, 6, 87, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (403, 1617.7, 24, 2, 88, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (404, 1344.4, 24, 2, 88, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (405, 1526.2, 24, 2, 88, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (406, 1724.6, 24, 2, 88, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (407, 1045, 24, 2, 88, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (408, 1195.6, 24, 2, 86, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (409, 6630, 24, 5, 80, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (410, 2165, 24, 6, 87, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (411, 340007, 24, 1, 83, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (412, 2177, 24, 6, 87, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (413, 2463.8, 24, 2, 89, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (414, 6289, 24, 5, 80, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (415, 1221.4, 24, 2, 90, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (416, 2099.4, 24, 2, 91, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (417, 2374.5, 24, 2, 89, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (418, 2339, 24, 6, 87, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (419, 338502, 24, 1, 83, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (420, 2184, 24, 6, 87, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (421, 2113.1, 24, 2, 89, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (422, 2139.7, 24, 2, 91, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (423, 1577.8, 24, 2, 90, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (424, 745.5, 24, 2, 92, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (425, 1081.7, 24, 2, 92, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (426, 673.9, 24, 2, 90, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (427, 1433.2, 24, 2, 91, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (428, 2365.6, 24, 2, 89, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (429, 2161, 24, 6, 93, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (430, 2143, 24, 6, 93, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (431, 2145, 24, 6, 93, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (432, 2356.8, 24, 2, 89, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (433, 1684, 24, 2, 91, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (434, 2391.6, 24, 2, 91, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (435, 1554, 24, 2, 90, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (436, 1234, 24, 2, 90, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (437, 668.1, 24, 2, 92, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (438, 1096.3, 24, 2, 92, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (439, 1023.7, 24, 2, 92, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (440, 1034.5, 24, 2, 97, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (441, 868.6, 24, 2, 97, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (442, 799.9, 24, 2, 97, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (443, 790.4, 24, 2, 97, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (444, 1137.6, 24, 2, 97, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (445, 1636, 24, 2, 96, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (446, 1921.9, 24, 2, 95, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (447, 2010.3, 24, 2, 95, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (448, 1533.8, 24, 2, 95, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (449, 1797.7, 24, 2, 95, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (450, 2160, 24, 2, 95, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (451, 2128, 24, 6, 93, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (452, 2161, 24, 6, 93, 6, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (453, 302846, 24, 1, 94, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (454, 2106.3, 24, 2, 101, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (455, 2130.1, 24, 2, 101, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (456, 1849.7, 24, 2, 101, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (457, 2216.9, 24, 2, 101, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (458, 1951.3, 24, 2, 101, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (459, 1803.9, 24, 2, 96, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (460, 1739.8, 24, 2, 96, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (461, -665, 24, 2, 100, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (462, -804.9, 24, 2, 100, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (463, -870.5, 24, 2, 100, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (464, -784, 24, 2, 99, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (465, -835, 24, 2, 99, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (466, -844.1, 24, 2, 99, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (467, -860.5, 24, 2, 100, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (468, 1824.5, 24, 2, 96, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (469, 2373, 24, 2, 96, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (470, 366690, 24, 1, 94, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (471, -464.7, 24, 2, 100, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (472, -901.4, 24, 2, 99, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (473, -715, 24, 2, 99, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (474, 3110, 24, 5, 98, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (475, 2967, 24, 5, 98, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (476, 1841.1, 24, 2, 103, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (477, 273129, 24, 1, 94, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (478, 314419, 24, 1, 94, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (479, 1709.6, 24, 2, 103, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (480, 1981.5, 24, 2, 103, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (481, 1006, 24, 2, 104, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (482, 3106, 24, 5, 98, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (483, 3042, 24, 5, 98, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (484, 3129, 24, 5, 98, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (485, 1605.9, 24, 2, 104, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (486, 2546.5, 24, 2, 103, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (487, 265866, 24, 1, 94, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (488, 2422, 24, 2, 103, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (489, 1655.9, 24, 2, 104, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (490, 1283.8, 24, 2, 104, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (491, 1674.1, 24, 2, 104, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (492, -462.7, 24, 2, 107, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (493, -620.7, 24, 2, 107, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (494, -393.2, 24, 2, 107, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (495, -319.6, 24, 2, 107, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (496, -364.7, 24, 2, 107, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (497, 3110, 24, 5, 108, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (498, 2967, 24, 5, 108, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (499, 3106, 24, 5, 108, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (500, 3042, 24, 5, 108, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (501, 3129, 24, 5, 108, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (502, -549.1, 24, 2, 109, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (503, -361.7, 24, 2, 109, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (504, -571.7, 24, 2, 109, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (505, -327.8, 24, 2, 109, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (506, -443.8, 24, 2, 109, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (507, 1419.7857142857142, 24, 2, 110, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (508, 1743.7857142857142, 24, 2, 110, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (509, 56686, 24, 1, 111, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (510, 1473.0714285714287, 24, 2, 110, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (511, 997, 24, 2, 110, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (512, 1120.2142857142858, 24, 2, 110, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (513, 5136, 24, 5, 112, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (514, 6019, 24, 5, 112, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (515, 5706, 24, 5, 112, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (516, 6036, 24, 5, 112, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (517, 457.85714285714283, 24, 2, 114, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (518, 391.35714285714283, 24, 2, 114, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (519, 500.7857142857143, 24, 2, 114, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (520, 242, 24, 2, 114, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (521, 481.57142857142856, 24, 2, 114, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (522, 5564, 24, 5, 112, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (523, 28010, 24, 1, 111, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (524, 16483, 24, 1, 111, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (525, 4138, 24, 5, 118, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (526, 118, 24, 2, 119, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (527, -57.5, 24, 2, 119, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (528, -67.42857142857143, 24, 2, 119, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (529, -100.07142857142857, 24, 2, 119, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (530, 4368, 24, 5, 118, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (531, 56.857142857142854, 24, 2, 119, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (532, 61012.6, 24, 1, 121, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (533, 4258, 24, 5, 118, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (534, 4085, 24, 5, 118, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (535, 4230, 24, 5, 118, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (536, 61012.6, 24, 1, 121, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (537, 61012.6, 24, 1, 121, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (538, 61012.6, 24, 1, 121, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (539, 61012.6, 24, 1, 121, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (540, 4772, 24, 5, 131, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (541, 5750, 24, 5, 131, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (542, 5369, 24, 5, 131, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (543, 4909, 24, 5, 131, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (544, 5212, 24, 5, 131, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (545, 2204.5, 24, 2, 132, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (546, 1666.6, 24, 2, 132, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (547, 2178.9, 24, 2, 132, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (548, 2015.7, 24, 2, 132, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (549, 2255.6, 24, 2, 132, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (550, 3110, 24, 5, 134, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (551, 2967, 24, 5, 134, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (552, 3106, 24, 5, 134, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (553, 3042, 24, 5, 134, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (554, 3129, 24, 5, 134, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (555, 3110, 24, 5, 138, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (556, 2967, 24, 5, 138, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (557, 3106, 24, 5, 138, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (558, 3042, 24, 5, 138, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (559, 1954.9, 24, 2, 137, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (560, 3129, 24, 5, 138, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (561, 1678, 24, 2, 137, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (562, 1523.3, 24, 2, 137, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (563, 1690.1, 24, 2, 137, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (564, 1699, 24, 2, 137, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (565, 2199, 24, 6, 141, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (566, 3081, 24, 5, 142, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (567, 3010, 24, 5, 142, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (568, 3057, 24, 5, 142, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (569, 2202, 24, 6, 141, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (570, 2198, 24, 6, 141, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (571, 3045, 24, 5, 142, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (572, 3123, 24, 5, 142, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (573, 2202, 24, 6, 141, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (574, 4138, 24, 5, 148, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (575, 4368, 24, 5, 148, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (576, 4258, 24, 5, 148, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (577, 4085, 24, 5, 148, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (578, 1896.6, 24, 2, 146, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (579, 4230, 24, 5, 148, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (580, 2196, 24, 6, 141, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (581, 2282.8, 24, 2, 146, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (582, 1795.9, 24, 2, 146, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (583, 1648.8, 24, 2, 146, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (584, 2170.3, 24, 2, 146, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (585, 1675.2, 24, 2, 151, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (586, 1954, 24, 2, 151, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (587, 1658.2, 24, 2, 151, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (588, 2188, 24, 6, 157, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (589, 2166, 24, 6, 155, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (590, 2190, 24, 6, 157, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (591, 2179, 24, 6, 157, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (592, 2188, 24, 6, 157, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (593, 2178, 24, 6, 157, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (594, 1859.8, 24, 2, 151, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (595, 1980.7, 24, 2, 151, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (596, 2166, 24, 6, 160, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (597, 2164, 24, 6, 160, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (598, 2188, 24, 6, 160, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (599, 2213, 24, 6, 160, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (600, 2164, 24, 6, 155, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (601, 2188, 24, 6, 155, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (602, 2213, 24, 6, 155, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (603, 2166, 24, 6, 155, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (604, 2166, 24, 6, 160, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (605, 1956, 24, 2, 161, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (606, 3192, 24, 6, 164, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (607, 3343, 24, 6, 164, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (608, 3105, 24, 6, 164, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (609, 3828, 24, 6, 164, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (610, 3774, 24, 6, 164, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (611, 1614.4, 24, 2, 161, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (612, 2964, 24, 6, 165, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (613, 3192, 24, 6, 162, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (614, 3343, 24, 6, 162, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (615, 3105, 24, 6, 162, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (616, 3828, 24, 6, 162, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (617, 3774, 24, 6, 162, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (618, 3221, 24, 6, 165, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (619, 1761.8, 24, 2, 161, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (620, 3033, 24, 6, 165, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (621, 2859, 24, 6, 165, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (622, 2818, 24, 6, 165, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (623, 2117.4, 24, 2, 161, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (624, 2161, 24, 6, 170, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (625, 2143, 24, 6, 170, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (626, 1831.9, 24, 2, 161, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (627, 2145, 24, 6, 170, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (628, 2207, 24, 6, 169, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (629, 2128, 24, 6, 170, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (630, 2161, 24, 6, 170, 8, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (631, 2190, 24, 6, 169, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (632, 2179, 24, 6, 169, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (633, 2193, 24, 6, 169, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (634, 2206, 24, 6, 169, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (635, 1731.1, 24, 2, 174, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (636, 1615, 24, 2, 174, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (637, 1557.7, 24, 2, 174, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (638, 2161, 24, 6, 177, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (639, 2143, 24, 6, 177, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (640, 2145, 24, 6, 177, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (641, 1895.1, 24, 2, 174, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (642, 2360, 24, 2, 174, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (643, 2128, 24, 6, 177, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (644, 2161, 24, 6, 177, 5, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (645, 2076.5714285714284, 24, 2, 182, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (646, 1803.5, 24, 2, 182, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (647, 2229.214285714286, 24, 2, 182, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (648, 1921.357142857143, 24, 2, 182, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (649, 1978.7142857142858, 24, 2, 182, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (650, 1588, 24, 2, 183, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (651, 1121.2142857142858, 24, 2, 188, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (652, 1792.5, 24, 2, 188, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (653, 2229.9285714285716, 24, 2, 188, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (654, 2036.1, 24, 2, 183, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (655, 1882.4, 24, 2, 183, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (656, 2397.0714285714284, 24, 2, 188, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (657, 1985, 24, 2, 188, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (658, 118, 24, 2, 191, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (659, -57.5, 24, 2, 191, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (660, 2028.2, 24, 2, 192, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (661, -67.42857142857143, 24, 2, 191, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (662, 3820, 24, 4, 195, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (663, 4080, 24, 4, 194, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (664, 4779, 24, 4, 195, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (665, -100.07142857142857, 24, 2, 191, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (666, 2048.9, 24, 2, 192, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (667, 56.857142857142854, 24, 2, 191, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (668, 4156, 24, 4, 195, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (669, 4456, 24, 4, 195, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (670, 4459, 24, 4, 195, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (671, 4390, 24, 4, 194, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (672, 1773.1, 24, 2, 192, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (673, 4278, 24, 4, 197, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (674, 4133, 24, 4, 197, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (675, 4413, 24, 4, 197, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (676, 4608, 24, 4, 197, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (677, 4386, 24, 4, 197, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (678, 3975, 24, 4, 194, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (679, 2894, 24, 4, 198, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (680, 2968, 24, 4, 198, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (681, 3117, 24, 4, 198, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (682, 3069, 24, 4, 198, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (683, 3130, 24, 4, 198, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (684, 2043.8, 24, 2, 192, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (685, 3318, 24, 4, 200, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (686, 4615, 24, 4, 200, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (687, 4204, 24, 4, 200, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (688, 4293, 24, 4, 200, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (689, 4183, 24, 4, 199, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (690, 4207, 24, 4, 199, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (691, 4258, 24, 4, 199, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (692, 4448, 24, 4, 199, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (693, 4210, 24, 4, 194, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (694, 4416, 24, 4, 199, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (695, 4233, 24, 4, 201, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (696, 4351, 24, 4, 200, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (697, 1714.7, 24, 2, 192, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (698, 4113, 24, 4, 201, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (699, 2551, 24, 4, 202, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (700, 2604, 24, 4, 202, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (701, 2573, 24, 4, 202, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (702, 2568, 24, 4, 202, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (703, 2521, 24, 4, 202, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (704, 4292, 24, 4, 194, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (705, 4574, 24, 4, 201, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (706, 3839, 24, 4, 204, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (707, 4412, 24, 4, 204, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (708, 5790, 24, 5, 206, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (709, 5450, 24, 5, 206, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (710, 5320, 24, 5, 206, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (711, 5085, 24, 5, 206, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (712, 4464, 24, 4, 204, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (713, 4716, 24, 4, 204, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (714, 4241, 24, 4, 204, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (715, 4342, 24, 4, 201, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (716, 4340, 24, 4, 201, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (717, 3201, 24, 4, 205, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (718, 3135, 24, 4, 205, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (719, 3168, 24, 4, 205, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (720, 3205, 24, 4, 205, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (721, 3364, 24, 4, 205, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (722, 4119, 24, 4, 208, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (723, 3853, 24, 4, 208, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (724, 4093, 24, 4, 208, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (725, 4553, 24, 4, 208, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (726, 4233, 24, 4, 208, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (727, 2648, 24, 4, 207, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (728, 2600, 24, 4, 207, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (729, 2540, 24, 4, 207, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (730, 2483, 24, 4, 207, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (731, 2625, 24, 4, 207, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (732, 6056, 24, 5, 206, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (733, -31.3, 24, 2, 203, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (734, 3124, 24, 4, 209, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (735, 3440, 24, 4, 209, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (736, 3253, 24, 4, 209, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (737, 3123, 24, 4, 209, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (738, 3311, 24, 4, 209, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (739, 4158, 24, 4, 213, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (740, 4273, 24, 4, 212, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (741, -320, 24, 2, 203, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (742, 3110, 24, 5, 210, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (743, 2967, 24, 5, 210, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (744, 3205, 24, 4, 211, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (745, 4104, 24, 4, 212, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (746, 4316, 24, 4, 213, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (747, 3745, 24, 4, 213, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (748, 4278, 24, 4, 213, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (749, 4607, 24, 4, 213, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (750, 4341, 24, 4, 212, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (751, 4430, 24, 4, 212, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (752, 4365, 24, 4, 212, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (753, 3170, 24, 4, 211, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (754, 3396, 24, 4, 211, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (755, 3186, 24, 4, 211, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (756, 3347, 24, 4, 211, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (757, 3106, 24, 5, 210, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (758, 3042, 24, 5, 210, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (759, 3129, 24, 5, 210, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (760, -156.3, 24, 2, 203, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (761, 3551, 24, 4, 217, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (762, 4571, 24, 4, 217, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (763, 4457, 24, 4, 217, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (764, 4564, 24, 4, 217, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (765, 4179, 24, 4, 217, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (766, 2601, 24, 4, 216, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (767, 4283, 24, 4, 215, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (768, 4403, 24, 4, 215, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (769, 4630, 24, 4, 215, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (770, 4492, 24, 4, 215, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (771, 4255, 24, 4, 215, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (772, 2945, 24, 4, 214, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (773, 2646, 24, 4, 219, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (774, 2776, 24, 4, 219, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (775, 2821, 24, 4, 219, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (776, 2580, 24, 4, 216, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (777, 2518, 24, 4, 216, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (778, 3110, 24, 5, 218, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (779, -313.1, 24, 2, 203, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (780, 2967, 24, 5, 218, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (781, 2672, 24, 4, 216, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (782, 2728, 24, 4, 219, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (783, 2902, 24, 4, 214, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (784, 2811, 24, 4, 219, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (785, 2497, 24, 4, 216, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (786, 3303, 24, 4, 220, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (787, 3106, 24, 5, 218, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (788, 3042, 24, 5, 218, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (789, 4126, 24, 4, 220, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (790, 4315, 24, 4, 220, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (791, 4383, 24, 4, 220, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (792, 5140, 24, 4, 220, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (793, 2975, 24, 4, 214, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (794, 3055, 24, 4, 214, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (795, 2860, 24, 4, 214, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (796, 3192, 24, 4, 223, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (797, 3159, 24, 4, 223, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (798, 3081, 24, 4, 223, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (799, 3069, 24, 4, 223, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (800, 3213, 24, 4, 221, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (801, 3175, 24, 4, 221, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (802, 3159, 24, 4, 221, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (803, 3157, 24, 4, 221, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (804, 3664, 24, 4, 222, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (805, 3129, 24, 5, 218, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (806, 4075, 24, 4, 222, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (807, 4032, 24, 4, 222, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (808, 3312, 24, 4, 221, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (809, 3275, 24, 4, 223, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (810, 4595, 24, 4, 222, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (811, 4399, 24, 4, 222, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (812, 4290, 24, 5, 225, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (813, 3473, 24, 4, 226, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (814, 3806, 24, 4, 226, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (815, 4117, 24, 4, 224, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (816, 4010, 24, 4, 224, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (817, 4593, 24, 4, 224, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (818, 4730, 24, 4, 224, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (819, 4185, 24, 4, 224, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (820, 3409, 24, 4, 226, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (821, 3595, 24, 4, 226, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (822, 3437, 24, 4, 226, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (823, 4314, 24, 4, 229, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (824, 4469, 24, 4, 229, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (825, 4908, 24, 4, 229, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (826, 4187, 24, 4, 229, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (827, 3992, 24, 4, 229, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (828, 3377, 24, 4, 228, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (829, 3936, 24, 5, 225, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (830, 3765, 24, 5, 225, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (831, 3589, 24, 5, 225, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (832, 3406, 24, 5, 225, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (833, 4138, 24, 5, 232, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (834, 4368, 24, 5, 232, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (835, 4258, 24, 5, 232, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (836, 4085, 24, 5, 232, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (837, 4295, 24, 4, 228, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (838, 4300, 24, 4, 228, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (839, 4086, 24, 4, 228, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (840, 3935, 24, 4, 228, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (841, 4617, 24, 4, 231, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (842, 4371, 24, 4, 231, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (843, 2607, 24, 4, 230, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (844, 2604, 24, 4, 230, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (845, 5004, 24, 4, 231, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (846, 3307, 24, 4, 233, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (847, 4230, 24, 5, 232, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (848, 2098, 24, 3, 227, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (849, 2080, 24, 3, 227, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (850, 2076, 24, 3, 227, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (851, 2072, 24, 3, 227, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (852, 2032, 24, 3, 227, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (853, 3950, 24, 4, 233, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (854, 4821, 24, 4, 231, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (855, 3909, 24, 4, 231, 3, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (856, 2560, 24, 4, 230, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (857, 2544, 24, 4, 230, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (858, 2531, 24, 4, 230, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (859, 4271, 24, 4, 234, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (860, 4086, 24, 4, 234, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (861, 4757, 24, 4, 234, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (862, 4366, 24, 4, 233, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (863, 4594, 24, 4, 233, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (864, 4470, 24, 4, 233, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (865, 2043, 24, 3, 235, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (866, 2069, 24, 3, 235, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (867, 2074, 24, 3, 235, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (868, 2076, 24, 3, 235, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (869, 2068, 24, 3, 235, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (870, 3536, 24, 4, 238, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (871, 3612, 24, 4, 238, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (872, 3411, 24, 4, 238, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (873, 3793, 24, 4, 238, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (874, 3642, 24, 4, 238, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (875, 4180, 24, 4, 234, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (876, 3215, 24, 4, 237, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (877, 3164, 24, 4, 237, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (878, 3264, 24, 4, 237, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (879, 3196, 24, 4, 237, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (880, 3372, 24, 4, 237, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (881, 3924, 24, 4, 234, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (882, 3685, 24, 4, 240, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (883, 3051, 24, 4, 241, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (884, 2831, 24, 4, 241, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (885, 3098, 24, 4, 241, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (886, 2976, 24, 4, 241, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (887, 5170, 24, 4, 240, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (888, 4416, 24, 4, 240, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (889, 4924, 24, 4, 240, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (890, 5209, 24, 4, 240, 1, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (891, 2079, 24, 3, 239, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (892, 2053, 24, 3, 239, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (893, 2075, 24, 3, 239, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (894, 2088, 24, 3, 239, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (895, 2068, 24, 3, 239, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (896, 2923, 24, 4, 241, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (897, 4674, 24, 4, 242, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (898, 4586, 24, 4, 242, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (899, 4314, 24, 4, 242, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (900, 4688, 24, 4, 242, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (901, 4821, 24, 4, 242, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (902, 2038, 24, 3, 243, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (903, 3935, 24, 4, 244, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (904, 4350, 24, 4, 244, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (905, 4708, 24, 4, 244, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (906, 4288, 24, 4, 244, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (907, 2210, 24, 6, 245, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (908, 2066, 24, 3, 243, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (909, 2058, 24, 3, 243, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (910, 2059, 24, 3, 243, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (911, 2029, 24, 3, 243, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (912, 2215, 24, 6, 245, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (913, 4167, 24, 4, 244, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (914, 4096, 24, 4, 246, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (915, 4073, 24, 4, 246, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (916, 4509, 24, 4, 246, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (917, 4513, 24, 4, 246, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (918, 2152, 24, 6, 245, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (919, 2174, 24, 6, 245, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (920, 2195, 24, 6, 245, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (921, 3675, 24, 4, 246, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (922, 4107, 24, 4, 247, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (923, 4307, 24, 4, 247, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (924, 4377, 24, 4, 247, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (925, 4351, 24, 4, 247, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (926, 4126, 24, 4, 247, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (927, 2166, 24, 6, 249, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (928, 2164, 24, 6, 249, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (929, 2188, 24, 6, 249, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (930, 2213, 24, 6, 249, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (931, 2166, 24, 6, 249, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (932, 2190, 24, 3, 248, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (933, 2235, 24, 3, 248, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (934, 2237, 24, 3, 248, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (935, 2194, 24, 3, 248, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (936, 2308, 24, 3, 248, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (937, 3192, 24, 6, 252, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (938, 3343, 24, 6, 252, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (939, 3105, 24, 6, 252, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (940, 3828, 24, 6, 252, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (941, 3774, 24, 6, 252, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (942, 3519, 24, 4, 251, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (943, 3266, 24, 4, 251, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (944, 3648, 24, 4, 251, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (945, 3371, 24, 4, 251, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (946, 3501, 24, 4, 251, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (947, 3980, 24, 4, 250, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (948, 4807, 24, 4, 255, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (949, 4843, 24, 4, 255, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (950, 4479, 24, 4, 255, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (951, 4333, 24, 4, 255, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (952, 4782, 24, 4, 255, 2, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (953, 2192, 24, 6, 254, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (954, 2177, 24, 6, 254, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (955, 2037, 24, 3, 253, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (956, 2060, 24, 3, 253, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (957, 2044, 24, 3, 253, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (958, 2063, 24, 3, 253, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (959, 2073, 24, 3, 253, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (960, 2180, 24, 6, 254, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (961, 4090, 24, 4, 250, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (962, 4296, 24, 4, 250, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (963, 4150, 24, 4, 250, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (964, 3697, 24, 4, 250, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (965, 2182, 24, 6, 254, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (966, 2178, 24, 6, 254, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (967, 2852, 24, 4, 256, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (968, 2875, 24, 4, 256, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (969, 2720, 24, 4, 256, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (970, 2748, 24, 4, 256, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (971, 2161, 24, 6, 258, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (972, 2143, 24, 6, 258, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (973, 2145, 24, 6, 258, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (974, 2128, 24, 6, 258, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (975, 2161, 24, 6, 258, 9, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (976, 2085, 24, 3, 257, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (977, 2083, 24, 3, 257, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (978, 2082, 24, 3, 257, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (979, 2084, 24, 3, 257, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (980, 2073, 24, 3, 257, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (981, 2720, 24, 4, 256, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (982, 3082, 24, 4, 260, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (983, 3066, 24, 4, 260, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (984, 2869, 24, 4, 260, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (985, 2022, 24, 3, 261, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (986, 3069, 24, 4, 260, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (987, 2100, 24, 3, 261, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (988, 3042, 24, 4, 260, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (989, 2076, 24, 3, 261, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (990, 2085, 24, 3, 261, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (991, 2070, 24, 3, 261, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (992, 3765, 24, 4, 262, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (993, 3327, 24, 4, 262, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (994, 3388, 24, 4, 262, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (995, 3569, 24, 4, 262, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (996, 3486, 24, 4, 262, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (997, 2030, 24, 3, 263, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (998, 4180, 24, 4, 264, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (999, 4697, 24, 4, 264, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1000, 4422, 24, 4, 264, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1001, 4514, 24, 4, 264, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1002, 4596, 24, 4, 264, 4, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1003, 2041, 24, 3, 263, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1004, 2045, 24, 3, 263, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1005, 2055, 24, 3, 263, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1006, 2024, 24, 3, 263, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1007, 2033, 24, 3, 265, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1008, 2061, 24, 3, 265, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1009, 2057, 24, 3, 265, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1010, 2062, 24, 3, 265, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1011, 2054, 24, 3, 265, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1012, 2035, 24, 3, 266, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1013, 2044, 24, 3, 266, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1014, 2051, 24, 3, 266, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1015, 2042, 24, 3, 266, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1016, 1984, 24, 3, 266, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1017, 2026, 24, 3, 267, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1018, 2050, 24, 3, 267, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1019, 2020, 24, 3, 267, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1020, 2057, 24, 3, 267, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1021, 2040, 24, 3, 267, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1022, 3699, 24, 4, 268, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1023, 3513, 24, 4, 268, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1024, 3554, 24, 4, 268, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1025, 3756, 24, 4, 268, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1026, 4062, 24, 4, 268, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1027, 3430, 24, 4, 269, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1028, 3402, 24, 4, 269, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1029, 3431, 24, 4, 269, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1030, 3429, 24, 4, 269, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1031, 3692, 24, 4, 269, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1032, 3654, 24, 4, 270, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1033, 3832, 24, 4, 270, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1034, 3739, 24, 4, 270, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1035, 3724, 24, 4, 270, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1036, 3941, 24, 4, 270, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1037, 2563, 24, 4, 271, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1038, 2484, 24, 4, 271, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1039, 2510, 24, 4, 271, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1040, 2536, 24, 4, 271, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1041, 2488, 24, 4, 271, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1042, 3081, 24, 4, 272, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1043, 3066, 24, 4, 272, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1044, 3083, 24, 4, 272, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1045, 3055, 24, 4, 272, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1046, 3237, 24, 4, 272, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1047, 3474, 24, 4, 273, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1048, 3530, 24, 4, 273, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1049, 3694, 24, 4, 273, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1050, 3069, 24, 4, 273, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1051, 3859, 24, 4, 273, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1052, 3440, 24, 4, 274, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1053, 3456, 24, 4, 274, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1054, 3581, 24, 4, 274, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1055, 3615, 24, 4, 274, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1056, 3632, 24, 4, 274, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1057, 3532, 24, 4, 275, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1058, 3515, 24, 4, 275, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1059, 3617, 24, 4, 275, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1060, 3474, 24, 4, 275, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1061, 4122, 24, 4, 275, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1062, 3618, 24, 4, 276, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1063, 3368, 24, 4, 276, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1064, 3433, 24, 4, 276, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1065, 3424, 24, 4, 276, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1066, 3887, 24, 4, 276, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1067, 3424, 24, 4, 277, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1068, 3610, 24, 4, 277, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1069, 3728, 24, 4, 277, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1070, 3463, 24, 4, 277, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1071, 3808, 24, 4, 277, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1072, 3366, 24, 4, 278, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1073, 3284, 24, 4, 278, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1074, 3821, 24, 4, 278, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1075, 3221, 24, 4, 278, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1076, 3440, 24, 4, 278, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1077, 4064, 24, 4, 279, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1078, 4088, 24, 4, 279, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1079, 4065, 24, 4, 279, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1080, 4176, 24, 4, 279, 7, 0);
INSERT INTO public.response (id, value, timestamp, endpoint_id, concentration_id, experiment_id, outlier_type_id)
VALUES (1081, 4068, 24, 4, 279, 7, 0);
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