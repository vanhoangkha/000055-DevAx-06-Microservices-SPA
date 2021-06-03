+++
title = "Setup the SPA Webpage"
date = 2021
weight = 5
chapter = false
pre = "<b>2.5. </b>"
+++

**Setup the Single Page Application Website**

Now that we have our three APIs set up, we are ready to call them from a web page. First, we need to set up our single-page web application (SPA) and host it on Amazon S3.

We have decided to use the AngularJS framework for our SPA. You could of course use any suitable framework. The aim of this Lab is not to teach you AngularJS or any other SPA framework, so we won’t be diving into the details of how the page works, other than to guide you through wiring up the API calls that the SPA will need to make to populate its data elements.


**Contents**
- [Generate client SDKs for each of the three APIs and deploy to the SPA](#generate-client-sdks-for-each-of-the-three-apis-and-deploy-to-the-spa)
- [Push SPA files to Amazon S3](#push-spa-files-to-amazon-s3)


1. Download the source code bundle from [www.zip](https://workshops.devax.academy/monoliths-to-microservices/module6/files/www.zip) and explode the zip file onto your filesystem.

{{%attachments title="Source code bundle" pattern=".*(zip)"/%}}

#### Generate client SDKs for each of the three APIs and deploy to the SPA

The SPA implementation you have been provided has stubbed-out implementations of the three APIs we want to expose to our users. They have just enough implementation to not cause an error on the page when executed, but they do not provide any data. In order to ‘wire up’ our APIs to the SPA, we will need to generate the Javascript client SDKs that relate to these APIs and store them in the appropriate path.

**For each of the three APIs we have created, follow these instructions, using either the name TripSearch, HotelSpecials or FlightSpecials as appropriate:**

2. Open the **API Gateway console** in the browser and under **APIs**, click the **iDevelop - Flight Specials API** link to reveal the resources for the API.
3. Click **Stages**
4. Click **prod**
5. Click **SDK Generation**
6. For **Platform**, choose ```Javascript```
7. Click **Generate SDK**. The Javascript SDK for the API will be downloaded by your browser.
8. **Explode** the downloaded ZIP file on your filesystem, and locate the file ```apigClient.js```
9. **Rename** this file as ```apigClient_FlightSpecials.js```
10. Open the renamed file in the Eclipse/Cloud9 IDE. Edit it as a text file - simply drag it into the IDE or open the file using the menu.
11. Using the **Search/Replace** feature, replace all occurrences of the text ```apigClientFactory``` with ```apigClientFactory_FlightSpecials```. There will be **2 occurrences** to replace, both at the start of the file.
12. **Save** the file
13. **Copy** the file from its current location on your filesystem, to the ```api``` folder inside the ```www``` folder inside the working folder for the SPA on your local development environment. **Replace** the file that was provided in the ZIP file you downloaded.

{{% notice note %}}
**REPEAT** the above set of instructions for this exercise two times - one for each of **TripSearch** and **HotelSpecials** APIs, ensuring that you name the ```apigClient.js``` files in each downloaded SDK ```apigClient_HotelSpecials.js``` and ```apigClient_TripSearch.js``` as appropriate, and that you **search/replace** ```apigClientFactory``` in each, with ```apigClientFactory_HotelSpecials``` and ```apigClientFactory_TripSearch``` as appropriate.
{{% /notice %}}

#### Push SPA files to Amazon S3

With the API SDKs in place, you are now ready to deploy the SPA code to the Amazon S3 Bucket that will serve the website. The lab setup process has provisioned a suitable S3 bucket, with WebSite Hosting enabled. So you will only need to push all the files from your local machine to the S3 bucket to be able to test the application.

14. In a commandline terminal, ```cd``` into the directory where your working copy of the SPA website is located
15. Issue the following command to synchronize between your local machine and the S3 bucket. Be sure to replace the with the value specified in **Cloudformation Outputs** tab:

```bash
aws s3 sync . s3://<S3BucketWWW> --acl public-read
```

16. When the synchronize has completed, you are ready to test your SPA hosted on S3. Open the following URL in the web browser, replacing the name of the S3 bucket with the value shown in the lab cloudformation ```S3BucketWWW``` field:

```bash
http://<S3BucketWWW>.s3-website-ap-southeast-2.amazonaws.com
```

The familiar ```TravelBuddy``` website should render in your browser. Previously you have seen this website when it was served from a monolithic Java application served off EC2 managed by Elastic Beanstalk. But now, the site is a single-page web application, and is hosted from an S3 bucket, making API calls to Amazon API Gateway to provide data to the website.

You should see the **Hotel Specials** and **Flight Specials** listings rendered on the page. 

In addition, a **Find trips to...** option is available. To test this, enter ```Melbourne``` in the text field and click the **Go!** button. A dialog will appear showing the results of the search. This data is being served from a call to the ```TripSearchAPI``` call, for ```/tripsfromcity```. 

If you clear the value in the field and click the **Go!** button, you will see a list of all available trips, which is served from the **TripSearchAPI** call for ```/trips```.

If you are not seeing the data as a result of the API calls, take a look at the developer console in the browser, to see if there are any errors that will help track down the issue.