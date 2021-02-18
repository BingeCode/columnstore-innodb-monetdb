# columnstore-innodb-monetdb

## Comparing performance, ease of installation and ease of use

## Semester assignment

The following work was done as part of a university assignment with the following goals:

- Compare MariaDB ColumnStore, InnoDB and MonetDB in terms of performance
- Check ease of installation
- Check ease of use (how easy are queries to execute?)
- Powerfulness of the language (which applications are particularly well supported?)
- How can certain queries be executed particularly fast?
- Short summary of the above questions in word document (incl. source code)

## Performance

The following timings were taken on Windows 10 running a virtual machine via VMWare Workstation 16 running CentOS 8 with 4 CPU cores (Intel i7 9700K), 8GB DDR4 RAM as well as 50GB fixed storage (Samsung 970 EVO NVMe M.2).

### CSV Import timings

| DBMS        | 36M records | 5.6M records | 500K records | Method                                                                                                            |
| ----------- | ----------- | ------------ | ------------ | ----------------------------------------------------------------------------------------------------------------- |
| Columnstore | 00m 17s     |              |              | [Columnstore cpimport](https://mariadb.com/docs/solutions/columnstore/load-columnstore-data/#cpimport)            |
| MonetDB     | 01m 07s     |              |              | [MonetDB CSV Bulk Loads](https://www.monetdb.org/Documentation/ServerAdministration/LoadingBulkData/CSVBulkLoads) |
| InnoDB      | 16m 40s     |              |              | [LOAD DATA INFILE](https://mariadb.com/kb/en/importing-data-into-mariadb/)                                        |

### Query timings

| Query statement                                          | MonetDB | Columnstore | InnoDB |
| -------------------------------------------------------- | ------- | ----------- | ------ |
| select \* from <table> where <column> = <value> limit 10 | 0.06s   | 0.1s        | 0.02s  |

### Next section

The [On-Time : Reporting Carrier On-Time Performance](https://www.transtats.bts.gov/Fields.asp?gnoyr_VQ=FGJ) flight data from the U.S. Bureau of Transportation Statistics was used as the original data basis. The data had to be manually downloaded for each month as well as mutated and merged with a lot of effort to make it ready for SQL bulk imports. You can inspect and download the cleaned data here.
