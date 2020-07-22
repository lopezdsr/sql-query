---

copyright:
  years: 2020
lastupdated: "2020-07-07"

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

{{site.data.keyword.sqlquery_full}} stores information about submitted jobs, such as SQL statements, job status, job IDs, and database catalog information like table and views. In the event of a disaster, the regular backups ensure that no more than 24 hours of data are at risk of loss. Backups are done automatically, so there is no action required on you side, neither for the creation of the backups, nor for their recovery.

The job results are stored in {{site.data.keyword.cos_full}} and are independent of any {{site.data.keyword.sqlquery_short}} disaster recovery.

If a region becomes unavailable due to a disaster, the {{site.data.keyword.Bluemix}} team will work to get the region available again. You can route your workload to a different region by creating a new instance in an available region. In case you have worked with tables or views, you have to create those in the new instance and region again. Indexes are still available, if they are saved in available buckets,  such as cross region buckets, but you have to set the corresponding base location. Depending on the location and size of your data, it is possible that the jobs take longer.

Until recovery has completed, you cannot use your instance(s) that had been created in the affected location. Once data recovery completes, job history will be available for the instances again.

## Restoring a deleted service instance
{: #restore-instance}

After you delete an instance of the {{site.data.keyword.sqlquery_short}} service, you can restore the deleted service instance within the data retention period of seven days. After the seven-day period expires, the service instance is permanently deleted.

To view which service instances are available for restoration, use the [`ibmcloud resource reclamations`](/docs/cli?topic=cli-ibmcloud_commands_resource#ibmcloud_resource_reclamations) command. To restore a deleted service, use the [`ibmcloud resource reclamation-restore`](/docs/cli?topic=cli-ibmcloud_commands_resource#ibmcloud_resource_reclamation_restore) command. If you try to restore a deleted service and an active {{site.data.keyword.contdelivery_short}} service instance exists, the restoration is blocked. To view the details for a resource reclamation, use the [`ibmcloud resource reclamation`](/docs/cli?topic=cli-ibmcloud_commands_resource#ibmcloud_resource_reclamation) command, with the `--output JSON` option.
