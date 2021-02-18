# Open Terminal

# Creates the monetdb daemon / server
monetdbd create /root/monetdb/
monetdbd start /root/monetdb/

# Creates database flights
monetdb create flights
monetdb release flights

# Connects to database
# password = monetdb
mclient -u monetdb -d flights --timer=clock

-- Create table for flights.csv
DROP TABLE IF EXISTS monetdb;

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

-- Importing flights.csv into monetdb
COPY 
INTO monetdb(YEAR_, MONTH_, DAY_OF_MONTH, DAY_OF_WEEK, OP_UNIQUE_CARRIER, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, CRS_DEP_TIME, DEP_DELAY_NEW, CRS_ARR_TIME, ARR_DELAY_NEW, CANCELLED, CANCELLATION_CODE, AIR_TIME, DISTANCE) 
FROM '/root/flights.csv' 
USING DELIMITERS ',', '\n';
