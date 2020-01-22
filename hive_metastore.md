---

copyright:
  year:  2020
lastupdated: "2020-01-22"

keywords: hive metastore,  performance, create table, object storage

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}


# Catalog Data – Hive Metastore
{: #hivemetastore}

Using {{site.data.keyword.cos_short}} URIs within your select statement allows you to process your data without any preparation steps. An automatic schema inference for JSON or CSV data is done in this case. Also, the partitions of the table are detected automatically during runtime of the query.  

But in case you know always your used objects in the select statement beforehand it is more efficient to catalog your COS objects. SQL Query provides a Hive Metastore with an own database for each instance which allows you to have all metadata for your tables in one place. 

To use the catalog you need to call the *CREATE TABLE* command before you run the select statement like:

```sql
create table employees (
  employeeID int,
  lastName string,
  firstName string,
  title string,
  titleOfCourtesy string,
  birthDate timestamp,
  hireDate timestamp,
  address string,
  city string,
  region string,
  postalCode string,
  country string,
  homePhone string,
  extension int,
  photo string,
  notes string,
  reportsTo string,
  photoPath string
)
USING CSV
OPTIONS (header='true')
partitioned by (city)
location cos://us-south/mycsv/employees.csv
```

In case you work with a partitioned table it is required to define the partitions used for this table. The easiest way is to let Hive evaluate this for you by calling *ALTER TABLE*.

```sql
ALTER TABLE employees RECOVER PARTITIONS
```

Having done this a quite select statement could be called without the lengthy COS URI.
```
SELECT firstName, lastName FROM employees WHERE city = ‘London’
```

In addition, that the query is more readable, and you have a central point where all your tables are cataloged, you get some further benefits: 
•	First there is no need to do schema inference any longer, as the schema was already specified during *CREATE TABLE* command. This will provide a better performance for JSON and CSV formats. 
•	Furthermore, the partitions lookup, needed for partitioned tables, is not needed anymore. This helps to speed up the query if there are many different partitions available.

The command *SHOW TABLES* provide you an overview of the existing tables in your instance. This command provides search filters to not get too much tables back.

```sql
SHOW TABLES LIKE '*empl*'
```

To get some more information about the definition of the table the command *DESCRIBE TABLE* will provide this. 

```sql
DESCRIBE TABLE employees
```

Finally, to clean up catalog entries for data not used anymore call DROP TABLE. This command only drops the definition but will not remove the real data on COS.

```sql
DROP TABLE employees
```
