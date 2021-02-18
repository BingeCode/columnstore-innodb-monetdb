# columnstore-innodb-monetdb

This project was part of a university assignment with the following goals:

- Compare MariaDB ColumnStore, InnoDB and MonetDB in terms of performance
- Check ease of installation
- Check ease of use (how easy are queries to execute?)
- Powerfulness of the language (which applications are particularly well supported?)
- How can certain queries be executed particularly fast?
- Extended summary of the above questions in word document (incl. source code)

Of the above, only the performance timings are included in this README - for the other topics please refer to the Word document (available in English and German).

The [flight data from the U.S. Bureau of Transportation Statistics](https://www.transtats.bts.gov/Fields.asp?gnoyr_VQ=FGJ) was used as the original data basis.

For this project it had to be manually downloaded for each month as well as cleaned and merged using custom python code (see `./Python code`).

All necessary SQL commands to connect to the DBMS, create a table, import the data and run the queries can be found in the folder `./SQL code`.

The cleaned data has been uploaded on [Kaggle](https://www.kaggle.com/bingecode/us-national-flight-data-2015-2020). Its size is 2.7GB uncompressed / 377MB compressed.

Also take a look at the sources used throughout this project in `./sources.md`.

## Performance

The following timings were taken on Windows 10 running a virtual machine via VMWare Workstation 16 running CentOS 8 with 4 CPU cores (Intel i7 9700K), 8GB DDR4 RAM as well as 50GB fixed storage (Samsung 970 EVO NVMe M.2).

### CSV Import timings

| Engine      | 36M records | 5.6M records | 500K records | Method                                                                                                            |
| ----------- | ----------- | ------------ | ------------ | ----------------------------------------------------------------------------------------------------------------- |
| Columnstore | 00m 17s     | 4.2s         | 1.1s         | [Columnstore cpimport](https://mariadb.com/docs/solutions/columnstore/load-columnstore-data/#cpimport)            |
| MonetDB     | 01m 07s     | 15s          | 1s           | [MonetDB CSV Bulk Loads](https://www.monetdb.org/Documentation/ServerAdministration/LoadingBulkData/CSVBulkLoads) |
| InnoDB      | 16m 40s     | 2m 37s       | 13s          | [LOAD DATA INFILE](https://mariadb.com/kb/en/importing-data-into-mariadb/)                                        |

### Query timings (warm)

All queries were performed multiple times in a row (except for InnoDB) to make most use of the caching strategies that the DBMS employ.

| Query statement                                                                                                                     | Description   | MonetDB | Columnstore | InnoDB |
| ----------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------- | ----------- | ------ |
| `select * from <table> where <column> = <value> limit 10;`                                                                          | select where  | 0.06s   | 0.1s        | 0.02s  |
| `select count(*) from <table> where <column> = <value>;`                                                                            | count where   | 0.04s   | 0.6s        | 0.02s  |
| `select count(*) from <table>;`                                                                                                     | simple count  | 0.003s  | 0.3s        | 5m 8s  |
| `select avg(DISTANCE) as AVERAGE from <table>`                                                                                      | aggregation   | 0.03s   | 0.6s        | 5m 38s |
| `select * from <table> where CRS_DEP_TIME > '10:00' and CRS_ARR_TIME < '15:00' and AIR_TIME > 300 order by AIR_TIME desc limit 10;` | complex where | 0.1s    | 0.8s        | 6m 6s  |
| `select <columns>, FLOOR(DEP_DELAY_NEW/60) as DELAY_IN_HOURS from <table> order by DELAY_IN_HOURS desc limit 10;`                   | TOP10 delayed | 0.3s    | 8s          | 6m 33s |

In this scenario (with the aforementioned hardware and dataset), MonetDB is the clear winner in terms of performance.

It remains to be tested though how it would fare in a more realistic scenario with proper DB server hardware and a large dataset (> 1TB).
From my research it sounds like Columnstore thrives more in large datasets. Refer to `./sources.md` for further reference.
