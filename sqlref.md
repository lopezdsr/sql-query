---

copyright:
  year: 2018
lastupdated: "2018-08-02"

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}


# SQL function reference
The {{site.data.keyword.sqlquery_full}} service provides a large and varied set of functions for you to use in your queries.
{: shortdesc}

## Spark SQL functions

A query can use any of the [Spark SQL functions](https://spark.apache.org/docs/2.3.0/api/sql/index.html), with the following exceptions:

- assert_true
- input_file_block_start
- input_file_block_length
- java_method
- reflect

## Geospatial functions

The [Geospatial Toolkit](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.analytics.doc/doc/geo_intro.html) provides a set 
of [geospatial functions](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.analytics.doc/doc/geo_functions.html) 
that you can use to efficiently process and index spatial data.
