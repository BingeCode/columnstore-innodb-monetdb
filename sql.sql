-- YEAR, MONTH, DAY_OF_MONTH, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, DEP_DELAY_NEW, ARR_DELAY_NEW, DISTANCE
-- sudo cpimport -s ',' flights flights flights.csv
-- sudo mariadb flights
-- DELETE FROM flights
-----------------------------------------------------------
-- Aggregation
-----------------------------------------------------------
-- Flug mit der größten Verspätung
select ORIGIN_CITY_NAME as Herkunft, DEST_CITY_NAME as Zielort, DEP_DELAY_NEW as Verspaetung from flights order by Verspaetung desc limit 10;

-- Flug mit der größten Entfernung
select ORIGIN_CITY_NAME as Herkunft, DEST_CITY_NAME as Zielort, DISTANCE as Distanz from flights GROUP BY ORIGIN_CITY_NAME, DEST_CITY_NAME order by DISTANCE desc limit 10;

-- Tag mit den meisten Flügen
select Count(*) as Fluege, DAY_OF_MONTH from flights group by DAY_OF_MONTH order by Fluege desc limit 10;

-- Herkunft mit den meisten Flügen
select Count(*) as Fluege, ORIGIN_CITY_NAME as Herkunft from flights group by ORIGIN_CITY_NAME order by Fluege desc limit 10;

-- Zielort mit den meisten Flügen (fast das gleiche Ergebnis wie bei der vorherigen Abfrage, da die ankommenden Flugzeuge zurückkehren müssen)
select Count(*) as Fluege, DEST_CITY_NAME as Zielort from flights group by DEST_CITY_NAME order by Fluege desc limit 10;

-- Bundesstaat mit den meisten Flügen
select Count(*) as Fluege, ORIGIN_STATE_ABR as Bundesstaat from flights group by ORIGIN_STATE_ABR order by Fluege desc limit 10;