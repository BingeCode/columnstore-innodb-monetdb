CREATE DATABASE IF NOT EXISTS test1;

use test1;

-- CREATE TABLE flights_innodb (
	
-- ) ENGINE=Columnstore DEFAULT CHARSET=utf8;

CREATE TABLE flights_innodb (
   Year SMALLINT NOT NULL,
   Month TINYINT NOT NULL,
   Day TINYINT NOT NULL,
   Day_of_week TINYINT NOT NULL,
   Origin_City varchar(30) NOT NULL, 
   Origin_State varchar(30) NOT NULL, 
   Destination_City varchar(30) NOT NULL, 
   Destination_State varchar(30) NOT NULL, 
   Departure_Time TIME,
   Departure_Delay SMALLINT DEFAULT 0,
   Arrival_Time TIME,
   Arrival_Delay SMALLINT DEFAULT 0,
   Cancelled BOOLEAN NOT NULL DEFAULT FALSE,
   Air_Time SMALLINT
);

INSERT INTO flights_innodb VALUES (2020,1,1,3,"Ontario, CA","CA","San Francisco, CA","CA","1851",41.00,"2053",68.00,0.00,74.00)
INSERT INTO flights_innodb VALUES (2020,1,1,3,"Ontario, CA",CA,"San Francisco, CA",CA,1851.0,41.0,2053.0,68.0,0.0,74.0)