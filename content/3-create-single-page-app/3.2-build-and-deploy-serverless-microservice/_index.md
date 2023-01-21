+++
title = "Manually Build And Deploy A Serverless Microservice"
date = 2020
weight = 2
chapter = false
pre = "<b>3.2. </b>"
+++
#### Manually Build And Deploy A Serverless Microservice

In this exercise, you will manually create and configure a serverless microservice. As you progress through this lab, you will use other techniques for build and deployment, so that you can compare and contrast the efficiencies of each approach and how automation makes the development experience more agile and increases developer efficiency.


You will create the TripSearch microservice manually. The TripSearch microservice exposes the following functions:
* **/trips** - returns a list of all available trips in the system.
* **/tripsfromcity** - returns a list of all trips that originate from a given city
* **/tripstocity** - returns a list of all trips that have the given city as a destination

This is the same microservice we looked at in a previous lab. But this time, we will expose this functionality in our TravelBuddy website, and so need to deploy the service to be available to the website. Previously, the API Gateway configuration was taken care of for you by the deployment pipeline - in this exercise, you will manually configure the setup of both the Lambda function and the API Gateway.

#### Download source code and build the deployment artefact
{{%attachments title="TripSearchFull Project" style="orange" pattern="TripSearchFull.zip"/%}}
1. Download **TripSearchFull.zip** file and extract
2. Open **Command Prompt** and navigate to the directory of the **TripSearchFull** project was extracted in step 1
* Execute the below command:
```
set AWS_PROFILE=devaxacademy
set DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors
mvn test
```
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-001.png?featherlight=false&width=60pc)
3. You will see the following result:
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-002.png?featherlight=false&width=60pc)
{{% notice note %}} 
Note that the from and to city examples shown here, and the dates and times, will be different for your environment because they have been randomly generated.\
You should see no errors emitted by the unit test, which confirms the source code is building and running as expected. If you see an error, investigate.
{{% /notice %}}
#### Why am I seeing the message **AWS X-ray unavailable - ignoring** in the output?
When you run the tests on your local development environment, the AWS X-ray agent is not available, and so the calls through the AWS SDK cannot be recorded with AWS X-ray. However, since the **pom.xml** file defines a dependency to the AWS X-ray recorder, all calls through the SDK (for example, to DynamoDB) are attempted to be recorded. This would normally cause an error, and the tests would fail.

Notice that each of the Lambda handler classes extend a base class called **LambdaHandlerWithXRayBase**? In this class, there is a static initializer, and it builds **ContextMissingStrategy** object, overrides the behaviour for when there is no AWS X-ray context, and sets this as the default behaviour. In the implementation of the **contextMissing** handler, we simply print a message to the console, rather than the default action, which is to throw an exception. The implementation of the **LambdaHandlerWithXRayBase** class looks like this:
```
public class LambdaHandlerWithXRayBase 
{
	static  
	{
	  AWSXRayRecorderBuilder builder = AWSXRayRecorderBuilder.standard();

	  builder.withContextMissingStrategy(new ContextMissingStrategy() 
	  {		
		@Override
		public void contextMissing(String arg0, Class<? extends RuntimeException> arg1) 
		{ 
			System.out.println("AWS X-ray unavailable - ignoring"); 
		}	  
	  });

	  AWSXRay.setGlobalRecorder(builder.build());
	}
}
```
As an optional experiment, you could try removing the static initializer from the **LambdaHandlerWithXRayBase** base class, and re-running the Maven build. You will see errors such as:
```
com.amazonaws.xray.exceptions.SegmentNotFoundException: Thread failed to begin a subsegment: segment not found. Verify that a segment is in progress, and that the SegmentContextResolverChain is configured correctly in order to discover the segment.
```
Without the agent being present, and the call to the Lambda function having the correct correlation Id context passed to it, the **SegmentContextResolverChain** cannot determine the AWS X-ray segment to attach the recorded metadata to, and throws an exception. The implementation we provide in the base class overrides this behaviour, to safely ignore this condition while testing on your development environment.

4. If the unit test run is succeeding, Execute the command ```mvn package shade:shade``` to build
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-003.png?featherlight=false&width=60pc)
5. It will take a few moments to complete the build. When the target JAR is built, whick is in the folder **target** of the project and whose name is **tripsearch-1.0.0.jar**
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-004.png?featherlight=false&width=60pc)
6. Go to [**Amazon CloudFormation Console**](https://console.aws.amazon.com/cloudformation/home).
* Click **Stacks**
* Type ```DevAx-06``` in the search bar and press **Enter**
* Click **DevAx-06**
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-010.png?featherlight=false&width=90pc)
7. Click tab **Outputs**
* Save the value **LambdaRoleARN** and **S3BucketLambdaCodeBucketName** to use in the next step
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-011.png?featherlight=false&width=90pc)
8. In **Command Prompt**, execute the below command
```
aws s3 cp target/tripsearch-1.0.0.jar s3://<S3BucketLambdaCodeBucketName> --region <YOUR_REGION>
```
{{% notice note %}} 
Replace **\<S3BucketLambdaCodeBucketName\>** by the value **S3BucketLambdaCodeBucketName** we saved in step 7\
Replace **<YOUR_REGION>** by your **Region**
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-005.png?featherlight=false&width=60pc)
9. Execute the following command to create a new Lambda function from this deployment artefact
```
aws lambda create-function --function-name idevelopTripSearchFull --runtime java8 --role <LambdaRoleARN> --handler devlounge.lambda.FindAllTripsHandler --code S3Bucket=<S3BucketLambdaCodeBucketName>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindAllTrips" --memory-size 1024 --region <YOUR_REGION>
```
{{% notice note %}} 
Replace **\<LambdaRoleARN\>** by the value **LambdaRoleARN** we saved in step 7\
Replace **\<S3BucketLambdaCodeBucketName\>** by the value **S3BucketLambdaCodeBucketName** we saved in step 7\
Replace **<YOUR_REGION>** by your **Region**
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-006.png?featherlight=false&width=60pc)
10. If successful, your new Lambda function will be created and you will see an output similar to the following:
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-007.png?featherlight=false&width=60pc)
#### Create two new Lambda functions using the same deployment artefact

The code that implements our TripSearch function has three handlers exposed - one for finding all trips; one for finding trips that originate from a given city; and one for finding trips that have a given city as the destination. We have exposed only one handler so far - the search for all trips. In this section, we will create two new Lambda functions, each exposing one of the two remaining handlers.

11. Create a new Lambda function from the same deployment artefact we previously uploaded. We can create different Lambda functions from the same artefact because the artefact exports multiple Lambda handlers. In the step above, we exposed **devlounge.lambda.FindAllTripsHandler**. In this step we expose **devlounge.lambda.FindTripsFromCityHandler**. Execute the following command:
```
aws lambda create-function --function-name idevelopTripSearchFromCity --runtime java8 --role <LambdaRoleARN> --handler devlounge.lambda.FindTripsFromCityHandler --code S3Bucket=<S3BucketLambdaCodeBucketName>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsFromCity" --memory-size 1024 --region <YOUR_REGION>
```
{{% notice note %}} 
Replace **\<LambdaRoleARN\>** by the value **LambdaRoleARN** we saved in step 7\
Replace **\<S3BucketLambdaCodeBucketName\>** by the value **S3BucketLambdaCodeBucketName** we saved in step 7\
Replace **<YOUR_REGION>** by your **Region**
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-008.png?featherlight=false&width=60pc)
12. Create the last Lambda function from the same deployment artefact, this time for **FindTripsToCity**. As per the previous step, we are exposing an additional handler, this time **devlounge.lambda.FindTripsToCityHandler**. Execute the following command:
```
aws lambda create-function --function-name idevelopFindTripsToCity --runtime java8 --role <LambdaRoleARN> --handler devlounge.lambda.FindTripsToCityHandler --code S3Bucket=<S3BucketLambdaCodeBucketName>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsToCity" --memory-size 1024 --region <YOUR_REGION>
```
{{% notice note %}} 
Replace **\<LambdaRoleARN\>** by the value **LambdaRoleARN** we saved in step 7\
Replace **\<S3BucketLambdaCodeBucketName\>** by the value **S3BucketLambdaCodeBucketName** we saved in step 7\
Replace **<YOUR_REGION>** by your **Region**
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-009.png?featherlight=false&width=60pc)
{{% notice note %}} 
Confirm that you receive a success response similar to the response when you successfully created the first Lambda function.
{{% /notice %}}