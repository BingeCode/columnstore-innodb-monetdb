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

### Bulk imports

| DBMS        | Timing  | Method                                                                                                 |
| ----------- | ------- | ------------------------------------------------------------------------------------------------------ |
| Columnstore | 00m 17s | [Columnstore cpimport](https://mariadb.com/docs/solutions/columnstore/load-columnstore-data/#cpimport) |
| MonetDB     | 01m 07s | Bulk Loads                                                                                             |
| InnoDB      | 16m 40s |

The [On-Time : Reporting Carrier On-Time Performance](https://www.transtats.bts.gov/Fields.asp?gnoyr_VQ=FGJ) flight data from the U.S. Bureau of Transportation Statistics was used as the original data basis. The data had to be manually downloaded for each month as well as mutated and merged with a lot of effort to make it ready for SQL bulk imports. You can inspect and download the cleaned data here.
