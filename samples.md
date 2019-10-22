---

copyright:
  years: 2019
lastupdated: "2019-10-16"

keywords: SQL query, UI, samples

subcollection: sql-query

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Samples
{: #samples}

You find a wide variety of samples in the {{site.data.keyword.sqlquery_full}} UI to get you started. You only need to click one of the sample queries in the UI to paste them into the editor. Here is an overview of all currently available sample queries, grouped by category.


## STARTER QUERIES
{: #starter}

- **Table exploration**

  Select the first lines of a table to explore it.

- **DESCRIBE schema**

  Get the schema of a data set in COS.

- **Multi-way join**

  Use a multi-way join to combine related rows from multiple tables.

- **Simple self join**

  Use a self join to find rows in a table that relate to a specific row from the same table.

- **Using Row Number**

  Generate a row number based to an ordering key and use it for filtering.

- **Produce JSON output**

  Produce nested JSON records for customers and their orders.

## BASE QUERIES
{: #base}

- **OUTER JOIN and GROUP BY**

  Use an outer join to retain rows that have no matching entries in a joined table and GROUP BY to aggregate rows into a count.

- **Union all**

  Use unions to append several queries that return the same result structure.

- **Subquery**

  Use a subquery to identify rows and NOT IN clause to exclude those rows from the outer query.

- **Correlated subquery**

  Within a subquery, reference a row from the outer query.

## ADVANCED QUERIES
{: #advanced}

- **Common table expression with CASE expression**

  Use common table expressions to decompose complex query constructs into multiple steps.

- **HAVING clause**

  Use a HAVING clause to filter rows after they are aggregated by a GROUP BY clause.

- **Date manipulation**

  Use various SQL functions to manipulate dates and to format output rows.

- **CASE expression**

  Use a CASE expression to compute values based on logical conditions.

- **Window function**

  Use window functions to relate each row to a group.

- **LISTAGG-style concatenation**

  Use collect_list and concat_ws functions to emulate LISTAGG.

## CSV & JSON PARSING QUERIES
{: #csv_json}

- **Custom CSV delimiter**

  Analyze a CSV data set with non-standard column delimiter.

- **CSV without header row**

  Analyze a CSV data set without a header row.

- **General JSON hierarchy flattening**

  Flatten struct type columns hierarchy (e.g. from JSON) using FLATTEN table transformer.

- **Simple JSON array flattening**

  Flatten your JSON array using the explode() function.

## ELT & ETL QUERIES
{: #elt_etl}

- **Parquet conversion**

  Convert a CSV data set to Parquet with SELECT INTO format specification.

- **Hive-style partition creation**

  Partition your data based on columns.

- **Fixed number of partitions**

  Partition your data into a fixed number of rows.

- **Clustered partitions**

  Cluster your data into a fixed number of partitions. each consisting of multiple objects of fixed cardinality.

- **Exact result target path**

  Write a Parquet result set into an exact target path without job ID.

- **General column name cleansing**

  Replace all characters in column names not supported by Parquet format using CLEANCOLS table transformer.

- **Combined column cleansing & flattening**

  Combine CLEANCOLS and FLATTEN table transformers.

- **Merge Parquet schemas**

  Merge schema of multiple Parquet input objects.

- **Write to Db2 (Db2 service credentials)**

  Write the query results to a Db2 table using the Db2 service credentials.

## SPATIAL QUERIES
{: #spatial}

- **Geospatial calculations**

  Geospatial calculation of distance and intersections of location data.

- **Geospatial join with small data**

  Geospatial join of two data sets based on the intersections of location data.

- **Geospatial join with prefiltering**

  Geospatial join with prefiltering to allow for larger data sets.

## TIME SERIES QUERIES
{: #time_series}

- **Hourly sum over time series**

  Example of hourly segmentation of time series data.

- **Two hour time series forecasting**

  Example of a time series forecast.

- **Time series join**

  Example of joining two time series columns.

- **Time series alignment**

  Example of aligning two time series columns.

- **Time series statistics**

  Example of a time series statistics query.
