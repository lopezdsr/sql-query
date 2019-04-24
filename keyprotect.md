---

copyright:
  year: 2018, 2019
lastupdated: "2019-04-24"

keywords: encryption, key protect, query, key management system

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}


# Encrypting SQL queries with Key Protect
{: #keyprotect}

By default, {{site.data.keyword.sqlquery_full}} uses server-managed encryption at rest for all job information that is recorded about your stored queries. If you are processing particularly sensitive data in your queries that is governed by special regulations, you can additionally use customer-managed keys to encrypt the SQL query texts and error messages that are stored in the job information.

{{site.data.keyword.keymanagementservicefull}} is a centralized key management system (KMS) for generating, managing, and destroying encryption keys used by {{site.data.keyword.cloud}} services. You can associate a key managed in {{site.data.keyword.keymanagementservicelong_notm}} with an SQL query instance to encrypt your queries. Customer key encryption can only be configured when you are creating the SQL query instance, and that configuration cannot be changed later. However, you can always create a new SQL query instance with a different configuration and use that for future queries. Note that encryption is only available for {{site.data.keyword.sqlquery_short}} Standard plan based instances.

## Setting up Key Protect encryption
{: #encryption}

1. Provision [Key Protect](https://cloud.ibm.com/docs/services/key-protect?topic=key-protect-about) on your {{site.data.keyword.cloud_notm}} account.
2. Navigate to your instance of {{site.data.keyword.keymanagementserviceshort}} and generate or enter a [root key](https://cloud.ibm.com/docs/services/key-protect?topic=key-protect-getting-started-tutorial).
3. Create a new Standard plan instance of {{site.data.keyword.sqlquery_short}} and select the {{site.data.keyword.keymanagementserviceshort}} key for encrypting your queries.
For performance reasons, create both the {{site.data.keyword.keymanagementserviceshort}} and {{site.data.keyword.sqlquery_short}} instances in the same {{site.data.keyword.cloud_notm}} region.
4. Give the new {{site.data.keyword.sqlquery_short}} instance [access](https://test.cloud.ibm.com/docs/iam?topic=iam-serviceauth#serviceauth) to your {{site.data.keyword.keymanagementserviceshort}} key.

  - Open your {{site.data.keyword.cloud_notm}} dashboard.
  - From the menu bar, click **Manage** > **Access (IAM)**, and select **Authorizations**.
  - Click **Create**.
  - In the source service menu, select **IBM SQL Query**.
  - In the source service instance menu, select the service instance to authorize.
  - In the target service menu, select **IBM Key Protect**.
  - In the target service instance menu, select the service instance to authorize.
  - Enable the **Reader** role.
  - Click **Authorize**.

## Further considerations
{: #considerations}

Customer key encryption in {{site.data.keyword.sqlquery_short}} applies to the queries that you are processing. 
With each query, you explicitly specify {{site.data.keyword.cos_full}} locations for input and target data, which are not controlled by {{site.data.keyword.sqlquery_short}}. 
So, if you are processing sensitive data, make sure that your query results are written to an {{site.data.keyword.cos_full_notm}} location that has appropriate protection. Note that default target locations, where results are stored by default if no other result locations are specified, are not and cannot be encrypted.

{{site.data.keyword.cos_full_notm}} documents [how to configure customer key encryption for the Cloud Object Storage buckets](https://cloud.ibm.com/docs/services/cloud-object-storage/libraries?topic=cloud-object-storage-manage-encryption#manage-encryption)
storing the actual data.

If you use {{site.data.keyword.keymanagementserviceshort}} to encrypt your queries, IBM staff cannot view the encrypted query texts and error messages. Consequently, provide this data explicitly to IBM service in a support case, so you can make sure that no sensitive information is exposed.

Deleting a key or the containing {{site.data.keyword.keymanagementserviceshort}} instance from the system will shred its contents and any data still encrypted with that key. Once removed, it cannot be undone or reversed. An SQL query instance associated with a deleted key cannot be used for any further queries. You need to create a new SQL query instance for future queries.
