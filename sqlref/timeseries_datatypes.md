---

copyright:
  years: 2019, 2021
lastupdated: "2021-03-02"

keywords: SQL query, time series, SQL, data types

subcollection: sql-query

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Time series data types
{: #ts_datatypes}

Time series functions operate on a wide variety of special data types that are designed especially for time series data.


Data type | Description
--- | ---
DoubleTimeSeries  | Time series with univariate observations of type Double. See the following example: 
`[(1, 7.2), (3, 4.5), (5, 4.5), (5, 4.6), (5, 7.1), (7, 3.9), (9, 1.1)`
DoubleArrayTimeSeries | Time series with multivariate observations of type Double. See the following example:
`[(1, [7.2, 8.74]), (3, [4.5, 9.44]), (5, [4.5, 10.12]), (5, [4.6, 12.91]), (5, [7.1, 9.90]), (7, [3.9, 3.76])]`
DoubleSegmentTimeSeries | DoubleTimeSeries that is segmented. See the following example:
`[(1,[(1, 7.2), (3, 4.5)]), (5,[(5, 4.5), (5, 4.6), (5, 7.1)]), (7,[(7, 3.9), (9, 1.1)])]`
DoubleArraySegmentTimeSeries |  DoubleArrayTimeSeries that is segmented.See the following example:
`[(1,[(1, 7.2, 8.74), (3, 4.5, 9.44)]), (5,[(5, 4.5, 10.12), (5, 4.6, 12.91), (5, 7.1, 9.90)]), (7,[(7, 3.9, 3.76)])]`
StringTimeSeries  | Time series with univariate observations of type String. See the following example:
`[(1, "a"), (3, "b"), (5, "c"), (5, "d"), (5, "e"), (7, "f"), (9, "g")]`
StringArrayTimeSeries | Time series with multivariate observations of type String. See the following example:
`[(1, ["a", "xq"]), (3, ["b", "zr"]), (5, ["c", "ms"]), (5, ["d", "rt"]), (5, ["e", "wu"]), (7, ["f", "vv"]), (9, ["g", "zw"])]`
StringSegmentTimeSeries | StringTimeSeries that is segmented. See the following example:
`[(1,[(1, "a"), (3, "b")]), (5,[(5, "c"), (5, "d"), (5, "e")]), (7,[(7, "f"), (9, "g")])]`
StringArraySegmentTimeSeries | StringArrayTimeSeries that is segmented. See the following example:
`[(1,[(1, ["a", "xq"]), (3, ["b", "zr"])]), (5,[(5, ["c", "ms"]), (5, ["d", "rt"]), (5, ["e", "wu"])]), (7, [(7, ["f", "vv"]), (9, ["g", "zw"])])]`
*Table 1. Time series data types. These are binary data types especially designed to hold time series data. Alternatively, you can store time series data in any BinaryType data array, such as those offered by Parquet, Avro, ORC, or JSON. CSV does not offer a suitable BinaryType data array for storing time series data.*


Placeholder | Description
--- | ---
TimeSeries  | Any of the following data types:
  DoubleTimeSeries
  DoubleArrayTimeSeries
  DoubleSegmentTimeSeries
  DoubleArraySegmentTimeSeries
  StringTimeSeries
  StringArrayTimeSeries
  StringSegmentTimeSeries
  StringArraySegmentTimeSeries
  SegmentTimeSeries | Any of the following data types:
  DoubleSegmentTimeSeries
  DoubleArraySegmentTimeSeries
  StringSegmentTimeSeries
  StringArraySegmentTimeSeries
ArrayTimeSeries | Any of the following data types:
  DoubleArrayTimeSeries
  DoubleArraySegmentTimeSeries
  StringArrayTimeSeries
  StringArraySegmentTimeSeries  
 *Table 2. Pseudo data types. These are not actual data types, but are placeholders that are used by the documentation to represent any of several time series data types.*


Data type | Description
--- | ---
TRS | A [time reference system (TRS)](/docs/sql-query?topic=sql-query-TRS) defines the granularity of time series timeticks, and defines a start time that maps a particular time series timetick to a corresponding moment in time.
*Table 3. Time reference system data type.*



