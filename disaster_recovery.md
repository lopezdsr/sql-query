---

copyright:
  years: 2020
lastupdated: "2020-04-22"

keywords: SQL query, disaster recovery, backup
subcollection: sql-query

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}

# Disaster recovery and backup
{: #disaster}

{{site.data.keyword.sqlquery_full}} stores information about submitted jobs, such as SQL statements, job status, and job IDs. Backups are performed on a regular basis, therefore, in case of a disaster, you can at the most lose information of the last eight hours. Backups are done automatically, so there is no action required on you side, neither for the creation of the backups, nor for their recovery.

During the time of disaster and recovery, the service at that location is not available, which means that you cannot use your instance(s) that had been created in the affected location. Once the phase of disaster recovery is over, you can access your service instances and submit new jobs, even before data recovery completes. Once data recovery completes, job history will be available for the instances again.

If you want to store information of {{site.data.keyword.sqlquery_short}} jobs outside of {{site.data.keyword.sqlquery_short}}, to be able to have a larger job history available, you can do so in the {{site.data.keyword.sqlquery_short}} Python SDK *export_job_history(cos_url)* It stores all new queries in the specified {{site.data.keyword.cos_full}} path in Parquet format.

The job results are stored in Cloud {{site.data.keyword.cos_short}} and are independent of any {{site.data.keyword.sqlquery_short}} disaster recovery.
