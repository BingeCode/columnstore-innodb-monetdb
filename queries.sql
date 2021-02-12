CREATE DATABASE IF NOT EXISTS flights_database;

use flights_database;

CREATE TABLE flights (
	YEAR SMALLINT NOT NULL,
   MONTH TINYINT NOT NULL,
   DAY_OF_MONTH TINYINT NOT NULL,
   DAY_OF_WEEK TINYINT NOT NULL,
   ORIGIN_CITY_NAME varchar(30) NOT NULL, 
   ORIGIN_STATE_ABR varchar(30) NOT NULL, 
   DEST_CITY_NAME varchar(30) NOT NULL, 
   DEST_STATE_ABR varchar(30) NOT NULL, 
   DEP_TIME TIME,
   DEP_DELAY_NEW SMALLINT DEFAULT 0,
   ARR_TIME TIME,
   ARR_DELAY_NEW SMALLINT DEFAULT 0,
   CANCELLED BOOLEAN NOT NULL DEFAULT FALSE,
   AIR_TIME SMALLINT
) ENGINE=Columnstore DEFAULT CHARSET=utf8;

show databases;

show tables;

-- sudo cpimport -s ',' <DATABASE> <TABLE> <FILENAME.csv>
-- sudo mariadb <DATABASE>

-----------------------------------------------------------
-- Aggregation Queries
-----------------------------------------------------------
-- TOP 10 Flights with the biggest delay in h
select ORIGIN_CITY_NAME as ORIGIN, DEST_CITY_NAME as DESTINATION, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from flights order by DELAY_IN_HOURS desc limit 10;

-- TOP 10 Flights with the largest distance
select ORIGIN_CITY_NAME as ORIGIN, DEST_CITY_NAME as DESTINATION, DISTANCE as Distance from flights GROUP BY ORIGIN, DESTINATION order by Distance desc limit 10;

-- Days of the month sorted by most flights
select Count(*) as NO_OF_FLIGHTS, DAY_OF_MONTH from flights group by DAY_OF_MONTH order by NO_OF_FLIGHTS desc;

-- TOP 10 Airports by traffic
select Count(*) as NO_OF_FLIGHTS, ORIGIN_CITY_NAME as Origin from flights group by Origin order by NO_OF_FLIGHTS desc limit 10;

-- Bundesstaat mit den meisten Flügen
select Count(*) as NO_OF_FLIGHTS, ORIGIN_STATE_ABR as 'STATE' from flights group by 'STATE' order by NO_OF_FLIGHTS desc limit 10;