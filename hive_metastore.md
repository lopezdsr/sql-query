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

{{site.data.keyword.sqlquery_full}} includes a full database catalog that you can use to register and manage table definitions for your data on {{site.data.keyword.cos_full}}. Each instance of {{site.data.keyword.sqlquery_full}} has its own database catalog namespace. In a fresh instance this catalog is empty and it is up to you to register table definitions in there.

## Benefits

When you have data on {{site.data.keyword.cos_full}} without an according table definition in the catalog yet you can query it by specifying the location and format of the data using {{site.data.keyword.cos_full}} URIs directly within your SELECT statements. This way you can explore fresh, changed and unknown data because all the required metadata is dynamically discovered as part of the SQL compilation process. This inferred meta data comprises column names, data types as well as the list of partitions and individual objects on {{site.data.keyword.cos_short}} that make up the overall table data.

Once the data is very well known to you, in particular the schema and partition structure, it imposes an unecessary overhead and latency for each query to infer all this information from the data with each and every query execution. Especially for text formats like CSV and JSON and also when you have thousands of objects in different partitions of the table, this inferrence process can make up a large part and sometimes the larger part of the query execution time.

In addition it is often beneficial if the SQL authors do not have to understand the exact location and format of data on {{site.data.keyword.cos_short}}. Only a data engineer should be concerned about this and "publish" registered tables with table names to SQL authors to use. This way you can also easily switch a table definition from  one location to another without the application or the SQL users to have to change anything.

## Usage

The database catalog in {{site.data.keyword.sqlquery_full}} is a Hive Metastore. You manage the catalog content via Database Definition Language (DDL) commands that you can submit just like any other SQL query statement.

Note: No data is written to {{site.data.keyword.cos_short}} when you create  or change table definitions, and no data is deleted from {{site.data.keyword.cos_short}} when you drop a table definition.

To register a new table in the catalog, call the *CREATE TABLE* command, as in the following example:

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
location cos://us-south/mycsv/employees
```

You can now proceed and query the table by name instead of specifying the {{site.data.keyword.cos_short}}  URI directly in the SQL statement:

```sql
SELECT * FROM employees
```

## Partitioned Tables

You can manage a tables in the catalog that consist of multiple partitions on {{site.data.keyword.cos_short}}. The naming of the objects needs to adhere to the Hive-style partitioning naming convention. The object names need to include a folder name that has the structure `columm=value`, where `column` must be a column name that is specified in the CREATE TABLE. You can also have combined partition keys, which then need to be existing in the object names as hierachies of folder names like `columm1=value/column2=value`. Following is an example list of object names on {{site.data.keyword.cos_short}} that is consistent with hive-partitioned naming convention:

```
/employees/region=north/city=Hamburg/emp-1.csv
/employees/region=north/city=Hamburg/emp-2.csv
/employees/region=north/city=Kiel/emp-1.csv
/employees/region=north/city=Rostock/emp-1.csv
/employees/region=north/city=Rostock/emp-2.csv
/employees/region=east/city=Berlin/emp-1.csv
/employees/region=east/city=Berlin/emp-2.csv
/employees/region=east/city=Berlin/emp-3.csv
/employees/region=east/city=Leipzig/emp-1.csv
/employees/region=south/city=Munich/emp-1.csv
/employees/region=south/city=Munich/emp-2.csv
/employees/region=south/city=Munich/emp-3.csv
```

With such a list of objects you can specify a partitioned table definition like in the following example:

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
PARTITIONED BY (region, city)
location cos://us-south/mycsv/employees
```

If your data on {{site.data.keyword.cos_short}} does not adhere to this naming convention and you still would like to build a partitioned table for it, then one way to produce hive-partitioned layout is to use SQL Query in a data preparation step and specify [PARTITION BY](https://cloud.ibm.com/docs/services/sql-query?topic=sql-query-sql-reference#partitionedClause) in the INTO clause.

When a partitioned table has been defined you always need to add each partition to it explicitly. You can do this one by one by running `ALTER TABLE` with the `ADD PARTITION` clause for a new partition.

A convenient way to add all partitions that already exist at once on {{site.data.keyword.cos_short}} is to use the `RECOVER PARTITIONS` clause like follows.

```sql
ALTER TABLE employees RECOVER PARTITIONS
```

Your partitioned table is now set up to be queried. When you submit a the following SELECT

```sql
SELECT firstName, lastName FROM employees WHERE city = Berlin
```

you will get returned all the Berlin employes first and last names. The query execution did in fact only read the three objects inside the `/employees/region=east/city=Berlin/` folder because the partition definitions were used by the query optimizer to minimize the necessary read I/O accordingly.

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
