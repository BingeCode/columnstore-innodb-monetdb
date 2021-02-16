-----------------------------------------------------------
-- Aggregation Queries
-----------------------------------------------------------
-- TOP 10 Flights with the biggest delay in h
select ORIGIN_CITY_NAME as ORIGIN_CITY, ORIGIN_STATE_ABR as ORIGIN_STATE, DEST_CITY_NAME as DESTINATION_CITY, DEST_STATE_ABR as DESTINATION_STATE, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from flights order by DELAY_IN_HOURS desc limit 10;

-- TOP 10 Flights with the largest distance
select ORIGIN_CITY_NAME as ORIGIN, DEST_CITY_NAME as DESTINATION, DISTANCE as Distance from flights GROUP BY ORIGIN, DESTINATION order by Distance desc limit 10;

-- Days of the month with traffic
select DAY_OF_MONTH, Count(*) as NO_FLIGHTS from flights group by DAY_OF_MONTH order by DAY_OF_MONTH asc;

-- Days of the week with traffic
select DAY_OF_WEEK, Count(*) as NO_FLIGHTS from flights group by DAY_OF_WEEK order by DAY_OF_WEEK asc;

-- TOP 10 Cities with most traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from flights group by CITY, 'STATE' order by NO_FLIGHTS desc limit 10;

-- TOP 10 Cities with least traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from flights group by CITY, 'STATE' order by NO_FLIGHTS asc limit 10;

-- TOP 10 States with most traffic
select ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from flights group by 'STATE' order by NO_FLIGHTS desc limit 10;

-- TOP 10 States with least traffic
select ORIGIN_STATE_ABR as 'STATE', Count(*) as NO_FLIGHTS from flights group by 'STATE' order by NO_FLIGHTS asc limit 10;

-- Bundesstaat mit den meisten innerstaatlichen Flügen
select ORIGIN_STATE_ABR as 'STATE', COUNT(*) as NO_FLIGHTS from flights where ORIGIN_STATE_ABR = DEST_STATE_ABR group by ORIGIN_STATE_ABR order by NO_FLIGHTS desc limit 10;

-- Percentage of total flights in state by city with most traffic for each TOP 10 state.
with 

