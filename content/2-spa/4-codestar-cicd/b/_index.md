+++
title = "AWS Cloud9 Environment"
date = 2021
weight = 2
chapter = false
pre = "<b>Option B. </b>"
+++

The next microservice we need for our **TravelBuddy serverless application** is the **FlightSpecials API**. We have seen **FlightSpecials** before in this course, so it should be familiar to you. It functions the same way as the **HotelSpecials API** in that it must be deployed with VPC integration so it can connect to the MySQL database to query for data. Instead of manually packaging and deploying this microservice, we will use CodeStar to build out a full CI/CD pipeline for us, as we have done in previous labs. So, since you have created CI/CD pipelines using AWS CodeStar a few times now, we are not going to provide you with full step-by-step instructions. If you need help, ask a Lab Assistant how to complete the tasks required to create a new CodeStar project and deploy the **FlightSpecials** code over the sample application provided by CodeStar.

**Contents**
- [Create a CI/CD pipeline with AWS CodeStar](#create-a-cicd-pipeline-with-aws-codestar)
- [Update placeholder parameters in the CloudFormation template](#update-placeholder-parameters-in-the-cloudformation-template)
- [Update the target AWS region in the swagger.yml API definition file](#update-the-target-aws-region-in-the-swaggeryml-api-definition-file)
- [Create CodeStar Project](#create-codestar-project)
- [AWS Cloud9 setup codecommit](#aws-cloud9-setup-codecommit)
- [Check changes into source control to trigger a deploy](#check-changes-into-source-control-to-trigger-a-deploy)
- [Test the FlightSpecials API](#test-the-flightspecials-api)


#### Create a CI/CD pipeline with AWS CodeStar

1. Create a new **AWS CodeStar Web Service project** targeting **Java** on **AWS Lambda**. Call the project ```FlightSpecialsAPI```. If you need help with this task, see the [CodeStar documentation](https://docs.aws.amazon.com/codestar/latest/userguide/how-to-create-project.html).
2. Create the CodeStar project from your **Cloud9 IDE**. See the [documentation](https://docs.aws.amazon.com/codestar/latest/userguide/setting-up-ide-ec.html).  Remember to add the ```git config helpers``` setup as below:

```bash
cd ~/environment
aws codestar create-project --generate-cli-skeleton | tee template.yml
```

This will create a ```template.yml``` file with the base skeleton. It requires details the following details to be updated. You can think of this as an overlay to create your CodeStar project, which will use the toolchain and zip file for your creation of the codestar project

   - S3 bucket name and key: This is the details for codestar deployment on where to grab the build for the pipeline.
   - Destination: This is the name of the codecommit repository or github repository, we are only using codecommit, but you can adapt this if you need to grab from your github repo.
   - Toolchain: this is a cloudformation template which sets up the required toolchain elements. It is the same as what has been done for you in eclipse, and will will create the following resources.
     - CodeCommit - s3bucket and policies to store the artifact
     - CodeCommit event - codecommit change occurs to action a new build
     - CodeBuild project - to build based off of the buildspec.yml
     - CodePipeline - project pipeline which will action all the required phases

3. Download and open the toolchain.yml file found here: [toolchain.yml](https://workshops.devax.academy/monoliths-to-microservices/module6/files/toolchain.yml)

We need to change the details for the toolchain.yml file to point to the correct docker container to be used. The docker container has all the pre-built requirements based on different requirements. In this website look for the one which will suit our JAVA 1.8, maven requirements. https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html

In the ```toolchain.yml``` look for the current container which will look as follows:

```yml
  CodeBuildProject:
    DependsOn:
    - CodeBuildPolicy
    Properties:
      Artifacts:
        Packaging: zip
        Type: codepipeline
      Cache:
        Type: S3
        Location: !Sub '${S3Bucket}/codebuildcache'
      Description: !Sub "AWS CodeStar created CodeBuild Project for ${ProjectId}"
      Environment:
        ComputeType: small
        # This environment variable informs AWS CodeBuild where it can retrieve your code artifact.
        # You can specify any other environment variables your buildspec.yml is looking for.
        EnvironmentVariables:
        - Name: S3_BUCKET
          Value: !Ref 'S3Bucket'
        # Replace this Docker image if necessary: https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
        Image: aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0
        Type: LINUX_CONTAINER
```

4. Change the image to be the version you need for java.

```bash
aws codebuild list-curated-environment-images
```

5. You could do this by also querying the **json** payload:

```bash
aws codebuild list-curated-environment-images --query "platforms[].languages[?language=='JAVA'].images"
```

6. Replace the latest one in the **toolchain.yml**: ```Image:aws/codebuild/eb-java-8-amazonlinux-64:2.4.3-1.0.0```

Remember to change these as newer versions are released to make sure you are using the latest.

The other part to review is how the cache and the ```buildspec``` works. Notice the cache component:

```yml
      Cache:
        Type: S3
        Location: !Sub '${S3Bucket}/codebuildcache'
```

This is setup to an S3 bucket, which is used in the setup for the ```buildspec.yml``` file - which is shown below:

```yml
cache:
  paths:
    - '/root/.m2/**/*'
```

7. You need to also provide the required service role to the template.yml you created. To get examples of this you can do the following:

```bash
aws codestar create-project help

# check the examples to get the service role : 
"roleArn": "arn:aws:iam::123456789012:role/service-role/aws-codestar-service-role"
```

8. Get the FlightSpecials.zip file and download it into your cloud9 environment, and unzip it. [FlightSpecials](https://workshops.devax.academy/monoliths-to-microservices/module6/files/FlightSpecials.zip)

{{%attachments title="FlightSpecials source code" pattern=".*(zip)"/%}}

#### Update placeholder parameters in the CloudFormation template

9. Edit the ```FlightSpecials/template_cloud9.yml``` and update the required parameters

{{% notice note %}}
If you are using eclipse you will need to have the CodeDeployRole as part of the parameters.
{{% /notice %}}

|     Item to replace     |                  Description                 |
|:-----------------------:|:--------------------------------------------:|
| <DatabaseSubnet1>       | First network subnet for the mySQL database  |
| <DatabaseSubnet2>       | Second network subnet for the mySQL database |
| <DatabaseSecurityGroup> | The security group for the mySQL database    |
| <RDSEndpoint>           | The mySQL database endpoint                  |

When you’ve completed updating the values, the **VPCConfig** section will look similar to this (with different values):

```yml
VpcConfig:
  SecurityGroupIds:
    - sg-858e61e3
  SubnetIds:
    - subnet-3c989d4a
    - subnet-a04255c4
Environment:
  Variables:
    JDBC_CONNECTION_STRING: jdbc:mysql://qlxx5jzrxxxby.cig0rzmdedgf.ap-northeast-1.rds.amazonaws.com:3306/travelbuddy?useSSL=false&serverTimezone=UTC&autoReconnect=true
    JDBC_UID: root
    JDBC_PWD: labpassword
```

#### Update the target AWS region in the swagger.yml API definition file

The ```swagger.yml``` file provided in the zip bundle is the definition for the API that exposes the microservice via Amazon API Gateway. It needs to be updated with details of your lab AWS Account Id and target AWS Region before you can deploy your microservice.

10. In the **Cloud9 IDE**, locate the ```swagger.yml``` file and open it in the text editor
11. Search for the text ```REPLACE_AWS_REGION``` and replace it with the region you are using (for example, ```ap-northeast-1```)
12. Search for the text ```REPLACE_AWS_ACCOUNTID``` and replace it with the your AWS Account Id. You can find your AWS Account Id in the lab dashboard.
13. Save the file.
14. When bundling the zip file to be used in codedeploy, you need to bundle from the source directory. To do this run the following:

```bash
cd ~/environment/FlightSpecials
zip -r ../FlightSpecials.zip *
```

15. Rezip the ```FlightSpecials.zip``` file with these updates.

```bash
cd ~/environment
rm FlightSpecials.zip
cd FlightSpecials
zip -r FlightSpecials.zip *
adding: buildspec.yml (deflated 53%)
  adding: copy_files.sh (deflated 63%)
  adding: pom.xml (deflated 75%)
  adding: src/ (stored 0%)
  adding: src/test/ (stored 0%)
  adding: src/test/java/ (stored 0%)
  adding: src/test/java/devlounge/ (stored 0%)
  adding: src/test/java/devlounge/lambda/ (stored 0%)
  adding: src/test/java/devlounge/lambda/test/ (stored 0%)
  adding: src/test/java/devlounge/lambda/test/TestContext.java (deflated 76%)
  adding: src/test/java/devlounge/lambda/test/TestUtils.java (deflated 79%)
  adding: src/test/java/devlounge/lambda/test/LambdaFunctionHandlerTest.java (deflated 57%)
  adding: src/main/ (stored 0%)
  adding: src/main/java/ (stored 0%)
  adding: src/main/java/devlounge/ (stored 0%)
  adding: src/main/java/devlounge/model/ (stored 0%)
  adding: src/main/java/devlounge/model/FlightSpecial.java (deflated 73%)
  adding: src/main/java/devlounge/model/LambdaResult.java (deflated 62%)
  adding: src/main/java/devlounge/lambda/ (stored 0%)
  adding: src/main/java/devlounge/lambda/FlightSpecialsHandler.java (deflated 65%)
  adding: swagger.yml (deflated 68%)
  adding: template-configuration.json (deflated 18%)
  adding: template.yml (deflated 65%)
```

{{% notice note %}}
Note that the directory **FlightSpecials** is now omitted which is very important to only have the actual code there that is required.
{{% /notice %}}

{{% notice note %}}
Note the directory structure here is **REALLY** important : https://docs.aws.amazon.com/codebuild/latest/userguide/getting-started-cli-upload-source-code.html
{{% /notice %}}

#### Create CodeStar Project

16. Copy the code over to the **FlightSpecials**. Your lab bucket will look something like this ```mod-9c10d0af24f74a4a-s3bucketlambdacode-vsuckr33vysr```

```bash
aws s3 cp FlightSpecials.zip s3://<Lambdabucket>
```

17. Copy the ```toolchain.yml``` to the **Lamdba bucket**

```bash
aws s3 cp toolchain.yml s3://<Lambdabucket>
```

18. Create the codepipeline template for **flightspecials**, which will look like this:

Change the **XXX** with your account details below for this to work.

```json
{
    "name": "flightspecials",
    "id": "flightspecials",
    "description": "flight specials java8 example using ci/cd",
    "sourceCode": [
        {
            "source": {
                "s3": {
                    "bucketName": "<Lambdabucket>",
                    "bucketKey": "FlightSpecials.zip"
                }
            },
            "destination": {
                "codeCommit": {
                    "name": "flightspecials"
                }
            }
        }
    ],
    "toolchain": {
        "source": {
            "s3": {
                "bucketName": "<Lambdabucket>",
                "bucketKey": "toolchain.yml"
            }
        },
        "roleArn": "arn:aws:iam::XXX:role/service-role/aws-codestar-service-role",
        "stackParameters": {
            "ProjectId": "flightspecials"
        }
    }
}
```

19. Create the **AWS Codestar project**:

```json
aws codestar create-project --cli-input-json file://template.json
{
    "arn": "arn:aws:codestar:ap-northeast-1:436753246579:project/flightspecials"
}
```

Now check the cloudformation has completed, the codecommit has created a repo, and the first build has been kicked off.

If any of these fail, look at the errors. You will need to remove the created s3 buckets and recreate if there are any issues. If you are changing any code for ```FlightSpecials.zip``` remember to resend this to the lambda bucket, and not just on the filesystem.

To see if all worked : ```aws codestar describe-project --id flightspecials```

#### AWS Cloud9 setup codecommit

Once you have created this, you need to setup your required git repo for codecommit you configured previously.

20. Move the original zip file, as this was just for the first upload, then setup required helper class and clone your repository.

```bash
mv FlightSpecials FlightSpecials_orig
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git clone https://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/flightspecials
cd flightspecials
```

**Give CloudFormation permission to create an IAM role**

As part of our microservice setup, we will be assigning a new IAM Role to our Lambda function to allow it to perform various tasks. When **CodeStar** created our project, it created an IAM Role that gave CloudFormation just enough permissions to deploy the **Hello World example** service. These permissions are not enough for our more advanced requirements. So we need to adjust the policies assigned to the **CloudFormation role**, to extend those permissions.

21. Open the **AWS IAM Console** in the browser.
22. Click **Roles** on the navigation pane.
23. In the **Filter** box, type ```CodeStarWorker-flightspecialsa-CloudFormation``` to locate the correct **IAM Role**.

{{% notice note %}}
If you can't find the role, it may be too early - CodeStar may still be provisioning the pipeline and may not yet have created the role. Check the progress of the provisioning in the CodeStar dashboard.
{{% /notice %}}

24. Click on the role to open the details panel.
25. Click **Attach Policy**, in the **Filter** box, type ```idevelop``` to shortlist the available policies. Select the ```idevelopCodeStarCloudFormationPolicy``` policy shown in the list. This policy has been created for you by the lab setup process, and has the permissions assigned to it to allow CloudFormation to work on our behalf when creating the Lambda execution role.
26. Select the listed policy and click **Attach Policy**

#### Check changes into source control to trigger a deploy

27.  Now that you have completed updating files, you need to add the changed files to your ```new-implementation``` git branch and commit the files. You can use the commandline in your Cloud9 IDE:
     - Issue ```git status``` to review the changed code files
     - Issue ```git add .``` to add in the changed files
     - Issue ```git commit -m "Baseline implementation"``` to commit the changes and provide a message
     - Issue ```git checkout master``` to switch back to the master branch
     - Now merge the changes for your new implementation into the master branch by issuing ```git merge new-implementation```
     - Issue ```git push``` to push the changes to **CodeCommit**.

It will take a few moments to push the code and commence the deployment. Checking in the source code and templates will trigger the pipeline to build and deploy the new implementation. AWS CodePipeline will now use CloudFormation to deploy the following resources:

While you have some time, spend a few minutes to explore the ```buildspec.yml```, ```swagger.yml``` and ```template.yml``` files which define the Amazon API Gateway, AWS Lambda function and the build/deployment process through AWS CodeBuild. You will notice that the ```builspec.yml``` file uses the same AWS CLI command to package the deployment that you used when you manually packaged the **HotelSpecials API** earlier 

{{% notice warning %}}
Do not execute these commands below, they are here as a reference!
{{% /notice %}}

```bash
mvn package shade:shade
aws cloudformation package --template template.yml --s3-bucket $S3_BUCKET --output-template template-export.yml
```

The ```template.yml``` file uses the **Serverless Application Model (SAM)** transform to define the REST API, as opposed to how we approached this in the **HotelSpecials API** example. In **HotelSpecials**, the **CloudFormation template** used canonical CloudFormation to define the REST API so that it could be explicit about the API definition and include the ```swagger``` definition inline. The **FlightSpecials** example uses a more declarative approach and left the details to SAM. You are free to mix CloudFormation and SAM in the same template, as you can see from these examples.

{{% notice note %}}
Note that the ```$S3_BUCKET``` environment variable is automatically replaced by CodeBuild when the build step is performed, and replaced by the S3 Bucket that CodeStar provisioned when it set up the project.
{{% /notice %}}

#### Test the FlightSpecials API

You can check the **status** of the deployment of the code change through the pipeline back on the CodeStar project dashboard. Once the deployment has completed through the CI/CD pipeline, you are ready to test the API.

28. Open the **API Gateway console** in the browser and under **APIs**, click the ```iDevelop - Flight Specials API``` link to reveal the resources for the API.
29. Click on the **Stages** link beneath the **iDevelop - Flight Specials API**.
30. Expand the **prod** root element in the **Stages** list to reveal the hierarchy.
31. Click on the **GET** method
32. Click on the **Invoke URL** value in the **prod - GET - /flightspecials** panel. After a moment while the Lambda function is initialised, you should see the JSON result of querying the mySQL database from the Lambda function. For example:

```json
{
	"succeeded": true,
	"message": "",
	"errorCode": 0,
	"data": [
        {
            "id": 1,
            "header": "London to Prague",
            "body": "Jewel of the East",
            "cost": 93,
            "expiryDate": 1504072439813
        }, 
        {
            "id": 2,
            "header": "Paris to London",
            "body": "Weekend getaway!",
            "cost": 182,
            "expiryDate": 1504074888702
        }
    ]
}
```

If you see a JSON payload with no errors, you have successfully deployed an API and supporting Lambda function that queries the mySQL database. Notice how much quicker and easier that was to deploy without any manual intervention, and you didn't even have to interact with the AWS CLI or Console? Everything was driven by the source control check-in process.

You are now ready to integrate these APIs with the **TravelBuddy** web site.
