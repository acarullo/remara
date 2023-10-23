--
-- PostgreSQL database dump
--

-- Started on 2010-05-24 11:41:10 CEST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public."user" DROP CONSTRAINT username_pkey;
ALTER TABLE ONLY public.medicine_case DROP CONSTRAINT ward_pkey;
ALTER TABLE ONLY public.province DROP CONSTRAINT region_pkey;
ALTER TABLE ONLY public.municipality DROP CONSTRAINT province_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT personal_occupation_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT personal_education_pkey;
ALTER TABLE ONLY public.medicine_case DROP CONSTRAINT patient_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT mother_occupation_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT mother_education_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT living_region_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT living_province_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT living_nation_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT living_municipality_pkey;
ALTER TABLE ONLY public.exam DROP CONSTRAINT exam_medicine_case_pkey;
ALTER TABLE ONLY public.medicine_case DROP CONSTRAINT illness_pkey;
ALTER TABLE ONLY public.hospital_organization DROP CONSTRAINT hospital_region_pkey;
ALTER TABLE ONLY public.medicine_case DROP CONSTRAINT hospital_pkey;
ALTER TABLE ONLY public.hospital_ward DROP CONSTRAINT hospital_hospital_ward_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT father_occupation_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT father_education_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT birth_region_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT birth_province_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT birth_nation_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT birth_municipality_pkey;
ALTER TABLE ONLY public.region DROP CONSTRAINT region_pkey;
ALTER TABLE ONLY public.province DROP CONSTRAINT province_pkey;
ALTER TABLE ONLY public.patient DROP CONSTRAINT patient_pkey;
ALTER TABLE ONLY public.occupation DROP CONSTRAINT occupation_pkey;
ALTER TABLE ONLY public.nation DROP CONSTRAINT nation_pkey;
ALTER TABLE ONLY public.municipality DROP CONSTRAINT municipality_pkey;
ALTER TABLE ONLY public.file_case DROP CONSTRAINT medicine_file_case_pkey;
ALTER TABLE ONLY public.exam DROP CONSTRAINT exam_pkey;
ALTER TABLE ONLY public.medicine_case DROP CONSTRAINT medicine_case_pkey;
ALTER TABLE ONLY public.illness DROP CONSTRAINT illness_unic_description;
ALTER TABLE ONLY public.illness DROP CONSTRAINT illness_unic_code;
ALTER TABLE ONLY public.illness DROP CONSTRAINT illness_pkey;
ALTER TABLE ONLY public.hospital_ward DROP CONSTRAINT hospital_ward_pkey;
ALTER TABLE ONLY public.hospital_organization DROP CONSTRAINT hospital_organization_pkey;
ALTER TABLE ONLY public.education DROP CONSTRAINT education_pkey;
ALTER TABLE ONLY public.file_case DROP CONSTRAINT file_case_pkey;
DROP TABLE public."user";
DROP SEQUENCE public.seq_illness;
DROP SEQUENCE public.seq_exam;
DROP SEQUENCE public.seq_os_wfentry;
DROP SEQUENCE public.seq_os_historystep;
DROP SEQUENCE public.seq_os_currentsteps;
DROP SEQUENCE public.seq_hospital_ward;
DROP SEQUENCE public.seq_hospital_organization;
DROP SEQUENCE public.seq_file_case;
DROP SEQUENCE public.seq_patient;
DROP SEQUENCE public.seq_medicine_case;
DROP TABLE public.exam;
DROP TABLE public.role;
DROP TABLE public.region;
DROP TABLE public.province;
DROP TABLE public.patient;
DROP TABLE public.os_wfentry;
DROP TABLE public.os_historystep;
DROP TABLE public.os_currentstep;
DROP TABLE public.occupation;
DROP TABLE public.nation;
DROP TABLE public.municipality;
DROP TABLE public.medicine_case;
DROP TABLE public.illness;
DROP TABLE public.hospital_ward;
DROP TABLE public.hospital_organization;
DROP TABLE public.education;
DROP TABLE public.file_case;



SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1532 (class 1259 OID 16929)
-- Dependencies: 6
-- Name: education; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE education (
    id integer NOT NULL,
    description_it character varying(255),
    description_en character varying(255),
    code character varying(2)
);


ALTER TABLE public.education OWNER TO remara;

--
-- TOC entry 1533 (class 1259 OID 16935)
-- Dependencies: 6
-- Name: hospital_organization; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE hospital_organization (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    region integer NOT NULL,
    code character varying(255) NOT NULL
);


ALTER TABLE public.hospital_organization OWNER TO remara;

--
-- TOC entry 1534 (class 1259 OID 16938)
-- Dependencies: 6
-- Name: hospital_ward; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE hospital_ward (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    hospital integer NOT NULL
);


ALTER TABLE public.hospital_ward OWNER TO remara;

--
-- TOC entry 1535 (class 1259 OID 16941)
-- Dependencies: 6
-- Name: illness; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE illness (
    id integer NOT NULL,
    code character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    exempt character varying(255),
    marche boolean
);


ALTER TABLE public.illness OWNER TO remara;


CREATE TABLE exam (
    id integer NOT NULL,
    medicine_case integer NOT NULL,
    type_exam character varying(20) NOT NULL,
    data_exam date,
    description text NOT NULL,
    report text,
    criterion text
);

CREATE TABLE medicine_case (
    id integer NOT NULL,
    patient integer NOT NULL,
    illness integer NOT NULL,
    exactly_illness character varying(255),
    diagnosis_date_illness date NOT NULL,
    starting_date_illness date,
    type_starting_date character varying(15),
    foreigner character varying(255),
    nation integer,
    hospital_foreigner character varying(255),
    hospital integer,
    ward integer,
    owner character varying(100) NOT NULL,
    referent character varying(100),
    workflow integer,
    status_workflow character varying(20),
    insert_date date NOT NULL,
    sped_date date,
    orphan_medicine boolean,
    medicine_description character varying(255),
    reason text
);


ALTER TABLE public.medicine_case OWNER TO remara;

--
-- TOC entry 1537 (class 1259 OID 16950)
-- Dependencies: 6
-- Name: municipality; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE municipality (
    id integer NOT NULL,
    description character varying(100),
    province character varying(2),
    cadastre character varying(10)
);


ALTER TABLE public.municipality OWNER TO remara;

--
-- TOC entry 1538 (class 1259 OID 16953)
-- Dependencies: 6
-- Name: nation; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE nation (
    id integer NOT NULL,
    description_it character varying(255),
    initials character varying(3),
    description_en character varying(255)
);


ALTER TABLE public.nation OWNER TO remara;

--
-- TOC entry 1539 (class 1259 OID 16959)
-- Dependencies: 6
-- Name: occupation; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE occupation (
    id integer NOT NULL,
    description_it character varying(255),
    description_en character varying(255),
    code character varying(2)
);


ALTER TABLE public.occupation OWNER TO remara;

--
-- TOC entry 1540 (class 1259 OID 16965)
-- Dependencies: 6
-- Name: os_currentstep; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE os_currentstep (
    id integer NOT NULL,
    entry_id integer,
    step_id smallint,
    action_id smallint,
    owner character varying(20),
    start_date timestamp without time zone,
    finish_date timestamp without time zone,
    due_date timestamp without time zone,
    status character varying(20),
    caller character varying(20)
);


ALTER TABLE public.os_currentstep OWNER TO remara;

--
-- TOC entry 1541 (class 1259 OID 16968)
-- Dependencies: 6
-- Name: os_historystep; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE os_historystep (
    id integer NOT NULL,
    entry_id integer,
    step_id smallint,
    action_id smallint,
    owner character varying(20),
    start_date timestamp without time zone,
    finish_date timestamp without time zone,
    due_date timestamp without time zone,
    status character varying(20),
    caller character varying(20)
);


ALTER TABLE public.os_historystep OWNER TO remara;

--
-- TOC entry 1542 (class 1259 OID 16971)
-- Dependencies: 6
-- Name: os_wfentry; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE os_wfentry (
    id integer NOT NULL,
    name character varying(128),
    state smallint,
    version smallint
);


ALTER TABLE public.os_wfentry OWNER TO remara;

--
-- TOC entry 1543 (class 1259 OID 16974)
-- Dependencies: 6
-- Name: patient; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE patient (
    id integer NOT NULL,
    tax_code character varying(255),
    name character varying(255),
    surname character varying(255),
    sex character(1),
    foreigner character varying(255),
    birth_date date,
    birth_foreign_information character varying(255),
    birth_nation integer,
    birth_region integer,
    birth_province character varying(2),
    birth_cap character varying(255),
    birth_municipality integer,
    living_nation integer,
    living_region integer,
    living_province character varying(2),
    living_cap character varying(255),
    living_municipality integer,
    living_address character varying(255),
    education integer,
    occupation integer,
    exactly_occupation character varying(255),
    mother_education integer,
    father_education integer,
    mother_occupation integer,
    father_occupation integer,
    death_date date
);


ALTER TABLE public.patient OWNER TO remara;

--
-- TOC entry 1544 (class 1259 OID 16980)
-- Dependencies: 6
-- Name: province; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE province (
    id character varying(2) NOT NULL,
    description character varying(255),
    num_occupants character varying(255),
    num_municipalities character varying(255),
    region integer
);


ALTER TABLE public.province OWNER TO remara;

--
-- TOC entry 1545 (class 1259 OID 16986)
-- Dependencies: 6
-- Name: region; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE region (
    id integer NOT NULL,
    description character varying(100),
    num_occupants integer,
    num_municipalities integer,
    num_provinces integer
);


ALTER TABLE public.region OWNER TO remara;

--
-- TOC entry 1546 (class 1259 OID 16989)
-- Dependencies: 6
-- Name: role; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE role (
    id integer NOT NULL,
    description character varying(100)
);


ALTER TABLE public.role OWNER TO remara;

CREATE SEQUENCE seq_illness
    START WITH 700
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
ALTER TABLE seq_illness OWNER TO remara;


CREATE SEQUENCE seq_exam
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
ALTER TABLE seq_exam OWNER TO remara;

CREATE SEQUENCE seq_patient
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
ALTER TABLE seq_patient OWNER TO remara;

CREATE SEQUENCE seq_medicine_case
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;
ALTER TABLE seq_medicine_case OWNER TO remara;

--
-- TOC entry 1547 (class 1259 OID 16992)
-- Dependencies: 6
-- Name: seq_hospital_organization; Type: SEQUENCE; Schema: public; Owner: remara
--

CREATE SEQUENCE seq_hospital_organization
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_hospital_organization OWNER TO remara;

--
-- TOC entry 1895 (class 0 OID 0)
-- Dependencies: 1547
-- Name: seq_hospital_organization; Type: SEQUENCE SET; Schema: public; Owner: remara
--

SELECT pg_catalog.setval('seq_hospital_organization', 3, true);


--
-- TOC entry 1548 (class 1259 OID 16994)
-- Dependencies: 6
-- Name: seq_hospital_ward; Type: SEQUENCE; Schema: public; Owner: remara
--

CREATE SEQUENCE seq_hospital_ward
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_hospital_ward OWNER TO remara;

--
-- TOC entry 1896 (class 0 OID 0)
-- Dependencies: 1548
-- Name: seq_hospital_ward; Type: SEQUENCE SET; Schema: public; Owner: remara
--

SELECT pg_catalog.setval('seq_hospital_ward', 10, true);


--
-- TOC entry 1549 (class 1259 OID 16996)
-- Dependencies: 6
-- Name: seq_os_currentsteps; Type: SEQUENCE; Schema: public; Owner: remara
--

CREATE SEQUENCE seq_os_currentsteps
    START WITH 10
    INCREMENT BY 2
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_os_currentsteps OWNER TO remara;

--
-- TOC entry 1897 (class 0 OID 0)
-- Dependencies: 1549
-- Name: seq_os_currentsteps; Type: SEQUENCE SET; Schema: public; Owner: remara
--

SELECT pg_catalog.setval('seq_os_currentsteps', 194, true);


--
-- TOC entry 1550 (class 1259 OID 16998)
-- Dependencies: 6
-- Name: seq_os_historystep; Type: SEQUENCE; Schema: public; Owner: remara
--

CREATE SEQUENCE seq_os_historystep
    START WITH 10
    INCREMENT BY 2
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_os_historystep OWNER TO remara;

--
-- TOC entry 1898 (class 0 OID 0)
-- Dependencies: 1550
-- Name: seq_os_historystep; Type: SEQUENCE SET; Schema: public; Owner: remara
--

SELECT pg_catalog.setval('seq_os_historystep', 134, true);


--
-- TOC entry 1551 (class 1259 OID 17000)
-- Dependencies: 6
-- Name: seq_os_wfentry; Type: SEQUENCE; Schema: public; Owner: remara
--

CREATE SEQUENCE seq_os_wfentry
    START WITH 10
    INCREMENT BY 2
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.seq_os_wfentry OWNER TO remara;

--
-- TOC entry 1899 (class 0 OID 0)
-- Dependencies: 1551
-- Name: seq_os_wfentry; Type: SEQUENCE SET; Schema: public; Owner: remara
--

SELECT pg_catalog.setval('seq_os_wfentry', 70, true);


--
-- TOC entry 1552 (class 1259 OID 17002)
-- Dependencies: 6
-- Name: user; Type: TABLE; Schema: public; Owner: remara; Tablespace: 
--

CREATE TABLE "user" (
    username character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(200),
    surname character varying(200),
    email character varying(200),
    role integer NOT NULL,
    pediatrician boolean DEFAULT false,
    hospital  character varying(255),
    ward  character varying(255),
    phone character varying(100),
    fax character varying(100),
    address character varying(200)
);


ALTER TABLE public."user" OWNER TO remara;



CREATE SEQUENCE seq_file_case
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;

ALTER TABLE public.seq_file_case OWNER TO remara;

CREATE TABLE file_case
(
   id integer NOT NULL,
   exam integer NOT NULL,
   name character varying(255) NOT NULL,
   file BYTEA NOT NULL
) ;

ALTER TABLE file_case OWNER TO remara;


ALTER TABLE ONLY file_case
    ADD CONSTRAINT file_case_pkey PRIMARY KEY (id);

--
-- TOC entry 1874 (class 0 OID 16929)
-- Dependencies: 1532
-- Data for Name: education; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY education (id, description_it, description_en, code) FROM stdin;
7	Non rilevato	\N	01
8	Nessun Titolo di studio	\N	02
1	Licenza di scuola elementare	Primary education	03
2	Licenza di scuola media inferiore/avviamento professionale	Secondary school	04
3	Licenza di scuola secondaria superiore	High school	05
5	Laurea	Master degree	06
\.


--
-- TOC entry 1875 (class 0 OID 16935)
-- Dependencies: 1533
-- Data for Name: hospital_organization; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY hospital_organization (id, name, region, code) FROM stdin;
1	yixsMdxna9Gv1D6S0tc8xE5eLPoNwyrHTPQFVxb4Y+w=	12	xjpKzT8V5TkXECiCgD5k94XN7v27WjTZ
2	uCgGeV0821OSPom3+B42SWjoUtlGQFzEh2fxK8ZMV2uE/Qm3eyFLHw==	12	qLfOrzfnWm29XSlNLdpmmmfE2YsW0FgA
3	n2WPEW4Ae+yKJb5TtGL9luy7THkZ/EkFizdqNqCtshxthb2lWSdbwaEkhdqy2i/2etSr1jIhFA8=	12	D3+l/uov/Z5ULkD0HMP+oc1d9rqLpeRi
4	JxRON6Ka13xIdg61mMFxOixcfTh7kBPz6XyZv9+WGvhwaar7U9gRprhuQJTbhwM1	12	7n9T6O3vntfsaWK4hxmiBrq2OcNU2NnB
5	sojcofSuOdWAu01KF4us4eB6Du8FWmop3eBb3ypHoXJ9W0hNbeFx1FtNMXxHr/usCEQBYvJ3lHA=	12	SntbtBZiOgwW+8DYf8eZQFSWm2vUCHx+
6	VhGGoBZ6Kid8xEUkxLiaVKCWyRoKyQzX8UjdRGyaF80=	12	lXmQkF7FMEmWfbh126ToFdO0xjT1VoTA
7	6IJe7L47QPhOjlTuWgfa3nTF1Y9ZZma2ZAw1b51wlgnKFwK3uGzHlmkFjRnyQNev	12	uAd73Xh7HnwQ9f1hmdt/9SKdKhgJIEDj
8	6G6yzj1Lv7hbYzt4uvakl7JkDN1XNr9wKmvVR/mm6SQWYPocE5PeTnTVLfRhnO3UkEu5gmt30NCG\nRF4v89dUiA==	12	L7YPdHY8NnB95UKXK4itYQUdE3CXmHcL
9	NZWfcBrLv4azg3cVRR1tTsQUwoD1gGd0/Jp9xKkEpvA=	12	N00zdmBM6TzbGq147tHj6ss8WVn+NSan
10	Pd0dAgyyTCSqVs1DdYV/URFndJQQdoyF48Zf6DU1UBZOSGZX5uBFIaCFuEhbFqezwjGiy3XO6PQ=	12	rPLOqYYduVYfU6fIuLsU7yVSyo9gQw6g
11	4/Byyf04OE92ohC6OWzfLxUW0l6pHpyv80QehZHXrgl4qbG/AwdSwg==	12	pwIohsPevikiQipIA09weGlr6kPqAJ9V
12	yyY3m+4Dkxd1XfhqQwAGHEuwTOV590TRAbwyfSk8Oe4=	12	yIy50nenBN6WYOpSxMB6ZSO8YUlia5/f
13	D1ggNvkkNbQQZ+liizlDWS8rwgr7VZe9myA1CVoeNKd1cB5jWgWXTQ6VYRuMkeYTvQ0X41n3HkCT\n5oNs74kwmg==	12	+hW+j3Vo0J5DXWznbKXq9+lJJQjkjxeI
14	5J1ah0ao6/Owe3/8yXre6QaJ9+o34Y9YqNylWDijP74=	12	e5cRkaYpPbsitC5eX+LRRz2hURmfKN3A
15	n+AG4wLEmqbunF7HBiLOE1cMyc7lADyqLkYNrBHdG4A=	12	OH0V5XW0qetHnCk8VPxrJqj/4P7Nidxr
16	RTBiawYB20Kte7mnQMkehdf3Ib/+Xh9H+LUHyLyA61A=	12	dfFIZsMdOs/sL2/Z2ZMwzGWublxg9U5s
17	exnW60dLui8+d1CaRmF1DqY7fY80dhZujtzpReAhvAeHNf8U9GbN72nZ501IEahA16yABw3IjfpS\nHyTlMxhCwA==	12	nj2PcRB9PTJcoYQk/Hgb74fUdnOqy/v/
18	SCzT393MKo1JCua6r/m+9C1aQcUpQNH2ZslqKfW+hMM=	12	eG7ILVWAqPkZ+ejpQTiNiZsoa5zIWV7n
19	POr74vY7ywu5NI5wdtKnk0ams6oQd9tj6DvnNtHG3YBMx8oIKmod1w==	12	BRIBksJWLzNwLZUxPuqN7aVv0n+iHeUN
20	B7/ehh9Db7wv6QSfHAtm6zKU2AWCxJQf+WIH25o7BA2yX6s0rQpH7g==	12	kdcBb5Bl586QGvyYWWBmlTevwHrz2iKd
21	bjTyIaXw8pL4xmum3xZL9PumCz/ILb/u2soV5RaYpsUqjC1gSz57kFvs5M5AgOHo	12	ttoKanU/2lhuYIVCcEX23MzVhJF490Jg
22	B7L95njH1Ro6roCYo+Iq9HwCbZhpK9IUr7pzvVj3GQMayQCAXPnmaA==	12	gg6hg7aUtGqwVQ77oygaUPj/CplvO+xA
23	0NaOxKlHPTT3fqsWfVXqC26aqLWhocy++/TdoGZih8+PsZ6ugMOFcg==	12	L0uKemvJwa1aLLnC8LT8rSxyMJX01bbY
24	kClpjYxl1qcdolnULSUrZEW8/ePLH4X4lh/omlEF9rFzc+jKf+ITf7gwdInIMhI2MNni9HUFXVjp\nFMO7N0+OKA1TdWEPaWnb	12	farxUhwMQxubadZJ3wHfO+0DJorSQ4lh
25	/WgnSz3F+TeA8FLJYt9TMBYwJNmvGQtEOSX4ML5ZOAdXKKIx9tCwQY89uYfam1pdV1f3N4Kl7fOH\nb3At5pIIR58tPA7VKW5i	12	CY3QX0ZuPGxifnpQodCCRt8SYRcB8GgT
26	unSOXSIptZcdNf97Ca9knKZCApzS3E6ahLIuI0cazJ+Ohf6gCvjEfg==	12	MwsPWQ31sSNT8YRuvcaZ5sQTCxFwVczP
27	wwpKBcFnft9xRtUJ8Jlr5WpvBhkfQ/XTQSL952vYQHQlJcufZ4mXeuTCRZ8K/fBx0yuk0BmLXpQ=	12	eRg7GLcBp/8xy8aFmCvDN9MrihEv88VD
28	Oe835hj0bVm/If24YitJEJ6uTmt3rDaYVMhnPvLyJ8M=	12	1dIh+tdHzl2Ta2NSm6T/9bWh5P7JsiJN
29	Jr7Vdq8T/Lwt8900WCRICK1hV3ylmudwR3ErXPWP2h8PHufw4Jwy6w==	12	EKmbVURAziGGgPJ6jtVU0OscU1dS/bUS
30	qUOyuc++SiN+7UPFM9mT8HdWQpM37UKBQJneLWQYePUIyEJVpNORCw==	12	Fj7KgXTnmTVmTDwZv7K5u428T1OVhcXu
31	3dUj3XPyA0wOB4VsuKRqv9qUerapPfNw5uXEBr9bIZ0=	12	n/9vczploApZMMEh+o+D33wXVzObNT9i
32	/faMJna1u3sDQIbgDV0AaEr9ZqjGuhQxs/q//raPfJPlFCWZ+6qiMaFXU6qyPGRL	12	eKudKquVyyLzidIhknpnbVL7JDTd3ZPm
33	F9V0woJ5OkscVstw/kTf1afo69HbwUDETIl8bD/It+4AjBGU+SwbYw==	12	M9TwcI6NX6+0CkmW5ARVvF53pzX7AxS+
34	vT4whnDUHiro7wepVxM2deZcPq08jq4u6NM2LZPqFL9VBAGf11v52ekP/QzbIQcc	12	QZEny4RZ6Q2V1r8loI0dGNhx8R0n09+T
35	3LNAGtPpLV17cPFaccBP2oc+uPF/ys2nadCteROO/Am5t4mXAD+OUjun+Vhb02GX5djO6obnuR8j\nvuZMvErmZw==	12	3NmjersVdgKbvtJ0sM2M8LgXU5kzATxw
36	uronrnhn99FX94JlEazZ9/BW9OHW52MEa4/jHdGrMLpfc6jda8khYQ==	12	94kpvp71N6XPykR1oosbBtFyKbtCHVAD
37	AzrNFAVNBSBl2z8tpa36BbQToILihjmhnwcU+lNY0ivrXxGCdlXj+kvUbzlWBS4kz+bhHX1rVQQ=	12	UmkYohs0sNSUdt6Aw5U2OmaJvO+k5i+n
38	O0ujUTDw2Rrj/STIz2TFTcIjdK8F07l98F3krZipfnpbMzKj++iQiwnoOnKzS+r3+1K6l3VXh5Y=	12	x0FmSgfwabSjivmxkxq2LiS6cW4/9jEi
39	HN81zZpRo2NpUpng62TVJ8ihPcFfll2brRtmS1KOyoty5qTv5Rqb3++fWg2idAZsJrNrEIH4dXc=	12	+51NVOgIo8Lq8CEHcUCdQwI3Pju0T1/s
40	ehaOjbGRz6rLFK5golPQXoe00BYOCoXloZlLSbBxv3uDPHnlgH9i92ZmCcLOJaL+FaruuTiX/zA=	12	jOoK9PR7W4p2zFR/JLnaFintzq7d3gnz
41	cvop4MDYw2XU7/ho7BNbwyVByJFIjiDSJbey1iaXduLQnA3nu/kdiQ==	12	rYpVQTY3qcBAS0zV4SelDkBIq65PFB2Q
42	mBd+leRivHXfp+UMtX+mmQP9XbO9Aw4TmBppSb01MhryLwbh687Vzg==	12	WPCpErlusp259dGu+W3vb4scWA0pwfHY
43	s1NqGaJZrFfUzAGwyBJlicFRUFJ1GuzoCalKa+hP7b1XoUTW26OZDA==	12	px173fR9GqwT6gxDwFxcWXDoiqDEq1k2
44	9eIlmTMKEduDNPMgyGOh7ePyvrJmPuX7icxeM/Ivb5J5/D4nLuwvDbUgGvieTmmj	12	CRR/QiuGEJ0+onN7BjbcWES+zFvABY+E
45	iYvtfEM95NsFvRS2k8Rl49kaomslkwAokuKm697OpIs=	12	n81F/Qk2qD6pcimof4+1Wwob/vQVRt2b
46	rZHkJ7kpKvfqDSfUuUW6wzphllji075oinGLdAOwxnU=	12	JiD86BMslOj6nONySQQXiIk4+MkBeb9N
47	DbdrE3lK44QL1gUXBLHhTt5lD04GrOgXgAxyKjL89K1mC2cLV8BNqbgVltbw09fr	12	qinBzMd372CRW17MnHrCT3FlkcYWvZyp
48	4qcn3QdjEhDhmFYOgo9Qx+DL+e+o0hlGgZOXhw0lt5IKQoGAwGUr6w==	12	wbbVotgugJSxcGdkcGabq3tfLQves0HM
49	E68HczAiLbSD5q4b1MFnv3dxPm3bUTSLm5Qh8Tbft0hy6rirXDRWK6+S/hR+FtlP	12	5neE89kNpOdNrXAkQofsHpJkJwph8yBx
50	xSZtBRqSvo+KYwbuhs19LlA8QAslKLna8Pcfd9h4y/rJWH+OPIQmPQ==	12	Z+oDtnuXGsM68ZIXxSr5/pm+smAsdyKr
51	h1n4znWaxZs4AfJo6sgMaH6/8jLWOL01yaT0vixprx2pwoDjuMjoPA==	12	IMzpd08g0zmgMjkxakFHx2tityoZXr0L
52	09ii6ID7nDij+G/Qvnx4AcVg204NrIAYnxUopk3LGkyexQEwaZIU+A==	12	vD3Q6mlN9fRT7qMmf+JmWapYj3BCXWk9
53	QnU6Q3YIwbH5iJ77DhcWlOQ7wmdhEpPMb9ZM9KN8q38pfXXkvJcqhw==	12	XSTi6zlt69IPk+EI3YG3DzYTVyEu2gSY
54	q7aLQZoMuIw5LAsU0q01KSW95bAgzbT3HIU4jkn1tvo6pp6DKFhnShxqn8ZZwcsn	12	SprAceT4lPhcQqzJT7/0oJEZuu1VQ1XU
55	D996LLDPnanvac73hdN4dMlEiBunNNcLutkZh04jSLGa4Dxmn6AogA==	12	jthGTHMmkSHcm0kHlU1OwA2dCKvarknQ
56	c9LW/PDliHOLn9rFVrvMWmv0ou7421g8bCAa9pyXbQm0lX0xzMZ1BCEEs8NXAxQ1	12	27dhgINhMoLBP0egDlK6M+bu+bHNoJYV
57	5MgfslpWQMchGvZE5yqKY6OUXlSxSaW1tCTxp80uMbnJUXn6YJB078c2U7yFhEDJ	12	kOPEq911sDn/pjGR36wK1cjySXbc781v
58	Y17/GztQCWhJ4x0sF1fMbAgrXEDQH+532j4k0qGSE7agB1X9js55og==	12	EcajfJJM+wkyJrNuHbniVZzZVo3lvTrd
59	cfxGAHCfuPQyK951nCUud9sr831uW/y15DHp1WrWcpE=	12	8V1QSajxrTdOmulSJD3ICE/vuf0s0m/m
60	okFl98TJBIccMPegllxhKjAaVclK257aN8Fl/ZIyXyFCeSbCcroCB4O+P6+I0glluhFWLvxFIzew\nu28xgrfY/A==	12	nW9Mtf1X8EZJVA1WV2qGD1vdDJAxXzzc
61	kcl1ZWhyTkXc8Sb6vKUXwhYWjYNfbtO5n3etwwqRZ4Gg3k5ElkZj8g==	12	9dn851PIE9Hn5+9jtj/mxK9SPgHwp1Ak
62	UJFiHcwn0CHUppnI6WcKVjMOExam/smGjo++0Nqo708=	12	s5WPcdH5KnqGYY9Hr4NzzyYPpMhGMTiu
63	MG0LGdDIZesYsFCgE3c3l2oaZH7V+QyNx9vsI44r26xjNE0Bg9mUgQ==	12	W1UisKIBWxSYHiX1b9ycp1x7CwB5PKx0
64	ClLtYEpyta+nXEVHL1pPG7M2JFiTy2cnXMWg+6P1tQYO1pJbqhgDpg==	12	fT8ojEW17bLWTBsxc/+0dSSGWnNIum9u
65	sYkGs6EdnVMUQmXWDt+hbZziRjhz10VwHwK2JO78UxIMAgJwJASkpg==	12	0opnbxDk197VoBhbhh3f/1KKsu8xNzCI
66	7EEpHf8YZnl7NG6nNRtF1Q4bxARarc8lUut2C9aCwRw3eHIvUivWXw==	12	YKo9ceHjrvLpYD9fdsHCXyHZ9q4GDKpI
67	INDBHafDOIBkObbjrJoIymMsv2nsw+T27TuN8bxsCmlOhV7AGT6/jA==	12	sy/VXOcc7Cfm36MFWiCrNyJD150GwI2z
68	OpjwbicUjtEjorZaPuAb04mxXgbTYmJiIe2BStXsfnOVgbQPVyl64w==	12	9uzksX067L8fEVIae0jmcYBJr2yBEWtC
69	MTqel5BGFaNSrXckGOclDrd5IyFxa9V5Z1PEEii2UsMFdjcjJsrS4A==	12	oXCVaaZ2omvCyHtMZFwaIPP+1R7a7112
70	/sX0F3jbmGCRkRuJfvE0zzdK4OGttYdRUR3EzQUw88fLoDuMpCJ99g==	12	Pi6BsJ6gJswk+0OyBPtuubo6n2aVDboB
71	gD48mO1zjnHBXF0hRlPPMIxCSo1f/3M7htg6ErYRIHVsfYC2Udiwdg==	12	4JTK3EN1th4fFmKEWokKtE2UmeDp7ACH
72	+vAc2tGLsdCYAq8L6RWTvme0wCqFsSchcNqhQCqFMcECiruiDpQ3bQ==	12	o2xfHbTxODNf5LvO+puWzO5+vLvlHKCQ
73	f65vGkXWpA/1D9mEMV1GunlCUXi1oVvQfvx+2MfIszgfgwNX7s6skg==	12	K4B9yxrsa/0js43QIZBmXLt80K/Rf5S/
74	nuPViZzruJfRSs7BN/PN6L+xpJtg1CFEVLMpNjxV8Ug=	12	jzeMcYczoekDPZVBbgG39PKnJBVgWIs3
75	VgsI0jFsn8Bm9pavcZM2iT2DkS26GXzVKeWT+4kP2ug=	12	4W4btCdVzYcS+NRxXolTHy40xtwqqplF
76	Wx0EH8/awx19B1vNQGO0uuszsnAPw7VWv4MmhBu43t8=	12	aFklMqbRcznyj0rWkKS1OsWTw1ZGWzkl
77	0YT+kwOupru4rEmg1F2B5qb3GJowDIbHb8W1eKaF5pY=	12	POhoHS0DT+N9JlgMqfL6oZWKFfTTZcZS
78	uv5ef9MiBxgc8i2EUJn1lckMHraTUywjBRJ2PfxxATtZ0CTT4bZthx6IeVOiS4SMJ4nkMuS1GGM=	12	QJWoBTG4O10uB3N+FeRJb0LbecFuYKCw
79	Syb/AXcJ+7q4weSa3ycHh+zvUf1IgJZkXFhZH1LUOdAq+9TE77WSAg==	12	pHWPTnLendruir7xhP/K6SK59IDFAIHs
80	B9c9IPXriQJRnbiV2A6ee9yM7JRFnWdxwSgr9mcfWsA=	12	OMtcbeAP0I/dtcfjm18dNtKQX8U3u5jR
81	dEF7KTpXxN9K/KgGR8caft3Ll/7uDU97KVu52QGpfFsRSqdfC38a2Q==	12	4KhCSq0iKwfvguQRG24v1tShjcJcZDOb
82	xq+EJ15NzRCOmAILn/JBSi3ujT/gkPXKB7MOKblff5CP7LKEWitjcw==	12	3g5tMXBQEYJOznNTI2n7OR6/RnzD62PK
83	IN2spVCC3cqKW805FTDDoJXFFjaaterc1JHOKU4jEVY=	12	0Zk76WRtPO80jlP+WlP4fTDpthKP3eEa
84	4qjv32d5qeHIFZMNqpZuoU5hgP75apWI1Vzg9hUy+C1gHJ08ayZFfA==	12	K9iRPgvLKeY1dyTaE4Eybzf6v6xYhlNI
85	W6j7GdvdJ2rpU7pdwiOxobG1+fqnOLQTDVJVPcERmDE=	12	Fdu9xB5FAyNR7AYKJNisAcEFEIuhg/Ci
86	xAz2rPK1ZD65iZq8urwg7vprmg4ReFCgLRGAdU/q1ls10bvmXx3DRQ==	12	3r70lsG9aYmbjonLR+FyEkKZ5jOqWT2c
87	vPj+dNd4kifKSmRQSP68og9CDdRavIRpi01Zf5PEFZE22EewrW2kbnh022LWdYgE	12	KZkrPTT7YMuJ/RcTVSNb5JT2eS64W9KG
88	fDN0neg4duk6OT0J3VDiqtJvFMqWeTXZ6e3DWb09HvbnRrtfdpzv0w==	12	zWLcN3J4w2IEAK2/u/+BA+IG1EkVaXl0
89	n7NMJmmz0pnRQLSPt0YQ3FEl8U6mY/4KbONQYsIwJro=	12	D9NCwiJ67Wj+6KRif9Uc4ksAz6qiywIl
90	EY7uXke6U/yNaGDdNnv0n+Ja/q7O6KdywXninp9ZSRivvUOdptUDKEljpeIq7Hz2ZnahTiWyvgDn\nsYbQ4NxYFA==	12	JN9fu1PzDOO26PbNC28NgdmZfraEp7VD
91	Jsg877Rp1mjrWBje3LWp+dszqgBhS95/AfJ5YqqsXLhoZTIKAG7qy4AN9KJ1NL9cxZbOUUhsoK1G\n0uOMDgeIgTWMZNLURwl2	12	QvMUl7Sn/OvyFslRscbueTVj2cV+CB7Z
92	mVTmo7VmZJAh8Ak6Hel53jV2NI/i1d+dwzkGS1ok0rCPBtTLqAZrWjMHoA7ORhAY6EZoYXmWgQip\nfAs2ndwPJihDqaSh0uX8	12	G4mDPy7xNV86WP032rxALC+qfp5H4zfc
93	fgtqrvF4Y14ke+POSRYt8lF6kKkj4RSlBwVoyHod2ro/TU3IIIUWbXnNcFMRYlPmaH60HzIU6+0=	12	dZQwPXMK+Gr/1Nf8RVfi/i8HNiKb8awX
94	2iIW9Zxl8dZoWiw1EaKfcsaac8euE4X9lSSn3MEEuYkkU7Y73pYu13Uig3t9+f2E	12	eMNs3U4YeSkY74tTAr32qMikV9IArSxl
95	OLd9te1VGTMusVVOimA2hlI5pMhhtQO/9bnBKaWu/i3azUxLzeYwKQK5vXsfQO2PiqXaPKStPK8R\nadAOEi6UYA==	12	DloqMEJxeBUO8ZL/qDumnzGosP+hjkiu
96	AjYT+700TPO9DCS5RO5AjA4gZSNLjQnclBecRzvSUiTPhCCz3gDfHcGIM1S1tf1V	12	gxVwWnjJhKSV/9/6Nov8NCRVoKx212r2
97	75kSljO8VkacQk1ILA4PVtj4PtgqIUBQg4s34KUB2s1aH7vGnj24y9bV2jOKqx+FBf9tqWhgqQBG\nyg2RPVv7UQiQhe651KjT	12	DjaDMVbAUUX1y3kXAaBPug1IUZiDoj4e
98	GUOe3KefsM7rOjQSo2UqLXdpSb3YXoY9o092FTlmrd0wyrpSCX1xAYpA+BffeVhUA3HjSFrn8uI=	12	/KzDgeBm3X00Orza1eZ0Tw0YeOy4dzaJ
99	OpRn5Dr10tdEAeQwkpG1N3uMEDTkx7C62EoCJVEkLGvg5Ktkv1bi06tNXFsokBAGC+wrnZ0ZNpw=	12	lpqrdUKKzgIfYy5SXxkNO6qoyuhWlAdI
100	vJayqAqkP1fGxofxPZituceCKUjwYMO2d1JKHzTuMSE7l7+29Q5vXQw6kV6GcFMy9qCKq8tJZmk=	12	agZs3cxsdzMROQaUZ6Nzz0OHZNhzM/Rg
101	2/2L6jVtzfl+Cd5vkwqKg5tPr7YrH4Wc+asge5QGt+Z2ElAQy3g1ZA==	19	ZQBb8Hp/DOaMHosMS6AI5IHs8KVYV2PI
102	hBCmDavOG2ouKz9vEyJ/rQ2ti36oPSYvVPdLcBrgIhwoXjvz53T0EecfJ1xhYCzO0ptTOEUAl58=	9	lJsSP4nkgA523ElvYX3ebpbCCBNmvHt3
103	Vu2P1ha5gQPYJQIRkuN6zZXEKRLV2m6hXb2G6z+73GQ4cIpDa4aWTyCDi5Uh/Xdf80p/uHGGg6s=	9	lBbp2EzGnNFwFvTTUsa2haeMiCKAo1AS
104	tLyyqsi+djC3WpRyevP05ceKp3pHEbJtu9PhjcU2JAeyAxo1VfSZWQqvQudMRm00	9	lyA/fZdSIYUiVwlZ9KFxETacX//BJp2d
105	OX3J4O7pnQ1DyqFFa8vZVBlmfCqL5cNwujH2pKDDcBVhWD1VY3jH1w==	9	q2y9WrUvewp4UvIFcwLea+u0L9cqkCCl
106	/Lyyzkv35PyQLbVhaMaDOfP3LtD2Di/zcmNfPOnGlw/fYA2SKV+jLbkEjarpO+PU	9	0nMnHbmjtZV9dSLqphcvrXadbkYJmX+h
107	KDOg3rvFaevZbOTkRzVbjEmMruxrECeTd8jREe2IC2SW0bmnWPcrFA==	9	mni9CAXSuq+TXMwvPbowDnoupuA2Gxls
108	rrRQUWEJbKBio2ZABQ0JZv7qdKUVdBZVM1N1gScVMXYXJpi6yE0TQgg6c3W5sWQK	9	z1TjQRqQcCcMT0JQqWHwPatYQ/yli/kD
109	lggdGEEec+q9wPrEBlBT/YFRofbqLmGtkmHrYO0F3j9ZGHX6UCIu3w==	9	nO0WgMz23Mh+GdwAoM1A2KsEbKqwpMJc
110	PpmmGH+9e2qSzetzd92o6er8e1XcL/V9epNLv43PxXo=	9	tra5Gz4fl8x6848wlbDXu8R14vfLt3MM
111	7zSkffQQ0qgTWQRUP6EMHLFZK7sTnTBbfQ7LbWb5G/O9Gk7AqGvU4A==	9	HjuNsq1i9814BS/SYP/zIFB6pXatnYYc
112	u35o84k4WIhKbI2Gok6c1DGb1KhREz2Zk+INIQQJX4z30FZc38Pavw==	9	SL/rXQoaX6ZOs8PRrRaMEHFGLNQlFyG+
113	D7Yvtey5a778HGVbSmwOwEAWXwCDlBUIZ3kPalz9e6o03C0aF4skgg==	9	Zb8bT+BXVRTRtIMSiNC4hCYojYCR5DfC
114	VZlvzGkcqY/dEJUI+cMgpz3DLsKP5IhzfBrm+K0zGsqqI14vCVJscw==	9	2HYDdpPM5a97c/ITaEIYYV/AJzIPNyGA
115	nmrbrMXpSQG5LZQkRAVOTL1tf5KRLywNnTbJiJrPlxmfvKciVEZOIg==	9	FHJojNEF6zX1oW3i49JI92knRxXiTxtk
116	t4E/0BlbM/dnp87+9OlG77QZKajiguXT08WUCa7xNaUCNyIIPbrmzg==	9	8y0T6fdYjShYWFCIi+aLRJx+03r2TthX
117	ZOsW1+rqPMHdTx2//8Py8Wp4ijJGljZcj6b0DxqOEecU+sdDxR4n3bII/U0YF9Nt	9	FYwhxtPPXGLTW3Ij/et6TBH5vvHeEkN+
118	g3ox/D3nOGkIeie79EbYdQcdUj4z+2gwU0lk53we+7E3g78XV5/dCfrIvXNydCb3	9	dX6zFOKyd6KDSaipMbNs6ucOMjHxxwzQ
119	rhy+NsaQPXDFpROmz1laR7jwUiGtMwIp6NN8vBRb0XnMYvG0rQoBsgfkupF3ouibSCSkyxf1Xv8=	9	VCn3OWKbyja32joL8Kvq7ki6ERbBjap+
120	1/FnMkdQWZIqz6au0O+PrFxiSFz3gR8PQrKwZuz/hNqm53mDOR2SwxiwXMl81W4l	9	GD+KSBH2WcfqD7KoFp845pgcpHs8pPcW
121	nazBuS76529/Vikx8MTHHkWgdfw6EhywepDsUAiktrF+5YQ4EXcugXv32ONxi40ZqNK22AZuIi8=	9	p2nsOL8S9qvVwJ9NdcVWXkm+SWV1v1iB
122	V1HSKkNc0qaSiUtoPAHr6rOU1TvQbQY3Lvx/NsIW78SUzO5MlQH/RQ==	9	5RvZyl7JRyk1poX7Yea23nXMBD2daSL9
123	ecTyV03oldbKliKuV4HtO4a95VaUz3hyBTXY/hWekfc=	9	jrVCFIpe5CDhGi7nsID7yv28+jHfkJBG
124	0S1lQh2jWqY5PfX9u1KZ/AY56PbzOa3fXnj+wOUPjreP/gqhK4Yyew==	9	Ejlh/66x1FOi1CfPZYzA3xuyD5l0jtFz
125	vxup3A32DYHO7mOXzVGsjxbgv2U9t0g95hCmL7JXCOIXeZh1vRfCuEcOac1M5sitDqWPWluSX68=	9	21a4jkzRZLxFMS/CIcj+y0quJYI0xh2w
126	BXD7WQaxbo5NJv12af/V2nf2hX/X9qTSnEm4Np6Sz8FxseYDzOZEAuflGATze4Eo	9	cjQ8nAvT3TGuv9BvmZK6uDjvuErnqSCh
127	2FgRzYui804wmuYD0As2/QOiexropgwaGPGzdkpjjNQ=	9	ThTwVlonsBOU1QJARRPt83y9JmBwnu/2
128	0GqH5TaUKDmZkzDpSb6PPMmJSiuj4qSiUJcZ8/49ivRDXIs4OI+4qd5QJ5ZiELx7Y3BvUjYvNHk=	9	NblKyn6SJqhwRQoha4F+VRt88+Pz+Ycg
129	cbcul+Xyi/SdCSdJQw0rnrITWh6whkwc69VFokhPVFRI7ZBOB7tQcg==	9	fOZMvMf+hKv3vH49TwzDeMOv3pNsNDy7
130	TfM0Zs769i0uHgN7IYvdO7WTAEhifWhg9UtC5VZZcroyoS/MMWMzYuFnFbZ53Efp	9	OoIiEybLl62IbaIRQXh4mc8fAg54JdCH
131	xFOLtTNJY3WFGsAYz5L1L60REmNIyP7uBfp1B8VO7+f0PoKI2SojlYSZwMfl39cy	9	e7U1ynSWiqLyiaqYsekjbiLm2WxyiOib
132	mKDAlFPPJHzZdWfmnq56vEAsDJZZwjCG5b+zn80HQUd88Ym94aVlYW60p1BHjeHztCYjvkPmYXLD\nN1Q5Hq0Hiw==	9	IYXuhC48nWNLmUUnnaSVB0pVxOGzb8oq
133	QOOOJhuIy2ktA8PkSt0uZTNegi31q4nu9EoQtvR+oeFvHmC+gZmN8KdWDHSsJc2J	9	NnWNjGrIX5uI9Ymnv1HynN9P67DVVsBA
134	k6vRfYuYY0zhUbOAqEUH/yPCjQYTfvWmwsAtoTQgwdR9ImyV5/h+1w6pB9uFhJfO	9	ODUgmh1ivLfQmNIdiU9VlPwkybPmtqpn
135	Twgg8ci5cOuGKstYHD6qAu0UQxDzxS51bn0DA/XK1m/8pkqLTo6sEKKF2+NGIliXGmzZv3i6DkQ=	9	RmcGObRR1PZj81plilYmln+ExJjYByNe
136	AqRgoMOiKWuZBm4p5R2FdGHDl6KviH/D3hYI8Ydf3vfhsVwQgVzRVeq1CyR9cdA+	9	ILAwKULr3RVHnKTejgJk4CtLhefZ2PhC
137	HnwgsRISxFn5XOWXQXKsXZ9cYZR2aE9Wb4516RGse/ihatQlPYe3fw==	9	GUOGjVCmt1k+NcRz9ipC1PLaEpDznv6U
138	vOdDke0AEjmt3wn68NwTjnDCzTe0UtwoWeTdfvOMyfWfJ4X1tcFkSA==	9	sSaHYWsFuLwYygWNSgR5ou60b7CFA0E2
139	FypYxJ3EV5SmTf2EZnUiwW4gOYUnQZOFOijut39iQPp9inHkRHjybmNUeTGogJFe	9	wMNHSU4oUJ+m9xXkoXp1ows9+dbf7E6F
140	Bex4HOdVT6kIrSWXQWI9Y8DOeWZvbZESwDK1S7jIwwGuCmer9DlHHg==	9	pQW1JJXVRFvI7/e2pR3DXNdBm4NmE19F
141	57HXxUkEF/kQ56jK1e1bB9l5MDze/J0/L3uKxTpVjp1W5fs0DFVRTLg5/m1tQu71UnvvLoF/zuc=	9	EbV8aGE3rZwg3ga40T+kGcG32VaqNKMk
142	m/SSXfBVgYIJ7ajESlaNsbvDellfldSuy2dZqC0Qqg7OBWwUCqvn5g==	9	bZ1nv0HqUONLajDYg1M77k5FX8xBEBTf
143	vWQLAG6c5UvhFQp/wyJQem9FPJ7YOTny5Rjg3nwqV203eBUYM/M9kg==	9	/34qcvUjqB/ccB1qy0PsGx7QI4M7LSis
144	vbenVa42rL3TkQ2sI3s6DiUIgAlOBhcCmxELz2zm3dELcs7gsM4ldESQ+enQjB2S	9	qxJBRZ0XXaX+cES0Rxl55QMSJPLxO3K8
145	HDt6eEnLfrVMu74yJAf+ez4Gkl3tCxYFrRa4ABR4YjC5hc8i7p9751tIBT3ZYNZz	9	CJ7Lp0Z66HlH6gozCnGGe9ocqcYOsY0y
146	77iA+CmbqQObxJfhWGlJ3TtMER1OG0KTvb2dYFlEUmRh5keuoC0+JQSautMSoV73	9	bOjEwadxTvI+XSnhGDk1BiDS9XCdig2k
147	uK+ZYVCUf7nGoOxyaucxjCFwPFLv5dMkKaLArLT+FP+Gn7454BiiVA==	9	XO98Wqw2w5TmCsGZfjHXhw2uwq8UCRcH
148	4SnOShoz3xxqimHJ7Pei6w83FSLoak8JWHJVBR4Z+ww87/wHqweeDCqTg8Z4fLbTM0OH58HHvSQ=	9	QryYbjC3AguHCkQejeEp9vi40WYQQbfe
149	1QRIOWGlRi1/FPbDprfIdtZ5ImEmH3deu+NNRknajNDEZLntSULFkGZGcCaVysci	9	LaFz4w6pcttxb5bMMoJ0y7f9JjQzMEPg
150	5cb379GoqchCxGL/YcuwNS9fuObZLruZTInWbd1wCH+0RFlUueNooQ==	9	YADU3+w75dVNlknvtl6bku5b1oGHkS8d
151	58/SINKrN26XOUzy2OOvKsNLPgCSbLhOKv1F2NgRYK3WLm5vlce3SEDnzT8WtyMexX4jP9sXldc=	9	IPXg1LOrGCz2qdGIKMLXazRnKDVbMpuT
152	9SyYVw5vl7vqDi3fDkhc+cgBj2T/PBVDtOrUKgLNdDGUi9VfUg4frCFMfGAlcP5Y	9	8IB1DQEaLAU0G9+Mjo8X3t+sCs3ndNH7
153	HhjHYrjL8AxxVPgpKTsBFhPbLNHkxLDPXbmaDveBnJaJwhYJ71iXm0tZ7BuL3wW7JlUpgCxh6HE=	9	cqiRJXxtzgNUciclbMQkBXBv9wCN2/GH
154	8H+O9zEkPmx/vwzemOSmxdTxhOrx0M7PSgK95LfO1mvTcqy1/Wo8iQ==	9	ITPJ2NU0U6DBKQ9le9eM7HGHkWp8NeU0
155	26zPUT7WzAK6SNYAPvYb/VztIxkOJaAg0IEsC5c5+Hg+pHG8ZBvITy6JZgAfcG2UEpqF/bbi2Xko\nK+lh1gQczfagLJz5xQxZ	9	lL4NPud3IJ7BKMiRvyH3RIZdRMKmhQpy
156	CxyXF6jJJkfVcov8x86P75BdExyDoiMrHOmy6MOignU3r3NXKKbAtQ==	9	EwlU0ftzExGW6W9IYqXqrk2FDojcyzTp
157	43vKMlYMbxhJaS6pyY+cFowCH11eC4M/gbIKrCQqYOy1kYYwlsQBew==	9	6VEAnZbwwJJkbH9YAZmLJdrOCJTTJtyx
158	5NMQi0kbUGhwQ2229cZw3OG4jb47ODk6Iz2Ecf5ZyZOIJvnBxWu6lA==	9	JgZhA90sqO1sgAfzFzLyd0nKabZTZvOp
159	vjyhv+21WASP/ZqEdNObgqne66UT47QPEvQMaFgjncc=	9	8EAIutWDK1qcREHvRwi0hzActH0nN/qs
160	Vv0HIZWYzaxa8v5a/tCcK1cbiFG9WwlkQ1PsgGXY2cb2GMYPaFMphg==	9	z4L/2nawpV+MRY7n5xyXu/bhOFwXLtLs
161	FjPlJ9hBLuJcCXvEf+JGO6dlbCXrlfp4rvvp+Bq+eoQ=	9	+/K3q9MCL/LSbbA47hbP3NKYTWkrudH+
162	UoBdtU1xa7yCszS0cjyblRizTjBHYWpETdFO/wLYlKLS2L0w5ckHIQ==	9	iwHtVd9aFDvUq41tLj/2qN6MTJSo0Og0
163	1le2NTpm1tdep1TX07p7adt8QfPs5MSjEGosLXmAfmO6gPAQds1nSA==	9	cO6QtKZzpAtygc4jWMsAaofBIvpU7JE1
164	OHOCdnlsONYV9hIVk8IkYQ34loPFcalENllvEP22MgMPhO/qEuPuojcgWjYjACpBFvhF8dXjlXk=	9	ZEYz7jtKfJq1e7eW1sYEPylZUg7GmYUI
165	9aCCvrCLXEqw+TA2mkptSNIRsTAv8WhPUGv/0BxlkqLJG2dd5lyJRA==	9	NaXWwmI5B/Ovo3mAtjR2i1f/EaQZ6au5
166	HX/DZU/zUxKGIa9U/Qz/7AbxGFeN99ouUfD0T+/AH9o=	9	VMEbxp6nwYzw1cgF8Zr7Pjs+mBY09s7A
167	z22YBujznYo9TUGwKkQItvfzHp+HR4crft6qVZWXS8AeM6LL3dl5JA==	9	Q8E3GLUiiWZndgR/nL1kET6wUCBjLwAC
168	lOHfVkBEZfNeZMD3zjN6hUeLslWEnz+jl1mJ71/LGZTUqPnVgBq7AQ==	9	3JlFqWN9RYQjXczgtHik7jmscQAXc2KW
169	5I4KHFY3iXqvyv9qqgKp/ldkVVdEKOoohFBIwwLvxkK9xCJe2rq14a+7j8GXeA6Fej+38/ZqvX8=	9	LiU9bsVyh6Nnm76k/cNrZfLfchTJW5EI
170	5yyehF7GamXHBYxOPbyYXcBDgwG5X/EmevCDJeJMIvkZ5ies4A3bkg==	9	BpI9ydJ/V+wD2Ty1FqlQQdRMKEtih8ww
171	LE+MC6eMZK/UNS5mdgVV6d6LK4RHgEqkYMLzTErrfevoCYaNbWowZAOqhMtU4tEFiEMtH2PPQ/c=	9	7VtP3RBz+KBrjSCzlUH4/TyFhBoN9dtr
172	xzWOCMTt6soOwOoMFqPmxWfX+HZN7wmFS3BkfebrdHU=	9	VErVbwmzfjf5C9Rc12aJgzd1Asp1N3tA
173	IM6+9MF/G2wQ88iK8cX9+cX8mbvA/ErEfW687HwdFM1za+qUWFsYmCQjWohL0B9a	9	iV3vbkHVRFFmZv1BQYe+ugyg+OW23/8Z
174	qCDfWvm9/6+gFvti5Ee7TneQHisw0YTDs3/ciLNQoii+cNjAQtzOGGRYQ4cE88JZ	9	vnK0N6lRpXQen5VstoufmMCk6io3VKu0
175	WgFU8ToXkvDkFy1/guUPuLN8Vnv95qraqmj2romiK3Y=	9	RcBKCrdZxp2j3NOmCkDsn9eNUlNBfpMT
176	8ZeRZz5bTdXFv0Jwp0j40JCvPpNZ2gt09V02OehRzcnyaVo2jgxo0Zjp4J7lnd+zJsDKCOmDjPQ=	9	H4+12t94CAaP9n2DNt5tK1x+b6pJ7i3a
177	Ah683xshJ6vX8wLBFOwHUKsMW+W1wZBJ9sL8c7AqQHGA0xixgPbqLlfM+AumhFOQxyWHpX3aizk=	9	rzhpJGJfClL7pBb358geqCyjJ0Ma1mWv
178	LW/vh1Lb2/EMPldSKFQCEWBHf2LHxEJgRgRcyeLxwvs=	9	U6Hnpq+jUlhza6dKsIv+ah3BPANNaBV+
179	dVStkH/t8zi3Pe8bKLF+PCqw5iLYwntwoScTA72hDwkfBu2UrxcD9V8iuqxrSovU	9	6UCahp2gWCTQT1YdNIjyPwRCA143HBjo
180	N7C6m8GNHsGAgXqyNXodUaM8t7tMKgtoeNkaM6o+nd3HHJsUiz3+jTpuK7AEMmy1AuEbi5lqYSQ=	9	Q6LvpI33BCVfrN4FZD+ZRS120EnrbmKI
181	VrHQH++kUNnlzZGYgBxZG9vN/5Twn9PQOMICU1Im2roBQLW9Ui4FiWCBm5KyacmZJtoxlCUDxYk=	9	khdkPYvbJEGum4PwmUKRvrgMMnVzGpcT
182	idRYVnrQY5OodTVeHDVBM7S5NibMBw6TSgv/5U5ox+22OqQuOMpryiAu2/0v5Rol	9	MqTGyNswO72SeMzTsmfWSjC0gwv6PwMM
183	2OPQqJodV8fR7yo2fo4COcXragwqsfjLQ6EC0EFEWdSVTqKXkKV1+0hm8RES4J31	9	kxw3YTATGxq9xeLNcXdXjq81HYa0h+OX
184	YzLGhNe7NIn+2eO1ZWV1W4Gy2kBDGAiaHxHvs8eBfZlIL0kHu19vzg==	9	G9wRph6p9ZoUDvtkB+uVwjdkN7FbkOWC
185	Cmh1KJjYbraWqCinORS5325YK8uR1LLkzch+k4KALqZpPOajoXp6Tv0mxJjEbDgQ	9	p1MuKp1IZDnBPS+kHvn1kgfODa5SSy0h
186	p45F5ynxG/U03sjHfz0qZMeuSYBs6DUlx5v1hf45dgFwpmoA9lMDmA==	9	q5zY00GFlLKv0Tt7+rQHL7vOfnY3XbTn
187	WZ/+/SuFrnglszpDe7IYFfDV6dD6C+BPYTkFHMLxI1XYUXpBGlvTOyBm3EhOXr1jKJq2n84X440=	9	PbjazT47iGNDegILfC61TZLv81r+SiJO
188	ckljg//Q50jNNgzMcXcied9m3Mjf9ANWYi0d7XWf5zXEID2bBUJAMQ==	9	aBR/McgU8/I+cp5DApmWAwufaR7t3lHG
189	vpAXxnoRFi/v07is54hFsJnCUCI8LfkkiKiYropLTqU1Dt/EMSa9qQ==	9	K0Ej+yWZMEU5SUItgYaETqfZzRDOJfQl
190	3Y3xA1ycgY2GGCBoBdPhw615jcXgGhFUUpID+zU2nLiPGBqfOPNh8g==	9	uAeR8bhJpyXFxXo+0ZOpJN9tiAJvo7z3
191	bPX9q/zkNJ4/64AlbaNewzBisU4cYePXQSKK/NsRCtbU5muc9Ei7ww==	9	uKcfFai1Vbz78VgLp9A7JubNmcLPX9uD
192	np7lp5jGZVqb8aXKyms1xfI35+23Wyh4APliFyqepLol7sKWJGUXRg==	9	+8cRVyifVmT+9YJCxg32ShjZwvqfILEI
193	zIIwLdObzT1fu88mmxTArwJmdtbSR9wK0faqROr9TV7/UEqgCL3y9NHH6eMUAZpI	9	9vcLkMbkcMlr/f0Wrvll6iv/CKxQj5CU
194	xdVnh9MXRBWnUY2k404FfbdrAsT2VN0hSsOJxB90Y9TpLhw/LXB+Eml+reEln541	9	ADz0u9/m/gtVbPWdzDta1y6xSKU2yI3d
195	CredymHcnOlp7tJ6gmqNvcfRW8RzMOKDKrE57uUYuh6LYhXdvcIV5Q==	9	Ay9kR+en5yCbE+BUbRzBXY12NJDFaBBc
196	+fkRiIMKi4uA9ZNzm/YYU03Y2td5V0Elfw874VIQW0vj6nvrfPXu4w==	9	es9wd9PkRe6S0cYRziQeCfc4cvq5rrsk
197	slvcr2ij5XoKEixHw9hkdjmm4wPumdk8HmKeBQod/mlXeh9k3PQ0OxNiya7gHoT6EUL59Rp80LI=	9	ePWfJoSyXIznRxXo7roSkDtJ5hN9l9RJ
198	4ZAGodYIpnjNnB2WnVmTawMO/BPAFWvUv3OtFxtOB7tMGkcJKMc3lA==	9	Op8LRINV0Fz9SBZG0tor61ZLoRALWUlA
199	QwyxiHrXxQ9rEWiqJ10RH/HpDyJ19s9wEcL91bO0L2ZNfTkoD127gw==	9	GR/joKXwOKYy/tB4kUZWymqDRM2XMLq4
200	NrlOkMh+k5rUWVvxi5LII8iRCFLzEi7T1i+xbyeb1HmzOY44eHZc3nE+QdTfmGub	9	8K0oZVoiN1pU32MEI+7Nr/MrkFtv3GOa
201	oAzrF7SAi21oyodTEeah/W5NuRfnJR2aW45u0ejBP5yKx1YaaHqIP6ZpD86KZeCW	9	03DwnqGv9JBu5fa/7bXTmuNMEcEOfZfc
202	Qxosz9/x8YrrumVF9gzOarcpOpvbkl/GnS/LEIV8yKkV8trrk2e6Wg==	9	Ku2VtKoQtmyx2R1OMGOAVcVBFYtb6/DE
203	nh/4Shz+CUWiGfiEAtoy7NuJU2lTwh0DIwlciOW2R/KQ3oaW3Vza7N23fVNR9X3c/DmdKyqK/dM=	9	OBgCeWt8Ry9WiiPORjrXtJGNIXfH13uQ
204	mdSmZMT6IpOtKUTBvhx8LI4RVgmCu+v7WjOFFLXVoQc4HoJfON5+Og==	9	543mSYVH5pwUWwlfIk9Y7IMuvo51GZu6
205	aCR3YNAXvfepcvp+5bDTPyc3Q9YAPvfvjCgqk5Cyt3Gs+vZ0btWtY7sZCA+aApYVCGrBwp1Z3CX0\ng4w4o4xC3w==	9	mOclMV8yetFyeYH+/0Frn0dHMY7J7vVH
206	VZMdHrvWX+AHxhfJNzfnIjkgOZn388mr0SK3w6f9d2KsvVCZmpCPDu4bIulz9yqYeWGd+jcqe1Y=	9	Vjqf/nVraGgGpTX8msSQ6cE/IECn5BMW
207	Gij5hSLn0hbQdwx+8xWmBCQTaMJIqy/dw4BV/yy3S5ndchyQ2yQyVPz6R7RNd9Rm0r9ZYiYR+Oc=	9	hRD9nkRya5jU9QnYeRfx9IOh9w+VoDdC
208	qXnsZIntob08yys+04DhJTKMIlQabkEquB3JYKfPjl5DpRJTLY5Vig==	9	yH4SI3KNSybsMdmd3UFrsLiVdEZyzTnF
209	ffXAjD6thuOdsWOcGfTv4KGTyWx0+vYh/Asq5f5zw3t7BJ+fVnq5xg==	9	W5IxFR/KTUYej7CaeLUnFF6pAMv/gtxM
210	Ov9ywqt3uIfV5IIKhBNggwDSEuctRvwFr8dvzvmisyl+7JAZpnQXew==	9	alwYTGvteQgmKemrjjJ+TXoOdNDVOCqH
211	sqSzGFC9ESjD/qpwHz0Q25iCKdpsa/9Tq8RyGbCmRp8LXaWWQbMXsQ==	9	K6XX96amleiW+AFpoemwkLuDJvjRJiu3
212	XB+58TcX2ByCqW9l0RrGBEACGea7j2moeweKzlYHULAGpD65Z61c+DKaJ8yEu+sK	9	Kl92osE97QmEXfIxM0AViV6UqCENhuJK
213	nRAYGLXEZe4VzvB4oHj1+HXgsGN8qibY0enOgeWSqZXA2pdhtMr2Og==	9	b88c0HC+bM3AAiMoLvfEl6yXNhco2P2h
214	GnJft34TG6lmoAsf6O/+y+LuCywCQMA5J5RHqRec1sFgfVeRMoGdng==	9	oAcZJMYMhHHcliI4XtfmFaKcpkrB/TgU
215	wSm8PQw+nkW+0g1hUbLCOYmQRsQKtTFLxX9SLJqlMo5Q0mLBdHSKo6AuyNazEQjj	9	t8LcEH25EbbQWeQzwucqjOdQ1bKBIRl3
216	En8Y7LIhSzTtZauxRCEZjSwExZw1Rrvm+AkNzqdPZzDNmJbrFBdXag==	9	So7wiuPdwaTzUDD0z7vh3MFQfB+Y+AHQ
217	NygDhyQZHSo4hQ2TgqPRPdgoh6KlydJ8oQD6KjTj7FYhX7hJEsEcE54NLRr78hKa	9	UI28hNmPFg9zKyvQc3UGbGHXCFpSrOkE
218	mXXoX3NNetMaYoneYWSmzLEKmCO4qWXv2ejSuE4zm2RdLefGulPJ9w==	9	fE9L/jifCNip2t6hDjdVN51EkwaFgiLd
219	XlmcXbh0tFdJQKMTXgXXywjSEON7pYJYeBeslsXh3H8ZOVPAbqbWluPBtpyEv2bE	9	5edqJFFlvG6uWfjYIe/tKCebL2whi4Z1
220	WlG5NVSiVSgaFBrB/gc/5wFyB+eVZft+9Y/e6MaZUmQF4zc4DugLeYDq7JUT0zab	9	cgp+RXnVV7PygBu/TkekqOL4CebrXSyv
221	CtRQmBrVApfXAN1lUrLGnuWotRvpfKSkF9I0OapKd2fLZ3bgdEjPbg==	9	1WC2Q6xuQb2DmSP+tC17bGBk3x3okwMn
222	0QQ7obq2D2p5EjQNPSapt2NKVkkNggvRK6xv5O3TC8xMrgZogs5VoaUnjN8KBQNo	9	iAjHEwqMNNh9t8pK6uZYNmiILUiUhpx7
223	hKQzj/tV8UQtqScVkiA9tEeGA9Fakjie6jMFt3tcoiIQ5ZfPUBBjSg==	9	4/qwX33w+PEJ7x3Zi7yaL8X2VJ/aHOAI
224	f7egwFzccOGeYzPvU5z/5mFOb1YG5grRDcazoE77qBdCUf1Lj6FbEw==	9	q2Oi0QHymwT07rSLo6RWzeRMEk7RdKkl
225	qhk0dq4QQIaQ2eJHzd1DAUKc8gVSZeGolMsHjOxHq2jsUcEZafzkFte3hilnkSIn	9	swu1RCdaBKj/yXD1nOpfrjQQbA0tOU1U
226	9sCMXKnOU/95is/mXolFRLcrS/tXwDv+Ki4FG+EaXZwt66+5RmV/cQ==	9	CkFiWq1USsy9psh0TIv7NfL+ntmKOvCi
227	ovpJagBiw2x2MzWt0XdTfayA18+LjsbhSK1yUU8C0GSAyP9ixPr7JQ==	9	m5vLnYFUHhgHdKaS6zPZUuehgHnuX4IS
228	r2zwuUFi096YWtSbKQ5khoOVSlANMMBiyLvLUNgbFyzA1vitrAvdvg==	9	Ptbk4WQ3CE9EaDWH0ulk2Nj5UxNbfhAB
229	z5WAZTNDDvozmu8h0N1poJNcmdojNUZGBPcBkiHpO2oqx187Jit/jSDcLbed0Cg0	9	3sV3mcp2xSVg+oKW5ZOeQYWHX7QkTSno
230	hD9FM+z9U2QAjF+pzYOWeV9s7SzCWC09vnEU6eRwOkG4g9qd4WSH/w==	9	z54P4iBdIEU7haMxjb9GgWHwxBbWXQJn
231	C7yvrhSQ5TNoBbD+6urWP4zhZIJsjTfIkVSJcaKwDdT7ngUGpf/5cccEJfkVJQ0C	9	tmboMVzXhn4wZs7Z1/xL9Mwhzfb9hZEI
232	LX8HHcW4ilUWxd1LGJSVY/1BLnLXXNdYDm2BYxLjh1N9sScsRUByAH9vd/UPORnE	9	BiuwD1XYs6DNLhKPcFdUoZ2YQBmTVx3i
233	HeO+sWJuBUWGiNY3zWeYZ7RBggkx+8mzsebYEG7qH5FH3BoEsvMUAYMBu9/3iC8O	9	M+j/yist0lGtzXF8BhQBrBY61n9NQ6lQ
234	hNWtKPoJ4DIKdWbvI/P452AF4tQe/BJGWlYxW+016ittT7zhk1gzDw==	9	9/tmIxz2ykwuOk0yXKSKjea9OTiXuD6C
235	Jy+1XgJkv6buJzPWhHXuP+r6pDJTT0I5vWOV+fivaczKhT9TSG9lsJSxgx6HwGFj	9	komYuFOpUPnCD0Lh+KDgoiKrahTtJwtr
236	2/DjJPAmasHrdWJYNOJcVy61wt0TpggMZMO8OokxEf9bC+NbFc4CqA==	9	7gxXK8XlsWNXWHHWprfPqQ53iQXzeF80
237	frM+b52NgeWzI7EJ7NrtEaWdJBTVxoh/qSVsvomzBTLdEt/X/ExiGNM4GO2mDxGPRJxZuW22MfVC\njzlAb7dwTg==	9	m220rn3Zu5wVBV6wpXCCdU5MiRUhPzKc
238	Ahnxufrflmhg00Ukn5j1pP8iGD7GrsO9U9ynCCJjh8y15+hiZxjJxkC+7m9hgWPF+1+5JVvhedc=	9	Um6Jxby2setfANG4DA3TKP+UJ+ohrnJS
239	X8boREwRUotjP1WhDmeGq7e4WbaZUQVJ9y1Bo/CP5yyk8OvvHroq/A==	9	dYJqpgka4qOTEhLz0H4AnK+RA0QjzR+s
240	ins/H5klo7YKpsPZ78FROe8X8vZQemxNST81uYKFIzxl7JOr6n+eRY1b5JVCWndC2e0iMV17ESlK\nePE/+dXlXA==	9	17yEFH9ZzmUx7OJ6NXlibOKA+iWBp7LU
241	DNy7NHOjhuymBlCIB7nSIBoMqS2xWj1Ij5t9l0NiB+g=	9	UfV4JQsF7/gBJgqbA4o5gqRNRR+c91El
242	wk8kMQEJ4d6Qw8q4a++gFNn3/d2337V3BQ+VX+c4nPg=	9	WW2wT0tsoFBIrGZKJRzZlA+HfOWPHEIR
243	eCCXmfp+A1xdDiBRo9JYqa+A3eFKPAqbt412S/NWLGJm0f7ETD+OrfCu/oX8S1Be	9	cL1bhOIywobIE/TFs3NAyrJsUK2fwEg8
244	TFtPhTk6D9XtLfx0bBoZ3vOAgQfjlUdhv4jUWuTqju8dtH9OauSVWRBELQ0iA2lWmpovSlFDlXvz\nwyPwk7aPXA==	9	IuQIdoPo7ouZ/yW8TD2PGgPhzpdggAk0
245	+5C/jI0NklA2oiXi4lnc9cT6xM0KTsCGFxIWdptyaqAGg32F1vkyr6PhbVqRalvz	9	UY17UOn4PeQe4eFXCZOTG6i3N3Iph81W
246	G5I7Om7xlw9x9PBEoD9RnUmG3sHukQGNJylRz0sJRh3sYm8h6G7pOevXZl5CHZT9	9	+Hqtz5zVDlwO8eZUfD4TLVKZNYNN/GDv
247	yeqqVZczggggOoUE3klk9wVDHlDTNu8Dd6BYj0ug8DE/k90wjSe1TepM5ZTnMJgRqkKlro/A7QE=	9	edj1110c1YZ9v8YEMng5++TYR7BmT3Ym
248	1EgSm5Gf2tIOR510cTqcWuTyVACZRsGUDXQcQHB+p+h1BYZMSciVTZWWHt6Ot8D3	9	kgsyx85qIUwLBl9+Ko8pdNRRe9QmsW9W
249	jZbZqpJLpE6OB2ryXLS8HM1yF0MR8pzcOo3su+hbxaTSMbRkffWhEQ==	9	AilS2l2qhAU90OhK7xSoCwvdI0VJRB6m
250	aXJtDUQaSnDz/39cUl+bvCRTti2/l7laL+nW4hhaT57+H1hMi0+zLWPU7w4ZY9PJxyMRTCZdlFs=	9	2Dbv4kAggi3y+QYkodR5zzK8NjSvBOZo
251	sns806Xji0QXB+1OXh+g/3RB9ku8AJzPYMvlP4bf+DfSMq6bjxzYWV0VF6MteYZSnY58Ydt3INk=	9	UD7hXKA4SgKdUEUko75DoC2h32TIdPoj
252	saova8u01QVmyRjX+WdYwMQ/k3xPtGNxD4kigfEwSbb5zMIAWNwlCA==	9	RuxcLYmT9wgxH5dyEoidrxBSK/JVAJAY
253	XkHUsTRw7XLTs5YknX+d/LOMrrnQFI9HQ72yexn3ZrX1E3KgNg8U9Q==	9	Zdp5Zh81RMaj9Rqt/d63xGd3/p8d+q2L
254	Kvnh7t3n0scS03ygiZwpY1WcvotPHgWrb5jPxOwfwpBtxsCzvNoiyUiGf8Ih8ESrwfxEvOHSdZVA\nTxkscmuv4A==	9	6/c6k/CjeetMp8Zmb8VVKMheLeKWQxqE
255	J1LVFNdnB7WdTt8U67GHHVZfo0kcyFox37ZC/Pe2KreUoBWTN9merw==	9	9HrAaCI1OOIG5Nf+ls5qzvsP4VcD1VyR
256	zzTWymQiGXh9prA75x6hOZyGMl+T6ZuAuFEFypZo6soLKMx7gfKUkuRKc9huETUd	9	1ZB/GZre2kEPNyN9OQ0ds9t+yhmxyns9
257	nFvGnieccfAvLpYbJWArBzqaKBvj++U4L+hSgxM/Urs=	9	AVSLfj2EsXCHlISwHrdcBI9VVuahcX3r
258	HaY7j4rCJabqUMkOjvecMpb9AnTEW5yejRaprUu5qqJyEsL8E5jFUjI0hgEpuuI9594rsiFJOYKQ\ndc8X5aNykvI77FOaPSsr	9	+gbOzE1U2aaZVPWf6AuSXd1v3qR0+VZ2
259	FvOKdzCTjKP2dz65GiEYhZxCOzgw8OA63rnAa0DrYP5YkQrm+cYY5A==	9	eeHjrlBNxRugh5IV7Fte0GZTiouqPu1+
260	mH7skFKJ/fIGaXsBzaFTiyoHhtGh0CwPlzvZa+hL6TH1oKhtKbr9uQ==	9	DEVOv/oFAyCmYm7vtLiW/CaLyzJSWuA9
261	FtDK/5N+n7JO+OPKGHQdRb4QlwaHEKQGS6h9fTEpXu4UxnVp/myqqg==	9	PgBd+g1HtoAJyjh5fIZSi/L0DHXM4rSt
262	I7iru8utfmLhciTETP6E+yazjp7nMEkv0EMWiL5BJMTlPZ8MqSHWhq+y7QBcdzpn	9	cMKOuZij6l2PNr6DiVrB10YVWyB5ZDWg
263	VJDf91h8iYDmg7kd4s1Np4BnbnIHeZkx1eguFgU6AFmbfafaohnl83qPED2l/BH9	9	fvtwGz7VW8MKsmvu0+BvCAwelLGBIFRq
264	gs7uXxN/IeSCdRJomhuSeI8QaGsetXjoLClmLjAN4TXDgvRRLbNKbNlR1Msz/cJR	9	Mxn0lkqDk+VdxubJyoms34aqpwLvxdgQ
265	HWffF5Suj1UzON1YwBCCkXda5puNYJLcP0Vnp1lWEgAMER79GqRCrTg53+0IFlhB	9	ucCTLUgDZhR7TzdMjD+3BJflhDnblNl/
266	GFW/JucscRWqaOYNWcitjVq8YhimhhswU65G+CHeGMQZI4bgjqqySQQdWwGacufv	9	VSwHNMBxn8quaNDiC8kXF5lgtsN6sMDg
267	KYMLogbqT06WOvJnscunVS/p0vYOQbZb3/DzxbQrmacJ67u6X8ZG2+24NbXiE3Ic+sUC/TvZC989\nH6etCqXnMQ==	9	uq7h6BQfSbIPhhXr+7NwEdyt0w0jIJB4
268	HFRkMkksnrRv13VPSo0e/vl/ExKuvlKIbqySRPot4oXY0OroA8NUpw==	9	sYm/FVq201K4i6pDFgKnzim2hqzRxfY+
269	EEiEowQdMUdAQx6f9XaMw5stNouQ87yduADCbQKvUuMbIIq2TGn3wQ==	9	1glU76iTshJ1+FBRjb3tMxVeSzpMyh8U
270	F/967S2RiExKzIZNP3/Wmd00hqAj+nkfzSgTTM6hVEoXXcP4/YWZVk50e13qr7eLGcg4pFBkax0=	9	XH74uO9IDt7Tdu6e9iQt28KOJImuCTja
271	kYmXRRiLzUibJr86xg6M8SoWcR8pvpBfmkk8XHEX1SrTZ43sGWFwS5089cEFyMRGXgRUjL6K/IkI\ngFHrvjnQGw==	9	tclsvD269TyIF0ljSJTtXIDkTsSthDsp
272	XxedNAW4nqLVdBaLHNgLGmMw/+xjdTpQ7IXl7Ffa2Zc5ZSftCFqRRmUHivtnrBFUGzk030Qthxg=	9	Ay8ysT8YcoByGD/m2aWpHS5S7B0yO4XG
273	za7gt4jqIucYOREx2uE9jzLA7xvVdR9f1e9BzAieQrywLx6m2UTnpA==	9	UYir6Ki9bc4p1diA3GHJ3bdXt11dBfkX
274	6bX9gaASb06wC2G+iAP27BA8bQioNmQV7oRve9hwcPsdY5HPwXvUOHI4t44WXAk6X019+HCoQdI=	9	U8tYZcEBG4kbhwE+Sa3L68wRbEHZSwn0
275	XlpAFIlVXiJEVM+YNKs3q+zczsjln8pdtElwg/vyr5jtoo3tzNmr1jQIzCSMHDyaCizgn1r2mNY=	9	+KFLxztLcDvnXLdgoyPLWGlIDXTT66tr
276	VG0q3fZlnt7DCk4bXEPdET2JS584PBVekVdeYBg9NTf56pxkIVoYPNnoVbiCocSRJmeApZIwcS87\nv4tWskna9w==	9	lnF6Yk2rHbTzdrVVG70jKrkW5QrLY8KP
277	VAJBRBftrOHb8EGRpmuNkkYQkQ2KeBD9VjYpWr22jIk15UBnJRi+t9XcY0PfFMnG0GihqFKkE0Ck\ncK/xoLBbzVmKa1OqCQ32	9	ykyxXah2rpGAKMe488W5BedXWPiBxw1A
278	VCtFyeKgoszGLTTV966qJG4KDoGqZPLs1wfCiEWXsGG/voir0s1GteT/mU3Dvmzu1OfhnVmjl+kS\nkfNiv0voQw==	9	7KWg5xy62IUTGh93cwpOePk6/7zETWZQ
279	Vn9npe3VktVQ11fQ7h03Cd3bs5dO7xLfcjjicblDVNSoGHFpwFe4ptR0E1RRqC4W	9	S+6hQegyD1alCgbYOBbizNWQWY2h6pM+
280	zKcQTyh8atGV/ggXn981phDcg8PfI/1nfAs5Z6T9IN5/nQItvjuMx097iHkXYNX7	9	oHuPDA6qh+Hgmh/nuDNKmdxdlcNo4Lva
281	nYWrwN6Lu+iJ+HmQXCIanWcCK0fm9zXcSyHBFWYAnYUtV2/9Es71STFQv4EcNWEg	9	jWYM/F9/N+ttjCG1PdOj70CvxjH0Dvte
282	Xc7Yw6LCUF94SkAY03qdx4k2pZtXmFkAvQruktC3WmRHguPM3Q384sL21hNE5aiF	9	FnibD9ZLR4cs/qOF5rAu078JshHzSB6B
283	a9JkMupXfcHRdVGL0uWWyGX538uG+9maoJ6IGucXgQtm/LyM8M6k9PiJ7kjWpkZuZR+pDEQrl+SO\nkMcyhmr9Km64/fur53Os	9	FNQYxRvrzMQL0I95V7+LGyeHCB9jrkWv
284	yYY1SZdhHFCGA7C6WSOHkUtfK7QptPOH8fGs4edePnFfxBKlFchBjtiAqEPg5Tv1Mye5zT0sXw3c\nWiSVguOdhBBh3hMBhQgp2DnYMm6VSWk=	9	Bq8lFil+fsnPoJAjZ4lgGHA8KC7/SA9N
285	VF2WnmTnrZ4iDRSDcCOLIM2PjUBR7FVzt1/CTl3ARGyDhOfJmek+sM6ceZYk71uKEnr0gQENbLhz\n/0yTBhKJTBtR3OtCiGzauooC074umuY=	9	TVljGdqm9ziqxXJTWFFqCcLv0LBkAjS3
286	WyOvZTe575fd//8LCEsr9L0yAtRiymjU7hBXKG4ok9Jf41bu4o6XO3Wqbnu85fKKgC8QuXwf5P3F\nqw+ZxiJ/KA==	9	8n1DHqSkCc8AvJscSA+A0ut7oijX0HpU
287	cbi5Kh85pzIjyLsSkjtqHYa2iyOCUOqGOBpgRZKYUO0eb2LlYfy967n0IMsloRQq9TTTEmIy72s4\npddB1Kab1g==	9	/SHCTghh+FymmGxYUaN/77V4xJV0tpqK
288	/iIxaqs8dnquQR6MKWI/TZ/2ka710cnS3pb0HiWnR/UDWkao8zAd9NsqMADdr7kC09iEg/9yiRcQ\na7utnC9ImQ==	9	ghRUSVqATjt+yw80EZnxee9NZ883bSR5
289	5xbjHUt8GYSnEAntYjyiOmMWV2Mw5bhZqgC8niGolBfTmwx/FjG/dyqbzPsUZgJN	9	IRxBZ6MNpV1MRxRXUAzCypbohNJTfzpG
290	d7W9lEDRIizWdvNtxDHjBXYMjBjaM3GxrPVOAEqEnJnmJOFID1ndjhERDfDScPZ7u+IjhzruMn+s\n+FKMZq+mHw==	9	bpiB7RjiNhhnbRsKR2JC8iHUk+GPcNp2
291	x2ECmgtMhw3h5BEnVILKiZrc/+E0ysIZ/jYf2cRChOnTBS6Vcc16XLWMDZkHx9bM2H0tDiKHHoTG\nLogE21YIyuQi5h5Cgb9O	9	X7jg9Qj5BvB0cIOoUU401uBI2gxorOgo
292	DyHBcfEvNHKQLBwMkKoj7E5RN0Inua20/Ksk5Po4m0OUHIHLkOuQSrPneIY3TdEEU2O7bbRjnrVT\nJpomoxgVCKlYNt8+sJaFSkl6skac9jQ=	9	hiVpoeqs+bBkIiU1ShGaV+wWrwRYgXoF
293	zV9tSSwz64Pg3tRNVTChFSiT+IwdGV4sMtpYNYnDgz52pIYKw/LyNfEWGiGhuk5pUUSgsOGAKzQ=	9	gl8VEW34pLttjijBJ2WMxqFfnmJB0SAz
294	OwFMMVbEit8u2qlp5m7V6My7dzMsiuKMe13Y8Gsp4qHd1mPqhj4gwdOSqs5ZMgVeP5X4fSUTaL/t\ntPzzKO+BtHGSAJzpn3Hb	9	xmkWb59GasfhMckSAzWM+xeJXA5uFtyo
295	BRFgX79Um4UNwg8fu93NBBzfpgnu6WK3hMCbNK5DldTVtCqOYdKJKJZ2o4IdkLOzahXlW0HArdKn\n8sg8GXtUV+Xf8dRyXrD2	9	llC5TJhuv83N5W2uVPHCAgl5H1f8DSNL
296	mw8m9MAIYiPAxblLZDjv52XriU4iyM8c5oVpO0LQelS7hSbw5+nLXqFvXVqqF892Q0nzAtLaWGei\nOB2CAN//vQ==	9	b6/cMKS647nhWfZt7cRXR8YOMiGMnqmx
297	EDUQcB5VtO3TQpzCDxIZqzaA83iJNLQmCjVERy576+9AepOY2MRRkQDPIwMuRr4gBAN3iq4GloQL\nvFJRMyGmNekzb2NHxMmA4tG7Kcc70/w=	9	sy5pifgLYRzwqpQg4Fsk3Ja4ed3tR095
298	hYW+XuR9dapYWWTjGAKeai91+7jKHUZpPPoh0PvIRpULErQ1rYtN/u39bdo8pDfdTr/m/dWaPu0Q\n9BFdYSTaKDFa1oppYBb/Axlk88XPAvo=	9	8I/Sp+Tp8rJCVY1aCEWyvHgQaQHrUMD3
299	g10PQ6GX+wrDPUFKnYubSDN79rSY+w04m66gzTZ4DGxbScKIBpFh77ZiOVTwMSSAUk0l1CjpDRg=	9	AZhGWQBmxWkkqFtyv1a4b96KWaDB2uN8
300	DHGVJMaRZzYOVVk6ln16UejvioOM8Pf32Ml+CEztMFIkqxW3wqWf9DiKbQWn5fDkrxePKEG2nuxJ\nHpIey2jCdJoLW058vTQN	9	x2uJZvj7oOMuQE94fOmRlOzQvCxREOzL
301	1acG/KmaP4P25CBoKOlYJtf7zwCxWw3XwtyLLRg3n9OrUaFQC+GhVUFbWR4EETQcCN0p+8cGqeRU\nF49gXmF9NA==	9	A6u8g9XyhnyJkddk9Tl2rcrpqHPsjgid
302	GhEhjBN2yczq4tuXIKr8j6bL3F2mudQ7X1mhk7clqnB8hV/haa5CDA==	17	Acq/CHdyIyjiOWHMsAYScPid1sqgTZos
303	1ZDMRBv+II/AfubUXgnKsUZkRpFjO7AVX4vwMxU6Kd6uKQtF/pg0dQ==	17	WgLVaThoN7FGMjzMZPfIlragqRgJhKKL
304	XazhrL/uG9f0wuwrSs57h+VKXAcLmOdijRS6SSuNLhY=	17	svL1Az8pHH/c75ym1d/4iT/TM6YnJxtJ
305	HEdek67GSBrusaN839fLrKN8WGlsscG3bGXwbEJZxc4=	17	ruU772sDcWREM9k5fN3ppIsPo33RSC+C
306	7B5jy3noUvZkR+1ACtmDUmX3bhsa9yuLzredIcu8hfndTu7WfQWLTQ==	17	2/JCZUYurtiIh5stpFWdErw+2x4AJbzF
307	xm50exvfRmJcc+G/W4zqsOmd7ymJoBbP0kYjxof/s6k=	17	3hBfAJKyDId+2uCaAqlohohZ8b4hlvZu
308	Rl3mM/UrmILcVVQ7H20ewz4Ey7ViaCF02dPz6Yiegiw=	17	ANB1Xjc70fejW5qkxpwWo2W1RfgKAAhk
309	BpWnsQiK4VsFY019tKZcOiqoPmYpoH15TLZOBuwHTNBwYlyBhYWLgjiK//PaCnxzL4yAlrvc53s=	17	ZwgCfKTGT1Hpypt106ewgPcOJHmXSFeJ
310	kT7PB94g5vvqY3RYOr7JrtDHRYCbC5/rQv4OtQeAnenqwlDG8a11IA==	17	c21u86C+Y7hT5OCarbVJo9fCTBKGT8Tn
311	P4FaFnmAouW3RCzc94nIkMo9+KEHCI5BWuHu2g2jB7YknreT11wYdA==	17	gp659o0xga/hjSxpFuqzQkXzEZhX9HsD
312	/LcBoa1I/+u32b7DW7fivmnNEtmy/hg7Hs1qR8lAvI6/VLl203/VEQ==	17	9B81P2NPcZaR7TskazZiVtBo1YqTzDmk
313	EYiogqvQHM9GOC4bN4hmulVQVszP6hrGZXM/afgTNtz/NTey26FcsQ==	17	6x/ykllpvhiDFWBJuDzQy+TgcUEARIKd
314	SfINxoDdq2p7lxrBfXQwB3JlWk+r03Fr3gu0kDdHeEcs88JqnDqgmA==	17	MRrp3BfH8+ilFM9AIrqM2/A5TmT28UyB
315	I3j/aID6nqhlllrjKpeWK446ICQuJmvYPFGoBoQxFWTYwmSbjtjKTw==	17	TbOMAZcTqZfIDHmHhT/z6KR9HXUuifKB
316	4YTOyQlFHSHMwVgq8dRt+u2SF8MgB6nvg9GTzV8Wbig+SFk8jhEFxQ==	17	5KxALyXleQG2sQfQaZwhxpfscVR+eCKp
317	oFcbMYL2ntAsOqZWL0V66jrbRVNcitNS3OiGVlWRS5A=	17	g2lWWOGmDxN7hvkTFTt3q/urd3oBYX/8
318	xf894rviprv2OvZWXn8LWXbuS0U8wwlakIuztICI0lD2NJfAeP/wTw==	17	f47OoOZID1fcTaEn6Vi/8CkueN2KKa7a
319	LV1rGV6UTglezFILZmGonJTZQP+YH+Keuc0DtL+4jcg=	17	8+LRAbfvznKxbc8Wh7KmHD1/vmX6TUAy
320	MCfQlGS/zLg2Zk90HoWNRd57xMXvIRAvjS/9rnT9FL0=	17	kyxkA1KyrQrUbF4N8pPFlZJV1i6oSvWt
321	iWfw8oVf+mnU745BtlClQdrtmhvZPwbHAf94FRgaFcd8t1GADALoDQ==	17	Mi/nS2wn5jQvYnHcy32PfSVbfqd2pqDo
322	QEBhPOlCmqsr2KI268Guy04UZiYSB69cW++J3mC1VNc=	17	O+B/6iyfSu1UcAJHFYHpby4Qt98vVrCy
323	LYeXO1aH/7luoVSURrz6nhtvv0KlzE3sUnZRJILf3JDQ0AZIK4uDuCtxpvbnHWl2KE9/s4FAFwQ=	17	P9Q2QjDfF44RZhl7JbA2+QuINeFxeLzJ
324	8Vj8alkfYcZ20YismI6JIWn5QSkNuzlU	17	ZwLsmuKpd+w2YEntWQnr76ZXCHW/0GFE
325	qFj5x7vrHd22b1hHKExjWc3YNTnd8VxjiMkNaIEDNrk=	17	YzuoMoUWjOMKZ54KFSOgoCk1yoYqwHK0
326	HpUSR13n7k4Efj/3uFaznmDLjMJ68JCsJHCDzoFkj8c=	17	buOk4z93Ga9TebeWjAIVRmnq1HS8vlQZ
327	T8gXZGNcUYte1Bruc45xV8HTCckpGyqdAXVzV6NxYXk=	17	yX6N/Pa/ALe2zSrLIfydMKQaMxOFGMKM
328	KRqJUIBXgY5OEV2avNZ3+GPTp4NdmTU0GPmP1/a8prs=	17	UO+wTYJs8SJvY9DqAAl7woThqdm0IxQg
329	qtSCnXUkbewdqGivVQ0gqHVJioFLabE3sjNnm+EfYUt0qYVSjoGygg==	17	DoDFd1v6t0sQ8oxlzJO2RHlReuYNlTCf
330	nsf4c2PqkskR8ZnMoIPykb2KZA9VGcee0vfFeH0zCx40FZ+EhSMGmw==	17	2eyTgP9Vav1IYUGbJ0ZqSI3SMZ/5kWKk
331	mm2UqoxnACPhsfG+ED7oxqFcP6bfTM38syEdLjq5yZo=	17	3wQgdEU3dyciuH2ciWKHDH+N4ydU+eAf
332	rw28GM+4x/SgcVzYRQNf75vlOF4DajOndmJoL3+PHKG0ptwmstY1/Q==	17	vIh1WMoWhBLR5xhiMXiKNlzRHTItbaTS
333	9XjCpxu69rd1IGaqPTIAPCyloi+9kBSkk2tTUsoI8XUbytbAfFLjpA==	17	kUqZ8VkNz1iNVE+t3N1BEXxMHJJ8Pm9N
334	j9AEip8E0cWjSZv5cte5s0Qq7G+4UERvOdN38Omur+RIPBJsjo3+Lw==	20	39e1wN0zHfAQHUl2+6cR8r3lbQR/BUS9
335	9Zxm0NUP6bnfVfdsUj1rDkIY9FgwmiiFDa04F0pPvAM=	20	RsIGTH3TeH2OWSnIICQkGz5fARSfOUTn
336	Vsea4NFRRKPjXENVUBWrTS5ujJH/yx1ZgUPDkmBB7eNyU8EuxtM/7w==	20	9w+tw+3fI6NIjgKEJMUTqf3LJCL/0G7Y
337	ZiNRYFQqRSCVqWt3w0ecWaA5ocGC59G5D9jrhtY/kIE=	20	Hp5opjJpZLoylIwUjt4MY3qH+yAP0yhb
338	0Mf+rNMmrmheU+vRkJXyPyQ2neFxJFaBAJEUEXsFCa4=	20	4uzZJhA97MxFpRU71rxAVScyQV0sfpkR
339	IMcc7X/1VOieH0JNhfJ8m7P1zkcml0cBJ5g9/B/DUHE4JocwQiPWwtQ2UXoAOgct	20	b3VWLXB+l0MFI8bBa1bUsXKBy2QUNBwD
340	ip7dTKYsxE+KS2jH2e9abo3lVHq9V6gdseyyh3HCZYkmGQmflO2Kgg==	20	rZq8JOecezxqQlAUYun9YMrXWxiIhMdZ
341	dpAZhux8S6E8iViCuDEeuJzBbCsZRGbyQgUCSE9JTfv5A93+OpQ49w2hE7U/Rs/priHxFV7GsgE=	20	IMLTvMB3co7aoX4KoAtGIfeBQ+bpoyrf
342	t+0ktmh0Meq4WZbrD8cz97AQJGuE4+ZjxXHlf19aqqZdmcHtydiRUpRvsCZWzEpT	20	/GJdZMd+QyEwAcV+VQgssXGUzd9J/ILj
343	AOlXh9UXqX2Jk9kYfzr66bqqySiI2cTpGLm2PnUtPyqy5l+4S9n8lg==	20	I4QB5OSw3/zlo25CU2sPcV+4jImHyywu
344	GhVbnenzrgaxY8dLjXV1v1pTBgnWCjUlJybp37UX6gzfWnMwNJjKDA==	20	oqgsOiiKCdEbmt+EO7RmdXT+MiH6FH3p
345	oEFELDcUVj6CE2rQQOP9RA/u2WlkRlt1ffvcnR1W+r+i/pxLafAkpXiQHpAnEoET7OUCqcYYLpQ=	20	vgS6vomkAxhyqd/6qzejAmhPKqgPItYB
346	6SfqAF52GLGRlOM7YufAxKRQ80RoEOeMb0UfqdDAFOdMu1zWz4suog==	20	bsC3QH57+BbF+pNipkNTvHnmZxC2Zd7l
347	iN+oQ7Y+bY3JCEFN3/ygQmLExnAi8UxeQY4RyUl5mZdKklyQkVWzmA==	20	nO1iGrJWWlAPM4n2Iks0yJcLxf9SoR0c
348	TbkSn7Zon+jRPPLjmtpj9BCMk64f25fy3O3+Xdrl9t4=	20	dP6XHJ8DGhGN3WfhfS8JMYD/3JpT/8PK
349	jBeGhuvByBQSga/8jSWuijBw/SuPlWPLVqI+a8/geH8=	20	TbWT6jZTouLz5uepX3EuUwdE3pKUHKY/
350	fZe3VkKIRaTvhwJgrYjJY6Jw6zcxg3dQqbRV72d27VbE2l7aEDCUqQ==	20	gRX8VZ09Xfv5IKwzL/dSE+ATzi7INpSu
351	F5HhOgjrhtZLVFe08SmileifOAA0KrIW5HZicRwXhvSjaZ/Cagm7GwvMLEbQ0gF4	20	imioKqNRDCwSjsi4EHMANjolREhLL/VC
352	JZ3SY+Fh+gxJz6FYzztwxg/NeFMvK05VPx7zFW1oumCkPH+rWa7QZQ==	20	TvHtY8VLKiYdTJ4Usx0rquEvQVjtT4yd
353	zLiqsSJ4j8ugfepuWn0GWGgW5EN097aWrH+rD5MmgbS/7SPayzAvTQ==	20	0sGFYe2YhoDK/EIpuOnT8FwymfeK1etJ
354	y7DWwRiRZ9+2eT/u8qfIi2bMtWtHLJHlJDbQAeI+996XH+nu9+iXuQ==	20	v8rODOXq916k83s3pVQXJW3Cs4P47kMX
355	oUxG3k/Qre3lhQN+UeU2uTEGRwhKsm6zH98hTIHyZBmTNATJ0Sv/Q9fOz3JitDmxwYcsVbuW04U=	20	oSJSrRsh0bnJeFsERdK6c2Su7jRSRauL
356	7b9AXKUWaz5hRpEphhE6qxV3jrX3cV3z3V0nqlsuMtM=	20	XmwNRWKjkE5KsXhrXf87OnQVgACmucHe
357	kCQz9mr6dTzpmkoWo7NSdpN8GSPpxDeX8l3u6jmxa5c=	20	KNC6V2jW7lEpjCMDaHtBILT1eA6FqXtt
358	QO0ERDc1MQ+5VSMsw1+sjg/SbfrUhddrVKKc8KFtnOiMtwKzw8abdtqiksZRtvtT	20	7oRaIUJYmvlo+7dakSsbhSKsG9DzA9zY
359	Pcbfo39B5rkutDJT5FM7maPIWVdl8E9kl/3VQ1vAWV7yHH9JjDaloA==	20	I5npc4g2XqJV+W2uNq/6+qgcBVmb/Wbv
360	LBHgh1TJ3S7XILK4vTZ6JEMoIU+oB98TzZuJWd1vr/NK2w3MoCkmCg==	20	Ml9H1qiTxgYFWqX0/QYCmuZMn7F0Xp5v
361	dlOKiMy1ET9KEBaFzi3FVZPkpofUe10JamuIkT4hO8RVeLgivStHug==	20	HlUqPTVvxUTiaZ2fWKYdTOxt9O1sfWoy
362	Qb64Lop6cLepxIhM75tSgc1e4fJrR7ETD6c3qkFqdb+V9unk+F8hwdM1hGy0fyaV	20	foFMFC7yWWzA+TZtIbQJj70++pMESN1u
363	ybINnN4RRr/2rKiF5Xouzvuzj09OxrHp+Owztcpf3+iX7k5ogL2Je9ioXRiw5Ac8	20	uiXgY2vqP/xemcFSNGibEsPZgrW2GiFN
364	6OefOpIBZBEs4cNvoB261MAOq5EQexa6WjeVRKdzmSdV7nVSx1ksYgZC/S0dQkYE	20	Nne9GTAWQyX/2GSn1TTxlRiAVAt+GXtd
365	hzJ5cqyTcbh1RIRtyJq/mj12bby+CGOM6ee1/WQLpDt1v5PmVLI203nDdWovQuVj	20	f4fg8hhkyp+gWSVJbyqpQoTRwodIU9r/
366	gQu0xxYNPqMuSdgFa9/JHCBL7IDdGFVIQlQ16frO7GRIDU1iOmKdzFl+KNppcUCj	20	l9RsKrVxbVi0Te/AudE13vPDWh8mX8WD
367	lIfBr+sYeHeOv/h4LpexFGjPGyQFxV4wDZxzXK+omJI=	20	DzL+X7udoMX6Bc/vqWSPdpH8F8DWxN6O
368	s4Vku8sdlaGK8bRr9rZskR15uxPdhc4W1Dc/EY69KfQ=	20	btMKRwX5TXX+u6g3ZNk6i/zSznJeybCD
369	83EcnnHYvI+RE3f8UW6TS1QILpfR/ddaB8WbWDVYv3TZRKlHi8eI2w==	20	U6yXmTeetYEOshsrqOoOOg/LSBYytFQG
370	xshAhDzVKF3NiwR9b4G0FZiGTDQiA2iVNnytom4A1Sk=	20	GC0oBTXRLICIQHxMmZ4ofKgsoDRZ9qcW
371	gwh7bFy6QWA7hFSfGeiUcJ3r6MSPrYkNGHvNtETRAVI=	20	g0CFog9WvCBLiw21H4Oh7NyBOLcusBmo
372	qOOCbVLLSS8KN7Fav+78372p47prUTvKCZTHRzOsTfHldb5rQD0Oxw==	20	z1gMcYAwyOYXX9BDy243Pr1QBhLSknfq
373	M07JQoe+bPHcDARMQ9p9wbBV2l2EP/EedCsC5jdVKbo=	20	6ZdEiHwBtuX9S7Y7mSd9XNsVrGG8VU1x
374	hxt31kT5v+IqRtVkbk+ZRfbHM9gF+EdULbE0Frxiu5Dui+DfrGELTQ==	20	lXI1W25mb2JmSCzP8RUKeuTo1rwgRWGx
375	TJ4ycQu9F6Kb5VhROtr8J4EGyV+Wh4TaWfVvZmiEOVE8QkMIAUOXAQ==	20	wFPq3QSDZGVor2ZtFnPKsmOECkzLLDg2
376	+qTRuuG7NRLoxb0e4BHoxu53MiV39wKWa+8D8KY9Odra4UMt2uOJpg==	20	pJQRuppyYVnt2N0q9KO3rds3p+LMamm2
377	oSLiCORfeu5vW7aJQLCHV+yTmfL4ez3q1LeOvv6viJrYOoyVyzshF4jonRqBD+hB	20	sc1bCfqFg/smVhmmjoTUvhCAdhXXc0dA
378	jbI79kk6kCshGYjTiYgdplCCCi9EKBwCyT0UYp5zBTMf9D2kiX1OsCmPCXajdfnk	20	H4eJVTtJvo/DWSEgLQKuofycr7RojKas
379	uzAEyY+WVYOedmsC1lxms+8HtA+Geiy2nYaW9JLQPYQ=	20	6Ezlit/qAhNt1k5U2b7l3WP4fTj45D/I
380	dUV0K9BckUhBqRyzcdzSRBBIJRHkWGJICWaL/70PdR+i5mkCOsDToA==	20	sNvB9O6Hvi8r4v61TCduxl0FJPbJkD0t
381	ziKlXbA5WBuRXmdQa4dkBDkyfHIF3qcsGCHWZGbL1Xs=	20	bw9kxO4L4Ntoxc7gdJnwJuc5V0BIskKo
382	VqkOd8OtM3CDpREADlRUwAJmPPmqgRXaHIsApT6YbrKZzEV22e5nE1HV1YTLTnMa	20	1qTWGAN6X+LfgdBoYHr3BQLK5k2D1xyi
383	E1sbD8O/sI6vqvDTAZeqE9Em4VWNzSodVxnVoVq/OUyGqlTeP8v9Z2kKXGf/0V9Rfr/24OONe3k=	20	q5DjS733IlEu9G7CUqQiVJsEm/l21GsD
384	HID2lylM/s4xqF+nrMeNcS79C1YNLWVcSVhseOI1pjr3QAXIYRkIgpmgnu59UvLd	20	fwS1xkQ3nKfXVn85SDwItvCHaRyEX478
385	RuQEwMMOvNpasUpRS+ZP/mKDXWyUfhc13xElFmf8Lxo=	20	zoO6bS8zbdVeuptnvKYzPB5szrm58bTL
386	k3wlEivksYd8jA8E4pq9mfxTQFVC7YygSboaA+kqulA=	20	QFlmL1LJX7CYT+IolPWSTHvo16eYRliO
387	pGpKZdq1BAUQKRVm4cSIGKwITgc+3gINTJ3ueZVExm4NL2NFMDMuhA==	20	hurP778I0C5l2o9CCSYnJRqTGFztHQE6
388	bBjZa6WShzi60S9z2OaCueaGSH5SRs9rqrf9UXnRV92QZCqMvgH78Q==	20	e27BS1l+BmQpMxG1rrHAVO+vAehSyiyF
389	AZdQ/RNwYX+VkmSB15JDOn7x6xNxjB/LeSzxNiddyA750nqHfr4B1Q==	20	sxJkP+EmVqkE1oqs1NFsxTgnRuzDeFRJ
390	6d3sq5exJdkjuNEWD+Wct+yG/2NpGH44gy5P3Osfqrk=	20	9DLpUCvKUXqZLgGpZDnuGzbyB9FMuXPK
391	L6mWSuKaqBaJOCHyti4U1QoyCaMCwFmQU+y6zh6LMr8=	20	i6Bi6/XWMm8nJc7O2EkvaBN4aggeVpdn
392	nxnqbPmErjnJg1M0DK657RahQwKD0+8uYBZNrFyT4QWY/TL1M+EXtm5ZU3XJlVHhqNX2g4Yu6ps=	20	8hMe7TRA9ldJi3SPzcIa9iRSdWuwnRK4
393	2Ka5sIK2FnflaCoN8svx5HY/iqBQhSvHj0amf395KStOWAHur3EheQ==	20	PzxPYl0+Hrl9KkqflLuiDWBCzue/LgIc
394	k1FwWhy+bwQ5fbL0hpSWMMVNetsgHL0YkRwmAuhWXz0cI9YMSGm59Q==	20	DV0NsO/tzPmWgOc3Sbz3/dbj2d5h9TZd
395	x910aJfyavXAkcHNBbH3FA8Pekd/j6L7J0m51IOi/5phxN4NSd2OqA==	20	OFJsUQ1hlumODsHYhiOVqNQ8n1UXngdL
396	l2stZgb01PhBxLFOzr9V8rcQ6SgmQsU67CFYaU5sQbUNqRq4P/qn9Q==	20	qc5ZQ2+g8Exzi2I8FXORKsoKPx9HleCx
397	YACeNb/tRC5Pxoca3hS02PDJtgvZXdMvF03PFSfwvCYWBBEpj3b8YRB1xvk9Fxx0	20	lfW9l3v4hHdSOUB6RkMyNcZ5+hFoBLLG
398	ys4IvQeaZAdiVcTEvxVviXF/5kq3DDjghA8YgYpulHxU6A6E/G9ELA==	20	+l3vfXrJ9lhDOSEBNgtmI+p2CTrOpkn0
399	lL/CijtgEChfg8Jg+jdRGTdL8hZtQimSRjBOSA26xvFbfi1UhbgKig4pHmd9jGvE	20	jJMufp5oj9rRRIoKfR/yXQyHHrL8GnPM
400	iLfB+wIX8L/3rQfWjX+Hi2JJk7kgHQo0nJ1mmWsN3rU=	20	SJLeFNgia+g1p72roW3W/kMnGnhUsah/
401	1UrUdcJeKyFTp+a/LXv9Ns+PWRf5sbbm96AYEC04k+hKGHnB2weWdQ==	20	wHMqA0PhFeyT6FZy7n0+JjJ5oQizShgK
402	daitf8WbBXOTZrUd+CAJ4QRsOrsT5wZDnLGMTYurHZBrU1KOaH/CwRLbenf4kk5B	20	dezM/855NZjRJpVdffDeBAuxV4iS5pyI
403	XTMFovuP9hAEnt7EENKpTYVjQCZ3rR5clLMOQGvp+B9ApJqjGyxz73sXlLknbbXKjLIQiAw8s2s=	20	DeLIAFSzWMaG3aieSbfT0m6a5mjy15BI
404	MZD1Q47DEZk0uYfqtLz9PK4G30d4r0MSZAAnltT7huePOSm7X8uutg==	20	Tv7G5R0kgqhsxdjibSuRYvo1kCWJm/9g
405	XOm42hy4HnPC+YrQmdqyUOoIDpyAUl4B06WpBvqZKu4=	20	p0wzNskB+Akx8tODaK9cpvuueKq5EWiq
406	+dBTSAFFHe0gZ0SdBrVJchVxmDQk9PKL5awGA+7Expy2W/HXtxYD+4Kq5Y6G3Wd+	20	wXLAfLxFM0S1z/cBt6aVbKCOq8+xPpjd
407	qEVn8qNiaM0I0LhsgnHS9fnJpcIeK5FAQ8JZlSG9F1o=	20	UsmFdp81alM2NWdhNtEe/KKiLrK9aOBM
408	zr3NqkzP48hEIUDqK0QWbnC3aUTcOlM0iMgt1HL0DhvHVoIXdK+cuQ==	20	NWXjx0aaTq6nOYTQ1VXsV/uknvoQ1lky
409	WqxJ+HIPhKdQ79YOpTHsxTgkuT2T+20u42cHIhqj65lUDwQnSDgaoGpkdghre+Di	20	0z5NRb3XqL94fW5cy01Mtb3qQh5+HC/2
410	UY0HuHNxbC89snQcd9rHi6BO4ocVJ44FmoKgFXI9oSqQRcRPzjvyOd4SsO5nRK9g	20	Lt/ilfCdngFY2/1H564Iq5knO+4JD2ue
411	JqDh64Q8lAHeLniT5hMGpsr6xmYglEmR2pj4/zLPZ9Ppe7ER/V/wBw==	20	OWyOq1hVEgoJjPYuXuRiAF0Ry4RdlhcI
412	nQFOGYZ+SvfPwDGLgByHfLCqY327gZdUFQpKLvLReCo=	20	maTnsb8qkpRO30woMa3zQnGPsbYkT+6t
413	/h5cWB6e/JUV694mIYxSaJZea2O9KJ580i4JTc6PvnWm2GkTwiukyTPxsUtXMwhFUVr+T5dpfEM=	20	7mIaCV+g9mkINqf/2VUvUHPLN6xR7bDw
414	CLp/UohWTdbp1KqG9crpKbpl0tv2SwSsie2Hdb1te2A=	20	yPrHtXlYJ0oc2Xw6yFuX6HVGcMKc4AJy
415	bo/3q7ajHAA/198k+OM9zVsBvQRlTlcxdO3cx+JUj/suzBYIpTu1GA==	20	zdvhOb28bxOUSOGVnFVJUvMn1lW225Zb
416	Xf6MnZsnGFzhRtYh5UxMXK7s6tyCyVohii0qTrjVe94=	20	ZU3bke8Ji+VODFTWxlFzm9Kv1Y+KrLyA
417	MWBYG/rXQ1mqQ7kNUMzckEqMNY1tBfTBLCfByQZAq4A=	20	j8Lj6P0OSxMMjsWucmvWzkjLxfJiXH0M
418	dmCD+ilaACLcR992mawCBnr3ur+IbdEWSfkIYFsRviwOHHBkF+cSXQ==	20	tiNNPpytZka4WqFSGWASsj6yNAj5HEDa
419	o4wxJNOBLxv3+qSHjyhH0y/nDQ4IglBomwsCRjCJOYSN76yHgSv00A==	20	2vsYej/KszdudGCWjDWbKk+o6XDKCZ6r
420	ni4ar0PVhXRIbX2pWG4W+TCxmMyfauWF+JAyr+GipHdzph2XRgNhkke2c7gfg77hHhAxvTz6gR3J\nopEYkDG649uJ9WWw0p/WDMMHDPrPkh8=	20	2kufuMpFw1dv0TmcLthkKKEMBYQOcshe
421	pArn+cwv20XsSpRGP0cbbGddhzNjwdN+q6cBGTY36cQ=	20	F5Parnqwun8u+i8cjiYNdR6TEG/IE+F6
422	GPPQyK1ufIp2utGMF5kdxZQ+9LLZqca4AmiPN/mhU+2yCxmzePeXJw==	20	MSFQ9J8WwXuoZ6Z2t2F1DdD6qqVQQufQ
423	XjcAhT8MIrFlYNuRUaWo5lyZvxlyoHr0+x2fq8XidIR3CL9AdDGafQ==	20	emQ/rGOu75vPdNz9NwTp3dd4mcgIgU4p
424	7DhTivYYQ+eGKTZnuUgpXU5aWmVAPdNvwTimgxSQLutFLQBQT7tZhsYc1zkulJUO66gfAyThS5s=	20	UmWtJ67dened96iUZO7oLLmOUrc0jJyR
425	vZze8sqfkQ7hqUh1NbLLziVLbQN1/nouQkPFtoTdPXNKYZVx3+Y+TsgYh58pj8FUOhK647gDA7M=	6	C2oegw3Mg7G/ePhvndwSI2nOda+43O+B
426	oPG8FzCbKD6AKpV64pUWVfZTLlHB2qDgpdcKXw4HdSeAU5/OEHGQKg==	6	jDV6KHnbHp95S4qPCeBiF4o/z202g0RC
427	o11YcOCkl3YwBokPq8lmqPA/gst4Ftw7R22eB5ku7BjEazwSb4PeGg==	6	ou9ddAfjJuOJERh18l00SJxDfpEWJ2fk
428	vNly+wUIqW/lXBpBL35NL3qNp/EjeQvNFwXHi/uYq5mR8Rww+8EiFA==	6	XEqJ5WOIQh/DRnpWgKKQIOr6+CfRKVk+
429	AvetxudNV7ljq8p2/fbvQO1f/3JBF9Poy8P/4y5CMqs5gQNIY7SD1RewFSnW0pzqtCjhcO9S87Y=	6	bArIy0ESbrEm3y+3oOQS47ui/WskfULM
430	tuH3QjYJoFEtZEL+IB8upB1iGNUMj/QD11k2MLeb1acCr5GqdiEd2w==	6	A+h+CIdXm3wq0WV1qUchumec6j9meypm
431	qxD5fnz/joFuSE6vlF6hcv2AsIJ5ZX3ugrlwA/GALbqO73WKmlTXZg==	6	42IFQAmJUG5M5mS+YinPEJW/wMCMfxq2
432	cQHPMtyIdOjdQEmZ946XglvP9tDKaOAAtNC1dGCLEGQ=	6	tzDdS6COxw0iVmq69nVf/Kt17XjGlgiy
433	0b8xPwn8VoaaM7HKeAzgwCSncKUkLxLt++g1sYir2ls=	6	x5BxTL3RDlhFwrbi4BkiWcePkw1u5P5o
434	dUi0ZcDF5PinBxRH6v1pwV1tZghP3diYM9X8zOq6gfR4z3938lAH6qqg1FtHxlPZ	6	+FU5C5974wbmLrqt7PzH3iUxCyfRcsEm
435	ov4zx5tBaSl633J6JTv0Wg1eLzKBGfmuHtrKe8EqM+2TDv9V6w9kmA==	6	3GTtlj5LXUe9eKO76iu4NbA9gwDMPQbB
436	mEP6d4PLJ6RCzcWrQdZeR2+fMqfAOiqAFgfQzhpmS5M=	6	ihTNXUjlPlM6hPAi8Kqowj2SeCE/PW3R
437	I+UBd/ofKv/lBLNB8IamK3H6gt/MXJecgKtBjnULu74=	6	Sd0pDde4e0ATzHOHZ6pB/YBwEJcb1Z2I
438	OVq2c7Zbgy87xqH05jnSc/Z797XBMDldRj7pZVykt/vHpqaVSlFMH3lTbaYmoNUp	6	35uYmYwEgY/xSKfvOF2bn6TvRJcswmMg
439	4PbCYitPdvYcnp6+2y1KJjjmFsvQ5PuWNeMzlItMj2g=	6	PF1EX1HO2Xx0ekQg5zIMkg1iSh0sQvw9
440	ukiv3X0sKol5PvFNfd8ZiTqrER1rAdtRRAWeYBmHrdlNtd5PAqUgFQ==	6	3oC20zpv3EwepwVXkR/PP5vP7/kp5eNg
441	YklMu7vVCd666EQhll4MCrQ7p5jrubE5zx1B6K7GC9wZ33tRFQlCrA6oSxHMblaryQ73goh04DE=	6	v167QDFbdyd/VZvvHjtDtJWli2N3Da5U
442	sIwRhK73TTMRadja9jsaiL5YvDuFK9dpXv0slaXw31p2SLW0hFuWmFXx4uHa2uTY	6	Zjq3t6K/FikFh78j6abUOhkLzy3J4YXO
443	hbGSkoTiZyEIYdStXKpKxEBVKuNmdqnzbh+uen2piTCRb+wc6HTyVHliggf3Nd6E	6	Ay1Uju3ow8VLOBrsZcKR3pOWqcHp7QnT
444	j1blkiI66t1S9DmWDCiv6EPT4EEiHtvELXYSBzEdMtota6PjSMfRKcExD0cBBAh087wg250USL0r\nO+vCa/ihjA==	6	5eemaFsm60y5O0/0RO6L8qyhStZsDJPq
445	Q+Sh1evnPkhtQcwyzp/uRCB3cDhF8+V7Zj8Ib7hcAGS41zAHmstYysaMilLvtckT	6	TRQP40VWtuRUVrcId/3r2D2/XTgxVM+1
446	k3m4cWSQE7CiGytumLdgV1kCyVNX6vCcEbXRlT1+LOVpAhXl5McbIvrbC3MRNLh75350XdEJlPo=	6	/qUy4k201mB4h9PEbrgrlV9h+eWG5NJn
447	00kEbaREv7HniCTYwp9k5Iz6PQnuqSD9r3t2Tr4gdTg=	8	TKWZax+/McMjJCXE6A82FLsHVAF9FRJV
448	fJeapxGOseWcVO4hyfCFuQLFoKWGH/u5oN79olDxZYN5Fna2o2Qeng==	8	HzHJuqa1S1fg2CC6I3Q1UPSaH3c3e/PY
449	YjWzew4iznRQIR8doBzIYS3gFXXK7bLAycYOPqcgBrJhAsJj5cNKCA==	8	chC3q5h0jZuk7TFNB1lFF71Jzikhp3ot
450	UR2Ax1u2rQq0G4N+U83ypKhks4kjQfyjx/wZhw4uZdB/wyeCVIrFJw==	8	kzf5Ud5W5bJK2MOGItMvip3N3CmVmpUp
451	MllyxWXi+MxDuhBAOHdvfdcsMndOaFUjinE54V/7f9mNXAampWQfCw==	8	2ONV0Xz4YjU4rPMxYkjPmOeS6UI+elwA
452	f3JT8ztCsl0swgqzgthehfnp+em7ow5l/7pNUwKcnKE/kRFXmpktcFuT78zQhX7WzW0tILr6xp/O\nDllALiQDoVAg2uqpyr2lDE/EgGvVgNU=	8	ln83glJ+Cick3fvnFzqt0s2nePOXLey+
453	UdDJPcZvPRZsuCUfROnh2tfpzJKg8xgAAtQ636r29QfkT347YTM6HUJonSNbljcRecJEFQ7iBYY=	8	7qestubRStJ5NHgxv9vBrTH+QsXnIpw3
454	f04DMy864zvO7oWRPbXWQU8W7a67Tjxm7jHUHQ140ZAbuJdT6hzZpEmSnwTmiJ7sGq+iiRxPWgYJ\nKOmwkqsZSA==	8	gnjZs5EpLADOc45mtX2MhBc/TI66CjNg
455	DJyAhc1xBkQVtcw6PaK2Gl7gSc3Mf5eqlZH1TRF4Gk3RPhXg2GfyXONW6PPCZ7do	8	nBIfl24XUp3yB0ESS9HCFWfikyW3drnw
456	t03KVGKrnaFWnjfCy/xg42YlmA+CcCZwncb0ht8zkRuPHsZ0rcC2yjndc6gT9N1uV2svJ1ZwV4Yr\nXLVIOmVnCg==	8	JNFXqdYNpQGJcaNhdIg8fa0QpK3SasO5
457	sQiUkDMvsJV+l7dxzgBo/L5/mgk6bZn5EhZ4q7P/RdtfvPgnNXUgEzUny/2/MB+f	8	/9/Qt/UD+r8lqDClvVdu/okTADNR2hT5
458	SnmX0InCHm/Bvoe+uYDLa4u4q+7Ian9Bk6xJOWhzlDcZI8lVAU768/YgUPny+/HYN3RAwiTtrD8=	8	Znpifk9b9g1TxaEBo/mrX55UjbyiE1k0
459	ccr3eYdYjcd6W7welri6an230TUMlv1mUEzN2uIoPL8gI4PZe60A9zMsGb/WQ7BS	8	q76bNQzpLeboDFWnljsJSlSviprn0cna
460	vbkLzNnbAVAZE3Isvy895AQJnqjgCxPOJMdFbKLF/H/RYdjKK5hF0A==	8	17wQC7HrDZRXUHOvTYmU3d8epAWjTwtK
461	aiuIYcbbhKtG0BjvSa8VD692CcJsxk45RjXLwgHBPZjgz5FCJwKR4w==	8	ICiLtmr1PGKORcZyqii/junF4DzmFIDZ
462	mNXdwsq2UelS8Ib4p4NYF5wGYusfgx8UotQZfJgTztslemCqEySSvQ==	8	UhWFyk3CovlYijqvY7MBLHORnqCe0kYV
463	fgnqiPxtGw7pALLJY4AsCpsrJoJYPzM3W6tC+we9ZazAyuwHYBl61A==	8	EKR2VbF1wQFdEM3Fl6Egt0YS22ZIn28z
464	2Kyfn9H5Ui7XC2DNg/yIGn9uvyCR7+JiqB+mMeFGGeo=	8	WHKA8DPbWuHDDpv6Z9HhI+tuK2qEhi4E
465	mAoDhdHQbeckIxHZmsF/UFnPQXiC4LyE7352NA0TPELE25qGBSr63Q==	8	5AS/Ksm8C+Gx68gaVGCg+H8tr6Kmd6Ii
466	lX9gMOziFE+0D9/vwWpOdGWHqiTLDhgv4KrHRezkSWBT9qGr+RitgF8uH3pmo9MN	8	JqTxg5zpmqckWJxqbKtiyu36pfJ+MiGg
467	2IdrsrCSIcFYQap1dF+bkcgUyPFVO7RVhrRr7lf944w/rwPC/mcz5vPnyLWREG1gU/tnd4/Bl08=	8	XbOUe2shgl0wbrEzKnVT/8Q1BX/LQnOg
468	ZxRUXIG2YYIAglAbl04Pio9r1SkeLBgEnMrL1OMvc7p7GFvAQQk4T7Z1LJrldlM+	8	2YDNPSRfUXH4skufKtrBvGpYa75K0R1H
469	9ETO9but8V4hx55tPcy1d7GP5rW2fwrcAxOAt4vqV1uPpToFq8YubSc4cICwfLTr	8	j3aGmWfNgRh+Iqd3Z+FpfDoOCepsFgmp
470	4o/IQk2059LoKy+LliDthLwo4wb+VnlCgNyIeMbHIjLotlEH/GuOfz9XTlxJdsCb	8	c/GpSM4vS85SOXHY3KSjw1cFquN+FAFO
471	8zId9T4UjoPc3xsu+On2RF6nukw776R0D4ZO2ModpAjO3GqbdhPGutrIwv9+B8I+	8	2/8/bONtX7zjX1JL1CKyPQFi7Su6duU+
472	FPZiVIfHQOel31Sr0VQAzsMo6iBFr7lLgKr47UfZcjGq9HIxry24795BJcmZuGH5kAebUch1D2M0\nvLbCKPXSStTocHkez4cM	8	x9FReQgGeB8PTWHREhzo630DdmvxiiN1
473	we1DJyV8on8NCOrBNpEQ6ZcBXTwnFEwpWl+k+Z375UOS6k6QeoB6TQ==	8	CLkss073gm7yOVS+vfG/WeY1N+0arhQM
474	LemkOg51fO9lOHw7lFRc/ayX1ZpZE05YgeGu+uBjsZemBg5zR4pp4AtYrPurP8MoSJ4rJuuST/Q=	8	926spJj8WnZbTv9vm2WalVDIOGZMYmEJ
475	+804TtPgxvq+R4AOYbKwwGSDZoUzPPHdX1Q8xPQwQVGd0cqvxcYhK3Mge8QWzblhrxlgD49IuhM=	8	sKaYcclNjerwCpNSn+QEfYetggmEbRPG
476	zo34kEV3jTqAEKXHd6Em3oeAhYN8SmC0d1DvRh9OcQJeX7GbeTzgcoWKB8D0msSRFnvE3fFVluv+\nubaJzRHapGeuc+oUwx8S	5	dEloNOezc4d4aMEguFdW3LfIOsRuwtwg
477	w4t4qhbFdvZzkCycqR9xbNPtjuaEhPPUxEja+dpnJ5oU+9GbsL3WqJ0Xza6KFs5qvvX4IX/8YVT+\nWnscnMsDdA==	5	YFMF1OFWWCSXICZzyzUDDsoWVk3X5CHW
478	VruwG9L6CLqMkAv7eQRtUqm5WPhd/Sz5BbAC4daJxAu1R/GrSF/Vre8/QHov1B5TPaF4KQcya1/o\nYEViD6uWcQ==	5	NxEkOtQ8KEH42uS54J4Ntuu0tiS0Mvid
479	e5IzQbHvF22IRxoOQ7AEfbiaRyNuLEY25ld8qYDNybycrflqengsrdrV9EoJfRdRr9SmeLC4AX/p\nJz01INiZXyhPdedsMUdh	5	Uy0SiH0mM5vDq4JbObXevTYdVlmpni/V
480	7mo1e+dVOLRMULMR47WajQ8/BtP7hVaLfzkG8O9EJDQaejWDE5HtISnPumEgaTps	5	9vrRMPCTOZk5nzlrLESlk3bkoeQo0K1q
481	00K/NAd7gtEtmfr/53INRfqp+A3DPTHw4YI66zOT/yX2HRoOHBnk6pCTspQ+aNS9	5	INvAfXMAoxJkPRLIBOkkwn8xuVkJDMBM
482	igg8mlFDrzmTAC+0Xzh/x0hDUdX6UB8igTMMLecr0lkdCviaCY/OWQ==	5	IysMKWTIbHMvz6YjPWTufr+sZvXS00Ny
483	vuTNWfyn+J2r3HyfnXg+SpgZX5xXVczhLtFTOLln9GM=	5	VfBlwIdMnn50XVCSeORBoNuiKwQLTsyx
484	sEzeoYtYFLaIajN6GW1i+H+4CjidfYMoolGyLVawh5s=	5	fScVAXj9X+rq+3a1IpC/52HmLy9ReHpD
485	Rr+7xeBmtkvcw75LpQdKJAfanIelcQwSPMmX8VMbvW0=	5	nWSqUvcZC4G1d/+K07WzV0sbMovNGlTU
486	A524txepFP+666eU7uiFzRntUmVQbb0m8BU9XYJPD5OqTKUYWwNst0lmj5mhtUlMkJWtKyK0/0qp\ntf5UgO3PSk51UwKZmtpk	5	P3UVDdmOQ6g86fjytSJlB1Vh5+FbCsW0
487	a/a9v+3L6h1LesPCPFQDDOAuDLEiJBm805G485zEejFZ+7/pKAefFZLgkRKEOPEDGQRrm0iyNy8U\nijC9Jipa+A==	5	yQKDHTS3tGw7aK/Hj0+LBCpms6ddkLyG
488	kq+JTXxKcyo8FfgmVs4l0KGnbVur+34XKsVcWYdv9VWnYibBugoyZIiw++aJZaf5CXYolh5bY7WY\ntFYoAvrcEw==	5	c0XYI9bQf2FuXi2jOVnjq1DK3nbw51gl
489	WHQ7ze3h6/nVUeBxcCLKM72uxIrQJQZhS5yg/KbdJAF6gGyynLjCxoviKsOlcwcLmHOa9yGsvUWu\n5Rp/rMr504KCcYflEGsJ	5	Ruj92meGGzn53BbTSEWOSEIJlUKTliRI
490	lF/UKrdSAQIthAVKk+Uhwm6IONS+7kMAsUmQSUi4QDmuTGzzifxzRXMwTGRKInxIbc5Klk0YvJTU\ntn+XIMigAg==	5	y4Hg4DuBWO3Aiq7ScaAMv4+BNAx1c2ge
491	jw3JG/8+coFZvOunZXSfN2v0VVSanwD8UhNCjL7yG/u2wghGrJnSOHGnFs6doXV46q8MiiHq2kou\nS/N5DEL+eA==	5	bvnM5jjEQesVjoxN9Oq34DghyA89Ml98
492	d7giih3ILXa9nzC0GjTY0XDTbUX2AsLL9KrPKIph0HNXlkDkJQNGhwXngi034HmtJkPLM72EAYt8\n97RBB/bj8h2AAA5zWYz6uP0mU3bH5UA=	5	MQ2XLfIXQXQ/jQogmmPekQo4pW4RU+K1
493	iKIofREd16c3/bA/6BT/B1ikIwt1lngKlubGDNxHCqlJvCNcPROBRNgKupP7EnAlvKwcSCxn2n+r\nRtkNrgzGfQ==	5	hFCz1fUN63Tyt6wpvfbr61wouChaLUUK
494	7TVGVVZ01AGuc26JeGCk2lLb2kjPJ4na0lNMHtelT9RNZdCgqPet2FZEXAcKLQ1J/DuEaFUwprgn\nYkhKB9LuolVBnsg4qYzt	5	llTamt9gGBHP5sYdR/kFBMzqIbr0neFe
495	ZCUEnUOyXhKG5v+OIXioj/Fg5oPSOxPoozTR7O8TCQDxOkfGEf4pg7O/RCXObaa8OdSb6u71pn9O\nwzoeunUZXA==	5	NZusoKbjdaMCZCu46y5tjPzCuBVqGZd/
496	v1ymf93XLUqkk0/qoc70fIzUWJ8+grfriI0SKczmJHhO+mPzJ4ZPQhhvdUkmbxoX3hc6tUWU9b9f\nFi0AvFtoog==	5	VQtQgAmVO8nXn5n6nBXBmLp5c0p+Qitj
497	VpREd6OCafm7r9jFDPTY7zAg7qQ8M6fy0qf73KYZJMIEBHYMLQt96jaCpHpsYUzaH9ZxueN2p2pj\ns3uxKH2FGx8yYAZmJh2x	5	1xm95yAPwCo0S8hwH+uWPTAYyB7HsYXY
498	2zwsjF8WuAgeGMJvlCZWUpRptsop5alr5E7903F2ykn23iHn6bf/z/Ju7eRA59jN	5	l/iOOc4qGNAi41UMHjYh76XyofAiEBtO
499	OFZSIPiieHuUMx5g3wh/REe4vHClhGYfmR9HYJV1Vtbgr6KX16F1w5xnn3Artd/gK/UoI3HqUTdo\nj4RME8hHLjHEKDHpUc7yHRc9qq/8K0g=	5	lwutfH03dtBJBNkLjh5qutHUUt/JJM9H
500	LETTGmg/sTO2wwE9L9PUknO2sdES1g3Ii/zaHKGCEF5hgxHEoTK+ee61ZuoqLpd8	5	ztxPipYvTOcOgav+djpaFo+iLfk50C0T
501	0iHMC5vw/ccKPIwqvEyR47WVbDf+IHygRHVD6UDlj+Q=	5	lJ77M4GggxrdeIL1egPixzS2kAAexQmb
502	17VohrctErhUqFUEQCWIIh+xN6spIXqTfAmboE2r0Co=	5	8oiSwp60ZYnmo6Jci42z8g4di8u8Gqv4
503	EOe27Q9rVlK/k+4SIvLFqeZFHcu0faVHsRwEJwosL+c1xB/ZYbSAIAK/F1cPRHGO+QWVJz2g/5XU\nacvj0MFdzw==	5	wWeRJuWHFD+jhotWkCv3i+MdjbRmfe/g
504	xodt+OnfrVNS1glYUUZnSPKaG/wa+wBGFA/Zs4r3T+qaCcVQfB6DgdURNOUADWr6UsLklSo4xzN6\nl48HvTVdHA==	5	4mj4QLgcF8vnBJGqWzALyeyx/+q1qLpv
505	bHnu5vvJKq3UHeaaGDpgGt5nVHvCfo5dWyy/iwLixFHopsbANMni5oZcSBW9zq6klJG4+UTYODiP\nFDIjeMsZ0Q==	5	mFvKv6vXbGI2xk5tQNs6bW/oNhzYW+pu
506	LAG3SxwKERuKaJvDmfphH9zP7dUuvJ8rVs2pg41IJVkEtX2tbUgdPupNKijEQEE3VgMgnXxZ+Gfb\nuFcJ85RPwQ==	5	FPB5CznHvXOPdx+kghFXnSdrzdUThbxa
507	ImBf0XMczzEmZ2aiSiNBM/yK4c1RB9i6J878G2VE8slAyWANLCvSF01VpyRmzOVRQ0039o5DNmf5\nJOe07OC3J2aKBmM/zMhj	5	cxCKKp0MwmMdFKe6HwCuFhXx7LLl64G4
508	IRK4E/KZ4OhAArC1gJ2xPEcqKtwsGymXpjnfmtqcUn3zl+orgwdiH6qgp1M4E3u+J11eP2+K7OE+\nclDLUV+NbDVnbnN36p+Z	5	LM1nroUJPdxJpc6biitZ058q611XxFRG
509	p/XpivqP6/4/hHLHe8IZA90u/9JxaXZ6oU/5tmBzFmHM98ivhbF9EqtnJcr4VDQQhmIBPXH74O5C\nB24/sueV2Q==	5	dj5vJogS8sOejBe0lpYrSW0Aym3ONJbU
510	Hu0MSptov/Tc7+/994g3iUUC2p7T2g2bqLu3mALBxLqF3GDt62jBLrD2kQ5E7jA9LCFgjeha0ubf\nQLtdJkQX2Q==	5	flPe3wMAAuYXKa92tTmHSvTKo/6d3eNy
511	lRWDtg5AzxAoRnxUh14FWNAjWa/c7OoDOU/C8xd+jKSh3hxIpQbr/g==	5	SYB7HnomO/IqQv7RhRw+stvv4lBD+XHM
512	GJ/O2CwEa3IdJlQo9Xj6dokgtDV0A9CYC6AaL52gpGzpbb7g08PyKg==	5	LIlQ5zSeED1sKXiL9euY0rNUkQvpUm/5
513	yjx0PuryEwd1tIQV8SO5ggdSHiJ+IkgUloi1B9V64GClOg9MXkuy6g==	5	o197GKaCE8XAxW7bG16enwoOhJQf5wzN
514	vGqH4VDpyyerFTZcP14UZ3ZqxDxLaSs4bWY/4UK7Auy4JRv6ob4qMkZOqY5XtoqA13+3NYSy9bk=	5	lt8MdQEylYO81PGbUtvWQoMUKOqag+gk
515	SAtLrumQ9OzFi+OJAoKvWJSwu++BtgkjJPWD1yCAs6N4yR/uX3BJQk9QiD171yHT	5	BO6izD/oJu0CUvlThxMYInzJPmPn59od
516	CoV4QJrjcdt5e8JYMhWm05b/ZbtgZeSZ74zX3lMiJEaASFn4gQYnR9NN34HcJpj7	5	pP5k0kwvcuBl6vUY2D+VpIKPsZPcBlnE
517	0Vcsxb49BPYdQI45kOcpzECOb1148iLvpRRk2Ib8VRw9pZCpvsQTX2mhx4W4cBCuzvORWWouNJrL\nfH8fBM2tqA==	5	GvjUG0kp8CLKkyaax16YKorfYC9gPX4D
518	4aVSQpV4YCo4213txUlZIZWacUqXaGaDBWxIgGu/55cXlNfcDuK5gHNHiaXy/56y2TUfhGjjykY=	5	bDnE/HPlIPaWM+RJawoaTo8K7C8XulIk
519	+Yv3NncBIH/GeRVM5hsDF4/VBYTETtfQagSO3CYeDvw5cO6/lLkzeg==	5	RrsgdovbYdtrCS99+f+vrjRT2Fefxowk
520	EH5DPLDEjOabI+ssH/zCCv7KXr391aRdcR3k6NJ1PeSPFGuKS/A2twBvqNJpb3XMKH0NeENLQCeu\nKzMsHjkW9A==	5	Q4UWTEBZSAL9wU+y0Azy6P5AWkIPIuWk
521	vyctzUelSXGjNHi4wDrfG9m2fu81S2ndnTdCL9/M385qQgu++kE5Cw==	5	Y2cZWfqEi8pYvQtz4OFK7kLdAG0ImsDn
522	Tuz9gsHJZPlrVQtbD6luyWisqeRNgODR3miUehRTUKJcavhOdusFcoh1ikoAaLWbHpH3icwxHTQ=	5	iCcTY5q+2hJXRx8iTQTk0UPNACJoQl77
523	sc+Inq2d790NND1e81GKgBeVwFhmlTCAIwzeuYhU5haLnGewA5hGkjJi/UVTJMfWncdS6lIej3o=	5	cFIhtun+cuCHOeCEMHui0mKNIKKkCV4B
524	soTvrGYDbeBKyCdqO4NwzeNr9R84ydrCsQ2StPFoQjc=	5	qkxrJjJwc4t6tNbE12AbhXw7Q2IkqW+P
525	PKJQmFXiR5or4hPZCUUhxL/HCfXNpybtOtSCoSxkjEYjitUTQOGhjQ==	5	+zhi3pG63uxBV8ZligOJ2d+jg8bowGfe
526	4QvVva2NOGBNr4gZizijFiMtzmjFwVY9nTdCryh+Iv3d5ol1FntoPA==	5	O3ed2mqSgo91FOWRcHspdGwU51MsYlfS
527	TMpi8t4CYxx8gA+hQwogpI/l+FGhq8KlHWeZXxlMmpKA10e6uYunCQ==	5	8K2UxkvlV/ZfqRoBUTi6MCaadNQqxvVD
528	iuzPatyWB+XJX0FLzFB+M+/nuimi52H7R6i4KCZerzXiqb6IX0mnqQ==	5	upaayt3NDdBlljY5kCe0F4Wgc+vJv34t
529	6gvFFCqj1BA+v/uq4wZoUfKHb0dkJb1KRMK/eEmyxuPJAV0gb2iLUA==	5	NRBJVFVYHt7szNiFVzo3v8dzfVEhAELK
530	otbk8vHdLStaSsFcRFzoNRBsR6dpJQdL8J+JGEu+OGY=	5	vRFRSedsGI+i7pOpMOE66EHa9Oep7y//
531	DSf1TYeNh+W1ATdA0DYI3/GA+jPwpudyadMy6oWbeJ0=	5	mF8flMIH+JnmT/XJoN6qWJivDX/5Ng0D
532	Y8zbzP7b3o8vefSK0WEVe1MytH4HZwv6Z2cvnoPusCg=	5	ZsCPweXP724e2XcHuDv65AUtdJ4G+QJY
533	GHabGuq7n2oQ4q9q0xcDOJVU6wFTOnTA/23tNIIL1vbTXVrbUVIE4w==	5	cKbvEEzT2oX8Qz/uLqcqrhLKFpJlm+Au
534	WyD4Z7Omw7FK2jZbcdFJtRXX1g6T61ENDrsauzXSN2iXRec5RT/uQQ==	5	OGbVGwcqUno8a5jHLymnuLVO1YOuF/ZX
535	9CLz0OV7b1AwLLeXPcyYQGuZWCV52UHdbCRZ6dSM+Vmoj9M/cWOwRQ==	5	ni32+gMRqiLSOorPh0qrVP466Rt0uDjL
536	Daxz4y/Rtu7LyBfW6ps07RSqTAP2oVbxlOO1CEXEMzU=	5	JUK5K4HkzorW5tWoPVL0o2DZrkYJ2FTZ
537	nTViPk+zyiAOhRvffYq2ehnRmGO/zoJNDti+EChXrwoQbiqYQvvI0FqdwhEX3hE2Xs8dpNapp2Y=	5	8sBE1CCxTvgdQAk9rr/Mj0A37KokDvPo
538	1WRsqBI+/158YH1i6juRwTUhsxeoe6tqrSNpZg+PxUxgtJF+1SqPCQ==	5	jzbDOcVWoxtDP9iTwHYIajV6wuNHThGo
539	q5q7/TkG98IDnggJEei8AvtAPTX58ZuGDtHvr50z4jgShxhllRL2Kw==	5	c69U8/25J9ZNk0F5QjoMbIo0ADvhuAcu
540	sibhZGHwBM9QMC55OcWDfnoQ+nTkA2LN24pDJEAXDJOU1XiJTvm0fw==	5	8FWMqkCHT3tfgCcQrrcjGDJXIChJOsRx
541	vY7UV8fE7kTJCVLm0aMmxfUIpoWAfKs+mIT/qFRQELDNqZFxtrkdFg==	5	NKmgh8BNPRMlH1cFJpeyTbmLjTOUrZPy
542	pUi7nqnPcTLoJhfynmUkGDPNWAX19K+nhhHM0jwSBaLTdinz8a7nfg==	5	w2Dtx7iJZ5qh00I/qbG+cyGUO6SdVW7E
543	QRs/FsoOjYExgrqlaEXJVzjAvI4ncpgM3ZoHf796K9wAuvvJQ/v6Xi51GYczh6Tqmez3A8HegYs=	5	BA5MAUtgAbrYg9Cy2lP64S5bo9hvt2rO
544	VgrR6hQQq+l8vAhqk5YGqG1jDnIFOgiRaiAqmDiFabv7MOe3PWQv6Q==	5	igNjHAdPYtYZRmeEKRNNFxXBjoGVxHQH
545	byIn2V1xZUK8TlMHRjbDsrzkbHhuQE8PtRWiDApOUbc=	5	EY9+FjjDyxW8h8HfjWfijHyD1d5JSJlN
546	rXyPs2qF/XPQhRYsyYNE5cJyc2f8J6tPJTc9Bvkui6VrCq0g+Q52vRA2ZvhsbI4q	5	3wxXOA+n3KM81pbIAcjHPvVf+FXxqH+/
547	CWA0+ZGKa3659sjjn5C2VtbrDO4eM7DWCCmo6IFfW4Q=	5	qu4riBTM+Gd+m/aunPtNiHySPpfJNIQC
548	++GnCvfenStWGTuSHlUGybADh6bJ1Z1HczpIj4uAEs9ZO8BbK4bfxA==	5	UJ4XdB5QcnqglavexaJ7LQ6rQspGzqQF
549	/ioUVhdvaHsWbxBu01NqmCuokyxlXVmkjbBFAdYi9yaCNlCBpcuPOA==	5	yLEnjtcPvTSROH+0J+s7zp0uak3L/8O7
550	8gTa2c+4l19kcVjLVh1N9ruEuEeCNNOCiPgueF4wPsFEhmlX/cX34Q==	5	jzNmjpPyOEN+AqPvrisuz64PfadSDe5Z
551	yUV5CLOE6ol/tw9Lexjw3NK+1Jxr+JtwJylnTm3zI+K9AqgEortgTg==	5	PwrUTmpCFMCTwwsKm+U8ocsRMvHiw6dR
552	FsvdxPyxaMpkrTDUF2ZjiZjDtjfXTJbR4L+tgqlHjBCxgmL37UqVtms+X6X7LfBK7U1dwzvxztc=	5	w3pqvw7C4tAhwKPdGVI7LlS5NO4pJJo7
553	+g5L4Zauc+NAONfj+W7T9CQ4C0AFp8DRbZa3Wp6ufdg=	5	WemLFjWcRWLC6K1rgrRvvdvpoIexAjdr
554	CPibXK9KQcMv1cWg8ylXFcmBJtGlRFqpI5BF/1F7QAI=	5	M153y4erDtsIm1xuRdNTBql6vdu6GfKt
555	26CtX4dLnq2LER5JiW4BlU4UTswlWA8EN8x79u/IRc8=	5	6Hr5W55Pm21Z+11NDMS1a6r0NgZD3ee/
556	kFE9JrDSgpYfOXC99Dlais/3zaNbPhomkE0N1uqhS/vVF4TkGbIMhw==	5	HnzgWwHS3r/E7NlEVFZpj4aMLbS8o9hy
557	InYsIKx8yuaja+5e6U19nwL5NsEX3cg2QSdBiCMz27VQOn5PIdAdkEvAbWKyY9mR	5	GVVhpb24GkkhVvE4o7wsB1W8hL6Hoduo
558	Uqi68GHEV94nu9ZpfGRMkNrwAr47lnI5VMbQJ6tW5zjyGZ2u+2A+AA==	5	meH2q5q52swjeR4CRhQUk1iv9K3vIevs
559	ZX2FmQk1k988LEaDqb2TPtCyJO5t9L21nNcihwVS5RlumM6xVhb4ew==	5	BuCcdQUD80EHkS81v6zJellgu/KDaZuh
560	oQEHJnmAcgx9dYvIybZBJpk0UY1oDfGH+kGzDYpvgMjnOJJhzAlczBU/dFnKJid3	5	CpHai10MXZqn8A4EJYYxJgqGsFbWKONG
561	MYkguhnTMpB3ziCc3/h7sQ+8GeZ7lglAKN+Apq4uPzJQAkoboaeRFw==	5	eRLKpC0GtDJBFXwVBRrOQwCnrmJZVEDE
562	bBikEfzpazADoUqEcYYSKsKNmXFrDhLLlt+6aGFSBWgRKpb4gRDn/g==	5	WBr1M5YsRjsAt40YRAVOxdae/AixXzi2
563	y57MQt5e0apsUbGt2sIhrwy0d27RNvSdr9pEiLPLI3mRWdKtKYboaQ==	5	M5/wEzJCj/Z4OEEvPP/BJWjESW7tYLMF
564	BxUOgU9UnFULZPZ2yR+/vdxLwLM4nSuw4PHUWzk6vVjqhc12NLEeuA==	5	7ojW4KzV6C0eh39wkC5uPLhrKzxbJc78
565	6U/IqpCNRWXJ9u+oSA6rRwUtzwMdGnKh/XQFmaxZU3/l5gNt1hzmJw==	5	HD0RRAUsFSz8XoBNnRf0OezlIEnf34XC
566	A6qWCgiZSDTFDb7pclW+gjhn9wXwSbnJwpSYhbQ58txOk3URekHuJgzxfu3/TNgxDrfgQsf8yBU=	5	sZPUkwqnIs4CNHsE9PuLncpU2Vtmbku2
567	Ow/KgxTZjX7RlmHsK2L/Pp42IUObSohuRDrTilAl1XtJTB6nnW/iMw==	5	vAocYGJm6EG27xGPe4S5zkVEo8g5UaNd
568	sPWtTLmSUTr4CtaoNStYjXd18rGn7mAOPmpXx6kzCwy4QTCwrXm8hjEH251UMV19hS7hWqxtnhA=	5	+1J8Ja4Zkh9CnWBeKjPi+OiTs4sU/dYv
569	TX3CeVbmogdfAgjhElAK0TMJl+tgg+3YPgQNqyayURahT96jetGZoKK44tUbJn2yPPc9rqgj5+Ns\n5Du/1Yeg0A==	5	BvQvKcY7RIpuzW0lSnn1jHu5Sz2K//GF
570	dCIWMj6NWzwVVYYojd0OQQkKFsqsX2GMQp1JqBSLmR+96wFkAgTEliEF42GzNhX8	5	T+d6mwxloDV9aNHrKnpUuzIHfuQkUztg
571	ky1LRqV6uz1UWGMe/woDzOucJ/pislEaY/VSZfmXB1iS3bjFDkEMuHxiEWjBo7PO	5	Fembj3o2TAEsA/9FiewYcue8xF2Q04hI
572	0axdZhRyJQz5Qmb4Sv0KHHPvXcgPlsX8levvQOvridQ/8rMxLhqjSVITqy9azLYf+m+aLUqdXRc=	5	KTdyNqmYqoK2F3ttwxf6HpF54ejB3eQ9
573	ZGGM851dV/G2HNMPLVreIn6FU47vpWq/KcyF2QodSddvTWTth7H3pw==	5	Fj09U4gmdjf5Wgmu20DT4jvPgGSUhmgY
574	wYArIdOqO14GQB2cHfGQ2uxaZSADuOG+oBhtY/bv6wnf7DTzVYc3iA==	5	QF1JOQmOgUD5signndzlxOzWLKgXNHgC
575	HSMj5uMJSi3YDfyP0i2T07VFsN3g+niDmaczoPaiz7xv9ZMF5o1GEg==	16	RM/jgBCMH778KGNFkIswaBDU9M/4UOk2
576	ncxKuAI0dzDDlgGPq8JPbkj1tzqEIJQws8wWVk1QALiqEApF18mGEA==	16	gqmoN8nxZNcwSo3/z8jMywOdEtbtJJma
577	97KKsfQkUL0JSAR4uYo09tRvygN2ytYgzD1sNshlUvCinIe2OIZ/QvYCLLSJ5ngg	16	jWz+kB5MVsV90ydXZIr+4lWb+AZqb/Ye
578	uBJ4tS1/Nn8sd3PqwWSute7Jwu4sT5s79CU4jpa7R4M=	16	lvj2KdPRijxMxbg3G7xdv/JzcJeBWHYC
579	0Ru/r4vYmSgNq/sWvizVs7PpbGQX1Q39nTpxSTm40M+5/ltRrltYZg==	16	6Edhl2q97g2G5hQRZNqyRGaWomp1yCbv
580	oXEfzmfWmW82bI/1RckYsuBp1X0FzhbjVyHn8F48KGM=	16	ElHJ+g9TNoARWi7V20XpTc3mJVcG8oN7
581	XUirFJZnCtYHVh0MjbY2+mzeUyueejOKoyXESU5jfF9XAt1w/3a09A==	16	xC9nfLoCDvp6LROPy3KGxaxTAYai34yH
582	2kQbfozsWROijSaW4pyYfbmPWWb9S2CjpVLKfwj4jMjlEtMNKMEBSg==	16	tbHt+FUUF/onFR8rm/bJhl0m5C+gTr3E
583	8/i3eO7V4xlwNc/VgcvHeYK7iO2sfetULRwL6Ui8aH7bjg7Gsuzh1Q==	16	C8+Lz5OFtsLAXlwiF+lu9GNmBBpX3Eyn
584	9UKtYvc28LvBdhlQF3aNm0gDAI5434B9AcmJnSAzgs5ZxeZBjh8iBQ==	16	/m5Yx7aW8/N3OJ7sqD3xMJhANqlHHXwx
585	NcncPnuqL/MIw4h/6saAvUdwgVgBU2dtlh29Pee+Mv0EkOJXd1+hVg==	16	ixz5/cPmIaqW+cbvE6k7rQUJm7IzzLNS
586	/Re7kni4N4CUfGgs4lW++1UmpXB55ZYI3BKiPulN1Jfg84kW/IBiTw==	16	kgH4mnsk3l9vz4Nc2lSOJyzZvJwrnUKZ
587	Eqwe6FyzfwZjgwy4e6/nIfORYs2PfSRowdSPCL0YsQoWo9Ggzr2WHg==	16	302SO2yeJlJkQsf71/7H29axMuK6H1EF
588	c0BR1bQn1bGNKrvEyP32B3YzMi5gj9EI8hdDUpg7F8v2oFTMRboWpg==	16	LUB5GbStlNkTrwpmpU4tj6+Rv9jkqaEV
589	wyKrGSmuqDWe+Q0kfbJk/PK5nfWZGPBNEFRA7+Hohi127QoIlo1qKw==	16	zQ5aYGDS4q5/plUBaomC2zjdbDHX7ZKW
590	AzA82a3OSsb+m5XnJPMEepDi22ik4co8SvauOTLcETA=	16	AbHIR4YHRIe9uU1chCoAIMrS+u/Lo0en
591	25wQpaY3A+OcafV7oc01cHhWox7jeC+58AHyTn5byv+1aOPO9KtjFQ==	16	gBkc58m5BaZ/2871DFO74bIf/R58l+Ak
592	ZrP3aRkKPNJtNXcCJoJKbRbVF14D00RHTWVbB6UZSd+TRb7YODEGTA==	16	Xu4KJFi7L7YTyIhGR3BNr4uWjlWMe6QV
593	mbnkUhW/anEarw1b/9s7Zi9HhVRY7US5KFDZZx3kVyIQGRXQBosx7w==	16	mpxs7+sQ6CkYsDm+CKYZlEifwdixvLaB
594	nt3IHvSskKpr3rL13nh19FBzwggFj8oQcJcgefu9LnpeUd/iCn+yqg==	16	W8ucNVwnf/kFNtw0DVx955C06SD67y0U
595	1aBTF0ej6tlpnUTYdaWxXkwg22w+mRWxxHspsamviIPF0W/6dTuWDQ==	16	t5nzSeYph00dwFG3SPSMgUe8QSGv7rb0
596	kWSJzzO6iHhbj77DfMZp2oijy5xnW/VRWxdsQNMG7gzk656vHvAKvw==	16	fqdG33HjmNSFSfqNJ2d0GDS1psCU9oce
597	iT6j3bPBJyDGD6i489fOWvFuCdob77pyrIm4mKspEKc303RpaT4/TQ==	16	yhfwbVge2C+ZfFXcBVpwUNqz4fwXnIOK
598	DaufFIOsnFoG7tivxLTxNeCIMPHeICD1ldi5hK0QEP/UtczaBMXoU47bpcuvsDhX	16	3cXil/tRXIYNug+UoZJ0Jt9ljrez4TZS
599	Y3GE9KvZ4O4CULlSmP9Tp2h8taQyQwEQ2M2/FkNqJB714W95XNopfQ==	16	y1ScpKoFcprWjtpJ4VQ4MoX5Ci53dCx9
600	ifIK0XQCvVAvkh0K1xe5uLKFTN6tcJ8zbHe/+lGTBOJ0co4WrkhSSw==	16	NqBSJ4JPP73WwcoYSHGWPMpIUOP86TI6
601	7D0QCMdCt94lFAaqnZxQBmNaTJmmiADoWg65knU8mdBAZiR2eZWbYA==	16	oNNQUg+Ohdg/UR6w8+RlCMmkRclK3+/i
602	sGKxtESABR+VUj8lYPvhEjEzBRWHWJ1fDZWTDcIJC4M=	16	Uzx3gSZyjcw/Xq/9CR/RBAfo8u2XOX5y
603	3Fj3HEjfnCutU6IefBl9wEJsF8kQJ5EpK0bzKN7pgOU9FBlvm+7mYw==	16	doMQgDd7NKi4Q5WaSuifzIxl5/oDRU9Q
604	O9QGqD2JSAJXDR6ZLPAtsambPzoiUWpOQyvhO4715Alsu9p3bM99Nw==	16	QrgDw2LvxwGg91rMd/4ZA6CB/D8X12q5
605	RTWgEMJBM/BhCZKknUnJdfs4Sq9JnmDcE26TUejhMTp8z6HT53P/3Q==	16	P7txEwdgoMv6smC1pzp0/8QbhH+b80wJ
606	4hADslyZcsd7dNjIKWhfSPzOldfOjGZglcY+gtPZEuI=	16	da4yDHoz8kRvFIL5txQoAX9HKlI3RkWA
607	0jsDsqX06mCqKCzgTpmAfg+ndd+dcrH1uA4MlqILt64=	16	HnV06AXhPmDNp4YKyMWDOYaczWR6SwyC
608	xwede1sqoDRA4o+hQy+oVg8lDO8/n21HhSmS0ufy/yz1fIWmG1odDmp9GLc/BtDKhXlyReMdG1AW\n+TwQ9gXBMg==	16	xTTE3FljOmjWIJ11kN6gEqKLFdTSMOeU
609	9w/ZKBW415p+9IGeiiwG4gbe2x16dcymHGzJj3yEZ4bj1BrJF/eJMXBaVnjVGnypgIL0m0W0/ikX\ngx1DFjx23Q==	16	TPh0Cj+YMwQ7k4KY+jOzpZMTafKbMjKb
610	vSLk7bu9+qGGNQwJBeM8fMAm9k/1KcHuSVIvcQTKzrftqgcRw/TCgg==	16	F1MJsBEkw5POnrmwb1yRrSd362Krz1Gp
611	ZPj+oxFR74A+/CSmOsiKNXhDDA7GnWLgh8+n0KRlNcZKkzUcy3Lszw==	16	BHJdrMYw3n1BjY2VgzMGJM9ZDZQwlwg3
612	erTG99FxnqlylHIq3iAVXn+GEjOY/2ElsmmLyXJZ1l0fogMAXWcLf5/393Ay+hbuORZ6A9DV5LhI\nN9kDKIcQ9yrbqKkkXtl6	16	faOhFqrppCsSL8ganVa/i4H5rW/T8VUN
613	L9ZfVE5+nevWIqrP19/U6vHmcn1nDKsWm3M4/AZsDKhVayI+GJzP559NgceiF/tTkPO8nTMhjHO+\nJnN9LjphbQ==	16	WagKAEGkyj4X6c66eTdvyGKSccMFnWRu
614	Iw0k5dAnwFBK44Mcea8rkkEkyrOBbPL8X6WAhgi4F3slfCtEwQRxAKrZZa1E8e7OTUFYChAM3ic=	16	JG8yO4K5nW4VLETWf2zSf6QnJq/EOmXL
615	AKapxoP9z3hpk4v1REullsPIHDhxdlBwmJPIBpLRPFUuzja+GdLBFZvpj749tRT/h/NeNaN3HxA=	16	efvttpzy27U9ckvjKkAJLVQ6Pbu1Ff9x
616	be7qCu6tWSeLFVb/ed/6JmiaJmwhGuIDfb6RtBOKXUcenKslUl6gX4h4H/BCVqkIrNufJQUZmERJ\nN5M2Z48oXA==	16	WunFmvVVjCeFD3RpZk4AuAcR6wdh299p
617	Q5zOBSD+rUZ6+oM5KNNgYh3Utd9ssbWcBra48xapPub73yZC2TVU6w==	16	boxLHx4GLo75k1CAO/1iSaWkNVbHw+0F
618	jLCGmBODbbevX5sUFBqb6fmsliJPw2r69lu4UTXoNxTlZXwHNXV/k9OPJ3HQu4KT	16	v1XYMUtE7zfFqPMQbEfylJ1ws8Fjg1RZ
619	Jkl7+T9U5aIt/iT11lmLTFdGJUeS261y6zZyFtZei7CBg+OZBaSWc4Xo0k6BfwXS	16	0DjuzlRg/koRq/idL2AOYJWwJGfiarby
620	n2vbPBuXc+DEnZcRUVjvU6iZbf2rZYG2Ra/BudYXYVjKCqzuSmK/2g==	16	qBbMr7Cwym4g+JiA6rTxmdN/huaGaR+p
621	YVF+9x59dO4nzTjcXP4aa5UKXA2f+3goEwHWeofxyx6PvEvhni8MFw==	16	8maEwDfAhu/Or74W2zHXIlsfN8I3DvvK
622	3ccJu8kGhfKCybJiAssVvybifLyv1Umku1EbLX0D5Z4v955iWKBDGTcLWcoguOhp	16	gcGpEixvZtU3efESfnThtv9lwAg1e4Qp
623	qcCk7aTaO+PTxtxi0AsGVGRUJdk3SwXmEVzL5aO5g5tVtvAF9hC0meIQMhrmLHr4	16	TgwAz9H4wbDuhSRND8x9OnaqWSNx62sY
624	CP42SjkxI40l6rFtUem/Qrn7J8sZRMRb/b48f0oUM3CfS4Bz9fSzI7Kpwm0fOARhDvf7zlmJrp7j\ndQxSSyqesA==	16	KraO7p6sySYhHn7NoA3Vsflsv1W1dq6q
625	DJeP8wCWoY5ECVbj+4M3m9aVYb3AuZ7pw9s0kZ3ZO8mmIVI0U4uEBkddhvYcjgBgBmV3SZpYXD8Q\nZ792ycJY0xBocglkPUW2	16	l0NzV8I1K2k2B1rHpHeHdU4ty+vHCF2o
626	2rPhjzfS3KyS14TaWw+Ll0rkbuymxX2947FmsFAmEdgtgZBjReGMqa+0Obnhv8dgF540HUZNRvUZ\nqvQPEPoedy5SZ7VwgOeX	16	g23GgFqguQMkpU9lIiaVeVOzunYfnt2M
627	aenrZqNtpZpcVh/6oqi9ErNgFk0wt6GLZQAbZD1iHikjwakCKYGlfC5CUJYjHa/JpmxNQDqC1vyk\n7PAnn/RvYw==	16	el2uYf4PNteg7D8zGIjYWC4yMgW+b5OU
628	pvfg2Ij+wgO/bejTSz8GH/rB+UJjgSllqPQrJ3HLEIpKF7s6Z1/+m/NWV6roWqqjRghR6yd9UqIy\ntz7t0+WCqvkwycDOriRy	16	x8iZKRrXtNt9vswRtqEfsinhBz02aTlM
629	7C1Ass0lQzCwl0sBbj1krf+MUudluSYJ2Lo0AKZB9jrfOgl7IzGdhi5k1VC8Hqka	16	9gxJE5yrYeI651swWKOSuXBc7GNEwQt8
630	ZRW+DpLSkodEZOcrg+mq2VbbBZhF19YEWitD8PViDBupMBSM5OTG6MsaB06NJvMVtfsy8Gosp4Tg\nu4A19jwtNDQuz1QW+ePf	16	khHXmEDVxRa7eo1B27ffw2RLEsR+AtUO
631	VZ/phcnDIPGgEVSew3L4vXviHeGhD6+B8684FteWQgXbBA2TjrbSzZAIHk0PNhGuf9g6oCi9LAxN\nQcJsKmFx3g==	16	+LFau8YRwBTHjBORwZc9FePgCYBrZMl5
632	fWoWsdut25TZ94TUpD3NE4vUKmYmi2IQHQRY0K7WyOG83tCG190QFU5PmEtogw1xyKQxaHbkDMg=	16	zI3dVzAnbkGjPPt+c/7oMA//sUG87axr
633	UAD6pUbY9XNjx6OFpkHjv36GyYtbo6i7rFaAkQk96Is4m3I7vhknIgXX3hSDHvJM	16	ynrvJkSvNxRaNB8zxf3Zj00uqpTjtm98
634	c4o1+W6qTR32MuIKil3FSxMFQPi/HG1YP00GAtLKqTFEyL0mczCcxInBcKq/XyQPj0MfF/iFRmw=	16	EhIpRbzmTinFSfFsNyFKefuA9lKFpu5h
635	1+Ics8ULHlIXHCX2gPXu8XqOmd8jyiK9SiFy9r+N4QPVMqfV1kvOajVmJAIKyXczROv5pzV+lrBV\n/S5wAhNynqH7P9SqzyPRgXwXhiNS1Rg=	16	d7cx0SnmRgqFPZDxyW3Wd/MDMH25+/cm
636	13MiGT0kroOoH27S2Z7zrG+lZXLB8Y32DpnpX2Pf/+jHn0voxDhbf4d/NsjB8AbKDTcHzIzXo+o=	16	sQetCraP4AG/yT01yGa6M6LpR0EO3yZz
637	28ktsqhsLWoMCLW9JU8CF2ug+bXlTIApeGXG6B/a+qgn1lvTHRaQYY/JAtTMiLC7QKhdyUUvr0gp\nLcspn8jUbA==	16	/ttqioAUSY7CCo7+W98l2LBdHIrx8vGH
638	qbp/ozEBZYYtRPvdhz0PTpmnzXReWGRg/9JGYnoLifbmc4OjFl4diQ==	16	nk9AGtMWdlRAqHsfmTw2cfrgmJZXY3Ww
639	/m7ycjN45xhMYuD1oktY1K/wJLjqOuDh9plzwZIY0xp81IntXXy7YQ==	16	6s7FzlPb+72XJLR3DUvBojDrihtA6oMP
640	GA/K2ZuWttjs/hcuMexzQ4BnaUTFfTAaDzmOjbLXIvKMMkPafmY4jcm9sOqW1vz7	16	3Zi+g2N0Oe5ZgRuq6gTfru76CVcZz4DQ
641	VDSDVEGeoJ7eGhMtA+7u1XkSpO6RsKvZgwU0fzugqUohL4bo1aHHcKqFZLq6o2Yi	16	JbIJepmzyvhflOGEyHxkJ6KpPxbbEFVV
642	XbPHk7Zp0ARIf43dSl1ge5CVow+0h0huPGhbvpIgUCyXbM7LlyCxdKFlTorOCdZj3lGjRPrv1UE=	16	m7mAJAK2jkfqcDwSUCScoZGRcoH7WHwk
643	8Ib5vNCjv/8ylfge9pAGbTQgR4WrluJsDGuQDn48rGPAN4dfGawJyHzRLLOtdsOJI0aduHETlJ/F\nRACb2aJQ4zbIR65B8Hu6	16	u88XLxtOUBmUxnA5VMaK8gL+iyBAxNC1
644	ffXJiwj2rLPkksqSgxEnvspdLVz9JFSRGRQnsb8YBzooJjXRkwONV8TVrmeruWUqoQqGGEVarKBV\nirv1eZJvKw==	16	nHCctP07qcKX4Pei5rEGmUPdMbsshHym
645	bJ75WsTbRfDO4cEOLwhKD6TqrrXM/sRA+J9DEAy2m0uuz7IcQQpNRHwzQetQsHtbiwowv2ocHbg/\n6o4WPa/EgAIWyk1nF1RzG2ZwwSzsF0s=	16	qGeeQDDLWGYkArfO5Cpeu9c7HLLAaZ4n
646	ngp+znuiMQ8/wDlZ78u1GCdflwJgvFb3GL3y27EKLa0xuczGQwvsNA==	16	DGwn9dLc9VW8nOuL6CO+omTdMQNHKvUd
647	ZIHhIjMdk1bTbzH2BDnTvWzKTwqbeMJIHV0APjoNZ+k70kGn5xeEkBBLeWkkcLM6cZgMxWQcr8iU\nbyKWhZrVuw==	16	uV0GNjonQsCaEy4JsIS3wMgN0XHtts1P
648	HToN+uhgQdO480V+Khs1hxImgYozXDsn3Z86poXGvmptcqu3M1Vl3g==	16	5f68VaOPzPqcETYZuWfQtsEndRXUCKw4
649	nNdn/yCDGiZ0iBcQI51HRP7mIGt5FQjE9zlSIbi0bqv5z4KS9OmPDw==	16	MoFdZsYvGvafxkMomC+Ooip+PufQFmuW
650	KBV7anrBvI63Mb9Fxu1qSgh2EgVNa64puvj+KOgazSNBpabJWd5B2Uptq8/RsE8B	16	O6m1ifX6FCck4MkusP3NqQk/j8HzJ+pu
651	kD3tyktx69j1xMTjWbwqzdI1Yr0aH9hIcP4hkePSb82ZvU6HZBm1xZnEP2zkGt8/8hy/x5rr374=	16	0CuoeVCEkkGigKQob+2IBQO7gcK7QJbN
652	/Cu9WLJ6Ojr/bMS9eCU8R9mXp9LxwaETyVE9abIxvdTZ6ASxcCasuoUEsEB8Hh9L8t7c31hh4L4=	16	ycP2GtyCeDp1SK2ktTKJAlNlGrv8GOjF
653	TFD+BpaZidB536JrJA9CKkhlZuWL8thokWkma/X5t6byuEpXmV8L9NvoVfyYVD5luylRfiolqho=	16	DzMFAGhLMRQPZlYLJDX3VvTh75LtG9mY
654	bemnuFdz+BUGEXrQ04sRw5LmiAyOpUtTq+i8Q8srtMPdq6pylw98QA==	16	XZpfWhSfnGiEPx48OLBt9CutVt8j5IPL
655	/Bf5WLNHLtNTJKBiHm1mcISCBMb9NT/WeZrCHQ9qORc=	16	nh7IXsdNUb67UpMr8g61e688aUkk2Ed5
656	dnkC6NaNie97s917kmyQY4/Yk+qvOQRo34LZ03Cq4IE5XtXB1kxXE0FhIlu5yn0j6s2/PSJgsXo=	16	V3V/g911KSBDyKMoo2UdWQua1u3o8zwS
657	IHcDCZQ7OWsdMXip6R5IU0YUpIQeK3cBB+wK3uKpLaE0GuDFKKr0h1MGfbvPPKC7	16	zZUx+NuCX0jqIuDQBNW3YmwMfoyQL4H7
658	5ZkSKlToMqLM21L7Wt2VvOadD1P6OMC2au355U4p0hc=	16	tDvXJLWyn6M46BboMR7Tnzj3konTJNZz
659	IT2oumXXF20XbrFCIRNDB7yYmRjVmx58zNza55rMNkOGSXlEzF8oIw==	16	xnXqOsaXmxjJkE18praED2+Zrk/g0rlh
660	u9ZGF1CekUR1XaI6IaR+VysUYaa4EPh12cOrWBTh+VAsonnaoFao5+gWAGJBMjtw	18	jCZwkHLSlKVV+Ozfsxj1eRgjNCL4gpgi
661	C0e3qMWBPfNfEuORbusfOxx0feQkMZYdBMzkz+2GrZERZZ+Q/liBUUn70iP35tUYn0we6O3R5IjW\nhX494Z+G7vmdL08/elYD	18	bSsBfrYc9BYw7/biP39mEJKStauj6lUf
662	MxSYYWsivWl04bVsMlk3QMQ0XSHlHqlwL6nmXyPKcDsk4HNEC1Vdtg==	18	RQHp3s7l6HH4H2LbiOjYzHYX7FkjUHur
663	HFT4ZnxMFRL8Jsf/lZImK/iLy+7azSGEPyV1oJrHiaM=	18	re9ea5Yve1/7/0bCevk6Pure4FEPck+e
664	XlCy14nTPHIRZZAMpqp57TEcKojdugUEzz/VQxCJUnALELnAJFmr9gXTY4fPeCnZ	18	HwkhtMPqxc45WBmsfu9RsCZowYKsPrTQ
665	CU8WqsB5Jk1iqvRGY1JWQohcBuA7NShEFfnCCTn+izQ=	18	9AeUlLG4fLY0ttB20kGiW2IUEyjHxwmd
666	jH17FHfk8Xf/Fa5Z0nRuNWsSeM2up8NboA5b2qVkhb6KgdfIRy+CHQ==	18	vIPTwsvpkcUviwW2Uc3+PEtbukDcjOvc
667	7w+U+NUWJHfLwIogiokfTFnJi/bOL0g2j7Iv33zg8FRcweYSvRSyH3A0R3600bWdp0flf7V9MWY=	18	Y7qwwJw1LBvF9B6GYL3D2zg5eFcvJY1E
668	2qyKvORbS9RAYMtEE2EClZCM29Khr1spj203kArQJZIxDLjxd4tGIfrxglo2w5uE	18	XPeuzNj2GAOPdeb73hNqIi1RqpzzcMBX
669	MF1jXHvVxNVBFwtYPAH3f1+hOucPnNBxtyZPyRBVRuQ7iNQbvC+jyhHqCLnvyK3iQlwo8eB9DPU=	18	8WyhVfzJaTr3/84ZnMdDBDKwwipKYIYr
670	2YFDIzMPexTg8zGO6htAuxX/kL0M+zVBcMfchhorFogxBySNnAfMdI0w8jS3bU2ZAICvKWd23KQ=	18	NKY7+q//NROkqfQWMbTv/LAJixvL3Hvq
671	qMNFL+RD9UEBNcbbQ0VU2G0ceP8o4RS/NQH0SGqQb/D6/FRVfY6+6RqnSy8Cd13Vt3iLjuWTKb/c\nCOH0VSGZCQ==	18	vf7ZezzcUU9E5MtzqHiGKRSupXrW95DO
672	PDm5vtq67puodhS35ELrgCYbnWVX/i9HVz4t9CvRO8IIN0yHA08i6g==	18	8Cry7w4QRd9+ONzLZ0m3sB+xVjfOftXJ
673	B8xzeW+S9KXa1uiboyzIT6UwUctEn5AzHubkAMvxzw/7Z2CXJdqHBNrdPoM4ZfYA	18	zxTGGfCzWWdZQFo8QfFQciTwyBcNBGaq
674	WWEW9QbdCP7c556B6RFcFqlb6JElyQyZERV0XNUXeTul6R8lxG6Vag==	18	AS+KlGxnoZXIn2BeRL2waSNwW4wTDWxY
675	Bvq4NfVm4EM7gk4v5VIr3FbG+hcz7eFdqTJaJF55j8uLH5FvPEJyKw==	18	wIaXOlPtTiG+WQQQ2+rVE3TbUIYTmCM0
676	pVj9BiQoqqFNoBOUwZbzXG4r+O82VIA6qAG3s6XlI/x7FuWwbnE/kQ==	18	tQ0WnSplt8MwJlSb2QplrLRNjMBuMRhb
677	630fSUQH3NzmE7YBeURgK4cGi91eIvkhMuM+Tb8zVEu9R/9XPzBxQg==	18	l/4+PGrOLK2JGa9lncDjHx8ZKLWsryaz
678	TgFspKpReB0n/HSfcw8gV03oMZN52p4gcPTiSPzv1ASVCs0SsFFG7Q==	18	x55j/wUKollvNwjDEODm1UFk5W7YvRTt
679	A0ONxcXoHSDNjWqkOGaL36uhYko1W76pfgrCbDm0DMDApX6QIaeO/Mz/9DhNVlOL	18	gvQ1CL3cGDD9Mrxiv/xG9dLv3yYPtESw
680	kLO4fWWSQSYouc4rBX87qziOnSeQLdeVlCddgjvTLfvdOKcv2v8b3A7nrKZhq53Q	18	sFZTJdVZ/pYF3senqDObUzmsqQOCexHQ
681	vlrLorE57S7YrqoByYsQGZnWVQkmN9F4mYwssBGE7zBjBjtaQ0fIfz2nY+gL7m/meQqOm2OkfQg=	18	sKPGOy7NReWaXD3RLVzfuKYsFXS7HNyY
682	0tfZ9M3kgimnlm/4sE0YBzJdGMu8HS//jT9ZjA8tRhi+++MqW9AmEdumv1Q+auRf	18	Cf4hmcLkarrAX0bWKQO4Tq+B1G0v5B31
683	DiUc/NNWs61z4XbTlrgr2r/R10/vXTfX0mEFml/4jM5eYJWv12HjZwOms3cBYM3l	18	NiODBj9Wgyf0PQKBd0RWeJSjey+i+YTJ
684	pOACJJF8DZrXEqy+HExmYhJhN82ad0HjmXxLVNKKUbSLgPDTKdoX9w==	18	RWutTLHuR4gBSlEkUR+rESCrVGbdXrQw
685	5cjpQ2TN+a+Ok1mTuFvmXRdClejeBPXpTAfjD+x6rxYzRhHOPrTixQ==	18	/LOcLfOENdApzepkWPxodF5bJ7j581wU
686	FFBwMs0k0WjleRb/KAprscaeZwZv+wSbcJVxOGCaYFD3D6gGaZ9v1e17RI1H+4g5	10	XeH/0AzRrdf1TYaFDrcFwnWkyUvtHwGs
687	wgFuXypdsnPtSgNa2Qce9yQeu5APMyS+okYnf1s4jHY3lZaOL455BO/P4XnhxEsPH0QyFypE+yO9\nvqigOiiGMA==	10	CccaYKO1nFDBNTkMfJAcealtjcEIEX5s
688	Wa5ldCB3AHoHEGCkLnWGqqdZzazRTEj2aU339RCIC/H6kkXJWGgUIw==	10	5xiKJVYOxjrpuvjgdcTMWiaxUYqme1Vi
689	FNRlMSip4kj9/duO86s1QDP8hlhTFqoC62DKtkYKqNwD0nSO2xo/pMHBRb/3TinW	10	cu40ThuqZClnsGS1pHCILckv071cuTyZ
690	yhhxSKlM6Q8RbZN2eaKpJbtTzvqc/uuR8wMr5RtGelHarhCke9JaOQ3z+M0cLg9Z	10	umlkr96exRxHYusWj06iI6palqDdfSxU
691	eTMIwUBwQgiL7evhlP9vAd2CJS96icMiHlYFh1GU96zfdGKIfyzJRFh9qXdILIh/	10	KKhRbS0QN5Sj21UJlJQvoHvYwb0LdjQz
692	xORKVuDPIbJxmzRI3iOWhIvLeBRbJwVWvQIgRTB7bSgF9doO2fXlxPiBXf/MsaYp	10	dXrwQddtmJEa9+QYhUJ3XTFC0Pd9ZQa9
693	IIIh+TwIkScHSyN70+2dc/+a/QgmjvsSA252sQAFf1An8RdEOrZw9Q==	10	yQv8Nvh95pPK6dPMrGF58LnZTE6FvZws
694	/rZwkcYqDw0o+FE/JZfOez+eIlhCZVnL9Vi1AHoe+UIZBn+C3ig93g==	10	ioUgvyEi9lB8ExOXNk86a3/4t7134MLU
695	YqdcZtN3rZtENkMIqdSa2Gb0UaQKkO9G6irF+J2P+HwgUmmHcVm03Q==	10	tQmeimqNmL309//8W2dKy3RN06lVp0xG
696	Q2pvzktSglkh9sQeSWgHp2J1z2JvFNYZMBybnnJNBeWJpuQFq97403fdW03TFk9t	10	mw/6SuqAm3yQ/Khm8/kl9s7aiEd4bfpM
697	Iq52y2tSRCI8Xqi1/hNbd2YAusVWTcGVOcvs7L/boSgTm1Uncyaz7qpA1dZ9lnG5	10	m9F5fmyvM15b5rURYSY5rX5BzDFEI9Zi
698	S9vJRqjPFza4FrXUopuNmpLUy/VZWgGORBbWbhBMtvkMDJZ4ammTtA==	10	uLWzoPom3rD5JPfAev1neMqrclBea1xu
699	b948I2b0/T2OmN79ipBhil8m/tlDSTPMrhqMmaw4eL0=	10	iz7Gv8KIm+xMXL4GAyFbgYmdDdlLFNz3
700	kIdEV939GphcZiJzugbmND9RDr8i2IJeUeZ5Y5iMeQDc+LPEr/PfTg==	10	MWOuYzc3xh/64BJD2iN13+QafPAq+kY5
701	yjuDf896X3YnWLrL43mLMzoAngoBVauTwO7KvERjnsJZXE0uhh7Cbg==	10	eQJMuBYbRnuRJVlmPJIlpQAiUc4gyTQg
702	Z6fyEHKK0uVYf7zZhEdKdBFhlaxdGC+1zsRFhYDMYUDEGwD2YeONhA==	10	VASlz7POHzKQAPGyf1VNg6zNr+4l9vtp
703	kFR4U/+vslq95K61ux4IxNQIgJG++dXT1L7qWbgWHYw3E6qbCWU6WASLy7hq2xIO6Om/yngSSIc=	10	MIGMuVWK3SRkWwThzRjgNCeFnV2fjD2A
704	TEvwyTaD3SSiVuYE7uJsNAEWaf6+pShWQXQSwm7nOkjgKel53QdhZgj23XcDyonX3wTtj4xTrsA=	10	btKDiCCHmNk/XXqp2AinlH8T9ZuLHmVy
705	eXGqw/WXzJ3fK8CyHwvgemWud8JLEK+9QvAsuLAHihc=	10	/o21NYTp9I1JfITrluJ72A6X67dIpkOs
706	K3L3fPTcagsC+eU9sYh2vbfeOXZASC+N64Yb+HisRB/ZMKSdzsUw6Yv66N+vjIpd	10	2AUv849e/413C/Vdwy0sa7rm843pCtDY
707	kDNy1AY1Epx87Hrt9kMeVcObBfcdoku9kg8COexv1bTs4wkD2xZsPA==	10	7Wf4DwYfeHKf5krNFl8krgx8Am90nixa
708	A+HhoDhHhY+cTiwA2XUEMoW6kNDfguE70GN9QWuCMcx7DskbohSsRMRasd38eqou	10	BMgXS7vSdwI0zqnJAlMYG3ZcKGG4Bf9z
709	Hjs+YfTeX0fv44ouf3D2pUlGO/1rz5rLcuI4w8d4mK4T1UXbO1j8ozOzRSrncriL	10	piBD17xuU5YUQSjoxXAKE3DvTCkXq0In
710	SJHiHt9vph6LToiGbQJ9CHOrt0l/oUbq2fO3R1YbtYwYkGtyrlKjkosQVaHdluwS7g4CrptC/RI=	10	1UIaGDS8MBaIzrMHECSTAqSBd3kQQ4S2
711	GO1u1mtTzlXB4sdoaxZ/wX8NPxc0rlP5vw9WgTIh50KbzDAEEZGhvru5V1WUTRSr5itKuzmQuTE=	10	qyNXbvonCoL3fwf0+dO64H1AWt5OeVRQ
712	MA7F1fgFYWt3q4LRolisUn6V4QIrhKvLjbDiPFIjJA/BdT+eSr7UyQ==	10	j+Urv6JYlfyKjQaEGg3kTjkKLMu1YopU
713	SeXrQGfCczQTsf2GsEqYyzsXyfzYyOMh7kGYy2GYhmV2gIjhAIyFKemITl8M7+XD	10	KUSiNh/lRM7LSsZPEURVxRjvWWVvnzrV
714	p0LAyyzjznQ9pP62UgeYhRjnhgWP7spDa4lf6rIizNpuv/h4TTCGwg==	10	FmVyC29TIJt+OiixCalyQRidLL7Jxoiv
715	sgw5U7L9FhnUx1DNqRKlnCf351N/8v8D8Sh7UX26n+8=	10	h16qYtneqwxUyUZmXBxRNj8SzWSYHKlp
716	0Qscxw9Vo3p33brCM4yc9GiDd9PwBZmEarCkJYdzxLCwhwerGxlPsT0BbCPo9RCU	10	guesGKg2t0Mh+PIxJeOI5cPbLJIaRcbh
717	0b4x13IFJ3kliloDOZV4DnaDyzyxQEp66aJLwKF2lbox9OOzD01/VA==	10	ioPchcH4hNYRx0gsMq2Uskj3s5xnNRZB
718	Zaq1lxZIppInjV+jjZ5qOfO8lV7HhFjB4Zg3IK27WQQhpKhvImS6t42XfVrfcXvV	10	ALoxdk06AfLj++wrJPT5AO0lclcST3sM
719	gUVmqpQaA6mYW9if2Q2+p+dNevyjfMC6DUIMiWqDIA+uMHfR2rLwCtm1a9PrdpX2fQ2srsCbzhs=	10	zOItNouv7Of4orzbOTA9M0gE2kbFk3GW
720	FqxvH37biVMVZK12GOOfIpnCwS8zsIHkPUkCGmtLwlRmNkeQcMnXmze5wId/t97rDUxPFFqrM2c=	10	OyhsGjkm4HjLEMHU55KS/DT3RUGPHlG2
721	KHwWguoUJO1GBGhmlR/AvL9uF94U48vFmwUuQadltfNwXBA9GRchQvUW9Q3GTtOrE7Yk8nsDuPJe\nV3uR9eFKrQ==	10	NcFFkSPrcuyq+DnBfeYoZY03q4fT6Iw8
722	dEogwxtRvizmp3faNWqAWepu08MW/9fCWTTl6tZkFidWH7kBtU9gMA==	10	qSLeRK94mBJ6rC5XGYVMWyS4GXwj9/gV
723	VKhke5OYbJVWIXAneB5oj0D5HCI4zjgzP1TGpRuxkRCd2aTU7Npjpg==	10	HLrPAS7pkLhqCMrFQcqktAoSOVrGzwtx
724	uWHeym25iJlYOYZiemuGIfut832GIIjmgqjAtPEQwRU=	10	PI0srt0Ael4pkVNjkcKccZZNYIPf6iLF
725	0WK/ANCW8CCzoeyVs5g1qIEsW09lw0ANfTccJ+ttj0bG0wWjCUQNMg==	10	zhfHzjqG9hrxUkZTcgPcPj9L8hJuh6Xd
726	TxNUFecYupXVSgAIMayJguR+E6oMx90DWiEUZEf81EWRbulbEHYF2g==	10	MBPdMziYc0FhMxEb+X9m4SRk+t+1d4lF
727	U47HCoYlNj90Ts6xUAZIWlKL//OSxebpbNJ8FpRqisMcRPkpVNCd9g==	10	LZ9Nq+/p7fvJfwkW1Q+mL3MdnLBY49Lj
728	S5m7RBPzP6hQCI3MOsUYiUbYStyUqA72ngcB7NlUo1un4YLhxwLl04cYCHEwBCui9w8YYyKaSEQ=	10	o5LJIhHYQbpxEiZOgvaywvIYMiYAHyhX
729	74GUMQEpf5xJgp0sx89iOP6W8ROAVl1mVsS+gPr+u2LWXaNKZS9+zUoQuvfAUiQyVAY3t2DrdyQ=	10	+pMfZJvvsSmFBfvBbMKC3pAT1cbll5Xy
730	c5xceT2Xa9FykOPrX5TXJ4Mm8FJ0Vsk9egSEalL54caV9eIxcqYrwmZoypBBVQAcHyfZ9/oyYds=	10	ZMgyTtd0Vwm6eaCLNZ+z1qf3RV8WIx8G
731	KTAWJ9Idhw9N9jIKoOi7G2w/hk/G4oiq8hLjPb+JYJk=	10	6jtk5C6HvGQCjcx2dgPRf1XRax1x5a/3
732	KgAcLyjv8Oq7pUaJd8QCpwAyEc1idvnZn4B+C2JpDkDRisBhjfGaEA==	10	4UILzDrDk2MiTXWt8iq7iTT+IaZFReav
733	fOv23ZPN9g1EHR5Ky9dPQAzc9Zm8ovJeahT9zEPqAI8mYcVb+aJvQQ==	10	TFMblRmjAuGyfzsvxQ04G8pYPtFEplax
734	m141kTM4Rtred20Bacix1/icRl9zkLNtrTk8+9d+v0ptpviFCJFHy3bsqIrVCVuO	7	wwDX6oxswuEF7ObpOn4Z9AWoB0o8xX3F
735	2NJHq6CG3gKHe5hKZhr2UbQMUm58P94+0ozuVz7BZEG+G8P33MT+cGMlaZhhx90AQNZ9hdXYORQ=	7	709Sc9yDGgGlkNki881q/9MDolDe1ki9
736	NDZHpQJY/1xOWxrXEgdddI7IMTilbLRbk0ruoUjpBFsZR1nLnoIWPnPyGDblJsng	7	qrHEaLvqmqdoMwdLQDucOM6e9hbydoky
737	77RXXjbJphAEKe1B8YEOHBz+nZvwbhprS6rgNJcaYrDATxov9S14hg==	7	gvSFmNcP6blSKUS/AIqwYqmp74t6oMlo
738	r2UDoZw53uVKtdXb3m5XejBEY8peW3sEVfKkOhwI3RkeAGj/5qHBAexWiE8HhSXC	7	ZV/VzTskHjlq+V2/96NidO385sdMQs0h
739	fexrhTgV3xUxYcpF8KOXYiO68/Mxon3kiQ57TsJEkMHmt78mrU9OvChRf+QRhCpLIyXQbdoY9WM=	7	j87MVqfGenj7ScNgtiQY694IpKqrAJXt
740	kzhmfCIy8Le9P4Yp57UZxaHVQP0w0SYnX1/nkaMBp8lad6ykeWi7dQ==	7	nw2Gy+ZHtPoseOVGcANuiC5aQ56aRf9B
741	5US1ZWVOAijzEWBOsSLsFxIpmgjQ104BvSvhyXfIOF85BMQZ5eqhCw==	7	pRmeGhenXKa4agxvt/T2+Or0flFEbcNB
742	uDLnnOSSny1S4wsYdrhNEFGAdPqNSyeQy9US4bwZgxI=	7	XRbAhbxyZCrmTq3SnncXwgTVICcrUYV8
743	XhmHmCpRFoY/uajEZxAoPxtfufv2cRiZu9zSsUFoSh0=	7	7AeENxT+b5c86WLQ6tKCLAZuScMcPJVB
744	gannwJUX2AeLvTMpCPsXJvCpbHRmu7/Puuhk7qEizjax0feFOpxwiXsQDECsqvPv	7	KwTc4F5w3nhqPptsgEne/xm+HNXzSh2c
745	H43X2h9d3hKlI8Ib4rFP+gkVgou+Sswy/zX2oFqxkNQ=	7	nxEhh9z1Y0KcFFWAKVdBwUU+PMjMXj3U
746	2HGw1RkW4CGozAXQS4CT4anA/XAahZFo9zyYuNiquNs=	7	DGiR/ZwcucuQt6sFHLcQQOtQ9DgG7ytv
747	JXE6yee8nMZUwf/AxAEG9yxDvVd9ndD69wVy1KsLoWa3SjOwII+z4X1cbG68sOVf	7	IINgtVHcF/OQdddRXaLbUJ9n5AzgwpK1
748	vj2DVRzHPkvQx4TrvxJqfA5YM51diJ1VpK4GPwhjf+o=	7	ALJDkKC5sqKsVjDXUsIiX6AKDlGQg8f2
749	ZCTvv2q4Q3Citv5k1BKcPhgTJf5+UrYtWmVlbOCs0yIQcyNFPmm0T5rNaIbWnOua	7	O3Z/47yAFs8N7nojh2rCTELCjfJwOpEt
750	NBXg+SojDmL67BdjQskTKztynS9bGVNZ1AWNXseTuykg3Xc5sJ9PoEWMWLdJeJManIv8lcSqyeM=	7	pdRx6OYXD3wPPWtU9g17CaQPFdQh49wF
751	88PlpvdvTux+iG5lsiusblx0UpG/P5mEwnr4ZOAuHQY7x50e7Sdf1xgXeaOa2gvlxRAbhTVRGjqL\nfJ07iz19ZA==	7	CrZJN4cERIfr3w9Ymsa1WLJgfHCdOvJA
752	O//CV4kHfHg2wY4K56E8aEJrkiZwtJUpocCWvwL4dlw=	7	hF9Os2ZhMyaDzDu05TniAWZ+OpFNDC8R
753	vnMnoSbFilIulRZEVeQb8uzPHcwqGNebl7xC2q9iTLri8dHRp4npoA==	7	Vi7lMxxJMUAlT5azvlBFWed6/xuMjMOn
754	IzYq50EJhwIW0Ld40MJXL+qxxuCTPbNpEVO0FcYtl2o=	7	Yk7y4mFplsf+qs8ZgB4V0NmHPqZDHdjK
755	zOelytsIqQbTVHlinmkYixUwtzScghQaC7hP7w/tRJM=	7	jb8dea72z89hDap3YCa4et4ZaD47+nzg
756	J1krOHGwK4iMjUTS+SKcSuC6hczXQQAEkPUNqftdTeg=	7	h2UEONnR8y9v6o57gAXxP27hvZeyaBev
757	l5z+CM/lH0f6aTcF37TXMFXY6HCTOMxCZVThKem10VaX4bae3z6lOg==	7	Km9/lLHe3IV0HrERce/XU/pQmc+JEByU
758	k3nzt80svUBJ+qJnzxVfqavKUTon3iK6RsL1kaB5dHw=	7	jXmFPh5/Amg/N2+8m7vnAC72/hodruKz
759	5gxIMSxZG/1ryyGqq2akZ3HGuwsTamzGFyA5+yjuiuyXWFc/Z+6bddhXabQ2I+QV	7	nC1JEszj3L74R8U+wBCVJZVzpoxx15y1
760	bBcwVT2WJWBBaqOlil3zgM7aPt0i6R6nEs3QGsklbRw=	7	0SOGQlhUM7yvsIWSnXD15jaxmcFV5bJ3
761	IHePvG3QDS+6WAi+rp5MWobYwMhXkRW5mlvM2PkvaZ4=	7	bmsJVSAf1g7FY/LBe2Z50Yn8B9udXJmm
762	dXKlR3PNjfOwAXK+MgavSFfvu75uckiGWrdpFjE7r6/d6iCV2DeQBQ==	7	xnJK3SGOfo/uUOU8bpoTgVS7trQ3bO4+
763	FRW0pLi1rTqFugmDuKPPzo+iacAjxvvE+Z5EdX0rc7aWwGAckLzBXw==	7	YHEaNx/hHtAZvIADB70n9Iw5x+y3tQOx
764	FdEb2DO+kkxyoc5g4QyN6v9cxX6GTixb+4gRldXm288=	7	wmKuUMdM72qNPOL0kfOJ6XWBzYaC4RFl
765	Drvr1m45VNDN0GWX78w/koFDzIAq5EeugBe9+ztTvCw=	7	8sIvbGf8+ZfTVQL6ErspowbJNwCxDBA7
766	2coN34+PGcvQ81YSS6VCGGQXuPPosCn5xVdMnB+PDfg=	7	yIEJ/Ta0VE6Kl8DYSLIgmRBkDDRfRuC2
767	D4A2YUPg3Dzi118cliyPaT+CZpYcnktMIK3gZA1HvR1iIQ4blnWjFwPzM9HpVXpW	7	ryGGOCqQ1HozcCCLB5/S5HNGYiQTRPtD
768	B9Sum6Ddlw1P8Ve07+fxc8nGlBOJpGhy7AKmfE9abek=	7	fvHYw+tsyic4Koe34IrzBGM6boiPhFEy
769	9OiDnqFYbJ/bwGnyFMGkLomD3ID1wGW8R6NrHdqTN4qr83faCMg18g==	7	vLnLCcI1uVW+tDXcqh2FiGl4ufM9rwOj
770	a1M9TzArLntqGN2LX47XfJ9THWEhGaHhtE6XMHJaQ4c=	7	P+O/z8biDGD5gYtE2+VnJpYSECwGiUdo
771	ozGXbTbsfy7vw8MLLLNOTtZDbSGBB81TO2YH4+S2OF9j0VW8amAvDA==	7	w2sgHBTzm5uxG6bBfYcF+2dG8ASBfouu
772	CcGJGEU6pmebMDP1f1wIouOW6naGG1iJGKAlG7ZTtHM=	7	OLGcv9E9ZQ1rdZgaV0a1b+e0OisldzFW
773	ReIdAxIzJ1G4qgXj0W0eVjtFSI5y6PJAgLn+yzVioBSips+3t9w4Yw==	7	R7G5yaEUX8JiskxA9pnWMq/NYjlNDYww
774	YltWWqgjzI73PZEm/4po52ZvQ3kxqnpXOvhDhZX/9iGTVtWRCoP7eQ==	7	g3M5sVOMsVxjj2Sjs9Ld9CM/2vWzdIlE
775	9XZRDNNPl1H6Nj9f3n5TZGtKGIBIHc8ZnJh9fMFAIJo=	7	3ebTLyv5upFzseW2m/khGPyv1s2u2tX1
776	RxgIHg3dYRecMqdZBhw4MiQOpLngyXe0irfGoJHeyi0=	7	SpFhDSV18nGq1NFNWR0RweWZ1WT/LFjV
777	p4VLXkDOkkFOLbxfJzBqBf1Dcw193OQbFR7TbGdLTRbR0wOsGwxkq35YAI/2MkaLpERd1reVVmY=	7	/KsIu6c2J28EK2dO6NTtkUPPZLTo7Agx
778	wG890ZIVz2Rv7xHt9GT6MwWPIdVN8L6XQtH/KbTSqTGGwbLMVUkTfQ==	7	yOJihsbm71vkFbRCNGlsTwNeAn9zw0NR
779	Yi2OmiqbdS+Dk2uvAB5lSxZB4KXSkDWpOdMRboxLcGR2Wq0/rh8XIw==	7	5oxuBhDHYjxpSlLcYCuWI11MMoOK4N4X
780	ytKEyIP89vTNtNXYi6hQUqy3xv/PR0Ypu1IxwmOweoc=	7	Oa0iTPxwwIJHtAP0OO3hFvJcYXDqO/IY
781	7YvKaeSRLC5APfWjNx+a9vWS3/zL2meoKWrk8Pmryy4oWM2juv2Vdg==	7	PEajDKAo9mCj1aPsDHTQuJA6KTO7t+vB
782	HdSUfg6DApR49Y3/YCutxpbdU83MGE+9+3viGNz8NiwhpaVGRVTvDA==	7	0phyKFzfD5pAaLyCF4UscF4g+frY6fnE
783	KX2BTbseK/YJDZZmEJg0JacAGLrZSR2tSOXRHcKv8zs0R7kn1yg30Q==	7	76rgbsq8IP/yW4gzyFTRoaCfWPIiy0Ju
784	Ka+TXX1KdfI5IVC9BK3vTNmFsqsRUj/yS7ORsJEaRnQuAf68Oo8iv0/qbMjryA03	7	Ktcu65I3KPm4xBKfgG1mGQ8wbZuBZ+MC
785	q+apiTeNvDALcwgXVEqkYxnh/nXOGptl90MO0b+reGpasHkeV1a7YQ==	7	1Sfgm/Bt8RGP4oPMlNcj2ScdQh+YhlJe
786	BbIt83W1TC7nAzMsXSIKKY5dEmHm0yERVEDZm3XFKjcreSwnQeV2mvYlemkekZkD	7	I9+MGDVwLCtvlnrkuuqEY5k9PFlrrAUv
787	a2zJ/WpylkQy6Ct8cAm1RinzfCQIms7+56uSgdcrT65yNjraktrcleFIJioQX8s3	7	mdMuuIyaxInG2szo3qt38AnuVhaTANX7
788	lMBtUmMZK0ov6kR5R0dwrukR/WbPq+MBPsQ5CO2vMw4R5tZGhx6GoIoHlzIz6K87	7	FXSTm7lbAdvcDmV8AUC6Hvsq1BSgRlME
789	cJ6taxsU1pvatXS+C+qYUyTqNBUrdgpgffW57l0B+x9BUU2gq6KUng==	7	OE3sOKSBs/Ze4U2TP4EJovyGGoEuid5T
790	NbbFNQeYZGsRMpVQymRpCY/VuyKOXH+xUByxQ6SKWho=	7	TeX0b7QDXbm8pOTlr/4FpvbTstBxgisp
791	nSxut+iKeZa+EaMKhN4G5nQMbEomolnKUzgpjn4FYzHYS3f2INQrLg==	7	olnrocQW9F4wyYs0FTjEsstpYcmvDnPm
792	tb18+A0Ydt1utWvItm/eJO7vGRPL6F+LUt9HnULynTeFzbCgK4WgVA==	7	FaIhp5vC2nWqlOs3QwO4Fu34MTq/sNHK
793	RSV02gIpgM+1Of0XQaXVMxjx1ppLnzb2fEBMxNvjI25kwDLv6msHPg==	7	sEEzWiU+1SbCWbfsjuWR3E7zuAiuQepI
794	iNiTzvz7kAZMNpcIy97qhNEt3ILLyIQHbZ59hTSOftmAkuEmXD+0SDOnGKaxh8/6	7	tXa0MaZQVPWRFbotoDkHxIPDrp/Bu30E
795	7nmyPCjKPM20kU5fw60ESEFv0r6EuLD4Wpe1rRyc4plVCKimVWtw8Q==	7	0aCX2z4aiou8n4jO0+jq/p3QfG8CJlFq
796	/MgQ0eOYGbGEDFij5mEhdLQw1NaT0eiiarh6Az07/p3fuN+6MQ3U9u0CJqKMWl4Du/D/6MEjzkI=	7	v30i0QBOAR8Dq3C2hg9xjwgbFizLzfav
797	R/ELnHPn4uZPvz1B2Dpl5jnxNc0OIGARN4rrUsine0LD7hQvAJLcOA==	7	GfPJTE+c3DeSe30+DTEonBVuFBfJhfyT
798	zzFkvmeJ7KDEt2KGowdc7WKhd/Zpma99McoxX/d4eJSbdq1HODonvQ==	7	nzXXBBPJCc1HoTa8vRzWyVSASRxRjy+R
799	q/y5sp7PwMSwRcMnvwoOcaLusMPlJwSnBw+EuPBvgswmWuFmcB8xOw==	7	Cy2ln120pouonQtDEq5pXXZ9zO/6xcAg
800	D0B8AlGXP8f+KiU430tcvLpPLzLdjSNimWTwRVIN1J4=	7	3tiLbqAipJVmExP95eha8FIqWQF5xPK5
801	TlaHU3JgbIYVrVdnnNnF/ofyJoheIzlJPR5kIsteYF4x/LOC2gtf63A5Plk8yutX	7	j234FK/nFVu+6RBXzcPyYGojOYVyzYnP
802	vqf7nIZFOPOmAkSpbp/7NBgNqHfI9kHWuZoZcC0kx/j7bNxHuomUrA==	7	r6EX79zAsqmX2AtI/ascosWvfW/+IZwT
803	P2I+/FXa8vIYJ51KgRm3huSP/0wwToPYDeLZYq/1n2JPZbzvLgZguw==	7	8umVKKOtxRogN6pN+S1YAgxk5fXWQwdI
804	MDCs4YRupOfts61fu2T0KH+HGBfl76lXvseuD7Osm0o=	7	sAh9NGZcBsBspZQQv5Vu1pryUEikvB+0
805	wOobZD1C7C9QnKcjZcPDRNm3QCTAU5t8+Fz8clmzDNGQAVvRPbHsaA==	7	gu9+xLVoBpUAzJ/cYJIocpqmU2X2GvKg
806	t9M8CDsphS9gOHVE6MJKam1lKQRCJ6pj6kiteeekmVg=	7	aePKg1Wd5Eq0b7otBoNBBIVF/Lk5fK/u
807	69p4vwNlvrxuWDW4uru/Deto52TQqtqv3w48ZcWavgQ=	7	KvECZ3xqAP3gz31DzjqyKAOE/iUVpR68
808	1HzWGHl5+LtXFQwOUfW72SOKawE98nUYuO2FkReasJ4DPmNh0EYY8Q==	7	FbuqqasLY8QsFcr/lbWvvTdvlGEj4LPn
809	MGfPafGWVLpq7chEOvyvRbpui7exNW/MjOtwBmuzoPs=	7	yDor3feXjIpPKaetENMkGiO/S068rMdT
810	wEnCAzxJACiMDMfUm7HD7LPBULxQso2rlsEC1Mm39ciGiFzOd23M1Q==	7	0dkIJVl9Hv0n+CLLkAw1zHNd3xqw3Nn4
811	MnE/QpFXX/J/xKsd+Gia6TB3M6VwhdDCBfqjHVeGNSGtpu4IiKpi/A==	7	qEKAN7w4FpOfxC6+PzA+TJC/8ik993uW
812	mPVwvlBNGxfHjgEGaVj+MeLx/VxlfZ32/jIbfEqOn/xWX43RDH/aXg==	7	o4vldluo5mnuJRC34xQs+p3zERMeu1tg
813	t1cTSvGwO5MLVEN/FFnnXnhMv+q12O17yfQ684hM//FA/J5Z96E9Zw==	7	oHZ+4ZFnk8hr52hKk+vZV4veMn3+QSx4
814	fzQkGcvKKUhhE7d8gRLbOLuaLqO/+H4h7BXtfhdjGhE3X8O1eNuTQA==	7	J4wjjOrvJJwCGEuYtSFFQ2lnQOxt+qCX
815	3LOEbk8cpxWEJoqKhYq/VNf5Sn3C4UdT6SgoH36fAOBoD1lO0jb54A==	7	rSeudz/eFEHN4w/gWD3Bz3Gviz2Zuv8W
816	mha1JMbYwcnjbvqWw/wOz2aTjx+dEUbTPwI6U2EDLVJTGnpXd8Wrhw==	7	uP7rmV2OJmBV59ZfoLihELM0CDEFiF4v
817	+jd94hpL/i1vO3IpITGHD7QCe1gduFcwwqEBU7+Y+t1AhLDEvja41A==	7	Wah0nrlcLV0/0qRuGyDtahssUlxl/rA/
818	qhW4JnkRbDH//Ttx8SlMy8bSolCuAAYsGq5dR5yRM8sv5VGE+MYc2jxJDeE3Yknx	7	1G/fjVJKYeZ79TW9ygVoqSriISsp0O7z
819	dNa4603sY54hbhstjt+lVbVfVaBflhX29v2O4aowQRt8xCfErSbovg==	7	8k8zseqMPGxUa4QHS1VSiji35zXsz/5H
820	HSjOE7LgsvFDOVQT0dAo5CF1l4DWIZNIvccNGcdtL063b95IHcL/S6ikRfcXCV5n	7	MvxIn1BMBg+WHXGjq7c9VrDsbCmzEjfZ
821	n2EhYGFBt+v3BQlYB7WMSYUsBmVtXbSUAhhmqD1Sk+yxXd3tRUawiWjE8wOPLAhf	7	iXItZqbWPBFlcMfO6M2osm1WoPtxXLAW
822	MrhNuuykW8Qyd2qsLDZakXhLNSn5aYanmyjlhjpHkQM=	7	f7NgeT5KGHTIFlZo9oHpj27GhZTMzutz
823	6IRCX596v3tCYUidanONtfJ/Qjm5ijugjHKRKhDir04BPc53IddHng==	7	QQjGwXEGR27edrXhlrYt1szNFqqvocyL
824	Nde3ctLmB167dCNvLCL/rtrOmRbvPIQKUPjqT10gOOo=	7	nc2XRCODmGm8ziePbGA2Qx8ys8KfUyHv
825	LwQ6gQ1Hoc5Y+bXkiwFwitGO1qNeuX+ZcCWc2FMymLsn7mAU/uwgBM9JmChtv2jO	7	+ENApCq72mtp/+QLi+3bC2heIc6mwrGd
826	ql+EeH6bBpEhjXZ0U0GwMVYxbaXzxFjEgTYuVN3FdLY=	7	OUshJUR1RQl4pUz/9ZAti8IUE0YxkMVF
827	tow/I6HmxRya9sqgqFj90NsLWypTj/20G20u4M3Lx496jL257ouD+Fb5vPRZc7jJ	7	PA1GKlzjT/BnYEt7Qb4mkyEQDSzYj9t5
828	gigDxofWmtmfw9y8SDNeHJy3jTkQEQdfvy1gvuSu5tc=	7	TC801I0TYTaJfitGEfOsf5oo9eOUBmWU
829	/NJ0sZ+A0VzJhsC3OQZqNyjNs1p0jQiYWtDwJCe0BaE=	7	nUp+g6t0ByD10wDjqmPeFzOG5+uN2hK5
830	uytfVTn06TzJbhgiideszGlLBMyqFSx2p2AVZK4A22Huyh1uiXxUzA==	7	EfKO14oZ/Cjn9/xtSacSkmwIwpVyheY7
831	/OVqxLEa65NDEinfnup0swimm2qlcH5jadoysoAGknL6/NR92QCC9A==	7	EEbIW+FbB3dZEp4fYKkytIUfCb4oAh9N
832	qBGiDvu+3ZLc87O4dwt5oRpuaMUn7pIh+lwmQQrWl/Pi+O+WMRiRZw==	7	enj71QEBoxYcxd6m4mKWkNsWztYM9Mzs
833	lQDwczuSNHQYJmnXqpJZvzPTenHwnULEHBZ5pFcyeEMMATpi4sqM9cBMQtfMCpky	7	mtVkQeHPF8VWShKyk2aDm1q+m4QYD7Pi
834	gFBHeKLJGzUQMQzXb3hiioaJwltZw2Q9bcBNLKk7+YZIdmAmdOUcJytQ9Xxjmsfw	7	yIcEx6aBB4/j8X4KLG+m3t5V/HFigdt+
835	RJe09VZSYq+XM2tOkSB6uXcAC9ZmBGXVokS2dw3KsRyiq5i8UinTL7okso5MkcOS	7	CAvAsj1Dq2Wv4FsiO53E154z41fmq1tO
836	SNzM4SpMMWBPTn8UNnWPjBpDZN8aMT5a7Yps1mvic8wVq45Utze0ag==	7	E1TEl2S/3XN0heOpW3tCvEPV/fXk+KxB
837	tVQmfm3oUrtzGDIXd0KUfBYpXnxIHWYSOBZSi87h4nY=	7	NvwVa4J5JGLLAldMldtouFxToHhA7uRS
838	N2rkiGSH23XdVPvJmTE4ZhFtAveKuewC0OSLhIYGknSbDzAnnuc6VHhjmOCpF9WI	7	4O7JgNEU7f+IsPYmifecnwGtEqXjkMT2
839	HjHzFSP0Bh/kaw9ATlKd1bXTbE3ZgK1BlcN9rTZCF5uzVfub/mE91w==	7	WgjKNvpkEgOkavBEOWyRRzUE9P75iuBk
840	octHkXzl3C/YMViXKZXNldWxfGblO6uXMr/ZJkKkfJo=	7	MxoCsnebeiQrfwJJaDW7IRRRNsk4gm/3
841	lUxKmSNbAHH3QlPwmPxTqCJWEB280nj8JDsXmLKYIcY0kMuU4Pwi19l/9SwqZ72m	7	Dy8yxVAIRn9JoyNt4S3y3J7/t5Q6mZcg
842	rRLBionjIPTV2QV78vKm4p3tKk1zGXzRDMb55HQDxhKnW9ERNs4+GQ==	7	8lcFku5kajp3l3jLurGWhGbfWwbcH2fQ
843	lXRbJ78tlS6pjZvzbR/JQXWndNKG4VlVr/j+7SuLBkLlwiekvmokqj1trHJmdlhnHXmdzztEmKU=	7	+1cwz0Mmvfon4BMqtKHugLmeSxp8ukNO
844	bgu5VA0afw8aneVQ5Mv0rDKo62fb7cRKC//2P8oIm39JQbmXRxjF9w==	7	AdAo3azqZWuIeEXqaVH7LJMdbp+TAGdO
845	xrYtkVfOKeqjvRL2nfWFOJeWrLmYaRAKqlN+OgO/y0YzsrBevD9lqJSJtmmrXCqB	7	KTfoXPSjtUDyTqHqZi6BzdCkV/NhhbEY
846	TZZhkWir5/Qh7alnnRP5NP8dJrXggWGm3Q9t4AznYTU=	7	Q6iwe9ceKuZkmHfAMMjucswhwbTNxZuD
847	OnetpkYn+Q9LuTMNDPcdsIDlie02IvN2WNEQJJQZYLg=	7	qsrXBjmEBcZ2fFnrgug+2tdFist15zOX
848	RF+9sPINZFLjp9szLonQMFos2naVaA7AA9l3GOeFhs6xpJuk9CQjwwFEXCsaIfuI	7	r3241nWTBZdZijGDgi2wPdA9MO74kAWU
849	ueDVb/WLFz7DnAjj/UqWo0WC2kGp5eCixKrANn8FIXHHzluIL4Je//4xi6IXqNsNQygQhwa51no=	7	VyB90OzM/Keeu0ZuCXoU2tTcHjo1YYyc
850	tqstuJn5FsURV2UEAPH/YmJYUXcuivePLMosvVi1Pv8xTQBTgBMzmQ==	7	wFddqU5ky566ZRIx3y9ZqZJleo/0H055
851	6ZJoKleamDLI49eRDrc/vFGzayGurccuuLwxd0tvEDXsufIZGasIIw==	7	5AqbgJ2ANyxIgJvIqAodMUhF+cP580aR
852	jhT96CYAohQCwhl2w8Ca1sQb5RnoKTIq6PUyWab0OiE=	7	fRhXpN6Rjn2aiYGj3KzhetmsESSmY5A4
853	rCGgvPm4cWWmFLEkU18XFWGoYKpoePY4Rqs1xlzHhW61yRGyGSn9tw==	7	UJZ1jJKMSK+UwDFSdk/fdlcVFGba7exs
854	/2hVn/BVMmbzz20ylCkDdAhx0kteOcf33BH/qOCOPp40fYgAAm0WfCVRU2DazOKQ	7	QQQk4XkY9+URFSvFXKQeJYj3vHVLjJfN
855	6YaJEnYweUZ/9BHg2o/MCThOijTB3DWh84v41zGa3rs=	7	1DvnW/P8A4IqZcEZfD++SUEeqwk7DEsM
856	KLWBmyH+UDwolKVwL1jRxDJmgYGuoY6nohgWN0CL4fUFTbI3Sy1pdtdEbiaCNhCu	7	Qfm09V0mC4+h9yaFz8r+mP/t0joTOyIX
857	Aq/j5V5mOc2tbgtSPtLpsdR9RKCpa1JUDFpO8LOrFpnxNC/+e7ERUw==	7	Zaatvc54yXCcSL/O/EGK5XiFSobqwA6s
858	KTBhyCbBqqIHjv8naFyk/2uuA6MywO3BEIHtEBUcdFfoKp9xd6ngGPzzy7pfrGjj	7	97F7CoI7nSbKxFkbRWF5XiDTd76g19AE
859	vNffMK8aGsZtrH5wC45T4WOwfirlIxU6sqzg/9q/15U1i3ltY/Pljw==	7	ho8v6yOevVhKFnfd65d9wJukvvJEV97W
860	yC2DXXyTgczPnCl8RAyQwup0Lbx9SvFD71/+efcPaVk59oxFTSDxSw==	7	JzDcAvJ2XTS464GTlNCVwzEa/9B5KorR
861	dXrZQOLYpR0GMNPS4arB8X3U+TOFvWRVfq0cR5tuNbM5fiainfrGQw==	7	QBpveVGy1XKP3CFmppQUnsQeHSlQchjR
862	S9sWnqc6hqe4bL05ugjTejGq2W7I/Hc0+G51OCIZuqs=	7	6t+iPzANhmwXzKypF/Gh2QlpM1eW5Kc5
863	H68KLu8PVY7AAjb7B5yK5X08pLekJl7VBsTUNS9b7fXDv9zuShPPBHpbqzSsIiijI2p/FkA6xTBf\nIO2I/Jv+hw==	7	50fUqdhqSOdlNh1847wPRSMOGTs8R7zj
864	KM2qL2vZ4eQG2VOpVWtUOrDRTc3lG5iZIl73hAw9iA9qsUP1My+4CzbQ/V8+qn9CCajTN+EiNFg=	7	ro7CNplA6q9gIURbb9ngKpHBnH3wvOSM
865	Q06d/goy14xgCCUrzMEQuZf7Y64DuWnfKLTg1bGygTVhsrj1v1IwnMvrKwGZWaBzVaSBbR7anUI=	7	w71CgOfS2hbq3LsruQ/y4QSrtmSd6CJW
866	vESbOlql7PHFmuVPqKkqUwZYH7/5Otjss/ZTdpsgoL4NMmN/V8LAXARKgUgpVD3iLti3+JPGQQTf\nON7fNkILUQ==	7	vdRHBGMHiYgslun6PFYxCRjSWgYzBegd
867	j+99HhvU6MkSkKQTWRIUX96GdIthZlZnOrI7Pxgo1OHjRhEnEppB5DruNoUGeqhLLDmcqqhjUgt5\n+dFdu0ANH7tZ9/CHS4W2	7	pLp56ci71oozhcNd0Jj5R96sQTEtfsDx
868	8HvipdeK762WoQkBu2P+u+T3vHLdNDHlpQCdsd6NyDPPsLvq3kYkpwmbE+xDpfBcZNTtjRsHuKM=	7	MHNnn+1fQMR97Q8MuvecNUCyPf1Z4mXf
869	tQewXX8Odt9SAOfFJjcL3wYdOfgwQ3a/ka/slvmjYckP3xH7lPWn1c+WTfyoHar+LjDS1zR+srbs\n3kkEPpKcuw==	7	fXWgELZq46E5N0m99qvTpl0XplA99nA6
870	yp5Ff3GLMteFPNzJvtSQSOmHyEqJI1WxZCfCbTYVK7Bge3qICqa4GuviWL9Sw5IY6Kapt7qWzOg=	7	EX00kTjbH2nnu8tD/twJoo5NC8Kzwpjk
871	H3ojzrZg4yMYFw+dRIrBlg4mPYLrwGNtS/MYJCgbT4mfMYk+VgLQHtl/7EMbsCee	7	jaOhOUXa2Tg9saiLJ8cTDfv7vljSMhB7
872	5zn+1ZCDj3nrsNjE6Zovbpc18Lp5cQjvN/VlNvbg9dv6VlFRHCsHIw==	7	kyhR4/oulVB18/0mMUO7iBfWRzhUKRbY
873	46YBfRUIJPu/ZL6gZLNil7VMtX9t1suay+GbxSAjgnhgI68bufrtFg==	7	ePPX2bK5vSjIdCIsz4I1yz+Iscsvd5f1
874	+rDCzLKeelq3I6uNyhw2pw5CiQ0uVC27Z9lYkjnZAh5kGrjniSKDgcyp4xArXy26JcLc/TSuaOA=	7	UJUxS4kukBXr/s0nZjk34W2rICneS8vA
875	hGMdsiLnKBsgzNlT/f9npiurlghQHwpj2VF1P0JEogk=	7	JTi+oJXUfaf83COX196f4Vz6MGqoha5c
876	PrqVzyZXNbXs9pOm3Aa5ZU6Wf3q7QCU6wA//hA1Oy2kBIp+zy4S8ae+YbVIuASkdnBVnlsL3mzo=	7	fckeYhILHt1AcxeTU/BhYwIrDSDl6wO0
877	B2Gjm+M+vuyYtcPYNRkz76nCPeWAs3dJaC1Ub+SmeTBcRlrbraDAuw==	7	eBUHwh9jjhzDF0pRZWdLQWN/5A9Gknd2
878	+MD10kKaZdapOW3u7LwW0zg0vaYRsmR+4ZJHBZxPTpA=	7	TwiBEIAg/QXnzOijwbbtY9/Ka/xCJ8e+
879	OPreLe0LYIHuZkvRfYJhdyPds6RrZoQkSMOckMC+UdbTZF/nnHnLkw==	7	0U85Rmr2ZUHOoTjhmJ4LgWJgTzsyp53i
880	FvumIWkdLbEMPIvab1DGi9Dog++UuHsuhRFD8oJZ13wa5oAmXWon1g==	7	1HhHr1IP8tkcCWKswQBZpIcbiBKfPT0L
881	XP0mS3OFooIu2XjIMInuDezfHpTS3XtqXY1pnmSojTsDcWAP+QyWZw==	7	uiD2D00P/TBumLAP2r0bE0aePJrTrbCR
882	K/sJYlhcjlqdrq4u+3mtF55GZULkXZFH0ayVN731eFpP/SxTW2B3EA==	7	H4J4yGOsMIPGamgS6hOW+Zx1GRo5lzXn
883	FRu2Jm2ezthUVA9D+hvtAD6x9iHrMex/L7ZQdm1JIZTXi2hVr4ZxqA==	7	sYe/8P28rfByIwAO3CurLNnCqsb2MdbG
884	GYXctHxbukuizDyLiNGFJXzjZ17+i2fZDa19XRTKNT91gCiunVEvmw==	7	qjBNPDsQAMvN8wT4M/pjuwGlOIbQuTWi
885	bIefrKGU051U6A+b/ExRXg7Z6Z3G7ltILTXr6/RIYNRbfaM1lztafGUwvRnz0wMk	7	W1Yob987kqaVg2G7tLCQqdw1iVhRsZW1
886	4A6cZj5txwR2bT8KuCy/h3ZD7BhoWbuotiJF+CilzGVHTqfUoJVBcg==	7	P+4TxUm2SgcT07G3RK1mwwUR84ts+DAY
887	YSpPD4nUjuDWLD+HxZMt0/QIxepSs6/7JRRCsOTGboo=	7	pepesndHzs/jSuWlnugzUluMI/Tb++3u
888	PNOor6nDU08iJ53FUoWS1tpBD5pkWmd9A9wxm1SVgeQ=	7	NaN4HEyuxjzfGTU5wiYIj246TxG5EV2f
889	9lzrCPTHN4fSlrnfXJDtNn3fasNnDis6sA/IHx8kBWKNSy0lhe1DTA==	7	LbP0BlbkgTLGuEx2yLMbNvLrhGbZ3c/4
890	LcAoB4DXx8Z37E1CAjtSesepCbs0rW54l9twnbW9GXLe2rfHBcwniA==	7	Wadhvm2TOIhuEZcMNsTCskNmp9LMMqd2
891	EaVeopwqMRrN1WJAK/0bYCNENm9e13vNVim4ewzXVP8bNxnWTyR0AA==	7	wVA2iZ2jaLeEw4B+7EUf+rWmmta7gA6K
892	8XB1jCNwlcZvEw6+oupYNXPoKdY75vEJBa+m+w34aQjPPsmLle2qRA==	7	rYpFv8xEpatKd5WeGgg2V+dW8gZbv4fj
893	LhLEWV6+p+3Bwl5Q6M2wpW+uLABUXh+6RPXrSD9dJFM=	7	jFpVMwbuTfvTiMvz/80g7j26GnGd1XEj
894	veqiklOLcpS6Le7Ueep94JcW4g6gnNM+rpMEYuqxoV6tPBsBIBfF8Q==	7	upkfk0CeKB8kSPqIO+Pf8Oas5ahcTOcf
895	zrFtidXer1VkEOg7UUA9o3rz6It+vFkuGoY22yKhssljHxPNYokZdg==	7	FQKkolsE+XMdCIOS1+S/aMnn9XsTiUbU
896	8vbD89BFXycALcp+HaIvnI094pEythzXitnReX7Vhst4vtXtoq4qgQ==	7	vOpu7Jc1JzUaph+c5hU7ITEUaB87YEsc
897	6VRHmFspULAPmdj3UXuX8pq/Vfm4koAq3KUaIk1p4Gt6UTcuymYbiQ==	7	UAEkA3fJWCxeHSs8YY03fdY+W1SI29Jy
898	dMBGZYcx/In/liygJG8DMHOyD+TP/kT3d+ei11zEzoV/ZEyb2pFFuw==	7	MSePDEArrt9Fqx5MXPSbWeGNr1SGRzRS
899	fxWgdCr6D5gylNjVP2Vp8fIrzinpSOfikK84PpL9a3o=	7	XYMDy6RsqXubJi8azadZ6aEpEHsBMYpV
900	JoT/KLVXkc78duiCjARcT93Sg1ChfeGW5i3DY6aztV+WYd8fnL1doPnwYV/DFfw2	7	WzUsXFvDdbFpb8h6Mefy3NMqgG9qnb/S
901	ddLzY4YUVHpre/eBSG7S36wdKOXKxa7yGa6H3xHIqorXdIuTJfhwiR6wzreBGMzn	7	o278fmFI3Zk1Q53eBHz4Nv+iXx6zsCrB
902	BxjETQNfOGRFxf73DCqY4pD7yo16dmb2eGuferniKzVvFVrQ2H33OCxFnyjBDe/l	7	gmb5K37KNgguTg8HP4iUec9PWoEdHDAm
903	eVNpfZhRvSbEPA7wJSoRKgfU4MWeckXOjhLgWg1EjwzbG4VsnCp1Jw==	7	0oB8uZN7O+Qs9zpurIYKm4PW9mlP+jUf
904	Tm8olkiLwyoTnidgNrTQtS+myv5whslppwcdNoV4uF5Q/4NJB+lV1hgLvt7sjJH3	7	tZ+f+3ulyML0wPSr8GJFuC9Uj+7BzEh7
905	e6lhiaYRNE9dvKwFud7oSq2WE2TbBPnZ3WBwj83TXB8=	7	vmEE/BeWMsBOoGFAdxmvdmmHBnqxAN1O
906	VxvZ9M51/x/9fPRMYCKRCpDVPFcd5/pkCSfhHiWKB3XncKomTLDWDKtMkWLSsTq4	7	72Sw79RRFllQEvm8zd0Czfp7X1C44/MX
907	qtOGHN28YeztqyLZmGexMVlVO95InhpTcYFKWLD0ayRsTbhJkxR5A1lWLIue33I4eIVlSp/sMOaS\nC7hG41+g4Vym/9amFtqH	7	kBdpGMp3rjhqww3KvnykhKrtpUNIvnVY
908	1gbAPA9H6dXrZhsJc7pJvYCKxOKIHrFAkKicBeG86kDPAIPgH9tnGralN85n72pd	7	XcA8xWwR3pOHUql37+TKbXvXJwpRonXS
909	8jkzywwDQkXtTM/e/8sus1FTf/2p+ofY3/XzwycXXZ43YMNxGifzpg==	7	huHGH6/SEA58oMOPEpV9tp2H/smvemn3
910	vSRtKbxTVQtGOgFWck+oErqNZ2et0I1ChnTf+ZqOIPSo+xgnN3SQZg==	7	7yxY0zFhPnmKxnF4fkwmgisa73GywLdq
911	4aEW7XNQdcwHhzakBdLOWT4CaTcojSYOz876zDuotP9Tzd8MCj6L5g==	7	xaKg3BIC2fH2yKY7AgMmjwrqajei0HpE
912	A2ch0KMBzRFdn0dCFVMNlWe8TnZ0T9qyxY0qePSYMBzW9WB+HM/65ap5mEQEzcAG	7	q5/63TAFFtcfU2WZ5vTzcTcAl6rGPdrK
913	FDVoke4t22rgk8GylZMAV2SfK6dcsKGjFc8xmoIBcwQ69m242aWIUQ==	7	0wxfr4keUWCvpEVoPRCBWYAyxTsn338T
914	WO8NZXkXgdCm8isSo2Ds/sDFGJ1QbEkPh9r+mjaUHtWoxJxj+pSe1vHDntxwQcQuanabGG1c7Dw=	7	FA2ZSITEybVG25+6CJ8WMPi1TdnNLakb
915	BSH2Lq6noNbv2O4DS/KZpQiP/+JqIHaUfGXfPQe9D1yho/sB//lSYP4rudIfB05hDurlhs1a+Cs=	7	VzXBaosGIbgnnszULzGi/yg3hPLp4aYV
916	McCEcihl1t36ERkfN+KPi2zLekoOHlLG1OO+6egJM692rnxoM4rtvyLZqze+oGV0JixfW0SnTJk=	7	J/lpLuTysduGYt8GrRWmIldirzMWJW62
917	zrTc3ip/vQgRVctajab+nZih9Ucs2hYA0LURDfPTXGsV8Pt5hLsthWI4Tnzv0a/2	7	FuivD50h5lWlxDLEjj/6195uueEybF/1
918	U1TLerBGkXDjX49TaxYR64NoE+tdVU5PtdS4STWeZuB+L9YvxesCfj4VCTyBfdqdI/HC+x3+vPk=	7	gtSz39WTsGdU96T0JNm7mHDJsbxQT4uF
919	lGPXHuzfmprNcbxkRLW5A4GBfsO4LZhZsEJy6BcYSqVb6/DNGMOalA==	7	XlyDuXr/MBoE8lks78fCnA+KjYB2vp1x
920	/huoMhaGrjqnMz9F7XL0BsTXZc7wAw6AQJ0Z9r9oq5hkn8KYoxKZZbkBBBYlYVdmtJiRbP2kiJZt\nbOqQe1Tfqi+Xl+G7pSy7	7	z7xV2CnTNQDudKDrKmy0F1b3buPWW4WP
921	NvOs4J7lcnJv4DfvGZA7GzFI5YPawC6JZEqe6bD6p3BBJxjnqWOrer303l/SVsVfuznBGBERlia6\n5FGZXpPpD8RZSQPH1urz	7	2JdeVQjdxU/8miogE4dOE6bb4+4NHbuL
922	bI7rV/LuPsnLA0RQ+QRm4sHVD4ArmmI76qNFu+UMly/IVsmuyyQkgexfAeLoetuK	7	FmbKYpK/84AdwuBLFkl+7vRdMIcBB9zV
923	HTiQw/9ySQPubZfJEZGtLu+HWSr4Ql2fbGvDiNsEs4mAF9cqUQccODCKiD9yb7iy	7	QCl/6ZW1Oplt4/SwRuCgbssPAt4s6oEb
924	6RGJuaF93YUWKR8bsND5Os6xPwLbBJClI5brA0mi/sFwsz4F6vSOLc7Ga/C0aMR2	7	1OrOvBo6SAhz9X9I2YIN+jcppsXO/UrC
925	+1g+Kug52khWPZoJA+3hIdaM0wyy74bMhBm0Tn70H44=	7	rZ+ziXwiISwMgSWLcrpvwIQmv7pPELzd
926	PGBAvZVfaY3NiAQxNEV/OQp0AEAQg0LM1oR/Pz6H7DnBEcrqmeasx/jBRTJMfjKnfOYDShVZRjM=	7	sN+kgmt6wgaDkiHn2/WEvI2cIWJl/VeZ
927	FRbSjFKcaDi45XK8n7F/91mGPhIhJH9J1JrcM1F8Js6jU+wqz9h+0w==	7	ejUJrrgzeAmAG0WOvSnlCe0WxftpVkdz
928	VwDhEr0XNf/urO6xODYckXDbGZsMkwjNCnxFhd4gSoTWIJgIV0LAkOeS4zmQ4rOcA++kt4JiPpU=	7	N7QsxPM3KV7o6YoGCKzU4hvWDqOWgRMP
929	ReS+g21Yew5GdFpRD/CdlhhLPEIUAAad99YAjuOLpJFgIwCSXditONn1RS1vJE8ETemaFgsUhkvi\nB54+OEDQY011qAha0oKt	7	nq2yEEyTThtm9S2pDVWSyfI/0TwwDHZH
930	zO9lgLMtO/2OabXA7yBspb0WGwa00bpVqq1hXJCrwFw=	1	YTW5IKlnncOgpYV+M6u0P0CW1R2s2Jo4
931	C9Tu3hZB5v9G8cx3raRexDLVpRzEwJbfkOkaf/Aew8HKncVZ0bNZ9eeVyRXKou6E	1	OWyyZAMzzCkXvNoyl9Rj6EgggnGBE/Y6
932	ZOIBp4CHs3GDLa4sOMrKocuaEzMiXetyl8bhLjXsDOLpN+uS8wTfleZD7HIiQ+2JQ9RZoQdmwto=	1	YFFbkXc2UilGBCUZfmB9Zjxyjaokm9UJ
933	I4d091932ilnZiHZoIxVMJopt2Umz92y6SdTXGEc4kotW80ufB/PSqITwP+VVrKB	1	Bw0AIIAzB7luclC1mAVQ19pcNHPh760o
934	wQx+fT7+oEq9i7vse4s159KO75t/ULi3rbYS6XjLbkyE26Xd/sLezNckhpAlWnKIRSrewvL0Mjk=	1	OcEj3Wzp2BE90nADqGNiSEpBq7ukntL5
935	GOmZws54ZKLH2VfEePIdx54ScfvY4cl+4o/kVjSxU9e3Mwdl4ue5BhVZdxlhz3QJ	1	3Py38aEOT299n/U3rd5PQ8Z2zY21Wnzh
936	65jbrzfxZ6Zx62E4qPCImXFPsAVa8IrkASVgd3O2Tls=	1	kYF95iupTKpPpLUUq3KKM3AM7hySCvVk
937	5krlMYvIzkMcoN6Ci93ebpGwNJgR26d94vspRP+YwTd3Dny3sWPaOGWL7uE8V4RG	1	6rMNHtLB8BOr5E6H9X/cDHX+2XZFz7sK
938	KCz6w1/iEmPHPJflz/d3PF8o6DgTCTATIxAXxNr/m1z5ghgsQfZBMA==	1	56kSpp6gsFtsGc688AmnjDRcqDv/B6Sk
939	2NgkfvCDmett4uciOC2sOHVA0XsPYrDDDBEF47yvdlNAiFqkIwHk8eOoFT7alksbOI3vQcV6LYk=	1	F/ADzbq2Cfd1KjmQ0n/P2y68k+4JZa8y
940	tQEIVKqLxhtkfXbwyQBQQAxWw2aRJpbgN+BJ4eBZ6Vmu0n01SowJ6Q==	1	uCCnQOeTT7DNLoKrjkpcH6nz0ym/5NR+
941	URPJb5qPtaHRZubaHCzdY3nv4LhQ+gyvQN00IsEMOS4rWSDeMiXO1A==	1	TLi4qplWzw+8GzAlCAes8/5a+gcUsrhW
942	nP0P3oykKedYHCGkrws+ILN2KtDg5NpKo2Y7ZkpC7PbfKsq413cCLAaMeji7m1Kp4HXFrvX7h6U=	1	8ph69KnSeaWxVu3HCF/qZBBQZvYJEi/p
943	Xb0N4+cguzTgG7D1hCLWlh45Jd4KxkaylsW1ueJ3PJDioaYB8Ijvug==	1	U+fuLJto9ibTw40scXFRyzkw/NKqOqL4
944	oenKe5USrLPZLkvo1E1nmAYLWFrVO4a7YAKJJ+8orm8QbqIUBHOVrf1sQVVlqliI	1	HrFH1ilsQgnq+BRZtGxTdu7B6ZMIInA/
945	JmSPYpio0y/t7Ej3zb+B4L0wlua/NNnazeeCqnE+pMvzH+mSDashDWv9aib8VOrv	1	Ko+4YvcQGmjytD9ERqY7O8maj6fOmevf
946	YU1wuKBub8rrG5AQ9wMxnHoktVA8BA7oKTxqoRxhFc7W3MxFJ5XoUQ==	1	WUB7cNczjPgKsKvuR2Bzd5aKSY63EBq4
947	10Qmf2oVRSKULct2hInXXpH4qmIgynWlJWt2dTAppvc=	1	1soKH5g2owrUbSvbtUtNYc9id3Y+u4hN
948	WYTvX1JIPVd/z0rd3VQvtddR9lFUorK096sdtCR+Y8w=	1	0ilqMTsx9ZODXthIO4FZad73LWKcRUWL
949	q8o3MNxlvrBt6tqJLJEay7BO2fYgQV6MXve8xxSWif8/68xzRpdmvg==	1	7wp1qWeSEqNwXjMukzZTKVbhqiz3+l6I
950	ydX2WrT4kmyEBCJZDCJllLJdR+DGyQPKGorDK6Pur6A=	1	wtIjie5kPYdQZjlCixNniZG2n3TYoplR
951	nIwC7D23MXLS1cFrdEQD9RWmcoMKJQJXZp2Y9zyEu5woeBekrqEM98HoPoHwiJi7DpmcpwSSIZxo\nLYUctKz+AA==	1	MXrFhp6+EBwt1Y0JD7coFbN+eCZPCs2/
952	jiFnh88RbqIFehXzuPEGMoSKIn+K18S+se1ui+mTTtDiAhk01giBrw==	1	HjM8OanGUU1bESlTxrAWnF0AaIV2ovn9
953	aOMOo2ynmnDYD5jzDazce2rE9V8Ibegz18QmB2UrR0OguO9nHEwFtoY5ImaUVDAj	1	Rg2Z++QlFGJ9bWeckfI545v8KNEc1LiL
954	h52wYSb8K6JaB19DM/phNdkN90HsKjgXqRNy0kCqZVFvkU3Tiq9cLQ==	1	C0zZ1WGxZdb4ZMM8c0wpDkBatdoMxv/O
955	HFjg/c0+KMfcnBpAZco71Lbik6wQ3Q7/NgXHRHXAo7Q=	1	gudQ7/l/QysPwWeEFfA0MvDOB5UaPnHR
956	WS8W4wj7t+titV9hl+9pcuVsmcPqW9n3AK5LpcHNDDR1kYudmV0tjQ==	1	I2KKY9kkNGEirpkGnyFdr5jLsnN48her
957	l2LXx/euBmjZoBo5e6685lOmFygIjbx06aaZfNJJDI1ZHUB4eNo/aEO+f8SL1Jqy	1	o2xzXlix365MtDaPKPnWaAwVrF+kLD6Z
958	tYBd4GkneqgJUEs/QW+8QgbysM+etzPFFFdgaLdMIpLhVsI+8nrN/A==	1	bF6yvLf0Rz6wjRp8TkF1ZMrVUA+FAop5
959	i4eF3VmoKtDEG+dR6AUJvnzFSZbm/EBHgw3as4b/w8U1o0MekdnkqxsopuADwMLx	1	ejRhH/XdgCGT3v1XqvHB3jUA+RZJGQBL
960	TIqtqn90HqTUAbbNmzZS1qNXQPJ4aVo5XUl2jkWTxl99yvLz50kqnN5QkQroCqt1	1	ISDpcUOQ2GBzOV5SILAFy/2K+9gCBxMB
961	23g63oPDF6Ka63PxhxL+0CwA4/anJ21cccyu+to7FpRVCY+/n2GHWg==	1	HzCSAr0fKkLWVqWAT3XhOEuuvkGBIZ1M
962	qQ6+cEoMR0JkvoQcKgSGHJIjGL3jCZALu0+iddAXKpq9UiYbI2Bp/Q==	1	+6xgnfb5uzTMwnxxdRZFmjdDVAB3fWpw
963	3Lj+8s3SzNLuTImbr0qMYW0A/Gm4JWQSxNnvyytXcoE9r2Y6iaLAMx1pYTyF+Hf5	1	gKC3MmItk3qaluU1SuiloytmHPWJOV3A
964	d0S22evrp56YyUzcePQblT+fXx/T0tc6vBgyFpAz1xhslmUpd3Nr0Q==	1	SYLfx3kjVH9PWjf6zJ0Fg046yIcNXpIu
965	PLdNJNvjWPrqoj0dpEXhgwAZP8j1zwfT3e+S7ODk/b87ehQHWHYOPQ==	1	ag2BxrqMuNmyA9SXdizcQBopnHCvvPxq
966	DQ9kulcGKwyx2NdId0I6wFHf+r8qdzIkWBADUDxiQBo=	1	lFRErwpQrdFpicRVftC3EtdyZ/A953fq
967	7Jm3zoLWLfG2lZQ3PH/qNwrNm7elJT/qjzyWuwgFSHeojFH/RJVBVA==	1	Z4MpYFbNPx/qzMYVDTVh2RQNV20CXGC9
968	W988viOnA7zOApfJXD0TMl2UKyo12r2P7Zuej9f1vH67P1/k6QZcfm10aZcvDIxv	11	i6meJPCVv2/S70eSuIJzWP/aWNTHoXOR
969	U6EtkBpf/v/CWiWRo8LxWMpNHX8fARwMKxr8YVqgnP5THhO2FMS5Zg==	11	LOSCJL0eIREGy5vnm5kwqy8dO1siGztG
970	4hyALsRaZWJy3B6kju9kt21Ufks08GwHaBXCQelRAuZE+gsJoxXBug==	11	60koeNtJ35HYO3fp0EvwLYz3Z9/wOUTz
971	RC/B/y2wOgdi0ZBO36Mo3YWf1kCzyTAvXc2Zx/5G9p4EO4HtneLlog==	11	wT5VqLbYZif//icaJXjYGkoRAfkNkZuy
972	CllLNlli8/raodBpQZ5TK9Yv3gpYyGhjKbhC4BSBN7/h3t8/1nu+Yw==	11	GpUEh5Yt0b1OXGoKc18d/39QXS2EYSQ0
973	Kj1+vIlSKayAuw/YAfCdqA1ielRSWW3UFhwcMRZqs3MIFygM8cZMJw==	11	bA/W5nZvz1rbho/XsqAJk3gZtnh6vzzi
974	43oFXDW8ytS2hADjlg61XtU1m2IR08NQoZJnxOkjDkInfmPXFn4D0w==	11	Kjg+4YO25ipT905gQePf9LNwwzAdgOLe
975	T70S0X7BIsmO6ZkHRPiBOzVyLUFRGKlvaz8HbRyLMxWut+2nJbIk0g==	11	b7+1fwGDz/2J6386O/hig3UfG2dZofaq
976	ggCgi5Pdx0mZuHuQZOwxcZOZSvkuPUa74FgBoRQc+qs=	11	hRBPmASSv9LVzpdygTnq5pWhvw0vlJXj
977	oPmjdoSEk6FowrdhmRdDjTIKh2zcW/01MeN9thI9/Kg=	4	kNvPjhZ+W3RowNheelU2DwAT6TGtIamn
978	k+6F5YqNqiWlohnIl29qAecfrZ7pFJIlDSnK/Zuw+tHLjf8o2RmnXg==	4	5yJWbESDcvdUmmxKlwPFyIBLGKdtZtq8
979	XdQXN3aiM7RcSlX9PA6qAeM8omCgx3p195F9OVllRZKkliFE4hb2EBJygTuyZEaJo+fhwtkDoDA=	4	WprTPf8FTGedHxJlxWEqlhh+sgdGaRHx
980	jmdKUG2DSy0T2VDq3sel6lDV5gjZo0EUpcmO7pZmT9Y=	4	NesGN08YT+GnmcWN4a0GjEKoo/KiixSm
981	YLNmc/LEzel9Z5OdPQn4IAGUn5f01/AgDXdVUkCgEfk=	4	4Av97Eux5HgHrWJqCRY+sIaAPA87qVlr
982	yk+05JEmOdUcyBjucZdnnaiJSQhupPLw7uJku7vvwAVM1EAh2US6cA==	4	QTq0jcDRQ6h6k2Qm26T8m1EgAUmqcy6H
983	FdIWARRP/Bg3rE9C/rYQIJ/69vmbfWUpLQgdJS0h8vF/lkj1FF4ObA==	4	pqe+ifb7X1IkhheyCxJkG+b2qyVsrSZR
984	rOpB3XGCHt6m/SZQ5zKx3wBF1o6tWKkk8dVcdPLWWLZ3Z9/WGUw5mqjVDqL3idDA	4	h8R5N6+km7K+J0OOna/4f7tITQC/oqm1
985	SXllWqHU8m067QnGiWBsxr90MkifY/hJ182XIc6SPxVQVDZysHAMjQ==	4	MgHr2Jt2WoKCNM1kTYdnPXuAJ1vtre1h
986	M+oLuunwuwNC6IAh2C3zek8TzbLrGg9VOvBl3hg1HOQ=	4	eD0Iz7T6s54NP2r7jwbZTfC2iQPCt9vD
987	0dv+O1V0sLjLB5uknMyHTeEM07dG73gyqRrySfZXkEFmbna57HET3w==	4	CIDKSZCEzy1g2uGUg3plCFNU/60/bHQK
988	gB5ztTS4GVTPRnxctuY/jnfPHt5PU3ZV5jsW6ugN9xjwCKPasQkQKQ==	4	jQ9dEQge0m0RUEk0knnBXVHpjjfhthud
989	Aqn8RS/CI0BbRv2tjLmraPNBh5OYCKOv+LlnqkptmII=	4	KNikVCu8nhe2paG6hoq8Z50V0lHufuKf
990	C/yWvffs4Sv/I+GGDdWpBCptIA3ulXwHo0QuBn+QI1LdnF0shuuX+g==	4	A8Pa8M1PCMDtldg0OrW8vFtus2207TGJ
991	sag+CG2AuOwF0EEhvxC2dV2LXT9aXt4qBji+Hw8Ko+JNWW4d6A5naA==	4	2EBbmMEE6mVd5pjmntPGh5ZygVt/vG65
992	Sv8jbgLnErFqbmZX2dHEvIBWGe+M/5Pq20xJ4NYNtG0iKBx/h7Lczg==	4	2aSn1Hsp8/3LaMFFaWkymXU7OBO3Zksk
993	zYooPo3r5MVR2Hu8BRxqJcMAWpLmrXkPW9j/WgnPq1tyojXWLyQliZF6/viQQ/wW	4	2h6NtNH0A6/me1fVGY9kBRPTg9d3S+1E
994	lSc+07PIktW/x1YU+MUG9sNBahmM0cW/swjItebnBH2WKhjAFaxL3Q==	4	poMvBJzo21pwgTfZzkaewfLP1laIx4/l
995	8yVxV9zecZKSnce3HJXsDhPI3euk4t7Mhs+LU1Fp10gLpHVhX/UKvg==	4	2yT0wojf5XRTcYl1iVAv13QN61AUW0HY
996	xUKWLHg9IUXyjdNne09znWS3LrWEBTdBLFJY5nRmcsWN6hIvdMhfAk+I6yef54fX	4	NtuQslTZ2w2O6rs3Eh34ftVlhjagaG+A
997	aXgDJ5hVDkD35G1XN+XFCs5Ql0T9psry4G8rdY9cmOE=	4	Ccl+8BAg3XOL9E5tBC/Ps2pK+lBbrHDm
998	Cc4YCN+z0YxU7/DJ9TmJthku1ns32e3lCwp1OOJMdXlPPqBbws/h9vUSv3+lY+5Z	4	fQUI690E7k2vPPMuXJjxgPV+/HeRsvDj
999	GjuNWKOhSrO6i09V1dhBDbAwL4Qg6LS3PrJisRKgLLsjWMD8XzXuFA==	4	QASudtineU5blD1IIz5rgazdHAEvneAK
1000	uBAWWPmedrDLaQemG+iNd6h7JDOzkawWIDBfApd46KhlQ2V3VDFlwiJt3Zb9ElVG	4	JcOWdjN4oAypRNUlA0FVjYo2Z/AuZZiZ
1001	Fgo2hZgVLYirF1vj3jwoXRnq0tJaFtFW3UFjsmlhESM=	4	kByVuGFN4WAEf2z7NUUduLMU6AjcVh8O
1002	k20hfbiV3xSeNH1e0WT06wlluenU0VbWDQ+hNV3cPw1Pt2ESzKkKUlDgDYkn0T4b	4	G2lufCxvXLQPOu0dhR29l0F5T2C/nd5b
1003	dXaYoTWCGljeRISfXqJoq1yCdK3zTNCq2bDIaBD8v35HFx2KxDIsvg==	4	US1jL5np4W6lEAhyh6DNspw0v7f40ffR
1004	8qtrbgVO4ZIXv4BOyIIkJEGwMte4l6lYq0DQQHjuuiJ9Yaf709pH4g==	4	AzqrNjcDImVXYmCdWLHPmD9Y0clAFB9K
1005	DgqPXH0EZyu3u1Geyd/zWmMLAVxS/0mMPQiDsdEePYStrQJWrq2KxQ==	4	Lev8MnmfvzHEdhv2RPHeaQLNBrU6apPo
1006	3WKEAOYAnw44JGP/7FC+q1eOJQ0Kq4zGu7MK0h7A8owUqyYNIuvPrcPmepwofpyn	4	GZaIP24HPL2l21QtFyAe03GgjLZx7Bio
1007	1u4ChQM/K7PFOClIOTCayD98izrbVNVIXJ3Amy5kefE=	4	iQzKjPhyidmeyZfxv7YNsovgV1Ws3Drz
1008	DM4PlX6C1gKSapvCb/rWzeY9E7+u1H5Tq1l+5BZYcN0/tViF86kz3eWUZjRe2x04	4	vKFieSed679ZQd/nkSRgv0XpZxJJW5Wy
1009	vsp0lnZKvxkN4MoXa1DNsircnyVOEu0CE0UJVkI1TyY=	4	/5ioSNtMFrE4jyvY2BrU7Swe4eD99S2Q
1010	ShJ3r+KzqL5FN6wmH9MlkvH3EgrHbD3c22RtvMVehx/GPHILWwhspA==	4	jqQBDPRWF3MoTTms1mfkrb73ImwTaOBP
1011	6z+WSjAYnDVWKxMuo7JWF9kHGe1dtAwAkNVYoJtTklA=	4	LpYGU01CTIQw0xankvAGDLaIRtKD7zJL
1012	RwbcYMQDOSmbsXl0zvxBsExTP2gW6/+mCBEIDh51FiU=	4	n5HlTNugDNPHyP7evTNiTQMA+kmRnDv3
1013	6e5Es2BglL3k9yHCIeBAKOSUEQf78ZOiS+D1I4JqSg7rl5x4fn7PriIpNwOt+hD5	4	0mNh5uxcpbndwOT0WWchKfEXyQzCz+AO
1014	LUahhFrYR9y6H87ZrD/lbadUQesVLHJjKhWNmDhFdv2qEqMbuhEKq9JJWxRW6L41	4	rq8TU+K6fObBLRq2G6EGHyyKh83gvWE5
1015	yNLNkH6zOlIFHYXMTZ53WW43vP4L9a/eYPE+4F5liuHT/1iM/vCU1Q==	4	G+2SKgx9MwoqitUY+9Od2obwhwXwsyTW
1016	25cwgBww3aUoAWjViRN/x/qYHcCS8vxQA3ZXLCnlA6LtgJby49mh/w==	4	Xyepqz8IPjH+Vdxfa3ElV+2zmWUPjkY9
1017	ynP8xHNEfyGSvIXQTdkVu41gfe89wfsR7jMDTSPN6jD2MDHRHT6BZqe/7bLCL9ds	4	yW69A8NT/IcoP76j3DJEH+QigC7ASEiJ
1018	ES/V+HHq2254/W3VtSM8YL4hf+l/Xq4qMuR5PUq3eY0=	4	fo+Ozf+KgMXxDx6mlpe2I5XHF14qSmPl
1019	Y1RrlUMc0WgsRl27P1Of3ISSXCHGM/HQwASr+QDO4uDeAkY3QSXwZyt7OHTm6La3FrCM/WpgGFc=	4	a501FSuQQmx2529rHgCF6f6CmDBuVVaF
1020	eHnK0O6hJu4nl/8gAlcW4a6ln/ucHuWd4e6CC+mkWhdJ9hQ6xSqc9E4tStkHJeb1	4	g6Fw21YyMnZhjiKCIs3rKVHX0UOaVjdP
1021	bHpw2qGLKe3Xgchlwd2u0ODT4tylbH7S3YKD0E3h5rPK1IkubTOSD/JLTRY2XOV/	4	3vdf8ZNQQK88Fc7Wh/Y2kUPHyyR464WK
1022	vu2j2gWKmrPegh1W5PuOteryARlKgqRi5seAWJ6Se/AwP6rfIQNKAg==	4	53EgF80l07XJJSWmg2/Ghs4KtcA9iu3v
1023	NI/meGQrw0z/jP1j0+JKrOwEg5AWp7S1CdCogjv4NnU=	4	KVh+OiP1rysB87qxyxH6UuiCQG/JLFeH
1024	aM6FAvIVNsIjzJqvxIwBWERKPOyj4I3+OWz6ymxxlbVdExyWLJThyQaPz7SDnTa2YSFMmemSTYs=	4	ZYHxTwKerzMH6DItewVBcXfLP7SHAxYK
1025	hdBxzLpVthZrAoea/d2Fugw5z2AyJ0k1/BTmNqnc4eU3DlqirtSK13EuM/NtBe6Q	4	tq+G5TQvwZdqgu0qdPQix5JhbF1172X1
1026	7IQJ/oQGILAvd5QLgLp1zWzrtGxsU5oDx075Yp/epf0=	4	WEu9wEPHATIj3WtJpOnLWVCWmSAUgD4V
1027	umsgh4x//MXuDg9y6ixIkcEjXNVFuvxNXFswn09q+2vSM8vygDoOuA==	4	TEcL4UvjdjhMSg4ZIHZ+6fdVZOjpVX03
1028	uR7J5QlEv3y5OVm8bJsfUlr1GfZW1u1skZXAFReCfSajHmwk1OMO1A==	4	iH9lqaDkMP5Vm6Lpv26/qqxCeXXT5ekS
1029	cqoW8KMmw9lRnF/lWQGhCNzQ6sX4Wk53aYJJCV/zOnQuqMe1Tp4r4A==	4	fnTi3+Iv7drv/0RUO77ibJUtrR9T6SUG
1030	c8LrAr4uPszJMBYgfvL6gqGsYpu8KNHbcjXHGByI7iIi6R2jdreYRZ46MYFUe366	4	yyvHYic8Fy2ZTONhN3ubGtpP1UwigeP3
1031	pHdti95bePNzhm+PkfUGZOAyIoEhID7H0HrQkAHyE3aKvlqCGms6cQ==	4	5ihyRG2gBFxaegp4nK0+bXAkbc7HFotq
1032	UBnaX0jnH74SAs/skcOOfYkrYL7Gs/72TvCIiI7KIi1MsQ4Aor9u2w==	4	A2MDA5y9zEPQpB7vinkR9EFSctJQWlUz
1033	0aeDMAVLbMJex5S9ioN7hIdwJM+OnR3U6tFrzm0LxpmUKCO88GmGAw==	4	mcg69gCwS2nGM6rXWyMp/p2fxrVHxBqr
1034	9GKhYuJUebUexnCZbeaQoadgHFedFoRnJ75mCBA7X0qqpVXjMBwtdw==	4	z5ZIgrr50UQM4rdA6BRNzbLWQOyhw+qE
1035	9V9aYrhO7wd8Dr9npG49wgJ42SNHgpMmycVvgyibwxmv7xg09/uYEA==	4	TxmSDrN6Owo7JGHCJcSgrlQ02CLaPMgO
1036	a97GqyErYR49BHjggXl1R3sHT6omjuqQ2ZWeidq94bqnsC6fKlUUkA==	4	u2L6bUn05wuH/MpmOR4LdX1psYy0UHLq
1037	lgUFKinhADTEwUhXp4P3lKyNxoOxCZowmmZIL4jkuCY=	4	qJtwb2ERqOBbsg2NyTA5BchiIhaL6lBD
1038	Om+qo5oqUZW2pSnB0wQfKBoGqhvnbRXNCT/QLCQ4TS/NDUsh1UGMUg==	4	qGe/kVsNAxwI6WV11deuYRcTL+qZyzGp
1039	9MI13OcskDQ5DZemXg3rpqwE9cYrbZRH1QTTnWnWeAk=	4	fOfZ9bbf3NWi7cxrOjdYNyx7p1zgUDNY
1040	5frnT6Z57tRYo7VFuCpMIOyj9nFsCGKzdYF0hGmryZM=	4	2UXHADomLbwysEnzismcnFlizba0Z59e
1041	Yd5wp3joFSxmNtzhbycqvH9YQlh7XQ1/VplVpQboqeQJ/46NJv2Prw==	4	uJfUI7Cr7tpPmiOLhWTG1j/j0T3TMljv
1042	H/aGDOpVAR7fwHOQY2Ta7LBmSRrsjcYyyceDxitP/KTjHjX77UID7g==	4	bmMzkrEm3j/Fv1nJXuo+noJ+oAlhJB0a
1043	FGFauHjKT9/uLalzZwiIe+uEyj+i6POVnbSh79v17gSNkHPtw2xWJw==	4	FYWNToRT4kytcIr1wGmL9OIAGnepIu8D
1044	kqT3FAQfZ2U9kqVM6XLoPsTJr9VAfiHc6ANCOgZTMcFesnBZZz6S6Q==	4	cUTNS83tKWV2DLc/2bZ16M6xUcCZvDX/
1045	y/6lt/R6QsYIUuLadqd7Ld43Cga4L9/nKeGvkbwHs4Qhsn3k4nD+WA==	4	sF4LLYSgmupQ+Cbpo4lR8UM+1SmeadrP
1046	hL6kLoKWsRg+7YLqq/1ppOUoQ7cupgJ9ZWKM8OSQ+fFTcWAMpK5eMQl0sKlnPJfs	4	YClD/xfxPuAtae0z7znv84lwjr4VDV6G
1047	J1ky/59q0u+af+80L625v88STlIH75li6bI2Sje6LHKInROWNlP9aOYCjzGA8khn	4	wGZtVEBZfXZGC5PodqWTGnlqJUI+Tnvi
1048	XvXU7KhPNKRlAKwdwE+AE2FkBs+RJrwq5icFLXoMqVOp09H2wbwSnQ==	4	tlSntECPQgdxgPRH+hXgI6F8fn+mthFJ
1049	s+0cWZya+p0bo6oCUFYZ2oRC8Q4PUHne0k9KvsIj2+WC7L4gidV13A==	4	h7X2XfikgBhI2fwIctUk/79uEXsXED2l
1050	u2PumZC4VvMmWf030QrJPUcp6wdmuxKt2iU55yTk8BuVJbHKP4B1Dw==	4	q7Mxi+Hx4iNWRz5Em0isTt2Frig6OMs3
1051	EDYnzgsXNNZFrVL+QVb2GhIcXxGjRFHpnpKEMmf7Z+RS9T7qvmwOAA==	4	tHtFr3OHd7/FfzBIVj4GP7aE4JzUU6bj
1052	lsAnbsV2PHgYqbWToA86vTITl5roOo1IyluhHJWiorg=	4	lELcuacx44PXUnyp4XiyGbOQpCesFqdg
1053	KTKMJXhnZxp4leDpYV6UM2tf5LHbrVr9zVHYI/D5ANYWz0PKZ8NrxQ==	4	Ok3uhTFJHq6L35dfPp4kjIfN/nvMoLrZ
1054	VDPYccMSNtBs5kUdYf+/+Dy+nhJSTprldy009k40yJ/KY7Urg9FV0w==	4	TSGhB7MTSDjGTAMqDJKKXkH5sj8p/wPv
1055	wS/CZb5/jURiCigEHRBY0xUMMZYWODtlMAD0yC53KmKQqiALw89Plrm2u/BMJfu1	4	bfeLJGnxd1OxQux5icEL05EqSR/5/8oC
1056	jLOnaSOeySCZ2oMprDIv7ZA0xJkJiiJ1Z4a9mgV444htv4eQ82noTV01nAo99nqZ	4	YNYWqLVTXnySZ1I/azM5cW/2rX3OyEFa
1057	aChPSgDyivH6VKTdE+YxMQIwl4b4F7dqa9NKpvDAAxln0m5TaOAkPg==	4	ivKVNVD3EfsGhbemcHc1ZJ456J1sfjAQ
1058	dmIfIY294IpeFZWs34F1CdKPKxa2Rqil0TlVYGBA7X9FIpMLA4hvUqWirmpCMCBP	4	igyKM0pcWmfs6bP1pD5Q2bmZq1RLkFbp
1059	kzXHgzHmoyVGXnRKOQMitsjCExQJzQSee4zP3Mp8sTm2TwLXUGopkdDRZ8fv8Vvr	4	24K7mjdiAvOnpPClVTAlA7imGRhRpu56
1060	iVKuYKCngWQ5azAFoOHE6nDptOHfYI3MZBNeTygXi88=	4	y7aPOPFu7X10t+NieB5mws5CHM7RjQ3h
1061	jnw7IpMv72jUY92bQcYvU5D/2J60tp7rBXN1mkvHmkr/ZhHS8Q8t7gCnPf2jqVbp	4	Ru23XsmN9juiEhR5y0SB9CkipR8H00Ia
1062	xucgYSmn7QB2xtEBYfu2Sxg3j8K1KBvqGM6BC7XDq/gohQlWae2gYw==	4	vqIaBKagFmvHHNfCXHflBl0bAdNK+UNj
1063	rUUdhaApoS8s58BWV62lzThe/osbNH/W44ElIoymMQXessuRQd9+Kg==	4	DO/vJjteiqw2I0wTlyx1j5G0KSHXd4hL
1064	bWVoak+k2t43ogv5My0+uf9SIlccKJJk3qefJ0wqx5B6Slt0fAKZKw==	4	o9NvrjQTTswyYFVtTHnvi3cjxwgZN9og
1065	dhE273XFsa1QN0hKihVWJ6dQ6Zyq2JbSGKcv3J0umyI=	4	GwX3ZP/C4bez+rDazgMHFcFMrqhE9PPp
1066	iApc3lE+adfcmXApvCcjRPpOYPUsfusNcu32xDre08ycQsA6LxdaKA==	4	qcBWUjL6Falqx624r+b4oIR+wS9FCfN/
1067	QwjG5/VhuerEJjmHuxls74j78gU2h+IT5xPRBhUHV48=	4	V+i3LNQjamPA7hOJczjUW0aY+TLHJ8e7
1068	UIKzXa/9P2SuDJMzexvldCZbkqiafWBAEqpSEWi9n9k0f364aHldxw==	4	UDNSHKuF2PgZfhEE3018yon/LbEXk9P+
1069	+Lh2CsUr7ftPp65n4fC1uKwcznzBsJw09/v7TANVpgacXRrZ3o6mxg==	4	wXVkedmchEUEEZaJbT5QbcnXUbQx2x1v
1070	yNps/uXM8AJo9NhXClQ0yoVErTpqfa+rds0f+4EjYOw=	4	Ghhj4lAux9BVpytuj5t0idC/apxhAInt
1071	Jy14QgrZLFaCy3/YQQZDTzJNb2TvyIXhD6SoKNqgXGL1+EY7hmtysg==	4	QP+VlTb5hWYZnRLOmFPNGmc87rgIHKUx
1072	w6uLZIaaApmSnOVB+cyCfEuotF8DY+eZOFanuzVAp+PMNP+oN8BeLw==	4	/DScpy3tPHMSSsHcoieyVeBRI+zmGxXP
1073	x9jT/lWhN4iX6nORScHUAk2kA7StbK9j/0FVzwX1Ggw=	4	8/10Fh/UwgfUZijLFXnEeJR5IYe10amp
1074	NM8RzXbMN2mfrAi6TkdcwnceKGawLicPDdN5HP6MAE8J09QhHO+5JQ==	4	Jsp00tSMAeC0TdTqP/B4yzFGfbYv/9Bh
1075	OhJy0qLg6YGuRnJVGjgBoBdLj1OmQ7ATGtX8ZbHh4NlWdh/EbUa62A==	4	LOP6fgoz2x7jyIgGeu7tHusKZ/9sxx44
1076	We/j3iYof739XJvqB/bYyAekCBnr/wYuagmbcmXx3lb3av4HQA/uug==	4	a2iGqkkEFNrpbxRBPufAFowdPlv76lPw
1077	vudFdxTx4T9OBIA/AaHHtSiHyOdLdoKVLODZJDVXcqHuOFGZey9HeQ==	4	r+oirDxybe6K10Rjwy2ziHVR71m8HWKo
1078	1HfZInfMetRQjQu7wxMlWm5mwMr5iqXHjqwt3X9iQCjgtKOdqEXcMKzMFExpBEH2	4	eY9CgarhoHiiEHOR9OZmtN8dfEDE9MDy
1079	x5HiZUo7v8iL7W7ceZ0mUjGdUgXqcskj4GSp/Yh7rJZbpECWBbf6juFu8dtyi0cZc7S/N2EqWb4=	4	k2+2TY718ibMoBs7rW/Tad9K9pJiKwoZ
1080	JbG5Ks0yt6JgHGUE0MvWI3MLMds6YdJ3e20W+zObnQAlf3VXp0sJoy/6ByPMK5zF	4	oUQRZ5/OjStRRtBbP78vEHnmv1QQ/rKw
1081	xIoyUfNGh00OUy3UVFxdDWWIxY1hXg9vqQIvTzdRJY2IIzQTdDJ0Qs7WMaLnGTbL	4	MfPR3QukdIUdBgdVBKi1IlMdbDUoh2Kc
1082	QXlCoyHrVui0dqq7mX4KxIM6xQHZ3IzYzP6Vo/0k+kcZw0v+vzkbp39YJbMq+A7vXGEvdiLNGHc=	4	biwkXhT3ZBb0dBxnAlPqFamvELgRK/a3
1083	Bb6CyA08lF/Kk2UJgMemyz9bzN2jcyVSKE7xc20EOOs2CX349jJ5kDZl1qDuqjjK	4	aLHOYkDaknFqCXTs/I8wavAsLTL5ric4
1084	AkY0OQeGNDOTYl+iX6WHLUB93TTOz5d7My5F5Ad2Zw8ZYTwX+fb8UQ==	4	9/6c8RjbgXv7tUlx027MzD5Eig2Pzyi1
1085	LcXUR798KCxJAP5vetAF6AersZZRcA4Fr9tw8JdsmwwPfzWLtsakyucjngrItC2O	4	8iRYwez7prfr+q0mPYI9xnRAnkAWzRNU
1086	R249CEi8Z5X5+QOUHEVUVmyLXDTvS3rabGy9dytznEgM/A5K4mr13MWNnjLifrGVvTLKsqk/qqU=	4	ZB/R8QC1QifQU1UzKAWwKhNwZ7WGUXbF
1087	NR7XJMneL0bdPEqMvPFfhtlrJxref3v7O3aecJCKWo/0/WdQDE+QezfIX8Vn553f	4	E4nySTik7lNlUM/h4vx3wvZhhuuJwf4x
1088	yNoy1XEfRzdc55zVzunmqKBb7mFcnt0jOgI4nxNNH9Oz3x2iDtUlmnuzZXzvIhe/	4	OdXz/qlu4hZ/eiQszE11DnK7/Y/g8VZk
1089	knWEgkHDZdfthV/qsefW3vSuHyIrnszMh/4dJd5QHxNfr2SlkyExkg==	4	JEJZkGmhuyYXg1HRKP8QP7WR7M1ppjsf
1090	rIvRn2P+DPIqioXUwCYUbIP9nbD4b+z3EEJo+8aREOHf++IzlGfl2Z+ixwOUcvvt	4	zBMBi7fIYiQXVMEWlK1kN1eCQo8hOTlg
1091	pUKSQGJ74GOUuyPuSHfgO/pd6YtDC9RHHVUAnsKoIj761zBEZ+JI1w==	4	46KTRy3Bf7oWa0fdQIaO8yc0p9KgoqlS
1092	gxVFeYpePZFm2Ki013ehnf1Qs6zcXuQ7KfNkWXG9DWE=	4	+rwD56WWMk1YUFsZ9zbOXs5OZtmNRhMA
1093	nyWChNkQLf9Yc+OXND+O18dDX8qWg5az2qod9TemPEU=	4	Riqge4+86baWLZOyrN7TMHgHC1LBvWMT
1094	DLKF+CYxxYZrjCBoXg9Qp3p48KHlYwPMxuppFc77hnbkjXhVVagPGA==	4	zTBeFNy4c4cpyd51mYHtmMR/MEqPkHEi
1095	nRoZsMStkTYdrh1/VWcli9Q0seWB1W6oDw0OHq/D0Z0=	4	mQ835HYzOWI3Dwl8JpqolDRhim21W7fO
1096	hIijpApZmQxX8kLbV+Zi1sJBYGWtG45qdqM9sxiI43Fh5ZaIT8HG7l/R5E+nWSnlRgmQ+vMGbgQ=	4	3h7zpAjX4Q3HkHL6f3Dp9N0qnY++44Pm
1097	QYiFCyHaxZCdx5AGHqMfczBpYQMZyZLnUEtPk7AcjgXNfH/jIPtJRULn9SOhIkEI	4	cGAtxTorQc+byid42LOYkhVL/sCvwhpH
1098	8T5W5ug1zRBE7sH2/yYQiaVL54FAbVbmPF62yAUgP/U=	4	6OenpSFR4tJGy9jdWNOqjdHIfFvoAqOM
1099	e9MUDgRkZcVDxOkzDeQQa7LuQjV03kHrxAKHInI7he/JnF97dRpJdQ==	4	Bt1V2J4tdQ/MiMzCLFpp68DCrzzCEa1O
1100	SrX6mRMpMfrGXwOpRYjcGtZootspU7Fk0jh4aiUfAZQS9NDZO1W9xYLkCCHCdg7stJPoM9EeK70=	4	HuoP15AOvnDm3l/PZos/tyGS8icjzZy7
1101	Qjr7yL2bbw4xMuWqRnx1Rg87aqj0Uw0LbeAH0VYDdhIqz906BsOQ3IkfISqraDlt7O0Z0h1J4nc=	4	DNwtgPHEBKSSEyBLaWifeEJQT6lyN/hG
1102	DCtDqJ90oSPYi1/Ai2o34fMMgf+YqnYTmrpbvmEJxVx1KMk5TbAqN/re2cnugPFo	4	LhprJ6uRBjgG5xnOh8fFRPKuRC+UaQrC
1103	g93xeRtpNKNrIbkJejg5ISaBPtjKKPCUgMrgLNc/SOlePKvq3+fZpJdntZeyk744	4	ILgvPsepkk3xZTK4rYgUTUhdnZDk+nk6
1104	Q7NQvysAD58iY4WAfe8osuIdZxu5KDJRU1ZscZuSCAPN64iO8kurOCmQwpV7eyi/	4	4bdL3wfR0o3A3Yx0hD9LwqxT/DBbUb2S
1105	Wbt39jdD7LrgIt8zpQtc6nx5/cgTGbP7RwxabhTWoZM=	4	fw6isUNzWSEmyGoMP/O/EI8rHKkektnY
1106	HUbm8UrbYpqIa+EOlc7uwyyW30Sdla1T/3/IoHfHJRWY1RPXhnCw2g==	4	dPOwCtu/LdpJuoq4qnI3EtIO7yM7hqSh
1107	p0m8a4pKkcHJsW5h6Z1Xhr0J0TNb7g09ke3O6315mxTtj+cRQ7hrU9oz4iyJDrxp	4	AXYHDBOBzkI5aDF7mvnCBKlDBwnLzn4+
1108	B/MLbvvsSyjyse7MZYYTqbW166D044oXpEXkq5+FjFtQv5uSZUK9Gg==	4	zqZnO/A/tT2GPAmgBsoFl+3UpWkerNgR
1109	SBGeb4IRLQ0Akdb7MPAxB5JPiInsX8GYw487pqTeNXIT9nP280q90vCcJe1rITx9	4	1uZ36D2d8zORlTM2tMy0J/RBCqnNlF6O
1110	nL+zlQOrSaWduuxOVw0DLZXzwHCDFFAdjo6OplkCwMoPQSkB4T7RWYtRPaQgCoqh	4	RHuqTGLfCS8VdYVnlFebnta1fm2daOKq
1111	4PkyK/0QvFdeq1nhlHPm03vbaOo9CkSvQdKDWzHf6jk/zvVGgWHs74/oz5j6yuIn14LR6Nffw3M=	4	o+anuCoyEGA+8iymnIiElh8NHg823X81
1112	UQfLW6bpeGG1ywGNSltYjbFfeAl70YKnf0D9Mgsnn+bTAcIBdfr4nQ==	4	G2T0yG7D0ftos06Q36d1hQ8sB/9Qvj03
1113	hvhsq6LlPRTk+qW/Dy3Q2ec0qQfquXSDFAkz2S6a+sssfulYgFpCM2wl1PzKvHIDMBM/0EeHMluK\nh0bo9PmxdQ==	4	qc4mEai+WrjvUJN90Lhk8+Ex71cRPo3V
1114	YbIh3ufBMvYevf8r7NmfP1oQpePSQCz35oFvyEyM/43Ksnb5zvQTP0ve3Ra3mh43oejyc+Xg3Mg=	4	3Vd0H3r9WI7UBa6H2WOLjJf3jc+Mj4Bc
1115	WSW12wJFAqQS1zvLVGKN0koxEsj7cpfr/btEp9LwInv6oMVaJnUTyQ==	4	xfV3am8gbJiKfVHaJJISG/O4HuYZ6Kk6
1116	JVOCKpGNk241DLlRcUPjymFUuU6yCrY/a1DOdMu/A5yQ9GhBPvNOEg==	4	BDhfKZaPyTkuhjKG1Hsym5x6W2DpZU8X
1117	7pTXbi47j/z3nxycV+NH1lrL05oK0Y8eLZwl4TQQyMYIpyJYYRBU/TDu2eP6F+8F	4	Oz76wP/hcyjscoNObPlw0AkZ6J/FQTEj
1118	3dGttUlIIdPoYhbniPGT2+g6NYeXBdzf51e9IaqUqfnkQBJE08w//MYhLYLLNI1a7TO/gparCpVd\nzvoPAiIhXzOPimKnjx6+nv/ao8AJg9U=	4	HUZzdu/BDPr1EsUoZDfaPHvuik1WhsAq
1119	eROpauPZFDQTBC1eZH3OZZbRi0QIa8yY+QyrNZw2VLd7xaCrADuSKA==	4	rUpd+v6+EnYqrzGzMkFuSfq1pUHHV/C/
1120	sY1BUtzJ6WZeNERYzp6/6kApGqgH7SXk0s+BVYoRcAgWl1ETkU+UXQ==	4	DEE9s+gCOZioXu38GrEC2SACi/2CU/Io
1121	oHpKlucnFlv8uwO8VXfYdGXS20US9mToi9Ftgf5M6D0ydx8migQG9g==	4	Oa2i01va7piEb2mPSO6X+mK1ieuTlJeJ
1122	6D8bMc/Fx4SsbhLj9zWdMLt7QKTQDHF2X6NEWuhmqxmmj+HnrfBIPQ==	13	OmC8g4FBxUnMIQLlCYHin5BJYjSvc5CB
1123	Iveti77+OEgwdfqLKw/HTRIazMxL1t5ZC3jsYaQXphmWCQtKdI2llBR/TD0tPayZ	13	SfRYe84jmblUbUzPTEU+mU5cbDfveBEe
1124	mbVUZHpG7vzU+HdufB39sFnPa/kZ2XTpmSjDOpLlhyg=	13	/h1aSZI3JxPqAgGr8cv9oEarHfSpm35n
1125	aOkr7SEESekrjV4ICB+IE3yd6Of5dD6Pqsc1AEZohfjxM10+dK5XQA==	13	X5hWyvPZDkqOGZWCglN9UxmgmU72AjCK
1126	6oGyyEzI15R4RiMwEZ5BdiDSXiCqYiBTHMqvLXkxaa9y6HaMRm7G/pKwj0EHCgBSMv9Nc2KQd5M=	13	pUZB3joDcEiRfQ4HWN+LtRScxWxdGe2z
1127	RMWisUvvG0li1RAc4smJRoe3fL5S3Gw8tUBNx1otblfMElS/1aOJVtWeBo6fMxAVSzhNZ9PNwEg=	13	lVj6yNFN4HaJT8pFFF0lOWhEPDH89bFh
1128	OXDa78ukaoeA1wa28re/P89M7IcSQN2g+lVqGUNwZ0Eh7EOkZj18OQ==	13	FQ4/WnobIy3JI0lkrH5RELgBpMNgd2AL
1129	p4Vy5l5pj7ZFjLpOrxBT5tYLlOj5c5aIz+j0XU7Fhw91bFqfiyPRJcSNUsOdtgbY	13	6QRZ8Z7cZxKlz6cRWkoHicVwMIrnmwUE
1130	C77y8W4w/I9YRm03OuHRMFhkfvRJXWxv	13	igtrDBjLDss9w8yZ6KOn9PAmdvS0Qy4V
1131	OPogW93RsL47NF8m2e1kWB/uq2wn04MMFOFvT6s3bDowWIfU4m4v/Q==	13	VonsNPrD3aT8C77Fr2zwKQPtvOWRQqcF
1132	KZI3l09vkYYr4C32h5l3EyKqHKD4PVd1NgjA2pgIjBtFm+TKi6bSig==	13	G279jem85lGpzSEAHvZzOAzeXXlsKQKX
1133	pcdR5/gwOi5W60bn6iQBD9T9LL2ILZhm1JHFgzTGgnCxbrIL+PqeHg==	13	QhkVjBWhiWQGdpd0XxgkkGazMJllgtJD
1134	ZfrC+9qvYGxCH6DyML0Z8oBkrzT1Zw5LJ2QP28jrAyVX9moSiUtJPg==	13	1UDJLY4/AAf3uW3ItF58YCYaCVhpURTM
1135	jrBAp3/XEch9X+s3zwBUeQQemFVPLtP0H5U2Onv/6PKKNBPUKS6dE2OcwbbBoouisVA7W/04jXA=	13	XSTR/Bqx6DspPGmEGBCCpDz5tnEqBrAs
1136	CoWLATlrzG1qnMApg5XslpRyedudi+dh1FHGcz9/R6w=	13	FN6EEI2XhSbAPNucFndSh3ctGSdK3xJ7
1137	8TCXQKh7GFOd56iqZdjA9H6C18oHTM2t0kahB5j+VCh9ZXpZoOn26GWRmdq0eh3rAnLPcQRjiAs=	13	fJY1IbVvx4AF8G10yCcMAEq4NC3lvrQr
1138	5TFwuZXBqlNggvAfixJTLKgzv6e4fMCFOGDVkjEyc+VqbPKGDZPi8Z4MEJcV/BhJrpnFBceRrUY=	13	AQ5MyHfkzFOo8OXlXxbgVNdKMZLnwoCV
1139	dji9Nrq+lfTZW5fujNFhvtjHKgB8vI3qNwK4RXssTWrTwUjJ/a9iaQ==	13	gVzszBMW8/NRPEf1koXwJ0ff3emnwV37
1140	L2/EWotvrydQ89U6ul/mflrMp108P15o4B4W7U0QN+w1igIhXW4cqQ==	13	hXSfw6857b2NnMrJKB7cn1slScPJOvRL
1141	s64hmdxHkP4iXjCYSaN8HYSKRnyzfJnHdzeRDdJZcCNu46x+MeENNA==	13	AVE/BnGKt8s7jp3zl0fyw4zQDKXVQmnS
1142	NsNWGErxmVJW5cp0OIll0XwveL1B9dQT3txKfTe8JjQPQNgq0sCmqA==	13	f5FVx3QnI+Jzu1gMINhTxVtD6hgsbjpd
1143	cEJYBlfweE2WyaKQR8NoiUgkQL8vcSI+rsJkpiEYrIU=	13	CbZb4kwNpvOU2T1zG39S/ICfAroIexhs
1144	SuzpBWWq+b34wxByh+Er1uRUkJKMRBxeOFV83usOoFGz2UO/XojGDbvVe86DM5o3	13	4NXjd1XM4Fdoe2CyppY86wt3nLoLW25t
1145	FjR5dRinUfQ0d9gSOpUuWR1UqP0SD7U+BMOG36aZ78qfdo7NA1gIIw==	13	t4TBCJIAaFNFWVEbmNa4BIgwF2pwO+ui
1146	2EFTL5RClmp9VE7KtN/+5jNx0dAybhfUDvZIZdoq8ODbKN6iMqGN3A==	13	TGZrl6L42HyU21ohrIZs5HX+uy8mm8z1
1147	IHAGo4ONrfRgOs9QuXjhJhH+KSze7ZfMEjfABossnywNDJgGzWe8ew==	13	Gx7bxLGfREGw8lEnIxrSHmBk3h9RwMK/
1148	XkyQGl1vkuxcRzFKVVS2eFhBeheBkgaiAOgkvtnzzyqgX9ag99IhnA==	13	UBfbVaLgV3Y2XFoXnAqXIaxlHjJ7vGEA
1149	LMsg1PaBaQw09waAYa8MAvs5jYPoY7sYbytzOz9rzqG1/hX2qybbow==	13	nOr8+gC7kpCLsa8fccYdNLX2Psyvt58J
1150	edfJfSicDAfv2dWVz1VfVquboq5363ycjSfeGJeuX7/0K5Pzjzpogw==	13	k8RLs7BXR7B8/RsA6e7H24+t+sIPn7IN
1151	3BYIIp5q6Qa/DD6I7M+3wdcX30k2tZQVw+Q/xSyFzdUpG9gv+0Yr0Q==	13	U8LZYZg7BTAO0PgPJhC3Sy6F+fYBuYrb
1152	kBhfuhuL4e9z/6FJpl7X/eRcIjmsKsWNhF2qgWXmlu8=	13	bFFmrfk4AxJZzMhgyeQUfd1Gq+yD8hL+
1153	E40X9jKid9c7XkGyA0Eu5ZmOdelpvhXqTX8x6263hYg=	13	D+c579B1b1TV1EpPy982WsmrEW3E4C4L
1154	BWcqz6hsPNlqc9K74U1FxjyXTGZkhIokGyMXqTnB4RY=	13	jNpgfgIr6QuQMLU8qZTuZY+5EBr93zIE
1155	JgNGsmUeqKN4PkZZWT/st4ywb8+QpZ4Nh5CwgeQA6HgLLHAWp/cviw==	13	DsfaoTVpDAmngX1GY+MH37wS2TCipRgA
1156	rmgBXNRiH5tPNMtWITxArFS+Sao+eshj5JtuNWJHcYM=	13	YQg7rJfblhIewXkIAe4NDN/SckbOHcgZ
1157	5BSdd8OPKnYgXdq+cHZ2cRDGr62sEa2hwbDDUtvZXAzqA87mjb6m5A==	13	99IhNp4VhQU4dsD4UhXZJWSSuyQNI5hg
1158	BiDpaUCeYDF3t0J7RCN4FLsx0u8pOspoQECCiDYf9uCqPtPU2t/amw==	13	PrJu1x+7ZUbD3dOERkyzHnJLbvFVC4IT
1159	tXtcPS+X544rbp/RnXFIIhNqvHNoSaiCL1oyI4bg8Cc3tIhZpK+PH3EE9dTq5aCl	13	W15op5JV1LPgENVQl6ocR3d9BJuqwBQ2
1160	zql1dpOtU5Ru6NLJkNRJWe3Kv1DR/fyDxC9iAYRei0g=	13	EtjHuejgUeCLUN+Y1cF72iC6AELbVnWM
1161	KPmQzHLdQeIuSQD3z5bELSJdTo5DvxE3kODJi0LTb5hB1dFdVR8/84MHMhUQQj0e	13	sDHzxQEWnyQOR6vLjHO7nXdJF3GdfGtV
1162	8OOnCvvv8PVwJxI08guYhRqzGkV56sfhyHR5MiHM0kzjiL34Z7TC0b8JkkG1YVbRk5j3VzXPpaQ=	13	jieVv++4PwDNkZGxyqZepD4NG3ubGKGO
1163	REVCFl1l7BpqlN8T8rKAwu/4rCHjSRD5XTc6d10tC40VO/2xZ0pANtz2KoyYsVxB	13	09dm3GP9MBiGQ/E97Yjt5JoTMAl/XGqu
1164	4KOkIQWHIrtzqFf3ncXgpUWhNF5m5K6tZVACo5/c87TPjUOqA/+CZ3dvCM74673eVsCw+u9e0+5T\nuKibEh7CDQ==	13	Eajzhvo6YGZLnMUzd6zWd2/bbS1VhwCi
1165	OKWLSpYMLTyr/w0NsmCPBpdexsDz/QxCZYF5uqv+y8zPVrCUmQibUg==	13	cTMPD0XVQjNjkP5y63EecPeEv+RPbduB
1166	o7/vfKXBc2Zn/kWMqg6yGweRlVGwW81wlzQLPHSSRDRMU9ad/W1sI0YjvwTCuKGi4M3pxWQfMAo=	13	uEu6e+lVMbF5OCjATGdSHiTFCCNik333
1167	cCRKbl41Bukcdd8Zcg8jWPDc7nUPCDlu6QeWSuI1ZFUC+vC0aU2Ht/N0As0JuSg3	13	V5Vpj5OzAYCMOruxc7i5EIKZ2HC5vhzK
1168	3QAscj0mEo0GS4FXAwL+YoQ5UFx4cOqF1xFsko5EmPEaOVcTPIbPp0/s27Zw430a	13	2meITqvk2IUXO0HZPSOLFwo+EC0Dz5t8
1169	DYzSl4mdI8hM/JkQbgTzU4h1TcGHxNZ7wMDOsXzbIbgpoSq0dQki7A==	13	BsdJjW1Us7JVTmoAS4tBvny6pzilUYVN
1170	W2HZx6Vnp2bap8g7y8XIw9PP8v5O5/y+JPWHV/LWeGbg62v2DjxMAI1d6mLNRXBP	13	bMarKkwC3XQQAWwAbllPEoAls7ea2QfF
1171	aRKQIyUL82qn71ggs6KOut8M80rAv1400pIw250nDBiBSM02YhxTrFb2zIpRR4mV	13	VlCCJwBA0FF7OT9oHxi/3tSJaj7ZrWRJ
1172	h4BFrEH8fKhJqGRgIqVVToFjKVNeMGRbRDRrta+P70DUwBXw/ipqa07aIY8R2kJT	13	9k/U/6k532OKu10J6eBTS7NXqMELiljL
1173	OpyGZX73vEIbaQuhQhvfYsKRWEpUxra1RsR61YPmRA42sypIHeYyrg==	13	q+gi3RbAz+z2lsp01Tk+byJInW6v8ZbL
1174	M1kNkSbreijqVm5IZHzzPGcov6G+4KxTODH6cxW/+VmPcwKBnfoHTpepOvCVzIyn	13	9xh4NbiFytCsFNoXiclQ3FFUpdJHlINP
1175	iY0ICOhdv46w2+pESSKMtXbGqAMER1y9uY7O5/gjohL8P9/myxDJU+UhLHsERGFa	13	IV9iiCVAeeICn86jxW1Urd4bP7GGa4U/
1176	PVO2vy2gEKNHHevRXvhPciatSj5JVOaAAhdLtHsYjtSPNlreeKUp9/SgMsipbHjl60L0EJAAa2Y=	13	ZV3Z9cZodHL4GwJLYDmMdRKPbCISoV80
1177	EBJ4uUlOZ39WOvFAE9qe9RKxFtZe3eDtUguSMMg57GOJa0chUueen2P0yBlNxo99	13	43iwawgMGg9dI5G/ypuu7JjobkJPSEST
1178	Y1lm39U0YUO4Tq+KBCCNxbRNP+vs9JflOC7zKfxH+xMuzqo0nC/fPDAbq3Y9N5BY	13	9ZspeZB8IjHbqy6CaX00rTPgCj3mbbUj
1179	Fn4dJJz2utya3o4AYHLDAjJLohV4U/2RN7gSNULu65S0GLo+pJx1SQ==	13	EG46c+4XPbZrohCR2pXHpjtYwhUKn54d
1180	wWa/ALxNv/WUsQN8ou4LS3CQ4ZQcQfzPLX/TTkSTo0K/Zas9lvPW9Q==	13	uqxyZ1JdYN9CySF+a+oX6jceFKdY97y9
1181	OuSd7Pv5iBmbEiVCD1VDTZOYXRnBnDrWxZSN5VMEHsf213gPD+IQXQ==	13	/5SgiKavPPpTPQAEyWWicS9I2EngrRVs
1182	g8gq4g2PGgpcKFxheeKBX1k/1U0TYo/a2XGBPk4V2b+875jp6+qSfw==	13	otl0v7M8L0N3eW2thAFr5yHpJ/SPh9wF
1183	yt70DEeu4ttLBKwWSES++VfoSpNb4Vq0VGgohaSS4n9HBox0AilFK9GBuDUCu+yS	13	ZzuN6q1osrKlDD7b410Xq6FmeqHkRraK
1184	GUbnQq0OOsQX+lddnyGUv9MYtvTXkbZx0+gQkKw90bU=	13	dOzJ9r1rf2XFALYLhQYMY24lQ4ObZiEi
1185	/vup65y43AlvL9bkU8JdNAObs4624V/ZiOCqbRu1or/tMIbj7CpKWA==	13	gZ9kyYnESQCxN6FJWEtbvINcU+arnT0M
1186	wRzXBesNBZ4tdEwNmwHTVkhcp4+vfpvmuOG1gZY3NFVj+3zg0pBK4w==	13	OkjrGl2D1klv1XXq3+ICEAdqdnIpTOzC
1187	u4sXOog9UhdWZhEj2FL5LCO4YXyOoSYbF/5xSmRzIsiONNk7SzX5iA==	13	LPU/fmebZRpvXtK0MEW/KuxIvfLroSZ8
1188	s4/AkOtss7lNlu4nMKWmin1JAY9yRfklEKSshID25HQ=	13	/CLPp1ce2Xf1fGxptI1e1Z0zFvihYq3Q
1189	jCVGAHEQ+ea6sXdmcZXqyVXpBsDc372+DuxFWhXxsBTLqTrf15s15FLJNKUv6LQY	13	4l8oOQ8f9xggGDk8pEpMp5erByyCsaiH
1190	Dc68DQJgnG8F7JfkI+SjPcldPy6eOO17GJ73ryrkci4En3XHnJl69S4Fk5CrhPvlJrT/YGaTW0E=	13	jvo7PMLqedB9SRi7VavwPQ+sl7XOoxt2
1191	t9O+zQZ84TpQvY5RfjE/U300O6idoXYsSrLhZlijcPKvh5F3MsLdXTUK80BMuqyoHEQWf1MdbQk=	13	BCyH9YyRVEN3ddV78cPXYZTlGJNZ+nri
1192	PRA2pysWyOaeuKGVpnv1saVCGCwvdkwuD+hj69adOTDp51bYyYAbCKV1eYWwblJi	13	N5DUzw0W/Vd9bB/9giKzuQrU6KnySd+H
1193	+FgeIRJ/q1sHMibq8DAu/fjVJSvrrMK1G4yKlTLfbfdDXc6rDmkJ2Qvgm5Djb2Ky	13	j45kxz66EQtZEm9rKriiXv2Wr4OxVcu/
1194	tQsLvPGJ8ho5YcnqCVQVlp9JRAAFeI/bs1aKv8llqkrN09OlfdgIxvYgMU4a+ujY	13	bXAn2NfzGBuGidsjOHO0gxmcZAVGZIej
1195	B6KkxDJVXU4YJyW5at+g46CfB1sLJTL8icw2BSHlTeekX6Njsv9jiA==	13	qWr1n5Vn43/ciRI2FM3L+lpQ3PPKht2l
1196	HPOeri+zsijsTLPg1KXNHvctz/iOGeIU+ucNZ1po+kFLJiwwPjtISIimPqVYshkA	13	QTakZFeD/o7ibaaLx2BW1nR9udik2N4j
1197	FVf//uea0Ud9uzsanN38znvvG7tJ5kZBclwv1nlfQnIsHxUJi+rMFfvv7hjP6rQYXYfS3jIAYK8=	13	LxYjTGUdrf5CwuTerYoYPUHedhZlkJoj
1198	IvocdgQd4fTcpZfbgBQBfVntNZ3tFasHmzK63XjQY/g5GXcby4qTxA==	13	jOApwdXIRs6Z5kikZdzGO8iisiHCip2K
1199	gz33G+ShiJ/vae7xTt+E8g0eRl+2xj0ssPedUKQHf+Fi03Njb+Gn7WyYGrzR2IfK	13	U87bt2aDaU7rY00kBVwdzt5V7uYfwAoU
1200	ybqZlc6Hxg+wOU7IKWnbksRgK2ACJmyaypIgujKYGZTAJe8yo7oYjw==	13	Lr2S4RwmvrBE5Jtrk5QNHNbNG+uGvosX
1201	fHpbVuEK8RZ5qMafL8sOYhj3cvbcJgU8uwysNZswkGgzP+2WiqRvF7p3GhjMHRum	13	dxg+X/w2R+khLHekvr7pPDm7X8LiQPhU
1202	vcvCgNKT803sjbF4I+Iw0ycSS6mcQBHKvY0oCe61VjA3hEavvLuiLw==	13	9saoo2H+YCvujQPiZAmYckLJevlto6xq
1203	O4fWsmTtsQ1ju/5eme/C/nWhvezBaIltbLqHRMNBiGy0dokUgoVaNw==	13	sv0g1tc6qgdySWp+Syp+Cv6gbXlRiLYN
1204	apPLrVobCfleJFUKlfl/1WsAmLlSCl8p+qd5EGjgTlw=	13	2muBFxORt7U5SXaFB7Hk2J4nhdGBEA7B
1205	AgtPff4B/cxSUzCxblE1wf+E+gwduplhTpn6RO8Vq7NfxXjfcKR5kHeJHeSZhBs5oNg/QI+hYFJ1\ndR7msEskdOuUtnzNveEr	13	Dz74Tvj8zfxSIYO4Nu9lA/XVBN+gLHMP
1206	jiTLW2b+Lm691IYdV7gR5102dcSRxMM7WseYCfAbJMLrCxZT6yJ1AvAAFbW1u2fk4n8ZIP+Doec=	13	IVXqhfKW7xPxHQWkKrMvQ0Ek3TkO/xQI
1207	07kGl1rvmCz8U3D6K+s5zsezW6Icy/QD/+qdjk6znFEqYQd+9iIxZ5m4pF6UiEyWWAQahWi2KWjK\nIOfkAedJrg6t/RKhsAQh	13	tttuQivUphqxYG79dvQj635tjiNFARV4
1208	Uy1TsXxeSxImxBzlgxuP6/WOpNFAoJ7ZF0Bu+bIyNJq4K6Efokye+A==	13	GNYPkjmyDfT6s/wYY5HuB/iKqfWzWJhT
1209	f+qnSz1uevOj8Nw8xOZsp55hGazs2lo2394woaE/fp+hLXr6n5fobVnxp/vmY4ax/NOMKHa+gx0=	13	yHhLJn5mbSStX1Kbx86sBzWNrx4DHL2g
1210	jGaQKQ9ukPsow3nRQ300xnswxskidtqSuVQm8YMEBxH3IBhTlPAMLPg5NrTgU5yY	13	X9447Xs61N9KSYrS3/yjrF8XgST3lDxu
1211	Kxube/V1WygfLfdS/6TsLL6vbmRMGa3AhZd/srK3u8UTCdnkyj89qA==	13	gmVrB29ZteV4yvdDitHHhhPVkMAVhtyf
1212	p8DwR1GmDtkBmGBBswmjtZBsHcV/GI+K3zEkrLdZgvts3OAOJtnSStJKgd3Np0cQqQ2fy91YUM4=	13	VpIa2YuHt4vxeR0GonQQapWEtbaO9RmC
1213	Hs9JkOc26hjRKcxZzu/YjZlhJ7kjR4q3yLjhdVyqIhqNGLMNFu7BwRQZ6s+jWGeBds/jrhzMIGw=	13	4+RN7HdwygXIBLROmsx0X1IoyxEeBCy4
1214	I1pGyroZGKdF//eDFSpuyF73VYgg+3PjBniHys5pcz1nUGXdPGXbjc/IPjFV2Tcw	13	dauwzhxezSWVM4z5RkYZVuZ5BBDWDnbg
1215	iBcgSxHVii3V2G2SVdly45j8gfD8pUE23NuyYfha05NXv00ZUf1EtA==	13	sZ6kEtkG3VUHszzSCeomECoG0fo3s6vs
1216	Pv9yMYo2OVgbBgtHvKbKCfU5UWpNH8PGrHNX+ZDuyAQLu2yyW6wfU4qpIkeckCqcZszeBLsK/g8=	13	IXh12YsaW1Hme6FRMyklIKHrQPjZ5H4P
1217	kYRVTAV4jpKibKyLmzqRbWRmGblAWquOSsFCFsD1zadiC25DD6UYoRxVszv+I99l	13	QJg60xLH2OTHo66EhpzqzMWsrOp3X9oL
1218	eSqa/sk+5D24BI96LHOOrYlTyR1XK0AOCUWefLz0+Gs=	13	0An9fl9QZdcLMSYzES3GGviP9mArpoHg
1219	abd8OWEw/VemtdWqoUhnaEMkO9irWxXijnBrVtLXnSO64+knewlhH16xM4RxJbPO5RUA7AFM78KX\nUcNMlXNykQ==	13	MtnYvKIenBQIaefGyvkT0rI4KdqDGrC9
1220	U4mQUzVM/lKX7QnsgKb/S2Oa1pV10Enj+rmqYsp6fjSgG21eEbbaNhltvnnPdy6lbEQOizEsPWs=	13	i6pxl4ox0mKgEGEUI1T2zkV+/P2Yw3iF
1221	CtRZtmRpc7QEyJp17JmrWt0lBWC1bCl0CnQ7CU1x49zLFygQfFatFoMVvQnHUfTil1NNhsUzk9DS\nSrpA9lkVmg==	13	plkTrM43r/HNekLK9snvGRa6nPUs8WHH
1222	/YRnAWQFsvaO3d413w//CK5aaF/w0EryBlrRYD8zfnKhNKKKYPIgb6QF1SJFbYhGS97JY60dObg=	13	VapV2SuDsOGua1tyIF+xXTV9GHng8Dsb
1223	IdTvMjv2Q6dP44jAHYKmkVyJamttvZN5hMgrBGDmw0hvtsfTNctsyBsFTZ/G5h9R	2	vbgq8blutVa9au8ABRfUP+Z+lB9kavIA
1224	+0K3wQ0Iz9aDt21jpevogpHj+wMz4yoE84h72plw8pdfBKM4MiciPQ==	2	fRjqR9e8bK/N+FVrvRGIUpeftY1VE82s
1225	DI4wHNovn8g+es4hoC9ECM5uBeMR4mNVap3MyHdPH8Y=	2	vJ8M+/GnG0OF5IyED96Y+nysvCoDHuLX
1226	GgeeFBtNN4W4bAHp18E+cOUJhzOZfRIdLkiKGzrVQn7Nh0cwYo+wNg==	2	yVKT6fYJ0c5zfJN8xIrDiTYoA42LT2+2
1227	Wmq61/faZmwnk0b+SWj3xmPoXjPDc5rc9FOI6oYs8ch/PV5BH5gKD6dLA8134kL9	2	obBN8V/To1fLmBSVTiy8frGPqxLFL99T
1228	MO2ZBzt578js8ORtHZ+c/d5OxqZQzE097Ths5roUdaEBK+kq3T8wKUvy02bNZQCxCNdky1CT7p3f\nvE74GuwsoGU/lyhtpTVK	2	lfhWkBdLMgFWaucVjGgb/qkAth5FwMyU
1229	DCBiZBOqy5ENjBRDeycFmqC2WP4dgr7QUInRNU6G0cQ=	2	/LHGlj+Z8mpjcJBb7tFbUMDGO2bHuPpZ
1230	Vb7xsRLe2oU3OON7B/QLvlO4PPH9YhPP8Y8VPT4Y9OW8IIWwrnNNCQ==	2	OKXtjjlGdsjUqtxQK1cz/aQoSj2fFMNX
1231	TuhekQ4d9E3BVyQAHy5Ee1FVzdciSbrdFNIU7baYo9HO1RHqFQuKCrbu2ybapyqictfjyhLMSBw=	2	qM811j+uU4RxxIn1Fqlt98L3Taopur6C
1232	pHh+rPSNsFmsEreRpKwlQHxC5uJqhK+V40XKU3BnWGGFtDJs7ZgedQ==	2	1GphTIQ72yp32uSWWEbGklQSQOmumB7L
1233	Syhsd1uuDTXp4hygIMgDWhHlYIINQJAbk0VBZjjz0TDv9IN5j3lKgw==	2	LWLqkcSDKl8glgpth0vBA/w0Q+OaUc2x
1234	E6wdFu1IC7OOO/XCjpYysET3JMlFA2R0C6MXBeHWG5Q=	2	yt6WieEXoQn3U3xPKleL1ITrasCejw1Y
1235	ClAY/8ivl0tzjP64KiLYIhNoMD7vi4WCmcLg86nY0oK6DPbqqN8k0A==	2	nh35lprT5RfB50xuWEV4mOW54aQp/p39
1236	wcXftgaHl296+UxAhkdwwparLv4/NVe6RnjiRqqriWcNUhzhUVGJsA==	2	JHTLPGQtHxNqQ7AOICHp+dBDYwGeOuiw
1237	UwRFfYHSSY1Q+xRsH44R4apH7GtH9JtIgBevzaRUtYUYD+mx86rtMA==	3	nDMgqBcgQXMCQXbTUXfNn4wTWBtU1n5m
1238	M1aheAOWRTRxmQ2JniKr2odBOnPY5L627ea8nG7LRCas8lQySVIJCbjRgPWr9dZ4	3	EzrvZjNyMpQOZe0QeKa7X9AxPEIrbOll
1239	N5T7GssViK/8HEq45oKbosrNPBjK3wTalKLLYjaTRrSqL1XDhmkQrQ==	3	xRBgbveHvNdqZs7jFxqA9uDDTwwtWqHT
1240	4lnBGJxLz3ubWBKMbzUIoeLz0OAiseANj6DVFOuNLL0=	3	gwm76nA8iUo5Fphgrc7YZj6in75gf0nn
1241	OJaqr+t3EKV3/FKVCQyUpy63QXGrmYRxloQ5z7mA27XpXXgYP/v10FSDRjsb397gIs89w1bW+2Q=	3	ECM9M9puxS40vOD/SR6YXEzO94mH29R6
1242	pRbP9HeI4l7dNl2jTK9P7JSq/BKVdajSOg9zFCHopT7rY362dE35Rw==	3	+ycWMy4tq8b5eyEFwvSjKVgeDM3TU4au
1243	ys2FfaYAP5Z71Z4iAu/D4J6G2q9ONHo8mFqUm+1Y3D8=	3	xk+8xtmSkaKktOIwDrNGYza+aB2tBO3h
1244	e1ykSKuzLpnvjHlpaxqLTJTKUGoXkTxpsc2zOsj1QlnAF7EHkLoC2XRsOihUDv35	3	zNcA/W1bhf2lXJo+VGdFu3/G6PxJeJRy
1245	Eail0liQGK18NUCeFjxXHnaN4jizX5gUBlpJY1awiAMG/WlWUpbuHA==	3	iTZlR7cZSim19pe9twi+Iggi4uQ6C8/9
1246	y/9upGxtIJPUsgKdMjzoJOwbsP8SXfJ1YYZPC/KAb+hzaqAJH+vJIw==	3	nl+HRPRZHqz0RnQmR+Yus7WH4z2GDpbJ
1247	V1B+wDTNZdMYGUVE/4v1rzx9NZC2Wqy79iiTqqwX9P5QymdgclBtRCs+JI4i7qlzEPFzIv9fmNg=	3	toclCCfgnw8CWL2TgkK8R3+nioKXsFcd
1248	gGGGeuUzPfgeS7SfjB3l6n0TQ6RUYyin+Wc64cnVG9aDIyrfUXkpNJoodoYjpyg7	3	gMCdM53tHlSeUatR0t28fz6A61ZhSg2M
1249	3+u2jHMhcRVIgEPccvB5ELH8eTvX0JpquW34ql9OtYsQt/fwtP4xzw==	3	RzMVu92Xyo5XmCJ2nU6p6B6vaV6i/7hn
1250	UXG3Xl6/GNI/NInUH4OMcekwNjxshQDCifJRkqFzDK1KVaX2e7i6Jg==	3	Oo7A0xJnKz088oQZBV4CrShbeL4zB7S8
1251	W1rC307OVS0taomw+ErPnYJt1wpQ3g+c3CsjVjHFvvK9EYZqo9mEuw==	3	CSXWMKGUkSatg41u/y73/hAtLQAv0prb
1252	QvEWGYPxD/IcRU6kjpKZmb7ZnA3EmWRAkLTe98udc4Tn0vtVkLRYnQ==	3	JNw0+I7fxXv/EoUsO63SCOt59PYLEjlP
1253	Lpz6PXVGr7gjBDoPimjreqeQ/NmFVw+UHlqL5Oz6nKo=	3	oKqdGAaqSYVrnGtb++kELum7yC57Ccwt
1254	7VYmYSSaDB08RD8ql7sqOdzJN6ChlmUKWrpQJsFekH7OsUzmW/fkIXxfvQQ85dwW	3	00/RdBP3diIwN/ynBcrAapXxI6QOWAvn
1255	XR2bir6OI2ZS6PFZGbZWVeWFIrZhIlF/iuHaydQsjeyJi4oaYWrllg==	3	RPBxSblyeH286YEDH5C4YwfJiCepJmbc
1256	sN3R/dboqSBVZzRHn2YAxWOv3/7hf50bPjESXPEIUPg=	3	9doiPGHAf3+7AVypBpMmvxuRcJ3b3R6u
1257	wDRmjGNz5+D9ImzPb4HWhV9dNuquxiO3ZZajsnQUo3s=	3	ATn0rpcp2wVJVm2areFnMothS5YaH1pg
1258	f4CDKlo5t4gbsiq6cMUrMskOaX42YzaK0G1mRJg8Hpg=	3	F52idQaLo4su4WA+sPdoLqrqVJxcI3yR
1259	XNQr8UbjIehD5klBIsH6CRKmn+P3BIjsv/7YD04nPS3RHOzieBWp0g==	3	6nXG1XiW7BtH7G1ibw5AEyHEA6wYkdfC
1260	Jf/ZvihfqfkKuRKVjvihAQAv5qZEGiqcp8ZRU3yPAa4=	3	JL6vIpQwG1ThlwI9P05EUYKcunn4gdY1
1261	RfvIjeMQKeOfR7KDSONIa5YtiTUnV2SJm2xCoR95f6LlmTLZKTFI+zBD0XOLOY8d	3	ccbnAfpRgBksxyXhbADM6Tv4nYrzccJA
1262	cizx37wMWFfgGCCowy6VIqFlj5vi+tKI0ynoxqzeLj9/E+PsL6EH+qlJp9DamHyO	3	E0lMig5Eh+of89LXTJ3yjVMbXPtMujN2
1263	OR/OtSb8agtXih12NBYJtdgagj/mcL9xSLrUo8X/6gk3J7v041GLbki2EHlS5JAO	3	NQhS4AzPJumcXoSbhsOjij+VY6pV+XJ/
1264	1WeQMUDlquSBD1l7osZ+YwWY3gZsFVRXvUbr4beOEeyUBFgBmyKUoHifAAmhigZK	3	xj0xSdgUz7PQ3FUqe7U0MWzBG8sOSnwG
1265	zCnf4eysD3eX7ihDCN7aewD6DugU+z48YLyDt/1miTGKNFn6Zutxyg==	3	dQbEi/d7x6VD+jDM0HKju06esUrx/mc3
1266	vNhChkznH/b5Oop6srlcB33gzR8lacgtqQmT8GAmsQ3ioz+ce4td7zjcJCLoz2oBQ4RUSQtpo4k=	3	NTnWPSyj7AKiZcUiyIa+4G7hTsC3dMni
1267	EfKdFvwNNBLVkTA1ls7J+NMApA9plMhgbvAjZ6EFpkED68HABmRCDw==	3	KIberkm4eRLbEl0EWjC46z3GJpxs+9Mn
1268	j1oaOmghdu6i7M/zbCZEdSG3Jb95eqEtcf9JH+qfxTNSFWkWY116HSUyZcqRIrpo	3	SKj6msTVtiqz/qjzo8KSis6vaRl7lFo4
1269	3QGJAfzdZ/Z/p6JTPTOQzObClBhq6djkb5TD/FsDT/eZhs0V/o1jNQ==	3	HXvjEG9xMB0R4trJfkNcCqYqTvlXl+4/
1270	1LqIUWmp/8XiYsJ+QIq0mgrqrmy4FLgz1hhGhlTuuec6S4oRGQmNBQ==	3	Z1oDQZqr3eAUHD5rx9xxQ6L0ernl7XvD
1271	D17G87XintRl4721T+o0oPFZckxM82iH3fY2rPFZTXM=	3	2c3IC4f708WQg1PGm66j1IBRWsbOfMuo
1272	EsaD2Hn3cguXmtDlDR6mkZl/CU87soP57Y/SFVXJN/X9NERhrtB+yofQxgluO3Ja	3	ufhEqvp1PsEQfpYi/P6ldBINMReO5UZg
1273	3kc6CqX+P72HcrCq4hE+T5F5KIvCVanY5n49oCe6bvxSaKQaBrecdA==	3	+fzL79Is3M0r9bMian1tNlEawFPT+YqK
1274	yYtJU1OTw82Y685kd0cYcdpfikmzqoKenqvMnXKx/UNdgef/ICxxIg==	3	t25QO39ziNfYcXcAy+XFXRCH+lyVXg/0
1275	j4k/Izwjis2G4sY1uDJTvVM10jVjnAhTxpn6xai9Jn9sqdGfk47I1g==	3	g6ilQJP0pAh5AldsCZd18UufjRhfhSah
1276	szLYKIENwLQedJ+bwRJn8jthUqkoP64fvfHNqf+dw/DLliRFTCYugQ==	3	RvKH4i0oWMdFjfeTwkeHn8Dmyyid8wqa
1277	SVzV3gG1YRzlupxmqPLKLWprlme+s0FDzJmMQdfxIbEaGIoCPcuAgg==	3	pLQmRj5sdRgVEDVrfrVl3db88BbiQ1Zt
1278	mNC7A46UNjtpAVpo0pIa1mGMGYq0GX/yZQygjyIDnj4=	3	dpObs8HZ+pd3rMMHvHRF+zpwZuDYUGuU
1279	c5bRj9WX5zNe4r/NKp7ipmFUw+abXrZy9Gp2leVa+qmvs76WNqQejg==	3	JAqXbov/zQilPdBUDDDwNdzWPXZW0WaU
1280	wVkIz6+j6T7SFo5sp9fW+QUV1VxUYNZKpiyhweJo0JofmcZKTJNwNI+vKLI8JG+9	3	Z+d6tTJ0RChCLHVrWd+3eY+TFlafNu9J
1281	RP/mNeX1TSV4dwoDTqXMh+TTvx3wGLh7IxBO7Mr9kZCGjwbH55yn/80a5sAWG56I	3	TWSh5e7LLxcDAsX94IV6GVcqaPR8nl4x
1282	GiOz0K2pmM5AEHfuAtOEGV43qpG65Nee7xARyitjmKYAmsqx+ix46taa1gq0Zi5k	3	HmaCfgaPaJo9l0S7xOAwaxBQKC7WQvZZ
1283	j1DzEqx6r4svCvJadeEwc+Z8DVQk2LGBwevqo/ET/o69hfjlYR6IcEUbKIVesYF4	3	VNmGulKN6ptXNjbRlYziZwVjv26VU3ZD
1284	LgXKTVPfyhrxDut6jYCXQq77JRUffzcx10dpjV6ODPbGG4Vl+nEC0A==	3	mCuyJAUYOjMdnnhRWFQCDg5bSUo2SVYF
1285	wMrzpQ0mHOMintRiI0oISct8xbjJqPVy6QRW/bCEuTgK+bGbLjnPpAgr6OMgusMv	3	RFtxeWGKZBaRMOoHIKrYMnnmDAGaEfuc
1286	OT4RxjFLDUvgj6xTRJHu/CneyObhYipn9GBpD0r17UGdEw0naXYN93JmfWmZWZ0vj4RUdrrV/Nv0\nsCnsb2VrOA==	3	iAarGhS6TvM9Nf0SAiOO2ErfyRNf6hFX
1287	2t7SZ09cUIVFguxF1Bp9J55G8HTRC5yROWDdBl/Hz3s=	3	S5ES3U+tQsiYNZQ8ylNIztRxxshjsFV5
1288	dxiL+ZlIi4WrTL6eBgnSUqcdlovXwLOtO6VEPHuxtYwE10K7ntTJf0yQLfAQyEpz8XQfhH19BOQ=	3	lDm4EYmc9I19gRBWfbnDmLIVM50wttHB
1289	hKOo9rDIc9b8mTHOk17NnXG7LFKQ3jNc9GMrcB711sqnlq2hqHfcNulNvd+/ea1qjV3+Wtabt/A=	3	ZAyZ0YPepyQwyRs3Fo5rOhlLavt7vhgz
1290	Xd4zkj9apeL1pd1QwMNwVPWHlOF3f37s8Hj2vitrcvoYE78syvp8YSF0yOSLaKmp	3	y1cLhNR1eXWxWwUMD/3n2/qgaLPu6eTe
1291	ZakaWlwrIMILBC3Czmw8l3aArTcsGRbOoeHsOzA7uDh7XGBXsUMtBAC4YVd3wIIQ	3	vyW5gPOp7CkphlvQ66CX4+/Pmp6Vr4zJ
1292	E7Stj6+Eu2QEWfUxEWIfkYkAMutHtVEAGIFqgznePPLPHracufJYFw==	3	Iwq4hCnzdHvWkTtHRHg3a53cB0RIk55J
1293	T8jTOd6Teo5m9uUouKx3CMBuzksF6M4sFW+ht26fxQXEt1CXZj7LKA==	3	X0Tz80xenwp0DYvMi856T66izOjRAoo/
1294	E4MTxzg3/PDTjcB5Trff7Bc/YCa37qLVs0Mac+w39R3OOxsKILidgB791eyv3j3f77ORWG+Z7YI=	3	M6J1kapFw8UraRockOcjFmKDlUEZC8s4
1295	tyL3CdSq5z9k4eE60ElkCMZMXzIVbJkktN/xZF8inBplJblL6C+HTA==	3	RZ0QgJ9A6KxOUhkTkhd8674Gdy4ZkO/D
1296	2N49PP9K7obeTmWObg8oyYzk9/u0zYri+gUpH+M4oUmMvOcPDShFlukTuP5Bt/WD	3	lR1TdLPVzJIlu0QJ2fNVIT6DbTJLwgkO
1297	bEGJj1Q21Dv4xjrnOnipPYNfBWhyQLvXxsG9s9GVAU9uE+Ret58pSQ==	3	YTtFVJuGVHbfoB6UiNr9Uqq0QTuqVc1g
1298	CozFMHz+fsArvPVDPhac4Tq8I0GadDWQuPjiDi6nQPiDVHdvsmyeGw==	3	OyMOVbL/jcFW3+CxXsJK2q2GzZKG94aT
1299	Hiz6IXJWiZB33sIv8yolsk8ReJq1GTE3dJcX1ODibIn53GO9YbRWSw==	3	120iHOWarxe3e8t0w/nAYM78kj9W4BHP
1300	KBqzKWl3gTUGEbagKBOMai/uCNjUix1SOaFhQ1d8PXGBJiiKhiepRA==	3	vrJ9Ea2Soabwqg3V2YFvNWt8km5M8Wky
1301	4MjmzMhNVX3AIR6jcKCy842Ay02axzdkvMpskz6Bp6glERQF4ZceabNr1y1nlVUt	3	IukuTeaMe2+2esDyUHueBA++uiwGalCE
1302	SNeFXW/XOKy+o2SH59bFRK2sGE8Zy6LWR6k3SgOVioI=	3	WmqyoowPwgfnv4DXe1UR4jSt/4TFFwnp
1303	mexHWgmLe+L6esu8WK+dbRy57iJG4GmC6YMiJLilPcdOemAxXzJoErMzWectlYay5LyJvgO2Mtc=	3	U3VOc/FnBiIGrnIGfuK7x4n/Q5DhxrZd
1304	FDZPREfvc3N2jCbkYvpCLH1SzFn56WLfKy+x38jiFQ8STI4AJBPFbxxYFd7QpHghE86dfW4Bk3Q=	3	crMDhvy4dpp3d1NciTP1Ulc927fCA6ld
1305	Sb8Djr4rO/COaAhaL9Ilf5hZPFJvOf4+d6GWQ9YFrjAlgtDziFIRKQ==	3	cjh0xt+pH+6XtUzVCv3fc10wJfomPvmP
1306	zVeUEoedF4EaQNphmMFB3RSFOlbhj90qTnxzDEwWW8kvCEMAe2/Bzw==	3	0L6nOvTLkVTY27pvx2Ys9guwrirjjXzq
1307	i18hJElVkLWOnYRKeudCy443saNSOgTJNqAUls8MNQCR7w9lON3uGTZ2oMDdbf9eX94E2M9U4vrT\nhx9vaw4T7B0R4w5LZLVX	3	cJNszUXIGKFOkPRTgUVHq3BJ5M0hK5yB
1308	jxmwFQZMlQJoBQm2fEIzMolZZiFS0DSwx0VXrVVbe+zCtl3J3BCUue+xpWW1xHheOnthEhal6a0=	3	VdhKXOMuLRmLSLO7G859LreNmlvOIJ6X
1309	SeH+24s1H9loSumWcjE38bcvplFf/jhhKiPetb4byEqq8dWyXI7X/ZCueRv+UZ+g	3	2zem6Shn6YSQi1DAu52OiV+gB837ixWe
1310	h12GcR0xnHYFuh3N0Maom8xlDKPVS7JYursdGdvImUfOY5TE5tm9/jjJbid7G8Um	3	bRO51A5w3MsM9S+VZnfWMsKAhTHq+P3U
1311	TDD+n7L/V52EQSZABlpdAeAR2tmwjgI1YtKzP7tVvxo5QkdSBfR0Rw==	3	NFwUoIu7xl38nGEIQIz/4r8RRw5C4CEC
1312	SYBlpRz2r9MjPIeZFd9z+0rBk3L3VuFLcMS5FcPcRR0=	15	bwcEGPmbEdJ3rxbEN32dDCu1i/zsBqts
1313	iJ1XPidoKAo6f1RhzGA5Wbgu7iQUR0YiqWPYjdZq5rA=	15	1uUcDr7DjOdxKiLeHRNvQWZhCqCi4bgg
1314	NjJDl31/dYf8iYbdAlANtn6H2ZvCbRG/7mqurGjKDTQYCo812Fx8MDOU8bZdVRH+	15	H+dpdWBwTw0+3KnPImaS0WSctMar7IIx
1315	0aFGLntpJUHepc7Hm8amp4GWpl5L7p7jcenIFeVuCzy+Y7Zbx+XOn0JAjmQA7FwNsCShXk0FJQM=	15	jTTk1oZUlMy4qMfpEb8Ejs9pf16H/Gq2
1316	5aDmXxaITuuJXQPFYdCzVsZ+CZpkBRTID7pSvHIN7vTAibMVg5gIkPZaWIgny8wC	15	Ydu0mnEbuiO+Dj3qPdnn5CSHdoiHwjsw
1317	93rhhQhVz4aDENhDkW+pGjoZzHLjCTB0tgrcD66TROfb+EdIIqRk3hCBuNJLB7f/	15	V0Vl9vtiAy9QQnyRrFb1+ueNXKaxXjph
1318	HTB/lxYz0kpX4frfekGZyq+TEIuO5QoqcCe2yUWzzs2KOUlxyyVlsq1ka+jcJ2lW	15	6FMtC2I+GqLuRWXkd8ddIoG1xdNM7ZvP
1319	CC5JrBqnuW2gOS0l7+mxvgAS09A879qCUblSqMNHtlCQG6KhmnM74g==	15	/x0zB92u1KQLAZJVciq11rVzXDu4aba2
1320	8KCHLvyqnSO/tLhTtNthHCZ0Orm3+7MZbVXdYzJAxxi0RYyCKGS6clGtwg/yuYBY	15	mxMwWvpyJjbgr4dr6exavg5NiMQmpQw5
1321	FqdkDTjvRLxIHcI80H6XPw5PUNbYez/nmwa7y+nm2r0MZqJvqmwY1F7/jIUchkPk	15	+XlUangk0PQxeoVF9nJ+BP48mlZ6+sxg
1322	MOLKUo9p+Iq2o+uuJZ+NKF2kTs3aHvkAfwQq9fEwexzLI1THaHTHdQ==	15	oeEn9PovilmVepyrRii6ooMWhuuKeZhf
1323	mu+STTTKE+O/TAj9ZTi/ZL5Go+QtEW9EZQiKsqdbLQGa2V7OcT+K4g==	15	GMPWc509HNWAjlnCxuNc8BM/UnUCBQDB
1324	YC3efyVk9atH15Bz/qTT94ZGGotUvtDcnauwzz0ft9fZg8Pd6AwsM9RFfj454ENWDVBUyYX33RI=	15	ulTFscoubc/knuAW4DbhgZKzWoqKT7lV
1325	HUBAvQosy13ikl3nOWt5lBt30/tteeeYNAr6fp8+5xPHTulCulgHmQ==	15	VRjHUTKU59Km3excL8B/T6WKNI2IL8dl
1326	LZUxE/LxffrmQy2V2MimjunRtI7SYJ+zkKstPYQkzrHmjo0Y2a+6u7jOPdamVDPl	15	TjR0vtf58yQ6HOt4R5YtKElJwq/OTIs4
1327	tUO8iZumkzNxu6I5BmcHL2ehHCBZPUUseDhu4+qrKxw=	15	DU+RDtsT+ZmmmzxVwtuCadnw4+mxSRAv
1328	Tq0M1bORdvp66qGY2IBhAMnEU2vzVw5CGDkOz6c4yWo=	15	Zo72SALy3+JhZ/GSi23M63cFFE0OLT8r
1329	IaKWnI9KxZIpFWAvDtp+tl/P3bxdFIH2MDQE0VS7Xhf2FmNiKXqliv2uGOpy3KmL	15	m6P7NheVMcP8pIo0hYa00L23F2ATgzGZ
1330	BGSMvvpxyg3qhbAXHl0fODyKwF23yClTyyM+p10lGyU=	15	fPLQVmvgjazgUzOJT+MsNhMffF5z/s91
1331	Z5fHEsMlmoLQ8Ya+XmrygMjI+0+QPMossAgeAqH3uH4=	15	Ijrx+Hu2BQ9vswdq7KYRX1OcFfruSGEf
1332	GRsvfzus1Qyqba0dCwqW/kk+9Fte2RHX2/cXTYDTB2Q=	15	6udruli0d3rz5YnTuby/SQQ5UxyngR48
1333	2Zjfpb8xHthlgnafjkQp2Zy1imSyL+OjHkAZ9GnVtzI=	15	4l0RdDB5tIm/5SMkOdeO0PjblEC6W3o/
1334	2tzFuM0d+fRN40etiSdW9shU7dzBTZjRe7aOU8BRXjc=	15	Yko/yunEn4Aa18j0S1LynYLUXSysvcjV
1335	Wmd/HlDpUyhlN04zipg4C+VKou1EmJatuMd41F7/aws=	15	1SXCJpWrMxt4MLjeEeRrE/ozxhzqm+mA
1336	sjrMqm32OgWmYv1ze2FBwp8HD5KrsXXOIULq+nx/HYUgeaPK067Wz7jlKsQeukyo	15	qGtNmjF0c4yJ/BmytjJyAXuL+44TFVjT
1337	u5CjIkW5go6qKwwRxx0uIP6F30JG7LbbUtATgaBkW57wjWNnBIHpNm8JqLgAdYJE	15	AdAD9X8CtzUntidC2SpAxleG/91FLBky
1338	7rDkwjqkjNWtPjmsgc5pO0Kd0lmA8Hi9/yhfDemBHt6kCQQpVj/b68VH0WGrSALWTYBgktOaikg=	15	01hROqFLD2u27WDZLkmHW+o/Zf7MxKyk
1339	dTvtRYPIk/BbfX4eKUS0nYsXZFgiFJyMVNYKWLsK4QNaFQsUGLjs85icw82SLG/T	15	qHsjY7LP1TmmhpUXglNsZkCZ9PDTljQ6
1340	Lxd8szcHPda7i6xms+Recrx6LocE7AJrYjmjRC1bTzNXjHKNdgjLpLV6rxC+w9lPGD6Kcf7yAM6U\n0qSKVrI2hA==	15	OYSgDhLcLP/77HU/v7Y1BWUvaueoQV4b
1341	VSW4IsGiGNPuxEUalgpaQiDKkIFOJA+p95mWWklOd6P9+q4g4K+6IobYcw7CDE1JBqB4cPHJE84=	15	U37hCCvInBButnIC7WKT8CsRokVTXCPZ
1342	r1N1gdwy8fWeyEN3T2ZZTUoKXlW6sjKh/IKhMc6eN4Utv3sp5DPVP32hHTG96DI1	15	wrosFLsq4zYm94N6uCM7KNWoMHVCiM+f
1343	5QnOb/R4yyJBw4GYrxYk6G3D04LFvrPHAH8Y/0bGjJ5YPDnGrTpa6Q==	15	YOLC5DdzUNzYTCHbM9/qpaJqFR9pizeo
1344	SIhwfdp+OTO2AtIYM+Td1ByMB0kWhnn6C6Ai0/42upg=	15	2ZclvD4AVQSpuegLoGDDg5N4rhSjyZkf
1345	lIdX/9Yoge4vW7k+7kAjeTI4xY0paGHEMN6c9fVYdrc=	15	P+rkyxajpdTG8tnPfdxJyygOvP2+fO3/
1346	L+RngrMExqf78g/IHGUf3uSiKqF29f/ZUAZ4xUnV2qdgulQjwJ/vK79ZE0iPC+K2	15	1y5kOWrVObzEcE0uiw6BOtwLfEbdC3j3
1347	d2srNK9s9s043QZhfudAYkM1iKstkw19pVoXMy0FGJg=	15	PmZO/7CkxLr/LEc1bTYa773qdkPN3M0s
1348	OEqSvVW38Zp95PhQv4DxtxeaysisEw429cB+uChrIbgdstKCVpiKxPyVON/M4xhj6sdD2da7Erw=	15	bll+ieMs/3bg9Dt1j76RZgVk+heiraX/
1349	sE8cSPwUWuwJjhK8iLVKAPzE3HIjiZtHUIn18O3/SFfqBPV2EJSDOxXrbrIkX7bWYyQtbXaazG0=	15	j6NIDKVqG+bgCSP/PTOdeQJubmjQd3Oe
1350	kSitPBCeQqH2Yc3u/o/yHSKF36+8ZsKZgC6+HIxm2YFUio4OsHKHAunHoS6zGnys	15	5XPGEhYIxaPLr3UN2Yptuc37r1az2miu
1351	pfxS5g9dz/M4cu7vmifwcJrLol1RNbvHHPStsmWfWjo=	15	KK6dtyB1DUhY1JuiB0E0UWEYWRhe7RFw
1352	1Hs0TIvMGwkWe0gwcAOhIzZTB21dDoSCIyoyo4e6XlKN15z/YA4gqggQ466gAkox	15	JO1BiH3gKmTr2tiFPsP3IrK3GPKd0PEz
1353	seD90xRHKthOMdRAFs9v6uXnO9SYMG0UoBDzjaxCu5ub5yWhajpXoXu2IyOHf2rr	15	HZanTL5XRVVwJw2P479jL0hn2GdI9x6g
1354	YUKLTjQiibzofZUoVrWT0QJUlj+NZcs4VCJ6fRooYJU=	15	F7/gM2+NrRVse2+ok3XZv+ZkDwAnQlKD
1355	0UD0aAi/yvUIIclG9cnF3Xt83NQ14eSMeYAQ6r9jhWQ=	15	0zu7/H6kjVDyVmTaN6f6wCDV6av4ylSe
1356	bhCLodQpsjGkYmI0ycHoLfZtwvJPNYfxgNs/mPf0/J8=	15	t+OIL+ocwg9GIyisByoAjDbObEleifgp
1357	zaY5VU4eS6sNFqPCiZC2rDRckGTrFAQNbi8zfvR6UZPjLn1fcM0KoiqE7KvwyxfM	15	PlAoZb4nlkLWozyRTT1cqM2SWm4jth6W
1358	/Xa1am6bxIvNAMXIPhu7AGovIyjR4ItqSWT1alGBZ0hxQ61BhV8lDBXKU0J1ya9j	15	w80WUsskXo6gLffIByG5XdmjFTnXdz66
1359	WdV2M8PIbF1veI0+PD0jPb3bQDDEmQsLhhBVBQ5JQDvu7lnsuPaxyA5HzqAxjioxeOuiY+Fietk=	15	ol0KCGcW1npWggIqbjucRjuxYxF4M8Be
1360	57NpiTL6+ZYY/HuUDKFm/FkPItUum3f+4tPL5YIb/Q8LuWio5Wt9Uw==	15	5sbJxbyRPqpipEoYQNOAErXJz0nf/7QV
1361	UYdZWS4IStCEewcNwlzMNSmpxI/5yoBo6WAuYSNrY8Ht/7bf9mGaRQ==	15	W8UL76rLqs+M9zVTZaIsj3FoXI6BlAtb
1362	Kv7wcWDv3JS/ORzFE5h6WNL4jMUXBVukQmV+rIpwEWk=	15	TAOW2q0RQEGn8PIAZfxEysz10g8XG411
1363	XPwTAAXS3SkOhZRwRjMYqjMHRckyvKp+EZQ2lhP36rNA+aO6OqXhXA==	15	wyVhiICCykyN4vs6J83IunRYEmxFrfts
1364	epzjMS58+8nBZ/VdnaKxFutZeFcwsapCJzm1J6ZLr8Q=	15	sc+mwpjUUSVcHMjMY2baYz6vAZQLict6
1365	yAoqMFIW+y3UpFB7YeKHT1VCsEAcxj/edxp1cuvleEhE+IauXXENSg==	15	dAijJ0Opm1W61mdHc+RNOIiAuD2ljWWF
1366	6hzAvJORU7Cnnmq4tgHO2TDg/a3HKIdLPM3I7IXXsX+RQdscI3pVzQ==	15	BTKdDZbHJbwTcPKqBdQq05q5YiTt+CZs
1367	FMl9bc9idjIuvAQpTgd6/bKAI0j/cV9NAfNcJWXWXSpfT91A7u+Ing==	15	8TRO8d4yHuqzyout/D4rnm7+sdHAsydh
1368	C3IRmFdl0OYDqrk6vIbnlgI4rGkGR5Pt9ZreamKck/vd/wP7rlxW1w==	15	bRLa83WS2TWxZuU5zfVdE514y1GRkv1X
1369	RVZ7CIzPvCohsuT2tUiJh7kEtNAzVBIRrYEDFPU5Yeupc1Uv/ImSCw==	15	2infVqDwFkrCXsf/bG23lZSgAamCoDyj
1370	vqySf6WtQ6id/j3nWUu3SxG3AdROpPovqnM9DE9b76Y39Wiu7cj/+c7H3FXuFkKo	15	rx0gj6DLAiTzvMcizj8oASC9niMCsCEs
1371	zKC+q4DjVDwv6Dv0oTZUTUGNIgr+zqT2N8gTHBLbbQWD1cQdNjQDSH/hAREPwypV	15	rrnDUCo6EBUTOw9uiOJErxoADdxfjSRY
1372	WtqcekVZrS5UZDWgEeEOj3tCZfl13VQFhYQ+0WvOMONUTalLXpn3ow==	15	NPinpgfMX7Uj1VYT80ZupPHIzY5BG9uA
1373	U/LvFNeptAMR0IPuSxpUomt9RN67Nu8yoKS8YKeAvYs=	15	t1gg/iFvtMdIYqMAFtRUpUwXlQ3uxwYA
1374	yxZFykOwWpKQphksy5Z/U54a9Vu7H6UClMqElASNT3qgK/DvCD1IWSD/zIB7yT7T	15	WAHPO9xBMbF8gey8vPOaYfq0d2tvRV70
1375	WwRew4PMLQ93HuMnK4QIywWDuUmGGo5vTMHs7L6Sl3O5CYeWB0y8GA==	15	gZAbt3myClIVbHfnRkj21CvJXKXXi877
1376	BK9Rx3nI+gQqThHKIYBVOQi3aTlMIijA1Xz3uHJoh60=	15	MPU6bjTa0VzuCjMNiwLs85qVGofptFkd
1377	FRLzVb4Pc0sA+xxqN+2PxIr+B7imTqYvAuQZbC+X3hg6Oraxy0F9Jw==	15	ghxgQjS5gENmtfR19wZeidANoERAhDCc
1378	WkoAd4ZAAvXrJuPwhKxHIUS6aqoFEd0pB7hxA1ozlia374Ej6d4zGGxQbTv9cYcu	15	AaWBzb33cVvxe2dw7Z9uFcBmnKBIjtHh
1379	MmkSRpEWFp0isB4/UZFAa4ZV9vq8wKhLmJfqhCDIPX3+rTAecu94hhq/bx4UGcXR	15	tFl4/rYg4yoCxxQDa8DcwP5K9BPt5xwx
1380	xPY2kvyI61Hic9YVBg1R9EPA9tTkyIzX1j0b9BLDDSWj/vmo+UC5IlP0oCKKbma7	15	tCslDZZZFK/+onBSeKZS4JzPv7hvByjz
1381	O4RUiO0zaoigrrT+KzbV4bjHPT9Bu29Z2NsrgUq3YNQ=	15	oXmXXfXcani2U/cChfDjXiLxqhNiRgZE
1382	m/LSwZfcyl++ciWYL/krayU7dHxxuwXJ0N86+1tlIHFxgh7AQjxwXr4ZDxapPl5S7aXkk3Nz0v8I\nZmYGbuFCSQ==	15	xqPxhHRPK8UI+P64wVtUFFYLD9U2MnNj
1383	4inG6yzdfR9vDoUBkwRL9Cim8wlKa0lt8SH+GGAhtkIfvtbTmCZ3vw==	15	aBtK0owMLyCPihefSbKx0IaexmfHuaAo
1384	3R9ReNcjdBzHBMaRc2/2vHt6p7VfTiGlO79YcB3yuc4=	15	We9BGJ2ENmaVSRD/FX52E2ovOj+2Zeg/
1385	OHCG2+ffC90jYb3XfUnVlm7HrElFE/Wm07T9FDeTdWs=	15	jIEX/67V8XhTES8iIedvQlC6oHB2Shi5
1386	5TjHuLXv8w2izYKo9WUc+Sqo3g0W46PtsvA+xmpukl0UBsHXUoQusw==	15	PxtJy5GohG9DnMCCJSJBeDmUPXJuAIDV
1387	fKbh349lXqQDNZzo1eKzr5OQq0WM3tpyQSR1YAkU+zA=	15	dIxATD72ou8idlqsBv/SlBjXN3HR2GXA
1388	TuzxUqkMsXMTIPuEVljkXzt/xwxu7p+fvhk10FwMtcHvEuoWNJcnh+Yq+MSNcWg7UJKXqIEnaCQ=	15	iTCGwbrG5t+1/DfXs5o6RMrw/s331bcx
1389	UfDPGacS3Uoc/CVSm5zICsXBQ9gQxB799q7Y2LyjlZA=	15	Awp2JMyg804mYMFJCqM3VxvRtMrxzjMp
1390	TxYhs2EaLPR6azGhFscD0ojQUnKPFW/AdLtbc8aBPcM=	15	hVYVfVaSshoD3QWbI9MjpGvwIslCfSGo
1391	DJQMuZsiMxbDCxbRAiAwWU58t+Qtyf1VXlMckmFoa8g=	15	cSg7hJExSRNSZwpVNcoFYaNNwqKeRprG
1392	wca6ZvhavlteSP8mbrhaOwdlI7kPGXhZp/46oGF+kmU=	15	HWvFCnyjNPHIqJX7klieE1JcM9Rt0kez
1393	56Yaely1166Np7B9bukH+bPHMVLFuJz+lOTw8uQNLu1/BG0UazufbA==	15	Lm32IjiawmQH5+xXSZFH1Voye61LETCj
1394	CPkzVyprBhiSicdTsoz4ttP2xVhCrC/vhfWh3H7nr8AoDQHrY4ayFA==	15	2z8w1Le1ZeFNkIPY4IgBmRLCjUv0838M
1395	qFQl3Bz2OeVxnhhUrzUCRcCMJSiql0XxqDIScUKAAUezsAhV7S13WA==	15	fBSubK+wMpp/CLaFjNNlYoYEr4y2MTzE
1396	BIsUD/tQ22oRW8GR8h1P+8aPNKVcni8b8I00lFhHSwM=	15	Y7Z5XTtxq4+PO1cJg/hbsiMdyoMlpB23
1397	6yd6ROvZpPQtZOATZ6VPONkKdf5s4mlsbfY6qnKFvKMmdndZ8kLT6w==	15	kAFY5VeIxN6FtPH0V1UfIfZcdXkVva+i
1398	NV2YgeTrCxjFGDMCuf5IIOV+0m0lblamIz86zqKxsCZHfOSW6fiVdQ==	15	wpqBWWRZ9yzIjr/jAoZbDEG0b6lR5HcV
1399	ZVnZ/TtUNTdwYokyfxru1LSXtAgl97Gh2PLdlxCSaW8=	15	7Rv2Hy2H37sxo7HWR6wGvvKjs64h4hAp
1400	skbanIYCRDI6drdUN9o+Fv11tnwR1Hx8FgTCCqrXGTwSgz3fsWi9lg==	15	ETKKsLogkb6lJFdKPYFi3Q2Q0vNpE0cg
1401	FWHM18B9Cr6yK3KsBnvU8+rH3Ih5sr7MDpLWEN+vwvuFI2Yp5ctWTmSQiz7f6psT	15	ExX7BYId7qMJpc7l9VYciY397fqarYPc
1402	0dgKf69K/WdtCS1U+b4JJuEq+Vb/k2W2d8HB4TLFGF0=	15	Zy5MzTF44MbahWXKWlITfFJRoc9hBJFQ
1403	PU9VnrZe8/AnRQJ5a0T4pBzgEtmPGb6sSpRH1RFVh5c=	15	drzXUJV8Mmx5uSRLyxNHZhjrJ2KvY7pf
1404	tIOpOB89oxbY3iCVAQVDQq6yGg9EX1Iz5ngfb+fh76U0C8zw/z8cRQ==	15	DQUkJZ4P3seWTFHokijiuRdwv/h/OAGJ
1405	tXtzmAjGJLSxmiqbMOQ1QThjhLxtw0VRopDbqLknBOoTLNsYMImJzA==	15	Vs/XQNzYQowKwPMlKFd2p9yrCFp7HEV0
1406	YFyU+8TnHFEfxk1ehTw6JJIda5wvcv3P6dLxm6fffauSG/h3mVU7cHYMiCWs30Na	15	CCN05EIXPi5d4cZmYq+si9e9zsFXhLWd
1407	JaEFv4KFRFdbZuMmRxani+qqngVY0IS7IOf30tpASO1V+zJYtKRc/vp1HztlijFm	15	7qoPifPpdfvGlfrMcPIlO2bdLvgaZNfZ
1408	jv9yvJnX3SE8vNOFwEKXT1qIDuNWjJSAKelabB+unRpfNJxkMfA+TA==	15	cgp5guKGeSSJUt48JJL08Lbp/VykRlW8
1409	wvzh10S8Dn6pSTzDqwrjlc90MD8uThS0hKP1qrRd0yT4t2UWQ473UJfsaEZ7ckNX	15	ISm7ty9MzVkZJtrTaGWsQljWtymIjfFf
1410	RNGaencSf5TD/nKMXtkRINYrnopaupF+NhJeQ3kzpIiiR6bfcZ6gJQ==	15	ZdTT9CF09A2eIEGEGHEwVz4NPhp/Ah9X
1411	lfmc9EdoAA58IznRprgKFoDURkTRaQd52B3gORJWh3H94U6BZN/wNg==	15	povax9x31U+n18KWUER0KWKG23rl16yh
1412	F6+OB3JKXiKf1iyOscr7PW55O1iPzEGx+MtVcIV9syAz7nxfdo/+KA==	15	6C7FlqdXVRUP/6Mza2NY9k9iENfjuGjg
1413	Ew82DuXAKQQzzGjGgrkrvk0h4LVB3tl420CpEglNELg=	15	BRVtmDGWDUReb+bVcHTjnOn7XHJzzrlR
1414	EJUvVIdD43ktPxhNOqOKm4Sca1q22V9Qt4bj5v2/HEw=	15	93evIy9EFZKXVE9VtsBXm6mgbI4QnOTD
1415	cOUTASJj7i9veh8ZbqvYCFVxFpvr9+76g0v9YohiUwYB8q0IXU8RyFE0edyX22y8	15	RdGsBOwZhi6ZWqRK5biFCHn1Z8kEzXK4
1416	pLnT8RvAFk+Em10bEkwUtijVCLMXTySuvYHh8zVZsa4=	15	AVSVOMrcUic24xpy3wzorQS6ea+y1BH5
1417	d3CKP2jpIwl3Jt6t84GbbG0TVT9AudbCIkiPCYuU2+E=	15	Dlm1ZP8ATeImML4uXn2ucPMRkV4+GIMU
1418	/NydRRSGMSrA8iwrr2NNtwq9uR9LELcwyjjS2E2l1DbwWYfTGfznlAFYfX1kIJcN5hykqO6G80A=	15	GqC5nOMpS9Ig4f/ezR6WX8Hvsi5XVbsL
1419	OjpiDgdlKsHtXPFZ7L/GGpSsAEaLwgYJ0BG4G+95HxwNro0tQ1xJ1eNcP/hQoPn0	15	jjZDWARLhwWpAfFEg11eNtm3fq0K6IRG
1420	98YVUV3KA49ks4HkQgY7glekfbAIP3SCNDqwPjg7g2zrTF33SLUYZg==	15	XvCXDcq2mpxz1E+JPeNv1NruOoN3c/rs
1421	Hb9e/dP35gZEyXUJoD5ou/wqdLY9K5H5	15	lPhHNtnZ+MUzGeq9K9myyER6Tg/7c4hI
1422	D+D+MblxDB0elsKqW2sjlFjhj1Qqrf3BuF6phbZkWwQ=	15	GbWBM9Wvv1IIDgkVNLSVWyjT3+qD5fkB
1423	UXihbzsWSvv1hm02/Trz9PzpIZdPEnAIUeULEZgNxls=	15	y3iBeutsgUlxruXb7tW6meBxuXbVVl03
1424	/9V55OZye2ST1MqaG/EG95f2ifNkSdtxeQvbrejrvGEOMwhbrk1ysxfsrbpXfaTo	15	heBmhuxo2YdsWMjV3PyeT0k9LR4dUMoM
1425	QVovgvNLwfSodxrV3F2k1vOj90Rw9vcRBEtXKwspxeFWLtsQbW9inQ==	15	T3LeDbSEGIqybxIu0u+fIbRt1QbrheP6
1426	VnO7BULClgsIMu0ulGXF3xyYlux4mnV4Vm9XsrpkMmYuVVV9jB5CdnbOaQ+TOdM5qN0K6HUykRk5\njlS6tYCyRQ==	15	RddwruvDGRs1mtq8BWGzFQPIUAXITNSY
1427	gGO/UNLkfEfCkVuMZcbMoUv1ySV8CU5NoSUB0u0O3THFVsVPc6Ko7LDjhm5wGgD3RLyRFVBfL08v\njk5AeNjJdva7v9Qeucy6	15	OZLGrhKplGXHjOXqCQfv7/AN/f8cwBhN
1428	fRP5g/UoHqyS8NT/xTiC6Ydr8/dOJguSAw36G4sQunBOUqhZuC70tJ2fIMwP4Ec8Oz1+FZSmdjmL\nezN1LxeelUp5RmqVmV0vYOXpDSWy+Dc=	15	TV68TolLc8HKNI+08WGRXvad+L9Tnaqf
1429	BIEGz1VtRZ6qaclrsEoy2THasEstrs/85KFjM81evssL+3P0KM7qkJXZaZpr3g9Ht2tPyV1n37xl\n6c9t1bNiqA==	15	tD/6dlSH8lpPxQLUzWwhDMzePUIjIVlL
1430	EjKj0xLiIxf1KpOi23Hu2+vabFiS+O6Yp2blewf+YXENlZbTrcc2FkLqtr9Vcur4pmDiLcPf1emv\nVkAqndTVoA==	15	mNjYhypiUFH5s3Lc2k+VZEVfeLao1cMu
1431	mndQySHYA2yjZFMzO4YfQvmCutCBHR6jkBV+J7SPEzb+e7mql1LzWKJq2X00NTUFTD1rmEyCr7M=	15	DBWli9ur60AY/rS1SNXojfbL9dMg1gRN
1432	jEHdq916d/QMWyTAVWsJL5CFM7KUS/7yj//nChjghH5m/VzbLDyMkQ==	15	VKRh1qAlr/BCcMuQygeoa9KB8lrzoELI
1433	SuVRymEYAPpZp47i3WJHwW0TKksbsLB+F7hSulKEi2NthFvnGHRaEg==	15	9vZk/fK+Br2fxKgKRC+GAKcr5iRJaUr/
1434	/bPR5NNR4VpNPeEiVNjjYn9AmpfPULBxwPWaOfrnn4w6Z8iHBxsg9Q==	15	W6iUDuFxhDfiayhYRdWJqy8xZmqgxvn6
1435	A8upUDteiFJY8eDzCvutcglmsQpQa5BaBVKz7YZQRGU6HzNVr1A9TkEuqXYPjo8pW/CxC2uDsYk=	15	S5cNdXNA0i8IWbTWY9hyQnnyp2jZRrjN
1436	w7xlqerpxWG4LrAHNBAHX4A9iOjng9y8+cF7ADg9913bYfU1Igs9MBbuR/i3+X3y	15	EaHYR4V4Vl8AvCYGX6+1SE7krQ4Y0tYO
1437	HzXYhhti8YpVFzTUlok9pINKYWVuIZy3FJCsQMPfRMTJwyPvisbPrw==	15	7VipGZz4AyHF7f8SJZsfSVNj7ySpbk2a
1438	XZo3YqYxaQfwPydkOV405uDhYFeRGb4jlXBkLzLDgTYaAF27K3y39w==	15	zbfAvT8epBAnUcar6wz5XBN0PnchNP0G
1439	1jjVC9ZKJlkvcnbq9oW9VNzEnhpBHiWjcvBh9ttr11BpXXuZUoOmtWHk+CJ3slKVs2N/8djlkq0=	15	1bUQgcKsOUDdq5B9GLJPxW8ASJtXimI6
1440	5i93Qp/+atM1yYxrCdBZbXAQhvUPrCyc7lz+ppGop9bXBq+BVp6prg==	15	/7xKSc4wONucZqD1rL3Y64RF9U/JgQ7F
1441	W4gOKQkqpvmBSfL8YDRlgY0FkBsG2kp0OCTmjdIvD5mfZUXHiW9neQ==	15	KKOPrQOaZxGA2JRQWX/yz7dGh9fsqnda
1442	BNOae9UcrdfgzaMcwgSJx7U8GaIXNT35aw6nNR6r2xdlxsElgReeSA==	15	geBr2YCRuHps5F+VCdYAGowTCxwjWxT4
1443	/9S7oRuOP9tebHQEximyiQjUOL/bz04Op18uPE+txX7C2U80OWHPeTTJ7H2RY8Eg	15	QMigaHABMS9DWpqRhxRt+0jPuX4vYaDY
1444	n56fKp80RAp66GUhiGpdfvdCINN35T8HHWmLCSS96o8vArevse7cAOxRzcw5f4sI	15	Ii1g03mkOjRz0wDNWHU2+WCAXXAuaxRq
1445	nwhPQaQ5Dxy9sLw6sanTWq2NMRF+Rfw08gPO1egHTC3W2KOjXYEfJE2OHraJLz2WMJc4Xf3Iu7o=	15	m4r2G0M6E1V/pteoOdoORaaJel0AFB0b
1446	JiFIQ/tMJacV8KxxM/CQTVWnpU/t2Dj8hb6RvEmQxyGQ34YmcTaM/4l/KeYem2Z9ygBOCreRLQ4=	15	ANZxneUuftGv3R8qlrp4GBw8cMhq4jRN
1447	gA0DIUAGF7rU4N3TmziCwimJ5gztIXN52IsG3cVOzeTYnubqDRsiiNT87PHFnhV3uqxsUidNwUQ=	15	8/dTUr/RT5y42nf4oQXlCwCE1AaFdLYr
1448	ozLeTnmjV4gaE28sJ3DPC7YzEaXd2tMXic7fMlc0V8rhmzpigOnNSze0roJf02OLJpyzD1CA3C4=	15	FIifgg5j5hvmNqi+bSXK8dtON3XXGpzX
1449	Jf+DUb6u84aL4mND4q5hK90W2ITE/LRfUsm75sEx181zijCCFOHiPh+p2gPqzku7	15	mHUE90xPZUWWHx5SLK/O9WLTgkwlwrn0
1450	1nvgPw51tSwUlmEbd0uMRjwrLug2KCGinAd7CytQL7A5SjFlTPMeMQ==	14	5+UATqRdxnyE1LMrKQDC/pfXnnrhxZEU
1451	5sv8bcYrZMqxKiei8q0P6mKdBrnbP7NQmaM2mE+QgeU=	14	DFgW8dS1p14DRf7GfONjnqGenb2+e+Mq
1452	5vKJfurhUupDH8s6DbZU4Bv56TkrGw6QJBN6yR7nUKk=	14	tI9W2EnT6mSh+GSipcVsUdS18kEyFMB3
1453	6OMWuL9ALfK7Mowr5KjVYPYzcXaTznDGXVE11Hb2AY0ag3wbu2ixkw==	14	wfw2oRtaIRM2Zb6AZstpygNvbuvx1PjA
1454	7FeRaE/V885ZwIkEqHj0nFPbPdwMdbDb42mGcZ+2RKTIchiw9/CiGw==	14	bsRrCh3SM2EpvMmu36WKdZgztAZ+aU9T
1455	3b4fYhD6Z83YpDf9Zhmi7ITK3JXwcnT+N1gDtxUrZbT8Ey+mStfgUw==	14	/VeUIPZ6QgvTJsyRYbHpTuRl8fgm9A24
1456	Nko7wamdnu7jMGv2CreQpijQRca/gzrB8t+VlunHJEJ302s1Gp7CAbUzE/YzZqJb	14	vlUaZoh/PvngcBb0mMxfTypB35xrVHpy
1457	uJv4iG0wUkcwfudttMIBG/uRpZjdmK1Bu46hJvapTChcX7b3kl2U4g==	14	2p1UjIbzcW/UUNHLSW3Uhf5+K0+UjQq3
1458	PaeJc6bVmJW9MzbHb6bItco3UPHSd0nMg7RsXx6JYtolpxlJMvH2XhvAL3WYsVIKxC8gPhw6beE=	14	YJwXR61Cuj+2Kdp5Sx9N8+c/BF1H5UV3
1459	oknOArhtK315Ej9ouLWwf3HFUPgcqNMtAbCvmGNcbFA0PlgVn7jplA==	14	iQEHPsT5WowqC4EIGwMXH4WaMuXnDHM8
1460	PEyHXtAbWjRVJJEiREfSxOeqONYXSnGfKJVcyxnZNoE=	14	cee/vhlSbyAnacNxJ/fvZ2mDpTV52e9P
1461	vBX4bPhocTR7O0iFL0g+Cgl+cb35Ey5kbGdb3MztbcrYcY6NkWv9sw==	14	b9pXHznSV2bYAF008guFKtgz2jF3il+Z
1462	YA5yaOhaahPwfs+uLZoERvv2To1MWFdOroEGnBAmCNU+onOcb7VJijzjtL1FeKTWproDNMO/Xia+\nyniWPR1b0w==	14	jXaS37quUMSMvcfONnrQMH9RszIo+z9S
1463	oRkidS6HFv9ejlPhgwriNNqoRAUTmzyeCPI3LKMDWnY=	14	/+O1SamEhnDhkEMxgbzKj/OP00mV9up/
1464	iZ/A4Xjk9BgqydHfRs4m4VjGieOPZJPtwoItE+AG/t8ow9GHFoW5Vn1Z7VEx/AqH	14	mBxRZynnnEznSZ/bMRRYamoJFaZ99zrV
1465	2ClPGIwyH0cEs2tBWqXM6k2Dw4rN73xHPdiUUvbwO4JOPOfFcEX0AERYDS0yYy0g	14	f3U+xKoCk3+4mwJ4+PTXaBBHI8v4BApz
1466	0dM/5ARIJABHSfDf31L3x5WYWPntnHdLKxZngsiboHvBIkMqEJvXiO0TPu5K4eje	14	pOxIp4036hrh8iJLNgVm3K63pylRgZf1
1467	DRlmbzNd7TgdTgaSFI6rqeonnMqMOZ2LJpLGoZCp2DtKYa2eXL5zFQ==	14	T0DksFC9ayL58ERYU0r9ptWG2AvUCU7+
1468	YNMe5mfK+XrWfqs5PzHibdNZTyuPkYSDtVlSSbMinsbQwtNIQWchjw==	14	kULNifED1qxFNOji1Jw5k7GZVnWr2Sn6
1469	bgAqUlMEQLBAo0+ptYNbRgFsntbe48hyoOKGWsaUjuK5FobQZJlKUQ==	14	sCP5azdb8je5xk+obsoYxILB9PeU29QR
1470	CP/XWmBe38xcSC4BpSFg2T+31FjzVf7gsjcIdQjdO4+DdkJ36cXr6Ex7t3y7kqju	14	1jpnGZRIfCpKxbwj0gA6E48zxSpipUeC
1471	d1OD2nS09JJ0knSXOp/0KCHUVaC77vAi11KFnptNvyHRytIlCnu6Vw+pfncgYqlQ	14	b/6ceBInoLe9ErmjM9Pn9YdZToTZYISj
1472	Aj4W12a1WfqieTFw2YUtpu8ACIzZkm0ClV+onkDCmBFEBM6xSrUvfg==	14	g3r1lTXrsJYzKe1ZdIMbeXn2KFdnANtV
1473	QbTBmUCRdfVXNA50cbTSiK2+Qib0hT3xuxyvr5yI/x8=	14	Yn4ACKEubSVvyMProH9q134q79jkFKmG
1474	jEERL9YpbS68UmzG3aa3nq4PmnNr2Hprya52fstwNqE=	14	BCjpr2ZSDTMNyhxWck05q3E0841Jx9bD
1475	lf2HWVtKrgeMIl1Yu0joKSOfJXwBLd0Oj/bXcxJl+NqzubSAvHtxF7HnvnuYTjf8	14	j0yQ+2fydetDZR0ynQqKBj1HM4x+dH/t
1476	hHWkzl3wBZgNFvWnisAG9CrnuEkHMgdzXe7H41Wak9c=	14	HUQV4Oc/gDc24TNP34DdqHe05W8nZNNX
1477	0QYueAW2qu8/I1aToCDzRCh3gdjmA511j70Q6uVuMuWGU9yGV2KjKQ==	14	XMpKjfuGvzeYbDF8jO1ucwWj/BoNySMJ
1478	dc0Qdr35hIo1UUeZZKsdlwM1BEUYfSZDAZ0oBmrdqmuAHjC0wwpsm8A5zwvgf7Nh	14	wntTMBbZEk3bArrxFEyK3jYWWkQuPv3q
1479	9oOimCdkAz3qg8LjpCiOOtVNBTl1Y6Jaxv7Zai79FcA=	14	m5NAcrGRq/Bi6BtMbbP5EB5cT2//xJsL
1480	iGztqHG5LR+4fcktjMDR9TnwWk/8XoUIQKISEy8dvSg=	14	OraLp8RpmJ1JduxwI4QImqoFQAkJKEJ+
1481	W4DGiGsUYBswBlChoplkci6uw37NrTBdqPUg8dmS54A2F7/8Xj5mng==	14	4e9z37sd4tbrzMOyibDFIeSxbjx8IJmu
1482	Dx6UfCe1u8fDgtpDnbhRfZQq7CM/GSUaW84rI/Gsraiegr6RaEVQog==	14	wlIExXyJ8zmQpRZcPHS5UKnCktzr+sZY
1483	ysBh4NbML7FsUu7lMixhsXYn0jug42uXPzGTHPyh5rP0W5J3NR4UIQ==	14	frTR8HLnz11t49JXhoo6sSGDWkA8w8cX
1484	WpsIo397DhI6eLkdxBarcpJTVTuOvboHHWYRdGXC0Ll7BSTRoES/aQ==	14	fMlZ6kdMAtI2L7ypNNDuAZTGtDWHQYNF
1485	uaKSVObM+oGZ+EeOk2MfV11pbw4VdLQEzYyTPYLcr8PewqLLORe57Q==	14	+lAEzMxkVEaSqm0emUV2B2AQISxYs0MX
1486	LQPmuZ2gElqM0dddBasNko+luZM8vAGnCvW2s9X0E2UA7dxUcNxNpA==	14	iRk9bRdyWI34YBmvYuykEKU9b/ZGxEXk
1487	1UR7jXWQNAJII5UR8dhqWZdrDPdmzDLuuHkdL2qOXKRccxsOIaCXyw==	14	o3mfOTP54mRB0S9bA+C9n+APO8Uk3AHr
1488	yYpWGb7dF0FLzy6jYDY5+322UP24ImKOxBuqWo89bv0=	14	idvnOPmZflsDPgZM13m508Vt5jBxvwYI
1489	1Kpcdakax9Y7zWJ/MUEUnm/7uWHTQ5DeUmsjynS/rtA=	14	KtrcS3qhT7PAeeolXbYN1aZfNtQ0gEzy
1490	ZGZNbvnHSsYb1wu/1LPttdz4nxBCp1izOSVua8UO/Ro6766fFo8u9yidd1n+mTQT	14	jpCkdKsfvfkDY8Rilxwjk9h93ZIyJmhk
1491	ZMqp216VrpQceffl6JP6DYL7OEUIdTnGnmk8KLaPJ4UUIUwf+2l7LlbUyvHJ/UGXTEIGEsAbze4=	14	RLJe/zLutAsPICZh7EgBrSQaVZw+emoa
1492	riGweREZKaw5JRkqB5bfAOe7R9oAzmQxh2eIdow//hWosg8/xGEoHxPIBJ24PaNH	14	vE90GSg2Sgk/fwWErH9RAExsg9+kXSEC
1493	74BAUucjiLRdYhixmmHrPrgSy8WE8CXmQc9RhvxE14pjIxojFnbibpHlAV94R4uz	14	RbfZj7+LpHS6qskcUCqOxoXkQMffyTMn
1494	43dqL77kKVGz/9EsJAYqY8wJuaJbm+M8RawUY07RXjUA+vrsHkfgxbgfQ0iiYUnKM1msmA42zRU=	14	McqDsoLksXeTCONrm4vITt62VskgeDhO
1495	iPEMATTogYPLuqLXxlqRJn5UBTqOlaZ0nuir3Z8ALkF43JT/NfXoVw==	14	aPT9kNoR3N5uV951aIiQ+tqGYQd0vG/V
\.


--
-- TOC entry 1876 (class 0 OID 16938)
-- Dependencies: 1534
-- Data for Name: hospital_ward; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY hospital_ward (id, name, hospital) FROM stdin;
1	wp8WYti8lmQKdihya47Eao7y7s+B3q3l\r\n	1
2	oKIgxjQL1aWr68pLJ/Oe1pgW79ub9l0i\r\n	1
\.


--
-- TOC entry 1877 (class 0 OID 16941)
-- Dependencies: 1535
-- Data for Name: illness; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY illness (id, code, description, exempt, marche) FROM stdin;
1	H/94mWsLAw10zaps9LTrRjHUqKKs0TGZ\r\n	cgjUFI23Rv+UxX5bNjC60QEicO6u+ETV\r\n	UvWCiEwklfJ0B49uCDBDDA==\r\n	f
2	/8UFcQzDWDsbpCFyYRhOQyQX6QLGC5Du\r\n	6gmwMjc8zL/KpJ/aPtvxt4Q/HGFK14ZB\r\n	qxr8al5TZNK3ObkJEQmyYw==\r\n	f
3	mGGSGslwnxE9LdLttLoV56jlGMhQpfWg\r\n	XHtB59CFBXdu/43WF3FyAbHOjQ8V7XwM\r\n	pfKnL6qBaaPCp0f3RsNVGg==\r\n	f
4	DlIS60Lp8H6TGsg6p6FGASLJuWDeNHy+\r\n	fF6Lee2ZmU46GlV0qCnPtKOO5bT5FGXf9MpBYdl2sgi+OY+jtbIv6Q==\r\n	t+kkhDxgSa6UgZNxPAg/DA==\r\n	f
5	XbvV3R8QRnkGajr5xi3i/WQBqUxIanEP\r\n	1Lu6KRFPkoBk+u+cRhQsv2HPBV1FlXP2\r\n	15LAH7irvEVnqpJ7hJQcQA==\r\n	f
6	I8J7meJJjhqZiRphEUYga/O63HNdPDDF\r\n	2OqZ9Odr73vdNNqTVPkMcSc6jAdwc7MPVZWemcliCcI=\r\n	W94u6P7RhPo7uCLJtP7Gow==\r\n	f
7	dp/+/HE6HwN4IPe5XFVz3O6+do3SIRiF\r\n	9PbOSkxZ7LRPapwLJbop/pAmhUiiqufCDF2MlfP9GswxncycJzZpUQ==\r\n	Oe66uwY5W8Y4EYpwgmVhug==\r\n	f
8	sYOk9NGKMby6sB3krn9SpHkndKzlpa5K\r\n	70C8eFfryN8niFmLQ/D4WRF0zyUzktNpvO+i6X6ImLObg7SXHfCX/w==\r\n	eiDxldMntbrw3uG+MMArHQ==\r\n	f
9	JB4ZyFM7j+pAesc6bFt3MWgkBcRZC8Vz\r\n	zV+bpiCBMiX/LuyoKhS0D9ZqgRwp/0/CIhrgww8ZEj7XF+xZxK7vjQ==\r\n	eC5sT/2/pd4Sc4agibCtuA==\r\n	f
10	l2A1MRv+YbB+203MEET40Zv9nF553gCv\r\n	zvv4COVlZff1P1KaWtLSulmth71RzPHunOMEc2PyHfvADWRaiar86JxBGY0zICSCv0rC7ooKIqc=\r\n	hYLckkGSV6HErcHffi9LtA==\r\n	f
11	FpFctYTAQJTZ4s0MYSWDqL5EAGpTbq54\r\n	uTt+VG6nq6xK57ZLPzfh63ABGajjmP2OTu02Zuf7wElya+nnpfCBJ2jN03IwFX5tBG+cp9iq3Lk=\r\n	difDz+jN5dZ9Dn1HHzYgLQ==\r\n	f
12	morzEGbqxzYxsFWvZHAthacLeUba1lFX\r\n	a5mXu5vwcZb/mdgibFwpUC1yR9MyRb0vhgK6vaxyDdSIsbZjp8EqDml32nfFI0b4v/jrBIVkIjTN\r\nnYWHekn8SoyXNd62V7So\r\n	58qcmrzEHfcxptmuo0t+tQ==\r\n	f
13	WsMHC7fU8WxGN3I+Xl2cCD+IzIqnmCYr\r\n	OknMKyRiEsGP/7nIwvhMUOJ3ZTv6fl+eQ2KUTw5qQJqfyDZR7GHeLA==\r\n	6cK6ZgfMBLXJhr9GO2waHQ==\r\n	f
14	c/R1eB4Xa/ZpXH0bHKKFMgDjBV92A5as\r\n	v+Cc8A43ipUOn1O7VpYH6K/8u2WqvmPwaAvUFwcOOlu2qP7z+7BpOw==\r\n	MfK2t6GvvTJqQQA3h1/uBQ==\r\n	f
15	8vVVS52z842Q2iciQxUdwqnfaRqCrNh6\r\n	XDDwlIqNoZ6UisElArtuW6+V6/Dtipj3QIcl5yV59Og/LIk7NmKSvg==\r\n	rvOEXQCNcV4o173qyM397A==\r\n	f
16	Me6rAcrmE08f5HD5BwCJscDrFf3Lyges\r\n	BAM+K0qELvJVDWlgOT4mDvbN0bPVJGYL\r\n	kJTllID0nARn4/ie2H71dQ==\r\n	f
17	PqWuhD898f6Erajj7KwA5LUTjl93WNKj\r\n	hT5dsTWJzh3voo6hZw4xX0r3WXXtC0g8\r\n	gLN+zanfi1nnWCngkt30aA==\r\n	f
18	dgPJj1cDvRi9VkGbb0s7rmfIRM+BzOqY\r\n	WJIa4Tr2tHJC9oa2bwNT10Ud+znKfKPesyprNLViQ9bZx1fMnAPb3Q==\r\n	VYpCbO5ZcOW5x3dAYsXibQ==\r\n	f
19	9KjK6R753zMivtVDSdlGSC+ctZz4GV1o\r\n	oElDLm21f8ccUf/dOhzYGVXW2NaBXWK2ch0u8dvWaN8=\r\n	xCzWA8lBImsJS9B5ZoapCw==\r\n	f
20	gfNfbF1otjHwkT8yrBHWwsIQfLqNgpee\r\n	3Zd3reM3ZuYTo2yzxlzIsrINU67mIoGNlolEeBocpklM26GSzJj4Lw==\r\n	vSE8bJG0lDLB0WduwGhV/A==\r\n	f
21	qQ3pruxVMxbtL13VIFA6KoP/tB5PX6LV\r\n	yb5JWxJuB13E9rIGG7RVgO7PG3LgU/l4gf6VAeQyLJB7t3pOk0oivQ==\r\n	9OBmRGr9pq7EbbJb1PmIIQ==\r\n	f
22	FufxUti+0YRwl2mFvfrMvfNnQ+ogXLk5\r\n	DIsCjkUMTVxaqtVmf/r0vPuoUZXTFcVeTLbgh6UEwX0NBJlIheEAqFCRkJKtjdK+\r\n	51QiDjEGIqNVgLslSZIeBA==\r\n	f
23	6kC1+Lw0osY5azWTMbJwM+Tk6EDq2U/7\r\n	+GQVOhk69Km/FBwUw8GTJTQm1L0YNyLfiSeHxHT9bOE=\r\n	LSjHWv3O9C7bvraJp44mPA==\r\n	f
24	vQq0pK/vEaZmM50RmBfmdmO1R0SCtcvR\r\n	gZp9ff7fGAf75/3OWJB8kkKd3/XAUYfNSsK6yb/4nBt+c1ENlrCMeQ==\r\n	Rc7H4E+Klfdsb0WdKjGR/A==\r\n	f
25	jxZPvJQlkad4dphQrUCEp3rp2AhYOtSe\r\n	aftWmLGzcFXMZTI/WtuEgsBXK74wDi8E\r\n	pln8XtfFvNtYmrCJUY4PHw==\r\n	f
26	KXkY3iJP2QGPsxWrLCe2rSMrDhmajPUJ\r\n	5qBsUVj8+uhvJY1Py0eawbXsoSrgCNPDNAPptrqweGQ=\r\n	0LH3t+wqMvJUOHbYRkHAtg==\r\n	f
27	NRfC+g0Ib3d0ytEzbtPC8xXTBm91Gofa\r\n	joQuLawhZ3lw26ktextPYARILBPEGrxgSZSYMIFlbDA=\r\n	mOTCOVdL2ypoObbck4loCw==\r\n	f
28	98wZhapecCi1I9hPAUz7KpxUP3Xjn6nI\r\n	I905QPY1JUg6FfpCiIHH7xYpdAriIwqebZywI/z2Ryg=\r\n	1R2rtX+ts+rJ1pFgNkkj3A==\r\n	f
29	vmxpbGRanNQjW72+bFgD8Yr8QgjzL921\r\n	kL6Z/ogoIjql7wJX4i+/oSfWEtWuj124NOohjoxQNod92B4sLMERl3xspPv1Uas2\r\n	Dg5pKa94lyN9Y+PQD36IAQ==\r\n	f
30	5tITWBkj/BQSFtVVBkXZVFz6xbsQcwTE\r\n	i9CnT3DNJWt5LZX/Uw0mcKwXEDo7nUuFbKpud2kJM4c=\r\n	aQc1WXrqWaUwtiHrts9Dsg==\r\n	f
31	RD1EAlSsE5D0uNwG8qlH67kUsz2Z0AKd\r\n	GKjmlsa80aSbFIPzgGEwFMwLbZ8ulFtGwGmq2EwHl8ou8EnswbHsbvXhgi1HjwV6\r\n	J52u9661wysBKxIJ84gRxw==\r\n	f
32	C99nLW2Tyv3veQ6HYChjU3Ql2Cx+oqbL\r\n	HvJ/SrNISKI8pNL0IrexmUJcHeocTCWrPHubNLFsCrYoeZMbH6ijrdTnL2jWSIU7\r\n	5HV8/UVToK8lAj6MbX3yag==\r\n	f
33	WwVCfv7pcZTbSYa+/DNRQNt64FJpj8L/\r\n	rq5nO2koCBRHhqTMRO4CZNz+DCmfvyl/\r\n	tQioPE5dK2puUDCK9iPXgA==\r\n	f
34	zc6CsxiyrupLGV2mqEDC1mwIS/hBWlUe\r\n	k/Ki3Nn9S6pEctVCaxxNnNAmzRarDs920vGHKul9NZ0=\r\n	953ye8OEj3Oh75UhON+5oQ==\r\n	f
35	xAPJvar2P8t6zph7W1zCIIj8SwwKzo3s\r\n	xYymgzAKCen756O5xnl0A/fByryp7XTi/qFz8cdd23o=\r\n	7i/ET+2R5MFH77FiW9LkLw==\r\n	f
36	pGCOVJnQZZKZ3Xm+oEsi4scRfcPDueJQ\r\n	8fsd0ZdQOVC7KoUjeL442RaYxGXqWNRuhXfyCK3Fe9k=\r\n	KqV6N0J59am6ykcFf2PgHQ==\r\n	f
37	xtd/2alCzUeIN+n/xiNuaCumzVfW8qwW\r\n	fEFdi7HxR0XwzXQWt4c8NC/M/3U9/gWsvXelbp+YolM=\r\n	BBxoTxL7M71Yu3ty4M+Ixg==\r\n	f
38	LF5T88EjEEtNqFBHVS2yyMK9a4e33grA\r\n	OBDLvxXgbQJoUabauHDQ7q2ssKb52rgyomU7g21C7hSQMMf+iLlJvw==\r\n	mMpxIzDSxEsXNTx7p5U8vA==\r\n	f
39	EH6AF3ekULY6dHQTmY72QIKfruKM0hJP\r\n	fUP5J15A9aQAuKLfEqklPnpVfzEDqtQeuN4f9BYBRGAKp5WFuZXUtA==\r\n	YHNGjyoFSTSFuGC+rAbb1Q==\r\n	f
40	5OY+mB7clQ3ldL6N31JKTmgdBdPec4RL\r\n	jYwnIYixUaLXooYjmDSiujEE9HLWbgfPBVA2fwHmSiPwKZgohNrJAQ==\r\n	9jolxAMjlGXIKbO9taEHsw==\r\n	f
41	3ll4z+BD9OKniiMQ113nPSH8FTXcmY3q\r\n	IB+jjyzTR+KhmMKii5eD8AW9lPOl0dJdqZzDCyqUncSz5gcCEvaauQ==\r\n	8LA4hVpb+cMtv0VyowHBfw==\r\n	f
42	wDEaXgIt1sMPrbF2M7WVkHoH+zMVmxZK\r\n	1bUimDlrRoNQ0uzsKP5NDoauEWVUVGWOuzkO+GQwhzwbapdBf0e7f9SvwSqg2R8vq2c3VE0Dc00Z\r\nevY1sFS5dJAT73s89rx0\r\n	pXlwlHTfe+j5exHVcWMhPQ==\r\n	f
43	lNMj/Qexk54irWF+dvhQLeT6zyFKLJKd\r\n	S4OQKD1NT2NYQmWBmG9Fxkml0ngBTay1u0E0ZfrKrzrdSDnz1wFb1ahmSkafeCcW\r\n	QGfGt9XeqHSpDCMkGkdr9Q==\r\n	f
44	igRTP6nEkyf+jgzTyvDYmuYWzLCJv6IW\r\n	e3GBMyXiunQJDj9INNiNoQXVH1xdVNKSdCtN4gsMe7LvH9RgL3KJ3Z7Zmgwv0eIl\r\n	Izq6BO4Y7LofGkinY5vKgQ==\r\n	f
45	rQEvnIy0j09c2qRzsoKK3joulVaPq7HP\r\n	HfeWMkCmm9UuS9/mIjZP002Bos3mpZeHhuzFUt0j/WYbi1VOfKDdfg==\r\n	7vN7bh3m+WxLPg/5R2gR6w==\r\n	f
46	QJ9TziwYGhjk0jh2Nnu8/o7zGA5EODIp\r\n	caObZ1FF+wS7fazrlRtp32SeCiE84KeZmDs6RYZPhoFsLfz09ET/wg==\r\n	85R0g+Rv2ZvwRp1/1LaCrA==\r\n	f
47	9iJNqdMhoBxJQqOXNwuk+5RUxNqV6Hmi\r\n	YseSEArcQfg5m7g8KnCFkbEkUJ7xjttgOkODe3UllcY=\r\n	odxl33FYR09AsrlOS+RfVQ==\r\n	f
48	fmiIyRbGcrRXl40JqRheXwSifF95fNtR\r\n	BYS5Lz3qS2Tw2vre3EoioOH5JLJUNIBCl6PKNYIokxOyfmGBT1L2Ig==\r\n	JI8AMAmbXT3L0EYBaBldLQ==\r\n	f
49	uM8cYxcI13NvMemXVcVt96NA0TFWo2O7\r\n	BtNcm5XOdKjrTmFih0srK+3UB6W1j1uc4yToCaDM0Ng=\r\n	L+90YKtdTX+9gcsck6OF3Q==\r\n	f
50	QPK6n7puPI2DZdx8er0wYM0EuVvtKg4s\r\n	8Hmriv38rifyd5y1+HMh0bfXjEsFkKcLteF+xowsUHY=\r\n	divwV9WON6m5/uAQ1F4fvw==\r\n	f
51	cCrwuTH6bGyKiVHnps+IsSY7oMN1NKNN\r\n	ZMzx01/nh6yxM6mSepFUSYMKzlTUry8EEafgOS0c60s=\r\n	bqBEh8VkJey0IW5CYHc9jA==\r\n	f
52	z1r9gH8/WMx9GsClNISKm2QjIVJDzxvg\r\n	NuVOl/TInsp2XEMe5Y0EvJjCas1ahHz+MpTx7KR2u4xQeJyKeurCVQ==\r\n	wLsimgIyp3JwCF+sh82g1Q==\r\n	f
53	osGVtu/u9iw/DCxZ8DmNSYWNJIk1jlsB\r\n	RgmxmUSnp3qKq1LJr/DctYsFsj3+I6LHelkcJEYT5l8=\r\n	iS9888rVpv4JgKyjyGlO3g==\r\n	f
54	y0mFNnjPm7nDawBq6PyYJ9mebvW1QIRa\r\n	PfTLWKDAQpvxmmBPDSNpJdGpxb3wamidkt2qhkyi9RY=\r\n	8JFZOt+rqgXJtKs8Df1xPA==\r\n	f
55	Psf3TsR+5J5MS2AcH0ZBbQl8uRvzpZlE\r\n	vmg3PZ+emrUVgodtMGFUHnsG9Z6QLRTm\r\n	fY3pvyv4WDywt/jKGOuovw==\r\n	f
56	d2/8IFUgOZXdDfAOR7ciaK4xnuNGkY3E\r\n	ZyOwnbGEaZtqNXRZBxHTv17iwMeEq9sXH4bsDSV5JOM=\r\n	iR9zXku/Fa117kEgVR1S+w==\r\n	f
57	nbmhjg1XRl989Q6rX44nVMNpyLAnXA5g\r\n	3yufQ6JB/Huokq7st+72DCKM7p+NfGg/XQAER51b93MhXlzPxGh1W71uPSXGzpPt\r\n	lkJLvO5ihAkyY9mkexzO/g==\r\n	f
58	nFzBbDxjDXdJ2fi01j2gpNHca/DnDWYv\r\n	hsvfO8QFCoWK2U867XiydS1KTxdVcVtd4bBFEe0PrmDatDgEm+41lA==\r\n	JtaxuII4nZgt61Pba8ga+w==\r\n	f
59	SpqEkzdMPBVw15ePyH84tQ==\r\n	YLBbpFZuuPfY4yTkwivg1+zGQB1qXuE6VpqcVBRZjnUvY778bUoCFJkPnes2hi4yNEazQNAqH/th\r\nUo/jtBbsZssVgdjQWSVEunNT3oGsVemrZ7cG9N3FCN6mCNU2JfRUJUvXe4U/poX1E2N5448OmjOy\r\nUkwnLf4Yfj1nkLEu1mgcYvBUdVIiJhEQw4+haIH4\r\n	pAMAA2umCUK/e6zQQkrANQ==\r\n	f
60	Hfoh2dLq0EeFEEDHY7jGdw==\r\n	QBDwnYBDX+ySJrMI5H2XCgqbTEtfJToAyqX9gWCP/kNJqh/KM+xpKWooxHjc0a7Y\r\n	d+KK9Klt5bwT5nKwy1Q2dA==\r\n	f
61	RW8v5ZThuGcGCbjH2ucrdA==\r\n	fSxTyN+tRWdh/3xYjEls0HlZgXx1puj7y3D9z6j5taAx47QNwO7+6uKlBSuZaZrM\r\n	9qF0znjvQZ7tQ7aeTTkHvQ==\r\n	f
62	ZSwHgaVtDCji2N4kgwa/IA==\r\n	3boyACxDcwp1BSSAQW3PsyvmvJ3g8AWTqjBXaB/h7IM=\r\n	iGoX26x4mvU2KSaftCOuHQ==\r\n	f
63	n2Jblral/rj2dU/N3fxdvQ==\r\n	B82zIREqklVy1uoxcTUVuBFx6HOwpSSoI/eJd7qKcQQ=\r\n	uPRliaz1kWLA0vFNrMVC8g==\r\n	f
64	WpSPu+sJp2FNYXxtDzXldw==\r\n	PhMZ/r5oViG5JZ1R1LRzGBrLuvQvUPDGPvrJd4qM8gAigx+oQWaENSdsFjHlX1nA\r\n	LpMZCr+D1lPYp9aklQhFIw==\r\n	f
65	aAclNm4+j+6HgkP0Z1McYQ==\r\n	+SvKSOthKsdHxs7BeCpRbJ7j2dLCv++yixXJUw1gIww=\r\n	a18iF9g8r8zdDH6wQ5owZQ==\r\n	f
66	Rr7KpLmei/IGJom1kk/umQ==\r\n	KUab0xk+qILzACN2bZ7hpDSiJEAErqz9ZH+JWPBOZlY=\r\n	X7ALDK2/hyhv6PWhOs+Nlw==\r\n	f
67	JaQ3O20JYyhFUXrrnPoovA==\r\n	VROzfAaxtOlTQeW0zD7Noc8/FWYzq39OTp5p8a3QwrE=\r\n	aWu0IvPZeiXApFeYWlOCWA==\r\n	f
68	eHlKkFiyenldhrD6zd3+pQ==\r\n	HTW+vD2OxZdluaaU7nhJHAWBLcyrZKs1ISEtRImnzH8vXTOCppoF1w==\r\n	g6wGtu542GnKyqxk07D5qw==\r\n	f
69	HTx5d5w1iPYKge7b06qjlA==\r\n	j5+rW75xF9UBTSYRq04BZlEh1vf/c/OS1Od8tzmReyY=\r\n	W5bQnsn7dX6LJGTkQtQH4g==\r\n	f
70	ZaLpXQkffymh0jrtNwQ6LA==\r\n	Chxid4NYf+GOmtjR1odm/1g+A3idhEYVESqkS8cZ+ewmOgrSVsWCgg==\r\n	08NZVzJFv/MMfglyf1vTxQ==\r\n	f
71	wAddTidOKE5AZxdfMmQi4Q==\r\n	QEHl11tgTCoXZ34GTD8FlQr6by+rkWgFHaaIZxURVIkGrEAAqOgL7VFScFDyC4sv20P67ecU1+YP\r\nDyA+0GGNAyV7XP7jHs5ZBEcoNeg8Lqa18VP1md9fNUjFkc2xFdzsb8ni/UMOwSAdeGXBeJQEBieF\r\nZjphW4rYcVCYJr4ksKMdcGE2mIVQILW8008Rcx7ZX6kPh5iKHSn3z8ACx/i+4A==\r\n	T69pOl72H32wKM9SKbpbUg==\r\n	f
72	dY2VEYGtOLRs02LYz8z8jQ==\r\n	vee0huJlguAHFQUn4jHTP6Dcn6Wx0rmu\r\n	BDHEos1LGAgStPv+CEe0kA==\r\n	f
73	EbEdMJllW9A9Xjvf2huK4w==\r\n	UdT8i5pbbvOEjV9ojFPIMqYS71xyRyU/DsmU2g7pou/Iwbz2B8z1TKWCXvC0gpOc\r\n	EuubS/xsKaWIQd7K9C1T2w==\r\n	f
74	kLGZ6u9mRtyUjaz+1MA1/bj7RUX/gjVo\r\n	aX6i+F+6THSkaQKxhREV10p27zcOYsFpK77TxMOvB70EHX5Nh3zb2Q==\r\n	m4SCCLJzqqsDctxB9UtKAQ==\r\n	f
75	JntczHxmg15wwnAOETixsd5Khx0bqE5Z\r\n	wE+mQMwmlb7WZlq3tjuzc9M3MbZohent/778Bh6fPtkEVeF3UtKb8Q==\r\n	JXW3kiY9GkARZqZZPok/iQ==\r\n	f
76	HDGLxMf/p5sz4woWMKlQSMEic27wWkcB\r\n	KBQjf1YISmYOvXKUFzNPo3CnF7rbQJNENQ69hvm1Npk=\r\n	reqh2y4Cden1QIUID48eBg==\r\n	f
77	UizYWTuPEnpct/2/T8TwGpLI5sgZrbEM\r\n	3cqHjyKpFitdVKNQux7k1vTKyf4xp5Patpp+EQKlQ3o=\r\n	h7NXSkOwAFSy09pSTtlLyw==\r\n	f
78	Cayq/HQrEW3PP25pboIix8WvFNPrdsxx\r\n	IBkduxypXg/rusfn+pO0NoQX+Kd4Okc+ofpIZd2aMH3mzIoiuAbivfbjILIJYyNy\r\n	+nrUjY7fKYEteLupInzFGg==\r\n	f
79	RmkZc7gzBzvJTqqx6Kj8V4kScdxg/c8I\r\n	Z06fynTFQpNbe8gifa9XA7ptJFbHfdmHtOG6aN1pa4Yh+/qs6Yt5fw==\r\n	YAUICZ3QSFddLr7cHrpP8A==\r\n	f
80	7DqMCLkNeE0SWkgAbsXtfs3n46Z7qL9X\r\n	cNp9ay/Mv1p+On6xTbIECxNZ+gsJeVD6\r\n	xuOBqyP0GutYWAx/fGMLLw==\r\n	f
81	ZzXI6Tv4DTIa7u2CSj1hws/u1Zv40vq6\r\n	o+IM71/1aKnyLevuigCfSBlv+H/BA7oy+aa8E45YIyvnig29LMxPpg==\r\n	YkShUFxLddF1HpDCcx1jXQ==\r\n	f
82	zQ603s3kaHoOgd45Vcf4HE3NLzKzGLVC\r\n	QTh/wsJacGAjxesIA898G7kg9MxXS8DTs2Sr6mjeb8EvnLVu0N/oHA==\r\n	nOs4ZQPIJlaKJVqKdrnb4Q==\r\n	f
83	zVtTo393jgj+ZIYY2xvVA5prNCelQxBp\r\n	FZ2HtkEO2ibP9LR/PHRJj04STdJdbJFS9xYo5aAvtQI=\r\n	S+3q/uENal/7qZrXWrn4YA==\r\n	f
84	QT8HxQIewMcKeEamQwQ5x1SwkymOAUKd\r\n	jqk6OcO15dBsEdu6UHoq3Dus+uFCWMsUTyVKIIVnKEy1TLqmihowig==\r\n	yGjnFGMQG5nMAK65GufK9Q==\r\n	f
85	RSa8xOyEBPPBV1LgBHcxdtJF4sj3toGi\r\n	W8986F1h5w0p4ETLDgnIUfwYZDqFWfYAM/qga/AhOXs=\r\n	YTagIIJRDorONOHaWgvgLQ==\r\n	f
86	T51N7i5N0t/nOvMYdwprIN/pgP9xYwq3\r\n	MJqYK7eb7RrvdJmKngOB6XpfQFG7oQMZw+3w74oMySM=\r\n	0E4VDfYF3RVoeR7k5/3nUA==\r\n	f
87	pGR+UTrcH69TAM0LfSG+KnTSM4SWWt0i\r\n	i+RgCRCmkQ/tomKEE96jrYsdp2u2RYTHfo1NF/JGDaczHrVDeWjN4If2R4Aug1Ohy3v+YzQojIY=\r\n	v8TasxLL901USTXmKITeOQ==\r\n	f
88	tzFBMdVWB1l2SQEOy6LiIb9l7lxT3TbM\r\n	rMYrGTQLIteP6QmXAZnH0ejZM9kaj0obNh4xX6NdFfs=\r\n	wj4MHoN4gkR9hip6VKqHHw==\r\n	f
89	pPLLq/k5SowhTLJfmYpQBt9JQ/d5b/Jq\r\n	FTp0hoSk8iIVyVLN30QfgvIqeDTDHqXq\r\n	7tNbwxqYSU4wQi/76ffz5w==\r\n	f
90	rqpgnFzrBg3PwN6YBRmMfkndWrGQ1ZNV\r\n	DcTxcGxli2+n6lWMHOesySntUsDBgHB17LXUPXSdydaXBX6x9nJG+G4hIGlgY7+cEsFMpSL8Axct\r\nU2HnZDWlIbldTxcTRVBM\r\n	u3WAOx2Eck6j66Ix9NWfdQ==\r\n	f
91	NmR5PSXD3meynmYbOOjk7yDvfaL53PSR\r\n	hfMhImm5mVrAL3nNwgRoRb+jYOtRS+a2U3pSjCtloog=\r\n	5afigIZJSvjLRhYaFlbbmA==\r\n	f
92	eiqS/4snrYtGsLb13BnAV6Rdf8M5QaEw\r\n	lk5VJGUFSdCu7yVt7XtmN2s20BYTzMXqaObBnHQZDDk=\r\n	QoxnZEo/g7iMPDfe2iYjSQ==\r\n	f
93	5G1z/uZNZRfeJSJGp5yHf0SDAM88ewwn\r\n	dLZ725OsGrPLaIhTxji23KYZaROqPWCy3cjoHGd8q4s=\r\n	fyHLWAwoIpd/cG4qKpmohg==\r\n	f
94	XSgdoZtapjVqrYBY68SENQJhsc/aYBC6\r\n	siHGXx5os3aTXDN0UCX/8t/LDw4BJZZwNB4nEtnVH2EREmQXgJNeZA==\r\n	I+H6qg7XvSVJPhtOo0qnmw==\r\n	f
95	iEL195JZ7w+H+/ZzI2s2sXDMvzgK9/Xy\r\n	TboR2BDntrGDeDSlj+urRgzgQnkol3ssMZwfjGmMgYfrx0hwiskUHEvrr1ElT6U3POFTBmuqyDc=\r\n	o7yqB4qds3F3VxmQm9Sb7Q==\r\n	f
96	EVFnNd6oRlA7i+Y92U1qR7+2Y6BWFguO\r\n	oP8aBfeP8AnN0XaMfrnkvJIFsHFOz9UVnApAuiwjhs+RUOsxoJs9xRlMmAK6VeZ1dfNkohwEgGxH\r\neM90K2P7Nvsr6PLguQV7J8jCjkXtIJM=\r\n	Wj9TaZayyxogFVHxBW1apw==\r\n	f
97	s7lGeucZN4Ifia6QCtWxwZz4u6RkbGC7\r\n	77fGGHfVikJaKWM9ELXq2Pw7BH0mg+255MBRqnT3bPo=\r\n	N0tCgZufuyQfYZCsVZ9obQ==\r\n	f
98	u8TML2S16q+q8BDC4UDNCVxYlRqNaWlD\r\n	yFV8m9AVVoU9r+L866dFIIUFPeqbVbWb\r\n	MGJpV+EN3TQD7gsHIs0j+Q==\r\n	f
99	qn2CCF/iK5iMnU/sUyx3yLcXUCGCPOkB\r\n	FvC3oY8MlT3W/zveCH9Lq+l04/NkbYXg07UjLpumInmSXGSULG4onQ==\r\n	+PpeP5b8SJUqnFXMYsOrjA==\r\n	f
100	q8sLbK1pKo40onL4GDEXRtuSHH9Bg4Iz\r\n	RO8Nz5zQGSuaRx4Nc73ZFn23oXzDhsIp+WIYxYfDRK0=\r\n	TsONBIZcXgYU++kVFklMtA==\r\n	f
101	M4nPRLyr31kZGcMNzYwMFgefE/7OcCvw\r\n	8TpvN7iO6nP2dpSr/gIWWyYci5a0EC4AewGizzyIL0wtybakOldrTQ==\r\n	Grhxen0Tpf89JV6lfrBwxA==\r\n	f
102	UJLAR0dYY3m/RHLqHt9DZHBxLBuy3Gbn\r\n	VxtcyzhSqWgjeZ8UhnJeuA==\r\n	uPAupqh8YADT+ojtlRcNqw==\r\n	f
103	uIgDrDODxPSwRZwqE4El+rYfDrHxrqy2\r\n	YqLbLDjc7Ftdmj9T0eao6eobEksWshi8FpfkNZoWoag=\r\n	sVCLeZWOReq7dfTZUL08zA==\r\n	f
104	x4MOlsmDKxSaFwX0jW5BZ4GobiEkX3M+\r\n	akcD6wNma4U823SO/mDBRlUNX+vHgvxX\r\n	hDfZ/GHEQ2njZklrD+DXaw==\r\n	f
105	qsMD5QvqdyFCO+tqqE70mwQQ77BI00d5\r\n	PeK4RtQp8VC0YBYMhLdZieKJ7+aisB23D0SGBxGgrIg8TOq4/7JObA==\r\n	NSKuLkfI6mwKZEvluuorzQ==\r\n	f
106	K6jfB3hPVqSBrv3dlBeZ8SEtU/wKBN9P\r\n	DqgJrDkm0eskJe9HM8TySd1eNFmbPh0fOfgcQBptDEZwgtoqcv3Gfg==\r\n	ZenRIkDfQhW6L2q1959KKA==\r\n	f
107	CX5ryibW426QkqrIjMeAjXL0lVSEphAk\r\n	xdpInjl6M1EzNynIdLWUVALBKa75+yJoFjGSe421a+o=\r\n	CIXrm4LXzAWJgSfM5JE5Ag==\r\n	f
108	G3fzS+ltoX2tMbZmnCSXz2RZFvb/uPjG\r\n	wT0zH0cLt5NqBat4gixJ/Axehg9BDokCwdJDbijgh4HnK3YRhdJ/SW07d1jpguTB8zzmYuWedCWw\r\nOdje2XJm7w==\r\n	XCk/gU4UN1xV846cehGANA==\r\n	f
109	IciUVrax0rQ9lBATRsM3QvkcuqNSSmE7\r\n	IdyL7OrejQiRQEGwTiWZIdPKGP7WQqUbhf1qdwbZJBviA/J/NSnUFw==\r\n	BPO6kwlnvwO8fFqfnoRvxg==\r\n	f
110	49Zi5YjJmeX/bmgdQc0dctMPMsAgKGa0\r\n	X7RuixsUscg5bTPbzbnNVwNwSyfn4dlUX4EThmq9LthkfYNbSCdkog==\r\n	tjRvwXG0aY6trGMAQ/Tajw==\r\n	f
111	twaHnq4rQGEZLMYr9JbYOQpY1fzoPNKu\r\n	tRzDT1ExT1ulYN67pDknRx1mXHwh0wpShn4HSYV2VajTALcQJ+ZVrCoEdSWJEFpGLYDAJqvsAxd1\r\no6Slk6EatQ==\r\n	sHuGU0p753dGcgiExKLQYA==\r\n	f
112	XlaYlBnGl040jvOcePM9qMM0V+6QVU/1\r\n	Mm+51RD595aaB3wmDhgfhMYo678dqGM27avsMMdZk+4=\r\n	1lBd1LxrB3hB3pPx1Az66g==\r\n	f
113	h/iEtbZYe53c/tOZagLBiH6Dp0/JiWi1\r\n	o7S62/C8d/KpdWQ0CjoZZfSX5jtptY/e\r\n	JylIen3fMHaH/Bl3V6uz7A==\r\n	f
114	1zyflTMdoGG7Jb1O+V/U1tfTBUUVL5hu\r\n	ZDWldrvrDbWLWMCNumJlTpjTjUXOdJqo+BYXQG+wDMY=\r\n	CuM0KgIa9jT4JwZ7PAFgdg==\r\n	f
115	Blz343KPfWkMO2jXkS+hWleXPbz3DKGl\r\n	5N08eZfbQWKenq8ugQ3Zq/dcLc2/yQILaGpPxYyAekjPUYzdRZbdsA==\r\n	cGdCm43WFlsiAtcuGGe1Fw==\r\n	f
116	nhO/3vEZi+rvOKq/4Cz4wh0njn24WV9E\r\n	nbCNcwtSMasKRMLJVTQJ3g==\r\n	pF/M1b/XDeVtL35CjJ5aNA==\r\n	f
117	u3NQHyVbZz9ZzV4L/AqAfxmdDB8LKZAR\r\n	WqdHHcHzvsJd0dSxSyznKBn7PCtXhrXGEgvunMAx98M=\r\n	hrss3AscCr2xk5I6+IsUOg==\r\n	f
118	8/q1xfVwPi77DkiCPmXHFWRUvx8zW5sm\r\n	QtfUFFyiovSTQxtObaIMF7LiaPo2jJEvKqHjA2JjMR1NVcdvJfRnKyVOOf526gYY\r\n	T33sf0EwnrpyKKT4V/I2Jg==\r\n	f
119	DEurTHSMrQbwrrrtw1HB6WSTUAzYnByG\r\n	ZBe6X4YMObERm4R4Vw1LkJX+7KNdvgvez5E3h/gJgqM=\r\n	ArxSJN+cZw3OQTY7FtfZLA==\r\n	f
120	o0xG7G1t1fGhE8erx1AnwqTtWV+o8AXL\r\n	jTChzAK4WcgGVXh8iSiR9QrdLXDkVAthoYu9vk6dqENEV6+DX6CHQg==\r\n	lTgWsN9hJwqXNtyrnXrtkg==\r\n	f
121	E2dINJNZLWc7l0HJZ0Krx9Cs7ZCZXAvO\r\n	CzBmNyV61lmJD/fbqp1MGxOnvLbvksH4\r\n	an75ygkmlU3hbab3G1Ne/w==\r\n	f
122	P6JYPItt/89YN1cS+062Uq/YXhgsBbhT\r\n	+F9KlC7cVf/jNm0LnjKsWZkQ0xw7aXkN\r\n	Kgpn4t/1iCr416DPsIIhCw==\r\n	f
123	57aUkheawqp3Qq0qGUb0FhIpfbAHxMlz\r\n	kH1UeUJdmdFMjgh1zIV7Rtc0T2seVbq1g83pegGq8BPr5Wq0kvydHSw6V8PQRtvg\r\n	wNidevl3MV6dDzsVOVIq9g==\r\n	f
124	BlXUuLIPcI+CTBegO20dDQHycQQeeicU\r\n	CeqLXD6Uz1no1jMKCTBitE9BEq00nrag+ew5ELRDvz0=\r\n	/qPISZj7GdXLovjHIcDULw==\r\n	f
125	MC2XL95mlMBDBYovENh8ABd4csv+twP9\r\n	l9t3yBwE9CyA+PZ4TBmskD9mj4YVtjPWKUxS2aFFfRc=\r\n	Wbz75oZD0PMgQud2jZ7zvQ==\r\n	f
126	oaV0t1NsWP8r/B03f01LpeZ8Qbx5tIq3\r\n	BOjcMLo/2MN3xJqjxoXSRXRlSm9Tuh0Q9tD2fRMbw2oqdKHmHlWnhyqC0x5LqfaALwN37BRr88vg\r\nOAnPcAUUOQ==\r\n	/dSXQVKsCOrWdkZ490DQyQ==\r\n	f
127	uVefgSzo3+b0OiiZRBpgvFDraz4AOwdK\r\n	trDJIQR64BOFPi9OT4jxu5bf/KAKa+Flt6THMkyUR4k=\r\n	SeETUKjrXRLbO3wEgAuYWg==\r\n	f
128	tc2g2VcuLmrjdmeht1ZYeI4aEQKufbVw\r\n	Vl7tWO1TvBryA0TcYmtT7aFPY0TtU8svJnYyHd35PTM=\r\n	xuSHyEsp2QCD90AYUdaelA==\r\n	f
129	aRKR2sHsTZajjZAWiF7uBMlZIfHXhFV6\r\n	o+7ME85KNDLniRS9JiVyY638tafcPP3f2OzdWo/+wHSZm1sLcO5L8g==\r\n	jpojNzyUhi19F7he4P3rtA==\r\n	f
130	H+ZHYnrLrjjRBzJ7uWNIO6UYnACZVUG+\r\n	u0r/NY0TzawbFd/XS/fQS7Y5tzVeZ22Q\r\n	VapAFjF9W/YbyXUiv/soxQ==\r\n	f
131	FaAH0G67zSyWaXiBA9lgcku2AndlNVJS\r\n	20MrVxHc1jvPPTc+r9cZWAKbpv57P8jEv3KNjU9LG5BvidbeJt1ykvKzPkCxtxBOc8J0zzAzae8=\r\n	TT1GVLie83D8Y7D69Ile0A==\r\n	f
132	Ug5KqSIKHOrDDfr4wx6g6mR6rCdUmfz3\r\n	x+mJVq+6qFVBRuOPDAf8mNOSAjuAWhZ9C7hf7nJYR3Pnfq5IV4IE4A==\r\n	bub40JvzqVQxgGGtGlUm8w==\r\n	f
133	hwWzYmzqF+rpGEVPq9Rp8pR7mxunoflT\r\n	vrilh6NwZ4s6joV1qToQM3wTYbpx4RD+jrFX8ZjbBacCnUaXANd9Q7UeAZkURsy9\r\n	Qtqm4JYYXfTfp80JPCdVDA==\r\n	f
134	X+TtnsPHQut96YYmozldYDWoyHXAbk0N\r\n	b6t5MRHd9c4okT2P7rTZExEd461prM5/voEVIiN3iXLRFR6sF1vvKQ==\r\n	aLS2Dn3skAyW09vHaHWdmQ==\r\n	f
135	3IooWXobczHdJbIgZpny03TiSFDUwcXK\r\n	ucGFezE6mx6obSWEC5NtObribN3bJHXgjeCevIqrC3+2drHYS1FOyZZEksj9nkTmKkn8zC5Na79U\r\n1LhGyFPhJcPDVci0QqgNwF5XdWJ7yJk=\r\n	QKJVsMiAnDTpQHvHRKNZ4A==\r\n	f
136	MbKZP8pSG5jyridVbL5E0yker+54U/jA\r\n	BF8LXbXNL7bzljdW8LVhtBO0yesjajBVLnla90YRyLk=\r\n	2f514OvKnwJT596c4ezyQw==\r\n	f
137	KaFa8pVCZ/oAERZW2piRB7TEi47txosA\r\n	DmGGjZyeba5hNUJBqnCZdfTzbEh6MfDDxvfqQVnqA0ny7cRaGwcEIQ==\r\n	5Sj+RNzuTO36StZ290Z5Ng==\r\n	f
138	DVDUVtNwqwRUhhLB7O3NkbvOuMM4I+Y5\r\n	ENZlB9+LhFEHG4Q5RH4bZL8kU6cFbRnrtZsmU5tplQc=\r\n	erDU1vbJvJ96P1df2p9ngw==\r\n	f
139	5KAwluHSCCj0Pgq4alNxA+8Knt5LmFfE\r\n	tGxEXSg77QNzkjf7WEouz4qAzndwmUUtwNqUb5nfamg=\r\n	etQMC4vIT35gkNFR1BS5eQ==\r\n	f
140	1y8GGKT44hJgJ2McjxR0SV+hVC1PVlkU\r\n	1XunwCxZqOeW2VcejZbVZAzMy887Yd5Tajl3HZPRXXZQb13gjXnHRw==\r\n	pNnfYVcyuAG11okNog2+QA==\r\n	f
141	4L9yBjhT6X8Pod+X778BXxWxlxGgT4aK\r\n	oJVSTT6Nxz0BuCdQKQg4+HLgOvRp9bCRqPHuDAfkYg3i9ZESLhoasA==\r\n	uho+tnj0rQ9NCaghDWnZRg==\r\n	f
142	wC/NiHyW2mULmAmb2WRp/eiqdp+NM7gP\r\n	RT1ycTJmFT+ZEshkdpEvidiqu8boEQ7+EFL3bShVX20=\r\n	PiV12+v5rXDctu+Yw2tTkg==\r\n	f
143	8+V07dr4B1zkqVl64G/llB03BEG03zy4\r\n	mA+Rr5HK8pRDLcb0tcm3WX3q5yERU3KQ\r\n	84TW4Rd4153HC2JdtURYww==\r\n	f
144	AjiCNJVvuSOqUcQux+OmRFimfMXheveP\r\n	K+H2/T3EL/lUUN/QDqDRzKpNFIm0RRcVDE8gqKiSEEyQ5Q/Toukt4g==\r\n	jmMm2yXUXAIk4DUmlsqIPQ==\r\n	f
145	XLL11mMGJDQQZ12hHYRtaWLncKp0ghvE\r\n	XJ0AjLlsDc8/n22gzurNCBAF4AgUVXWWwiB6elbR9Pj4gZkPrB5Ffw==\r\n	Lak2TWxTseWzK/JjWOkZUQ==\r\n	f
146	QTnwAwnJ1p1rMaz2s28qM0pzjkrBjPgN\r\n	q629qBzxLakXrspIifpf82M4k3XsbzdECC0NEsJOUJE=\r\n	JbBziBACo5Kui1jPSBuF+w==\r\n	f
147	FUx965OhH/jJ+cxsWb/OHkdO7cmBAFAd\r\n	vcZcmKOoyrn1GHnAosQsHr10ft7QSVTJHu+31iR4nV0=\r\n	NBO+7y2Hsx3M9I4J+zStBA==\r\n	f
148	ldXuZ2o6tXWJXdq0TtrDGNwAC/JoHyUG\r\n	GOlO/aAYyu89e1HVSUAXdO6hx6fYOTkwUMGNnE6KJoM=\r\n	XS73zNOownN8Q5JaXAo8HA==\r\n	f
149	Sv2zYI0iZcBvngyNWyDVr1kzbC58+eCM\r\n	GAFO4KVciwc4rl6WMphi9Dt11JXaM4Jr5JULkmlgoDs=\r\n	Xtzk9o5bufQgMQaCRDB1Gw==\r\n	f
150	KJLtQ4vLvhoQC0gmRFNZ1hNldkjX+NFo\r\n	ymqx2WqlaZF8fISj2EsJWi/daxoFkWiFFkh/xYx3ORZ7wIQ+6mr7xA==\r\n	L5G3cSLjVg3yttzqxPNMxw==\r\n	f
151	UTWpNXVmoAH6QRfpRpgSNOc6YarIVpf8\r\n	wfiZQhHJnEssENOvSrZPEXSNVKu3kyDhOphvW3FWPm+xtj8XE6xUa15wnNgBFUCh\r\n	y8ZZOFnQU7/UxVzddvcDOg==\r\n	f
152	97YPPOM6ozPipBAVj05OhXtGfPGaumWL\r\n	nbEYDuB+vBuQevbj0Npg/pB8TEt8c8hhJgvlTjKtozopPyFqzjy0VA==\r\n	0eoW+VPiT1pITAZgsObx+Q==\r\n	f
153	9cm5kWMfZKu2P8vXVnzP9CyC2MVk7pfI\r\n	xkHnaJR7f8pZpQltKcEPfmWwCW0r5/0xec8Kkta8TqMWd4DcQo407utzLH4ikP+E\r\n	EadgLIRAR1rPwGImiYdfWg==\r\n	f
154	lD1lYe6Fk662qFQ5dlMrTRw6z0MeT29Y\r\n	UFA+IifsVJirBWU7iy00D3ELXae/uaL89uhozo8SAJNmx63mF6NbTQ==\r\n	2ynsn3DN1LO2XPzzn7OumQ==\r\n	f
155	W5eq052dOvRi7AcEunAQrQI2B4EL0Z7F\r\n	RwglHADKQXxvfptMbgkhS53atYFWmXmvC+SuPOghsNo=\r\n	m3oaYsZ+o1IfQrPXYGDvkw==\r\n	f
156	J4xQLSIi3zp7kbov2bwNPCO1vfLIayL4\r\n	2Z7v9JS0EDv58W+uLKUe7hEKfqThrEA4sTWyHX19mSDEtngw0TwVpfMb3MZh2MtylFnIqWc4AuM=\r\n	69eO8AKjk+EgjNJeEVVwhA==\r\n	f
157	6iPodyBIRpFGuCctspvulZz4+4ifWIEG\r\n	jLyfA7Q80cZZTUv8cd9cX6DYzQnmbeFudgqarZcERUDa1riOJNuWEA==\r\n	MIWXHkmNQSQ0aUW40ZUvqA==\r\n	f
158	bEYeAC5HSTE4jbofzKom30ec9RN2dq2c\r\n	5FloCG7oCGtRc2s/sez9mMCRJ6rrcOXk3dXDlRo/SVX9aWBfdlCIIA==\r\n	IhE9Q7/r2k5TGp2FKpfJyA==\r\n	f
159	+RNdC9yZbjyFvDTBc8h921BQLrs+LcS3\r\n	cUGHsInWini5/pDlOs31EkuM2dVkpBwb\r\n	P1CtUxGbIixMleY98HhQ0Q==\r\n	f
160	WS7xZoj3Snn9TW9+crWa7AADhN7H3lpb\r\n	moSp46PntzvDs1ujMuJtfSAy3s3zg7Uk1QtH7aKomrr65S7rahsgFA==\r\n	4X7BV5VG9M/vsiQXUQWJ+w==\r\n	f
161	kAdUX+FT/KSashdfasjt1NFZDHrjEmTz\r\n	VNDyK5fDfJqAXpokiGKFRgporYPt5wA7qSIN31xI7C0F3Je2b9kRUw==\r\n	caBYQOyaBL9E4mghxMCpwg==\r\n	f
162	skaK5RtIDs098qf8oUe4x0f/cykMHL9/\r\n	XPcZ9JsbVuEXQqRdd3PZuDiVcsg46QagDh6kZdWcON5c23dUns8r5DKVTAdOBqHb\r\n	2iF8t/a2j/dAyZvXRWXd8w==\r\n	f
163	KunAJ9WGnh4wfsesqpQG/OJsL2X3XjVs\r\n	G3MDNPFPbqR3UAKZz30j8o4ueCVTOIkQXEecVW7ALWgDmco6v/K+gJVOWdFLj/D2bTq5HSYrRHNM\r\nfIP6LWgHzg==\r\n	HNSyDxd5RfHNOz549UV/Pg==\r\n	f
164	SVtZvU1GGBANNcWL/P2daJvR0td8+MpF\r\n	0zws5QjkivUT71ueFglHCDLvyRgwHNwJzly3XXxfUfLXP/++zdMkoglD2uH4KVEBfVNs9qbXvjI=\r\n	kEQ61AH5SgFs6qmsR7PZjA==\r\n	f
165	lw2CocPGk/vhD6UFPH9v9wUBPwXYV1pL\r\n	q4hGdF7hO1ol7lnD6QQw0+IAXXDHXist\r\n	QQP6QIBwm8ff/051pCnAMw==\r\n	f
166	yptKgMzAMesvm3ueodwNSklf28CQsqDw\r\n	MtDNhNioQWhhk6atG/w0eHo3PqQ0i6lnFu2yNybZCqTV/u8FsJVOGoTeiegwQR0d\r\n	QdwJJ/zZaKiol0BldhD7hQ==\r\n	f
167	n7eCSXIWJGqBir8ON6Cnzg55W6U8xuQF\r\n	Vmm15x0NJ/sQBO02iPSSrSyU5/caibl2Wl169yJpXik=\r\n	Q9jMVqpUQHriIbhyWmSl3A==\r\n	f
168	K+UcICIE2AiYOCYAmE5BBkDBsJQhm6tr\r\n	U4dbSSgi5UFBOlX9HRgAUggh1+1mYXqIl6RXnsLnaYY=\r\n	+eqeuQunKzEnj5ZWE44xjQ==\r\n	f
169	GZixV31pQoX/oiPzUMIYfu5BZm5694UX\r\n	2x9f6OwZG0JbALwp1IT0kmvwe0brESWVhW2nhP0+KrU=\r\n	lOIDocNlBtOmDsl0RQdIIA==\r\n	f
170	uYV3mKWwZqP7NC6b5WdEfv4rH11o9H/d\r\n	bgSW7UOdslKUUO8aURP7hVUIDHGKYlzOJCQx37wY9ub6sY4HgVgYHA==\r\n	daBujhiiqoYCyVCq6M4Nzg==\r\n	f
171	fVz6VdKfbIIdHvHBSCauvXG6kbYbZYF6\r\n	5cKJHGXXKLQopQjS56XS0bGsD9Ww+fZ0udeL5We0xLoZzNHAOK09bw==\r\n	Gf6mUCmxSLYuvT3gHX7WDg==\r\n	f
172	GjhwzKCg59kaF7xK96YOMtGCfefn9ZcX\r\n	/3//OQ0nH3SiWXZZHU1WXAturiCxcORjA0iee8OyHNGnT4QRi5E0MusLaFV3DwsJQfk2Bvqf4j4=\r\n	WeE5zW8Drny8cnHO51kP3w==\r\n	f
173	uF677CmSt8TpIR6InL9WYsAJI+ao505q\r\n	421VS9YtugPbKAaTJGGY8Lv1Ftp5nJeegc0eHN22M3uu7Avf3UB8pj01N0Dyzd4YPDP27pRJRL4=\r\n	sZNQdSAPK9jRn7VnDDdU0A==\r\n	f
174	Zj4MoZm5Tq53oqTVOtiMFkSPeDx2Qp9O\r\n	rVSDQDB/5kG1nHP5co9jI/IsSD/ucRQr2XfRDar6tJc=\r\n	54ITiJUdqbskPRz31IAscQ==\r\n	f
175	KVhjadmnKMub4Q8J9AxqXoIs7nOPn81C\r\n	OGEFxA9LrwC8ZGtXvTT3GUpJnaQGU9cgMaDQEVTibPk=\r\n	PbOtdcfp7rqJE2wPA6ckcg==\r\n	f
176	jyYWKltbizs6kJY4V1opp62rSNhsc2QQ\r\n	sz5wy4zWHS9pisvAsKBPYdFUrgBwUXCfEZ0T01DBr7BSpwbUigiqYaTxl/9siv/m\r\n	vqA39v/U82rDZza5MdsipQ==\r\n	f
177	fLbAtPBH9jcToSQuLst2eA77jcjXFjpH\r\n	YFhTpF/HvRzmoSWePPk+vnsT+S/7pKtdrvyYAgePQ0I=\r\n	mkldSRIGGoR/QWENdbK6Kg==\r\n	f
178	WQtBReDwKc2D9TiK6BEVlY2tufsirEan\r\n	DO8hYsKO7agtXSsWVyqpn3l210/0cVPTp986o+TjTWC6uZNEpTiwiw==\r\n	5228IEf/mLMZl13IvIbGuQ==\r\n	f
179	Zx9PkFTjbwfPXNWEuhEwnSYDeqzXgn/B\r\n	0cXVDe8+i6kIxhxqBU7nUmPKHbWG6mNQ/8FvIXLKlbE=\r\n	6WJZh1FTKq587IPZxUopeg==\r\n	f
180	/QvW0RclWHl1qYUqXnQVkKiOFwdx0w2y\r\n	BY0jgpOGzb/d8CfLxVTYr2400U7XpEZbHvi+UHjCMMq1u2AH3v8qPw==\r\n	RmqYxa3IpFACNbQqjdAqTw==\r\n	f
181	mQssik6bhiW2WiQSPXFEDrITykd8Q5mr\r\n	XCBwtZV2+c0hjebJkThkX5fpLVSL7MMvXejur//dGOxFUg5RJd13GRuEGUOPGmMu\r\n	oMh5ObYlF7jkHCR+BBT8Hw==\r\n	f
182	+UfKy2BNHcxsAymA7UcwbRW7OOE3ArLQ\r\n	ML0Ma00/bXHHUutXaaiXsZ+V4l3sQ0EZHndto/0jFks=\r\n	AEoIMITzM8fHNJxbSYRb+w==\r\n	f
183	NcRM8BWudBIek+TDAaBmakLufApyC2r0\r\n	ZhmzaeklPwTLMfKJKGReNs/mux0iFDHn4wYk3WruRh0=\r\n	WroKs74wLb2f/SgC8mgNPQ==\r\n	f
184	QY4IwO0pRRXzx3hGuLE6c1H93tIZw9CJ\r\n	stQJx/fiD8YKrPD1E5gZhOGXw8l7oOIB3SKSo4yirfYnPOhzkEs5/Q==\r\n	JZwwffqwwbXgsf9Eswe0Hw==\r\n	f
185	pVsM7kd6bZRHHnDB8gR99fVUNxMZNOdR\r\n	EFK4K9taUpP23uSqBx5TbXxiaGay1xi01kVhiBKVXAUvMBqtxWSMGC0hAfYdegs1UV1ZumEBZo6W\r\nvkGH0ZQgvA==\r\n	WBnd3FD0zErZaXXfaxSqQg==\r\n	f
186	FchAiYulHRi/GZbX6Ni6BClGW0ZQBcQp\r\n	JKL2cEgEuMDkjrwluGaVs2ARMX3ayeje6z2cjKRBDBpSCYoQI69syg==\r\n	bcN3OZOt6T6yafzopdKDaQ==\r\n	f
187	boQPfnvXE55nbyvfbSsggmmztMmzBUPR\r\n	J9vBf6pFvno4LKnJpHctqXmSCSgXxv+PciDDlAhkiKI=\r\n	ktabr4WHudkPe+zGwZfx3g==\r\n	f
188	+7jJ+OZ1rOqsQH3kJMU5hz+jM7TWgk5x\r\n	LUUNuqBeHHULGMynbyV4Y5ZGnqlt5NNHZ09ZIkJjnMPwmjszNDqmXQ==\r\n	LhlR28591ZyAgWng+jLt8g==\r\n	f
189	jygNhaN4XmuGvt18f/w3fbTyexpWH7N/\r\n	H50MDl+btiXWrghUwS1bd9saqExyTVQAx5sJqnhhqRjoWE9S9X47zve5R6xIejqY\r\n	ZsxRYJhouShuG4SkIR6hvg==\r\n	f
190	VKCQKFLpNQWp6RmR0viPuBSdxBj5Zh66\r\n	HVoVNrfywVDAtywQyrkPEh/5N1MR+zMbCe0vLvXi0Ad3mig4PYt3F97FgIDfKaJW\r\n	VdRPqzIvHtEk+PPhuwdgRA==\r\n	f
191	/+4Tw8uOkied6voguRuNYL4MtAZfkHpl\r\n	K1lcw211rpN7qS+003F/KoxTd7Tsu+4Jt4EO32ScgaABt714AC1aK/xxkDSuVkxK\r\n	6eIqpbp7DVAcbOlE2+hm1A==\r\n	f
192	hmHHoDPE2AT1gflKkQfc2/UTVQMkRtub\r\n	wGhzwghvu6ode8SEq8++KUt6eWmg2S4J0mbNPWkD4jQ=\r\n	8CavjU4DwO82LuEN4vuLZw==\r\n	f
193	xTS5rmnSbDdf93MKqQDbj+CjmBo/cEf8\r\n	wGsZAb1H+cSNfjqAKRb8aXSR9/Zu1mEU475+dsMEnUEx0bvcALxzHA==\r\n	a/EMSJVc6xrv9AcGuN+iYQ==\r\n	f
194	d30Fv+TSfpw8SzSWaRe0TsWCV1xMuDsE\r\n	nUn+UN27FcqpiFIsLHQYR2DLrcvGOpoZRIlZ8CCPfOvk8JBcf9UQUNMVTnqlwcBmqJxi4hbLWn7M\r\nxwVVODxEOg==\r\n	gu+IbyUAoiyXTTvcQjBjYw==\r\n	f
195	UBjvst4Yu+Bkgq1i0Hlkqg9WNiO8ObGJ\r\n	v8HLESp7fAVnaCpzb2rGC5c31MIuyHKDuuV1NSRpK8U=\r\n	bxDmLAdjMwt1Hu34F3K5nQ==\r\n	f
196	S8nS407NfO7wFlXzaGvbq2anItCrm+Qf\r\n	itg5dKI1YEDvhxtwh/4D1Lalty3AZeG9Tw2cVo/JUg8=\r\n	3mhLwU7oTairgo9DvJ436g==\r\n	f
197	1PXuS3ImxP5AWWd09mq/dWgB26cIN+35\r\n	BNrHHJfr/JM04+VKnDzDy6MwUDp7rAFf53jzvBQoZHvwRd7v2H+1E3MHbJ6WtEOB\r\n	QD9F/W0jTjWCYsqXOqM+TQ==\r\n	f
198	6rFnz76VlwLIBH2CdH45NOZjJsqa1fMm\r\n	Ubu6JUo0IXLFCHiU7U43VOQ6g22QeuXRYuDBwTmzGUQ=\r\n	k7WAgQQ1sVCe0kdXZ+2QLg==\r\n	f
199	60nwoCgZURJicNUF6rscYrmV4Z7mHId+\r\n	CFc9wcm8T7iKvyMR6nx6VOqQA1OsJzduVgJEHNyW44ssVGZkUMvZSg==\r\n	cLOOSjNRc0eBLQ7HXchvIw==\r\n	f
200	gZiGUlL7nS0DzaNU+XwEXcCOVjCLjMDu\r\n	y+Z7em65XwlhxrRm4vpyIcpemuEAIAWNDcJ6ZUB6yCSn5N2qSuQUycAIcrim5pFRQznCz6Rp1sw=\r\n	35RDwC789YTv7gx2x3KGug==\r\n	f
201	l8K0lmpWdOAszt5zbRcLksDqM+dpeKW8\r\n	W4GZznJdTn/T88KQ2ghlnhdxTMxITMWIdL/AckL048I=\r\n	+CIVAJgdInhOfGqKTm4J2Q==\r\n	f
202	NmX3N6S2Z40FnZhkrL4zbrCSfrDiN6cO\r\n	6G29pDtdAezo7GHIMwMCuUsMhZjtSufrPQXFqwI6KU8=\r\n	uwRlgmm3wYyKZYOHGmE5ZQ==\r\n	f
203	moL84nOn831jvXpl4ajc2txQC6yRK8/w\r\n	GFPl1zRb1/UTHVhDDTftiCPRtOzeu2j1ioYXOyvWqMPyqRvdkQgTKQ==\r\n	XU81vmJlCovSF0ACaBTXaQ==\r\n	f
204	I9bo+Ndk+CPiHlOh52ccNXqrBb0X4CYF\r\n	P9y87huViMN2Y4zCZGXihYauYGCEWYfD4Y3mdUfLatI7wr5Glbk1/A77fmmqGRVAy4g1PG6n6Z4g\r\nqLQuOvB6nnaRrqJ1RV44\r\n	YVvo4z8HD64ZOVd6AFkn+g==\r\n	f
205	f+uErHb1noRJqLj5ex85VKTppou09ACw\r\n	dV/WpPaIk3vGLzp75r7+33PnS/YtM9Xy6p1ZOUFl7NF2FVJqDKvBUg==\r\n	B2ReqQDkMjD38tGzKQ5naw==\r\n	f
206	aLgPV7FuZ09s0BA861gNHaMfBlhbNidV\r\n	DBlc2T0G1G16NMgaSSAMM4QOt0KCgJT2ixR7wkF0trc=\r\n	o1vjA0n2I9dymRjCMz7P0Q==\r\n	f
207	kelepaQAKOTdlV5FryaRiRSR08wV4lb/\r\n	N9pvleyjN9OuO8I6E87s+kQUBwUbm12l\r\n	ZwtVwMGHo0LWMVs8+c+1Ew==\r\n	f
208	F9egh+z+6wsdZsGu2HcuYlY+VfEx2Au/\r\n	s7XyHHaeKgKFw7tB1+w/kngsjFICoG2V\r\n	p0BcUPTyoHywsJoLZ1W/wg==\r\n	f
209	CqGo/Yeaz8dS8ycuGACEHoAEZvsQv9mF\r\n	uqdzbNGQPEYCZjFBx2etGioFKfbhG4RxB46R8FE1p1s=\r\n	hnZO7RzjoqCmvOrcDIJOgg==\r\n	f
210	6VToFVdU8QlIx5PDpIwU3yNQ+BhjqHyy\r\n	fb4EhRfzAWVuxEA01/qf3dsLrpa7/x1QLcHL4lVcdsQ=\r\n	/HOg0JTgIIN4OewAbmFYPQ==\r\n	f
211	2T5niFZJQq0Ck/p0URqpqxES0FKP9ke1\r\n	CoZpjveLlvxShl9UeC7sCegYdiExov8aHDv8eaB54E4=\r\n	HNPsa/kw4eOif86RvPDYjQ==\r\n	f
212	DVrRpCGxWB1hFERZQ5kmhiTxTJm6nzoc\r\n	VZNYWL3bzoeupmPC0S/trs/5Vt+tuE9u\r\n	KUN3nyovkFGLlhUUOoE7hg==\r\n	f
213	7QGEi/Yg5mr23LwQHaSripXbYpt3PQev\r\n	pi0bk8HPgWcAu5aqAnnKghQCh1PPBDPmerP7CNZESPM=\r\n	XV/gIVJzTtbLyM+5rTdRfA==\r\n	f
214	2DvTFosbcSMRaff48qRrZRq24+HN+S1z\r\n	LW2fBwqZQ0DfB8dykaTBGOCI0z8gsj44d34TfYXUfgqijus4/l+ofGSBdch8AuE9\r\n	6trra/g0RsK64K5vBnO/VA==\r\n	f
215	MNLwvQS2ext42Rj0cztwAh59rKhsZ8fT\r\n	uBnWjrU2AqChO0XH2/8lkUhzkIFAMwFNGCArSuG0fAtQMkP67h6q0bCmEI5f2oxF\r\n	5pQ83TBV3PUUAk8agjzXbA==\r\n	f
216	XfPPr96Xfo2Jwx2CEjvvNt7CzEieloGi\r\n	W0ItDxvHXMFQXx480mwCHG7fTmI98+CV4nVb6C9iITs=\r\n	J84+VMJs4+ZOdW54yyhZOw==\r\n	f
217	S61BO2XaW1ls0/AplVXp0QLt/ck8fvJ2\r\n	/LJsdtfwXqHiCZufso7mEEg3+8yKhIsStQo8+9M4rp3KxUEgHqXH4w==\r\n	Wwhn3Wxl2xPSI3Ds/IVhmQ==\r\n	f
218	2FpJ+Ma6tFqVphmhPGo5baEtR++55Mqh\r\n	CfUdcFLehqfu0SPxZkY15J7VWv/xBe0nf6kUsBUeDPjc/3EldvvWuQ==\r\n	HuwSOKMixZ8UiSkTs6+ceQ==\r\n	f
219	eTmUnevYFmlfqHfszSeWcxbDxNLdbeT9\r\n	gMvzXDIs3DfAiMsEX5yrBgRYBikC48/+rBrBTwT3KfY=\r\n	Ty4RGqhafZdU3PuR+cxb4Q==\r\n	f
220	nasd/xnF3s6b/Bg2/q5klDyMoMluvYRA\r\n	YrPvSljK80gvgeuUMMQXe4bFT3pWx/7upDx3NaIaT4c07soeEPVqFQ==\r\n	TcbwJVnQOYnZiwvtyDmQHw==\r\n	f
221	1S5RucUUE1X/kSWl61+tJX24trjyS1It\r\n	Lmu3GnPFaeTqhlEgJr1ENNdLyqAl8wew4H3XD2atduw=\r\n	bEmgZI3CJP5eZEoWzeJ6tQ==\r\n	f
222	3n5FE4XP23lxB61e4QZE+JU2uker+vLq\r\n	33ze5JvUsXy3/gBpGZK1mg2lQfmy3FagbkaVfRVh9SMdWqupRg23PA==\r\n	KC1vBjNqO1ozf1W1GF99lA==\r\n	f
223	oASHfmQqI37SDUju6t//x3rvLryfMR9h\r\n	U2uj0OO0bQc5PCdh1niWIMqS+2m5dQObQIdF0a3zB8A=\r\n	f0Y+QEmErJKBv3U8VDSkpg==\r\n	f
224	1CF6Bj+xsI+Bt99GApConVGKQYfMvPJI\r\n	VZ3gfAR5RFDmSMbZ6y/IhaOn8A5SH46Bo/MCPPQW64o=\r\n	y78URvy4RwQWf0rnkVdGcw==\r\n	f
225	cRU1/xgUry4X3b2yMnqjpOHrrinA9MIV\r\n	bHP+qU0Xo7vqPOuVfCAqJvOZ0cwd83aAealh0bQTfGzBQRSQsWuFVA==\r\n	53biXCuEPlRqwEy9Bu5d7g==\r\n	f
226	StBYuRvIt9E6CLKjgK7mAeB3Sbohh9nb\r\n	LfuIH4fbJPSouWaXPnwb5PYsuiwLKtDbewWtYCSPaF9B2VZaG9aA1g==\r\n	6VHY4f/emPgguhDYjKiE4A==\r\n	f
227	5fgz2mRzl8Q/iAqOFuwzk4ZOKbrmKKCa\r\n	E11iNRZMNgDngXjYrpy0wSXy11/lmFmEid22ZjScCKM=\r\n	7Iba5jKTKwGVYpEsYDjggw==\r\n	f
228	CfV2IV8mXuGLq2LxFT/Uihwl3w7Wsb9U\r\n	SIDG2njCkzzD0Ep3TEnxDH8qL8xpkJ7hPhrGZ5hSE2PcO9LCz1lBxw==\r\n	HeTRjXaQUz/a2+Ddl+sOow==\r\n	f
229	EdWHF0CLZU5Rb1djJHS4C307IhgWbngv\r\n	AJwlwD7+IMWnfTm6ZWnsjTDMKKoNtSO4lcLYshv+opR3VHb/wqvejA==\r\n	WLZjvhJduVX2xYy35+QLDA==\r\n	f
230	+Erq07bmlgcaeWIzBUNB6hIg905pnRcL\r\n	0DvueV8BZcFbrHNpaOTGXUeplpbL5L9/NR2X4swFsa8=\r\n	Ps3vfq21qDVw2UN5pHYzeA==\r\n	f
231	I3/J68/DCMLd3bQzl4jsm/R7jOCMcsuu\r\n	MHeG2M39pJyFV33vdQLY61pWBwdYkXwlCqZ4nGY//XM=\r\n	CNm7gx0iUhRCtQTlsTVOYg==\r\n	f
232	lDiIycC1OIG2opuFpYyKT8KxAwhrbrAq\r\n	A9acZHP8W4PJmfWFu+XBfpX+5CdvJ3uyJoozMOWg2Ag=\r\n	HW9VVu0NTdmdeZ7S9H6vIg==\r\n	f
233	eTfC7I2X5Idqel7x4nBR4WW3CMux1L5G\r\n	aoeCIcXFFxNSU6JmV3WP0BM9ykQF/BvfwYAH68PbjeMcSwAjl838LQ==\r\n	pn+7StBrvVxTFpZ+spEOdw==\r\n	f
234	s6lBOvG+0AceL41YcxqJcOUNrYU5KQeY\r\n	e1os2AvmTsu1tKt5fOMr/8eIWWlBEgo9vZ6Ba0LIsMVFUzhE2jCDTUEN6BW95r0k3O6QskLy+ew=\r\n	MKPQ1YTjqXe2CTxbuOKs5g==\r\n	f
235	37GkLv23dn9FYax+7kXy31SkAWgOVEbG\r\n	Hjo0rhYsEUYIEDc3K/Y+QpN8FgGo646EvKMvxevrP07YwOFZ4bhDDA==\r\n	g6qglL6KiCcepSUKR8Q+ZQ==\r\n	f
236	CazOqzmPIvLitfFLHLKsztwlHM12u3IZ\r\n	v2nI/STHJxnWisBtUfH1VZQIwkHYq7/XF09QZp4id0tf8SlvKIjnog==\r\n	d+h6ZlNO/9f5PWiFFykHKg==\r\n	f
237	7YZ+Z+gZZ5Kye2iPwNa6KZHk+g5UQ18B\r\n	8OiKZTjwxhgHx5T77b4Epx/TxzSFNqIax5Ft0oRRpdGlP4VDGrHXtuuOzGj34+lb\r\n	EQ5jAOjHvWabkUeWLb1ayg==\r\n	f
238	V56RObZWRAKFkQiNQk4+KhqruwKp6cMf\r\n	a1/Uh7izdTV6dFVJ+0hQCu7NsR+yIGz/Duq6Ynm9vhFklpBcOM15vQ==\r\n	GNX2ZbWcVhkJV4LCZ7yf6g==\r\n	f
239	LRTOtasZ//akW3+0fpNNKlI6WCKIiM1l\r\n	RK8NvNvE9JQkblZqzg6EKIQ3vUS5B9pN\r\n	G3xpjVYAwh+Pd47eIJNG8A==\r\n	f
240	o1E7gFnQyrxuVSkQL5FWJOEJ08bxinre\r\n	5cJ4KuHc0u9xUvBzNJGeleygHto1SRjXKlCiPOp8D20=\r\n	uNA1CKSWiF5a8QqcZ/xliQ==\r\n	f
241	Jv/5LPT1j1NKKxXiSMR751OyB1ZK63LU\r\n	lDiBKsFqIgXBg2tCC9NR//PCAq6vbVJ8\r\n	YvVRDdbS8hiNzwlXK2QsSg==\r\n	f
242	+RHF1Mnh18IP8fMwH0I5iBeVMp3EZZ7O\r\n	4Hac4h8M05/lG7QkaB/PTI26Z9NnQ3M9mWeTQbgIBPRe7Z37RekJW3ttYUR61lkEKUemzMaqg52M\r\nflVSiZ1cGEGVZSvPpfbA0uvky9NFCFM=\r\n	6dvHOnSyf9D7/MvpP0wy3Q==\r\n	f
243	3aAGo9IqpSPHE2SwNafghkxnSkZp9xdn\r\n	AarUvlGnyXzYF5ME/czuB0y2WBoPTumi\r\n	2eR69npFi05VV7LAuV0hwQ==\r\n	f
244	raMW1KfXyGgLxPrkd2/1GIJc1oL3y1Jq\r\n	sx916s6kiVjAiLXdLjMpUmcEcFgFCrnmUksm0ujqAcE=\r\n	vSjY0/pn5WLrO+y1rbXWZw==\r\n	f
245	8dpjs85zLPo3EaRpQg5xacxH4FXXvRgE\r\n	j7p/JLpr1XQosCOJ4LftkJSBDROPoAR54YtHlTbbRGk=\r\n	ze998b37VqYERtOIYWIoLg==\r\n	f
246	gOwTnh1a6jdbPbhRMxXC/YtN/ejZ5sqU\r\n	DghEr8mgHpCJEGtGjEvjsTV2TQ+wiXVu3BPOU3u73vk=\r\n	J0M4Swd72VEXgAf4rNiglw==\r\n	f
247	GpqlMtNMI5UnEGHqIR5zXJ1YVhRC58Qm\r\n	1I9IjvOU5P9RMYMYXJ0rU5mQz04hLEHjPCy+sDRQlMw=\r\n	lLF5naIzOeu5C4EPI7TrVQ==\r\n	f
248	A/fbbRCYHS314myMQ623QuwP+O2ADHGx\r\n	W0lBKbylJb7/W+gQ/uc3w9QxkCMJ7mJ6\r\n	3iFJ+PH5cIxtCd9YW/5aaw==\r\n	f
249	0uUbU7a1oUDe536sBNFnxyasUdqEAH4e\r\n	Wnff59ejFbiLrLYDjh50OUNifi394OQlpycsQkLh11U=\r\n	ulyYeojQ1FkmWFgoGP6zaw==\r\n	f
250	MvE+rlYdf8FBB4P2esQjyclcQ0CFg1CZ\r\n	7JxwxgxDCoaYj2pyj4JCyY8HHY1gHxqe90h/dqElD/W5g1czWvclwbQUnQ7GoNew\r\n	Vk73CXkUs+EynHL55CZmwg==\r\n	f
251	TP05bWMLiJk3/ZHp1gz87HySLSB9VJus\r\n	IvRW+hmrR0inXOe+bAYeNt7NWGAL6ocLcFxx1ybk3hGxJt7dLBL38Q==\r\n	omyFgIJH1F1EzagWwn01fg==\r\n	f
252	n96Usftw2OVl/kJvlQBS1HbTA0oENdJt\r\n	XIcQK/lvHIRN5/jHtLgaPGszlHBHpdwGQsNW/JDtUA0=\r\n	nRbQhS4g+dHRdIb5KuQojA==\r\n	f
253	bvH8T+LhhGp+tlw+Hi9jzeCcLKx6xpEr\r\n	y74EtcXzG4i1DIuZ2JDtQAbr2sllN0BhuDW/NNXI+fQBeAxQAoEYDg==\r\n	mmD34Uq+969GZBgwSzZUXw==\r\n	f
254	mFBIaT2AsT7uUBdnPNb5m36UlMkju4Fc\r\n	VIIGYX7NuVM5/KlD6fMQKqlfpjVZSK3l9ROw2urDJzU=\r\n	LCFy3qDthxlZJQ+dXo2Rpw==\r\n	f
255	jZnEW1FKmZjiYn1568XbR++3ZlKItzyS\r\n	00fql9yyMpkhuIbscMbm9orG93jg/BTl9QnkqSPezJY=\r\n	PAbJG7Gu6ODgg9BdxKLnHQ==\r\n	f
256	Cs943qVHJOXGSZlaXgEAXQEmtS5fqgtV\r\n	y7t12pyJypHt97Fu7gSfhoCLIVqJOxzYwSUiUsjXb3QsX2ZqtJCZOw==\r\n	E23mr73A4L2gu3MeU/jNgQ==\r\n	f
257	P5atilyz8A+T5oVYTUnUE6pEl5aCCp6A\r\n	5XlY7hZ6zxwQb1xvTokLkrcWi/YxT0J7BG1dxq60OmpPldMIHuDRMA==\r\n	mI2mya21Cj3R9+Q9XEyBQA==\r\n	f
258	WTLY3/CtZGXoGIpR9obwfw/j94hwF40w\r\n	qu4zFiHrt5HzF3+0SLxB8ybW7b2DxQvDmvjriHa/gm26yZIyE0LEzw==\r\n	rklqfG52NKEQsCnR2PRVAQ==\r\n	f
259	V8yUCFAHCC0bPdNzsKgbNZeEWW3Y4ZqI\r\n	Av6SgLTz2YADrco6S9Y50AK3qq5k2Agy4RWRArJj9Pc=\r\n	qasLtI52+ul1jZ1pFBSzDQ==\r\n	f
260	u0BNmV8r1bVbI6Gpx+CN6TeAASbqlIdL\r\n	lb2lPH8/IfXBPRpxnnC5gCpawuata+EjIV0Uu69WCHQ=\r\n	riV12LZfuj8rgfDmObinZw==\r\n	f
261	mi2rcHX/1FMPSe7elymSckvzMIYkoUAf\r\n	pCceAzu2B1CXjZh40oCidK4L1NmnDBSY\r\n	9mXNBbDEgWWZo/b8na3zVg==\r\n	f
262	qdZ8lBgZoHPJnnuILhFkCA42/oKausx8\r\n	MQbxpnHynlKuztFpsgHJMij8XyXYulVKmQoa+zFheYTDZmmLuJ6MGA==\r\n	0z9Z7QhdoxbqefhOyyYZxA==\r\n	f
263	wFVDfMfoZLOJ805VIxyS/LbU29no2du3\r\n	lvDY5mgnZG44GqZg+Hgr8nMhgliAU14GFhQVwcOWsmk=\r\n	NrBkIvHw7mGh5VFA0wfYcg==\r\n	f
264	rTzqOzSfqljnKBOY5RqbL5EYsVOsrm7r\r\n	VbDnU6QPvOt8AMYHqUYkfafnqoJQK89q564q0jKvZOu4BGnhFGw+P+BtkwAGShXL\r\n	FE4Yl02PEVwR8qdVs86KnQ==\r\n	f
265	du/YwID+OjwKYPdirH+tjzxvfsubZprN\r\n	l9Z+KKYFvmwEVutIE48JCCvcv2NfBnkndMfM9eYDkD0=\r\n	/B+iHHCgdgSgUgi5SqWalA==\r\n	f
266	haUAgNX2rXYLiUSxVtHQjN+MLOgZk6BF\r\n	JfRzNLMSwzplxBoPK4qWfydmvp0hfqgE\r\n	We41hvAyYfuQ+jtiBGl+uA==\r\n	f
267	etbJ3BmVyjww3ZfgpxnTNONfsrrxtSjV\r\n	FNAejgxgdo6gDKd0/qfeFJ/8XGFQIKqqwNuTT/PQzp6Ug5GJGgbvJ1pwieHcKuGf\r\n	yddI7tKun5p6Ve66MLx5Mw==\r\n	f
268	TcpXvor3DE/GTEhMWwuF972xo00hWoVy\r\n	gZD9PQUAowHQeviRP2nFvvtnwgRCEl4Sk3zSKO37lRE=\r\n	Goq5s1kuo38Xd8Bq2HqFEA==\r\n	f
269	doWLwy83Rv9FExmL9zeUJKUN78IpKw8R\r\n	51MBnw0RLqYldZXnu6KUDxQ41knRsBptHIRRq3DMeXCX/YX7nl2nyQ==\r\n	8E8yylTVS5IEJqV9br5REA==\r\n	f
270	AmAmzfozhGiknRdkxsMzNxKJ3XRWqLDg\r\n	ku2SoLmXk5vVYo6GtfMi5+yUedCJ4izdkBdGHduuV8nA5IydsXuHsA==\r\n	X2rHUCjIAm+75BupOyS4AA==\r\n	f
271	0sYFZJDyKxbykzlSZEQu5n4WG71amSMi\r\n	/64T8vnZviHBKSxmIrYMsveZ0ZkAchukXn5bTLaYAQR8/a/hw1Idkg==\r\n	GqomwttWXSW/LmKS+OrlFA==\r\n	f
272	QYE+LgEG/BqoePOd9N5204v6KkVqjDa6\r\n	cqw+2AcCIvog4AdIu4zJtzAzql6d04biw/Jl28KtvlE=\r\n	CyzJc/h9ypHzEerhmIpU6w==\r\n	f
273	rpU4mu4p4Yr/7TOx0ylbBSffD7PhWThc\r\n	nEb8Ck9ScCOsw9OzKvr0hsOJA2H8l2LuXf8XM7G1JiX6Rv0tLeiH8Q==\r\n	34VKleXmXgeUTiIJMz2oYg==\r\n	f
274	h6QIt4slM9Xlgk3WAnbD8bxq7lZHy/nX\r\n	cVDdDj4ITW4LMyBAJMe2nPSqiR2cx0O0nOZwPO38Pmg=\r\n	eXiVpo2jVt7HdtSg5PZ+XA==\r\n	f
275	Ie+dN8pkM6K/AD7zP6FfkiOsyg9gosfV\r\n	vsS9pC+Q0WIeanTZRwMgUSXH++Fvoyg0rmhoR7Spluw=\r\n	DgrT/2JQhiuflyRuHLkw5w==\r\n	f
276	n4/PQ5MSgxltFqwC+AgbUkg+YNNjYx3U\r\n	mZbjjQVA0ToodNtOsAhVzuj09C5nk/fr\r\n	Euu8tf7xT+c84UwrvcfQ9Q==\r\n	f
277	7JDdr8jOrYNwfrXlLuZxL7Z8kPtokSuZ\r\n	suARtsWJzhboH5V2fxn+/mFl4GqlLtb0DjkCZRoG0PWo5+8yUtlwig==\r\n	h6oApdgU06z6ojjId9G7sA==\r\n	f
278	n+zZxFwcieJa2GqokatgIToTbCA64Lib\r\n	K1a+L7b6OgFwvBeF0i0Di4mBo6f6uzacR+kZPcrCPig=\r\n	j1D1kXUukGHZKSMDbSe6Dw==\r\n	f
279	kIvIvWAbu51OfxCGPfNSkAP5daR0/Mrk\r\n	LewT+UXmY40ds8sjV/mYExrjE/nshzTBiPERK3IDd/VLX7rfegsT+A==\r\n	ub0hykdgReXWXkAMbZpovw==\r\n	f
280	88bgRf5n9U4vdBPo36g6zyvuMymm3bb6\r\n	cUT9Sbn1JO1Di6XTcksiwwPObXPgnf0IzNrLdAT3AFM=\r\n	kIt03b7ExaFAfFLfzHk8Zg==\r\n	f
281	Le1F77atpgOIfu42udUJ6R+YcpT9p67A\r\n	jHcSUYIuK4/eiMQBjTpkCUZ5o3kOYWD2\r\n	B00efnTd5kKnybzN2X646g==\r\n	f
282	mUzJVm6jj494Nq6fv+EqQAydMiTrljmR\r\n	HcZ3aFZXo2wOpW2NskFSpTd1HKIMDehW7iPxoNxxM0I=\r\n	ZWTQ6M5Lwft+O2UO/8MNcg==\r\n	f
283	tBRM1i8asm2Qdjb601bxiFf3D898Ntmt\r\n	0ePxbCU2NCqoj4MZ8SWEv629FsiykXovkWaC9nilVSubg5g/ueMnSA==\r\n	O8/ZX+AwqLycnUPzpM6jOQ==\r\n	f
284	xUGwJtuGIZu4VAd0SPw04eoJa98wxN4k\r\n	Jj0R908h7817zNCcOVB9dymliNPsXEbe\r\n	EhUCvMeHqahd8CFPUR1C2w==\r\n	f
285	zLsQPhAF7k+NyBVLEbXSZqRHoAQKjK8u\r\n	VrpjJXrL3uG8zVTfLHjrIipkaOxyEjXM7obKLpWfOuAsJIWf4fEk2Q==\r\n	9LTjAnHJYoTl8j7Up0vLog==\r\n	f
286	2QRlmrvHwPZiswxnZbL0JnjngCf9aOUC\r\n	aruvC6Zgf5/b9LyvMtWHlKL/EynK07PfuiuDoVORNcs=\r\n	MZufaoyUWgfemjmvL1wckg==\r\n	f
287	51cRMLhNhcsCEfek6IdXbuTdKvul6QJj\r\n	J5y1erVDVceTHoSKohiUWLmRuEbpPAErE9N6gV8+AiA=\r\n	xP7PhxzhJyQHbVlR2c3Sww==\r\n	f
288	Ewps9KPzZy56AZ6GyZxfCtRJrL/AJYkI\r\n	OxSMIdHXM8KfCc+EIHjqfjZkqIYNICHynczgB9+082/cJ2gk7eqprw==\r\n	8DZ+ZyGBtTvMYT45hjU9Cg==\r\n	f
289	GkWcdaLIrnc6+cilmra5rmrEdI+qiYar\r\n	yg5sk/Qatac9yO6g0JrJnjJNnHMF8haDUiZN8ZDFX0wRbgxRRYmlRzbTy4QgNogj\r\n	QGDOHvm8FBq9LHJDy9xI5Q==\r\n	f
290	37x6A64XxtrvPoSrW54eoLAwiiDDr7dt\r\n	PYy5WJXxTrWqzMOuovMw7lRICVNgWXECa4wbFBVNOZW0LkizsBMv3K0ckZg0beqW\r\n	f7AuVeO6QrkzQfnYWvrHmg==\r\n	f
291	zAzMmaDRyluf1rU136cE93/LAeMuR2RC\r\n	CT0Y20xywjyL7bSbntF/ag0d2p6aA3ZcicjHt0DxA3eXw/pb9/Nj3Q/U6wB3yY+C\r\n	LJh77JMWy7xZ+/yNwdHB9Q==\r\n	f
292	npwkLQbcI6rtS84dAy0UpFovMZWECJL9\r\n	UPvMMUaXvstLugIQ4Xdc8VsZbNVCYi5wHJSZtlxVxaXmPuI/+eyutd0ttrOh4YI3\r\n	A4bY0RGSGFfjwqG2oMlzxA==\r\n	f
293	gu0rGiRkgP7waco94lMI3n/6WMxlTA7Z\r\n	6I5e6ctTtVGQGvF2Op2Triixvq9xjagi\r\n	494eAoq3lEWxo5bETIiVaA==\r\n	f
294	PSaEN4zMNk0eMny7P0GXiNDE6Hx/di5O\r\n	83EmJWd1SaXiqEFmzprmZHdknBtKaw+xtNT4o5ld13EApoQ4u9pB4w==\r\n	AmKMUG2CSUyYdf2Ch3oAQg==\r\n	f
295	VU4hmDmfcyJ6bPDHWnpa6dFLImNvLk1G\r\n	zVmDipINMftRDUzr2ApsXH8tiRfO2CPnWlyQaLDGHkM=\r\n	64BBXKxWIavILLiqd9/jUQ==\r\n	f
296	RHoiQEs2JBvIqO8Os+09qkC9XpMBNWbU\r\n	JQ24u+CSQLAGRSP8fwxTMRQMb4gpka0NnEbuVt3XBx3KiByBedruFKQi8Wsb6aVT/qdOKmAXceo=\r\n	xIjHxt7zUHG7TUjNjCq1vw==\r\n	f
297	5jWB78Z9hKAEKlSQgvPifj7H28n2Z6MX\r\n	27xyziAVg7PvTbXUJ66iF2WntU9ZgPx8A6CxUVPvWsg=\r\n	PumtGHOcMWnyQeIaSIL0VA==\r\n	f
298	KimrPAWmRypZSJW3FzHUYLHt7HdklW8P\r\n	BqtXeRBmXmouLbNfepN748yAmxChzy6m7gZF1MCd+z8=\r\n	BrPyGxWxlCMxabIGVjE6Hg==\r\n	f
299	YYxql7qUhauyqrkdqDpeq1Pg3li7qUMo\r\n	SBOdD9omnEEr2OPMhnz/T8w7+A8rfmdNfRgpU0gNf6isTwF2cvTAxw==\r\n	3FYr2y5o3H55A529zbU6Ww==\r\n	f
300	GzLllpKT946LmrNng6+Nbwp1aYT3JMUl\r\n	63E0E8J5mTeEk5h5NiD50XqG9BKu4LSfi68Ggm1ISh4=\r\n	+7fjU4dQdPOESQ4wC8l9Eg==\r\n	f
301	+MHfwDaSYg2LkjbGG5LQ4MdOXCNyYbMA\r\n	W4gpDX52FtrZhUONy+QhrLnjB1FTcofIkdtKxtFzchULr8eaWz72eQ==\r\n	hQmwUJLZxszPlHLTcEYvpA==\r\n	f
302	fBexad4QsdL17h6px6o+TFyO45vkO+ze\r\n	HDYsSYHkBgoyjZIxKZSKHHWvALO1+atVJiRA6K8yoFU3n5AG3cPVnQ==\r\n	cp9H8aFDpVSfWkNpkKM1rQ==\r\n	f
303	mBafyaJtqDa4ND1rXEeg0Yg4dN9//qy+\r\n	BGrn66qY6X+HUepTAcRigPEn1VxFZWwSnrvX7bYZm5E=\r\n	i7s8JS1mdIa5hyanmp4vbg==\r\n	f
304	+LSVr7NFi3jcynnC2yLeeHknn0ZtCExW\r\n	XLHh018kqNdym/T652EwS1c6MW93VjYoHE+wTCJzmRZ1BZr2XWTVrg==\r\n	43/RNV6WdG7/gYF909jwkQ==\r\n	f
305	UcVH/2XF1wEZ/w9qfCTNzGSA5aRnbQSF\r\n	5x/YWwmGFdrO2sMu+GJEnvOkqASirIlQchzzkoKTjIQy60kmdzLEkA==\r\n	Su/lIoRjrII0uwQsV+RDtQ==\r\n	f
306	mQDxVkF44xTMFNbYmzeYVGUW61c5gHZA\r\n	MInk5oorf3IYNlRBy5DfCcPuanktpO6K7MG26wvajocr2uXWaEUH+g==\r\n	OdlwuClmYBi7eQhlkVE8jg==\r\n	f
307	tK2Tw+nztkeeitOFs2Iwcy+8yNkt0MPv\r\n	rMHamyQNm1Nbrvywhh/lc/B6QL29VlTFbjWOx7ol2vQp3MIv6BWUAA==\r\n	Kz7nR9D+h4k7ZnOs2OxugQ==\r\n	f
308	0ZOrkVbVcQATHiIl+NL9hVs9RJYs6EHG\r\n	cBe25HFySR6a20PPrXhf2rAM1piswGCvPYxh0UfcWTY=\r\n	eKCkiPUNYdf0iYvwHjPocA==\r\n	f
309	zKcvBAAznJ0/4ifcBpE2tJEMZRQkKK5o\r\n	+yGW4bXYbCqny3MH8ggU8RGsiiFlut/EyclrLD5GoFMs34HLoDV4J2bz7JxGk929ZRZyWY5IX4Q=\r\n	TUMMiev2le31VL4wp6VmlA==\r\n	f
310	5O+iw7nyjMMZeo7YUy4NcCpL8g39AKTg\r\n	Ox7UiEODs741Z90KPpqtaOih+cnXd0XaQgoCPKjHXSsInXn54lbSZg==\r\n	t6Gy25Es1Zdy+7DR5fWCSg==\r\n	f
311	hP1YcvB3VwyE12vy72O3Yp4FVqa+qR9Y\r\n	JS3OkQV4uVWKEnaM0gEO7sTp8uCu8z9CWyiIafHT4W2N9Rto+9K1Bg==\r\n	cXGGEfhlEWhUXHnUIBCZhQ==\r\n	f
312	dbE66nMJ5v/VXIu8jZ9wcI0zJLkCy5de\r\n	hu4Erl6r4ajWF9zciGb2RNVZVUzZCRSoQXcR5up/mvk=\r\n	e98nK1iadzXgSJCU/FvBGg==\r\n	f
313	po99cpRo+4+raq3nEklhqORpZdiB2Kse\r\n	XkIXMVG0PBc3M+9LinEziruiMm4itdo29sX6dC0gwulIL0a49KnF5g==\r\n	Ji+k5gnwSleitVFv0L4xPQ==\r\n	f
314	JR4lKO3RR/HDB0YmSrbQBmMpKuotCBks\r\n	Om17me64aRLpb6n9rC+FmLM7WdXKMb2vjzZgTo6QgEi5/020bk3ZZg==\r\n	AU89lj86/NatkDa3+nL+Wg==\r\n	f
315	K5U8S0PlPE/0yjzoco+QNZ2goxsm4Wkp\r\n	0YCzK6XoyMGR+nIHeMIf+k/eS4gI0G/Pi9SKxccQBw/L7+UFFfIAtYwmqFg808G677qjFZU7eZY=\r\n	gLRKT6aO9v1A4ysBADr1uA==\r\n	f
316	nZurfHjdXl585nIoDblLAjEQPl0LtNhU\r\n	OTGSfpbi4u2tCM06Vu3DBNSkEqcGFD/cbpBtBJoQjDLw4Y+i5h+Rrg==\r\n	b0jo/jp2twfFNAyichsCMA==\r\n	f
317	58HEkY4IeySHOLNzmAB2hQqndTMlGnhm\r\n	54QpOqgbctilT0y6msgxDDOiI8etZpS/aFI3qUlZ1jzXZcj3hs1cq50ohaFLpVWBHWPmDcXdDR0=\r\n	F3IjeqkG1TMaB4XjzBqing==\r\n	f
318	IZ+L/PR8G/a+c9rU4wg38kbGszV1RIyF\r\n	sIh2dcINZJDDuvk3RtDSnKzi50s6DSuz9WY5HW+T3mk=\r\n	hEKxgNwYdE7UykD8t8C67g==\r\n	f
319	ajawg05dKoI/GlNokhc4RCBUjvz1BMmU\r\n	SSRBBsjFV6gSfgSPQiTP7Z6rSJ6YmKR7W3dNbqLTcLg=\r\n	iriP2du/nFjazecw3zFk0Q==\r\n	f
320	6EuDKOROo/JuL1ODC8ncuHz56/LIz6t+\r\n	8pvYf6H4ennk5sQpoEapH8ny2gfnN5lHVR40wl7dChyjUwAa6F5wdw==\r\n	eelhS8kp3ufCBts45KQo1Q==\r\n	f
321	IsthI9aYDF+LgbnaLlX+qPhpV7Iqypam\r\n	3vvcw00UyvGFDzF+dQW2AkWNeFf3+29OJ2knvCh2KTU=\r\n	DUo5I0FQYoGMmEQzdDQSMw==\r\n	f
322	0GYyPDFqrOjuQqVg5stF+9zb/4gD8apP\r\n	9kZDk7CKEHCeC3MWi2WhpCvmrpM6pqvqef+ZXSWK+hwZoAgMFSMe8al0S/q9PnV5\r\n	x7Fy4zioEhGYYV5d3ApdHA==\r\n	f
323	GtV9IgBanXzfAvGJ1WN+H5XFU8+yRD/n\r\n	3TVcuhNswpYWiWt2ljID1IaSkLXnB37PKJUCTGK4Xy0=\r\n	xAqIVm2rRdAI8re0t1839w==\r\n	f
324	E05YGm+RjQ2JNPZZ1fJmhhXA9OtcNHfW\r\n	NRKwGxXnMLh1QgY6CcjIpqYc02g6mJiaJq/6qX/Z3W3Jqys29/zVlKyCovx3fXMZ\r\n	zIZp0cyp/V5YRi3RTx4+mA==\r\n	f
325	qd4g7RSyaEL8VDpsPLDL6buU9LnsAnYp\r\n	Q1mzGtLrboVHX5UkcoXkhgT15OKkWIeaQvdi/YqBGBY3MtNXw/X03A==\r\n	xrS/nIK4r7ZlBCT8/lGngw==\r\n	f
326	maIA+p9rLvz0hNaCZH/YXYQRJtybjqSL\r\n	cDkz8mR8/PAXybM9fM+st7zbiBcmiOlJ5dmKl0OQedNhkSNAopeE8g==\r\n	BXyQlC8CDl/j9yM4J4YiWQ==\r\n	f
327	DCAZYdgWP7DBDUNF0G8Bf7ZF3ib8QZip\r\n	FjgJxtOeB/GQDgpCA/ahBLG1klXHJ6qSAltX2plKbVc=\r\n	HcjE+gYOyobsefeknPSGyg==\r\n	f
328	J22gCWYN/2SH7DtwBVKt33xIObwAlOvv\r\n	IfcTomwsmeKUA3ZGJQ6qhIAa5w0Xv6u4od4tiDtSkbg=\r\n	kDZqlBEIPsXGN21tJL7EBA==\r\n	f
329	radBCMFHC8lEHmHpQddf5a7rz9ILa+Pk\r\n	j2LEGhpKd/H0/bqyK5tYtBe7y3oYDEl0ieRQbZbvG64=\r\n	Ea5ln4kzKE+onZnJHFJazQ==\r\n	f
330	JnoAPeYy3HEDioCFaHxGVRoXR67W2Uhr\r\n	2iZVpmShOMjWwhaORXeg6S99KnAZnBwa3X/S2hSg2yY=\r\n	gow0MnpGadF/XhCvgUbpog==\r\n	f
331	DT0r5/OBOUeHYATwEX3v89s6rBayCL6r\r\n	BnhhmK3XiKU2vZmEoWarxiy9Rtx3L3PtcDQPKnbX3tXaZfD82xpfgw==\r\n	yqFJ+O3pslY53SXvSlwepQ==\r\n	f
332	z+J/BIIw71tofQq31DAFXl7Q0FS6943N\r\n	v0wHu6vrJhqXaNSu7zX8BnSD9KuZEhlefwZ/p7CTzLmI/JU5XJp3IQ==\r\n	SDAFkv+EBfoAdBzQtoQLFQ==\r\n	f
333	18FJe/iqCnKyi5c1ysF50ug427R4goXd\r\n	PW8aPGjbpau39Grz756T1Qe+2kknBhypdzyTzu6sII0=\r\n	6ABdJXh9JhqsC5xt18Ba4g==\r\n	f
334	1hIpOTBlL5BUOYKpHdL0f7NU/AaeWC3q\r\n	AxsceqVXrM/FwBg/ZwGm5YvswegkNfM9Br4ZpFohtu8=\r\n	hsGQG10skABoiTK7JFw+sQ==\r\n	f
335	kqittIFTNc8lEe+kX3yQIcTQ9LJdQIg/\r\n	net5+TJ4SpswDaxXD9u+EkjVv2omuYtc9uXQ0qm/XvSlj+6MxCDsdQ==\r\n	MGjMHliWdmAEomQy4FRfBg==\r\n	f
336	MGIHSSvVLsZQfaFga1x3jdu1Rjc+iJjf\r\n	EETFVx5VuYGFu97F8opbDU7YBcikkz4hSvrIKK+5AqI=\r\n	6GfJPAUEWyfLeAaES43nIw==\r\n	f
337	goSujXHb9V9uZb08vkbx7NX8YeeGz6BS\r\n	bMH4n3yr0+wumK1tmQaW1Dk7fU8RV0ky\r\n	jRdS70aZiek8O43QqsQuKg==\r\n	f
338	+4XJJnj8IWYBBQfwEJrlYpjckK8mYK+m\r\n	8qmm13vmxGWk+fSz/HnNTzym/LTOgBpcBoo/qzSkTWCB/n0ersiCt24dxiNJCOenhRtiVcC0nss=\r\n	DhHSXw2X98SU+/mMjtjV/w==\r\n	f
339	jbcgc/IplL5ozaOuAXbnMuWAH/WmEqS6\r\n	yWzysQHAZW+XH5VdPLWnI+WbvC+SaV8tom+8rKAuNyni33QKpoHexA==\r\n	W4kgVrCaBoCJwKlJ5SO7xQ==\r\n	f
340	2K+WB7tVQAxS2fT+5q613K6IzV80u3Os\r\n	p3eZaqhnNCdXwLXom95hB76L1gCWPa+5ZkPFewgZyIqxpPbQoVz5PQ==\r\n	qp2YA51a48Xq66mgJJ0uvA==\r\n	f
341	J2WLO/apvw6BmBISrLyimr1oZNnFVdgg\r\n	FLfxS+XXLjVOetfrwHMbrx21Ot8hGKnFFPwGnh+34RxB+YqVdmKhkg==\r\n	om01QjkFZfU1kvlKMVkJmA==\r\n	f
342	c2WS87Zjpta5FSgewL/ubJMWyoM8RIxU\r\n	v/rHf09qVyBee69Mg/m2dYKXnGHDJ7YIDREaHi8k8mU=\r\n	HtAFpxI5YLxPuwISMidnLg==\r\n	f
343	o8sybrfECUG9ZcWh6llV+2j8xDDvnV09\r\n	uLbvi5UJsc6AtZYVftQ4f6pM653Qs96+YcBg2LG3YkI=\r\n	fYOWCuWBfeOj8n9B0B5H0Q==\r\n	f
344	VJoJaymxylthRLnfbpFE4J/yrb8bKJV5\r\n	fM1mxpFwsnraDcU/Y4yNjZNzAWDMTAq/Qfitrc/+kP4=\r\n	otvCjXytRM7NwGsRysW8tw==\r\n	f
345	OGrvZT9K0Oy/FH0ypR0N/Lga9IpYPm+k\r\n	TVEUR+MOW/Jnx+MYzfhDpNg9dxCqLCYCG239LEnlZAVa2ZZfBxmXTA==\r\n	B1ZoDEQNgbokUIMVEUqkNw==\r\n	f
346	eNekSfnlUF4cSLsvUw+mCUlXcCgBft9y\r\n	vfcUGtIgjUmssX6df1Td/yW520f3g5R/\r\n	Hg70WXlUi4T64lozgSDVyg==\r\n	f
347	9QQ/MgpgwyfcjN12kw5GrAnM3zXIo8sd\r\n	BUfD/dWgiEhpNq/HZtu1JvlBwf+3+su4Bs3fyF/x8a2ilEeCU570hA==\r\n	j85AB/zOoEk1A1a/RMKVvw==\r\n	f
348	GjN+tgAu0cRp9X31SB+kz6qAaFno/ZXt\r\n	xs5Je7F8vpCX6T8Rp5Q7e+Lgoia1CXQl7r4pwRJcKKdAa/KtEo0VGA==\r\n	xXZkJII1IlGsizuHsKgwyA==\r\n	f
349	8k0XTV6fhGwblE4N7hm1jrfDbjmkLZIH\r\n	Y8K4tcROjD9hYNYV5RPhcoh5MxKhk3+8xsSW66QpC0f99t1mTL9m7Q==\r\n	7FKH8LNZadPt3v+UOnTEpg==\r\n	f
350	vcTRkD+XaNe7ZaGzEEciwZJ/jqRZnBLF\r\n	6Mk6oZgZp7joWFeHACzEG90cNQdKEdihL2Dmn4tIxEGAxm3ItcWrmg==\r\n	abrQZTdKzBmac7arP367mw==\r\n	f
351	j+DlkNIuU/oPlVbVUzM8+7ACh+Xwfk7w\r\n	mt5NA1Fu+lsyFLYnSPHM5e2oq2P+l4EZk6hFCHSsCKs=\r\n	NusYKAJJwHDNoisrPEqW3A==\r\n	f
352	dkNCx7mkZ7rV9OIA4qbLuuKVPJ56uur0\r\n	PFMPlUAtsofwTl1IbZUEz+4TiiJLYJoJ\r\n	HH3naY0zW+6rPhr1/9i94w==\r\n	f
353	AcJLeDbLfe9ya/kKQwXSv5w2SS+Ca3Am\r\n	faFmHFdP+2u7h7Uk2JvLT68eTDdkziGIQcqKAK5UG7w=\r\n	YLdcQao7fkea/fTmxeGJlg==\r\n	f
354	ZDXoe7kh2rdh81+jkydNd+hW5WOosW0j\r\n	kK7O12VhTIbRDe6nSx5juBsHiu0Mw03XGG9h6ylMjAuQtfDALo6sqQ==\r\n	TGk4Vw4bCEXR8cbE1HmDyA==\r\n	f
355	gbkU2SPJJGr3VrGBNS8WUy1ocsRYnZLJ\r\n	MsQx7crYQQp19P2AT3H/Eo1OytA3AXWGg1aqAxFisk5bC4ahp4NTuA==\r\n	SE4bLC4beTZ519jcvxeJDA==\r\n	f
356	HTG6R+nqV/pmvdLior+MkVjlmiEEw/mY\r\n	EUVDGetP25rViFdNERn9BfdHexpdaVDlHLe2BtxKm24=\r\n	4wlSrt4Q+/iR/+Jtkomlsg==\r\n	f
357	IdpRyskIxmEmdGqdYuURPA5ONvAHqb5o\r\n	JLOKAefAJ9gEqmwQvXfe7hHckEauY1Cu6JYVs1La8btn5rWNWTa3GmYiwoZcAOYHSZYLBAszHRc=\r\n	bx+8990gCOWrR19XaaGG3Q==\r\n	f
358	/TxECbeA/ccuO7lnArJTwBGBrUrF3Z2o\r\n	cnrWDNq8lneha9L6LUiS5ugfyq9yDqunfk6GklCNB+YTK57vYYyXYJvV8d19g4ba\r\n	Oh5hUVUWFW7zz+NiWTZi+w==\r\n	f
359	yJh/Xu84feAtRsEgeJ/7r2V0CsgzA8Wq\r\n	PG9RmCSHHcBaFkMpyZFC2yrTRp/b6moXfBoFkLBnHvAaFSPoYGjpng==\r\n	6R272zXwXdX1tDEfBpDrVA==\r\n	f
360	xa57SzQxCWH09RTXLh/CBVGvqeSYJDw1\r\n	KH38VG7pEyAf0kPHbhAPHZmBkAtfNhV6xnwwaJuzOx8=\r\n	adMMxQnzWBEL6TSnBznmAQ==\r\n	f
361	Tux5VafU1rNkJxztIBHFN2ao6Ecr8T3X\r\n	y0W+1pTHAmXmL/BlVJ1G4tmchPGFaNcvZ9uTTwXZwmBW1th04nAfgA==\r\n	DeYIotw+HSgnc5hl2ksGTA==\r\n	f
362	cZMoIkApOEsNna8bEE22AfPxOJHVQzLH\r\n	1RnraJEQy39wErxfBBOxxebzAJQkCf+ZjtV74tgJjZ+gOSTJyWwnQA==\r\n	8q5mieDIXu5wJT+vjgz2Kw==\r\n	f
363	kYjXW97KZDFm4Btah3q3mNeBcUf86Z/0\r\n	5ehVzpXTfBl+2pQOK9bMajk65HKAlW16Q4VlebSNKTvx4FhdiRHf9Q==\r\n	CYZhjenP23ZldGuhXZb6jw==\r\n	f
364	cFP28/djh4XJuqmAvTCV0P+0Om9XcRtA\r\n	seXxppPttqhQOIDxDK38otjBBjGhZUhT8ZEpVOCR96JRvBNPGMeDZ4JX/Kjq1jOzk0RgvvgAHzo=\r\n	nEvmpqq3BF75rKjDyU48xw==\r\n	f
365	OffdovRwL4iM4nXH8bRrtI8RsJL+g0rQ\r\n	wZT/9iEDKRk6xbVj/9lRNu0XNKOs9dON4tJkPGyumvk=\r\n	UseKq50EYOd6pcv1024hvg==\r\n	f
366	kqL6BylcyZEZkEXvioO+Um0dQhuUluZj\r\n	3GkPpXbRx6m195jMOZZji8mTYDVCH8+vQ0F74w7UuAA=\r\n	KXcR0uxAbtfelYui9g1sjA==\r\n	f
367	8MbaT47vLWbI3uoYsvsjdAuL0bin7SdI\r\n	bqpkmbRPjlWBZjcgaj2L5qrTa4hUVK5g\r\n	VpxeyohQtPE2Pr8mb5h/eA==\r\n	f
368	6XJxnL3Ad0xG0R3GtlKECZZyj38KZTmZ\r\n	a1rYZ8NtBydF/tHnD30yPzH2GiG2iq7iwI+5uT5zVMg=\r\n	EU9bDHhj6PPYJYrrsHpnaA==\r\n	f
369	JJ0JTZeCagvcGT5jj0VL0SvTnqXugL3P\r\n	iQ2bdm8xrBu95FDP6I88Vpp6+Ml2IWAs\r\n	1JCbDhacGhl/pGuptHHngg==\r\n	f
370	IBSokbyAXOaDyhxHSDnZJfLkVVMDVb9R\r\n	H/UepOzEdwZgaoLsfatCEo+d/LmG6I8cu809ujDz99s=\r\n	7gm1C5doDOpjcyWm4oDw5Q==\r\n	f
371	4JvWq36F5x8/GNUWfpPbEO+dxRujOznB\r\n	1Xkt/vz4tf0h/EkSRTKkwIPncVNHeaYigpCAtQ1Eh3s=\r\n	fXuQxLvhOhB5uJ9JpRFinw==\r\n	f
372	yeyX18QeAmFS2Lc20FVFpTQP0sK3Mjny\r\n	IPgnfMvef5bjPA2oMGSF0hUYsQPY7DXj\r\n	rO1j4zGA9FdTvJso81haFg==\r\n	f
373	XI6bgs+U9BZP1ooa/bvahUKvconR+HxQ\r\n	kwVbFoCKvHWCRqqRPC6rqjgCjhm3+vANr//SJVJwYf8zmyLV/ZCRSWLpHV3GCBWDrGyvdj+nUQI=\r\n	csixH4EEAumYJtBQFP0quw==\r\n	f
374	1LnGT1mawsXLj+z3zVBEUAOSWBaGTBg+\r\n	2S8v+QiOuMXz6aci00ydYZwR4BA8b3XyoiIEiZ327Ao=\r\n	DHrc46v4tXCtMqoViNJIBA==\r\n	f
375	P3pfa2D/L+UuhGVGTiGtCQGKLfHi/QoR\r\n	my4cKTZ9x9mR3E40JtlG5aUCZMrELbK0TzniwwXnukI=\r\n	rP6vJ2SHlzoRA+Ngu0n5LA==\r\n	f
376	azqOU2Dn2XekKk4rMFbO/mtg5jAEX5s1\r\n	Xy7yVYZ1egATJLPUTHLdwobFtyCrkdoxSk0TWIFVv/x1oFcnnxhhbLcpbML9C0SC\r\n	pi3/nsjIT+WA+PcGbndluQ==\r\n	f
377	NKxU5xuCJu0wfZjWZvN/a0Yf7dhhNJWu\r\n	PrX4E61kEYnQcj6K7WoAF853+yRI4VqPHlWxPU1vztLQv52kRfVsFQ==\r\n	SEc6efuvazT8naJ/TnTa8w==\r\n	f
378	miogP44bF8hPqRFA0ncx0cmxvGouFyz1\r\n	mrKWBtYMJYif6gZML7GGViDeH28sGKFdZS5V7/ht3qQ=\r\n	EQNMBBJj41ARinBsCdLImQ==\r\n	f
379	4OJvkCO903ijeBN+BJB08m//UyX+B74p\r\n	U3qEQyuYZPuIsjl1Gu1cBDziQMYbg4Xt6crgUL+L/D0rz6ffwpC56GV9xNsa+y24\r\n	9ATPx6bdRytmH0dDHD3eqw==\r\n	f
380	E+E5dZlYygfbrK6eFvQZNKa4Cn8C1j04\r\n	z3v+q7KEBxmInsk6/Nk/NbqCUNO3g+TF3dzvUOyycXhABEncg5aY5KNWc+tKCf5e6rpBFXXWgSE=\r\n	CPbuAbekPoQh8xXkfE5kvQ==\r\n	f
381	Jv5HF1TOuMJvYfKJAT+YeCRRgUih0qZ6\r\n	uW6f8TjStHo/U9knT71MnJR205hb+xjD\r\n	KYxJoVEJGTA7qbAgfCw6sQ==\r\n	f
382	h1JnkjgTKcbawZ09OxKgHV/SQmOGnHr3\r\n	IseObe24pG7xpQrt7kaQhlaPN/gromi03sM2iVPw2lk=\r\n	wU+G+4wpVhTI+oZT0Q5nfg==\r\n	f
383	t3YLtTnltiqMwZ+9gPE/IRUfoJqOT9hp\r\n	Ru6C1vGFoQ0xjR523przz83bb3kjwIDPLy31/ANVcK+LvwDMSEYDCw==\r\n	Vj4HUc00jFX+n229WYSwXQ==\r\n	f
384	WKODeoD0m4Cz+aH54vFxrmHc+6vMthH+\r\n	e5H3q+MqxUKG8hrm/EwVuLVxVm19e4cO\r\n	DTlQkbEx5Ydix/p+OWXVmA==\r\n	f
385	tbEopIKbg9RUCwXHdITzOcymUzPXlP9a\r\n	TVJcZc59TQ79aALh/m5rS6sPfsk3qh+NFycKoA6N6ruyA/xDOjMKFg==\r\n	KmFepNDVcgE79+7rFlsY3g==\r\n	f
386	h272EXNVcnx9zUfKWAhcdQE5L+71/72n\r\n	JnaTvybPlLwF5H3jc0k3yy8ux6MgmA4L8FJhWJFyVdA=\r\n	Jg07X7iS5L7FrPtzxkEOlw==\r\n	f
387	CQrKcRh82/P7LYzcmNaxZtsk8DbRk2dI\r\n	79rvX7/MAENqInQmcTu/OlExnEzpD7zXMD8C1c012T4=\r\n	ZyhBKiZyah6bLMzmuVZJSQ==\r\n	f
388	EbOoSWUP9Rlb7MG/Ka+XCp+ZKoQMolF6\r\n	noxnPPJFcVDSQV6KdS9bwFWs9xIzE5uTDNBv1iyi5RSsr+H6YEy50g==\r\n	uhQBqTDfZhT7GqPm/shiuA==\r\n	f
389	btlxQpi+128ieJqCBOksqqGY9ZNVPTk8\r\n	TvruGMDtIY0qHbBFrkaa+FN0bFnapeacmmeC+qPNgGc=\r\n	RmoTkviedD/gR8ugCkyu/g==\r\n	f
390	WZvZyAZcA0dPuzmox5gCkxlVDo++P407\r\n	22no70DDSNnfDRZYHUYEpf7TSrdxQ8j+YHSeF5xgipI=\r\n	F+KjYNdYk6ofLvE0QY/ilg==\r\n	f
391	Sl0m2wEQHUxihCm51tgUHpE/V3U/3UK6\r\n	btJzkm/VwOQLTPOOYPf+BvXlYIMSD4XG/HZ70zYmT1s=\r\n	xeHnItRVe77THd+iCntuMQ==\r\n	f
392	/Thl6t9LJlprufGwA0gQhv+F1am7hp1+\r\n	qX561A1nJku9bDLvR82lJfEvahCnCSpqwftg/kwUjew0QvMApBbTUQAqfRbzIC4cpR/bZtBJdQw=\r\n	ShiezQBotW8+UTwp0u3N2A==\r\n	f
393	9ch4fJ3Y1N2eE/4+9X9roa89YV0CLx3d\r\n	SNxUKBK7cnyaYudBv5osCtY/3EXYFFC36eYZxlaOkkIay3gDfB4xx4iIu5OixD+4\r\n	mwrXwl7x/j/Ep7nxh/Df6w==\r\n	f
394	aL78/pOymro71gbjI+00HVbhfHhD0Jeu\r\n	qVYUQW4ytB06RCk30Ab7BpCBAEN4NKj52O2fCpUgQGjmcjsmK33BDUodVTJfpKyYy0fRuDHL5wU=\r\n	2HIrpj5vpvWxUn6Ej/n9Gg==\r\n	f
395	qhcpIib3GPH6FeFgr3oda5P0GjBqzQ5V\r\n	4EmhSU7oTuiLoowPG26fpswvTvgURzPw/sO5yX3uH1Q=\r\n	Cjy+mk+++zUs6pGlyICT7A==\r\n	f
396	dompZh/PRe3Vy2iTMtvnlpoubkyZDEAx\r\n	s+OX4Rj+WS9QFAaYZhmsvinKvFzXupvT0nMIrToTfdY=\r\n	lH8kN8sAhwsJC+y7/tnF4w==\r\n	f
397	V4KyWHfgBuT7wMcZU+OBcbupDc5wfrS3\r\n	DbEL6JQkz6vF0msQ1azJpYzaLyb+KNAQwtwn0huWLxQumMHMkFLsoA==\r\n	6wd+vI1imRpaC8Ts5HkvcQ==\r\n	f
398	a9bYdhdYWXNsUdacx8EQYEuQMu5B60/m\r\n	Mn8h97Lj73GzkB7xsVanIYGsE+PkMNbZ5/dKBGCUAU1dMvIBSbKUuQ==\r\n	USTtvzy1B6E5IvcoUX5JuA==\r\n	f
399	mpEFAZkrdhTH67GUw1T2KNxjjrxu0ubS\r\n	KJnIyH7OV773nrGIkpkUz8O14jMVvf4dGK6FinWiUCM=\r\n	9fr2CNMC4GjPlQvviu8uag==\r\n	f
400	eN4YnQ2rxy3sSMSmpjEMjXVrCmY4dDxr\r\n	y0Jm8xyWKRY2cyQgI1nUkIJJS6q+dfDN2fDTz4+ngXeDqOPufPqbiw==\r\n	VcFQWAueKtabR+yLikT1Ag==\r\n	f
401	FPGxCpum9K0/3/Id2eK+M+5OjcklAcC5\r\n	6/pLYeusUcL36QbU8RoynBTj+wqH8iMiFjsSWXk2s6Yb0+ABdspunw==\r\n	kx0eEg9JyDVhBLCdBFTpMw==\r\n	f
402	UchPFhnEueSt37Wk7CEBdl0d+oYZCLS8\r\n	ST2U596l82p8T7zBqRSPW6dIkpY9Lol7XOXGWRuYgcBhnO1uhywstg==\r\n	jogUdnSpIJolbDLv7W1veQ==\r\n	f
403	B3rObm8aX2GrqKRbCUXBSjFYPsyZjzge\r\n	kofftF3UtZAit6hJC6RhJF4e3QyrACwhy+kX+FjR5M0=\r\n	eetswroxc2t98luoF3gMVg==\r\n	f
404	FhBgq5j93KUGFTu0g1NJFGNoANsawjfR\r\n	uANUJq2jw0nWzuZhZuvFomm56qZ/mpWl\r\n	OZ2KyN+uQowd/YyYi3nO/Q==\r\n	f
405	zO3eLmzHZi0iq+noLH38i76uCZIENoPp\r\n	Bpp3rBgq+vz/lJgJfZHC9fRfZm9B97PX1afgMXvoD8I=\r\n	TkUYoLTtecqx3uvsF+gpaw==\r\n	f
406	uASBy0NGGeMeg+jFU6ixrtzobybOzcKh\r\n	8OldecCQuBogrMEXrnMhzvPFUxT1eJP0oYS3r4m281JRbFnCQVEGIA==\r\n	A85IW3dTppgKsszMt6ZkRQ==\r\n	f
407	7pOApMGahIzkrj6q8kggiF4OC9ZSnnOr\r\n	ADKlU6t5pyfZouztyso1jMbKyPDV8EI/h223h96ip+xJSv0v7bx7Bg==\r\n	516rKGMq0Yd8h7tjHyjOVg==\r\n	f
408	X1b25lNwvhMwh4bPchDadKzjXc8qyWjo\r\n	2ofaw28IS8lsRTE03mWkkVMZpcAYCmSiQfmWiFIRjcI=\r\n	vY8mH35QKqvdhg93krovzQ==\r\n	f
409	5U9YfV4gxXafwws+5jSogbhfE1vUYDc0\r\n	bnGuH2gpAwn/qntPaHIgpA1VoDlvTj+FyqKH6OL5Z4Tf/jKjrmEi2g==\r\n	maEv9YcigA9kn7fvWO4NFw==\r\n	f
410	Y3+RVt+1Qp3TgG1a6sZ79AHz9SSvfzxn\r\n	1itDdLG7jO9mDY70ikiQuBEwgh+qS3XMVO1TJ6ohiRSlDgpnv7IpWA==\r\n	rMr203lpI24KR0atX7XrOQ==\r\n	f
411	GsTHLsNjT3sLsqlGzWPwPbm25mqiVIwf\r\n	en3wKOyln/t6TdHzknPfuKIZOq2a11Pb\r\n	//3iEWlSChRE9bQpxyDM/w==\r\n	f
412	aGHzTD4RPk175b62Ok4hObf0DmiuJkcn\r\n	Rj6nGaaiCPaY63yZQvcZB0sRYG4zPFOMuGSN7oRSokQ=\r\n	wTHEzrmRER9HB6ZDfwZPfA==\r\n	f
413	OOqUVToCwvrGgldZdlX7ci7vDL/M447S\r\n	+OSkJWJPmbeOcemOmC4d9Rd5Qz4fAKBs24zLZnu/5MQ=\r\n	uMR5ye+CTylAq3Pi1TV+tw==\r\n	f
414	ep5y4G9MJo4uMl0eoinKm4D8QSxlUQ5N\r\n	kJwmiB0HdeAb7+Scuqw1U5nKP9R+znHS+/JUqU26wm6NNvMVyJYwhw==\r\n	3INOC93gSFuLVaHzYc8NVQ==\r\n	f
415	E0AnafRUVLkWQ4cyuZn892Lj4Kzr+Y6r\r\n	55coaVeRHkvKxVJtcAlaWFO8r+jxRW2V\r\n	GF+A8BsfeA9A0cTyvPjyRg==\r\n	f
416	27lZhqpCvqhkJ2BQP8xn2JU2bEs05x5U\r\n	yQujtPCu1sGnlLM4PBs9YhynLhulS/ksDCvATNjZ1UA=\r\n	3pmiyXSBlK4LzMb53MKl8g==\r\n	f
417	STcTXKfozjBdIuYqroLmcDIGu4Qn1roV\r\n	AkfUx8VNnCIuNL1rTBh3NGw8HAWl0n5T\r\n	+kGLaWoJL4Z0Xs6U/TxizA==\r\n	f
418	I+VJli/ywW27QnET8XUQe8xfhFpfMjtG\r\n	Je5hBJn3ln7oHL84BEnCdX7gZ3TBOsgLTJeB+XZEi3U=\r\n	tin0qK4EJx/EA8SMrP6LiA==\r\n	f
419	ucDcRe2MzeLzyWaB4Brg8/KxhDsSA7c+\r\n	JX7khpOTYlD0k/Npb5Ff9Y91eobkcbXaZhzkfeWo+ekM0+lQO1+oRw==\r\n	bwOOnaytqgIPswIdv+bjzw==\r\n	f
420	fFI9DIQqRZax69kHhpKWmbiUD85ZxS7z\r\n	zqmwFJCGYxYdREqoWXhbxvcmruB7187BV4QhNwZAJfM6f5t8IhS2WiAWQmFavDSH\r\n	n4taulKtjyIxEpt2WOfHdg==\r\n	f
421	N8bwdsXTKodKUc3/28dURyFRYejQWy5K\r\n	SUfWn1pn3xsNd9of5YQjHIJs4AUN/Vpr5uGi4wr88WI=\r\n	0ErQblIwyGzvnR/1FXGhOg==\r\n	f
422	HQxLZPIrlfK+XEjCyzV1Ypl87Py/e6Uf\r\n	8QgEsY1n/QpTmcVrglTYWGWh8EfbQG7JeoDSb0ODNqo=\r\n	xpLbBo3+1wo75tln0gG06w==\r\n	f
423	vaqk9SzYHrMmlZ/UPli8cyPc8n6GVmMp\r\n	N7GpHlW1HRwoU2vT8EPFfy3cktwDkKnNC1aZ7ewLfAmQ9evYqr+1e15z9AnS6yBWxl68usS42P0y\r\n2qPWhagPNlec4PW7ukmF\r\n	BdgaOe+F9Y2MeqRbxtaXxA==\r\n	f
424	CmmR6IN6gjypbTfLLJiEcWoFf8Ul+hKh\r\n	SXQiXaB+sqzoLa8jSA5m/fxp8QO9fQrjCB2OkwdJk2paOJGzo1l7Hw==\r\n	DWqjJx3PsEn3rkIePajZNg==\r\n	f
425	KGNQaRxVFFekKXTpqpyNVmW3YQO1qmcX\r\n	saySyM3B1j/H33xy+4pWMc7xzA+xsGDadnTb3Hfj3upzCE741HzQut87sUbEE5MX\r\n	uzmF0MfSAqqdOCFAaRudkQ==\r\n	f
426	vHye5o0RlIICRvB4aYT+maJ5JicPpjEd\r\n	S63UUAxKDDlPMiL2DY38b8FaaMekbeoQdRQvf2MdDFCykxBZ/ozojA==\r\n	4pvgwX0n1sGNNx6liqpeNw==\r\n	f
427	AVU2cMBLKyjD3GP0yp+L9P0vje0x3uIq\r\n	68KOh8wdx0a38XnFREv9/JAeiliS3mEvXon5ckFAC+z5j40kwK88u9veiCZybqYdB26D6G/NHLER\r\nO9H9rzqmwQ==\r\n	lNBRJhmJEq6CLX/x5KzQXQ==\r\n	f
428	6fmnsvoV9/vhTmGTdEOO/Dn57iYqr5Q+\r\n	y2m1PTkbJ6V9Z3JhJ0VkEaBWtVmSwqzJERV19tDxyYg=\r\n	iyhVJPgWz8E5FJgbzWVUsA==\r\n	f
429	ctr2+0yWdeV8ISwMU/ieWBYyQMJmiFZY\r\n	81RrCQwdSr2hm1Fc/y3meP4bDFuisUXLvnWLljgvzDmvV+xPx0+2/uk7ZRUCBDLh\r\n	aMSnj/VDI7zElWLk2I0xKQ==\r\n	f
430	VjLpmEBVZceMxZBHnV6vqJSbw9oWsw3c\r\n	nxyLP45wgIMIyTAK7EyxfEyv9YpElA47a6lJS0C4WvMfrYY3kFV7JA==\r\n	pJDTpfavs4lrq0DGjrUmcA==\r\n	f
431	VgldoqJ2iAL7+T7gzS4DbiDuzILnSAfn\r\n	d6lf+YDosmBeZ6B1Hu9Y8/V24LNq6jVIp6SFqkEp7NotQKaC96vRiZd6SBaCL4LLWhHoM6osSCJF\r\nswXM6c5Y2A==\r\n	mGtoTZ2kpFge7Tzgk79FxA==\r\n	f
432	cB6nGPOQAF+PjOzBToLLwa/Wo32FLMqj\r\n	GDe8jq2QVWKxr3vthz9iKOm/vdb8MAFKzvGwPb8a5ew=\r\n	JIswq2x0hgAqZE9UtEDOsQ==\r\n	f
433	iHJflkD+ZlnkD8kC5vFE/NOiN5r5F7mt\r\n	g5Z83xBUTajMszhiMnmfFXSHBU26aSV+xCMUOQeSdto=\r\n	PgHjNY9ox5F05Q/hhEIZfg==\r\n	f
434	EEsf9nIbmLF0o4zUlL58muc9AsnJ0/C9\r\n	VEdzZbUvU2fzI0zNNIo7qf+xaHr97rm1VeF2j8Tkb3ubMySeGwAf7BITt7LHMERk\r\n	UePMexO43Lj00xxTlw0XPw==\r\n	f
435	dxOzu8l4C4ekMQkKWnuUnZAr3s5T8DBh\r\n	HoKCAD3mtTQp2ZB1xvH+eLfq3FFW16H7\r\n	MtR/Z9vfAG8wubEc4mdLXQ==\r\n	f
436	XHgHU85dJtxFQMhZ7ky1KDL0/fHacpTl\r\n	cNPon7/DX9FwrBoOYN1pkT+gkOuWQ6a+vFGdc3fj7ro=\r\n	2GKvelq4JHoJP2LYce0GoA==\r\n	f
437	uGepfbK45hdb0ZP2+YUgjTNK0dRj09JX\r\n	ijMozTIDQhcnvXA0m9drhGlniOl7yzR0\r\n	zAP5GQnzy5BX5SnkI/VV7Q==\r\n	f
438	wicRWZSB5tcYSsFeStSlFMsKtecbbCJK\r\n	st4IT3LGk3ICwcyx4KVOx7inO1Pik1uz\r\n	doWsge9f6HmOfvdun3Qi3Q==\r\n	f
439	Y70+ctYulO7+xddODRtdERnreIxoQV5K\r\n	OOkU9uFgWxR23Jza7zjRgv/cyqB1R+UZDtfKXxIwcPwqf9YUF0l7gw==\r\n	XYJCylOJnSwc94RKVsQj1g==\r\n	f
440	3dkIUekqf0guVWhhTTn+weiqAzft45Md\r\n	jDgwFsUmM82JHlkgfP0qxOGLyezANxZwCqMONfn+SVE=\r\n	qIB9aSKuCy6Ua5olxa8kkQ==\r\n	f
441	wRfggZzG8SK+230k7mTHGMonAXT3mMhi\r\n	v5z89PPQv7Tq/3I6rxyRXgOf6x+aQHA3wg/MlJG7n2wmJkng5c6wEw==\r\n	Cq/b3gHGpWKi1GS5WQonCQ==\r\n	f
442	fkqJtKXd7GYwRPz/D2HRMcU1i/xbIhAQ\r\n	xeLx2LK9XaLnw9+KpCC5ID/5gkBxNsEeqJLKXKpbynGfePLUKhz1tA==\r\n	dbRhIR9S1yKEJayOZajddA==\r\n	f
443	0Ps5GjM1lE7K0FjB1JmzRjNkk0/dyL1E\r\n	u+6X4GJSsXvbS6eUvFXzIlsJDA8+T1mbG6VDM2OHextFK0Jn2i1UFA==\r\n	QN/Zqpjrh7JFdSU7OkIKjw==\r\n	f
444	qM4KayNXwbjKm86vubyFyKqNrN9UvAfo\r\n	OPm1thhhBDRn/VsPVfw7Hur83Y94tLblUVzsIHKZxfI=\r\n	DYeWW88C9pHHo4TV97K2dA==\r\n	f
445	e1byyZM0UebV5iwnb1niXN8pBy71X8KH\r\n	dgIp847cK2DftQPb21qLGLtl+G4Eb4wJUhO8XDHH1A+T6T+4hRewpw==\r\n	WY144OdwSs7SmAhoay9ARg==\r\n	f
446	H+/huiaNGOTv/JH4dT78NN9MpkCZvJSC\r\n	WnAY5JgPyQBi4i5GqnKmF3GrbSc9Gs3w2pJ06J3kkHFjGUKgFkHCRw==\r\n	C9M1TkId3MHb1/1NsLe9Vg==\r\n	f
447	iFNGxwvPkG5n3Ou5fOUIqUtmGJGaBOZY\r\n	xtVkqyclGjUXdMWiY2j6xFBzMViH126P\r\n	R8iXlhgEtTUMGE0qxNJeow==\r\n	f
448	IUOG2WBWmdl5XvTIDzQvwwoqM9Zeju7A\r\n	HAzMQxWEKThs878Yhr+7lUXwh4DpMMS+ilJnI0pVSjWET9SXMXhJDQ==\r\n	MKnVGEGJAigTpX3+Z83jOQ==\r\n	f
449	MuTUTnv1iYtpFJIvOHVRRFjqCb3HNQ4N\r\n	zWR/OBQhivMejhb7oaGtrpByRM3z4jS0lh+1FFo0jFM=\r\n	av9/l0JPz3DeIxrO5Mq6yA==\r\n	f
450	Ue4GFUSYj4djK4qRokDSQSFZGulUgEa4\r\n	vZx4sZ9wCV3PKGoNVrOdHFolxrEg3duR\r\n	IMeJeArhz56sfTteDSZ53Q==\r\n	f
451	eHIlLUK7jdieVCysQeiV/q+GJ1mT1xfi\r\n	2Ztz3HeZFakgc0cTPo7SiimfivqkVKCFpdzB4rxnSC9viM6l9RD4lqjDyaNpyKUn/MdfBpYUS4en\r\nxxqyG6dp1Fb47xyukgXd\r\n	3scKVAbNJRbO+VzEZk4TSA==\r\n	f
452	xkywOhr10ddACjkgCizpILSOpp4aUmYB\r\n	XIWN3yFIOIapo5ELrWbw9+kRskD4VWOn4isiC/mECkc30G8I858qCzlZqsaBWXY/\r\n	tgWFU7wy2/2gXgeE9W4jsQ==\r\n	f
453	67rxtXp1HxzidFadlBEskIM9Zf0kC+f5\r\n	nWI4t7CTUsgd3OdtJwc0uQXnDK8YqP8L+lnP6H0POcU=\r\n	h8ZM27mLp3jlPSbn+V7diQ==\r\n	f
454	dP4JwynMUTarX8M9jNGYJ3lcZubSNZqX\r\n	wteY9VMTfmk5HNWSBCmCgLCOLl76BR0xxVZB18gqKkQ=\r\n	JeELAh7g04HpzzvLwX1d7Q==\r\n	f
455	AbCyAHPWyk0sUyG+G2MGgoVa3B+BZCJQ\r\n	PQ3XI1uWyTQ0cnWkPM8ZP0TRxfczNKX6cI/PP2CVDGM=\r\n	QJh0TD1oDcWvwgrqqdpe4w==\r\n	f
456	b7XnuJqdWww5SybDH83AEhBoa8aoINUJ\r\n	WsBbhwOprL9co4Y5aIOpSgDqGtXcYbirSQ1cj9shBcdxxVDmHRLTWQ==\r\n	EuGw9zYuW3SXNmmV1ZL+FQ==\r\n	f
457	cI2KE3R9qns56ynKutFQuJa/R8nFDDog\r\n	oFId1x/ltEpVe0JhpAd2qWh4xBsseVP+U7dDh+9wvPEhm62scSKBGA==\r\n	0FF0Cx49qprunkotC5Z5Lw==\r\n	f
458	kivuNH1UQbp0A5J0a/8f3c8j65dFkHkE\r\n	kgobjceAx89leSn8NVZiXdK5jxWxx5Ivum75LTypC+Y=\r\n	RY4G/swrmKTHP7ghcUtqiw==\r\n	f
459	oieOK2YxJ/vbrp26bCS9y/uDR1s72JMu\r\n	Ms59zrwk8OQtWolettfiVpOZnWDJDz16Inw0uIjXO0dPGEW7/svp1w==\r\n	Du1f3dWhPJAxf3mq4ykj2w==\r\n	f
460	W1CKgZpT60L8K8mBaM2sf4Kst1HXQs7s\r\n	wXYMceqzzmoUYxgrIBVmdmiRLXNzXvvNfu6DjcsR4jFaIftrKDnOOg==\r\n	TgAHQkFBX+z1YMmFanbaHQ==\r\n	f
461	kpaB2BEmdno5eRmWpXYXC+kwtC5ggCv9\r\n	NBEfCNOdwYlOfQJEnyUnLKkcCzqWxjvBQemayPVtqt7ZbfNWQlTo5Q==\r\n	Jqzbs/5rGg0Bu/+noQsFqA==\r\n	f
462	0yeKLYZVIxakU1uS7O1UnY8I9IxBenYT\r\n	e0MFsEHS6qaCOttghiGhhJDIurcsZWv0rfIn6ZHclAtFiFAdOz18lGix1OjL5pFcbYzcH5PAVsA=\r\n	idSfuLcIBq1EoOaN/jTl6A==\r\n	f
463	nzOa2WBPTGf5Xd7uOPoMCX8oRptzCa/N\r\n	Ns+uq2PkraWnWAfHTNFiqIycllms7u4ALgFK/UfmEKY=\r\n	Kmx1cUGXEFbgdMUBkTR8ig==\r\n	f
464	YqjhuzzG4VRKucng7FI//rVjHBp5InyT\r\n	xQhTv231ZkmubhX4hQUx35yyc3NO2pRVKAQ1kDNBz0NjBtSC72YH+Q==\r\n	CDtKo/GoB82Twf9l+tudvg==\r\n	f
465	KpuCITnl5Ta6IIVrHTivttB4r3Is11a+\r\n	CWYgxs0p1d5QJ3CAQswzWInrXcPPUW/ANke+x5Bvdbo=\r\n	SAdpNgNsRdMNXw9yk8fiKQ==\r\n	f
466	v9oZvwnqyRDZpyQ/Uk6wWJ433loR5f0M\r\n	8sg0GOJD2ZECGFfpvCxDpTRhLCXqCoKbAEkgIP4RDBg=\r\n	Yvg7B6DT154Scn/Dxg7+bg==\r\n	f
467	+fjFjckxkjST2XJUqzBsrE6YkAMEkaaV\r\n	QJGDo839sRIX+2wxLczxpBWNDavKUCJS\r\n	DRnuI8r4sAvUtTmU90mW7Q==\r\n	f
468	wmdTOEd+CSokGQwY6DpVKBx8cHHwoaEf\r\n	Wmq2ft0KkB2CF2nDtt/uMWPNrdvaGkxZrCSRdybyvnA=\r\n	2j2CqHlc8g6JBI+MyRm2vA==\r\n	f
469	Bdg/RPryIC9uasLZRMfQBAgImj2P+5P6\r\n	b6RINg8QHF+z0450lX9IRdRfeKkWbaFLCURhQSbdErs=\r\n	rC1zjW2T5oY4ZotaTkOpNA==\r\n	f
470	q76B7Bd3/Z1dVEMNI5OdIApIZhms1CvM\r\n	34j2Ns4k6c5ShfOmbbiht9ouuOL2Kt1fAwn76mveukAYQRplqqZ1iw==\r\n	mqxfAmb4iEwjiWFimg+FYQ==\r\n	f
471	S+X0sIM0SUQJ928viaJ910FMRufhNCYa\r\n	iRFaXx30Httk1lD8twgxLdOitYwDMBFGHB5qzZDlTuY=\r\n	04RkOR3YPFiePn1lLIVYZw==\r\n	f
472	FzQDhtr0EeujkVxnx1WP75Bzo5gUQD8E\r\n	9CDyKKn1FuuLOu8NzUv6id1wy/5tgCcI1KLfxuEBkXA=\r\n	0NNt4ohX84ChcaLv4cnA3A==\r\n	f
473	y1ZbGulMco81vTpfk5rTkGy0EBAbjcFx\r\n	lL/oQmAgs0BZX36ttK+4optKaf+NzNQDMI6rNJbdAYc=\r\n	KSyI/746XgQFwBToyereqw==\r\n	f
474	1pSG1UhSa2OIpl5t6zkUDPeG6Hsgd0Q6\r\n	D2XSeRPjmw+m+AEP50MoCCrZE46AHBU5vKtd8tOSSmqRV5EvcI0FHA==\r\n	tVwp5RaDo+V3djGuZPhL+A==\r\n	f
475	rV+BuJFTzBvQndYe4O03+d/DA2ByG0VP\r\n	+ugJqIVHp+6kDO/9uJGEroqBU6E+EYbcyew+NM8on5S3cDkeBpdWVN3ShSSmrSGt1CBXWKsd0U4E\r\nGaj+bs6kHYmOlkhCtlDn\r\n	6Y7YbfPYH3wOTtSKBJyAqQ==\r\n	f
476	TzoDmoi4uijkJq5CVIEbovS1ZXQWTTC/\r\n	JW/ALwwGdCnRFyFlgoXvdKAzO4QDWdIrz+sx1z+iJ4w=\r\n	Lv69XNDCb8sXYd8eh334WQ==\r\n	f
477	kxGiOpBcQOs21wVLJcHGZ3H5ldHi0C1M\r\n	fZBZPsC0sxKPkH/bYQ6RgWTAi0caX5PlD68cg/MOFpkdSCtcRK572A==\r\n	LCDb6OkheUMJRl2H+3ZAMQ==\r\n	f
478	0lmEjFNKrHo0oY21ArSY00WNFN+RZP2l\r\n	+2cGDWBd1wkUrYQhXxv35+YNUmJOhlG1OrRNgFR9chOrTGP0NCSPcX0QwJCYHhSP\r\n	zBs+a2KNlPIuiHBDIAyOmg==\r\n	f
479	eFQLMuOBUlo2zTPKLpxS719Z52TETFI3\r\n	Oojv1YJDcA3FMVwzLyb58Pf0NLiXetp0auo9MyFFyOUNvF4GIrgkBA==\r\n	oNmc9lTeM69OT92mvPyPtQ==\r\n	f
480	tyRvt9+b/VQ05SUUysxfrcYuQ5rXFgLp\r\n	d29xRUYx2EWOWpR4BpBN14Svu0kIm6gRXty8RvhbFhDHVCN6TuqBmw==\r\n	mnLqxJtK/9abYv9JikYWIQ==\r\n	f
481	pryNVMBPXgeyS3/gV0Zkz9hvslTWm+2P\r\n	Q7AoEGZelW3+tehopTZi3GoEEgOF4zQE3hboYamQn2g=\r\n	BKQOC7Q3MK6bjlcppmigRA==\r\n	f
482	tnpjQqtnkJ6gcTvWm9Ru6bOh9Qw0LKze\r\n	Y6Q0Fx2dKmhIYeruftoBlNjpu3/VTDf5uPXX2FgoaYj8o30r8oODs6JEOIAJ0tQF\r\n	HGGum6ZKG8Blv9lpxnpuuQ==\r\n	f
483	OZukiZGVehqZgTA47ScileEJmfxwhyb6\r\n	Ze4sxXCL97fy94lDZg1Cqv6Zq1/shcQoOStRmY3UH/63xh/ox6Lzjg==\r\n	lS1KMW8DPGl1aaPZJtzvpA==\r\n	f
484	KfbXqKPOv5FooZ3eg5Yq/6pCZcOhxjxQ\r\n	jhi9HAC4B/JXTpCxw1MZ6xcLu5t8ELUlEhJZC3J/S7p1gAbR89hH7g==\r\n	O+9zh7SNkN8yaQjuxvhFLw==\r\n	f
485	4cKPtWjGgsok+FKL2OjZa84FqwjArwCv\r\n	bFk0+D8jTWfmiapPQLUXTN4EhR1ty3YXpOjwBqWUvjg=\r\n	gR5HQGTz/TCeA/jjY8dHkQ==\r\n	f
486	VMWFby+n+9H72GA1XB9T1skzDrXRmzi7\r\n	X5f5NfF+SdzXNDkfwqDExGPiw5yq0Y+yomuOwFWbpaI=\r\n	em5l2JjldlL7wKXmPgDwWw==\r\n	f
487	gzCuOlMf07eBPREn/63t664bxsOgkPeC\r\n	YBvxusLe3rWefzcWsVUGNchfYb5ujOzFTDKX/+NLQs7nSSzA2jHhrrHKh9YSNkuCrcLU/xT94fk=\r\n	Rt4xohdP4uzbPq8Ztvt0gQ==\r\n	f
488	j8nMwaGekH3xLir25Y4hdaqjZzWSd1IW\r\n	bt52tZ55S/pSlUuKcGN/MU/C6mcJlbrQRN11XzOsSm0aq1fT3JSffw==\r\n	Bq1qmVUSggM8/TANDSnZ0w==\r\n	f
489	QVSzQo2PZIRWmi9Y7lUueANT0DXGw6Mt\r\n	c+pmPVROEqEes3OdIEvUXbKSmLuORQkOH/HK6Yc2YfsDTeZ0DKxThA==\r\n	p0+4AQOwI5VDVmcpbjrfvQ==\r\n	f
490	D/3kaJc5I1Rm+MI9lCMESpmZOtW/JTw0\r\n	HUur6Xmayp43zF2TO7rkIDZqoSFw3r8P6/EgrsO6IkaJ7FLhBLICJQ==\r\n	0WpGSzpnMa+lRRIqWz7jFQ==\r\n	f
491	Y8ojsKuCvlgmW4XQdUEmY5KNamOir53h\r\n	VRH7foo0qfQ3D920yUVRPUZ2z0vsUkzbEQcV0T20i5E=\r\n	4vGhgCnGkf1WF9KlNZFP0w==\r\n	f
492	glb22/9B0kR9jnm+XKNcBZmNYZGMxqQ5\r\n	sC0XYrulgLENjBDWzcCc0yP3i4qMwvsG9N4zQ2Rvrcb37epRgMnUqQ==\r\n	eemRqFxZSEUoAobLwkMIaQ==\r\n	f
493	jNVeLC3qNyMcjdagqrC1GFh1HOogyXoO\r\n	sPWLvK53wR1+w3ci+30r0sAKvPfzY5cbTl6YGbdPnPs=\r\n	GrmYPbmxR7f55aXUjADyPA==\r\n	f
494	WUVUdpdA02wM3cDO4wtm7566LnBmSdHM\r\n	/Zk40e+mLOXtW/V10tgbCpZXDmfukSFRAf0gi1/KQ1g=\r\n	CjHcXs9qeQTRPIPDsqwWQw==\r\n	f
495	LalwWrFUzrL0s1gMdNo7iW4eK+RviH3R\r\n	YltUrFwfp2M/XtIS95b14Uwra8i6qLZs\r\n	/o5AJrDksX1RgMtTyRoBEQ==\r\n	f
496	bZSr+qFnWLMEI/Nyh7uk1Jw2qYfqIyq+\r\n	hwAv0jqOGOII5A2w5Ni1xd3DpkUXMK6gML/N6GxqlSN+F2kssdsMqA==\r\n	wTt3U1nTBfqWG96s0U0JaA==\r\n	f
497	1y0xnCSCsvfBsapJsrghn/mHNtuOvYwm\r\n	uefQNqKLSNFiSPlzBX84N4kV/wS+Pf+cF+UBT1FBiGtPBxlm+Xbv/w==\r\n	r6itKj93D8ccqZBXy077Pw==\r\n	f
498	rvLs1V7hQme9Te8E9iPaI3Jv947r2MHf\r\n	Gi4CT0qCv4QzbiLm10wDnP8njVWigyIcih6UeoSUO7drw+OghnSQ2Q==\r\n	pDpl3738P8IY56FJdtaP+g==\r\n	f
499	HJkU1BIJ8p0eFVIQmzdlhI56DkiazlmQ\r\n	mXrY4VgLN1nonDCQ8Hc2TcIisqrKg643tp+mk6ScJ3frWdiaL5L9bQ9vYK6SULui\r\n	vT1IRiwQGpAobtccA8RVhA==\r\n	f
500	UE7dUwRSPgfKbnwT9Sa8XB45a+PJcHqF\r\n	2RwiQiF6BbfZAoaRQr/zMl6lXtRZZOZnTraI1AZ49i6hilamrmahs7NnA7PszAW5V5nFjS+y88o=\r\n	+KWjnIIfhEhUDmaXSNRhLA==\r\n	f
501	gqJUYHZ5FpaAlmn2aHzTC9LwRgtMbHUs\r\n	Y5jiDWMJw2Jt8ARbWjlgo4/jwZvd4YQvV0ZQRYzV0/E3G242rK73bOslWzZa3+LX\r\n	r2++uI4WC6uqG/ZaViyJ8A==\r\n	f
502	x8X2Wj/oakGITgzn1ZfUwDXSpQdDvZ17\r\n	RpKKhZC3sk/ulsMQ3x/ww8h4oLSF8eM3shsEw7p8EzAlq5seTfLHgQ==\r\n	eiLZPIm2SqlhFpBODLze/Q==\r\n	f
503	6bIQ2P9dTG0OB2tJmCt1KzXyS3+2jsW4\r\n	9P8gBUKPwVMtUzrGMczzsNVx117dXlRm5hiDFpGsENDmC2w+x3gxIw==\r\n	Q09x1lD2U1HlqJ5tDdrnxg==\r\n	f
504	diH6kwADWYlTS7EkxLrs9uC4msPm1NB0\r\n	ZjsNGYan6m+3LIWHjglhJpMsu7iB3Xa5jcIMNbea6e8cCmnVI5p0wg==\r\n	AIrjN1y6RrhSgegwNaD1OQ==\r\n	f
505	7k9R5b8EmGmT963M9HKkwn6d3sti8MOn\r\n	gN7rc4865U0tR+xPvVjelra8aouM0PSga6rAIgRIBnw=\r\n	R8qlH4xx4ak8W064PaUaRA==\r\n	f
506	YiDM65qqyT2roarGtN9hU6Wsia5UjhqE\r\n	s4v0flCu0YMrkF0q2+0qsXt6njGjwMMx\r\n	dAfDSLj3IchapVK6fviZoQ==\r\n	f
507	spfRNIiTCpI3BXpjBYl9huQ4fe643fd3\r\n	KdnlzOR6QavEO/fUAvbdnRek+lrKRso+PovhVnlasCaxsfInqPdCxg==\r\n	r/c4r7v6+GjpubjATmoTzw==\r\n	f
508	JdQZflz7QA2MlDDvZZ/SbPvquEx3/w85\r\n	kqxoHgc7T4MlBdnUsN4uI3BVI+akvCTA\r\n	IKwNqRHUIQ6HnH0TOP4VpA==\r\n	f
509	1CJp7Eq3MahetM8YY4TiHsc1qWXpzO7v\r\n	pejGfNXTf1IvX9MFv/hOF2f+YsUZB7XlPCn49yG/P/Q=\r\n	Z5PIYBwi6vUwO+JxO3Jdzw==\r\n	f
510	SjeD3/bwvyZdWrNLTp0S7YxoVTzziBeH\r\n	73pmhJFIvko7MJI8I5VEOxPKVySA1Suzy4NTPc/p0I2AI9XjltiU+Q==\r\n	yS44LZ/OBpl8QD1sQgWNMg==\r\n	f
511	6jVeHHiqk06d2m+rnOI+Tcj8ki2oqUXn\r\n	LHZ+wCk9cXt/7QEBREBSHPBmTdJcvW6sJ1p4XilnBKAvwplLCASIG0gCLfkYonCx\r\n	wZFxbW5gJTpSNogqKhJVNQ==\r\n	f
512	DwZzS843IqkSZzCd3F5S1nA4uCw4Tk/X\r\n	gxpwN1d0tZKB6RHzKW36OLli3p15DRRPC8PLkukJhX4BqhJayQ4OQQ==\r\n	o6+yMhVXJBNbVYQHk6rRCQ==\r\n	f
513	iQ62A5OHQJeMPbK8JZCbbBKo8SSHR1NQ\r\n	aOouYxo3memiufTgrJp9kMjRFRvAD4xvbqJlSh3OlN42gEwDrL9Wy4Q6gcoRpTEX/WuPcif5XMQ=\r\n	yZ+nvF9c79msfC6YCoEpRQ==\r\n	f
514	DeE5SRtQ2wuuvWo0cWcBwppOk0OdDXkH\r\n	pqr/tCU9n/s3eCGgRdMJsVCDDtc69WlZBz8ULoE5+1w=\r\n	GHKInWGkfOowlty9rubxNg==\r\n	f
515	OvltZLyfSLLywralov7vx9Kp3DOe+cLu\r\n	1w5hQx1WoWjP6R46my6N4tTvwDp6NWPNnHzbla+hlmA=\r\n	nMlLf/YeiN7tr3QOSfLllQ==\r\n	f
516	2l9mvnPEl2f1L6guPvrLevL0eWXGOFAg\r\n	LK0ZMp+6RjsyaZzYyXvZfiguZiF86gJzddM80Ba9Vwgb/ukcvElctQ==\r\n	x3XZO1KGi9CVpmQEsfS2Xg==\r\n	f
517	5hQ8vxs+ykD3G1QjvhebRLe45zUIZLkE\r\n	zDpsqkSt3PjE7m0dwScP1XKGjNgvV1UBUlqPXsGBEwf+4owsUSBF7A==\r\n	sVlfEgY/pI4jkPmTefIscA==\r\n	f
518	yyHvuywBjwLGfw+ZQlGo3HhDIyERbzVF\r\n	RHK81Sv7YpWL/56X3zduRALaIyh/bc1BFMqOYA3sOYI=\r\n	0qLINo12ntEmz9o+2WCosQ==\r\n	f
519	rA7a9wL0/MtFZC3pAmIhZXEWOmdSdaOS\r\n	q4VOifSuqSvXcQxxPobez8c5E3FArx4CR7IpvxqigsGVao+/EF7WXA==\r\n	oXQh8iY4OpRMgPmLGn6ahA==\r\n	f
520	TubUy0PqIK/I47rDHy9PcCsKUz8wcIxN\r\n	BphVCSWli0SGNZXfWI+P9uoZdDggHavl+HaXd6QotDKEQ4WFdFv4AA==\r\n	TBbxCqNqZ+WL7Q3TxddkOQ==\r\n	f
521	pXy15Ac+MtMt1XicgKey4NuMYaAI4CLX\r\n	iIG7lC0Gl8spxGqLzEQt+wCMAvHyA1UguIMUgeGVbVMbCPZLwTnZbg==\r\n	2VvcpvnSi+C3KpjU6bmk5w==\r\n	f
522	Pu03R70gFepPNr37eqB10PR6K/9KhXDg\r\n	AOfhioaVVVO64yXMtlDzmABlRYQ9ZW22cG/yDzRY4q6ATjNDi+QnkA==\r\n	lNUwhuWrnhW4Vj8DLWh9kQ==\r\n	f
523	F201TV5mmUsj3Yg6Rt5J+6BaJ1Nrt08u\r\n	MP4TUMummm1AUoP39HQPyburzSrsgbaf5yaXgHcelAI=\r\n	HJZSBpkJ+c2rl+laet2ZnA==\r\n	f
524	0ercVeuj0FUajLLy68VDyQ8ZmK+XXHM1\r\n	ClIYoQZXI/gXg22EchsPyDq/RXOCTNPM\r\n	2d2Rl0/iWTRLZ8vP9N4DLA==\r\n	f
525	r4CchRFViuEVsYPLtpCegKAzTXKzvnYe\r\n	K0lJfUZ8RpHkrpgM0OOnyjT0YqKKFkbw+DRMq0cDlL8=\r\n	t8rY6wRddixh2N4rZPYNZA==\r\n	f
526	gPcp3D4FFlsNXZAPvD8dlN3rx2mo1DJl\r\n	5A23qmsXhPwOPem60qW5ty2AY6Y6johZ\r\n	LnLR6stCEzOV9cMosyah0w==\r\n	f
527	oxefQZPCaPI8uuGTJIQmh9WHRtbRu40x\r\n	cRcLqDfw/+IfS/ne4/LsChPYFMF1KCOeaqS6QssSuo8=\r\n	4K83FKu7tp6X4NLypwB++A==\r\n	f
528	nBgc+Ok1zC8+ei65rprtlFnoOMvxVrQe\r\n	3psDIAUN0waMmI+eifT/mnlnS0zI3gzeFvvj9bjcTEk=\r\n	zD5+TiidLj4VnaaYj8qLRA==\r\n	f
529	iTyRb8Aa5i4Z4Um4AbtHKQKQIYrIRQ3M\r\n	Z2yDpOMfSSWaen+zwYCF1d1b2Tm/Kj4nL6RLSUey/jHVrFkSCvMFuf/RYC8wBX6jnFMVqG0mvUrM\r\n3Fgs5kfp5Q==\r\n	o0zaMLZnVifKd+4RTgJLRw==\r\n	f
530	T5QdWRvQbBGuWFku2bcV/LIJtISYOa5Q\r\n	QPdLZKgLXO6E7CzW8BbxOzW5EPhY4YFAOP8A1zIDodQ=\r\n	DMfISgvCyhUzFOJFhTO8qQ==\r\n	f
531	bROUxQcPIukqsfwUd1IVY4ClXRAOD7wc\r\n	YGC3sJqHVkxT7NZikQwIR0Wr6IEuRjWQ\r\n	cNDfYLPF5ZBI5dDZHbTRhw==\r\n	f
532	CF+kEc6EtB4HLBV0rhzK6suwurhEbHe/\r\n	e68FE7CFOzoGvJdIgsx7Cr8WbtSLLbd22bkX5Wx9JiM=\r\n	gIPodb62q0G4ofDfsToFcQ==\r\n	f
533	+HFAkypJlK0BJ8Yo7Ah5qjzycIfQS14Y\r\n	/iy0Bb5wPzVm7z+wv51Rh9AuJ+GYUg8D\r\n	PBEaZeUfOE9cE8XkVJ+30Q==\r\n	f
534	OpPQNKDn7vbZryyrMTp0T26xeSbJBYGN\r\n	pzAkNkpghOvikkqthGws0aNSVa+IjauOOLXqu6/YhCA=\r\n	nt3ToQ//SA/XRa3PHU6VJQ==\r\n	f
535	vC49D8Ea/vS91fDoE27+o+R2s2JH6UdO\r\n	gAw9atAZho+MhfqYLahrIBBoRCMHOhiIMluMqakiYIU=\r\n	4ksAhOMSLatYPIh0raMsiQ==\r\n	f
536	QdAMqH/Aju+QL5JHq0Q8dKdppxF9hlLo\r\n	2fPEQIFIot4dw2MZJ89gspM2G+X1sNmweOA8lUYLres=\r\n	ypQMunl5fGrhA1TUPlhO9A==\r\n	f
537	hGmdsodNIDfzXCK4Lm5GE6jajQ71YgDD\r\n	A4ebzBjxmB/imA061ThRGm9YVPnp4hKnjEmPt+FY+kDKTdyKDh+VG4mrcbXLP9xKYJlI8eFIhi0=\r\n	OyS56k7CPr1CN0ssZ9TPXQ==\r\n	f
538	0IVVgvYZqizvVj1Og3z8DTejP7NpNT4b\r\n	AKYxC89ygMAh7/Tyy2itXWVcJ474A8gyLpAU9EtPWWY=\r\n	K1JjfytqSrdw+2n4/+FQyg==\r\n	f
539	5EDvHHoxzVoisPldpHdsN9etvPx9b+K8\r\n	iVYMBAPCQlIuyK3zjGp5OlwzsDu+yakV0VTj3yZeNlU=\r\n	RcHq1pLfNZPjbeemEtSjTA==\r\n	f
540	tQ6bqqsHzxEBhaD9Hit5OAQBgqdLb3XO\r\n	hlRpKt0w+GNsuqQkBbGsKMMv/UTS3aF7nNTwO4M2en+M7aMSXe/AXQ==\r\n	Eoeu5hTaUq9Z2a/vC42ybQ==\r\n	f
541	FO8+YSxljNiuMbvPgWmPsSttvQEQuVvg\r\n	aPmx2GQS6YK3VPEOlkgRpEhYU0/hmzm6u2xSr/0EMmk=\r\n	raV8f87InFJMI7gG9HaOjg==\r\n	f
542	nhBHGAPjcKvNq2njeLDJwEsGZbrRcPlV\r\n	igan+E87+sSKU4REq8RrNhLzNQEC9tKqF1D/I+hTfhA=\r\n	CE4xBSu/QW7WDRzuiyOhKg==\r\n	f
543	TXpjpkoZEFNHXJkKDZ/wMMptTBZuP5zQ\r\n	ZvZ5PvWqHALKqCfYi4IpOVwHsRpv9Swb/qK4vUYHAoA=\r\n	UrwFgRbe/dGYq1wKiA3uEw==\r\n	f
544	iUfPAQ0SiygtA+lRoiE9RSpaG+jAD/D6\r\n	tuCJIwfSRX4PF2j2P7NRYmU78gJv21i4rjO+RBG0tao=\r\n	8ApCW40iqNg8GCaSQouQ8A==\r\n	f
545	TNs5Cknxt2BExYKXZe7G9tmJkwGcT7hr\r\n	ah5KBBLCOAkPs4QiP8A/AhCvR2EyRsz2sdZIngbcS6s=\r\n	o2JcT9SrXhjKOUMriswe8A==\r\n	f
546	pl7ntlmEzgh1LA06kdZ1etcjxWiVFL9q\r\n	sj5upxSVkCJ+Pa4YWbEvodOa9f+QpzaOW6Q6hdYHi6Y=\r\n	KVc1+AdYg2ficwAweBi5hQ==\r\n	f
547	mBJnG+eoJ8nK66RB5/hPdTbEwxZwV011\r\n	R/h5PMIZXPvQPx9JiPFbYGUFTZ5IWk1ol5653ku4V9YGSW20V7Xw7w4PoJMlI+gg\r\n	QWR+aFzRUKxXLicvzz/JHA==\r\n	f
548	QyaTeMAm1Mbssm5uyYHkJ5cxqa+FGbj9\r\n	LiPASlX1UKpXajslNiy+tLgVmV2HQiUy08o4lfvuLA+bNFtfsw4ryg==\r\n	bcZ56F+1RPbhjKJJ/GYh7Q==\r\n	f
549	H3OwHoSnVIhEKkIrKpJAvG8qMSz8n6lX\r\n	u5s15eUi8pKFQ+hEhGnbliL5r2481RP6ikpxv++xshwGYri5grcgVw==\r\n	mWF5SDzioRF1LF+h9nv1uw==\r\n	f
550	dOnCsjSH51aYN9nBXAUDZYepj/sDW9eb\r\n	HV+CgSMUMDAAopaRiZ/5+fbMfuj04f54WdKiJ+nA3pBW1VhQ0T1xVA==\r\n	JMFSjZfB84i/JuAqOWVDqw==\r\n	f
551	88TwAS7KCb74j7lLD/kAdM+0BPEqA0JH\r\n	F/jQQuSEwPhYIoTO/4UK5Z9HKS1OzN/iAZc6m6Hl+SHXXazQYIPAuXPFwEof8p7O\r\n	a7SP05cScQRBQkYTwaAiQg==\r\n	f
552	ly2zhE/6TxofT2OfedpuJB8V96BdxQX9\r\n	6mILlhSF+6L3vtcLLzkI9VQcB1oxZD9Wl8dIZOr+5nw=\r\n	mfz9KbsqGPZXhyqxlmWmpA==\r\n	f
553	5AQeYg3Uwf+HNlfY5fxJnmHGhNQ9jsey\r\n	0JyiIkYbdnDbnIffvq3B+2QDgXG/DQF0A8kDZcLxAueYLbIqDNJam8r3UyN3reVHC3xki5l1+RA=\r\n	xuSLlXGf7rTkuRzDaBCKgA==\r\n	f
554	lCUY02Yc78wXDtzDYdBE7WkNjhiBed7H\r\n	GNL+uBEcTBVxrkPcef75QMHRIiXHNc1xZ3J7rTQ4yT1xpzMMUvZsF41E9Hubmsuo\r\n	ipasx5I0UVyQKjDiZ4Z8+w==\r\n	f
555	HwtJzPQATOI1sYmrS3f/xOBnEoFIuNso\r\n	AJrgO3JL0IxLOlw9HUDkcXrZ6nhqX4h3E/k4atZIRQg=\r\n	vzr5p6G1qW2kZ36G3XX76Q==\r\n	f
556	L1weG2q5uCX0Bf46n5+FNdHXi216HTk9\r\n	aEW5rkmKCBpu88pnXGsQIhK14m6rLvvs27Bv6QEn6l/r9TrHnpwMtuaLbL3nwYKe\r\n	PJ2I5ZNE1ge4k0VqJurnPw==\r\n	f
557	F9HrrInB/kFFxngPsrEVAnWpSQt7MD0S\r\n	s1qUsB8HMlWH3xhYvRlMDB3e+Z0tpaTk8d3/gqfbT2KOKZ7Pryv5uMIY7g3GyimQ\r\n	TtxaaazCcjnebyaRTmn6Bw==\r\n	f
558	k1jILZAnNkdz/91iyQtjzHD/KPLY/RsY\r\n	1uKkUjufoSBjzqQyIsVHN9hOat/e5qq4RGVD8vmX75PAOKtSJIw+Ew==\r\n	38Ooejmfu3VcqLo0dIHk4A==\r\n	f
559	UiCJ+NPOBeo31ko4FP2fqK/Ein5Vs8fl\r\n	u4qJRQ51FCyQ15rK5FQJugxjm/5FM29tKuW2ViyNdGY=\r\n	d1xc3rx+fmkuPE3GjvYrww==\r\n	f
560	rO932Lmzhs+SUKGIvY6GOPp1PoqUu9NK\r\n	iiCu63hzTqSF3PNJi/PiHqd3Mxwz2+zsKH1UBd0ULogAj3j7InhrkA==\r\n	JTy1fRQYtaPCDQNrp6YMGw==\r\n	f
561	KvuoD7yCA8dRWA66P6TeHx0rhRxF+UVD\r\n	v39d9CUgX+NIF0KCh2pY23U4AczPkihss9iBabDqwwE=\r\n	Q2dZQFb/8G60Le594hBfqw==\r\n	f
562	74BZRUFdaDbyDRcBtBlmIfTf8/PjvPKc\r\n	+UKZRHY0g3fdwkzw5yy8LnFTZzOQFfyOhLMM1azX6Og=\r\n	gFW5xs0JWhfpjXxbFGGg/g==\r\n	f
563	AFB+fshAvY6oc7MG3VAYn4sxAo3QADZ+\r\n	VzZsFfUGiki2v9+b9FErWIUgGMe0aLBV\r\n	PexBkuOJCn0QBmlFQPtL8g==\r\n	f
564	yeI1FPxnD2R89u2ee9OohRB5MrQjXfOm\r\n	6LhMvwc8ZhoZe4lcsuejf26J8WIRCn0xCwYFw0HWpRw=\r\n	alHn9/DcsreGQEbH8bT7tw==\r\n	f
565	4/F4bcUcHnjCVt+WgxqLdq4VmyTVnn6s\r\n	dYSgRjx25sZmMWzsRd76UyQc7p9nvqMyIrfMTfl/2p51PhE9/BJlfw==\r\n	ASGFLIwblBnZv7+ANsBp7g==\r\n	f
566	mS6wy6aa+8LcQykt4gwEKd8KstTtFpol\r\n	COeVhQfeqnSt0r3JzcRjeN+yj6OYBFCoreLMcrtV7ygbbtP/5QiKeg==\r\n	evPKNPuXNJG+HuRmOsTBBQ==\r\n	f
567	K9yxftJNm+S0LWBF1AngfuZs9O1Fn6/F\r\n	Z5+7uC+8X9+q7jXaTvagXwvcxBaZ09n4HYc7yF4YXQM=\r\n	aUnozcGM3WX+nTZ3PtdUhg==\r\n	f
568	c5cB0PqjEDRJuCcym/9n+LFf0P1PhZ/Z\r\n	Ts0hSXmg3epb1Hi4hCbUYxJXKn7hHFeJ3GVjMzytnoCJ8Va56l8biw==\r\n	IdpSCoxStHxeHb7GFBvtrQ==\r\n	f
569	8b9Ru45YFyJ5N5Awm6pebH5mRhmCfh+0\r\n	KDdo8jkdw9KuVGsRKbbMq/bv9t04hLNGA6ZEdbbtYS4=\r\n	gP7/ogut9ie4mTz8AvFcFA==\r\n	f
570	hZC0+WXX+e7ki3W2xdDmV3rqa55sW1kr\r\n	la2+Ifdtm7Dg0kvdpYIhXXyKLVaT4JHDT3wfV4yNkHY=\r\n	wAWMX78UPn5XvXmOAcD5GA==\r\n	f
571	5mPiH6c1aBf5bmxHeDlxRMrgtp/Dfs95\r\n	ZiP/6l3COsL+XFeXxgoQAU38JfJrjWpFc0JNFyMy4xg=\r\n	6OvkFH/s+NS/tsavc4qewg==\r\n	f
572	SjExaKdSREW7DWempy5hwrkwuGbpo4/s\r\n	JAkMuSP7YuO4wZXraDaVGuYcQxoZ6kW5\r\n	PWBkSH5xnHHQrTKBLs0tWA==\r\n	f
573	lOI/CIsnDNO3pp7wi9w3SA7hMigWmAol\r\n	em6CaN5tHNuN4Hl4IkK4dF+fscUdEIUCU1kjZBwy/K4=\r\n	BmyfPyZPIUb+b1GeJ5EWEw==\r\n	f
574	Q1YUm1eWiqTSyg9rW7uIT2nWT3lMfnAa\r\n	A4xrZ6UP2GT+37WTA3vOUeqdzETTcTMgfARw0Oc49jeWDLRc1ZbdCw==\r\n	iy4TcApeM6FGDYGrQXs8Hg==\r\n	f
575	OpTjCrAdif5W0QmyObG+nz4zgF/noNJG\r\n	sTSNpBw+gJl/4R2E4LtumAPqdReuB3dLq0tDmHGzGGZjOGSN54dl0g==\r\n	vj3+TQyTOo3xJ2jC4u3CIQ==\r\n	f
576	BiyQ5b9sW8asnNlUZD67mx6vkEAuYZMm\r\n	Ik1juwQSb4Ux2T3rc+zKEqporhtQ8wM3xddEkKapbXs=\r\n	IzRbwGxvLUeqZWZneZEoXQ==\r\n	f
577	nJ1fu1wXf3I6QxXSdxbTQuxVY7Clw3sw\r\n	F8q0Sq6ei6KMTA/Dx8EI+IlxSRkRe971sYtbTFNQ92I=\r\n	3UK9687Yus2MvzXLQo7yzw==\r\n	f
578	cRdQHModjFOeym0yGFcRRukOv6Q3QgYM\r\n	34O/3h2ZJ/GyghAwz1NiuDVzC0sxT4X+M6JAVRFo6FI=\r\n	pmTzuTW/at9QKK3aog0APQ==\r\n	f
579	IeJQ16yKkcTXgFkhKmBwvulYWB/O7ZgA\r\n	Z6XckGPwz08D/kIGbtPrvaOxZVvalS12VD7BYkWxE/wnfC0Sdbl/wXvkCwjGQ1U+\r\n	AOCZTQ89CKAGb+8pziHLsQ==\r\n	f
580	2SEWi3XiXVm61wciTaoA6i8bEhspUFam\r\n	cJbxQfKGQefOUb5FR6eiY/NOxjXZzF4999ZiCOeXIgc=\r\n	lnkgDCFh59VVrwEJwnCSYg==\r\n	f
581	7C/fuEQ8fCv2b+z1LtwOTocEHKNJhTH1\r\n	cH6zR3wbrLmT7Vg+ipV+1CcMGOqueTq8\r\n	MFlabHgRm0yqGkYsNECOkg==\r\n	f
582	nx8Pt4iFpHRTfBf1k3zLGMtkGjOp4CQO\r\n	KbeFZUL7rKMw2ennQE2zzr3KMWBGnJbb+T8PgBCPtpE=\r\n	9q6DarGhck0rZSvKcRtMJA==\r\n	f
583	muVARVKm3Gg2PgczoRagyGZncW1GsGp7\r\n	TkcYUgZ6fPmaG5gBViUaSnEfI5uP3A31CpycLzbi5t8=\r\n	U2XFyVZ2JIVk3XvcnEDMXQ==\r\n	f
584	h4TGUn0p/9stPeZ0EYSQIS3vRPMWODhV\r\n	Byo+lvbCfeA9cpo7ah49hV3jSjEQsznLAFeiVxRAnbg=\r\n	HCbbvhoFknrZX1vxsCcB4Q==\r\n	f
585	hNMfdpSeq+1Mw1D39G7wBBUrpk5qFdUH\r\n	LRFGnUgKGb8GmXWP/HXiuIEwB9At3ou65G9byHCLs5k=\r\n	Vm58df3kGAG04pZMlIVnbQ==\r\n	f
586	9C6um9YlGNOaRD5m2oEF8QwSn8fBpUV1\r\n	5ECG8pD3/A2vghysv8vR0NpmR4mOyzAkuLAVnaAqn8A=\r\n	FRTIfcIlj4WcZQUFnwICEg==\r\n	f
587	J6wrhr40pJHNnJ0P1j4KwRzTPyITG1l8\r\n	Z4rD/bJYgDP7i4DaUtOrhEPjTUC55o0dZ06qfJ0PYGA=\r\n	og/XFsGhCTiPKVC+U9q71Q==\r\n	f
588	ifHC5ETmoqVxCdy0L4d0Ec3FniNq2+XL\r\n	kh06QpNMXuKhs/1HlTvnOwo8IXqMh+or\r\n	LWSa7r69ZJXRp8Ff09AxxQ==\r\n	f
589	/jSIcbcbv9RNj0/Rox3qCi/Qncr3Jeju\r\n	mdeYJsF/CCDdrl4ZUv58XfYFovsFxMqXHDUbzqFpFhn3Wum6kYUU7A==\r\n	UlJHsgr5+d9NL129kEIb9A==\r\n	f
590	UxZ+NteQIu/qINHGCpd95DR5QcUlSe4e\r\n	lvi4B0ZFAFvdnirQJA9hgAyV6g4knxHWzdIL1HK8hew=\r\n	MsWzVIhl04mZU4sb2RftXA==\r\n	f
591	1EeFTyyF8VOJ6ss3XFBycsBPzG+0fj5M\r\n	fSZWCPguk/b5FEf1TorIks0jjBgpG8UAp8I2wepG31uwhV12RHw2Zw==\r\n	yPt2J8rOt43+crpGLvQ2cg==\r\n	f
592	tmwZM+PDD0u+fZ9ka3tVdIDzHU1g5aJZ\r\n	gC1kNv/Ff1B6TC1LdLfaIeOoUweo7RYIvJAgNuoi7l1wT3LZCdGZ4/bVOOr6UUHCnpeI83vdo/7R\r\n7boNrvdBGA==\r\n	EEtQLiz+2wcbMobHvwmrig==\r\n	f
593	2g3XJENddZNUfyK1SOF766cKmlKo4/Gz\r\n	Y6+AgRl/IlFbWEuNcJGG1uk/mZmTp5Nb2QTLBdBGz3SfB83EnVL0dcBzX6IFkSQapyu4zvNyYzc=\r\n	Xhliux8gv4uQl6DQaK877Q==\r\n	f
594	IXnQBQ0GLdNKH087hrLq1QTdHIkxHdex\r\n	MqA4NC0M7/YUr2M5sGb2QKvPRBegROt3JXiMLn0grWo=\r\n	Z6KdbSwj78d+F8lMHvryoA==\r\n	f
595	u4/jKOuu3DExBTxElQ8Xf5tHLRETNtf8\r\n	AJuvElr+yj8Os14jM7JmrsHV7qUgheVYi6SNqyMMLtQ=\r\n	BwJD6IlFQYdWA2h6D7FNYQ==\r\n	f
596	VULJynJIeok7UpdXuXRKifCmtcJ1XziX\r\n	JRO3qM9XSBF2DW8tbkDe94puvqqW9syp4VDBZyCf2jQ=\r\n	Ttif3GyLD/l+FvAJi3JHBw==\r\n	f
597	xMuRtaMWiprDSdjNAwk4XQ==\r\n	w/m+o4g0yQTb32VSfJ20rR4ALJGpklQf67N1xT0FGzl7CwuGv5pitg==\r\n	TlIAlJgS6/a6wiq6K1w33A==\r\n	f
598	UOfZIilCHUf0ODxNGoTKPA==\r\n	WuWaWHdyaUk0yKLUucysVh/OxcgaMUkNYRa/w7Tbxvib2Lt7fTfSIQ==\r\n	Dh+dlAo6jCVp9phH+wbZzA==\r\n	f
599	7r+q/nY2AMsKisStZg/ObQ==\r\n	PLn+/IRgRww9xdck95bsVFS7CnRGYafAl6SJPgxOQm0=\r\n	FPKdu5LSoAlrNPpr6t3nyg==\r\n	f
600	kcaBzRVPr3z3ErB2zDn+9Q==\r\n	U92j1pMuUFjn/f6JgInSTfs25jE7g7v9vUki8lPA/84=\r\n	h9lxq6BwaYw37+YbSpDmLw==\r\n	f
601	uDovpboZ+RqXIPpSDC/N1g==\r\n	+MtV29ivI10z2b6R0vzJblPY/tXMHdkV/ONHjHv4b5VF/g+OUgbAaQ==\r\n	J3eID4uylIrd3adTm3K02Q==\r\n	f
602	peQmH+KtDFcee4wJyDdY4Q==\r\n	zM/f2biHFeDtCRRzEjrU2lnt7cYrXPWtm233zE3QomwjTRTgJ9M0C3TXMbcGa/h9F2r/qXdGqT8j\r\nrVwJwhFrMMSh+szfvp7FBQC7jLn2hOpK/T8xQcdElaU4CeSzHw/m\r\n	qDP9Rgwipk+3whOeuLow3Q==\r\n	f
603	5Kbc/JiUkkgK+roUvIRWng==\r\n	wZNBXi+fHLtCcI8f2gL87XnlhJiW5o7nGO7KzEX53Lc=\r\n	yUEm+hQT4TSY7nFl8ezcGA==\r\n	f
604	QKgawSOE4kLdrsvEDF9++A==\r\n	6cThbRJtuAqkBkm+fF7iYDmRvOw3V1mic+tNakev0aSz4e7B1snYyHOH3VAN8gY9\r\n	v8Fv9V12g/oqMxVeKl/Tjg==\r\n	f
605	prH6Hl4chFIyK7ziNOnW/g==\r\n	D3tSmk/PJo1DLRyRCqdn++BD6mIYr7j+yUO7WQHj/a7CRWuPF6xCrQ==\r\n	FW/wvjXOkWf1OeaoelqryQ==\r\n	f
606	9w7Q+BLW5F5ShOucVAs9ew==\r\n	e1zvZjpKohR+1RIDBPhKWCGHn/p+H6kuTTckdFVf3M1fuMc0+8ND3MPWIVzfc4dn\r\n	bN6JzhjouZlxlKayaN3vHA==\r\n	f
607	gWwV63R1BgwM4Ggh7cvPKg==\r\n	CjbdjExCJx2gZZRCjUfR66wFQWFA3SglGvas+lPXwRA=\r\n	pTNf1QjpSOB0IRXEzT7VJQ==\r\n	f
608	BFQenonGV/+UV6WVXEMyUw==\r\n	t5byD3gVFblFr1UkQmyYSUujmHWfQoJNGC0RFZ76xc/nYhTdXskiPlddswuqWR7L\r\n	gYn3bEHHwN1CAXt2Gpp8+Q==\r\n	f
609	3LPQ+GsvlAnqlMy6E9h4VA==\r\n	sAluP/KdGlS9cFbkfYG19tl0xxr7BMDJ8/Z5sxgyNIA=\r\n	FBrWieeoC5yg4i4ujL6ghw==\r\n	f
610	5V8+cPo1bfKADTGAdZPolw==\r\n	KZEq75INHzBJGSzLNc6PZxxV3mlysVkvPTz1Lui8esAYlLl3vGvzSjnhGBjLYQ8M\r\n	iAO7Xm+lSSK4JgXHqlG40Q==\r\n	f
611	lHmtv92p+tPkM+GVJXnvEw==\r\n	x543kAOt0f57AThk7h2KSbcGZee/COc3kLGhHH3zLA/4S/L5+5jEdotR8w/NPoq4Ct9DBEWjlLU=\r\n	YYN5od3b73v6VGdTFnI+xw==\r\n	f
\.


--
-- TOC entry 1879 (class 0 OID 16950)
-- Dependencies: 1537
-- Data for Name: municipality; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY municipality (id, description, province, cadastre) FROM stdin;
2886	FIUMINATA	MC	D628
2887	FIVIZZANO	MS	D629
2888	FLAIBANO	UD	D630
2889	FLAVON	TN	D631
2890	FLERO	BS	D634
2891	FLORESTA	ME	D635
2892	FLORIDIA	SR	D636
2893	FLORINAS	SS	D637
2894	FLUMERI	AV	D638
2895	FLUMINIMAGGIORE	CI	D639
2896	FLUSSIO	NU	D640
2897	FOBELLO	VC	D641
2898	FOGGIA	FG	D643
2899	FOGLIANISE	BN	D644
2900	FOGLIANO REDIPUGLIA	GO	D645
2901	FOGLIZZO	TO	D646
2902	FOIANO DELLA CHIANA	AR	D649
2903	FOIANO DI VAL FORTORE	BN	D650
2904	FOLGARIA	TN	D651
2905	FOLIGNANO	AP	D652
2906	FOLIGNO	PG	D653
2907	FOLLINA	TV	D654
2908	FOLLO	SP	D655
2909	FOLLONICA	GR	D656
2910	FOMBIO	LO	D660
2911	FONDACHELLI-FANTINA	ME	D661
2912	FONDI	LT	D662
2913	FONDO	TN	D663
2914	FONNI	NU	D665
2915	FONTAINEMORE	AO	D666
2916	FONTANA LIRI	FR	D667
2917	FONTANELICE	BO	D668
2919	FONTANAFREDDA	PN	D670
2920	FONTANAROSA	AV	D671
2921	FONTANELLA	BG	D672
2922	FONTANELLATO	PR	D673
2923	FONTANELLE	TV	D674
2924	FONTANETO D'AGOGNA	NO	D675
2925	FONTANETTO PO	VC	D676
2926	FONTANIGORDA	GE	D677
2927	FONTANILE	AT	D678
2928	FONTANIVA	PD	D679
2929	FONTE	TV	D680
2930	FONTECCHIO	AQ	D681
2931	FONTECHIARI	FR	D682
2932	FONTEGRECA	CE	D683
2933	FONTENO	BG	D684
2934	FONTEVIVO	PR	D685
2935	FONZASO	BL	D686
2936	FOPPOLO	BG	D688
2937	FORANO	RI	D689
2938	SAN GIOVANNI TEATINO	CH	D690
2939	FORCE	AP	D691
2940	FORCHIA	BN	D693
2941	FORCOLA	SO	D694
2942	FORDONGIANUS	OR	D695
2943	FORENZA	PZ	D696
2944	FORESTO SPARSO	BG	D697
2945	FORGARIA NEL FRIULI	UD	D700
2946	FORINO	AV	D701
2947	FORIO	NA	D702
2948	FORLI' DEL SANNIO	IS	D703
2949	FORLI'	FC	D704
2950	FORLIMPOPOLI	FC	D705
2951	FORMAZZA	VB	D706
2952	FORMELLO	RM	D707
2953	FORMIA	LT	D708
2954	FORMICOLA	CE	D709
2955	FORMIGARA	CR	D710
2956	FORMIGINE	MO	D711
2957	FORMIGLIANA	VC	D712
2958	FORMIGNANA	FE	D713
2959	FORNACE	TN	D714
2960	FORNELLI	IS	D715
2961	TONEZZA DEL CIMONE	VI	D717
2962	FORNI AVOLTRI	UD	D718
2963	FORNI DI SOPRA	UD	D719
2964	FORNI DI SOTTO	UD	D720
2965	FORNO CANAVESE	TO	D725
2966	FORNO DI ZOLDO	BL	D726
2967	FORNOVO SAN GIOVANNI	BG	D727
2968	FORNOVO DI TARO	PR	D728
2969	FORTE DEI MARMI	LU	D730
2970	FORTEZZA * FRANZENSFESTE	BZ	D731
2971	FORTUNAGO	PV	D732
2972	FORZA D'AGRO'	ME	D733
2973	FOSCIANDORA	LU	D734
2974	FOSDINOVO	MS	D735
2975	FOSSA	AQ	D736
2976	FOSSALTO	CB	D737
2977	FOSSACESIA	CH	D738
2978	FOSSALTA DI PIAVE	VE	D740
2979	FOSSALTA DI PORTOGRUARO	VE	D741
2980	FOSSANO	CN	D742
2981	FOSSATO SERRALTA	CZ	D744
2982	FOSSATO DI VICO	PG	D745
2983	MONTEBELLO IONICO	RC	D746
2984	FOSSO'	VE	D748
2985	FOSSOMBRONE	PU	D749
2986	FOZA	VI	D750
2987	FRABOSA SOPRANA	CN	D751
2988	FRABOSA SOTTANA	CN	D752
2989	FRAGAGNANO	TA	D754
2990	FRAGNETO L'ABATE	BN	D755
2991	FRAGNETO MONFORTE	BN	D756
2992	FRAINE	CH	D757
2993	FRAMURA	SP	D758
2994	FRANCAVILLA BISIO	AL	D759
2995	FRANCAVILLA D'ETE	FM	D760
2996	FRANCAVILLA FONTANA	BR	D761
2997	FRANCAVILLA ANGITOLA	VV	D762
2998	FRANCAVILLA AL MARE	CH	D763
2999	FRANCAVILLA MARITTIMA	CS	D764
3000	FRANCAVILLA DI SICILIA	ME	D765
3001	FRANCAVILLA IN SINNI	PZ	D766
3002	FRANCICA	VV	D767
3003	FRANCOFONTE	SR	D768
3004	FRANCOLISE	CE	D769
3005	FRASCARO	AL	D770
3006	FRASCAROLO	PV	D771
3007	FRASCATI	RM	D773
3008	FRASCINETO	CS	D774
3009	FRASSILONGO	TN	D775
3010	FRASSINELLE POLESINE	RO	D776
3011	FRASSINELLO MONFERRATO	AL	D777
3012	FRASSINETO PO	AL	D780
3013	FRASSINETTO	TO	D781
3014	FRASSINO	CN	D782
3015	FRASSINORO	MO	D783
3016	FRASSO TELESINO	BN	D784
3017	FRASSO SABINO	RI	D785
3018	UMBERTIDE	PG	D786
3019	FRATTA TODINA	PG	D787
3020	FRATTA POLESINE	RO	D788
3021	FRATTAMAGGIORE	NA	D789
3022	FRATTAMINORE	NA	D790
3023	FRATTE ROSA	PU	D791
3024	FRAZZANO'	ME	D793
3025	FREGONA	TV	D794
3026	FRESAGRANDINARIA	CH	D796
3027	FRESONARA	AL	D797
3028	FRIGENTO	AV	D798
3029	FRIGNANO	CE	D799
3030	VILLA DI BRIANO	CE	D801
3031	FRINCO	AT	D802
3032	FRISA	CH	D803
3033	FRISANCO	PN	D804
3034	FRONT	TO	D805
3035	FRONTINO	PU	D807
3036	FRONTONE	PU	D808
3037	FROSINONE	FR	D810
3038	FROSOLONE	IS	D811
3039	FROSSASCO	TO	D812
3040	FRUGAROLO	AL	D813
3041	FUBINE	AL	D814
3042	FUCECCHIO	FI	D815
3043	FUIPIANO VALLE IMAGNA	BG	D817
3044	FUMANE	VR	D818
3045	FUMONE	FR	D819
3046	FUNES * VILLNOESS	BZ	D821
3047	FURCI	CH	D823
3048	FURCI SICULO	ME	D824
3049	FURNARI	ME	D825
3050	FURORE	SA	D826
3051	FURTEI	VS	D827
3052	FUSCALDO	CS	D828
3053	FUSIGNANO	RA	D829
3054	FUSINE	SO	D830
3055	FUTANI	SA	D832
3056	GABBIONETA BINANUOVA	CR	D834
3057	GABIANO	AL	D835
3058	GABICCE MARE	PU	D836
3059	GABY	AO	D839
3060	GADESCO PIEVE DELMONA	CR	D841
3061	GADONI	NU	D842
3062	GAETA	LT	D843
3063	GAGGI	ME	D844
3064	GAGGIANO	MI	D845
3065	GAGGIO MONTANO	BO	D847
3066	GAGLIANICO	BI	D848
3067	GAGLIANO CASTELFERRATO	EN	D849
3068	GAGLIANO ATERNO	AQ	D850
3069	GAGLIANO DEL CAPO	LE	D851
3070	GAGLIATO	CZ	D852
3071	GAGLIOLE	MC	D853
3072	GAIARINE	TV	D854
3073	GAIBA	RO	D855
3074	GAIOLA	CN	D856
3075	GAIOLE IN CHIANTI	SI	D858
3076	GAIRO	OG	D859
3077	GAIS * GAIS	BZ	D860
3078	GALATI MAMERTINO	ME	D861
3079	GALATINA	LE	D862
3080	GALATONE	LE	D863
3081	GALATRO	RC	D864
3082	GALBIATE	LC	D865
3083	GALEATA	FC	D867
3084	GALGAGNANO	LO	D868
3085	GALLARATE	VA	D869
3086	GALLESE	VT	D870
3087	GALLIATE LOMBARDO	VA	D871
3088	GALLIATE	NO	D872
3089	GALLIAVOLA	PV	D873
3090	GALLICANO	LU	D874
3091	GALLICANO NEL LAZIO	RM	D875
3092	GALLICCHIO	PZ	D876
3093	GALLIERA	BO	D878
3094	GALLIERA VENETA	PD	D879
3095	GALLINARO	FR	D881
3096	GALLIO	VI	D882
3097	GALLIPOLI	LE	D883
3098	GALLO MATESE	CE	D884
3099	GALLODORO	ME	D885
3100	GALLUCCIO	CE	D886
3101	GALTELLI	NU	D888
3102	GALZIGNANO TERME	PD	D889
3103	GAMALERO	AL	D890
3104	GAMBARA	BS	D891
3105	GAMBARANA	PV	D892
3106	GAMBASCA	CN	D894
3107	GAMBASSI TERME	FI	D895
3108	GAMBATESA	CB	D896
3109	GAMBELLARA	VI	D897
3110	GAMBERALE	CH	D898
3111	GAMBETTOLA	FC	D899
3112	GAMBOLO'	PV	D901
3113	GAMBUGLIANO	VI	D902
3114	GANDELLINO	BG	D903
3115	GANDINO	BG	D905
3116	GANDOSSO	BG	D906
3117	GANGI	PA	D907
3118	GARAGUSO	MT	D909
3119	GARBAGNA	AL	D910
3120	GARBAGNA NOVARESE	NO	D911
3121	GARBAGNATE MILANESE	MI	D912
3122	GARBAGNATE MONASTERO	LC	D913
3123	GARDA	VR	D915
3124	GARDONE RIVIERA	BS	D917
3125	GARDONE VAL TROMPIA	BS	D918
3126	GARESSIO	CN	D920
3127	GARGALLO	NO	D921
3128	GARGARO	GO	D922
3129	GARGAZZONE * GARGAZON	BZ	D923
3130	GARGNANO	BS	D924
3131	GARLASCO	PV	D925
3132	GARLATE	LC	D926
3133	GARLENDA	SV	D927
3134	GARNIGA TERME	TN	D928
3135	GARZENO	CO	D930
3136	GARZIGLIANA	TO	D931
3137	GASPERINA	CZ	D932
3138	GASSINO TORINESE	TO	D933
3139	GATTATICO	RE	D934
3140	GATTEO	FC	D935
3141	GATTICO	NO	D937
3142	GATTINARA	VC	D938
3143	GAVARDO	BS	D940
3144	GAVAZZANA	AL	D941
3145	GAVELLO	RO	D942
3146	GAVERINA TERME	BG	D943
3147	GAVI	AL	D944
3148	GAVIGNANO	RM	D945
3149	GAVIRATE	VA	D946
3150	GAVOI	NU	D947
3151	GAVORRANO	GR	D948
3152	GAZOLDO DEGLI IPPOLITI	MN	D949
3153	GAZZADA SCHIANNO	VA	D951
3154	GAZZANIGA	BG	D952
3155	GAZZO PADOVANO	PD	D956
3156	GAZZO VERONESE	VR	D957
3157	GAZZOLA	PC	D958
3158	GAZZUOLO	MN	D959
3159	GELA	CL	D960
3160	GEMMANO	RN	D961
3161	GEMONA DEL FRIULI	UD	D962
3162	GEMONIO	VA	D963
3163	GENAZZANO	RM	D964
3164	GENGA	AN	D965
3165	GENIVOLTA	CR	D966
3166	GENOLA	CN	D967
3167	GENONI	NU	D968
3168	GENOVA	GE	D969
3169	GENURI	VS	D970
3170	GENZANO DI LUCANIA	PZ	D971
3171	GENZANO DI ROMA	RM	D972
3172	GENZONE	PV	D973
3173	GERA LARIO	CO	D974
3174	GERACE	RC	D975
3175	LOCRI	RC	D976
3176	GERACI SICULO	PA	D977
3177	GERANO	RM	D978
3178	GERENZAGO	PV	D980
3179	GERENZANO	VA	D981
3180	GERGEI	NU	D982
3181	GERMAGNANO	TO	D983
3182	GERMAGNO	VB	D984
3183	GERMASINO	CO	D986
3184	GERMIGNAGA	VA	D987
3185	GEROCARNE	VV	D988
3186	GEROLA ALTA	SO	D990
3187	GEROSA	BG	D991
3188	GERRE DE' CAPRIOLI	CR	D993
3189	GESICO	CA	D994
3190	GESSATE	MI	D995
3191	GESSOPALENA	CH	D996
3192	GESTURI	VS	D997
3193	GESUALDO	AV	D998
3194	GHEDI	BS	D999
3195	GHEMME	NO	E001
3196	GHIFFA	VB	E003
3197	GHILARZA	OR	E004
3198	GHISALBA	BG	E006
3199	GHISLARENGO	VC	E007
3200	GIACCIANO CON BARUCHELLA	RO	E008
3201	GIAGLIONE	TO	E009
3202	GIANICO	BS	E010
3203	GIANO VETUSTO	CE	E011
3204	GIANO DELL'UMBRIA	PG	E012
3205	GIARDINELLO	PA	E013
3206	GIARDINI-NAXOS	ME	E014
3207	GIAROLE	AL	E015
3208	GIARRATANA	RG	E016
3209	GIARRE	CT	E017
3210	GIAVE	SS	E019
3211	GIAVENO	TO	E020
3212	GIAVERA DEL MONTELLO	TV	E021
3213	GIBA	CI	E022
3214	GIBELLINA	TP	E023
3215	GIFFLENGA	BI	E024
3216	GIFFONE	RC	E025
3217	GIFFONI SEI CASALI	SA	E026
3218	GIFFONI VALLE PIANA	SA	E027
3219	GIGNESE	VB	E028
3220	GIGNOD	AO	E029
3221	GILDONE	CB	E030
3222	GIMIGLIANO	CZ	E031
3224	GINESTRA	PZ	E033
3225	GINESTRA DEGLI SCHIAVONI	BN	E034
3226	GINOSA	TA	E036
3227	GIOI	SA	E037
3228	GIOIA DEL COLLE	BA	E038
3229	GIOIA SANNITICA	CE	E039
3230	GIOIA DEI MARSI	AQ	E040
3231	GIOIA TAURO	RC	E041
3232	GIOIOSA MAREA	ME	E043
3233	GIOIOSA IONICA	RC	E044
3234	GIOVE	TR	E045
3235	GIOVINAZZO	BA	E047
3236	GIOVO	TN	E048
3237	GIRASOLE	OG	E049
3238	GIRIFALCO	CZ	E050
3239	GIRONICO	CO	E051
3240	GISSI	CH	E052
3241	GIUGGIANELLO	LE	E053
3242	GIUGLIANO IN CAMPANIA	NA	E054
3243	GIULIANA	PA	E055
3244	GIULIANO TEATINO	CH	E056
3245	GIULIANO DI ROMA	FR	E057
3246	GIULIANOVA	TE	E058
3247	GIUNCUGNANO	LU	E059
3248	GIUNGANO	SA	E060
3249	GIURDIGNANO	LE	E061
3250	GIUSSAGO	PV	E062
3251	GIUSSANO	MB	E063
3252	GIUSTENICE	SV	E064
3253	GIUSTINO	TN	E065
3254	GIUSVALLA	SV	E066
3255	GIVOLETTO	TO	E067
3256	GIZZERIA	CZ	E068
3257	GLORENZA * GLURNS	BZ	E069
3258	SESTA GODANO	SP	E070
3259	GODEGA DI SANT'URBANO	TV	E071
3260	GODIASCO	PV	E072
3261	GODRANO	PA	E074
3262	GOITO	MN	E078
3263	GOLASECCA	VA	E079
3264	GOLFERENZO	PV	E081
3265	GOMBITO	CR	E082
3266	GONARS	UD	E083
3267	GONI	CA	E084
3268	GONNOSFANADIGA	VS	E085
3269	GONNESA	CI	E086
3270	GONNOSCODINA	OR	E087
3271	GONNOSTRAMATZA	OR	E088
3272	GONZAGA	MN	E089
3273	GORDONA	SO	E090
3274	GORGA	RM	E091
3275	GORGO AL MONTICANO	TV	E092
3276	GORGOGLIONE	MT	E093
3277	GORGONZOLA	MI	E094
3278	GORIANO SICOLI	AQ	E096
3279	GORIZIA	GO	E098
3280	GORLAGO	BG	E100
3281	GORLA MAGGIORE	VA	E101
3282	GORLA MINORE	VA	E102
3283	GORLE	BG	E103
3284	GORNATE-OLONA	VA	E104
3285	GORNO	BG	E106
3286	GORO	FE	E107
3287	GORRETO	GE	E109
3288	GORZEGNO	CN	E111
3289	GOSALDO	BL	E113
3290	GOSSOLENGO	PC	E114
3291	GOTTASECCA	CN	E115
3292	GOTTOLENGO	BS	E116
3293	GOVONE	CN	E118
3294	GOZZANO	NO	E120
3295	GRACOVA SERRAVALLE	GO	E121
3296	GRADARA	PU	E122
3297	GRADISCA D'ISONZO	GO	E124
3298	GRADO	GO	E125
3299	GRADOLI	VT	E126
3300	GRAFFIGNANA	LO	E127
3301	GRAFFIGNANO	VT	E128
3302	GRAGLIA	BI	E130
3303	GRAGNANO	NA	E131
3304	GRAGNANO TREBBIENSE	PC	E132
3305	GRAMMICHELE	CT	E133
3306	GRANA	AT	E134
3307	GRANAGLIONE	BO	E135
3308	GRANAROLO DELL'EMILIA	BO	E136
3309	GRANCONA	VI	E138
3310	GRANDATE	CO	E139
3311	GRANDOLA ED UNITI	CO	E141
3312	GRANITI	ME	E142
3313	GRANOZZO CON MONTICELLO	NO	E143
3314	GRANTOLA	VA	E144
3315	GRANTORTO	PD	E145
3316	GRANZE	PD	E146
3317	GRASSANO	MT	E147
3318	GRASSOBBIO	BG	E148
3319	GRATTERI	PA	E149
3320	GRAUNO	TN	E150
3321	GRAVEDONA	CO	E151
3322	GRAVELLONA LOMELLINA	PV	E152
3323	GRAVELLONA TOCE	VB	E153
3324	GRAVERE	TO	E154
3325	GRAVINA IN PUGLIA	BA	E155
3326	GRAVINA DI CATANIA	CT	E156
3327	GRAZZANISE	CE	E158
3328	GRAZZANO BADOGLIO	AT	E159
3329	GRECCIO	RI	E160
3330	GRECI	AV	E161
3331	GREGGIO	VC	E163
3332	GREMIASCO	AL	E164
3333	GRESSAN	AO	E165
3334	GRESSONEY-LA-TRINITE'	AO	E167
3335	GRESSONEY-SAINT-JEAN	AO	E168
3336	GREVE IN CHIANTI	FI	E169
3337	GREZZAGO	MI	E170
3338	GREZZANA	VR	E171
3339	GRIANTE	CO	E172
3340	GRICIGNANO DI AVERSA	CE	E173
3341	GRIGNASCO	NO	E177
3342	GRIGNO	TN	E178
3343	GRIMACCO	UD	E179
3344	GRIMALDI	CS	E180
3345	GRINZANE CAVOUR	CN	E182
3347	GRISIGNANO DI ZOCCO	VI	E184
3348	GRISOLIA	CS	E185
3349	GRIZZANA MORANDI	BO	E187
3350	GROGNARDO	AL	E188
3351	GROMO	BG	E189
3352	GRONDONA	AL	E191
3353	GRONE	BG	E192
3354	GRONTARDO	CR	E193
3355	GROPELLO CAIROLI	PV	E195
3356	GROPPARELLO	PC	E196
3357	GROSCAVALLO	TO	E199
3358	GROSIO	SO	E200
3359	GROSOTTO	SO	E201
3360	GROSSETO	GR	E202
3361	GROSSO	TO	E203
3362	GROTTAFERRATA	RM	E204
3363	GROTTAGLIE	TA	E205
3364	GROTTAMINARDA	AV	E206
3365	GROTTAMMARE	AP	E207
3366	GROTTAZZOLINA	FM	E208
3367	GROTTE	AG	E209
3368	GROTTE DI CASTRO	VT	E210
3369	GROTTERIA	RC	E212
3370	GROTTOLE	MT	E213
3371	GROTTOLELLA	AV	E214
3372	GRUARO	VE	E215
3373	GRUGLIASCO	TO	E216
3374	GRUMELLO CREMONESE ED UNITI	CR	E217
3375	GRUMELLO DEL MONTE	BG	E219
3376	GRUMENTO NOVA	PZ	E221
3377	GRUMES	TN	E222
3378	GRUMO APPULA	BA	E223
3379	GRUMO NEVANO	NA	E224
3380	GRUMOLO DELLE ABBADESSE	VI	E226
3381	GUAGNANO	LE	E227
3382	GUALDO	MC	E228
3383	GUALDO CATTANEO	PG	E229
3384	GUALDO TADINO	PG	E230
3385	GUALTIERI	RE	E232
3386	GUALTIERI SICAMINO'	ME	E233
3387	GUAMAGGIORE	CA	E234
3388	GUANZATE	CO	E235
3389	GUARCINO	FR	E236
3390	GUARDABOSONE	VC	E237
3391	GUARDAMIGLIO	LO	E238
3392	GUARDAVALLE	CZ	E239
3393	GUARDA VENETA	RO	E240
3394	GUARDEA	TR	E241
3395	GUARDIA PIEMONTESE	CS	E242
3396	GUARDIAGRELE	CH	E243
3397	GUARDIALFIERA	CB	E244
3398	GUARDIA LOMBARDI	AV	E245
3399	GUARDIA PERTICARA	PZ	E246
3400	GUARDIAREGIA	CB	E248
3401	GUARDIA SANFRAMONDI	BN	E249
3402	GUARDISTALLO	PI	E250
3403	GUARENE	CN	E251
3404	GUASILA	CA	E252
3405	GUASTALLA	RE	E253
3406	GUAZZORA	AL	E255
3407	GUBBIO	PG	E256
3408	GUDO VISCONTI	MI	E258
3409	GUGLIONESI	CB	E259
3410	GUIDIZZOLO	MN	E261
3411	GUIDONIA MONTECELIO	RM	E263
3412	GUIGLIA	MO	E264
3413	SIZIANO	PV	E265
3414	GUILMI	CH	E266
3415	GURRO	VB	E269
3416	GUSPINI	VS	E270
3417	GUSSAGO	BS	E271
3418	GUSSOLA	CR	E272
3419	HONE	AO	E273
3420	JACURSO	CZ	E274
3421	IDRIA	GO	E278
3422	IDRO	BS	E280
3423	IGLESIAS	CI	E281
3424	IGLIANO	CN	E282
3425	ILBONO	OG	E283
3426	ILLASI	VR	E284
3427	ILLORAI	SS	E285
3428	IMBERSAGO	LC	E287
3429	IMER	TN	E288
3430	IMOLA	BO	E289
3431	IMPERIA	IM	E290
3432	IMPRUNETA	FI	E291
3433	INARZO	VA	E292
3434	INCISA SCAPACCINO	AT	E295
3435	INCISA IN VAL D'ARNO	FI	E296
3436	INCUDINE	BS	E297
3437	INDUNO OLONA	VA	E299
3438	INGRIA	TO	E301
3439	INTRAGNA	VB	E304
3440	INTROBIO	LC	E305
3441	INTROD	AO	E306
3442	INTRODACQUA	AQ	E307
3443	INTROZZO	LC	E308
3444	INVERIGO	CO	E309
3445	INVERNO E MONTELEONE	PV	E310
3446	INVERSO PINASCA	TO	E311
3447	INVERUNO	MI	E313
3448	INVORIO	NO	E314
3449	INZAGO	MI	E317
3450	JOLANDA DI SAVOIA	FE	E320
3451	IONADI	VV	E321
3452	IRGOLI	NU	E323
3453	IRMA	BS	E325
3454	IRSINA	MT	E326
3455	ISASCA	CN	E327
3456	ISCA SULLO IONIO	CZ	E328
3457	ISCHIA	NA	E329
3458	ISCHIA DI CASTRO	VT	E330
3459	ISCHITELLA	FG	E332
3460	ISEO	BS	E333
3461	ISERA	TN	E334
3462	ISERNIA	IS	E335
3463	ISILI	NU	E336
3464	ISNELLO	PA	E337
3465	ISOLA D'ASTI	AT	E338
3466	ISOLA DI CAPO RIZZUTO	KR	E339
3467	ISOLA DEL LIRI	FR	E340
3468	ISOLA DEL CANTONE	GE	E341
3469	MADESIMO	SO	E342
3470	ISOLA DEL GRAN SASSO D'ITALIA	TE	E343
3471	ISOLABELLA	TO	E345
3472	ISOLABONA	IM	E346
3473	ISOLA DEL GIGLIO	GR	E348
3474	ISOLA DELLA SCALA	VR	E349
3475	ISOLA DELLE FEMMINE	PA	E350
3476	ISOLA DEL PIANO	PU	E351
3477	ISOLA DI FONDRA	BG	E353
3478	ISOLA VICENTINA	VI	E354
3480	ISOLA DOVARESE	CR	E356
3481	ISOLA RIZZA	VR	E358
3482	ISOLA SANT'ANTONIO	AL	E360
3483	ISOLE TREMITI	FG	E363
3484	ISORELLA	BS	E364
3485	ISPANI	SA	E365
3486	ISPICA	RG	E366
3487	ISPRA	VA	E367
3488	ISSIGLIO	TO	E368
3489	ISSIME	AO	E369
3490	ISSO	BG	E370
3491	ISSOGNE	AO	E371
3492	VASTO	CH	E372
3493	ISTRANA	TV	E373
3494	ITALA	ME	E374
3495	ITRI	LT	E375
3496	ITTIREDDU	SS	E376
3497	ITTIRI	SS	E377
3498	IVANO FRACENA	TN	E378
3499	IVREA	TO	E379
3500	IZANO	CR	E380
3501	JELSI	CB	E381
3502	JENNE	RM	E382
3503	JERAGO CON ORAGO	VA	E386
3504	JERZU	OG	E387
3505	JESI	AN	E388
3506	JOPPOLO	VV	E389
3507	JOPPOLO GIANCAXIO	AG	E390
3508	JOVENCAN	AO	E391
3509	LABICO	RM	E392
3510	LABRO	RI	E393
3511	LA CASSA	TO	E394
3512	LACCHIARELLA	MI	E395
3513	LACCO AMENO	NA	E396
3514	LACEDONIA	AV	E397
3515	LACES * LATSCH	BZ	E398
3516	LACONI	NU	E400
3517	LAERRU	SS	E401
3518	LAGANADI	RC	E402
3519	LAGHI	VI	E403
3520	LAGLIO	CO	E405
3521	LAGNASCO	CN	E406
3522	LAGO	CS	E407
3523	LAGONEGRO	PZ	E409
3524	LAGOSANTO	FE	E410
3526	LAGUNDO * ALGUND	BZ	E412
3527	LAJATICO	PI	E413
3528	LAIGUEGLIA	SV	E414
3529	LAINATE	MI	E415
3530	LAINO	CO	E416
3531	LAINO BORGO	CS	E417
3532	LAINO CASTELLO	CS	E419
3533	LAION * LAJEN	BZ	E420
3534	LAIVES * LEIFERS	BZ	E421
3535	LALLIO	BG	E422
3536	LA LOGGIA	TO	E423
3537	LAMA DEI PELIGNI	CH	E424
3538	LA MADDALENA	OT	E425
3539	LAMA MOCOGNO	MO	E426
3540	LAMBRUGO	CO	E428
3541	LAMON	BL	E429
3542	LA MORRA	CN	E430
3543	LAMPEDUSA E LINOSA	AG	E431
3544	LAMPORECCHIO	PT	E432
3545	LAMPORO	VC	E433
3546	LANA * LANA	BZ	E434
3547	LANCIANO	CH	E435
3548	LANDIONA	NO	E436
3549	LANDRIANO	PV	E437
3550	LANGHIRANO	PR	E438
3551	LANGOSCO	PV	E439
3553	LANUSEI	OG	E441
3554	LANZADA	SO	E443
3555	LANZO D'INTELVI	CO	E444
3556	LANZO TORINESE	TO	E445
3557	LAPEDONA	FM	E447
3558	LAPIO	AV	E448
3559	LAPPANO	CS	E450
3560	LARCIANO	PT	E451
3561	LARDARO	TN	E452
3562	LARDIRAGO	PV	E454
3563	LARI	PI	E455
3564	LARINO	CB	E456
3565	LASA * LAAS	BZ	E457
3566	LA SALLE	AO	E458
3567	LASCARI	PA	E459
3568	LASINO	TN	E461
3569	LASNIGO	CO	E462
3570	LA SPEZIA	SP	E463
3571	LAS PLASSAS	VS	E464
3572	LASTEBASSE	VI	E465
3573	LASTRA A SIGNA	FI	E466
3574	LATERA	VT	E467
3575	LATERINA	AR	E468
3576	LATERZA	TA	E469
3577	LA THUILE	AO	E470
3578	LATIANO	BR	E471
3579	LATINA	LT	E472
3580	LATISANA	UD	E473
3581	LATRONICO	PZ	E474
3582	LATTARICO	CS	E475
3583	LAUCO	UD	E476
3585	LAUREANA DI BORRELLO	RC	E479
3586	LAUREANA CILENTO	SA	E480
3587	LAUREGNO * LAUREIN	BZ	E481
3588	LAURENZANA	PZ	E482
3589	LAURIA	PZ	E483
3590	LAURIANO	TO	E484
3591	LAURINO	SA	E485
3592	LAURITO	SA	E486
3593	LAURO	AV	E487
3594	LAVAGNA	GE	E488
3595	LAVAGNO	VR	E489
3596	LA VALLE AGORDINA	BL	E490
3597	LA VALLE * WENGEN	BZ	E491
3598	LAVARONE	TN	E492
3599	LAVELLO	PZ	E493
3600	LAVENA PONTE TRESA	VA	E494
3601	LAVENO-MOMBELLO	VA	E496
3602	LAVENONE	BS	E497
3603	LAVIANO	SA	E498
3604	LAVIS	TN	E500
3605	LAZISE	VR	E502
3606	LAZZATE	MB	E504
3607	LECCE NEI MARSI	AQ	E505
3608	LECCE	LE	E506
3609	LECCO	LC	E507
3610	LEFFE	BG	E509
3611	LEGGIUNO	VA	E510
3612	LEGNAGO	VR	E512
3613	LEGNANO	MI	E514
3614	LEGNARO	PD	E515
3615	LEI	NU	E517
3616	LEINI	TO	E518
3617	LEIVI	GE	E519
3618	LEMIE	TO	E520
3619	LENDINARA	RO	E522
3620	LENI	ME	E523
3621	LENNA	BG	E524
3622	LENNO	CO	E525
3623	LENO	BS	E526
3624	LENOLA	LT	E527
3625	LENTA	VC	E528
3626	OSMATE	VA	E529
3627	LENTATE SUL SEVESO	MB	E530
3628	LENTELLA	CH	E531
3629	LENTINI	SR	E532
3630	LEONESSA	RI	E535
3631	LEONFORTE	EN	E536
3632	LEPORANO	TA	E537
3633	LEQUILE	LE	E538
3634	LEQUIO TANARO	CN	E539
3635	LEQUIO BERRIA	CN	E540
3636	LERCARA FRIDDI	PA	E541
3637	LERICI	SP	E542
3638	LERMA	AL	E543
3639	LESA	NO	E544
3640	LESEGNO	CN	E546
3641	LESIGNANO DE' BAGNI	PR	E547
3642	TERENZO	PR	E548
3643	LESINA	FG	E549
3644	LESMO	MB	E550
3645	LESSOLO	TO	E551
3646	LESSONA	BI	E552
3647	LESTIZZA	UD	E553
3648	LETINO	CE	E554
3649	LETOJANNI	ME	E555
3650	LETTERE	NA	E557
3651	LETTOMANOPPELLO	PE	E558
3652	LETTOPALENA	CH	E559
3653	LEVANTO	SP	E560
3654	LEVATE	BG	E562
3655	LEVERANO	LE	E563
3656	LEVICE	CN	E564
3657	LEVICO TERME	TN	E565
3658	LEVONE	TO	E566
3659	LEZZENO	CO	E569
3660	LIBERI	CE	E570
3661	LIBRIZZI	ME	E571
3662	LICATA	AG	E573
3663	LICCIANA NARDI	MS	E574
3664	LICENZA	RM	E576
3665	LICODIA EUBEA	CT	E578
3666	LIERNA	LC	E581
3667	LIGNANA	VC	E583
3668	LIGNANO SABBIADORO	UD	E584
3669	LIGONCHIO	RE	E585
3670	LIGOSULLO	UD	E586
3671	LILLIANES	AO	E587
3672	LIMANA	BL	E588
3673	LIMATOLA	BN	E589
3674	LIMBADI	VV	E590
3675	LIMBIATE	MB	E591
3676	LIMENA	PD	E592
3677	LIMIDO COMASCO	CO	E593
3678	LIMINA	ME	E594
3679	LIMONE SUL GARDA	BS	E596
3680	LIMONE PIEMONTE	CN	E597
3681	LIMOSANO	CB	E599
3682	LINAROLO	PV	E600
3683	LINGUAGLOSSA	CT	E602
3684	LIONI	AV	E605
3685	LIPARI	ME	E606
3686	LIPOMO	CO	E607
3687	LIRIO	PV	E608
3688	LISCATE	MI	E610
3689	LISCIA	CH	E611
3690	LISCIANO NICCONE	PG	E613
3691	LISIGNAGO	TN	E614
3692	LISIO	CN	E615
3693	LISSONE	MB	E617
3694	MILENA	CL	E618
3695	LIVERI	NA	E620
3696	LIVIGNO	SO	E621
3697	LIVINALLONGO DEL COL DI LANA	BL	E622
3698	LIVO	CO	E623
3699	LIVO	TN	E624
3700	LIVORNO	LI	E625
3701	LIVORNO FERRARIS	VC	E626
3702	LIVRAGA	LO	E627
3703	LIZZANELLO	LE	E629
3704	LIZZANO	TA	E630
3705	LOANO	SV	E632
3706	LOAZZOLO	AT	E633
3707	LOCANA	TO	E635
3708	LOCATE VARESINO	CO	E638
3709	LOCATE DI TRIULZI	MI	E639
3710	LOCATELLO	BG	E640
3711	LOCERI	OG	E644
3712	LOCOROTONDO	BA	E645
3713	LOCULI	NU	E646
3714	LODE'	NU	E647
3715	LODI	LO	E648
3716	LODINE	NU	E649
3717	LODI VECCHIO	LO	E651
3718	LODRINO	BS	E652
3719	LOGRATO	BS	E654
3720	LOIANO	BO	E655
3721	LOMAGNA	LC	E656
3722	LOMAZZO	CO	E659
3723	LOMBARDORE	TO	E660
3724	LOMBRIASCO	TO	E661
3725	LOMELLO	PV	E662
3726	LONA LASES	TN	E664
3727	LONATE CEPPINO	VA	E665
3728	LONATE POZZOLO	VA	E666
3729	LONATO	BS	E667
3730	LONDA	FI	E668
3731	LONGANO	IS	E669
3732	LONGARE	VI	E671
3733	LONGARONE	BL	E672
3734	LONGHENA	BS	E673
3735	LONGI	ME	E674
3736	LONGIANO	FC	E675
3737	LONGOBARDI	CS	E677
3738	LONGOBUCCO	CS	E678
3739	LONGONE AL SEGRINO	CO	E679
3740	PORTO AZZURRO	LI	E680
3741	LONGONE SABINO	RI	E681
3742	LONIGO	VI	E682
3743	LORANZE'	TO	E683
3744	LOREGGIA	PD	E684
3745	LOREGLIA	VB	E685
3746	LORENZAGO DI CADORE	BL	E687
3747	LORENZANA	PI	E688
3748	LOREO	RO	E689
3749	LORETO	AN	E690
3750	LORETO APRUTINO	PE	E691
3751	LORIA	TV	E692
3752	LORO CIUFFENNA	AR	E693
3753	LORO PICENO	MC	E694
3754	LORSICA	GE	E695
3755	LOSINE	BS	E698
3756	LOTZORAI	OG	E700
3757	LOVERE	BG	E704
3758	LOVERO	SO	E705
3759	LOZIO	BS	E706
3760	LOZZA	VA	E707
3761	LOZZO DI CADORE	BL	E708
3762	LOZZO ATESTINO	PD	E709
3763	LOZZOLO	VC	E711
3764	LU	AL	E712
3765	LUBRIANO	VT	E713
3766	LUCCA SICULA	AG	E714
3767	LUCCA	LU	E715
3768	LUCERA	FG	E716
3769	LUCIGNANO	AR	E718
3770	LUCINASCO	IM	E719
3771	LUCITO	CB	E722
3772	LUCO DEI MARSI	AQ	E723
3773	LUCOLI	AQ	E724
3774	LUGAGNANO VAL D'ARDA	PC	E726
3775	LUGNACCO	TO	E727
3776	LUGNANO IN TEVERINA	TR	E729
3777	LUGO	RA	E730
3778	LUGO DI VICENZA	VI	E731
3779	LUINO	VA	E734
3780	LUISAGO	CO	E735
3781	LULA	NU	E736
3782	LUMARZO	GE	E737
3783	LUMEZZANE	BS	E738
3784	LUNAMATRONA	VS	E742
3785	LUNANO	PU	E743
3786	LUNGRO	CS	E745
3787	LUOGOSANO	AV	E746
3788	LUOGOSANTO	OT	E747
3789	LUPARA	CB	E748
3790	LURAGO D'ERBA	CO	E749
3791	LURAGO MARINONE	CO	E750
3792	LURANO	BG	E751
3793	LURAS	OT	E752
3794	LURATE CACCIVIO	CO	E753
3795	LUSCIANO	CE	E754
3796	LUSERNA	TN	E757
3797	LUSERNA SAN GIOVANNI	TO	E758
3798	LUSERNETTA	TO	E759
3799	LUSEVERA	UD	E760
3800	LUSIA	RO	E761
3801	LUSIANA	VI	E762
3802	LUSIGLIE'	TO	E763
3803	LUSON * LUESEN	BZ	E764
3806	LUSTRA	SA	E767
3807	LUVINATE	VA	E769
3808	LUZZANA	BG	E770
3809	LUZZARA	RE	E772
3810	LUZZI	CS	E773
3811	MACCAGNO	VA	E775
3812	MACCASTORNA	LO	E777
3813	MACCHIA D'ISERNIA	IS	E778
3814	MACCHIAGODENA	IS	E779
3815	MACCHIA VALFORTORE	CB	E780
3816	MACELLO	TO	E782
3817	MACERATA	MC	E783
3818	MACERATA CAMPANIA	CE	E784
3819	MACERATA FELTRIA	PU	E785
3820	MACHERIO	MB	E786
3821	MACLODIO	BS	E787
3822	MACOMER	NU	E788
3823	MACRA	CN	E789
3824	MACUGNAGA	VB	E790
3825	MADDALONI	CE	E791
3826	MADIGNANO	CR	E793
3827	MADONE	BG	E794
3828	MADONNA DEL SASSO	VB	E795
3829	MAENZA	LT	E798
3830	MAFALDA	CB	E799
3831	MAGASA	BS	E800
3832	MAGENTA	MI	E801
3833	MAGGIORA	NO	E803
3834	MAGHERNO	PV	E804
3835	MAGIONE	PG	E805
3836	MAGISANO	CZ	E806
3837	MAGLIANO DI TENNA	FM	E807
3838	MAGLIANO ALPI	CN	E808
3839	MAGLIANO ALFIERI	CN	E809
3840	MAGLIANO IN TOSCANA	GR	E810
3841	MAGLIANO DE' MARSI	AQ	E811
3842	MAGLIANO SABINA	RI	E812
3843	MAGLIANO ROMANO	RM	E813
3844	MAGLIANO VETERE	SA	E814
3845	MAGLIE	LE	E815
3846	MAGLIOLO	SV	E816
3847	MAGLIONE	TO	E817
3848	MAGNACAVALLO	MN	E818
3849	MAGNAGO	MI	E819
3850	MAGNANO IN RIVIERA	UD	E820
3851	MAGNANO	BI	E821
3852	MAGOMADAS	NU	E825
3853	MAGRE' SULLA STRADA DEL VINO * MARGREID AN DER WEINSTRASSE	BZ	E829
3854	MAGREGLIO	CO	E830
3855	MAJANO	UD	E833
3856	MAIDA	CZ	E834
3857	MAIERA'	CS	E835
3858	MAIERATO	VV	E836
3859	MAIOLATI SPONTINI	AN	E837
3860	MAIOLO	RN	E838
3861	MAIORI	SA	E839
3862	MAIRAGO	LO	E840
3863	MAIRANO	BS	E841
3864	MAISSANA	SP	E842
3865	MALAGNINO	CR	E843
3866	MALALBERGO	BO	E844
3867	MALBORGHETTO-VALBRUNA	UD	E847
3868	MALCESINE	VR	E848
3869	MALE'	TN	E850
3870	MALEGNO	BS	E851
3871	MALEO	LO	E852
3872	MALESCO	VB	E853
3873	MALETTO	CT	E854
3874	MALFA	ME	E855
3875	MALGESSO	VA	E856
3876	MALGRATE	LC	E858
3877	MALITO	CS	E859
3878	MALLARE	SV	E860
3879	MALLES VENOSTA * MALS	BZ	E862
3880	MALNATE	VA	E863
3881	MALO	VI	E864
3882	MALONNO	BS	E865
3883	MALOSCO	TN	E866
3884	MALTIGNANO	AP	E868
3885	MALVAGNA	ME	E869
3886	MALVICINO	AL	E870
3887	MALVITO	CS	E872
3888	MAMMOLA	RC	E873
3889	MAMOIADA	NU	E874
3890	MANCIANO	GR	E875
3891	MANDANICI	ME	E876
3892	MANDAS	CA	E877
3893	MANDATORICCIO	CS	E878
3894	MANDELLO DEL LARIO	LC	E879
3895	MANDELLO VITTA	NO	E880
3896	MANDURIA	TA	E882
3897	MANERBA DEL GARDA	BS	E883
3898	MANERBIO	BS	E884
3899	MANFREDONIA	FG	E885
3900	MANGO	CN	E887
3901	MANGONE	CS	E888
3902	MANIAGO	PN	E889
3903	MANOCALZATI	AV	E891
3904	MANOPPELLO	PE	E892
3905	MANSUE'	TV	E893
3906	MANTA	CN	E894
3907	MANTELLO	SO	E896
3908	MANTOVA	MN	E897
3909	MANZANO	UD	E899
3910	MANZIANA	RM	E900
3911	MAPELLO	BG	E901
3912	MARA	SS	E902
3913	MARACALAGONIS	CA	E903
3914	MARANELLO	MO	E904
3915	MARANO SUL PANARO	MO	E905
3916	MARANO DI NAPOLI	NA	E906
3917	MARANO TICINO	NO	E907
3918	MARANO EQUO	RM	E908
3919	MARANO LAGUNARE	UD	E910
3920	MARANO DI VALPOLICELLA	VR	E911
3921	MARANO VICENTINO	VI	E912
3922	MARANO MARCHESATO	CS	E914
3923	MARANO PRINCIPATO	CS	E915
3924	MARANZANA	AT	E917
3925	MARATEA	PZ	E919
3926	MARCALLO CON CASONE	MI	E921
3927	MARCARIA	MN	E922
3928	MARCEDUSA	CZ	E923
3929	MARCELLINA	RM	E924
3930	MARCELLINARA	CZ	E925
3931	MARCETELLI	RI	E927
3932	MARCHENO	BS	E928
3933	MARCHIROLO	VA	E929
3934	MARCIANA	LI	E930
3935	MARCIANA MARINA	LI	E931
3936	MARCIANISE	CE	E932
3937	MARCIANO DELLA CHIANA	AR	E933
3938	MARCIGNAGO	PV	E934
3939	MARCON	VE	E936
3940	MAREBBE * ENNEBERG	BZ	E938
3941	MARENE	CN	E939
3942	MARENO DI PIAVE	TV	E940
3943	MARENTINO	TO	E941
3945	MARETTO	AT	E944
3946	MARGARITA	CN	E945
3947	MARGHERITA DI SAVOIA	BT	E946
3948	MARGNO	LC	E947
3949	MARIANA MANTOVANA	MN	E949
3950	MARIANO COMENSE	CO	E951
3951	MARIANO DEL FRIULI	GO	E952
3952	MARIANOPOLI	CL	E953
3953	MARIGLIANELLA	NA	E954
3954	MARIGLIANO	NA	E955
3955	MARINA DI GIOIOSA IONICA	RC	E956
3956	MARINEO	PA	E957
3957	MARINO	RM	E958
3958	MARLENGO * MARLING	BZ	E959
3959	MARLIANA	PT	E960
3960	MARMENTINO	BS	E961
3961	MARMIROLO	MN	E962
3962	MARMORA	CN	E963
3963	MARNATE	VA	E965
3964	MARONE	BS	E967
3965	MAROPATI	RC	E968
3966	MAROSTICA	VI	E970
3967	MARRADI	FI	E971
3968	MARRUBIU	OR	E972
3969	MARSAGLIA	CN	E973
3970	MARSALA	TP	E974
3971	MARSCIANO	PG	E975
3972	MARSICO NUOVO	PZ	E976
3973	MARSICOVETERE	PZ	E977
3974	MARTA	VT	E978
3975	MARTANO	LE	E979
3976	MARTELLAGO	VE	E980
3977	MARTELLO * MARTELL	BZ	E981
3978	MARTIGNACCO	UD	E982
3979	MARTIGNANA DI PO	CR	E983
3980	MARTIGNANO	LE	E984
3981	MARTINA FRANCA	TA	E986
3982	MARTINENGO	BG	E987
3983	MARTINIANA PO	CN	E988
3984	MARTINSICURO	TE	E989
3985	MARTIRANO	CZ	E990
3986	MARTIRANO LOMBARDO	CZ	E991
3987	MARTIS	SS	E992
3988	MARTONE	RC	E993
3989	MARUDO	LO	E994
3990	MARUGGIO	TA	E995
3991	MARZANO DI NOLA	AV	E997
3992	MARZANO APPIO	CE	E998
3993	MARZANO	PV	E999
3994	MARZI	CS	F001
3995	MARZIO	VA	F002
3996	MASATE	MI	F003
3997	MASCALI	CT	F004
3998	MASCALUCIA	CT	F005
3999	MASCHITO	PZ	F006
4000	MASCIAGO PRIMO	VA	F007
4001	MASER	TV	F009
4002	MASERA	VB	F010
4003	MASERA' DI PADOVA	PD	F011
4004	MASERADA SUL PIAVE	TV	F012
4005	MASI	PD	F013
4006	MASIO	AL	F015
4007	MASI TORELLO	FE	F016
4008	MASLIANICO	CO	F017
4009	MASON VICENTINO	VI	F019
4010	MASONE	GE	F020
4011	MASSA FERMANA	FM	F021
4012	MASSA D'ALBE	AQ	F022
4013	MASSA	MS	F023
4014	MASSA MARTANA	PG	F024
4015	MASSA E COZZILE	PT	F025
4016	MASSA FISCAGLIA	FE	F026
4017	MASSAFRA	TA	F027
4018	MASSALENGO	LO	F028
4019	MASSA LOMBARDA	RA	F029
4020	MASSA LUBRENSE	NA	F030
4021	MASSA MARITTIMA	GR	F032
4022	MASSANZAGO	PD	F033
4023	MASSAROSA	LU	F035
4024	MASSAZZA	BI	F037
4025	MASSELLO	TO	F041
4026	MASSERANO	BI	F042
4027	SAN MARCO EVANGELISTA	CE	F043
4028	MASSIGNANO	AP	F044
4029	MASSIMENO	TN	F045
4030	MASSIMINO	SV	F046
4031	MASSINO VISCONTI	NO	F047
4032	MASSIOLA	VB	F048
4033	MASULLAS	OR	F050
4034	MATELICA	MC	F051
4035	MATERA	MT	F052
4036	MATHI	TO	F053
4037	MATINO	LE	F054
4038	MATRICE	CB	F055
4040	MATTIE	TO	F058
4041	MATTINATA	FG	F059
4043	MAZARA DEL VALLO	TP	F061
4044	MAZZANO	BS	F063
4045	MAZZANO ROMANO	RM	F064
4046	MAZZARINO	CL	F065
4047	MAZZARRA' SANT'ANDREA	ME	F066
4048	MAZZE'	TO	F067
4049	MAZZIN	TN	F068
4050	MAZZO DI VALTELLINA	SO	F070
4051	MEANA SARDO	NU	F073
4052	MEANA DI SUSA	TO	F074
4053	MEDA	MB	F078
4054	MEDE	PV	F080
4055	MEDEA	GO	F081
4056	MEDESANO	PR	F082
4057	MEDICINA	BO	F083
4058	MEDIGLIA	MI	F084
4059	MEDOLAGO	BG	F085
4060	MEDOLE	MN	F086
4061	MEDOLLA	MO	F087
4062	MEDUNA DI LIVENZA	TV	F088
4063	MEDUNO	PN	F089
4064	MEGLIADINO SAN FIDENZIO	PD	F091
4065	MEGLIADINO SAN VITALE	PD	F092
4066	MEINA	NO	F093
4067	MEL	BL	F094
4068	MELARA	RO	F095
4069	MELAZZO	AL	F096
4070	MELDOLA	FC	F097
4071	MELE	GE	F098
4072	MELEGNANO	MI	F100
4073	MELENDUGNO	LE	F101
4074	MELETI	LO	F102
4075	MELFI	PZ	F104
4076	MELICUCCA'	RC	F105
4077	MELICUCCO	RC	F106
4078	MELILLI	SR	F107
4079	MELISSA	KR	F108
4080	MELISSANO	LE	F109
4081	MELITO IRPINO	AV	F110
4082	MELITO DI NAPOLI	NA	F111
4083	MELITO DI PORTO SALVO	RC	F112
4084	MELIZZANO	BN	F113
4085	MELLE	CN	F114
4086	MELLO	SO	F115
4087	SILEA	TV	F116
4088	MELPIGNANO	LE	F117
4089	MELTINA * MOELTEN	BZ	F118
4090	MELZO	MI	F119
4091	MENAGGIO	CO	F120
4092	MENAROLA	SO	F121
4093	MENCONICO	PV	F122
4094	MENDATICA	IM	F123
4095	MENDICINO	CS	F125
4096	MENFI	AG	F126
4097	MENTANA	RM	F127
4098	MEOLO	VE	F130
4099	MERANA	AL	F131
4100	MERANO * MERAN	BZ	F132
4101	MERATE	LC	F133
4102	MERCALLO	VA	F134
4103	MERCATELLO SUL METAURO	PU	F135
4104	MERCATINO CONCA	PU	F136
4105	NOVAFELTRIA	RN	F137
4106	MERCATO SAN SEVERINO	SA	F138
4107	MERCATO SARACENO	FC	F139
4108	MERCENASCO	TO	F140
4109	MERCOGLIANO	AV	F141
4110	MERETO DI TOMBA	UD	F144
4111	MERGO	AN	F145
4112	MERGOZZO	VB	F146
4113	MERI'	ME	F147
4114	MERLARA	PD	F148
4115	MERLINO	LO	F149
4116	MERNA	GO	F150
4117	MERONE	CO	F151
4118	MESAGNE	BR	F152
4119	MESE	SO	F153
4120	MESENZANA	VA	F154
4121	MESERO	MI	F155
4122	MESOLA	FE	F156
4123	MESORACA	KR	F157
4124	MESSINA	ME	F158
4125	MESTRINO	PD	F161
4126	META	NA	F162
4127	MEUGLIANO	TO	F164
4128	MEZZAGO	MB	F165
4129	MEZZANA MORTIGLIENGO	BI	F167
4130	MEZZANA	TN	F168
4131	MEZZANA BIGLI	PV	F170
4132	MEZZANA RABATTONE	PV	F171
4133	MEZZANE DI SOTTO	VR	F172
4134	MEZZANEGO	GE	F173
4135	MEZZANI	PR	F174
4136	MEZZANINO	PV	F175
4137	MEZZANO	TN	F176
4138	MEZZEGRA	CO	F181
4139	MEZZENILE	TO	F182
4140	MEZZOCORONA	TN	F183
4141	MEZZOJUSO	PA	F184
4142	MEZZOLDO	BG	F186
4143	MEZZOLOMBARDO	TN	F187
4144	MEZZOMERICO	NO	F188
4145	MIAGLIANO	BI	F189
4146	MIANE	TV	F190
4147	MIASINO	NO	F191
4148	MIAZZINA	VB	F192
4149	MICIGLIANO	RI	F193
4150	MIGGIANO	LE	F194
4151	MIGLIANICO	CH	F196
4152	MIGLIARINO	FE	F198
4153	MIGLIARO	FE	F199
4154	MIGLIERINA	CZ	F200
4155	MIGLIONICO	MT	F201
4156	MIGNANEGO	GE	F202
4157	MIGNANO MONTE LUNGO	CE	F203
4158	MILANO	MI	F205
4159	MILAZZO	ME	F206
4160	MILETO	VV	F207
4161	MILIS	OR	F208
4162	MILITELLO IN VAL DI CATANIA	CT	F209
4163	MILITELLO ROSMARINO	ME	F210
4164	MILLESIMO	SV	F213
4165	MILO	CT	F214
4166	MILZANO	BS	F216
4167	MINEO	CT	F217
4168	MINERBE	VR	F218
4169	MINERBIO	BO	F219
4170	MINERVINO MURGE	BT	F220
4171	MINERVINO DI LECCE	LE	F221
4172	MINORI	SA	F223
4173	MINTURNO	LT	F224
4174	MINUCCIANO	LU	F225
4175	MIOGLIA	SV	F226
4176	MIRA	VE	F229
4177	MIRABELLA ECLANO	AV	F230
4178	MIRABELLA IMBACCARI	CT	F231
4179	MIRABELLO MONFERRATO	AL	F232
4180	MIRABELLO SANNITICO	CB	F233
4181	MIRABELLO	FE	F235
4182	MIRADOLO TERME	PV	F238
4183	MIRANDA	IS	F239
4184	MIRANDOLA	MO	F240
4185	MIRANO	VE	F241
4186	MIRTO	ME	F242
4187	MISANO DI GERA D'ADDA	BG	F243
4188	MISANO ADRIATICO	RN	F244
4189	MISILMERI	PA	F246
4190	MISINTO	MB	F247
4191	MISSAGLIA	LC	F248
4192	MISSANELLO	PZ	F249
4193	MISTERBIANCO	CT	F250
4194	MISTRETTA	ME	F251
4195	MOASCA	AT	F254
4196	MOCONESI	GE	F256
4197	MODENA	MO	F257
4198	MODICA	RG	F258
4199	MODIGLIANA	FC	F259
4200	TAVAZZANO CON VILLAVESCO	LO	F260
4201	MODOLO	NU	F261
4202	MODUGNO	BA	F262
4203	MOENA	TN	F263
4204	MOGGIO	LC	F265
4205	MOGGIO UDINESE	UD	F266
4206	MOGLIA	MN	F267
4207	MOGLIANO	MC	F268
4208	MOGLIANO VENETO	TV	F269
4209	MOGORELLA	OR	F270
4210	RUINAS	OR	F271
4211	MOGORO	OR	F272
4212	MOIANO	BN	F274
4213	MOIMACCO	UD	F275
4214	MOIO DE' CALVI	BG	F276
4215	MOIO ALCANTARA	ME	F277
4216	MOIO DELLA CIVITELLA	SA	F278
4217	MOIOLA	CN	F279
4218	MOLA DI BARI	BA	F280
4219	MOLARE	AL	F281
4220	MOLAZZANA	LU	F283
4221	MOLFETTA	BA	F284
4222	MOLINARA	BN	F287
4223	MOLINELLA	BO	F288
4224	MOLINI DI TRIORA	IM	F290
4225	MOLINO DEI TORTI	AL	F293
4226	MOLISE	CB	F294
4227	MOLITERNO	PZ	F295
4228	MOLLIA	VC	F297
4229	PORTO EMPEDOCLE	AG	F299
4230	MOLOCHIO	RC	F301
4231	MOLTENO	LC	F304
4232	MOLTRASIO	CO	F305
4233	MOLVENA	VI	F306
4234	MOLVENO	TN	F307
4235	MOMBALDONE	AT	F308
4236	MOMBARCARO	CN	F309
4237	MOMBAROCCIO	PU	F310
4238	MOMBARUZZO	AT	F311
4239	MOMBASIGLIO	CN	F312
4240	MOMBELLO MONFERRATO	AL	F313
4241	MOMBELLO DI TORINO	TO	F315
4242	MOMBERCELLI	AT	F316
4243	MOMO	NO	F317
4244	MOMPANTERO	TO	F318
4245	MOMPEO	RI	F319
4246	MOMPERONE	AL	F320
4247	MONACILIONI	CB	F322
4248	MONALE	AT	F323
4249	MONASTERACE	RC	F324
4250	MONASTERO BORMIDA	AT	F325
4251	MONASTERO DI VASCO	CN	F326
4252	MONASTERO DI LANZO	TO	F327
4253	MONASTEROLO DEL CASTELLO	BG	F328
4254	MONASTEROLO CASOTTO	CN	F329
4255	MONASTEROLO DI SAVIGLIANO	CN	F330
4256	MONASTIER DI TREVISO	TV	F332
4257	MONASTIR	CA	F333
4258	MONCALIERI	TO	F335
4259	MONCALVO	AT	F336
4260	MONCESTINO	AL	F337
4261	MONCHIERO	CN	F338
4262	MONCHIO DELLE CORTI	PR	F340
4263	MONCLASSICO	TN	F341
4264	MONCRIVELLO	VC	F342
4265	MONCUCCO TORINESE	AT	F343
4266	MONDAINO	RN	F346
4267	MONDAVIO	PU	F347
4268	MONDOLFO	PU	F348
4269	MONDOVI'	CN	F351
4270	MONDRAGONE	CE	F352
4271	MONEGLIA	GE	F354
4272	MONESIGLIO	CN	F355
4273	MONFALCONE	GO	F356
4274	SERRAMAZZONI	MO	F357
4275	MONFORTE D'ALBA	CN	F358
4276	MONFORTE SAN GIORGIO	ME	F359
4277	MONFUMO	TV	F360
4278	MONGARDINO	AT	F361
4279	MONGHIDORO	BO	F363
4280	MONGIANA	VV	F364
4281	MONGIARDINO LIGURE	AL	F365
4282	MONTJOVET	AO	F367
4283	MONGIUFFI MELIA	ME	F368
4284	MONGRANDO	BI	F369
4285	MONGRASSANO	CS	F370
4286	MONGUELFO-TESIDO * WELSBERG-TAISTEN	BZ	F371
4287	MONGUZZO	CO	F372
4288	MONIGA DEL GARDA	BS	F373
4289	MONLEALE	AL	F374
4290	MONNO	BS	F375
4291	MONOPOLI	BA	F376
4292	MONREALE	PA	F377
4293	MONRUPINO	TS	F378
4294	MONSAMPIETRO MORICO	FM	F379
4295	MONSAMPOLO DEL TRONTO	AP	F380
4296	MONSANO	AN	F381
4297	MONSELICE	PD	F382
4298	MONSERRATO	CA	F383
4299	MONSUMMANO TERME	PT	F384
4300	MONTA'	CN	F385
4301	MONTABONE	AT	F386
4302	MONTACUTO	AL	F387
4303	MONTAFIA	AT	F390
4304	MONTAGANO	CB	F391
4305	MONTAGNA * MONTAN	BZ	F392
4306	MONTAGNA IN VALTELLINA	SO	F393
4307	MONTAGNANA	PD	F394
4308	MONTAGNAREALE	ME	F395
4309	MONTAGNE	TN	F396
4310	MONTAGUTO	AV	F397
4311	MONTAIONE	FI	F398
4312	MONTALBANO JONICO	MT	F399
4313	MONTALBANO ELICONA	ME	F400
4314	OSTRA	AN	F401
4315	MONTALCINO	SI	F402
4316	MONTALDEO	AL	F403
4317	MONTALDO BORMIDA	AL	F404
4318	MONTALDO DI MONDOVI'	CN	F405
4319	MONTALTO LIGURE	IM	F406
4320	MONTALDO TORINESE	TO	F407
4321	MONTALDO ROERO	CN	F408
4322	MONTALDO SCARAMPI	AT	F409
4323	MONTALE	PT	F410
4324	MONTALENGHE	TO	F411
4325	MONTALLEGRO	AG	F414
4326	MONTALTO DELLE MARCHE	AP	F415
4327	MONTALTO UFFUGO	CS	F416
4328	MONTALTO PAVESE	PV	F417
4329	MONTALTO DI CASTRO	VT	F419
4330	MONTALTO DORA	TO	F420
4331	MONTANARO	TO	F422
4332	MONTANASO LOMBARDO	LO	F423
4333	MONTANERA	CN	F424
4334	MONTANO ANTILIA	SA	F426
4335	MONTANO LUCINO	CO	F427
4336	MONTAPPONE	FM	F428
4337	MONTAQUILA	IS	F429
4338	MONTASOLA	RI	F430
4339	MONTAURO	CZ	F432
4340	MONTAZZOLI	CH	F433
4341	MONTE CREMASCO	CR	F434
4342	MONTE ARGENTARIO	GR	F437
4343	MONTEBELLO DELLA BATTAGLIA	PV	F440
4344	MONTEBELLO DI BERTONA	PE	F441
4345	MONTEBELLO VICENTINO	VI	F442
4346	MONTEBELLUNA	TV	F443
4347	MONTEBRUNO	GE	F445
4348	MONTEBUONO	RI	F446
4349	MONTECALVO IRPINO	AV	F448
4350	MONTECALVO VERSIGGIA	PV	F449
4351	MONTECALVO IN FOGLIA	PU	F450
4352	MONTECARLO	LU	F452
4353	MONTECAROTTO	AN	F453
4354	MONTECASSIANO	MC	F454
4355	MONTECASTELLO	AL	F455
4356	MONTE CASTELLO DI VIBIO	PG	F456
4357	MONTECASTRILLI	TR	F457
4358	MONTECATINI VAL DI CECINA	PI	F458
4359	MONTE CAVALLO	MC	F460
4360	MONTECCHIA DI CROSARA	VR	F461
4361	MONTECCHIO	TR	F462
4362	MONTECCHIO EMILIA	RE	F463
4363	MONTECCHIO MAGGIORE	VI	F464
4364	MONTECCHIO PRECALCINO	VI	F465
4365	MONTE CERIGNONE	PU	F467
4366	MONTECHIARO D'ASTI	AT	F468
4367	MONTECHIARO D'ACQUI	AL	F469
4368	MONTICHIARI	BS	F471
4369	MONTECHIARUGOLO	PR	F473
4370	MONTECICCARDO	PU	F474
4371	MONTECILFONE	CB	F475
4372	MONTE COLOMBO	RN	F476
4373	MONTECOMPATRI	RM	F477
4374	MONTECOPIOLO	PU	F478
4375	MONTECORICE	SA	F479
4376	MONTECORVINO PUGLIANO	SA	F480
4377	MONTECORVINO ROVELLA	SA	F481
4378	MONTECOSARO	MC	F482
4379	MONTECRESTESE	VB	F483
4380	MONTECRETO	MO	F484
4382	MONTE DI MALO	VI	F486
4383	MONTEDINOVE	AP	F487
4384	MONTE DI PROCIDA	NA	F488
4385	MONTEDORO	CL	F489
4386	MONTEFALCIONE	AV	F491
4387	MONTEFALCO	PG	F492
4388	MONTEFALCONE APPENNINO	FM	F493
4389	MONTEFALCONE DI VAL FORTORE	BN	F494
4390	MONTEFALCONE NEL SANNIO	CB	F495
4391	MONTEFANO	MC	F496
4392	MONTEFELCINO	PU	F497
4393	MONTEFERRANTE	CH	F498
4394	MONTEFIASCONE	VT	F499
4395	MONTEFINO	TE	F500
4396	MONTEFIORE DELL'ASO	AP	F501
4397	MONTEFIORE CONCA	RN	F502
4398	MONTEFIORINO	MO	F503
4399	MONTEFLAVIO	RM	F504
4400	MONTEFORTE IRPINO	AV	F506
4401	MONTEFORTE CILENTO	SA	F507
4402	MONTEFORTE D'ALPONE	VR	F508
4403	MONTEFORTINO	FM	F509
4404	MONTEFRANCO	TR	F510
4405	MONTEFREDANE	AV	F511
4406	MONTEFUSCO	AV	F512
4407	MONTEGABBIONE	TR	F513
4408	MONTEGALDA	VI	F514
4409	MONTEGALDELLA	VI	F515
4410	MONTEGALLO	AP	F516
4411	MONTE GIBERTO	FM	F517
4412	MONTEGIOCO	AL	F518
4413	MONTEGIORDANO	CS	F519
4414	MONTEGIORGIO	FM	F520
4415	MONTEGRANARO	FM	F522
4416	MONTEGRIDOLFO	RN	F523
4417	MONTE GRIMANO TERME	PU	F524
4418	MONTEGRINO VALTRAVAGLIA	VA	F526
4419	MONTEGROSSO D'ASTI	AT	F527
4420	MONTEGROSSO PIAN LATTE	IM	F528
4421	MONTEGROTTO TERME	PD	F529
4422	MONTEIASI	TA	F531
4423	MONTE ISOLA	BS	F532
4424	MONTELABBATE	PU	F533
4425	MONTELANICO	RM	F534
4426	MONTELAPIANO	CH	F535
4427	MONTELEONE DI FERMO	FM	F536
4428	VIBO VALENTIA	VV	F537
4429	MONTELEONE DI PUGLIA	FG	F538
4430	MONTELEONE DI SPOLETO	PG	F540
4431	MONTELEONE SABINO	RI	F541
4432	MONTELEONE ROCCA DORIA	SS	F542
4433	MONTELEONE D'ORVIETO	TR	F543
4434	MONTELEPRE	PA	F544
4435	MONTELIBRETTI	RM	F545
4436	MONTELLA	AV	F546
4437	MONTELLO	BG	F547
4438	MONTELONGO	CB	F548
4439	MONTELPARO	FM	F549
4440	MONTELUPO ALBESE	CN	F550
4441	MONTELUPO FIORENTINO	FI	F551
4442	MONTELUPONE	MC	F552
4443	MONTEMAGGIORE BELSITO	PA	F553
4444	MONTEMAGGIORE AL METAURO	PU	F555
4445	MONTEMAGNO	AT	F556
4446	SANT'ARCANGELO TRIMONTE	BN	F557
4447	MONTEMALE DI CUNEO	CN	F558
4448	MONTEMARANO	AV	F559
4449	MONTEMARCIANO	AN	F560
4450	MONTE MARENZO	LC	F561
4451	MONTEMARZINO	AL	F562
4452	MONTEMESOLA	TA	F563
4453	MONTEMEZZO	CO	F564
4454	MONTEMIGNAIO	AR	F565
4455	MONTEMILETTO	AV	F566
4456	POLLENZA	MC	F567
4457	MONTEMILONE	PZ	F568
4458	MONTEMITRO	CB	F569
4459	MONTEMONACO	AP	F570
4460	MONTEMURLO	PO	F572
4461	MONTEMURRO	PZ	F573
4462	MONTENARS	UD	F574
4463	MONTENERO DI BISACCIA	CB	F576
4464	MONTENERO D'IDRIA	GO	F577
4465	MONTENERODOMO	CH	F578
4466	MONTENERO SABINO	RI	F579
4467	MONTENERO VAL COCCHIARA	IS	F580
4468	OSTRA VETERE	AN	F581
4469	MONTEODORISIO	CH	F582
4470	ROSETO DEGLI ABRUZZI	TE	F585
4471	MONTEPAONE	CZ	F586
4472	MONTEPARANO	TA	F587
4473	MONTE PORZIO	PU	F589
4474	MONTE PORZIO CATONE	RM	F590
4475	MONTEPRANDONE	AP	F591
4476	MONTEPULCIANO	SI	F592
4477	MONTERADO	AN	F593
4478	MONTERCHI	AR	F594
4479	MONTEREALE	AQ	F595
4480	MONTEREALE VALCELLINA	PN	F596
4481	MONTERENZIO	BO	F597
4482	MONTERIGGIONI	SI	F598
4483	MONTE RINALDO	FM	F599
4484	MONTE ROBERTO	AN	F600
4485	MONTERODUNI	IS	F601
4486	MONTE ROMANO	VT	F603
4487	MONTERONI DI LECCE	LE	F604
4488	MONTERONI D'ARBIA	SI	F605
4489	MONTEROSI	VT	F606
4490	MONTEROSSO CALABRO	VV	F607
4491	MONTEROSSO GRANA	CN	F608
4492	MONTEROSSO AL MARE	SP	F609
4493	MONTEROSSO ALMO	RG	F610
4494	MONTEROTONDO	RM	F611
4495	MONTEROTONDO MARITTIMO	GR	F612
4496	MONTERUBBIANO	FM	F614
4497	MONTE SAN BIAGIO	LT	F616
4498	MONTE SAN GIACOMO	SA	F618
4499	MONTE SAN GIOVANNI IN SABINA	RI	F619
4500	MONTE SAN GIOVANNI CAMPANO	FR	F620
4501	MONTE SAN GIUSTO	MC	F621
4502	MONTE SAN MARTINO	MC	F622
4503	MONTESANO SALENTINO	LE	F623
4504	MONTESANO SULLA MARCELLANA	SA	F625
4505	MONTE SAN PIETRANGELI	FM	F626
4506	MONTE SAN PIETRO	BO	F627
4507	MONTE SAN SAVINO	AR	F628
4508	MONTE SANTA MARIA TIBERINA	PG	F629
4509	MONTE SANT'ANGELO	FG	F631
4510	POTENZA PICENA	MC	F632
4511	MONTE SAN VITO	AN	F634
4512	MONTESARCHIO	BN	F636
4513	MONTESCAGLIOSO	MT	F637
4514	MONTESCANO	PV	F638
4515	MONTESCHENO	VB	F639
4516	MONTESCUDAIO	PI	F640
4517	MONTESCUDO	RN	F641
4518	MONTESE	MO	F642
4519	MONTESEGALE	PV	F644
4520	MONTESILVANO	PE	F646
4521	MONTESPERTOLI	FI	F648
4522	MONTESPINO	GO	F649
4523	MONTEU DA PO	TO	F651
4524	MONTE URANO	FM	F653
4525	MONTEU ROERO	CN	F654
4526	MONTEVAGO	AG	F655
4527	MONTEVARCHI	AR	F656
4528	MONTEVECCHIA	LC	F657
4529	MONTEVEGLIO	BO	F659
4530	MONTEVERDE	AV	F660
4531	MONTEVERDI MARITTIMO	PI	F661
4532	MONTEVIALE	VI	F662
4533	MONTE VIDON COMBATTE	FM	F664
4534	MONTE VIDON CORRADO	FM	F665
4535	MONTEZEMOLO	CN	F666
4536	MONTI	OT	F667
4537	MONTIANO	FC	F668
4538	MONTICELLO D'ALBA	CN	F669
4539	MONTICELLI PAVESE	PV	F670
4540	MONTICELLI D'ONGINA	PC	F671
4541	MONTICELLI BRUSATI	BS	F672
4542	MONTICELLO BRIANZA	LC	F674
4543	MONTICELLO CONTE OTTO	VI	F675
4544	MONTICIANO	SI	F676
4545	MONTIERI	GR	F677
4546	MONTIGNOSO	MS	F679
4547	MONTIRONE	BS	F680
4548	MONTODINE	CR	F681
4549	MONTOGGIO	GE	F682
4551	MONTONE	PG	F685
4552	MONTOPOLI IN VAL D'ARNO	PI	F686
4553	MONTOPOLI DI SABINA	RI	F687
4554	MONTORFANO	CO	F688
4555	MONTORIO NEI FRENTANI	CB	F689
4556	MONTORIO AL VOMANO	TE	F690
4557	MONTORIO ROMANO	RM	F692
4558	MONTORO INFERIORE	AV	F693
4559	MONTORO SUPERIORE	AV	F694
4560	MONTORSO VICENTINO	VI	F696
4561	MONTOTTONE	FM	F697
4562	MONTRESTA	NU	F698
4563	MONTU' BECCARIA	PV	F701
4564	MONVALLE	VA	F703
4565	MONZA	MB	F704
4566	MONZAMBANO	MN	F705
4567	MONZUNO	BO	F706
4568	MORANO SUL PO	AL	F707
4569	MORANO CALABRO	CS	F708
4570	MORANSENGO	AT	F709
4571	MORARO	GO	F710
4572	MORAZZONE	VA	F711
4573	MORBEGNO	SO	F712
4574	MORBELLO	AL	F713
4575	MORCIANO DI ROMAGNA	RN	F715
4576	MORCIANO DI LEUCA	LE	F716
4577	MORCONE	BN	F717
4578	MORDANO	BO	F718
4579	MORENGO	BG	F720
4580	MORES	SS	F721
4581	MORESCO	FM	F722
4582	MORETTA	CN	F723
4583	MORFASSO	PC	F724
4584	MORGANO	TV	F725
4585	MORGEX	AO	F726
4586	MORGONGIORI	OR	F727
4587	MORI	TN	F728
4588	MORIAGO DELLA BATTAGLIA	TV	F729
4589	MORICONE	RM	F730
4590	MORIGERATI	SA	F731
4591	MORINO	AQ	F732
4592	MORIONDO TORINESE	TO	F733
4593	MORLUPO	RM	F734
4594	MORMANNO	CS	F735
4595	MORNAGO	VA	F736
4596	MORNESE	AL	F737
4597	MORNICO AL SERIO	BG	F738
4598	MORNICO LOSANA	PV	F739
4599	MOROLO	FR	F740
4600	MOROZZO	CN	F743
4601	MORRA DE SANCTIS	AV	F744
4602	MORRO D'ALBA	AN	F745
4603	MORRO REATINO	RI	F746
4604	MORRO D'ORO	TE	F747
4605	MORRONE DEL SANNIO	CB	F748
4606	MORROVALLE	MC	F749
4607	MORSANO AL TAGLIAMENTO	PN	F750
4608	MORSASCO	AL	F751
4609	MORTARA	PV	F754
4610	MORTEGLIANO	UD	F756
4611	MORTERONE	LC	F758
4612	MORUZZO	UD	F760
4613	MOSCAZZANO	CR	F761
4614	MOSCHIANO	AV	F762
4616	MOSCIANO SANT'ANGELO	TE	F764
4617	MOSCUFO	PE	F765
4618	MOSO IN PASSIRIA * MOOS IN PASSEIER	BZ	F766
4619	MOSSA	GO	F767
4620	MOSSANO	VI	F768
4621	MOTTA DI LIVENZA	TV	F770
4622	MOTTA BALUFFI	CR	F771
4623	MOTTA CAMASTRA	ME	F772
4624	MOTTA D'AFFERMO	ME	F773
4625	MOTTA DE' CONTI	VC	F774
4626	MOTTAFOLLONE	CS	F775
4627	MOTTALCIATA	BI	F776
4628	MOTTA MONTECORVINO	FG	F777
4629	MOTTA SAN GIOVANNI	RC	F779
4630	MOTTA SANTA LUCIA	CZ	F780
4631	MOTTA SANT'ANASTASIA	CT	F781
4632	MOTTA VISCONTI	MI	F783
4633	MOTTOLA	TA	F784
4634	MOZZAGROGNA	CH	F785
4635	MOZZANICA	BG	F786
4636	MOZZATE	CO	F788
4637	MOZZECANE	VR	F789
4638	MOZZO	BG	F791
4639	MUCCIA	MC	F793
4640	MUGGIA	TS	F795
4641	MUGGIO'	MB	F797
4642	MUGNANO DEL CARDINALE	AV	F798
4643	MUGNANO DI NAPOLI	NA	F799
4644	MULAZZANO	LO	F801
4645	MULAZZO	MS	F802
4646	VILLA POMA	MN	F804
4647	MURA	BS	F806
4648	MURAVERA	CA	F808
4649	MURAZZANO	CN	F809
4650	SALCEDO	VI	F810
4651	MURELLO	CN	F811
4652	MURIALDO	SV	F813
4653	MURISENGO	AL	F814
4654	MURLO	SI	F815
4655	MURO LECCESE	LE	F816
4656	MURO LUCANO	PZ	F817
4657	MUROS	SS	F818
4658	MUSCOLINE	BS	F820
4659	MUSEI	CI	F822
4660	MUSILE DI PIAVE	VE	F826
4661	MUSSO	CO	F828
4662	MUSSOLENTE	VI	F829
4663	MUSSOMELI	CL	F830
4664	PINETO	TE	F831
4665	MUZZANA DEL TURGNANO	UD	F832
4666	MUZZANO	BI	F833
4667	NAGO-TORBOLE	TN	F835
4668	NALLES * NALS	BZ	F836
4669	NANNO	TN	F837
4670	NANTO	VI	F838
4671	NAPOLI	NA	F839
4672	NARBOLIA	OR	F840
4673	NARCAO	CI	F841
4674	NARDO'	LE	F842
4675	NARDODIPACE	VV	F843
4676	NARNI	TR	F844
4677	NARO	AG	F845
4678	NARZOLE	CN	F846
4679	NASINO	SV	F847
4680	NASO	ME	F848
4681	NATURNO * NATURNS	BZ	F849
4682	NAVE	BS	F851
4683	NAVELLI	AQ	F852
4684	NAVE SAN ROCCO	TN	F853
4685	NAZ-SCIAVES * NATZ-SCHABS	BZ	F856
4686	NAZZANO	RM	F857
4687	NE	GE	F858
4688	NEBBIUNO	NO	F859
4689	NEGRAR	VR	F861
4690	NEIRONE	GE	F862
4691	NEIVE	CN	F863
4692	NEMBRO	BG	F864
4693	NEMI	RM	F865
4694	NEMOLI	PZ	F866
4695	NEONELI	OR	F867
4696	NEPI	VT	F868
4698	NERETO	TE	F870
4699	NEROLA	RM	F871
4700	NERVESA DELLA BATTAGLIA	TV	F872
4701	NERVIANO	MI	F874
4702	NESPOLO	RI	F876
4703	NESSO	CO	F877
4704	NETRO	BI	F878
4705	NETTUNO	RM	F880
4706	NEVIANO	LE	F881
4707	NEVIANO DEGLI ARDUINI	PR	F882
4708	NEVIGLIE	CN	F883
4709	NIARDO	BS	F884
4710	NIBBIANO	PC	F885
4711	NIBBIOLA	NO	F886
4712	NIBIONNO	LC	F887
4713	NICHELINO	TO	F889
4714	NICOLOSI	CT	F890
4715	NICORVO	PV	F891
4716	NICOSIA	EN	F892
4717	NICOTERA	VV	F893
4718	NIELLA BELBO	CN	F894
4719	NIELLA TANARO	CN	F895
4720	NIMIS	UD	F898
4721	NISCEMI	CL	F899
4722	NISSORIA	EN	F900
4723	NIZZA DI SICILIA	ME	F901
4724	NIZZA MONFERRATO	AT	F902
4725	NOALE	VE	F904
4726	NOASCA	TO	F906
4727	NOCARA	CS	F907
4728	NOCCIANO	PE	F908
4729	NOCERA TERINESE	CZ	F910
4730	NOCERA UMBRA	PG	F911
4731	NOCERA INFERIORE	SA	F912
4732	NOCERA SUPERIORE	SA	F913
4733	NOCETO	PR	F914
4734	NOCI	BA	F915
4735	NOCIGLIA	LE	F916
4736	NOEPOLI	PZ	F917
4737	NOGARA	VR	F918
4738	NOGAREDO	TN	F920
4739	NOGAROLE ROCCA	VR	F921
4740	NOGAROLE VICENTINO	VI	F922
4741	NOICATTARO	BA	F923
4742	NOLA	NA	F924
4743	NOLE	TO	F925
4744	NOLI	SV	F926
4745	NOMAGLIO	TO	F927
4746	NOMI	TN	F929
4747	NONANTOLA	MO	F930
4748	NONE	TO	F931
4749	NONIO	VB	F932
4750	NORAGUGUME	NU	F933
4751	NORBELLO	OR	F934
4752	NORCIA	PG	F935
4753	NORMA	LT	F937
4754	NOSATE	MI	F939
4755	PONTE NOSSA	BG	F941
4756	NOTARESCO	TE	F942
4757	NOTO	SR	F943
4758	NOVA MILANESE	MB	F944
4759	NOVALEDO	TN	F947
4760	NOVALESA	TO	F948
4761	NOVA LEVANTE * WELSCHNOFEN	BZ	F949
4762	NOVA PONENTE * DEUTSCHNOFEN	BZ	F950
4763	NOVARA DI SICILIA	ME	F951
4764	NOVARA	NO	F952
4765	NOVATE MILANESE	MI	F955
4766	NOVATE MEZZOLA	SO	F956
4767	NOVE	VI	F957
4768	NOVEDRATE	CO	F958
4769	NOVELLARA	RE	F960
4770	NOVELLO	CN	F961
4771	NOVENTA PADOVANA	PD	F962
4772	NOVENTA DI PIAVE	VE	F963
4773	NOVENTA VICENTINA	VI	F964
4774	NOVI LIGURE	AL	F965
4775	NOVI DI MODENA	MO	F966
4776	NOVI VELIA	SA	F967
4777	NOVIGLIO	MI	F968
4778	NOVOLI	LE	F970
4779	NUCETTO	CN	F972
4780	NUGHEDU SANTA VITTORIA	OR	F974
4781	NUGHEDU SAN NICOLO'	SS	F975
4782	NULE	SS	F976
4783	NULVI	SS	F977
4784	NUMANA	AN	F978
4785	NUORO	NU	F979
4786	NURACHI	OR	F980
4787	NURAGUS	NU	F981
4788	NURALLAO	NU	F982
4789	NURAMINIS	CA	F983
4790	NURECI	OR	F985
4791	NURRI	NU	F986
4792	NUS	AO	F987
4793	NUSCO	AV	F988
4794	NUVOLENTO	BS	F989
4795	NUVOLERA	BS	F990
4796	NUXIS	CI	F991
4797	OCCHIEPPO INFERIORE	BI	F992
4798	OCCHIEPPO SUPERIORE	BI	F993
4799	OCCHIOBELLO	RO	F994
4800	OCCIMIANO	AL	F995
4801	OCRE	AQ	F996
4802	ODALENGO GRANDE	AL	F997
4803	ODALENGO PICCOLO	AL	F998
4804	ODERZO	TV	F999
4805	ODOLO	BS	G001
4806	OFENA	AQ	G002
4807	OFFAGNA	AN	G003
4808	OFFANENGO	CR	G004
4809	OFFIDA	AP	G005
4810	OFFLAGA	BS	G006
4811	OGGEBBIO	VB	G007
4812	OGGIONA CON SANTO STEFANO	VA	G008
4813	OGGIONO	LC	G009
4814	OGLIANICO	TO	G010
4815	OGLIASTRO CILENTO	SA	G011
4816	OYACE	AO	G012
4817	OLBIA	OT	G015
4818	OLCENENGO	VC	G016
4819	OLDENICO	VC	G018
4820	OLEGGIO	NO	G019
4821	OLEGGIO CASTELLO	NO	G020
4822	OLEVANO DI LOMELLINA	PV	G021
4823	OLEVANO ROMANO	RM	G022
4824	OLEVANO SUL TUSCIANO	SA	G023
4825	OLGIATE COMASCO	CO	G025
4826	OLGIATE MOLGORA	LC	G026
4827	OLGIATE OLONA	VA	G028
4828	OLGINATE	LC	G030
4829	OLIENA	NU	G031
4830	OLIVA GESSI	PV	G032
4831	OLIVADI	CZ	G034
4832	OLIVERI	ME	G036
4833	OLIVETO LUCANO	MT	G037
4834	OLIVETO CITRA	SA	G039
4835	OLIVETO LARIO	LC	G040
4836	OLIVETTA SAN MICHELE	IM	G041
4837	OLIVOLA	AL	G042
4838	OLLASTRA	OR	G043
4839	OLLOLAI	NU	G044
4840	OLLOMONT	AO	G045
4841	OLMEDO	SS	G046
4842	OLMENETA	CR	G047
4843	OLMO GENTILE	AT	G048
4844	OLMO AL BREMBO	BG	G049
4845	OLTRE IL COLLE	BG	G050
4846	OLTRESSENDA ALTA	BG	G054
4847	OLTRONA DI SAN MAMETTE	CO	G056
4848	OLZAI	NU	G058
4849	OME	BS	G061
4850	OMEGNA	VB	G062
4851	OMIGNANO	SA	G063
4852	ONANI	NU	G064
4853	ONANO	VT	G065
4854	ONCINO	CN	G066
4855	ONETA	BG	G068
4856	ONIFAI	NU	G070
4857	ONIFERI	NU	G071
4858	ONO SAN PIETRO	BS	G074
4859	ONORE	BG	G075
4860	ONZO	SV	G076
4861	OPACCHIASELLA	GO	G077
4862	OPERA	MI	G078
4863	OPI	AQ	G079
4864	OPPEANO	VR	G080
4865	OPPIDO LUCANO	PZ	G081
4866	OPPIDO MAMERTINA	RC	G082
4867	ORA * AUER	BZ	G083
4868	ORANI	NU	G084
4869	ORATINO	CB	G086
4870	ORBASSANO	TO	G087
4871	ORBETELLO	GR	G088
4872	ORCIANO DI PESARO	PU	G089
4873	ORCIANO PISANO	PI	G090
4874	ORERO	GE	G093
4875	ORGIANO	VI	G095
4876	PIEVE FISSIRAGA	LO	G096
4877	ORGOSOLO	NU	G097
4878	ORIA	BR	G098
4879	ORICOLA	AQ	G102
4880	ORIGGIO	VA	G103
4881	ORINO	VA	G105
4882	ORIO LITTA	LO	G107
4883	ORIO AL SERIO	BG	G108
4884	ORIO CANAVESE	TO	G109
4885	ORIOLO	CS	G110
4886	ORIOLO ROMANO	VT	G111
4887	ORISTANO	OR	G113
4888	ORMEA	CN	G114
4889	ORMELLE	TV	G115
4890	ORNAGO	MB	G116
4891	ORNAVASSO	VB	G117
4892	ORNICA	BG	G118
4893	OROSEI	NU	G119
4894	OROTELLI	NU	G120
4895	ORRIA	SA	G121
4896	ORROLI	NU	G122
4897	ORSAGO	TV	G123
4898	ORSARA BORMIDA	AL	G124
4899	ORSARA DI PUGLIA	FG	G125
4900	ORSENIGO	CO	G126
4902	ORSOGNA	CH	G128
4903	ORSOMARSO	CS	G129
4904	ORTA DI ATELLA	CE	G130
4905	ORTA NOVA	FG	G131
4906	ORTACESUS	CA	G133
4907	ORTA SAN GIULIO	NO	G134
4908	ORTE	VT	G135
4909	ORTELLE	LE	G136
4910	ORTEZZANO	FM	G137
4911	ORTIGNANO RAGGIOLO	AR	G139
4912	ORTISEI * SANKT ULRICH	BZ	G140
4913	ORTONA	CH	G141
4914	ORTONA DEI MARSI	AQ	G142
4915	ORTONOVO	SP	G143
4916	ORTOVERO	SV	G144
4917	ORTUCCHIO	AQ	G145
4918	ORTUERI	NU	G146
4919	ORUNE	NU	G147
4920	ORVIETO	TR	G148
4921	ORZINUOVI	BS	G149
4922	ORZIVECCHI	BS	G150
4923	OSASCO	TO	G151
4924	OSASIO	TO	G152
4925	OSCHIRI	OT	G153
4926	OSIDDA	NU	G154
4927	OSIGLIA	SV	G155
4928	OSILO	SS	G156
4929	OSIMO	AN	G157
4930	OSINI	OG	G158
4931	OSIO SOPRA	BG	G159
4932	OSIO SOTTO	BG	G160
4933	OSNAGO	LC	G161
4934	OSOPPO	UD	G163
4935	OSPEDALETTI	IM	G164
4936	OSPEDALETTO D'ALPINOLO	AV	G165
4937	OSPEDALETTO LODIGIANO	LO	G166
4938	OSPEDALETTO EUGANEO	PD	G167
4939	OSPEDALETTO	TN	G168
4940	OSPITALE DI CADORE	BL	G169
4941	OSPITALETTO	BS	G170
4942	OSSAGO LODIGIANO	LO	G171
4943	OSSANA	TN	G173
4945	OSSI	SS	G178
4946	OSSIMO	BS	G179
4947	OSSONA	MI	G181
4948	OSSUCCIO	CO	G182
4949	OSTANA	CN	G183
4950	OSTELLATO	FE	G184
4951	OSTIANO	CR	G185
4952	OSTIGLIA	MN	G186
4953	OSTUNI	BR	G187
4954	OTRANTO	LE	G188
4955	OTRICOLI	TR	G189
4956	OTTAVIANO	NA	G190
4957	OTTANA	NU	G191
4958	OTTATI	SA	G192
4959	OTTIGLIO	AL	G193
4960	OTTOBIANO	PV	G194
4961	OTTONE	PC	G195
4962	OULX	TO	G196
4963	OVADA	AL	G197
4964	OVARO	UD	G198
4965	OVIGLIO	AL	G199
4966	OVINDOLI	AQ	G200
4967	OVODDA	NU	G201
4968	OZEGNA	TO	G202
4969	OZIERI	SS	G203
4970	OZZANO MONFERRATO	AL	G204
4971	OZZANO DELL'EMILIA	BO	G205
4972	OZZERO	MI	G206
4973	PABILLONIS	VS	G207
4974	PACECO	TP	G208
4975	PACE DEL MELA	ME	G209
4976	PACENTRO	AQ	G210
4977	PACHINO	SR	G211
4978	PACIANO	PG	G212
4979	PADENGHE SUL GARDA	BS	G213
4980	PADERGNONE	TN	G214
4981	PADERNA	AL	G215
4982	PADERNO FRANCIACORTA	BS	G217
4983	PADERNO D'ADDA	LC	G218
4984	PADERNO DUGNANO	MI	G220
4985	PADERNO DEL GRAPPA	TV	G221
4986	PADERNO PONCHIELLI	CR	G222
4987	ROBBIATE	LC	G223
4988	PADOVA	PD	G224
4989	PADRIA	SS	G225
4990	PADULA	SA	G226
4991	PADULI	BN	G227
4992	PAESANA	CN	G228
4993	PAESE	TV	G229
4994	PAGANI	SA	G230
4995	PAGANICO SABINO	RI	G232
4996	PAGAZZANO	BG	G233
4997	PAGLIARA	ME	G234
4998	PAGLIETA	CH	G237
4999	PAGNACCO	UD	G238
5000	PAGNO	CN	G240
5001	PAGNONA	LC	G241
5002	PAGO DEL VALLO DI LAURO	AV	G242
5003	PAGO VEIANO	BN	G243
5004	PAISCO LOVENO	BS	G247
5005	PAITONE	BS	G248
5006	PALADINA	BG	G249
5007	PALAGANO	MO	G250
5008	PALAGIANELLO	TA	G251
5009	PALAGIANO	TA	G252
5010	PALAGONIA	CT	G253
5011	PALAIA	PI	G254
5012	PALANZANO	PR	G255
5013	PALATA	CB	G257
5014	PALAU	OT	G258
5015	PALAZZAGO	BG	G259
5016	PALAZZO PIGNANO	CR	G260
5017	PALAZZO SAN GERVASIO	PZ	G261
5018	PALAZZO CANAVESE	TO	G262
5019	PALAZZO ADRIANO	PA	G263
5020	PALAZZOLO SULL'OGLIO	BS	G264
5021	PALAZZOLO VERCELLESE	VC	G266
5022	PALAZZOLO ACREIDE	SR	G267
5023	PALAZZOLO DELLO STELLA	UD	G268
5024	PALAZZUOLO SUL SENIO	FI	G270
5025	PALENA	CH	G271
5026	PALERMITI	CZ	G272
5027	PALERMO	PA	G273
5028	PALESTRINA	RM	G274
5029	PALESTRO	PV	G275
5030	PALIANO	FR	G276
5031	PALIZZI	RC	G277
5032	PALLAGORIO	KR	G278
5033	PALLANZENO	VB	G280
5034	PALLARE	SV	G281
5035	PALMA DI MONTECHIARO	AG	G282
5036	PALMA CAMPANIA	NA	G283
5037	PALMANOVA	UD	G284
5038	PALMARIGGI	LE	G285
5039	PALMAS ARBOREA	OR	G286
5040	SAN GIOVANNI SUERGIU	CI	G287
5041	PALMI	RC	G288
5042	PALMIANO	AP	G289
5043	PALMOLI	CH	G290
5044	PALO DEL COLLE	BA	G291
5045	PALOMONTE	SA	G292
5046	PALOMBARA SABINA	RM	G293
5047	PALOMBARO	CH	G294
5048	PALOSCO	BG	G295
5049	PALU' DEL FERSINA	TN	G296
5050	PALU'	VR	G297
5051	PALUDI	CS	G298
5052	PLAUS * PLAUS	BZ	G299
5053	PALUZZA	UD	G300
5054	PAMPARATO	CN	G302
5055	PANCALIERI	TO	G303
5056	PANCARANA	PV	G304
5057	PANCHIA'	TN	G305
5058	PANDINO	CR	G306
5059	PANETTIERI	CS	G307
5060	PANICALE	PG	G308
5061	VILLARICCA	NA	G309
5062	PANNARANO	BN	G311
5063	PANNI	FG	G312
5064	PANTELLERIA	TP	G315
5065	PANTIGLIATE	MI	G316
5066	PAOLA	CS	G317
5067	PAOLISI	BN	G318
5068	VALDERICE	TP	G319
5069	PAPASIDERO	CS	G320
5070	PAPOZZE	RO	G323
5071	PARABIAGO	MI	G324
5072	PARABITA	LE	G325
5073	PARATICO	BS	G327
5074	PARCINES * PARTSCHINS	BZ	G328
5075	PARE'	CO	G329
5076	PARELLA	TO	G330
5077	PARENTI	CS	G331
5079	PARETE	CE	G333
5080	PARETO	AL	G334
5081	PARGHELIA	VV	G335
5082	PARLASCO	LC	G336
5083	PARMA	PR	G337
5084	PARODI LIGURE	AL	G338
5085	PAROLDO	CN	G339
5086	PAROLISE	AV	G340
5087	PARONA	PV	G342
5088	PARRANO	TR	G344
5089	PARRE	BG	G346
5090	PARTANNA	TP	G347
5091	PARTINICO	PA	G348
5092	PARUZZARO	NO	G349
5093	PARZANICA	BG	G350
5094	PASIAN DI PRATO	UD	G352
5095	PASIANO DI PORDENONE	PN	G353
5096	PASPARDO	BS	G354
5097	PASSERANO MARMORITO	AT	G358
5098	PASSIGNANO SUL TRASIMENO	PG	G359
5099	PASSIRANO	BS	G361
5100	PASTENA	FR	G362
5101	PASTORANO	CE	G364
5102	PASTRENGO	VR	G365
5103	PASTURANA	AL	G367
5104	PASTURO	LC	G368
5105	PATERNOPOLI	AV	G370
5106	PATERNO'	CT	G371
5107	PATERNO CALABRO	CS	G372
5108	PATRICA	FR	G374
5109	PATTADA	SS	G376
5110	PATTI	ME	G377
5111	PATU'	LE	G378
5112	PAU	OR	G379
5113	PAULARO	UD	G381
5114	PAULI ARBAREI	VS	G382
5115	SAN NICOLO' GERREI	CA	G383
5116	PAULILATINO	OR	G384
5117	PAULLO	MI	G385
5118	PAUPISI	BN	G386
5119	PAVAROLO	TO	G387
5120	PAVIA	PV	G388
5121	PAVIA DI UDINE	UD	G389
5122	PAVONE DEL MELLA	BS	G391
5123	PAVONE CANAVESE	TO	G392
5124	PAVULLO NEL FRIGNANO	MO	G393
5125	PAZZANO	RC	G394
5126	PECCIOLI	PI	G395
5127	PECCO	TO	G396
5128	PECETTO DI VALENZA	AL	G397
5129	PECETTO TORINESE	TO	G398
5130	PECORARA	PC	G399
5131	PEDACE	CS	G400
5132	PEDARA	CT	G402
5133	PEDASO	FM	G403
5134	PEDAVENA	BL	G404
5135	PEDEMONTE	VI	G406
5136	SAN PAOLO	BS	G407
5137	PEDEROBBA	TV	G408
5138	PEDESINA	SO	G410
5139	PEDIVIGLIANO	CS	G411
5140	PEDRENGO	BG	G412
5141	PEGLIO	CO	G415
5142	PEGLIO	PU	G416
5143	PEGOGNAGA	MN	G417
5144	PEIA	BG	G418
5145	PEIO	TN	G419
5146	PELAGO	FI	G420
5147	PELLA	NO	G421
5148	PELLEGRINO PARMENSE	PR	G424
5149	PELLEZZANO	SA	G426
5150	PELLIO INTELVI	CO	G427
5151	PELLIZZANO	TN	G428
5152	PELUGO	TN	G429
5153	PENANGO	AT	G430
5154	POGGIRIDENTI	SO	G431
5155	PENNA IN TEVERINA	TR	G432
5156	PENNABILLI	RN	G433
5157	PENNADOMO	CH	G434
5158	PENNAPIEDIMONTE	CH	G435
5159	PENNA SAN GIOVANNI	MC	G436
5160	PENNA SANT'ANDREA	TE	G437
5161	PENNE	PE	G438
5162	PENTONE	CZ	G439
5163	PERANO	CH	G441
5164	PERAROLO DI CADORE	BL	G442
5165	PERCA * PERCHA	BZ	G443
5166	PERCILE	RM	G444
5167	PERDASDEFOGU	OG	G445
5168	PERDAXIUS	CI	G446
5169	PERDIFUMO	SA	G447
5170	PEREGO	LC	G448
5171	PERETO	AQ	G449
5172	PERFUGAS	SS	G450
5173	PERGINE VALDARNO	AR	G451
5174	PERGINE VALSUGANA	TN	G452
5175	PERGOLA	PU	G453
5176	PERINALDO	IM	G454
5177	PERITO	SA	G455
5178	PERLEDO	LC	G456
5179	PERLETTO	CN	G457
5180	PERLO	CN	G458
5181	PERLOZ	AO	G459
5182	PERNUMIA	PD	G461
5183	PEROSA CANAVESE	TO	G462
5184	PEROSA ARGENTINA	TO	G463
5185	PERRERO	TO	G465
5186	SAN GIOVANNI IN PERSICETO	BO	G467
5187	PERSICO DOSIMO	CR	G469
5188	PERTENGO	VC	G471
5189	PERTICA ALTA	BS	G474
5190	PERTICA BASSA	BS	G475
5191	PERTOSA	SA	G476
5192	PERTUSIO	TO	G477
5193	PERUGIA	PG	G478
5194	PESARO	PU	G479
5195	PESCAGLIA	LU	G480
5196	PESCANTINA	VR	G481
5197	PESCARA	PE	G482
5198	PESCAROLO ED UNITI	CR	G483
5199	PESCASSEROLI	AQ	G484
5200	PESCATE	LC	G485
5201	PESCHE	IS	G486
5202	PESCHICI	FG	G487
5203	PESCHIERA BORROMEO	MI	G488
5204	PESCHIERA DEL GARDA	VR	G489
5205	PESCIA	PT	G491
5206	PESCINA	AQ	G492
5207	PESCOCOSTANZO	AQ	G493
5208	PESCO SANNITA	BN	G494
5209	PESCOLANCIANO	IS	G495
5210	PESCOPAGANO	PZ	G496
5211	PESCOPENNATARO	IS	G497
5212	PESCOROCCHIANO	RI	G498
5213	PESCOSANSONESCO	PE	G499
5214	PESCOSOLIDO	FR	G500
5215	PESSANO CON BORNAGO	MI	G502
5216	PESSINA CREMONESE	CR	G504
5217	PESSINETTO	TO	G505
5218	PETACCIATO	CB	G506
5219	TURANIA	RI	G507
5220	PETILIA POLICASTRO	KR	G508
5221	PETINA	SA	G509
5222	PETRALIA SOPRANA	PA	G510
5223	PETRALIA SOTTANA	PA	G511
5224	PETRELLA TIFERNINA	CB	G512
5225	PETRELLA SALTO	RI	G513
5226	PETRIANO	PU	G514
5227	PETRIOLO	MC	G515
5228	PETRITOLI	FM	G516
5229	PETRIZZI	CZ	G517
5230	PETRONA'	CZ	G518
5231	PETRURO IRPINO	AV	G519
5232	PETTENASCO	NO	G520
5233	PETTINENGO	BI	G521
5234	PETTINEO	ME	G522
5235	PETTORANELLO DEL MOLISE	IS	G523
5236	PETTORANO SUL GIZIO	AQ	G524
5237	PETTORAZZA GRIMANI	RO	G525
5238	PEVERAGNO	CN	G526
5239	PEZZANA	VC	G528
5240	PEZZAZE	BS	G529
5241	PEZZOLO VALLE UZZONE	CN	G532
5242	PIACENZA D'ADIGE	PD	G534
5243	PIACENZA	PC	G535
5244	PIADENA	CR	G536
5245	PIAGGE	PU	G537
5246	PIAGGINE	SA	G538
5247	VALLE DELL'ANGELO	SA	G540
5248	PIANA DI MONTE VERNA	CE	G541
5249	PIANA CRIXIA	SV	G542
5250	PIANA DEGLI ALBANESI	PA	G543
5251	PONTBOSET	AO	G545
5252	PIAN CAMUNO	BS	G546
5253	PIANCASTAGNAIO	SI	G547
5254	PIANCOGNO	BS	G549
5255	PIANDIMELETO	PU	G551
5256	PIAN DI SCO	AR	G552
5257	PIANE CRATI	CS	G553
5258	PIANELLA	PE	G555
5259	PIANELLO DEL LARIO	CO	G556
5260	PIANELLO VAL TIDONE	PC	G557
5261	PIANENGO	CR	G558
5262	PIANEZZA	TO	G559
5263	PIANEZZE	VI	G560
5264	PIANFEI	CN	G561
5265	PIANICO	BG	G564
5266	PIANIGA	VE	G565
5267	SAN BENEDETTO VAL DI SAMBRO	BO	G566
5268	PIANO DI SORRENTO	NA	G568
5269	PIANORO	BO	G570
5270	PIANSANO	VT	G571
5271	PIANTEDO	SO	G572
5272	PIARIO	BG	G574
5273	PIASCO	CN	G575
5274	PIATEDA	SO	G576
5275	PIATTO	BI	G577
5276	PIAZZA BREMBANA	BG	G579
5277	PIAZZA ARMERINA	EN	G580
5278	PIAZZA AL SERCHIO	LU	G582
5279	PIAZZATORRE	BG	G583
5280	PIAZZOLA SUL BRENTA	PD	G587
5281	PIAZZOLO	BG	G588
5282	PICCIANO	PE	G589
5283	PICERNO	PZ	G590
5284	PICINISCO	FR	G591
5285	PICO	FR	G592
5286	PIEA	AT	G593
5287	PIEDICAVALLO	BI	G594
5288	PIEDIMONTE MATESE	CE	G596
5289	PIEDIMONTE ETNEO	CT	G597
5290	PIEDIMONTE SAN GERMANO	FR	G598
5291	PIEDIMULERA	VB	G600
5292	PIEGARO	PG	G601
5293	PIENZA	SI	G602
5294	PIERANICA	CR	G603
5295	PIETRAMONTECORVINO	FG	G604
5296	PIETRA LIGURE	SV	G605
5297	PIETRABBONDANTE	IS	G606
5298	PIETRABRUNA	IM	G607
5299	PIETRACAMELA	TE	G608
5300	PIETRACATELLA	CB	G609
5301	PIETRACUPA	CB	G610
5302	PIETRADEFUSI	AV	G611
5303	PIETRA DE' GIORGI	PV	G612
5304	PIETRAFERRAZZANA	CH	G613
5305	SATRIANO DI LUCANIA	PZ	G614
5306	PIETRAFITTA	CS	G615
5307	PIETRAGALLA	PZ	G616
5308	PIETRALUNGA	PG	G618
5309	PIETRA MARAZZI	AL	G619
5310	PIETRAMELARA	CE	G620
5311	PIETRANICO	PE	G621
5312	PIETRAPAOLA	CS	G622
5313	PIETRAPERTOSA	PZ	G623
5314	PIETRAPERZIA	EN	G624
5315	PIETRAPORZIO	CN	G625
5316	PIETRAROJA	BN	G626
5317	PIETRARUBBIA	PU	G627
5318	PIETRASANTA	LU	G628
5319	PIETRASTORNINA	AV	G629
5320	PIETRAVAIRANO	CE	G630
5321	PIETRELCINA	BN	G631
5322	PIEVE DI TECO	IM	G632
5323	PIEVE DI CORIANO	MN	G633
5324	PIEVE EMANUELE	MI	G634
5325	PIEVE ALBIGNOLA	PV	G635
5326	PIEVE A NIEVOLE	PT	G636
5327	PIEVEBOVIGLIANA	MC	G637
5328	PIEVE D'ALPAGO	BL	G638
5329	PIEVE DEL CAIRO	PV	G639
5330	PIEVE DI BONO	TN	G641
5331	PIEVE DI CADORE	BL	G642
5332	PIEVE DI CENTO	BO	G643
5333	PIEVE DI SOLIGO	TV	G645
5334	PIEVE LIGURE	GE	G646
5335	PIEVE D'OLMI	CR	G647
5336	PIEVE FOSCIANA	LU	G648
5337	PIEVEPELAGO	MO	G649
5338	PIEVE PORTO MORONE	PV	G650
5339	PIEVE SAN GIACOMO	CR	G651
5340	PIEVE SANTO STEFANO	AR	G653
5341	RAMISETO	RE	G654
5342	PIEVE TESINO	TN	G656
5343	PIEVE TORINA	MC	G657
5344	PIEVE VERGONTE	VB	G658
5345	PIGLIO	FR	G659
5346	PIGNA	IM	G660
5347	PIGNATARO MAGGIORE	CE	G661
5348	PIGNATARO INTERAMNA	FR	G662
5349	PIGNOLA	PZ	G663
5350	PIGNONE	SP	G664
5351	PIGRA	CO	G665
5352	PILA	VC	G666
5353	PIMENTEL	CA	G669
5354	PIMONTE	NA	G670
5355	PINAROLO PO	PV	G671
5356	PINASCA	TO	G672
5357	PINCARA	RO	G673
5358	PINEROLO	TO	G674
5360	PINO D'ASTI	AT	G676
5361	PINO SULLA SPONDA DEL LAGO MAGGIORE	VA	G677
5362	PINO TORINESE	TO	G678
5363	PINZANO AL TAGLIAMENTO	PN	G680
5364	PINZOLO	TN	G681
5365	PIOBBICO	PU	G682
5366	PIOBESI D'ALBA	CN	G683
5367	PIOBESI TORINESE	TO	G684
5368	PIODE	VC	G685
5369	PIOLTELLO	MI	G686
5370	PIOMBINO	LI	G687
5371	PIOMBINO DESE	PD	G688
5372	PIORACO	MC	G690
5373	PIOSSASCO	TO	G691
5374	PIOVA' MASSAIA	AT	G692
5375	PIOVE DI SACCO	PD	G693
5376	PIOVENE ROCCHETTE	VI	G694
5377	PIOVERA	AL	G695
5378	PIOZZANO	PC	G696
5379	PIOZZO	CN	G697
5380	PRIVERNO	LT	G698
5381	PIRAINO	ME	G699
5383	PISA	PI	G702
5384	PISANO	NO	G703
5385	PISONIANO	RM	G704
5386	PISCINA	TO	G705
5387	PISCIOTTA	SA	G707
5389	PISOGNE	BS	G710
5390	PISTICCI	MT	G712
5391	PISTOIA	PT	G713
5392	PITEGLIO	PT	G715
5393	PITIGLIANO	GR	G716
5394	PIUBEGA	MN	G717
5395	PIURO	SO	G718
5396	PIVERONE	TO	G719
5397	PIZZALE	PV	G720
5398	PIZZIGHETTONE	CR	G721
5399	PIZZO	VV	G722
5400	PIZZOFERRATO	CH	G724
5401	PIZZOLI	AQ	G726
5402	PIZZONE	IS	G727
5403	PIZZONI	VV	G728
5404	PLACANICA	RC	G729
5405	PLATACI	CS	G733
5406	PLATANIA	CZ	G734
5407	PLATI'	RC	G735
5408	TAIPANA	UD	G736
5409	PLESIO	CO	G737
5410	PLEZZO	GO	G738
5411	PLOAGHE	SS	G740
5412	PLODIO	SV	G741
5413	POCAPAGLIA	CN	G742
5414	POCENIA	UD	G743
5415	PODENZANA	MS	G746
5416	PODENZANO	PC	G747
5417	POFI	FR	G749
5418	POGGIARDO	LE	G751
5419	POGGIBONSI	SI	G752
5420	POGGIO RUSCO	MN	G753
5421	POGGIO A CAIANO	PO	G754
5422	POGGIO BERNI	RN	G755
5423	POGGIO BUSTONE	RI	G756
5424	POGGIO CATINO	RI	G757
5425	POGGIODOMO	PG	G758
5426	POGGIOFIORITO	CH	G760
5427	POGGIO IMPERIALE	FG	G761
5428	POGGIOMARINO	NA	G762
5429	POGGIO MIRTETO	RI	G763
5430	POGGIO MOIANO	RI	G764
5431	POGGIO NATIVO	RI	G765
5432	POGGIO PICENZE	AQ	G766
5433	POGGIOREALE	TP	G767
5434	POGGIO RENATICO	FE	G768
5435	POGGIORSINI	BA	G769
5436	POGGIO SAN LORENZO	RI	G770
5437	POGGIO SAN MARCELLO	AN	G771
5438	POGLIANO MILANESE	MI	G772
5439	POGNANA LARIO	CO	G773
5440	POGNANO	BG	G774
5441	POGNO	NO	G775
5442	POIANA MAGGIORE	VI	G776
5443	POIRINO	TO	G777
5445	POLAVENO	BS	G779
5446	POLCENIGO	PN	G780
5447	POLESELLA	RO	G782
5448	POLESINE PARMENSE	PR	G783
5449	POLI	RM	G784
5450	POLIA	VV	G785
5451	POLICORO	MT	G786
5452	POLIGNANO A MARE	BA	G787
5453	SAN PIETRO IN CERRO	PC	G788
5454	POLINAGO	MO	G789
5455	POLINO	TR	G790
5456	POLISTENA	RC	G791
5457	POLIZZI GENEROSA	PA	G792
5458	POLLA	SA	G793
5459	POLLEIN	AO	G794
5460	POLLENA TROCCHIA	NA	G795
5461	POLLICA	SA	G796
5462	POLLINA	PA	G797
5463	POLLONE	BI	G798
5464	POLLUTRI	CH	G799
5465	POLONGHERA	CN	G800
5466	POLPENAZZE DEL GARDA	BS	G801
5467	POLVERARA	PD	G802
5468	POLVERIGI	AN	G803
5469	POMARANCE	PI	G804
5470	POMARETTO	TO	G805
5471	POMARICO	MT	G806
5472	POMARO MONFERRATO	AL	G807
5473	POMAROLO	TN	G808
5474	POMBIA	NO	G809
5475	POMEZIA	RM	G811
5476	POMIGLIANO D'ARCO	NA	G812
5477	POMPEI	NA	G813
5478	POMPEIANA	IM	G814
5479	POMPIANO	BS	G815
5480	POMPONESCO	MN	G816
5481	POMPU	OR	G817
5482	PONCARALE	BS	G818
5483	PONDERANO	BI	G820
5484	PONNA	CO	G821
5485	PONSACCO	PI	G822
5486	PONSO	PD	G823
5487	PONTASSIEVE	FI	G825
5488	PONT CANAVESE	TO	G826
5489	PONTE	BN	G827
5490	PONTE IN VALTELLINA	SO	G829
5491	PONTE GARDENA * WAIDBRUCK	BZ	G830
5492	PONTEBBA	UD	G831
5493	PONTE BUGGIANESE	PT	G833
5494	PONTECAGNANO FAIANO	SA	G834
5495	PONTECCHIO POLESINE	RO	G836
5496	PONTECHIANALE	CN	G837
5497	PONTECORVO	FR	G838
5498	PONTECURONE	AL	G839
5499	PONTEDASSIO	IM	G840
5500	PONTE DELL'OLIO	PC	G842
5501	PONTEDERA	PI	G843
5502	PONTE DI LEGNO	BS	G844
5503	PONTE DI PIAVE	TV	G846
5504	PONTE LAMBRO	CO	G847
5505	PONTELANDOLFO	BN	G848
5506	PONTELATONE	CE	G849
5507	PONTELONGO	PD	G850
5508	PONTE NIZZA	PV	G851
5509	PONTENURE	PC	G852
5510	PONTERANICA	BG	G853
5511	PONT-SAINT-MARTIN	AO	G854
5512	PONTE SAN NICOLO'	PD	G855
5513	PONTE SAN PIETRO	BG	G856
5514	PONTESTURA	AL	G858
5515	PONTEVICO	BS	G859
5516	PONTEY	AO	G860
5517	PONTI	AL	G861
5518	PONTI SUL MINCIO	MN	G862
5519	PONTIDA	BG	G864
5520	PONTINIA	LT	G865
5521	PONTINVREA	SV	G866
5522	PONTIROLO NUOVO	BG	G867
5523	PONTOGLIO	BS	G869
5524	PONTREMOLI	MS	G870
5525	PONZA	LT	G871
5526	PONZANO MONFERRATO	AL	G872
5527	PONZANO DI FERMO	FM	G873
5528	PONZANO ROMANO	RM	G874
5529	PONZANO VENETO	TV	G875
5530	PONZONE	AL	G877
5531	POPOLI	PE	G878
5532	POPPI	AR	G879
5533	PORANO	TR	G881
5534	PORCARI	LU	G882
5535	PORCIA	PN	G886
5536	STELLA CILENTO	SA	G887
5537	PORDENONE	PN	G888
5538	PORLEZZA	CO	G889
5539	PORNASSIO	IM	G890
5540	PORPETTO	UD	G891
5541	PORTACOMARO	AT	G894
5542	PORTALBERA	PV	G895
5543	PORTE	TO	G900
5544	PORTICI	NA	G902
5545	PORTICO DI CASERTA	CE	G903
5546	PORTICO E SAN BENEDETTO	FC	G904
5547	PORTIGLIOLA	RC	G905
5548	PORTO CERESIO	VA	G906
5549	PORTO VALTRAVAGLIA	VA	G907
5550	PORTOBUFFOLE'	TV	G909
5551	PORTOCANNONE	CB	G910
5552	PORTOFERRAIO	LI	G912
5553	PORTOFINO	GE	G913
5554	PORTOGRUARO	VE	G914
5556	PORTOMAGGIORE	FE	G916
5557	PORTO MANTOVANO	MN	G917
5558	PORTO RECANATI	MC	G919
5559	PORTO SAN GIORGIO	FM	G920
5560	PORTO SANT'ELPIDIO	FM	G921
5561	PORTOSCUSO	CI	G922
5562	PORTO TOLLE	RO	G923
5563	PORTO TORRES	SS	G924
5564	PORTOVENERE	SP	G925
5565	PORTO VIRO	RO	G926
5566	PORTULA	BI	G927
5567	POSADA	NU	G929
5568	POSINA	VI	G931
5569	POSITANO	SA	G932
5570	POSSAGNO	TV	G933
5571	POSTA	RI	G934
5572	POSTA FIBRENO	FR	G935
5573	POSTAL * BURGSTALL	BZ	G936
5574	POSTALESIO	SO	G937
5575	POSTIGLIONE	SA	G939
5576	POSTUA	VC	G940
5577	POSTUMIA GROTTE	TS	G941
5578	POTENZA	PZ	G942
5579	POVE DEL GRAPPA	VI	G943
5580	POVEGLIANO	TV	G944
5581	POVEGLIANO VERONESE	VR	G945
5582	POVIGLIO	RE	G947
5583	POVOLETTO	UD	G949
5584	POZZA DI FASSA	TN	G950
5585	POZZAGLIA SABINA	RI	G951
5586	POZZALLO	RG	G953
5587	POZZILLI	IS	G954
5588	POZZO D'ADDA	MI	G955
5589	POZZOLEONE	VI	G957
5590	POZZOLENGO	BS	G959
5591	POZZOL GROPPO	AL	G960
5592	POZZOLO FORMIGARO	AL	G961
5593	POZZOMAGGIORE	SS	G962
5594	POZZONOVO	PD	G963
5595	POZZUOLI	NA	G964
5596	POZZUOLO MARTESANA	MI	G965
5597	POZZUOLO DEL FRIULI	UD	G966
5598	PRADALUNGA	BG	G968
5599	PRADAMANO	UD	G969
5600	PRADLEVES	CN	G970
5601	SASSO MARCONI	BO	G972
5602	PRAGELATO	TO	G973
5603	PRAY	BI	G974
5604	PRAIA A MARE	CS	G975
5605	PRAIANO	SA	G976
5606	PRALBOINO	BS	G977
5607	PRALI	TO	G978
5608	PRALORMO	TO	G979
5609	PRALUNGO	BI	G980
5610	PRAMAGGIORE	VE	G981
5611	PRAMOLLO	TO	G982
5612	PRAROLO	VC	G985
5613	PRAROSTINO	TO	G986
5614	PRASCO	AL	G987
5615	PRASCORSANO	TO	G988
5616	PRASO	TN	G989
5617	PRATA DI PRINCIPATO ULTRA	AV	G990
5618	PRATA SANNITA	CE	G991
5619	PRATA D'ANSIDONIA	AQ	G992
5620	PRATA CAMPORTACCIO	SO	G993
5621	PRATA DI PORDENONE	PN	G994
5622	PRATELLA	CE	G995
5623	PRATIGLIONE	TO	G997
5624	PRATO	PO	G999
5625	PRATO SESIA	NO	H001
5626	PRATO CARNICO	UD	H002
5627	PRATO ALLO STELVIO * PRAD AM STILFSERJOCH	BZ	H004
5628	PRATOLA SERRA	AV	H006
5629	PRATOLA PELIGNA	AQ	H007
5630	PRATOVECCHIO	AR	H008
5631	PRAVISDOMINI	PN	H010
5632	PRAZZO	CN	H011
5633	SAMO	RC	H013
5634	PRECENICCO	UD	H014
5635	PRECI	PG	H015
5636	PREDAPPIO	FC	H017
5637	PREDAZZO	TN	H018
5638	PREDOI * PRETTAU	BZ	H019
5639	PREDORE	BG	H020
5640	PREDOSA	AL	H021
5641	PREGANZIOL	TV	H022
5642	PREGNANA MILANESE	MI	H026
5643	PRELA'	IM	H027
5644	PREMANA	LC	H028
5645	PREMARIACCO	UD	H029
5646	PREMENO	VB	H030
5647	PREMIA	VB	H033
5648	PREMILCUORE	FC	H034
5649	PREMOLO	BG	H036
5650	PREMOSELLO-CHIOVENDA	VB	H037
5651	PREONE	UD	H038
5652	PREORE	TN	H039
5653	PREPOTTO	UD	H040
5654	PRE'-SAINT-DIDIER	AO	H042
5655	PRESEGLIE	BS	H043
5656	PRESENZANO	CE	H045
5657	PRESEZZO	BG	H046
5658	PRESICCE	LE	H047
5659	PRESSANA	VR	H048
5660	PRESTINE	BS	H050
5661	PRETORO	CH	H052
5662	PREVALLE	BS	H055
5663	PREZZA	AQ	H056
5664	PREZZO	TN	H057
5665	PRIERO	CN	H059
5666	PRIGNANO SULLA SECCHIA	MO	H061
5667	PRIGNANO CILENTO	SA	H062
5668	PRIMALUNA	LC	H063
5669	PRIMANO	FM	H064
5670	PRIOCCA	CN	H068
5671	PRIOLA	CN	H069
5672	PRIZZI	PA	H070
5673	PROCENO	VT	H071
5674	PROCIDA	NA	H072
5675	PROPATA	GE	H073
5676	PROSERPIO	CO	H074
5677	PROSSEDI	LT	H076
5678	PROVAGLIO VAL SABBIA	BS	H077
5679	PROVAGLIO D'ISEO	BS	H078
5680	PROVES * PROVEIS	BZ	H081
5681	PROVVIDENTI	CB	H083
5682	PRUNETTO	CN	H085
5683	PUEGNAGO SUL GARDA	BS	H086
5684	PUGLIANELLO	BN	H087
5685	PULA	CA	H088
5686	PULFERO	UD	H089
5687	PULSANO	TA	H090
5688	PUMENENGO	BG	H091
5689	PUOS D'ALPAGO	BL	H092
5690	PUSIANO	CO	H094
5691	PUTIFIGARI	SS	H095
5692	PUTIGNANO	BA	H096
5693	QUADRELLE	AV	H097
5694	QUADRI	CH	H098
5695	QUAGLIUZZO	TO	H100
5696	QUALIANO	NA	H101
5697	QUARANTI	AT	H102
5698	QUAREGNA	BI	H103
5699	QUARGNENTO	AL	H104
5700	QUARNA SOPRA	VB	H106
5701	QUARNA SOTTO	VB	H107
5702	QUARONA	VC	H108
5703	QUARRATA	PT	H109
5704	QUART	AO	H110
5705	QUARTO	NA	H114
5706	QUARTO D'ALTINO	VE	H117
5707	QUARTU SANT'ELENA	CA	H118
5708	QUARTUCCIU	CA	H119
5709	QUASSOLO	TO	H120
5710	QUATTORDIO	AL	H121
5711	QUATTRO CASTELLA	RE	H122
5712	VIRGILIO	MN	H123
5713	QUERO	BL	H124
5714	QUILIANO	SV	H126
5715	QUINCINETTO	TO	H127
5716	QUINDICI	AV	H128
5717	QUINGENTOLE	MN	H129
5718	QUINTANO	CR	H130
5719	QUINTO DI TREVISO	TV	H131
5720	QUINTO VERCELLESE	VC	H132
5721	QUINTO VICENTINO	VI	H134
5722	QUINZANO D'OGLIO	BS	H140
5723	QUISTELLO	MN	H143
5724	QUITTENGO	BI	H145
5725	RABBI	TN	H146
5726	RACALE	LE	H147
5727	RACALMUTO	AG	H148
5728	RACCONIGI	CN	H150
5729	RACCUJA	ME	H151
5730	RACINES * RATSCHINGS	BZ	H152
5731	RADDA IN CHIANTI	SI	H153
5732	RADDUSA	CT	H154
5733	RADICOFANI	SI	H156
5734	RADICONDOLI	SI	H157
5735	RAFFADALI	AG	H159
5736	RAGOGNA	UD	H161
5737	RAGOLI	TN	H162
5738	RAGUSA	RG	H163
5739	RUVIANO	CE	H165
5740	RAIANO	AQ	H166
5741	RAMACCA	CT	H168
5742	RAMPONIO VERNA	CO	H171
5743	RANCIO VALCUVIA	VA	H173
5744	RANCO	VA	H174
5745	RANDAZZO	CT	H175
5746	RANICA	BG	H176
5747	RANZANICO	BG	H177
5748	RANZIANO	GO	H178
5749	RANZO	IM	H180
5750	RAPAGNANO	FM	H182
5751	RAPALLO	GE	H183
5752	RAPINO	CH	H184
5753	RAPOLANO TERME	SI	H185
5754	RAPOLLA	PZ	H186
5755	RAPONE	PZ	H187
5756	RASSA	VC	H188
5757	RASUN-ANTERSELVA * RASEN-ANTHOLZ	BZ	H189
5758	RASURA	SO	H192
5759	RAVANUSA	AG	H194
5760	RAVARINO	MO	H195
5761	RAVASCLETTO	UD	H196
5762	RAVELLO	SA	H198
5763	RAVENNA	RA	H199
5764	RAVEO	UD	H200
5765	RAVISCANINA	CE	H202
5766	RE	VB	H203
5767	REA	PV	H204
5768	REALMONTE	AG	H205
5769	REANA DEL ROIALE	UD	H206
5770	REANO	TO	H207
5771	RECALE	CE	H210
5772	RECANATI	MC	H211
5773	RECCO	GE	H212
5774	RECETTO	NO	H213
5775	RECOARO TERME	VI	H214
5776	REDAVALLE	PV	H216
5777	REDONDESCO	MN	H218
5778	REFRANCORE	AT	H219
5779	REFRONTOLO	TV	H220
5780	REGALBUTO	EN	H221
5781	REGGELLO	FI	H222
5782	REGGIO NELL'EMILIA	RE	H223
5783	REGGIO DI CALABRIA	RC	H224
5784	REGGIOLO	RE	H225
5785	REINO	BN	H227
5786	REITANO	ME	H228
5787	REMANZACCO	UD	H229
5788	REMEDELLO	BS	H230
5789	RENATE	MB	H233
5790	RENDE	CS	H235
5791	RENON * RITTEN	BZ	H236
5792	RESANA	TV	H238
5793	RESCALDINA	MI	H240
5794	RESIA	UD	H242
5795	ERCOLANO	NA	H243
5796	RESIUTTA	UD	H244
5797	RESUTTANO	CL	H245
5798	RETORBIDO	PV	H246
5799	REVELLO	CN	H247
5800	REVERE	MN	H248
5801	REVIGLIASCO D'ASTI	AT	H250
5802	REVINE LAGO	TV	H253
5803	REVO'	TN	H254
5804	REZZAGO	CO	H255
5805	REZZATO	BS	H256
5806	REZZO	IM	H257
5807	REZZOAGLIO	GE	H258
5808	VAL REZZO	CO	H259
5809	RHEMES-NOTRE-DAME	AO	H262
5810	RHEMES-SAINT-GEORGES	AO	H263
5811	RHO	MI	H264
5812	RIACE	RC	H265
5813	RIALTO	SV	H266
5814	RIANO	RM	H267
5815	RIARDO	CE	H268
5816	RIBERA	AG	H269
5817	RIBORDONE	TO	H270
5818	RICADI	VV	H271
5819	RICALDONE	AL	H272
5820	RICCIA	CB	H273
5821	RICCIONE	RN	H274
5822	RICCO' DEL GOLFO DI SPEZIA	SP	H275
5823	RICENGO	CR	H276
5824	RICIGLIANO	SA	H277
5825	RIESE PIO X	TV	H280
5826	RIESI	CL	H281
5827	RIETI	RI	H282
5828	RIFEMBERGO	GO	H283
5829	RIFIANO * RIFFIAN	BZ	H284
5830	RIFREDDO	CN	H285
5831	RIGNANO SULL'ARNO	FI	H286
5832	RIGNANO GARGANICO	FG	H287
5833	RIGNANO FLAMINIO	RM	H288
5834	RIGOLATO	UD	H289
5835	RIMA SAN GIUSEPPE	VC	H291
5836	RIMASCO	VC	H292
5837	RIMELLA	VC	H293
5838	RIMINI	RN	H294
5839	RIO NELL'ELBA	LI	H297
5840	RIO SALICETO	RE	H298
5841	RIO DI PUSTERIA * MUEHLBACH	BZ	H299
5842	RIOFREDDO	RM	H300
5843	RIOLA SARDO	OR	H301
5844	RIOLO TERME	RA	H302
5845	RIOLUNATO	MO	H303
5846	RIOMAGGIORE	SP	H304
5847	RIO MARINA	LI	H305
5848	RIONERO IN VULTURE	PZ	H307
5849	RIONERO SANNITICO	IS	H308
5850	RIPABOTTONI	CB	H311
5851	RIPACANDIDA	PZ	H312
5852	RIPALIMOSANI	CB	H313
5853	RIPALTA ARPINA	CR	H314
5854	RIPALTA CREMASCA	CR	H315
5855	RIPALTA GUERINA	CR	H316
5856	RIPARBELLA	PI	H319
5857	RIPA TEATINA	CH	H320
5858	RIPATRANSONE	AP	H321
5859	RIPE	AN	H322
5860	RIPE SAN GINESIO	MC	H323
5861	RIPI	FR	H324
5862	RIPOSTO	CT	H325
5863	RITTANA	CN	H326
5864	RIVAMONTE AGORDINO	BL	H327
5865	RIVA LIGURE	IM	H328
5866	RIVA VALDOBBIA	VC	H329
5867	RIVA DEL GARDA	TN	H330
5868	RIVA DI SOLTO	BG	H331
5869	RIVALBA	TO	H333
5870	RIVALTA BORMIDA	AL	H334
5871	RIVALTA DI TORINO	TO	H335
5872	RIVANAZZANO TERME	PV	H336
5873	RIVA PRESSO CHIERI	TO	H337
5874	RIVARA	TO	H338
5875	RIVAROLO CANAVESE	TO	H340
5876	RIVAROLO DEL RE ED UNITI	CR	H341
5877	RIVAROLO MANTOVANO	MN	H342
5878	RIVARONE	AL	H343
5879	RIVAROSSA	TO	H344
5880	RIVE	VC	H346
5881	RIVE D'ARCANO	UD	H347
5882	RIVELLO	PZ	H348
5883	RIVERGARO	PC	H350
5884	RIVIGNANO	UD	H352
5885	RIVISONDOLI	AQ	H353
5886	RIVODUTRI	RI	H354
5887	RIVOLI	TO	H355
5888	RIVOLI VERONESE	VR	H356
5889	RIVOLTA D'ADDA	CR	H357
5890	RIZZICONI	RC	H359
5891	RO	FE	H360
5892	ROANA	VI	H361
5893	ROASCHIA	CN	H362
5894	ROASCIO	CN	H363
5895	ROVASENDA	VC	H364
5896	ROASIO	VC	H365
5897	ROATTO	AT	H366
5898	ROBASSOMERO	TO	H367
5899	ROBBIO	PV	H369
5900	ROBECCHETTO CON INDUNO	MI	H371
5901	ROBECCO D'OGLIO	CR	H372
5902	ROBECCO SUL NAVIGLIO	MI	H373
5903	ROBECCO PAVESE	PV	H375
5904	ROBELLA	AT	H376
5905	ROBILANTE	CN	H377
5906	ROBURENT	CN	H378
5907	ROCCA PIETORE	BL	H379
5908	ROCCAVALDINA	ME	H380
5909	ROCCABASCERANA	AV	H382
5910	ROCCABERNARDA	KR	H383
5911	ROCCABIANCA	PR	H384
5912	ROCCABRUNA	CN	H385
5913	ROCCA CANAVESE	TO	H386
5914	ROCCA CANTERANO	RM	H387
5915	ROCCACASALE	AQ	H389
5916	ROCCAFLUVIONE	AP	H390
5917	ROCCA CIGLIE'	CN	H391
5918	ROCCA D'ARAZZO	AT	H392
5919	ROCCADARCE	FR	H393
5920	ROCCADASPIDE	SA	H394
5921	ROCCA DE' BALDI	CN	H395
5922	ROCCA DE' GIORGI	PV	H396
5923	ROCCA D'EVANDRO	CE	H398
5924	ROCCA DI BOTTE	AQ	H399
5925	ROCCA DI CAMBIO	AQ	H400
5926	ROCCA DI CAVE	RM	H401
5927	ROCCA DI MEZZO	AQ	H402
5928	ROCCA DI NETO	KR	H403
5929	ROCCA DI PAPA	RM	H404
5930	ROCCAFIORITA	ME	H405
5931	ROCCAFORTE LIGURE	AL	H406
5932	ROCCAFORTE MONDOVI'	CN	H407
5933	ROCCAFORTE DEL GRECO	RC	H408
5934	ROCCAFORZATA	TA	H409
5935	ROCCAFRANCA	BS	H410
5936	ROCCAGIOVINE	RM	H411
5937	ROCCAGLORIOSA	SA	H412
5938	ROCCAGORGA	LT	H413
5939	ROCCA GRIMALDA	AL	H414
5940	ROCCA IMPERIALE	CS	H416
5941	ROCCALBEGNA	GR	H417
5942	ROCCALUMERA	ME	H418
5943	ROCCAMANDOLFI	IS	H420
5944	ROCCA MASSIMA	LT	H421
5945	ROCCAMENA	PA	H422
5946	ROCCAMONFINA	CE	H423
5947	ROCCAMONTEPIANO	CH	H424
5948	ROCCAMORICE	PE	H425
5949	ROCCANOVA	PZ	H426
5950	ROCCANTICA	RI	H427
5951	ROCCAPALUMBA	PA	H428
5952	ROCCA PIA	AQ	H429
5953	ROCCAPIEMONTE	SA	H431
5954	ROCCA PRIORA	RM	H432
5955	ROCCARAINOLA	NA	H433
5956	ROCCARASO	AQ	H434
5957	ROCCAROMANA	CE	H436
5958	ROCCA SAN CASCIANO	FC	H437
5959	ROCCA SAN FELICE	AV	H438
5960	ROCCA SAN GIOVANNI	CH	H439
5961	ROCCA SANTA MARIA	TE	H440
5962	ROCCA SANTO STEFANO	RM	H441
5963	ROCCASCALEGNA	CH	H442
5964	ROCCASECCA	FR	H443
5965	ROCCASECCA DEI VOLSCI	LT	H444
5966	ROCCASICURA	IS	H445
5967	ROCCA SINIBALDA	RI	H446
5968	ROCCASPARVERA	CN	H447
5969	ROCCASPINALVETI	CH	H448
5970	ROCCASTRADA	GR	H449
5971	ROCCA SUSELLA	PV	H450
5972	ROCCAVERANO	AT	H451
5973	ROCCAVIGNALE	SV	H452
5974	ROCCAVIONE	CN	H453
5975	ROCCAVIVARA	CB	H454
5976	ROCCELLA VALDEMONE	ME	H455
5977	ROCCELLA IONICA	RC	H456
5978	ROCCHETTA A VOLTURNO	IS	H458
5979	ROCCHETTA E CROCE	CE	H459
5980	ROCCHETTA NERVINA	IM	H460
5981	ROCCHETTA DI VARA	SP	H461
5982	ROCCHETTA BELBO	CN	H462
5983	ROCCHETTA LIGURE	AL	H465
5984	ROCCHETTA PALAFEA	AT	H466
5985	ROCCHETTA SANT'ANTONIO	FG	H467
5986	ROCCHETTA TANARO	AT	H468
5987	RODANO	MI	H470
5988	RODDI	CN	H472
5989	RODDINO	CN	H473
5990	RODELLO	CN	H474
5991	RODENGO * RODENECK	BZ	H475
5992	RODENGO-SAIANO	BS	H477
5993	RODERO	CO	H478
5994	RODI' MILICI	ME	H479
5995	RODI GARGANICO	FG	H480
5996	RODIGO	MN	H481
5997	ROE' VOLCIANO	BS	H484
5998	ROFRANO	SA	H485
5999	ROGENO	LC	H486
6000	ROGGIANO GRAVINA	CS	H488
6001	ROGHUDI	RC	H489
6002	ROGLIANO	CS	H490
6003	ROGNANO	PV	H491
6004	ROGNO	BG	H492
6005	ROGOLO	SO	H493
6006	ROIATE	RM	H494
6007	ROIO DEL SANGRO	CH	H495
6008	ROISAN	AO	H497
6009	ROLETTO	TO	H498
6010	ROLO	RE	H500
6011	ROMA	RM	H501
6012	ROMAGNANO SESIA	NO	H502
6013	ROMAGNANO AL MONTE	SA	H503
6014	ROMAGNESE	PV	H505
6015	ROMALLO	TN	H506
6016	ROMANA	SS	H507
6017	ROMANENGO	CR	H508
6018	ROMANO DI LOMBARDIA	BG	H509
6019	ROMANO CANAVESE	TO	H511
6020	ROMANO D'EZZELINO	VI	H512
6021	ROMANS D'ISONZO	GO	H514
6022	ROMBIOLO	VV	H516
6023	ROMENO	TN	H517
6024	ROMENTINO	NO	H518
6025	ROMETTA	ME	H519
6026	RONAGO	CO	H521
6027	RONCA'	VR	H522
6028	RONCADE	TV	H523
6029	RONCADELLE	BS	H525
6030	RONCARO	PV	H527
6031	RONCEGNO	TN	H528
6032	RONCELLO	MB	H529
6033	RONCHI DEI LEGIONARI	GO	H531
6034	RONCHI VALSUGANA	TN	H532
6035	RONCHIS	UD	H533
6036	RONCIGLIONE	VT	H534
6037	RONCOBELLO	BG	H535
6038	RONCO SCRIVIA	GE	H536
6039	RONCO BRIANTINO	MB	H537
6040	RONCO BIELLESE	BI	H538
6041	RONCO CANAVESE	TO	H539
6042	RONCO ALL'ADIGE	VR	H540
6043	RONCOFERRARO	MN	H541
6044	RONCOFREDDO	FC	H542
6045	RONCOLA	BG	H544
6046	RONCONE	TN	H545
6047	RONDANINA	GE	H546
6048	RONDISSONE	TO	H547
6049	RONSECCO	VC	H549
6050	RONZONE	TN	H552
6051	ROPPOLO	BI	H553
6052	RORA'	TO	H554
6053	ROURE	TO	H555
6054	ROSA'	VI	H556
6055	ROSARNO	RC	H558
6056	ROSASCO	PV	H559
6057	ROSATE	MI	H560
6058	ROSAZZA	BI	H561
6059	ROSCIANO	PE	H562
6060	ROSCIGNO	SA	H564
6061	ROSE	CS	H565
6062	ROSELLO	CH	H566
6063	ROSETO VALFORTORE	FG	H568
6064	ROSIGNANO MONFERRATO	AL	H569
6065	ROSIGNANO MARITTIMO	LI	H570
6066	ROSETO CAPO SPULICO	CS	H572
6067	ROSOLINA	RO	H573
6068	ROSOLINI	SR	H574
6069	ROSORA	AN	H575
6070	ROSSA	VC	H577
6071	ROSSANA	CN	H578
6072	ROSSANO	CS	H579
6073	ROSSANO VENETO	VI	H580
6074	ROSSIGLIONE	GE	H581
6075	ROSTA	TO	H583
6076	ROTA D'IMAGNA	BG	H584
6077	ROTA GRECA	CS	H585
6078	ROTELLA	AP	H588
6079	ROTELLO	CB	H589
6080	ROTONDA	PZ	H590
6081	ROTONDELLA	MT	H591
6082	ROTONDI	AV	H592
6083	ROTTOFRENO	PC	H593
6084	ROTZO	VI	H594
6085	ROVAGNATE	LC	H596
6086	ROVATO	BS	H598
6087	ROVEGNO	GE	H599
6088	ROVELLASCA	CO	H601
6089	ROVELLO PORRO	CO	H602
6090	ROVERBELLA	MN	H604
6091	ROVERCHIARA	VR	H606
6092	ROVERE' DELLA LUNA	TN	H607
6093	ROVERE' VERONESE	VR	H608
6094	ROVEREDO IN PIANO	PN	H609
6095	ROVEREDO DI GUA'	VR	H610
6096	ROVERETO	TN	H612
6097	ROVESCALA	PV	H614
6098	ROVETTA	BG	H615
6099	ROVIANO	RM	H618
6101	ROVIGO	RO	H620
6102	ROVITO	CS	H621
6103	ROVOLON	PD	H622
6104	ROZZANO	MI	H623
6106	RUBANO	PD	H625
6107	RUBIANA	TO	H627
6108	RUBIERA	RE	H628
6109	RUDA	UD	H629
6110	RUDIANO	BS	H630
6111	RUEGLIO	TO	H631
6112	RUFFANO	LE	H632
6113	RUFFIA	CN	H633
6114	RUFFRE'	TN	H634
6115	RUFINA	FI	H635
6116	RUINO	PV	H637
6117	RUMO	TN	H639
6118	RUOTI	PZ	H641
6119	RUSSI	RA	H642
6120	RUTIGLIANO	BA	H643
6121	RUTINO	SA	H644
6122	RUVO DI PUGLIA	BA	H645
6123	RUVO DEL MONTE	PZ	H646
6124	SABAUDIA	LT	H647
6125	SABBIA	VC	H648
6126	SABBIO CHIESE	BS	H650
6127	SABBIONETA	MN	H652
6128	SACCO	SA	H654
6129	SACCOLONGO	PD	H655
6130	SACILE	PN	H657
6131	SACROFANO	RM	H658
6132	SADALI	NU	H659
6133	SAGAMA	NU	H661
6134	SAGLIANO MICCA	BI	H662
6135	SAGRADO	GO	H665
6136	SAGRON MIS	TN	H666
6137	SAINT-CHRISTOPHE	AO	H669
6138	SAINT-DENIS	AO	H670
6139	SAINT-MARCEL	AO	H671
6140	SAINT-NICOLAS	AO	H672
6141	SAINT-OYEN	AO	H673
6142	SAINT-PIERRE	AO	H674
6143	SAINT-RHEMY-EN-BOSSES	AO	H675
6144	SAINT-VINCENT	AO	H676
6145	SALA MONFERRATO	AL	H677
6146	SALA BOLOGNESE	BO	H678
6147	SALA COMACINA	CO	H679
6148	SALA BIELLESE	BI	H681
6149	SALA BAGANZA	PR	H682
6150	SALA CONSILINA	SA	H683
6151	SALBERTRAND	TO	H684
6152	SALENTO	SA	H686
6153	SALANDRA	MT	H687
6154	SALAPARUTA	TP	H688
6155	SALARA	RO	H689
6156	SALASCO	VC	H690
6157	SALASSA	TO	H691
6158	SALCITO	CB	H693
6159	SALE	AL	H694
6160	SALE DELLE LANGHE	CN	H695
6161	SALE MARASINO	BS	H699
6162	SALEMI	TP	H700
6163	SALERANO SUL LAMBRO	LO	H701
6164	SALERANO CANAVESE	TO	H702
6165	SALERNO	SA	H703
6166	SALE SAN GIOVANNI	CN	H704
6167	SALETTO	PD	H705
6168	SALGAREDA	TV	H706
6169	SALI VERCELLESE	VC	H707
6170	SALICE SALENTINO	LE	H708
6171	SALICETO	CN	H710
6172	SAN MAURO DI SALINE	VR	H712
6173	SALISANO	RI	H713
6174	SALIZZOLE	VR	H714
6175	SALLE	PE	H715
6176	SALMOUR	CN	H716
6177	SALO'	BS	H717
6178	SALONA D'ISONZO	GO	H718
6179	SALORNO * SALURN	BZ	H719
6180	SALSOMAGGIORE TERME	PR	H720
6181	SALTARA	PU	H721
6182	SALTRIO	VA	H723
6183	SALUDECIO	RN	H724
6184	SALUGGIA	VC	H725
6185	SALUSSOLA	BI	H726
6186	SALUZZO	CN	H727
6187	SALVE	LE	H729
6188	SAVOIA DI LUCANIA	PZ	H730
6189	SALVIROLA	CR	H731
6190	SALVITELLE	SA	H732
6191	SALZA IRPINA	AV	H733
6192	SALZA DI PINEROLO	TO	H734
6193	SALZANO	VE	H735
6194	SAMARATE	VA	H736
6195	SAMASSI	VS	H738
6196	SAMATZAI	CA	H739
6197	SAMBASSO	GO	H740
6198	SAMBUCA DI SICILIA	AG	H743
6199	SAMBUCA PISTOIESE	PT	H744
6200	SAMBUCI	RM	H745
6201	SAMBUCO	CN	H746
6202	SAMMICHELE DI BARI	BA	H749
6203	SAMOLACO	SO	H752
6204	SAMONE	TO	H753
6205	SAMONE	TN	H754
6206	SAMPEYRE	CN	H755
6207	SAMUGHEO	OR	H756
6208	SANARICA	LE	H757
6209	SAN BARTOLOMEO VAL CAVARGNA	CO	H760
6210	SAN BARTOLOMEO AL MARE	IM	H763
6211	SAN BARTOLOMEO IN GALDO	BN	H764
6212	SAN BASILE	CS	H765
6213	SAN BASILIO	CA	H766
6214	SAN BASSANO	CR	H767
6215	SAN BELLINO	RO	H768
6216	SAN BENEDETTO DEL TRONTO	AP	H769
6217	SAN BENEDETTO BELBO	CN	H770
6218	SAN BENEDETTO PO	MN	H771
6219	SAN BENEDETTO DEI MARSI	AQ	H772
6220	SAN BENEDETTO IN PERILLIS	AQ	H773
6221	SAN BENEDETTO ULLANO	CS	H774
6222	SAN BENIGNO CANAVESE	TO	H775
6223	SAN BERNARDINO VERBANO	VB	H777
6224	SAN BIAGIO PLATANI	AG	H778
6225	SAN BIAGIO SARACINISCO	FR	H779
6226	SAN BIAGIO DELLA CIMA	IM	H780
6227	SAN BIAGIO DI CALLALTA	TV	H781
6228	SAN BIASE	CB	H782
6229	SAN BONIFACIO	VR	H783
6230	SAN BUONO	CH	H784
6231	SAN CALOGERO	VV	H785
6232	SAN CANDIDO * INNICHEN	BZ	H786
6233	SAN CANZIAN D'ISONZO	GO	H787
6234	SAN CARLO CANAVESE	TO	H789
6235	SAN CASCIANO DEI BAGNI	SI	H790
6236	SAN CASCIANO IN VAL DI PESA	FI	H791
6237	SAN CATALDO	CL	H792
6238	SAN CESARIO DI LECCE	LE	H793
6239	SAN CESARIO SUL PANARO	MO	H794
6240	SAN CHIRICO NUOVO	PZ	H795
6241	SAN CHIRICO RAPARO	PZ	H796
6242	SAN CIPIRELLO	PA	H797
6243	SAN CIPRIANO D'AVERSA	CE	H798
6244	SAN CIPRIANO PO	PV	H799
6245	SAN CIPRIANO PICENTINO	SA	H800
6246	SAN CLEMENTE	RN	H801
6247	SAN COLOMBANO CERTENOLI	GE	H802
6248	SAN COLOMBANO AL LAMBRO	MI	H803
6249	SAN COLOMBANO BELMONTE	TO	H804
6250	SAN CONO	CT	H805
6251	SAN COSMO ALBANESE	CS	H806
6252	SAN COSTANTINO CALABRO	VV	H807
6253	SAN COSTANTINO ALBANESE	PZ	H808
6254	SAN COSTANZO	PU	H809
6255	SAN CRISTOFORO	AL	H810
6256	SAN DAMIANO D'ASTI	AT	H811
6257	SAN DAMIANO MACRA	CN	H812
6258	SAN DAMIANO AL COLLE	PV	H814
6259	SAN DANIELE PO	CR	H815
6260	SAN DANIELE DEL FRIULI	UD	H816
6261	SAN DANIELE DEL CARSO	GO	H817
6262	SAN DEMETRIO CORONE	CS	H818
6263	SAN DEMETRIO NE' VESTINI	AQ	H819
6264	SAN DIDERO	TO	H820
6265	SANDIGLIANO	BI	H821
6266	SAN DONACI	BR	H822
6267	SAN DONA' DI PIAVE	VE	H823
6268	SAN DONATO VAL DI COMINO	FR	H824
6269	SAN DONATO DI NINEA	CS	H825
6270	SAN DONATO DI LECCE	LE	H826
6271	SAN DONATO MILANESE	MI	H827
6272	SANDRIGO	VI	H829
6273	SAN FEDELE INTELVI	CO	H830
6274	SAN FELE	PZ	H831
6275	SAN FELICE DEL MOLISE	CB	H833
6276	SAN FELICE A CANCELLO	CE	H834
6277	SAN FELICE SUL PANARO	MO	H835
6278	SAN FELICE CIRCEO	LT	H836
6279	SAN FELICE DEL BENACO	BS	H838
6280	SAN FERDINANDO DI PUGLIA	BT	H839
6281	SAN FERMO DELLA BATTAGLIA	CO	H840
6282	SAN FILI	CS	H841
6283	SAN FILIPPO DEL MELA	ME	H842
6284	SAN FIOR	TV	H843
6285	SAN FIORANO	LO	H844
6286	SAN FLORIANO DEL COLLIO	GO	H845
6287	SAN FLORO	CZ	H846
6288	SAN FRANCESCO AL CAMPO	TO	H847
6289	AGLIENTU	OT	H848
6290	SAN FRATELLO	ME	H850
6291	SANFRE'	CN	H851
6292	SANFRONT	CN	H852
6293	SANGANO	TO	H855
6294	SAN GAVINO MONREALE	VS	H856
6295	SAN GEMINI	TR	H857
6296	SAN GENESIO ATESINO * JENESIEN	BZ	H858
6297	SAN GENESIO ED UNITI	PV	H859
6298	SAN GENNARO VESUVIANO	NA	H860
6299	SAN GERMANO VERCELLESE	VC	H861
6300	SAN GERMANO CHISONE	TO	H862
6301	SAN GERMANO DEI BERICI	VI	H863
6302	SAN GERVASIO BRESCIANO	BS	H865
6303	SAN GIACOMO DEGLI SCHIAVONI	CB	H867
6304	SAN GIACOMO FILIPPO	SO	H868
6305	SAN GIACOMO DELLE SEGNATE	MN	H870
6306	SAN GIACOMO IN COLLE	TS	H871
6307	SANGIANO	VA	H872
6308	SAN GILLIO	TO	H873
6309	SAN GIMIGNANO	SI	H875
6310	SAN GINESIO	MC	H876
6311	SANGINETO	CS	H877
6312	SAN GIORGIO MONFERRATO	AL	H878
6313	SAN GIORGIO A LIRI	FR	H880
6314	SAN GIORGIO ALBANESE	CS	H881
6315	SAN GIORGIO IONICO	TA	H882
6316	SAN GIORGIO DI MANTOVA	MN	H883
6317	SAN GIORGIO SU LEGNANO	MI	H884
6318	SAN GIORGIO DI LOMELLINA	PV	H885
6319	SAN GIORGIO DI PESARO	PU	H886
6320	SAN GIORGIO PIACENTINO	PC	H887
6321	SAN GIORGIO LUCANO	MT	H888
6322	SAN GIORGIO MORGETO	RC	H889
6323	SAN GIORGIO CANAVESE	TO	H890
6324	SAN GIORGIO DELLA RICHINVELDA	PN	H891
6325	SAN GIORGIO A CREMANO	NA	H892
6326	SAN GIORGIO DELLE PERTICHE	PD	H893
6327	SAN GIORGIO DEL SANNIO	BN	H894
6328	SAN GIORGIO DI NOGARO	UD	H895
6329	SAN GIORGIO DI PIANO	BO	H896
6330	SAN GIORGIO IN BOSCO	PD	H897
6331	SAN GIORGIO LA MOLARA	BN	H898
6332	SAN GIORGIO SCARAMPI	AT	H899
6333	SAN GIORIO DI SUSA	TO	H900
6334	SAN GIOVANNI VALDARNO	AR	H901
6335	SAN GIOVANNI DI GERACE	RC	H903
6336	SAN GIOVANNI AL NATISONE	UD	H906
6337	SAN GIOVANNI A PIRO	SA	H907
6338	SAN GIOVANNI BIANCO	BG	H910
6339	SAN GIOVANNI D'ASSO	SI	H911
6340	SAN GIOVANNI DEL DOSSO	MN	H912
6341	VILLA SAN GIOVANNI IN TUSCIA	VT	H913
6342	SAN GIOVANNI GEMINI	AG	H914
6343	SAN GIOVANNI ILARIONE	VR	H916
6344	SAN GIOVANNI INCARICO	FR	H917
6345	SAN GIOVANNI IN CROCE	CR	H918
6346	SAN GIOVANNI IN FIORE	CS	H919
6347	SAN GIOVANNI IN GALDO	CB	H920
6348	SAN GIOVANNI IN MARIGNANO	RN	H921
6349	SAN GIOVANNI LA PUNTA	CT	H922
6350	SAN GIOVANNI LIPIONI	CH	H923
6351	SAN GIOVANNI LUPATOTO	VR	H924
6352	SAN GIOVANNI ROTONDO	FG	H926
6353	SAN GIULIANO DEL SANNIO	CB	H928
6354	SAN GIULIANO DI PUGLIA	CB	H929
6355	SAN GIULIANO MILANESE	MI	H930
6356	SAN GIUSEPPE VESUVIANO	NA	H931
6357	SAN GIUSEPPE JATO	PA	H933
6358	SAN GIUSTINO	PG	H935
6359	SAN GIUSTO CANAVESE	TO	H936
6360	SAN GODENZO	FI	H937
6361	SAN GREGORIO NELLE ALPI	BL	H938
6362	SAN GREGORIO MATESE	CE	H939
6363	SAN GREGORIO DI CATANIA	CT	H940
6364	SAN GREGORIO D'IPPONA	VV	H941
6365	SAN GREGORIO DA SASSOLA	RM	H942
6366	SAN GREGORIO MAGNO	SA	H943
6367	SANGUINETTO	VR	H944
6368	SAN LAZZARO DI SAVENA	BO	H945
6369	SAN LEO	RN	H949
6370	SAN LEONARDO	UD	H951
6371	SAN LEONARDO IN PASSIRIA * SANKT LEONHARD IN PASSEIER	BZ	H952
6372	SAN LEUCIO DEL SANNIO	BN	H953
6373	SAN LORENZELLO	BN	H955
6374	SAN LORENZO DI SEBATO * SANKT LORENZEN	BZ	H956
6375	SAN LORENZO AL MARE	IM	H957
6376	SAN LORENZO IN CAMPO	PU	H958
6377	SAN LORENZO	RC	H959
6378	SAN LORENZO BELLIZZI	CS	H961
6379	SAN LORENZO DEL VALLO	CS	H962
6380	SAN LORENZO ISONTINO	GO	H964
6381	SAN LORENZO IN BANALE	TN	H966
6382	SAN LORENZO MAGGIORE	BN	H967
6383	SAN LORENZO NUOVO	VT	H969
6384	SAN LUCA	RC	H970
6385	SAN LUCIDO	CS	H971
6386	SAN LUPO	BN	H973
6387	SANLURI	VS	H974
6388	SAN MANGO SUL CALORE	AV	H975
6389	SAN MANGO D'AQUINO	CZ	H976
6390	SAN MANGO PIEMONTE	SA	H977
6391	SAN MARCELLINO	CE	H978
6392	SAN MARCELLO	AN	H979
6393	SAN MARCELLO PISTOIESE	PT	H980
6394	SAN MARCO ARGENTANO	CS	H981
6395	SAN MARCO D'ALUNZIO	ME	H982
6396	SAN MARCO DEI CAVOTI	BN	H984
6397	SAN MARCO IN LAMIS	FG	H985
6398	SAN MARCO LA CATOLA	FG	H986
6399	SAN MARTINO ALFIERI	AT	H987
6400	SAN MARTINO IN BADIA * SANKT MARTIN IN THURN	BZ	H988
6401	SAN MARTINO IN PASSIRIA * SANKT MARTIN IN PASSEIER	BZ	H989
6402	SAN MARTINO IN PENSILIS	CB	H990
6403	SAN MARTINO SULLA MARRUCINA	CH	H991
6404	SAN MARTINO DI FINITA	CS	H992
6405	SAN MARTINO D'AGRI	PZ	H994
6406	SAN MARTINO DI VENEZZE	RO	H996
6407	SAN MARTINO CANAVESE	TO	H997
6408	SAN MARTINO AL TAGLIAMENTO	PN	H999
6409	SAN MARTINO SANNITA	BN	I002
6410	SAN MARTINO BUON ALBERGO	VR	I003
6411	SAN MARTINO DALL'ARGINE	MN	I005
6412	SAN MARTINO DEL LAGO	CR	I007
6413	SAN MARTINO DI LUPARI	PD	I008
6414	SAN MARTINO IN RIO	RE	I011
6415	SAN MARTINO IN STRADA	LO	I012
6416	SAN MARTINO QUISCA	GO	I013
6417	SAN MARTINO SICCOMARIO	PV	I014
6418	SAN MARTINO VALLE CAUDINA	AV	I016
6419	SAN MARZANO OLIVETO	AT	I017
6420	SAN MARZANO DI SAN GIUSEPPE	TA	I018
6421	SAN MARZANO SUL SARNO	SA	I019
6422	SAN MASSIMO	CB	I023
6423	SAN MAURIZIO CANAVESE	TO	I024
6424	SAN MAURIZIO D'OPAGLIO	NO	I025
6425	SAN MAURO MARCHESATO	KR	I026
6426	SAN MAURO PASCOLI	FC	I027
6427	SAN MAURO CASTELVERDE	PA	I028
6428	SAN MAURO FORTE	MT	I029
6429	SAN MAURO TORINESE	TO	I030
6430	SAN MAURO CILENTO	SA	I031
6431	SAN MAURO LA BRUCA	SA	I032
6432	SAN MICHELE DI SERINO	AV	I034
6433	SAN MICHELE DI GANZARIA	CT	I035
6434	SAN MICHELE MONDOVI'	CN	I037
6435	SAN MICHELE AL TAGLIAMENTO	VE	I040
6436	SAN MICHELE ALL'ADIGE	TN	I042
6437	SAN MICHELE DI POSTUMIA	TS	I044
6438	SAN MICHELE SALENTINO	BR	I045
6439	SAN MINIATO	PI	I046
6440	SAN NAZARIO	VI	I047
6441	SANNAZZARO DE' BURGONDI	PV	I048
6442	SAN NAZZARO	BN	I049
6443	SAN NAZZARO VAL CAVARGNA	CO	I051
6444	SAN NAZZARO SESIA	NO	I052
6445	SANNICANDRO DI BARI	BA	I053
6446	SANNICANDRO GARGANICO	FG	I054
6447	SAN NICOLA LA STRADA	CE	I056
6448	SAN NICOLA DELL'ALTO	KR	I057
6449	SAN NICOLA DA CRISSA	VV	I058
6450	SANNICOLA	LE	I059
6451	SAN NICOLA ARCELLA	CS	I060
6452	SAN NICOLA BARONIA	AV	I061
6453	SAN NICOLA MANFREDI	BN	I062
6454	SAN NICOLO' DI COMELICO	BL	I063
6455	SAN PANCRAZIO * SANKT PANKRAZ	BZ	I065
6456	SAN PANCRAZIO SALENTINO	BR	I066
6457	SAN PAOLO DI JESI	AN	I071
6458	SAN PAOLO DI CIVITATE	FG	I072
6459	SAN PAOLO BEL SITO	NA	I073
6460	SAN PAOLO CERVO	BI	I074
6461	SAN PAOLO SOLBRITO	AT	I076
6462	SAN PELLEGRINO TERME	BG	I079
6463	SAN PIER D'ISONZO	GO	I082
6464	SAN PIER NICETO	ME	I084
6465	SAN PIERO A SIEVE	FI	I085
6466	SAN PIERO PATTI	ME	I086
6467	SAN PIETRO DI CADORE	BL	I088
6468	SAN PIETRO AL TANAGRO	SA	I089
6469	SAN PIETRO VAL LEMINA	TO	I090
6470	SAN PIETRO AL NATISONE	UD	I092
6471	SAN PIETRO A MAIDA	CZ	I093
6472	SAN PIETRO APOSTOLO	CZ	I095
6473	SAN PIETRO AVELLANA	IS	I096
6474	SAN PIETRO CLARENZA	CT	I098
6475	SAN PIETRO DEL CARSO	TS	I100
6476	SAN PIETRO DI CARIDA'	RC	I102
6477	SAN PIETRO DI FELETTO	TV	I103
6478	SAN PIETRO DI MORUBIO	VR	I105
6479	SAN PIETRO IN GU	PD	I107
6480	SAN PIETRO IN AMANTEA	CS	I108
6481	SAN PIETRO IN CARIANO	VR	I109
6482	SAN PIETRO IN CASALE	BO	I110
6483	SAN PIETRO INFINE	CE	I113
6484	SAN PIETRO IN GUARANO	CS	I114
6485	SAN PIETRO IN LAMA	LE	I115
6486	SAN PIETRO MOSEZZO	NO	I116
6487	SAN PIETRO MUSSOLINO	VI	I117
6488	VILLA SAN PIETRO	CA	I118
6489	SAN PIETRO VERNOTICO	BR	I119
6490	SAN PIETRO VIMINARIO	PD	I120
6491	SAN PIO DELLE CAMERE	AQ	I121
6492	SAN POLO MATESE	CB	I122
6493	SAN POLO D'ENZA	RE	I123
6494	SAN POLO DI PIAVE	TV	I124
6495	SAN POLO DEI CAVALIERI	RM	I125
6496	SAN PONSO	TO	I126
6497	SAN POSSIDONIO	MO	I128
6498	SAN POTITO ULTRA	AV	I129
6499	SAN POTITO SANNITICO	CE	I130
6500	SAN PRISCO	CE	I131
6501	SAN PROCOPIO	RC	I132
6502	SAN PROSPERO	MO	I133
6503	SAN QUIRICO D'ORCIA	SI	I135
6504	SAN QUIRINO	PN	I136
6505	SAN RAFFAELE CIMENA	TO	I137
6506	SAN REMO	IM	I138
6507	SAN ROBERTO	RC	I139
6508	SAN ROCCO AL PORTO	LO	I140
6509	SAN ROMANO IN GARFAGNANA	LU	I142
6510	SAN RUFO	SA	I143
6511	SAN SALVATORE MONFERRATO	AL	I144
6512	SAN SALVATORE TELESINO	BN	I145
6513	SAN SALVATORE DI FITALIA	ME	I147
6514	SAN SALVO	CH	I148
6515	SAN SEBASTIANO CURONE	AL	I150
6516	SAN SEBASTIANO AL VESUVIO	NA	I151
6517	SAN SEBASTIANO DA PO	TO	I152
6518	SAN SECONDO PARMENSE	PR	I153
6519	SAN SECONDO DI PINEROLO	TO	I154
6520	SANSEPOLCRO	AR	I155
6521	SAN SEVERINO MARCHE	MC	I156
6522	SAN SEVERINO LUCANO	PZ	I157
6523	SAN SEVERO	FG	I158
6524	SAN SIRO	CO	I162
6525	SAN SOSSIO BARONIA	AV	I163
6526	SAN SOSTENE	CZ	I164
6527	SAN SOSTI	CS	I165
6528	SAN SPERATE	CA	I166
6529	SANTA BRIGIDA	BG	I168
6530	SANTA CATERINA VILLARMOSA	CL	I169
6531	SANTA CATERINA DELLO IONIO	CZ	I170
6532	SANTA CATERINA ALBANESE	CS	I171
6533	SANTA CESAREA TERME	LE	I172
6534	SANTA CRISTINA VALGARDENA * SANKTA CHRISTINA IN GROEDEN	BZ	I173
6535	SANTA CRISTINA GELA	PA	I174
6536	SANTA CRISTINA E BISSONE	PV	I175
6537	SANTA CRISTINA D'ASPROMONTE	RC	I176
6538	SANTA CROCE SULL'ARNO	PI	I177
6539	SANTA CROCE CAMERINA	RG	I178
6540	SANTA CROCE DEL SANNIO	BN	I179
6541	SANTA CROCE DI AIDUSSINA	GO	I180
6542	SANTA CROCE DI MAGLIANO	CB	I181
6543	SANTADI	CI	I182
6544	SANTA DOMENICA TALAO	CS	I183
6545	SANTA DOMENICA VITTORIA	ME	I184
6546	SANTA ELISABETTA	AG	I185
6547	SANTA FIORA	GR	I187
6548	SANTA FLAVIA	PA	I188
6549	SANT'AGAPITO	IS	I189
6550	SANT'AGATA FOSSILI	AL	I190
6551	SANT'AGATA BOLOGNESE	BO	I191
6552	SANT'AGATA DI ESARO	CS	I192
6553	SANT'AGATA DI PUGLIA	FG	I193
6554	SANT'AGATA SUL SANTERNO	RA	I196
6555	SANT'AGATA DE' GOTI	BN	I197
6556	SANT'AGATA DEL BIANCO	RC	I198
6557	SANT'AGATA DI MILITELLO	ME	I199
6558	SANT'AGATA FELTRIA	RN	I201
6559	SANT'AGATA LI BATTIATI	CT	I202
6560	SANTA GIULETTA	PV	I203
6561	SANTA GIUSTA	OR	I205
6562	SANTA GIUSTINA	BL	I206
6563	SANTA GIUSTINA IN COLLE	PD	I207
6564	SANT'AGNELLO	NA	I208
6565	SANT'AGOSTINO	FE	I209
6566	SANT'ALBANO STURA	CN	I210
6567	SANT'ALESSIO CON VIALONE	PV	I213
6568	SANT'ALESSIO IN ASPROMONTE	RC	I214
6569	SANT'ALESSIO SICULO	ME	I215
6570	SANT'ALFIO	CT	I216
6571	SANTA LUCE	PI	I217
6572	SANTA LUCIA DI SERINO	AV	I219
6573	SANTA LUCIA DEL MELA	ME	I220
6574	SANTA LUCIA DI PIAVE	TV	I221
6575	SANTA LUCIA D'ISONZO	GO	I222
6576	SANTA MARGHERITA DI BELICE	AG	I224
6577	SANTA MARGHERITA LIGURE	GE	I225
6578	SANTA MARGHERITA D'ADIGE	PD	I226
6579	SANTA MARGHERITA DI STAFFORA	PV	I230
6580	SANTA MARIA A MONTE	PI	I232
6581	SANTA MARIA A VICO	CE	I233
6582	SANTA MARIA CAPUA VETERE	CE	I234
6583	TRAVACO' SICCOMARIO	PV	I236
6584	SANTA MARIA DELLA VERSA	PV	I237
6585	SANTA MARIA DEL MOLISE	IS	I238
6586	SANTA MARIA DI LICODIA	CT	I240
6587	SANTA MARIA DI SALA	VE	I242
6588	SANTA MARIA HOE'	LC	I243
6589	SANTA MARIA IMBARO	CH	I244
6590	SANTA MARIA LA FOSSA	CE	I247
6591	SANTA MARIA LA LONGA	UD	I248
6592	SANTA MARIA MAGGIORE	VB	I249
6593	SANTA MARIA NUOVA	AN	I251
6594	SANTA MARINA	SA	I253
6595	SANTA MARINA SALINA	ME	I254
6596	SANTA MARINELLA	RM	I255
6597	SANT'AMBROGIO SUL GARIGLIANO	FR	I256
6598	SANT'AMBROGIO DI TORINO	TO	I258
6599	SANT'AMBROGIO DI VALPOLICELLA	VR	I259
6600	SANTOMENNA	SA	I260
6601	SAN TAMMARO	CE	I261
6602	SANT'ANASTASIA	NA	I262
6603	SANT'ANATOLIA DI NARCO	PG	I263
6604	SANT'ANDREA DI CONZA	AV	I264
6605	SANT'ANDREA DEL GARIGLIANO	FR	I265
6606	SANT'ANDREA APOSTOLO DELLO IONIO	CZ	I266
6607	SANT'ANDREA FRIUS	CA	I271
6608	SANT'ANGELO D'ALIFE	CE	I273
6609	SANT'ANGELO LODIGIANO	LO	I274
6610	SANT'ANGELO DI PIOVE DI SACCO	PD	I275
6611	SANT'ANGELO LOMELLINA	PV	I276
6612	SANT'ANGELO A CUPOLO	BN	I277
6613	SANT'ANGELO A FASANELLA	SA	I278
6614	SANT'ANGELO ALL'ESCA	AV	I279
6615	SANT'ANGELO A SCALA	AV	I280
6616	SANT'ANGELO DEI LOMBARDI	AV	I281
6617	SANT'ANGELO DEL PESCO	IS	I282
6618	SANT'ANGELO DI BROLO	ME	I283
6619	SANT'ANGELO ROMANO	RM	I284
6620	SANT'ANGELO IN LIZZOLA	PU	I285
6621	SANT'ANGELO IN PONTANO	MC	I286
6622	SANT'ANGELO IN VADO	PU	I287
6623	SANT'ANGELO LE FRATTE	PZ	I288
6624	SANT'ANGELO LIMOSANO	CB	I289
6625	SANT'ANGELO MUXARO	AG	I290
6626	SANTA NINFA	TP	I291
6627	SANT'ANNA D'ALFAEDO	VR	I292
6628	SANT'ANTIMO	NA	I293
6629	SANT'ANTIOCO	CI	I294
6630	SANT'ANTONINO DI SUSA	TO	I296
6631	VILLA SANT'ANTONIO	OR	I298
6632	SANT'ANTONIO ABATE	NA	I300
6633	SANTA PAOLINA	AV	I301
6634	SANT'APOLLINARE	FR	I302
6635	SANTARCANGELO DI ROMAGNA	RN	I304
6636	SANT'ARCANGELO	PZ	I305
6637	SANT'ARPINO	CE	I306
6638	SANT'ARSENIO	SA	I307
6639	SANTA SEVERINA	KR	I308
6640	SANTA SOFIA D'EPIRO	CS	I309
6641	SANTA SOFIA	FC	I310
6642	SANTA TERESA DI RIVA	ME	I311
6643	SANTA TERESA GALLURA	OT	I312
6644	SANTA VENERINA	CT	I314
6645	SANTA VITTORIA IN MATENANO	FM	I315
6646	SANTA VITTORIA D'ALBA	CN	I316
6647	SANT'EGIDIO DEL MONTE ALBINO	SA	I317
6648	SANT'EGIDIO ALLA VIBRATA	TE	I318
6649	SANT'ELENA	PD	I319
6650	SANT'ELIA A PIANISI	CB	I320
6651	SANT'ELIA FIUMERAPIDO	FR	I321
6652	VALLEFIORITA	CZ	I322
6653	SANT'ELPIDIO A MARE	FM	I324
6654	SANTE MARIE	AQ	I326
6655	SANTENA	TO	I327
6656	SAN TEODORO	ME	I328
6657	SAN TEODORO	OT	I329
6658	SANTERAMO IN COLLE	BA	I330
6659	SANT'EUFEMIA A MAIELLA	PE	I332
6660	SANT'EUFEMIA D'ASPROMONTE	RC	I333
6661	SANT'EUSANIO DEL SANGRO	CH	I335
6662	SANT'EUSANIO FORCONESE	AQ	I336
6663	SANTHIA'	VC	I337
6664	SANTI COSMA E DAMIANO	LT	I339
6665	SANT'ILARIO DELLO IONIO	RC	I341
6666	SANT'ILARIO D'ENZA	RE	I342
6667	SANT'IPPOLITO	PU	I344
6668	ZOLDO ALTO	BL	I345
6669	SANT'OLCESE	GE	I346
6670	SAN TOMASO AGORDINO	BL	I347
6671	SANT'OMERO	TE	I348
6672	SANT'OMOBONO IMAGNA	BG	I349
6673	SANT'ONOFRIO	VV	I350
6674	SANTOPADRE	FR	I351
6675	SANT'ORESTE	RM	I352
6676	SANTORSO	VI	I353
6677	SANT'ORSOLA TERME	TN	I354
6678	SANTO STEFANO QUISQUINA	AG	I356
6679	SANTO STEFANO DEL SOLE	AV	I357
6680	SANTO STEFANO DI ROGLIANO	CS	I359
6681	SANTO STEFANO DI SESSANIO	AQ	I360
6682	SANTO STEFANO TICINO	MI	I361
6683	SANTO STEFANO LODIGIANO	LO	I362
6684	SANTO STEFANO DI MAGRA	SP	I363
6685	VILLA SANTO STEFANO	FR	I364
6686	SANTO STEFANO AL MARE	IM	I365
6687	SANTO STEFANO BELBO	CN	I367
6688	SANTO STEFANO D'AVETO	GE	I368
6689	SANTO STEFANO DI CAMASTRA	ME	I370
6690	SANTO STEFANO IN ASPROMONTE	RC	I371
6691	SANTO STEFANO ROERO	CN	I372
6692	SANTO STINO DI LIVENZA	VE	I373
6693	SANTU LUSSURGIU	OR	I374
6694	SANT'URBANO	PD	I375
6695	SAN VALENTINO IN ABRUZZO CITERIORE	PE	I376
6696	SAN VALENTINO TORIO	SA	I377
6697	SAN VENANZO	TR	I381
6698	SAN VENDEMIANO	TV	I382
6699	SAN VERO MILIS	OR	I384
6701	SAN VINCENZO LA COSTA	CS	I388
6702	SAN VINCENZO VALLE ROVETO	AQ	I389
6703	SAN VINCENZO	LI	I390
6704	SAN VITALIANO	NA	I391
6705	SAN VITO DI CADORE	BL	I392
6706	SAN VITO SULLO IONIO	CZ	I393
6707	SAN VITO CHIETINO	CH	I394
6708	SAN VITO DEI NORMANNI	BR	I396
6709	SAN VITO ROMANO	RM	I400
6710	SAN VITO DI LEGUZZANO	VI	I401
6711	SAN VITO	CA	I402
6712	SAN VITO AL TAGLIAMENTO	PN	I403
6713	SAN VITO AL TORRE	UD	I404
6714	SAN VITO DI FAGAGNA	UD	I405
6715	SAN VITO DI VIPACCO	GO	I406
6716	SAN VITO LO CAPO	TP	I407
6717	SAN VITTORE DEL LAZIO	FR	I408
6718	SAN VITTORE OLONA	MI	I409
6719	SANZA	SA	I410
6720	SANZENO	TN	I411
6721	SAN ZENO NAVIGLIO	BS	I412
6722	SAN ZENO DI MONTAGNA	VR	I414
6723	SAN ZENONE AL LAMBRO	MI	I415
6724	SAN ZENONE AL PO	PV	I416
6725	SAN ZENONE DEGLI EZZELINI	TV	I417
6726	SAONARA	PD	I418
6727	SAPONARA	ME	I420
6728	SAPPADA	BL	I421
6729	SAPRI	SA	I422
6730	SARACENA	CS	I423
6731	SARACINESCO	RM	I424
6732	SARCEDO	VI	I425
6733	SARCONI	PZ	I426
6734	SARDARA	VS	I428
6735	SARDIGLIANO	AL	I429
6736	SAREGO	VI	I430
6737	SARENTINO * SARNTAL	BZ	I431
6738	SAREZZANO	AL	I432
6739	SAREZZO	BS	I433
6740	SARMATO	PC	I434
6741	SARMEDE	TV	I435
6742	SARNANO	MC	I436
6743	SARNICO	BG	I437
6744	SARNO	SA	I438
6745	SARNONICO	TN	I439
6746	SARONNO	VA	I441
6747	SARRE	AO	I442
6748	SARROCH	CA	I443
6749	SARSINA	FC	I444
6750	SARTEANO	SI	I445
6751	SARTIRANA LOMELLINA	PV	I447
6752	SARULE	NU	I448
6753	SARZANA	SP	I449
6754	SASSANO	SA	I451
6755	SASSARI	SS	I452
6756	SASSELLO	SV	I453
6757	SASSETTA	LI	I454
6758	SASSINORO	BN	I455
6759	SASSO DI CASTALDA	PZ	I457
6760	SASSOCORVARO	PU	I459
6761	SASSOFELTRIO	PU	I460
6762	SASSOFERRATO	AN	I461
6763	SASSUOLO	MO	I462
6764	SATRIANO	CZ	I463
6765	SAURIS	UD	I464
6766	SAUZE DI CESANA	TO	I465
6767	SAUZE D'OULX	TO	I466
6768	SAVA	TA	I467
6769	SAVELLI	KR	I468
6770	SAVIANO	NA	I469
6771	SAVIGLIANO	CN	I470
6772	SAVIGNANO IRPINO	AV	I471
6773	SAVIGNANO SUL RUBICONE	FC	I472
6774	SAVIGNANO SUL PANARO	MO	I473
6775	SAVIGNO	BO	I474
6776	SAVIGNONE	GE	I475
6777	SAVIORE DELL'ADAMELLO	BS	I476
6778	SAVOCA	ME	I477
6779	SAVOGNA	UD	I478
6780	SAVOGNA D'ISONZO	GO	I479
6781	SAVONA	SV	I480
6782	SCAFA	PE	I482
6783	SCAFATI	SA	I483
6784	SCAGNELLO	CN	I484
6785	SCALA COELI	CS	I485
6786	SCALA	SA	I486
6787	SCALDASOLE	PV	I487
6788	SCALEA	CS	I489
6789	SCALENGHE	TO	I490
6790	SCALETTA ZANCLEA	ME	I492
6791	SCAMPITELLA	AV	I493
6792	SCANDALE	KR	I494
6793	SCANDIANO	RE	I496
6794	SCANDOLARA RAVARA	CR	I497
6795	SCANDOLARA RIPA D'OGLIO	CR	I498
6796	SCANDRIGLIA	RI	I499
6797	SCANNO	AQ	I501
6798	SCANO DI MONTIFERRO	OR	I503
6799	SCANSANO	GR	I504
6800	SCANZOROSCIATE	BG	I506
6801	SCAPOLI	IS	I507
6802	SCARLINO	GR	I510
6803	SCARMAGNO	TO	I511
6804	SCARNAFIGI	CN	I512
6805	SCARPERIA	FI	I514
6806	SCENA * SCHENNA	BZ	I519
6807	SCERNI	CH	I520
6808	SCHEGGIA E PASCELUPO	PG	I522
6809	SCHEGGINO	PG	I523
6810	SCHIAVI DI ABRUZZO	CH	I526
6811	SCHIAVON	VI	I527
6812	SCHIGNANO	CO	I529
6813	SCHILPARIO	BG	I530
6814	SCHIO	VI	I531
6815	SCHIVENOGLIA	MN	I532
6816	SCIACCA	AG	I533
6817	SCIARA	PA	I534
6818	SCICLI	RG	I535
6819	SCIDO	RC	I536
6820	SCILLA	RC	I537
6821	SCILLATO	PA	I538
6822	SCIOLZE	TO	I539
6823	SCISCIANO	NA	I540
6824	SCLAFANI BAGNI	PA	I541
6825	SCONTRONE	AQ	I543
6826	SCOPA	VC	I544
6827	SCOPELLO	VC	I545
6828	SCOPPITO	AQ	I546
6829	SCORDIA	CT	I548
6830	SCORRANO	LE	I549
6831	TORRIANA	RN	I550
6832	SCORZE'	VE	I551
6833	SCURCOLA MARSICANA	AQ	I553
6834	SCURELLE	TN	I554
6835	SCURZOLENGO	AT	I555
6836	SEBORGA	IM	I556
6837	SECINARO	AQ	I558
6838	SECLI'	LE	I559
6839	SECUGNAGO	LO	I561
6840	SEDEGLIANO	UD	I562
6841	SEDICO	BL	I563
6842	SEDILO	OR	I564
6843	SEDINI	SS	I565
6844	SEDRIANO	MI	I566
6845	SEDRINA	BG	I567
6846	SEFRO	MC	I569
6847	SEGARIU	VS	I570
6848	SEGGIANO	GR	I571
6849	SEGNI	RM	I573
6850	SEGONZANO	TN	I576
6851	SEGRATE	MI	I577
6852	SEGUSINO	TV	I578
6853	SELARGIUS	CA	I580
6854	SELCI	RI	I581
6855	SELEGAS	CA	I582
6856	SELLANO	PG	I585
6857	SELLERO	BS	I588
6858	SELLIA	CZ	I589
6859	SELLIA MARINA	CZ	I590
6860	SELVA DI VAL GARDENA * WOLKENSTEIN IN GROEDEN	BZ	I591
6861	SELVA DI CADORE	BL	I592
6862	SELVA DEI MOLINI * MUEHLWALD	BZ	I593
6863	SELVA DI PROGNO	VR	I594
6864	SELVAZZANO DENTRO	PD	I595
6865	SELVE MARCONE	BI	I596
6866	SELVINO	BG	I597
6867	SEMESTENE	SS	I598
6868	SEMIANA	PV	I599
6869	SEMINARA	RC	I600
6870	SEMPRONIANO	GR	I601
6871	SENAGO	MI	I602
6872	SENALE-SAN FELICE * UNSERE LIEBE FRAU IM WALDE-SANKT FELIX	BZ	I603
6873	SENALES * SCHNALS	BZ	I604
6874	SENEGHE	OR	I605
6875	SENERCHIA	AV	I606
6876	SENIGA	BS	I607
6877	SENIGALLIA	AN	I608
6878	SENIS	OR	I609
6879	SENISE	PZ	I610
6880	SENNA COMASCO	CO	I611
6881	SENNA LODIGIANA	LO	I612
6882	SENNARIOLO	OR	I613
6883	SENNORI	SS	I614
6884	SENORBI'	CA	I615
6885	SENOSECCHIA	TS	I616
6886	SEPINO	CB	I618
6887	SEPPIANA	VB	I619
6888	SEQUALS	PN	I621
6889	SERAVEZZA	LU	I622
6890	SERDIANA	CA	I624
6891	SEREGNO	MB	I625
6892	SEREN DEL GRAPPA	BL	I626
6893	SERGNANO	CR	I627
6894	SERIATE	BG	I628
6895	SERINA	BG	I629
6896	SERINO	AV	I630
6897	SERLE	BS	I631
6898	SERMIDE	MN	I632
6899	SIRMIONE	BS	I633
6900	SERMONETA	LT	I634
6901	SERNAGLIA DELLA BATTAGLIA	TV	I635
6902	SERNIO	SO	I636
6903	SEROLE	AT	I637
6904	SERRA SAN BRUNO	VV	I639
6905	SERRA RICCO'	GE	I640
6906	SERRACAPRIOLA	FG	I641
6907	SERRA D'AIELLO	CS	I642
6908	SERRA DE' CONTI	AN	I643
6909	SERRADIFALCO	CL	I644
6910	SERRALUNGA DI CREA	AL	I645
6911	SERRALUNGA D'ALBA	CN	I646
6912	SERRAMANNA	VS	I647
6913	SERRAMEZZANA	SA	I648
6914	SERRAMONACESCA	PE	I649
6915	SERRA PEDACE	CS	I650
6916	SERRAPETRONA	MC	I651
6917	SERRARA FONTANA	NA	I652
6918	SERRA SAN QUIRICO	AN	I653
6919	SERRA SANT'ABBONDIO	PU	I654
6920	SERRASTRETTA	CZ	I655
6921	SERRATA	RC	I656
6922	SERRAVALLE SCRIVIA	AL	I657
6923	SERRAVALLE LANGHE	CN	I659
6924	SERRAVALLE PISTOIESE	PT	I660
6925	SERRAVALLE DI CHIENTI	MC	I661
6926	SERRAVALLE A PO	MN	I662
6927	SERRAVALLE SESIA	VC	I663
6928	SERRE	SA	I666
6929	SERRENTI	VS	I667
6930	SERRI	NU	I668
6931	SERRONE	FR	I669
6932	SERRUNGARINA	PU	I670
6933	SERSALE	CZ	I671
6934	SOVRAMONTE	BL	I673
6935	SESANA	TS	I674
6936	SESSA AURUNCA	CE	I676
6937	SESSA CILENTO	SA	I677
6938	SESSAME	AT	I678
6939	SESSANO DEL MOLISE	IS	I679
6940	SESTINO	AR	I681
6941	SESTO CAMPANO	IS	I682
6942	SESTO ED UNITI	CR	I683
6943	SESTO FIORENTINO	FI	I684
6944	SESTO AL REGHENA	PN	I686
6945	SESTO * SEXTEN	BZ	I687
6946	SESTO CALENDE	VA	I688
6947	SESTOLA	MO	I689
6948	SESTO SAN GIOVANNI	MI	I690
6949	SESTRIERE	TO	I692
6950	SESTRI LEVANTE	GE	I693
6951	SESTU	CA	I695
6952	SETTALA	MI	I696
6953	SETTEFRATI	FR	I697
6954	SETTIME	AT	I698
6955	SETTIMO SAN PIETRO	CA	I699
6956	SETTIMO MILANESE	MI	I700
6957	SETTIMO ROTTARO	TO	I701
6958	SETTIMO VITTONE	TO	I702
6959	SETTIMO TORINESE	TO	I703
6960	SETTINGIANO	CZ	I704
6961	SETZU	VS	I705
6962	SEUI	OG	I706
6963	SEULO	NU	I707
6964	SEVESO	MB	I709
6965	SEZZADIO	AL	I711
6966	SEZZE	LT	I712
6967	SFRUZ	TN	I714
6968	SGONICO	TS	I715
6969	SGURGOLA	FR	I716
6970	SIAMAGGIORE	OR	I717
6971	SIAMANNA	OR	I718
6972	SIANO	SA	I720
6973	SIAPICCIA	OR	I721
6974	SICULIANA	AG	I723
6975	SIDDI	VS	I724
6976	SIDERNO	RC	I725
6977	SIENA	SI	I726
6978	SIGILLO	PG	I727
6979	SIGNA	FI	I728
6980	SILANDRO * SCHLANDERS	BZ	I729
6981	SILANUS	NU	I730
6982	SILIGO	SS	I732
6983	SILIQUA	CA	I734
6984	SILIUS	CA	I735
6985	SILLAVENGO	NO	I736
6986	SILLANO	LU	I737
6987	SILVANO D'ORBA	AL	I738
6988	SILVANO PIETRA	PV	I739
6989	SILVI	TE	I741
6990	SIMALA	OR	I742
6991	SIMAXIS	OR	I743
6992	SIMBARIO	VV	I744
6993	SIMERI CRICHI	CZ	I745
6994	SINAGRA	ME	I747
6995	SINDIA	NU	I748
6996	SINI	OR	I749
6997	SINIO	CN	I750
6998	SINISCOLA	NU	I751
6999	SINNAI	CA	I752
7000	SINOPOLI	RC	I753
7001	SIRACUSA	SR	I754
7002	SIRIGNANO	AV	I756
7003	SIRIS	OR	I757
7004	SIROLO	AN	I758
7005	SIRONE	LC	I759
7006	SIROR	TN	I760
7007	SIRTORI	LC	I761
7008	SISSA	PR	I763
7009	SIURGUS DONIGALA	CA	I765
7010	SIZZANO	NO	I767
7011	SLUDERNO * SCHLUDERNS	BZ	I771
7012	SMARANO	TN	I772
7013	SMERILLO	FM	I774
7014	SOAVE	VR	I775
7015	SOCCHIEVE	UD	I777
7016	SODDI'	OR	I778
7017	SOGLIANO AL RUBICONE	FC	I779
7018	SOGLIANO CAVOUR	LE	I780
7019	SOGLIO	AT	I781
7020	SOIANO DEL LAGO	BS	I782
7021	SOLAGNA	VI	I783
7022	SOLARINO	SR	I785
7023	SOLARO	MI	I786
7024	SOLAROLO	RA	I787
7025	SOLAROLO RAINERIO	CR	I790
7026	SOLARUSSA	OR	I791
7027	SOLBIATE	CO	I792
7028	SOLBIATE ARNO	VA	I793
7029	SOLBIATE OLONA	VA	I794
7030	SOLDANO	IM	I796
7031	SOLEMINIS	CA	I797
7032	SOLERO	AL	I798
7033	SOLESINO	PD	I799
7034	SOLETO	LE	I800
7035	SOLFERINO	MN	I801
7036	SOLIERA	MO	I802
7037	SOLIGNANO	PR	I803
7038	SULMONA	AQ	I804
7039	SOLOFRA	AV	I805
7040	SOLONGHELLO	AL	I808
7041	SOLOPACA	BN	I809
7042	SOLTO COLLINA	BG	I812
7043	SOLZA	BG	I813
7044	SOMAGLIA	LO	I815
7045	SOMANO	CN	I817
7046	SOMMA LOMBARDO	VA	I819
7047	SOMMA VESUVIANA	NA	I820
7048	SOMMACAMPAGNA	VR	I821
7049	SOMMARIVA DEL BOSCO	CN	I822
7050	SOMMARIVA PERNO	CN	I823
7051	SOMMATINO	CL	I824
7052	SOMMO	PV	I825
7053	SONA	VR	I826
7054	SONCINO	CR	I827
7055	SONDALO	SO	I828
7056	SONDRIO	SO	I829
7057	SONGAVAZZO	BG	I830
7058	SONICO	BS	I831
7059	SONNINO	LT	I832
7060	SONZIA	GO	I833
7061	SOPRANA	BI	I835
7062	SORA	FR	I838
7063	SORAGA	TN	I839
7064	SORAGNA	PR	I840
7065	SORANO	GR	I841
7066	SORBO SERPICO	AV	I843
7067	SORBO SAN BASILE	CZ	I844
7068	SORBOLO	PR	I845
7069	SORDEVOLO	BI	I847
7070	SORDIO	LO	I848
7071	SORESINA	CR	I849
7072	SORGA'	VR	I850
7073	SORGONO	NU	I851
7074	SORI	GE	I852
7075	SORIANELLO	VV	I853
7076	SORIANO CALABRO	VV	I854
7077	SORIANO NEL CIMINO	VT	I855
7078	SORICO	CO	I856
7079	SORISO	NO	I857
7080	SORISOLE	BG	I858
7081	SORMANO	CO	I860
7082	SORRADILE	OR	I861
7083	SORRENTO	NA	I862
7084	SORSO	SS	I863
7085	SORTINO	SR	I864
7086	SOSPIRO	CR	I865
7087	SOSPIROLO	BL	I866
7088	SOSSANO	VI	I867
7089	SOSTEGNO	BI	I868
7090	SOTTO IL MONTE GIOVANNI XXIII	BG	I869
7091	SOVER	TN	I871
7092	SOVERATO	CZ	I872
7093	SOVERE	BG	I873
7094	SOVERIA MANNELLI	CZ	I874
7095	SOVERIA SIMERI	CZ	I875
7096	SOVERZENE	BL	I876
7097	SOVICILLE	SI	I877
7098	SOVICO	MB	I878
7099	SOVIZZO	VI	I879
7100	SOZZAGO	NO	I880
7101	SPADAFORA	ME	I881
7102	SPADOLA	VV	I884
7103	SPARANISE	CE	I885
7104	SPARONE	TO	I886
7105	SPECCHIA	LE	I887
7106	SPELLO	PG	I888
7107	SPERA	TN	I889
7108	SPERLINGA	EN	I891
7109	SPERLONGA	LT	I892
7110	SPERONE	AV	I893
7111	SPESSA	PV	I894
7112	SPEZZANO ALBANESE	CS	I895
7113	SPEZZANO DELLA SILA	CS	I896
7114	SPEZZANO PICCOLO	CS	I898
7115	SPIAZZO	TN	I899
7116	SPIGNO MONFERRATO	AL	I901
7117	SPIGNO SATURNIA	LT	I902
7118	SPILAMBERTO	MO	I903
7119	SPILIMBERGO	PN	I904
7120	SPILINGA	VV	I905
7121	SPINADESCO	CR	I906
7122	SPINAZZOLA	BT	I907
7123	SPINEA	VE	I908
7124	SPINEDA	CR	I909
7125	SPINETE	CB	I910
7126	SPINETO SCRIVIA	AL	I911
7127	SPINETOLI	AP	I912
7128	SPINO D'ADDA	CR	I914
7129	SPINONE AL LAGO	BG	I916
7130	SPINOSO	PZ	I917
7131	SPIRANO	BG	I919
7132	SPOLETO	PG	I921
7133	SPOLTORE	PE	I922
7134	SPONGANO	LE	I923
7135	SPORMAGGIORE	TN	I924
7136	SPORMINORE	TN	I925
7137	SPOTORNO	SV	I926
7138	SPRESIANO	TV	I927
7139	SPRIANA	SO	I928
7140	SQUILLACE	CZ	I929
7141	SQUINZANO	LE	I930
7142	STAFFOLO	AN	I932
7143	STAGNO LOMBARDO	CR	I935
7144	STAITI	RC	I936
7145	STALETTI	CZ	I937
7146	STANGHELLA	PD	I938
7147	STARANZANO	GO	I939
7148	STAZZANO	AL	I941
7149	STAZZEMA	LU	I942
7150	STAZZONA	CO	I943
7151	STEFANACONI	VV	I945
7152	STELLA	SV	I946
7153	STELLANELLO	SV	I947
7154	STELVIO * STILFS	BZ	I948
7155	STENICO	TN	I949
7156	STERNATIA	LE	I950
7157	STEZZANO	BG	I951
7158	STIA	AR	I952
7159	STIENTA	RO	I953
7160	STIGLIANO	MT	I954
7161	STIGNANO	RC	I955
7162	STILO	RC	I956
7163	STIMIGLIANO	RI	I959
7164	STIO	SA	I960
7165	STORNARA	FG	I962
7166	STORNARELLA	FG	I963
7167	STORO	TN	I964
7168	STRA	VE	I965
7169	STRADELLA	PV	I968
7170	STRAMBINELLO	TO	I969
7171	STRAMBINO	TO	I970
7172	STRANGOLAGALLI	FR	I973
7173	STREGNA	UD	I974
7174	STREMBO	TN	I975
7175	STRESA	VB	I976
7176	STREVI	AL	I977
7177	STRIANO	NA	I978
7178	STRIGNO	TN	I979
7179	STRONA	BI	I980
7180	STRONCONE	TR	I981
7181	STRONGOLI	KR	I982
7182	STROPPIANA	VC	I984
7183	STROPPO	CN	I985
7184	STROZZA	BG	I986
7185	STURNO	AV	I990
7186	SUBBIANO	AR	I991
7187	SUBIACO	RM	I992
7188	SUCCIVO	CE	I993
7189	SUEGLIO	LC	I994
7190	SUELLI	CA	I995
7191	SUELLO	LC	I996
7192	SUISIO	BG	I997
7193	SULBIATE	MB	I998
7194	SULZANO	BS	L002
7195	SUMIRAGO	VA	L003
7196	SUMMONTE	AV	L004
7197	SUNI	NU	L006
7198	SUNO	NO	L007
7199	SUPERSANO	LE	L008
7200	SUPINO	FR	L009
7201	SURANO	LE	L010
7202	SURBO	LE	L011
7203	SUSA	TO	L013
7204	SUSEGANA	TV	L014
7205	SUSTINENTE	MN	L015
7206	SUTERA	CL	L016
7207	SUTRI	VT	L017
7208	SUTRIO	UD	L018
7209	SUVERETO	LI	L019
7210	SUZZARA	MN	L020
7211	TACENO	LC	L022
7212	TADASUNI	OR	L023
7213	TAGGIA	IM	L024
7214	TAGLIACOZZO	AQ	L025
7215	TAGLIO DI PO	RO	L026
7216	TAGLIOLO MONFERRATO	AL	L027
7217	TAIBON AGORDINO	BL	L030
7218	TAINO	VA	L032
7219	TAIO	TN	L033
7220	TALAMELLO	RN	L034
7221	TALAMONA	SO	L035
7222	TALANA	OG	L036
7223	TALEGGIO	BG	L037
7224	TALLA	AR	L038
7225	TALMASSONS	UD	L039
7226	TAMBRE	BL	L040
7227	TAORMINA	ME	L042
7228	TARANO	RI	L046
7229	TARANTA PELIGNA	CH	L047
7230	TARANTASCA	CN	L048
7231	TARANTO	TA	L049
7232	TARCENTO	UD	L050
7233	TARNOVA DELLA SELVA	GO	L053
7234	TARSIA	CS	L055
7235	TARTANO	SO	L056
7236	TARVISIO	UD	L057
7237	TARZO	TV	L058
7238	TASSAROLO	AL	L059
7239	TASSULLO	TN	L060
7240	TAURANO	AV	L061
7241	TAURASI	AV	L062
7242	TAURIANOVA	RC	L063
7243	TAURISANO	LE	L064
7244	TAVAGNACCO	UD	L065
7245	TAVAGNASCO	TO	L066
7246	TAVARNELLE VAL DI PESA	FI	L067
7247	TAVENNA	CB	L069
7248	TAVERNA	CZ	L070
7249	TAVERNERIO	CO	L071
7250	TAVERNOLA BERGAMASCA	BG	L073
7251	TAVIANO	LE	L074
7252	TAVIGLIANO	BI	L075
7253	TAVOLETO	PU	L078
7254	TAVULLIA	PU	L081
7255	TEANA	PZ	L082
7256	TEANO	CE	L083
7257	TEGLIO	SO	L084
7258	TEGLIO VENETO	VE	L085
7259	TELESE TERME	BN	L086
7260	TELGATE	BG	L087
7261	TELTI	OT	L088
7262	TELVE	TN	L089
7263	TELVE DI SOPRA	TN	L090
7264	TEMENIZZA	GO	L092
7265	TEMPIO PAUSANIA	OT	L093
7266	TEMU'	BS	L094
7267	TENDA	CN	L095
7268	TENNA	TN	L096
7269	TENNO	TN	L097
7270	TEOLO	PD	L100
7271	TEOR	UD	L101
7272	TEORA	AV	L102
7273	TERAMO	TE	L103
7274	TERDOBBIATE	NO	L104
7275	TERELLE	FR	L105
7276	TERENTO * TERENTEN	BZ	L106
7277	TERLAGO	TN	L107
7278	TERLANO * TERLAN	BZ	L108
7279	TERLIZZI	BA	L109
7280	TERMENO SULLA STRADA DEL VINO * TRAMIN AN DER WEINSTRASSE	BZ	L111
7281	TERMINI IMERESE	PA	L112
7282	TERMOLI	CB	L113
7283	TERNATE	VA	L115
7284	TERNENGO	BI	L116
7285	TERNI	TR	L117
7286	TERNO D'ISOLA	BG	L118
7287	TERRACINA	LT	L120
7288	TERRAGNOLO	TN	L121
7289	TERRALBA	OR	L122
7290	TERRANUOVA BRACCIOLINI	AR	L123
7291	TERRANOVA DA SIBARI	CS	L124
7292	TERRANOVA DEI PASSERINI	LO	L125
7293	TERRANOVA DI POLLINO	PZ	L126
7294	TERRANOVA SAPPO MINULIO	RC	L127
7295	TERRASINI	PA	L131
7296	TERRASSA PADOVANA	PD	L132
7297	TERRAVECCHIA	CS	L134
7298	TERRAZZO	VR	L136
7299	TERRES	TN	L137
7300	TERRICCIOLA	PI	L138
7301	TERRUGGIA	AL	L139
7302	TERTENIA	OG	L140
7303	TERZIGNO	NA	L142
7304	TERZO	AL	L143
7305	TERZO DI AQUILEIA	UD	L144
7306	TERZOLAS	TN	L145
7307	TERZORIO	IM	L146
7308	TESERO	TN	L147
7309	TESIMO * TISENS	BZ	L149
7310	TESSENNANO	VT	L150
7311	TESTICO	SV	L152
7312	TETI	NU	L153
7313	TEULADA	CA	L154
7314	TEVEROLA	CE	L155
7315	TEZZE SUL BRENTA	VI	L156
7316	THIENE	VI	L157
7317	THIESI	SS	L158
7318	TIANA	NU	L160
7319	TICENGO	CR	L164
7320	TICINETO	AL	L165
7321	TIGGIANO	LE	L166
7322	TIGLIETO	GE	L167
7323	TIGLIOLE	AT	L168
7324	TIGNALE	BS	L169
7325	TINNURA	NU	L172
7326	TIONE DEGLI ABRUZZI	AQ	L173
7327	TIONE DI TRENTO	TN	L174
7328	TIRANO	SO	L175
7329	TIRES * TIERS	BZ	L176
7330	TIRIOLO	CZ	L177
7331	TIROLO * TIROL	BZ	L178
7332	TISSI	SS	L180
7333	TITO	PZ	L181
7334	TIVOLI	RM	L182
7335	TIZZANO VAL PARMA	PR	L183
7336	TOANO	RE	L184
7337	TOCCO CAUDIO	BN	L185
7338	TOCCO DA CASAURIA	PE	L186
7339	TOCENO	VB	L187
7340	TODI	PG	L188
7341	TOFFIA	RI	L189
7342	TOIRANO	SV	L190
7343	TOLENTINO	MC	L191
7344	TOLFA	RM	L192
7345	TOLLEGNO	BI	L193
7346	TOLLO	CH	L194
7347	TOLMEZZO	UD	L195
7348	TOLMINO	GO	L196
7349	TOLVE	PZ	L197
7350	TOMADIO	TS	L198
7351	TOMBOLO	PD	L199
7352	TON	TN	L200
7353	TONADICO	TN	L201
7354	TONARA	NU	L202
7355	TONCO	AT	L203
7356	TONENGO	AT	L204
7357	TORA E PICCILLI	CE	L205
7358	TORANO CASTELLO	CS	L206
7359	TORANO NUOVO	TE	L207
7360	TORBOLE CASAGLIA	BS	L210
7361	TORCEGNO	TN	L211
7362	TORCHIARA	SA	L212
7363	TORCHIAROLO	BR	L213
7364	TORELLA DEI LOMBARDI	AV	L214
7365	TORELLA DEL SANNIO	CB	L215
7366	TORGIANO	PG	L216
7367	TORGNON	AO	L217
7368	TORINO DI SANGRO	CH	L218
7369	TORINO	TO	L219
7370	TORITTO	BA	L220
7371	TORLINO VIMERCATI	CR	L221
7372	TORNACO	NO	L223
7373	TORNARECCIO	CH	L224
7374	TORNATA	CR	L225
7375	TORNIMPARTE	AQ	L227
7376	TORNO	CO	L228
7377	TORNOLO	PR	L229
7378	TORO	CB	L230
7379	TORPE'	NU	L231
7380	TORRACA	SA	L233
7381	TORRALBA	SS	L235
7382	TORRAZZA COSTE	PV	L237
7383	TORRAZZA PIEMONTE	TO	L238
7384	TORRAZZO	BI	L239
7385	TORRE DI RUGGIERO	CZ	L240
7386	TORRE MONDOVI'	CN	L241
7387	TORRE CAJETANI	FR	L243
7388	TORRE DI SANTA MARIA	SO	L244
7389	TORRE ANNUNZIATA	NA	L245
7390	TORREANO	UD	L246
7391	TORRE CANAVESE	TO	L247
7392	TORREBELVICINO	VI	L248
7393	TORRE BERETTI E CASTELLARO	PV	L250
7394	TORRE BOLDONE	BG	L251
7395	TORRE BORMIDA	CN	L252
7396	TORREBRUNA	CH	L253
7397	TORRECUSO	BN	L254
7398	TORRE D'ARESE	PV	L256
7399	TORRE DE' BUSI	LC	L257
7400	TORRE DE' PICENARDI	CR	L258
7401	TORRE DEL GRECO	NA	L259
7402	TORRE DE' NEGRI	PV	L262
7403	TORRE DE' PASSERI	PE	L263
7404	TORRE DE' ROVERI	BG	L265
7405	TORRE DI MOSTO	VE	L267
7406	TORRE D'ISOLA	PV	L269
7407	TORREGLIA	PD	L270
7408	TORREGROTTA	ME	L271
7409	TORRE LE NOCELLE	AV	L272
7410	TORREMAGGIORE	FG	L273
7411	TORRE ORSAIA	SA	L274
7412	TORRE PALLAVICINA	BG	L276
7413	TORRE PELLICE	TO	L277
7414	TORRE SAN GIORGIO	CN	L278
7415	TORRE SAN PATRIZIO	FM	L279
7416	TORRE SANTA SUSANNA	BR	L280
7417	TORRESINA	CN	L281
7418	TORRETTA	PA	L282
7419	TORREVECCHIA TEATINA	CH	L284
7420	TORREVECCHIA PIA	PV	L285
7421	TORRI IN SABINA	RI	L286
7422	TORRI DEL BENACO	VR	L287
7423	TORRICE	FR	L290
7424	TORRICELLA PELIGNA	CH	L291
7425	TORRICELLA VERZATE	PV	L292
7426	TORRICELLA IN SABINA	RI	L293
7427	TORRICELLA	TA	L294
7428	TORRICELLA SICURA	TE	L295
7429	TORRICELLA DEL PIZZO	CR	L296
7430	TORRI DI QUARTESOLO	VI	L297
7431	TORRIGLIA	GE	L298
7432	TORRILE	PR	L299
7433	TORRIONI	AV	L301
7434	TORRITA TIBERINA	RM	L302
7435	TORRITA DI SIENA	SI	L303
7436	TORTONA	AL	L304
7437	TORTORA	CS	L305
7438	TORTORELLA	SA	L306
7439	TORTORETO	TE	L307
7440	TORTORICI	ME	L308
7441	TORVISCOSA	UD	L309
7442	TUSCANIA	VT	L310
7443	TOSCOLANO-MADERNO	BS	L312
7444	TOSSICIA	TE	L314
7445	TOVO SAN GIACOMO	SV	L315
7446	TOVO DI SANT'AGATA	SO	L316
7447	TRABIA	PA	L317
7448	TRADATE	VA	L319
7449	TRAMATZA	OR	L321
7450	TRAMBILENO	TN	L322
7451	TRAMONTI	SA	L323
7452	TRAMONTI DI SOPRA	PN	L324
7453	TRAMONTI DI SOTTO	PN	L325
7454	TRAMUTOLA	PZ	L326
7455	TRANA	TO	L327
7456	TRANI	BT	L328
7457	TRANSACQUA	TN	L329
7458	TRAONA	SO	L330
7459	TRAPANI	TP	L331
7460	TRAPPETO	PA	L332
7461	TRAREGO VIGGIONA	VB	L333
7462	TRASACCO	AQ	L334
7463	TRASAGHIS	UD	L335
7464	TRASQUERA	VB	L336
7465	TRATALIAS	CI	L337
7466	TRAUSELLA	TO	L338
7467	TRAVAGLIATO	BS	L339
7468	TRAVES	TO	L340
7469	TRAVEDONA-MONATE	VA	L342
7470	TRAVERSELLA	TO	L345
7471	TRAVERSETOLO	PR	L346
7472	TRAVESIO	PN	L347
7473	TRAVO	PC	L348
7474	TREBASELEGHE	PD	L349
7475	TREBISACCE	CS	L353
7476	TRECASALI	PR	L354
7477	TRECASTAGNI	CT	L355
7478	TRECATE	NO	L356
7479	TRECCHINA	PZ	L357
7480	TRECENTA	RO	L359
7481	TREDOZIO	FC	L361
7482	TREGLIO	CH	L363
7483	TREGNAGO	VR	L364
7484	TREIA	MC	L366
7485	TREISO	CN	L367
7486	TREMENICO	LC	L368
7487	TREMESTIERI ETNEO	CT	L369
7488	TREMEZZO	CO	L371
7489	TREMOSINE	BS	L372
7490	TRENTA	CS	L375
7491	TRENTINARA	SA	L377
7492	TRENTO	TN	L378
7493	TRENTOLA DUCENTA	CE	L379
7494	TRENZANO	BS	L380
7495	TREPPO CARNICO	UD	L381
7496	TREPPO GRANDE	UD	L382
7497	TREPUZZI	LE	L383
7498	TREQUANDA	SI	L384
7499	TRES	TN	L385
7500	TRESANA	MS	L386
7501	TRESCORE BALNEARIO	BG	L388
7502	TRESCORE CREMASCO	CR	L389
7503	TRESIGALLO	FE	L390
7504	TRESIVIO	SO	L392
7505	TRESNURAGHES	OR	L393
7506	TREVENZUOLO	VR	L396
7507	TREVI	PG	L397
7508	TREVI NEL LAZIO	FR	L398
7509	TREVICO	AV	L399
7510	TREVIGLIO	BG	L400
7511	TREVIGNANO ROMANO	RM	L401
7512	TREVIGNANO	TV	L402
7513	TREVILLE	AL	L403
7514	TREVIOLO	BG	L404
7515	TREVISO BRESCIANO	BS	L406
7516	TREVISO	TV	L407
7517	TREZZANO ROSA	MI	L408
7518	TREZZANO SUL NAVIGLIO	MI	L409
7519	TREZZO TINELLA	CN	L410
7520	TREZZO SULL'ADDA	MI	L411
7521	TREZZONE	CO	L413
7522	TRIBANO	PD	L414
7523	TRIBIANO	MI	L415
7524	TRIBOGNA	GE	L416
7525	TRICARICO	MT	L418
7526	TRICASE	LE	L419
7527	TRICERRO	VC	L420
7528	TRICESIMO	UD	L421
7529	TRICHIANA	BL	L422
7530	TRIEI	OG	L423
7531	TRIESTE	TS	L424
7532	TRIGGIANO	BA	L425
7533	TRIGOLO	CR	L426
7534	TRINITA'	CN	L427
7535	TRINITA' D'AGULTU E VIGNOLA	OT	L428
7536	TRINO VERCELLESE	VC	L429
7537	TRIORA	IM	L430
7538	TRIPI	ME	L431
7539	TRISOBBIO	AL	L432
7540	TRISSINO	VI	L433
7541	TRIUGGIO	MB	L434
7542	TRIVENTO	CB	L435
7543	TRIVERO	BI	L436
7544	TRIVIGLIANO	FR	L437
7545	TRIVIGNANO UDINESE	UD	L438
7546	TRIVIGNO	PZ	L439
7547	TRIVOLZIO	PV	L440
7548	TRODENA NEL PARCO NATURALE  * TRUDEN IM NATURPARK	BZ	L444
7549	TROFARELLO	TO	L445
7550	TROIA	FG	L447
7551	TROINA	EN	L448
7552	TROMELLO	PV	L449
7553	TRONTANO	VB	L450
7554	TRONZANO VERCELLESE	VC	L451
7555	TROPEA	VV	L452
7556	TROVO	PV	L453
7557	TRUCCAZZANO	MI	L454
7558	TUBRE * TAUFERS	BZ	L455
7559	TUENNO	TN	L457
7560	TUFARA	CB	L458
7561	TUFILLO	CH	L459
7562	TUFINO	NA	L460
7563	TUFO	AV	L461
7564	TUGLIE	LE	L462
7565	TUILI	VS	L463
7566	TULA	SS	L464
7567	TUORO SUL TRASIMENO	PG	L466
7568	VALVESTINO	BS	L468
7569	TURANO LODIGIANO	LO	L469
7570	TURATE	CO	L470
7571	TURBIGO	MI	L471
7572	TURI	BA	L472
7573	TURRI	VS	L473
7574	TURRIACO	GO	L474
7575	TURRIVALIGNANI	PE	L475
7576	TURSI	MT	L477
7577	TUSA	ME	L478
7578	UBOLDO	VA	L480
7579	UCRIA	ME	L482
7580	UDINE	UD	L483
7581	UGENTO	LE	L484
7582	UGGIANO LA CHIESA	LE	L485
7583	UGGIATE-TREVANO	CO	L487
7584	ULA' TIRSO	OR	L488
7585	ULASSAI	OG	L489
7586	ULTIMO * ULTEN	BZ	L490
7588	UMBRIATICO	KR	L492
7589	URAGO D'OGLIO	BS	L494
7590	URAS	OR	L496
7591	URBANA	PD	L497
7592	URBANIA	PU	L498
7593	URBE	SV	L499
7594	URBINO	PU	L500
7595	URBISAGLIA	MC	L501
7596	URGNANO	BG	L502
7597	URI	SS	L503
7598	URURI	CB	L505
7599	URZULEI	OG	L506
7600	USCIO	GE	L507
7601	USELLUS	OR	L508
7602	USINI	SS	L509
7603	USMATE VELATE	MB	L511
7604	USSANA	CA	L512
7605	USSARAMANNA	VS	L513
7606	USSASSAI	OG	L514
7607	USSEAUX	TO	L515
7608	USSEGLIO	TO	L516
7609	USSITA	MC	L517
7610	USTICA	PA	L519
7611	UTA	CA	L521
7612	UZZANO	PT	L522
7613	VACCARIZZO ALBANESE	CS	L524
7614	VACONE	RI	L525
7615	VACRI	CH	L526
7616	VADENA * PFATTEN	BZ	L527
7617	VADO LIGURE	SV	L528
7618	VAGLIA	FI	L529
7619	VAGLIO SERRA	AT	L531
7620	VAGLIO BASILICATA	PZ	L532
7621	VAGLI SOTTO	LU	L533
7622	VAIANO CREMASCO	CR	L535
7623	VAIANO	PO	L537
7624	VAIE	TO	L538
7625	VAILATE	CR	L539
7626	VAIRANO PATENORA	CE	L540
7627	VALBONDIONE	BG	L544
7628	VALBREMBO	BG	L545
7629	VALBREVENNA	GE	L546
7630	VALBRONA	CO	L547
7631	VICO CANAVESE	TO	L548
7632	VALDA	TN	L550
7633	VALDAGNO	VI	L551
7634	VALDAORA * OLANG	BZ	L552
7636	VALDASTICO	VI	L554
7637	VAL DELLA TORRE	TO	L555
7638	VALDENGO	BI	L556
7639	VALDIDENTRO	SO	L557
7640	VALDIERI	CN	L558
7641	VALDINA	ME	L561
7642	VAL DI NIZZA	PV	L562
7643	VALDISOTTO	SO	L563
7644	VAL DI VIZZE * PFITSCH	BZ	L564
7645	VALDOBBIADENE	TV	L565
7646	VALDUGGIA	VC	L566
7647	VALEGGIO SUL MINCIO	VR	L567
7648	VALEGGIO	PV	L568
7649	VALENTANO	VT	L569
7650	VALENZA	AL	L570
7651	VALENZANO	BA	L571
7652	VALERA FRATTA	LO	L572
7653	VALFABBRICA	PG	L573
7654	VALFENERA	AT	L574
7655	VALFLORIANA	TN	L575
7656	VALFURVA	SO	L576
7657	VALGANNA	VA	L577
7658	VALGIOIE	TO	L578
7659	VALGOGLIO	BG	L579
7660	VALGRANA	CN	L580
7661	VALGREGHENTINO	LC	L581
7662	VALGRISENCHE	AO	L582
7663	VALGUARNERA CAROPEPE	EN	L583
7664	VALLADA AGORDINA	BL	L584
7665	VALLANZENGO	BI	L586
7666	VALLARSA	TN	L588
7667	VALLATA	AV	L589
7668	VALLE DI CADORE	BL	L590
7669	VALLE DI MADDALONI	CE	L591
7670	VALLE LOMELLINA	PV	L593
7671	VALLE AGRICOLA	CE	L594
7672	VALLE AURINA * AHRNTAL	BZ	L595
7673	VALLEBONA	IM	L596
7674	VALLE CASTELLANA	TE	L597
7675	VALLECORSA	FR	L598
7676	VALLECROSIA	IM	L599
7677	VALLE DI CASIES * GSIES	BZ	L601
7679	VALLEDOLMO	PA	L603
7680	VALLEDORIA	SS	L604
7681	VALLEMAIO	FR	L605
7682	VALLE MOSSO	BI	L606
7683	VALLELONGA	VV	L607
7684	VALLELUNGA PRATAMENO	CL	L609
7685	VALLEPIETRA	RM	L611
7686	VALLERANO	VT	L612
7687	VALLERMOSA	CA	L613
7688	VALLEROTONDA	FR	L614
7689	VALLESACCARDA	AV	L616
7690	VALLE SALIMBENE	PV	L617
7691	VALLE SAN NICOLAO	BI	L620
7692	VALLEVE	BG	L623
7693	VALLI DEL PASUBIO	VI	L624
7694	VALLINFREDA	RM	L625
7695	VALLIO TERME	BS	L626
7696	VALLO DI NERA	PG	L627
7697	VALLO DELLA LUCANIA	SA	L628
7698	VALLO TORINESE	TO	L629
7699	VALLORIATE	CN	L631
7700	VALMACCA	AL	L633
7701	VALMADRERA	LC	L634
7702	VALMALA	CN	L636
7703	VAL MASINO	SO	L638
7704	VALMONTONE	RM	L639
7705	VALMOREA	CO	L640
7706	VALMOZZOLA	PR	L641
7707	VALNEGRA	BG	L642
7708	VALPELLINE	AO	L643
7709	VALPERGA	TO	L644
7710	VALSAVARENCHE	AO	L647
7711	VALSECCA	BG	L649
7712	VALSTAGNA	VI	L650
7713	VALSTRONA	VB	L651
7714	VALTOPINA	PG	L653
7715	VALTOURNENCHE	AO	L654
7716	VALTORTA	BG	L655
7717	VALVA	SA	L656
7718	VALVASONE	PN	L657
7719	VALVERDE	CT	L658
7720	VALVERDE	PV	L659
7721	VANDOIES * VINTL	BZ	L660
7722	VANZAGHELLO	MI	L664
7723	VANZAGO	MI	L665
7724	VANZONE CON SAN CARLO	VB	L666
7725	VAPRIO D'ADDA	MI	L667
7726	VAPRIO D'AGOGNA	NO	L668
7727	VARALLO	VC	L669
7728	VARALLO POMBIA	NO	L670
7729	VARANO BORGHI	VA	L671
7730	VARANO DE' MELEGARI	PR	L672
7731	VARAPODIO	RC	L673
7732	VARAZZE	SV	L675
7733	VARCO SABINO	RI	L676
7734	VAREDO	MB	L677
7735	VARENA	TN	L678
7736	VARENNA	LC	L680
7737	VARESE LIGURE	SP	L681
7738	VARESE	VA	L682
7739	VARISELLA	TO	L685
7740	VARMO	UD	L686
7741	VARNA * VAHRN	BZ	L687
7742	VARSI	PR	L689
7743	VARZI	PV	L690
7744	VARZO	VB	L691
7745	VAS	BL	L692
7746	VASIA	IM	L693
7747	VASTOGIRARDI	IS	L696
7748	VATTARO	TN	L697
7749	VAUDA CANAVESE	TO	L698
7750	VAZZANO	VV	L699
7751	VAZZOLA	TV	L700
7752	VECCHIANO	PI	L702
7753	VEDANO OLONA	VA	L703
7754	VEDANO AL LAMBRO	MB	L704
7755	VEDDASCA	VA	L705
7756	VEDELAGO	TV	L706
7757	VEDESETA	BG	L707
7758	VEDUGGIO CON COLZANO	MB	L709
7759	VEGGIANO	PD	L710
7760	VEGLIE	LE	L711
7761	VEGLIO	BI	L712
7762	VEJANO	VT	L713
7763	VELESO	CO	L715
7764	VELEZZO LOMELLINA	PV	L716
7765	VELLETRI	RM	L719
7766	VELLEZZO BELLINI	PV	L720
7767	VELO VERONESE	VR	L722
7768	VELO D'ASTICO	VI	L723
7769	VELTURNO * FELDTHURNS	BZ	L724
7770	VENAFRO	IS	L725
7771	VENAUS	TO	L726
7772	VENARIA REALE	TO	L727
7773	VENAROTTA	AP	L728
7774	VENASCA	CN	L729
7775	VENDONE	SV	L730
7776	VENDROGNO	LC	L731
7777	VENEGONO INFERIORE	VA	L733
7778	VENEGONO SUPERIORE	VA	L734
7779	VENETICO	ME	L735
7780	VENEZIA	VE	L736
7781	VENIANO	CO	L737
7782	VENOSA	PZ	L738
7783	VENTICANO	AV	L739
7784	VENTIMIGLIA DI SICILIA	PA	L740
7785	VENTIMIGLIA	IM	L741
7786	VENTOTENE	LT	L742
7787	VENZONE	UD	L743
7788	VERANO BRIANZA	MB	L744
7789	VERANO * VOERAN	BZ	L745
7790	VERBANIA	VB	L746
7791	VERBICARO	CS	L747
7792	VERCANA	CO	L748
7793	VERCEIA	SO	L749
7794	VERCELLI	VC	L750
7795	VERCURAGO	LC	L751
7796	VERDELLINO	BG	L752
7797	VERDELLO	BG	L753
7798	VERDERIO INFERIORE	LC	L755
7799	VERDERIO SUPERIORE	LC	L756
7800	VERDUNO	CN	L758
7801	VERGATO	BO	L762
7802	VERGEMOLI	LU	L763
7803	VERGHERETO	FC	L764
7804	VERGIATE	VA	L765
7805	VERMEZZO	MI	L768
7806	VERMIGLIO	TN	L769
7807	VERNANTE	CN	L771
7808	VERNASCA	PC	L772
7809	VERNATE	MI	L773
7810	VERNAZZA	SP	L774
7811	VERNIO	PO	L775
7812	VERNOLE	LE	L776
7813	VEROLANUOVA	BS	L777
7814	VEROLAVECCHIA	BS	L778
7815	VEROLENGO	TO	L779
7816	VEROLI	FR	L780
7817	VERONA	VR	L781
7818	VERRAYES	AO	L783
7819	VERRETTO	PV	L784
7820	VERRONE	BI	L785
7821	VERRUA SAVOIA	TO	L787
7822	VERRUA PO	PV	L788
7823	VERTEMATE CON MINOPRIO	CO	L792
7825	VERTOVA	BG	L795
7826	VERUCCHIO	RN	L797
7827	VERUNO	NO	L798
7828	VERVIO	SO	L799
7829	VERVO'	TN	L800
7830	VERZEGNIS	UD	L801
7831	VERZINO	KR	L802
7832	VERZUOLO	CN	L804
7833	VESCOVANA	PD	L805
7834	VESCOVATO	CR	L806
7835	VESIME	AT	L807
7836	VESPOLATE	NO	L808
7837	VESSALICO	IM	L809
7838	VESTENANOVA	VR	L810
7839	VESTIGNE'	TO	L811
7840	VESTONE	BS	L812
7841	VESTRENO	LC	L813
7842	VETRALLA	VT	L814
7843	VETTO	RE	L815
7844	VEZZA D'OGLIO	BS	L816
7845	VEZZA D'ALBA	CN	L817
7846	VEZZANO LIGURE	SP	L819
7847	VEZZANO SUL CROSTOLO	RE	L820
7848	VEZZANO	TN	L821
7849	VEZZI PORTIO	SV	L823
7850	VIADANA	MN	L826
7851	VIADANICA	BG	L827
7852	VIAGRANDE	CT	L828
7853	VIALE D'ASTI	AT	L829
7854	VIALFRE'	TO	L830
7855	VIANO	RE	L831
7856	VIAREGGIO	LU	L833
7857	VIARIGI	AT	L834
7858	VIBONATI	SA	L835
7859	VICALVI	FR	L836
7860	VICARI	PA	L837
7861	VICCHIO	FI	L838
7862	VICENZA	VI	L840
7863	VICOFORTE	CN	L841
7864	VICO DEL GARGANO	FG	L842
7865	VICO NEL LAZIO	FR	L843
7866	VILLA LITERNO	CE	L844
7867	VICO EQUENSE	NA	L845
7868	VICOLI	PE	L846
7869	VICOLUNGO	NO	L847
7870	ZIANO PIACENTINO	PC	L848
7871	VICOPISANO	PI	L850
7872	VICOVARO	RM	L851
7873	VIDIGULFO	PV	L854
7874	VIDOR	TV	L856
7875	VIDRACCO	TO	L857
7876	VIESTE	FG	L858
7877	VIETRI DI POTENZA	PZ	L859
7878	VIETRI SUL MARE	SA	L860
7879	VIGANELLA	VB	L864
7880	VIGANO SAN MARTINO	BG	L865
7881	VIGANO'	LC	L866
7882	VIGARANO MAINARDA	FE	L868
7883	VIGASIO	VR	L869
7884	VIGEVANO	PV	L872
7885	VIGGIANELLO	PZ	L873
7886	VIGGIANO	PZ	L874
7887	VIGGIU'	VA	L876
7888	VIGHIZZOLO D'ESTE	PD	L878
7889	VIGLIANO D'ASTI	AT	L879
7890	VIGLIANO BIELLESE	BI	L880
7891	VIGNALE MONFERRATO	AL	L881
7892	VIGNANELLO	VT	L882
7893	VIGNATE	MI	L883
7894	VIGNOLA	MO	L885
7895	VIGNOLA FALESINA	TN	L886
7896	VIGNOLE BORBERA	AL	L887
7897	VIGNOLO	CN	L888
7898	VIGNONE	VB	L889
7899	VIGO DI CADORE	BL	L890
7900	VIGODARZERE	PD	L892
7901	VIGO DI FASSA	TN	L893
7902	VIGOLO	BG	L894
7903	VIGOLO VATTARO	TN	L896
7904	VIGOLZONE	PC	L897
7905	VIGONE	TO	L898
7906	VIGONOVO	VE	L899
7907	VIGONZA	PD	L900
7908	VIGO RENDENA	TN	L903
7909	VIGUZZOLO	AL	L904
7910	VILLA SANTA LUCIA	FR	L905
7911	VILLADOSSOLA	VB	L906
7912	VILLA DI CHIAVENNA	SO	L907
7913	VILLA DI TIRANO	SO	L908
7914	VILLA SANTINA	UD	L909
7915	VILLA AGNEDO	TN	L910
7916	VILLA BARTOLOMEA	VR	L912
7917	VILLA BASILICA	LU	L913
7918	VILLABASSA * NIEDERDORF	BZ	L915
7919	VILLABATE	PA	L916
7920	VILLA BISCOSSI	PV	L917
7921	VILLA CARCINA	BS	L919
7922	VILLA CASTELLI	BR	L920
7923	VILLA CELIERA	PE	L922
7924	VILLACHIARA	BS	L923
7925	VILLACIDRO	VS	L924
7926	VILLA COLLEMANDINA	LU	L926
7927	VILLA CORTESE	MI	L928
7928	VILLA D'ADDA	BG	L929
7929	VILLADEATI	AL	L931
7931	VILLA DEL BOSCO	BI	L933
7932	VILLA DEL CONTE	PD	L934
7934	VILLA DI SERIO	BG	L936
7935	VILLA ESTENSE	PD	L937
7936	VILLA D'OGNA	BG	L938
7937	VILLADOSE	RO	L939
7938	VILLAFALLETTO	CN	L942
7939	VILLA FARALDI	IM	L943
7940	VILLAFRANCA SICULA	AG	L944
7941	VILLAFRANCA D'ASTI	AT	L945
7942	VILLAFRANCA IN LUNIGIANA	MS	L946
7943	VILLAFRANCA PADOVANA	PD	L947
7944	VILLAFRANCA PIEMONTE	TO	L948
7945	VILLAFRANCA DI VERONA	VR	L949
7946	VILLAFRANCA TIRRENA	ME	L950
7947	VILLAFRATI	PA	L951
7948	VILLAGA	VI	L952
7949	VILLAGRANDE STRISAILI	OG	L953
7950	VILLA GUARDIA	CO	L956
7951	VILLA LAGARINA	TN	L957
7952	VILLALAGO	AQ	L958
7953	VILLALBA	CL	L959
7954	VILLALFONSINA	CH	L961
7955	VILLALVERNIA	AL	L963
7956	VILLAMAGNA	CH	L964
7957	VILLAMAINA	AV	L965
7958	VILLAMAR	VS	L966
7959	VILLAMARZANA	RO	L967
7960	VILLAMASSARGIA	CI	L968
7961	VILLA MINOZZO	RE	L969
7962	VILLAMIROGLIO	AL	L970
7963	VILLANDRO * VILLANDERS	BZ	L971
7964	VILLANOVA MONFERRATO	AL	L972
7965	VILLANOVA DEL BATTISTA	AV	L973
7966	VILLANOVA MONDOVI'	CN	L974
7967	VILLANOVA D'ALBENGA	SV	L975
7968	VILLANOVA DEL SILLARO	LO	L977
7969	VILLANOVA BIELLESE	BI	L978
7970	VILLANOVA DI CAMPOSAMPIERO	PD	L979
7971	VILLANOVA SULL'ARDA	PC	L980
7972	VILLENEUVE	AO	L981
7973	VILLANOVA CANAVESE	TO	L982
7974	VILLANOVA D'ARDENGHI	PV	L983
7975	VILLANOVA D'ASTI	AT	L984
7976	VILLANOVA DEL GHEBBO	RO	L985
7977	VILLANOVAFORRU	VS	L986
7978	VILLANOVAFRANCA	VS	L987
7979	VILLANOVA MARCHESANA	RO	L988
7980	VILLANOVA MONTELEONE	SS	L989
7981	VILLANOVA SOLARO	CN	L990
7982	VILLANOVA TRUSCHEDU	OR	L991
7983	VILLANOVATULO	NU	L992
7984	VILLANTERIO	PV	L994
7985	VILLANUOVA SUL CLISI	BS	L995
7986	VILLAPUTZU	CA	L998
7987	VILLAR DORA	TO	L999
7988	VILLARBASSE	TO	M002
7989	VILLARBOIT	VC	M003
7990	VILLAREGGIA	TO	M004
7991	VILLA RENDENA	TN	M006
7992	VILLAR FOCCHIARDO	TO	M007
7993	VILLAROMAGNANO	AL	M009
7994	VILLAROSA	EN	M011
7995	VILLAR PELLICE	TO	M013
7996	VILLAR PEROSA	TO	M014
7997	VILLAR SAN COSTANZO	CN	M015
7998	VILLASALTO	CA	M016
7999	VILLASANTA	MB	M017
8000	VILLA SAN GIOVANNI	RC	M018
8001	VILLA SAN SECONDO	AT	M019
8002	VILLA SANTA LUCIA DEGLI ABRUZZI	AQ	M021
8003	VILLA SANTA MARIA	CH	M022
8004	VILLA SANT'ANGELO	AQ	M023
8005	VILLA SLAVINA	TS	M024
8006	VILLASOR	CA	M025
8007	VILLASPECIOSA	CA	M026
8008	VILLASTELLONE	TO	M027
8009	VILLATA	VC	M028
8010	VILLAURBANA	OR	M030
8011	VILLAVALLELONGA	AQ	M031
8012	VILLAVERLA	VI	M032
8013	VILLA VICENTINA	UD	M034
8014	VILLETTA BARREA	AQ	M041
8015	VILLETTE	VB	M042
8016	VILLESSE	GO	M043
8017	VILLIMPENTA	MN	M044
8018	VILLONGO	BG	M045
8019	VILLORBA	TV	M048
8020	VILMINORE DI SCALVE	BG	M050
8021	VIMERCATE	MB	M052
8022	VIMODRONE	MI	M053
8023	VINADIO	CN	M055
8024	VINCHIATURO	CB	M057
8025	VINCHIO	AT	M058
8026	VINCI	FI	M059
8027	VINOVO	TO	M060
8028	VINZAGLIO	NO	M062
8029	VIOLA	CN	M063
8030	VIONE	BS	M065
8031	VIPACCO	GO	M066
8032	VIPITENO * STERZING	BZ	M067
8033	VIRLE PIEMONTE	TO	M069
8034	VISANO	BS	M070
8035	VISCHE	TO	M071
8036	VISCIANO	NA	M072
8037	VISCO	UD	M073
8040	VISONE	AL	M077
8041	VISSO	MC	M078
8042	VISTARINO	PV	M079
8043	VISTRORIO	TO	M080
8044	VITA	TP	M081
8045	VITERBO	VT	M082
8046	VITICUSO	FR	M083
8047	VITO D'ASIO	PN	M085
8048	VITORCHIANO	VT	M086
8049	VITTORIA	RG	M088
8050	VITTORIO VENETO	TV	M089
8051	VITTORITO	AQ	M090
8052	VITTUONE	MI	M091
8053	VITULAZIO	CE	M092
8054	VITULANO	BN	M093
8055	VIU'	TO	M094
8056	VIVARO ROMANO	RM	M095
8057	VIVARO	PN	M096
8058	VIVERONE	BI	M098
8059	VIZZINI	CT	M100
8060	VIZZOLA TICINO	VA	M101
8061	VIZZOLO PREDABISSI	MI	M102
8062	VO	PD	M103
8063	VOBARNO	BS	M104
8064	VOBBIA	GE	M105
8065	VOCCA	VC	M106
8066	VODO DI CADORE	BL	M108
8067	VOGHERA	PV	M109
8068	VOGHIERA	FE	M110
8069	VOGOGNA	VB	M111
8070	VOLANO	TN	M113
8071	VOLLA	NA	M115
8072	VOLONGO	CR	M116
8073	VOLPAGO DEL MONTELLO	TV	M118
8074	VOLPARA	PV	M119
8075	VOLPEDO	AL	M120
8076	VOLPEGLINO	AL	M121
8077	VOLPIANO	TO	M122
8078	VOLTAGGIO	AL	M123
8079	VOLTAGO AGORDINO	BL	M124
8080	VOLTA MANTOVANA	MN	M125
8081	VOLTERRA	PI	M126
8082	VOLTIDO	CR	M127
8083	VOLTURARA IRPINA	AV	M130
8084	VOLTURARA APPULA	FG	M131
8085	VOLTURINO	FG	M132
8086	VOLVERA	TO	M133
8087	VOTTIGNASCO	CN	M136
8088	ZACCANOPOLI	VV	M138
8089	ZAFFERANA ETNEA	CT	M139
8090	ZAGARISE	CZ	M140
8091	ZAGAROLO	RM	M141
8092	ZAMBANA	TN	M142
8093	ZAMBRONE	VV	M143
8094	ZANDOBBIO	BG	M144
8095	ZANE'	VI	M145
8096	ZANICA	BG	M147
8098	ZAVATTARELLO	PV	M150
8099	ZECCONE	PV	M152
8100	ZEDDIANI	OR	M153
8101	ZELBIO	CO	M156
8102	ZELO BUON PERSICO	LO	M158
8103	ZELO SURRIGONE	MI	M160
8104	ZEME	PV	M161
8105	ZENEVREDO	PV	M162
8106	ZENSON DI PIAVE	TV	M163
8107	ZERBA	PC	M165
8108	ZERBO	PV	M166
8109	ZERBOLO'	PV	M167
8110	ZERFALIU	OR	M168
8111	ZERI	MS	M169
8112	ZERMEGHEDO	VI	M170
8113	ZERO BRANCO	TV	M171
8114	ZEVIO	VR	M172
8115	ZIANO DI FIEMME	TN	M173
8116	ZIBELLO	PR	M174
8117	ZIBIDO SAN GIACOMO	MI	M176
8118	ZIGNAGO	SP	M177
8119	ZIMELLA	VR	M178
8120	ZIMONE	BI	M179
8121	ZINASCO	PV	M180
8122	ZOAGLI	GE	M182
8123	ZOCCA	MO	M183
8124	ZOGNO	BG	M184
8125	ZOLA PREDOSA	BO	M185
8126	ZOLLA	GO	M186
8127	ZOLLINO	LE	M187
8128	ZONE	BS	M188
8129	ZOPPE' DI CADORE	BL	M189
8130	ZOPPOLA	PN	M190
8131	ZOVENCEDO	VI	M194
8132	ZUBIENA	BI	M196
8133	ZUCCARELLO	SV	M197
8134	ZUCLO	TN	M198
8135	ZUGLIANO	VI	M199
8136	ZUGLIO	UD	M200
8137	ZUMAGLIA	BI	M201
8138	ZUMPANO	CS	M202
8139	ZUNGOLI	AV	M203
8140	ZUNGRI	VV	M204
8141	LARIANO	RM	M207
8142	LAMEZIA TERME	CZ	M208
8143	SANT'ANNA ARRESI	CI	M209
8144	TERME VIGLIATORE	ME	M210
8145	ACQUEDOLCI	ME	M211
8146	LADISPOLI	RM	M212
8147	ARDEA	RM	M213
8148	BADESI	OT	M214
8149	SICIGNANO DEGLI ALBURNI	SA	M253
8150	MOLINA ATERNO	AQ	M255
8151	SCANZANO JONICO	MT	M256
8152	PORTOPALO DI CAPO PASSERO	SR	M257
8153	AVIGLIANO UMBRO	TR	M258
8154	VIDDALBA	SS	M259
8155	CASAPESENNA	CE	M260
8156	CASTRO	LE	M261
8157	CELLOLE	CE	M262
8158	PORTO CESAREO	LE	M263
8159	SAN CASSIANO	LE	M264
8160	VAJONT	PN	M265
8161	ORDONA	FG	M266
8162	ZAPPONETA	FG	M267
8163	BLUFI	PA	M268
8164	PATERNO	PZ	M269
8165	MASAINAS	CI	M270
8166	MAZZARRONE	CT	M271
8167	CIAMPINO	RM	M272
8168	SANTA MARIA LA CARITA'	NA	M273
8169	GOLFO ARANCI	OT	M274
8170	LOIRI PORTO SAN PAOLO	OT	M275
8171	SANT'ANTONIO DI GALLURA	OT	M276
8172	SAN FERDINANDO	RC	M277
8173	VILLAPERUCCIO	CI	M278
8174	PRIOLO GARGALLO	SR	M279
8175	TRECASE	NA	M280
8176	PETROSINO	TP	M281
8177	TERGU	SS	M282
8178	MANIACE	CT	M283
8179	SANTA MARIA COGHINAS	SS	M284
8180	CARDEDU	OG	M285
8181	TORRENOVA	ME	M286
8182	RAGALNA	CT	M287
8183	CASTIADAS	CA	M288
8184	MASSA DI SOMMA	NA	M289
8185	STINTINO	SS	M290
8186	PISCINAS	CI	M291
8187	ERULA	SS	M292
8189	BELLIZZI	SA	M294
8190	SAN CESAREO	RM	M295
8192	FIUMICINO	RM	M297
8193	STATTE	TA	M298
8194	DUE CARRARE	PD	M300
8195	PADRU	OT	M301
8196	MONTIGLIO MONFERRATO	AT	M302
8197	RONZO-CHIENIS	TN	M303
8198	MOSSO	BI	M304
8199	CAVALLINO-TREPORTI	VE	M308
8200	FONTE NUOVA	RM	M309
8202	CAMPOLONGO TAPOGLIANO	UD	M311
8203	LEDRO	TN	M313
8204	COMANO TERME	TN	M314
1	ABANO TERME	PD	A001
2	ABBADIA CERRETO	LO	A004
3	ABBADIA LARIANA	LC	A005
4	ABBADIA SAN SALVATORE	SI	A006
5	ABBASANTA	OR	A007
6	ABBATEGGIO	PE	A008
8	ABBIATEGRASSO	MI	A010
9	ABETONE	PT	A012
10	ABRIOLA	PZ	A013
11	ACATE	RG	A014
12	ACCADIA	FG	A015
13	ACCEGLIO	CN	A016
14	ACCETTURA	MT	A017
15	ACCIANO	AQ	A018
16	ACCUMOLI	RI	A019
17	ACERENZA	PZ	A020
18	CERMES * TSCHERMS	BZ	A022
19	ACERNO	SA	A023
20	ACERRA	NA	A024
21	ACI BONACCORSI	CT	A025
22	ACI CASTELLO	CT	A026
23	ACI CATENA	CT	A027
24	ACIREALE	CT	A028
25	ACI SANT'ANTONIO	CT	A029
26	ACQUACANINA	MC	A031
27	ACQUAFONDATA	FR	A032
28	ACQUAFORMOSA	CS	A033
29	ACQUAFREDDA	BS	A034
30	ACQUALAGNA	PU	A035
31	ACQUANEGRA SUL CHIESE	MN	A038
32	ACQUANEGRA CREMONESE	CR	A039
33	ACQUAPENDENTE	VT	A040
34	ACQUAPPESA	CS	A041
35	ACQUARICA DEL CAPO	LE	A042
36	ACQUARO	VV	A043
37	ACQUASANTA TERME	AP	A044
38	ACQUASPARTA	TR	A045
39	ACQUAVIVA PICENA	AP	A047
40	ACQUAVIVA DELLE FONTI	BA	A048
41	ACQUAVIVA PLATANI	CL	A049
42	ACQUAVIVA COLLECROCE	CB	A050
43	ACQUAVIVA D'ISERNIA	IS	A051
44	ACQUI TERME	AL	A052
45	ACRI	CS	A053
46	ACUTO	FR	A054
47	ADELFIA	BA	A055
48	ADRANO	CT	A056
49	ADRARA SAN MARTINO	BG	A057
50	ADRARA SAN ROCCO	BG	A058
51	ADRIA	RO	A059
52	ADRO	BS	A060
53	AFFI	VR	A061
54	AFFILE	RM	A062
55	AFRAGOLA	NA	A064
56	AFRICO	RC	A065
57	AGAZZANO	PC	A067
58	AGEROLA	NA	A068
59	AGGIUS	OT	A069
60	AGIRA	EN	A070
61	AGLIANA	PT	A071
62	AGLIANO TERME	AT	A072
63	AGLIE'	TO	A074
64	AGNA	PD	A075
65	AGNADELLO	CR	A076
66	AGNANA CALABRA	RC	A077
67	AGNONE	IS	A080
68	VILLA LATINA	FR	A081
69	AGNOSINE	BS	A082
70	AGORDO	BL	A083
71	AGOSTA	RM	A084
72	AGRA	VA	A085
73	AGRATE BRIANZA	MB	A087
74	AGRATE CONTURBIA	NO	A088
75	AGRIGENTO	AG	A089
76	AGROPOLI	SA	A091
77	AGUGLIANO	AN	A092
78	AGUGLIARO	VI	A093
79	AYAS	AO	A094
80	AICURZIO	MB	A096
81	AIDOMAGGIORE	OR	A097
82	AIDONE	EN	A098
83	AIDUSSINA	GO	A099
84	AIELLI	AQ	A100
85	AIELLO DEL SABATO	AV	A101
86	AIELLO CALABRO	CS	A102
87	AIELLO DEL FRIULI	UD	A103
88	AIETA	CS	A105
89	AILANO	CE	A106
90	AILOCHE	BI	A107
91	AYMAVILLES	AO	A108
92	AIRASCA	TO	A109
93	AIROLA	BN	A110
94	AIROLE	IM	A111
95	AIRUNO	LC	A112
96	AISONE	CN	A113
97	ALA' DEI SARDI	OT	A115
98	ALA	TN	A116
99	ALA DI STURA	TO	A117
100	ALAGNA	PV	A118
101	ALAGNA VALSESIA	VC	A119
102	ALANNO	PE	A120
103	ALANO DI PIAVE	BL	A121
104	ALASSIO	SV	A122
105	ALATRI	FR	A123
106	ALBA	CN	A124
107	ALBA ADRIATICA	TE	A125
108	ALBAGIARA	OR	A126
109	ALBAIRATE	MI	A127
110	ALBANELLA	SA	A128
111	ALBANO SANT'ALESSANDRO	BG	A129
112	ALBANO VERCELLESE	VC	A130
113	ALBANO DI LUCANIA	PZ	A131
114	ALBANO LAZIALE	RM	A132
115	ALBAREDO ARNABOLDI	PV	A134
116	ALBAREDO PER SAN MARCO	SO	A135
117	ALBAREDO D'ADIGE	VR	A137
118	ALBARETO	PR	A138
119	ALBARETTO DELLA TORRE	CN	A139
120	ALBAVILLA	CO	A143
121	ALBENGA	SV	A145
122	ALBERA LIGURE	AL	A146
123	ALBEROBELLO	BA	A149
124	ALBERONA	FG	A150
125	ALBESE CON CASSANO	CO	A153
126	ALBETTONE	VI	A154
127	ALBI	CZ	A155
128	ALBIANO D'IVREA	TO	A157
129	ALBIANO	TN	A158
130	ALBIATE	MB	A159
131	ALBIDONA	CS	A160
132	ALBIGNASEGO	PD	A161
133	ALBINEA	RE	A162
134	ALBINO	BG	A163
135	ALBIOLO	CO	A164
136	ALBISSOLA MARINA	SV	A165
137	ALBISOLA SUPERIORE	SV	A166
138	ALBIZZATE	VA	A167
140	ALBONESE	PV	A171
141	ALBOSAGGIA	SO	A172
142	ALBUGNANO	AT	A173
143	ALBUZZANO	PV	A175
144	ALCAMO	TP	A176
145	ALCARA LI FUSI	ME	A177
146	ALDENO	TN	A178
147	ALDINO * ALDEIN	BZ	A179
148	ALES	OR	A180
149	ALESSANDRIA DELLA ROCCA	AG	A181
150	ALESSANDRIA	AL	A182
151	ALESSANDRIA DEL CARRETTO	CS	A183
152	ALESSANO	LE	A184
153	ALEZIO	LE	A185
154	ALFANO	SA	A186
155	ALFEDENA	AQ	A187
156	ALFIANELLO	BS	A188
157	ALFIANO NATTA	AL	A189
158	ALFONSINE	RA	A191
159	ALGHERO	SS	A192
160	ALGUA	BG	A193
161	ALI'	ME	A194
162	ALIA	PA	A195
163	ALIANO	MT	A196
164	ALICE BEL COLLE	AL	A197
165	ALICE CASTELLO	VC	A198
166	ALICE SUPERIORE	TO	A199
167	ALIFE	CE	A200
168	ALI' TERME	ME	A201
169	ALIMENA	PA	A202
170	ALIMINUSA	PA	A203
171	ALLAI	OR	A204
172	ALLEIN	AO	A205
173	ALLEGHE	BL	A206
174	ALLERONA	TR	A207
175	ALLISTE	LE	A208
176	ALLUMIERE	RM	A210
177	ALLUVIONI CAMBIO'	AL	A211
178	ALME'	BG	A214
179	VILLA D'ALME'	BG	A215
180	ALMENNO SAN BARTOLOMEO	BG	A216
181	ALMENNO SAN SALVATORE	BG	A217
182	ALMESE	TO	A218
183	ALONTE	VI	A220
184	ALPETTE	TO	A221
185	ALPIGNANO	TO	A222
186	ALSENO	PC	A223
187	ALSERIO	CO	A224
188	ALTAMURA	BA	A225
189	ALTARE	SV	A226
190	ALTAVILLA MONFERRATO	AL	A227
191	ALTAVILLA IRPINA	AV	A228
192	ALTAVILLA MILICIA	PA	A229
193	ALTAVILLA SILENTINA	SA	A230
194	ALTAVILLA VICENTINA	VI	A231
195	ALTIDONA	FM	A233
196	ALTILIA	CS	A234
197	ALTINO	CH	A235
198	ALTISSIMO	VI	A236
199	ALTIVOLE	TV	A237
200	ALTO	CN	A238
201	ALTOFONTE	PA	A239
202	ALTOMONTE	CS	A240
203	ALTOPASCIO	LU	A241
204	ALVIANO	TR	A242
205	ALVIGNANO	CE	A243
206	ALVITO	FR	A244
207	ALZANO SCRIVIA	AL	A245
208	ALZANO LOMBARDO	BG	A246
209	ALZATE BRIANZA	CO	A249
210	AMALFI	SA	A251
211	AMANDOLA	FM	A252
212	AMANTEA	CS	A253
213	AMARO	UD	A254
214	AMARONI	CZ	A255
215	AMASENO	FR	A256
216	AMATO	CZ	A257
217	AMATRICE	RI	A258
218	AMBIVERE	BG	A259
219	AMBLAR	TN	A260
220	AMEGLIA	SP	A261
221	AMELIA	TR	A262
222	AMENDOLARA	CS	A263
223	AMENO	NO	A264
224	AMOROSI	BN	A265
225	CORTINA D'AMPEZZO	BL	A266
226	AMPEZZO	UD	A267
227	ANACAPRI	NA	A268
228	ANAGNI	FR	A269
229	ANCARANO	TE	A270
230	ANCONA	AN	A271
231	ANDALI	CZ	A272
232	ANDALO VALTELLINO	SO	A273
233	ANDALO	TN	A274
234	ANDEZENO	TO	A275
235	ANDORA	SV	A278
236	ANDORNO MICCA	BI	A280
237	ANDRANO	LE	A281
238	ANDRATE	TO	A282
239	ANDREIS	PN	A283
240	ANDRETTA	AV	A284
241	ANDRIA	BT	A285
242	ANDRIANO * ANDRIAN	BZ	A286
243	ANELA	SS	A287
244	ANFO	BS	A288
245	ANGERA	VA	A290
246	ANGHIARI	AR	A291
247	ANGIARI	VR	A292
248	ANGOLO TERME	BS	A293
249	ANGRI	SA	A294
250	ANGROGNA	TO	A295
251	ANGUILLARA VENETA	PD	A296
252	ANGUILLARA SABAZIA	RM	A297
253	ANNICCO	CR	A299
254	CASTELLO DI ANNONE	AT	A300
255	ANNONE DI BRIANZA	LC	A301
256	ANNONE VENETO	VE	A302
257	ANOIA	RC	A303
258	ANTEGNATE	BG	A304
259	ANTEY-SAINT-ANDRE'	AO	A305
260	ANTERIVO * ALTREI	BZ	A306
261	LA MAGDELEINE	AO	A308
262	ANTICOLI CORRADO	RM	A309
263	FIUGGI	FR	A310
265	ANTIGNANO	AT	A312
266	ANTILLO	ME	A313
267	ANTONIMINA	RC	A314
268	ANTRODOCO	RI	A315
269	ANTRONA SCHIERANCO	VB	A317
270	ANVERSA DEGLI ABRUZZI	AQ	A318
271	ANZANO DEL PARCO	CO	A319
272	ANZANO DI PUGLIA	FG	A320
273	ANZI	PZ	A321
274	ANZIO	RM	A323
275	ANZOLA DELL'EMILIA	BO	A324
276	ANZOLA D'OSSOLA	VB	A325
277	AOSTA	AO	A326
278	APECCHIO	PU	A327
279	APICE	BN	A328
280	APIRO	MC	A329
281	APOLLOSA	BN	A330
282	APPIANO SULLA STRADA DEL VINO * EPPAN AN DER WEINSTRASSE	BZ	A332
283	APPIANO GENTILE	CO	A333
284	APPIGNANO	MC	A334
285	APPIGNANO DEL TRONTO	AP	A335
286	APRICA	SO	A337
287	APRICALE	IM	A338
288	APRICENA	FG	A339
289	APRIGLIANO	CS	A340
290	APRILIA	LT	A341
291	AQUARA	SA	A343
292	AQUILA D'ARROSCIA	IM	A344
293	L'AQUILA	AQ	A345
294	AQUILEIA	UD	A346
295	AQUILONIA	AV	A347
296	AQUINO	FR	A348
297	ARADEO	LE	A350
298	ARAGONA	AG	A351
299	ARAMENGO	AT	A352
300	ARBA	PN	A354
301	TORTOLI'	OG	A355
302	ARBOREA	OR	A357
303	ARBORIO	VC	A358
304	ARBUS	VS	A359
305	ARCADE	TV	A360
306	ARCE	FR	A363
307	ARCENE	BG	A365
308	ARCEVIA	AN	A366
309	ARCHI	CH	A367
310	SAN NICOLO' D'ARCIDANO	OR	A368
311	ARCIDOSSO	GR	A369
312	ARCINAZZO ROMANO	RM	A370
313	ARCISATE	VA	A371
314	ARCO	TN	A372
315	ARCOLA	SP	A373
316	ARCOLE	VR	A374
317	ARCONATE	MI	A375
318	ARCORE	MB	A376
319	ARCUGNANO	VI	A377
320	ARDARA	SS	A379
321	ARDAULI	OR	A380
322	ARDENNO	SO	A382
323	ARDESIO	BG	A383
324	ARDORE	RC	A385
325	ARENA	VV	A386
326	ARENA PO	PV	A387
327	ARENZANO	GE	A388
328	ARESE	MI	A389
329	AREZZO	AR	A390
330	ARGEGNO	CO	A391
331	ARGELATO	BO	A392
332	ARGENTA	FE	A393
333	ARGENTERA	CN	A394
334	ARGUELLO	CN	A396
335	ARGUSTO	CZ	A397
336	ARI	CH	A398
337	ARIANO IRPINO	AV	A399
338	ARIANO NEL POLESINE	RO	A400
339	ARICCIA	RM	A401
340	ARIELLI	CH	A402
341	ARIENZO	CE	A403
342	ARIGNANO	TO	A405
343	ARITZO	NU	A407
344	ARIZZANO	VB	A409
345	ARLENA DI CASTRO	VT	A412
346	ARLUNO	MI	A413
347	ARMENO	NO	A414
348	ARMENTO	PZ	A415
349	ARMO	IM	A418
350	ARMUNGIA	CA	A419
351	ARNARA	FR	A421
352	ARNASCO	SV	A422
353	ARNAD	AO	A424
354	ARNESANO	LE	A425
355	AROLA	VB	A427
356	ARONA	NO	A429
357	AROSIO	CO	A430
358	ARPAIA	BN	A431
359	ARPAISE	BN	A432
360	ARPINO	FR	A433
361	ARQUA' PETRARCA	PD	A434
362	ARQUA' POLESINE	RO	A435
363	ARQUATA SCRIVIA	AL	A436
364	ARQUATA DEL TRONTO	AP	A437
365	ARRE	PD	A438
366	ARRONE	TR	A439
367	ARZAGO D'ADDA	BG	A440
368	ARSAGO SEPRIO	VA	A441
370	ARSIE'	BL	A443
371	ARSIERO	VI	A444
372	ARSITA	TE	A445
373	ARSOLI	RM	A446
374	ARTA TERME	UD	A447
375	ARTEGNA	UD	A448
376	ARTENA	RM	A449
377	ARTOGNE	BS	A451
378	ARVIER	AO	A452
379	ARZACHENA	OT	A453
380	ARZANA	OG	A454
381	ARZANO	NA	A455
382	ARZENE	PN	A456
383	ARZERGRANDE	PD	A458
384	ARZIGNANO	VI	A459
385	ASCEA	SA	A460
386	ASCIANO	SI	A461
387	ASCOLI PICENO	AP	A462
388	ASCOLI SATRIANO	FG	A463
389	ASCREA	RI	A464
390	ASIAGO	VI	A465
391	ASIGLIANO VERCELLESE	VC	A466
392	ASIGLIANO VENETO	VI	A467
393	SINALUNGA	SI	A468
394	ASOLA	MN	A470
395	ASOLO	TV	A471
396	CASPERIA	RI	A472
397	ASSAGO	MI	A473
398	ASSEMINI	CA	A474
399	ASSISI	PG	A475
400	ASSO	CO	A476
401	ASSOLO	OR	A477
402	ASSORO	EN	A478
403	ASTI	AT	A479
404	ASUNI	OR	A480
405	ATELETA	AQ	A481
406	ATELLA	PZ	A482
407	ATENA LUCANA	SA	A484
408	ATESSA	CH	A485
409	ATINA	FR	A486
410	ATRANI	SA	A487
411	ATRI	TE	A488
412	ATRIPALDA	AV	A489
413	ATTIGLIANO	TR	A490
414	ATTIMIS	UD	A491
415	ATZARA	NU	A492
416	AUDITORE	PU	A493
417	AUGUSTA	SR	A494
418	AULETTA	SA	A495
419	AULLA	MS	A496
420	AURANO	VB	A497
421	AURIGO	IM	A499
422	AURONZO DI CADORE	BL	A501
423	AUSONIA	FR	A502
424	AUSTIS	NU	A503
425	AVEGNO	GE	A506
426	AVELENGO * HAFLING	BZ	A507
427	AVELLA	AV	A508
428	AVELLINO	AV	A509
429	AVERARA	BG	A511
430	AVERSA	CE	A512
431	AVETRANA	TA	A514
432	AVEZZANO	AQ	A515
433	AVIANO	PN	A516
434	AVIATICO	BG	A517
435	AVIGLIANA	TO	A518
436	AVIGLIANO	PZ	A519
437	AVIO	TN	A520
438	AVISE	AO	A521
439	AVOLA	SR	A522
440	AVOLASCA	AL	A523
441	AZEGLIO	TO	A525
442	AZZANELLO	CR	A526
443	AZZANO D'ASTI	AT	A527
444	AZZANO SAN PAOLO	BG	A528
445	AZZANO MELLA	BS	A529
446	AZZANO DECIMO	PN	A530
447	AZZATE	VA	A531
448	AZZIO	VA	A532
449	AZZONE	BG	A533
450	BACENO	VB	A534
451	BACOLI	NA	A535
452	BADALUCCO	IM	A536
453	BADIA * ABTEI	BZ	A537
454	BADIA PAVESE	PV	A538
455	BADIA POLESINE	RO	A539
456	BADIA CALAVENA	VR	A540
457	BADIA TEDALDA	AR	A541
458	BADOLATO	CZ	A542
459	BAGALADI	RC	A544
460	BAGHERIA	PA	A546
461	BAGNACAVALLO	RA	A547
462	BAGNARIA	PV	A550
463	BAGNARA DI ROMAGNA	RA	A551
464	BAGNARA CALABRA	RC	A552
465	BAGNARIA ARSA	UD	A553
466	BAGNASCO	CN	A555
467	BAGNATICA	BG	A557
468	PORRETTA TERME	BO	A558
469	CASCIANA TERME	PI	A559
470	BAGNI DI LUCCA	LU	A560
471	MONTECATINI TERME	PT	A561
472	SAN GIULIANO TERME	PI	A562
473	BAGNO A RIPOLI	FI	A564
474	BAGNO DI ROMAGNA	FC	A565
475	BAGNOLI IRPINO	AV	A566
476	BAGNOLI DEL TRIGNO	IS	A567
477	BAGNOLI DI SOPRA	PD	A568
478	BAGNOLO MELLA	BS	A569
479	BAGNOLO CREMASCO	CR	A570
480	BAGNOLO PIEMONTE	CN	A571
481	BAGNOLO DEL SALENTO	LE	A572
482	BAGNOLO IN PIANO	RE	A573
483	BAGNOLO DI PO	RO	A574
484	BAGNOLO SAN VITO	MN	A575
485	BAGNONE	MS	A576
486	BAGNOREGIO	VT	A577
487	BAGOLINO	BS	A578
488	BAIA E LATINA	CE	A579
489	BAIANO	AV	A580
490	BAIARDO	IM	A581
491	BAIRO	TO	A584
492	BAISO	RE	A586
493	BALANGERO	TO	A587
494	BALDICHIERI D'ASTI	AT	A588
495	BALDISSERO D'ALBA	CN	A589
496	BALDISSERO CANAVESE	TO	A590
497	BALDISSERO TORINESE	TO	A591
498	BALESTRATE	PA	A592
499	BALESTRINO	SV	A593
500	BALLABIO	LC	A594
501	BALLAO	CA	A597
502	BALME	TO	A599
503	BALMUCCIA	VC	A600
504	BALOCCO	VC	A601
505	BALSORANO	AQ	A603
506	BALVANO	PZ	A604
507	BALZOLA	AL	A605
508	BANARI	SS	A606
509	BANCHETTE	TO	A607
510	VILLA VERDE	OR	A609
511	BANNIO ANZINO	VB	A610
512	BANZI	PZ	A612
513	BAONE	PD	A613
514	BARADILI	OR	A614
515	BARAGIANO	PZ	A615
516	BARANELLO	CB	A616
517	BARANO D'ISCHIA	NA	A617
518	BARANZATE	MI	A618
519	BARASSO	VA	A619
520	BARATILI SAN PIETRO	OR	A621
522	BARBANIA	TO	A625
523	BARBARA	AN	A626
524	BARBARANO VICENTINO	VI	A627
525	BARBARANO ROMANO	VT	A628
526	BARBARESCO	CN	A629
527	BARBARIGA	BS	A630
528	BARBATA	BG	A631
529	BARBERINO DI MUGELLO	FI	A632
530	BARBERINO VAL D'ELSA	FI	A633
531	BARBIANELLO	PV	A634
532	BARBIANO * BARBIAN	BZ	A635
533	BARBONA	PD	A637
534	BARCELLONA POZZO DI GOTTO	ME	A638
535	BARCHI	PU	A639
536	BARCIS	PN	A640
537	BARD	AO	A643
538	BARDELLO	VA	A645
539	BARDI	PR	A646
540	BARDINETO	SV	A647
541	BARDOLINO	VR	A650
542	BARDONECCHIA	TO	A651
543	BAREGGIO	MI	A652
544	BARENGO	NO	A653
545	BARESSA	OR	A655
546	BARETE	AQ	A656
547	BARGA	LU	A657
548	BARGAGLI	GE	A658
549	BARGE	CN	A660
550	BARGHE	BS	A661
551	BARI	BA	A662
552	BARI SARDO	OG	A663
553	BARIANO	BG	A664
554	BARICELLA	BO	A665
555	BARILE	PZ	A666
556	BARISCIANO	AQ	A667
557	BARLASSINA	MB	A668
558	BARLETTA	BT	A669
559	BARNI	CO	A670
560	BAROLO	CN	A671
561	BARONE CANAVESE	TO	A673
562	BARONISSI	SA	A674
563	BARRAFRANCA	EN	A676
564	BARRALI	CA	A677
565	BARREA	AQ	A678
566	BARUMINI	VS	A681
567	BARZAGO	LC	A683
568	BARZANA	BG	A684
569	BARZANO'	LC	A686
570	BARZIO	LC	A687
571	BASALUZZO	AL	A689
572	BASCAPE'	PV	A690
573	BASCHI	TR	A691
574	BASCIANO	TE	A692
575	BASELGA DI PINE'	TN	A694
576	BASELICE	BN	A696
577	BASIANO	MI	A697
578	BASICO'	ME	A698
579	BASIGLIO	MI	A699
580	BASILIANO	UD	A700
581	VASANELLO	VT	A701
582	BASSANO BRESCIANO	BS	A702
583	BASSANO DEL GRAPPA	VI	A703
584	BASSANO ROMANO	VT	A704
585	TRONZANO LAGO MAGGIORE	VA	A705
586	BASSANO IN TEVERINA	VT	A706
587	BASSIANO	LT	A707
588	BASSIGNANA	AL	A708
589	BASTIA MONDOVI'	CN	A709
590	BASTIA UMBRA	PG	A710
591	BASTIDA DE' DOSSI	PV	A711
592	BASTIDA PANCARANA	PV	A712
593	BASTIGLIA	MO	A713
594	BATTAGLIA TERME	PD	A714
595	BATTIFOLLO	CN	A716
596	BATTIPAGLIA	SA	A717
597	BATTUDA	PV	A718
598	BAUCINA	PA	A719
599	BOVILLE ERNICA	FR	A720
600	BAULADU	OR	A721
601	BAUNEI	OG	A722
602	BAVENO	VB	A725
603	BAZZANO	BO	A726
604	BEDERO VALCUVIA	VA	A728
605	BEDIZZOLE	BS	A729
606	BEDOLLO	TN	A730
607	BEDONIA	PR	A731
608	BEDULITA	BG	A732
609	BEE	VB	A733
610	BEINASCO	TO	A734
611	BEINETTE	CN	A735
612	BELCASTRO	CZ	A736
613	BELFIORE	VR	A737
614	BELFORTE MONFERRATO	AL	A738
615	BELFORTE DEL CHIENTI	MC	A739
616	BELFORTE ALL'ISAURO	PU	A740
617	BELGIOIOSO	PV	A741
618	BELGIRATE	VB	A742
619	BELLA	PZ	A743
620	BELLAGIO	CO	A744
621	BELLANO	LC	A745
622	BELLANTE	TE	A746
623	BELLARIA-IGEA MARINA	RN	A747
624	BELLEGRA	RM	A749
625	BELLINO	CN	A750
626	BELLINZAGO LOMBARDO	MI	A751
627	BELLINZAGO NOVARESE	NO	A752
628	BELLONA	CE	A755
629	BELLOSGUARDO	SA	A756
630	BELLUNO	BL	A757
631	BELLUSCO	MB	A759
632	BELMONTE PICENO	FM	A760
633	BELMONTE DEL SANNIO	IS	A761
634	BELMONTE CALABRO	CS	A762
635	BELMONTE CASTELLO	FR	A763
636	BELMONTE MEZZAGNO	PA	A764
637	BELMONTE IN SABINA	RI	A765
638	BELPASSO	CT	A766
639	BELSITO	CS	A768
640	BELVEDERE OSTRENSE	AN	A769
641	BELVEGLIO	AT	A770
642	LIZZANO IN BELVEDERE	BO	A771
643	BELVEDERE DI SPINELLO	KR	A772
644	BELVEDERE MARITTIMO	CS	A773
645	BELVEDERE LANGHE	CN	A774
646	BELVI	NU	A776
647	BEMA	SO	A777
648	BENE LARIO	CO	A778
649	BENE VAGIENNA	CN	A779
650	BENESTARE	RC	A780
651	BENETUTTI	SS	A781
652	BENEVELLO	CN	A782
653	BENEVENTO	BN	A783
654	BENNA	BI	A784
655	BENTIVOGLIO	BO	A785
656	BERBENNO	BG	A786
657	BERBENNO DI VALTELLINA	SO	A787
658	BERCETO	PR	A788
659	BERCHIDDA	OT	A789
660	BEREGAZZO CON FIGLIARO	CO	A791
661	BEREGUARDO	PV	A792
662	BERGAMASCO	AL	A793
663	BERGAMO	BG	A794
664	BERGANTINO	RO	A795
665	BERGEGGI	SV	A796
666	BERGOGNA	GO	A797
667	BERGOLO	CN	A798
668	BERLINGO	BS	A799
669	BERNALDA	MT	A801
670	BERNAREGGIO	MB	A802
671	BERNATE TICINO	MI	A804
672	BERNEZZO	CN	A805
673	BERRA	FE	A806
674	BERSONE	TN	A808
675	BERTINORO	FC	A809
676	BERTIOLO	UD	A810
677	BERTONICO	LO	A811
678	BERZANO DI SAN PIETRO	AT	A812
679	BERZANO DI TORTONA	AL	A813
680	BERZO SAN FERMO	BG	A815
681	BERZO DEMO	BS	A816
682	BERZO INFERIORE	BS	A817
683	BESANA IN BRIANZA	MB	A818
684	BESANO	VA	A819
685	BESATE	MI	A820
686	BESENELLO	TN	A821
687	BESENZONE	PC	A823
688	BESNATE	VA	A825
689	BESOZZO	VA	A826
690	BESSUDE	SS	A827
691	BETTOLA	PC	A831
692	BETTONA	PG	A832
693	BEURA-CARDEZZA	VB	A834
694	BEVAGNA	PG	A835
695	BEVERINO	SP	A836
696	BEVILACQUA	VR	A837
697	BIANCAVILLA	CT	A841
698	BIANCHI	CS	A842
699	BIANCO	RC	A843
700	BIANDRATE	NO	A844
701	BIANDRONNO	VA	A845
702	BIANZANO	BG	A846
703	BIANZE'	VC	A847
704	BIANZONE	SO	A848
705	BIASSONO	MB	A849
706	BIBBIANO	RE	A850
707	BIBBIENA	AR	A851
708	BIBBONA	LI	A852
709	BIBIANA	TO	A853
710	BICCARI	FG	A854
711	BICINICCO	UD	A855
712	BIDONI'	OR	A856
713	BLERA	VT	A857
714	BIELLA	BI	A859
715	BIENNO	BS	A861
716	BIENO	TN	A863
717	BIENTINA	PI	A864
718	BIGARELLO	MN	A866
719	BINAGO	CO	A870
720	BINASCO	MI	A872
721	BINETTO	BA	A874
722	BIOGLIO	BI	A876
723	BIONAZ	AO	A877
724	BIONE	BS	A878
725	BIRORI	NU	A880
726	BISACCIA	AV	A881
727	BISACQUINO	PA	A882
728	BISCEGLIE	BT	A883
729	BISEGNA	AQ	A884
730	BISENTI	TE	A885
731	BISIGNANO	CS	A887
732	BISTAGNO	AL	A889
733	BISUSCHIO	VA	A891
734	BITETTO	BA	A892
735	BITONTO	BA	A893
736	BITRITTO	BA	A894
737	BITTI	NU	A895
738	BIVONA	AG	A896
739	BIVONGI	RC	A897
740	BIZZARONE	CO	A898
741	BLEGGIO SUPERIORE	TN	A902
742	BLELLO	BG	A903
743	BLESSAGNO	CO	A904
744	BLEVIO	CO	A905
745	BOARA PISANI	PD	A906
746	BOBBIO	PC	A909
747	BOBBIO PELLICE	TO	A910
748	BOCA	NO	A911
749	BOCCHIGLIERO	CS	A912
750	BOCCIOLETO	VC	A914
751	BOCENAGO	TN	A916
752	BODIO LOMNAGO	VA	A918
753	BOFFALORA D'ADDA	LO	A919
754	BOFFALORA SOPRA TICINO	MI	A920
755	BOGLIASCO	GE	A922
757	BOGNANCO	VB	A925
758	BOGOGNO	NO	A929
759	BOIANO	CB	A930
760	BOISSANO	SV	A931
761	BOLANO	SP	A932
762	BOLBENO	TN	A933
763	BOLGARE	BG	A937
764	BOLLATE	MI	A940
765	BOLLENGO	TO	A941
766	NOVA SIRI	MT	A942
767	BOLOGNA	BO	A944
768	BOLOGNANO	PE	A945
769	BOLOGNETTA	PA	A946
770	BOLOGNOLA	MC	A947
771	BOLOTANA	NU	A948
772	BOLSENA	VT	A949
773	BOLTIERE	BG	A950
774	BOLZANO * BOZEN	BZ	A952
775	BOLZANO NOVARESE	NO	A953
776	BOLZANO VICENTINO	VI	A954
777	BOMARZO	VT	A955
778	BOMBA	CH	A956
779	BOMPENSIERE	CL	A957
780	BOMPIETRO	PA	A958
781	BOMPORTO	MO	A959
782	BONARCADO	OR	A960
783	BONASSOLA	SP	A961
784	BONATE SOTTO	BG	A962
785	BONATE SOPRA	BG	A963
786	BONAVIGO	VR	A964
787	BONDENO	FE	A965
788	BONDO	TN	A967
789	BONDONE	TN	A968
790	BONEA	BN	A970
791	BONEFRO	CB	A971
792	BONEMERSE	CR	A972
793	BONIFATI	CS	A973
794	BONITO	AV	A975
795	BONNANARO	SS	A976
796	BONO	SS	A977
797	BONORVA	SS	A978
798	BONVICINO	CN	A979
799	BORBONA	RI	A981
800	BORCA DI CADORE	BL	A982
801	BORDANO	UD	A983
802	BORDIGHERA	IM	A984
803	BORDOLANO	CR	A986
804	BORE	PR	A987
805	BORETTO	RE	A988
806	BORGARELLO	PV	A989
807	BORGARO TORINESE	TO	A990
808	BORGETTO	PA	A991
809	BORGHETTO DI VARA	SP	A992
810	BORGHETTO D'ARROSCIA	IM	A993
811	BORGHETTO LODIGIANO	LO	A995
812	BORGO VELINO	RI	A996
813	BORGHETTO DI BORBERA	AL	A998
814	BORGHETTO SANTO SPIRITO	SV	A999
815	BORGHI	FC	B001
816	BORGIA	CZ	B002
817	BORGIALLO	TO	B003
818	BORGIO VEREZZI	SV	B005
819	BORGO VALSUGANA	TN	B006
820	BORGO A MOZZANO	LU	B007
821	BORGOROSE	RI	B008
822	BORGO D'ALE	VC	B009
823	BORGO DI TERZO	BG	B010
824	BORGOFORTE	MN	B011
825	MOTTEGGIANA	MN	B012
826	BORGOFRANCO SUL PO	MN	B013
827	SUARDI	PV	B014
828	BORGOFRANCO D'IVREA	TO	B015
829	BORGOLAVEZZARO	NO	B016
830	BORGO SAN GIOVANNI	LO	B017
831	BORGOMALE	CN	B018
832	BORGOMANERO	NO	B019
833	BORGOMARO	IM	B020
834	BORGOMASINO	TO	B021
835	BORGONE SUSA	TO	B024
836	BORGONOVO VAL TIDONE	PC	B025
837	BORGO PACE	PU	B026
838	BORGO PRIOLO	PV	B028
839	BORGORATTO ALESSANDRINO	AL	B029
840	BORGORATTO MORMOROLO	PV	B030
841	BORGORICCO	PD	B031
842	BORGO SAN DALMAZZO	CN	B033
843	FIDENZA	PR	B034
844	BORGO SAN GIACOMO	BS	B035
845	BORGO SAN LORENZO	FI	B036
846	BORGO SAN MARTINO	AL	B037
847	BORGO SAN SIRO	PV	B038
848	BORGOSATOLLO	BS	B040
849	BORGOSESIA	VC	B041
850	BORGO VAL DI TARO	PR	B042
851	BORGO TICINO	NO	B043
852	BORGO TOSSIGNANO	BO	B044
853	BORGO VERCELLI	VC	B046
854	BORMIDA	SV	B048
855	BORMIO	SO	B049
856	BORNASCO	PV	B051
857	BORNO	BS	B054
858	BORONEDDU	OR	B055
859	BORORE	NU	B056
860	BORRELLO	CH	B057
861	BORRIANA	BI	B058
862	BORSO DEL GRAPPA	TV	B061
863	BORTIGALI	NU	B062
864	BORTIGIADAS	OT	B063
865	BORUTTA	SS	B064
866	BORZONASCA	GE	B067
867	BOSA	NU	B068
868	BOSARO	RO	B069
869	BOSCHI SANT'ANNA	VR	B070
870	BOSCO MARENGO	AL	B071
871	BOSCO CHIESANUOVA	VR	B073
872	BOSCONERO	TO	B075
873	BOSCOREALE	NA	B076
874	BOSCOTRECASE	NA	B077
875	BOSENTINO	TN	B078
876	BOSIA	CN	B079
877	BOSIO	AL	B080
878	BOSISIO PARINI	LC	B081
879	BOSNASCO	PV	B082
880	BOSSICO	BG	B083
881	BOSSOLASCO	CN	B084
882	BOTRICELLO	CZ	B085
883	BOTRUGNO	LE	B086
884	BOTTANUCO	BG	B088
885	BOTTICINO	BS	B091
886	BOTTIDDA	SS	B094
887	BOVA	RC	B097
888	BOVALINO	RC	B098
889	BOVA MARINA	RC	B099
890	BOVEGNO	BS	B100
891	BOVES	CN	B101
892	BOVEZZO	BS	B102
893	BOVINO	FG	B104
894	BOVISIO-MASCIAGO	MB	B105
895	BOVOLENTA	PD	B106
896	BOVOLONE	VR	B107
897	BOZZOLE	AL	B109
898	BOZZOLO	MN	B110
899	BRA	CN	B111
900	BRACCA	BG	B112
901	BRACCIANO	RM	B114
902	BRACIGLIANO	SA	B115
903	BRAIES * PRAGS	BZ	B116
904	BRALLO DI PREGOLA	PV	B117
905	BRANCALEONE	RC	B118
906	BRANDICO	BS	B120
907	BRANDIZZO	TO	B121
908	BRANZI	BG	B123
909	BRAONE	BS	B124
910	BREBBIA	VA	B126
911	BREDA DI PIAVE	TV	B128
912	CASTELVERDE	CR	B129
913	BREGANO	VA	B131
914	BREGANZE	VI	B132
915	BREGNANO	CO	B134
916	BREGUZZO	TN	B135
917	BREIA	VC	B136
918	BREMBATE	BG	B137
919	BREMBATE DI SOPRA	BG	B138
920	BREMBILLA	BG	B140
921	BREMBIO	LO	B141
922	BREME	PV	B142
923	BRENDOLA	VI	B143
924	BRENNA	CO	B144
925	BRENNERO * BRENNER	BZ	B145
926	BRENO	BS	B149
927	BRENTA	VA	B150
928	BRENTINO BELLUNO	VR	B152
929	BRENTONICO	TN	B153
930	BRENZONE	VR	B154
931	BRESCELLO	RE	B156
932	BRESCIA	BS	B157
933	BRESIMO	TN	B158
934	BRESSANA BOTTARONE	PV	B159
935	BRESSANONE * BRIXEN	BZ	B160
936	BRESSANVIDO	VI	B161
937	BRESSO	MI	B162
938	BREZ	TN	B165
939	BREZZO DI BEDERO	VA	B166
940	BRIAGLIA	CN	B167
941	BRIATICO	VV	B169
942	BRICHERASIO	TO	B171
943	BRIENNO	CO	B172
944	BRIENZA	PZ	B173
945	BRIGA MARITTIMA	CN	B174
946	BRIGA ALTA	CN	B175
947	BRIGA NOVARESE	NO	B176
948	BRIGNANO GERA D'ADDA	BG	B178
949	BRIGNANO-FRASCATA	AL	B179
950	BRINDISI	BR	B180
951	BRINDISI MONTAGNA	PZ	B181
952	BRINZIO	VA	B182
953	BRIONA	NO	B183
954	BRIONE	BS	B184
955	BRIONE	TN	B185
957	BRIOSCO	MB	B187
958	BRISIGHELLA	RA	B188
959	BRISSAGO-VALTRAVAGLIA	VA	B191
960	BRISSOGNE	AO	B192
961	BRITTOLI	PE	B193
962	BRIVIO	LC	B194
963	BROCCOSTELLA	FR	B195
964	BROGLIANO	VI	B196
965	BROGNATURO	VV	B197
966	BROLO	ME	B198
967	BRONDELLO	CN	B200
968	BRONI	PV	B201
969	BRONTE	CT	B202
970	BRONZOLO * BRANZOLL	BZ	B203
971	BROSSASCO	CN	B204
972	BROSSO	TO	B205
973	BROVELLO-CARPUGNINO	VB	B207
974	BROZOLO	TO	B209
975	BRUGHERIO	MB	B212
976	BRUGINE	PD	B213
977	BRUGNATO	SP	B214
978	BRUGNERA	PN	B215
979	BRUINO	TO	B216
980	BRUMANO	BG	B217
981	BRUNATE	CO	B218
982	BRUNELLO	VA	B219
983	BRUNICO * BRUNECK	BZ	B220
984	BRUNO	AT	B221
985	BRUSAPORTO	BG	B223
986	BRUSASCO	TO	B225
987	BRUSCIANO	NA	B227
988	BRUSIMPIANO	VA	B228
989	BRUSNENGO	BI	B229
990	BRUSSON	AO	B230
991	BRUZOLO	TO	B232
992	BRUZZANO ZEFFIRIO	RC	B234
993	BUBBIANO	MI	B235
994	BUBBIO	AT	B236
995	BUCCHERI	SR	B237
996	BUCCHIANICO	CH	B238
997	BUCCIANO	BN	B239
998	BUCCINASCO	MI	B240
999	BUCCINO	SA	B242
1000	BUCINE	AR	B243
1001	BUCUIE	TS	B244
1002	BUDDUSO'	OT	B246
1003	BUDOIA	PN	B247
1004	BUDONI	OT	B248
1005	BUDRIO	BO	B249
1006	BUGGERRU	CI	B250
1007	BUGGIANO	PT	B251
1008	BUGLIO IN MONTE	SO	B255
1009	BUGNARA	AQ	B256
1010	BUGUGGIATE	VA	B258
1011	BUJA	UD	B259
1013	BULCIAGO	LC	B261
1014	BULGAROGRASSO	CO	B262
1015	BULTEI	SS	B264
1016	BULZI	SS	B265
1017	BUONABITACOLO	SA	B266
1018	BUONALBERGO	BN	B267
1019	MONTEBELLO SUL SANGRO	CH	B268
1020	BUONCONVENTO	SI	B269
1021	BUONVICINO	CS	B270
1022	BURAGO DI MOLGORA	MB	B272
1023	BURCEI	CA	B274
1024	BURGIO	AG	B275
1025	BURGOS	SS	B276
1026	BURIASCO	TO	B278
1027	BUROLO	TO	B279
1028	BURONZO	VC	B280
1029	BUSACHI	OR	B281
1030	BUSALLA	GE	B282
1031	BUSANA	RE	B283
1032	BUSANO	TO	B284
1033	BUSCA	CN	B285
1034	BUSCATE	MI	B286
1035	BUSCEMI	SR	B287
1036	BUSETO PALIZZOLO	TP	B288
1037	BUSNAGO	MB	B289
1038	BUSSERO	MI	B292
1039	BUSSETO	PR	B293
1040	BUSSI SUL TIRINO	PE	B294
1041	BUSSO	CB	B295
1042	BUSSOLENGO	VR	B296
1043	BUSSOLENO	TO	B297
1044	BUSTO ARSIZIO	VA	B300
1045	BUSTO GAROLFO	MI	B301
1046	BUTERA	CL	B302
1047	BUTI	PI	B303
1048	BUTTAPIETRA	VR	B304
1049	BUTTIGLIERA ALTA	TO	B305
1050	BUTTIGLIERA D'ASTI	AT	B306
1051	BUTTRIO	UD	B309
1052	SAN PAOLO D'ARGON	BG	B310
1053	CABELLA LIGURE	AL	B311
1054	CASTELLO CABIAGLIO	VA	B312
1055	CABIATE	CO	B313
1056	CABRAS	OR	B314
1057	CACCAMO	PA	B315
1058	POGGIO SANNITA	IS	B317
1059	CACCURI	KR	B319
1060	CA' D'ANDREA	CR	B320
1061	CADEGLIANO-VICONAGO	VA	B326
1062	CADELBOSCO DI SOPRA	RE	B328
1063	CADEO	PC	B332
1064	CADERZONE	TN	B335
1065	CADONEGHE	PD	B345
1066	CADORAGO	CO	B346
1067	CADREZZATE	VA	B347
1068	CAERANO DI SAN MARCO	TV	B349
1069	CAFASSE	TO	B350
1070	CAGGIANO	SA	B351
1071	CAGLI	PU	B352
1072	CAGLIARI	CA	B354
1073	CAGLIO	CO	B355
1074	CAGNANO VARANO	FG	B357
1075	CAGNANO AMITERNO	AQ	B358
1076	CAGNO	CO	B359
1077	CAGNO'	TN	B360
1078	CAIANELLO	CE	B361
1079	CAIAZZO	CE	B362
1080	CAINES * KUENS	BZ	B364
1081	CAINO	BS	B365
1082	CAIOLO	SO	B366
1083	CAIRANO	AV	B367
1084	CAIRATE	VA	B368
1085	CAIRO MONTENOTTE	SV	B369
1086	CAIVANO	NA	B371
1087	CALABRITTO	AV	B374
1088	CALALZO DI CADORE	BL	B375
1089	CALAMANDRANA	AT	B376
1090	CALAMONACI	AG	B377
1091	CALANGIANUS	OT	B378
1092	CALANNA	RC	B379
1093	CALASCA-CASTIGLIONE	VB	B380
1094	CALASCIBETTA	EN	B381
1095	CALASCIO	AQ	B382
1096	CALASETTA	CI	B383
1097	CALATABIANO	CT	B384
1098	CALATAFIMI SEGESTA	TP	B385
1099	CALAVINO	TN	B386
1100	LUNGAVILLA	PV	B387
1101	CALCATA	VT	B388
1102	CALCERANICA AL LAGO	TN	B389
1103	CALCI	PI	B390
1104	CALCIANO	MT	B391
1105	CALCINAIA	PI	B392
1106	CALCINATE	BG	B393
1107	CALCINATO	BS	B394
1108	CALCIO	BG	B395
1109	CALCO	LC	B396
1110	CALDARO SULLA STRADA DEL VINO * KALTERN AN DER WEINSTRASSE	BZ	B397
1111	CALDAROLA	MC	B398
1112	CALDERARA DI RENO	BO	B399
1113	CALDES	TN	B400
1114	CAL DI CANALE	GO	B401
1115	CALDIERO	VR	B402
1116	CALDOGNO	VI	B403
1117	CALDONAZZO	TN	B404
1118	CALENDASCO	PC	B405
1119	CALENZANO	FI	B406
1120	CALESTANO	PR	B408
1121	CALICE LIGURE	SV	B409
1122	CALICE AL CORNOVIGLIO	SP	B410
1123	CALIMERA	LE	B413
1124	CALITRI	AV	B415
1125	CALIZZANO	SV	B416
1126	CALLABIANA	BI	B417
1127	CALLIANO	AT	B418
1128	CALLIANO	TN	B419
1129	CALOLZIOCORTE	LC	B423
1130	CALOPEZZATI	CS	B424
1131	CALOSSO	AT	B425
1132	CALOVETO	CS	B426
1133	CALTABELLOTTA	AG	B427
1134	CALTAGIRONE	CT	B428
1135	CALTANISSETTA	CL	B429
1136	CALTAVUTURO	PA	B430
1137	CALTIGNAGA	NO	B431
1138	CALTO	RO	B432
1139	CALTRANO	VI	B433
1140	CALUSCO D'ADDA	BG	B434
1141	CALUSO	TO	B435
1142	CALVAGESE DELLA RIVIERA	BS	B436
1143	CALVANICO	SA	B437
1144	CALVATONE	CR	B439
1145	CALVELLO	PZ	B440
1146	CALVENE	VI	B441
1147	CALVENZANO	BG	B442
1148	CALVERA	PZ	B443
1149	CALVI	BN	B444
1150	CALVI RISORTA	CE	B445
1151	CALVI DELL'UMBRIA	TR	B446
1152	CALVIGNANO	PV	B447
1153	CALVIGNASCO	MI	B448
1154	CALVISANO	BS	B450
1155	CALVIZZANO	NA	B452
1156	CAMAGNA MONFERRATO	AL	B453
1157	CAMAIORE	LU	B455
1158	CAMAIRAGO	LO	B456
1159	CAMANDONA	BI	B457
1160	CAMASTRA	AG	B460
1161	CAMBIAGO	MI	B461
1162	CAMBIANO	TO	B462
1163	CAMBIASCA	VB	B463
1164	CAMBURZANO	BI	B465
1165	SANT'ELENA SANNITA	IS	B466
1166	CAMERANA	CN	B467
1167	CAMERANO	AN	B468
1168	CAMERANO CASASCO	AT	B469
1169	CAMERATA PICENA	AN	B470
1170	CAMERATA CORNELLO	BG	B471
1171	CAMERATA NUOVA	RM	B472
1172	CAMERI	NO	B473
1173	CAMERINO	MC	B474
1174	CAMEROTA	SA	B476
1175	CAMIGLIANO	CE	B477
1176	CAMINATA	PC	B479
1177	CAMINI	RC	B481
1178	CAMINO	AL	B482
1179	CAMINO AL TAGLIAMENTO	UD	B483
1180	CAMISANO	CR	B484
1181	CAMISANO VICENTINO	VI	B485
1182	CAMMARATA	AG	B486
1183	CAMO	CN	B489
1184	CAMOGLI	GE	B490
1185	CHAMOIS	AO	B491
1186	CAMPAGNA	SA	B492
1187	CAMPAGNA LUPIA	VE	B493
1188	CASTEL CAMPAGNANO	CE	B494
1189	CAMPAGNANO DI ROMA	RM	B496
1190	CAMPAGNATICO	GR	B497
1191	CAMPAGNOLA CREMASCA	CR	B498
1192	CAMPAGNOLA EMILIA	RE	B499
1193	CAMPANA	CS	B500
1194	CAMPARADA	MB	B501
1195	CAMPEGINE	RE	B502
1196	CAMPELLO SUL CLITUNNO	PG	B504
1197	CAMPERTOGNO	VC	B505
1198	CAMPI SALENTINA	LE	B506
1199	CAMPI BISENZIO	FI	B507
1200	CAMPIGLIA CERVO	BI	B508
1201	CAMPIGLIA MARITTIMA	LI	B509
1202	VALPRATO SOANA	TO	B510
1203	CAMPIGLIA DEI BERICI	VI	B511
1204	CAMPIGLIONE FENILE	TO	B512
1205	CAMPIONE D'ITALIA	CO	B513
1206	CAMPITELLO DI FASSA	TN	B514
1207	CAMPLI	TE	B515
1208	CAMPO CALABRO	RC	B516
1209	CAMPOBASSO	CB	B519
1210	CAMPOBELLO DI LICATA	AG	B520
1211	CAMPOBELLO DI MAZARA	TP	B521
1212	CAMPOCHIARO	CB	B522
1213	CAMPODARSEGO	PD	B524
1214	CAMPODENNO	TN	B525
1215	CAMPO DI GIOVE	AQ	B526
1216	CAMPODIMELE	LT	B527
1217	CAMPODIPIETRA	CB	B528
1218	CAMPO DI TRENS * FREIENFELD	BZ	B529
1219	CAMPODOLCINO	SO	B530
1220	CAMPODORO	PD	B531
1221	CAMPOFELICE DI ROCCELLA	PA	B532
1222	CAMPOFELICE DI FITALIA	PA	B533
1223	CAMPOFILONE	FM	B534
1224	CAMPOFIORITO	PA	B535
1225	CAMPOFORMIDO	UD	B536
1226	CAMPOFRANCO	CL	B537
1227	CAMPO LIGURE	GE	B538
1228	CAMPOGALLIANO	MO	B539
1229	CHAMPORCHER	AO	B540
1230	CAMPOLATTARO	BN	B541
1231	CAMPOLI DEL MONTE TABURNO	BN	B542
1232	CAMPOLI APPENNINO	FR	B543
1233	CAMPOLIETO	CB	B544
1234	CAMPOLONGO MAGGIORE	VE	B546
1235	CAMPOLONGO SUL BRENTA	VI	B547
1236	CAMPOMAGGIORE	PZ	B549
1237	CAMPOMARINO	CB	B550
1238	CAMPOMORONE	GE	B551
1239	CAMPO NELL'ELBA	LI	B553
1240	CAMPONOGARA	VE	B554
1241	CAMPORA	SA	B555
1242	CAMPOREALE	PA	B556
1243	CAMPORGIANO	LU	B557
1244	CAMPOROSSO	IM	B559
1245	CAMPOROTONDO ETNEO	CT	B561
1246	CAMPOROTONDO DI FIASTRONE	MC	B562
1247	CAMPOSAMPIERO	PD	B563
1248	CAMPO SAN MARTINO	PD	B564
1249	CAMPOSANO	NA	B565
1250	CAMPOSANTO	MO	B566
1251	CAMPOSPINOSO	PV	B567
1252	CAMPOTOSTO	AQ	B569
1253	CAMPO TURES * SAND IN TAUFERS	BZ	B570
1254	CAMUGNANO	BO	B572
1255	CANALE	CN	B573
1256	CANALE D'AGORDO	BL	B574
1257	CANALE D'ISONZO	GO	B575
1258	CANALE MONTERANO	RM	B576
1259	CANAL SAN BOVO	TN	B577
1260	CANARO	RO	B578
1261	CANAZEI	TN	B579
1262	CANCELLARA	PZ	B580
1263	CANCELLO ED ARNONE	CE	B581
1264	CANDA	RO	B582
1265	CANDELA	FG	B584
1266	CANDELO	BI	B586
1267	CANDIA LOMELLINA	PV	B587
1268	CANDIA CANAVESE	TO	B588
1269	CANDIANA	PD	B589
1270	CANDIDA	AV	B590
1271	CANDIDONI	RC	B591
1272	CANDIOLO	TO	B592
1273	CANEGRATE	MI	B593
1274	CANELLI	AT	B594
1275	ORVINIO	RI	B595
1276	CANEPINA	VT	B597
1277	CANEVA	PN	B598
1278	CANEVINO	PV	B599
1280	CANICATTI'	AG	B602
1281	CANICATTINI BAGNI	SR	B603
1282	CANINO	VT	B604
1283	CANISCHIO	TO	B605
1284	CANISTRO	AQ	B606
1285	CANNA	CS	B607
1286	CANNALONGA	SA	B608
1287	CANNARA	PG	B609
1288	CANNERO RIVIERA	VB	B610
1289	CANNETO SULL'OGLIO	MN	B612
1290	CANNETO PAVESE	PV	B613
1291	CANNOBIO	VB	B615
1292	CANNOLE	LE	B616
1293	CANOLO	RC	B617
1294	CANONICA D'ADDA	BG	B618
1295	CANOSA DI PUGLIA	BT	B619
1296	CANOSA SANNITA	CH	B620
1297	CANOSIO	CN	B621
1298	CANSANO	AQ	B624
1299	CANTAGALLO	PO	B626
1300	CANTALICE	RI	B627
1301	CANTALUPA	TO	B628
1302	CANTALUPO LIGURE	AL	B629
1303	CANTALUPO NEL SANNIO	IS	B630
1304	CANTALUPO IN SABINA	RI	B631
1305	MANDELA	RM	B632
1306	CANTARANA	AT	B633
1307	CANTELLO	VA	B634
1308	CANTERANO	RM	B635
1309	CANTIANO	PU	B636
1310	CANTOIRA	TO	B637
1311	CANTU'	CO	B639
1312	CANZANO	TE	B640
1313	CANZO	CO	B641
1314	CAORLE	VE	B642
1315	CAORSO	PC	B643
1316	CAPACCIO	SA	B644
1317	CAPACI	PA	B645
1318	CAPALBIO	GR	B646
1319	CAPANNOLI	PI	B647
1320	CAPANNORI	LU	B648
1321	CAPENA	RM	B649
1322	CAPERGNANICA	CR	B650
1323	CAPESTRANO	AQ	B651
1324	CAPIAGO INTIMIANO	CO	B653
1325	CAPISTRANO	VV	B655
1326	CAPISTRELLO	AQ	B656
1327	CAPITIGNANO	AQ	B658
1328	CAPIZZI	ME	B660
1329	CAPIZZONE	BG	B661
1330	PONTE NELLE ALPI	BL	B662
1331	CAPODIMONTE	VT	B663
1332	CAPO DI PONTE	BS	B664
1334	CAPO D'ORLANDO	ME	B666
1335	CAPODRISE	CE	B667
1336	CAPOLIVERI	LI	B669
1337	CAPOLONA	AR	B670
1338	CAPONAGO	MB	B671
1339	CAPORCIANO	AQ	B672
1340	CAPORETTO	GO	B673
1341	CAPOSELE	AV	B674
1342	CAPOTERRA	CA	B675
1343	CAPOVALLE	BS	B676
1344	CAPPADOCIA	AQ	B677
1345	CAPPELLA MAGGIORE	TV	B678
1346	CAPPELLA CANTONE	CR	B679
1347	CAPPELLA DE' PICENARDI	CR	B680
1348	CAPPELLE SUL TAVO	PE	B681
1349	CAPRACOTTA	IS	B682
1350	CAPRAIA E LIMITE	FI	B684
1351	CAPRAIA ISOLA	LI	B685
1352	CAPRALBA	CR	B686
1353	CAPRANICA PRENESTINA	RM	B687
1354	CAPRANICA	VT	B688
1355	MARZABOTTO	BO	B689
1356	CAPRARICA DI LECCE	LE	B690
1357	CAPRAROLA	VT	B691
1358	CAPRAUNA	CN	B692
1359	CAPRESE MICHELANGELO	AR	B693
1360	CAPREZZO	VB	B694
1361	CAPRI LEONE	ME	B695
1362	CAPRI	NA	B696
1363	CAPRIANA	TN	B697
1364	CAPRIANO DEL COLLE	BS	B698
1365	CAPRIATA D'ORBA	AL	B701
1366	CAPRIATE SAN GERVASIO	BG	B703
1367	CAPRIATI A VOLTURNO	CE	B704
1368	CAPRIE	TO	B705
1369	CAPRIGLIA IRPINA	AV	B706
1370	CAPRIGLIO	AT	B707
1371	CAPRILE	BI	B708
1372	CAPRINO VERONESE	VR	B709
1373	CAPRINO BERGAMASCO	BG	B710
1374	CAPRIOLO	BS	B711
1375	CAPRIVA DEL FRIULI	GO	B712
1376	CAPUA	CE	B715
1377	CAPURSO	BA	B716
1378	CARAFFA DI CATANZARO	CZ	B717
1379	CARAFFA DEL BIANCO	RC	B718
1380	CARAGLIO	CN	B719
1381	CARAMAGNA PIEMONTE	CN	B720
1382	CARAMANICO TERME	PE	B722
1383	CARANO	TN	B723
1384	CARAPELLE	FG	B724
1385	CARAPELLE CALVISIO	AQ	B725
1386	CARASCO	GE	B726
1387	CARASSAI	AP	B727
1388	CARATE BRIANZA	MB	B729
1389	CARATE URIO	CO	B730
1390	CARAVAGGIO	BG	B731
1391	CARAVATE	VA	B732
1392	CARAVINO	TO	B733
1393	CARAVONICA	IM	B734
1394	CARBOGNANO	VT	B735
1395	CARBONARA SCRIVIA	AL	B736
1396	VILLASIMIUS	CA	B738
1397	CARBONARA DI PO	MN	B739
1398	CARBONARA DI NOLA	NA	B740
1399	CARBONARA AL TICINO	PV	B741
1400	CARBONATE	CO	B742
1401	CARBONE	PZ	B743
1402	CARBONERA	TV	B744
1403	CARBONIA	CI	B745
1404	CARCARE	SV	B748
1405	CARCERI	PD	B749
1406	CARCOFORO	VC	B752
1407	CARDANO AL CAMPO	VA	B754
1408	CARDE'	CN	B755
1409	CARDETO	RC	B756
1410	CARDINALE	CZ	B758
1411	CARDITO	NA	B759
1412	CAREGGINE	LU	B760
1413	CAREMA	TO	B762
1414	CARENNO	LC	B763
1415	CARENTINO	AL	B765
1416	CARERI	RC	B766
1417	CARESANA	VC	B767
1418	CARESANABLOT	VC	B768
1419	CAREZZANO	AL	B769
1420	CARFIZZI	KR	B771
1421	CARGEGHE	SS	B772
1422	CARIATI	CS	B774
1423	CARIFE	AV	B776
1424	CARIGNANO	TO	B777
1425	CARIMATE	CO	B778
1426	CARINARO	CE	B779
1427	CARINI	PA	B780
1428	CARINOLA	CE	B781
1429	CARISIO	VC	B782
1430	CARISOLO	TN	B783
1431	CARLANTINO	FG	B784
1432	CARLAZZO	CO	B785
1433	CARLENTINI	SR	B787
1434	CARLINO	UD	B788
1435	CARLOFORTE	CI	B789
1436	CARLOPOLI	CZ	B790
1437	CARMAGNOLA	TO	B791
1438	CARMIANO	LE	B792
1439	CARMIGNANO	PO	B794
1440	CARMIGNANO DI BRENTA	PD	B795
1441	CARNAGO	VA	B796
1442	CARNATE	MB	B798
1443	CORNEDO ALL'ISARCO * KARNEID	BZ	B799
1444	CAROBBIO DEGLI ANGELI	BG	B801
1445	CAROLEI	CS	B802
1446	CARONA	BG	B803
1447	CARONIA	ME	B804
1448	CARONNO PERTUSELLA	VA	B805
1449	CARONNO VARESINO	VA	B807
1450	CAROSINO	TA	B808
1451	CAROVIGNO	BR	B809
1452	CAROVILLI	IS	B810
1453	CARPANETO PIACENTINO	PC	B812
1454	CARPANZANO	CS	B813
1455	CARPASIO	IM	B814
1456	CARPEGNA	PU	B816
1457	CARPENEDOLO	BS	B817
1458	CARPENETO	AL	B818
1459	CARPI	MO	B819
1460	CARPIANO	MI	B820
1461	CARPIGNANO SALENTINO	LE	B822
1462	CARPIGNANO SESIA	NO	B823
1463	CURA CARPIGNANO	PV	B824
1464	CARPINETI	RE	B825
1465	CARPINETO SINELLO	CH	B826
1466	CARPINETO DELLA NORA	PE	B827
1467	CARPINETO ROMANO	RM	B828
1468	CARPINO	FG	B829
1469	CARPINONE	IS	B830
1470	CARRARA	MS	B832
1471	CARRE'	VI	B835
1472	CARREGA LIGURE	AL	B836
1473	CARRO	SP	B838
1474	CARRODANO	SP	B839
1475	CARROSIO	AL	B840
1476	CARRU'	CN	B841
1477	CARSOLI	AQ	B842
1478	CARTIGLIANO	VI	B844
1479	CARTIGNANO	CN	B845
1480	CARTOCETO	PU	B846
1481	CARTOSIO	AL	B847
1482	CARTURA	PD	B848
1483	CARUGATE	MI	B850
1484	CARUGO	CO	B851
1485	CARUNCHIO	CH	B853
1486	CARVICO	BG	B854
1487	CARZANO	TN	B856
1488	CASABONA	KR	B857
1489	CASACALENDA	CB	B858
1490	CASACANDITELLA	CH	B859
1491	CASAGIOVE	CE	B860
1492	CASALANGUIDA	CH	B861
1493	CASALATTICO	FR	B862
1494	CASALBELTRAME	NO	B864
1495	CASALBORDINO	CH	B865
1496	CASALBORE	AV	B866
1497	CASALBORGONE	TO	B867
1498	CASALBUONO	SA	B868
1499	CASALBUTTANO ED UNITI	CR	B869
1500	CASAL CERMELLI	AL	B870
1501	CASALCIPRANO	CB	B871
1502	CASAL DI PRINCIPE	CE	B872
1503	CASALDUNI	BN	B873
1504	CASALE LITTA	VA	B875
1505	CASALE CORTE CERRO	VB	B876
1506	CASALE DI SCODOSIA	PD	B877
1507	CASALE MARITTIMO	PI	B878
1508	CASALE SUL SILE	TV	B879
1509	CASALECCHIO DI RENO	BO	B880
1510	CASALE CREMASCO-VIDOLASCO	CR	B881
1511	CASALEGGIO BOIRO	AL	B882
1512	CASALEGGIO NOVARA	NO	B883
1513	CASALE MONFERRATO	AL	B885
1514	CASALEONE	VR	B886
1515	CASALETTO LODIGIANO	LO	B887
1516	CASALETTO SPARTANO	SA	B888
1517	CASALETTO CEREDANO	CR	B889
1518	CASALETTO DI SOPRA	CR	B890
1519	CASALETTO VAPRIO	CR	B891
1520	CASALFIUMANESE	BO	B892
1521	CASALGRANDE	RE	B893
1522	CASALGRASSO	CN	B894
1523	CASAL VELINO	SA	B895
1524	CASALINCONTRADA	CH	B896
1525	CASALINO	NO	B897
1526	CASALMAGGIORE	CR	B898
1527	CASALMAIOCCO	LO	B899
1528	CASALMORANO	CR	B900
1529	CASALMORO	MN	B901
1530	CASALNOCETO	AL	B902
1531	VILLAPIANA	CS	B903
1532	CASALNUOVO MONTEROTARO	FG	B904
1533	CASALNUOVO DI NAPOLI	NA	B905
1534	SAN PAOLO ALBANESE	PZ	B906
1535	CASALOLDO	MN	B907
1536	CASALPUSTERLENGO	LO	B910
1537	CASALROMANO	MN	B911
1538	CASALSERUGO	PD	B912
1539	POZZAGLIO ED UNITI	CR	B914
1540	TRINITAPOLI	BT	B915
1541	CASALUCE	CE	B916
1542	CASALVECCHIO DI PUGLIA	FG	B917
1543	CASALVECCHIO SICULO	ME	B918
1544	CASALVIERI	FR	B919
1545	CASALVOLONE	NO	B920
1546	CASALZUIGNO	VA	B921
1547	CASAMARCIANO	NA	B922
1548	CASAMASSIMA	BA	B923
1549	CASAMICCIOLA TERME	NA	B924
1550	CASANDRINO	NA	B925
1551	CASANOVA LERRONE	SV	B927
1552	CASANOVA ELVO	VC	B928
1553	CASANOVA LONATI	PV	B929
1554	CASAPE	RM	B932
1555	CASAPINTA	BI	B933
1556	CASAPROTA	RI	B934
1557	CASAPULLA	CE	B935
1558	CASARANO	LE	B936
1559	CASARGO	LC	B937
1560	CASARILE	MI	B938
1561	CASARZA LIGURE	GE	B939
1562	CASARSA DELLA DELIZIA	PN	B940
1563	CASASCO	AL	B941
1564	CASASCO D'INTELVI	CO	B942
1565	CASATENOVO	LC	B943
1566	CASATISMA	PV	B945
1567	CASAVATORE	NA	B946
1568	CASAZZA	BG	B947
1569	CASCIA	PG	B948
1570	CASCIAGO	VA	B949
1571	CASCINA	PI	B950
1572	SAN GIACOMO VERCELLESE	VC	B952
1573	CASCINETTE D'IVREA	TO	B953
1574	CASEI GEROLA	PV	B954
1575	CASELETTE	TO	B955
1576	CASELLA	GE	B956
1577	CASELLE LURANI	LO	B958
1578	CASELLE IN PITTARI	SA	B959
1579	CASELLE TORINESE	TO	B960
1580	CASELLE LANDI	LO	B961
1581	SCANDICCI	FI	B962
1582	CASERTA	CE	B963
1583	CASIER	TV	B965
1584	CASIGNANA	RC	B966
1585	CASINA	RE	B967
1586	CASTELSILANO	KR	B968
1587	CASTEL DI CASIO	BO	B969
1588	CASIRATE D'ADDA	BG	B971
1589	CASLINO D'ERBA	CO	B974
1590	CASNATE CON BERNATE	CO	B977
1591	CASNIGO	BG	B978
1592	CASOLA IN LUNIGIANA	MS	B979
1593	CASOLA DI NAPOLI	NA	B980
1594	CASOLA VALSENIO	RA	B982
1595	CASOLE BRUZIO	CS	B983
1596	CASOLE D'ELSA	SI	B984
1597	CASOLI	CH	B985
1598	CASORATE SEMPIONE	VA	B987
1599	CASORATE PRIMO	PV	B988
1600	CASOREZZO	MI	B989
1601	CASORIA	NA	B990
1602	CASORZO	AT	B991
1603	CASPOGGIO	SO	B993
1604	CASSACCO	UD	B994
1605	CASSAGO BRIANZA	LC	B996
1606	CASSANO IRPINO	AV	B997
1607	CASSANO DELLE MURGE	BA	B998
1608	CASSANO VALCUVIA	VA	B999
1609	CASSANO ALLO IONIO	CS	C002
1610	CASSANO D'ADDA	MI	C003
1611	CASSANO MAGNAGO	VA	C004
1612	CASSANO SPINOLA	AL	C005
1613	CASSARO	SR	C006
1614	CASSIGLIO	BG	C007
1615	PERO	MI	C013
1616	CASSINA DE' PECCHI	MI	C014
1617	CASSINA RIZZARDI	CO	C020
1618	CASSINASCO	AT	C022
1619	CASSINA VALSASSINA	LC	C024
1620	CASSINE	AL	C027
1621	CASSINELLE	AL	C030
1622	CASSINETTA DI LUGAGNANO	MI	C033
1623	CASSINO	FR	C034
1624	CASSOLA	VI	C037
1625	CASSOLNOVO	PV	C038
1626	CASTEL CASTAGNA	TE	C040
1627	CASTAGNARO	VR	C041
1628	CASTAGNETO CARDUCCI	LI	C044
1629	CASTAGNETO PO	TO	C045
1630	CASTAGNITO	CN	C046
1631	CASTAGNOLE MONFERRATO	AT	C047
1632	CASTAGNOLE PIEMONTE	TO	C048
1633	CASTAGNOLE DELLE LANZE	AT	C049
1634	CASTANA	PV	C050
1635	CASTELL'UMBERTO	ME	C051
1636	CASTANO PRIMO	MI	C052
1637	CASTEGGIO	PV	C053
1638	CASTEGNATO	BS	C055
1639	CASTEGNERO	VI	C056
1640	CASTELBALDO	PD	C057
1641	CASTEL BARONIA	AV	C058
1642	CASTELBELFORTE	MN	C059
1643	CASTELBELLINO	AN	C060
1644	CASTELBELLO-CIARDES * KASTELBELL-TSCHARS	BZ	C062
1645	CASTELBIANCO	SV	C063
1646	CASTEL BOGLIONE	AT	C064
1647	CASTEL BOLOGNESE	RA	C065
1648	CASTELBOTTACCIO	CB	C066
1649	CASTELBUONO	PA	C067
1650	CASTELCIVITA	SA	C069
1651	SERVIGLIANO	FM	C070
1652	CASTEL COLONNA	AN	C071
1653	CASTELCOVATI	BS	C072
1654	CASTELCUCCO	TV	C073
1655	CASTELDACCIA	PA	C074
1656	CASTEL D'AIANO	BO	C075
1657	CASTEL D'ARIO	MN	C076
1658	CASTEL D'AZZANO	VR	C078
1659	CASTELLI CALEPIO	BG	C079
1660	CASTELDELCI	RN	C080
1661	CASTELDELFINO	CN	C081
1662	CASTEL DEL GIUDICE	IS	C082
1663	CASTEL DEL MONTE	AQ	C083
1664	CASTEL DEL PIANO	GR	C085
1665	CASTEL DEL RIO	BO	C086
1666	CASTELDIDONE	CR	C089
1667	CASTEL DI IERI	AQ	C090
1668	CASTEL DI IUDICA	CT	C091
1669	CASTEL DI LAMA	AP	C093
1670	CASTEL DI LUCIO	ME	C094
1671	CASTEL DI SANGRO	AQ	C096
1672	CASTEL DI SASSO	CE	C097
1673	CASTEL DI TORA	RI	C098
1674	CASTEL DOBRA	GO	C099
1675	CASTELFIDARDO	AN	C100
1676	CASTELFIORENTINO	FI	C101
1677	CASTEL FOCOGNANO	AR	C102
1678	CASTELFONDO	TN	C103
1679	CASTELFORTE	LT	C104
1680	CASTELFRANCI	AV	C105
1681	CASTELFRANCO IN MISCANO	BN	C106
1682	CASTELFRANCO EMILIA	MO	C107
1683	CASTROLIBERO	CS	C108
1684	CASTEL VITTORIO	IM	C110
1685	CASTELFRANCO VENETO	TV	C111
1686	CASTELFRANCO DI SOPRA	AR	C112
1687	CASTELFRANCO DI SOTTO	PI	C113
1688	CASTEL FRENTANO	CH	C114
1689	CASTEL GABBIANO	CR	C115
1690	CASTEL GANDOLFO	RM	C116
1691	CASTEL GIORGIO	TR	C117
1692	CASTEL GOFFREDO	MN	C118
1693	CASTELGOMBERTO	VI	C119
1694	CASTELGRANDE	PZ	C120
1695	CASTEL GUELFO DI BOLOGNA	BO	C121
1696	CASTELGUGLIELMO	RO	C122
1697	CASTELGUIDONE	CH	C123
1699	CASTELLABATE	SA	C125
1700	CASTELLAFIUME	AQ	C126
1701	CASTELL'ALFERO	AT	C127
1702	CASTELLALTO	TE	C128
1703	CASTELLAMMARE DI STABIA	NA	C129
1704	CASTELLAMMARE DEL GOLFO	TP	C130
1705	CASTELLAMONTE	TO	C133
1706	CASTELLANA GROTTE	BA	C134
1707	CASTELLANA SICULA	PA	C135
1708	CASTELLANETA	TA	C136
1709	CASTELLANIA	AL	C137
1710	CASTELLANZA	VA	C139
1711	CASTELLAR	CN	C140
1712	CASTELLARANO	RE	C141
1713	CASTELLAR GUIDOBONO	AL	C142
1714	CASTELLARO	IM	C143
1715	CASTELL'ARQUATO	PC	C145
1716	CASTELLAVAZZO	BL	C146
1717	CASTELL'AZZARA	GR	C147
1718	CASTELLAZZO BORMIDA	AL	C148
1719	CASTELLAZZO NOVARESE	NO	C149
1720	CASTELLEONE DI SUASA	AN	C152
1721	CASTELLEONE	CR	C153
1722	CASTELLERO	AT	C154
1723	CASTELLETTO CERVO	BI	C155
1724	CASTELLETTO D'ERRO	AL	C156
1725	CASTELLETTO DI BRANDUZZO	PV	C157
1726	CASTELLETTO D'ORBA	AL	C158
1727	CASTELLETTO MERLI	AL	C160
1728	CASTELLETTO MOLINA	AT	C161
1729	CASTELLETTO MONFERRATO	AL	C162
1730	CASTELLETTO STURA	CN	C165
1731	CASTELLETTO SOPRA TICINO	NO	C166
1732	CASTELLETTO UZZONE	CN	C167
1733	CASTELLI	TE	C169
1734	CASTELLINA IN CHIANTI	SI	C172
1735	CASTELLINALDO	CN	C173
1736	CASTELLINA MARITTIMA	PI	C174
1737	CASTELLINO DEL BIFERNO	CB	C175
1738	CASTELLINO TANARO	CN	C176
1739	CASTELLIRI	FR	C177
1740	CASTELLO DEL MATESE	CE	C178
1741	CASTELVECCANA	VA	C181
1742	CASTEL CONDINO	TN	C183
1743	CASTELLO D'AGOGNA	PV	C184
1744	CASTELLO D'ARGILE	BO	C185
1745	CASTELLO DELL'ACQUA	SO	C186
1746	CASTELLO DI BRIANZA	LC	C187
1747	CASTELLO DI CISTERNA	NA	C188
1748	CASTELLO-MOLINA DI FIEMME	TN	C189
1749	CASTELLO DI GODEGO	TV	C190
1750	CASTELLO DI SERRAVALLE	BO	C191
1751	CASTELLO TESINO	TN	C194
1752	CASTELLUCCHIO	MN	C195
1753	CASTELMAURO	CB	C197
1754	CASTELLUCCIO DEI SAURI	FG	C198
1755	CASTELLUCCIO INFERIORE	PZ	C199
1756	CASTELVERRINO	IS	C200
1757	CASTELLUCCIO SUPERIORE	PZ	C201
1758	CASTELLUCCIO VALMAGGIORE	FG	C202
1759	CASTEL MADAMA	RM	C203
1760	CASTEL MAGGIORE	BO	C204
1761	CASTELMAGNO	CN	C205
1762	CASTELMARTE	CO	C206
1763	CASTELMASSA	RO	C207
1764	CASTEL MELLA	BS	C208
1765	CASTELMEZZANO	PZ	C209
1766	CASTELMOLA	ME	C210
1767	CASTEL MORRONE	CE	C211
1768	CASTELNOVETTO	PV	C213
1769	CASTELNUOVO DI CEVA	CN	C214
1770	CASTELNOVO BARIANO	RO	C215
1771	CASTELNUOVO	TN	C216
1772	CASTELNOVO DEL FRIULI	PN	C217
1773	CASTELNOVO DI SOTTO	RE	C218
1774	CASTELNOVO NE' MONTI	RE	C219
1775	CASTELNUOVO BOZZENTE	CO	C220
1776	CASTELNUOVO DELLA DAUNIA	FG	C222
1777	CASTELNUOVO PARANO	FR	C223
1778	CASTELNUOVO DI FARFA	RI	C224
1779	CASTELNUOVO DEL GARDA	VR	C225
1780	CASTELNUOVO BELBO	AT	C226
1781	CASTELNUOVO BERARDENGA	SI	C227
1782	CASTELNUOVO BOCCA D'ADDA	LO	C228
1783	CASTELNUOVO BORMIDA	AL	C229
1784	CASTELNUOVO CALCEA	AT	C230
1785	CASTELNUOVO CILENTO	SA	C231
1786	CASTELNUOVO DON BOSCO	AT	C232
1787	CASTELNUOVO DI CONZA	SA	C235
1788	CASTELNUOVO DI GARFAGNANA	LU	C236
1789	CASTELNUOVO DI PORTO	RM	C237
1791	CASTELNUOVO MAGRA	SP	C240
1792	CASTELNUOVO NIGRA	TO	C241
1793	CASTELNUOVO RANGONE	MO	C242
1794	CASTELNUOVO SCRIVIA	AL	C243
1795	CASTELNUOVO VAL DI CECINA	PI	C244
1796	CASTELPAGANO	BN	C245
1797	CASTELPETROSO	IS	C246
1798	CASTELPIZZUTO	IS	C247
1799	CASTELPLANIO	AN	C248
1800	CASTELPOTO	BN	C250
1801	CASTELRAIMONDO	MC	C251
1802	CASTEL RITALDI	PG	C252
1803	CASTEL ROCCHERO	AT	C253
1804	CASTELROTTO * KASTELRUTH	BZ	C254
1805	CASTEL ROZZONE	BG	C255
1806	CASTEL SAN GIORGIO	SA	C259
1807	CASTEL SAN GIOVANNI	PC	C261
1808	CASTEL SAN LORENZO	SA	C262
1809	CASTEL SAN NICCOLO'	AR	C263
1810	CASTEL SAN PIETRO TERME	BO	C265
1811	CASTEL SAN PIETRO ROMANO	RM	C266
1812	CASTELSANTANGELO SUL NERA	MC	C267
1813	CASTEL SANT'ANGELO	RI	C268
1814	CASTEL SANT'ELIA	VT	C269
1815	CASTEL SAN VINCENZO	IS	C270
1816	CASTELSARACENO	PZ	C271
1817	CASTELSARDO	SS	C272
1818	CASTELSEPRIO	VA	C273
1819	CASTELSPINA	AL	C274
1820	CASTELTERMINI	AG	C275
1821	CASTELVECCHIO DI ROCCA BARBENA	SV	C276
1822	CASTELVECCHIO CALVISIO	AQ	C278
1823	CASTELVECCHIO SUBEQUO	AQ	C279
1824	CASTELVENERE	BN	C280
1825	VERRES	AO	C282
1826	CASTELVETERE SUL CALORE	AV	C283
1827	CASTELVETERE IN VAL FORTORE	BN	C284
1828	CAULONIA	RC	C285
1829	CASTELVETRANO	TP	C286
1830	CASTELVETRO DI MODENA	MO	C287
1831	CASTELVETRO PIACENTINO	PC	C288
1832	CASTEL VISCARDO	TR	C289
1833	CASTELVISCONTI	CR	C290
1834	CASTEL VOLTURNO	CE	C291
1835	CASTENASO	BO	C292
1836	CASTENEDOLO	BS	C293
1837	CHATILLON	AO	C294
1838	CASTIGLIONE DEI PEPOLI	BO	C296
1839	CASTIGLIONE DI SICILIA	CT	C297
1840	CASTIGLIONE MESSER MARINO	CH	C298
1841	CASTIGLIONE D'INTELVI	CO	C299
1842	CASTIGLIONE OLONA	VA	C300
1843	CASTIGLIONE COSENTINO	CS	C301
1844	CASTIGLIONE CHIAVARESE	GE	C302
1845	CASTIGLIONE DI GARFAGNANA	LU	C303
1846	CASTIGLIONE D'ADDA	LO	C304
1847	CASTIGLIONE DEL GENOVESI	SA	C306
1848	CASTIGLIONE TORINESE	TO	C307
1849	CASTIGLIONE A CASAURIA	PE	C308
1850	CASTIGLIONE DEL LAGO	PG	C309
1851	CASTIGLIONE DELLA PESCAIA	GR	C310
1852	COLLEDARA	TE	C311
1853	CASTIGLIONE DELLE STIVIERE	MN	C312
1854	CASTIGLIONE D'ORCIA	SI	C313
1855	CASTIGLIONE FALLETTO	CN	C314
1856	CASTIGLIONE IN TEVERINA	VT	C315
1857	CASTIGLIONE MESSER RAIMONDO	TE	C316
1858	CASTIGLIONE TINELLA	CN	C317
1859	CASTIGLION FIBOCCHI	AR	C318
1860	CASTIGLION FIORENTINO	AR	C319
1861	CASTIGNANO	AP	C321
1862	CASTILENTI	TE	C322
1863	CASTINO	CN	C323
1864	CASTIONE DELLA PRESOLANA	BG	C324
1865	CASTIONE ANDEVENNO	SO	C325
1866	CASTIONS DI STRADA	UD	C327
1867	CASTIRAGA VIDARDO	LO	C329
1868	CASTO	BS	C330
1869	CASTORANO	AP	C331
1870	CASTREZZATO	BS	C332
1871	CASTRI DI LECCE	LE	C334
1872	CASTRIGNANO DE' GRECI	LE	C335
1873	CASTRIGNANO DEL CAPO	LE	C336
1874	CASTRO	BG	C337
1875	CASTRO DEI VOLSCI	FR	C338
1876	CASTROCARO TERME E TERRA DEL SOLE	FC	C339
1877	CASTROCIELO	FR	C340
1878	CASTROFILIPPO	AG	C341
1879	ENNA	EN	C342
1880	CASTRONNO	VA	C343
1881	CASTRONOVO DI SICILIA	PA	C344
1882	CASTRONUOVO DI SANT'ANDREA	PZ	C345
1883	CASTROPIGNANO	CB	C346
1884	CASTROREALE	ME	C347
1885	CASTROREGIO	CS	C348
1886	CASTROVILLARI	CS	C349
1887	CATANIA	CT	C351
1888	CATANZARO	CZ	C352
1889	CATENANUOVA	EN	C353
1890	CATIGNANO	PE	C354
1891	CATTOLICA ERACLEA	AG	C356
1892	CATTOLICA	RN	C357
1893	CAUTANO	BN	C359
1894	CAVA MANARA	PV	C360
1895	CAVA DE' TIRRENI	SA	C361
1896	CAVACURTA	LO	C362
1897	CAVAGLIA'	BI	C363
1898	CAVAGLIETTO	NO	C364
1899	CAVAGLIO D'AGOGNA	NO	C365
1900	CAVAGLIO-SPOCCIA	VB	C367
1901	CAVAGNOLO	TO	C369
1902	CAVAION VERONESE	VR	C370
1903	CAVALESE	TN	C372
1904	CAVALLASCA	CO	C374
1905	CAVALLERLEONE	CN	C375
1906	CAVALLERMAGGIORE	CN	C376
1907	CAVALLINO	LE	C377
1908	CAVALLIRIO	NO	C378
1909	CAVARENO	TN	C380
1910	CAVARGNA	CO	C381
1911	CAVARIA CON PREMEZZO	VA	C382
1912	CAVARZERE	VE	C383
1913	CAVASO DEL TOMBA	TV	C384
1914	CAVASSO NUOVO	PN	C385
1915	CAVATORE	AL	C387
1916	JESOLO	VE	C388
1917	CAVAZZO CARNICO	UD	C389
1918	CAVE	RM	C390
1919	CAVE AUREMIANE	TS	C391
1920	CAVEDAGO	TN	C392
1921	CAVEDINE	TN	C393
1922	CAVENAGO D'ADDA	LO	C394
1923	CAVENAGO DI BRIANZA	MB	C395
1924	CAVERNAGO	BG	C396
1925	CAVEZZO	MO	C398
1926	CAVIZZANA	TN	C400
1927	CAVOUR	TO	C404
1928	CAVRIAGO	RE	C405
1929	CAVRIANA	MN	C406
1930	CAVRIGLIA	AR	C407
1931	CAZZAGO SAN MARTINO	BS	C408
1932	CAZZAGO BRABBIA	VA	C409
1933	CAZZANO SANT'ANDREA	BG	C410
1934	CAZZANO DI TRAMIGNA	VR	C412
1935	CECCANO	FR	C413
1936	CECIMA	PV	C414
1937	CECINA	LI	C415
1938	CEDEGOLO	BS	C417
1939	CEDRASCO	SO	C418
1940	CEFALA' DIANA	PA	C420
1941	CEFALU'	PA	C421
1942	CEGGIA	VE	C422
1943	CEGLIE MESSAPICA	BR	C424
1944	CELANO	AQ	C426
1945	CELENZA SUL TRIGNO	CH	C428
1946	CELENZA VALFORTORE	FG	C429
1947	CELICO	CS	C430
1948	CELLA MONTE	AL	C432
1949	CELLA DATI	CR	C435
1950	CELLAMARE	BA	C436
1951	CELLARA	CS	C437
1952	CELLARENGO	AT	C438
1953	CELLATICA	BS	C439
1954	CELLE ENOMONDO	AT	C440
1955	CELLE DI MACRA	CN	C441
1956	CELLE SAN VITO	FG	C442
1957	CELLE LIGURE	SV	C443
1958	CELLE DI BULGHERIA	SA	C444
1959	CELLENO	VT	C446
1960	CELLERE	VT	C447
1961	CELLINO SAN MARCO	BR	C448
1962	CELLINO ATTANASIO	TE	C449
1963	CELLIO	VC	C450
1964	CEMBRA	TN	C452
1965	CENADI	CZ	C453
1966	CENATE SOPRA	BG	C456
1967	CENATE SOTTO	BG	C457
1968	CENCENIGHE AGORDINO	BL	C458
1969	CENE	BG	C459
1970	CENESELLI	RO	C461
1971	CENGIO	SV	C463
1972	CENTALLO	CN	C466
1973	CENTA SAN NICOLO'	TN	C467
1974	CENTO	FE	C469
1975	CENTOLA	SA	C470
1976	CENTURIPE	EN	C471
1977	CENTRACHE	CZ	C472
1978	CEPAGATTI	PE	C474
1979	CEPPALONI	BN	C476
1980	CEPPO MORELLI	VB	C478
1981	CEPRANO	FR	C479
1982	CERAMI	EN	C480
1983	CERANESI	GE	C481
1984	CERANO D'INTELVI	CO	C482
1985	CERANO	NO	C483
1986	CERANOVA	PV	C484
1987	CERASO	SA	C485
1988	CERCEMAGGIORE	CB	C486
1989	CERCENASCO	TO	C487
1990	CERCEPICCOLA	CB	C488
1991	CERCHIARA DI CALABRIA	CS	C489
1992	CERCHIO	AQ	C492
1993	CERCINO	SO	C493
1994	CERCIVENTO	UD	C494
1995	CERCOLA	NA	C495
1996	CERDA	PA	C496
1997	CERES	TO	C497
1998	CEREA	VR	C498
1999	CEREGNANO	RO	C500
2000	CERENZIA	KR	C501
2001	CERESARA	MN	C502
2002	CERESETO	AL	C503
2003	CERESOLE ALBA	CN	C504
2004	CERESOLE REALE	TO	C505
2005	CERETE	BG	C506
2006	CERRETO GRUE	AL	C507
2007	CERETTO LOMELLINA	PV	C508
2008	CERGNAGO	PV	C509
2009	CERIALE	SV	C510
2010	CERIANA	IM	C511
2011	CERIANO LAGHETTO	MB	C512
2012	CERIGNALE	PC	C513
2013	CERIGNOLA	FG	C514
2014	CERISANO	CS	C515
2015	CERMENATE	CO	C516
2016	CERMIGNANO	TE	C517
2017	CERRETO LAZIALE	RM	C518
2018	CERNIZZA GORIZIANA	GO	C519
2019	CERNOBBIO	CO	C520
2020	CERNUSCO LOMBARDONE	LC	C521
2021	CERNUSCO SUL NAVIGLIO	MI	C523
2022	CERRETO D'ESI	AN	C524
2023	CERRETO SANNITA	BN	C525
2024	CERRETO CASTELLO	BI	C526
2025	CERRETO DI SPOLETO	PG	C527
2026	CERRETO D'ASTI	AT	C528
2027	CERRETO GUIDI	FI	C529
2028	CERRETTO LANGHE	CN	C530
2029	CERRINA	AL	C531
2030	CERRIONE	BI	C532
2031	CERRO TANARO	AT	C533
2032	CERRO AL VOLTURNO	IS	C534
2033	CERRO AL LAMBRO	MI	C536
2034	CERRO MAGGIORE	MI	C537
2035	CERRO VERONESE	VR	C538
2036	CERSOSIMO	PZ	C539
2037	CERTALDO	FI	C540
2038	CERTOSA DI PAVIA	PV	C541
2039	CERVA	CZ	C542
2040	CERVARA DI ROMA	RM	C543
2041	CERVARESE SANTA CROCE	PD	C544
2042	CERVARO	FR	C545
2043	CERVASCA	CN	C547
2044	CERVATTO	VC	C548
2045	CERVENO	BS	C549
2046	CERVERE	CN	C550
2047	CERVESINA	PV	C551
2048	CERVETERI	RM	C552
2049	CERVIA	RA	C553
2050	CERVICATI	CS	C554
2051	CERVIGNANO D'ADDA	LO	C555
2052	CERVIGNANO DEL FRIULI	UD	C556
2053	CERVINARA	AV	C557
2054	CERVINO	CE	C558
2055	CERVO	IM	C559
2056	CERZETO	CS	C560
2057	CESA	CE	C561
2058	LENTIAI	BL	C562
2059	CESANA BRIANZA	LC	C563
2060	CESANA TORINESE	TO	C564
2061	CESANO BOSCONE	MI	C565
2062	CESANO MADERNO	MB	C566
2063	CESARA	VB	C567
2064	CESARO'	ME	C568
2065	CESATE	MI	C569
2066	CESENA	FC	C573
2067	CESENATICO	FC	C574
2068	CESINALI	AV	C576
2069	CESIOMAGGIORE	BL	C577
2070	CESIO	IM	C578
2071	CESSALTO	TV	C580
2072	CESSANITI	VV	C581
2073	CESSAPALOMBO	MC	C582
2074	CESSOLE	AT	C583
2075	CETARA	SA	C584
2076	CETO	BS	C585
2077	CETONA	SI	C587
2078	CETRARO	CS	C588
2079	CEVA	CN	C589
2080	CEVO	BS	C591
2081	CHALLAND-SAINT-ANSELME	AO	C593
2082	CHALLAND-SAINT-VICTOR	AO	C594
2083	CHAMBAVE	AO	C595
2084	CHAMPDEPRAZ	AO	C596
2085	CHARVENSOD	AO	C598
2086	CHERASCO	CN	C599
2087	CHEREMULE	SS	C600
2089	CHIALAMBERTO	TO	C604
2090	CHIAMPO	VI	C605
2091	CHIANCHE	AV	C606
2092	CHIANCIANO TERME	SI	C608
2093	CHIANNI	PI	C609
2094	CHIANOCCO	TO	C610
2095	CHIAPOVANO	GO	C611
2096	CHIARAMONTE GULFI	RG	C612
2097	CHIARAMONTI	SS	C613
2098	CHIARANO	TV	C614
2099	CHIARAVALLE	AN	C615
2100	CHIARAVALLE CENTRALE	CZ	C616
2101	CHIARI	BS	C618
2102	CHIAROMONTE	PZ	C619
2103	CHIAUCI	IS	C620
2104	CHIAVARI	GE	C621
2105	CHIAVENNA	SO	C623
2106	CHIAVERANO	TO	C624
2107	CHIENES * KIENS	BZ	C625
2108	CHIERI	TO	C627
2109	CHIESA IN VALMALENCO	SO	C628
2110	CHIESANUOVA	TO	C629
2111	CHIES D'ALPAGO	BL	C630
2112	CHIESINA UZZANESE	PT	C631
2113	CHIETI	CH	C632
2114	CHIEUTI	FG	C633
2115	CHIEVE	CR	C634
2116	CHIGNOLO D'ISOLA	BG	C635
2117	CHIGNOLO PO	PV	C637
2118	CHIOGGIA	VE	C638
2119	CHIOMONTE	TO	C639
2120	CHIONS	PN	C640
2121	CHIOPRIS VISCONE	UD	C641
2122	CHITIGNANO	AR	C648
2123	CHIUDUNO	BG	C649
2124	CHIUPPANO	VI	C650
2125	CHIURO	SO	C651
2126	CHIUSA * KLAUSEN	BZ	C652
2127	CHIUSA DI PESIO	CN	C653
2128	CHIUSA SCLAFANI	PA	C654
2129	CHIUSA DI SAN MICHELE	TO	C655
2130	CHIUSAFORTE	UD	C656
2131	CHIUSANICO	IM	C657
2132	CHIUSANO D'ASTI	AT	C658
2133	CHIUSANO DI SAN DOMENICO	AV	C659
2134	CHIUSAVECCHIA	IM	C660
2135	CHIUSDINO	SI	C661
2136	CHIUSI	SI	C662
2137	CHIUSI DELLA VERNA	AR	C663
2138	CHIVASSO	TO	C665
2139	CIANCIANA	AG	C668
2140	CANOSSA	RE	C669
2141	CROCETTA DEL MONTELLO	TV	C670
2142	CIBIANA DI CADORE	BL	C672
2143	CICAGNA	GE	C673
2144	CICALA	CZ	C674
2145	CICCIANO	NA	C675
2146	CICERALE	SA	C676
2147	CICILIANO	RM	C677
2148	CICOGNOLO	CR	C678
2149	CICONIO	TO	C679
2150	CIGLIANO	VC	C680
2151	CIGLIE'	CN	C681
2152	CIGOGNOLA	PV	C684
2153	CIGOLE	BS	C685
2154	CILAVEGNA	PV	C686
2155	CIMADOLMO	TV	C689
2156	CIMBERGO	BS	C691
2157	CIMEGO	TN	C694
2158	CIMINA'	RC	C695
2159	CIMINNA	PA	C696
2160	CIMITILE	NA	C697
2161	TAVERNOLE SUL MELLA	BS	C698
2162	CIMOLAIS	PN	C699
2163	CIMONE	TN	C700
2164	CINAGLIO	AT	C701
2165	CINETO ROMANO	RM	C702
2166	CINGIA DE' BOTTI	CR	C703
2167	CINGOLI	MC	C704
2168	CINIGIANO	GR	C705
2169	CINISELLO BALSAMO	MI	C707
2170	CINISI	PA	C708
2171	CINO	SO	C709
2172	CINQUEFRONDI	RC	C710
2173	CINTANO	TO	C711
2174	CINTE TESINO	TN	C712
2175	CINTO EUGANEO	PD	C713
2176	CINTO CAOMAGGIORE	VE	C714
2177	CINZANO	TO	C715
2178	CIORLANO	CE	C716
2179	SANTA MARIA DEL CEDRO	CS	C717
2180	CIPRESSA	IM	C718
2181	CIRCELLO	BN	C719
2182	CIRCHINA	GO	C720
2183	CIRIE'	TO	C722
2184	CIRIGLIANO	MT	C723
2185	CIRIMIDO	CO	C724
2186	CIRO'	KR	C725
2187	CIRO' MARINA	KR	C726
2188	CIS	TN	C727
2189	CISANO BERGAMASCO	BG	C728
2190	CISANO SUL NEVA	SV	C729
2191	CISERANO	BG	C730
2192	CISLAGO	VA	C732
2193	CISLIANO	MI	C733
2194	CISMON DEL GRAPPA	VI	C734
2195	CISON DI VALMARINO	TV	C735
2196	CISSONE	CN	C738
2197	CISTERNA D'ASTI	AT	C739
2198	CISTERNA DI LATINA	LT	C740
2199	CISTERNINO	BR	C741
2200	CITERNA	PG	C742
2201	CITTADELLA	PD	C743
2202	CITTA' DELLA PIEVE	PG	C744
2203	CITTA' DI CASTELLO	PG	C745
2204	CITTADUCALE	RI	C746
2205	CITTANOVA	RC	C747
2207	CITTAREALE	RI	C749
2208	CITTA' SANT'ANGELO	PE	C750
2209	CITTIGLIO	VA	C751
2210	CIVATE	LC	C752
2211	CIVENNA	CO	C754
2212	CIVEZZA	IM	C755
2213	CIVEZZANO	TN	C756
2214	CIVIASCO	VC	C757
2215	CIVIDALE DEL FRIULI	UD	C758
2216	CIVIDATE AL PIANO	BG	C759
2217	CIVIDATE CAMUNO	BS	C760
2218	CIVITA	CS	C763
2219	CIVITACAMPOMARANO	CB	C764
2220	CIVITA CASTELLANA	VT	C765
2221	CIVITA D'ANTINO	AQ	C766
2222	LANUVIO	RM	C767
2223	CIVITALUPARELLA	CH	C768
2224	CIVITANOVA DEL SANNIO	IS	C769
2225	CIVITANOVA MARCHE	MC	C770
2226	CIVITAQUANA	PE	C771
2227	DURONIA	CB	C772
2228	CIVITAVECCHIA	RM	C773
2229	CIVITELLA IN VAL DI CHIANA	AR	C774
2230	CIVITELLA MESSER RAIMONDO	CH	C776
2231	CIVITELLA DI ROMAGNA	FC	C777
2232	CIVITELLA ALFEDENA	AQ	C778
2233	CIVITELLA CASANOVA	PE	C779
2234	CIVITELLA D'AGLIANO	VT	C780
2235	CIVITELLA DEL TRONTO	TE	C781
2236	CIVITELLA PAGANICO	GR	C782
2237	CIVITELLA ROVETO	AQ	C783
2238	CIVITELLA SAN PAOLO	RM	C784
2239	CIVO	SO	C785
2240	CLAINO CON OSTENO	CO	C787
2242	UBIALE CLANEZZO	BG	C789
2243	CLAUT	PN	C790
2244	CLAUZETTO	PN	C791
2245	CLAVESANA	CN	C792
2246	CLAVIERE	TO	C793
2247	CLES	TN	C794
2248	CLETO	CS	C795
2249	CLIVIO	VA	C796
2250	CLOZ	TN	C797
2251	CLUSONE	BG	C800
2252	COASSOLO TORINESE	TO	C801
2253	COAZZE	TO	C803
2254	COAZZOLO	AT	C804
2255	COCCAGLIO	BS	C806
2256	COCCONATO	AT	C807
2257	COCQUIO-TREVISAGO	VA	C810
2258	COCULLO	AQ	C811
2259	CODEVIGO	PD	C812
2260	CODEVILLA	PV	C813
2261	CODIGORO	FE	C814
2262	CODOGNE'	TV	C815
2263	CODOGNO	LO	C816
2264	CODROIPO	UD	C817
2265	CODRONGIANUS	SS	C818
2266	COGGIOLA	BI	C819
2267	COGLIATE	MB	C820
2268	COGNE	AO	C821
2269	COGOLETO	GE	C823
2270	COGOLLO DEL CENGIO	VI	C824
2271	COGORNO	GE	C826
2272	COLAZZA	NO	C829
2273	COLBORDOLO	PU	C830
2274	COLERE	BG	C835
2275	COLFELICE	FR	C836
2276	COLI	PC	C838
2277	COLICO	LC	C839
2278	COLLAGNA	RE	C840
2279	COLLALTO SABINO	RI	C841
2280	COLLARMELE	AQ	C844
2281	COLLAZZONE	PG	C845
2282	COLLE SANNITA	BN	C846
2283	COLLE DI VAL D'ELSA	SI	C847
2284	COLLE UMBERTO	TV	C848
2285	COLLEBEATO	BS	C850
2286	COLLE BRIANZA	LC	C851
2287	COLLECCHIO	PR	C852
2288	COLLECORVINO	PE	C853
2289	COLLE D'ANCHISE	CB	C854
2290	COLLEDIMACINE	CH	C855
2291	COLLEDIMEZZO	CH	C856
2292	COLLE DI TORA	RI	C857
2293	COLLEFERRO	RM	C858
2294	COLLEGIOVE	RI	C859
2295	COLLEGNO	TO	C860
2296	COLLELONGO	AQ	C862
2297	COLLEPARDO	FR	C864
2298	COLLEPASSO	LE	C865
2299	COLLEPIETRO	AQ	C866
2300	COLLERETTO CASTELNUOVO	TO	C867
2301	COLLERETTO GIACOSA	TO	C868
2302	COLLESALVETTI	LI	C869
2303	COLLE SAN MAGNO	FR	C870
2304	COLLESANO	PA	C871
2305	COLLE SANTA LUCIA	BL	C872
2306	COLLETORTO	CB	C875
2307	COLLEVECCHIO	RI	C876
2308	COLLI DEL TRONTO	AP	C877
2309	COLLI A VOLTURNO	IS	C878
2310	COLLIANO	SA	C879
2311	COLLI SUL VELINO	RI	C880
2312	COLLINAS	VS	C882
2313	COLLIO	BS	C883
2314	COLLOBIANO	VC	C884
2315	COLLOREDO DI MONTE ALBANO	UD	C885
2316	COLMURANO	MC	C886
2317	COLOBRARO	MT	C888
2318	COLOGNA VENETA	VR	C890
2319	COLOGNE	BS	C893
2320	COLOGNO AL SERIO	BG	C894
2321	COLOGNO MONZESE	MI	C895
2322	COLOGNOLA AI COLLI	VR	C897
2323	COLONNA	RM	C900
2324	COLONNELLA	TE	C901
2325	COLONNO	CO	C902
2326	COLORINA	SO	C903
2327	COLORNO	PR	C904
2328	COLOSIMI	CS	C905
2329	COLTURANO	MI	C908
2330	COLZATE	BG	C910
2331	COMABBIO	VA	C911
2332	COMACCHIO	FE	C912
2333	COMANO	MS	C914
2334	COMAZZO	LO	C917
2335	COMEGLIANS	UD	C918
2336	SANTO STEFANO DI CADORE	BL	C919
2337	COMELICO SUPERIORE	BL	C920
2338	COMENO	GO	C921
2339	COMERIO	VA	C922
2340	COMEZZANO-CIZZAGO	BS	C925
2341	COMIGNAGO	NO	C926
2342	COMISO	RG	C927
2343	COMITINI	AG	C928
2344	COMIZIANO	NA	C929
2345	COMMESSAGGIO	MN	C930
2346	COMMEZZADURA	TN	C931
2347	COMO	CO	C933
2348	COMPIANO	PR	C934
2349	COMUNANZA	AP	C935
2350	VALSOLDA	CO	C936
2351	COMUN NUOVO	BG	C937
2352	CONA	VE	C938
2353	CONCA DELLA CAMPANIA	CE	C939
2354	CONCA DEI MARINI	SA	C940
2355	CONCA CASALE	IS	C941
2356	CONCAMARISE	VR	C943
2357	CONCERVIANO	RI	C946
2358	CONCESIO	BS	C948
2359	CONCO	VI	C949
2360	CONCORDIA SAGITTARIA	VE	C950
2361	CONCORDIA SULLA SECCHIA	MO	C951
2362	CONCOREZZO	MB	C952
2363	CONDINO	TN	C953
2364	CONDOFURI	RC	C954
2365	CONDOVE	TO	C955
2366	CONDRO'	ME	C956
2367	CONEGLIANO	TV	C957
2368	CONFIENZA	PV	C958
2369	CONFIGNI	RI	C959
2370	CONFLENTI	CZ	C960
2371	CONIOLO	AL	C962
2372	CONSELICE	RA	C963
2373	CONSELVE	PD	C964
2374	CONSIGLIO DI RUMO	CO	C965
2375	CONTESSA ENTELLINA	PA	C968
2376	CONTIGLIANO	RI	C969
2377	CONTRADA	AV	C971
2378	CONTROGUERRA	TE	C972
2379	CONTRONE	SA	C973
2380	CONTURSI TERME	SA	C974
2381	CONVERSANO	BA	C975
2382	CONZA DELLA CAMPANIA	AV	C976
2383	CONZANO	AL	C977
2384	COPERTINO	LE	C978
2385	COPIANO	PV	C979
2386	COPPARO	FE	C980
2387	CORANA	PV	C982
2388	CORATO	BA	C983
2389	CORBARA	SA	C984
2390	CORBETTA	MI	C986
2391	CORBOLA	RO	C987
2392	CORCHIANO	VT	C988
2393	CORCIANO	PG	C990
2394	CORDENONS	PN	C991
2395	CORDIGNANO	TV	C992
2396	CORDOVADO	PN	C993
2397	COREDO	TN	C994
2398	COREGLIA LIGURE	GE	C995
2399	COREGLIA ANTELMINELLI	LU	C996
2400	CORENO AUSONIO	FR	C998
2401	CORFINIO	AQ	C999
2402	CORGNALE	TS	D002
2403	CORI	LT	D003
2404	CORIANO	RN	D004
2405	CORIGLIANO CALABRO	CS	D005
2406	CORIGLIANO D'OTRANTO	LE	D006
2407	CORINALDO	AN	D007
2408	CORIO	TO	D008
2409	CORLEONE	PA	D009
2410	CORLETO PERTICARA	PZ	D010
2411	CORLETO MONFORTE	SA	D011
2412	COURMAYEUR	AO	D012
2413	CORMANO	MI	D013
2414	CORMONS	GO	D014
2415	CORNA IMAGNA	BG	D015
2416	CORNALBA	BG	D016
2417	CORNALE	PV	D017
2418	CORNAREDO	MI	D018
2419	CORNATE D'ADDA	MB	D019
2420	CORNEDO VICENTINO	VI	D020
2421	CORNEGLIANO LAUDENSE	LO	D021
2422	CORNELIANO D'ALBA	CN	D022
2423	TARQUINIA	VT	D024
2424	CORNIGLIO	PR	D026
2425	CORNO DI ROSAZZO	UD	D027
2426	CORNO GIOVINE	LO	D028
2427	CORNOVECCHIO	LO	D029
2428	CORNUDA	TV	D030
2429	MORIMONDO	MI	D033
2430	CORREGGIO	RE	D037
2431	CORREZZANA	MB	D038
2432	CORREZZOLA	PD	D040
2433	CORRIDO	CO	D041
2434	CORRIDONIA	MC	D042
2435	CORROPOLI	TE	D043
2436	CORSANO	LE	D044
2437	CORSICO	MI	D045
2438	CORSIONE	AT	D046
2439	CORTACCIA SULLA STRADA DEL VINO * KURTATSCH AN DER WEINSTRASSE	BZ	D048
2440	CORTALE	CZ	D049
2441	CORTANDONE	AT	D050
2442	CORTANZE	AT	D051
2443	CORTAZZONE	AT	D052
2444	CORTE BRUGNATELLA	PC	D054
2445	CORTE DE' CORTESI CON CIGNONE	CR	D056
2446	CORTE DE' FRATI	CR	D057
2447	CORTE FRANCA	BS	D058
2448	CORTEMAGGIORE	PC	D061
2449	CORTEMILIA	CN	D062
2450	CORTENO GOLGI	BS	D064
2451	CORTENOVA	LC	D065
2452	CORTENUOVA	BG	D066
2453	CORTEOLONA	PV	D067
2454	CORTE PALASIO	LO	D068
2455	CORTIGLIONE	AT	D072
2456	CORTINA SULLA STRADA DEL VINO * KURTINIG AN DER WEINSTRASSE	BZ	D075
2457	CORTINO	TE	D076
2458	CORTONA	AR	D077
2459	CORVARA	PE	D078
2460	CORVARA IN BADIA * CORVARA	BZ	D079
2461	CORVINO SAN QUIRICO	PV	D081
2462	CORZANO	BS	D082
2463	COSEANO	UD	D085
2464	COSENZA	CS	D086
2465	COSIO D'ARROSCIA	IM	D087
2466	COSIO VALTELLINO	SO	D088
2467	COSOLETO	RC	D089
2468	COSSANA	TS	D090
2469	COSSANO CANAVESE	TO	D092
2470	COSSANO BELBO	CN	D093
2471	COSSATO	BI	D094
2472	COSSERIA	SV	D095
2473	COSSIGNANO	AP	D096
2474	COSSOGNO	VB	D099
2475	COSSOINE	SS	D100
2476	COSSOMBRATO	AT	D101
2477	COSTA VESCOVATO	AL	D102
2478	COSTA VALLE IMAGNA	BG	D103
2479	COSTA DI ROVIGO	RO	D105
2480	COSTABISSARA	VI	D107
2481	COSTACCIARO	PG	D108
2482	COSTA DE' NOBILI	PV	D109
2483	COSTA DI MEZZATE	BG	D110
2484	COSTA SERINA	BG	D111
2485	COSTA MASNAGA	LC	D112
2486	COSTANZANA	VC	D113
2487	COSTARAINERA	IM	D114
2488	COSTA VOLPINO	BG	D117
2489	COSTERMANO	VR	D118
2490	COSTIGLIOLE D'ASTI	AT	D119
2491	COSTIGLIOLE SALUZZO	CN	D120
2492	COTIGNOLA	RA	D121
2493	CROTONE	KR	D122
2494	COTRONEI	KR	D123
2495	COTTANELLO	RI	D124
2496	COVO	BG	D126
2497	COZZO	PV	D127
2498	CRACO	MT	D128
2499	CRANDOLA VALSASSINA	LC	D131
2500	CRAVAGLIANA	VC	D132
2501	CRAVANZANA	CN	D133
2502	CRAVEGGIA	VB	D134
2503	CREAZZO	VI	D136
2504	CRECCHIO	CH	D137
2505	CREDARO	BG	D139
2506	CREDERA RUBBIANO	CR	D141
2507	CREMA	CR	D142
2508	CREMELLA	LC	D143
2509	CREMENAGA	VA	D144
2510	CREMENO	LC	D145
2511	CREMIA	CO	D147
2512	CREMOLINO	AL	D149
2513	CREMONA	CR	D150
2514	CREMOSANO	CR	D151
2515	CRENOVIZZA	TS	D153
2516	CRESCENTINO	VC	D154
2517	CRESPADORO	VI	D156
2518	CRESPANO DEL GRAPPA	TV	D157
2519	CRESPELLANO	BO	D158
2520	CRESPIATICA	LO	D159
2521	CRESPINA	PI	D160
2522	CRESPINO	RO	D161
2523	CRESSA	NO	D162
2524	CREVACUORE	BI	D165
2525	CREVALCORE	BO	D166
2526	CREVOLADOSSOLA	VB	D168
2527	CRISPANO	NA	D170
2528	CRISPIANO	TA	D171
2529	CRISSOLO	CN	D172
2530	CROCEFIESCHI	GE	D175
2531	CRODO	VB	D177
2532	CROGNALETO	TE	D179
2533	CROPALATI	CS	D180
2534	CROPANI	CZ	D181
2535	CROSA	BI	D182
2536	CROSIA	CS	D184
2537	CROSIO DELLA VALLE	VA	D185
2538	CROTTA D'ADDA	CR	D186
2539	CROVA	VC	D187
2540	CROVIANA	TN	D188
2541	CRUCOLI	KR	D189
2542	CUASSO AL MONTE	VA	D192
2543	VERONELLA	VR	D193
2544	CUCCARO MONFERRATO	AL	D194
2545	CUCCARO VETERE	SA	D195
2546	CUCCIAGO	CO	D196
2547	CUCEGLIO	TO	D197
2548	CUGGIONO	MI	D198
2549	CUGLIATE-FABIASCO	VA	D199
2550	CUGLIERI	OR	D200
2551	CUGNOLI	PE	D201
2552	CUMIANA	TO	D202
2553	CUMIGNANO SUL NAVIGLIO	CR	D203
2554	CUNARDO	VA	D204
2555	CUNEO	CN	D205
2556	CUNEVO	TN	D206
2557	CUNICO	AT	D207
2558	CUORGNE'	TO	D208
2559	CUPELLO	CH	D209
2560	CUPRA MARITTIMA	AP	D210
2561	CUPRAMONTANA	AN	D211
2562	CURCURIS	OR	D214
2563	CUREGGIO	NO	D216
2564	CURIGLIA CON MONTEVIASCO	VA	D217
2565	CURINGA	CZ	D218
2566	CURINO	BI	D219
2567	CURNO	BG	D221
2568	CURON VENOSTA * GRAUN IM VINSCHGAU	BZ	D222
2569	CURSI	LE	D223
2570	CURSOLO-ORASSO	VB	D225
2571	CURTAROLO	PD	D226
2572	CURTATONE	MN	D227
2573	CURTI	CE	D228
2574	CUSAGO	MI	D229
2575	CUSANO MUTRI	BN	D230
2576	CUSANO MILANINO	MI	D231
2577	CUSINO	CO	D232
2578	CUSIO	BG	D233
2579	CUSTONACI	TP	D234
2580	CUTIGLIANO	PT	D235
2581	CUTRO	KR	D236
2582	CUTROFIANO	LE	D237
2583	CUVEGLIO	VA	D238
2584	CUVIO	VA	D239
2585	DAIANO	TN	D243
2586	DAIRAGO	MI	D244
2587	DALMINE	BG	D245
2588	DAMBEL	TN	D246
2589	DANTA DI CADORE	BL	D247
2590	DAONE	TN	D248
2591	DARE'	TN	D250
2592	DARFO BOARIO TERME	BS	D251
2593	DASA'	VV	D253
2594	DAVAGNA	GE	D255
2595	DAVERIO	VA	D256
2596	DAVOLI	CZ	D257
2597	DAZIO	SO	D258
2598	DECIMOMANNU	CA	D259
2599	DECIMOPUTZU	CA	D260
2600	DECOLLATURA	CZ	D261
2601	DEGO	SV	D264
2602	DEIVA MARINA	SP	D265
2603	DELEBIO	SO	D266
2604	DELIA	CL	D267
2605	DELIANUOVA	RC	D268
2606	DELICETO	FG	D269
2607	DELLO	BS	D270
2608	DEMONTE	CN	D271
2609	DENICE	AL	D272
2610	DENNO	TN	D273
2611	DERNICE	AL	D277
2612	DEROVERE	CR	D278
2613	DERUTA	PG	D279
2614	DERVIO	LC	D280
2615	DESANA	VC	D281
2616	DESENZANO DEL GARDA	BS	D284
2617	DESIO	MB	D286
2618	DESULO	NU	D287
2619	DIAMANTE	CS	D289
2620	SCIGLIANO	CS	D290
2621	DIANO D'ALBA	CN	D291
2622	TEGGIANO	SA	D292
2623	DIANO ARENTINO	IM	D293
2624	DIANO CASTELLO	IM	D296
2625	DIANO MARINA	IM	D297
2626	DIANO SAN PIETRO	IM	D298
2627	DICOMANO	FI	D299
2628	DIGNANO	UD	D300
2630	DIMARO	TN	D302
2631	DINAMI	VV	D303
2632	DIPIGNANO	CS	D304
2633	DISO	LE	D305
2634	DIVACCIA SAN CANZIANO	TS	D308
2635	DIVIGNANO	NO	D309
2636	DIZZASCO	CO	D310
2637	DOBBIACO * TOBLACH	BZ	D311
2638	DOBERDO' DEL LAGO	GO	D312
2639	DOGLIANI	CN	D314
2640	DOGLIOLA	CH	D315
2641	DOGNA	UD	D316
2642	DOLCE'	VR	D317
2643	DOLCEACQUA	IM	D318
2644	DOLCEDO	IM	D319
2645	DOLEGNA DEL COLLIO	GO	D321
2646	DOLIANOVA	CA	D323
2647	SAN DORLIGO DELLA VALLE	TS	D324
2648	DOLO	VE	D325
2649	DOLZAGO	LC	D327
2650	DOMANICO	CS	D328
2651	DOMASO	CO	D329
2652	DOMEGGE DI CADORE	BL	D330
2653	DOMICELLA	AV	D331
2654	DOMODOSSOLA	VB	D332
2655	DOMUS DE MARIA	CA	D333
2656	DOMUSNOVAS	CI	D334
2657	DON	TN	D336
2658	DONNAS	AO	D338
2659	DONATO	BI	D339
2660	DONGO	CO	D341
2661	DONORI	CA	D344
2662	DORGALI	NU	D345
2663	DORIO	LC	D346
2664	DORMELLETTO	NO	D347
2665	DORNO	PV	D348
2666	DORSINO	TN	D349
2667	DORZANO	BI	D350
2668	DOSOLO	MN	D351
2669	DOSSENA	BG	D352
2670	DOSSO DEL LIRO	CO	D355
2671	DOUES	AO	D356
2672	DOVADOLA	FC	D357
2673	DOVERA	CR	D358
2674	DOZZA	BO	D360
2675	DRAGONI	CE	D361
2676	DRAPIA	VV	D364
2677	DRENA	TN	D365
2678	DRENCHIA	UD	D366
2679	DRESANO	MI	D367
2680	DREZZO	CO	D369
2681	DRIZZONA	CR	D370
2682	DRO	TN	D371
2683	DRONERO	CN	D372
2684	DRUENTO	TO	D373
2685	DRUOGNO	VB	D374
2686	DUALCHI	NU	D376
2687	DUBINO	SO	D377
2688	DUEVILLE	VI	D379
2689	DUGENTA	BN	D380
2690	DUINO-AURISINA	TS	D383
2691	DUMENZA	VA	D384
2692	DUNO	VA	D385
2693	DURAZZANO	BN	D386
2694	DUSINO SAN MICHELE	AT	D388
2695	DUTTOGLIANO	TS	D389
2696	EBOLI	SA	D390
2697	EDOLO	BS	D391
2698	EGNA * NEUMARKT	BZ	D392
2699	ELICE	PE	D394
2700	ELINI	OG	D395
2701	ELLO	LC	D398
2702	ELMAS	CA	D399
2704	ELVA	CN	D401
2705	EMARESE	AO	D402
2706	EMPOLI	FI	D403
2707	ENDINE GAIANO	BG	D406
2708	ENEGO	VI	D407
2709	ENEMONZO	UD	D408
2710	ENTRACQUE	CN	D410
2711	ENTRATICO	BG	D411
2712	ENVIE	CN	D412
2713	EPISCOPIA	PZ	D414
2714	ERACLEA	VE	D415
2715	ERBA	CO	D416
2716	ERBE'	VR	D419
2717	ERBEZZO	VR	D420
2718	ERBUSCO	BS	D421
2719	ERCHIE	BR	D422
2720	ERICE	TP	D423
2721	ERLI	SV	D424
2723	ERTO E CASSO	PN	D426
2724	ERVE	LC	D428
2725	ESANATOGLIA	MC	D429
2726	ESCALAPLANO	NU	D430
2727	ESCOLCA	NU	D431
2728	EXILLES	TO	D433
2729	ESINE	BS	D434
2730	ESINO LARIO	LC	D436
2731	ESPERIA	FR	D440
2732	ESPORLATU	SS	D441
2733	ESTE	PD	D442
2734	ESTERZILI	NU	D443
2735	ETROUBLES	AO	D444
2736	EUPILIO	CO	D445
2737	FABBRICA CURONE	AL	D447
2738	FABBRICHE DI VALLICO	LU	D449
2739	FABBRICO	RE	D450
2740	FABRIANO	AN	D451
2741	FABRICA DI ROMA	VT	D452
2742	FABRIZIA	VV	D453
2743	FABRO	TR	D454
2744	FAEDIS	UD	D455
2745	FAEDO VALTELLINO	SO	D456
2746	FAEDO	TN	D457
2747	FAENZA	RA	D458
2748	FAETO	FG	D459
2749	FAGAGNA	UD	D461
2750	FAGGETO LARIO	CO	D462
2751	FAGGIANO	TA	D463
2752	FAGNANO CASTELLO	CS	D464
2753	FAGNANO ALTO	AQ	D465
2754	FAGNANO OLONA	VA	D467
2755	FAI DELLA PAGANELLA	TN	D468
2756	FAICCHIO	BN	D469
2757	FALCADE	BL	D470
2758	FALCIANO DEL MASSICO	CE	D471
2759	FALCONARA MARITTIMA	AN	D472
2760	FALCONARA ALBANESE	CS	D473
2761	FALCONE	ME	D474
2762	FALERIA	VT	D475
2763	FALERNA	CZ	D476
2764	FALERONE	FM	D477
2765	FALLO	CH	D480
2766	FALMENTA	VB	D481
2767	FALOPPIO	CO	D482
2768	FALVATERRA	FR	D483
2769	FALZES * PFALZEN	BZ	D484
2770	FANANO	MO	D486
2771	FANNA	PN	D487
2772	FANO	PU	D488
2773	FANO ADRIANO	TE	D489
2774	FARA GERA D'ADDA	BG	D490
2775	FARA OLIVANA CON SOLA	BG	D491
2776	FARA NOVARESE	NO	D492
2777	FARA IN SABINA	RI	D493
2778	FARA FILIORUM PETRI	CH	D494
2779	FARA SAN MARTINO	CH	D495
2780	FARA VICENTINO	VI	D496
2781	FARDELLA	PZ	D497
2782	FARIGLIANO	CN	D499
2783	FARINDOLA	PE	D501
2784	FARINI	PC	D502
2785	FARNESE	VT	D503
2786	FARRA D'ISONZO	GO	D504
2787	FARRA DI SOLIGO	TV	D505
2788	FARRA D'ALPAGO	BL	D506
2789	FASANO	BR	D508
2790	FASCIA	GE	D509
2791	FAUGLIA	PI	D510
2792	FAULE	CN	D511
2793	FAVALE DI MALVARO	GE	D512
2794	VALSINNI	MT	D513
2795	FAVARA	AG	D514
2796	FAVER	TN	D516
2797	FAVIGNANA	TP	D518
2798	FAVRIA	TO	D520
2799	ORCO FEGLINO	SV	D522
2800	FEISOGLIO	CN	D523
2801	FELETTO	TO	D524
2802	FELINO	PR	D526
2803	FELITTO	SA	D527
2804	FELIZZANO	AL	D528
2805	FELONICA	MN	D529
2806	FELTRE	BL	D530
2807	FENEGRO'	CO	D531
2808	FENESTRELLE	TO	D532
2809	FENIS	AO	D537
2810	FERENTILLO	TR	D538
2811	FERENTINO	FR	D539
2812	FERLA	SR	D540
2813	FERMIGNANO	PU	D541
2814	FERMO	FM	D542
2815	FERNO	VA	D543
2816	FEROLETO ANTICO	CZ	D544
2817	FEROLETO DELLA CHIESA	RC	D545
2818	PIANOPOLI	CZ	D546
2819	FERRANDINA	MT	D547
2820	FERRARA	FE	D548
2821	FERRARA DI MONTE BALDO	VR	D549
2822	FERRAZZANO	CB	D550
2823	FERRERA DI VARESE	VA	D551
2824	FERRERA ERBOGNONE	PV	D552
2825	MONCENISIO	TO	D553
2826	FERRERE	AT	D554
2827	FERRIERE	PC	D555
2828	FERRUZZANO	RC	D557
2829	FRACONALTO	AL	D559
2830	FIAMIGNANO	RI	D560
2831	FIANO ROMANO	RM	D561
2832	FIANO	TO	D562
2834	FIASTRA	MC	D564
2835	FIAVE'	TN	D565
2836	POGGIO SAN VICINO	MC	D566
2837	FICARAZZI	PA	D567
2838	FICAROLO	RO	D568
2839	FICARRA	ME	D569
2840	FICULLE	TR	D570
2841	FIE' ALLO SCILIAR * VOELS AM SCHLERN	BZ	D571
2842	FIERA DI PRIMIERO	TN	D572
2843	FIEROZZO	TN	D573
2844	FIESCO	CR	D574
2845	FIESOLE	FI	D575
2846	FIESSE	BS	D576
2847	FIESSO UMBERTIANO	RO	D577
2848	FIESSO D'ARTICO	VE	D578
2849	FIGINO SERENZA	CO	D579
2850	FIGLINE VEGLIATURO	CS	D582
2851	FIGLINE VALDARNO	FI	D583
2852	GONNOSNO'	OR	D585
2853	FILACCIANO	RM	D586
2854	FILADELFIA	VV	D587
2855	FILAGO	BG	D588
2856	FILANDARI	VV	D589
2857	FILATTIERA	MS	D590
2858	FILETTINO	FR	D591
2859	FILETTO	CH	D592
2860	FILIANO	PZ	D593
2861	FILIGHERA	PV	D594
2862	FILIGNANO	IS	D595
2863	FILOGASO	VV	D596
2864	FILOTTRANO	AN	D597
2865	FINALE EMILIA	MO	D599
2866	FINALE LIGURE	SV	D600
2867	FINO DEL MONTE	BG	D604
2868	FINO MORNASCO	CO	D605
2869	FIORANO AL SERIO	BG	D606
2870	FIORANO MODENESE	MO	D607
2871	FIORANO CANAVESE	TO	D608
2872	FIORDIMONTE	MC	D609
2873	FIORENZUOLA D'ARDA	PC	D611
2874	FIRENZE	FI	D612
2875	FIRENZUOLA	FI	D613
2876	FIRMO	CS	D614
2877	FISCIANO	SA	D615
2878	FIUMALBO	MO	D617
2879	FIUMARA	RC	D619
2881	FIUME VENETO	PN	D621
2882	FIUMEDINISI	ME	D622
2883	FIUMEFREDDO DI SICILIA	CT	D623
2884	FIUMEFREDDO BRUZIO	CS	D624
2885	FIUMICELLO	UD	D627
\.


--
-- TOC entry 1880 (class 0 OID 16953)
-- Dependencies: 1538
-- Data for Name: nation; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY nation (id, description_it, initials, description_en) FROM stdin;
1	Afghanistan	AF	Afghanistan
2	Albania	AL	Albania
3	Algeria	DZ	Algeria
4	Samoa Americane	AS	American Samoa
5	Andorra	AD	Andorra
6	Angola	AO	Angola
7	Anguilla	AI	Anguilla
8	Antartide	AQ	Antarctica
9	Antigua e Barbuda	AG	Antigua and Barbuda
10	Argentina	AR	Argentina
11	Armenia	AM	Armenia
12	Aruba	AW	Aruba
13	Australia	AU	Australia
14	Austria	AT	Austria
15	Azerbaijan	AZ	Azerbaijan
16	Bahamas	BS	Bahamas
17	Bahrein	BH	Bahrain
18	Bangladesh	BD	Bangladesh
19	Barbados	BB	Barbados
20	Bielorussia	BY	Belarus
21	Belgio	BE	Belgium
22	Belize	BZ	Belize
23	Benin	BJ	Benin
24	Bermuda	BM	Bermuda
25	Bhutan	BT	Bhutan
26	Bolivia	BO	Bolivia
27	Bosnia Erzegovina	BA	Bosnia and Herzegovina
28	Botswana	BW	Botswana
29	Isola Bouvet	BV	Bouvet Island
30	Brasile	BR	Brazil
31	Oceano Indiano, territorio britannico	IO	British Indian Ocean Territory
32	Brunei Darussalam	BN	Brunei Darussalam
33	Bulgaria	BG	Bulgaria
34	Burkina Faso	BF	Burkina Faso
35	Burundi	BI	Burundi
36	Cambogia	KH	Cambodia
37	Camerun	CM	Cameroon
38	Canada	CA	Canada
39	Capo Verde	CV	Cape Verde
40	Isole Cayman	KY	Cayman Islands
41	Repubblica Centrafricana	CF	Central African Republic
42	Ciad	TD	Chad
43	Cile	CL	Chile
44	Cina	CN	China
45	Christmas Island	CX	Christmas Island
46	Cocos (Keeling) Islands	CC	Cocos (Keeling) Islands
47	Colombia	CO	Colombia
48	Comore	KM	Comoros
49	Congo	CG	Congo
50	Congo,Rep. Democratica	CD	Congo, the Democratic Republic of the
51	Isole di Cook	CK	Cook Islands
52	Costa Rica	CR	Costa Rica
53	Costa d'Avorio	CI	Cote d'Ivoire
54	Croazia	HR	Croatia
55	Cuba	CU	Cuba
56	Cipro	CY	Cyprus
57	Repubblica Ceca	CZ	Czech Republic
58	Danimarca	DK	Denmark
59	Gibuti	DJ	Djibouti
60	Dominica	DM	Dominica
61	Repubblica Dominicana	DO	Dominican Republic
62	Timor Est	TP	East Timor
63	Ecuador	EC	Ecuador
64	Egitto	EG	Egypt
65	El Salvador	SV	El Salvador
66	Guinea Equatoriale	GQ	Equatorial Guinea
67	Eritrea	ER	Eritrea
68	Estonia	EE	Estonia
69	Etiopia	ET	Ethiopia
70	Falkland Islands (Malvinas)	FK	Falkland Islands (Malvinas)
71	Isole Faroe	FO	Faroe Islands
72	Figi	FJ	Fiji
73	Finlandia	FI	Finland
74	Francia	FR	France
75	Guiana Francese	GF	French Guiana
76	Polinesia Francese	PF	French Polynesia
77	Territori Francesi del Sud	TF	French Southern Territories
78	Gabon	GA	Gabon
79	Gambia	GM	Gambia
80	Georgia	GE	Georgia
81	Germania	DE	Germany
82	Ghana	GH	Ghana
83	Gibilterra	GI	Gibraltar
84	Grecia	GR	Greece
85	Groenlandia	GL	Greenland
86	Grenada	GD	Grenada
87	Guadalupa	GP	Guadeloupe
88	Guam	GU	Guam
89	Guatemala	GT	Guatemala
90	Guinea	GN	Guinea
91	Guinea-Bissau	GW	Guinea-Bissau
92	Guyana	GY	Guyana
93	Haiti	HT	Haiti
94	Isole Heard e McDonald	HM	Heard Island and McDonald Islands
95	Holy See (Vatican City State)	VA	Holy See (Vatican City State)
96	Honduras	HN	Honduras
97	Hong Kong	HK	Hong Kong
98	Ungheria	HU	Hungary
99	Islanda	IS	Iceland
100	India	IN	India
101	Indonesia	ID	Indonesia
102	Iran	IR	Iran, Islamic Republic of
103	Iraq	IQ	Iraq
104	EIRE	IE	Ireland
105	Israele	IL	Israel
106	Italia	IT	Italy
107	Giamaica	JM	Jamaica
108	Giappone	JP	Japan
109	Giordania	JO	Jordan
110	Kazakistan	KZ	Kazakstan
111	Kenya	KE	Kenya
112	Kiribati	KI	Kiribati
113	Corea del Nord	KP	Korea, Democratic People's Republic of
114	Corea del Sud	KR	Korea, Republic of
115	Kuwait	KW	Kuwait
116	Kirgizistan	KG	Kyrgyzstan
117	Laos	LA	Lao People's Democratic Republic
118	Lettonia	LV	Latvia
119	Libano	LB	Lebanon
120	Lesotho	LS	Lesotho
121	Liberia	LR	Liberia
122	Libia	LY	Libyan Arab Jamahiriya
123	Liechtenstein	LI	Liechtenstein
124	Lituania	LT	Lithuania
125	Lussemburgo	LU	Luxembourg
126	Macao	MO	Macau
127	Macedonia	MK	Macedonia
128	Madagascar	MG	Madagascar
129	Malawi	MW	Malawi
130	Malaysia	MY	Malaysia
131	Isole Maldive	MV	Maldives
132	Mali	ML	Mali
133	Malta	MT	Malta
134	Isole Marshall	MH	Marshall Islands
135	Martinica	MQ	Martinique
136	Mauritania	MR	Mauritania
137	Mauritius	MU	Mauritius
138	Mayotte	YT	Mayotte
139	Mexico	MX	Mexico
140	Micronesia	FM	Micronesia, Federated States of
141	Moldova, Republic of	MD	Moldova, Republic of
142	Monaco	MC	Monaco
143	Mongolia	MN	Mongolia
144	Montserrat	MS	Montserrat
145	Marocco	MA	Morocco
146	Mozambique	MZ	Mozambique
147	Myanmar	MM	Myanmar
148	Namibia	NA	Namibia
149	Nauru	NR	Nauru
150	Nepal	NP	Nepal
151	Paesi Bassi	NL	Netherlands
152	Antille Olandesi	AN	Netherlands Antilles
153	Nuova Caledonia	NC	New Caledonia
154	Nuova Zelanda	NZ	New Zealand
155	Nicaragua	NI	Nicaragua
156	Niger	NE	Niger
157	Nigeria	NG	Nigeria
158	Niue	NU	Niue
159	Isola di Norfolk	NF	Norfolk Island
160	Isole Marianne del Nord	MP	Northern Mariana Islands
161	Norvegia	NO	Norway
162	Oman	OM	Oman
163	Pakistan	PK	Pakistan
164	Palau	PW	Palau
165	Panama	PA	Panama
166	Nuova Guinea	PG	Papua New Guinea
167	Paraguay	PY	Paraguay
168	Peru	PE	Peru
169	Filippine	PH	Philippines
170	Pitcairn	PN	Pitcairn
171	Polonia	PL	Poland
172	Portogallo	PT	Portugal
173	Porto Rico	PR	Puerto Rico
174	Qatar	QA	Qatar
175	Rèunion	RE	Rèunion
176	Romania	RO	Romania
177	Russia	RU	Russian Federation
178	Rwanda	RW	Rwanda
179	Sant'Elena	SH	Saint Helena
180	Saint Kitts e Nevis	KN	Saint Kitts and Nevis
181	Santa Lucia	LC	Saint Lucia
182	Saint Pierre e Miquelon	PM	Saint Pierre and Miquelon
183	Saint Vincent e le Grenadine	VC	Saint Vincent and the Grenadines
184	Samoa	WS	Samoa
185	San Marino	SM	San Marino
186	Sao Tome e Principe	ST	Sao Tome and Principe
187	Arabia Saudita	SA	Saudi Arabia
188	Senegal	SN	Senegal
189	Seychelles	SC	Seychelles
190	Sierra Leone	SL	Sierra Leone
191	Singapore	SG	Singapore
192	Slovacchia	SK	Slovakia
193	Slovenia	SI	Slovenia
194	Isole Solomone	SB	Solomon Islands
195	Somalia	SO	Somalia
196	Sud Africa	ZA	South Africa
197	Sud Georgia e Isole Sandwich del Sud	GS	South Georgia and the South Sandwich Islands
198	Spagna	ES	Spain
199	Sri Lanka	LK	Sri Lanka
200	Sudan	SD	Sudan
201	Suriname	SR	Suriname
202	Svalbard e Jan Mayen	SJ	Svalbard and Jan Mayen
203	Swaziland	SZ	Swaziland
204	Svezia	SE	Sweden
205	Svizzera	CH	Switzerland
206	Siria	SY	Syrian Arab Republic
207	Taiwan	TW	Taiwan, Province of China
208	Tagikistan	TJ	Tajikistan
209	Tanzania	TZ	Tanzania, United Republic of
210	Thailand	TH	Thailand
211	Togo	TG	Togo
212	Tokelau	TK	Tokelau
213	Tonga	TO	Tonga
214	Trinidad e Tobago	TT	Trinidad and Tobago
215	Tunisia	TN	Tunisia
216	Turchia	TR	Turkey
217	Turkmenistan	TM	Turkmenistan
218	Isole Turks e Caicos	TC	Turks and Caicos Islands
219	Tuvalu	TV	Tuvalu
220	Uganda	UG	Uganda
221	Ucraina	UA	Ukraine
222	Emirati Arabi Uniti	AE	United Arab Emirates
223	Gran Bretagna	GB	United Kingdom
224	USA	US	United States
225	Isole Minor Outlying, USA	UM	United States Minor Outlying Islands
226	Isole Vergini, USA	UY	United States Virgin Islands
227	Uruguay	UZ	Uruguay
228	Uzbekistan	VU	Uzbekistan
229	Vanuatu	VE	Vanuatu
230	Venezuela	VN	Venezuela
231	Vietnam	VG	Vietnam
232	Isole Vergini, GB	VI	Virgin Islands, British
233	Wallis e Futuna	WF	Wallis and Futuna
234	Sahara Occidentale	EH	Western Sahara
235	Yemen	YE	Yemen
236	Serbia e Montenegro	YU	Yugoslavia
237	Zambia	ZM	Zambia
238	Zimbabwe	ZW	Zimbabwe
239	Territori Palestinesi	PS	Palestinian Territory, occupied
\.


--
-- TOC entry 1881 (class 0 OID 16959)
-- Dependencies: 1539
-- Data for Name: occupation; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY occupation (id, description_it, description_en, code) FROM stdin;
6	Non rilevato	\N	01
3	Occupato	Employee	02
1	Disoccupato/in cerca di prima occupazione	Unemployed	03
2	Studente	Student	04
5	Ritirato dal lavoro/Pensionato	Pensioner	06
4	Casalinga		05
7	In altra condizione Professionale (militare,serv.civile, inabile al lavoro)	\N	07
\.


--
-- TOC entry 1882 (class 0 OID 16965)
-- Dependencies: 1540
-- Data for Name: os_currentstep; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY os_currentstep (id, entry_id, step_id, action_id, owner, start_date, finish_date, due_date, status, caller) FROM stdin;
\.


--
-- TOC entry 1883 (class 0 OID 16968)
-- Dependencies: 1541
-- Data for Name: os_historystep; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY os_historystep (id, entry_id, step_id, action_id, owner, start_date, finish_date, due_date, status, caller) FROM stdin;
\.


--
-- TOC entry 1884 (class 0 OID 16971)
-- Dependencies: 1542
-- Data for Name: os_wfentry; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY os_wfentry (id, name, state, version) FROM stdin;
\.


--
-- TOC entry 1885 (class 0 OID 16974)
-- Dependencies: 1543
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY patient (id, tax_code, name, surname, sex, foreigner, birth_date, birth_foreign_information, birth_nation, birth_region, birth_province, birth_cap, birth_municipality, living_nation, living_region, living_province, living_cap, living_municipality, living_address, education, occupation, mother_education, father_education, mother_occupation, father_occupation) FROM stdin;
\.


--
-- TOC entry 1886 (class 0 OID 16980)
-- Dependencies: 1544
-- Data for Name: province; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY province (id, description, num_occupants, num_municipalities, region) FROM stdin;
AG	Agrigento	448053	43	15
AL	Alessandria	418231	190	12
AN	Ancona	448473	49	10
AO	Aosta	119548	74	19
AR	Arezzo	323288	39	16
AP	Ascoli Piceno	369371	73	10
AT	Asti	208339	118	12
AV	Avellino	429178	119	4
BA	Bari	1559662	48	13
BL	Belluno	209550	69	20
BN	Benevento	287042	78	4
BG	Bergamo	973129	244	9
BI	Biella	187249	82	12
BO	Bologna	915225	60	5
BZ	Bolzano	462999	116	17
BS	Brescia	1108776	206	9
BR	Brindisi	402422	20	13
CA	Cagliari	543310	71	14
CL	Caltanissetta	274035	22	15
CB	Campobasso	230749	84	11
CI	Carbonia-Iglesias	131890	23	14
CE	Caserta	852872	104	4
CT	Catania	1054778	58	15
CZ	Catanzaro	369578	80	3
CH	Chieti	382076	104	1
CO	Como	537500	162	9
CS	Cosenza	733797	155	3
CR	Cremona	335939	115	9
KR	Crotone	173122	27	3
CN	Cuneo	556330	250	12
EN	Enna	177200	20	15
FE	Ferrara	344323	26	5
FI	Firenze	933860	44	16
FG	Foggia	690992	64	13
FR	Frosinone	484566	91	7
GE	Genova	878082	67	8
GO	Gorizia	136491	25	6
GR	Grosseto	211086	28	16
IM	Imperia	205238	67	8
IS	Isernia	89852	52	11
SP	La Spezia	215935	32	8
AQ	L'Aquila	297424	108	1
LT	Latina	491230	33	7
LE	Lecce	787825	97	13
LC	Lecco	311452	90	9
LI	Livorno	326444	20	16
LO	Lodi	197672	61	9
LU	Lucca	372244	35	16
MC	Macerata	301523	57	10
MN	Mantova	377790	70	9
MS	Massa-Carrara	197652	17	16
MT	Matera	204239	31	2
ME	Messina	662450	108	15
MI	Milano	3707210	189	9
MO	Modena	633993	47	5
NA	Napoli	3059196	92	4
NO	Novara	343040	88	12
NU	Nuoro	164260	52	14
OT	Olbia-Tempio	138334	26	14
OR	Oristano	167971	88	14
PD	Padova	849857	104	20
PA	Palermo	1235923	82	15
PR	Parma	392976	47	5
PV	Pavia	493753	190	9
PG	Perugia	605950	59	18
PE	Pescara	295481	46	1
PC	Piacenza	263872	48	5
PI	Pisa	384555	39	16
PT	Pistoia	268503	22	16
PN	Pordenone	286198	51	6
PZ	Potenza	393529	100	2
PO	Prato	227886	7	16
RG	Ragusa	295264	12	15
RA	Ravenna	347847	18	5
RC	Reggio Calabria	564223	97	3
RE	Reggio Emilia	453892	45	5
RI	Rieti	147410	73	7
RN	Rimini	272676	20	5
RM	Roma	3700424	121	7
RO	Rovigo	242538	50	20
SA	Salerno	1073643	158	4
VS	Medio Campidano	105400	28	14
SS	Sassari	322326	66	14
SV	Savona	272528	69	8
SI	Siena	252288	36	16
SR	Siracusa	396167	21	15
SO	Sondrio	176856	78	9
TA	Taranto	579806	29	13
TE	Teramo	287411	47	1
TR	Terni	219876	33	18
TO	Torino	2165619	315	12
OG	Ogliastra	58389	23	14
TP	Trapani	425121	24	15
TN	Trento	477017	223	17
TV	Treviso	795264	95	20
TS	Trieste	242235	6	6
UD	Udine	518840	137	6
VA	Varese	812477	141	9
VE	Venezia	809586	44	20
VB	Verbano-Cusio-Ossola	159040	77	12
VC	Vercelli	176829	86	12
VR	Verona	826582	98	20
VV	Vibo Valentia	170746	50	3
VI	Vicenza	794317	121	20
VT	Viterbo	288783	60	7
MB	Monza e Brianza	840000	55	9
PU	Pesaro e Urbino	364.896 	60	10
FM	Fermo	177.388	40	10
BT	Barletta-Andria-Trani	391.180	10	13
FC	Forlì-Cesena	391.072	30	5
\.


--
-- TOC entry 1887 (class 0 OID 16986)
-- Dependencies: 1545
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY region (id, description, num_occupants, num_municipalities, num_provinces) FROM stdin;
1	Abruzzo	1262392	305	4
2	Basilicata	597768	131	2
3	Calabria	2011466	409	5
4	Campania	5701931	551	5
5	Emilia-Romagna	3983346	341	9
6	Friuli-Venezia Giulia	1183764	219	4
7	Lazio	5112413	378	5
8	Liguria	1571783	235	4
9	Lombardia	9032554	1546	11
10	Marche	1470581	246	4
11	Molise	320601	136	2
12	Piemonte	4214677	1206	8
13	Puglia	4020707	258	5
14	Sardegna	1631880	377	8
15	Sicilia	4968991	390	9
16	Toscana	3497806	287	10
17	Trentino-Alto Adige	940016	339	2
18	Umbria	825826	92	2
19	Valle d'Aosta	119548	74	1
20	Veneto	4527694	581	7
\.


--
-- TOC entry 1888 (class 0 OID 16989)
-- Dependencies: 1546
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY role (id, description) FROM stdin;
1	Administrator
2	Referent
3	Compiler
\.


--
-- TOC entry 1889 (class 0 OID 17002)
-- Dependencies: 1552
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: remara
--

COPY "user" (username, password, name, surname, email, role, pediatrician) FROM stdin;
admin	qYNvzxxn1LvVAJQolrRws/OtfYFNy0cT	 	 	 	1	f
ffiora	qYNvzxxn1LvVAJQolrRws/OtfYFNy0cT	Francesco	Fiora	francesco.fiora@everett.it	3	f
lbrandolini	qYNvzxxn1LvVAJQolrRws/OtfYFNy0cT	Luigi	Brandolini	luigi.brandolini@everett.it	2	t
\.


ALTER TABLE ONLY exam
    ADD CONSTRAINT exam_pkey PRIMARY KEY (id);


--
-- TOC entry 1831 (class 2606 OID 17009)
-- Dependencies: 1532 1532
-- Name: username_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace:
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT username_pkey PRIMARY KEY (username);

--
-- TOC entry 1831 (class 2606 OID 17009)
-- Dependencies: 1532 1532
-- Name: education_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace:
--


ALTER TABLE ONLY education
    ADD CONSTRAINT education_pkey PRIMARY KEY (id);


--
-- TOC entry 1833 (class 2606 OID 17011)
-- Dependencies: 1533 1533
-- Name: hospital_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY hospital_organization
    ADD CONSTRAINT hospital_organization_pkey PRIMARY KEY (id);


--
-- TOC entry 1835 (class 2606 OID 17013)
-- Dependencies: 1534 1534
-- Name: hospital_ward_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY hospital_ward
    ADD CONSTRAINT hospital_ward_pkey PRIMARY KEY (id);


--
-- TOC entry 1837 (class 2606 OID 17015)
-- Dependencies: 1535 1535
-- Name: illness_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY illness
    ADD CONSTRAINT illness_pkey PRIMARY KEY (id);

ALTER TABLE ONLY illness
    ADD CONSTRAINT illness_unic_code UNIQUE (code);

ALTER TABLE ONLY illness
    ADD CONSTRAINT illness_unic_description UNIQUE (description);

--
-- TOC entry 1839 (class 2606 OID 17017)
-- Dependencies: 1536 1536
-- Name: medicine_case_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY medicine_case
    ADD CONSTRAINT medicine_case_pkey PRIMARY KEY (id);


--
-- TOC entry 1841 (class 2606 OID 17019)
-- Dependencies: 1537 1537
-- Name: municipality_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY municipality
    ADD CONSTRAINT municipality_pkey PRIMARY KEY (id);


--
-- TOC entry 1843 (class 2606 OID 17021)
-- Dependencies: 1538 1538
-- Name: nation_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY nation
    ADD CONSTRAINT nation_pkey PRIMARY KEY (id);


--
-- TOC entry 1845 (class 2606 OID 17023)
-- Dependencies: 1539 1539
-- Name: occupation_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY occupation
    ADD CONSTRAINT occupation_pkey PRIMARY KEY (id);


--
-- TOC entry 1847 (class 2606 OID 17025)
-- Dependencies: 1543 1543
-- Name: patient_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (id);


--
-- TOC entry 1849 (class 2606 OID 17027)
-- Dependencies: 1544 1544
-- Name: province_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY province
    ADD CONSTRAINT province_pkey PRIMARY KEY (id);


--
-- TOC entry 1851 (class 2606 OID 17029)
-- Dependencies: 1545 1545
-- Name: region_pkey; Type: CONSTRAINT; Schema: public; Owner: remara; Tablespace: 
--

ALTER TABLE ONLY region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- TOC entry 1859 (class 2606 OID 17030)
-- Dependencies: 1543 1537 1840
-- Name: birth_municipality_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT birth_municipality_pkey FOREIGN KEY (birth_municipality) REFERENCES municipality(id);


--
-- TOC entry 1860 (class 2606 OID 17035)
-- Dependencies: 1538 1842 1543
-- Name: birth_nation_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT birth_nation_pkey FOREIGN KEY (birth_nation) REFERENCES nation(id);


--
-- TOC entry 1861 (class 2606 OID 17040)
-- Dependencies: 1848 1544 1543
-- Name: birth_province_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT birth_province_pkey FOREIGN KEY (birth_province) REFERENCES province(id);


--
-- TOC entry 1862 (class 2606 OID 17045)
-- Dependencies: 1543 1850 1545
-- Name: birth_region_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT birth_region_pkey FOREIGN KEY (birth_region) REFERENCES region(id);


--
-- TOC entry 1863 (class 2606 OID 17050)
-- Dependencies: 1830 1532 1543
-- Name: father_education_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT father_education_pkey FOREIGN KEY (father_education) REFERENCES education(id);


--
-- TOC entry 1864 (class 2606 OID 17055)
-- Dependencies: 1543 1844 1539
-- Name: father_occupation_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT father_occupation_pkey FOREIGN KEY (father_occupation) REFERENCES occupation(id);


--
-- TOC entry 1853 (class 2606 OID 17060)
-- Dependencies: 1832 1533 1534
-- Name: hospital_hospital_ward_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY hospital_ward
    ADD CONSTRAINT hospital_hospital_ward_pkey FOREIGN KEY (hospital) REFERENCES hospital_organization(id);


--
-- TOC entry 1854 (class 2606 OID 17065)
-- Dependencies: 1832 1533 1536
-- Name: hospital_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY medicine_case
    ADD CONSTRAINT hospital_pkey FOREIGN KEY (hospital) REFERENCES hospital_organization(id);


--
-- TOC entry 1852 (class 2606 OID 17070)
-- Dependencies: 1850 1545 1533
-- Name: hospital_region_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY hospital_organization
    ADD CONSTRAINT hospital_region_pkey FOREIGN KEY (region) REFERENCES region(id);


--
-- TOC entry 1855 (class 2606 OID 17075)
-- Dependencies: 1836 1535 1536
-- Name: illness_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY medicine_case
    ADD CONSTRAINT illness_pkey FOREIGN KEY (illness) REFERENCES illness(id);


--
-- TOC entry 1865 (class 2606 OID 17080)
-- Dependencies: 1840 1537 1543
-- Name: living_municipality_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT living_municipality_pkey FOREIGN KEY (living_municipality) REFERENCES municipality(id);


--
-- TOC entry 1866 (class 2606 OID 17085)
-- Dependencies: 1842 1538 1543
-- Name: living_nation_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT living_nation_pkey FOREIGN KEY (living_nation) REFERENCES nation(id);


--
-- TOC entry 1867 (class 2606 OID 17090)
-- Dependencies: 1544 1543 1848
-- Name: living_province_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT living_province_pkey FOREIGN KEY (living_province) REFERENCES province(id);


--
-- TOC entry 1868 (class 2606 OID 17095)
-- Dependencies: 1543 1545 1850
-- Name: living_region_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT living_region_pkey FOREIGN KEY (living_region) REFERENCES region(id);


--
-- TOC entry 1869 (class 2606 OID 17100)
-- Dependencies: 1830 1532 1543
-- Name: mother_education_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT mother_education_pkey FOREIGN KEY (mother_education) REFERENCES education(id);


--
-- TOC entry 1870 (class 2606 OID 17105)
-- Dependencies: 1844 1539 1543
-- Name: mother_occupation_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT mother_occupation_pkey FOREIGN KEY (mother_occupation) REFERENCES occupation(id);


--
-- TOC entry 1856 (class 2606 OID 17110)
-- Dependencies: 1846 1543 1536
-- Name: patient_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY medicine_case
    ADD CONSTRAINT patient_pkey FOREIGN KEY (patient) REFERENCES patient(id);


--
-- TOC entry 1871 (class 2606 OID 17115)
-- Dependencies: 1830 1532 1543
-- Name: personal_education_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT personal_education_pkey FOREIGN KEY (education) REFERENCES education(id);


--
-- TOC entry 1872 (class 2606 OID 17120)
-- Dependencies: 1539 1844 1543
-- Name: personal_occupation_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY patient
    ADD CONSTRAINT personal_occupation_pkey FOREIGN KEY (occupation) REFERENCES occupation(id);


--
-- TOC entry 1858 (class 2606 OID 17125)
-- Dependencies: 1848 1544 1537
-- Name: province_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY municipality
    ADD CONSTRAINT province_pkey FOREIGN KEY (province) REFERENCES province(id);


--
-- TOC entry 1873 (class 2606 OID 17130)
-- Dependencies: 1545 1544 1850
-- Name: region_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY province
    ADD CONSTRAINT region_pkey FOREIGN KEY (region) REFERENCES region(id);


--
-- TOC entry 1857 (class 2606 OID 17135)
-- Dependencies: 1534 1536 1834
-- Name: ward_pkey; Type: FK CONSTRAINT; Schema: public; Owner: remara
--

ALTER TABLE ONLY medicine_case
    ADD CONSTRAINT ward_pkey FOREIGN KEY (ward) REFERENCES hospital_ward(id);


ALTER TABLE ONLY file_case
    ADD CONSTRAINT medicine_file_case_pkey FOREIGN KEY (exam) REFERENCES exam(id);

ALTER TABLE ONLY exam
    ADD CONSTRAINT exam_medicine_case_pkey FOREIGN KEY (medicine_case) REFERENCES medicine_case(id);

