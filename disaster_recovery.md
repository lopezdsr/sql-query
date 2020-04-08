---

copyright:
  years: 2020
lastupdated: "2020-04-08"

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
the job ID. In case of a disaster, you might lose the information of the jobs that you submitted between the last backup and the time 
of the disaster. Backups are done in a frequency of four hours. The job results are stored in {{site.data.keyword.cos_full}} 
and are independent of any {{site.data.keyword.sqlquery_short}} disaster recovery.
