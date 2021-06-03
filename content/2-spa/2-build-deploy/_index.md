+++
title = "Serverless Microservices"
date = 2021
weight = 2
chapter = false
pre = "<b>2.2. </b>"
+++

**Manually Build and Deploy a Serverless Microservice**

In this exercise, you will manually create and configure a serverless microservice. As you progress through this lab, you will use other techniques for build and deployment, so that you can compare and contrast the efficiencies of each approach and how automation makes the development experience more agile and increases developer efficiency.

You will create the TripSearch microservice manually. The TripSearch microservice exposes the following functions:

> - **/trips** - returns a list of all available trips in the system
> - **/tripsfromcity** - returns a list of all trips that originate from a given city
> - **/tripstocity** - returns a list of all trips that have the given city as a destination

This is the same microservice we looked at in a previous lab. But this time, we will expose this functionality in our TravelBuddy website, and so need to deploy the service to be available to the website. Previously, the API Gateway configuration was taken care of for you by the deployment pipeline - in this exercise, you will manually configure the setup of both the Lambda function and the API Gateway.

**Contents**
- [Download source code and build the deployment artefact](#download-source-code-and-build-the-deployment-artefact)
- [Why am I seeing the message **AWS X-ray unavailable - ignoring** in the output?](#why-am-i-seeing-the-message-aws-x-ray-unavailable---ignoring-in-the-output)
- [Create two new Lambda functions using the same deployment artefact](#create-two-new-lambda-functions-using-the-same-deployment-artefact)

#### Download source code and build the deployment artefact

1. The lab setup has created an **S3 bucket** for you to store the **deployment artefact** for the Lambda function for the **TripSearch microservice**. First, you need to test and build the deployment package.\
Download the source code bundle from [TripSearchFull.zip](https://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchFull.zip) and explode the zip file onto your filesystem. You can do this in your own operating system, the windows system or cloud9 as your options. The following command will download the bundle for you:

```bash
curl -L http://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchFull.zip --output TripSearchFull.zip
```

Or download below:

{{%attachments title="Source code bundle" pattern=".*(zip)"/%}}

2. ```cd``` into the filesystem location where you exploded the **TripSearchFull** source code, and run the unit test by issuing one of the following commands:

**For MacOS:**
```bash
export DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors; mvn test
```

**For Windows:**
```bash
set DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors
mvn test
```

**For Cloud9 - if not already setup:**
```bash
set DDB_TAB
sudo yum install -y java-1.8.0-openjdk-devel
sudo alternatives --config java #enter 1.8 version #enter 2
sudo alternatives --config javac #enter 1.8 version #enter 2
sudo yum remove -y java-1.7.0-openjdk-devel
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

**Run test for Cloud9:**

```bash
export DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors; mvn test
```

{{% notice tip %}}
If the tests **fail**, First try to export you profile as the default profile e.g. **On Windows:** ```set AWS_PROFILE=devaxacademy``` | **On Mac:** ```export AWS_PROFILE=devaxacademy```
{{% /notice %}}

{{% notice tip %}}
If the tests continue to **fail**, it may be because the lab environment hasn’t yet finished creating. Check that the Lab is **fully running** before continuing.
{{% /notice %}}

{{% notice tip %}}
If the tests **fail** and the first error message is **"Unable to load AWS credentials from any provider in the chain"**. Make sure to set your **AWS CLI credentials**.
{{% /notice %}}

This command sets the table name for the DynamoDB table to match the name of the table set by the lab setup. You will see output like the following:
```bash
2021-03-30 18:03:55 <> WARN  BasicProfileConfigLoader:96 - The legacy profile format requires the 'profile ' prefix before the profile name. The latest code does not require
 such prefix, and will consider it as part of the profile name. Please remove the prefix if you are seeing this warning.
EnvVar DDB_TABLENAME_TRIPSECTOR detected - overriding DDB TableName to TravelBuddyTripSectors
AWS X-ray unavailable - ignoring
Found 52 total trips.
Sun Jun 20 23:52:23 UTC 2021 > Melbourne to Geelong on Qantas
Tue Jun 15 02:12:51 UTC 2021 > Geelong to Brisbane on Qantas
Tue Aug 17 20:29:29 UTC 2021 > Melbourne to Cairo on Qantas
Sat Mar 12 23:18:51 UTC 2022 > Sydney to Singapore on Qantas
Thu May 27 02:55:51 UTC 2021 > Perth to Hobart on Qantas
.....<omitted>
Starting devlounge.lambda.FindTripsFromCityHandler Lambda with input Melbourne

AWS X-ray unavailable - ignoring
Found 8 total trips.

Sun Jun 20 23:52:23 UTC 2021 > Melbourne to Geelong on Qantas
Tue Aug 17 20:29:29 UTC 2021 > Melbourne to Cairo on Qantas
Tue Jun 08 04:55:44 UTC 2021 > Melbourne to Dallas on Qantas
Thu Dec 09 22:15:45 UTC 2021 > Melbourne to Singapore on Qantas
Tue Jun 15 06:55:59 UTC 2021 > Melbourne to Broome on Qantas
Sun Dec 19 18:06:06 UTC 2021 > Melbourne to Geelong on Qantas
Fri Apr 09 05:45:41 UTC 2021 > Melbourne to Newcastle on Qantas
Sun Apr 03 15:19:34 UTC 2022 > Melbourne to Sydney on Qantas
Starting devlounge.lambda.FindTripsToCityHandler Lambda with city Sydney

AWS X-ray unavailable - ignoring
Found 2 total trips.

Mon Feb 28 19:39:13 UTC 2022 > Perth to Sydney on Qantas
Sun Apr 03 15:19:34 UTC 2022 > Melbourne to Sydney on Qantas
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 2.111 sec

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
```

{{% notice note %}}
Note that the from and to city examples shown here, and the dates and times, will be different for your environment because they have been randomly generated.
{{% /notice %}}

{{% notice info %}}
You should see no errors emitted by the unit test, which confirms the source code is building and running as expected. If you see an error, investigate.
{{% /notice %}}

#### Why am I seeing the message **AWS X-ray unavailable - ignoring** in the output?

When you run the tests on your local development environment, the AWS X-ray agent is not available, and so the calls through the AWS SDK cannot be recorded with AWS X-ray. However, since the ```pom.xml``` file defines a dependency to the AWS X-ray recorder, all calls through the SDK (for example, to DynamoDB) are attempted to be recorded. This would normally cause an error, and the tests would fail.

Notice that each of the Lambda handler classes extend a base class called **LambdaHandlerWithXRayBase**? In this class, there is a static initializer, and it builds **ContextMissingStrategy object**, overrides the behaviour for when there is no AWS X-ray context, and sets this as the default behaviour. In the implementation of the **contextMissing handler**, we simply print a message to the console, rather than the default action, which is to throw an exception. The implementation of the **LambdaHandlerWithXRayBase class** looks like this:

```java
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

As an optional experiment, you could try removing the static initializer from the **LambdaHandlerWithXRayBase base class**, and re-running the Maven build. You will see errors such as:

```bash
com.amazonaws.xray.exceptions.SegmentNotFoundException: Thread failed to begin a subsegment: segment not found. Verify that a segment is in progress, and that the SegmentContextResolverChain is configured correctly in order to discover the segment.
```

Without the agent being present, and the call to the Lambda function having the correct correlation Id context passed to it, the **SegmentContextResolverChain** cannot determine the AWS X-ray segment to attach the recorded metadata to, and throws an exception. The implementation we provide in the base class overrides this behaviour, to safely ignore this condition while testing on your development environment.

3. If the unit test run is succeeding, you are ready to build the deployment artefact. From the command line, issue the following:

```bash
mvn package shade:shade
```

4. The deployment artefact (JAR file) will be built and stored in ```./target/tripsearch-1.0.0.jar```

In order to create an AWS Lambda function from this JAR file, you need to push the build artefact up to the **S3BucketLambdaCode S3 bucket** that is accessible by the AWS Lambda environment in the **same region** the Lambda function will be created in. Execute the following command after replacing the relevant parameters noted below:

```bash
aws s3 cp target/tripsearch-1.0.0.jar s3://<S3BucketLambdaCode> --region ap-northeast-1
```

Replace the with the value shown in **Cloudformation Outputs** tab for the key **S3BucketLambdaCodeBucketName**. **Do not** include the \**<** and \**>** symbols.

5. Create a new Lambda function from this deployment artefact, by issuing the following command after replacing the relevant parameters noted below:

```bash
aws lambda create-function --function-name idevelopTripSearchFull --runtime java8 --role <LambdaRole> --handler devlounge.lambda.FindAllTripsHandler --code S3Bucket=<S3BucketLambdaCode>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindAllTrips" --memory-size 1024 --region ap-northeast-1
```

Replace the with the value shown in **Cloudformation Outputs** tab for the key **S3BucketLambdaCodeBucketName**. Replace the with the value shown in **Cloudformation Outputs** tab for the key **LambdaRoleARN**.

**Do not** include the **\<** and **\>** symbols.

If successful, your new Lambda function will be created and you will see an output similar to the following:

```bash
{
    "FunctionName": "idevelopTripSearchFull",
    "FunctionArn": "arn:aws:lambda:ap-northeast-1:XXXXXXXXXXXX:function:idevelopTripSearchFull",
    "Runtime": "java8",
    "Role": "arn:aws:iam::XXXXXXXXXXXX:role/LambdaRole",
    "Handler": "devlounge.lambda.FindAllTripsHandler",
    "CodeSize": 9737054,
    "Description": "TravelBuddy TripSearch microservice - FindAllTrips",
    "Timeout": 15,
    "MemorySize": 1024,
    "LastModified": "2021-03-30T18:10:38.011+0000",
    "CodeSha256": "EGhfTqT/kThg05Ibn8ivLWcKSabLZtIh/t3brnmvyHA=",
    "Version": "$LATEST",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "4fdee380-f0ce-4e1e-ab1e-d42e74e89308",
    "State": "Active",
    "LastUpdateStatus": "Successful",
    "PackageType": "Zip"
}
```

#### Create two new Lambda functions using the same deployment artefact

The code that implements our TripSearch function has three handlers exposed - one for finding all trips; one for finding trips that originate from a given city; and one for finding trips that have a given city as the destination. We have exposed only one handler so far - the search for all trips. In this section, we will create two new Lambda functions, each exposing one of the two remaining handlers.

6. Create a new Lambda function from the same deployment artefact we previously uploaded. We can create different Lambda functions from the same artefact because the artefact exports multiple Lambda handlers. In the step above, we exposed **devlounge.lambda.FindAllTripsHandler**. In this step we expose **devlounge.lambda.FindTripsFromCityHandler**. We simply need to issue the same command as above, but change the handler we are exposing and give the Lambda function a unique name.

Issue the following command after replacing the relevant parameters noted below:

```bash
aws lambda create-function --function-name idevelopTripSearchFromCity --runtime java8 --role <LambdaRole> --handler devlounge.lambda.FindTripsFromCityHandler --code S3Bucket=<S3BucketLambdaCode>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsFromCity" --memory-size 1024 --region ap-northeast-1
```

Replace the with the value shown in **Cloudformation Outputs** tab for the key **S3BucketLambdaCodeBucketName**. Replace the with the value shown in **Cloudformation Outputs** tab for the key **LambdaRoleARN**.

Confirm that you receive a success response similar to the response when you successfully created the first Lambda function.

7. Create the last Lambda function from the same deployment artefact, this time for **FindTripsToCity**. As per the previous step, we are exposing an additional handler, this time **devlounge.lambda.FindTripsToCityHandler**.

Issue the following command after replacing the relevant parameters noted below:

```bash
aws lambda create-function --function-name idevelopFindTripsToCity --runtime java8 --role <LambdaRole> --handler devlounge.lambda.FindTripsToCityHandler --code S3Bucket=<S3BucketLambdaCode>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsToCity" --memory-size 1024 --region ap-northeast-1
```

Replace the with the value shown in **Cloudformation Outputs** tab for the key **S3BucketLambdaCodeBucketName**. Replace the with the value shown in **Cloudformation Outputs** tab for the key **LambdaRoleARN**.

Confirm that you receive a success response similar to the response when you successfully created the Lambda function.