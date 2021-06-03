+++
title = "Consume the API"
date = 2021
weight = 6
chapter = false
pre = "<b>2.6. </b>"
+++

**Build a Client to Consume the API**

You now have a working model of the web site running as an SPA calling for data via RESTful APIs hosted on AWS Lambda, and served from Amazon API Gateway. These data feeds are considered public because the user does not need to be signed-in and provide credentials for the call to the API. In this exercise, we will take a look at how we can require authentication to make the API calls, and the use of API Keys to enforce call-rate throttling and quota management. To demonstrate, we will use a Java client application, to show how you can consume the auto-generated Java SDKs in your applications.

**Contents**
- [Create Response Model for the TripSearch API](#create-response-model-for-the-tripsearch-api)
- [Assign the TripsFromCityResponse model to the **/tripsfromcity** API call](#assign-the-tripsfromcityresponse-model-to-the-tripsfromcity-api-call)
- [Build a Java client application that consumes the API](#build-a-java-client-application-that-consumes-the-api)
- [Regenerate the client SDK and install on your development machine](#regenerate-the-client-sdk-and-install-on-your-development-machine)
- [Test the newly generated SDK with the Java client app](#test-the-newly-generated-sdk-with-the-java-client-app)
- [Set the API Key in the client code and re-run the API consumer application with throttling enabled](#set-the-api-key-in-the-client-code-and-re-run-the-api-consumer-application-with-throttling-enabled)

#### Create Response Model for the TripSearch API

In order for the SDK generator to create the appropriate classes for a strongly-typed language like Java (as opposed to Javascript, for example) we need to tell API Gateway what the shape or schema of the request/response objects looks like. In the **TripSearch API**, we are using the **GET** method for each of the three API calls. Therefore, there is no schema for inbound requests because the **city** parameter is passed on as part of the URL. If we instead changed the method to **POST**, we would need to pass in the city parameter in the **body** payload, and would need to create a model for this object schema for the code generator to create a Java class for us to bind to.

The result data from the API calls is returned in the **body** of the response. In order for the code generator to create an appropriate class to represent this response, we need to create a response model, and set it as the method response model.

1. Open the **API Gateway console** and click the **Models** link beneath ```iDevelop - Trip Search API```.
2. Click Create
3. For **Model name** type ```TripsFromCityResponse```
4. For **Content-type** type ```application/json```
5. For **Model schema** paste in the following description:

```json
{
  "type" : "object",
  "properties" : {
    "succeeded" : {
      "type" : "boolean"
    },
    "errorMessage" : {
      "type" : "string"
    },
    "errorType" : {
      "type" : "number"
    },
    "data" : {
      "type" : "array",
      "items" : {
        "type" : "object",
        "properties" : {

			"date": {
				"type" : "number"
			},
       		"originCity": {
				"type" : "string"
			},
			"destinationCity": {
				"type" : "string"
			},
			"airline": {
				"type" : "string"
			}
          }
        }
      }
  },
  "title" : "TripsFromCityResponse"
}
```

6. Click **Create model**

#### Assign the TripsFromCityResponse model to the **/tripsfromcity** API call

7. Click the **Resources** link beneath ```iDevelop - Trip Search API```.
8. Click the **GET** method beneath ```/tripsfromcity/{city}```
9. Click **Method Response**
10. In the **/tripsfromcity/{city} - GET - Method Response** panel, click the arrow next to **HTTP Status** to reveal the panel
11. Under **Response Body for 200** click the **pencil icon** next to the **Empty model**.
12. The field becomes a drop-down list. Select **TripsFromCityResponse** and click the **grey tick** to **commit** the change.
13. From the **Actions** menu, select ```Deploy API```
14. For **Deployment stage** select ```prod``` from the list and click **Deploy**
15. On the **prod Stage Editor** that appears, click the **SDK Generation** tab
16. In the **Platform** drop-down list, select **Java SDK**
17. For **Service name** type ```TripSearch```
18. For **Java package name** type ```idevelop.api.sdk```

![API](/images/2/35.png?width=90pc)

19. Click **Generate SDK**. The Java SDK will be generated and downloaded as a ZIP file.
20. **Explode** the downloaded ZIP file on your filesystem.
21. In a terminal window, ```cd``` into the folder where the downloaded SDK has been exploded (typically, the directory is called generated-code) and issue the following command:

```bash
mvn install

# if you are using Eclipse IDE on Windows
%M2_HOME%\bin\mvn install
```

This will **compile** and **install** the SDK in your local Maven repository and we will refer to it in the next steps.

#### Build a Java client application that consumes the API

22. Download the source code bundle for a test application from [TripSearchJavaClient.zip](https://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchJavaClient.zip) and explode the zip file onto your filesystem.\
  If you’re using **Cloud9**, refer to the command below:
```bash
cd ~/environment
curl -L https://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchJavaClient.zip --output TripSearchJavaClient.zip
unzip TripSearchJavaClient.zip
```

{{%attachments title="TripSearchJavaClient ource code bundle" pattern=".*(zip)"/%}}

23. If you’re using Eclipse IDE, use the **Open projects from filesystem location** menu and browse to the filesystem location where you exploded the **TripSearchJavaClient** source code. Open the project.\
  If you’re using **Cloud9**, refer to the command below.
```bash
cd ~/environment/TripSearchJavaClient
mvn install

# if you are using Eclipse IDE on Windows
%M2_HOME%\bin\mvn install
```

24. Run the project. It will use the **TripSearch API** to call ```/tripsfromcity``` and search for trips with destination ```Melbourne```. You will see an output like this:

```bash
Got 2 items in 91ms
Got 2 items in 91ms
Got 2 items in 90ms
.
.
.
Got 2 items in 90ms
```

The example API consumer will time how long each call to the API takes, and display the results. It will make a maximum of 100 calls as quickly as it can.

If we had many of these clients consuming the API rapidly, we could overwhelm the provisioned infrastructure, so we need some way of throttling calls. We can use **Usage Plans** to do this.

25. On the **API Gateway console**, click **Usage Plans** beneath the **APIs** navigator panel.
26. Click **Create** to create a new **Usage Plan**
27. For **Name** type ```LabPlan```
28. Under **Throttling**, for **Rate** type ```1```
29. For **Burst** type ```1```
30. Under **Quota** type ```1000``` per month

![API](/images/2/36.png?width=90pc)

31. Click **Next**
32. Click **Add API Stage**
33. In the **API** drop-down list, select ```iDevelop - Trip Search API```
34. In the **Stage** drop-down list, select **prod**
35. Click the **grey tick** icon to commit the changes
36. Click **Next**
37. Click **Create API Key and add to Usage Plan**
38. In the dialog that appears, for **Name** type ```SDKClient```
39. Click **Save**
40. Click **Done**. A new API key will be created and associated with the usage Plan.
41. Click the **iDevelop - Trip Search API** link beneath **APIs** on the left of the **API Gateway console**.
42. Click the **GET** method beneath ```/tripsfromcity/{city}```
43. Click **Method Request**
44. Under **Settings**, for **API Key Required**, click the **pencil edit** icon, and choose ```true``` from the list.

![API](/images/2/37.png?width=90pc)

45. Click the **grey tick** icon to **commit** the change
46. From the **Actions** menu, select **Deploy API**
47. Choose the **prod** stage and click **Deploy** to deploy the changes

#### Regenerate the client SDK and install on your development machine

48. In the **prod Stage Editor**, click the **SDK Generation** tab
49. For **Platform**, choose **Java SDK**
50. For **Service name** type ```TripSearch```
51. For **Java package name** type ```idevelop.api.sdk```

![API](/images/2/38.png?width=90pc)

52. Click **Generate SDK**. The Java SDK will be generated and downloaded as a ZIP file.
53. **Explode** the downloaded ZIP file on your filesystem.
54. In a terminal window, ```cd``` into the folder where the downloaded SDK has been exploded (typically, the directory is called generated-code) and issue the following command:

```bash
mvn install
```

This will **compile** and **install** the SDK in your local Maven repository, overwriting the previous version. In the following steps, you will use this SDK artefact by referencing it in a client application POM file.

#### Test the newly generated SDK with the Java client app

In the IDE, re-run the application without making any changes. Since you have set the ```/tripsfromcity/{GET}``` endpoint to require an **API Key**, but have not actually set an API in the client application, you will see a **Forbidden error** in the console.

#### Set the API Key in the client code and re-run the API consumer application with throttling enabled

55. The provided client source code needs to be updated to set the **API Key** in order to successfully call the ```/tripsfromcity/{GET}``` method.
56. On the **AWS API Gateway Console**, click the **API Keys** tab
57. Click the **SDKClient** link
58. Click the **Show** link next to **API Key** to reveal the **auto-generated API key**. **Copy** the value into your clipboard.
59. In the **IDE**, in the ```/src/main/java/idevelop/api/tripsearch/sdk/app/App.java``` file, **paste** in the API Key in your clipboard, in the ```API_KEY``` definition, replacing the ```<REPLACE_WITH_API_KEY>``` placeholder.
60. In the same file, locate the **commented out** call to ```apiKey(API_KEY)``` in the **TripSearch builder** call. You may have to run a ```Maven Update``` on the project to pick up the ```.apiKey``` as we updated the jar in the last step and Eclipse may not have picked it up. Now that you have **required an API Key** in the API Gateway call, the SDK created for you will contain a call to allow the key to be set. If you have no API Key requirements, the code generator does not emit this functionality so in the provided code, it is commented out. You need to enable the call in the client code to allow the API Key to be set correctly.
61. Re-run the application in the IDE. Notice that the calls will now succeed, but, you will now periodically start receiving errors requesting you slow down the call-rate. This is because we set a **maximum call-rate** of **1 call per second per API key**. You will see output like this:

```bash
Got 2 items in 97ms
Got 2 items in 125ms
Too Many Requests - waiting 1 second...
.
.
.
```

62. As an experiment, edit the ```API_KEY``` you have set in the **App class** (for example, add a period at the end) which will cause it to be invalid. Re-run the app and notice that you now receive a **Forbidden** message. This is because you set the API Key as required for calls to the ```/tripsfromcity``` call.
63. Experiment with the **Rate and Burst** settings in the **Usage Plan** to see how they affect the client app calling the API. 

{{% notice note %}}
Note that you **do not need** to re-deploy the API nor re-create the SDK if you change the settings in the **Usage Plan**.
{{% /notice %}}
