---

copyright:
  years: 2018
lastupdated: "2018-08-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Overview
{:shortdesc}

{{site.data.keyword.sqlquery_full}} is a fully-managed service that lets you run SQL queries (that is, SELECT statements) to analyze, transform, or clean up rectangular data.
{:shortdesc}

**Note:** You can use {{site.data.keyword.sqlquery_short}} to create SELECT statements only; actions such as CREATE, DELETE, INSERT, and UPDATE are not possible.

Input data is read from CSV, JSON, ORC, or Parquet files located in one or more {{site.data.keyword.cos_full}} instances.
Each query result is written to a CSV file in a Cloud {{site.data.keyword.cos_short}} instance of your choice. 
Use the {{site.data.keyword.sqlquery_short}} user interface (UI) to develop your queries and the [SQL Query REST API](sql-query.html#rest-api) to automate them.

## Where your input data and query results are stored

Before you can use the {{site.data.keyword.sqlquery_short}} service to run SQL queries, the input data must be uploaded to one or more Cloud {{site.data.keyword.cos_short}} instances.
You must also have at least 'Writer' access to at least one Cloud {{site.data.keyword.cos_short}} bucket, so that result files 
(that is, the files containing output data) can be written there.
For more information about Cloud {{site.data.keyword.cos_short}}, including how to provision an instance, create buckets, and upload data, 
refer to the [Cloud Object Storage Getting Started Guide](https://console.bluemix.net/docs/services/cloud-object-storage/getting-started.html#getting-started-console).

## Running an {{site.data.keyword.sqlquery_short}}

In SQL, the term *query* is just another way of saying *SELECT statement*. To run a query:

1. In the SQL editor field of the {{site.data.keyword.sqlquery_short}} UI, enter a SELECT statement. In this statement:
    - After the FROM keyword, specify one or more [unique resource identifiers](sql-query.html#table-unique-resource-identifier) (URIs).
Each URI can be thought of as a table. 
Each URI comprises one or more input files; each input file can be thought of as a table partition.
You must have at least 'Reader' access to the buckets that contain the input files.
    - If the format of the input files is CSV, there is no need to specify a STORED AS clause. 
However, if the format is JSON, ORC, or Parquet, after the FROM clause, specify STORED AS JSON, STORED AS ORC, or STORED AS PARQUET, as appropriate. 
    - If required, you can use JOIN constructs to join data from several input files, even if those files are located in different instances.
2. Below the SELECT statement, in the **Target** field, specify the output [URI](sql-query.html#table-unique-resource-identifier),
that is, the URI of the directory to which the result file is to be written. You must have at least 'Writer' access to the corresponding bucket.
3. Click the **Run** button.
The query result is displayed in the result area of the UI. You can run up to 5 queries simultaneously.

## Object result set

Currently three objects are written as a result set per job:

1. `jobid=<job_id>`
2. `jobid=<job_id>/_SUCCESS`
3. `jobid=<job_id>/<part-number>`

Only contains the result set (`jobid=<job_id>/<part-number>`), and the other two are empty and don't contain any data. 
It is important not to delete any of the files if you want to use the result set.
Each result is stored with an own job ID prefix that allows you to use the result directly in a query.
When you want to specify a result as input in your SQL query, specify the first (`jobid=<job_id>`) or the third one (`jobid=<job_id>/<part-number>`).

## Table unique resource identifier

A table unique resource identifier (URI) has the form 

&nbsp;&nbsp;**`cos://<endpoint>/<bucket>/<object>`**

where:

**`<endpoint>`**
The [endpoint](sql-query.html#endpoints) of your Cloud {{site.data.keyword.cos_short}} instance, or its [alias](sql-query.html#endpoints).

**`<bucket>`**
The bucket name:
- For an input URI, the bucket that contains the input file or files.
- For an output URI, the bucket to which the output file is to be written.

**`<object>`**
A more exact specification of the file or files:
- The specified object is interpreted in a similar way as listing file system contents with `ls`. 
When you specify a folder name, it will match all objects in that folder. When you specify a 
specific object name, it only matches that single object. When you specify the string with a * wildcard, 
it matches all objects accordingly. For example:
  - The pattern `mydir/test1/` matches all files in the specified directory, including files in any subdirectory of that directory.
  - The pattern `mydir/test1/tr*` matches all files in the specified directory whose names begin with `tr`, plus all files in any subdirectory whose name begins with `tr`.
  
  Because a pattern might match more than one file, ensure that the schema of each matching file is appropriate within the context of the SELECT statement. 
- For an output URI, this is the directory to which the result file is to be written. 
Each result file is stored in a separate subfolder with a name that indicates the job ID. The name of the result file is automatically generated and also indicates the job ID.
Consequently, each time a query is run, the result is stored in a different subdirectory of the target directory. 
For example, if you specify `mydir/out` or `mydir/out/` as the target directory, the result file is written to `mydir/out/jobid=<job_id>`.

  Note that you can use the output data from one query as input data for subsequent queries: 
  - A query can reference the output of single query execution by specifying the fully-qualified object path, including the `jobid=<job_id>` phrase. 
  - A query can reference the output of multiple executions of the same query by omitting the `jobid=<job_id>` part in the object name. 
  Such a query can then treat `jobid` as if it were a column in the input table (for example, in a WHERE clause). 
  This is the Hive-style partitioning concept that Hadoop SQL engines employ for data stored in Hadoop Distributed File System (HDFS).

## Endpoints

Your Cloud {{site.data.keyword.cos_short}} instance will have one of the endpoints shown in the following tables. 
To save space, you can use the alias shown instead of the full endpoint name.

Internal Cross-Regional Endpoint Name | Alias
--- | --- 
s3-api.us-geo.objectstorage.service.networklayer.com     | us-geo
s3-api.dal-us-geo.objectstorage.service.networklayer.com | dal-us-geo
s3-api.wdc-us-geo.objectstorage.service.networklayer.com | wdc-us-geo
s3-api.sjc-us-geo.objectstorage.service.networklayer.com | sjc-us-geo
s3.eu-geo.objectstorage.service.networklayer.com         | eu-geo
s3.ams-eu-geo.objectstorage.service.networklayer.com     | ams-eu-geo
s3.fra-eu-geo.objectstorage.service.networklayer.com     | fra-eu-geo
s3.mil-eu-geo.objectstorage.service.networklayer.com     | mil-eu-geo
s3.ap-geo.objectstorage.service.networklayer.com         | ap-geo
s3.tok-ap-geo.objectstorage.service.networklayer.com     | tok-ap-geo
s3.seo-ap-geo.objectstorage.service.networklayer.com     | seo-ap-geo
s3.hkg-ap-geo.objectstorage.service.networklayer.com     | hkg-ap-geo


External Cross-Regional Endpoint Name | Alias
--- | --- 
s3-api.us-geo.objectstorage.softlayer.net     | us-geo
s3-api.dal-us-geo.objectstorage.softlayer.net | dal-us-geo
s3-api.wdc-us-geo.objectstorage.softlayer.net | wdc-us-geo
s3-api.sjc-us-geo.objectstorage.softlayer.net | sjc-us-geo
s3.eu-geo.objectstorage.softlayer.net         | eu-geo
s3.ams-eu-geo.objectstorage.softlayer.net     | ams-eu-geo
s3.fra-eu-geo.objectstorage.softlayer.net     | fra-eu-geo
s3.mil-eu-geo.objectstorage.softlayer.net     | mil-eu-geo
s3.ap-geo.objectstorage.softlayer.net         | ap-geo
s3.tok-ap-geo.objectstorage.softlayer.net     | tok-ap-geo
s3.seo-ap-geo.objectstorage.softlayer.net     | seo-ap-geo
s3.hkg-ap-geo.objectstorage.softlayer.net     | hkg-ap-geo


Internal Regional Endpoint Name | Alias
--- | --- 
s3.eu-de.objectstorage.service.networklayer.com    | eu-de
s3.eu-gb.objectstorage.service.networklayer.com    | eu-gb
s3.us-south.objectstorage.service.networklayer.com | us-south
s3.us-east.objectstorage.service.networklayer.com  | us-east


External Regional Endpoint Name | Alias
--- | --- 
s3.eu-de.objectstorage.softlayer.net    | eu-de
s3.eu-gb.objectstorage.softlayer.net    | eu-gb
s3.us-south.objectstorage.softlayer.net | us-south
s3.us-east.objectstorage.softlayer.net  | us-east


Internal Single-Site Endpoint Name | Alias
--- | --- 
s3.ams03.objectstorage.service.networklayer.com    | ams
s3.che01.objectstorage.service.networklayer.com    | che
s3.mel01.objectstorage.service.networklayer.com    | mel
s3.tor01.objectstorage.service.networklayer.com    | tor


External Single-Site Endpoint Name | Alias
--- | --- 
s3.ams03.objectstorage.softlayer.net   | ams
s3.che01.objectstorage.softlayer.net   | che
s3.mel01.objectstorage.softlayer.net   | mel
s3.tor01.objectstorage.softlayer.net   | tor

## Programmatic access

### REST API

You can use the [SQL Query service REST API](https://console.bluemix.net/apidocs/sql-query?language=curl) 
to run queries and retrieve information about their status. This is especially helpful when writing code that automatically queries data.

**Note:** The Cloud Resource Name (CRN) is a mandatory part of an {{site.data.keyword.sqlquery_short}} REST endpoint call. The CRN Copy button 
copies your CRN to clipboard and you can just paste it into your API call.

<!--BLH; 13 FEB 2018: This will be uncommented later.
aa
[This IBM developerWorks article](https://developer.ibm.com/api/view/cloudsqlquery-prod:cloud-sql-query) contains additional information about how to use the REST API.
aa
Note to Andrea: When the Bluemix catalog is combined with AE, the URL will change to
https://developer.ibm.com/api/view/cloudsqlquery/cloud-sql-query
-->

### Python applications and notebooks

For a Python application, you can also use the [ibmcloudsql package](https://pypi.python.org/pypi/ibmcloudsql). 
This allows you to use IBM Watson Studio to run queries with {{site.data.keyword.sqlquery_short}} and visualize the query results with one 
of the various widget libraries available in [Watson Studio](https://console.stage1.bluemix.net/catalog/services/data-science-experience).

Using the ibmcloudsql library, you can also interact with {{site.data.keyword.sqlquery_short}} directly from Watson Studio notebooks. 
You can start by [Using IBM Cloud SQL Query notebook](https://dataplatform.ibm.com/analytics/notebooks/v2/656c7d43-7ccd-4e50-a3c0-bbc37c001132/view?access_token=baaa77ad715e17a8f823615d45431329fde0fe92fecb85abb9fc55a877939fe8) 
in the [Watson Studio community](https://dataplatform.ibm.com/exchange/public/entry/view/4a9bb1c816fb1e0f31fec5d580e4e14d). 

### Cloud functions

{{site.data.keyword.sqlquery_short}} is a serverless mechanism to submit SQL queries, making it a very natural match for the serverless 
[IBM Cloud Functions](https://www.ibm.com/cloud/functions). Accordingly, you can use the generic 
[SQL Cloud function](https://hub.docker.com/r/ibmfunctions/sqlquery) to run {{site.data.keyword.sqlquery_short}} as an IBM Cloud function.

<!--BLH; 04 JUL 2018: New section for Geospatial-->
### Geospatial functions

The [Geospatial Toolkit](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.analytics.doc/doc/geo_intro.html) 
provides a set 
of [geospatial functions](https://www.ibm.com/support/knowledgecenter/SS6NHC/com.ibm.swg.im.dashdb.analytics.doc/doc/geo_functions.html) 
that you can use to efficiently process and index spatial data. 
These functions are integrated into the {{site.data.keyword.sqlquery_short}} service and ready for immediate use.
The {{site.data.keyword.sqlquery_short}} service also provides several sample queries that illustrate how 
to use these functions. 

## Required user roles

The following table shows which which user roles are required to invoke a particular service action or API endpoint. 
Use this information to decide which access rights to grant your users when creating new user IDs.

Description | Service Action | API Endpoint | Required User Roles
--- | --- | --- | ---
Submit an SQL query | sql-query.api.submit | POST/v2-beta/sql_jobs/ | Manager or Writer
Get info for all submitted jobs | sql-query.api.getalljobs | GET/v2-beta/sql_jobs/ | Manager, Writer, or Reader
Get info for a specific submitted job | sql-query.api.getjobinfo | GET/v2-beta/sql_jobs/{job_id} | Manager, Writer, or Reader

## Limitations

- CSV input supports only comma-separated objects with a header.
- If a JSON, ORC, or Parquet object contains a nested or arrayed structure, using a wildcard (for example, `select * from cos://...`) returns an error such as 
"Invalid CSV data type used: `struct<nested JSON object>`."
Use one of the following workarounds:
  - For a nested structure, specify the fully nested column name instead of the wildcard, for example, `select address.city from cos://...`.
  - For an array, use the Spark SQL explode() function, for example, `select explode(address.city) from cos://...`.
- If you receive a corrupted result, verify that the source file is correct and that the correct input file format is specified using 'STORED AS' in the SQL statement.
- If you receive an error message stating that some columns are not found in the input columns,
but the columns do exist in the input file, check if the input file format being specified using 'STORED AS'
in the SQL statement is the actual file format of your current file.
- In order to further process CSV output with {{site.data.keyword.sqlquery_short}}, all values have to be contained within one line. The multi-line option 
is not supported and therefore must be manually changed. 
To remove new lines from multi-line column values, use the SQL function `regexp_replace`. For example, a CSV object `data` has an attribute `multi_line` 
containing values spanning multiple lines. To select a subset of rows based on a `condition` and store it on COS for further processing, a skeleton 
SQL statement looks like the following:

	`SELECT regexp_replace(multi_line, '[\\r\\n]', ' ') as multi_line FROM data STORED AS CSV WHERE condition`
	
- Ensure that each SQL query updating the composite object uses the same column select list, meaning that names of columns and sequence 
of columns have to be identical. Otherwise, composed objects become unreadable due to incompatible headers stored in different parts of the object.
- Ensure that for growing composite objects, all SQL statements that update the object and introduce new columns to a column selection list, 
add these columns to the end of the column list. If this is not the case, the structure of the object gets corrupted, causing unreadable objects, corrupted data, or unreliable results.
