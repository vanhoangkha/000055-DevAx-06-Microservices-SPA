+++
title = "Add Authentication to the SPA using Amazon Cognito User Pools"
date = 2020
weight = 1
chapter = false
pre = "<b>4.1. </b>"
+++
#### Add Authentication to the SPA using Amazon Cognito User Pools

In this exercise, we will make use of the **Cognito User Pool** and **Identity Pool**, and mark one of our API endpoints as requiring authentication via **Cognito User Pools**.

1. Go to [**AWS Cognito console**](https://console.aws.amazon.com/cognito/home).
* Click **User pools**
* Click **TravelBuddy**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-001.png?featherlight=false&width=90pc)
2. Save the **User pool ID** value
* Click **App integration**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-002.png?featherlight=false&width=90pc)
3. Save the **Client ID** value of the **App client name** whose name is **TravelBuddyWebApp**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-003.png?featherlight=false&width=90pc)
4. Click **Federated Identities**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-004.png?featherlight=false&width=90pc)
5. Click **TravelBuddy**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-005.png?featherlight=false&width=90pc)
6. Click **Sample code**
* In the **Get AWS Credentials** section, save the **Identity Pool ID** value displayed in the sample code
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-006.png?featherlight=false&width=90pc)
7. Open the file whose path is **www\scripts\webapp-configuration.js** in the **www** folder we extracted in step 1 of the 3.5 section
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-007.png?featherlight=false&width=90pc)

The SPA is implemented using the Angular framework, which allows you to define global constants that are used as configuration variables throughout your application. This file defines the values of the configuration variables that you need to set based on your AWS Account’s ARNs and Ids for the various Cognito resources

8. Replace **REPLACE_WITH_COGNITO_IDENTITY_POOL_ID** with the **Identity Pool ID** value we saved in step 6
* Replace **REPLACE_WITH_COGNITO_USER_POOL** with the **User pool ID** value we saved in step 2
* Replace **REPLACE_WITH_COGNITO_USER_POOL_CLIENT_ID** with the **Client ID** value we saved in step 3
* Replace **REPLACE_WITH_S3_BUCKET_WWW** with the **S3BucketWWWBucketName** value in the **Output** tab of the **DevAx-06** stack
* In the **AWS_REGION** field replace with your **Region**
* Save
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-008.png?featherlight=false&width=90pc)
9. Open **Command Prompt**, navigate to the directory of the **www** folder we extracted in step 1 in the 3.5 section
* Execute the following command to upload the changes to the **S3BucketWWWBucketName** bucket
```
set AWS_PROFILE=devaxacademy
aws s3 sync . s3://<S3BucketWWWBucketName>
```
{{% notice note %}} 
Replace **\<S3BucketWWWBucketName\>** with the **S3BucketWWWBucketName** value in the **Output** tab of the **DevAx-06** stack
{{% /notice %}}
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-009.png?featherlight=false&width=60pc)
10. Refresh the **TravelBuddy web page** and check the developer console to confirm there are no errors following the changes you have made.