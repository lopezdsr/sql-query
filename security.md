---

copyright:
  year: 2018, 2019
lastupdated: "2019-04-11"

keywords: security, gdpr, hipaa, compliance, personal data, personal information, privacy policy, cloud notice, terms of use

subcollection: sql-query

---

{:shortdesc: .shortdesc}
{:new_window: target="_blank"}
{:codeblock: .codeblock}
{:pre: .pre}
{:screen: .screen}
{:tip: .tip}

# Security and compliance
{: #security}

## Authentication
{: #authentication}
The SQL Query service is tightly integrated with IBM Cloud Identify and Access Management (IAM). In order to perform an action using the SQL Query user interfacer or API, you require an IAM user ID, which is an IBM ID with an IBM Cloud signup. The SQL Query service then verifies whether you are authorised to work with the SQL Query instance.

### Authenticating access to data sources in SQL Query
{: #accessauthentication}
#### SSO via IAM
{: #iamsso}
IAM is also the preferred and the default mechanism for authenticating access to downstream data sources that are referenced by your SQL queries. If you use it, you have to make sure that the user ID you use to submit the SQL query through the web console or the API is also authorized to read the input data sources (these are what are referenced in your FROM clauses), and to write to the target location of the SQL query result set (this is what is referenced in your INTO clause). This mechanism provides seamless single sign-on (SSO) that happens with your first query submission using the SQL Query service. As alternatives to using IAM, the SQL Query service offers the following alternative methods of authenticating access:

#### IBM Cloud service credentials
{: #servicecredentials}
You can use the unique CRN of a service instance in IBM Cloud to address an input or output data source. The credentials for accessing this data source are retrieved from the Credentials object of that service instance. This requires the that IAM user ID that is used to submit the SQL Query has the operator role for the service instance of the corresponding data source.

#### Custom user ID and password for each data source
{: #userpassword}
You can use the USER and PASSWORD keywords in the corresponding FROM or INTO clauses to securely pass a user ID and password combination for individual input data sets and the output data set. To ensure that the passing of sensitive data is secure, you must first store the password as a custom standard key into a Key Protect service instance to which you have access, and then pass in a CRN to that key instead of the plain text password. See [Setting up custom secrets in Key Protect](#kpsetup) for more information about how to store the password or API key securely.

#### Custom API key for each data source
{: #apikey}
As an alternative to provide user and password combinations SQL Query also allows you to securely pass it an API key for individual input data sets and for the output data set. Using the `APIKEY` keyword inside the according FROM or INTO clauses you can pass in this information. To ensure that the passing of sensitive data is secure, you must first store the API key as a custom standard key into a Key Protect service instance to which you have access, and then pass in a CRN to that key instead of the plain text API key. See [Setting up custom secrets in Key Protect](#kpsetup) for more information about how to store the password or API key securely.

#### Currently supported authentication methods per data source
{: #supportedauthentication}
| Authentication Method                 | COS   | Db2 on Cloud | Db2 Warehouse on Cloud |
| ---                                   | :---: | :---:        | :---:                  |
| IAM SSO                               | yes   | Enterprise   | Enterprise             |
| CRN with Service Credentials          | no    | yes          | yes                    |
| User and password via Key Protect CRN | no    | yes          | yes                    |
| API key via Key Protect CRN           | no    | yes          | yes                    |

### Setting up custom secrets in Key Protect
{: #kpsetup}
IBM Key Protect is the recommended mechanism for storing and manage any secrets in IBM Cloud. It also provides an option for you to upload custom secrets, which it then manages for you. IBM Key Protect ensures that only those users and services to whom you have explicitly granted access privileges are able to access and use secrets. The SQL query service uses IBM Key Protect as its secure and trusted credential broker for custom secrets used for custom data sources as the following diagram shows.

![Secure Credential Passing in SQL Query](accesssecrets.png)

Make sure that you have provisioned or have been given access to an instance of Key Protect in IBM Cloud. The following description uses the command-line interface to set up a new custom key. Alternatively you can also use the Key Protect service web console in IBM Cloud.

- Log on to IBM Cloud with `ibmcloud login --sso`
- If the Key Protect CLI plugin is not already installed, install it by issuing the following command: `ibmcloud plugin install key-protect -r 'IBM Cloud'` For more information, see [Documention](https://cloud.ibm.com/docs/services/key-protect?topic=key-protect-set-up-cli&locale=en-US))
-List your key protect service instances and identify the ID of the instance that you want to use by issuing the following command: `ibmcloud resource service-instances --long`
- Optionally review the currently existing keys in that instance by issuing the following command:  `ibmcloud kp list -I <kp instance id>`
- Note that Key Protect accepts only base64 encoded secret data. Issue the following command to add a custom secret as properly encoded content to Key Protect: ``ibmcloud kp create "<custom name for your new key>" -i <kp instance id> -s -k `echo <your custom secret> | base64` ``

You cannot use the key protect CLI or web console to review actual key content after it is uploaded. However, you can use the [REST API](https://cloud.ibm.com/apidocs/key-protect#retrieve-a-key-by-id) directly to review existing custom key content by issuing the following command: `curl -X GET "https://us-south.kms.cloud.ibm.com/api/v2/keys/<key id>" -H "accept: application/vnd.ibm.collection+json" -H "authorization: <Bearer token>" -H "bluemix-instance: <key instance id> | jq -r '.resources[].payload' | base64 --decode`.

For more information, refer to the Key Protect [CLI Documentation](https://cloud.ibm.com/docs/services/key-protect?topic=key-protect-cli-reference&locale=en-US#ibmcloud-kp-commands).

#### Managing access to custom secrets
{: #kpauthorization}
Use IBM Key Protect to manage access to your keys. You can do this for an entire Key Protect instance or for an individual key. For more information, refer to the Key Protect [documentation](https://cloud.ibm.com/docs/services/key-protect?topic=key-protect-grant-access-keys) for further details.

## General Data Protection Regulation (GDPR)
{: #gdpr}

If you have an account with {{site.data.keyword.cloud}}, your personal data is held by {{site.data.keyword.cloud_notm}}. The [IBM Data Processing Addendum (IBM DPA)](https://www.ibm.com/support/customer/csol/terms/?cat=dpa) applies to the processing of client's personal data by IBM on behalf of client in order to provide IBM standard services.

{{site.data.keyword.sqlquery_full}} processes limited client Personal Information (PI) in the course of running the service and optimizing the user experience.

{{site.data.keyword.sqlquery_notm}} provides a [Data Sheet Addendum (DSA)](https://www.ibm.com/software/reports/compatibility/clarity-reports/report/html/softwareReqsForProduct?deliverableId=AC17FFB0B52911E7A9EB066095601ABB) with its policies as a Data Processor regarding content and data protection.

## HIPAA
{: #hipaa}

{{site.data.keyword.sqlquery_notm}} with {{site.data.keyword.keymanagementservicelong}} for managing encryption keys meets the required IBM controls that are commensurate with the Health Insurance Portability and Accountability Act of 1996 (HIPAA) Security and Privacy Rule requirements. These requirements include the appropriate administrative, physical, and technical safeguards required of Business Associates in 45 CFR Part 160 and Subparts A and C of Part 164. HIPAA must be requested at the time of provisioning and requires a representative to sign a Business Associate Addendum (BAA) agreement with IBM.

## ISO 27001/27017/27018
{: #iso}

{{site.data.keyword.sqlquery_notm}} is ISO 27001/27017/27018 certified. The certificates and the certified cloud products listing can be found in the [IBM Trust Center](https://www.ibm.com/trust) in section [Compliance](https://www.ibm.com/cloud/compliance).

## Terms
{: #terms}

[The IBM Privacy Policy](https://www.ibm.com/privacy/us/en/)

[The IBM Cloud Notices and Terms of Use](/docs/overview/terms-of-use?topic=overview-terms#terms)
