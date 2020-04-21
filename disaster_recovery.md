---

copyright:
  years: 2020
lastupdated: "2020-04-21"

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

{{site.data.keyword.sqlquery_full}} stores information about the submitted jobs, such as the SQL statement, the status of the job, or 
the job ID. Backups are performed on a regular basis, therefore, in case of a disaster, you can at the most lose information of the last eight hours. Backups are done automatically, so there is no action required on you side. 

During the time of disaster recovery, the service is not available in the location of the instance; and job history is bound to the location, where the instance was created.

If you want to store information of {{site.data.keyword.sqlquery_short}} jobs outside of {{site.data.keyword.sqlquery_short}}, to be able to have a larger job history available, you can do so in the {{site.data.keyword.sqlquery_short}} Python SDK *export_job_history(cos_url)*. It stores all new queries in the specified Cloud {{site.data.keyword.cos_full}} path in Parquet format.

The job results are stored in {{site.data.keyword.cos_full}} and are independent of any {{site.data.keyword.sqlquery_short}} disaster recovery.
