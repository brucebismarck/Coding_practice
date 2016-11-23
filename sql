DROP TABLE public.deficiencies;

CREATE TABLE public.deficiencies
(
    provnum character varying COLLATE pg_catalog."default" NOT NULL,
    provname text COLLATE pg_catalog."default",
    survey_date_output date NOT NULL,
    surveytype character varying(20) COLLATE pg_catalog."default" NOT NULL,
    defpref character varying(5) COLLATE pg_catalog."default",
    tag smallint NOT NULL,
    tag_desc text COLLATE pg_catalog."default",
    scope character varying(5) COLLATE pg_catalog."default",
    defstat text COLLATE pg_catalog."default",
    statdate date,
    cycle smallint NOT NULL,
    standard boolean,
    compliant boolean,
    filedate date,
    CONSTRAINT deficiencies_pkey PRIMARY KEY (survey_date_output, surveytype, tag, provnum)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.deficiencies
    OWNER to postgres;

GRANT ALL ON TABLE public.deficiencies TO postgres;

GRANT INSERT, SELECT, UPDATE ON TABLE public.deficiencies TO PUBLIC;





-- Table: public.ownership

DROP TABLE public.ownership;

CREATE TABLE public.ownership
(
    role_desc text COLLATE pg_catalog."default" NOT NULL,
    provnum character varying(6) COLLATE pg_catalog."default" NOT NULL,
    provname text COLLATE pg_catalog."default",
    owner_type "char",
    owner_percentage text COLLATE pg_catalog."default",
    association_date date,
    owner_name text COLLATE pg_catalog."default" NOT NULL,
    filedate date,
    CONSTRAINT ownership_pkey PRIMARY KEY (role_desc, owner_name, provnum)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ownership
    OWNER to postgres;

GRANT ALL ON TABLE public.ownership TO postgres;

GRANT INSERT ON TABLE public.ownership TO PUBLIC;




-- Table: public.penalties

DROP TABLE public.penalties;

CREATE TABLE public.penalties
(
    provnum character varying(6) COLLATE pg_catalog."default" NOT NULL,
    provname text COLLATE pg_catalog."default",
    pnlty_date date NOT NULL,
    pnlty_type character varying(20) COLLATE pg_catalog."default",
    fine_amt integer,
    payden_strt_dt date,
    payden_days integer,
    order_key integer NOT NULL,
    filedate date,
    CONSTRAINT "Penalties_pkey" PRIMARY KEY (order_key)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.penalties
    OWNER to postgres;

GRANT ALL ON TABLE public.penalties TO postgres;

GRANT INSERT ON TABLE public.penalties TO PUBLIC;




-- Table: public.providerinfo

DROP TABLE public.providerinfo;

CREATE TABLE public.providerinfo
(
    provnum character varying(6) COLLATE pg_catalog."default" NOT NULL,
    provname text COLLATE pg_catalog."default",
    address text COLLATE pg_catalog."default",
    city character varying(20) COLLATE pg_catalog."default",
    state character(2) COLLATE pg_catalog."default",
    zip integer DEFAULT nextval('"Providerinfo_zip_seq"'::regclass),
    phone bigint DEFAULT nextval('"Providerinfo_phone_seq"'::regclass),
    county_ssa smallint DEFAULT nextval('"Providerinfo_county_ssa_seq"'::regclass),
    county_name character varying COLLATE pg_catalog."default",
    ownership text COLLATE pg_catalog."default",
    bedcert integer DEFAULT nextval('"Providerinfo_bedcert_seq"'::regclass),
    restot integer DEFAULT nextval('"Providerinfo_restot_seq"'::regclass),
    certification text COLLATE pg_catalog."default",
    inhosp boolean,
    lbn text COLLATE pg_catalog."default",
    participation_date date,
    ccrc_facil boolean,
    sff boolean,
    oldsurvey boolean,
    chow_last_12mos boolean,
    resfamcouncil character varying(20) COLLATE pg_catalog."default",
    sprinkler_status character varying(20) COLLATE pg_catalog."default",
    overall_rating smallint DEFAULT nextval('"Providerinfo_overall_rating_seq"'::regclass),
    overall_rating_fn text COLLATE pg_catalog."default",
    survey_rating smallint DEFAULT nextval('"Providerinfo_survey_rating_seq"'::regclass),
    survey_rating_fn text COLLATE pg_catalog."default",
    quality_rating smallint DEFAULT nextval('"Providerinfo_quality_rating_seq"'::regclass),
    quality_rating_fn text COLLATE pg_catalog."default",
    staffing_rating smallint DEFAULT nextval('"Providerinfo_staffing_rating_seq"'::regclass),
    staffing_rating_fn text COLLATE pg_catalog."default",
    rn_staffing_rating smallint DEFAULT nextval('"Providerinfo_rn_staffing_rating_seq"'::regclass),
    rn_staffing_rating_fn text COLLATE pg_catalog."default",
    staffing_flag text COLLATE pg_catalog."default",
    pt_staffing_flag text COLLATE pg_catalog."default",
    aidhrd numeric,
    vochrd numeric,
    rnhrd numeric,
    totlichrd numeric,
    tothrd numeric,
    pthrd numeric,
    exp_aide numeric,
    exp_lpn numeric,
    exp_rn numeric,
    exp_total numeric,
    adj_aide numeric,
    adj_lpn numeric,
    adj_rn numeric,
    adj_total numeric,
    cycle_1_defs integer,
    cycle_1_nfromdefs integer,
    cycle_1_nfromcomp integer,
    cycle_1_defs_score integer,
    cycle_1_survey_date date,
    cycle_1_numrevis integer,
    cycle_1_revisit_score integer,
    cycle_1_total_score integer,
    cycle_2_defs integer,
    cycle_2_nfromdefs integer,
    cycle_2_nfromcomp integer,
    "	cycle_2_defs_score" integer,
    cycle_2_survey_date date,
    cycle_2_numrevis integer,
    cycle_2_revisit_score integer,
    cycle_2_total_score integer,
    cycle_3_defs integer,
    cycle_3_nfromdefs integer,
    cycle_3_nfromcomp integer,
    "	cycle_3_defs_score" integer,
    cycle_3_survey_date date,
    cycle_3_numrevis integer,
    cycle_3_revisit_score integer,
    cycle_3_total_score integer,
    weighted_all_cycles_score numeric,
    indicent_cnt integer,
    cmplnt_cnt integer,
    fine_cnt integer,
    fine_tot integer,
    payden_cnt integer,
    tot_panlty_cnt integer,
    filedate date,
    CONSTRAINT "Providerinfo_pkey" PRIMARY KEY (provnum),
    CONSTRAINT zip CHECK (zip < 100000) NOT VALID,
    CONSTRAINT rn_staffing_rating CHECK (rn_staffing_rating = ANY (ARRAY[1, 2, 3, 4, 5])) NOT VALID,
    CONSTRAINT staffing_rating CHECK (staffing_rating = ANY (ARRAY[1, 2, 3, 4, 5])) NOT VALID,
    CONSTRAINT quality_rating CHECK (quality_rating = ANY (ARRAY[1, 2, 3, 4, 5])) NOT VALID,
    CONSTRAINT survey_rating CHECK (survey_rating = ANY (ARRAY[1, 2, 3, 4, 5])) NOT VALID,
    CONSTRAINT overall_rating CHECK (overall_rating = ANY (ARRAY[1, 2, 3, 4, 5])) NOT VALID,
    CONSTRAINT county_ssa CHECK (county_ssa < 1000 AND county_ssa > '-1'::integer) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.providerinfo
    OWNER to postgres;

GRANT ALL ON TABLE public.providerinfo TO postgres;

GRANT INSERT ON TABLE public.providerinfo TO PUBLIC;





-- Table: public.qualitymsrclaims

DROP TABLE public.qualitymsrclaims;

CREATE TABLE public.qualitymsrclaims
(
    provnum character varying(6) COLLATE pg_catalog."default" NOT NULL,
    provname text COLLATE pg_catalog."default",
    msr_cd smallint NOT NULL,
    msr_dsscr text COLLATE pg_catalog."default",
    stay_type character varying(20) COLLATE pg_catalog."default",
    score_adjusted numeric,
    score_observed numeric,
    score_expected numeric,
    score_fn text COLLATE pg_catalog."default",
    five_star_msr boolean,
    measure_start_yr smallint,
    measure_start_qt smallint,
    measure_end_yr smallint,
    measure_end_qt smallint,
    filedate date,
    CONSTRAINT "QualityMsrMDS_pkey" PRIMARY KEY (msr_cd, provnum),
    CONSTRAINT stay_type CHECK (stay_type::text = ANY (ARRAY['Long Stay'::character varying, 'Short Stay'::character varying]::text[])) NOT VALID,
    CONSTRAINT measure_end_qt CHECK (measure_end_qt = ANY (ARRAY[1, 2, 3, 4])) NOT VALID,
    CONSTRAINT measure_end_yr CHECK (measure_end_yr >= measure_start_yr AND measure_end_yr < 2050) NOT VALID,
    CONSTRAINT measure_start_qt CHECK (measure_start_qt = ANY (ARRAY[1, 2, 3, 4])) NOT VALID,
    CONSTRAINT measure_start_yr CHECK (measure_start_yr > 1970 AND measure_start_yr < 2050) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.qualitymsrclaims
    OWNER to postgres;

GRANT ALL ON TABLE public.qualitymsrclaims TO postgres;

GRANT INSERT ON TABLE public.qualitymsrclaims TO PUBLIC;




-- Table: public.qualitymsrmds

DROP TABLE public.qualitymsrmds;

CREATE TABLE public.qualitymsrmds
(
    provnum character varying(6) COLLATE pg_catalog."default" NOT NULL,
    provname text COLLATE pg_catalog."default",
    msr_cd smallint NOT NULL,
    msr_descr text COLLATE pg_catalog."default",
    stay_type character varying(20) COLLATE pg_catalog."default",
    q1_measure_score numeric,
    q1_measure_fn text COLLATE pg_catalog."default",
    q2_measure_score numeric,
    q2_measure_fn text COLLATE pg_catalog."default",
    q3_measure_score numeric,
    q3_measure_fn text COLLATE pg_catalog."default",
    q4_measure_score numeric,
    q4_measure_fn text COLLATE pg_catalog."default",
    measure_score_4qtr_avg numeric,
    score4qtr_fn text COLLATE pg_catalog."default",
    five_star_msr boolean,
    q1_quater character(6) COLLATE pg_catalog."default",
    q2_quater character(6) COLLATE pg_catalog."default",
    q3_quater character(6) COLLATE pg_catalog."default",
    q4_quater character(6) COLLATE pg_catalog."default",
    filedate date,
    CONSTRAINT "QualityMsrMDS_pkey1" PRIMARY KEY (msr_cd, provnum),
    CONSTRAINT stay_type CHECK (stay_type::text = ANY (ARRAY['Long Stay'::character varying, 'Short Stay'::character varying]::text[]))
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.qualitymsrmds
    OWNER to postgres;

GRANT ALL ON TABLE public.qualitymsrmds TO postgres;

GRANT INSERT ON TABLE public.qualitymsrmds TO PUBLIC;




-- Table: public.stateaverages

DROP TABLE public.stateaverages;

CREATE TABLE public.stateaverages
(
    c1_hlth_defs_cnt numeric,
    c1_fs_defs_cnt numeric,
    c2_hlth_defs_cnt numeric,
    c2_fs_defs_cnt numeric,
    c3_hlth_defs_cnt numeric,
    c3_fs_defs_cnt numeric,
    aidhrd numeric,
    vochrd numeric,
    rnhrd numeric,
    totlichrd numeric,
    tothrd numeric,
    pthrd numeric,
    fine_cnt numeric,
    fine_tot integer,
    qm401 numeric,
    qm402 numeric,
    qm403 numeric,
    qm404 numeric,
    qm405 numeric,
    qm406 numeric,
    qm407 numeric,
    qm408 numeric,
    qm409 numeric,
    qm410 numeric,
    qm411 numeric,
    qm415 numeric,
    qm419 numeric,
    qm424 numeric,
    qm425 numeric,
    qm426 numeric,
    qm430 numeric,
    qm434 numeric,
    qm451 numeric,
    qm452 numeric,
    qm471 numeric,
    qm521 numeric,
    qm522 numeric,
    qm523 numeric,
    filedate date,
    state character varying(6) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "StateAverage_pkey" PRIMARY KEY (state)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.stateaverages
    OWNER to postgres;

GRANT ALL ON TABLE public.stateaverages TO postgres;

GRANT INSERT ON TABLE public.stateaverages TO PUBLIC;




-- Table: public.surveysummary

DROP TABLE public.surveysummary;

CREATE TABLE public.surveysummary
(
    provnum character varying(6) COLLATE pg_catalog."default" NOT NULL,
    provname text COLLATE pg_catalog."default",
    cycle integer NOT NULL,
    h_survey_date date,
    f_survey_date date,
    h_tot_dfcncy smallint,
    f_tot_dfcncy smallint,
    h_ss_max character varying(4) COLLATE pg_catalog."default",
    f_ss_max character varying(4) COLLATE pg_catalog."default",
    h_ij_n smallint,
    f_ij_n smallint,
    h_severe_n smallint,
    f_severe_n smallint,
    h_substndrd_qoc_n smallint,
    h_administration_n smallint,
    h_environmental_n smallint,
    h_mistreat_n smallint,
    h_nutrition_n smallint,
    h_pharmacy_n smallint,
    h_quality_care_n smallint,
    h_res_asmnt_n smallint,
    h_res_rights_n smallint,
    f_construction_n smallint,
    f_corridor_doors_n smallint,
    f_electrical_n smallint,
    f_emergency_plan_n smallint,
    f_exit_egress_n smallint,
    f_exit_access_n smallint,
    f_fire_alarm_n smallint,
    f_furnishings_n smallint,
    f_hazard_area_n smallint,
    f_illumination_n smallint,
    f_interior_n smallint,
    f_laboratories_n smallint,
    f_medical_gas_n smallint,
    f_miscellaneous_n smallint,
    f_service_equipment_n smallint,
    f_smoke_control_n smallint,
    f_smoking_reg_n smallint,
    f_sprinkler_n smallint,
    f_vert_openings_n smallint,
    filedate date,
    CONSTRAINT "SurveySummary_pkey" PRIMARY KEY (cycle, provnum),
    CONSTRAINT f_illumination_n CHECK (f_illumination_n < 100 AND f_illumination_n >= 0) NOT VALID,
    CONSTRAINT h_quality_care_n CHECK (h_quality_care_n < 100 AND h_quality_care_n >= 0) NOT VALID,
    CONSTRAINT cycle CHECK (cycle = ANY (ARRAY[1, 2, 3])) NOT VALID,
    CONSTRAINT h_ij_n CHECK (h_ij_n < 100 AND h_ij_n >= 0) NOT VALID,
    CONSTRAINT f_smoking_reg_n CHECK (f_smoking_reg_n < 100 AND f_smoking_reg_n >= 0) NOT VALID,
    CONSTRAINT f_severe_n CHECK (f_severe_n < 100 AND f_severe_n >= 0) NOT VALID,
    CONSTRAINT f_electrical_n CHECK (f_electrical_n < 100 AND f_electrical_n >= 0) NOT VALID,
    CONSTRAINT f_ij_n CHECK (f_ij_n < 100 AND f_ij_n >= 0) NOT VALID,
    CONSTRAINT f_medical_gas_n CHECK (f_medical_gas_n < 100 AND f_medical_gas_n >= 0) NOT VALID,
    CONSTRAINT f_service_equipment_n CHECK (f_service_equipment_n < 100 AND f_service_equipment_n >= 0) NOT VALID,
    CONSTRAINT f_construction_n CHECK (f_construction_n < 100 AND f_construction_n >= 0) NOT VALID,
    CONSTRAINT h_tot_dfcncy CHECK (h_tot_dfcncy < 100 AND h_tot_dfcncy >= 0) NOT VALID,
    CONSTRAINT h_environmental_n CHECK (h_environmental_n < 100 AND h_environmental_n >= 0) NOT VALID,
    CONSTRAINT f_hazard_area_n CHECK (f_hazard_area_n < 100 AND f_hazard_area_n >= 0) NOT VALID,
    CONSTRAINT f_vert_openings_n CHECK (f_vert_openings_n < 100 AND f_vert_openings_n >= 0) NOT VALID,
    CONSTRAINT h_substndrd_qoc_n CHECK (h_substndrd_qoc_n < 100 AND h_substndrd_qoc_n >= 0) NOT VALID,
    CONSTRAINT f_sprinkler_n CHECK (f_sprinkler_n < 100 AND f_sprinkler_n >= 0) NOT VALID,
    CONSTRAINT h_pharmacy_n CHECK (h_pharmacy_n < 100 AND h_pharmacy_n >= 0) NOT VALID,
    CONSTRAINT h_nutrition_n CHECK (h_nutrition_n < 100 AND h_nutrition_n >= 0) NOT VALID,
    CONSTRAINT f_corridor_doors_n CHECK (f_corridor_doors_n < 100 AND f_corridor_doors_n >= 0) NOT VALID,
    CONSTRAINT h_res_asmnt_n CHECK (h_res_asmnt_n < 100 AND h_res_asmnt_n >= 0) NOT VALID,
    CONSTRAINT f_miscellaneous_n CHECK (f_miscellaneous_n < 100 AND f_miscellaneous_n >= 0) NOT VALID,
    CONSTRAINT f_laboratories_n CHECK (f_laboratories_n < 100 AND f_laboratories_n >= 0) NOT VALID,
    CONSTRAINT f_tot_dfcncy CHECK (f_tot_dfcncy < 100 AND f_tot_dfcncy >= 0) NOT VALID,
    CONSTRAINT f_emergency_plan_n CHECK (f_emergency_plan_n < 100 AND f_emergency_plan_n >= 0) NOT VALID,
    CONSTRAINT h_res_rights_n CHECK (h_res_rights_n < 100 AND h_res_rights_n >= 0) NOT VALID,
    CONSTRAINT f_furnishings_n CHECK (f_furnishings_n < 100 AND f_furnishings_n >= 0) NOT VALID,
    CONSTRAINT h_mistreat_n CHECK (h_mistreat_n < 100 AND h_mistreat_n >= 0) NOT VALID,
    CONSTRAINT f_fire_alarm_n CHECK (f_fire_alarm_n < 100 AND f_fire_alarm_n >= 0) NOT VALID,
    CONSTRAINT f_exit_egress_n CHECK (f_exit_egress_n < 100 AND f_exit_egress_n >= 0) NOT VALID,
    CONSTRAINT h_administration_n CHECK (h_administration_n < 100 AND h_administration_n >= 0) NOT VALID,
    CONSTRAINT f_interior_n CHECK (f_interior_n < 100 AND f_interior_n >= 0) NOT VALID,
    CONSTRAINT h_severe_n CHECK (h_severe_n < 100 AND h_severe_n >= 0) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.surveysummary
    OWNER to postgres;

GRANT ALL ON TABLE public.surveysummary TO postgres;

GRANT INSERT ON TABLE public.surveysummary TO PUBLIC;
