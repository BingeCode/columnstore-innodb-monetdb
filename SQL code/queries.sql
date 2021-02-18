drop table if exists cancellation_codes;

create table cancellation_codes (
    CODE varchar(1) PRIMARY KEY,
    DESCR varchar(50) NOT NULL
);

insert into cancellation_codes values('A', 'Carrier');
insert into cancellation_codes values('B', 'Weather');
insert into cancellation_codes values('C', 'National Air System');
insert into cancellation_codes values('D', 'Security');

create view avg_flight_distance as (
    select avg(DISTANCE) as AVERAGE from columnstore
);

-----------------------------------------------------------
-- Queries
-----------------------------------------------------------
-- Simple select
select * from monetdb where OP_UNIQUE_CARRIER = 'AA' limit 10; --0.06s
select * from columnstore where OP_UNIQUE_CARRIER = 'AA' limit 10; --0.1s
select * from innodb where OP_UNIQUE_CARRIER = 'AA' limit 10; -- 0.02s

-- Count where
select count(*) from monetdb where OP_UNIQUE_CARRIER = 'AA'; --0.04s
select count(*) from columnstore where OP_UNIQUE_CARRIER = 'AA'; --0.6s
select count(*) from innodb where OP_UNIQUE_CARRIER = 'AA'; -- 0.02s

-- Simple count
select count(*) from monetdb; -- 3ms
select count(*) from columnstore; -- 300ms
select count(*) from innodb; --5m 8s

-- Aggregate
select avg(DISTANCE) as AVERAGE from monetdb; --0.03s
select avg(DISTANCE) as AVERAGE from columnstore; --0.6s
select avg(DISTANCE) as AVERAGE from innodb;  --5m 38s

-- Select complex where
select * from monetdb where CRS_DEP_TIME > '10:00' and CRS_ARR_TIME < '15:00' and AIR_TIME > 300 order by AIR_TIME desc limit 10; --100ms
select * from columnstore where CRS_DEP_TIME > '10:00' and CRS_ARR_TIME < '15:00' and AIR_TIME > 300 order by AIR_TIME desc limit 10; --800ms
select * from innodb where CRS_DEP_TIME > '10:00' and CRS_ARR_TIME < '15:00' and AIR_TIME > 300 order by AIR_TIME desc limit 10; --6m 6s

-- TOP 10 Flights with the biggest delay in h
select YEAR_, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from monetdb order by DELAY_IN_HOURS desc limit 10; --0.3s
select YEAR_, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from columnstore order by DELAY_IN_HOURS desc limit 10; --8s
select YEAR_, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from innodb order by DELAY_IN_HOURS desc limit 10; --6m 33s



-- Count 
select DAY_OF_MONTH, count(*) as NUMBER_FLIGHTS from monetdb group by DAY_OF_MONTH order by DAY_OF_MONTH asc; --0.1s
select DAY_OF_MONTH, count(*) as NUMBER_FLIGHTS from columnstore group by DAY_OF_MONTH order by DAY_OF_MONTH asc; --0.7s
select DAY_OF_MONTH, count(*) as NUMBER_FLIGHTS from innodb group by DAY_OF_MONTH order by DAY_OF_MONTH asc; --5m 52s

-- TOP 10 Connections with the largest/shortest distance
select ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, DISTANCE from monetdb group by ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, DISTANCE order by DISTANCE desc limit 10;

-- Number of cancellations
select count(CANCELLATION_CODE) as COUNT_CANCELLATIONS, CANCELLATION_CODE, DESCR from monetdb join cancellation_codes on CANCELLATION_CODE = CODE where CANCELLATION_CODE is not null group by CANCELLATION_CODE, DESCR order by CANCELLATION_CODE;
select count(CANCELLATION_CODE) as COUNT_CANCELLATIONS, CANCELLATION_CODE, DESCR from columnstore join cancellation_codes on CANCELLATION_CODE = CODE where CANCELLATION_CODE <> 'N' group by CANCELLATION_CODE, DESCR order by CANCELLATION_CODE; -- ERROR

-- TOP 10 states by cancellations
select count(*) as COUNT_CANCELLATIONS, ORIGIN_STATE_ABR from monetdb where CANCELLATION_CODE is not null group by ORIGIN_STATE_ABR order by COUNT_CANCELLATIONS desc;
select count(*) as COUNT_CANCELLATIONS, ORIGIN_STATE_ABR from columnstore where CANCELLATION_CODE <> 'N' group by ORIGIN_STATE_ABR order by COUNT_CANCELLATIONS desc;

-- TOP 10 flights with most/least air time (in minutes)
select YEAR_, MONTH_, DAY_OF_MONTH, OP_UNIQUE_CARRIER, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, AIR_TIME from monetdb where AIR_TIME > 0 order by AIR_TIME desc limit 10;
select YEAR_, MONTH_, DAY_OF_MONTH, OP_UNIQUE_CARRIER, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, AIR_TIME from columnstore where AIR_TIME > 0 order by AIR_TIME desc limit 10;

-- Days of the week with traffic
select DAY_OF_WEEK, count(*) as NO_FLIGHTS from monetdb group by DAY_OF_WEEK order by DAY_OF_WEEK asc;

-- TOP 10 Cities with most/least traffic including percentage
with temp as (select count(*) as total_flights from monetdb)
    select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS, count(*)*100.0/total_flights as percentage_of_total_flights 
    from temp, monetdb group by CITY, STATE order by NO_FLIGHTS desc limit 10;

-- TOP 10 flights that are above average distance
with temp as (select avg(DISTANCE) as AVERAGE from monetdb)
select ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, DISTANCE, avg(DISTANCE) as AVERAGE from monetdb, temp where DISTANCE > AVERAGE order by DISTANCE asc limit 10;

select ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, DISTANCE, AVERAGE from columnstore, avg_flight_distance where DISTANCE > AVERAGE order by DISTANCE asc limit 10; --ERROR

-- TOP 100 Cities with most/least traffic
select ORIGIN_CITY_NAME as CITY, ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb group by CITY, STATE order by NO_FLIGHTS desc limit 100;

-- TOP 10 States with most/least traffic
select ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb group by STATE order by NO_FLIGHTS desc limit 10;

-- TOP 10 States with most/least innerstate flights
select ORIGIN_STATE_ABR as STATE, count(*) as NO_FLIGHTS from monetdb where ORIGIN_STATE_ABR = DEST_STATE_ABR group by ORIGIN_STATE_ABR order by NO_FLIGHTS desc limit 10;