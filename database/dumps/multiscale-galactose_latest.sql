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
2	127.0.0.1	1	2014-05-07 07:15:25.447181+02
4	127.0.0.1	3	2014-05-07 07:15:28.637132+02
3	127.0.0.1	2	2014-05-07 07:15:29.53691+02
1	127.0.0.1	0	2014-05-07 07:15:29.545058+02
\.


--
-- Name: sim_core_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_core_id_seq', 4, true);


--
-- Data for Name: sim_integration; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_integration (id, tend, tsteps, tstart, abs_tol, rel_tol) FROM stdin;
1	100	4000	0	9.99999999999999955e-07	9.99999999999999955e-07
\.


--
-- Name: sim_integration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_integration_id_seq', 1, true);


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
\.


--
-- Name: sim_parameter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_parameter_id_seq', 500, true);


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
\.


--
-- Name: sim_parametercollection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_parametercollection_id_seq', 100, true);


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
\.


--
-- Name: sim_parametercollection_parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_parametercollection_parameters_id_seq', 500, true);


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
\.


--
-- Name: sim_sbmlmodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_sbmlmodel_id_seq', 5, true);


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
98	5	98	DONE	10	2014-05-07 07:04:27.438098+02	2014-05-07 07:15:28.638694+02	4	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim98_config.ini	2014-05-07 07:15:51.969611+02
\.


--
-- Name: sim_simulation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_simulation_id_seq', 100, true);


--
-- Data for Name: sim_task; Type: TABLE DATA; Schema: public; Owner: mkoenig
--

COPY sim_task (id, sbml_model_id, integration_id, info) FROM stdin;
1	1	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
2	2	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
3	3	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
4	4	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
5	5	1	Simulation of multiple-indicator dilution curves (tracer peak periportal)
\.


--
-- Name: sim_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_task_id_seq', 5, true);


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
69	71	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim71_copasi.csv
74	73	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim73_copasi.csv
78	78	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim78_copasi.csv
81	82	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim82_copasi.csv
85	85	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim85_copasi.csv
89	89	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim89_copasi.csv
93	93	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim93_copasi.csv
97	97	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim97_copasi.csv
70	70	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim70_copasi.csv
73	74	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim74_copasi.csv
77	77	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim77_copasi.csv
82	81	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim81_copasi.csv
86	86	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim86_copasi.csv
90	90	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim90_copasi.csv
94	94	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim94_copasi.csv
98	98	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim98_copasi.csv
71	69	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim69_copasi.csv
75	75	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim75_copasi.csv
80	79	timecourse/2014-05-07/MultipleIndicator_P03_v14_Nc20_Nf1_Sim79_copasi.csv
84	84	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim84_copasi.csv
87	88	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim88_copasi.csv
91	91	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim91_copasi.csv
95	95	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim95_copasi.csv
100	99	timecourse/2014-05-07/MultipleIndicator_P04_v14_Nc20_Nf1_Sim99_copasi.csv
\.


--
-- Name: sim_timecourse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mkoenig
--

SELECT pg_catalog.setval('sim_timecourse_id_seq', 100, true);


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

