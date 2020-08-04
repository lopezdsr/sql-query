---

copyright:
  years: 2018, 2020
lastupdated: "2020-08-05"

keywords: aspera, data lake, object storage, csv, sysdig, monitoring

subcollection: sql-query

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:note: .note}
{:deprecated: .deprecated}
{:important: .important}

# Monitoring {{site.data.keyword.sqlquery_full}} metrics using {{site.data.keyword.mon_full_notm}}
{: #metrics}

[{{site.data.keyword.mon_full}} ![External link icon](../../icons/launch-glyph.svg "External link icon")](/docs/Monitoring-with-Sysdig?topic=Sysdig-getting-started#getting-started)
 is a third-party cloud-native, and container-intelligence management system that you can include as part of your {{site.data.keyword.cloud_notm}} architecture. Use it to gain operational visibility into the performance and health of your applications, services, and platforms. It offers administrators, DevOps teams, and developers full stack telemetry with advanced features to monitor and troubleshoot, define alerts, and design custom dashboards.
{:shortdesc}


## Opting in to and enabling {{site.data.keyword.sqlquery_full}} metrics
{: #opt_in_metrics}

Metrics integration is not available on lite plan {{site.data.keyword.sqlquery_full}} instances.

Before you can start using {{site.data.keyword.sqlquery_full}} Sysdig metrics, you must first opt in and then enable platform metrics by completing the following steps:

1. Enable platform metrics for {{site.data.keyword.sqlquery_full}}. For more information, see [Enabling platform metrics ![External link icon](../../icons/launch-glyph.svg "External link icon")](/docs/Monitoring-with-Sysdig?topic=Sysdig-platform_metrics_enabling){:new_window}. The owner of the account has full access to the this metrics data. For more information about managing access for other users see [Getting started tutorial for {{site.data.keyword.mon_full}} ![External link icon](../../icons/launch-glyph.svg "External link icon")](/docs/Monitoring-with-Sysdig?topic=Sysdig-getting-started#prereqs){:new_window}.

2. To navigate from the {{site.data.keyword.sqlquery_full}} instance page to the {{site.data.keyword.mon_full_notm}} dashboard, click the 3 vertical dots in the upper right corner of the instance page (**Service instance options**) and select **Monitoring**.

   On your first usage, you might see a welcome wizard. To advance to the dashboard selection menu, select **Next** and then **Skip** at the bottom of the **Choosing an installation method** page.  Accept the prompts that follow. You can then select the **{{site.data.keyword.sqlquery_full}}** dashboard.

   Dashboards are available only after metrics have started to be recorded; this might take a few minutes to initialize.
   {:note}


## {{site.data.keyword.sqlquery_full}} metrics cost information
{: #metric_costs}

Before you opt in to using {{site.data.keyword.mon_full}} metrics, be aware of the cost of doing so. Every instance of {{site.data.keyword.sqlquery_full}} makes four metrics available, each time series has a monthly cost of $0.08,
which leads to monthly cost of $0.24 per instance.

{: caption="Table 1. Cost for each plan" caption-side="top"}

For more information, see [{{site.data.keyword.mon_full_notm}} pricing ![External link icon](../../icons/launch-glyph.svg "External link icon")](/docs/Monitoring-with-Sysdig?topic=Sysdig-pricing_plans).


## {{site.data.keyword.messagehub}} metrics details
{: #metric_details}

The following tables describe the specific metrics provided by {{site.data.keyword.sqlquery_full}}.


| Metric Name |
|-----------|
| [Number of bytes read by completed jobs](#ibm_sqlquery_bytes_read) |
| [Number of completed Jobs](#ibm_sqlquery_completed_jobs) |
| [Number of failed Jobs](#ibm_sqlquery_failed_jobs) |
| [Number of jobs in progress](#ibm_sqlquery_jobs_in_progress) |
{: caption="Table 1: Metrics Available by Plan Names" caption-side="top"}

### Number of bytes read by completed jobs
{: #ibm_sqlquery_bytes_read}

Cumulative number of bytes read by all SQL Query jobs completed successfully

| Metadata | Description |
|----------|-------------|
| `Metric Name` | `ibm_sqlquery_bytes_read`|
| `Metric Type` | `gauge` |
| `Value Type`  | `byte` |
| `Segment By` | `Service instance, Service instance name` |
{: caption="Table 2: Number of bytes read by completed jobs metric metadata" caption-side="top"}

### Number of completed Jobs
{: #ibm_sqlquery_completed_jobs}

Number of SQL Query jobs that are finished successfully

| Metadata | Description |
|----------|-------------|
| `Metric Name` | `ibm_sqlquery_completed_jobs`|
| `Metric Type` | `gauge` |
| `Value Type`  | `none` |
| `Segment By` | `Service instance, Service instance name` |
{: caption="Table 3: Number of completed Jobs metric metadata" caption-side="top"}

### Number of failed Jobs
{: #ibm_sqlquery_failed_jobs}

Number of SQL Query jobs that are failed

| Metadata | Description |
|----------|-------------|
| `Metric Name` | `ibm_sqlquery_failed_jobs`|
| `Metric Type` | `gauge` |
| `Value Type`  | `none` |
| `Segment By` | `Service instance, Service instance name` |
{: caption="Table 4: Number of failed Jobs metric metadata" caption-side="top"}

### Number of jobs in progress
{: #ibm_sqlquery_jobs_in_progress}

Number of submitted SQL Query jobs that are in progress (queued or running)

| Metadata | Description |
|----------|-------------|
| `Metric Name` | `ibm_sqlquery_jobs_in_progress`|
| `Metric Type` | `gauge` |
| `Value Type`  | `none` |
| `Segment By` | `Service instance, Service instance name` |
{: caption="Table 5: Number of jobs in progress metric metadata" caption-side="top"}

## Attributes for Segmentation
{: attributes}

### Global Attributes
{: global-attributes}

The following attributes are available for segmenting all of the metrics listed above

| Attribute | Attribute Name | Attribute Description |
|-----------|----------------|-----------------------|
| `Cloud Type` | `ibm_ctype` | The cloud type is a value of public, dedicated or local |
| `Location` | `ibm_location` | The location of the monitored resource - this may be a region, data center or global |
| `Resource` | `ibm_resource` | The resource being measured by the service - typically a indentifying name or GUID |
| `Resource Type` | `ibm_resource_type` | The type of the resource being measured by the service |
| `Resource group` | `ibm_resource_group_name` | The resource group where the service instance was created |
| `Scope` | `ibm_scope` | The scope is the account, organization or space GUID associated with this metric |
| `Service name` | `ibm_service_name` | Name of the service generating this metric |

### Additional Attributes
{: additional-attributes}

The following attributes are available for segmenting one or more attributes as described in the reference above.  Please see the individual metrics for segmentation options.

| Attribute | Attribute Name | Attribute Description |
|-----------|----------------|-----------------------|
| `Service instance` | `ibm_service_instance` | The service instance segment identifies the instance the metric is associated with |
| `Service instance name` | `ibm_service_instance_name` | The service instance name provides the user-provided name of the service instance which isn't necessarily a unique value depending on the name provided by the user. |

<br/>

For more information about enabling platform metrics from the {{site.data.keyword.sqlquery_full}} dashboard and viewing metrics, see [Monitoring {{site.data.keyword.sqlquery_full}} metrics ![External link icon](../../icons/launch-glyph.svg "External link icon")](/docs/observability-monitoring?topic=observability-monitoring-monitor-sysdig){:new_window}.
