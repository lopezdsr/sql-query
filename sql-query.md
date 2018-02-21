---

copyright:
  years: 2018
lastupdated: "2018-02-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Overview
{:shortdesc}
IBM Cloud SQL Query is a fully-managed service that lets you run SQL queries (that is, SELECT statements) to analyze, transform, or clean up rectangular data.
{:shortdesc}

**Note:** You can use SQL Query to create SELECT statements only; actions such as CREATE, DELETE, INSERT, and UPDATE are not possible.

Input data is read from CSV, JSON, or Parquet files located in one or more IBM Cloud Object Storage instances.
Each query result is written to a CSV file in a Cloud Object Storage instance of your choice. 
Use the SQL Query user interface (UI) to develop your queries and the [SQL Query REST API](sql-query.html#rest-api) to automate them.

## Where your input data and query results are stored

Before you can use the SQL Query service to run SQL queries, the input data must be uploaded to one or more Cloud Object Storage instances.
You must also have at least 'Writer' access to at least one Cloud Object Storage bucket, so that result files (that is, the files containing output data) can be written there.
For more information about Cloud Object Storage, including how to provision an instance, create buckets, and upload data, 
refer to the Cloud Object Storage [getting started information](https://console.bluemix.net/docs/services/cloud-object-storage/getting-started.html#getting-started-console)
or [quickstart guide](https://ibm-public-cos.github.io/crs-docs/getting-started-with-cos).

## Running an SQL query

In SQL, the term *query* is just another way of saying *SELECT statement*. To run a query:

1. In the SQL editor field of the SQL Query UI, enter a SELECT statement. In this statement:
    - After the FROM keyword, specify one or more [unique resource identifiers](sql-query.html#table-unique-resource-identifier) (URIs).
Each URI can be thought of as a table. 
Each URI comprises one or more input files; each input file can be thought of as a table partition.
You must have at least 'Reader' access to the buckets that contain the input files.
    - If the format of the input files is CSV, there is no need to specify a STORED AS clause. 
However, if the format is JSON or Parquet, after the FROM clause, specify either STORED AS JSON or STORED AS PARQUET, as appropriate. 
    - If required, you can use JOIN constructs to join data from several input files, even if those files are located in different instances.
2. Below the SELECT statement, in the **Target** field, specify the output [URI](sql-query.html#table-unique-resource-identifier),
that is, the URI of the directory to which the result file is to be written. You must have at least 'Writer' access to the corresponding bucket.
3. Click the **Run** button.
The query result is displayed in the result area of the UI. You can run up to 5 queries simultaneously.

## Table unique resource identifier

A table unique resource identifier (URI) has the form 

&nbsp;&nbsp;**`cos://<endpoint>/<bucket>/<object>`**

where:

**`<endpoint>`**
The [endpoint](sql-query.html#endpoints) of your Cloud Object Store instance, or its [alias](sql-query.html#endpoints).

**`<bucket>`**
The bucket name:
- For an input URI, the bucket that contains the input file or files.
- For an output URI, the bucket to which the output file is to be written.

**`<object>`**
A more exact specification of the file or files:
- For an input URI, this is a pattern that matches one or more input files. 
The specified pattern behaves as if it were appended with a wildcard character, so that any files whose fully-qualified names begin with the pattern are 
used as input files. For example:
  - The pattern `mydir/test1/` matches all files in the specified directory, including files in any subdirectory of that directory.
  - The pattern `mydir/test1/tr` matches all files in the specified directory whose names begin with `tr`, plus all files in any subdirectory whose name begins with `tr`.
  
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

Your Cloud Object Storage instance will have one of the endpoints shown in the following tables. 
To save space, you can use the alias shown instead of the full endpoint name.

Cross-Regional Endpoint Name | Alias
--- | --- 
s3-api.us-geo.objectstorage.{softlayer.net\|service.networklayer.com}     | us-geo
s3-api.dal-us-geo.objectstorage.{softlayer.net\|service.networklayer.com} | dal
s3-api.wdc-us-geo.objectstorage.{softlayer.net\|service.networklayer.com} | wdc
s3-api.sjc-us-geo.objectstorage.{softlayer.net\|service.networklayer.com} | sjc
s3.eu-geo.objectstorage.{softlayer.net\|service.networklayer.com}         | eu-geo
s3.ams-eu-geo.objectstorage.{softlayer.net\|service.networklayer.com}     | ams
s3.fra-eu-geo.objectstorage.{softlayer.net\|service.networklayer.com}     | fra
s3.mil-eu-geo.objectstorage.{softlayer.net\|service.networklayer.com}     | mil

Regional Endpoint Name | Alias
--- | --- 
s3.us-south.objectstorage.{softlayer.net\|service.networklayer.com}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| us-south
s3.us-east.objectstorage.{softlayer.net\|service.networklayer.com} | us-east

## REST API

You can use the [SQL Query service REST API](https://apiexplorer.swg.usma.ibm.com/test/explorer/view/cloudsqlquery-prod:cloud-sql-query:title-Cloud_SQL_Query__beta_#doc) to run queries 
and retrieve information about their status. This is especially helpful when writing code that automatically queries data.
<!--BLH; 13 FEB 2018: This will be uncommented later.
Click [here](https://developer.ibm.com/api/view/cloudsqlquery-prod:cloud-sql-query) for more information about how to use the REST API.
At the end of the month when the Bluemix catalog is combined with AE, the URL will change to
https://developer.ibm.com/api/view/cloudsqlquery/cloud-sql-query
-->

For a Python application, you can also use the [ibmcloudsql package](https://pypi.python.org/pypi/ibmcloudsql).

## Required user roles

The following table shows which which user roles are required to invoke a particular service action or API endpoint. 
Use this information to decide which access rights to grant your users when creating new user IDs.

Description | Service Action | API Endpoint | Required User Roles
--- | --- | --- | ---
Submit an SQL query | sql-query.api.submit | POST/v2-beta/sql_jobs/ | Manager or Writer
Get info for all submitted jobs | sql-query.api.getalljobs | GET/v2-beta/sql_jobs/ | Manager, Writer, or Reader
Get info for a specific submitted job | sql-query.api.getjobinfo | GET/v2-beta/sql_jobs/{job_id} | Manager, Writer, or Reader
