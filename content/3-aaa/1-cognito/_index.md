+++
title = "SPA Authentication"
weight = 1
chapter = false
pre = "<b>3.1. </b>"
+++

**Add Authentication to the SPA using Amazon Cognito User Pools**

In this exercise, we will make use of the **Cognito User Pool** and **Identity Pool**, and mark one of our API endpoints as requiring authentication via Cognito User Pools.

1. On your local filesystem, locate the file ```webapp-configuration.js``` in the ```scripts``` directory of the web site bundle you have downloaded and exploded. This file has the following contents:

```js
(function () {
    'use strict';

    angular
        .module('app')

        .constant('COGNITO_IDENTITY_POOL_ID',   'REPLACE_WITH_COGNITO_IDENTITY_POOL_ID')
        .constant('COGNITO_USER_POOL',          'REPLACE_WITH_COGNITO_USER_POOL')
        .constant('COGNITO_USER_POOL_CLIENT_ID','REPLACE_WITH_COGNITO_USER_POOL_CLIENT_ID')
        .constant('COGNITO_APP_WEB_DOMAIN',     'REPLACE_WITH_S3_BUCKET_WWW')

        .constant('AWS_REGION',                 'ap-northeast-1')
        .constant('APP_BANNER',                 'TravelBuddy')

})();
```

The SPA is implemented using the Angular framework, which allows you to define global constants that are used as configuration variables throughout your application. This file defines the values of the configuration variables that you need to set based on your AWS Account’s ARNs and Ids for the various Cognito resources. Open the ```webapp-configuration.js``` file in a text editor and keep it open while we make changes in the following steps.

2. Open the **AWS Cognito console** by clicking **Services** and typing ```cognito``` in the filter box. Press **Enter**.
3. Click **Manage your User Pools**
4. Click **TravelBuddy**

![API](/images/3/1.png?width=90pc)

5. In the **General Settings** panel that appears, locate the **Pool Id** value, and replace the text ```REPLACE_WITH_COGNITO_USER_POOL``` in the ```webapp-configuration.js``` file with the value.
6. Click the **App Client** settings link beneath **App integration** in the left-hand navigation panel of the **Cognito User Pools** page. Locate the ```ID``` value beneath the App client **TravelBuddyWebApp** heading and copy it to your clipboard. For example:

![API](/images/3/2.png?width=90pc)

7. Replace the text ```REPLACE_WITH_COGNITO_USER_POOL_CLIENT_ID``` in the ```webapp-configuration.js``` file with the value of the **App client ID**.
8. In the **Cognito console**, click **Federated Identities** at the top navigation bar to switch to the **Cognito Identity Pools manager**.
9. Click the **TravelBuddy** link in the identity pool card that is shown.
10. In the dashboard that appears, on the left navigation panel, click **Sample code**.
11. In the **Get AWS Credentials** section, note the **Identity Pool ID** is displayed in the sample code. Copy the **Identity Pool ID** into your clipboard. It will look something like this:

```bash
ap-northeast-1:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeee
```

![API](/images/3/3.png?width=90pc)

Make sure you copy the whole entry, including the **region** specifier.

12. Replace the text ```REPLACE_WITH_COGNITO_IDENTITY_POOL_ID``` in the ```webapp-configuration.js``` file with the value of the **Identity Pool Id**.
13. In the lab **CloudFormation console**, in the **Additional Info** panel, copy the value of ```S3BucketWWW``` which is the S3 bucket name for the web hosting bucket you are using to serve your SPA.
14. Replace the text ```REPLACE_WITH_S3_BUCKET_WWW``` in the ```webapp-configuration.js``` file with the value of the ```S3BucketWWW``` from the **Additional Info** panel in lab.
15. The finished ```webapp-configuration.js``` file will look something like this:

```js
(function () {
    'use strict';

    angular
        .module('app')

        .constant('COGNITO_IDENTITY_POOL_ID',   'ap-northeast-1:429c1d1c-7a5e-4d53-be18-177b806c53a4')
        .constant('COGNITO_USER_POOL',          'ap-northeast-1_YSRyht4ck')
        .constant('COGNITO_USER_POOL_CLIENT_ID','3mh9486bds2f2cr3gio8bdjoik')
        .constant('COGNITO_APP_WEB_DOMAIN',     'devax-m6-s3bucketwebsite18ddbcd4-19ewci3z6hece')

        .constant('AWS_REGION',                 'ap-northeast-1')
        .constant('APP_BANNER',                 'TravelBuddy')

})();
```

16. You have now made all the changes you need to in the ```webapp-configuration.js``` file. Save the file, and upload it to the ```S3BucketWWW``` in the **scripts** folder, to overwrite the existing stubbed-out file. You can perform the upload using ath S3 console, or the commandline.
17. Refresh the **TravelBuddy web page** and check the developer console to confirm there are **no errors** following the changes you have made.
