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

Using {{site.data.keyword.cos_full}} URIs within your SELECT statements allows you to process data without any preparation steps. You benefit from an automatic schema inference for JSON or CSV data. Also, the partitions of the table are detected automatically during runtime of the query.  

But if you always know your used objects in the SELECT statement beforehand, it is more efficient to catalog your {{site.data.keyword.cos_short}} objects. {{site.data.keyword.sqlquery_full}} provides a Hive Metastore with an own database for each instance, which allows you to have all metadata for your tables in one place. 

To use the catalog, call the *CREATE TABLE* command before you run the SELECT statement, as in the following example:

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

If you work with a partitioned table, it is required to define the partitions used for this table. The easiest way to do this is to let Hive evaluate it for you by calling *ALTER TABLE*.

```sql
ALTER TABLE employees RECOVER PARTITIONS
```

Having done this a quite SELECT statement could be called without the lengthy {{site.data.keyword.cos_short}} URI.

```
SELECT firstName, lastName FROM employees WHERE city = ‘London’
```

In addition to the query being more readable and having a central point where all your tables are cataloged, you get some further benefits: 
-	First, there is no need to do schema inference any longer, as the schema was already specified in the *CREATE TABLE* command. This  provides a better performance for JSON and CSV formats. 
-	Second, the partitions lookup, needed for partitioned tables, is not needed anymore. This helps to speed up the query if there are many different partitions available.

The command *SHOW TABLES* provides you with an overview of the existing tables in your instance. This command provides search filters to avoid getting too many tables back.

```sql
SHOW TABLES LIKE '*empl*'
```

To get some more information about the definition of the table, use the command *DESCRIBE TABLE*. 

```sql
DESCRIBE TABLE employees
```

Finally, to clean up catalog entries for unused data, call *DROP TABLE*. The *DROP TABLE* command drops the definition without removing the real data on {{site.data.keyword.cos_short}}.

```sql
DROP TABLE employees
```
