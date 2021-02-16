monetdbd create /root/monetdb/
monetdbd start /root/monetdb/
monetdb create flights
monetdb release flights
# password = monetdb
mclient -u monetdb -d flights --timer=clock

CREATE TABLE monetdb (
   YEAR_ SMALLINT NOT NULL,
   MONTH_ TINYINT NOT NULL,
   DAY_OF_MONTH TINYINT NOT NULL,
   DAY_OF_WEEK TINYINT NOT NULL,
   OP_UNIQUE_CARRIER varchar(5) NOT NULL,
   ORIGIN_CITY_NAME varchar(30) NOT NULL, 
   ORIGIN_STATE_ABR varchar(30) NOT NULL, 
   DEST_CITY_NAME varchar(30) NOT NULL, 
   DEST_STATE_ABR varchar(30) NOT NULL, 
   CRS_DEP_TIME TIME,
   DEP_DELAY_NEW SMALLINT,
   CRS_ARR_TIME TIME,
   ARR_DELAY_NEW SMALLINT,
   CANCELLED BOOLEAN,
   CANCELLATION_CODE varchar(1),
   AIR_TIME SMALLINT,
   DISTANCE SMALLINT
);

-- show tables
SELECT name FROM sys.tables WHERE type IN (SELECT table_type_id FROM sys.table_types
           WHERE table_type_name LIKE '%TABLE' AND table_type_name <> 'SYSTEM TABLE')
   ORDER BY name;

-- Importing CSV file into monetdb table
COPY 
INTO monetdb(YEAR, MONTH, DAY_OF_MONTH, DAY_OF_WEEK, OP_UNIQUE_CARRIER, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, CRS_DEP_TIME, DEP_DELAY_NEW, CRS_ARR_TIME, ARR_DELAY_NEW, CANCELLED, CANCELLATION_CODE, AIR_TIME, DISTANCE) 
FROM '/root/flights.csv' 
USING DELIMITERS ',', '\n';

-----------------------------------------------------------
-- Queries
-----------------------------------------------------------
-- TOP 10 Flights with the biggest delay in h
select ORIGIN_CITY_NAME as ORIGIN_CITY, ORIGIN_STATE_ABR as ORIGIN_STATE, DEST_CITY_NAME as DESTINATION_CITY, DEST_STATE_ABR as DESTINATION_STATE, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from monetdb order by DELAY_IN_HOURS desc limit 10;

-- TOP 10 Flights with the largest distance
select ORIGIN_CITY_NAME as ORIGIN, DEST_CITY_NAME as DESTINATION, DISTANCE as Distance from monetdb GROUP BY ORIGIN, DESTINATION order by Distance desc limit 10;

-- Days of the month with traffic
select DAY_OF_MONTH, Count(*) as NO_FLIGHTS from monetdb group by DAY_OF_MONTH order by DAY_OF_MONTH asc;

-- Days of the week with traffic
select DAY_OF_WEEK, Count(*) as NO_FLIGHTS from monetdb group by DAY_OF_WEEK order by DAY_OF_WEEK asc;

-- TOP 10 Cities with most traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from monetdb group by CITY, 'STATE' order by NO_FLIGHTS desc limit 10;

-- TOP 10 Cities with least traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from monetdb group by CITY, 'STATE' order by NO_FLIGHTS asc limit 10;

-- TOP 10 States with most traffic
select ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from monetdb group by 'STATE' order by NO_FLIGHTS desc limit 10;

-- TOP 10 States with least traffic
select ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from monetdb group by 'STATE' order by NO_FLIGHTS asc limit 10;

-- TOP 10 States with most innerstate flights
select ORIGIN_STATE_ABR as 'STATE', COUNT(*) as NO_FLIGHTS from monetdb where ORIGIN_STATE_ABR = DEST_STATE_ABR group by ORIGIN_STATE_ABR order by NO_FLIGHTS desc limit 10;
