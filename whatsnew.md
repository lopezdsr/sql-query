---

copyright:
  year: 2018, 2019
lastupdated: "2019-04-04"

---

# What's new

## April 2019

- Support for encrypting SQL queries with {{site.data.keyword.keymanagementservicefull}}. {{site.data.keyword.keymanagementservicelong_notm}} is a centralized key management system (KMS) for generating, managing, and destroying encryption keys used by IBM Cloud™ services. 
If you are processing particularly sensitive data in your queries, you can now use customer-managed keys to encrypt SQL query texts and error messages that are stored in the job information.
- {{site.data.keyword.sqlquery_full}} with {{site.data.keyword.keymanagementservicelong_notm}} for managing encryption keys meets the required IBM controls that are commensurate with the Health Insurance Portability and Accountability Act of 1996 (HIPAA) Security and Privacy Rule requirements.

## February 2019

- Beta support for JDBC driver of {{site.data.keyword.sqlquery_short}}. Request to participate by sending an email to cglew@us.ibm.com.
- Beta support for data skipping indexes. You can create custom indexes on any column for minimum and maximum values, list of values, 
and geospatial bounding box for any object queried. This significantly reduces I/O and query cost and lower the query execution time. 
Request to participate by sending an email to cglew@us.ibm.com.
- Beta support for SQL-native TimeSeries support in {{site.data.keyword.sqlquery_short}}. This includes functions for timeseries segmentation, prediction, alignment, 
temporal joins and subsequence mining. Request to participate by sending an email to cglew@us.ibm.com.

## December 2018

Release of a complete SQL Reference Guide, an SQL introduction for Cloud SQL/Spark SQL.
This Guide includes examples that can be copied and directly pasted into the Web UI to be executed.

## November 2018

- Support for controlling the layout of SQL results. Including support for creating hive-style partitioning and paginated result data.
- Support for extensions in [Python SDK](https://pypi.org/project/ibmcloudsql) for result data partitioning, pagination and exporting SQL job history to {{site.data.keyword.cos_full}}.

## October 2018

Support for SELECT INTO to control the format the SQL result is written in.

## August 2018 

- {{site.data.keyword.sqlquery_full}} is now generally available. Its open beta phase has ended.
- Support for [new built-in SQL functions](https://issues.apache.org/jira/browse/SPARK-20746) released with Apache Spark 2.3.
- Set of SQL optimizer and ANSI SQL and Hive SQL compliance enhancements introduced with Apache Spark 2.3.

## June 2018 

- Support for ORC data (STORED AS ORC).
- Support for geospatial SQL functions for calculations, aggregations and joins on location data.
- Release of [ibmcloudsql Node.js client SDK](https://www.npmjs.com/package/ibmcloudsql).


## April 2018 

[{{site.data.keyword.sqlquery_notm}} release beta](https://www.ibm.com/blogs/bluemix/2018/04/introducing-ibm-cloud-sql-query/).
