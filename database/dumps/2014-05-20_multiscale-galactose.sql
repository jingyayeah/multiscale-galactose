--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO mkoenig;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO mkoenig;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO mkoenig;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO mkoenig;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO mkoenig;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO mkoenig;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO mkoenig;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO mkoenig;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO mkoenig;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO mkoenig;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO mkoenig;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO mkoenig;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO mkoenig;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO mkoenig;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO mkoenig;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO mkoenig;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO mkoenig;

--
-- Name: sim_core; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_core (
    id integer NOT NULL,
    ip character varying(200) NOT NULL,
    cpu integer NOT NULL,
    "time" timestamp with time zone NOT NULL
);


ALTER TABLE public.sim_core OWNER TO mkoenig;

--
-- Name: sim_core_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_core_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_core_id_seq OWNER TO mkoenig;

--
-- Name: sim_core_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_core_id_seq OWNED BY sim_core.id;


--
-- Name: sim_integration; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_integration (
    id integer NOT NULL,
    tend double precision NOT NULL,
    tsteps integer NOT NULL,
    tstart double precision NOT NULL,
    abs_tol double precision NOT NULL,
    rel_tol double precision NOT NULL
);


ALTER TABLE public.sim_integration OWNER TO mkoenig;

--
-- Name: sim_integration_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_integration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_integration_id_seq OWNER TO mkoenig;

--
-- Name: sim_integration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_integration_id_seq OWNED BY sim_integration.id;


--
-- Name: sim_parameter; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_parameter (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    value double precision NOT NULL,
    unit character varying(10) NOT NULL
);


ALTER TABLE public.sim_parameter OWNER TO mkoenig;

--
-- Name: sim_parameter_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_parameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_parameter_id_seq OWNER TO mkoenig;

--
-- Name: sim_parameter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_parameter_id_seq OWNED BY sim_parameter.id;


--
-- Name: sim_parametercollection; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_parametercollection (
    id integer NOT NULL
);


ALTER TABLE public.sim_parametercollection OWNER TO mkoenig;

--
-- Name: sim_parametercollection_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_parametercollection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_parametercollection_id_seq OWNER TO mkoenig;

--
-- Name: sim_parametercollection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_parametercollection_id_seq OWNED BY sim_parametercollection.id;


--
-- Name: sim_parametercollection_parameters; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_parametercollection_parameters (
    id integer NOT NULL,
    parametercollection_id integer NOT NULL,
    parameter_id integer NOT NULL
);


ALTER TABLE public.sim_parametercollection_parameters OWNER TO mkoenig;

--
-- Name: sim_parametercollection_parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_parametercollection_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_parametercollection_parameters_id_seq OWNER TO mkoenig;

--
-- Name: sim_parametercollection_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_parametercollection_parameters_id_seq OWNED BY sim_parametercollection_parameters.id;


--
-- Name: sim_plot; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_plot (
    id integer NOT NULL,
    timecourse_id integer NOT NULL,
    plot_type character varying(20) NOT NULL,
    file character varying(100) NOT NULL
);


ALTER TABLE public.sim_plot OWNER TO mkoenig;

--
-- Name: sim_plot_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_plot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_plot_id_seq OWNER TO mkoenig;

--
-- Name: sim_plot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_plot_id_seq OWNED BY sim_plot.id;


--
-- Name: sim_sbmlmodel; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_sbmlmodel (
    id integer NOT NULL,
    sbml_id character varying(200) NOT NULL,
    file character varying(100) NOT NULL
);


ALTER TABLE public.sim_sbmlmodel OWNER TO mkoenig;

--
-- Name: sim_sbmlmodel_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_sbmlmodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_sbmlmodel_id_seq OWNER TO mkoenig;

--
-- Name: sim_sbmlmodel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_sbmlmodel_id_seq OWNED BY sim_sbmlmodel.id;


--
-- Name: sim_simulation; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_simulation (
    id integer NOT NULL,
    task_id integer NOT NULL,
    parameters_id integer NOT NULL,
    status character varying(20) NOT NULL,
    priority integer NOT NULL,
    time_create timestamp with time zone NOT NULL,
    time_assign timestamp with time zone,
    core_id integer,
    file character varying(100),
    time_sim timestamp with time zone
);


ALTER TABLE public.sim_simulation OWNER TO mkoenig;

--
-- Name: sim_simulation_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_simulation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_simulation_id_seq OWNER TO mkoenig;

--
-- Name: sim_simulation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_simulation_id_seq OWNED BY sim_simulation.id;


--
-- Name: sim_task; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_task (
    id integer NOT NULL,
    sbml_model_id integer NOT NULL,
    integration_id integer NOT NULL,
    info text
);


ALTER TABLE public.sim_task OWNER TO mkoenig;

--
-- Name: sim_task_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_task_id_seq OWNER TO mkoenig;

--
-- Name: sim_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_task_id_seq OWNED BY sim_task.id;


--
-- Name: sim_timecourse; Type: TABLE; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE TABLE sim_timecourse (
    id integer NOT NULL,
    simulation_id integer NOT NULL,
    file character varying(100) NOT NULL
);


ALTER TABLE public.sim_timecourse OWNER TO mkoenig;

--
-- Name: sim_timecourse_id_seq; Type: SEQUENCE; Schema: public; Owner: mkoenig
--

CREATE SEQUENCE sim_timecourse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sim_timecourse_id_seq OWNER TO mkoenig;

--
-- Name: sim_timecourse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mkoenig
--

ALTER SEQUENCE sim_timecourse_id_seq OWNED BY sim_timecourse.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_core ALTER COLUMN id SET DEFAULT nextval('sim_core_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_integration ALTER COLUMN id SET DEFAULT nextval('sim_integration_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_parameter ALTER COLUMN id SET DEFAULT nextval('sim_parameter_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_parametercollection ALTER COLUMN id SET DEFAULT nextval('sim_parametercollection_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_parametercollection_parameters ALTER COLUMN id SET DEFAULT nextval('sim_parametercollection_parameters_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_plot ALTER COLUMN id SET DEFAULT nextval('sim_plot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_sbmlmodel ALTER COLUMN id SET DEFAULT nextval('sim_sbmlmodel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_simulation ALTER COLUMN id SET DEFAULT nextval('sim_simulation_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_task ALTER COLUMN id SET DEFAULT nextval('sim_task_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_timecourse ALTER COLUMN id SET DEFAULT nextval('sim_timecourse_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add permission	2	add_permission
5	Can change permission	2	change_permission
6	Can delete permission	2	delete_permission
7	Can add group	3	add_group
8	Can change group	3	change_group
9	Can delete group	3	delete_group
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add Core	7	add_core
20	Can change Core	7	change_core
21	Can delete Core	7	delete_core
22	Can add SBML Model	8	add_sbmlmodel
23	Can change SBML Model	8	change_sbmlmodel
24	Can delete SBML Model	8	delete_sbmlmodel
25	Can add Integration Setting	9	add_integration
26	Can change Integration Setting	9	change_integration
27	Can delete Integration Setting	9	delete_integration
28	Can add parameter	10	add_parameter
29	Can change parameter	10	change_parameter
30	Can delete parameter	10	delete_parameter
31	Can add ParameterCollection	11	add_parametercollection
32	Can change ParameterCollection	11	change_parametercollection
33	Can delete ParameterCollection	11	delete_parametercollection
34	Can add task	12	add_task
35	Can change task	12	change_task
36	Can delete task	12	delete_task
37	Can add simulation	13	add_simulation
38	Can change simulation	13	change_simulation
39	Can delete simulation	13	delete_simulation
40	Can add timecourse	14	add_timecourse
41	Can change timecourse	14	change_timecourse
42	Can delete timecourse	14	delete_timecourse
43	Can add plot	16	add_plot
44	Can change plot	16	change_plot
45	Can delete plot	16	delete_plot
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('auth_permission_id_seq', 75, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$12000$fRmdVIJuSeVb$+pVHyKAd6R94xfA5qsnt3TBn0jAIFW3LVDvnE1zEE/s=	2014-05-07 22:41:33.141322+02	t	mkoenig				t	t	2013-12-10 01:08:09.829031+01
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2014-03-20 22:36:58.295611+01	1	13	33	Sim:33	3	
2	2014-03-20 22:36:58.302318+01	1	13	32	Sim:32	3	
3	2014-03-20 22:36:58.303908+01	1	13	31	Sim:31	3	
4	2014-03-20 22:36:58.305255+01	1	13	30	Sim:30	3	
5	2014-03-20 22:36:58.306617+01	1	13	29	Sim:29	3	
6	2014-03-20 22:36:58.308241+01	1	13	28	Sim:28	3	
7	2014-03-20 22:36:58.309133+01	1	13	27	Sim:27	3	
8	2014-03-20 22:36:58.309911+01	1	13	26	Sim:26	3	
9	2014-03-20 22:36:58.310675+01	1	13	25	Sim:25	3	
10	2014-03-20 22:36:58.311421+01	1	13	24	Sim:24	3	
11	2014-03-20 22:36:58.312187+01	1	13	23	Sim:23	3	
12	2014-03-20 22:36:58.312935+01	1	13	22	Sim:22	3	
13	2014-03-20 22:36:58.313676+01	1	13	21	Sim:21	3	
14	2014-03-20 22:36:58.314399+01	1	13	20	Sim:20	3	
15	2014-03-20 22:36:58.315123+01	1	13	19	Sim:19	3	
16	2014-03-20 22:36:58.316097+01	1	13	18	Sim:18	3	
17	2014-03-20 22:36:58.317558+01	1	13	17	Sim:17	3	
18	2014-03-20 22:36:58.319033+01	1	13	16	Sim:16	3	
19	2014-03-20 22:36:58.320574+01	1	13	15	Sim:15	3	
20	2014-03-20 22:36:58.322266+01	1	13	14	Sim:14	3	
21	2014-03-20 22:36:58.323877+01	1	13	13	Sim:13	3	
22	2014-03-20 22:36:58.32518+01	1	13	12	Sim:12	3	
23	2014-03-20 22:36:58.326541+01	1	13	11	Sim:11	3	
24	2014-03-20 22:36:58.327947+01	1	13	10	Sim:10	3	
25	2014-03-20 22:36:58.329563+01	1	13	9	Sim:9	3	
26	2014-03-20 22:36:58.331428+01	1	13	8	Sim:8	3	
27	2014-03-20 22:36:58.333708+01	1	13	7	Sim:7	3	
28	2014-03-20 22:36:58.336086+01	1	13	6	Sim:6	3	
29	2014-03-20 22:36:58.338643+01	1	13	5	Sim:5	3	
30	2014-03-20 22:36:58.341095+01	1	13	4	Sim:4	3	
31	2014-03-20 22:36:58.344146+01	1	13	3	Sim:3	3	
32	2014-03-20 22:44:56.874529+01	1	13	64	Sim:64	3	
33	2014-03-20 22:44:56.877889+01	1	13	63	Sim:63	3	
34	2014-03-20 22:44:56.881706+01	1	13	62	Sim:62	3	
35	2014-03-20 22:44:56.886219+01	1	13	61	Sim:61	3	
36	2014-03-20 22:44:56.89075+01	1	13	60	Sim:60	3	
37	2014-03-20 22:44:56.896885+01	1	13	59	Sim:59	3	
38	2014-03-20 22:44:56.90032+01	1	13	58	Sim:58	3	
39	2014-03-20 22:44:56.90367+01	1	13	57	Sim:57	3	
40	2014-03-20 22:44:56.906771+01	1	13	56	Sim:56	3	
41	2014-03-20 22:44:56.913458+01	1	13	55	Sim:55	3	
42	2014-03-20 22:44:56.916429+01	1	13	54	Sim:54	3	
43	2014-03-20 22:44:56.917505+01	1	13	53	Sim:53	3	
44	2014-03-20 22:44:56.918477+01	1	13	52	Sim:52	3	
45	2014-03-20 22:44:56.919373+01	1	13	51	Sim:51	3	
46	2014-03-20 22:44:56.920223+01	1	13	50	Sim:50	3	
47	2014-03-20 22:44:56.921117+01	1	13	49	Sim:49	3	
48	2014-03-20 22:44:56.922001+01	1	13	48	Sim:48	3	
49	2014-03-20 22:44:56.922856+01	1	13	47	Sim:47	3	
50	2014-03-20 22:44:56.923779+01	1	13	46	Sim:46	3	
51	2014-03-20 22:44:56.925656+01	1	13	45	Sim:45	3	
52	2014-03-20 22:44:56.926866+01	1	13	44	Sim:44	3	
53	2014-03-20 22:44:56.928373+01	1	13	43	Sim:43	3	
54	2014-03-20 22:44:56.92947+01	1	13	42	Sim:42	3	
55	2014-03-20 22:44:56.930442+01	1	13	41	Sim:41	3	
56	2014-03-20 22:44:56.931364+01	1	13	40	Sim:40	3	
57	2014-03-20 22:44:56.932341+01	1	13	39	Sim:39	3	
58	2014-03-20 22:44:56.933338+01	1	13	38	Sim:38	3	
59	2014-03-20 22:44:56.934189+01	1	13	37	Sim:37	3	
60	2014-03-20 22:44:56.934986+01	1	13	36	Sim:36	3	
61	2014-03-20 22:44:56.935895+01	1	13	35	Sim:35	3	
62	2014-03-20 22:44:56.936745+01	1	13	34	Sim:34	3	
63	2014-03-20 22:52:08.179569+01	1	13	95	Sim:95	3	
64	2014-03-20 22:52:08.185972+01	1	13	94	Sim:94	3	
65	2014-03-20 22:52:08.188607+01	1	13	93	Sim:93	3	
66	2014-03-20 22:52:08.190855+01	1	13	92	Sim:92	3	
67	2014-03-20 22:52:08.193439+01	1	13	91	Sim:91	3	
68	2014-03-20 22:52:08.196123+01	1	13	90	Sim:90	3	
69	2014-03-20 22:52:08.198327+01	1	13	89	Sim:89	3	
70	2014-03-20 22:52:08.200696+01	1	13	88	Sim:88	3	
71	2014-03-20 22:52:08.202974+01	1	13	87	Sim:87	3	
72	2014-03-20 22:52:08.204928+01	1	13	86	Sim:86	3	
73	2014-03-20 22:52:08.207051+01	1	13	85	Sim:85	3	
74	2014-03-20 22:52:08.209826+01	1	13	84	Sim:84	3	
75	2014-03-20 22:52:08.212429+01	1	13	83	Sim:83	3	
76	2014-03-20 22:52:08.21477+01	1	13	82	Sim:82	3	
77	2014-03-20 22:52:08.217099+01	1	13	81	Sim:81	3	
78	2014-03-20 22:52:08.219321+01	1	13	80	Sim:80	3	
79	2014-03-20 22:52:08.221895+01	1	13	79	Sim:79	3	
80	2014-03-20 22:52:08.224309+01	1	13	78	Sim:78	3	
81	2014-03-20 22:52:08.226549+01	1	13	77	Sim:77	3	
82	2014-03-20 22:52:08.228828+01	1	13	76	Sim:76	3	
83	2014-03-20 22:52:08.231416+01	1	13	75	Sim:75	3	
84	2014-03-20 22:52:08.233966+01	1	13	74	Sim:74	3	
85	2014-03-20 22:52:08.236224+01	1	13	73	Sim:73	3	
86	2014-03-20 22:52:08.238923+01	1	13	72	Sim:72	3	
87	2014-03-20 22:52:08.241632+01	1	13	71	Sim:71	3	
88	2014-03-20 22:52:08.244058+01	1	13	70	Sim:70	3	
89	2014-03-20 22:52:08.245149+01	1	13	69	Sim:69	3	
90	2014-03-20 22:52:08.246842+01	1	13	68	Sim:68	3	
91	2014-03-20 22:52:08.249079+01	1	13	67	Sim:67	3	
92	2014-03-20 22:52:08.251562+01	1	13	66	Sim:66	3	
93	2014-03-20 22:52:08.253437+01	1	13	65	Sim:65	3	
94	2014-03-20 23:01:52.236861+01	1	13	126	Sim:126	3	
95	2014-03-20 23:01:52.243883+01	1	13	125	Sim:125	3	
96	2014-03-20 23:01:52.24575+01	1	13	124	Sim:124	3	
97	2014-03-20 23:01:52.247277+01	1	13	123	Sim:123	3	
98	2014-03-20 23:01:52.249045+01	1	13	122	Sim:122	3	
99	2014-03-20 23:01:52.251123+01	1	13	121	Sim:121	3	
100	2014-03-20 23:01:52.253213+01	1	13	120	Sim:120	3	
101	2014-03-20 23:01:52.255688+01	1	13	119	Sim:119	3	
102	2014-03-20 23:01:52.258269+01	1	13	118	Sim:118	3	
103	2014-03-20 23:01:52.260943+01	1	13	117	Sim:117	3	
104	2014-03-20 23:01:52.264199+01	1	13	116	Sim:116	3	
105	2014-03-20 23:01:52.266888+01	1	13	115	Sim:115	3	
106	2014-03-20 23:01:52.269532+01	1	13	114	Sim:114	3	
107	2014-03-20 23:01:52.272331+01	1	13	113	Sim:113	3	
108	2014-03-20 23:01:52.275036+01	1	13	112	Sim:112	3	
109	2014-03-20 23:01:52.277998+01	1	13	111	Sim:111	3	
110	2014-03-20 23:01:52.28097+01	1	13	110	Sim:110	3	
111	2014-03-20 23:01:52.283986+01	1	13	109	Sim:109	3	
112	2014-03-20 23:01:52.286414+01	1	13	108	Sim:108	3	
113	2014-03-20 23:01:52.289122+01	1	13	107	Sim:107	3	
114	2014-03-20 23:01:52.291806+01	1	13	106	Sim:106	3	
115	2014-03-20 23:01:52.294372+01	1	13	105	Sim:105	3	
116	2014-03-20 23:01:52.296204+01	1	13	104	Sim:104	3	
117	2014-03-20 23:01:52.296965+01	1	13	103	Sim:103	3	
118	2014-03-20 23:01:52.297718+01	1	13	102	Sim:102	3	
119	2014-03-20 23:01:52.298477+01	1	13	101	Sim:101	3	
120	2014-03-20 23:01:52.299435+01	1	13	100	Sim:100	3	
121	2014-03-20 23:01:52.300331+01	1	13	99	Sim:99	3	
122	2014-03-20 23:01:52.302342+01	1	13	98	Sim:98	3	
123	2014-03-20 23:01:52.303394+01	1	13	97	Sim:97	3	
124	2014-03-20 23:01:52.304455+01	1	13	96	Sim:96	3	
125	2014-03-20 23:09:56.563938+01	1	13	157	Sim:157	3	
126	2014-03-20 23:09:56.572992+01	1	13	156	Sim:156	3	
127	2014-03-20 23:09:56.574185+01	1	13	155	Sim:155	3	
128	2014-03-20 23:09:56.575378+01	1	13	154	Sim:154	3	
129	2014-03-20 23:09:56.576712+01	1	13	153	Sim:153	3	
130	2014-03-20 23:09:56.578532+01	1	13	152	Sim:152	3	
131	2014-03-20 23:09:56.580472+01	1	13	151	Sim:151	3	
132	2014-03-20 23:09:56.582562+01	1	13	150	Sim:150	3	
133	2014-03-20 23:09:56.584691+01	1	13	149	Sim:149	3	
134	2014-03-20 23:09:56.58685+01	1	13	148	Sim:148	3	
135	2014-03-20 23:09:56.588815+01	1	13	147	Sim:147	3	
136	2014-03-20 23:09:56.591225+01	1	13	146	Sim:146	3	
137	2014-03-20 23:09:56.592888+01	1	13	145	Sim:145	3	
138	2014-03-20 23:09:56.594228+01	1	13	144	Sim:144	3	
139	2014-03-20 23:09:56.595488+01	1	13	143	Sim:143	3	
140	2014-03-20 23:09:56.59668+01	1	13	142	Sim:142	3	
141	2014-03-20 23:09:56.598054+01	1	13	141	Sim:141	3	
142	2014-03-20 23:09:56.599232+01	1	13	140	Sim:140	3	
143	2014-03-20 23:09:56.600959+01	1	13	139	Sim:139	3	
144	2014-03-20 23:09:56.602765+01	1	13	138	Sim:138	3	
145	2014-03-20 23:09:56.604674+01	1	13	137	Sim:137	3	
146	2014-03-20 23:09:56.607033+01	1	13	136	Sim:136	3	
147	2014-03-20 23:09:56.609572+01	1	13	135	Sim:135	3	
148	2014-03-20 23:09:56.612025+01	1	13	134	Sim:134	3	
149	2014-03-20 23:09:56.614408+01	1	13	133	Sim:133	3	
150	2014-03-20 23:09:56.616798+01	1	13	132	Sim:132	3	
151	2014-03-20 23:09:56.619352+01	1	13	131	Sim:131	3	
152	2014-03-20 23:09:56.622308+01	1	13	130	Sim:130	3	
153	2014-03-20 23:09:56.62538+01	1	13	129	Sim:129	3	
154	2014-03-20 23:09:56.62819+01	1	13	128	Sim:128	3	
155	2014-03-20 23:09:56.631363+01	1	13	127	Sim:127	3	
156	2014-03-20 23:24:27.439582+01	1	13	188	Sim:188	3	
157	2014-03-20 23:24:27.447945+01	1	13	187	Sim:187	3	
158	2014-03-20 23:24:27.450145+01	1	13	186	Sim:186	3	
159	2014-03-20 23:24:27.452512+01	1	13	185	Sim:185	3	
160	2014-03-20 23:24:27.454864+01	1	13	184	Sim:184	3	
161	2014-03-20 23:24:27.457157+01	1	13	183	Sim:183	3	
162	2014-03-20 23:24:27.45961+01	1	13	182	Sim:182	3	
163	2014-03-20 23:24:27.462669+01	1	13	181	Sim:181	3	
164	2014-03-20 23:24:27.465328+01	1	13	180	Sim:180	3	
165	2014-03-20 23:24:27.467828+01	1	13	179	Sim:179	3	
166	2014-03-20 23:24:27.47054+01	1	13	178	Sim:178	3	
167	2014-03-20 23:24:27.473046+01	1	13	177	Sim:177	3	
168	2014-03-20 23:24:27.475626+01	1	13	176	Sim:176	3	
169	2014-03-20 23:24:27.478713+01	1	13	175	Sim:175	3	
170	2014-03-20 23:24:27.481774+01	1	13	174	Sim:174	3	
171	2014-03-20 23:24:27.484453+01	1	13	173	Sim:173	3	
172	2014-03-20 23:24:27.486865+01	1	13	172	Sim:172	3	
173	2014-03-20 23:24:27.489857+01	1	13	171	Sim:171	3	
174	2014-03-20 23:24:27.492571+01	1	13	170	Sim:170	3	
175	2014-03-20 23:24:27.494874+01	1	13	169	Sim:169	3	
176	2014-03-20 23:24:27.497943+01	1	13	168	Sim:168	3	
177	2014-03-20 23:24:27.500996+01	1	13	167	Sim:167	3	
178	2014-03-20 23:24:27.503996+01	1	13	166	Sim:166	3	
179	2014-03-20 23:24:27.507276+01	1	13	165	Sim:165	3	
180	2014-03-20 23:24:27.510276+01	1	13	164	Sim:164	3	
181	2014-03-20 23:24:27.51322+01	1	13	163	Sim:163	3	
182	2014-03-20 23:24:27.515988+01	1	13	162	Sim:162	3	
183	2014-03-20 23:24:27.51891+01	1	13	161	Sim:161	3	
184	2014-03-20 23:24:27.521744+01	1	13	160	Sim:160	3	
185	2014-03-20 23:24:27.524315+01	1	13	159	Sim:159	3	
186	2014-03-20 23:24:27.526784+01	1	13	158	Sim:158	3	
187	2014-03-20 23:38:39.54178+01	1	13	219	Sim:219	3	
188	2014-03-20 23:38:39.547665+01	1	13	218	Sim:218	3	
189	2014-03-20 23:38:39.549353+01	1	13	217	Sim:217	3	
190	2014-03-20 23:38:39.550759+01	1	13	216	Sim:216	3	
191	2014-03-20 23:38:39.552101+01	1	13	215	Sim:215	3	
192	2014-03-20 23:38:39.553595+01	1	13	214	Sim:214	3	
193	2014-03-20 23:38:39.555129+01	1	13	213	Sim:213	3	
194	2014-03-20 23:38:39.556149+01	1	13	212	Sim:212	3	
195	2014-03-20 23:38:39.557463+01	1	13	211	Sim:211	3	
196	2014-03-20 23:38:39.558894+01	1	13	210	Sim:210	3	
197	2014-03-20 23:38:39.560252+01	1	13	209	Sim:209	3	
198	2014-03-20 23:38:39.561554+01	1	13	208	Sim:208	3	
199	2014-03-20 23:38:39.562756+01	1	13	207	Sim:207	3	
200	2014-03-20 23:38:39.564267+01	1	13	206	Sim:206	3	
201	2014-03-20 23:38:39.566138+01	1	13	205	Sim:205	3	
202	2014-03-20 23:38:39.56777+01	1	13	204	Sim:204	3	
203	2014-03-20 23:38:39.569555+01	1	13	203	Sim:203	3	
204	2014-03-20 23:38:39.571655+01	1	13	202	Sim:202	3	
205	2014-03-20 23:38:39.573893+01	1	13	201	Sim:201	3	
206	2014-03-20 23:38:39.576514+01	1	13	200	Sim:200	3	
207	2014-03-20 23:38:39.5786+01	1	13	199	Sim:199	3	
208	2014-03-20 23:38:39.579805+01	1	13	198	Sim:198	3	
209	2014-03-20 23:38:39.581378+01	1	13	197	Sim:197	3	
210	2014-03-20 23:38:39.583515+01	1	13	196	Sim:196	3	
211	2014-03-20 23:38:39.585774+01	1	13	195	Sim:195	3	
212	2014-03-20 23:38:39.58763+01	1	13	194	Sim:194	3	
213	2014-03-20 23:38:39.589941+01	1	13	193	Sim:193	3	
214	2014-03-20 23:38:39.592139+01	1	13	192	Sim:192	3	
215	2014-03-20 23:38:39.594285+01	1	13	191	Sim:191	3	
216	2014-03-20 23:38:39.596778+01	1	13	190	Sim:190	3	
217	2014-03-20 23:38:39.599843+01	1	13	189	Sim:189	3	
218	2014-03-20 23:45:39.721046+01	1	13	250	Sim:250	3	
219	2014-03-20 23:45:39.727837+01	1	13	249	Sim:249	3	
220	2014-03-20 23:45:39.729916+01	1	13	248	Sim:248	3	
221	2014-03-20 23:45:39.732079+01	1	13	247	Sim:247	3	
222	2014-03-20 23:45:39.734272+01	1	13	246	Sim:246	3	
223	2014-03-20 23:45:39.736246+01	1	13	245	Sim:245	3	
224	2014-03-20 23:45:39.738107+01	1	13	244	Sim:244	3	
225	2014-03-20 23:45:39.739612+01	1	13	243	Sim:243	3	
226	2014-03-20 23:45:39.742746+01	1	13	242	Sim:242	3	
227	2014-03-20 23:45:39.74561+01	1	13	241	Sim:241	3	
228	2014-03-20 23:45:39.748288+01	1	13	240	Sim:240	3	
229	2014-03-20 23:45:39.750768+01	1	13	239	Sim:239	3	
230	2014-03-20 23:45:39.753266+01	1	13	238	Sim:238	3	
231	2014-03-20 23:45:39.756075+01	1	13	237	Sim:237	3	
232	2014-03-20 23:45:39.758851+01	1	13	236	Sim:236	3	
233	2014-03-20 23:45:39.761386+01	1	13	235	Sim:235	3	
234	2014-03-20 23:45:39.763908+01	1	13	234	Sim:234	3	
235	2014-03-20 23:45:39.766173+01	1	13	233	Sim:233	3	
236	2014-03-20 23:45:39.76842+01	1	13	232	Sim:232	3	
237	2014-03-20 23:45:39.770722+01	1	13	231	Sim:231	3	
238	2014-03-20 23:45:39.773678+01	1	13	230	Sim:230	3	
239	2014-03-20 23:45:39.776392+01	1	13	229	Sim:229	3	
240	2014-03-20 23:45:39.779266+01	1	13	228	Sim:228	3	
241	2014-03-20 23:45:39.781949+01	1	13	227	Sim:227	3	
242	2014-03-20 23:45:39.784709+01	1	13	226	Sim:226	3	
243	2014-03-20 23:45:39.787224+01	1	13	225	Sim:225	3	
244	2014-03-20 23:45:39.789804+01	1	13	224	Sim:224	3	
245	2014-03-20 23:45:39.792389+01	1	13	223	Sim:223	3	
246	2014-03-20 23:45:39.794913+01	1	13	222	Sim:222	3	
247	2014-03-20 23:45:39.797553+01	1	13	221	Sim:221	3	
248	2014-03-20 23:45:39.800851+01	1	13	220	Sim:220	3	
249	2014-03-21 12:06:49.547814+01	1	13	312	Sim:312	3	
250	2014-03-21 12:06:49.555598+01	1	13	311	Sim:311	3	
251	2014-03-21 12:06:49.556836+01	1	13	310	Sim:310	3	
252	2014-03-21 12:06:49.557805+01	1	13	309	Sim:309	3	
253	2014-03-21 12:06:49.55954+01	1	13	308	Sim:308	3	
254	2014-03-21 12:06:49.561445+01	1	13	307	Sim:307	3	
255	2014-03-21 12:06:49.563162+01	1	13	306	Sim:306	3	
256	2014-03-21 12:06:49.565299+01	1	13	305	Sim:305	3	
257	2014-03-21 12:06:49.567349+01	1	13	304	Sim:304	3	
258	2014-03-21 12:06:49.568452+01	1	13	303	Sim:303	3	
259	2014-03-21 12:06:49.569423+01	1	13	302	Sim:302	3	
260	2014-03-21 12:06:49.570357+01	1	13	301	Sim:301	3	
261	2014-03-21 12:06:49.571227+01	1	13	300	Sim:300	3	
262	2014-03-21 12:06:49.572124+01	1	13	299	Sim:299	3	
263	2014-03-21 12:06:49.572948+01	1	13	298	Sim:298	3	
264	2014-03-21 12:06:49.573733+01	1	13	297	Sim:297	3	
265	2014-03-21 12:06:49.574618+01	1	13	296	Sim:296	3	
266	2014-03-21 12:06:49.575477+01	1	13	295	Sim:295	3	
267	2014-03-21 12:06:49.577116+01	1	13	294	Sim:294	3	
268	2014-03-21 12:06:49.578365+01	1	13	293	Sim:293	3	
269	2014-03-21 12:06:49.579537+01	1	13	292	Sim:292	3	
270	2014-03-21 12:06:49.58084+01	1	13	291	Sim:291	3	
271	2014-03-21 12:06:49.581966+01	1	13	290	Sim:290	3	
272	2014-03-21 12:06:49.583123+01	1	13	289	Sim:289	3	
273	2014-03-21 12:06:49.584234+01	1	13	288	Sim:288	3	
274	2014-03-21 12:06:49.585305+01	1	13	287	Sim:287	3	
275	2014-03-21 12:06:49.586359+01	1	13	286	Sim:286	3	
276	2014-03-21 12:06:49.58744+01	1	13	285	Sim:285	3	
277	2014-03-21 12:06:49.588526+01	1	13	284	Sim:284	3	
278	2014-03-21 12:06:49.589697+01	1	13	283	Sim:283	3	
279	2014-03-21 12:06:49.590796+01	1	13	282	Sim:282	3	
280	2014-03-21 12:10:21.780425+01	1	12	1	T:1 [Dilution_Curves_v4_Nc20_Nf1 | Int:1]	3	
281	2014-03-21 12:10:35.241918+01	1	8	1	Dilution_Curves_v4_Nc20_Nf1	3	
282	2014-03-21 12:42:51.190141+01	1	13	352	Sim:352	3	
283	2014-03-21 12:42:51.198526+01	1	13	351	Sim:351	3	
284	2014-03-21 12:42:51.200736+01	1	13	350	Sim:350	3	
285	2014-03-21 12:42:51.202561+01	1	13	349	Sim:349	3	
286	2014-03-21 12:42:51.204353+01	1	13	348	Sim:348	3	
287	2014-03-21 12:42:51.206139+01	1	13	347	Sim:347	3	
288	2014-03-21 12:42:51.207666+01	1	13	346	Sim:346	3	
289	2014-03-21 12:42:51.210123+01	1	13	345	Sim:345	3	
290	2014-03-21 12:42:51.212614+01	1	13	344	Sim:344	3	
291	2014-03-21 12:42:51.215038+01	1	13	343	Sim:343	3	
292	2014-03-21 12:42:51.217606+01	1	13	342	Sim:342	3	
293	2014-03-21 12:42:51.220205+01	1	13	341	Sim:341	3	
294	2014-03-21 12:42:51.222658+01	1	13	340	Sim:340	3	
295	2014-03-21 12:42:51.225374+01	1	13	339	Sim:339	3	
296	2014-03-21 12:42:51.228763+01	1	13	338	Sim:338	3	
297	2014-03-21 12:42:51.231577+01	1	13	337	Sim:337	3	
298	2014-03-21 12:42:51.234263+01	1	13	336	Sim:336	3	
299	2014-03-21 12:42:51.237147+01	1	13	335	Sim:335	3	
300	2014-03-21 12:42:51.23985+01	1	13	334	Sim:334	3	
301	2014-03-21 12:42:51.243334+01	1	13	333	Sim:333	3	
302	2014-03-21 12:42:51.246027+01	1	13	332	Sim:332	3	
303	2014-03-21 12:42:51.248728+01	1	13	331	Sim:331	3	
304	2014-03-21 12:42:51.251381+01	1	13	330	Sim:330	3	
305	2014-03-21 12:42:51.253958+01	1	13	329	Sim:329	3	
306	2014-03-21 12:42:51.256269+01	1	13	328	Sim:328	3	
307	2014-03-21 12:42:51.258775+01	1	13	327	Sim:327	3	
308	2014-03-21 12:42:51.261371+01	1	13	326	Sim:326	3	
309	2014-03-21 12:42:51.263899+01	1	13	325	Sim:325	3	
310	2014-03-21 12:42:51.266437+01	1	13	324	Sim:324	3	
311	2014-03-21 12:42:51.269129+01	1	13	323	Sim:323	3	
312	2014-03-21 12:42:51.271696+01	1	13	322	Sim:322	3	
313	2014-03-21 12:42:51.274026+01	1	13	321	Sim:321	3	
314	2014-03-21 12:42:51.276688+01	1	13	320	Sim:320	3	
315	2014-03-21 12:42:51.27907+01	1	13	319	Sim:319	3	
316	2014-03-21 12:42:51.281379+01	1	13	318	Sim:318	3	
317	2014-03-21 12:42:51.28357+01	1	13	317	Sim:317	3	
318	2014-03-21 12:42:51.286073+01	1	13	316	Sim:316	3	
319	2014-03-21 12:42:51.288729+01	1	13	315	Sim:315	3	
320	2014-03-21 12:42:51.290975+01	1	13	314	Sim:314	3	
321	2014-03-21 12:42:51.293382+01	1	13	313	Sim:313	3	
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 111, true);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	log entry	admin	logentry
2	permission	auth	permission
3	group	auth	group
4	user	auth	user
5	content type	contenttypes	contenttype
6	session	sessions	session
7	Core	sim	core
8	SBML Model	sim	sbmlmodel
9	Integration Setting	sim	integration
10	parameter	sim	parameter
11	ParameterCollection	sim	parametercollection
12	task	sim	task
13	simulation	sim	simulation
14	timecourse	sim	timecourse
16	plot	sim	plot
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('django_content_type_id_seq', 28, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
a5miie155lud0f1uyjuxqcjt2hrlox1f	YzMzN2FhZDc5MTZhNjkwZWFiZDIyNzgwNjZiMzJiOWRkMGUyZmU3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2014-04-03 22:36:12.746417+02
bn8dk6k8vfmxe1uenbuhxw2v3ukvho2s	YzMzN2FhZDc5MTZhNjkwZWFiZDIyNzgwNjZiMzJiOWRkMGUyZmU3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2014-04-04 13:06:40.570405+02
wztxx4es8ducqk00abbnby7l1wv326it	YzMzN2FhZDc5MTZhNjkwZWFiZDIyNzgwNjZiMzJiOWRkMGUyZmU3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2014-04-10 00:38:49.98188+02
tk6izqtilpnps2hmq7zibjxm2v3rvu4s	YzMzN2FhZDc5MTZhNjkwZWFiZDIyNzgwNjZiMzJiOWRkMGUyZmU3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2013-12-10 14:45:45.96673+01
yhy0d51fkw2ujzdq3on5d0akz3iksxc3	YzMzN2FhZDc5MTZhNjkwZWFiZDIyNzgwNjZiMzJiOWRkMGUyZmU3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2014-04-08 18:49:20.170232+02
4btg4gdwsycps3rd5wgwozm44dsrqsg2	YzMzN2FhZDc5MTZhNjkwZWFiZDIyNzgwNjZiMzJiOWRkMGUyZmU3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2014-04-09 21:00:31.87485+02
hkyqyw0jza5zcv746afydku658ar6mjf	YzMzN2FhZDc5MTZhNjkwZWFiZDIyNzgwNjZiMzJiOWRkMGUyZmU3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=	2014-04-22 10:32:01.90347+02
d1wpkpbh7ohbdfiucxvm21hopo8n38s1	NjBjNjNjNGVmZWY1NTJlMTA2MWUzNzU2NjhlZGQ2NGQwZmNiNmI3NDp7fQ==	2014-05-21 22:41:45.342194+02
\.


--
-- Data for Name: sim_core; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_core (id, ip, cpu, "time") FROM stdin;
5	10.39.32.236	0	2014-05-12 16:48:36.294934+02
6	10.39.32.236	1	2014-05-12 16:48:36.388397+02
7	10.39.32.236	2	2014-05-12 16:48:36.476182+02
8	10.39.32.236	3	2014-05-12 16:48:36.576339+02
2	127.0.0.1	1	2014-05-14 12:58:12.188772+02
1	127.0.0.1	0	2014-05-14 13:12:22.023479+02
3	127.0.0.1	2	2014-05-11 20:46:47.941416+02
4	127.0.0.1	3	2014-05-11 20:46:47.99938+02
\.


--
-- Name: sim_core_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_core_id_seq', 8, true);


--
-- Data for Name: sim_integration; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_integration (id, tend, tsteps, tstart, abs_tol, rel_tol) FROM stdin;
1	100	4000	0	9.99999999999999955e-07	9.99999999999999955e-07
2	20	100	0	9.99999999999999955e-07	9.99999999999999955e-07
3	100	2000	0	9.99999999999999955e-07	9.99999999999999955e-07
4	200	100	0	9.99999999999999955e-07	9.99999999999999955e-07
5	30	120	0	9.99999999999999955e-07	9.99999999999999955e-07
\.


--
-- Name: sim_integration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_integration_id_seq', 5, true);


--
-- Data for Name: sim_parameter; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_parameter (id, name, value, unit) FROM stdin;
1	flow_sin	0.000414230205846897982	m/s
2	y_dis	1.35565305299023715e-06	m
3	L	0.00041151555306306024	m
4	y_cell	6.84817502084485644e-06	m
5	y_sin	3.43887382257348824e-06	m
6	flow_sin	0.000205616501064500321	m/s
7	y_dis	9.79289581631819972e-07	m
8	L	0.000613198920904855756	m
9	y_cell	7.26390597805384113e-06	m
10	y_sin	4.67053239303063092e-06	m
11	flow_sin	0.000335233872584203671	m/s
12	y_dis	6.06835459376311372e-07	m
13	L	0.000360353922277020431	m
14	y_cell	6.81757658624711269e-06	m
15	y_sin	4.30359822584091101e-06	m
16	flow_sin	0.00012691952954798605	m/s
17	y_dis	1.89701523057496193e-06	m
18	L	0.000292284623796619145	m
19	y_cell	7.79695736911205473e-06	m
20	y_sin	5.0395112268872353e-06	m
21	flow_sin	0.000217557621475486935	m/s
22	y_dis	1.22709861697639958e-06	m
23	L	0.000488972710853521507	m
24	y_cell	6.99356175227507607e-06	m
25	y_sin	4.12045290610975835e-06	m
26	flow_sin	0.000664311086767884222	m/s
27	y_dis	2.56828285054436296e-06	m
28	L	0.000373401481237524153	m
29	y_cell	6.77185600877545612e-06	m
30	y_sin	4.87856823485489165e-06	m
31	flow_sin	0.000126412944790519672	m/s
32	y_dis	7.87211205672681747e-07	m
33	L	0.000459525656424189868	m
34	y_cell	7.79561186158189394e-06	m
35	y_sin	4.46569721878769929e-06	m
36	flow_sin	0.000292168651478586178	m/s
37	y_dis	8.6874134164450004e-07	m
38	L	0.000694711510685385347	m
39	y_cell	6.91589470802543386e-06	m
40	y_sin	3.97312943245543284e-06	m
41	flow_sin	7.5146820506568276e-05	m/s
42	y_dis	1.33810815397480827e-06	m
43	L	0.000486573818776916294	m
44	y_cell	7.55900993324106843e-06	m
45	y_sin	4.57078601484135932e-06	m
46	flow_sin	0.000162878551706858212	m/s
47	y_dis	9.44858357991384382e-07	m
48	L	0.00040684294937644289	m
49	y_cell	7.74083584425995237e-06	m
50	y_sin	3.87958162554479532e-06	m
51	flow_sin	7.75649515170041094e-05	m/s
52	y_dis	1.0498924317427171e-06	m
53	L	0.000471591647508919846	m
54	y_cell	6.11488017889573775e-06	m
55	y_sin	4.42617792193408583e-06	m
56	flow_sin	0.000127625349527436046	m/s
57	y_dis	5.31198791145003941e-07	m
58	L	0.00038493633501508306	m
59	y_cell	7.30795770886893855e-06	m
60	y_sin	4.85319987898435324e-06	m
61	flow_sin	0.000282294487030223813	m/s
62	y_dis	6.39164116897343438e-07	m
63	L	0.000374347719785367945	m
64	y_cell	7.41682860029472454e-06	m
65	y_sin	4.34897976717070697e-06	m
66	flow_sin	0.000109328251074152524	m/s
67	y_dis	1.29686855328566439e-06	m
68	L	0.000553507851112756835	m
69	y_cell	8.13640841159540556e-06	m
70	y_sin	4.04573725772717696e-06	m
71	flow_sin	0.000357462210133001508	m/s
72	y_dis	1.0859192711355388e-06	m
73	L	0.000453091037831248092	m
74	y_cell	7.02776786230796463e-06	m
75	y_sin	4.75275966796684233e-06	m
76	flow_sin	0.000235448390503798459	m/s
77	y_dis	1.08269592903097661e-06	m
78	L	0.000472405187425966309	m
79	y_cell	7.29622551951604259e-06	m
80	y_sin	3.80314920608638173e-06	m
81	flow_sin	0.00025044673175506234	m/s
82	y_dis	1.57814346969191687e-06	m
83	L	0.000428417043844759151	m
84	y_cell	5.68773474084952662e-06	m
85	y_sin	3.58111074551919882e-06	m
86	flow_sin	0.000222173140902927959	m/s
87	y_dis	8.10636192784129649e-07	m
88	L	0.000489768346730731817	m
89	y_cell	6.38005069158772829e-06	m
90	y_sin	4.43890806479167723e-06	m
91	flow_sin	0.000279862798023614229	m/s
92	y_dis	9.45723564065955635e-07	m
93	L	0.000581664502176075754	m
94	y_cell	6.83777308112602671e-06	m
95	y_sin	4.76723467470825852e-06	m
96	flow_sin	0.000532539760397331531	m/s
97	y_dis	1.57363009878614036e-06	m
98	L	0.000433967484817521633	m
99	y_cell	8.04587162994853948e-06	m
100	y_sin	4.00317873450849018e-06	m
101	flow_sin	0.000212265001290382109	m/s
102	y_dis	8.80607837748766575e-07	m
103	L	0.000436588643494368754	m
104	y_cell	8.48352408246365151e-06	m
105	y_sin	4.24907911900432989e-06	m
106	flow_sin	0.000248898586839717501	m/s
107	y_dis	9.72729398422282283e-07	m
108	L	0.000375037661782181349	m
109	y_cell	5.76652082842842623e-06	m
110	y_sin	4.58134557262037986e-06	m
111	flow_sin	0.000136518486174535739	m/s
112	y_dis	1.23439965959902035e-06	m
113	L	0.000440104520448851469	m
114	y_cell	7.22382538458600698e-06	m
115	y_sin	4.3713356295453837e-06	m
116	flow_sin	0.000478740670883241824	m/s
117	y_dis	2.19593563899017761e-06	m
118	L	0.000345350705170571477	m
119	y_cell	7.5449576447309698e-06	m
120	y_sin	4.37089491302418154e-06	m
121	flow_sin	0.000139696300073722217	m/s
122	y_dis	1.35561117451306466e-06	m
123	L	0.000354594709547504207	m
124	y_cell	6.43883198610010221e-06	m
125	y_sin	3.67822357502187067e-06	m
126	flow_sin	8.50900450503343128e-05	m/s
127	y_dis	1.21908942216839022e-06	m
128	L	0.000333603961330413519	m
129	y_cell	8.70554086332233375e-06	m
130	y_sin	4.2101627823055966e-06	m
131	flow_sin	0.000772387692704502404	m/s
132	y_dis	8.85179725589835784e-07	m
133	L	0.000730424993359463938	m
134	y_cell	7.48372820364644363e-06	m
135	y_sin	4.22966572403305556e-06	m
136	flow_sin	0.00061076340132979834	m/s
137	y_dis	1.10542734505617885e-06	m
138	L	0.000375687935965570926	m
139	y_cell	6.47644162058192195e-06	m
140	y_sin	4.44642808941191301e-06	m
141	flow_sin	0.000159297088955533074	m/s
142	y_dis	1.7026158459375814e-06	m
143	L	0.000619338569195737945	m
144	y_cell	7.91656384174889503e-06	m
145	y_sin	4.27537311949852397e-06	m
146	flow_sin	0.000436720718844037714	m/s
147	y_dis	7.43560289735249492e-07	m
148	L	0.000344531761460276152	m
149	y_cell	5.46834602599778554e-06	m
150	y_sin	4.04254950167780989e-06	m
151	flow_sin	0.000350919284728095423	m/s
152	y_dis	1.42886089156622427e-06	m
153	L	0.000386272923275861422	m
154	y_cell	6.29743119981384221e-06	m
155	y_sin	4.75324392303021351e-06	m
156	flow_sin	0.000266956265869112421	m/s
157	y_dis	1.23073324766799404e-06	m
158	L	0.000408854243595563696	m
159	y_cell	1.04977585977709306e-05	m
160	y_sin	3.94449390819719988e-06	m
161	flow_sin	0.000147759794558699183	m/s
162	y_dis	8.38689017735627239e-07	m
163	L	0.00044763985555740769	m
164	y_cell	7.2655307836718154e-06	m
165	y_sin	5.22334836929059249e-06	m
166	flow_sin	0.000292837245798979696	m/s
167	y_dis	3.8850512275208814e-07	m
168	L	0.000690567634132180147	m
169	y_cell	6.93372547289229189e-06	m
170	y_sin	4.35045333969067695e-06	m
171	flow_sin	0.00121054713418830106	m/s
172	y_dis	1.61416834508174375e-06	m
173	L	0.000497937039583328965	m
174	y_cell	8.63075679779288923e-06	m
175	y_sin	4.93398463472314639e-06	m
176	flow_sin	0.000296498771602286262	m/s
177	y_dis	1.19930210228144607e-06	m
178	L	0.000406441489811949037	m
179	y_cell	6.45900330889874097e-06	m
180	y_sin	3.99800387446846847e-06	m
181	flow_sin	0.00068030645076969402	m/s
182	y_dis	1.5087626401190696e-06	m
183	L	0.000474383322005355527	m
184	y_cell	8.21551668028292753e-06	m
185	y_sin	4.73396003273246897e-06	m
186	flow_sin	0.000215115051515002025	m/s
187	y_dis	1.1690608652682659e-06	m
188	L	0.000340999844901912193	m
189	y_cell	7.64946712173045733e-06	m
190	y_sin	4.68028044677032682e-06	m
191	flow_sin	0.000299197293391552117	m/s
192	y_dis	1.25367849554819166e-06	m
193	L	0.000647135497310757425	m
194	y_cell	6.18872117268167504e-06	m
195	y_sin	3.89003879441426088e-06	m
196	flow_sin	0.000138669731725249277	m/s
197	y_dis	1.50607500870218189e-06	m
198	L	0.000499902865155569783	m
199	y_cell	6.7853605915123543e-06	m
200	y_sin	4.34590443095077961e-06	m
201	flow_sin	0.000151023463800346403	m/s
202	y_dis	1.14675246159254614e-06	m
203	L	0.000478816610058940774	m
204	y_cell	7.76495890215301606e-06	m
205	y_sin	4.2465390365648605e-06	m
206	flow_sin	0.00028968178781871713	m/s
207	y_dis	1.36088842544746909e-06	m
208	L	0.000649200571052563694	m
209	y_cell	5.28183543860886591e-06	m
210	y_sin	3.77846036227604201e-06	m
211	flow_sin	0.000699237861512569956	m/s
212	y_dis	6.18688102100904216e-07	m
213	L	0.000451287389544495921	m
214	y_cell	7.97485229832763409e-06	m
215	y_sin	3.99551735544632587e-06	m
216	flow_sin	0.000227836259765396129	m/s
217	y_dis	1.73764885319629244e-06	m
218	L	0.000501415308775979458	m
219	y_cell	6.36076381670934793e-06	m
220	y_sin	4.74101731067841528e-06	m
221	flow_sin	0.000186213623850455928	m/s
222	y_dis	1.40424069994359658e-06	m
223	L	0.000684176727969607002	m
224	y_cell	8.33300965224532822e-06	m
225	y_sin	3.68331656455462098e-06	m
226	flow_sin	0.000110655039062756099	m/s
227	y_dis	1.00413543318536336e-06	m
228	L	0.000790958440004357194	m
229	y_cell	8.8133263346842476e-06	m
230	y_sin	3.80124974386080639e-06	m
231	flow_sin	0.000403468962157356806	m/s
232	y_dis	1.11692258446527904e-06	m
233	L	0.000617636367057245676	m
234	y_cell	8.04955504396456264e-06	m
235	y_sin	4.86659346007781577e-06	m
236	flow_sin	0.000224825561181237605	m/s
237	y_dis	8.35606102747977947e-07	m
238	L	0.000607266476300510828	m
239	y_cell	9.06528355955456393e-06	m
240	y_sin	3.89099698089070612e-06	m
241	flow_sin	0.000241681802775421434	m/s
242	y_dis	2.34918696575336882e-06	m
243	L	0.000414784236064455816	m
244	y_cell	6.11070467665682431e-06	m
245	y_sin	5.0449535057432174e-06	m
246	flow_sin	0.000140945259815143561	m/s
247	y_dis	8.73188245139076866e-07	m
248	L	0.000506558168024222734	m
249	y_cell	4.47709210621790668e-06	m
250	y_sin	5.56986914167262675e-06	m
251	flow_sin	0.000312872653568773275	m/s
252	y_dis	1.21229887647149324e-06	m
253	L	0.000706590562741520804	m
254	y_cell	6.57005990842301909e-06	m
255	y_sin	4.02892134445217076e-06	m
256	flow_sin	0.00050211829376213817	m/s
257	y_dis	9.5815838215042141e-07	m
258	L	0.000778659312389719358	m
259	y_cell	6.95831002953806392e-06	m
260	y_sin	4.31219336789990406e-06	m
261	flow_sin	0.000105251251783024767	m/s
262	y_dis	7.83500270048023084e-07	m
263	L	0.000551703926124712794	m
264	y_cell	7.63423193348672907e-06	m
265	y_sin	5.12548484151921072e-06	m
266	flow_sin	0.000159889481541464201	m/s
267	y_dis	9.77920279157940904e-07	m
268	L	0.00045741359235412321	m
269	y_cell	6.90380625819737341e-06	m
270	y_sin	4.74067857481980399e-06	m
271	flow_sin	0.000339043991947226805	m/s
272	y_dis	1.37719253796410058e-06	m
273	L	0.000693058694416094048	m
274	y_cell	7.63658433202959045e-06	m
275	y_sin	4.56652287975388295e-06	m
276	flow_sin	0.000362887258854166994	m/s
277	y_dis	9.28867897026318928e-07	m
278	L	0.000481740723741218302	m
279	y_cell	8.73189003131670831e-06	m
280	y_sin	4.57427874331985579e-06	m
281	flow_sin	0.000307613950541341422	m/s
282	y_dis	1.18665832364008429e-06	m
283	L	0.000471294113062825518	m
284	y_cell	5.68263000077875024e-06	m
285	y_sin	4.61223803374907345e-06	m
286	flow_sin	7.1014088780136598e-05	m/s
287	y_dis	1.24526613674556723e-06	m
288	L	0.000486238688604786421	m
289	y_cell	7.88575361345116207e-06	m
290	y_sin	4.71260696162888442e-06	m
291	flow_sin	0.000570609643254880484	m/s
292	y_dis	9.80168135815676932e-07	m
293	L	0.000733121955540470523	m
294	y_cell	7.04658428289033831e-06	m
295	y_sin	4.81319937867297784e-06	m
296	flow_sin	0.000314487002568873512	m/s
297	y_dis	5.4956731251943735e-07	m
298	L	0.000424572618993482895	m
299	y_cell	8.43742010321074568e-06	m
300	y_sin	4.53141152512509969e-06	m
301	flow_sin	7.50480606806391739e-05	m/s
302	y_dis	7.70576217311281111e-07	m
303	L	0.000527880618867067829	m
304	y_cell	6.49558944097310949e-06	m
305	y_sin	4.36214824467981955e-06	m
306	flow_sin	0.000275366908927585736	m/s
307	y_dis	1.34104152811704516e-06	m
308	L	0.000361104304424057039	m
309	y_cell	8.91629808740619129e-06	m
310	y_sin	4.64327849378843425e-06	m
311	flow_sin	0.00028551008704535665	m/s
312	y_dis	1.66482708427157435e-06	m
313	L	0.000734667164570903717	m
314	y_cell	6.45580055367412375e-06	m
315	y_sin	4.25541980006650457e-06	m
316	flow_sin	0.00040593146348217831	m/s
317	y_dis	1.16808663685048069e-06	m
318	L	0.000386626649077618525	m
319	y_cell	6.88575202650631017e-06	m
320	y_sin	4.67034154508398779e-06	m
321	flow_sin	8.39485958216993142e-05	m/s
322	y_dis	5.27995580477906812e-07	m
323	L	0.000537563728458661356	m
324	y_cell	6.07894072475770259e-06	m
325	y_sin	3.86330258991510634e-06	m
326	flow_sin	0.000367272070094485585	m/s
327	y_dis	8.56384294461970984e-07	m
328	L	0.000344210140181521189	m
329	y_cell	6.99894910583842599e-06	m
330	y_sin	4.71619427577186252e-06	m
331	flow_sin	5.51053466885484833e-05	m/s
332	y_dis	1.38024567449375458e-06	m
333	L	0.000535588741190880409	m
334	y_cell	7.28652001081230373e-06	m
335	y_sin	3.99524165127699067e-06	m
336	flow_sin	0.000128350341213200086	m/s
337	y_dis	1.65861126405265504e-06	m
338	L	0.00038771130373146381	m
339	y_cell	7.61986051436560674e-06	m
340	y_sin	4.58885102019930262e-06	m
341	flow_sin	0.000514824856241745898	m/s
342	y_dis	6.59346795614054635e-07	m
343	L	0.000729659416990295824	m
344	y_cell	6.43083347227032272e-06	m
345	y_sin	3.80136110954430887e-06	m
346	flow_sin	0.00042216713363904876	m/s
347	y_dis	9.44799493082921459e-07	m
348	L	0.000692606848824637547	m
349	y_cell	9.52862254973659942e-06	m
350	y_sin	3.99394468170925179e-06	m
351	flow_sin	0.000455037755289877937	m/s
352	y_dis	1.60932122368143441e-06	m
353	L	0.000518337187905404243	m
354	y_cell	7.33927707780033596e-06	m
355	y_sin	4.40320632917407885e-06	m
356	flow_sin	0.000180148388937816589	m/s
357	y_dis	8.90068636347591621e-07	m
358	L	0.000434010947705127997	m
359	y_cell	6.26001178856158134e-06	m
360	y_sin	5.42041418587731429e-06	m
361	flow_sin	0.000160646360746329286	m/s
362	y_dis	1.1289029100406278e-06	m
363	L	0.00051670728019399207	m
364	y_cell	6.24496216470638048e-06	m
365	y_sin	4.13984202164687188e-06	m
366	flow_sin	0.00025463981680670715	m/s
367	y_dis	1.81528538212586754e-06	m
368	L	0.000508337555707574881	m
369	y_cell	7.19904724844173562e-06	m
370	y_sin	4.72112983088122385e-06	m
371	flow_sin	0.000944943819660589465	m/s
372	y_dis	1.39829541050482157e-06	m
373	L	0.000417499094873570475	m
374	y_cell	5.59705786684859276e-06	m
375	y_sin	3.67125444502006127e-06	m
376	flow_sin	0.000330939010358396904	m/s
377	y_dis	9.99157710957318344e-07	m
378	L	0.000508505292318692714	m
379	y_cell	6.58370641996085793e-06	m
380	y_sin	3.79964156712608013e-06	m
381	flow_sin	0.000294138883580176088	m/s
382	y_dis	1.64427964826039418e-06	m
383	L	0.000433307705987383209	m
384	y_cell	7.38318726009071791e-06	m
385	y_sin	4.33697669852240853e-06	m
386	flow_sin	0.000160357623150770103	m/s
387	y_dis	1.23712888532922545e-06	m
388	L	0.000605173881701165394	m
389	y_cell	8.27148428300372459e-06	m
390	y_sin	3.83291769557118279e-06	m
391	flow_sin	0.000292749565305134218	m/s
392	y_dis	7.83029783677510736e-07	m
393	L	0.000377216480449522765	m
394	y_cell	7.7435815225212653e-06	m
395	y_sin	4.80197972410873073e-06	m
396	flow_sin	0.000588410406509632419	m/s
397	y_dis	7.14331356555778035e-07	m
398	L	0.000647274388400326858	m
399	y_cell	5.23983317850103362e-06	m
400	y_sin	3.83442274129556398e-06	m
401	flow_sin	0.000127434764811230406	m/s
402	y_dis	7.00293679259376561e-07	m
403	L	0.00062609180992501351	m
404	y_cell	6.05053898921355798e-06	m
405	y_sin	4.81219015710180239e-06	m
406	flow_sin	0.000605886365781781741	m/s
407	y_dis	1.67013813097458567e-06	m
408	L	0.000969148292980699351	m
409	y_cell	9.10215299581158687e-06	m
410	y_sin	4.46823550162592493e-06	m
411	flow_sin	0.000109068286866356875	m/s
412	y_dis	1.74064966929908879e-06	m
413	L	0.000601731718516439478	m
414	y_cell	8.85723985683817916e-06	m
415	y_sin	4.16237979733230589e-06	m
416	flow_sin	0.000136714445917713066	m/s
417	y_dis	1.31615542858693908e-06	m
418	L	0.000571447916289638124	m
419	y_cell	1.07462237697608252e-05	m
420	y_sin	3.92575931762313025e-06	m
421	flow_sin	0.000255857878676055161	m/s
422	y_dis	1.46529952311423535e-06	m
423	L	0.00035339031801239672	m
424	y_cell	8.18513576015356528e-06	m
425	y_sin	4.26866701118965594e-06	m
426	flow_sin	0.000361093565178146247	m/s
427	y_dis	1.51086768812690576e-06	m
428	L	0.00037170088057075437	m
429	y_cell	7.51562498008097388e-06	m
430	y_sin	4.68843405160979663e-06	m
431	flow_sin	0.000324620753870731593	m/s
432	y_dis	9.75421691976207617e-07	m
433	L	0.000528586444794536541	m
434	y_cell	5.77311214149937308e-06	m
435	y_sin	4.7481188764135941e-06	m
436	flow_sin	0.00017828586161858722	m/s
437	y_dis	1.3920068827087355e-06	m
438	L	0.00034976615319616208	m
439	y_cell	5.86861185748893637e-06	m
440	y_sin	4.75136755014050601e-06	m
441	flow_sin	0.000197013663674156544	m/s
442	y_dis	1.00080966135019943e-06	m
443	L	0.000555388314352158428	m
444	y_cell	5.55205750246046824e-06	m
445	y_sin	4.83298552537502812e-06	m
446	flow_sin	0.00022222892354343567	m/s
447	y_dis	9.50062077710785675e-07	m
448	L	0.000381976465391362617	m
449	y_cell	6.49144609146339799e-06	m
450	y_sin	4.32639987192857495e-06	m
451	flow_sin	4.65864067670496943e-05	m/s
452	y_dis	9.16149566061818816e-07	m
453	L	0.000408103791182670586	m
454	y_cell	9.40460725203993778e-06	m
455	y_sin	4.24573138217405043e-06	m
456	flow_sin	0.000152264610528288886	m/s
457	y_dis	1.28384865482971026e-06	m
458	L	0.000573958310142400324	m
459	y_cell	7.63749254564294681e-06	m
460	y_sin	5.49175958159165453e-06	m
461	flow_sin	0.000171322811408107598	m/s
462	y_dis	1.17909375848882534e-06	m
463	L	0.000444796927892851708	m
464	y_cell	6.33272569672492001e-06	m
465	y_sin	4.59258203535940119e-06	m
466	flow_sin	0.000343342006201097748	m/s
467	y_dis	1.19944988662639592e-06	m
468	L	0.000308836258636791341	m
469	y_cell	7.82033719235481927e-06	m
470	y_sin	3.91263044135311133e-06	m
471	flow_sin	9.10640943668805013e-05	m/s
472	y_dis	1.52859627804414494e-06	m
473	L	0.000456341193876924037	m
474	y_cell	7.74148678550392715e-06	m
475	y_sin	5.00807298793088234e-06	m
476	flow_sin	0.00035162572642029403	m/s
477	y_dis	1.30469871531355897e-06	m
478	L	0.000535512940711743669	m
479	y_cell	7.21420529790769782e-06	m
480	y_sin	4.65256161227447024e-06	m
481	flow_sin	0.000283467506874997028	m/s
482	y_dis	1.05233897297083252e-06	m
483	L	0.000453756810678556549	m
484	y_cell	7.47879817114751641e-06	m
485	y_sin	4.9600257992704043e-06	m
486	flow_sin	0.00116034074189847835	m/s
487	y_dis	1.22420265180433936e-06	m
488	L	0.000609664762751232288	m
489	y_cell	8.35425898544487396e-06	m
490	y_sin	4.12085620874531464e-06	m
491	flow_sin	0.000296548121102722625	m/s
492	y_dis	1.38368732266747165e-06	m
493	L	0.000454739260643646109	m
494	y_cell	7.45036556992990051e-06	m
495	y_sin	4.36771235944407414e-06	m
496	flow_sin	0.000228190363594101871	m/s
497	y_dis	8.44283853429872491e-07	m
498	L	0.000474785468427209702	m
499	y_cell	8.65885093754551168e-06	m
500	y_sin	3.72086469537025861e-06	m
501	Vmax_b2	1.65390887308976395e-06	mole_per_s
502	Vmax_b1	4.78398116461871535e-06	mole_per_s
503	Vmax_b2	2.52139844298152587e-06	mole_per_s
504	Vmax_b1	5.48710459801318947e-06	mole_per_s
505	Vmax_b2	2.79625349314614112e-06	mole_per_s
506	Vmax_b1	5.03612504920796318e-06	mole_per_s
507	Vmax_b2	1.57837778503383959e-06	mole_per_s
508	Vmax_b1	4.89732607451463438e-06	mole_per_s
509	Vmax_b2	2.20660918150296047e-06	mole_per_s
510	Vmax_b1	5.1686358563447928e-06	mole_per_s
511	Vmax_b2	2.27940997495116941e-06	mole_per_s
512	Vmax_b1	6.20688865521421194e-06	mole_per_s
513	Vmax_b2	2.1712411678575603e-06	mole_per_s
514	Vmax_b1	4.85569629982853901e-06	mole_per_s
515	Vmax_b2	2.00550230050935224e-06	mole_per_s
516	Vmax_b1	5.05020309608126069e-06	mole_per_s
517	Vmax_b2	2.0359331622297548e-06	mole_per_s
518	Vmax_b1	5.19425419003985166e-06	mole_per_s
519	Vmax_b2	1.52542779388865166e-06	mole_per_s
520	Vmax_b1	5.10739750393138256e-06	mole_per_s
521	Vmax_b2	2.81291807481995618e-06	mole_per_s
522	Vmax_b1	5.39610085856145011e-06	mole_per_s
523	Vmax_b2	1.92755577505701269e-06	mole_per_s
524	Vmax_b1	3.82357576631374406e-06	mole_per_s
525	Vmax_b2	1.89646033421135407e-06	mole_per_s
526	Vmax_b1	4.04372977598515442e-06	mole_per_s
527	Vmax_b2	1.74735644363270022e-06	mole_per_s
528	Vmax_b1	4.44767600696031534e-06	mole_per_s
529	Vmax_b2	9.99930454258926842e-07	mole_per_s
530	Vmax_b1	5.56014406721860418e-06	mole_per_s
531	Vmax_b2	1.72464471831121513e-06	mole_per_s
532	Vmax_b1	4.98803903923226171e-06	mole_per_s
533	Vmax_b2	2.60097513942270743e-06	mole_per_s
534	Vmax_b1	4.67382605923974063e-06	mole_per_s
535	Vmax_b2	2.32863246935131917e-06	mole_per_s
536	Vmax_b1	4.37424256578491887e-06	mole_per_s
537	Vmax_b2	2.90229437048982798e-06	mole_per_s
538	Vmax_b1	5.14452294928758184e-06	mole_per_s
539	Vmax_b2	1.50489810699632155e-06	mole_per_s
540	Vmax_b1	5.13307496215270103e-06	mole_per_s
541	Vmax_b2	2.6567642044070297e-06	mole_per_s
542	Vmax_b1	5.29702927065812506e-06	mole_per_s
543	Vmax_b2	1.47446972593039857e-06	mole_per_s
544	Vmax_b1	5.50524814071142971e-06	mole_per_s
545	Vmax_b2	1.44949662383009375e-06	mole_per_s
546	Vmax_b1	3.75234117497623355e-06	mole_per_s
547	Vmax_b2	1.57764495272670954e-06	mole_per_s
548	Vmax_b1	4.82809755585847563e-06	mole_per_s
549	Vmax_b2	1.41348511263140958e-06	mole_per_s
550	Vmax_b1	4.54586672558414469e-06	mole_per_s
551	Vmax_b2	2.24913423518129214e-06	mole_per_s
552	Vmax_b1	5.16655694304107601e-06	mole_per_s
553	Vmax_b2	2.54570602721657657e-06	mole_per_s
554	Vmax_b1	4.74621347680973189e-06	mole_per_s
555	Vmax_b2	1.8097392690829159e-06	mole_per_s
556	Vmax_b1	5.44993639988842037e-06	mole_per_s
557	Vmax_b2	1.66867299892754544e-06	mole_per_s
558	Vmax_b1	4.71656224106370833e-06	mole_per_s
559	Vmax_b2	2.17534588586152744e-06	mole_per_s
560	Vmax_b1	5.40067494664308031e-06	mole_per_s
561	Vmax_b2	3.57528157525572991e-06	mole_per_s
562	Vmax_b1	5.1461761149704138e-06	mole_per_s
563	Vmax_b2	1.67799541328000797e-06	mole_per_s
564	Vmax_b1	4.64063585133792868e-06	mole_per_s
565	Vmax_b2	2.17835528998615228e-06	mole_per_s
566	Vmax_b1	4.56345202849402568e-06	mole_per_s
567	Vmax_b2	2.02585030329567568e-06	mole_per_s
568	Vmax_b1	4.7139327736630185e-06	mole_per_s
569	Vmax_b2	1.96789068818739411e-06	mole_per_s
570	Vmax_b1	5.09263485798637059e-06	mole_per_s
571	Vmax_b2	1.85478254838894548e-06	mole_per_s
572	Vmax_b1	4.63614825179743258e-06	mole_per_s
573	Vmax_b2	2.61417923161216854e-06	mole_per_s
574	Vmax_b1	4.91147619788325743e-06	mole_per_s
575	Vmax_b2	2.09255369088667284e-06	mole_per_s
576	Vmax_b1	4.88251374869728488e-06	mole_per_s
577	Vmax_b2	2.60560854785570897e-06	mole_per_s
578	Vmax_b1	5.51354105122202996e-06	mole_per_s
579	Vmax_b2	1.55219024560647603e-06	mole_per_s
580	Vmax_b1	4.94345254071373662e-06	mole_per_s
581	Vmax_b2	1.71548484257457654e-06	mole_per_s
582	Vmax_b1	5.58580229052839313e-06	mole_per_s
583	Vmax_b2	1.56803758049504037e-06	mole_per_s
584	Vmax_b1	5.19204073971237005e-06	mole_per_s
585	Vmax_b2	2.0799779456061511e-06	mole_per_s
586	Vmax_b1	6.39748313080859348e-06	mole_per_s
587	Vmax_b2	2.16015642014269834e-06	mole_per_s
588	Vmax_b1	4.22774159012978967e-06	mole_per_s
589	Vmax_b2	1.38634950634141249e-06	mole_per_s
590	Vmax_b1	4.38884993612611315e-06	mole_per_s
591	Vmax_b2	1.93019854200231215e-06	mole_per_s
592	Vmax_b1	5.49460340859249569e-06	mole_per_s
593	Vmax_b2	1.65886101418860305e-06	mole_per_s
594	Vmax_b1	4.94385779374712277e-06	mole_per_s
595	Vmax_b2	2.10872024667922915e-06	mole_per_s
596	Vmax_b1	5.50330156167835348e-06	mole_per_s
597	Vmax_b2	2.07434959744412903e-06	mole_per_s
598	Vmax_b1	5.90678364387851885e-06	mole_per_s
599	Vmax_b2	2.3035497744418958e-06	mole_per_s
600	Vmax_b1	4.0897839964210628e-06	mole_per_s
601	Vmax_b2	1.70983503806323097e-06	mole_per_s
602	Vmax_b1	5.33595066390294781e-06	mole_per_s
603	Vmax_b2	2.33612400012335488e-06	mole_per_s
604	Vmax_b1	6.27782471217596106e-06	mole_per_s
605	Vmax_b2	2.74296578518436785e-06	mole_per_s
606	Vmax_b1	5.76874054467624912e-06	mole_per_s
607	Vmax_b2	2.32319031463010766e-06	mole_per_s
608	Vmax_b1	5.0758569806715313e-06	mole_per_s
609	Vmax_b2	2.29362227767535014e-06	mole_per_s
610	Vmax_b1	4.15461479368122093e-06	mole_per_s
611	Vmax_b2	1.97994256600127767e-06	mole_per_s
612	Vmax_b1	5.74812608740670324e-06	mole_per_s
613	Vmax_b2	1.74406782424676094e-06	mole_per_s
614	Vmax_b1	4.73109942544510675e-06	mole_per_s
615	Vmax_b2	1.99708722340787626e-06	mole_per_s
616	Vmax_b1	5.36671004090877297e-06	mole_per_s
617	Vmax_b2	2.69940360855200153e-06	mole_per_s
618	Vmax_b1	4.15855642648621173e-06	mole_per_s
619	Vmax_b2	1.41066334121525606e-06	mole_per_s
620	Vmax_b1	5.72009142720684207e-06	mole_per_s
621	Vmax_b2	2.87497883689586047e-06	mole_per_s
622	Vmax_b1	6.2306466720815642e-06	mole_per_s
623	Vmax_b2	1.97678125759912414e-06	mole_per_s
624	Vmax_b1	4.20074636273536829e-06	mole_per_s
625	Vmax_b2	1.93061646002377006e-06	mole_per_s
626	Vmax_b1	4.79747641617147443e-06	mole_per_s
627	Vmax_b2	2.99680787016719436e-06	mole_per_s
628	Vmax_b1	4.19808121961179521e-06	mole_per_s
629	Vmax_b2	1.81158114611829678e-06	mole_per_s
630	Vmax_b1	4.23574898560880671e-06	mole_per_s
631	Vmax_b2	1.68159799384783694e-06	mole_per_s
632	Vmax_b1	4.74920603044918184e-06	mole_per_s
633	Vmax_b2	2.11521391019855124e-06	mole_per_s
634	Vmax_b1	5.27740653186899624e-06	mole_per_s
635	Vmax_b2	1.71806700750575572e-06	mole_per_s
636	Vmax_b1	4.70104613548956782e-06	mole_per_s
637	Vmax_b2	1.57673836959305989e-06	mole_per_s
638	Vmax_b1	6.22547626950602187e-06	mole_per_s
639	Vmax_b2	2.39281029990808239e-06	mole_per_s
640	Vmax_b1	4.58482599845478321e-06	mole_per_s
641	Vmax_b2	2.29218469969426031e-06	mole_per_s
642	Vmax_b1	5.34933936357406423e-06	mole_per_s
643	Vmax_b2	1.60477224493504261e-06	mole_per_s
644	Vmax_b1	4.7306469103299009e-06	mole_per_s
645	Vmax_b2	1.97537475358134452e-06	mole_per_s
646	Vmax_b1	5.76473804000032354e-06	mole_per_s
647	Vmax_b2	1.92263796915937773e-06	mole_per_s
648	Vmax_b1	4.60102914699421184e-06	mole_per_s
649	Vmax_b2	2.00474131209027506e-06	mole_per_s
650	Vmax_b1	4.47690606161920664e-06	mole_per_s
651	Vmax_b2	1.5645754034254304e-06	mole_per_s
652	Vmax_b1	4.85239720635720877e-06	mole_per_s
653	Vmax_b2	1.72903377051994396e-06	mole_per_s
654	Vmax_b1	5.32435695132954793e-06	mole_per_s
655	Vmax_b2	3.17093900538831329e-06	mole_per_s
656	Vmax_b1	5.09342062822158815e-06	mole_per_s
657	Vmax_b2	2.45906617182531004e-06	mole_per_s
658	Vmax_b1	4.82071565492201706e-06	mole_per_s
659	Vmax_b2	2.23533007597933224e-06	mole_per_s
660	Vmax_b1	6.04755046725138447e-06	mole_per_s
661	Vmax_b2	1.58084071672693666e-06	mole_per_s
662	Vmax_b1	4.68323786791140464e-06	mole_per_s
663	Vmax_b2	1.70032665230914793e-06	mole_per_s
664	Vmax_b1	5.57403052648066356e-06	mole_per_s
665	Vmax_b2	2.59910509052016109e-06	mole_per_s
666	Vmax_b1	4.86535446863937312e-06	mole_per_s
667	Vmax_b2	1.8886458430264041e-06	mole_per_s
668	Vmax_b1	5.44031498385138591e-06	mole_per_s
669	Vmax_b2	1.8538438841032928e-06	mole_per_s
670	Vmax_b1	6.11051920477598465e-06	mole_per_s
671	Vmax_b2	2.93436597514449466e-06	mole_per_s
672	Vmax_b1	5.63601734062406902e-06	mole_per_s
673	Vmax_b2	2.21596468644916088e-06	mole_per_s
674	Vmax_b1	4.42449478059767901e-06	mole_per_s
675	Vmax_b2	1.97700189108243246e-06	mole_per_s
676	Vmax_b1	5.26268559061315366e-06	mole_per_s
677	Vmax_b2	2.91935000173326854e-06	mole_per_s
678	Vmax_b1	4.3410899698555602e-06	mole_per_s
679	Vmax_b2	1.98407455775724419e-06	mole_per_s
680	Vmax_b1	4.8598171068910444e-06	mole_per_s
681	Vmax_b2	2.02655733811283732e-06	mole_per_s
682	Vmax_b1	4.42497200013844167e-06	mole_per_s
683	Vmax_b2	1.9207568237952234e-06	mole_per_s
684	Vmax_b1	4.57707126578910609e-06	mole_per_s
685	Vmax_b2	2.36005796714734748e-06	mole_per_s
686	Vmax_b1	6.36296748445337788e-06	mole_per_s
687	Vmax_b2	1.85933612195926501e-06	mole_per_s
688	Vmax_b1	4.98719408454853304e-06	mole_per_s
689	Vmax_b2	2.72309831385223409e-06	mole_per_s
690	Vmax_b1	5.5022701047328815e-06	mole_per_s
691	Vmax_b2	1.30594172363949009e-06	mole_per_s
692	Vmax_b1	4.73282077748466898e-06	mole_per_s
693	Vmax_b2	1.87782852791912909e-06	mole_per_s
694	Vmax_b1	4.98790205444937656e-06	mole_per_s
695	Vmax_b2	1.81703940110846153e-06	mole_per_s
696	Vmax_b1	3.68114430599733121e-06	mole_per_s
697	Vmax_b2	2.54427844183343296e-06	mole_per_s
698	Vmax_b1	4.51806924416406501e-06	mole_per_s
699	Vmax_b2	1.83467623367535087e-06	mole_per_s
700	Vmax_b1	4.66848113992174607e-06	mole_per_s
701	Vmax_b2	1.79590524473779407e-06	mole_per_s
702	Vmax_b1	4.34806462022343365e-06	mole_per_s
703	Vmax_b2	2.20939536445505076e-06	mole_per_s
704	Vmax_b1	5.41216870501314756e-06	mole_per_s
705	Vmax_b2	1.97452277055865308e-06	mole_per_s
706	Vmax_b1	5.92602708416755422e-06	mole_per_s
707	Vmax_b2	1.33545648416552535e-06	mole_per_s
708	Vmax_b1	5.63271604871753353e-06	mole_per_s
709	Vmax_b2	1.57665007416990595e-06	mole_per_s
710	Vmax_b1	4.74574206868419835e-06	mole_per_s
711	Vmax_b2	1.82978611278643098e-06	mole_per_s
712	Vmax_b1	5.58125481925274186e-06	mole_per_s
713	Vmax_b2	1.76500785569450037e-06	mole_per_s
714	Vmax_b1	6.14798872737469744e-06	mole_per_s
715	Vmax_b2	1.68589778140165871e-06	mole_per_s
716	Vmax_b1	4.45231262294218605e-06	mole_per_s
717	Vmax_b2	1.63983028629603899e-06	mole_per_s
718	Vmax_b1	4.75916315601173635e-06	mole_per_s
719	Vmax_b2	1.71741523947606383e-06	mole_per_s
720	Vmax_b1	4.55681777398899157e-06	mole_per_s
721	Vmax_b2	1.75375279829113129e-06	mole_per_s
722	Vmax_b1	5.48679176153025343e-06	mole_per_s
723	Vmax_b2	2.45106941191113452e-06	mole_per_s
724	Vmax_b1	4.5868389253651859e-06	mole_per_s
725	Vmax_b2	1.89184642348495642e-06	mole_per_s
726	Vmax_b1	5.17931081504910553e-06	mole_per_s
727	Vmax_b2	2.94571653910643179e-06	mole_per_s
728	Vmax_b1	4.83050949808840155e-06	mole_per_s
729	Vmax_b2	1.66377718328537957e-06	mole_per_s
730	Vmax_b1	4.96254821236713151e-06	mole_per_s
731	Vmax_b2	1.49417807174680756e-06	mole_per_s
732	Vmax_b1	4.03112953140051605e-06	mole_per_s
733	Vmax_b2	2.2735883573065744e-06	mole_per_s
734	Vmax_b1	4.71246063878878835e-06	mole_per_s
735	Vmax_b2	1.55785133191961425e-06	mole_per_s
736	Vmax_b1	4.09646626459770128e-06	mole_per_s
737	Vmax_b2	2.02287852320486536e-06	mole_per_s
738	Vmax_b1	4.59397481840659223e-06	mole_per_s
739	Vmax_b2	1.90472491026508796e-06	mole_per_s
740	Vmax_b1	4.83514594994614111e-06	mole_per_s
741	Vmax_b2	2.11865973495619218e-06	mole_per_s
742	Vmax_b1	5.50262759680457139e-06	mole_per_s
743	Vmax_b2	1.60593807498125526e-06	mole_per_s
744	Vmax_b1	4.44653910723550416e-06	mole_per_s
745	Vmax_b2	2.15809158935456759e-06	mole_per_s
746	Vmax_b1	5.79092598921004813e-06	mole_per_s
747	Vmax_b2	2.83596919368872798e-06	mole_per_s
748	Vmax_b1	5.23021123611420801e-06	mole_per_s
749	Vmax_b2	1.6511967622502801e-06	mole_per_s
750	Vmax_b1	5.21593445119262296e-06	mole_per_s
751	Vmax_b2	1.73758580159238324e-06	mole_per_s
752	Vmax_b1	4.74543979372185519e-06	mole_per_s
753	Vmax_b2	2.21295688503570881e-06	mole_per_s
754	Vmax_b1	5.91402888735355739e-06	mole_per_s
755	Vmax_b2	1.68422427747178526e-06	mole_per_s
756	Vmax_b1	4.71899216946309824e-06	mole_per_s
757	Vmax_b2	1.52098788501835575e-06	mole_per_s
758	Vmax_b1	4.74976413522264331e-06	mole_per_s
759	Vmax_b2	1.65320133890286818e-06	mole_per_s
760	Vmax_b1	5.49412942742996045e-06	mole_per_s
761	Vmax_b2	2.15446861416335215e-06	mole_per_s
762	Vmax_b1	4.9109445566027115e-06	mole_per_s
763	Vmax_b2	1.51126790083162358e-06	mole_per_s
764	Vmax_b1	4.56923471751260895e-06	mole_per_s
765	Vmax_b2	2.89662578089788993e-06	mole_per_s
766	Vmax_b1	4.34240923468070655e-06	mole_per_s
767	Vmax_b2	1.69723652022086696e-06	mole_per_s
768	Vmax_b1	4.91650408186778795e-06	mole_per_s
769	Vmax_b2	2.566704338586518e-06	mole_per_s
770	Vmax_b1	4.75233206241654101e-06	mole_per_s
771	Vmax_b2	1.40718820367126761e-06	mole_per_s
772	Vmax_b1	5.54834373541004339e-06	mole_per_s
773	Vmax_b2	2.0780365636472649e-06	mole_per_s
774	Vmax_b1	5.4811652615264456e-06	mole_per_s
775	Vmax_b2	1.61718906561668487e-06	mole_per_s
776	Vmax_b1	4.34211015946760243e-06	mole_per_s
777	Vmax_b2	1.68306673431002725e-06	mole_per_s
778	Vmax_b1	5.01149720023256074e-06	mole_per_s
779	Vmax_b2	1.86398077083087514e-06	mole_per_s
780	Vmax_b1	4.68340640267791695e-06	mole_per_s
781	Vmax_b2	1.96787652051094318e-06	mole_per_s
782	Vmax_b1	5.07928811142647302e-06	mole_per_s
783	Vmax_b2	1.90277579211300847e-06	mole_per_s
784	Vmax_b1	5.12917658836114789e-06	mole_per_s
785	Vmax_b2	1.85878950642214528e-06	mole_per_s
786	Vmax_b1	4.57255888996720523e-06	mole_per_s
787	Vmax_b2	1.60507136473356842e-06	mole_per_s
788	Vmax_b1	4.47846138156525385e-06	mole_per_s
789	Vmax_b2	1.98700291889498644e-06	mole_per_s
790	Vmax_b1	5.02088899916906362e-06	mole_per_s
791	Vmax_b2	1.93735666577625033e-06	mole_per_s
792	Vmax_b1	4.50660656283676189e-06	mole_per_s
793	Vmax_b2	1.71477913024331739e-06	mole_per_s
794	Vmax_b1	4.15301134132537864e-06	mole_per_s
795	Vmax_b2	2.36044340590530595e-06	mole_per_s
796	Vmax_b1	4.76868724387793966e-06	mole_per_s
797	Vmax_b2	1.67731913046707594e-06	mole_per_s
798	Vmax_b1	4.59567855737937582e-06	mole_per_s
799	Vmax_b2	2.05942430427634682e-06	mole_per_s
800	Vmax_b1	5.01479995233156901e-06	mole_per_s
801	Vmax_b2	2.00499392629523297e-06	mole_per_s
802	Vmax_b1	4.98859352916945541e-06	mole_per_s
803	Vmax_b2	2.50562100080697987e-06	mole_per_s
804	Vmax_b1	5.87583889172281162e-06	mole_per_s
805	Vmax_b2	1.97850142392943778e-06	mole_per_s
806	Vmax_b1	5.33003888921996063e-06	mole_per_s
807	Vmax_b2	1.95403298146834648e-06	mole_per_s
808	Vmax_b1	4.90822592761916796e-06	mole_per_s
809	Vmax_b2	2.16596474340682633e-06	mole_per_s
810	Vmax_b1	6.23136165882104322e-06	mole_per_s
811	Vmax_b2	3.79767625346362498e-06	mole_per_s
812	Vmax_b1	4.95662675097883631e-06	mole_per_s
813	Vmax_b2	2.32878493260084666e-06	mole_per_s
814	Vmax_b1	5.53841530194597964e-06	mole_per_s
815	Vmax_b2	1.74632932139217379e-06	mole_per_s
816	Vmax_b1	5.1274430820255817e-06	mole_per_s
817	Vmax_b2	2.05344247741175916e-06	mole_per_s
818	Vmax_b1	4.31583092437781755e-06	mole_per_s
819	Vmax_b2	2.11410391087565992e-06	mole_per_s
820	Vmax_b1	4.66685918336321282e-06	mole_per_s
821	Vmax_b2	1.77875126813756774e-06	mole_per_s
822	Vmax_b1	4.15441822141195904e-06	mole_per_s
823	Vmax_b2	1.73138694381799986e-06	mole_per_s
824	Vmax_b1	5.25083990230932022e-06	mole_per_s
825	Vmax_b2	1.41319800973945379e-06	mole_per_s
826	Vmax_b1	4.36414185756809819e-06	mole_per_s
827	Vmax_b2	2.01668476242526612e-06	mole_per_s
828	Vmax_b1	5.13371887044334183e-06	mole_per_s
829	Vmax_b2	2.06981545366860473e-06	mole_per_s
830	Vmax_b1	5.50668577211416966e-06	mole_per_s
831	Vmax_b2	2.06511578254421296e-06	mole_per_s
832	Vmax_b1	4.43695508897080962e-06	mole_per_s
833	Vmax_b2	2.96531885158584409e-06	mole_per_s
834	Vmax_b1	5.15837000148762284e-06	mole_per_s
835	Vmax_b2	1.79322896759011111e-06	mole_per_s
836	Vmax_b1	4.38984016267314353e-06	mole_per_s
837	Vmax_b2	1.59360502451924844e-06	mole_per_s
838	Vmax_b1	5.85739069312729385e-06	mole_per_s
839	Vmax_b2	3.35554732067473249e-06	mole_per_s
840	Vmax_b1	4.74498829735642945e-06	mole_per_s
841	Vmax_b2	1.86611217247990146e-06	mole_per_s
842	Vmax_b1	4.20688619695450938e-06	mole_per_s
843	Vmax_b2	1.88791701213967917e-06	mole_per_s
844	Vmax_b1	5.72806025336801546e-06	mole_per_s
845	Vmax_b2	1.8158574675404979e-06	mole_per_s
846	Vmax_b1	4.49970454652534726e-06	mole_per_s
847	Vmax_b2	1.82519596100847581e-06	mole_per_s
848	Vmax_b1	5.32772072661993563e-06	mole_per_s
849	Vmax_b2	2.02977491000159864e-06	mole_per_s
850	Vmax_b1	5.2463555097363729e-06	mole_per_s
851	Vmax_b2	2.85906004326991835e-06	mole_per_s
852	Vmax_b1	4.93329730057732051e-06	mole_per_s
853	Vmax_b2	2.5757155091156615e-06	mole_per_s
854	Vmax_b1	5.08117184864567045e-06	mole_per_s
855	Vmax_b2	1.79527757107386831e-06	mole_per_s
856	Vmax_b1	5.07058849299252565e-06	mole_per_s
857	Vmax_b2	2.56020614208062367e-06	mole_per_s
858	Vmax_b1	5.7003608241607972e-06	mole_per_s
859	Vmax_b2	2.74088540485431095e-06	mole_per_s
860	Vmax_b1	4.13225351876179895e-06	mole_per_s
861	Vmax_b2	1.40692247998327793e-06	mole_per_s
862	Vmax_b1	4.32698274737796349e-06	mole_per_s
863	Vmax_b2	1.58267791807790379e-06	mole_per_s
864	Vmax_b1	5.02922372973593616e-06	mole_per_s
865	Vmax_b2	2.05107400162141827e-06	mole_per_s
866	Vmax_b1	5.13069227149179864e-06	mole_per_s
867	Vmax_b2	1.92281807254869519e-06	mole_per_s
868	Vmax_b1	4.75987366711083196e-06	mole_per_s
869	Vmax_b2	1.59501482012267531e-06	mole_per_s
870	Vmax_b1	5.1134204435633097e-06	mole_per_s
871	Vmax_b2	1.57895412997421302e-06	mole_per_s
872	Vmax_b1	4.87300323897165677e-06	mole_per_s
873	Vmax_b2	1.85814687134671084e-06	mole_per_s
874	Vmax_b1	6.02571838722306492e-06	mole_per_s
875	Vmax_b2	2.06316819475498845e-06	mole_per_s
876	Vmax_b1	5.05114872329174148e-06	mole_per_s
877	Vmax_b2	2.32728488535600313e-06	mole_per_s
878	Vmax_b1	5.81692060982334213e-06	mole_per_s
879	Vmax_b2	1.33219880621354742e-06	mole_per_s
880	Vmax_b1	6.25530337113345481e-06	mole_per_s
881	Vmax_b2	2.00256552505847903e-06	mole_per_s
882	Vmax_b1	4.91005997060269027e-06	mole_per_s
883	Vmax_b2	2.69500338571432864e-06	mole_per_s
884	Vmax_b1	5.09651003748267254e-06	mole_per_s
885	Vmax_b2	2.09390000226502876e-06	mole_per_s
886	Vmax_b1	5.98735232205308451e-06	mole_per_s
887	Vmax_b2	2.07341080317261032e-06	mole_per_s
888	Vmax_b1	5.43898200293988266e-06	mole_per_s
889	Vmax_b2	1.69295097907692783e-06	mole_per_s
890	Vmax_b1	4.76929333762396099e-06	mole_per_s
891	Vmax_b2	2.10003139904590144e-06	mole_per_s
892	Vmax_b1	4.52582601406567434e-06	mole_per_s
893	Vmax_b2	2.43712599372294144e-06	mole_per_s
894	Vmax_b1	5.35590516440329476e-06	mole_per_s
895	Vmax_b2	1.8750253931942409e-06	mole_per_s
896	Vmax_b1	5.39295299146824756e-06	mole_per_s
897	Vmax_b2	2.49600654430425331e-06	mole_per_s
898	Vmax_b1	4.72096151957987627e-06	mole_per_s
899	Vmax_b2	2.0267457906654908e-06	mole_per_s
900	Vmax_b1	4.61148034537226757e-06	mole_per_s
901	Vmax_b2	2.22903350298690852e-06	mole_per_s
902	Vmax_b1	4.46646475391458708e-06	mole_per_s
903	Vmax_b2	2.45333416382564941e-06	mole_per_s
904	Vmax_b1	5.09756732783162359e-06	mole_per_s
905	Vmax_b2	1.63515363455015126e-06	mole_per_s
906	Vmax_b1	4.45979355654658949e-06	mole_per_s
907	Vmax_b2	1.97140924653176195e-06	mole_per_s
908	Vmax_b1	5.52921519425555682e-06	mole_per_s
909	Vmax_b2	2.08924380617775593e-06	mole_per_s
910	Vmax_b1	6.05717326604444171e-06	mole_per_s
911	Vmax_b2	1.57550626750003972e-06	mole_per_s
912	Vmax_b1	4.08014664233400173e-06	mole_per_s
913	Vmax_b2	2.20026444266535995e-06	mole_per_s
914	Vmax_b1	6.27459490598020143e-06	mole_per_s
915	Vmax_b2	1.96583620994499468e-06	mole_per_s
916	Vmax_b1	5.32010663873447142e-06	mole_per_s
917	Vmax_b2	1.7538382535082797e-06	mole_per_s
918	Vmax_b1	4.78858785134337388e-06	mole_per_s
919	Vmax_b2	1.71649644185923732e-06	mole_per_s
920	Vmax_b1	3.98317166075165909e-06	mole_per_s
921	Vmax_b2	1.7926073077803032e-06	mole_per_s
922	Vmax_b1	4.72808817626422513e-06	mole_per_s
923	Vmax_b2	1.5740052738279862e-06	mole_per_s
924	Vmax_b1	5.3837192568564657e-06	mole_per_s
925	Vmax_b2	2.0491164560097074e-06	mole_per_s
926	Vmax_b1	5.08428923458180351e-06	mole_per_s
927	Vmax_b2	2.18492204546339167e-06	mole_per_s
928	Vmax_b1	4.68888396297095997e-06	mole_per_s
929	Vmax_b2	2.45895967650093945e-06	mole_per_s
930	Vmax_b1	5.19218312904533757e-06	mole_per_s
931	Vmax_b2	1.69605066291804556e-06	mole_per_s
932	Vmax_b1	4.7710691115021815e-06	mole_per_s
933	Vmax_b2	2.01455776606919714e-06	mole_per_s
934	Vmax_b1	4.68172046056047037e-06	mole_per_s
935	Vmax_b2	1.21485512080553706e-06	mole_per_s
936	Vmax_b1	5.64109028857052624e-06	mole_per_s
937	Vmax_b2	2.67921080760774363e-06	mole_per_s
938	Vmax_b1	4.93742911531984154e-06	mole_per_s
939	Vmax_b2	1.7131247690710772e-06	mole_per_s
940	Vmax_b1	5.02288568387538447e-06	mole_per_s
941	Vmax_b2	1.28156502389544703e-06	mole_per_s
942	Vmax_b1	4.89786662142231462e-06	mole_per_s
943	Vmax_b2	1.60466299428549381e-06	mole_per_s
944	Vmax_b1	5.40331000755370458e-06	mole_per_s
945	Vmax_b2	2.40935071001793454e-06	mole_per_s
946	Vmax_b1	5.11353635997922484e-06	mole_per_s
947	Vmax_b2	1.84324272109024824e-06	mole_per_s
948	Vmax_b1	4.5682844783585793e-06	mole_per_s
949	Vmax_b2	2.03994454227631501e-06	mole_per_s
950	Vmax_b1	4.17399242869243274e-06	mole_per_s
951	Vmax_b2	3.85241653694153176e-06	mole_per_s
952	Vmax_b1	6.14745233478239004e-06	mole_per_s
953	Vmax_b2	1.53294637870761287e-06	mole_per_s
954	Vmax_b1	4.63941118384162169e-06	mole_per_s
955	Vmax_b2	1.3159149920047052e-06	mole_per_s
956	Vmax_b1	5.11289764882812774e-06	mole_per_s
957	Vmax_b2	1.58992313094506585e-06	mole_per_s
958	Vmax_b1	5.10486949411411875e-06	mole_per_s
959	Vmax_b2	1.48434564266932321e-06	mole_per_s
960	Vmax_b1	5.4130596563425707e-06	mole_per_s
961	Vmax_b2	2.14677469770065585e-06	mole_per_s
962	Vmax_b1	5.99727356814713131e-06	mole_per_s
963	Vmax_b2	1.7855259528058932e-06	mole_per_s
964	Vmax_b1	4.87764358697080482e-06	mole_per_s
965	Vmax_b2	2.35804193378256536e-06	mole_per_s
966	Vmax_b1	5.85832898170686538e-06	mole_per_s
967	Vmax_b2	1.87360892184623336e-06	mole_per_s
968	Vmax_b1	5.57829854421511443e-06	mole_per_s
969	Vmax_b2	1.9790957194482427e-06	mole_per_s
970	Vmax_b1	5.83528330604149452e-06	mole_per_s
971	Vmax_b2	1.8634166479436512e-06	mole_per_s
972	Vmax_b1	4.38348641748067066e-06	mole_per_s
973	Vmax_b2	2.4692072124696818e-06	mole_per_s
974	Vmax_b1	4.38630238200699416e-06	mole_per_s
975	Vmax_b2	1.60061112752535185e-06	mole_per_s
976	Vmax_b1	4.72990885045377666e-06	mole_per_s
977	Vmax_b2	1.77205364588988755e-06	mole_per_s
978	Vmax_b1	5.33395384084749579e-06	mole_per_s
979	Vmax_b2	1.71560751744964107e-06	mole_per_s
980	Vmax_b1	5.24596665241163174e-06	mole_per_s
981	Vmax_b2	1.90732296806734359e-06	mole_per_s
982	Vmax_b1	4.59508240274856512e-06	mole_per_s
983	Vmax_b2	1.52875956324697367e-06	mole_per_s
984	Vmax_b1	5.54688384056691325e-06	mole_per_s
985	Vmax_b2	2.87232300070523329e-06	mole_per_s
986	Vmax_b1	4.90563188921722164e-06	mole_per_s
987	Vmax_b2	1.21523643849489813e-06	mole_per_s
988	Vmax_b1	4.93113077684437405e-06	mole_per_s
989	Vmax_b2	1.60763286645044394e-06	mole_per_s
990	Vmax_b1	4.4997446474205571e-06	mole_per_s
991	Vmax_b2	2.31887845466342154e-06	mole_per_s
992	Vmax_b1	5.03535577472931313e-06	mole_per_s
993	Vmax_b2	2.55176920290049021e-06	mole_per_s
994	Vmax_b1	5.59928069094107643e-06	mole_per_s
995	Vmax_b2	1.56834193750890762e-06	mole_per_s
996	Vmax_b1	4.72413895218053074e-06	mole_per_s
997	Vmax_b2	2.14456647452422817e-06	mole_per_s
998	Vmax_b1	5.64529102280990815e-06	mole_per_s
999	Vmax_b2	2.10038603559555489e-06	mole_per_s
1000	Vmax_b1	5.74771516098385246e-06	mole_per_s
1001	Vmax_b2	1.79201183991361611e-06	mole_per_s
1002	Vmax_b1	4.28233509554976377e-06	mole_per_s
1003	Vmax_b2	2.16122846359917646e-06	mole_per_s
1004	Vmax_b1	4.61146320786609528e-06	mole_per_s
1005	Vmax_b2	2.24974811382269194e-06	mole_per_s
1006	Vmax_b1	4.42462537338978295e-06	mole_per_s
1007	Vmax_b2	2.16890392606102168e-06	mole_per_s
1008	Vmax_b1	5.41224612126262717e-06	mole_per_s
1009	Vmax_b2	1.5313103834121831e-06	mole_per_s
1010	Vmax_b1	4.93694617937945384e-06	mole_per_s
1011	Vmax_b2	1.64733159104933461e-06	mole_per_s
1012	Vmax_b1	4.14510720003709432e-06	mole_per_s
1013	Vmax_b2	1.49909584286461261e-06	mole_per_s
1014	Vmax_b1	5.03187944239131548e-06	mole_per_s
1015	Vmax_b2	1.63865569381376909e-06	mole_per_s
1016	Vmax_b1	5.9216830261379745e-06	mole_per_s
1017	Vmax_b2	1.97191030692023865e-06	mole_per_s
1018	Vmax_b1	5.97299163100591489e-06	mole_per_s
1019	Vmax_b2	1.66486847019061451e-06	mole_per_s
1020	Vmax_b1	4.7483184686589497e-06	mole_per_s
1021	Vmax_b2	2.42774632255486478e-06	mole_per_s
1022	Vmax_b1	5.59069317806204615e-06	mole_per_s
1023	Vmax_b2	1.94599502262627417e-06	mole_per_s
1024	Vmax_b1	4.74244139925537667e-06	mole_per_s
1025	Vmax_b2	1.49143944377140504e-06	mole_per_s
1026	Vmax_b1	4.99179996100052725e-06	mole_per_s
1027	Vmax_b2	1.93661237480658629e-06	mole_per_s
1028	Vmax_b1	5.68885727005072888e-06	mole_per_s
1029	Vmax_b2	2.00135302268084219e-06	mole_per_s
1030	Vmax_b1	4.0413026581633256e-06	mole_per_s
1031	Vmax_b2	2.1265832605961934e-06	mole_per_s
1032	Vmax_b1	4.9433426270430296e-06	mole_per_s
1033	Vmax_b2	1.9336697644843324e-06	mole_per_s
1034	Vmax_b1	4.79082248665382852e-06	mole_per_s
1035	Vmax_b2	3.15403001454329289e-06	mole_per_s
1036	Vmax_b1	5.91541375901133815e-06	mole_per_s
1037	Vmax_b2	1.57522261975152762e-06	mole_per_s
1038	Vmax_b1	4.27189040682327182e-06	mole_per_s
1039	Vmax_b2	2.41425920461656475e-06	mole_per_s
1040	Vmax_b1	5.04091942977713277e-06	mole_per_s
1041	Vmax_b2	1.97121748435819644e-06	mole_per_s
1042	Vmax_b1	4.46806978307797427e-06	mole_per_s
1043	Vmax_b2	2.7480126209294766e-06	mole_per_s
1044	Vmax_b1	5.05533003192730531e-06	mole_per_s
1045	Vmax_b2	2.09832893004620438e-06	mole_per_s
1046	Vmax_b1	4.85274493996766547e-06	mole_per_s
1047	Vmax_b2	1.74034251238800836e-06	mole_per_s
1048	Vmax_b1	5.05302541103996525e-06	mole_per_s
1049	Vmax_b2	1.97681571238593542e-06	mole_per_s
1050	Vmax_b1	5.01267836897836517e-06	mole_per_s
1051	Vmax_b2	2.39689115128600582e-06	mole_per_s
1052	Vmax_b1	5.01751657459119174e-06	mole_per_s
1053	Vmax_b2	2.28937919918592424e-06	mole_per_s
1054	Vmax_b1	4.77058149028154368e-06	mole_per_s
1055	Vmax_b2	1.31858212762361745e-06	mole_per_s
1056	Vmax_b1	4.78074823063938839e-06	mole_per_s
1057	Vmax_b2	1.71584547713771682e-06	mole_per_s
1058	Vmax_b1	5.31258106399589326e-06	mole_per_s
1059	Vmax_b2	2.23483268125271021e-06	mole_per_s
1060	Vmax_b1	5.03708087748534861e-06	mole_per_s
1061	Vmax_b2	1.81992859297218132e-06	mole_per_s
1062	Vmax_b1	4.47076187279001938e-06	mole_per_s
1063	Vmax_b2	2.02019651691700106e-06	mole_per_s
1064	Vmax_b1	5.09064348859490195e-06	mole_per_s
1065	Vmax_b2	1.78906737739513926e-06	mole_per_s
1066	Vmax_b1	4.68065302510379043e-06	mole_per_s
1067	Vmax_b2	2.05273753175990347e-06	mole_per_s
1068	Vmax_b1	4.82442227814662103e-06	mole_per_s
1069	Vmax_b2	3.17460465946934786e-06	mole_per_s
1070	Vmax_b1	4.21677627394813122e-06	mole_per_s
1071	Vmax_b2	2.02267340942102463e-06	mole_per_s
1072	Vmax_b1	4.80461474296663234e-06	mole_per_s
1073	Vmax_b2	2.01396688320771106e-06	mole_per_s
1074	Vmax_b1	5.26692203761343706e-06	mole_per_s
1075	Vmax_b2	2.64391603717230243e-06	mole_per_s
1076	Vmax_b1	4.64317352474379399e-06	mole_per_s
1077	Vmax_b2	1.77756394320987539e-06	mole_per_s
1078	Vmax_b1	4.78570677423524137e-06	mole_per_s
1079	Vmax_b2	2.33171732703548551e-06	mole_per_s
1080	Vmax_b1	5.44217850859621604e-06	mole_per_s
1081	Vmax_b2	2.83785861823175922e-06	mole_per_s
1082	Vmax_b1	4.77188133803851444e-06	mole_per_s
1083	Vmax_b2	1.90471763814255626e-06	mole_per_s
1084	Vmax_b1	5.47540686323202195e-06	mole_per_s
1085	Vmax_b2	1.84746053530739247e-06	mole_per_s
1086	Vmax_b1	4.94981605014504424e-06	mole_per_s
1087	Vmax_b2	2.054390923730006e-06	mole_per_s
1088	Vmax_b1	4.95821892126581137e-06	mole_per_s
1089	Vmax_b2	1.77043318459815149e-06	mole_per_s
1090	Vmax_b1	4.72338240072475618e-06	mole_per_s
1091	Vmax_b2	1.54534136560699257e-06	mole_per_s
1092	Vmax_b1	5.4121250161549015e-06	mole_per_s
1093	Vmax_b2	1.71661034178332626e-06	mole_per_s
1094	Vmax_b1	5.45836779963115378e-06	mole_per_s
1095	Vmax_b2	1.77489969731753487e-06	mole_per_s
1096	Vmax_b1	4.82290611269329579e-06	mole_per_s
1097	Vmax_b2	2.07516116012256459e-06	mole_per_s
1098	Vmax_b1	5.44734045764908985e-06	mole_per_s
1099	Vmax_b2	2.04190481860041189e-06	mole_per_s
1100	Vmax_b1	4.73324656207138368e-06	mole_per_s
1101	Vmax_b2	1.81846145671553996e-06	mole_per_s
1102	Vmax_b1	4.95202525618200653e-06	mole_per_s
1103	Vmax_b2	2.47676054712230042e-06	mole_per_s
1104	Vmax_b1	4.61999610053823148e-06	mole_per_s
1105	Vmax_b2	2.37137104914681218e-06	mole_per_s
1106	Vmax_b1	4.6158746935801978e-06	mole_per_s
1107	Vmax_b2	1.97426842657757558e-06	mole_per_s
1108	Vmax_b1	5.38886242088028643e-06	mole_per_s
1109	Vmax_b2	2.39998401514935227e-06	mole_per_s
1110	Vmax_b1	6.6856279703864389e-06	mole_per_s
1111	Vmax_b2	1.98319897858174924e-06	mole_per_s
1112	Vmax_b1	4.73630472280467521e-06	mole_per_s
1113	Vmax_b2	1.41244492586727284e-06	mole_per_s
1114	Vmax_b1	5.22078036274854819e-06	mole_per_s
1115	Vmax_b2	2.76361060288662858e-06	mole_per_s
1116	Vmax_b1	4.93237953905419993e-06	mole_per_s
1117	Vmax_b2	2.26415017289969547e-06	mole_per_s
1118	Vmax_b1	5.20612699005168413e-06	mole_per_s
1119	Vmax_b2	1.55419612335843777e-06	mole_per_s
1120	Vmax_b1	4.4675594240945115e-06	mole_per_s
1121	Vmax_b2	2.50792125577819529e-06	mole_per_s
1122	Vmax_b1	4.58954089496994014e-06	mole_per_s
1123	Vmax_b2	2.04074704976164832e-06	mole_per_s
1124	Vmax_b1	4.12238599665620673e-06	mole_per_s
1125	Vmax_b2	1.66909477140971494e-06	mole_per_s
1126	Vmax_b1	4.64200801630287786e-06	mole_per_s
1127	Vmax_b2	1.83564818863542627e-06	mole_per_s
1128	Vmax_b1	4.73995945936274095e-06	mole_per_s
1129	Vmax_b2	1.99398297118365458e-06	mole_per_s
1130	Vmax_b1	4.61696702798673572e-06	mole_per_s
1131	Vmax_b2	1.92461407133048311e-06	mole_per_s
1132	Vmax_b1	4.53661219774939545e-06	mole_per_s
1133	Vmax_b2	1.50425530908991035e-06	mole_per_s
1134	Vmax_b1	5.33683608169445203e-06	mole_per_s
1135	Vmax_b2	1.57390470875809132e-06	mole_per_s
1136	Vmax_b1	4.453676617321845e-06	mole_per_s
1137	Vmax_b2	1.58169242931004412e-06	mole_per_s
1138	Vmax_b1	5.4699907102052722e-06	mole_per_s
1139	Vmax_b2	1.5208170203224229e-06	mole_per_s
1140	Vmax_b1	4.89315715117801001e-06	mole_per_s
1141	Vmax_b2	2.65706661831112047e-06	mole_per_s
1142	Vmax_b1	4.7410922106306132e-06	mole_per_s
1143	Vmax_b2	2.1092323859352579e-06	mole_per_s
1144	Vmax_b1	5.37151351932949303e-06	mole_per_s
1145	Vmax_b2	1.67141954250445931e-06	mole_per_s
1146	Vmax_b1	4.93153267483346249e-06	mole_per_s
1147	Vmax_b2	1.42240550246356544e-06	mole_per_s
1148	Vmax_b1	4.92012379468051245e-06	mole_per_s
1149	Vmax_b2	1.32254497703863956e-06	mole_per_s
1150	Vmax_b1	4.86528891359178014e-06	mole_per_s
1151	Vmax_b2	2.49562473092434038e-06	mole_per_s
1152	Vmax_b1	5.62287334806152453e-06	mole_per_s
1153	Vmax_b2	1.68141616039950994e-06	mole_per_s
1154	Vmax_b1	5.40650987456322594e-06	mole_per_s
1155	Vmax_b2	1.44120266645702234e-06	mole_per_s
1156	Vmax_b1	4.8068529878560203e-06	mole_per_s
1157	Vmax_b2	2.95935497517060327e-06	mole_per_s
1158	Vmax_b1	5.77653375878272657e-06	mole_per_s
1159	Vmax_b2	1.63637708084764852e-06	mole_per_s
1160	Vmax_b1	4.97627886839102525e-06	mole_per_s
1161	Vmax_b2	2.5338890104555277e-06	mole_per_s
1162	Vmax_b1	4.32083756133361873e-06	mole_per_s
1163	Vmax_b2	2.23508655889165437e-06	mole_per_s
1164	Vmax_b1	5.02489345446233274e-06	mole_per_s
1165	Vmax_b2	1.91049785393784325e-06	mole_per_s
1166	Vmax_b1	4.06468855776130995e-06	mole_per_s
1167	Vmax_b2	2.60209254605408761e-06	mole_per_s
1168	Vmax_b1	5.43478646006668314e-06	mole_per_s
1169	Vmax_b2	1.66272545718921392e-06	mole_per_s
1170	Vmax_b1	4.95506001284319716e-06	mole_per_s
1171	Vmax_b2	1.6833096114478283e-06	mole_per_s
1172	Vmax_b1	4.58237207482542395e-06	mole_per_s
1173	Vmax_b2	1.86759837781395616e-06	mole_per_s
1174	Vmax_b1	5.0401280422011103e-06	mole_per_s
1175	Vmax_b2	1.93199241857513422e-06	mole_per_s
1176	Vmax_b1	4.8552972989472387e-06	mole_per_s
1177	Vmax_b2	1.88904232558203228e-06	mole_per_s
1178	Vmax_b1	4.83715831134019904e-06	mole_per_s
1179	Vmax_b2	1.39059209826109325e-06	mole_per_s
1180	Vmax_b1	5.75583167508503685e-06	mole_per_s
1181	Vmax_b2	1.76113475172870956e-06	mole_per_s
1182	Vmax_b1	4.89218499712836958e-06	mole_per_s
1183	Vmax_b2	2.0272490527943656e-06	mole_per_s
1184	Vmax_b1	5.26529824236592373e-06	mole_per_s
1185	Vmax_b2	1.57113758753992798e-06	mole_per_s
1186	Vmax_b1	4.29094716655744685e-06	mole_per_s
1187	Vmax_b2	1.46530173833932979e-06	mole_per_s
1188	Vmax_b1	4.6114681859010346e-06	mole_per_s
1189	Vmax_b2	1.79094100631198655e-06	mole_per_s
1190	Vmax_b1	5.0962242998163413e-06	mole_per_s
1191	Vmax_b2	1.90276479375986086e-06	mole_per_s
1192	Vmax_b1	4.81026366691019497e-06	mole_per_s
1193	Vmax_b2	2.06474811548636256e-06	mole_per_s
1194	Vmax_b1	5.11804639123143417e-06	mole_per_s
1195	Vmax_b2	1.97522583352670474e-06	mole_per_s
1196	Vmax_b1	5.66653448768620101e-06	mole_per_s
1197	Vmax_b2	2.25861003901671657e-06	mole_per_s
1198	Vmax_b1	4.77555414020333676e-06	mole_per_s
1199	Vmax_b2	1.5860240493464291e-06	mole_per_s
1200	Vmax_b1	5.63098172594739243e-06	mole_per_s
1201	Vmax_b2	2.80889869220653271e-06	mole_per_s
1202	Vmax_b1	5.76424089996692372e-06	mole_per_s
1203	Vmax_b2	2.34231765737714777e-06	mole_per_s
1204	Vmax_b1	5.51816955025391912e-06	mole_per_s
1205	Vmax_b2	2.56789301689953341e-06	mole_per_s
1206	Vmax_b1	6.17600845416643625e-06	mole_per_s
1207	Vmax_b2	1.80854329426135843e-06	mole_per_s
1208	Vmax_b1	4.67062388681684411e-06	mole_per_s
1209	Vmax_b2	1.50451671297550668e-06	mole_per_s
1210	Vmax_b1	4.959398957648988e-06	mole_per_s
1211	Vmax_b2	2.4727036864701398e-06	mole_per_s
1212	Vmax_b1	4.52699389653406858e-06	mole_per_s
1213	Vmax_b2	1.51563740819206399e-06	mole_per_s
1214	Vmax_b1	3.75665652405570154e-06	mole_per_s
1215	Vmax_b2	2.0426629212376711e-06	mole_per_s
1216	Vmax_b1	6.33148570821777524e-06	mole_per_s
1217	Vmax_b2	1.72637057609950423e-06	mole_per_s
1218	Vmax_b1	4.72691307702585855e-06	mole_per_s
1219	Vmax_b2	2.17954773293852604e-06	mole_per_s
1220	Vmax_b1	5.24089202819883799e-06	mole_per_s
1221	Vmax_b2	2.05455939839869045e-06	mole_per_s
1222	Vmax_b1	5.49939258392606547e-06	mole_per_s
1223	Vmax_b2	2.53093094642569124e-06	mole_per_s
1224	Vmax_b1	5.61723797005758264e-06	mole_per_s
1225	Vmax_b2	1.96262257058199844e-06	mole_per_s
1226	Vmax_b1	5.65734269053124941e-06	mole_per_s
1227	Vmax_b2	2.70146028603503458e-06	mole_per_s
1228	Vmax_b1	4.6759545195450967e-06	mole_per_s
1229	Vmax_b2	1.80070961135671416e-06	mole_per_s
1230	Vmax_b1	4.15291568427396033e-06	mole_per_s
1231	Vmax_b2	1.53313267864813579e-06	mole_per_s
1232	Vmax_b1	4.64523533928819744e-06	mole_per_s
1233	Vmax_b2	2.62057458201721199e-06	mole_per_s
1234	Vmax_b1	4.90713443167655662e-06	mole_per_s
1235	Vmax_b2	1.76560789904968764e-06	mole_per_s
1236	Vmax_b1	5.02958931622278055e-06	mole_per_s
1237	Vmax_b2	1.43678950080670674e-06	mole_per_s
1238	Vmax_b1	5.04613344312124444e-06	mole_per_s
1239	Vmax_b2	2.43928484536511023e-06	mole_per_s
1240	Vmax_b1	4.41337045400031651e-06	mole_per_s
1241	Vmax_b2	2.01238269656375115e-06	mole_per_s
1242	Vmax_b1	4.71321619978702493e-06	mole_per_s
1243	Vmax_b2	2.17502587604062135e-06	mole_per_s
1244	Vmax_b1	5.19810678256534587e-06	mole_per_s
1245	Vmax_b2	1.37639609614409734e-06	mole_per_s
1246	Vmax_b1	4.01912424560865495e-06	mole_per_s
1247	Vmax_b2	2.22271509202089463e-06	mole_per_s
1248	Vmax_b1	4.63143303882826103e-06	mole_per_s
1249	Vmax_b2	1.88988984914692805e-06	mole_per_s
1250	Vmax_b1	5.9288285746015666e-06	mole_per_s
1251	Vmax_b2	2.51900082985785282e-06	mole_per_s
1252	Vmax_b1	4.69508326058868451e-06	mole_per_s
1253	Vmax_b2	2.10674454830387255e-06	mole_per_s
1254	Vmax_b1	5.30258990349887548e-06	mole_per_s
1255	Vmax_b2	1.55730269772622915e-06	mole_per_s
1256	Vmax_b1	4.86998067651635611e-06	mole_per_s
1257	Vmax_b2	1.59758854966908067e-06	mole_per_s
1258	Vmax_b1	4.69331233517150891e-06	mole_per_s
1259	Vmax_b2	2.0811611051125401e-06	mole_per_s
1260	Vmax_b1	5.73528845804481759e-06	mole_per_s
1261	Vmax_b2	1.35131093132784117e-06	mole_per_s
1262	Vmax_b1	5.04860876802361176e-06	mole_per_s
1263	Vmax_b2	2.12576211137171695e-06	mole_per_s
1264	Vmax_b1	4.69576298915250945e-06	mole_per_s
1265	Vmax_b2	2.02579864967486907e-06	mole_per_s
1266	Vmax_b1	4.98482918429623886e-06	mole_per_s
1267	Vmax_b2	2.45543541476164542e-06	mole_per_s
1268	Vmax_b1	4.10325576807743386e-06	mole_per_s
1269	Vmax_b2	2.40298573174196118e-06	mole_per_s
1270	Vmax_b1	5.30441940982619846e-06	mole_per_s
1271	Vmax_b2	2.00027201463327408e-06	mole_per_s
1272	Vmax_b1	5.08234540320387414e-06	mole_per_s
1273	Vmax_b2	2.25193378084700004e-06	mole_per_s
1274	Vmax_b1	4.76350736219903202e-06	mole_per_s
1275	Vmax_b2	1.89189408272724276e-06	mole_per_s
1276	Vmax_b1	4.84144995230907456e-06	mole_per_s
1277	Vmax_b2	2.07967723727716875e-06	mole_per_s
1278	Vmax_b1	4.9476671390000343e-06	mole_per_s
1279	Vmax_b2	1.95625815369130969e-06	mole_per_s
1280	Vmax_b1	4.71400571919728688e-06	mole_per_s
1281	Vmax_b2	1.96224335531681898e-06	mole_per_s
1282	Vmax_b1	4.74272946464542944e-06	mole_per_s
1283	Vmax_b2	2.00099196715853467e-06	mole_per_s
1284	Vmax_b1	5.15395823020908882e-06	mole_per_s
1285	Vmax_b2	1.52487213111826933e-06	mole_per_s
1286	Vmax_b1	5.15350115642218688e-06	mole_per_s
1287	Vmax_b2	2.023641175269644e-06	mole_per_s
1288	Vmax_b1	5.80658928442573073e-06	mole_per_s
1289	Vmax_b2	1.94384390474803422e-06	mole_per_s
1290	Vmax_b1	4.7057915837451717e-06	mole_per_s
1291	Vmax_b2	1.79349179746740046e-06	mole_per_s
1292	Vmax_b1	4.88558393430107683e-06	mole_per_s
1293	Vmax_b2	2.11395701729857852e-06	mole_per_s
1294	Vmax_b1	5.33236657776855806e-06	mole_per_s
1295	Vmax_b2	2.05797758425575951e-06	mole_per_s
1296	Vmax_b1	5.24825703471926057e-06	mole_per_s
1297	Vmax_b2	1.78622145310519529e-06	mole_per_s
1298	Vmax_b1	5.45269641385315352e-06	mole_per_s
1299	Vmax_b2	2.05285429548704286e-06	mole_per_s
1300	Vmax_b1	4.78936734880584001e-06	mole_per_s
1301	Vmax_b2	1.81092701267082028e-06	mole_per_s
1302	Vmax_b1	5.18193094190241344e-06	mole_per_s
1303	Vmax_b2	2.91333801986969963e-06	mole_per_s
1304	Vmax_b1	4.87830772738264303e-06	mole_per_s
1305	Vmax_b2	2.75315557729779038e-06	mole_per_s
1306	Vmax_b1	5.01638384312925542e-06	mole_per_s
1307	Vmax_b2	1.32515526132714578e-06	mole_per_s
1308	Vmax_b1	5.12847307573517881e-06	mole_per_s
1309	Vmax_b2	2.05797251313228257e-06	mole_per_s
1310	Vmax_b1	5.75345464503595291e-06	mole_per_s
1311	Vmax_b2	1.69928061906076686e-06	mole_per_s
1312	Vmax_b1	6.31125272911588764e-06	mole_per_s
1313	Vmax_b2	2.3122094878859743e-06	mole_per_s
1314	Vmax_b1	4.8680808601570785e-06	mole_per_s
1315	Vmax_b2	1.81432245755154717e-06	mole_per_s
1316	Vmax_b1	4.42593224115399124e-06	mole_per_s
1317	Vmax_b2	1.8266470778034747e-06	mole_per_s
1318	Vmax_b1	4.81401378652113768e-06	mole_per_s
1319	Vmax_b2	1.50722965303944573e-06	mole_per_s
1320	Vmax_b1	5.1848560452403598e-06	mole_per_s
1321	Vmax_b2	2.58382029494150663e-06	mole_per_s
1322	Vmax_b1	4.32556600079764505e-06	mole_per_s
1323	Vmax_b2	2.17625655975144813e-06	mole_per_s
1324	Vmax_b1	4.13508347461340559e-06	mole_per_s
1325	Vmax_b2	1.3894714901079225e-06	mole_per_s
1326	Vmax_b1	5.23590027215088564e-06	mole_per_s
1327	Vmax_b2	2.15229008817244253e-06	mole_per_s
1328	Vmax_b1	5.55232214749658085e-06	mole_per_s
1329	Vmax_b2	2.57416982885893639e-06	mole_per_s
1330	Vmax_b1	5.16685822143795795e-06	mole_per_s
1331	Vmax_b2	2.58762837868079959e-06	mole_per_s
1332	Vmax_b1	5.04940395974003316e-06	mole_per_s
1333	Vmax_b2	1.89066674379080533e-06	mole_per_s
1334	Vmax_b1	4.51472832208473822e-06	mole_per_s
1335	Vmax_b2	2.60885913116906418e-06	mole_per_s
1336	Vmax_b1	4.93813813328745624e-06	mole_per_s
1337	Vmax_b2	2.16930069061690076e-06	mole_per_s
1338	Vmax_b1	4.47248873415714913e-06	mole_per_s
1339	Vmax_b2	2.14486463124590438e-06	mole_per_s
1340	Vmax_b1	5.31149022581332728e-06	mole_per_s
1341	Vmax_b2	2.15509776652572377e-06	mole_per_s
1342	Vmax_b1	4.60619833328050495e-06	mole_per_s
1343	Vmax_b2	2.55597767425168766e-06	mole_per_s
1344	Vmax_b1	4.76086049385062963e-06	mole_per_s
1345	Vmax_b2	1.29451098619391326e-06	mole_per_s
1346	Vmax_b1	5.07438843845888926e-06	mole_per_s
1347	Vmax_b2	1.97510150486188599e-06	mole_per_s
1348	Vmax_b1	4.34806342336238263e-06	mole_per_s
1349	Vmax_b2	1.75298533061713119e-06	mole_per_s
1350	Vmax_b1	4.78889736693780013e-06	mole_per_s
1351	Vmax_b2	1.78303265864658896e-06	mole_per_s
1352	Vmax_b1	4.82411424686985235e-06	mole_per_s
1353	Vmax_b2	2.21720191321916912e-06	mole_per_s
1354	Vmax_b1	5.08346138637102755e-06	mole_per_s
1355	Vmax_b2	1.72159581865360729e-06	mole_per_s
1356	Vmax_b1	5.36259520968567317e-06	mole_per_s
1357	Vmax_b2	1.7643648007807162e-06	mole_per_s
1358	Vmax_b1	5.42251271525838637e-06	mole_per_s
1359	Vmax_b2	1.84410524547768902e-06	mole_per_s
1360	Vmax_b1	4.72950294847786242e-06	mole_per_s
1361	Vmax_b2	1.74023479880836176e-06	mole_per_s
1362	Vmax_b1	4.704386224131713e-06	mole_per_s
1363	Vmax_b2	2.32568574583596761e-06	mole_per_s
1364	Vmax_b1	4.21428640124614835e-06	mole_per_s
1365	Vmax_b2	3.18505210703792952e-06	mole_per_s
1366	Vmax_b1	4.5987723855523485e-06	mole_per_s
1367	Vmax_b2	1.59846642069907427e-06	mole_per_s
1368	Vmax_b1	4.81084802552936658e-06	mole_per_s
1369	Vmax_b2	2.54477628363870796e-06	mole_per_s
1370	Vmax_b1	5.90082069566972747e-06	mole_per_s
1371	Vmax_b2	2.54244200764076732e-06	mole_per_s
1372	Vmax_b1	5.72726415764699224e-06	mole_per_s
1373	Vmax_b2	1.85404189810479587e-06	mole_per_s
1374	Vmax_b1	5.19220936676925617e-06	mole_per_s
1375	Vmax_b2	1.68481214818881949e-06	mole_per_s
1376	Vmax_b1	5.87506994563830498e-06	mole_per_s
1377	Vmax_b2	1.95585166017831501e-06	mole_per_s
1378	Vmax_b1	5.10988372352717162e-06	mole_per_s
1379	Vmax_b2	2.28294416962547985e-06	mole_per_s
1380	Vmax_b1	5.96314351013707978e-06	mole_per_s
1381	Vmax_b2	1.64813112017157877e-06	mole_per_s
1382	Vmax_b1	4.99094442334662011e-06	mole_per_s
1383	Vmax_b2	1.98008754945458812e-06	mole_per_s
1384	Vmax_b1	5.30144788457511444e-06	mole_per_s
1385	Vmax_b2	2.38371492334676064e-06	mole_per_s
1386	Vmax_b1	5.66264940515087199e-06	mole_per_s
1387	Vmax_b2	2.02636674381444796e-06	mole_per_s
1388	Vmax_b1	5.20995629570000206e-06	mole_per_s
1389	Vmax_b2	2.89187210788436882e-06	mole_per_s
1390	Vmax_b1	5.57428142789123685e-06	mole_per_s
1391	Vmax_b2	1.46788423186634682e-06	mole_per_s
1392	Vmax_b1	4.95431175887405735e-06	mole_per_s
1393	Vmax_b2	1.70638861296242749e-06	mole_per_s
1394	Vmax_b1	6.31664168949003878e-06	mole_per_s
1395	Vmax_b2	2.31669675448997475e-06	mole_per_s
1396	Vmax_b1	4.69566076945677531e-06	mole_per_s
1397	Vmax_b2	2.27227038423271126e-06	mole_per_s
1398	Vmax_b1	5.06630459210671072e-06	mole_per_s
1399	Vmax_b2	2.67079043792145226e-06	mole_per_s
1400	Vmax_b1	4.31204242481253935e-06	mole_per_s
1401	Vmax_b2	1.85127502900390515e-06	mole_per_s
1402	Vmax_b1	5.00227802180140429e-06	mole_per_s
1403	Vmax_b2	2.02606970382594126e-06	mole_per_s
1404	Vmax_b1	4.09594759576370354e-06	mole_per_s
1405	Vmax_b2	1.61884881535295504e-06	mole_per_s
1406	Vmax_b1	4.80728011932087736e-06	mole_per_s
1407	Vmax_b2	1.48265751233826795e-06	mole_per_s
1408	Vmax_b1	6.1026407687675028e-06	mole_per_s
1409	Vmax_b2	1.60580266140162783e-06	mole_per_s
1410	Vmax_b1	4.97396734018786666e-06	mole_per_s
1411	Vmax_b2	1.88133979339068646e-06	mole_per_s
1412	Vmax_b1	4.68007823315020564e-06	mole_per_s
1413	Vmax_b2	1.91194295853318018e-06	mole_per_s
1414	Vmax_b1	4.97621915066580613e-06	mole_per_s
1415	Vmax_b2	1.99637717507046632e-06	mole_per_s
1416	Vmax_b1	4.20407887026089877e-06	mole_per_s
1417	Vmax_b2	2.34870384746365031e-06	mole_per_s
1418	Vmax_b1	4.34565924766415667e-06	mole_per_s
1419	Vmax_b2	2.00473435125456626e-06	mole_per_s
1420	Vmax_b1	4.64845106196839824e-06	mole_per_s
1421	Vmax_b2	2.14823843605866882	mole_per_s
1422	Vmax_b1	5.30986688916890692	mole_per_s
1423	Vmax_b2	1.50138774707217459	mole_per_s
1424	Vmax_b1	5.77427512458246639	mole_per_s
1425	Vmax_b2	2.20617150363600167	mole_per_s
1426	Vmax_b1	5.19320888679622605	mole_per_s
1427	Vmax_b2	2.36989749366872582	mole_per_s
1428	Vmax_b1	5.01422196674994147	mole_per_s
1429	Vmax_b2	2.42857296135331602	mole_per_s
1430	Vmax_b1	4.62518789682646236	mole_per_s
1431	Vmax_b2	1.40620083922659389	mole_per_s
1432	Vmax_b1	4.85761478255221757	mole_per_s
1433	Vmax_b2	2.76020701992096029	mole_per_s
1434	Vmax_b1	4.7304371328520709	mole_per_s
1435	Vmax_b2	2.13268747940107817	mole_per_s
1436	Vmax_b1	4.6695083715295409	mole_per_s
1437	Vmax_b2	1.63644694918579359	mole_per_s
1438	Vmax_b1	5.40082545085615529	mole_per_s
1439	Vmax_b2	2.38939339983325461	mole_per_s
1440	Vmax_b1	4.50645117176040344	mole_per_s
1441	Vmax_b2	1.97887651718798363	mole_per_s
1442	Vmax_b1	5.73157415381490498	mole_per_s
1443	Vmax_b2	3.03521382207711321	mole_per_s
1444	Vmax_b1	4.29420076711927212	mole_per_s
1445	Vmax_b2	2.65586100817986548	mole_per_s
1446	Vmax_b1	4.15242326408093021	mole_per_s
1447	Vmax_b2	2.01831887657664533	mole_per_s
1448	Vmax_b1	4.62796924982002	mole_per_s
1449	Vmax_b2	2.52177561336179634	mole_per_s
1450	Vmax_b1	4.7093943450741147	mole_per_s
1451	Vmax_b2	2.18206924676266345	mole_per_s
1452	Vmax_b1	5.22927587613233502	mole_per_s
1453	Vmax_b2	1.75491027178468917	mole_per_s
1454	Vmax_b1	5.44085179473678782	mole_per_s
1455	Vmax_b2	1.49969737797810376	mole_per_s
1456	Vmax_b1	4.70101142759209534	mole_per_s
1457	Vmax_b2	1.68713517679831848	mole_per_s
1458	Vmax_b1	4.77672940563224557	mole_per_s
1459	Vmax_b2	1.77939478086412617	mole_per_s
1460	Vmax_b1	5.24261474675322781	mole_per_s
1461	Vmax_b2	2.25291762098108661	mole_per_s
1462	Vmax_b1	5.44121158716302933	mole_per_s
1463	Vmax_b2	1.86236603248400212	mole_per_s
1464	Vmax_b1	5.47464673804415547	mole_per_s
1465	Vmax_b2	2.30711457298246936	mole_per_s
1466	Vmax_b1	4.71275904615023489	mole_per_s
1467	Vmax_b2	1.54461568872928945	mole_per_s
1468	Vmax_b1	5.1017640762657539	mole_per_s
1469	Vmax_b2	2.10766233562585281	mole_per_s
1470	Vmax_b1	4.56927700208995446	mole_per_s
1471	Vmax_b2	1.6209406207451571	mole_per_s
1472	Vmax_b1	5.46404897351009033	mole_per_s
1473	Vmax_b2	2.38961924297670247	mole_per_s
1474	Vmax_b1	5.85134852131191252	mole_per_s
1475	Vmax_b2	1.84341964315368823	mole_per_s
1476	Vmax_b1	4.99409984647945748	mole_per_s
1477	Vmax_b2	2.09860242486204296	mole_per_s
1478	Vmax_b1	4.38780809701622765	mole_per_s
1479	Vmax_b2	1.74797225285559188	mole_per_s
1480	Vmax_b1	4.74443581766495548	mole_per_s
1481	Vmax_b2	1.80112829576140721	mole_per_s
1482	Vmax_b1	5.20072981866405204	mole_per_s
1483	Vmax_b2	1.67178772777293494	mole_per_s
1484	Vmax_b1	4.78213669384234841	mole_per_s
1485	Vmax_b2	1.4880141745567026	mole_per_s
1486	Vmax_b1	5.86293123775174241	mole_per_s
1487	Vmax_b2	1.76886415889705262	mole_per_s
1488	Vmax_b1	4.61345677779871455	mole_per_s
1489	Vmax_b2	2.2618580603346734	mole_per_s
1490	Vmax_b1	5.02353405903021422	mole_per_s
1491	Vmax_b2	1.29364763623997359	mole_per_s
1492	Vmax_b1	4.9951915773570148	mole_per_s
1493	Vmax_b2	2.72749498713911365	mole_per_s
1494	Vmax_b1	6.49888357144285411	mole_per_s
1495	Vmax_b2	1.7387634477399263	mole_per_s
1496	Vmax_b1	3.96647373388260238	mole_per_s
1497	Vmax_b2	1.83593316060355871	mole_per_s
1498	Vmax_b1	4.27042577596452322	mole_per_s
1499	Vmax_b2	1.95502639934522571	mole_per_s
1500	Vmax_b1	5.38328833938920592	mole_per_s
1501	Vmax_b2	2.12096836621058626	mole_per_s
1502	Vmax_b1	5.92113180966842911	mole_per_s
1503	Vmax_b2	2.13203690649064281	mole_per_s
1504	Vmax_b1	5.2043238838344319	mole_per_s
1505	Vmax_b2	1.64660695780947641	mole_per_s
1506	Vmax_b1	5.19762976156920242	mole_per_s
1507	Vmax_b2	1.90333420374122997	mole_per_s
1508	Vmax_b1	5.425855719726008	mole_per_s
1509	Vmax_b2	1.49739740740385252	mole_per_s
1510	Vmax_b1	5.39227601687657998	mole_per_s
1511	Vmax_b2	2.1746505034187007	mole_per_s
1512	Vmax_b1	4.62900537548701685	mole_per_s
1513	Vmax_b2	2.00924069502383018	mole_per_s
1514	Vmax_b1	4.97811030982466551	mole_per_s
1515	Vmax_b2	1.84415347261153761	mole_per_s
1516	Vmax_b1	5.124713287212046	mole_per_s
1517	Vmax_b2	1.66951713187466577	mole_per_s
1518	Vmax_b1	4.54711661340274187	mole_per_s
1519	Vmax_b2	1.98026700974415792	mole_per_s
1520	Vmax_b1	5.51841741716981193	mole_per_s
1521	Vmax_b2	1.66034665825656225	mole_per_s
1522	Vmax_b1	5.07641771002048081	mole_per_s
1523	Vmax_b2	1.39632528659345456	mole_per_s
1524	Vmax_b1	5.00805697375169423	mole_per_s
1525	Vmax_b2	2.64297548939435956	mole_per_s
1526	Vmax_b1	4.44213638276951173	mole_per_s
1527	Vmax_b2	1.4952811887859585	mole_per_s
1528	Vmax_b1	5.226604396416759	mole_per_s
1529	Vmax_b2	1.70042620651635756	mole_per_s
1530	Vmax_b1	5.21451513135819411	mole_per_s
1531	Vmax_b2	2.01314103992319327	mole_per_s
1532	Vmax_b1	4.96976425457895843	mole_per_s
1533	Vmax_b2	1.47770483323137136	mole_per_s
1534	Vmax_b1	4.78505264341923731	mole_per_s
1535	Vmax_b2	1.94883357154174996	mole_per_s
1536	Vmax_b1	4.09525433126015415	mole_per_s
1537	Vmax_b2	1.91516727023651301	mole_per_s
1538	Vmax_b1	4.68348774929115841	mole_per_s
1539	Vmax_b2	2.02826063694005088	mole_per_s
1540	Vmax_b1	4.50663614257524081	mole_per_s
1541	Vmax_b2	1.48949773200806601	mole_per_s
1542	Vmax_b1	4.5737561158749731	mole_per_s
1543	Vmax_b2	1.93540185630084483	mole_per_s
1544	Vmax_b1	5.19454215203420056	mole_per_s
1545	Vmax_b2	2.21121395027595335	mole_per_s
1546	Vmax_b1	6.36456577131571155	mole_per_s
1547	Vmax_b2	1.92652422918184985	mole_per_s
1548	Vmax_b1	5.34809311987191638	mole_per_s
1549	Vmax_b2	1.53950790146829442	mole_per_s
1550	Vmax_b1	5.32580265898350014	mole_per_s
1551	Vmax_b2	2.00597735604854277	mole_per_s
1552	Vmax_b1	5.08817134764838563	mole_per_s
1553	Vmax_b2	2.05554170919328794	mole_per_s
1554	Vmax_b1	5.62029793121125465	mole_per_s
1555	Vmax_b2	1.78341636482306076	mole_per_s
1556	Vmax_b1	5.58557838626333503	mole_per_s
1557	Vmax_b2	1.60299654958385829	mole_per_s
1558	Vmax_b1	4.88565388958746816	mole_per_s
1559	Vmax_b2	1.77714816006197895	mole_per_s
1560	Vmax_b1	4.70440260722875347	mole_per_s
1561	Vmax_b2	1.39304326792976485	mole_per_s
1562	Vmax_b1	4.68996651753655058	mole_per_s
1563	Vmax_b2	1.64212238769443331	mole_per_s
1564	Vmax_b1	5.30325827843001196	mole_per_s
1565	Vmax_b2	1.4681196652614521	mole_per_s
1566	Vmax_b1	4.25975726538711186	mole_per_s
1567	Vmax_b2	2.72551839486671454	mole_per_s
1568	Vmax_b1	4.49485385833966777	mole_per_s
1569	Vmax_b2	2.1861996588804522	mole_per_s
1570	Vmax_b1	4.94228963118660047	mole_per_s
1571	Vmax_b2	1.45723687249935829	mole_per_s
1572	Vmax_b1	4.75440633622250353	mole_per_s
1573	Vmax_b2	1.87014903266305876	mole_per_s
1574	Vmax_b1	4.70137022523862669	mole_per_s
1575	Vmax_b2	2.04888551170236255	mole_per_s
1576	Vmax_b1	4.49356433872581906	mole_per_s
1577	Vmax_b2	1.29794481537527462	mole_per_s
1578	Vmax_b1	5.3839076310393823	mole_per_s
1579	Vmax_b2	2.36669626059762184	mole_per_s
1580	Vmax_b1	4.71911375778709274	mole_per_s
1581	Vmax_b2	1.51754972468011728	mole_per_s
1582	Vmax_b1	4.97303013831999507	mole_per_s
1583	Vmax_b2	2.37035621587654832	mole_per_s
1584	Vmax_b1	5.20942733540805669	mole_per_s
1585	Vmax_b2	1.99484938686413771	mole_per_s
1586	Vmax_b1	4.78796328780294456	mole_per_s
1587	Vmax_b2	1.61863157660549528	mole_per_s
1588	Vmax_b1	5.07078735432857375	mole_per_s
1589	Vmax_b2	2.85694577088893364	mole_per_s
1590	Vmax_b1	4.52899972797327077	mole_per_s
1591	Vmax_b2	2.47612080498774079	mole_per_s
1592	Vmax_b1	4.98867986632748828	mole_per_s
1593	Vmax_b2	2.85458767464389362	mole_per_s
1594	Vmax_b1	4.66566012133180053	mole_per_s
1595	Vmax_b2	2.26703950267723942	mole_per_s
1596	Vmax_b1	4.51216806322736996	mole_per_s
1597	Vmax_b2	1.91812704452103389	mole_per_s
1598	Vmax_b1	4.4161330374304022	mole_per_s
1599	Vmax_b2	2.22889291716082649	mole_per_s
1600	Vmax_b1	6.16853475967682385	mole_per_s
1601	Vmax_b2	1.20147243826835615	mole_per_s
1602	Vmax_b1	5.05767782249220055	mole_per_s
1603	Vmax_b2	1.98782356310202513	mole_per_s
1604	Vmax_b1	4.69772462493088838	mole_per_s
1605	Vmax_b2	2.55083076954690435	mole_per_s
1606	Vmax_b1	5.19038327059234472	mole_per_s
1607	Vmax_b2	2.44392638871899015	mole_per_s
1608	Vmax_b1	4.86117781489173328	mole_per_s
1609	Vmax_b2	1.99855478877086501	mole_per_s
1610	Vmax_b1	4.64954453732912665	mole_per_s
1611	Vmax_b2	1.99328653046921467	mole_per_s
1612	Vmax_b1	5.324206874585375	mole_per_s
1613	Vmax_b2	1.6610521287697313	mole_per_s
1614	Vmax_b1	5.17087401111437206	mole_per_s
1615	Vmax_b2	2.15410299409375483	mole_per_s
1616	Vmax_b1	4.93362945895202554	mole_per_s
1617	Vmax_b2	2.92450091413822344	mole_per_s
1618	Vmax_b1	4.63655954189983355	mole_per_s
1619	Vmax_b2	3.54751640479333874	mole_per_s
1620	Vmax_b1	4.46805673949393789	mole_per_s
1621	Vmax_b2	2.23417643753231854	mole_per_s
1622	Vmax_b1	5.14156979744957709	mole_per_s
1623	Vmax_b2	2.0430461995473479	mole_per_s
1624	Vmax_b1	5.81723979842327399	mole_per_s
1625	Vmax_b2	2.01486169379864144	mole_per_s
1626	Vmax_b1	4.89743325893839643	mole_per_s
1627	Vmax_b2	1.63566978994607348	mole_per_s
1628	Vmax_b1	4.71541543744290248	mole_per_s
1629	Vmax_b2	2.39105475838117254	mole_per_s
1630	Vmax_b1	4.74253241565520867	mole_per_s
1631	Vmax_b2	2.52111745901073681	mole_per_s
1632	Vmax_b1	5.45891388051433069	mole_per_s
1633	Vmax_b2	1.89581413441239732	mole_per_s
1634	Vmax_b1	5.08519124014719903	mole_per_s
1635	Vmax_b2	2.26591172203900459	mole_per_s
1636	Vmax_b1	5.06615452006151834	mole_per_s
1637	Vmax_b2	2.32389648514696034	mole_per_s
1638	Vmax_b1	5.35146304275758222	mole_per_s
1639	Vmax_b2	1.85788882491179308	mole_per_s
1640	Vmax_b1	4.7953374923714831	mole_per_s
1641	Vmax_b2	2.40008304267782835	mole_per_s
1642	Vmax_b1	5.22604789017380522	mole_per_s
1643	Vmax_b2	2.80569240024625977	mole_per_s
1644	Vmax_b1	4.58232748223558239	mole_per_s
1645	Vmax_b2	1.7617965516747045	mole_per_s
1646	Vmax_b1	5.76585139925124501	mole_per_s
1647	Vmax_b2	1.52195741617756775	mole_per_s
1648	Vmax_b1	5.77753899857534403	mole_per_s
1649	Vmax_b2	2.12512064303824566	mole_per_s
1650	Vmax_b1	5.18692252418054789	mole_per_s
1651	Vmax_b2	1.63929308945860774	mole_per_s
1652	Vmax_b1	4.80423437626560723	mole_per_s
1653	Vmax_b2	2.14324538771062745	mole_per_s
1654	Vmax_b1	5.13452605341552015	mole_per_s
1655	Vmax_b2	2.79284697893325795	mole_per_s
1656	Vmax_b1	5.45859014425303091	mole_per_s
1657	Vmax_b2	1.68261085777166031	mole_per_s
1658	Vmax_b1	4.90112847316003553	mole_per_s
1659	Vmax_b2	1.87236698143447833	mole_per_s
1660	Vmax_b1	4.33526258748551463	mole_per_s
1661	Vmax_b2	2.09539065417966874	mole_per_s
1662	Vmax_b1	4.9048806644746854	mole_per_s
1663	Vmax_b2	2.48447454951693958	mole_per_s
1664	Vmax_b1	4.39012779710888879	mole_per_s
1665	Vmax_b2	1.68623712414939741	mole_per_s
1666	Vmax_b1	4.67720107632781446	mole_per_s
1667	Vmax_b2	1.40827746521711039	mole_per_s
1668	Vmax_b1	4.69186269511456633	mole_per_s
1669	Vmax_b2	2.67599309132252117	mole_per_s
1670	Vmax_b1	4.16345519377813034	mole_per_s
1671	Vmax_b2	1.58357643532314851	mole_per_s
1672	Vmax_b1	5.73404040090224054	mole_per_s
1673	Vmax_b2	2.46103899638974832	mole_per_s
1674	Vmax_b1	4.5070481818918271	mole_per_s
1675	Vmax_b2	1.7891583680342098	mole_per_s
1676	Vmax_b1	4.73903272325970626	mole_per_s
1677	Vmax_b2	2.36882282936672128	mole_per_s
1678	Vmax_b1	4.52789498112243827	mole_per_s
1679	Vmax_b2	1.94161767097499216	mole_per_s
1680	Vmax_b1	4.99291579355447013	mole_per_s
1681	Vmax_b2	2.03698747486523635	mole_per_s
1682	Vmax_b1	5.39473337882068193	mole_per_s
1683	Vmax_b2	1.60048375091946093	mole_per_s
1684	Vmax_b1	5.53745388389085758	mole_per_s
1685	Vmax_b2	1.56640983980042381	mole_per_s
1686	Vmax_b1	4.35637024878807466	mole_per_s
1687	Vmax_b2	2.49944251286912467	mole_per_s
1688	Vmax_b1	4.85205354235490116	mole_per_s
1689	Vmax_b2	2.37078509403512738	mole_per_s
1690	Vmax_b1	5.28675267608125576	mole_per_s
1691	Vmax_b2	1.30305572835353889	mole_per_s
1692	Vmax_b1	5.03045936084224632	mole_per_s
1693	Vmax_b2	2.12253101593004301	mole_per_s
1694	Vmax_b1	4.98048898427454123	mole_per_s
1695	Vmax_b2	1.85790400670159817	mole_per_s
1696	Vmax_b1	4.58990912980528254	mole_per_s
1697	Vmax_b2	1.65194457962707686	mole_per_s
1698	Vmax_b1	4.85537843661494328	mole_per_s
1699	Vmax_b2	2.26912820031438534	mole_per_s
1700	Vmax_b1	4.96986361356174289	mole_per_s
1701	Vmax_b2	1.85095337841800012	mole_per_s
1702	Vmax_b1	4.3281505002940861	mole_per_s
1703	Vmax_b2	1.67461486356866418	mole_per_s
1704	Vmax_b1	5.64447597296956083	mole_per_s
1705	Vmax_b2	2.34868669789544571	mole_per_s
1706	Vmax_b1	5.35950044831174388	mole_per_s
1707	Vmax_b2	2.00548233943042487	mole_per_s
1708	Vmax_b1	4.84575797836645705	mole_per_s
1709	Vmax_b2	1.45544225341070521	mole_per_s
1710	Vmax_b1	4.67844206952395414	mole_per_s
1711	Vmax_b2	2.17045590059792337	mole_per_s
1712	Vmax_b1	4.76568072833694067	mole_per_s
1713	Vmax_b2	1.73322391924112695	mole_per_s
1714	Vmax_b1	5.15161452275388054	mole_per_s
1715	Vmax_b2	2.24370930901313814	mole_per_s
1716	Vmax_b1	5.17655935954988689	mole_per_s
1717	Vmax_b2	1.47977681912655989	mole_per_s
1718	Vmax_b1	4.52154317282538987	mole_per_s
1719	Vmax_b2	3.57895004318026189	mole_per_s
1720	Vmax_b1	5.39323484260365849	mole_per_s
1721	Vmax_b2	1.71462665523037483	mole_per_s
1722	Vmax_b1	6.23983589650029735	mole_per_s
1723	Vmax_b2	2.30828715048580291	mole_per_s
1724	Vmax_b1	4.9727661866660462	mole_per_s
1725	Vmax_b2	2.22076970172763977	mole_per_s
1726	Vmax_b1	5.25832443919234827	mole_per_s
1727	Vmax_b2	1.58581424374317526	mole_per_s
1728	Vmax_b1	5.08046820508294061	mole_per_s
1729	Vmax_b2	1.72662304913489195	mole_per_s
1730	Vmax_b1	5.21441357233545055	mole_per_s
1731	Vmax_b2	2.20030377238783537	mole_per_s
1732	Vmax_b1	5.90283976680449296	mole_per_s
1733	Vmax_b2	2.60059424486765245	mole_per_s
1734	Vmax_b1	4.92494457333450786	mole_per_s
1735	Vmax_b2	1.35552169795389066	mole_per_s
1736	Vmax_b1	5.28388878974767096	mole_per_s
1737	Vmax_b2	1.42595097110480218	mole_per_s
1738	Vmax_b1	4.83838661718959884	mole_per_s
1739	Vmax_b2	1.74583550315145186	mole_per_s
1740	Vmax_b1	4.93872136571644482	mole_per_s
1741	Vmax_b2	2.65598679114167036	mole_per_s
1742	Vmax_b1	4.43265328096454958	mole_per_s
1743	Vmax_b2	1.89236014258628171	mole_per_s
1744	Vmax_b1	5.28596473647791321	mole_per_s
1745	Vmax_b2	2.34325708909653585	mole_per_s
1746	Vmax_b1	5.86155272779629311	mole_per_s
1747	Vmax_b2	2.18821460296749759	mole_per_s
1748	Vmax_b1	5.51300717148493113	mole_per_s
1749	Vmax_b2	1.34095205574351484	mole_per_s
1750	Vmax_b1	5.66407354249319983	mole_per_s
1751	Vmax_b2	1.21611560324366197	mole_per_s
1752	Vmax_b1	4.39684474924435076	mole_per_s
1753	Vmax_b2	1.43359399372670859	mole_per_s
1754	Vmax_b1	5.20298579134192263	mole_per_s
1755	Vmax_b2	2.27836822819844853	mole_per_s
1756	Vmax_b1	5.47872404419263681	mole_per_s
1757	Vmax_b2	1.71720979857670475	mole_per_s
1758	Vmax_b1	5.32861850186502739	mole_per_s
1759	Vmax_b2	2.57896726084441497	mole_per_s
1760	Vmax_b1	4.80254053188422247	mole_per_s
1761	Vmax_b2	2.07430849342054069	mole_per_s
1762	Vmax_b1	5.10757495442854115	mole_per_s
1763	Vmax_b2	2.10285322277241704	mole_per_s
1764	Vmax_b1	4.83914409799871503	mole_per_s
1765	Vmax_b2	1.40374051566894709	mole_per_s
1766	Vmax_b1	4.73357305259889927	mole_per_s
1767	Vmax_b2	1.76950786332775056	mole_per_s
1768	Vmax_b1	4.82431227388620965	mole_per_s
1769	Vmax_b2	1.97056153372451393	mole_per_s
1770	Vmax_b1	5.03467557618664152	mole_per_s
1771	Vmax_b2	1.9853284238650204	mole_per_s
1772	Vmax_b1	5.56926816255492696	mole_per_s
1773	Vmax_b2	1.61966243950649291	mole_per_s
1774	Vmax_b1	5.09015900857186132	mole_per_s
1775	Vmax_b2	1.57552582857984569	mole_per_s
1776	Vmax_b1	5.18476624441655698	mole_per_s
1777	Vmax_b2	2.03976374919346526	mole_per_s
1778	Vmax_b1	5.82704196846251588	mole_per_s
1779	Vmax_b2	2.66252734951369519	mole_per_s
1780	Vmax_b1	5.10682779257192632	mole_per_s
1781	Vmax_b2	3.22252592421329931	mole_per_s
1782	Vmax_b1	4.59053951665556692	mole_per_s
1783	Vmax_b2	1.42958305860141333	mole_per_s
1784	Vmax_b1	4.76322156219433968	mole_per_s
1785	Vmax_b2	1.83240266320400758	mole_per_s
1786	Vmax_b1	4.82640247644637022	mole_per_s
1787	Vmax_b2	1.71738923458327175	mole_per_s
1788	Vmax_b1	4.68352033568163595	mole_per_s
1789	Vmax_b2	1.80278817883782749	mole_per_s
1790	Vmax_b1	4.7825173949355646	mole_per_s
1791	Vmax_b2	1.39114026899491305	mole_per_s
1792	Vmax_b1	5.54296174020916066	mole_per_s
1793	Vmax_b2	1.80557127552143082	mole_per_s
1794	Vmax_b1	4.50927258113331586	mole_per_s
1795	Vmax_b2	1.90579374675297442	mole_per_s
1796	Vmax_b1	5.52069002069548098	mole_per_s
1797	Vmax_b2	2.40843420982056111	mole_per_s
1798	Vmax_b1	5.59220338018862417	mole_per_s
1799	Vmax_b2	1.93231312350985629	mole_per_s
1800	Vmax_b1	4.61567246487387361	mole_per_s
1801	Vmax_b2	3.02351113495214685	mole_per_s
1802	Vmax_b1	5.75845116235828947	mole_per_s
1803	Vmax_b2	1.50586757283931361	mole_per_s
1804	Vmax_b1	4.03259031638667675	mole_per_s
1805	Vmax_b2	1.614395438292485	mole_per_s
1806	Vmax_b1	5.47844363552761493	mole_per_s
1807	Vmax_b2	2.4218407880160604	mole_per_s
1808	Vmax_b1	4.601637853623882	mole_per_s
1809	Vmax_b2	1.706634974117615	mole_per_s
1810	Vmax_b1	4.78405052084121252	mole_per_s
1811	Vmax_b2	2.29637802130140667	mole_per_s
1812	Vmax_b1	4.89058589057486603	mole_per_s
1813	Vmax_b2	1.50205641628475917	mole_per_s
1814	Vmax_b1	5.02480642443500525	mole_per_s
1815	Vmax_b2	2.42361896144148981	mole_per_s
1816	Vmax_b1	4.55520990626944666	mole_per_s
1817	Vmax_b2	2.53166379207158343	mole_per_s
1818	Vmax_b1	5.54155394909282428	mole_per_s
1819	Vmax_b2	1.59153248875643127	mole_per_s
1820	Vmax_b1	5.08988106032587062	mole_per_s
1821	flow_sin	2.69999999999999998e-10	m/s
1822	y_dis	1.19999999999999994e-12	m
1823	L	5.00000000000000031e-10	m
1824	y_cell	7.57999999999999961e-12	m
1825	y_sin	4.39999999999999983e-12	m
1826	deficiency	0	-
1827	PP__gal	0	mM
1828	PP__gal	1	mM
1829	PP__gal	2	mM
1830	PP__gal	3	mM
1831	PP__gal	4	mM
1832	PP__gal	5	mM
1833	PP__gal	0.5	mM
1834	PP__gal	1.5	mM
1835	PP__gal	2.5	mM
1836	PP__gal	3.5	mM
1837	PP__gal	4.5	mM
1838	PP__gal	5.5	mM
1839	y_cell	7.58000000000000027e-06	m
1840	y_sin	4.40000000000000022e-06	m
1841	y_dis	1.19999999999999995e-06	m
1842	L	0.00050000000000000001	m
1843	flow_sin	0.000126899999999999995	m/s
\.


--
-- Name: sim_parameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_parameter_id_seq', 1843, true);


--
-- Data for Name: sim_parametercollection; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_parametercollection (id) FROM stdin;
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
375
376
377
378
379
380
381
382
383
384
385
386
387
388
389
390
391
392
393
394
395
396
397
398
399
400
401
402
403
404
405
406
407
408
409
410
411
412
413
414
415
416
417
418
419
420
421
422
423
424
425
426
427
428
429
430
431
432
433
434
435
436
437
438
439
440
441
442
443
444
445
446
447
448
449
450
451
452
453
454
455
456
457
458
459
460
461
462
463
464
465
466
467
468
469
470
471
472
473
474
475
476
477
478
479
480
481
482
483
484
485
486
487
488
489
490
491
492
493
494
495
496
497
498
499
500
501
502
503
504
505
506
507
508
509
510
511
512
513
514
515
516
517
518
519
520
521
522
523
524
525
526
527
528
529
530
531
532
533
534
535
536
537
538
539
540
541
542
543
544
545
546
547
548
549
550
551
552
553
554
555
556
557
558
559
560
561
562
563
564
565
566
567
568
569
570
571
572
573
574
575
576
577
578
579
580
581
582
583
584
585
586
587
588
589
590
591
592
593
594
595
596
597
598
599
600
601
602
603
604
605
606
607
608
609
610
611
612
613
614
615
616
617
618
619
620
621
622
623
624
625
626
627
628
629
630
631
632
633
634
635
636
637
638
639
640
641
642
643
644
645
646
647
648
649
650
651
652
653
654
655
656
657
658
659
660
661
662
663
664
665
666
667
668
669
670
671
672
673
674
675
676
677
678
679
680
681
682
683
684
685
686
687
688
689
690
691
692
693
694
695
696
697
698
699
700
701
702
703
704
705
706
707
708
709
710
711
712
713
714
715
716
717
718
719
720
721
722
723
724
725
726
727
728
729
730
731
732
733
734
735
736
737
738
739
740
741
742
743
744
745
746
747
748
749
750
751
752
753
754
755
756
757
758
759
760
761
762
763
764
765
766
767
768
769
770
771
772
773
774
\.


--
-- Name: sim_parametercollection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_parametercollection_id_seq', 774, true);


--
-- Data for Name: sim_parametercollection_parameters; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_parametercollection_parameters (id, parametercollection_id, parameter_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	2	6
7	2	7
8	2	8
9	2	9
10	2	10
11	3	11
12	3	12
13	3	13
14	3	14
15	3	15
16	4	16
17	4	17
18	4	18
19	4	19
20	4	20
21	5	21
22	5	22
23	5	23
24	5	24
25	5	25
26	6	26
27	6	27
28	6	28
29	6	29
30	6	30
31	7	31
32	7	32
33	7	33
34	7	34
35	7	35
36	8	36
37	8	37
38	8	38
39	8	39
40	8	40
41	9	41
42	9	42
43	9	43
44	9	44
45	9	45
46	10	46
47	10	47
48	10	48
49	10	49
50	10	50
51	11	51
52	11	52
53	11	53
54	11	54
55	11	55
56	12	56
57	12	57
58	12	58
59	12	59
60	12	60
61	13	61
62	13	62
63	13	63
64	13	64
65	13	65
66	14	66
67	14	67
68	14	68
69	14	69
70	14	70
71	15	71
72	15	72
73	15	73
74	15	74
75	15	75
76	16	76
77	16	77
78	16	78
79	16	79
80	16	80
81	17	81
82	17	82
83	17	83
84	17	84
85	17	85
86	18	86
87	18	87
88	18	88
89	18	89
90	18	90
91	19	91
92	19	92
93	19	93
94	19	94
95	19	95
96	20	96
97	20	97
98	20	98
99	20	99
100	20	100
101	21	101
102	21	102
103	21	103
104	21	104
105	21	105
106	22	106
107	22	107
108	22	108
109	22	109
110	22	110
111	23	111
112	23	112
113	23	113
114	23	114
115	23	115
116	24	116
117	24	117
118	24	118
119	24	119
120	24	120
121	25	121
122	25	122
123	25	123
124	25	124
125	25	125
126	26	126
127	26	127
128	26	128
129	26	129
130	26	130
131	27	131
132	27	132
133	27	133
134	27	134
135	27	135
136	28	136
137	28	137
138	28	138
139	28	139
140	28	140
141	29	141
142	29	142
143	29	143
144	29	144
145	29	145
146	30	146
147	30	147
148	30	148
149	30	149
150	30	150
151	31	151
152	31	152
153	31	153
154	31	154
155	31	155
156	32	156
157	32	157
158	32	158
159	32	159
160	32	160
161	33	161
162	33	162
163	33	163
164	33	164
165	33	165
166	34	166
167	34	167
168	34	168
169	34	169
170	34	170
171	35	171
172	35	172
173	35	173
174	35	174
175	35	175
176	36	176
177	36	177
178	36	178
179	36	179
180	36	180
181	37	181
182	37	182
183	37	183
184	37	184
185	37	185
186	38	186
187	38	187
188	38	188
189	38	189
190	38	190
191	39	191
192	39	192
193	39	193
194	39	194
195	39	195
196	40	196
197	40	197
198	40	198
199	40	199
200	40	200
201	41	201
202	41	202
203	41	203
204	41	204
205	41	205
206	42	206
207	42	207
208	42	208
209	42	209
210	42	210
211	43	211
212	43	212
213	43	213
214	43	214
215	43	215
216	44	216
217	44	217
218	44	218
219	44	219
220	44	220
221	45	221
222	45	222
223	45	223
224	45	224
225	45	225
226	46	226
227	46	227
228	46	228
229	46	229
230	46	230
231	47	231
232	47	232
233	47	233
234	47	234
235	47	235
236	48	236
237	48	237
238	48	238
239	48	239
240	48	240
241	49	241
242	49	242
243	49	243
244	49	244
245	49	245
246	50	246
247	50	247
248	50	248
249	50	249
250	50	250
251	51	251
252	51	252
253	51	253
254	51	254
255	51	255
256	52	256
257	52	257
258	52	258
259	52	259
260	52	260
261	53	261
262	53	262
263	53	263
264	53	264
265	53	265
266	54	266
267	54	267
268	54	268
269	54	269
270	54	270
271	55	271
272	55	272
273	55	273
274	55	274
275	55	275
276	56	276
277	56	277
278	56	278
279	56	279
280	56	280
281	57	281
282	57	282
283	57	283
284	57	284
285	57	285
286	58	286
287	58	287
288	58	288
289	58	289
290	58	290
291	59	291
292	59	292
293	59	293
294	59	294
295	59	295
296	60	296
297	60	297
298	60	298
299	60	299
300	60	300
301	61	301
302	61	302
303	61	303
304	61	304
305	61	305
306	62	306
307	62	307
308	62	308
309	62	309
310	62	310
311	63	311
312	63	312
313	63	313
314	63	314
315	63	315
316	64	316
317	64	317
318	64	318
319	64	319
320	64	320
321	65	321
322	65	322
323	65	323
324	65	324
325	65	325
326	66	326
327	66	327
328	66	328
329	66	329
330	66	330
331	67	331
332	67	332
333	67	333
334	67	334
335	67	335
336	68	336
337	68	337
338	68	338
339	68	339
340	68	340
341	69	341
342	69	342
343	69	343
344	69	344
345	69	345
346	70	346
347	70	347
348	70	348
349	70	349
350	70	350
351	71	351
352	71	352
353	71	353
354	71	354
355	71	355
356	72	356
357	72	357
358	72	358
359	72	359
360	72	360
361	73	361
362	73	362
363	73	363
364	73	364
365	73	365
366	74	366
367	74	367
368	74	368
369	74	369
370	74	370
371	75	371
372	75	372
373	75	373
374	75	374
375	75	375
376	76	376
377	76	377
378	76	378
379	76	379
380	76	380
381	77	381
382	77	382
383	77	383
384	77	384
385	77	385
386	78	386
387	78	387
388	78	388
389	78	389
390	78	390
391	79	391
392	79	392
393	79	393
394	79	394
395	79	395
396	80	396
397	80	397
398	80	398
399	80	399
400	80	400
401	81	401
402	81	402
403	81	403
404	81	404
405	81	405
406	82	406
407	82	407
408	82	408
409	82	409
410	82	410
411	83	411
412	83	412
413	83	413
414	83	414
415	83	415
416	84	416
417	84	417
418	84	418
419	84	419
420	84	420
421	85	421
422	85	422
423	85	423
424	85	424
425	85	425
426	86	426
427	86	427
428	86	428
429	86	429
430	86	430
431	87	431
432	87	432
433	87	433
434	87	434
435	87	435
436	88	436
437	88	437
438	88	438
439	88	439
440	88	440
441	89	441
442	89	442
443	89	443
444	89	444
445	89	445
446	90	446
447	90	447
448	90	448
449	90	449
450	90	450
451	91	451
452	91	452
453	91	453
454	91	454
455	91	455
456	92	456
457	92	457
458	92	458
459	92	459
460	92	460
461	93	461
462	93	462
463	93	463
464	93	464
465	93	465
466	94	466
467	94	467
468	94	468
469	94	469
470	94	470
471	95	471
472	95	472
473	95	473
474	95	474
475	95	475
476	96	476
477	96	477
478	96	478
479	96	479
480	96	480
481	97	481
482	97	482
483	97	483
484	97	484
485	97	485
486	98	486
487	98	487
488	98	488
489	98	489
490	98	490
491	99	491
492	99	492
493	99	493
494	99	494
495	99	495
496	100	496
497	100	497
498	100	498
499	100	499
500	100	500
501	101	501
502	101	502
503	102	503
504	102	504
505	103	505
506	103	506
507	104	507
508	104	508
509	105	509
510	105	510
511	106	511
512	106	512
513	107	513
514	107	514
515	108	515
516	108	516
517	109	517
518	109	518
519	110	519
520	110	520
521	111	521
522	111	522
523	112	523
524	112	524
525	113	525
526	113	526
527	114	527
528	114	528
529	115	529
530	115	530
531	116	531
532	116	532
533	117	533
534	117	534
535	118	535
536	118	536
537	119	537
538	119	538
539	120	539
540	120	540
541	121	541
542	121	542
543	122	543
544	122	544
545	123	545
546	123	546
547	124	547
548	124	548
549	125	549
550	125	550
551	126	551
552	126	552
553	127	553
554	127	554
555	128	555
556	128	556
557	129	557
558	129	558
559	130	559
560	130	560
561	131	561
562	131	562
563	132	563
564	132	564
565	133	565
566	133	566
567	134	567
568	134	568
569	135	569
570	135	570
571	136	571
572	136	572
573	137	573
574	137	574
575	138	575
576	138	576
577	139	577
578	139	578
579	140	579
580	140	580
581	141	581
582	141	582
583	142	583
584	142	584
585	143	585
586	143	586
587	144	587
588	144	588
589	145	589
590	145	590
591	146	591
592	146	592
593	147	593
594	147	594
595	148	595
596	148	596
597	149	597
598	149	598
599	150	599
600	150	600
601	151	601
602	151	602
603	152	603
604	152	604
605	153	605
606	153	606
607	154	607
608	154	608
609	155	609
610	155	610
611	156	611
612	156	612
613	157	613
614	157	614
615	158	615
616	158	616
617	159	617
618	159	618
619	160	619
620	160	620
621	161	621
622	161	622
623	162	623
624	162	624
625	163	625
626	163	626
627	164	627
628	164	628
629	165	629
630	165	630
631	166	631
632	166	632
633	167	633
634	167	634
635	168	635
636	168	636
637	169	637
638	169	638
639	170	639
640	170	640
641	171	641
642	171	642
643	172	643
644	172	644
645	173	645
646	173	646
647	174	647
648	174	648
649	175	649
650	175	650
651	176	651
652	176	652
653	177	653
654	177	654
655	178	655
656	178	656
657	179	657
658	179	658
659	180	659
660	180	660
661	181	661
662	181	662
663	182	663
664	182	664
665	183	665
666	183	666
667	184	667
668	184	668
669	185	669
670	185	670
671	186	671
672	186	672
673	187	673
674	187	674
675	188	675
676	188	676
677	189	677
678	189	678
679	190	679
680	190	680
681	191	681
682	191	682
683	192	683
684	192	684
685	193	685
686	193	686
687	194	687
688	194	688
689	195	689
690	195	690
691	196	691
692	196	692
693	197	693
694	197	694
695	198	695
696	198	696
697	199	697
698	199	698
699	200	699
700	200	700
701	201	701
702	201	702
703	202	703
704	202	704
705	203	705
706	203	706
707	204	707
708	204	708
709	205	709
710	205	710
711	206	711
712	206	712
713	207	713
714	207	714
715	208	715
716	208	716
717	209	717
718	209	718
719	210	719
720	210	720
721	211	721
722	211	722
723	212	723
724	212	724
725	213	725
726	213	726
727	214	727
728	214	728
729	215	729
730	215	730
731	216	731
732	216	732
733	217	733
734	217	734
735	218	735
736	218	736
737	219	737
738	219	738
739	220	739
740	220	740
741	221	741
742	221	742
743	222	743
744	222	744
745	223	745
746	223	746
747	224	747
748	224	748
749	225	749
750	225	750
751	226	751
752	226	752
753	227	753
754	227	754
755	228	755
756	228	756
757	229	757
758	229	758
759	230	759
760	230	760
761	231	761
762	231	762
763	232	763
764	232	764
765	233	765
766	233	766
767	234	767
768	234	768
769	235	769
770	235	770
771	236	771
772	236	772
773	237	773
774	237	774
775	238	775
776	238	776
777	239	777
778	239	778
779	240	779
780	240	780
781	241	781
782	241	782
783	242	783
784	242	784
785	243	785
786	243	786
787	244	787
788	244	788
789	245	789
790	245	790
791	246	791
792	246	792
793	247	793
794	247	794
795	248	795
796	248	796
797	249	797
798	249	798
799	250	799
800	250	800
801	251	801
802	251	802
803	252	803
804	252	804
805	253	805
806	253	806
807	254	807
808	254	808
809	255	809
810	255	810
811	256	811
812	256	812
813	257	813
814	257	814
815	258	815
816	258	816
817	259	817
818	259	818
819	260	819
820	260	820
821	261	821
822	261	822
823	262	823
824	262	824
825	263	825
826	263	826
827	264	827
828	264	828
829	265	829
830	265	830
831	266	831
832	266	832
833	267	833
834	267	834
835	268	835
836	268	836
837	269	837
838	269	838
839	270	839
840	270	840
841	271	841
842	271	842
843	272	843
844	272	844
845	273	845
846	273	846
847	274	847
848	274	848
849	275	849
850	275	850
851	276	851
852	276	852
853	277	853
854	277	854
855	278	855
856	278	856
857	279	857
858	279	858
859	280	859
860	280	860
861	281	861
862	281	862
863	282	863
864	282	864
865	283	865
866	283	866
867	284	867
868	284	868
869	285	869
870	285	870
871	286	871
872	286	872
873	287	873
874	287	874
875	288	875
876	288	876
877	289	877
878	289	878
879	290	879
880	290	880
881	291	881
882	291	882
883	292	883
884	292	884
885	293	885
886	293	886
887	294	887
888	294	888
889	295	889
890	295	890
891	296	891
892	296	892
893	297	893
894	297	894
895	298	895
896	298	896
897	299	897
898	299	898
899	300	899
900	300	900
901	301	901
902	301	902
903	302	903
904	302	904
905	303	905
906	303	906
907	304	907
908	304	908
909	305	909
910	305	910
911	306	911
912	306	912
913	307	913
914	307	914
915	308	915
916	308	916
917	309	917
918	309	918
919	310	919
920	310	920
921	311	921
922	311	922
923	312	923
924	312	924
925	313	925
926	313	926
927	314	927
928	314	928
929	315	929
930	315	930
931	316	931
932	316	932
933	317	933
934	317	934
935	318	935
936	318	936
937	319	937
938	319	938
939	320	939
940	320	940
941	321	941
942	321	942
943	322	943
944	322	944
945	323	945
946	323	946
947	324	947
948	324	948
949	325	949
950	325	950
951	326	951
952	326	952
953	327	953
954	327	954
955	328	955
956	328	956
957	329	957
958	329	958
959	330	959
960	330	960
961	331	961
962	331	962
963	332	963
964	332	964
965	333	965
966	333	966
967	334	967
968	334	968
969	335	969
970	335	970
971	336	971
972	336	972
973	337	973
974	337	974
975	338	975
976	338	976
977	339	977
978	339	978
979	340	979
980	340	980
981	341	981
982	341	982
983	342	983
984	342	984
985	343	985
986	343	986
987	344	987
988	344	988
989	345	989
990	345	990
991	346	991
992	346	992
993	347	993
994	347	994
995	348	995
996	348	996
997	349	997
998	349	998
999	350	999
1000	350	1000
1001	351	1001
1002	351	1002
1003	352	1003
1004	352	1004
1005	353	1005
1006	353	1006
1007	354	1007
1008	354	1008
1009	355	1009
1010	355	1010
1011	356	1011
1012	356	1012
1013	357	1013
1014	357	1014
1015	358	1015
1016	358	1016
1017	359	1017
1018	359	1018
1019	360	1019
1020	360	1020
1021	361	1021
1022	361	1022
1023	362	1023
1024	362	1024
1025	363	1025
1026	363	1026
1027	364	1027
1028	364	1028
1029	365	1029
1030	365	1030
1031	366	1031
1032	366	1032
1033	367	1033
1034	367	1034
1035	368	1035
1036	368	1036
1037	369	1037
1038	369	1038
1039	370	1039
1040	370	1040
1041	371	1041
1042	371	1042
1043	372	1043
1044	372	1044
1045	373	1045
1046	373	1046
1047	374	1047
1048	374	1048
1049	375	1049
1050	375	1050
1051	376	1051
1052	376	1052
1053	377	1053
1054	377	1054
1055	378	1055
1056	378	1056
1057	379	1057
1058	379	1058
1059	380	1059
1060	380	1060
1061	381	1061
1062	381	1062
1063	382	1063
1064	382	1064
1065	383	1065
1066	383	1066
1067	384	1067
1068	384	1068
1069	385	1069
1070	385	1070
1071	386	1071
1072	386	1072
1073	387	1073
1074	387	1074
1075	388	1075
1076	388	1076
1077	389	1077
1078	389	1078
1079	390	1079
1080	390	1080
1081	391	1081
1082	391	1082
1083	392	1083
1084	392	1084
1085	393	1085
1086	393	1086
1087	394	1087
1088	394	1088
1089	395	1089
1090	395	1090
1091	396	1091
1092	396	1092
1093	397	1093
1094	397	1094
1095	398	1095
1096	398	1096
1097	399	1097
1098	399	1098
1099	400	1099
1100	400	1100
1101	401	1101
1102	401	1102
1103	402	1103
1104	402	1104
1105	403	1105
1106	403	1106
1107	404	1107
1108	404	1108
1109	405	1109
1110	405	1110
1111	406	1111
1112	406	1112
1113	407	1113
1114	407	1114
1115	408	1115
1116	408	1116
1117	409	1117
1118	409	1118
1119	410	1119
1120	410	1120
1121	411	1121
1122	411	1122
1123	412	1123
1124	412	1124
1125	413	1125
1126	413	1126
1127	414	1127
1128	414	1128
1129	415	1129
1130	415	1130
1131	416	1131
1132	416	1132
1133	417	1133
1134	417	1134
1135	418	1135
1136	418	1136
1137	419	1137
1138	419	1138
1139	420	1139
1140	420	1140
1141	421	1141
1142	421	1142
1143	422	1143
1144	422	1144
1145	423	1145
1146	423	1146
1147	424	1147
1148	424	1148
1149	425	1149
1150	425	1150
1151	426	1151
1152	426	1152
1153	427	1153
1154	427	1154
1155	428	1155
1156	428	1156
1157	429	1157
1158	429	1158
1159	430	1159
1160	430	1160
1161	431	1161
1162	431	1162
1163	432	1163
1164	432	1164
1165	433	1165
1166	433	1166
1167	434	1167
1168	434	1168
1169	435	1169
1170	435	1170
1171	436	1171
1172	436	1172
1173	437	1173
1174	437	1174
1175	438	1175
1176	438	1176
1177	439	1177
1178	439	1178
1179	440	1179
1180	440	1180
1181	441	1181
1182	441	1182
1183	442	1183
1184	442	1184
1185	443	1185
1186	443	1186
1187	444	1187
1188	444	1188
1189	445	1189
1190	445	1190
1191	446	1191
1192	446	1192
1193	447	1193
1194	447	1194
1195	448	1195
1196	448	1196
1197	449	1197
1198	449	1198
1199	450	1199
1200	450	1200
1201	451	1201
1202	451	1202
1203	452	1203
1204	452	1204
1205	453	1205
1206	453	1206
1207	454	1207
1208	454	1208
1209	455	1209
1210	455	1210
1211	456	1211
1212	456	1212
1213	457	1213
1214	457	1214
1215	458	1215
1216	458	1216
1217	459	1217
1218	459	1218
1219	460	1219
1220	460	1220
1221	461	1221
1222	461	1222
1223	462	1223
1224	462	1224
1225	463	1225
1226	463	1226
1227	464	1227
1228	464	1228
1229	465	1229
1230	465	1230
1231	466	1231
1232	466	1232
1233	467	1233
1234	467	1234
1235	468	1235
1236	468	1236
1237	469	1237
1238	469	1238
1239	470	1239
1240	470	1240
1241	471	1241
1242	471	1242
1243	472	1243
1244	472	1244
1245	473	1245
1246	473	1246
1247	474	1247
1248	474	1248
1249	475	1249
1250	475	1250
1251	476	1251
1252	476	1252
1253	477	1253
1254	477	1254
1255	478	1255
1256	478	1256
1257	479	1257
1258	479	1258
1259	480	1259
1260	480	1260
1261	481	1261
1262	481	1262
1263	482	1263
1264	482	1264
1265	483	1265
1266	483	1266
1267	484	1267
1268	484	1268
1269	485	1269
1270	485	1270
1271	486	1271
1272	486	1272
1273	487	1273
1274	487	1274
1275	488	1275
1276	488	1276
1277	489	1277
1278	489	1278
1279	490	1279
1280	490	1280
1281	491	1281
1282	491	1282
1283	492	1283
1284	492	1284
1285	493	1285
1286	493	1286
1287	494	1287
1288	494	1288
1289	495	1289
1290	495	1290
1291	496	1291
1292	496	1292
1293	497	1293
1294	497	1294
1295	498	1295
1296	498	1296
1297	499	1297
1298	499	1298
1299	500	1299
1300	500	1300
1301	501	1301
1302	501	1302
1303	502	1303
1304	502	1304
1305	503	1305
1306	503	1306
1307	504	1307
1308	504	1308
1309	505	1309
1310	505	1310
1311	506	1311
1312	506	1312
1313	507	1313
1314	507	1314
1315	508	1315
1316	508	1316
1317	509	1317
1318	509	1318
1319	510	1319
1320	510	1320
1321	511	1321
1322	511	1322
1323	512	1323
1324	512	1324
1325	513	1325
1326	513	1326
1327	514	1327
1328	514	1328
1329	515	1329
1330	515	1330
1331	516	1331
1332	516	1332
1333	517	1333
1334	517	1334
1335	518	1335
1336	518	1336
1337	519	1337
1338	519	1338
1339	520	1339
1340	520	1340
1341	521	1341
1342	521	1342
1343	522	1343
1344	522	1344
1345	523	1345
1346	523	1346
1347	524	1347
1348	524	1348
1349	525	1349
1350	525	1350
1351	526	1351
1352	526	1352
1353	527	1353
1354	527	1354
1355	528	1355
1356	528	1356
1357	529	1357
1358	529	1358
1359	530	1359
1360	530	1360
1361	531	1361
1362	531	1362
1363	532	1363
1364	532	1364
1365	533	1365
1366	533	1366
1367	534	1367
1368	534	1368
1369	535	1369
1370	535	1370
1371	536	1371
1372	536	1372
1373	537	1373
1374	537	1374
1375	538	1375
1376	538	1376
1377	539	1377
1378	539	1378
1379	540	1379
1380	540	1380
1381	541	1381
1382	541	1382
1383	542	1383
1384	542	1384
1385	543	1385
1386	543	1386
1387	544	1387
1388	544	1388
1389	545	1389
1390	545	1390
1391	546	1391
1392	546	1392
1393	547	1393
1394	547	1394
1395	548	1395
1396	548	1396
1397	549	1397
1398	549	1398
1399	550	1399
1400	550	1400
1401	551	1401
1402	551	1402
1403	552	1403
1404	552	1404
1405	553	1405
1406	553	1406
1407	554	1407
1408	554	1408
1409	555	1409
1410	555	1410
1411	556	1411
1412	556	1412
1413	557	1413
1414	557	1414
1415	558	1415
1416	558	1416
1417	559	1417
1418	559	1418
1419	560	1419
1420	560	1420
1421	561	1421
1422	561	1422
1423	562	1423
1424	562	1424
1425	563	1425
1426	563	1426
1427	564	1427
1428	564	1428
1429	565	1429
1430	565	1430
1431	566	1431
1432	566	1432
1433	567	1433
1434	567	1434
1435	568	1435
1436	568	1436
1437	569	1437
1438	569	1438
1439	570	1439
1440	570	1440
1441	571	1441
1442	571	1442
1443	572	1443
1444	572	1444
1445	573	1445
1446	573	1446
1447	574	1447
1448	574	1448
1449	575	1449
1450	575	1450
1451	576	1451
1452	576	1452
1453	577	1453
1454	577	1454
1455	578	1455
1456	578	1456
1457	579	1457
1458	579	1458
1459	580	1459
1460	580	1460
1461	581	1461
1462	581	1462
1463	582	1463
1464	582	1464
1465	583	1465
1466	583	1466
1467	584	1467
1468	584	1468
1469	585	1469
1470	585	1470
1471	586	1471
1472	586	1472
1473	587	1473
1474	587	1474
1475	588	1475
1476	588	1476
1477	589	1477
1478	589	1478
1479	590	1479
1480	590	1480
1481	591	1481
1482	591	1482
1483	592	1483
1484	592	1484
1485	593	1485
1486	593	1486
1487	594	1487
1488	594	1488
1489	595	1489
1490	595	1490
1491	596	1491
1492	596	1492
1493	597	1493
1494	597	1494
1495	598	1495
1496	598	1496
1497	599	1497
1498	599	1498
1499	600	1499
1500	600	1500
1501	601	1501
1502	601	1502
1503	602	1503
1504	602	1504
1505	603	1505
1506	603	1506
1507	604	1507
1508	604	1508
1509	605	1509
1510	605	1510
1511	606	1511
1512	606	1512
1513	607	1513
1514	607	1514
1515	608	1515
1516	608	1516
1517	609	1517
1518	609	1518
1519	610	1519
1520	610	1520
1521	611	1521
1522	611	1522
1523	612	1523
1524	612	1524
1525	613	1525
1526	613	1526
1527	614	1527
1528	614	1528
1529	615	1529
1530	615	1530
1531	616	1531
1532	616	1532
1533	617	1533
1534	617	1534
1535	618	1535
1536	618	1536
1537	619	1537
1538	619	1538
1539	620	1539
1540	620	1540
1541	621	1541
1542	621	1542
1543	622	1543
1544	622	1544
1545	623	1545
1546	623	1546
1547	624	1547
1548	624	1548
1549	625	1549
1550	625	1550
1551	626	1551
1552	626	1552
1553	627	1553
1554	627	1554
1555	628	1555
1556	628	1556
1557	629	1557
1558	629	1558
1559	630	1559
1560	630	1560
1561	631	1561
1562	631	1562
1563	632	1563
1564	632	1564
1565	633	1565
1566	633	1566
1567	634	1567
1568	634	1568
1569	635	1569
1570	635	1570
1571	636	1571
1572	636	1572
1573	637	1573
1574	637	1574
1575	638	1575
1576	638	1576
1577	639	1577
1578	639	1578
1579	640	1579
1580	640	1580
1581	641	1581
1582	641	1582
1583	642	1583
1584	642	1584
1585	643	1585
1586	643	1586
1587	644	1587
1588	644	1588
1589	645	1589
1590	645	1590
1591	646	1591
1592	646	1592
1593	647	1593
1594	647	1594
1595	648	1595
1596	648	1596
1597	649	1597
1598	649	1598
1599	650	1599
1600	650	1600
1601	651	1601
1602	651	1602
1603	652	1603
1604	652	1604
1605	653	1605
1606	653	1606
1607	654	1607
1608	654	1608
1609	655	1609
1610	655	1610
1611	656	1611
1612	656	1612
1613	657	1613
1614	657	1614
1615	658	1615
1616	658	1616
1617	659	1617
1618	659	1618
1619	660	1619
1620	660	1620
1621	661	1621
1622	661	1622
1623	662	1623
1624	662	1624
1625	663	1625
1626	663	1626
1627	664	1627
1628	664	1628
1629	665	1629
1630	665	1630
1631	666	1631
1632	666	1632
1633	667	1633
1634	667	1634
1635	668	1635
1636	668	1636
1637	669	1637
1638	669	1638
1639	670	1639
1640	670	1640
1641	671	1641
1642	671	1642
1643	672	1643
1644	672	1644
1645	673	1645
1646	673	1646
1647	674	1647
1648	674	1648
1649	675	1649
1650	675	1650
1651	676	1651
1652	676	1652
1653	677	1653
1654	677	1654
1655	678	1655
1656	678	1656
1657	679	1657
1658	679	1658
1659	680	1659
1660	680	1660
1661	681	1661
1662	681	1662
1663	682	1663
1664	682	1664
1665	683	1665
1666	683	1666
1667	684	1667
1668	684	1668
1669	685	1669
1670	685	1670
1671	686	1671
1672	686	1672
1673	687	1673
1674	687	1674
1675	688	1675
1676	688	1676
1677	689	1677
1678	689	1678
1679	690	1679
1680	690	1680
1681	691	1681
1682	691	1682
1683	692	1683
1684	692	1684
1685	693	1685
1686	693	1686
1687	694	1687
1688	694	1688
1689	695	1689
1690	695	1690
1691	696	1691
1692	696	1692
1693	697	1693
1694	697	1694
1695	698	1695
1696	698	1696
1697	699	1697
1698	699	1698
1699	700	1699
1700	700	1700
1701	701	1701
1702	701	1702
1703	702	1703
1704	702	1704
1705	703	1705
1706	703	1706
1707	704	1707
1708	704	1708
1709	705	1709
1710	705	1710
1711	706	1711
1712	706	1712
1713	707	1713
1714	707	1714
1715	708	1715
1716	708	1716
1717	709	1717
1718	709	1718
1719	710	1719
1720	710	1720
1721	711	1721
1722	711	1722
1723	712	1723
1724	712	1724
1725	713	1725
1726	713	1726
1727	714	1727
1728	714	1728
1729	715	1729
1730	715	1730
1731	716	1731
1732	716	1732
1733	717	1733
1734	717	1734
1735	718	1735
1736	718	1736
1737	719	1737
1738	719	1738
1739	720	1739
1740	720	1740
1741	721	1741
1742	721	1742
1743	722	1743
1744	722	1744
1745	723	1745
1746	723	1746
1747	724	1747
1748	724	1748
1749	725	1749
1750	725	1750
1751	726	1751
1752	726	1752
1753	727	1753
1754	727	1754
1755	728	1755
1756	728	1756
1757	729	1757
1758	729	1758
1759	730	1759
1760	730	1760
1761	731	1761
1762	731	1762
1763	732	1763
1764	732	1764
1765	733	1765
1766	733	1766
1767	734	1767
1768	734	1768
1769	735	1769
1770	735	1770
1771	736	1771
1772	736	1772
1773	737	1773
1774	737	1774
1775	738	1775
1776	738	1776
1777	739	1777
1778	739	1778
1779	740	1779
1780	740	1780
1781	741	1781
1782	741	1782
1783	742	1783
1784	742	1784
1785	743	1785
1786	743	1786
1787	744	1787
1788	744	1788
1789	745	1789
1790	745	1790
1791	746	1791
1792	746	1792
1793	747	1793
1794	747	1794
1795	748	1795
1796	748	1796
1797	749	1797
1798	749	1798
1799	750	1799
1800	750	1800
1801	751	1801
1802	751	1802
1803	752	1803
1804	752	1804
1805	753	1805
1806	753	1806
1807	754	1807
1808	754	1808
1809	755	1809
1810	755	1810
1811	756	1811
1812	756	1812
1813	757	1813
1814	757	1814
1815	758	1815
1816	758	1816
1817	759	1817
1818	759	1818
1819	760	1819
1820	760	1820
1821	761	1821
1822	761	1822
1823	761	1823
1824	761	1824
1825	761	1825
1826	761	1826
1827	761	1827
1828	762	1821
1829	762	1822
1830	762	1823
1831	762	1824
1832	762	1825
1833	762	1826
1834	762	1828
1835	763	1821
1836	763	1822
1837	763	1823
1838	763	1824
1839	763	1825
1840	763	1826
1841	763	1829
1842	764	1821
1843	764	1822
1844	764	1823
1845	764	1824
1846	764	1825
1847	764	1826
1848	764	1830
1849	765	1821
1850	765	1822
1851	765	1823
1852	765	1824
1853	765	1825
1854	765	1826
1855	765	1831
1856	766	1821
1857	766	1822
1858	766	1823
1859	766	1824
1860	766	1825
1861	766	1826
1862	766	1832
1863	767	1821
1864	767	1822
1865	767	1823
1866	767	1824
1867	767	1825
1868	767	1826
1869	767	1833
1870	768	1821
1871	768	1822
1872	768	1823
1873	768	1824
1874	768	1825
1875	768	1826
1876	768	1834
1877	769	1821
1878	769	1822
1879	769	1823
1880	769	1824
1881	769	1825
1882	769	1826
1883	769	1835
1884	770	1821
1885	770	1822
1886	770	1823
1887	770	1824
1888	770	1825
1889	770	1826
1890	770	1836
1891	771	1821
1892	771	1822
1893	771	1823
1894	771	1824
1895	771	1825
1896	771	1826
1897	771	1837
1898	772	1821
1899	772	1822
1900	772	1823
1901	772	1824
1902	772	1825
1903	772	1826
1904	772	1838
1905	773	1839
1906	773	1840
1907	773	1841
1908	773	1842
1909	773	1843
1910	774	1839
1911	774	1840
1912	774	1841
1913	774	1842
1914	774	1843
\.


--
-- Name: sim_parametercollection_parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_parametercollection_parameters_id_seq', 1914, true);


--
-- Data for Name: sim_plot; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_plot (id, timecourse_id, plot_type, file) FROM stdin;
\.


--
-- Name: sim_plot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_plot_id_seq', 1, false);


--
-- Data for Name: sim_sbmlmodel; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_sbmlmodel (id, sbml_id, file) FROM stdin;
1	MultipleIndicator_P00_v14_Nc20_Nf1	sbml/MultipleIndicator_P00_v14_Nc20_Nf1.xml
2	MultipleIndicator_P01_v14_Nc20_Nf1	sbml/MultipleIndicator_P01_v14_Nc20_Nf1.xml
3	MultipleIndicator_P02_v14_Nc20_Nf1	sbml/MultipleIndicator_P02_v14_Nc20_Nf1.xml
4	MultipleIndicator_P03_v14_Nc20_Nf1	sbml/MultipleIndicator_P03_v14_Nc20_Nf1.xml
5	MultipleIndicator_P04_v14_Nc20_Nf1	sbml/MultipleIndicator_P04_v14_Nc20_Nf1.xml
6	Koenig2013_demo_kinetic	sbml/Koenig2013_demo_kinetic.xml
7	Koenig2013_demo_kinetic_v1	sbml/Koenig2013_demo_kinetic_v1.xml
8	Koenig2013_demo_kinetic_v2	sbml/Koenig2013_demo_kinetic_v2.xml
9	Koenig2013_demo_kinetic_v3	sbml/Koenig2013_demo_kinetic_v3.xml
10	Koenig2013_demo_kinetic_v4	sbml/Koenig2013_demo_kinetic_v4.xml
11	Koenig2013_demo_kinetic_v5	sbml/Koenig2013_demo_kinetic_v5.xml
12	Koenig2014_demo_kinetic_v7	sbml/Koenig2014_demo_kinetic_v7.xml
13	Galactose_v15_Nc20_Nf1	sbml/Galactose_v15_Nc20_Nf1.xml
14	Galactose_v16_Nc20_Nf1	sbml/Galactose_v16_Nc20_Nf1.xml
15	MultipleIndicator_P00_v18_Nc20_Nf1	sbml/MultipleIndicator_P00_v18_Nc20_Nf1_1.xml
\.


--
-- Name: sim_sbmlmodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_sbmlmodel_id_seq', 15, true);


--
-- Data for Name: sim_simulation; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_simulation (id, task_id, parameters_id, status, priority, time_create, time_assign, core_id, file, time_sim) FROM stdin;
93	5	93	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:58.784775+02	2	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim93_config.ini	2014-05-07 07:15:25.439887+02
45	3	45	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:06.590691+02	1	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim45_config.ini	2014-05-07 07:10:31.487804+02
47	3	47	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:11.519205+02	2	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim47_config.ini	2014-05-07 07:10:34.88011+02
48	3	48	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:13.789063+02	4	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim48_config.ini	2014-05-07 07:10:36.002807+02
49	3	49	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:31.505695+02	1	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim49_config.ini	2014-05-07 07:10:52.328971+02
94	5	94	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:02.406018+02	4	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim94_config.ini	2014-05-07 07:15:28.622113+02
95	5	95	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:05.578926+02	3	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim95_config.ini	2014-05-07 07:15:29.345087+02
96	5	96	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:06.684785+02	1	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim96_config.ini	2014-05-07 07:15:29.531488+02
51	3	51	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:34.888001+02	2	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim51_config.ini	2014-05-07 07:10:58.55858+02
56	3	56	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:58.5681+02	2	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim56_config.ini	2014-05-07 07:11:22.83182+02
58	3	58	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:20.975985+02	3	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim58_config.ini	2014-05-07 07:11:44.077086+02
60	3	60	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:22.842061+02	2	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim60_config.ini	2014-05-07 07:11:47.031387+02
63	4	63	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:45.712817+02	4	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim63_config.ini	2014-05-07 07:12:07.74127+02
64	4	64	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:47.038015+02	2	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim64_config.ini	2014-05-07 07:12:10.291184+02
66	4	66	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:07.748766+02	4	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim66_config.ini	2014-05-07 07:12:33.126972+02
65	4	65	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:07.203694+02	1	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim65_config.ini	2014-05-07 07:12:35.303251+02
71	4	71	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:33.498131+02	2	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim71_config.ini	2014-05-07 07:12:57.279005+02
70	4	70	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:33.13708+02	4	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim70_config.ini	2014-05-07 07:12:58.457152+02
69	4	69	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:32.455564+02	3	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim69_config.ini	2014-05-07 07:13:00.011926+02
74	4	74	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:58.465296+02	4	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim74_config.ini	2014-05-07 07:13:20.538638+02
75	4	75	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:00.021772+02	3	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim75_config.ini	2014-05-07 07:13:22.952298+02
3	1	3	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:05.976884+02	3	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim3_config.ini	2014-05-07 07:06:29.851498+02
77	4	77	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:20.556203+02	4	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim77_config.ini	2014-05-07 07:13:44.295214+02
8	1	8	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:29.858367+02	3	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim8_config.ini	2014-05-07 07:06:50.166599+02
80	4	80	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:24.674293+02	1	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim80_config.ini	2014-05-07 07:13:51.323882+02
10	1	10	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:47.023547+02	1	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim10_config.ini	2014-05-07 07:07:08.882912+02
15	1	15	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:11.828179+02	3	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim15_config.ini	2014-05-07 07:07:30.923466+02
16	1	16	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:12.287399+02	4	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim16_config.ini	2014-05-07 07:07:32.10878+02
20	1	20	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:32.11533+02	4	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim20_config.ini	2014-05-07 07:07:53.23772+02
18	1	18	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:30.930788+02	3	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim18_config.ini	2014-05-07 07:07:57.368446+02
83	5	83	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:51.339841+02	1	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim83_config.ini	2014-05-07 07:14:15.996569+02
23	2	23	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:53.506193+02	2	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim23_config.ini	2014-05-07 07:08:15.40583+02
22	2	22	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:53.249414+02	4	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim22_config.ini	2014-05-07 07:08:20.354192+02
26	2	26	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:15.551243+02	2	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim26_config.ini	2014-05-07 07:08:36.934349+02
27	2	27	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:19.270378+02	3	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim27_config.ini	2014-05-07 07:08:39.894094+02
30	2	30	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:36.941447+02	2	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim30_config.ini	2014-05-07 07:09:00.044933+02
32	2	32	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:39.901698+02	3	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim32_config.ini	2014-05-07 07:09:02.225134+02
85	5	85	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:11.458916+02	2	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim85_config.ini	2014-05-07 07:14:34.328049+02
31	2	31	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:39.819309+02	4	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim31_config.ini	2014-05-07 07:09:02.416562+02
35	2	35	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:02.233875+02	3	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim35_config.ini	2014-05-07 07:09:25.794575+02
36	2	36	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:02.423566+02	4	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim36_config.ini	2014-05-07 07:09:26.260537+02
37	2	37	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:21.63712+02	1	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim37_config.ini	2014-05-07 07:09:42.717975+02
39	2	39	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:26.270174+02	4	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim39_config.ini	2014-05-07 07:09:47.017109+02
88	5	88	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:17.327227+02	3	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim88_config.ini	2014-05-07 07:14:41.566312+02
41	3	41	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:42.725933+02	1	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim41_config.ini	2014-05-07 07:10:06.571942+02
87	5	87	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:16.004698+02	1	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim87_config.ini	2014-05-07 07:14:42.569459+02
89	5	89	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:34.351851+02	2	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim89_config.ini	2014-05-07 07:14:58.776612+02
90	5	90	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:37.558885+02	4	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim90_config.ini	2014-05-07 07:15:02.398552+02
43	3	43	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:47.024798+02	4	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim43_config.ini	2014-05-07 07:10:13.778729+02
46	3	46	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:09.603948+02	3	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim46_config.ini	2014-05-07 07:10:33.383539+02
1	1	1	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:05.789502+02	1	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim1_config.ini	2014-05-07 07:06:25.890094+02
2	1	2	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:05.879177+02	2	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim2_config.ini	2014-05-07 07:06:27.189178+02
4	1	4	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:06.076165+02	4	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim4_config.ini	2014-05-07 07:06:28.036923+02
6	1	6	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:27.251955+02	2	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim6_config.ini	2014-05-07 07:06:46.756642+02
5	1	5	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:25.900172+02	1	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim5_config.ini	2014-05-07 07:06:47.016066+02
7	1	7	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:28.044214+02	4	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim7_config.ini	2014-05-07 07:06:49.551801+02
9	1	9	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:46.985464+02	2	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim9_config.ini	2014-05-07 07:07:07.584733+02
12	1	12	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:50.172826+02	3	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim12_config.ini	2014-05-07 07:07:11.820812+02
11	1	11	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:06:49.558216+02	4	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim11_config.ini	2014-05-07 07:07:12.281414+02
14	1	14	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:08.890359+02	1	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim14_config.ini	2014-05-07 07:07:28.729158+02
13	1	13	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:07.59215+02	2	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim13_config.ini	2014-05-07 07:07:31.907519+02
17	1	17	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:28.742835+02	1	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim17_config.ini	2014-05-07 07:07:51.927843+02
19	1	19	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:31.91584+02	2	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim19_config.ini	2014-05-07 07:07:53.347686+02
21	2	21	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:51.937681+02	1	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim21_config.ini	2014-05-07 07:08:15.220583+02
24	2	24	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:07:57.376642+02	3	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim24_config.ini	2014-05-07 07:08:19.262928+02
25	2	25	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:15.228274+02	1	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim25_config.ini	2014-05-07 07:08:36.873863+02
28	2	28	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:20.361783+02	4	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim28_config.ini	2014-05-07 07:08:39.811611+02
29	2	29	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:36.900548+02	1	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim29_config.ini	2014-05-07 07:08:57.002921+02
33	2	33	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:08:57.011097+02	1	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim33_config.ini	2014-05-07 07:09:21.628076+02
34	2	34	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:00.05237+02	2	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim34_config.ini	2014-05-07 07:09:27.940199+02
38	2	38	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:25.801972+02	3	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim38_config.ini	2014-05-07 07:09:46.49356+02
40	2	40	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:27.947639+02	2	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim40_config.ini	2014-05-07 07:09:48.752554+02
42	3	42	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:46.500969+02	3	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim42_config.ini	2014-05-07 07:10:09.596486+02
44	3	44	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:09:48.759364+02	2	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim44_config.ini	2014-05-07 07:10:11.257807+02
52	3	52	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:36.01597+02	4	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim52_config.ini	2014-05-07 07:10:57.656303+02
50	3	50	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:33.391226+02	3	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim50_config.ini	2014-05-07 07:10:58.144261+02
53	3	53	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:52.336754+02	1	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim53_config.ini	2014-05-07 07:11:19.506211+02
55	3	55	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:58.162192+02	3	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim55_config.ini	2014-05-07 07:11:20.96753+02
54	3	54	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:10:57.663653+02	4	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim54_config.ini	2014-05-07 07:11:22.112594+02
57	3	57	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:19.51473+02	1	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim57_config.ini	2014-05-07 07:11:41.510832+02
59	3	59	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:22.123933+02	4	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim59_config.ini	2014-05-07 07:11:45.705126+02
61	4	61	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:41.518253+02	1	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim61_config.ini	2014-05-07 07:12:07.195693+02
62	4	62	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:11:44.084973+02	3	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim62_config.ini	2014-05-07 07:12:08.140354+02
67	4	67	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:08.154913+02	3	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim67_config.ini	2014-05-07 07:12:32.447575+02
68	4	68	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:10.298944+02	2	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim68_config.ini	2014-05-07 07:12:33.483824+02
72	4	72	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:35.313792+02	1	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim72_config.ini	2014-05-07 07:13:02.401763+02
73	4	73	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:12:57.286709+02	2	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim73_config.ini	2014-05-07 07:13:22.252248+02
76	4	76	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:02.409156+02	1	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim76_config.ini	2014-05-07 07:13:24.666851+02
78	4	78	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:22.259651+02	2	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim78_config.ini	2014-05-07 07:13:48.536148+02
79	4	79	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:22.960302+02	3	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim79_config.ini	2014-05-07 07:13:52.746537+02
82	5	82	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:48.555055+02	2	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim82_config.ini	2014-05-07 07:14:11.438322+02
81	5	81	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:44.30273+02	4	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim81_config.ini	2014-05-07 07:14:13.368997+02
84	5	84	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:13:52.756134+02	3	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim84_config.ini	2014-05-07 07:14:17.155686+02
86	5	86	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:13.376718+02	4	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim86_config.ini	2014-05-07 07:14:37.543884+02
91	5	91	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:41.575085+02	3	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim91_config.ini	2014-05-07 07:15:05.569614+02
92	5	92	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:14:42.576808+02	1	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim92_config.ini	2014-05-07 07:15:06.677094+02
99	5	99	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:29.538284+02	3	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim99_config.ini	2014-05-07 07:15:53.173573+02
97	5	97	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:25.448834+02	2	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim97_config.ini	2014-05-07 07:15:51.449915+02
100	5	100	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:29.546551+02	1	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim100_config.ini	2014-05-07 07:15:53.024384+02
568	12	568	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.314503+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim568_config.ini	2014-05-12 12:26:38.570072+02
570	12	570	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.338386+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim570_config.ini	2014-05-12 12:26:38.584095+02
575	12	575	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.711408+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim575_config.ini	2014-05-12 12:26:38.955661+02
578	12	578	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.875477+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim578_config.ini	2014-05-12 12:26:39.129898+02
579	12	579	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.962564+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim579_config.ini	2014-05-12 12:26:39.28542+02
580	12	580	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.105011+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim580_config.ini	2014-05-12 12:26:39.349286+02
581	12	581	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.138372+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim581_config.ini	2014-05-12 12:26:39.433408+02
584	12	584	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.355604+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim584_config.ini	2014-05-12 12:26:39.592906+02
585	12	585	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.417461+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim585_config.ini	2014-05-12 12:26:39.705587+02
588	12	588	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.599334+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim588_config.ini	2014-05-12 12:26:39.840608+02
589	12	589	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.689471+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim589_config.ini	2014-05-12 12:26:39.953262+02
591	12	591	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.821079+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim591_config.ini	2014-05-12 12:26:40.065338+02
593	12	593	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.959874+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim593_config.ini	2014-05-12 12:26:40.218136+02
595	12	595	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.080588+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim595_config.ini	2014-05-12 12:26:40.364344+02
597	12	597	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.225814+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim597_config.ini	2014-05-12 12:26:40.484435+02
598	12	598	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.290112+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim598_config.ini	2014-05-12 12:26:40.563568+02
600	12	600	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.449085+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim600_config.ini	2014-05-12 12:26:40.708123+02
602	12	602	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.571158+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim602_config.ini	2014-05-12 12:26:40.819926+02
608	12	608	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.974217+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim608_config.ini	2014-05-12 12:26:41.260326+02
604	12	604	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.715926+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim604_config.ini	2014-05-12 12:26:40.96686+02
606	12	606	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.826735+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim606_config.ini	2014-05-12 12:26:41.073625+02
607	12	607	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.903864+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim607_config.ini	2014-05-12 12:26:41.256658+02
609	12	609	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.058379+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim609_config.ini	2014-05-12 12:26:41.368946+02
611	12	611	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.26434+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim611_config.ini	2014-05-12 12:26:41.506724+02
613	12	613	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.382421+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim613_config.ini	2014-05-12 12:26:41.656269+02
614	12	614	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.390445+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim614_config.ini	2014-05-12 12:26:41.694166+02
615	12	615	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.514378+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim615_config.ini	2014-05-12 12:26:41.772354+02
619	12	619	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.7798+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim619_config.ini	2014-05-12 12:26:42.057482+02
623	12	623	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.051555+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim623_config.ini	2014-05-12 12:26:42.309738+02
625	12	625	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.306545+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim625_config.ini	2014-05-12 12:26:42.568064+02
624	12	624	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.072757+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim624_config.ini	2014-05-12 12:26:42.393219+02
626	12	626	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.317306+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim626_config.ini	2014-05-12 12:26:42.563488+02
627	12	627	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.344592+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim627_config.ini	2014-05-12 12:26:42.599018+02
629	12	629	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.570268+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim629_config.ini	2014-05-12 12:26:42.834069+02
631	12	631	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.605494+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim631_config.ini	2014-05-12 12:26:42.898593+02
632	12	632	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.704157+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim632_config.ini	2014-05-12 12:26:42.962206+02
633	12	633	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.827092+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim633_config.ini	2014-05-12 12:26:43.112258+02
637	12	637	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.094711+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim637_config.ini	2014-05-12 12:26:43.429288+02
643	12	643	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.464751+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim643_config.ini	2014-05-12 12:26:43.698632+02
640	12	640	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.249646+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim640_config.ini	2014-05-12 12:26:43.589171+02
641	12	641	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.425422+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim641_config.ini	2014-05-12 12:26:43.715325+02
644	12	644	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.596375+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim644_config.ini	2014-05-12 12:26:43.84311+02
647	12	647	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.722843+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim647_config.ini	2014-05-12 12:26:44.019124+02
652	12	652	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.121991+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim652_config.ini	2014-05-12 12:26:44.39073+02
653	12	653	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.247503+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim653_config.ini	2014-05-12 12:26:44.538929+02
650	12	650	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.986399+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim650_config.ini	2014-05-12 12:26:44.238283+02
651	12	651	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.027611+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim651_config.ini	2014-05-12 12:26:44.323898+02
98	5	98	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:28.638694+02	4	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim98_config.ini	2014-05-07 07:15:51.969611+02
656	12	656	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.397577+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim656_config.ini	2014-05-12 12:26:44.677222+02
658	12	658	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.557144+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim658_config.ini	2014-05-12 12:26:44.82382+02
662	12	662	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.832605+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim662_config.ini	2014-05-12 12:26:45.082639+02
663	12	663	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.895076+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim663_config.ini	2014-05-12 12:26:45.158975+02
667	12	667	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.16598+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim667_config.ini	2014-05-12 12:26:45.459209+02
668	12	668	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.258101+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim668_config.ini	2014-05-12 12:26:45.566204+02
669	12	669	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.36044+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim669_config.ini	2014-05-12 12:26:45.616434+02
674	12	674	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.663986+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim674_config.ini	2014-05-12 12:26:45.896938+02
670	12	670	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.411941+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim670_config.ini	2014-05-12 12:26:45.656986+02
678	12	678	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.906553+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim678_config.ini	2014-05-12 12:26:46.150996+02
676	12	676	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.826225+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim676_config.ini	2014-05-12 12:26:46.117391+02
677	12	677	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.900073+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim677_config.ini	2014-05-12 12:26:46.147044+02
679	12	679	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.034229+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim679_config.ini	2014-05-12 12:26:46.315324+02
683	12	683	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.324425+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim683_config.ini	2014-05-12 12:26:46.642814+02
684	12	684	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.382813+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim684_config.ini	2014-05-12 12:26:46.655994+02
685	12	685	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.425002+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim685_config.ini	2014-05-12 12:26:46.682492+02
686	12	686	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.460539+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim686_config.ini	2014-05-12 12:26:46.722507+02
689	12	689	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.691376+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim689_config.ini	2014-05-12 12:26:46.937504+02
690	12	690	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.729798+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim690_config.ini	2014-05-12 12:26:46.975223+02
692	12	692	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.932598+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim692_config.ini	2014-05-12 12:26:47.186758+02
695	12	695	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.171861+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim695_config.ini	2014-05-12 12:26:47.448641+02
696	12	696	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.194241+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim696_config.ini	2014-05-12 12:26:47.494277+02
698	12	698	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.244031+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim698_config.ini	2014-05-12 12:26:47.504977+02
702	12	702	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.534101+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim702_config.ini	2014-05-12 12:26:47.791783+02
703	12	703	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.733047+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim703_config.ini	2014-05-12 12:26:47.978326+02
704	12	704	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.752856+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim704_config.ini	2014-05-12 12:26:47.998117+02
705	12	705	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.79891+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim705_config.ini	2014-05-12 12:26:48.057304+02
706	12	706	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.820086+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim706_config.ini	2014-05-12 12:26:48.076439+02
712	12	712	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.278521+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim712_config.ini	2014-05-12 12:26:48.55188+02
709	12	709	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.064125+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim709_config.ini	2014-05-12 12:26:48.366348+02
716	12	716	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.565261+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim716_config.ini	2014-05-12 12:26:48.800476+02
713	12	713	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.338204+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim713_config.ini	2014-05-12 12:26:48.590178+02
714	12	714	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.379658+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim714_config.ini	2014-05-12 12:26:48.708765+02
715	12	715	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.556912+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim715_config.ini	2014-05-12 12:26:48.800061+02
719	12	719	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.806806+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim719_config.ini	2014-05-12 12:26:49.075807+02
721	12	721	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.895527+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim721_config.ini	2014-05-12 12:26:49.150638+02
722	12	722	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.966019+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim722_config.ini	2014-05-12 12:26:49.23703+02
728	12	728	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.375908+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim728_config.ini	2014-05-12 12:26:49.681973+02
726	12	726	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.24367+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim726_config.ini	2014-05-12 12:26:49.506956+02
729	12	729	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.413609+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim729_config.ini	2014-05-12 12:26:49.67678+02
730	12	730	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.522624+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim730_config.ini	2014-05-12 12:26:49.81277+02
731	12	731	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.661697+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim731_config.ini	2014-05-12 12:26:49.928902+02
741	12	741	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.238142+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim741_config.ini	2014-05-12 12:26:50.493036+02
732	12	732	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.68621+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim732_config.ini	2014-05-12 12:26:49.96699+02
739	12	739	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.183218+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim739_config.ini	2014-05-12 12:26:50.455703+02
736	12	736	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.942525+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim736_config.ini	2014-05-12 12:26:50.187288+02
737	12	737	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.974021+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim737_config.ini	2014-05-12 12:26:50.230093+02
612	12	612	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.271+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim612_config.ini	2014-05-12 12:26:41.518607+02
561	12	561	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:37.740363+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim561_config.ini	2014-05-12 12:26:38.026259+02
562	12	562	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:37.833381+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim562_config.ini	2014-05-12 12:26:38.081685+02
563	12	563	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:37.9353+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim563_config.ini	2014-05-12 12:26:38.187635+02
565	12	565	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.042147+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim565_config.ini	2014-05-12 12:26:38.301322+02
564	12	564	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.034701+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim564_config.ini	2014-05-12 12:26:38.316808+02
566	12	566	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.088403+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim566_config.ini	2014-05-12 12:26:38.331455+02
567	12	567	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.194014+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim567_config.ini	2014-05-12 12:26:38.45058+02
569	12	569	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.324304+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim569_config.ini	2014-05-12 12:26:38.579612+02
571	12	571	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.46163+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim571_config.ini	2014-05-12 12:26:38.705065+02
573	12	573	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.586287+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim573_config.ini	2014-05-12 12:26:38.834541+02
574	12	574	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.594904+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim574_config.ini	2014-05-12 12:26:38.842721+02
572	12	572	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.576726+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim572_config.ini	2014-05-12 12:26:38.868723+02
577	12	577	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.849606+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim577_config.ini	2014-05-12 12:26:39.09806+02
576	12	576	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:38.84116+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim576_config.ini	2014-05-12 12:26:39.148562+02
582	12	582	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.159974+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim582_config.ini	2014-05-12 12:26:39.410825+02
583	12	583	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.291908+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim583_config.ini	2014-05-12 12:26:39.550406+02
586	12	586	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.440296+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim586_config.ini	2014-05-12 12:26:39.682634+02
587	12	587	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.558551+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim587_config.ini	2014-05-12 12:26:39.813336+02
590	12	590	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.713197+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim590_config.ini	2014-05-12 12:26:39.983673+02
592	12	592	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.847547+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim592_config.ini	2014-05-12 12:26:40.179078+02
594	12	594	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:39.990577+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim594_config.ini	2014-05-12 12:26:40.281531+02
596	12	596	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.193239+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim596_config.ini	2014-05-12 12:26:40.442191+02
599	12	599	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.370887+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim599_config.ini	2014-05-12 12:26:40.629786+02
601	12	601	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.490871+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim601_config.ini	2014-05-12 12:26:40.738724+02
603	12	603	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.636424+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim603_config.ini	2014-05-12 12:26:40.893755+02
605	12	605	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:40.750664+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim605_config.ini	2014-05-12 12:26:41.050918+02
610	12	610	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.086932+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim610_config.ini	2014-05-12 12:26:41.363148+02
616	12	616	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.526622+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim616_config.ini	2014-05-12 12:26:41.790335+02
617	12	617	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.668355+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim617_config.ini	2014-05-12 12:26:41.951371+02
618	12	618	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.701078+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim618_config.ini	2014-05-12 12:26:42.002733+02
620	12	620	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.799292+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim620_config.ini	2014-05-12 12:26:42.042211+02
621	12	621	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:41.964083+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim621_config.ini	2014-05-12 12:26:42.295924+02
622	12	622	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.009166+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim622_config.ini	2014-05-12 12:26:42.336031+02
628	12	628	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.400697+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim628_config.ini	2014-05-12 12:26:42.697291+02
630	12	630	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.576464+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim630_config.ini	2014-05-12 12:26:42.820725+02
634	12	634	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.842527+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim634_config.ini	2014-05-12 12:26:43.088115+02
635	12	635	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.905537+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim635_config.ini	2014-05-12 12:26:43.179792+02
636	12	636	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:42.969894+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim636_config.ini	2014-05-12 12:26:43.23722+02
638	12	638	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.120406+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim638_config.ini	2014-05-12 12:26:43.418036+02
639	12	639	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.18955+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim639_config.ini	2014-05-12 12:26:43.4577+02
642	12	642	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.43644+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim642_config.ini	2014-05-12 12:26:43.692729+02
743	12	743	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.462338+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim743_config.ini	2014-05-12 12:26:50.802747+02
746	12	746	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.676616+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim746_config.ini	2014-05-12 12:26:50.985319+02
748	12	748	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.760997+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim748_config.ini	2014-05-12 12:26:50.993624+02
749	12	749	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.809801+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim749_config.ini	2014-05-12 12:26:51.089981+02
750	12	750	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.982195+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim750_config.ini	2014-05-12 12:26:51.22557+02
752	12	752	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.001694+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim752_config.ini	2014-05-12 12:26:51.257735+02
753	12	753	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.102221+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim753_config.ini	2014-05-12 12:26:51.366153+02
759	12	759	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.499994+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim759_config.ini	2014-05-12 12:26:51.7405+02
755	12	755	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.239581+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim755_config.ini	2014-05-12 12:26:51.483903+02
760	12	760	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.5802+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim760_config.ini	2014-05-12 12:26:51.80668+02
646	12	646	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.706838+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim646_config.ini	2014-05-12 12:26:43.955456+02
649	12	649	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.961842+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim649_config.ini	2014-05-12 12:26:44.240053+02
654	12	654	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.254558+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim654_config.ini	2014-05-12 12:26:44.542106+02
666	12	666	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.096005+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim666_config.ini	2014-05-12 12:26:45.35327+02
673	12	673	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.623111+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim673_config.ini	2014-05-12 12:26:45.8934+02
681	12	681	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.157849+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim681_config.ini	2014-05-12 12:26:46.417447+02
693	12	693	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.945306+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim693_config.ini	2014-05-12 12:26:47.225017+02
697	12	697	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.23695+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim697_config.ini	2014-05-12 12:26:47.527054+02
718	12	718	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.715482+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim718_config.ini	2014-05-12 12:26:48.95849+02
734	12	734	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.819565+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim734_config.ini	2014-05-12 12:26:50.094148+02
738	12	738	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.101334+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim738_config.ini	2014-05-12 12:26:50.356204+02
742	12	742	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.365581+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim742_config.ini	2014-05-12 12:26:50.669407+02
751	12	751	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.991996+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim751_config.ini	2014-05-12 12:26:51.225953+02
758	12	758	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.490999+02	8	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim758_config.ini	2014-05-12 12:26:51.76228+02
645	12	645	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.700634+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim645_config.ini	2014-05-12 12:26:43.978263+02
657	12	657	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.55019+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim657_config.ini	2014-05-12 12:26:44.820455+02
661	12	661	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.826466+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim661_config.ini	2014-05-12 12:26:45.082231+02
665	12	665	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.08932+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim665_config.ini	2014-05-12 12:26:45.403979+02
682	12	682	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.165975+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim682_config.ini	2014-05-12 12:26:46.453544+02
694	12	694	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.98214+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim694_config.ini	2014-05-12 12:26:47.235899+02
701	12	701	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.511589+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim701_config.ini	2014-05-12 12:26:47.806558+02
710	12	710	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.083444+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim710_config.ini	2014-05-12 12:26:48.329283+02
717	12	717	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.596967+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim717_config.ini	2014-05-12 12:26:48.888935+02
725	12	725	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.161748+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim725_config.ini	2014-05-12 12:26:49.406745+02
745	12	745	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.500704+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim745_config.ini	2014-05-12 12:26:50.753651+02
756	12	756	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.265328+02	5	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim756_config.ini	2014-05-12 12:26:51.57335+02
648	12	648	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:43.852091+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim648_config.ini	2014-05-12 12:26:44.114975+02
660	12	660	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.689712+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim660_config.ini	2014-05-12 12:26:44.968707+02
664	12	664	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.975245+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim664_config.ini	2014-05-12 12:26:45.251084+02
672	12	672	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.573285+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim672_config.ini	2014-05-12 12:26:45.81788+02
680	12	680	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.127951+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim680_config.ini	2014-05-12 12:26:46.369983+02
688	12	688	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.662534+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim688_config.ini	2014-05-12 12:26:46.90943+02
691	12	691	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.91591+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim691_config.ini	2014-05-12 12:26:47.160115+02
699	12	699	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.465099+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim699_config.ini	2014-05-12 12:26:47.726849+02
707	12	707	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.984937+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim707_config.ini	2014-05-12 12:26:48.26963+02
720	12	720	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.822342+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim720_config.ini	2014-05-12 12:26:49.076182+02
724	12	724	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.09002+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim724_config.ini	2014-05-12 12:26:49.35761+02
727	12	727	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.364401+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim727_config.ini	2014-05-12 12:26:49.651876+02
735	12	735	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.935807+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim735_config.ini	2014-05-12 12:26:50.17653+02
757	12	757	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.373123+02	7	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim757_config.ini	2014-05-12 12:26:51.617066+02
779	15	773	DONE	10	2014-05-14 12:55:45.822352+02	2014-05-14 12:58:12.192001+02	2	timecourse/2014-05-14/MultipleIndicator_P00_v18_Nc20_Nf1_Sim779_config.ini	2014-05-14 12:58:20.808714+02
655	12	655	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.331433+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim655_config.ini	2014-05-12 12:26:44.633993+02
659	12	659	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:44.640791+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim659_config.ini	2014-05-12 12:26:44.888856+02
671	12	671	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.466191+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim671_config.ini	2014-05-12 12:26:45.760632+02
675	12	675	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:45.768194+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim675_config.ini	2014-05-12 12:26:46.025874+02
687	12	687	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:46.649041+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim687_config.ini	2014-05-12 12:26:46.918767+02
700	12	700	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:47.504154+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim700_config.ini	2014-05-12 12:26:47.744495+02
708	12	708	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.006858+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim708_config.ini	2014-05-12 12:26:48.265103+02
711	12	711	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:48.271847+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim711_config.ini	2014-05-12 12:26:48.549748+02
723	12	723	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.082723+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim723_config.ini	2014-05-12 12:26:49.361144+02
733	12	733	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:49.696727+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim733_config.ini	2014-05-12 12:26:49.935409+02
740	12	740	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.194534+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim740_config.ini	2014-05-12 12:26:50.470283+02
744	12	744	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.478169+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim744_config.ini	2014-05-12 12:26:50.719062+02
747	12	747	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:50.729207+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim747_config.ini	2014-05-12 12:26:50.973755+02
754	12	754	DONE	10	2014-05-12 12:26:12.151979+02	2014-05-12 12:26:51.232691+02	6	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim754_config.ini	2014-05-12 12:26:51.493152+02
780	16	774	DONE	10	2014-05-14 13:12:07.952127+02	2014-05-14 13:12:22.026409+02	1	timecourse/2014-05-14/MultipleIndicator_P00_v18_Nc20_Nf1_Sim780_config.ini	2014-05-14 13:12:27.515377+02
\.


--
-- Name: sim_simulation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_simulation_id_seq', 780, true);


--
-- Data for Name: sim_task; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_task (id, sbml_model_id, integration_id, info) FROM stdin;
1	1	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
2	2	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
3	3	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
4	4	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
5	5	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
6	6	2	Simulation of the demo network for visualization.
7	7	2	Simulation of the demo network for visualization.
8	8	2	Simulation of the demo network for visualization.
9	9	2	Simulation of the demo network for visualization.
10	10	2	Simulation of the demo network for visualization.
11	11	2	Simulation of the demo network for visualization.
12	12	3	Simulation of the demo network for visualization.
13	13	4	Simulation of varying galactose concentrations periportal to steady state.
14	14	4	Simulation of varying galactose concentrations periportal to steady state.
15	15	1	Simulation of multiple-indicator dilution curves (tracer peak periportal).\n        Flow adapted via the liver scaling factor after sampling!
16	15	5	Simulation of multiple-indicator dilution curves (tracer peak periportal).\n        Flow adapted via the liver scaling factor after sampling!
\.


--
-- Name: sim_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_task_id_seq', 16, true);


--
-- Data for Name: sim_timecourse; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_timecourse (id, simulation_id, file) FROM stdin;
1	1	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim1_copasi.csv
2	2	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim2_copasi.csv
3	4	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim4_copasi.csv
4	3	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim3_copasi.csv
5	6	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim6_copasi.csv
6	5	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim5_copasi.csv
7	7	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim7_copasi.csv
8	8	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim8_copasi.csv
9	9	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim9_copasi.csv
10	10	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim10_copasi.csv
11	12	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim12_copasi.csv
12	11	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim11_copasi.csv
13	14	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim14_copasi.csv
14	15	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim15_copasi.csv
15	13	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim13_copasi.csv
16	16	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim16_copasi.csv
17	17	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim17_copasi.csv
18	20	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim20_copasi.csv
19	19	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim19_copasi.csv
20	18	timecourse/2014-05-07/MultipleIndicator_P00_v14_Nc20_Nf1_Sim18_copasi.csv
21	21	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim21_copasi.csv
22	23	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim23_copasi.csv
23	24	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim24_copasi.csv
24	22	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim22_copasi.csv
25	25	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim25_copasi.csv
26	26	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim26_copasi.csv
27	28	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim28_copasi.csv
28	27	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim27_copasi.csv
29	29	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim29_copasi.csv
30	30	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim30_copasi.csv
31	32	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim32_copasi.csv
32	31	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim31_copasi.csv
33	33	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim33_copasi.csv
34	35	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim35_copasi.csv
35	36	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim36_copasi.csv
36	34	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim34_copasi.csv
37	37	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim37_copasi.csv
38	38	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim38_copasi.csv
39	39	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim39_copasi.csv
40	40	timecourse/2014-05-07/MultipleIndicator_P01_v14_Nc20_Nf1_Sim40_copasi.csv
41	41	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim41_copasi.csv
42	42	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim42_copasi.csv
43	44	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim44_copasi.csv
44	43	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim43_copasi.csv
45	45	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim45_copasi.csv
46	46	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim46_copasi.csv
47	47	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim47_copasi.csv
48	48	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim48_copasi.csv
49	49	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim49_copasi.csv
50	52	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim52_copasi.csv
51	50	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim50_copasi.csv
52	51	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim51_copasi.csv
53	53	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim53_copasi.csv
54	55	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim55_copasi.csv
55	54	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim54_copasi.csv
56	56	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim56_copasi.csv
57	57	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim57_copasi.csv
58	58	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim58_copasi.csv
59	59	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim59_copasi.csv
60	60	timecourse/2014-05-07/MultipleIndicator_P02_v14_Nc20_Nf1_Sim60_copasi.csv
61	61	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim61_copasi.csv
62	63	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim63_copasi.csv
63	62	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim62_copasi.csv
64	64	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim64_copasi.csv
65	67	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim67_copasi.csv
66	66	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim66_copasi.csv
67	68	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim68_copasi.csv
68	65	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim65_copasi.csv
72	72	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim72_copasi.csv
76	76	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim76_copasi.csv
79	80	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim80_copasi.csv
83	83	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim83_copasi.csv
88	87	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim87_copasi.csv
92	92	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim92_copasi.csv
96	96	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim96_copasi.csv
99	100	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim100_copasi.csv
461	561	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim561_copasi.csv
464	565	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim565_copasi.csv
468	568	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim568_copasi.csv
474	572	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim572_copasi.csv
477	578	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim578_copasi.csv
482	581	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim581_copasi.csv
485	586	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim586_copasi.csv
489	589	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim589_copasi.csv
493	593	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim593_copasi.csv
497	597	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim597_copasi.csv
501	601	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim601_copasi.csv
505	605	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim605_copasi.csv
510	609	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim609_copasi.csv
513	613	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim613_copasi.csv
517	617	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim617_copasi.csv
521	621	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim621_copasi.csv
526	625	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim625_copasi.csv
529	630	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim630_copasi.csv
534	633	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim633_copasi.csv
537	638	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim638_copasi.csv
543	641	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim641_copasi.csv
547	647	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim647_copasi.csv
551	651	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim651_copasi.csv
555	655	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim655_copasi.csv
559	659	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim659_copasi.csv
563	663	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim663_copasi.csv
567	667	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim667_copasi.csv
571	671	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim671_copasi.csv
575	675	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim675_copasi.csv
579	679	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim679_copasi.csv
583	683	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim683_copasi.csv
588	687	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim687_copasi.csv
592	692	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim692_copasi.csv
596	696	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim696_copasi.csv
600	700	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim700_copasi.csv
604	704	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim704_copasi.csv
607	708	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim708_copasi.csv
611	711	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim711_copasi.csv
615	715	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim715_copasi.csv
619	719	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim719_copasi.csv
624	723	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim723_copasi.csv
629	728	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim728_copasi.csv
632	733	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim733_copasi.csv
636	736	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim736_copasi.csv
640	740	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim740_copasi.csv
643	744	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim744_copasi.csv
646	747	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim747_copasi.csv
650	750	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim750_copasi.csv
655	754	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim754_copasi.csv
658	759	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim759_copasi.csv
661	779	timecourse/2014-05-14/MultipleIndicator_P00_v18_Nc20_Nf1_Sim779_copasi.csv
69	71	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim71_copasi.csv
74	73	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim73_copasi.csv
78	78	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim78_copasi.csv
81	82	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim82_copasi.csv
85	85	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim85_copasi.csv
89	89	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim89_copasi.csv
93	93	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim93_copasi.csv
97	97	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim97_copasi.csv
462	562	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim562_copasi.csv
466	566	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim566_copasi.csv
470	570	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim570_copasi.csv
473	574	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim574_copasi.csv
476	577	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim577_copasi.csv
480	580	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim580_copasi.csv
484	584	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim584_copasi.csv
488	588	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim588_copasi.csv
492	592	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim592_copasi.csv
496	596	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim596_copasi.csv
500	600	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim600_copasi.csv
504	604	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim604_copasi.csv
508	608	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim608_copasi.csv
512	612	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim612_copasi.csv
516	616	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim616_copasi.csv
519	620	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim620_copasi.csv
522	623	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim623_copasi.csv
525	626	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim626_copasi.csv
530	629	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim629_copasi.csv
533	634	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim634_copasi.csv
538	637	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim637_copasi.csv
541	642	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim642_copasi.csv
546	645	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim645_copasi.csv
550	650	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim650_copasi.csv
553	653	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim653_copasi.csv
557	657	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim657_copasi.csv
561	661	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim661_copasi.csv
566	665	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim665_copasi.csv
570	670	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim670_copasi.csv
574	674	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim674_copasi.csv
578	678	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim678_copasi.csv
582	682	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim682_copasi.csv
586	686	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim686_copasi.csv
590	690	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim690_copasi.csv
594	694	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim694_copasi.csv
597	698	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim698_copasi.csv
602	701	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim701_copasi.csv
606	706	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim706_copasi.csv
609	710	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim710_copasi.csv
613	713	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim713_copasi.csv
617	717	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim717_copasi.csv
621	721	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim721_copasi.csv
625	725	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim725_copasi.csv
628	729	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim729_copasi.csv
633	732	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim732_copasi.csv
637	737	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim737_copasi.csv
641	741	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim741_copasi.csv
644	745	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim745_copasi.csv
648	748	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim748_copasi.csv
652	752	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim752_copasi.csv
656	756	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim756_copasi.csv
660	760	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim760_copasi.csv
662	780	timecourse/2014-05-14/MultipleIndicator_P00_v18_Nc20_Nf1_Sim780_copasi.csv
70	70	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim70_copasi.csv
73	74	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim74_copasi.csv
77	77	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim77_copasi.csv
82	81	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim81_copasi.csv
86	86	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim86_copasi.csv
90	90	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim90_copasi.csv
94	94	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim94_copasi.csv
98	98	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim98_copasi.csv
463	563	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim563_copasi.csv
467	567	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim567_copasi.csv
471	571	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim571_copasi.csv
475	575	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim575_copasi.csv
479	579	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim579_copasi.csv
483	583	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim583_copasi.csv
487	587	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim587_copasi.csv
491	591	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim591_copasi.csv
495	595	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim595_copasi.csv
499	599	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim599_copasi.csv
503	603	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim603_copasi.csv
507	607	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim607_copasi.csv
511	611	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim611_copasi.csv
515	615	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim615_copasi.csv
520	619	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim619_copasi.csv
524	624	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim624_copasi.csv
528	628	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim628_copasi.csv
532	632	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim632_copasi.csv
536	636	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim636_copasi.csv
540	640	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim640_copasi.csv
544	644	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim644_copasi.csv
548	648	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim648_copasi.csv
552	652	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim652_copasi.csv
556	656	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim656_copasi.csv
560	660	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim660_copasi.csv
564	664	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim664_copasi.csv
568	668	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim668_copasi.csv
572	672	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim672_copasi.csv
576	676	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim676_copasi.csv
580	680	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim680_copasi.csv
584	684	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim684_copasi.csv
587	688	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim688_copasi.csv
591	691	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim691_copasi.csv
595	695	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim695_copasi.csv
599	699	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim699_copasi.csv
603	703	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim703_copasi.csv
608	707	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim707_copasi.csv
612	712	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim712_copasi.csv
616	716	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim716_copasi.csv
620	720	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim720_copasi.csv
623	724	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim724_copasi.csv
627	727	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim727_copasi.csv
631	731	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim731_copasi.csv
635	735	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim735_copasi.csv
639	739	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim739_copasi.csv
645	743	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim743_copasi.csv
649	749	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim749_copasi.csv
653	753	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim753_copasi.csv
657	757	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim757_copasi.csv
71	69	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim69_copasi.csv
75	75	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim75_copasi.csv
80	79	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim79_copasi.csv
84	84	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim84_copasi.csv
87	88	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim88_copasi.csv
91	91	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim91_copasi.csv
95	95	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim95_copasi.csv
100	99	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim99_copasi.csv
465	564	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim564_copasi.csv
469	569	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim569_copasi.csv
472	573	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim573_copasi.csv
478	576	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim576_copasi.csv
481	582	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim582_copasi.csv
486	585	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim585_copasi.csv
490	590	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim590_copasi.csv
494	594	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim594_copasi.csv
498	598	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim598_copasi.csv
502	602	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim602_copasi.csv
506	606	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim606_copasi.csv
509	610	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim610_copasi.csv
514	614	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim614_copasi.csv
518	618	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim618_copasi.csv
523	622	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim622_copasi.csv
527	627	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim627_copasi.csv
531	631	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim631_copasi.csv
535	635	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim635_copasi.csv
539	639	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim639_copasi.csv
542	643	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim643_copasi.csv
545	646	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim646_copasi.csv
549	649	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim649_copasi.csv
554	654	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim654_copasi.csv
558	658	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim658_copasi.csv
562	662	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim662_copasi.csv
565	666	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim666_copasi.csv
569	669	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim669_copasi.csv
573	673	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim673_copasi.csv
577	677	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim677_copasi.csv
581	681	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim681_copasi.csv
585	685	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim685_copasi.csv
589	689	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim689_copasi.csv
593	693	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim693_copasi.csv
598	697	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim697_copasi.csv
601	702	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim702_copasi.csv
605	705	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim705_copasi.csv
610	709	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim709_copasi.csv
614	714	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim714_copasi.csv
618	718	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim718_copasi.csv
622	722	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim722_copasi.csv
626	726	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim726_copasi.csv
630	730	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim730_copasi.csv
634	734	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim734_copasi.csv
638	738	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim738_copasi.csv
642	742	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim742_copasi.csv
647	746	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim746_copasi.csv
651	751	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim751_copasi.csv
654	755	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim755_copasi.csv
659	758	timecourse/2014-05-12/Koenig2014_demo_kinetic_v7_Sim758_copasi.csv
\.


--
-- Name: sim_timecourse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_timecourse_id_seq', 662, true);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_group_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_codename_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_content_type_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_group_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_groups_user_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_user_permissions_user_id_permission_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_key UNIQUE (app_label, model);


--
-- Name: django_content_type_app_label_model_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: sim_core_ip_cpu_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_core
    ADD CONSTRAINT sim_core_ip_cpu_key UNIQUE (ip, cpu);


--
-- Name: sim_core_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_core
    ADD CONSTRAINT sim_core_pkey PRIMARY KEY (id);


--
-- Name: sim_integration_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_integration
    ADD CONSTRAINT sim_integration_pkey PRIMARY KEY (id);


--
-- Name: sim_parameter_name_value_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_parameter
    ADD CONSTRAINT sim_parameter_name_value_key UNIQUE (name, value);


--
-- Name: sim_parameter_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_parameter
    ADD CONSTRAINT sim_parameter_pkey PRIMARY KEY (id);


--
-- Name: sim_parametercollection_param_parametercollection_id_parame_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_parametercollection_parameters
    ADD CONSTRAINT sim_parametercollection_param_parametercollection_id_parame_key UNIQUE (parametercollection_id, parameter_id);


--
-- Name: sim_parametercollection_parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_parametercollection_parameters
    ADD CONSTRAINT sim_parametercollection_parameters_pkey PRIMARY KEY (id);


--
-- Name: sim_parametercollection_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_parametercollection
    ADD CONSTRAINT sim_parametercollection_pkey PRIMARY KEY (id);


--
-- Name: sim_plot_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_plot
    ADD CONSTRAINT sim_plot_pkey PRIMARY KEY (id);


--
-- Name: sim_sbmlmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_sbmlmodel
    ADD CONSTRAINT sim_sbmlmodel_pkey PRIMARY KEY (id);


--
-- Name: sim_sbmlmodel_sbml_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_sbmlmodel
    ADD CONSTRAINT sim_sbmlmodel_sbml_id_key UNIQUE (sbml_id);


--
-- Name: sim_simulation_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_simulation
    ADD CONSTRAINT sim_simulation_pkey PRIMARY KEY (id);


--
-- Name: sim_simulation_task_id_parameters_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_simulation
    ADD CONSTRAINT sim_simulation_task_id_parameters_id_key UNIQUE (task_id, parameters_id);


--
-- Name: sim_task_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_task
    ADD CONSTRAINT sim_task_pkey PRIMARY KEY (id);


--
-- Name: sim_task_sbml_model_id_integration_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_task
    ADD CONSTRAINT sim_task_sbml_model_id_integration_id_key UNIQUE (sbml_model_id, integration_id);


--
-- Name: sim_timecourse_pkey; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_timecourse
    ADD CONSTRAINT sim_timecourse_pkey PRIMARY KEY (id);


--
-- Name: sim_timecourse_simulation_id_key; Type: CONSTRAINT; Schema: public; Owner: mkoenig; Tablespace: 
--

ALTER TABLE ONLY sim_timecourse
    ADD CONSTRAINT sim_timecourse_simulation_id_key UNIQUE (simulation_id);


--
-- Name: auth_group_name_like; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_group_name_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_like; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX auth_user_username_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_like; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX django_session_session_key_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: sim_parametercollection_parameters_parameter_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_parametercollection_parameters_parameter_id ON sim_parametercollection_parameters USING btree (parameter_id);


--
-- Name: sim_parametercollection_parameters_parametercollection_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_parametercollection_parameters_parametercollection_id ON sim_parametercollection_parameters USING btree (parametercollection_id);


--
-- Name: sim_plot_timecourse_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_plot_timecourse_id ON sim_plot USING btree (timecourse_id);


--
-- Name: sim_sbmlmodel_sbml_id_like; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_sbmlmodel_sbml_id_like ON sim_sbmlmodel USING btree (sbml_id varchar_pattern_ops);


--
-- Name: sim_simulation_core_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_simulation_core_id ON sim_simulation USING btree (core_id);


--
-- Name: sim_simulation_parameters_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_simulation_parameters_id ON sim_simulation USING btree (parameters_id);


--
-- Name: sim_simulation_task_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_simulation_task_id ON sim_simulation USING btree (task_id);


--
-- Name: sim_task_integration_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_task_integration_id ON sim_task USING btree (integration_id);


--
-- Name: sim_task_sbml_model_id; Type: INDEX; Schema: public; Owner: mkoenig; Tablespace: 
--

CREATE INDEX sim_task_sbml_model_id ON sim_task USING btree (sbml_model_id);


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_93d2d1f8; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT content_type_id_refs_id_93d2d1f8 FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_d043b34a; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_d043b34a FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_f4b32aac; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_f4b32aac FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: parametercollection_id_refs_id_3e4129e9; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_parametercollection_parameters
    ADD CONSTRAINT parametercollection_id_refs_id_3e4129e9 FOREIGN KEY (parametercollection_id) REFERENCES sim_parametercollection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_parametercollection_parameters_parameter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_parametercollection_parameters
    ADD CONSTRAINT sim_parametercollection_parameters_parameter_id_fkey FOREIGN KEY (parameter_id) REFERENCES sim_parameter(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_plot_timecourse_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_plot
    ADD CONSTRAINT sim_plot_timecourse_id_fkey FOREIGN KEY (timecourse_id) REFERENCES sim_timecourse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_simulation_core_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_simulation
    ADD CONSTRAINT sim_simulation_core_id_fkey FOREIGN KEY (core_id) REFERENCES sim_core(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_simulation_parameters_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_simulation
    ADD CONSTRAINT sim_simulation_parameters_id_fkey FOREIGN KEY (parameters_id) REFERENCES sim_parametercollection(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_simulation_task_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_simulation
    ADD CONSTRAINT sim_simulation_task_id_fkey FOREIGN KEY (task_id) REFERENCES sim_task(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_task_integration_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_task
    ADD CONSTRAINT sim_task_integration_id_fkey FOREIGN KEY (integration_id) REFERENCES sim_integration(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_task_sbml_model_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_task
    ADD CONSTRAINT sim_task_sbml_model_id_fkey FOREIGN KEY (sbml_model_id) REFERENCES sim_sbmlmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sim_timecourse_simulation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY sim_timecourse
    ADD CONSTRAINT sim_timecourse_simulation_id_fkey FOREIGN KEY (simulation_id) REFERENCES sim_simulation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_40c41112; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_40c41112 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_4dc23c39; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_4dc23c39 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_c0d12874; Type: FK CONSTRAINT; Schema: public; Owner: mkoenig
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT user_id_refs_id_c0d12874 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

