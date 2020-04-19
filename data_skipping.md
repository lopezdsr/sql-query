---

copyright:
  year:  2020
lastupdated: "2020-04-19"

keywords: data, skipping, performance, cost, data format, indexes, sample data

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}
{:note: .note}


# Data skipping ![Beta](beta.png)
{: #dataskipping}

Beta support for this feature was introduced in May, 2020.
{: note}

Data skipping can significantly boost performance and reduce cost of SQL queries by skipping over irrelevant data objects, based on a summary metadata associated with each object.
Data skipping indexes apply to structured data sets in {{site.data.keyword.cos_full}} and they store summary metadata for each object in the data set.
The summary metadata is significantly smaller than the data itself and it can be indexed. SQL queries benefit from an index by skipping over all objects whose does not overlap with the summary metadata in the index.

## Benefits

- Boosts performance of your queries
- Lowers cost of your queries

## Overview

For each column(s) in the object, the summary metadata can include minimum and maximum values, a list or bloom filter of the appearing values, or other metadata that concisely represents the data in that column. The summary metadata is then used during query evaluation to skip over objects that do not contain any relevant data. All formats are supported, including Parquet, ORC, CSV, JSON, and Avro. Data skipping is for performance optimization, using it does not affect the content of query results.

As {{site.data.keyword.sqlquery_full}} charges on a per-query basis based on the amount of data scanned, reducing the number of bytes scanned per query, reduces cost while improving performance. For data skipping to work well, as well as for good performance overall, use the [best practices for data layout](https://www.ibm.com/cloud/blog/big-data-layout), such as using the Parquet format and adopting Hive-style partitioning. Ideally, create tables using the [{{site.data.keyword.cos_full}! catalog](/docs/services/sql-query?topic=sql-query-hivemetastore).
Data skipping complements these best practices and provides significant additional cost savings and performance benefits.

To use this feature, you have to create indexes on one or more columns of the data set. Start by indexing those columns that you query most often in the `WHERE` clause.

The following three index types are supported:

Index type | Description | Applicable to predicates in `WHERE` clause | Column types
--- | --- | --- | ---
MinMax | Stores minimum or maximum values for a column | <,<=,=,>=,> | [Orderable types](https://spark.apache.org/docs/latest/api/sql/index.html)
ValueList | Stores the list of unique values for the column | =,IN,LIKE | All types
BloomFilter | Using bloom filter technique for set membership | =,IN | Byte, string, long, integer, short

Use ValueList for a column if the number of distinct values for that column per object is typically much smaller than the total number of values for that column per object (otherwise, the index could be as big as that column of the data set). Use BloomFilter if the number of distinct column values per object is high.

Indexes, or data skipping metadata, are stored in a location you specify. Note that metadata is much smaller than the data itself. If changes are made to some of the objects in the data set after index creation, refresh the indexes. Otherwise, data skipping still works correctly, however it cannot skip the changed objects.

## Usage

### Sample data

The sample data set used in this documentation originates from the `meter_gen` [data generator](https://github.com/gridpocket/project-iostack/tree/master/meter_gen) that was developed by [Gridpocket](https://www.gridpocket.com/en/) in the context of the [IOStack project](http://iostack.eu/).
It generates electricity, water, and gas meter readings, along with their associated timestamps, geospatial locations, and additional information.
The data set is in Parquet format, has 18 GB, and is publicly available to use with {{site.data.keyword.sqlquery_short}} at `cos:\\us-geo\sql\metergen`. 
The queries listed in the examples are also available in the UI under **Samples** > **Data Skipping**. 

### Assign 


