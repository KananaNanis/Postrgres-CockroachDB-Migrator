CREATE TABLE public.killbill_account_subscriptions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    product_id uuid NOT NULL,
    account_id uuid NOT NULL,
    subscription_id uuid NOT NULL,
    tenant_id uuid,
    external_key character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    phone_number character varying(255) NOT NULL,
    state integer DEFAULT 0 NOT NULL
);
CREATE TABLE public.killbill_tenants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    status smallint NOT NULL,
    currency character varying NOT NULL,
    key character varying NOT NULL,
    secret character varying NOT NULL,
    product_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.products (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    status smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
CREATE TABLE public.schema_version (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);
COPY public.killbill_account_subscriptions (id, product_id, account_id, subscription_id, tenant_id, external_key, created_at, updated_at, phone_number, state) FROM stdin;
\.
COPY public.killbill_tenants (id, name, status, currency, key, secret, product_id, created_at, updated_at) FROM stdin;
\.
COPY public.products (id, name, status, created_at, updated_at) FROM stdin;
\.
COPY public.schema_version (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	0.1	AddOsspUuid	SQL	V0.1__AddOsspUuid.sql	138560310	songa_songa	2018-03-21 12:19:09.48468	753	t
2	0.2	CreateProductsTable	SQL	V0.2__CreateProductsTable.sql	-1001115090	songa_songa	2018-03-21 12:19:13.122256	816	t
3	0.3	AddProductsData	SQL	V0.3__AddProductsData.sql	771568044	songa_songa	2018-03-21 12:19:16.77894	1224	t
4	0.4	CreateKillbillTenantsTable	SQL	V0.4__CreateKillbillTenantsTable.sql	1152368854	songa_songa	2018-03-21 12:19:21.424505	1225	t
5	0.5	AddKillbillTenantsData	SQL	V0.5__AddKillbillTenantsData.sql	1330772458	songa_songa	2018-03-21 12:19:25.175685	748	t
6	0.6	CreateKillbillAccountSubscriptionsTable	SQL	V0.6__CreateKillbillAccountSubscriptionsTable.sql	-593137375	songa_songa	2018-03-21 12:19:28.879718	830	t
7	0.7	AddPhoneNUmberColumnToKBASubs	SQL	V0.7__AddPhoneNUmberColumnToKBASubs.sql	1872998784	songa_songa	2018-03-21 12:19:40.054191	1112	t
8	0.8	MakePhoneNumberUnique	SQL	V0.8__MakePhoneNumberUnique.sql	1379523471	songa_songa	2018-03-21 12:19:46.712414	2557	t
9	0.9	AddStateToKBAS	SQL	V0.9__AddStateToKBAS.sql	-221764380	songa_songa	2018-03-21 12:19:51.90322	1178	t
\.
