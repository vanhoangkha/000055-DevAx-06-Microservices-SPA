+++
title = "Setup The Single Page Application Website"
date = 2020
weight = 5
chapter = false
pre = "<b>3.5. </b>"
+++
#### Setup The Single Page Application Website

Now that we have our three APIs set up, we are ready to call them from a web page. First, we need to set up our single-page web application (SPA) and host it on Amazon S3.

We have decided to use the AngularJS framework for our SPA. You could of course use any suitable framework. The aim of this Lab is not to teach you AngularJS or any other SPA framework, so we won’t be diving into the details of how the page works, other than to guide you through wiring up the API calls that the SPA will need to make to populate its data elements.

{{%attachments title="SPA Project" style="orange" pattern="www.zip"/%}}

1. Download the **www.zip** file and extract

#### Generate client SDKs for each of the three APIs and deploy to the SPA

The SPA implementation you have been provided has stubbed-out implementations of the three APIs we want to expose to our users. They have just enough implementation to not cause an error on the page when executed, but they do not provide any data. In order to ‘wire up’ our APIs to the SPA, we will need to generate the Javascript client SDKs that relate to these APIs and store them in the appropriate path.

2. Go to [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Type **iDevelop - Flight Specials API** to the search bar and press **Enter**
* Click **iDevelop - Flight Specials API**
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-001.png?featherlight=false&width=90pc)
3. Click **Stages**
* Select **prod**
* Click tab **SDK Generation**
* In the **Platform** section, select **Javascript**
* Click **Generate SDK**. The Javascript SDK for the API will be downloaded by your browser.
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-002.png?featherlight=false&width=90pc)
4. Extract the file we downloaded in step 3
* Find the **apigClient.js** file inside the folder we extracted and rename this file as **apigClient_FlightSpecials.js**
5. Open the **apigClient_FlightSpecials.js** file in the  Eclipse IDE. Use **Search/Replace** and replace **apigClientFactory** with **apigClientFactory_FlightSpecials**. There will be 2 occurrences to replace, both at the start of the file.
* Press **Ctrl+F** shortcut
* In the **Find** section, type ```apigClientFactory```
* In the **Replace with** section, type ```apigClientFactory_FlightSpecials```
* Click **Replace All** to replace
* Save
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-003.png?featherlight=false&width=90pc)
6. Copy the **apigClient_FlightSpecials.js** file to the **api** folder inside the **www** folder inside the working folder for the SPA on your local development environment. Replace the **apigClient_FlightSpecials.js** file inside the **api** folder
7. For **iDevelop - Hotel Specials API**, do the same **iDevelop - Flight Specials API**
* Go to [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Type **iDevelop - Hotel Specials API** to the search bar and press **Enter**
* Click **iDevelop - Hotel Specials API**
8. Click **Stages**
* Select **prod**
* Click tab **SDK Generation**
* In the **Platform** section, select **Javascript**
* Click **Generate SDK**. The Javascript SDK for the API will be downloaded by your browser.
9. Extract the file we downloaded in step 8
* Find the **apigClient.js** file inside the folder we extracted and rename this file as **apigClient_HotelSpecials.js**
10. Open the **apigClient_HotelSpecials.js** file in the Eclipse IDE. Use **Search/Replace** and replace **apigClientFactory** with **apigClientFactory_HotelSpecials**.
* Press **Ctrl+F** shortcut
* In the **Find** section, type ```apigClientFactory```
* In the **Replace with** section, type ```apigClientFactory_HotelSpecials```
* Click **Replace All** to replace
* Save
11. Copy the **apigClient_HotelSpecials.js** file to the **api** folder inside the **www** folder inside the working folder for the SPA on your local development environment. Replace the **apigClient_HotelSpecials.js** file inside the **api** folder
12. For **iDevelop - Trip Search API**, do the same **iDevelop - Flight Specials API**
* Go to [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Type **iDevelop - Trip Search API** to the search bar and press **Enter**
* Click **iDevelop - Trip Search API**
13. Click **Stages**
* Select **prod**
* Click tab **SDK Generation**
* In the **Platform** section, select **Javascript**
* Click **Generate SDK**. The Javascript SDK for the API will be downloaded by your browser.
14. Extract the file we downloaded in step 13
* Find the **apigClient.js** file inside the folder we extracted and rename this file as **apigClient_TripSearch.js**
15. Open the **apigClient_TripSearch.js** file in the Eclipse IDE. Use **Search/Replace** and replace **apigClientFactory** with **apigClientFactory_TripSearch**.
* Press **Ctrl+F** shortcut
* In the **Find** section, type ```apigClientFactory```
* In the **Replace with** section, type ```apigClientFactory_TripSearch```
* Click **Replace All** to replace
* Save
16. Copy the **apigClient_TripSearch.js** file to the **api** folder inside the **www** folder inside the working folder for the SPA on your local development environment. Replace the **apigClient_TripSearch.js** file inside the **api** folder

#### Push SPA files to Amazon S3

With the API SDKs in place, you are now ready to deploy the SPA code to the Amazon S3 Bucket that will serve the website. The lab setup process has provisioned a suitable S3 bucket, with WebSite Hosting enabled. So you will only need to push all the files from your local machine to the S3 bucket to be able to test the application.

17. Open **Command Prompt** , navigate to the directory of the **www** file we extracted in step 1
* Execute the following command to synchronize between your local machine and the S3 bucket
```
set AWS_PROFILE=devaxacademy
aws s3 sync . s3://<S3BucketWWWBucketName> --acl public-read
```
{{% notice note %}} 
Replace **\<S3BucketWWWBucketName\>** with the **S3BucketWWWBucketName** value in the **Output** tab of the **DevAx-06** stack
{{% /notice %}}
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-004.png?featherlight=false&width=60pc)
18. When the synchronize has completed, you are ready to test your SPA hosted on S3. Open the following URL in the web browser
```
http://<S3BucketWWWBucketName>.s3-website-<YOUR_REGION>.amazonaws.com
```
{{% notice note %}} 
Repalce **\<S3BucketWWWBucketName\>** with the **S3BucketWWWBucketName** value in the **Output** tab of the **DevAx-06** stack\
Repalce **<YOUR_REGION>** with your **Region**
{{% /notice %}}
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-005.png?featherlight=false&width=90pc)

The familiar TravelBuddy website should render in your browser. Previously you have seen this website when it was served from a monolithic Java application served off EC2 managed by Elastic Beanstalk. But now, the site is a single-page web application, and is hosted from an S3 bucket, making API calls to Amazon API Gateway to provide data to the website.

You should see the **Hotel Specials** and **Flight Specials** listings rendered on the page.

In addition, a **Find trips to…** option is available. To test this, enter **Melbourne** in the text field and click the Go! button. A dialog will appear showing the results of the search. This data is being served from a call to the **TripSearchAPI** call, for **/tripsfromcity**.

![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-006.png?featherlight=false&width=90pc)

If you clear the value in the field and click the **Go!** button, you will see a list of all available trips, which is served from the **TripSearchAPI** call for **/trips**.

![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-007.png?featherlight=false&width=90pc)

If you are not seeing the data as a result of the API calls, take a look at the developer console in the browser, to see if there are any errors that will help track down the issue.