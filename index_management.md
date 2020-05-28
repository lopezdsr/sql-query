---

copyright:
  year:  2020
lastupdated: "2020-05-18"

keywords: data skipping, performance, cost, data format, indexes, sample data, index management

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}
{:note: .note}


# Index management ![Beta](beta.png)
{: #index_management}

Beta support for this feature was introduced in May, 2020.
{: note}

Index management, also referred to as data skipping, can significantly boost performance and reduce cost of SQL queries by skipping over irrelevant data.
Data skipping indexes apply to structured data sets in {{site.data.keyword.cos_full}} and store summary metadata for each object in the data set.
The indexes are stored in Cloud {{site.data.keyword.cos_short}} in a user-provided bucket, similarly to the data.
SQL queries benefit from an index by skipping over all objects whose metadata indicates that they are not relevant to the given query.

## Benefits
{: #benefits_ds}

- Boosts performance of your queries
- Lowers cost of your queries

## Overview
{: #overview_ds}

For each of the columns in an object, summary metadata can include minimum and maximum values, a list or bloom filter of the appearing values, or other metadata that concisely 
represents the data in that column. The summary metadata is then used during query evaluation to skip over objects that do not contain any relevant data. 
All formats are supported, including Parquet, ORC, CSV, and JSON. Data skipping is for performance optimization, using it does not affect the content of query results.
{{site.data.keyword.sqlquery_full}} currently supports metaindexes only. Metaindexes are indexes on a higher level, thus they index objects instead of rows.

As {{site.data.keyword.sqlquery_short}} charges on a per-query basis based on the amount of data scanned, reducing the number of bytes scanned per query, reduces cost while improving performance. For data skipping to work well, as well as for good performance overall, use the [best practices for data layout](https://www.ibm.com/cloud/blog/big-data-layout), such as using the Parquet format and adopting Hive-style partitioning. Ideally, create tables using the [Cloud Object Storage catalog](/docs/services/sql-query?topic=sql-query-hivemetastore).
Data skipping complements these best practices and provides significant additional cost savings and performance benefits.

To use this feature, you must create indexes on one or more columns of the data set. Start by indexing columns that you query most often in the `WHERE` clause.

The following three index types are supported:

Index type | Description | Applicable to predicates in `WHERE` clause | Column types
--- | --- | --- | ---
MinMax | Stores minimum or maximum values for a column | <,<=,=,>=,> | [Orderable types](https://spark.apache.org/docs/latest/sql-reference.html#data-types)
ValueList | Stores the list of unique values for the column | =,IN,LIKE | All types
BloomFilter | Using bloom filter technique for set membership | =,IN | Byte, string, long, integer, short

Use ValueList for a column if the number of distinct values for that column per object is typically much smaller than the total number of values for that column per object (otherwise, the index could be undesirably large). Use BloomFilter if the number of distinct column values per object is high.

Indexes, or data skipping metadata, are stored in a location you specify. Note that metadata is typically much smaller than the data itself. If changes are made to some of the objects in the data set after index creation, refresh the indexes. Otherwise, data skipping still works correctly, but it cannot skip the changed objects.

## Usage
{: #usage_ds}

### Sample data

The sample data set used in this documentation originates from the *meter_gen* [data generator](https://github.com/gridpocket/project-iostack/tree/master/meter_gen) that was developed by [Gridpocket](https://www.gridpocket.com/en/) in the context of the [IOStack project](http://iostack.eu/).
It generates electricity, water, and gas meter readings, along with their associated timestamps, geospatial locations, and additional information.
The data set is in Parquet format, has 9 GB, and is publicly available to use with {{site.data.keyword.sqlquery_short}} at `cos:\\us-geo\sql\metergen`.
The queries listed in the examples are also available in the UI under **Samples** > **Index management**. 
Examples for queries when working on tables are available under **Samples** > **Index management on tables**.
In the UI samples, under **Basic index creation**, you find a fast running index creation example that only creates MinMax indexes.
**Advanced index creation** is an example for using all index types and it takes longer to finish.

### Assigning a base location for data skipping indexes

Indexes are stored in Cloud {{site.data.keyword.cos_short}} in a bucket of your choice.
Before starting to create indexes, first configure the default location, called base location, for indexes created in your {{site.data.keyword.sqlquery_short}} instance.
When using Hive tables, you can additionally or alternatively also configure the index location per Hive table.

To assign your base location, use the following command:

`ALTER METAINDEX SET LOCATION <path>`

A command including a path, looks like the following:

`ALTER METAINDEX SET LOCATION cos://us-south/mybucket/mypath/`

### Creating data skipping indexes

When you create a data skipping index on a data set, decide which columns to index, and choose an index type for each column.
Your choices depend on your workload and data. In general, index those columns that are queried the most in the `WHERE` clause. The three supported index types are MinMax, ValueList, and BloomFilter.

The following example creates a data skipping index on the `metergen` data set using all three index types:

```
CREATE METAINDEX
MINMAX FOR temp,
MINMAX FOR lat,
MINMAX FOR lng,
BLOOMFILTER FOR vid,
VALUELIST FOR city
ON cos://us-geo/sql/metergen STORED AS parquet
```

In the [COS URI](/docs/services/sql-query?topic=sql-query-sql-reference#COSURI), specify the top level (the root) of the data set.

Note that it is possible to share indexes across {{site.data.keyword.sqlquery_short}} accounts. Users having READ access to the base location of an index can use it by setting their base location accordingly. However, it is important to avoid multiple users writing indexes for the same data set to the same base location. Users can avoid sharing indexes by using different base locations.

### Describing an index

To retrieve data skipping index statistics and metadata, use the `DESCRIBE` operation, as in the following example:

```
DESCRIBE METAINDEX
ON cos://us-geo/sql/metergen STORED AS parquet
```

The result includes how many objects were indexed, whether the index is up-to-date, as well as the base location of the indexes and the
index types that were generated.

### Using data skipping indexes

Once you create a data skipping index, {{site.data.keyword.sqlquery_short}} automatically uses it when running queries.
The UI shows the percentage of objects skipped. You also find examples in the UI of queries benefiting from data skipping.

### Geospatial data skipping

Data skipping is supported for queries using [geospatial functions](https://www.ibm.com/support/knowledgecenter/en/SSCJDQ/com.ibm.swg.im.dashdb.analytics.doc/doc/geo_functions.html).

The list of supported geospatial functions includes the following:

- ST_Distance
- ST_Intersects
- ST_Contains
- ST_Equals
- ST_Crosses
- ST_Touches
- ST_Within
- ST_Overlaps
- ST_EnvelopesIntersect
- ST_IntersectsInterior

The following example will get all of the points in 1 km around the point POINT(6.433881 43.422323).
For data skipping to work, a MinMax index on the `lat` and `lng` columns is required.

```
SELECT * FROM cos://us-geo/sql/metergen STORED AS PARQUET WHERE
ST_Distance(ST_Point(lng,lat),ST_WKTToSQL('POINT(6.433881 43.422323)')) < 1000.0
```

### Choosing data formats

You can use data skipping with all of the formats that are supported by {{site.data.keyword.sqlquery_short}}, except for AVRO.
Best practices for data layout advise using a column-based format, such as Parquet.
CSV and JSON require the entire data set to first be scanned in order to infer the schema, prior to running any query.
This is not necessary if you create tables using the {{site.data.keyword.sqlquery_short}} [catalog](/docs/services/sql-query?topic=sql-query-hivemetastore). Unlike Parquet and ORC, CSV and JSON do not have built-in data skipping capabilities and can potentially benefit more from data skipping.

### Refreshing data skipping indexes

If data is added to a data set, or if there are modifications to a data set after a data skipping index is created, the new or changed data is not skipped during queries. Once the amount of new data becomes significant, refresh the index incrementally, as follows:

```
REFRESH METAINDEX
ON cos://us-geo/sql/metergen STORED AS parquet
```

### Showing data skipping indexes

To retrieve existing data skipping indexes under the currently configured metadata base location, use the SHOW operation, as in the following example:

```
SHOW METAINDEXES
```

The result includes the currently set metadata base location and a list of indexed data sets.


### Deleting data skipping indexes

To delete a data skipping index, use the following query:

```
DROP METAINDEX
ON cos://us-geo/sql/metergen STORED AS parquet

```

Note that dropping a table, does not also drop the table indexes.

## Data skipping on catalog tables
{: #ds_catalog}

Data skipping also supports indexing and skipping on [catalog tables](/docs/services/sql-query?topic=sql-query-hivemetastore). How the index is created differs for partitioned and non-partitioned tables.

For non-partitioned tables, indexing must be done using the [COS URI](/docs/services/sql-query?topic=sql-query-sql-reference#COSURI). In this case, the same metadata is used whether a query accesses the table by name or by physical location using the COS URI.

For [partitioned tables](/docs/sql-query?topic=sql-query-hivemetastore#partitioned), indexes created in the COS URI are not used when accessing a table by name. Instead, all command and query examples above must be rewritten by replacing the COS URI with the table name, using the ON TABLE clause. For example, for the above CREATE INDEX statement, to index a table named *metergen*, use the following syntax:

```
CREATE METAINDEX
MINMAX FOR temp,
MINMAX FOR lat,
MINMAX FOR lng,
BLOOMFILTER FOR vid,
VALUELIST FOR city
ON TABLE metergen
```

Refer to the [SQL reference](/docs/services/sql-query?topic=sql-query-sql-reference) for the full list of query statements and commands.

For partitioned tables, by default, the metadata is saved under the base location you defined. However, if you want to set a custom location for the metadata, use the following command:

```
ALTER TABLE metergen SET METAINDEX LOCATION <target-location>
```

If the metadata already exists in the location that was set, no indexing is needed.
If the index does not exist and you run this command before running the CREATE INDEX query, the index will be stored under the configured location, instead of the base location.

The location of the metadata for a table is saved in the table properties under the parameter *spark.ibm.metaindex.parquet.mdlocation*.
If this parameter does not exist, there is a fallback to the base location. Automatic indexing updates the table parameter with the index location.

To remove the parameter from the table, use the following command:

```
ALTER TABLE metergen DROP METAINDEX LOCATION
```

### Notes

-	The metadata for a partitioned table has to be different from the metadata on the physical location (the location that was defined in the LOCATION clause of the CREATE TABLE query) because the table can possibly contain partitions that are not located under the physical location. Therefore, depending on what data skipping metadata was generated for each case, using the table name can give different results than using the COS URI.  


## Limitations
{: #limitations_ds}

- Data skipping sometimes does not work if type *casting* is used in the `WHERE` clause. For example, given a MinMax index on a column    with a short data type, the following query does not benefit from data skipping:

  ```
  select * from table where shortType > 1
  ```

  Apache Spark evaluates the query as `(cast(shortType#3 as int) > 1)` because the constant 1 is of type *integer*.

  Note that in some cases Apache Spark automatically casts the literal to the right type.
  For example, the previous query works for all other numerical types, except for the byte type, as it requires casting, as well.
  To benefit from data skipping in such cases, ensure that the literal has the same type as the column type, as in the following    example:

  ```
  select * from table where shortType > cast(1 as short)
  ```

- Using the Lite plan, data skipping features, such as `CREATE METAINDEX`, are not allowed.


## References
{: #references_ds}

- [Data skipping for IBM SQL Query](https://www.ibm.com/cloud/blog/data-skipping-for-ibm-cloud-sql-query)
- [Data skipping demo at Think 2019](https://www.ibm.com/cloud/blog/ibm-cloud-sql-query-at-think-2019) for the [Danaos use case](https://www.danaos.com/home/default.aspx) of [BigDataStack](https://bigdatastack.eu/?utm_source=IBM-Ta-Shma)
- [How to Layout Big Data in IBM Cloud Object Storage for Spark SQL](https://www.ibm.com/cloud/blog/big-data-layout)
- [Querying Geospatial Data using IBM SQL Query](https://www.ibm.com/cloud/blog/new-builders/querying-geospatial-data-using-ibm-sql-query)
