/**
 * This software was developed and / or modified by Raytheon Company,
 * pursuant to Contract DG133W-05-CQ-1067 with the US Government.
 * 
 * U.S. EXPORT CONTROLLED TECHNICAL DATA
 * This software product contains export-restricted data whose
 * export/transfer/disclosure is restricted by U.S. law. Dissemination
 * to non-U.S. persons whether in the United States or abroad requires
 * an export license or other authorization.
 * 
 * Contractor Name:        Raytheon Company
 * Contractor Address:     6825 Pine Street, Suite 340
 *                         Mail Stop B8
 *                         Omaha, NE 68106
 *                         402.291.0100
 * 
 * See the AWIPS II Master Rights File ("Master Rights File.pdf") for
 * further licensing information.
 **/
--
-- Data for Name: mon_climate_norm; Type: TABLE DATA; Schema: public; Owner: pguser
--

COPY mon_climate_norm (station_id, month_of_year, period_type, max_temp_mean, max_temp_record, day_max_temp_rec1, day_max_temp_rec2, day_max_temp_rec3, min_temp_mean, min_temp_record, day_min_temp_rec1, day_min_temp_rec2, day_min_temp_rec3, norm_mean_temp, norm_mean_max_temp, norm_mean_min_temp, num_max_ge_90f, num_max_le_32f, num_min_le_32f, num_min_le_0f, precip_pd_mean, precip_pd_max, precip_pd_max_yr1, precip_pd_max_yr2, precip_pd_max_yr3, precip_period_min, precip_pd_min_yr1, precip_pd_min_yr2, precip_pd_min_yr3, precip_day_norm, num_prcp_ge_01, num_prcp_ge_10, num_prcp_ge_50, num_prcp_ge_100, snow_pd_mean, snow_pd_max, snow_pd_max_yr1, snow_pd_max_yr2, snow_pd_max_yr3, snow_24h_begin1, snow_24h_begin2, snow_24h_begin3, snow_max_24h_rec, snow_24h_end1, snow_24h_end2, snow_24h_end3, snow_water_pd_norm, snow_ground_norm, snow_ground_max, day_snow_grnd_max1, day_snow_grnd_max2, day_snow_grnd_max3, num_snow_ge_tr, num_snow_ge_1, heat_pd_mean, cool_pd_mean) FROM stdin;
16350	1	5	31.299999	69	1944-01-25	\N	\N	10.9	-32	1884-01-05	\N	\N	21.700001	31.700001	11.6	0	15	30	8	0.76999998	3.7	1949	9999	9999	-1	1986	9999	9999	0.024838701	6	9999	9999	0	6.3000002	25.700001	1936	9999	9999	\N	\N	\N	13.1	\N	\N	\N	0.69999999	9999	17	1984-01-01	\N	\N	4.5999999	1.9	1349	0
13830	5	5	74.199997	104	1934-05-30	\N	\N	50	24	1994-05-01	\N	\N	62	73.800003	50.099998	1	0	1	0	4.23	10.72	1903	9999	9999	0.49000001	1934	9999	9999	0.13645162	11	9999	9999	1	-1	3	1967	9999	9999	2007-05-05	\N	\N	-1	2007-05-05	\N	\N	3.9000001	9999	3	\N	\N	\N	0	0	154	56
19860	5	5	73.699997	9999	\N	\N	\N	50.5	32	2008-05-04	\N	\N	62.099998	9999	9999	9999	9999	9999	9999	4.2199998	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	165	75
16350	10	5	65.599998	96	1938-10-03	\N	\N	41.200001	8	1925-10-28	\N	\N	53.200001	65.199997	41.099998	0	0	6	0	2.21	6.23	2007	9999	9999	-1	1952	9999	9999	0.071290299	7	9999	9999	1	0.30000001	7.1999998	1941	9999	9999	\N	\N	\N	7.1999998	\N	\N	\N	2.3	9999	5	1997-10-26	\N	\N	0.2	0.2	384	12
16350	9	5	76.5	104	1939-09-06	\N	\N	53.599998	28	1984-09-29	\N	\N	65.400002	77.300003	53.5	3	0	0	0	3.1700001	13.75	1965	9999	9999	0.23999999	1898	9999	9999	0.105667	9	9999	9999	1	-1	0.30000001	1985	9999	9999	2005-09-18	\N	\N	-1	2005-09-18	\N	\N	3.7	9999	0	\N	\N	\N	0	0	105	114
16230	6	5	82.099998	109	1933-06-10	1933-06-06	\N	58.599998	34	1935-06-07	\N	\N	70.099998	82.300003	58	7	0	0	0	4.25	12.28	1924	9999	9999	0.44	1933	9999	9999	0.14166699	10	9999	9999	1	0	0	2002	2001	1996	2002-06-30	\N	\N	0	2002-06-30	\N	\N	4.5	9999	0	\N	\N	\N	0	0	28	197
13830	1	9	9999	9999	\N	\N	\N	9999	9999	\N	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	9999	9999	9999	9999	\N	9999	9999	\N	9999	9999	9999	9999	\N	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	-9999	-9999
16350	4	5	63.799999	96	1989-04-22	\N	\N	39.900002	5	1975-04-03	\N	\N	51.400002	63.200001	39.599998	1	0	7	0	2.9400001	8.4799995	1999	9999	9999	0.23	1936	9999	9999	0.097999997	10	9999	9999	1	1.2	10	1992	9999	9999	\N	\N	\N	9.8999996	\N	\N	\N	2.7	9999	8	1992-04-21	\N	\N	1.1	0.60000002	424	14
16173	4	5	9999	93	2002-04-15	\N	\N	9999	17	2007-04-07	\N	\N	50.700001	61.900002	39.5	9999	9999	9999	9999	2.9400001	4.6799998	2007	9999	9999	1.28	2004	9999	9999	0.1	9999	9999	9999	9999	9999	-1	2007	2006	2005	2003-04-06	\N	\N	3.8	2003-04-06	\N	\N	9999	9999	3	2003-04-08	2003-04-07	\N	9999	9999	442	13
13830	4	5	64.400002	97	1989-04-26	1910-04-28	\N	38.900002	3	1975-04-03	\N	\N	51.200001	63.5	38.799999	1	0	8	0	2.9000001	7.21	1978	9999	9999	0.02	1910	9999	9999	0.096666701	9	9999	9999	1	1.7	11.1	1997	9999	9999	\N	\N	\N	10.1	\N	\N	\N	2.8	9999	7	1997-04-12	\N	\N	1.1	0.5	425	13
16173	1	5	9999	67	2003-01-08	2002-01-26	\N	9999	-14	2007-01-16	2005-01-15	\N	21.5	31.4	11.5	9999	9999	9999	9999	0.76999998	1.6799999	2004	9999	9999	0.30000001	2009	9999	9999	0.02	6	9999	9999	0	9999	20.799999	2004	9999	9999	2004-01-25	\N	\N	11.1	2004-01-26	\N	\N	9999	9999	13	2005-01-07	2005-01-06	2004-01-27	9999	9999	1350	0
16350	11	7	\N	104	1939-09-06	\N	\N	\N	-14	1887-11-27	\N	\N	52.484402	63.804298	41.164501	\N	\N	\N	\N	7.4899998	\N	\N	\N	\N	\N	\N	\N	\N	2.49667	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1232	95
16350	6	5	83.699997	107	1933-06-06	\N	\N	60.400002	39	1945-06-04	\N	\N	72.199997	83.699997	60.599998	7	0	0	0	3.95	12.7	1883	9999	9999	0.23999999	2007	9999	9999	0.13166666	10	9999	9999	1	0	-1	2008	2005	2001	2008-06-19	2008-06-11	2005-06-27	-1	2008-06-19	2008-06-11	2005-06-27	3.9000001	9999	0	\N	\N	\N	0	0	17	233
16173	6	5	9999	96	2002-06-29	2001-06-11	\N	9999	46	2004-06-25	\N	\N	71.699997	82.400002	60.900002	9999	9999	9999	9999	3.95	8.4300003	2008	9999	9999	1.21	2002	9999	9999	0.13	9999	9999	9999	9999	9999	-1	2008	2006	2005	\N	\N	\N	9999	\N	\N	\N	9999	9999	0	\N	\N	\N	9999	9999	20	220
13830	1	5	32.400002	73	1990-01-10	\N	\N	10.1	-33	1974-01-12	\N	\N	22.4	33.200001	11.5	0	14	30	7	0.67000002	3.1500001	1949	9999	9999	-1	1986	9999	9999	0.021612903	6	9999	9999	0	5.6999998	23	1915	9999	9999	2004-01-25	\N	\N	8.6000004	2004-01-26	\N	\N	0.5	9999	18	1974-01-11	1974-01-12	1974-01-13	5.5	2	1328	0
16350	12	5	34.599998	72	1939-12-06	\N	\N	15.6	-25	1989-12-22	\N	\N	25.6	34.799999	16.4	0	12	29	4	0.92000002	5.4200001	1984	9999	9999	-1	2002	1943	9999	0.029677421	7	9999	9999	0	5.5	19.9	1969	9999	9999	\N	\N	\N	10.2	\N	\N	\N	1	9999	17	1983-12-21	1983-12-22	1983-12-23	4.8000002	2	1211	0
16173	12	5	9999	65	2002-12-15	\N	\N	9999	-9	2008-12-22	2005-12-06	2000-01-01	25.200001	34.200001	16.200001	9999	9999	9999	9999	0.92000002	2.9400001	2006	9999	9999	0.0099999998	2002	9999	9999	9999	9999	9999	9999	9999	9999	11.4	2007	9999	9999	2003-12-09	\N	\N	5.5999999	2003-12-09	\N	\N	9999	9999	8	2007-12-17	2007-12-16	\N	9999	9999	1229	0
13830	12	5	35.799999	75	1939-12-06	\N	\N	15.4	-27	1983-12-22	\N	\N	26.5	36.799999	16.200001	0	12	30	4	0.86000001	4.0300002	1913	9999	9999	0	1889	9999	9999	0.0277419	6	9999	9999	0	5.6999998	22.299999	1945	9999	9999	\N	\N	\N	10.4	\N	\N	\N	0.89999998	9999	16	1983-12-28	\N	\N	4.3000002	1.8	1188	0
13830	6	5	84.699997	108	1946-06-15	1936-06-26	\N	60.200001	39	1978-06-08	\N	\N	72.699997	84.900002	60.400002	9	0	0	0	3.51	13.77	1967	9999	9999	0.17	2002	9999	9999	0.117	8	9999	9999	1	0	-1	2004	2003	2001	2002-06-30	\N	\N	0	2002-06-30	\N	\N	3.9000001	9999	0	\N	\N	\N	0	0	16	244
16173	10	5	9999	91	2006-10-01	2005-10-04	\N	9999	21	2002-10-31	\N	\N	52.900002	64.599998	41.200001	9999	9999	9999	9999	2.21	5.6100001	2008	9999	9999	0.79000002	2006	9999	9999	0.07	9999	9999	9999	9999	9999	3.7	2002	9999	9999	2002-10-23	\N	\N	3.7	2002-10-24	\N	\N	9999	9999	3	2002-10-24	\N	\N	9999	9999	395	11
16350	11	5	49.299999	83	1999-11-13	\N	\N	28.700001	-14	1887-11-27	\N	\N	38	47.799999	28.1	0	2	20	0	1.8200001	6.2399998	1909	9999	9999	0.029999999	2007	1989	9999	0.060666669	6	9999	9999	0	3.4000001	15.8	1928	9999	9999	\N	\N	\N	8.6999998	\N	\N	\N	1.5	9999	9	1957-11-19	\N	\N	2.5	1.3	806	0
16173	7	5	9999	101	2002-07-21	2002-07-20	\N	9999	52	2005-07-27	2005-07-27	2005-07-27	75.800003	86	65.599998	9999	9999	9999	9999	3.8599999	5.3699999	2005	9999	9999	1.78	2003	9999	9999	0.12	9999	9999	9999	9999	9999	-1	2008	2006	2001	2008-07-15	2006-07-13	\N	-1	2008-07-15	2006-07-13	\N	9999	9999	0	\N	\N	\N	9999	9999	0	334
19860	7	5	87.300003	9999	\N	\N	\N	64.400002	50	2006-07-06	\N	\N	75.900002	9999	9999	9999	9999	9999	9999	3.47	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1	337
16350	5	5	74	103	1934-05-30	\N	\N	50.900002	25	1909-05-01	\N	\N	62.200001	73.699997	50.700001	2	0	0	0	4.4400001	11.29	1883	9999	9999	0.55000001	1989	9999	9999	0.143226	12	9999	9999	1	0	2	1945	9999	9999	\N	\N	\N	2	\N	\N	\N	4.5	9999	0	\N	\N	\N	0	0	151	60
11160	6	5	86.900002	9999	\N	\N	\N	60.900002	49	2007-06-09	2007-06-08	1950-08-20	73.900002	9999	9999	9999	9999	9999	9999	3.8299999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	10	277
16173	5	5	9999	94	2002-05-31	2002-05-30	\N	9999	32	2005-05-01	2004-05-03	\N	61.799999	72.599998	50.900002	9999	9999	9999	9999	4.4400001	9.3400002	2001	9999	9999	1.05	2006	9999	9999	0.14	9999	9999	9999	9999	9999	-1	2007	2005	2004	\N	\N	\N	9999	\N	\N	\N	9999	9999	0	\N	\N	\N	9999	9999	160	56
13830	10	5	66.699997	98	1947-10-05	\N	\N	40.5	3	1925-10-30	\N	\N	53.5	66.5	40.400002	0	0	6	0	1.9400001	5.4000001	1986	9999	9999	-1	1952	9999	9999	0.0625806	7	9999	9999	1	0.69999999	13.2	1997	9999	9999	\N	\N	\N	13.2	\N	\N	\N	2.0999999	9999	10	1997-10-26	\N	\N	0.2	0.1	377	12
19860	6	5	83.800003	9999	\N	\N	\N	60.200001	48	2007-06-09	2007-06-05	2007-06-08	72	9999	9999	9999	9999	9999	9999	3.8599999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	16	224
11160	5	5	76.699997	9999	\N	\N	\N	51.299999	34	2008-05-04	\N	\N	64	9999	9999	9999	9999	9999	9999	4.3299999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	129	98
16230	12	5	32.700001	72	1904-12-31	\N	\N	12.8	-30	1989-12-22	\N	\N	23.700001	33.599998	13.7	0	15	30	5	0.64999998	2.6199999	2006	9999	9999	-1	1905	9999	9999	0.0209677	6	9999	9999	0	6	19.1	1968	9999	9999	\N	\N	\N	12.1	\N	\N	\N	0.69999999	9999	17	1968-12-31	\N	\N	4.6999998	1.9	1266	0
16230	1	5	29.6	74	2002-01-26	\N	\N	8.3999996	-39	1912-01-12	\N	\N	20.4	31.200001	9.6000004	0	16	31	10	0.56999999	2.3299999	1949	9999	9999	0.050000001	1928	9999	9999	0.0183871	6	9999	9999	0	5.9000001	21.200001	1932	9999	9999	2007-01-14	\N	\N	6.5	2007-01-14	\N	\N	0.5	9999	17	1969-01-01	1969-01-02	\N	5.8000002	1.7	1388	0
11160	1	5	34.5	9999	\N	\N	\N	13.7	-12	2008-01-24	\N	\N	24.1	9999	9999	9999	9999	9999	9999	0.87	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	0	672	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1268	0
16230	2	9	9999	9999	\N	\N	\N	9999	9999	\N	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	9999	9999	9999	9999	\N	9999	9999	\N	9999	9999	9999	9999	\N	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	-9999	-9999
16230	10	5	64.099998	96	1938-10-03	\N	\N	38.599998	2	1925-10-30	\N	\N	51	64	38	0	0	8	0	1.72	6.8099999	2007	9999	9999	-1	1958	9999	9999	0.0554839	6	9999	9999	0	0.69999999	7	1916	9999	9999	\N	\N	\N	9999	\N	\N	\N	1.6	9999	3	1997-10-26	\N	\N	0.60000002	0.2	432	7
11160	12	5	38.299999	9999	\N	\N	\N	18.1	-9	2008-12-22	\N	\N	28.200001	9999	9999	9999	9999	9999	9999	1.03	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1141	0
11160	10	5	68.5	9999	\N	\N	\N	41.5	22	2008-10-28	\N	\N	55	9999	9999	9999	9999	9999	9999	2.5899999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	319	9
16230	4	5	61.599998	102	1910-04-28	\N	\N	37.599998	-5	1936-04-03	\N	\N	49.099998	61.299999	36.799999	1	0	9	0	2.5899999	7.4699998	1984	9999	9999	0.11	1928	9999	9999	0.086333297	9	9999	9999	1	2.7	13.2	1984	9999	9999	\N	\N	\N	9999	\N	\N	\N	2.3	9999	9	1997-04-12	\N	\N	1.5	0.80000001	478	11
11160	4	5	65.699997	9999	\N	\N	\N	39.599998	16	2007-04-08	\N	\N	52.700001	9999	9999	9999	9999	9999	9999	3.1800001	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	381	10
19860	10	5	65.400002	9999	\N	\N	\N	39.700001	17	2006-10-31	\N	\N	52.599998	9999	9999	9999	9999	9999	9999	2.3199999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	389	3
19860	4	5	62.099998	9999	\N	\N	\N	38.599998	17	2007-04-07	\N	\N	50.400002	9999	9999	9999	9999	9999	9999	3.0799999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	447	7
13830	11	5	50.200001	85	1999-11-13	\N	\N	27.299999	-15	1887-11-27	\N	\N	38.099998	49.099998	27	0	3	21	0	1.58	7.1399999	1909	9999	9999	-1	1894	9999	9999	0.052666701	6	9999	9999	0	2.8	12.6	1957	9999	9999	\N	\N	\N	7.6999998	\N	\N	\N	1.3	9999	10	1957-11-18	\N	\N	2.4000001	1	806	0
19860	12	5	33.200001	9999	\N	\N	\N	14.8	-16	2008-12-22	\N	\N	24	9999	9999	9999	9999	9999	9999	0.82999998	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1272	0
16230	11	5	46.900002	83	2005-11-02	1909-11-04	\N	25.5	-15	1964-11-30	\N	\N	35.099998	45.5	24.700001	0	4	23	1	1.4400001	3.97	1983	9999	9999	-1	1939	9999	9999	0.048	5	9999	9999	0	4.9000001	22.6	1983	9999	9999	\N	\N	\N	14.6	\N	\N	\N	1	9999	17	1983-11-29	\N	\N	3.5	1.7	881	0
19860	11	5	46.700001	9999	\N	\N	\N	26.9	6	2006-11-30	\N	\N	36.799999	9999	9999	9999	9999	9999	9999	1.58	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	846	0
16350	7	5	87.900002	114	1936-07-25	\N	\N	65.900002	44	1972-07-05	\N	\N	76.699997	87.400002	65.900002	14	0	0	0	3.8599999	10.35	1884	9999	9999	0.38999999	1983	9999	9999	0.124516	9	9999	9999	1	0	-1	2008	2002	9999	2008-07-02	\N	\N	-1	2008-07-02	\N	\N	3.5	9999	0	\N	\N	\N	0	0	1	365
13830	7	5	90	115	\N	\N	\N	66.300003	42	\N	\N	\N	77.800003	89.599998	65.900002	17	0	0	0	3.54	12.5	1993	9999	9999	0.079999998	1936	9999	9999	0.114194	8	9999	9999	1	0	0	2002	2001	1989	2002-07-31	\N	\N	0	2002-07-31	\N	\N	3.2	9999	0	\N	\N	\N	0	0	1	390
16230	7	5	86.800003	116	1936-07-17	\N	\N	64	42	1971-07-30	\N	\N	74.800003	86.5	63	13	0	0	0	3.74	9.1099997	1950	9999	9999	0.18000001	1936	9999	9999	0.120645	9	9999	9999	1	0	0	2002	2001	1996	2002-07-31	\N	\N	0	2002-07-31	\N	\N	3.2	9999	0	\N	\N	\N	0	0	4	322
19860	1	5	30.1	9999	\N	\N	\N	10	-20	2008-01-24	\N	\N	20.1	9999	9999	9999	9999	9999	9999	0.75999999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1395	0
16173	9	5	9999	95	2005-09-21	\N	\N	9999	32	2003-09-29	\N	\N	65.099998	76.699997	53.599998	9999	9999	9999	9999	3.1700001	5.4699998	2006	9999	9999	0.92000002	2002	9999	9999	0.12	9999	9999	9999	9999	9999	-1	2001	9999	9999	2002-09-30	\N	\N	0	2002-09-30	\N	\N	9999	9999	0	\N	\N	\N	9999	9999	108	111
16350	8	5	85.199997	111	\N	\N	\N	62.900002	43	\N	\N	\N	74.5	85.199997	63.799999	9	0	0	0	3.21	12.5	1903	9999	9999	0.18000001	1913	9999	9999	0.103548	9	9999	9999	1	0	-1	2005	2004	2002	2005-08-28	\N	\N	-1	2005-08-28	\N	\N	3.2	9999	0	\N	\N	\N	0	0	6	296
16173	8	5	9999	100	\N	\N	\N	9999	47	\N	\N	\N	73.599998	83.699997	63.5	9999	9999	9999	9999	3.21	8.3800001	2007	9999	9999	1.42	2003	9999	9999	0.1	9999	9999	9999	9999	9999	-1	2005	2004	2001	\N	\N	\N	9999	\N	\N	\N	9999	9999	0	\N	\N	\N	9999	9999	11	276
13830	8	5	86.699997	110	1936-08-18	1934-08-08	\N	63.299999	39	1950-08-20	\N	\N	75.400002	87.099998	63.700001	12	0	0	0	3.3499999	13.98	1910	9999	9999	0.07	1976	9999	9999	0.10806451	9	9999	9999	1	0	-1	2007	2004	2002	2007-08-20	\N	\N	-1	2007-08-20	\N	\N	3.4000001	9999	0	\N	\N	\N	0	0	5	315
16173	11	7	\N	95	2005-09-21	\N	\N	\N	8	2006-11-30	2002-11-27	2002-11-26	9999	9999	9999	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	9999	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9999	-9999
16350	8	7	9999	114	1936-07-25	\N	\N	9999	39	1945-06-04	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	0	5024	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	12	641
16173	11	5	9999	82	2006-11-08	\N	\N	9999	8	2006-11-30	2002-11-27	2002-11-26	37.599998	47.099998	28	9999	9999	9999	9999	9999	3.1300001	2004	9999	9999	0.039999999	2007	9999	9999	9999	9999	9999	9999	9999	9999	-1	2008	2001	9999	2004-11-28	\N	\N	4	2004-11-28	\N	\N	9999	9999	4	2004-11-29	\N	\N	9999	9999	819	0
11160	7	5	91.599998	9999	\N	\N	\N	65.099998	55	2008-07-13	2006-07-06	1950-08-20	78.400002	9999	9999	9999	9999	9999	9999	5.23	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	0	413
16230	8	5	83.800003	110	\N	\N	\N	61.200001	36	\N	\N	\N	72.699997	84.400002	61	9	0	0	0	2.8	8.2700005	1923	9999	9999	0.37	1941	9999	9999	0.090322599	8	9999	9999	1	0	0	2002	2001	1992	2002-08-31	\N	\N	0	2002-08-31	\N	\N	2.5	9999	0	\N	\N	\N	0	0	11	261
11160	8	5	89.300003	9999	\N	\N	\N	62.200001	52	2008-08-30	\N	\N	75.800003	9999	9999	9999	9999	9999	9999	4.3000002	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	8	340
19860	8	5	84.900002	9999	\N	\N	\N	61.900002	47	2008-08-29	2006-08-30	2007-06-08	73.400002	9999	9999	9999	9999	9999	9999	3.51	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	13	273
16230	2	7	\N	76	2002-02-23	\N	\N	\N	-39	1912-01-12	\N	\N	22.0616	32.3456	11.7776	\N	\N	\N	\N	2.03	\N	\N	\N	\N	\N	\N	\N	\N	0.67666698	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3871	0
13830	9	5	77.199997	106	2000-09-02	1922-09-01	\N	53.200001	26	1984-09-29	\N	\N	66	78.800003	53.200001	4	0	1	0	2.9200001	8.3199997	1914	9999	9999	-1	1894	9999	9999	0.097333297	8	9999	9999	1	-1	0.80000001	1985	9999	9999	\N	\N	\N	0.80000001	\N	\N	\N	3.5	9999	0	\N	\N	\N	0	0	100	123
11160	2	7	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	-12	2008-01-24	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	0	5024	5881-10-07	5881-10-07	5881-10-07	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	3383	0
16173	8	7	\N	101	2002-07-21	2002-07-20	\N	\N	46	2004-06-25	\N	\N	73.480301	83.847702	63.1129	\N	\N	\N	\N	10.62	\N	\N	\N	\N	\N	\N	\N	\N	3.54	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	32	825
13830	8	7	\N	115	1936-07-25	\N	\N	\N	39	1978-06-08	1950-08-20	\N	75.198402	87.136597	63.260201	\N	\N	\N	\N	10.5	\N	\N	\N	\N	\N	\N	\N	\N	3.5	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	20	964
16230	8	7	\N	116	\N	\N	\N	\N	34	\N	\N	\N	72.751099	84.237602	61.2645	\N	\N	\N	\N	10.23	\N	\N	\N	\N	\N	\N	\N	\N	3.4100001	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	38	754
11160	8	7	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	49	2007-06-09	2007-06-08	2007-06-08	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	0	5024	5881-10-07	5881-10-07	5881-10-07	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	18	1030
19860	8	7	9999	9999	\N	\N	\N	9999	47	2008-08-29	2006-08-30	2006-08-30	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	30	834
16230	9	5	75.099998	103	1913-09-06	\N	\N	51.099998	20	1899-09-29	\N	\N	63.400002	76.400002	50.400002	3	0	1	0	2.25	8.5200005	1901	9999	9999	0.1	1892	9999	9999	0.075000003	8	9999	9999	1	-1	1.1	1985	9999	9999	\N	\N	\N	1.1	\N	\N	\N	2.5	9999	0	\N	\N	\N	0.1	0	130	93
11160	9	5	81	9999	\N	\N	\N	53.099998	37	2007-09-15	\N	\N	67.099998	9999	9999	9999	9999	9999	9999	3.98	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	73	135
16230	5	5	72.599998	106	1934-05-29	\N	\N	49.200001	21	1909-05-02	1909-05-01	1908-05-02	60.299999	72.300003	48.299999	1	0	1	0	3.9200001	9.8800001	1905	9999	9999	0.69	1940	9999	9999	0.126452	11	9999	9999	1	-1	2.7	1947	9999	9999	\N	\N	\N	9999	\N	\N	\N	3.7	9999	0	\N	\N	\N	0	0	180	48
19860	9	5	77.599998	9999	\N	\N	\N	51.900002	33	2007-09-15	1999-12-31	\N	64.800003	9999	9999	9999	9999	9999	9999	3.28	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	87	80
16350	2	5	37.099998	78	1896-02-26	\N	\N	16.700001	-26	1899-02-11	\N	\N	28	37.900002	18	0	11	26	4	0.80000001	3.0899999	1881	9999	9999	0.029999999	1931	9999	9999	0.028571401	6	9999	9999	0	5.9000001	25.4	1965	9999	9999	\N	\N	\N	18.299999	\N	\N	\N	0.80000001	9999	26	2004-02-07	2004-02-06	\N	4.1999998	1.9	1052	0
13830	11	7	\N	106	2000-09-02	1922-09-01	\N	\N	-15	1887-11-27	\N	\N	52.510201	64.703201	40.3172	\N	\N	\N	\N	6.8699999	\N	\N	\N	\N	\N	\N	\N	\N	2.29	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1229	98
16173	2	5	9999	67	2002-02-23	\N	\N	9999	-9	2007-02-14	\N	\N	27.5	37.400002	17.6	0	11	26	4	0.80000001	3.71	2005	9999	9999	0.090000004	1981	9999	9999	0.029999999	6	9999	9999	0	9999	25.4	1965	9999	9999	\N	\N	\N	18.299999	\N	\N	\N	0.80000001	9999	23	2004-02-07	2004-02-06	\N	9999	2	1050	0
11160	11	5	51.099998	9999	\N	\N	\N	28.799999	6	2007-11-23	\N	\N	40	9999	9999	9999	9999	9999	9999	2.3399999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	752	0
16350	2	7	9999	78	1896-02-26	\N	\N	9999	-32	1884-01-05	\N	\N	24.4	34.299999	14.4	9999	9999	9999	9999	2.53	9999	9999	9999	9999	9999	9999	9999	9999	0.83999997	9999	9999	9999	9999	9999	9999	9999	0	-3168	5881-10-07	5881-10-07	5881-10-07	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	3622	0
16230	11	7	\N	103	1913-09-06	\N	\N	\N	-15	1964-11-30	\N	\N	50.2183	62.032299	38.404301	\N	\N	\N	\N	5.0599999	\N	\N	\N	\N	\N	\N	\N	\N	1.6866699	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1414	67
16173	2	7	\N	67	2003-01-08	2002-02-23	2002-01-26	\N	-14	2007-01-16	2005-01-15	\N	9999	9999	9999	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	9999	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9999	-9999
13830	2	7	\N	79	1896-02-26	\N	\N	\N	-33	1974-01-12	\N	\N	24.440901	35.362099	13.5196	\N	\N	\N	\N	2.1400001	\N	\N	\N	\N	\N	\N	\N	\N	0.71333301	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3651	0
11160	11	7	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	6	2007-11-23	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	0	5024	5881-10-07	5881-10-07	5881-10-07	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	1144	144
19860	11	7	9999	9999	\N	\N	\N	9999	6	2006-11-30	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1322	83
13830	2	5	37.900002	79	1896-02-26	\N	\N	15.1	-26	1905-02-13	1899-02-11	\N	28.299999	39.299999	17.200001	0	11	26	4	0.66000003	3.47	1951	9999	9999	0	1897	9999	9999	0.0235714	5	9999	9999	0	5	26.1	1965	9999	9999	\N	\N	\N	7.6999998	\N	\N	\N	0.69999999	9999	18	2004-02-06	\N	\N	3.8	1.7	1043	0
16230	2	5	34.700001	76	2002-02-23	\N	\N	14.1	-35	1905-02-02	1899-02-11	\N	26.4	37.299999	15.5	0	12	27	5	0.75999999	3.1800001	1971	9999	9999	0.039999999	1949	9999	9999	0.027142899	6	9999	9999	0	5.5	23	1936	9999	9999	\N	\N	\N	9999	\N	\N	\N	0.80000001	9999	19	1969-02-21	\N	\N	4.5	1.9	1096	0
19860	2	7	9999	9999	\N	\N	\N	9999	-20	2008-01-24	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	3753	0
11160	2	5	41.700001	9999	\N	\N	\N	18.700001	-6	2007-02-16	\N	\N	30.200001	9999	9999	9999	9999	9999	9999	0.94999999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	974	0
19860	2	5	36.200001	9999	\N	\N	\N	16.200001	-10	2008-02-20	2007-02-14	2007-02-04	26.200001	9999	9999	9999	9999	9999	9999	0.70999998	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1086	0
16350	5	7	9999	103	1934-05-30	\N	\N	9999	-16	1948-03-11	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	0	-3168	5881-10-07	5881-10-07	5881-10-07	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	1380	75
16350	12	9	9999	114	1936-07-25	\N	\N	9999	-32	1884-01-05	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	48.919998	1883	9999	9999	14.9	1934	9999	9999	9999	9999	9999	9999	9999	9999	74.199997	1983	9999	9999	1965-02-11	\N	\N	18.299999	1965-02-12	\N	\N	9999	9999	27	1960-03-16	\N	\N	9999	9999	-9999	-9999
16173	5	7	\N	94	2002-05-31	2002-05-30	\N	\N	-1	2009-03-01	2008-03-07	2008-03-07	9999	9999	9999	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	9999	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	-9999	-9999
16350	3	5	49.400002	91	1907-03-25	\N	\N	27.700001	-16	1948-03-11	\N	\N	39.299999	50.400002	28.1	0	4	21	0	2.1300001	5.96	1973	9999	9999	-1	1910	9999	9999	0.068709701	9	9999	9999	1	4.5	29.200001	1912	9999	9999	\N	\N	\N	13	\N	\N	\N	2	9999	27	1960-03-16	\N	\N	2.7	1.3	805	1
16173	3	5	9999	82	2003-03-15	\N	\N	9999	-1	2009-03-01	2008-03-07	2000-01-01	38.799999	49.200001	28.299999	9999	9999	9999	9999	2.1300001	5.04	2006	9999	9999	0.62	2009	9999	9999	0.07	9999	9999	9999	9999	9999	13.5	2006	9999	9999	2007-03-01	\N	\N	12	2007-03-01	\N	\N	9999	9999	12	2007-03-03	2007-03-02	\N	9999	9999	813	0
13830	3	5	50.299999	91	1907-03-25	\N	\N	27.200001	-19	1978-03-04	1948-03-11	\N	39.400002	51.200001	27.5	0	3	21	1	2.21	6.6500001	1973	9999	9999	0.059999999	1994	9999	9999	0.071290322	8	9999	9999	1	4.6999998	21.299999	1912	9999	9999	\N	\N	\N	12.7	\N	\N	\N	2.0999999	9999	20	1960-03-15	1960-03-16	\N	2.9000001	1.5	799	1
16230	3	5	46.299999	92	1910-03-22	\N	\N	25	-20	1960-03-04	\N	\N	37	48.5	25.4	0	5	24	1	1.97	7.27	1987	9999	9999	-1	1910	9999	9999	0.063548401	8	9999	9999	0	5.5999999	20.799999	1960	9999	9999	\N	\N	\N	9999	\N	\N	\N	1.9	9999	28	1960-03-16	1960-03-17	\N	4.3000002	1.8	872	0
11160	3	5	53.599998	9999	\N	\N	\N	28.6	2	2009-03-01	\N	\N	41.099998	9999	9999	9999	9999	9999	9999	2.45	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	740	0
19860	3	5	48.5	9999	\N	\N	\N	26.799999	-3	2009-03-02	2009-03-01	1948-03-11	37.700001	9999	9999	9999	9999	9999	9999	2.22	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	847	0
16173	12	9	\N	101	2002-07-21	2002-07-20	\N	\N	-14	2007-01-16	2005-01-15	\N	9999	9999	9999	\N	\N	\N	\N	9999	42.599998	2007	9999	9999	25.309999	2003	9999	9999	9999	\N	\N	\N	\N	9999	47.900002	2007	9999	9999	\N	\N	\N	12	\N	\N	\N	\N	\N	12	2007-03-03	2007-03-02	\N	\N	\N	-9999	-9999
13830	5	7	\N	104	1934-05-30	\N	\N	\N	-19	1978-03-04	1948-03-11	\N	50.487598	62.9753	38	\N	\N	\N	\N	8.75	\N	\N	\N	\N	\N	\N	\N	\N	2.9166701	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1378	72
13830	12	9	9999	115	1936-07-25	\N	\N	9999	-33	1974-01-12	\N	\N	50.700001	62.5	38.799999	9999	9999	9999	9999	28.26	42.169998	1951	9999	9999	14.81	1890	9999	9999	7.0700002	9999	9999	9999	9999	9999	55.200001	1983	9999	9999	1965-02-11	\N	\N	19	1965-02-12	\N	\N	9999	9999	21	1965-02-12	2001-02-10	\N	9999	9999	6278	1134
16230	5	7	\N	106	1934-05-29	\N	\N	\N	-20	1960-03-04	\N	\N	48.617699	60.171001	37.064499	\N	\N	\N	\N	7.8299999	\N	\N	\N	\N	\N	\N	\N	\N	2.6099999	\N	\N	\N	\N	9999	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1550	56
16230	12	9	9999	116	1936-07-17	\N	\N	9999	-39	1912-01-12	\N	\N	48.400002	59.700001	37.099998	9999	9999	9999	9999	25.15	37.810001	2007	9999	9999	15.81	1955	9999	9999	6.29	9999	9999	9999	9999	9999	63.799999	1983	9999	9999	1984-02-18	\N	\N	19	1984-02-19	\N	\N	9999	9999	28	1960-03-17	1960-03-16	2007-12-12	9999	9999	6873	877
11160	5	7	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	2	2009-03-01	\N	\N	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	0	5024	5881-10-07	5881-10-07	5881-10-07	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	9999	5881-10-07	5881-10-07	5881-10-07	9999	9999	1250	108
19860	5	7	9999	9999	\N	\N	\N	9999	-3	2009-03-02	2009-03-01	2009-03-01	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	9999	\N	\N	\N	9999	\N	\N	\N	9999	9999	9999	\N	\N	\N	9999	9999	1459	82
\.

