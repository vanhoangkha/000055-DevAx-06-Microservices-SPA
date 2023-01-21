+++
title = "Create And Expose the API with Amazon API Gateway"
date = 2020
weight = 3
chapter = false
pre = "<b>3.3. </b>"
+++
#### Create And Expose the API with Amazon API Gateway

1. Go to [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home).
* In the **Choose an API type** section, find **REST API - Develop a REST API where you gain complete control over the request and response along with API management capabilities.**
* Click **Build**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-001.png?featherlight=false&width=90pc)
2. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-002.png?featherlight=false&width=90pc)
3. In the **Create new API** section, select **New API**
* In the **API name** section, type ```iDevelop - Trip Search API```
* In the **Description** section, type ```Allows searching ở trips from/to cities```
* Click **Create API**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-003.png?featherlight=false&width=90pc)
4. The API will be created, and have a **root** path element and nothing else.
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-004.png?featherlight=false&width=90pc)
5. In the **New Child Resource** page
* In the **Resource Name** section, type ```trips```
* Check **Enable API Gateway CORS**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-005.png?featherlight=false&width=90pc)
6. The **/trips** resource will be created. Click on the **/trips** link
* Click **Actions**
* Click **Create Method**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-006.png?featherlight=false&width=90pc)
7. In the dropdown list that appears, select **GET** 
* Click the grey tick next to the dropdown list to commit the change.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-007.png?featherlight=false&width=90pc)
8. In the **Lambda Region** section, select your **Region**
* In the **Lambda Function** section, type ```idevelop``` and select **idevelopTripSearchFull**
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-008.png?featherlight=false&width=90pc)
9. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-009.png?featherlight=false&width=90pc)
10. When the method is created, you will see the **Method Execution** panel: 
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-010.png?featherlight=false&width=90pc)
11. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-011.png?featherlight=false&width=90pc)
12. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-012.png?featherlight=false&width=90pc)
13. After a moment or two for the Lambda function to initialise and execute, you should see an output similar to this: 
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-013.png?featherlight=false&width=90pc)
14. Click **/trips**
* Click **Actions**
* Click **Enable CORS**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-014.png?featherlight=false&width=90pc)
15. Click **Enable CORS and replace existing CORS headers**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-015.png?featherlight=false&width=90pc)
16. Click **Yes, replace existing values**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-016.png?featherlight=false&width=90pc)
17. When each of the listed items have a green tick against them, you can move on to the next section. This will only take a moment.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-017.png?featherlight=false&width=90pc)
#### Expose the **/tripsfromcity** RESTful API endpoint

The first path we exposed was quite simple - **/trips** gets all the trips in the system. But we know our source code implementation allows us to specify a filter to query for trips that originate from a particular city or have a particular destination, so we want to expose this functionality to our API consumers. First, we will expose the **/tripsfromcity** path.

18. In the **Resources** section, click **/**
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-018.png?featherlight=false&width=90pc)
19. In the **Resource Name** section, type ```tripsfromcity```
* Select **Enable API Gateway CORS**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-019.png?featherlight=false&width=90pc)
20. Our call into the Lambda function requires a city parameter. We will follow the standard pattern for RESTful interfaces, and pass this parameter in as a URL parameter. Select **/tripsfromcity**
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-020.png?featherlight=false&width=90pc)
21. In the **Resource Name** section, type ```{city}```
* In the **Resource Path** section, delete the default and replace with ```{city}```
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-021.png?featherlight=false&width=90pc)
22. Click **/{city}**
* Click **Actions**
* Click **Create Method**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-022.png?featherlight=false&width=90pc)
23. In the dropdown list that appears, select **GET**
* Click the grey tick next to the dropdown list to commit the change.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-023.png?featherlight=false&width=90pc)
24. In the **Lambda Region** section, select your **Region**
* In the **Lambda Function** section, type ```idevelop``` and select **idevelopTripSearchFromCity**
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-024.png?featherlight=false&width=90pc)
25. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-025.png?featherlight=false&width=90pc)
26. When the method is created, you will see the **Method Execution** panel. as before for the /trips resource. We can’t go ahead and test the API call just yet, because we need to transform the request through API Gateway so that the city parameter is passed through to the Lambda function correctly.

The **devlounge.lambda.FindTripsFromCityHandler** handler expects to see the input data in this JSON format:
```
{
	"payload" : 
	{
        "city": "Melbourne"
    }
}
```
{{% notice note %}} 
This would cause the Lambda function to search DynamoDB for all trips that originate from Melbourne. We need to add a **Body Mapping Template** for this method in API Gateway to correctly transform the request into this format.
{{% /notice %}}
* Click **Integration Request**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-026.png?featherlight=false&width=90pc)
27. Click **Mapping Templates**
* Click **When there are no templates defined (recommended)**
* Click **Add mapping template**
* In the **Content-Type** section , type ```application/json```
* Click the grey tick icon to commit the change.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-027.png?featherlight=false&width=90pc)
28. Scroll further down to show the mapping template entry text field. Paste in the following template:
```
{
    "payload" : {
        "city": "$input.params('city')"
    }
}
```
{{% notice info %}} 
This template will take the parameter **{city}** from the URL and add it into a JSON payload that is sent to the Lambda function, as a property of the payload object, just as the Lambda function expects.
{{% /notice %}}
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-028.png?featherlight=false&width=90pc)

{{% notice note %}} 
The schema defined here for this Lambda function is completely arbitrary, and in your own application you could use a completely different model. The mapping template gives you the flexibility to transform the inbound data on-the-fly through the API Gateway endpoint.
{{% /notice %}}

29. Click **Method Execution**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-029.png?featherlight=false&width=90pc)
30. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-030.png?featherlight=false&width=90pc)
31. In the **Path** section, in **{city}** field, type ```Melbourne```
* Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-031.png?featherlight=false&width=90pc)
32. API Gateway will make the call into the Lambda function, passing the value Melbourne into the Body Mapping Template you have defined, which will insert the search parameter Melbourne into the JSON payload that is sent to the Lambda function. This will cause the function handler to consume the JSON and execute a search in the DynamoDB table, and return the results. You will see a result similar to this:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-032.png?featherlight=false&width=90pc)
33. Select **/{city}** in **/tripsfromcity** section
* Click **Actions**
* Click **Enable CORS**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-033.png?featherlight=false&width=90pc)
34. Click **Enable CORS and replace existing CORS headers**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-034.png?featherlight=false&width=90pc)
35. Click **Yes, replace existing values**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-035.png?featherlight=false&width=90pc)
36. When each of the listed items have a green tick against them, you can move on to the next section. This will only take a moment.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-036.png?featherlight=false&width=90pc)
37. Click **/** in **Resources** section
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-037.png?featherlight=false&width=90pc)
38. In the **Resource Name** section, type ```tripstocity```
* Select **Enable API Gateway CORS**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-038.png?featherlight=false&width=90pc)
39. Our call into the Lambda function requires a **city** parameter. We will follow the standard pattern for RESTful interfaces, and pass this parameter in as a URL parameter. Click **/tripstocity**
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-039.png?featherlight=false&width=90pc)
40. In the **Resource Name** section, type ```{city}```
* In the **Resource Path** section, delete the default and replace with ```{city}```
* Select **Enable API Gateway CORS**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-040.png?featherlight=false&width=90pc)
41. Click **/{city}** in the section **/tripstocity**
* Click **Actions**
* Click **Create Method**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-041.png?featherlight=false&width=90pc)
42. In the dropdown list that appears, select **GET**
* Click the grey tick next to the dropdown list to commit the change.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-042.png?featherlight=false&width=90pc)
43. In the **Lambda Region** section, select your **Region**
* In the **Lambda Function** section, type ```idevelop``` and select **idevelopTripSearchToCity**
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-043.png?featherlight=false&width=90pc)
44. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-044.png?featherlight=false&width=90pc)
45. When the method is created, you will see the **Method Execution** panel, as before for the /tripsfromcity resource. We again need to transform the request through API Gateway so that the city parameter is passed through to the Lambda function correctly, before we can test this API call.

The **devlounge.lambda.FindTripsToCityHandler** handler expects to see the input data in this JSON format:
```
{
	"payload" : 
	{
        "city": "Melbourne"
    }
}
```
{{% notice note %}} 
This would cause the Lambda function to search DynamoDB for all trips that have Melbourne as a destination. We need to add a **Mapping Template** for this method in API Gateway to correctly transform the request into this format.
{{% /notice %}}
* Click **Integration Request**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-045.png?featherlight=false&width=90pc)
46. Click **Mapping Templates**
* Select **When there are no templates defined (recommended)**
* Click **Add mapping template**
* In the **Content-Type** section, type ```application/json```
* Click the grey tick to commit the change
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-046.png?featherlight=false&width=90pc)
47.  Scroll further down to show the mapping template entry text field. Paste in the following template:
```
{
    "payload" : {
        "city": "$input.params('city')"
    }
}
```
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-047.png?featherlight=false&width=90pc)
49. Click **Method Execution**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-048.png?featherlight=false&width=90pc)
50. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-049.png?featherlight=false&width=90pc)
51. In the **Path** section, in the **{city}** field, type ```Melbourne```
* Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-050.png?featherlight=false&width=90pc)
52. API Gateway will make the call into the Lambda function, passing the value Melbourne into the Body Mapping Template you have defined, which will insert the search parameter Melbourne into the JSON payload that is sent to the Lambda function. This will cause the function handler to consume the JSON and execute a search in the DynamoDB table, and return the results. You will see a result similar to this:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-051.png?featherlight=false&width=90pc)
53. Click **/{city}** in **/tripstocity** section
* Click **Actions**
* Click **Enable CORS**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-052.png?featherlight=false&width=90pc)
54. Click **Enable CORS and replace existing CORS headers**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-053.png?featherlight=false&width=90pc)
55. Click **Yes, replace existing values**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-054.png?featherlight=false&width=90pc)
56. When each of the listed items have a green tick against them, you can move on to the next section. This will only take a moment.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-055.png?featherlight=false&width=90pc)
57. If you have completed the steps above as described, you will have a resources tree that looks like this:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-056.png?featherlight=false&width=90pc)

#### Deploy the API and test

58. Now that you have confirmed that the microservices are functioning correctly, you are ready to deploy the API and test it from the publicly available endpoint. In the **Resources** section, click **/**
* Click **Actions**
* Click **Deploy API**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-057.png?featherlight=false&width=90pc)
59. In the **Deployment stage** section, select **[New Stage]** to create a new deployment stage.
* In the **Stage name** section, type ```prod```
* In the **Stage description** section, type ```Trips API```
* In the **Deployment description** section, type ```Initial deployment```
* Click **Deploy**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-058.png?featherlight=false&width=90pc)
60. The new stage **prod** will be created and you will see the **prod Stage Editor**
* Click **Invoke URL**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-059.png?featherlight=false&width=90pc)
61. A new window will open and hit the stage endpoint. You will see an error message stating **{"message":"Missing Authentication Token"}**. This is because there is no handler for the root of the stage - you have only defined resources/methods beneath the **/trips**, **/tripsfromcity** and **/tripstocity**paths.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-060.png?featherlight=false&width=90pc)
62. Edit the URL in the URL bar of the browser and append **/trips** then press **Enter**. The page will refresh, and then display all of the available trips as JSON. The output will be similar to this:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-061.png?featherlight=false&width=90pc)
63. Test the **/tripsfromcity** method, use ```/tripsfromcity/Melbourne``` to search for all trips that leave from Melbourne.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-062.png?featherlight=false&width=90pc)
64. Test the **/tripstocity** method, use ```/tripstocity/Melbourne``` to search for all trips that go to Melbourne.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-063.png?featherlight=false&width=90pc)

NIf the data looks right, and there are no errors, you are ready to move on to the next exercise.

#### Use CloudFormation/SAM via the AWS CLI to deploy the HotelSearch microservice

In the previous steps, you manually deployed and configured the **TripSearch** microservice, including the Lambda functions and API Gateway resources. You will have noticed that there are quite a few steps required, and doing this manually is time consuming and prone to errors. In this step, you will use the AWS CLI and CloudFormation/SAM to deploy the **HotelSearch** microservice, instead of manually deploying the resources.

By using CloudFormation/SAM, many of the manual steps will be taken care of for you, streamlining the deployment process. You will still have to manually trigger the process, but the actual deployment will be automated.

The **HotelSpecials** microservice needs to access a MySQL database to retrieve the hotel specials data. The lab environment has automatically deployed and seeded a database for you, and the connection details are provided in Cloudformation Outputs tab with instructions below on where to update the placeholder in the template you will use to deploy the microservice. The MySQL instance has been deployed using Amazon RDS and is not publicly-accessible since it is launched in a private subnet. Therefore, for the Lambda function to be able to connect to the database, the Lambda function will also need to be deployed into a private subnet by enabling VPC Integration. The template.yml file provided has all the required setup to do this, you just need to update the placeholders as per the below instructions.

{{%attachments title="HotelSpecials Project" style="orange" pattern="HotelSpecials.zip"/%}}

65. Download the **HotelSpecials.zip** file and extract
66. Open **Command Prompt** and navigate to the directory of the **HotelSpecials** project was extracted in step 65
* Execute the following command:
```
set AWS_PROFILE=devaxacademy
mvn package shade:shade
```
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-064.png?featherlight=false&width=60pc)
67. When the target JAR is built, whick is in the **target** folder of the project and whose name is **hotelspecials-1.0.0.jar**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-065.png?featherlight=false&width=60pc)
68. Go to [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).
* Click **Stack**.
* Type ```DevAx-06``` to the search bar and press **Enter**.
* Click **DevAx-06**.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-066.png?featherlight=false&width=90pc)
69. Click tab **Output**
* Save the value of **DatabaseSecurityGroup**, **DatabaseSubnet1**, **DatabaseSubnet2**, **RDSEndpoint** and **S3BucketLambdaCodeBucketName** to use in the next step.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-067.png?featherlight=false&width=90pc)
70. In the Eclipse IDE, open the **template.yml** file
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-068.png?featherlight=false&width=90pc)
71. Replace **\<DatabaseSecurityGroup\>** by the **DatabaseSecurityGroup** value we saved in step 69
* Replace **\<DatabaseSubnet1\>** by the **DatabaseSubnet1** value we saved in step 69
* Replace **\<DatabaseSubnet2\>** by the **DatabaseSubnet2** value we saved in step 69
* Replace **\<RDSEndpoint\>** by the **RDSEndpoint** value we saved in step 69
* Save
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-069.png?featherlight=false&width=90pc)
72. In the **Command Prompt**, execute the following command to package the Lambda function
```
aws cloudformation package --template template.yml --s3-bucket <S3BucketLambdaCodeBucketName> --output-template template-export.yml
```
{{% notice note %}} 
Replace **\<S3BucketLambdaCodeBucketName\>** by the **S3BucketLambdaCodeBucketName** value we saved in step 69
{{% /notice %}}
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-070.png?featherlight=false&width=60pc)
{{% notice info %}} 
The command will upload the build artefact to the S3 bucket, and then update the **template.yml** pointer to the code artefact on S3, and write out a new template with this update included, to a file called **template-export.yml**\
It will take a moment or two for the upload of the artefact to complete.
{{% /notice %}}
73. Execute the following command to create and deploy a **CloudFormation Change Set**
```
aws cloudformation deploy --template-file template-export.yml --stack-name HotelSpecialsAPI --capabilities CAPABILITY_IAM
```
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-071.png?featherlight=false&width=60pc)
74. Go to [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).
* Click **Stack**.
* You will see the **HotelSpecialsAPI** stack. This indicates that the CloudFormation Change Set has been created. The command you issued will create the Change Set and then automatically execute the Change Set. It will take a few moments to complete the execution
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-072.png?featherlight=false&width=90pc)
75. Select **HotelSpecialsAPI** stack, click tab **Events** and eview the steps that the CloudFormation template has applied to your environment. These will match the resources and actions in the **template-output.yml** file.
76. Go to [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Click **iDevelop - Hotel Specials API**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-073.png?featherlight=false&width=90pc)
77. Click **Get**
* Click **Integration Request**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-074.png?featherlight=false&width=90pc)
78. The **Integration Request** panel will be shown. **Lambda Function** specified:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-075.png?featherlight=false&width=90pc)

The specified value is not a Lambda function, but instead, is a **Stage Variable** that will be replaced at runtime by API Gateway. Therefore, in order for this API call to succeed, the **Stage** in API Gateway must have defined a value for the **envHotelSpecials** stage variable.

79. Click **Stages**
* Click **prod**
* Click tab **Stage Variables**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-076.png?featherlight=false&width=90pc)
{{% notice info %}} 
a single variable is defined - **envHotelSpecials** - which correlates to the stage variable name the GET method was expecting. The value of the variable is **GetHotelSpecials** which is the name of the Lambda function that the template created using the JAR file you built and uploaded during the package/deploy process.
{{% /notice %}}

#### Test the HotelSpecials API

80. Expand the **prod** root element in the Stages list to reveal the hierarchy.
* Click **Get**
* Click **Invoke URL**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-077.png?featherlight=false&width=90pc)
81. After a moment while the Lambda function is initialised, you should see the JSON result of querying the mySQL database from the Lambda function
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-078.png?featherlight=false&width=90pc)

If you see a JSON payload with no errors, you have successfully deployed an API and supporting Lambda function that queries the mySQL database. Notice how much quicker and easier that was to deploy without any manual intervention? That is the power of automation. In the next exercise, we will take this one step further, using the (now familiar) CI/CD pipeline approach to deploy our next API.