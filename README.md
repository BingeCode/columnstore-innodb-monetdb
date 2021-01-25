# ColumnStore vs InnoDB vs MonetDB

## Semesteraufgabe

- MariaDB ColumnStore, InnoDB und MonetDB hinsichtlich Performance vergleichen
- Einfachheit der Installation prüfen
- Einfachheit der Benutzung prüfen (wie leicht lassen sich Querys ausführen?)
- Mächtigkeit der Sprache (Welche Anwendungen werden besonders gut understützt?)
- Wie können bestimmte Anfragen besonders schnell ausgeführt werden?
- Kurzbeschreibung der o.g. Fragen insgesamt 10 Seiten (inkl. Source-Code)

Als Datengrundlage wurden [Flugdaten](https://www.transtats.bts.gov/DL_SelectFields.asp?Table_ID=236&DB_Short_Name=On-Time) des US-amerikanischen Amts für Verkehrsstatistik verwendet.

https://mariadb.com/kb/en/choosing-the-right-storage-engine/

https://db-engines.com/en/system/MariaDB%3bMonetDB

Die heruntergeladene CSV-Datei enthält dabei die folgenden Felder:

YEAR MONTH, DAY_OF_MONTH, DAY_OF_WEEK, ORIGIN_CITY_NAME, ORIGIN_STATE_ABR, DEST_CITY_NAME, DEST_STATE_ABR, DEP_TIME, DEP_DELAY_NEW, ARR_TIME, ARR_DELAY_NEW, CANCELLED, AIR_TIME

Anhand der Daten sind eine Reihe von Aggregations-Abfragen möglich, um die Performance der verschiedenen Datenbank-Engines

Aggregation Tasks:

- Day with most flights
- Origin with most flights
- Destination with most flights
- State with most traffic (in and out)
- Flight with the biggest delay
- Flight with the greatest distance
