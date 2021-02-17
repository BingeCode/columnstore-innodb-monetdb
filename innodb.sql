-- Open Terminal

sudo mariadb

CREATE DATABASE IF NOT EXISTS flights;

use flights;

DROP TABLE IF EXISTS innodb;

CREATE TABLE innodb (
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
) DEFAULT CHARSET=utf8;

show tables;

-- Import CSV
LOAD DATA LOCAL INFILE '/root/flights.csv' INTO TABLE innodb 
   FIELDS TERMINATED BY ',' 
   LINES TERMINATED BY '\r\n'
   (YEAR_, MONTH_, DAY_OF_MONTH, DAY_OF_WEEK, OP_UNIQUE_CARRIER, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, CRS_DEP_TIME, DEP_DELAY_NEW, CRS_ARR_TIME, ARR_DELAY_NEW, CANCELLED, CANCELLATION_CODE, AIR_TIME, DISTANCE);

-----------------------------------------------------------
-- Queries
-----------------------------------------------------------
-- TOP 10 Flights with the biggest delay in h
select ORIGIN_CITY_NAME as ORIGIN_CITY, ORIGIN_STATE_ABR as ORIGIN_STATE, DEST_CITY_NAME as DESTINATION_CITY, DEST_STATE_ABR as DESTINATION_STATE, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from innodb order by DELAY_IN_HOURS desc limit 10;

-- TOP 10 Flights with the largest distance
select ORIGIN_CITY_NAME as ORIGIN, DEST_CITY_NAME as DESTINATION, DISTANCE as Distance from innodb GROUP BY ORIGIN, DESTINATION order by Distance desc limit 10;

-- Days of the month with traffic
select DAY_OF_MONTH, Count(*) as NO_FLIGHTS from innodb group by DAY_OF_MONTH order by DAY_OF_MONTH asc;

-- Days of the week with traffic
select DAY_OF_WEEK, Count(*) as NO_FLIGHTS from innodb group by DAY_OF_WEEK order by DAY_OF_WEEK asc;

-- TOP 10 Cities with most traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from innodb group by CITY, 'STATE' order by NO_FLIGHTS desc limit 10;

-- TOP 10 Cities with least traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from innodb group by CITY, 'STATE' order by NO_FLIGHTS asc limit 10;

-- TOP 10 States with most traffic
select ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from innodb group by 'STATE' order by NO_FLIGHTS desc limit 10;

-- TOP 10 States with least traffic
select ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from innodb group by 'STATE' order by NO_FLIGHTS asc limit 10;

-- TOP 10 States with most innerstate flights
select ORIGIN_STATE_ABR as 'STATE', COUNT(*) as NO_FLIGHTS from innodb where ORIGIN_STATE_ABR = DEST_STATE_ABR group by ORIGIN_STATE_ABR order by NO_FLIGHTS desc limit 10;
