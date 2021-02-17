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

-----------------------------------------------------------
-- Queries
-----------------------------------------------------------
-- TOP 10 Flights with the biggest delay in h
select YEAR_, ORIGIN_CITY_NAME as ORIGIN_CITY, ORIGIN_STATE_ABR as ORIGIN_STATE, DEST_CITY_NAME as DESTINATION_CITY, DEST_STATE_ABR as DESTINATION_STATE, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from monetdb order by DELAY_IN_HOURS desc limit 10;

-- TOP 10 Flights with the largest distance
select ORIGIN_CITY_NAME as ORIGIN, DEST_CITY_NAME as DESTINATION, DISTANCE as DISTANCE from monetdb group by ORIGIN_CITY_NAME, DEST_CITY_NAME, DISTANCE order by DISTANCE desc limit 10;

-- Days of the month with traffic
select DAY_OF_MONTH, count(*) as NO_FLIGHTS from monetdb group by DAY_OF_MONTH order by DAY_OF_MONTH asc;

-- Days of the week with traffic
select DAY_OF_WEEK, count(*) as NO_FLIGHTS from monetdb group by DAY_OF_WEEK order by DAY_OF_WEEK asc;

with temp as (select count(*) as total_flights from monetdb)
    select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS, count(*)*100.0/total_flights as percentage_of_total_flights 
    from temp, monetdb group by CITY, STATE order by NO_FLIGHTS desc limit 10;

select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS, count(*)*100.0/(select count(*) from columnstore) as percentage_of_total_flights 
from columnstore group by CITY, STATE order by NO_FLIGHTS desc limit 10;

with temp as (select count(*) as total_flights from columnstore) select total_flights, ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as STATE
    from temp, columnstore group by city, state limit 10;



-- TOP 10 Cities with most traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb group by CITY, STATE order by NO_FLIGHTS desc limit 10;

-- TOP 10 Cities with least traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb group by CITY, STATE order by NO_FLIGHTS asc limit 10;

-- TOP 10 States with most traffic
select ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb group by STATE order by NO_FLIGHTS desc limit 10;

-- TOP 10 States with least traffic
select ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb group by STATE order by NO_FLIGHTS asc limit 10;

-- TOP 10 States with most innerstate flights
select ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb where ORIGIN_STATE_ABR = DEST_STATE_ABR group by ORIGIN_STATE_ABR order by NO_FLIGHTS desc limit 10;