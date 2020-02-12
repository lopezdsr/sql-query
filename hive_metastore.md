---

copyright:
  year:  2020
lastupdated: "2020-02-12"

keywords: hive metastore,  performance, create table, object storage

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}


# Catalog Management – Hive Metastore ![Beta](beta.png)
{: #hivemetastore}

Beta support for this feature was introduced in February, 2020.
{: note}

{{site.data.keyword.sqlquery_full}} includes a full database catalog that you can use to register and manage table definitions for your data on {{site.data.keyword.cos_full}}. 
Each instance of {{site.data.keyword.sqlquery_short}} has its own database catalog namespace. In a fresh instance this catalog is empty and it is up to you to register table definitions in there.

## Benefits

When you have data on {{site.data.keyword.cos_short}} without an according table definition in the catalog, you can query it by specifying the location and format of the data using {{site.data.keyword.cos_short}} URIs directly within your SELECT statements. This way you can explore new, changed, and unknown data because all the required metadata is dynamically discovered as part of the SQL compilation process. This inferred meta data comprises column names, data types, as well as the list of partitions and individual objects on {{site.data.keyword.cos_short}} that make up the overall table data.

Once you are familiar with the data, in particular with the schema and partition structure, it imposes an unnecessary overhead and latency for each query to infer all this information from the data with every query execution. Especially for text formats, such as CSV and JSON, and also when you have thousands of objects in different partitions of the table, this inference process can make up a large part and sometimes the largest part of the query execution time.

In addition, it is beneficial if the SQL authors do not have to understand the exact location and format of data on {{site.data.keyword.cos_short}}. Ideally, only data engineers should be concerned with it. They should then "publish" registered tables with table names to SQL authors to use. This way, you can also easily switch a table definition from one location to another without the application or the SQL users having to change anything.

## Usage

The database catalog in {{site.data.keyword.sqlquery_short}} is a Hive Metastore. You manage the catalog content via Database Definition Language (DDL) commands that you can submit just like any other SQL query statement.

Note: No data is written to {{site.data.keyword.cos_short}} when you create or change table definitions, and no data is deleted from {{site.data.keyword.cos_short}} when you drop a table definition.

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

You can then proceed and query the table by name instead of specifying the {{site.data.keyword.cos_short}} URI directly in the SQL statement:

```sql
SELECT * FROM employees
```

If registering table definitions does not work as expected, it might be caused by improper registration of the table using the CREATE TABLE statement. The column definition that specifies the column names and their data types in your CREATE TABLE statement must match the result of the following query:

```
SELECT * FROM describe (<data-location> stored as <storage-format>)
```
Note that the column names are case-sensitive. Incorrect column name specification results in an empty column, that is, the column seems to contain no data. To solve this, reorder the columns or omit some columns.


## Partitioned Tables

You can manage a table in the catalog that consist of multiple partitions on {{site.data.keyword.cos_short}}. The naming of the objects needs to adhere to the Hive-style partitioning naming convention. The object names must include a folder name that has the structure `columm=value`, where `column` must be a column name that is specified in the CREATE TABLE. You can also have combined partition keys, which then need to be existing in the object names as hierachies of folder names, such as `columm1=value/column2=value`. Following is an example list of object names on {{site.data.keyword.cos_short}} that is consistent with the Hive-partitioned naming convention:

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

With such a list of objects, you can specify a partitioned table definition, such as in the following example:

```sql
CREATE TABLE employees (
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

If your data on {{site.data.keyword.cos_short}} does not adhere to this naming convention and you still want to build a partitioned table for it, one way to produce Hive-partitioned layout is to use {{site.data.keyword.sqlquery_short}} in a data preparation step and specify [PARTITION BY](https://cloud.ibm.com/docs/services/sql-query?topic=sql-query-sql-reference#partitionedClause) in the INTO clause.

If a partitioned table has been defined, you always must add each partition to it explicitly. You can do this one by one by running the
`ALTER TABLE` with the `ADD PARTITION` clause for a new partition.

A convenient way to add all partitions that already exist at once on {{site.data.keyword.cos_short}}, is to use the `RECOVER PARTITIONS` clause as follows:

```sql
ALTER TABLE employees RECOVER PARTITIONS
```

Once you added all your partitions, your partitioned table is set up to be queried. You get all the Berlin employees' first and last names, if you submit the following SELECT statement:

```sql
SELECT firstName, lastName FROM employees WHERE city = Berlin
```

The query execution in fact only reads the three objects inside the `/employees/region=east/city=Berlin/` folder 
because the partition definitions are used by the query optimizer to minimize the necessary read I/O accordingly.

The command *SHOW TABLES* provides you with an overview of the existing tables in your instance. 
This command provides search filters to avoid getting too many tables back.

```sql
SHOW TABLES LIKE '*empl*'
```

To get some more information about the definition of the table, use the command *DESCRIBE TABLE*. 

```sql
DESCRIBE TABLE employees
```

Finally, to clean up catalog entries for unused data, call *DROP TABLE*. 
The *DROP TABLE* command drops the definition without removing the real data on {{site.data.keyword.cos_short}}.

```sql
DROP TABLE employees
```
