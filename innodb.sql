-- Open Terminal

sudo mariadb

CREATE DATABASE IF NOT EXISTS flights;

use flights;

CREATE TABLE innodb (
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
) DEFAULT CHARSET=utf8;

show tables;

-- Import CSV
LOAD DATA LOCAL INFILE '/root/flights.csv' INTO TABLE innodb 
   FIELDS TERMINATED BY ',' 
   LINES TERMINATED BY '\r\n'
   (YEAR, MONTH, DAY_OF_MONTH, DAY_OF_WEEK, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, DEP_TIME, DEP_DELAY_NEW, ARR_TIME, ARR_DELAY_NEW, CANCELLED, AIR_TIME);

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
