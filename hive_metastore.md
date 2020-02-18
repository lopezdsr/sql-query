---

copyright:
  year:  2020
lastupdated: "2020-02-18"

keywords: hive metastore,  performance, create table, object storage

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}
{:note: .note}


# Catalog Management ![Beta](beta.png)
{: #hivemetastore}

Beta support for this feature was introduced in February, 2020.
{: note}

{{site.data.keyword.sqlquery_full}} includes a full database catalog that you can use to register and manage table definitions for your data on {{site.data.keyword.cos_full}}. Each instance of {{site.data.keyword.sqlquery_short}} has its own database catalog namespace. In a fresh instance, this catalog is empty, and it is up to you to register table definitions in there.

## Benefits

If you have data on [Cloud Object Storage](/docs/services/cloud-object-storage/getting-started.html#getting-started-console) you want to explore, change, or discover, you can create queries with {{site.data.keyword.sqlquery_short}} using SQL syntax. To query data on {{site.data.keyword.cos_short}} without a table definition in the catalog, you need to specify the data location (the corresponding COS URI) and the data format in your SELECT statement. During query execution, all the required metadata is dynamically discovered as part of the SQL compilation process. This inferred metadata comprises column names, data types, the list of partitions, and individual objects on {{site.data.keyword.cos_short}} that together make up the overall table data.
 
Once you are familiar with the data, in particular with the schema and partition structure, it imposes an unnecessary overhead and latency to infer all this information from the data with every query execution. The inference process can take up a significant amount of time, especially for text formats (for example, CSV and JSON), or when there are thousands of objects in different table partitions. In some cases it is even accountable for the largest part of the overall query execution time. 

Registering the table definition in a catalog is a huge benefit and boosts time savings for repetitive query executions. A registry is based on a table name and contains location and schema information. You can use the table name as a reference for the table. This way, the table name is decoupled from the data location and becomes part of the table definition. Ideally, only data engineers deal with the data location and they *publish* registered tables under their table names. This eases the work of SQL authors, as in order to compose a SELECT statement, the understanding of the exact location and format of data on {{site.data.keyword.cos_short}} is not required anymore. In case of data location changes, only the table definition has to be updated but the table name can remain. Such updates get simplified and the robustness of SQL statements and applications is increased. 

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
USING PARQUET
LOCATION cos://us-geo/sql/employees.parquet
```

You can then proceed and query the table by name instead of specifying the {{site.data.keyword.cos_short}} URI directly in the SQL statement:

```sql
SELECT * FROM employees
```

If registering table definitions does not work as expected, it is possibly caused by improper registration of the table using the CREATE TABLE statement. The column definition that specifies the column names and their data types in your CREATE TABLE statement must match the result of the following query:

```sql
SELECT * FROM describe (<data-location> stored as <storage-format>)
```
Note that the column names are case-sensitive. Incorrect column name specification results in an empty column, that is, the column seems to contain no data. To solve such a problem use the automatic schema detection, reorder the columns or omit some columns.

Automatic schema detection will be triggert if you do not define the column list. For the above employees table example:

```sql
create table employees 
USING PARQUET
LOCATION cos://us-geo/sql/employees.parquet
```

## Partitioned Tables

You can manage a table in the catalog that consists of multiple partitions on {{site.data.keyword.cos_short}}. The naming of the objects must adhere to the Hive-style partitioning naming convention. The object names must include a folder name that has the structure `columm=value`, where `column` must be a column name that is specified in the CREATE TABLE. You can also have combined partition keys, that need to be existing in the object names as hierachies of folder names, such as `columm1=value/column2=value`. Following is an example list of object names on {{site.data.keyword.cos_short}} that is consistent with the Hive-partitioned naming convention:

```
/customers/country=Germany/cust-1.csv
/customers/country=Germany/cust-2.csv
/customers/country=Spain/cust-1.csv
/customers/country=Austria/cust-1.csv
/customers/country=Austria/cust-2.csv
/customers/country=USA/cust-1.csv
/customers/country=USA/cust-2.csv
/customers/country=USA/cust-3.csv
/customers/country=Sweden/cust-1.csv
```

With such a list of objects, you can specify a partitioned table definition, such as in the following example:

```sql
CREATE TABLE customers (
  customerID string,
  companyName string,
  contactName string,
  contactTitle string,
  address string,
  region string,
  postalCode string,
  country string,
  phone string,
  fax string
)
USING CSV
PARTITIONED BY (country)
LOCATION cos://us-geo/sql/customers_partitioned.csv
```

If your data on {{site.data.keyword.cos_short}} does not adhere to this naming convention and you still want to build a partitioned table for it, one way to produce Hive-partitioned layout is to use {{site.data.keyword.sqlquery_short}} in a data preparation step and specify [PARTITION BY](https://cloud.ibm.com/docs/services/sql-query?topic=sql-query-sql-reference#partitionedClause) in the INTO clause.

If a partitioned table has been defined, you always must add each partition to it explicitly. You can do this one by one by running the
`ALTER TABLE` with the `ADD PARTITION` clause for a new partition.

A convenient way to add all partitions that already exist at once on {{site.data.keyword.cos_short}}, is to use the `RECOVER PARTITIONS` clause as follows:

```sql
ALTER TABLE customers RECOVER PARTITIONS
```

Once you added all your partitions, your partitioned table is set up to be queried. You get all the German customers, if you submit the following SELECT statement:

```sql
select customerID from customers where country = 'Germany'
```

The query execution in fact only reads the  objects inside the `cos://us-geo/sql/customers_partitioned.csv/country=Germany/` folder 
because the partition definitions are used by the query optimizer to minimize the necessary read I/O accordingly.

The command *SHOW TABLES* provides you with an overview of the existing tables in your instance. 
This command provides search filters to avoid getting too many tables back.

```sql
SHOW TABLES LIKE '*cus*'
```

To get some more information about the definition of the table, use the command *DESCRIBE TABLE*. 

```sql
DESCRIBE TABLE customers
```

Finally, to clean up catalog entries for unused data, call *DROP TABLE*. 
The *DROP TABLE* command drops the definition without removing the real data on {{site.data.keyword.cos_short}}.

```sql
DROP TABLE customers
```
