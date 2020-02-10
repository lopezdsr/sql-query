---

copyright:
  year: 2018, 2020
lastupdated: "2020-01-22"

keywords: security, authentication, access, iam, sso, service credential

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}


# Authentication
{: #authentication}

The {{site.data.keyword.sqlquery_full}} service is tightly integrated with {{site.data.keyword.iamlong}} (IAM). 
In order to perform an action using the {{site.data.keyword.sqlquery_short}} user interface or API, you require an IAM user ID, which is an IBM ID with an 
IBM Cloud account. {{site.data.keyword.sqlquery_short}} then verifies whether you are authorized to work with the service instance.

## Authenticating access to data resources in SQL Query
{: #accessauthentication}

### SSO via IAM
{: #iamsso}

IAM is also the preferred and the default mechanism for authenticating access to downstream data resources that are referenced by your SQL queries. If you use it, 
ensure that the user ID you use to submit the SQL query through the web console or the API is also authorized to read the input locations 
(referenced in the `FROM` clauses of the query), and to write the result set to the target location (referenced in the `INTO` clause of the query). 
This mechanism provides seamless single sign-on (SSO) for your query submissions in {{site.data.keyword.sqlquery_short}}. 
You can use the following alternative methods for authenticating access to data resources:

#### IBM Cloud service credentials
{: #servicecredentials}

You can use the unique CRN of a service instance in {{site.data.keyword.Bluemix_notm}} to address a resource location. 
The credentials for accessing this data resource are retrieved from the Credentials object of that service instance. 
This requires the that IAM user ID that is used to submit the query has the operator role for the service instance of the corresponding data resource.

#### Custom user ID and password for each data resource
{: #userpassword}

You can use the USER and PASSWORD keywords in the corresponding FROM or INTO clauses to securely pass user ID and password for each resource location. 
To ensure that the passing of sensitive data is secure, you must first store the password as a custom standard key in an instance of 
{{site.data.keyword.keymanagementserviceshort}} to which you have access, and then pass it in a CRN to that key instead of the plain text password. 
See [Setting up custom secrets in Key Protect](#kpsetup) for more information about how to store the password securely.

#### Custom API key for each data resource
{: #apikey}

As an alternative to providing user and password combinations, {{site.data.keyword.Bluemix_notm}} also allows you to securely pass API keys 
for each resource location. Using the `APIKEY` keyword inside the according `FROM` or `INTO` clauses, you can pass in this information. 
To ensure that the passing of sensitive data is secure, you must first store the API key as a custom standard key in a 
{{site.data.keyword.keymanagementserviceshort}} service instance to which you have access, and then pass it in a CRN to that 
key instead of the plain text API key. See [Setting up custom secrets in Key Protect](#kpsetup) for more information about how to store the API key securely.

### Currently supported authentication methods per data resource
{: #supportedauthentication}

| Authentication Method                 | COS   | Db2 on Cloud | Db2 Warehouse on Cloud |
| ---                                   | :---: | :---:        | :---:                  |
| IAM SSO                               | yes   | Enterprise   | Enterprise             |
| CRN with Service Credentials          | no    | yes          | yes                    |
| User and password via Key Protect CRN | no    | yes          | yes                    |
| API key via Key Protect CRN           | no    | Enterprise   | Enterprise             |
