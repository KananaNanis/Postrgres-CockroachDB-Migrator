--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.8

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET client_min_messages = warning;
-- SET row_security = off;

-- --
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

-- CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


-- --
-- -- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
-- --

-- COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


-- --
-- -- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
-- --

-- CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA ral_payments_dev;


-- --
-- -- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
-- --

-- COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


-- SET default_tablespace = '';

-- SET default_with_oids = false;

--
-- Name: lipa_na_mpesa_online_payment_requests; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.lipa_na_mpesa_online_payment_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    business_short_code character varying NOT NULL,
    password character varying,
    request_timestamp character varying,
    transaction_type character varying NOT NULL,
    amount numeric(15,9) NOT NULL,
    party_a character varying NOT NULL,
    party_b character varying NOT NULL,
    phone_number character varying NOT NULL,
    callback_url character varying NOT NULL,
    account_reference character varying NOT NULL,
    transaction_desc character varying NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    request_json jsonb,
    external_transaction_id character varying NOT NULL,
    mobile_payment_request_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.lipa_na_mpesa_online_payment_requests OWNER TO songa_songa;

--
-- Name: lipa_na_mpesa_online_payment_response_callbacks; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.lipa_na_mpesa_online_payment_response_callbacks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    phone_number character varying NOT NULL,
    amount numeric(15,9) NOT NULL,
    mobile_payment_request_id uuid NOT NULL,
    external_transaction_id character varying NOT NULL,
    status smallint NOT NULL,
    response_json jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.lipa_na_mpesa_online_payment_response_callbacks OWNER TO songa_songa;

--
-- Name: lipa_na_mpesa_online_payment_responses; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.lipa_na_mpesa_online_payment_responses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    merchant_request_id character varying NOT NULL,
    checkout_request_id character varying NOT NULL,
    response_description character varying NOT NULL,
    response_code smallint NOT NULL,
    customer_message character varying NOT NULL,
    response_json jsonb NOT NULL,
    mobile_payment_response_id uuid NOT NULL,
    mobile_payment_request_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.lipa_na_mpesa_online_payment_responses OWNER TO songa_songa;

--
-- Name: mobile_payment_requests; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.mobile_payment_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    phone_number character varying NOT NULL,
    amount numeric(15,9) NOT NULL,
    payment_method character varying NOT NULL,
    product_id character varying NOT NULL,
    external_transaction_id character varying NOT NULL,
    transaction_description character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.mobile_payment_requests OWNER TO songa_songa;

--
-- Name: mobile_payment_responses; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.mobile_payment_responses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    phone_number character varying NOT NULL,
    amount numeric(15,9) NOT NULL,
    payment_method character varying NOT NULL,
    mobile_payment_request_id uuid NOT NULL,
    external_transaction_id character varying NOT NULL,
    status smallint NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.mobile_payment_responses OWNER TO songa_songa;

--
-- Name: schema_version; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.schema_version (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL,
    PRIMARY KEY (installed_rank)
);


-- ALTER TABLE ral_payments_dev.schema_version OWNER TO songa_songa;

--
-- Name: sdp_authorization_receipt_callbacks; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.sdp_authorization_receipt_callbacks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    original_transaction_id character varying NOT NULL,
    capability_type character varying NOT NULL,
    end_user_identifier character varying NOT NULL,
    user_cnfm_result character varying NOT NULL,
    payment_result character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.sdp_authorization_receipt_callbacks OWNER TO songa_songa;

--
-- Name: sdp_datasync_service_callbacks; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.sdp_datasync_service_callbacks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    userid_id character varying NOT NULL,
    userid_type smallint NOT NULL,
    sp_id character varying NOT NULL,
    product_id character varying NOT NULL,
    product_name character varying NOT NULL,
    service_id character varying NOT NULL,
    service_list character varying NOT NULL,
    update_type smallint NOT NULL,
    update_time character varying NOT NULL,
    update_desc character varying NOT NULL,
    effective_time character varying NOT NULL,
    expiry_time character varying NOT NULL,
    transaction_id character varying NOT NULL,
    order_key character varying NOT NULL,
    mdspsubexpmode character varying NOT NULL,
    object_type character varying NOT NULL,
    trace_unique_id character varying NOT NULL,
    rent_success character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.sdp_datasync_service_callbacks OWNER TO songa_songa;

--
-- Name: sdp_sms_delivery_receipt_callbacks; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.sdp_sms_delivery_receipt_callbacks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    correlator character varying NOT NULL,
    delivery_status character varying NOT NULL,
    address character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.sdp_sms_delivery_receipt_callbacks OWNER TO songa_songa;

--
-- Name: sdp_sms_notification_callbacks; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.sdp_sms_notification_callbacks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    correlator character varying NOT NULL,
    sms_message character varying NOT NULL,
    sender_address character varying NOT NULL,
    sms_service_activation_number character varying NOT NULL,
    date_time character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.sdp_sms_notification_callbacks OWNER TO songa_songa;

--
-- Name: sdp_subscribe_manage_requests; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.sdp_subscribe_manage_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    phone_number character varying NOT NULL,
    request_json jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    product_id character varying,
    status integer NOT NULL,
    amount character varying,
    payment_method character varying,
    account_id character varying,
    payment_id character varying,
    payment_transaction_id character varying,
    payment_external_key character varying,
    transaction_description character varying,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.sdp_subscribe_manage_requests OWNER TO songa_songa;

--
-- Name: sdp_subscriptions; Type: TABLE; Schema: ral_payments_dev; Owner: songa_songa
--

CREATE TABLE ral_payments_dev.sdp_subscriptions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    userid_id character varying NOT NULL,
    userid_type smallint NOT NULL,
    sp_id character varying NOT NULL,
    product_id character varying NOT NULL,
    product_name character varying NOT NULL,
    service_id character varying NOT NULL,
    service_list character varying NOT NULL,
    update_type smallint NOT NULL,
    update_time character varying NOT NULL,
    update_desc character varying NOT NULL,
    effective_time character varying NOT NULL,
    expiry_time character varying NOT NULL,
    transaction_id character varying NOT NULL,
    order_key character varying NOT NULL,
    mdspsubexpmode character varying NOT NULL,
    object_type character varying NOT NULL,
    trace_unique_id character varying NOT NULL,
    rent_success character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    PRIMARY KEY (id)
);


-- ALTER TABLE ral_payments_dev.sdp_subscriptions OWNER TO songa_songa;

--
-- Data for Name: lipa_na_mpesa_online_payment_requests; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.lipa_na_mpesa_online_payment_requests (id, business_short_code, password, request_timestamp, transaction_type, amount, party_a, party_b, phone_number, callback_url, account_reference, transaction_desc, status, request_json, external_transaction_id, mobile_payment_request_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: lipa_na_mpesa_online_payment_response_callbacks; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.lipa_na_mpesa_online_payment_response_callbacks (id, phone_number, amount, mobile_payment_request_id, external_transaction_id, status, response_json, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: lipa_na_mpesa_online_payment_responses; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.lipa_na_mpesa_online_payment_responses (id, merchant_request_id, checkout_request_id, response_description, response_code, customer_message, response_json, mobile_payment_response_id, mobile_payment_request_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mobile_payment_requests; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.mobile_payment_requests (id, phone_number, amount, payment_method, product_id, external_transaction_id, transaction_description, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mobile_payment_responses; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.mobile_payment_responses (id, phone_number, amount, payment_method, mobile_payment_request_id, external_transaction_id, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_version; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.schema_version (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	0.1	Add Uuid ossp	SQL	V0.1__Add_Uuid_ossp.sql	138560310	songa_songa	2018-02-27 13:13:21.176688	301	t
2	0.2	Create LipaNaMpesaOnlinePaymentRequests table	SQL	V0.2__Create_LipaNaMpesaOnlinePaymentRequests_table.sql	-1556006461	songa_songa	2018-02-27 13:13:22.463357	309	t
3	0.3	Create LipaNaMpesaOnlinePaymentResponses table	SQL	V0.3__Create_LipaNaMpesaOnlinePaymentResponses_table.sql	521144374	songa_songa	2018-02-27 13:13:23.75086	306	t
4	0.4	Create MobilePaymentRequest table	SQL	V0.4__Create_MobilePaymentRequest_table.sql	1535385337	songa_songa	2018-02-27 13:13:25.035939	306	t
5	0.5	CreateMobilePaymentResponses	SQL	V0.5__CreateMobilePaymentResponses.sql	-1312230448	songa_songa	2018-02-27 13:13:26.320851	305	t
6	0.6	CreateLipaNaMpesaResponseCallbacksTable	SQL	V0.6__CreateLipaNaMpesaResponseCallbacksTable.sql	1685513438	songa_songa	2018-02-27 13:13:27.60437	305	t
7	0.7	CreateSDPAuthorizationReceiptCallbacksTable	SQL	V0.7__CreateSDPAuthorizationReceiptCallbacksTable.sql	-1936713366	songa_songa	2018-02-27 13:13:28.887008	305	t
8	0.8	CreateSDPDatasyncServiceCallbacksTable	SQL	V0.8__CreateSDPDatasyncServiceCallbacksTable.sql	1664155920	songa_songa	2018-02-27 13:13:30.172798	461	t
9	0.9	CreateSDPSMSNotificationCallbacksTable	SQL	V0.9__CreateSDPSMSNotificationCallbacksTable.sql	718037806	songa_songa	2018-02-27 13:13:31.616876	462	t
10	1.0	CreateSDPNotifySmsDeliveryReceiptCallbacksTable	SQL	V1.0__CreateSDPNotifySmsDeliveryReceiptCallbacksTable.sql	747388719	songa_songa	2018-02-27 13:13:33.063755	460	t
11	1.1	CreateSDPSubscribeManageRequestsTable	SQL	V1.1__CreateSDPSubscribeManageRequestsTable.sql	-1405448256	songa_songa	2018-02-27 13:13:34.501773	383	t
12	1.2	CreateSDPSubscriptionsTable	SQL	V1.2__CreateSDPSubscriptionsTable.sql	-739095948	songa_songa	2018-02-27 13:13:35.862629	461	t
13	1.3	CreateIndexOnSDPAuthorizationReceiptCallbacks	SQL	V1.3__CreateIndexOnSDPAuthorizationReceiptCallbacks.sql	420837698	songa_songa	2018-02-27 13:13:37.300103	303	t
14	1.4	MakePaymentResultNullable	SQL	V1.4__MakePaymentResultNullable.sql	-1545152909	songa_songa	2018-02-27 13:13:38.57742	299	t
15	1.5	AddExternalKeyToSdpSubscribeManage	SQL	V1.5__AddExternalKeyToSdpSubscribeManage.sql	1908629993	songa_songa	2018-02-27 13:13:39.854492	459	t
16	1.6	AddProcessedStatusToSdpSubscribeManage	SQL	V1.6__AddProcessedStatusToSdpSubscribeManage.sql	959986735	songa_songa	2018-02-27 13:13:41.291849	300	t
17	1.7	AddMoreTransactionDetailsToSdpSubscribeManage	SQL	V1.7__AddMoreTransactionDetailsToSdpSubscribeManage.sql	662159821	songa_songa	2018-03-09 12:58:12.90695	934	t
\.


--
-- Data for Name: sdp_authorization_receipt_callbacks; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.sdp_authorization_receipt_callbacks (id, original_transaction_id, capability_type, end_user_identifier, user_cnfm_result, payment_result, created_at, updated_at) FROM stdin;
1981d6c1-ca43-4274-9065-d2a31fada5f0	60197320180321151920000001	1	254717574251	0	\N	2018-03-21 12:19:37.150683	2018-03-21 12:19:37.150683
cfce53b2-853e-4254-9048-b9a8304ea227	60197320180322102123000001	1	254717574251	0	\N	2018-03-22 07:21:46.561334	2018-03-22 07:21:46.561334
f3a04f81-2e11-44fe-a78a-78007da04a73	60197320180322102200000001	1	254717574251	0	\N	2018-03-22 07:22:19.222999	2018-03-22 07:22:19.222999
fe38c512-1956-434b-91d2-7ba52f9adc92	60197320180322165316000001	1	254717574251	2	\N	2018-03-22 13:53:35.430293	2018-03-22 13:53:35.430293
1148b00b-8349-49f3-b9b3-fd3b1566cdb7	60197320180322174609000001	1	254717574251	0	\N	2018-03-22 14:46:36.232377	2018-03-22 14:46:36.232377
ce8b2b75-fc90-4ac3-be91-9e76bff72db8	60197320180323100013000001	1	254717574251	0	\N	2018-03-23 07:00:57.720329	2018-03-23 07:00:57.720329
\.


--
-- Data for Name: sdp_datasync_service_callbacks; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.sdp_datasync_service_callbacks (id, userid_id, userid_type, sp_id, product_id, product_name, service_id, service_list, update_type, update_time, update_desc, effective_time, expiry_time, transaction_id, order_key, mdspsubexpmode, object_type, trace_unique_id, rent_success, created_at, updated_at) FROM stdin;
9a4280d2-743b-48b5-b50b-e94e1148fb7f	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180320210444	Modification	20180314150555	20361231210000	1521532507276	999000000000012542	1	1	000000403211803202104400947003	true	2018-03-20 21:04:51.617664	2018-03-20 21:04:51.617664
df65f4c2-3bbd-42f5-a558-35faded1149b	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180320210453	Modification	20180301103000	20361231210000	1521532507290	999000000000012523	1	1	000000403211803202104520959003	true	2018-03-20 21:04:54.074023	2018-03-20 21:04:54.074023
dec888a8-f379-4692-bbb3-14cc79132555	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180320210453	Modification	20180302071826	20361231210000	1521532507276	999000000000012529	1	1	000000403211803202104520957003	true	2018-03-20 21:04:54.150694	2018-03-20 21:04:54.150694
02b661d6-5748-4f98-8317-69da85e2ade3	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180320210453	Modification	20180304142437	20361231210000	1521532507291	999000000000012534	1	1	000000403211803202104520958003	true	2018-03-20 21:04:54.227992	2018-03-20 21:04:54.227992
5791ee13-d3e4-4242-aca4-d61cc12fd79d	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180321210358	Modification	20180314150555	20361231210000	1521532507290	999000000000012542	1	1	000000403211803212103391253003	true	2018-03-21 21:04:16.054649	2018-03-21 21:04:16.054649
2080dd09-5b65-46af-8e88-8aca328050c0	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180321210358	Modification	20180302071826	20361231210000	1521532507292	999000000000012529	1	1	000000403211803212103391264003	true	2018-03-21 21:04:16.137256	2018-03-21 21:04:16.137256
166f0eaa-ed32-4dfd-bdd0-747c09f2c751	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180321210409	Modification	20180301103000	20361231210000	1521532507287	999000000000012523	1	1	000000403211803212103511266003	true	2018-03-21 21:04:20.278264	2018-03-21 21:04:20.278264
bd934ce8-19d4-4c64-89f0-fde7529e10b8	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180321210409	Modification	20180304142437	20361231210000	1521532507288	999000000000012534	1	1	000000403211803212103511265003	true	2018-03-21 21:04:20.35511	2018-03-21 21:04:20.35511
561a65c9-d877-4bb4-8a32-2791dc07f5fc	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180322210400	Modification	20180314150555	20361231210000	1521532507294	999000000000012542	1	1	000000403211803222103521484003	true	2018-03-22 21:04:02.139774	2018-03-22 21:04:02.139774
871fc90d-9e90-4a08-ad48-cef867f425b2	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180322210402	Modification	20180304142437	20361231210000	1521532507294	999000000000012534	1	1	000000403211803222104021491003	true	2018-03-22 21:04:03.206896	2018-03-22 21:04:03.206896
b488701c-1499-4e53-a9e5-8e0cc31211a3	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180322210402	Modification	20180302071826	20361231210000	1521532507294	999000000000012529	1	1	000000403211803222104021490003	true	2018-03-22 21:04:03.283386	2018-03-22 21:04:03.283386
37a139d6-d246-402a-b1a7-cd7e4b2e664a	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180322210402	Modification	20180301103000	20361231210000	1521532507291	999000000000012523	1	1	000000403211803222104021492003	true	2018-03-22 21:04:03.359827	2018-03-22 21:04:03.359827
3ae4e578-a56c-4125-8ac7-9919eb4544f3	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180323210323	Modification	20180314150555	20361231210000	1521532507282	999000000000012542	1	1	000000403211803232103101806003	true	2018-03-23 21:03:32.174558	2018-03-23 21:03:32.174558
b286d951-0cbe-40df-95ef-d3f4c76a7e00	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180323210353	Modification	20180302071826	20361231210000	1521532507290	999000000000012529	1	1	000000403211803232103411816003	true	2018-03-23 21:04:06.127191	2018-03-23 21:04:06.127191
1c7ebe1a-277c-479c-92ff-f8d839243236	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180323210353	Modification	20180304142437	20361231210000	1521532507288	999000000000012534	1	1	000000403211803232103411815003	true	2018-03-23 21:04:06.203783	2018-03-23 21:04:06.203783
3c83d5b0-dcf1-49b7-a3f5-d98bc9ca6942	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180323210353	Modification	20180301103000	20361231210000	1521532507292	999000000000012523	1	1	000000403211803232103411817003	true	2018-03-23 21:04:06.281925	2018-03-23 21:04:06.281925
6058968d-c447-406d-ad50-1d60025ab737	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180324210343	Modification	20180314150555	20361231210000	1521532507292	999000000000012542	1	1	000000403211803242103351992003	true	2018-03-24 21:03:44.975488	2018-03-24 21:03:44.975488
1f451d98-e3cc-4f39-89af-06d24cfad6f4	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180324210345	Modification	20180302071826	20361231210000	1521532507291	999000000000012529	1	1	000000403211803242103442000003	true	2018-03-24 21:03:45.961545	2018-03-24 21:03:45.961545
33bad8a8-f541-4b0b-96f5-d796c8e0b885	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180324210345	Modification	20180301103000	20361231210000	1521532507292	999000000000012523	1	1	000000403211803242103442002003	true	2018-03-24 21:03:46.057592	2018-03-24 21:03:46.057592
74970570-a86d-4738-a7bf-6ae2b0a5ae11	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180324210345	Modification	20180304142437	20361231210000	1521532507292	999000000000012534	1	1	000000403211803242103442001003	true	2018-03-24 21:03:46.134634	2018-03-24 21:03:46.134634
728be76d-79ec-45ac-8184-64feb7a54c7a	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180325210431	Modification	20180314150555	20361231210000	1521532507291	999000000000012542	1	1	000000403211803252104302195003	true	2018-03-25 21:04:32.212772	2018-03-25 21:04:32.212772
21de5955-af5c-4a9b-b868-79ca053081d5	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180325210431	Modification	20180302071826	20361231210000	1521532507288	999000000000012529	1	1	000000403211803252104302201003	true	2018-03-25 21:04:32.307121	2018-03-25 21:04:32.307121
d01c457c-9e61-4e2d-b97f-307fbe9526d4	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180325210431	Modification	20180304142437	20361231210000	1521532507284	999000000000012534	1	1	000000403211803252104302206003	true	2018-03-25 21:04:32.386128	2018-03-25 21:04:32.386128
106dfb78-45dd-404c-ae8f-d57690fc33e2	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180325210431	Modification	20180301103000	20361231210000	1521532507282	999000000000012523	1	1	000000403211803252104302205003	true	2018-03-25 21:04:32.479397	2018-03-25 21:04:32.479397
b2dbf4cd-21bf-4e52-a7e5-f2a150c3e758	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180326210348	Modification	20180314150555	20361231210000	1521532507286	999000000000012542	1	1	000000403211803262103472480003	true	2018-03-26 21:03:49.980772	2018-03-26 21:03:49.980772
12addc93-6a0a-4b5d-a861-fcd1475d812f	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180326210349	Modification	20180302071826	20361231210000	1521532507294	999000000000012529	1	1	000000403211803262103482489003	true	2018-03-26 21:03:50.4487	2018-03-26 21:03:50.4487
f8e21779-dfcb-4343-becc-54f2babf7c9b	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180326210349	Modification	20180301103000	20361231210000	1521532507291	999000000000012523	1	1	000000403211803262103492491003	true	2018-03-26 21:03:50.534823	2018-03-26 21:03:50.534823
052ac751-9cc3-464a-b8bb-e4c8d55142a6	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180326210349	Modification	20180304142437	20361231210000	1521532507288	999000000000012534	1	1	000000403211803262103482490003	true	2018-03-26 21:03:50.614081	2018-03-26 21:03:50.614081
1f5ad947-a13f-4947-a2c3-16a4abfe90e5	254700689874	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180327210336	Modification	20180314150555	20361231210000	1521532507282	999000000000012542	1	1	000000403211803272103343070003	true	2018-03-27 21:03:37.293982	2018-03-27 21:03:37.293982
e0ac102e-be65-4fca-8190-8c3b503d1ccb	254715898440	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180327210336	Modification	20180304142437	20361231210000	1521532507292	999000000000012534	1	1	000000403211803272103343080003	true	2018-03-27 21:03:37.376551	2018-03-27 21:03:37.376551
872ec08e-99ce-4c6e-9a97-b38e7e0d7540	254799748045	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180327210336	Modification	20180301103000	20361231210000	1521532507288	999000000000012523	1	1	000000403211803272103343081003	true	2018-03-27 21:03:37.455909	2018-03-27 21:03:37.455909
877caf5b-6a2d-4e04-b085-6c17206aa6b1	254746783234	0	601973	MDSP2000008827	songa2500	6019732000004089	6019732000004089	3	20180327210336	Modification	20180302071826	20361231210000	1521532507290	999000000000012529	1	1	000000403211803272103343079003	true	2018-03-27 21:03:37.532181	2018-03-27 21:03:37.532181
\.


--
-- Data for Name: sdp_sms_delivery_receipt_callbacks; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.sdp_sms_delivery_receipt_callbacks (id, correlator, delivery_status, address, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sdp_sms_notification_callbacks; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.sdp_sms_notification_callbacks (id, correlator, sms_message, sender_address, sms_service_activation_number, date_time, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sdp_subscribe_manage_requests; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.sdp_subscribe_manage_requests (id, phone_number, request_json, created_at, updated_at, product_id, status, amount, payment_method, account_id, payment_id, payment_transaction_id, payment_external_key, transaction_description) FROM stdin;
00083a5d-161a-472f-a9fd-58a76eddd104	254717574251	{"subscribeProductRsp": {"result": "999999999", "resultDescription": "Pending"}}	2018-03-08 09:22:19.832658	2018-03-08 09:22:19.832658	songa25000	2	1.00	Charge Amount	8y586440-4370-45b2-afc0-e20a28897b22	e20a28897b22-4d586650-4370-45b2-afc0	4d586650-4370-45b2-afc0-e20a28897b22	f2ddd2f3-82c9-48be-92a6-fa505ea3b9f7	\N
\.


--
-- Data for Name: sdp_subscriptions; Type: TABLE DATA; Schema: ral_payments_dev; Owner: songa_songa
--

COPY ral_payments_dev.sdp_subscriptions (id, userid_id, userid_type, sp_id, product_id, product_name, service_id, service_list, update_type, update_time, update_desc, effective_time, expiry_time, transaction_id, order_key, mdspsubexpmode, object_type, trace_unique_id, rent_success, created_at, updated_at) FROM stdin;
\.


--
-- Name: lipa_na_mpesa_online_payment_requests lipa_na_mpesa_online_payment_requests_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
--

-- ALTER TABLE ONLY ral_payments_dev.lipa_na_mpesa_online_payment_requests
--     ADD CONSTRAINT lipa_na_mpesa_online_payment_requests_pkey PRIMARY KEY (id);


-- --
-- -- Name: lipa_na_mpesa_online_payment_response_callbacks lipa_na_mpesa_online_payment_response_callbacks_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.lipa_na_mpesa_online_payment_response_callbacks
--     ADD CONSTRAINT lipa_na_mpesa_online_payment_response_callbacks_pkey PRIMARY KEY (id);


-- --
-- -- Name: lipa_na_mpesa_online_payment_responses lipa_na_mpesa_online_payment_responses_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.lipa_na_mpesa_online_payment_responses
--     ADD CONSTRAINT lipa_na_mpesa_online_payment_responses_pkey PRIMARY KEY (id);


-- --
-- -- Name: mobile_payment_requests mobile_payment_requests_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.mobile_payment_requests
--     ADD CONSTRAINT mobile_payment_requests_pkey PRIMARY KEY (id);


-- --
-- -- Name: mobile_payment_responses mobile_payment_responses_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.mobile_payment_responses
--     ADD CONSTRAINT mobile_payment_responses_pkey PRIMARY KEY (id);


-- --
-- -- Name: schema_version schema_version_pk; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.schema_version
--     ADD CONSTRAINT schema_version_pk PRIMARY KEY (installed_rank);


-- --
-- -- Name: sdp_authorization_receipt_callbacks sdp_authorization_receipt_callbacks_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.sdp_authorization_receipt_callbacks
--     ADD CONSTRAINT sdp_authorization_receipt_callbacks_pkey PRIMARY KEY (id);


-- --
-- -- Name: sdp_datasync_service_callbacks sdp_datasync_service_callbacks_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.sdp_datasync_service_callbacks
--     ADD CONSTRAINT sdp_datasync_service_callbacks_pkey PRIMARY KEY (id);


-- --
-- -- Name: sdp_sms_delivery_receipt_callbacks sdp_sms_delivery_receipt_callbacks_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.sdp_sms_delivery_receipt_callbacks
--     ADD CONSTRAINT sdp_sms_delivery_receipt_callbacks_pkey PRIMARY KEY (id);


-- --
-- -- Name: sdp_sms_notification_callbacks sdp_sms_notification_callbacks_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.sdp_sms_notification_callbacks
--     ADD CONSTRAINT sdp_sms_notification_callbacks_pkey PRIMARY KEY (id);


-- --
-- -- Name: sdp_subscribe_manage_requests sdp_subscribe_manage_requests_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.sdp_subscribe_manage_requests
--     ADD CONSTRAINT sdp_subscribe_manage_requests_pkey PRIMARY KEY (id);


-- --
-- -- Name: sdp_subscriptions sdp_subscriptions_pkey; Type: CONSTRAINT; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- ALTER TABLE ONLY ral_payments_dev.sdp_subscriptions
--     ADD CONSTRAINT sdp_subscriptions_pkey PRIMARY KEY (id);


-- --
-- -- Name: address_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX address_idx ON ral_payments_dev.sdp_sms_delivery_receipt_callbacks USING btree (address);


-- --
-- -- Name: correlator_sms_delivery_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX correlator_sms_delivery_idx ON ral_payments_dev.sdp_sms_delivery_receipt_callbacks USING btree (correlator);


-- --
-- -- Name: correlator_sms_notification_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX correlator_sms_notification_idx ON ral_payments_dev.sdp_sms_notification_callbacks USING btree (correlator);


-- --
-- -- Name: original_transaction_id_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX original_transaction_id_idx ON ral_payments_dev.sdp_authorization_receipt_callbacks USING btree (original_transaction_id);


-- --
-- -- Name: phone_number_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX phone_number_idx ON ral_payments_dev.sdp_subscribe_manage_requests USING btree (phone_number);


-- --
-- -- Name: schema_version_s_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX schema_version_s_idx ON ral_payments_dev.schema_version USING btree (success);


-- --
-- -- Name: sender_address_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX sender_address_idx ON ral_payments_dev.sdp_sms_notification_callbacks USING btree (sender_address);


-- --
-- -- Name: transaction_id_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX transaction_id_idx ON ral_payments_dev.sdp_datasync_service_callbacks USING btree (transaction_id);


-- --
-- -- Name: transaction_id_sdp_subscriptions_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX transaction_id_sdp_subscriptions_idx ON ral_payments_dev.sdp_subscriptions USING btree (transaction_id);


-- --
-- -- Name: userid_id_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX userid_id_idx ON ral_payments_dev.sdp_datasync_service_callbacks USING btree (userid_id);


-- --
-- -- Name: userid_id_sdp_subscriptions_idx; Type: INDEX; Schema: ral_payments_dev; Owner: songa_songa
-- --

-- CREATE INDEX userid_id_sdp_subscriptions_idx ON ral_payments_dev.sdp_subscriptions USING btree (userid_id);


-- --
-- -- Name: SCHEMA ral_payments_dev; Type: ACL; Schema: -; Owner: songa_songa
-- --

-- GRANT ALL ON SCHEMA ral_payments_dev TO ral_payments_dev;


--
-- PostgreSQL database dump complete
--

