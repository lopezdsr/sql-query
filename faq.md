---

copyright:
  years: 2020
lastupdated: "2020-10-27"

keywords: best practice, faq, sql query

subcollection: sql-query

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# FAQ
{:faq}



## Is SQL Query transaction safe?
{:transaction_safe}

IBM Cloud Object Storage does not support transaction. IBM Cloud SQL Query can be used to create 
Parquet or CSV files / objects on COS. Since IBM Cloud SQL Query does not support INSERT, UPDATE or DELETE; while it can be used 
to create COS object using the INTO clause, for the created object in COS, the question arises if they are transaction safe and ACID compliant?
Is other words, if you create an object in COS using IBM Cloud SQL Query, can you assume that COS object creation is transaction 
safe and if anything happens before the creation is done, it will be rolled back?

The answer is yes if you are producing with a single SQL query jobs only a single partitioned object on COS, 
because COS itself does object write in an atomic fashion. If you want to write complex hierarchies of objects with a 
single SQL job, then A) it can happen that the job fails half way and only part of the objects are written, and B) during job 
execution some objects are already visible while others are still in process to be written.
But for the latter scenario, we recommend using Hive-style partitioned tables. I.e. the SQL job writes a new set of objects into a new 
COS prefix location. This does not affect anything in the Hive-style partitioned table. Only when you then also issue an ALTER TABLE … 
ADD PARTITION with the newly written object location, the data will be made available in the Hive-style partitioned table. 
That ALTER TABLE DDL is in fact also an atomic operation.

## How to handle very large time series?
{:large_ts}

Note: When using time-series queries, in general the more time series that exist, the better the parallelism.

Example:

```
select 
	key, 
	ts
from table 
using time_series_format(key="key", timetick="time_tick", value="amount") in ts
```

The following query creates one time series per key, and partition the data based on the key. Anytime a query is run against "ts", 
it will be run in parallel across time series. The issue arises if "ts" is very large and thus does not fit in the memory of one machine. 
To mitigate this, modify your key as follows:

First query: Add date to your key (the key must not be with a date, it can be with any granularity of time).

```
select
	concat(cast(to_date(time_tick) as str), "-", key) as date_and_key
	time_tick,
	amount
from table
into table2
```

Second query: Create your time series with the new `date_and_key` key.

```
select
	date_and_key,
	ts
from table2
using time_series_format(key="date_and_key", timetick="time_tick", value="amount") in ts
```

The above queries will better utilize parallelism by providing a larger set of keys. 
In this case, you will not only have the set of unique keys, but the dates associated with each key as well. 
By doing so, each time series will be much smaller, and have a better chance of fitting in memory on a single machine.
