---

copyright:
  year: 2018, 2019
lastupdated: "2019-04-04"

keywords: activity tracker, activity, event

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}



# Activity Tracker events
{: #activitytracker}

Use the {{site.data.keyword.cloudaccesstraillong}} service to track how users and applications interact with {{site.data.keyword.sqlquery_full}}.

The {{site.data.keyword.cloudaccesstraillong_notm}} service records user-initiated activities that change the state of a service in {{site.data.keyword.cloud}}.
For more information, see [Getting started with Activity Tracker with LogDNA](/docs/services/Activity-Tracker-with-LogDNA?topic=logdnaat-getting-started).

##List of events
{: #events}

The following table lists the actions that generate an event:

Actions  |	Description
--- | ---
sql-query.sql-job.create | 	An SQL query was submitted.
sql-query.sql-job.list | 	List of jobs has been retrieved.
sql-query.sql-job.get | 	Details of a job have been retrieved.
sql-query.catalog-table.list | 	List of catalog tables has been retrieved.
sql-query.catalog-table.get | 	Details of a catalog table have been retrieved.
