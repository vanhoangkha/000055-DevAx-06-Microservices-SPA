+++
title = "Eclipse Environment"
date = 2021
weight = 1
chapter = false
pre = "<b>Option A. </b>"
+++

The next microservice we need for our **TravelBuddy serverless application** is the **FlightSpecials API**. We have seen **FlightSpecials** before in this course, so it should be familiar to you. It functions the same way as the **HotelSpecials API** in that it must be deployed with VPC integration so it can connect to the MySQL database to query for data. Instead of manually packaging and deploying this microservice, we will use CodeStar to build out a full CI/CD pipeline for us, as we have done in previous labs. So, since you have created CI/CD pipelines using AWS CodeStar a few times now, we are not going to provide you with full step-by-step instructions. If you need help, ask a Lab Assistant how to complete the tasks required to create a new CodeStar project and deploy the **FlightSpecials** code over the sample application provided by CodeStar.

**Contents**
- [Create a CI/CD pipeline with AWS CodeStar](#create-a-cicd-pipeline-with-aws-codestar)
- [Update placeholder parameters in the CloudFormation template](#update-placeholder-parameters-in-the-cloudformation-template)
- [Update the target AWS region in the swagger.yml API definition file](#update-the-target-aws-region-in-the-swaggeryml-api-definition-file)
- [Check changes into source control to trigger a deploy](#check-changes-into-source-control-to-trigger-a-deploy)
- [Test the FlightSpecials API](#test-the-flightspecials-api)

#### Create a CI/CD pipeline with AWS CodeStar

1. Create a new **AWS CodeStar Web Service project** targeting **Java** on **AWS Lambda**. Call the project ```FlightSpecialsAPI```. If you need help with this task, see the [CodeStar documentation](https://docs.aws.amazon.com/codestar/latest/userguide/how-to-create-project.html).
2. Import the **CodeStar project** into the **Eclipse IDE**. See the [documentation](https://docs.aws.amazon.com/codestar/latest/userguide/setting-up-ide-ec.html) if you need help with this. \
Remember, your **Git credentials** for this Lab are provided in **output** section of the **CloudFormation** template. \
If using **Cloud9** remember to add the ```git config helpers```.
3. Right-click [FlightSpecials](https://workshops.devax.academy/monoliths-to-microservices/module6/files/FlightSpecials.zip) and save the file to your local machine. Explode the ZIP file.

{{%attachments title="FlightSpecials source code" pattern=".*(zip)"/%}}

4. Create a **new branch** in git for the new implementation you are about to create. Call the new branch ```new-implementation```
5. Overwrite the implementation provided by CodeStar with the contents of the ZIP file you just exploded. We have provided a ```copy_files.sh``` script in the ```FlightSpecials.zip``` bundle that you can use, as before in previous lab exercises. To use it, run the below command by replacing ```path/to/your/working/folder``` E.G.:

```bash
copy_files.sh /path/to/your/working/folder
```

Don't forget to use the **Maven | Update Project** feature of the Eclipse IDE to 'rethink' the project after the change to the source code.

**Give CloudFormation permission to create an IAM role**

As part of our microservice setup, we will be assigning a new IAM Role to our Lambda function to allow it to perform various tasks. When **CodeStar** created our project, it created an IAM Role that gave CloudFormation just enough permissions to deploy the **Hello World example** service. These permissions are not enough for our more advanced requirements. So we need to adjust the policies assigned to the **CloudFormation role**, to extend those permissions.

6. Open the **AWS IAM Console** in the browser.
7. Click **Roles** on the navigation pane.
8. In the **Filter** box, type ```CodeStarWorker-flightspecialsa-CloudFormation``` to locate the correct **IAM Role**.

{{% notice note %}}
If you can't find the role, it may be too early - CodeStar may still be provisioning the pipeline and may not yet have created the role. Check the progress of the provisioning in the CodeStar dashboard.
{{% /notice %}}

9. Click on the role to open the details panel.
10. Click **Attach Policy**, in the **Filter** box, type ```idevelop``` to shortlist the available policies. Select the ```idevelopCodeStarCloudFormationPolicy``` policy shown in the list. This policy has been created for you by the lab setup process, and has the permissions assigned to it to allow CloudFormation to work on our behalf when creating the Lambda execution role.
11. Select the listed policy and click **Attach Policy**

#### Update placeholder parameters in the CloudFormation template

12. The CloudFormation template ```template.yml``` that was provided as part of the ```FlightSpecials.zip``` file has some placeholder values that you need to update to match the values from your lab account before you can deploy the updates. These include **Subnet Ids**, **Security Group Ids** and the **RDS Instance Endpoint**, which are unique to your lab account and unknown at this stage to the template.

In the **Eclipse IDE**, open the ```template.yml``` file and search for each of the items in the table below in the **Replace** column, and replace them with the values that are found in **Cloudformation Outputs** tab:

|     Item to replace     |                  Description                 |
|:-----------------------:|:--------------------------------------------:|
| \<DatabaseSubnet1\>       | First network subnet for the mySQL database  |
| \<DatabaseSubnet2\>       | Second network subnet for the mySQL database |
| \<DatabaseSecurityGroup\> | The security group for the mySQL database    |
| \<RDSEndpoint\>           | The mySQL database endpoint                  |

13. When you've completed updating the values, the **VPCConfig** section will look similar to this (with different values):

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

14. In the **Eclipse IDE**, locate the ```swagger.yml``` file and open it in the text editor
15. Search for the text ```REPLACE_AWS_REGION``` and replace it with the region you are using (for example, ```ap-northeast-1```)
16. Search for the text ```REPLACE_AWS_ACCOUNTID``` and replace it with the your AWS Account Id. You can find your AWS Account Id in the lab dashboard.
17. Save the file.

#### Check changes into source control to trigger a deploy

18. Now that you have completed updating files, you need to add the changed files to your ```new-implementation``` git branch and commit the files. You can use the Eclipse IDE or the commandline. In this example, we will use the commandline, but note for the final push you will need to use the Eclipse IDE since it is configured with your Git credentials, whereas the commandline has not:
    - Issue ```git status``` to review the changed code files
    - Issue ```git add .``` to add in the changed files
    - Issue ```git commit -m "Baseline implementation"``` to commit the changes and provide a message
    - Issue ```git checkout master``` to switch back to the master branch
    - Now merge the changes for your new implementation into the master branch by issuing ```git merge new-implementation```
    - Push the changes to **CodeCommit** using Eclipse by right-clicking the project **root** and click **Team | Push to Origin...**

![API Gateway](/images/2/34.png?width=90pc)

You need to perform the push from Eclipse because the git credentials are embedded within the Eclipse environment. You could also configure the command line environment with the git credentials but that is beyond the scope of this lab.

It will take a few moments to push the code and commence the deployment. Checking in the source code and templates will trigger the pipeline to build and deploy the new implementation. AWS CodePipeline will now use CloudFormation to deploy the following resources:

- The Lambda function implemented by the Java code you checked into CodeCommit
- IAM role for the Lambda function
- API Gateway configuration for the API

While you have some time, spend a few minutes to explore the ```buildspec.yml```, ```swagger.yml``` and ```template.yml``` files which define the Amazon API Gateway, AWS Lambda function and the build/deployment process through AWS CodeBuild. You will notice that the ```builspec.yml``` file uses the same AWS CLI command to package the deployment that you used when you manually packaged the **HotelSpecials API** earlier.

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

19. Open the **API Gateway console** in the browser and under **APIs**, click the ```iDevelop - Flight Specials API``` link to reveal the resources for the API.
20. Click on the **Stages** link beneath the **iDevelop - Flight Specials API**.
21. Expand the **prod** root element in the **Stages** list to reveal the hierarchy.
22. Click on the **GET** method
23. Click on the **Invoke URL** value in the **prod - GET - /flightspecials** panel. After a moment while the Lambda function is initialised, you should see the JSON result of querying the mySQL database from the Lambda function. For example:

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
