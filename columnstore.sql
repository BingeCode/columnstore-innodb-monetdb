# Open Terminal

sudo mariadb

CREATE DATABASE IF NOT EXISTS flights;

use flights;

DROP TABLE IF EXISTS columnstore;

CREATE TABLE columnstore (
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
   CANCELLATION_CODE varchar(4),
   AIR_TIME SMALLINT,
   DISTANCE SMALLINT
) ENGINE=Columnstore DEFAULT CHARSET=utf8;

show tables;

exit;

# Import CSV
sudo cpimport -s ',' flights columnstore '/root/flights.csv'

sudo mariadb flights
