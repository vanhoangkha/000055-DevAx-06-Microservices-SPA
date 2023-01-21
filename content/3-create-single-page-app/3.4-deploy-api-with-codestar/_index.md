+++
title = "Deploy the api using code star and CI/CD"
date = 2020
weight = 4
chapter = false
pre = "<b>3.4. </b>"
+++
#### Create a CI/CD pipeline with AWS CodeStar

1. Go to [**AWS CodeStar Console**](https://console.aws.amazon.com/codesuite/codestar/home).
* Click **Projects**
* Click **Create project**
{{% notice note %}} 
Click **Create service role** if you never go to **AWS CodeStar Service** before.
{{% /notice %}}
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-001.png?featherlight=false&width=90pc)
2. In the **Templates** page, select **Java** and **AWS Lambda**
* Select **Java Spring**
* Click **Next**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-002.png?featherlight=false&width=90pc)
3. In the **Project name** section, type ```FlightSpecialsAPI```
* Click **Next**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-003.png?featherlight=false&width=90pc)
4. In the **Review** page, click **Create project**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-004.png?featherlight=false&width=90pc)
5. Add **awsstudent** account to the the team with **Owner** role.
* Click **Team**
* Click **Add team member**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-005.png?featherlight=false&width=90pc)
6. In the **Team member details** section
* In the **User** section, select **awsstudent**
* In the **Email address** section, type your **email**
* In the **Project role** section, select **Owner**
* CLick **Allow SSH access to project instances.**
* Click **Add team member**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-006.png?featherlight=false&width=90pc)
7. Check added team member
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-007.png?featherlight=false&width=90pc)
8. Go to [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).
* Click **Stack**.
* Type ```DevAx-06``` to the search bar and click **Enter**.
* Click **DevAx-06**.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-008.png?featherlight=false&width=90pc)
9. Click tab **Output**
* Save **GitPassword** value and **GitUserName** value to use in the next step.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-009.png?featherlight=false&width=90pc)
10. Open **Eclipse IDE**.
* Find the AWS Icon and click it to reveal the menu
* Click **Import AWS CodeStar Project…**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-010.png?featherlight=false&width=90pc)
11. Select your region
* Select ```FlightSpecialsAPI```
* Type the saved information in step 9 to **User name** section and **Password** section
* Click **Next**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-011.png?featherlight=false&width=90pc)
12. Click **OK**, ignore the error **org.eclipse.egit.ui.internal.repository.tree.RepositoryTreeNodeType.getIcon()Lorg/eclipse/swt/graphics/Image;**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-012.png?featherlight=false&width=90pc)
13. Select **master** branch and click **Next**.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-013.png?featherlight=false&width=90pc)
14. Click **Finish**. 
* Click **No** to skip setup password hint.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-014.png?featherlight=false&width=90pc)
15. Project sample was created by CodeStar was imported
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-015.png?featherlight=false&width=90pc)
16. Open **Command Prompt**, execute the below command to go to the directory where the IDE code is located and to create and switch to the new branch
```
cd C:\Users\Administrator\git\FlightSpecialsAPI
git checkout -b "new-implementation"
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-016.png?featherlight=false&width=60pc)

{{%attachments title="FlightSpecials Project" style="orange" pattern="FlightSpecials.zip"/%}}

17. Download the **FlightSpecials.zip** file and extract.
18. In the **Command Prompt**, navigate to the directory of the **FlightSpecials** folder we extracted in step 17
* Execute the following command to overwrite the implementation provided by CodeStar with the contents of the **FlightSpecials.zip** file we extracted in step 17. We have provided a **copy_files.sh** script in the **FlightSpecials.zip** bundle that you can use
```
copy_files.sh C:\Users\Administrator\git\FlightSpecialsAPI
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-017.png?featherlight=false&width=60pc)
19. In the Eclipse IDE, right-click on the **FlightSpecialsAPI** project we imported
* Click **Maven**
* Click **Update Project...**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-018.png?featherlight=false&width=90pc)
20. In the Eclipse IDE, open the **pom.xml** file
* After the line 113, add the following content
```
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot</artifactId>
			<version>2.0.3.RELEASE</version>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-autoconfigure</artifactId>
			<version>2.0.3.RELEASE</version>
		</dependency>
		<dependency>
    		<groupId>org.json</groupId>
    		<artifactId>json</artifactId>
    		<version>20180130</version>
		</dependency>
		<dependency>
			<groupId>com.amazonaws.serverless</groupId>
			<artifactId>aws-serverless-java-container-core</artifactId>
			<version>1.1.3</version>
		</dependency>
		<dependency>
			<groupId>org.junit.jupiter</groupId>
			<artifactId>junit-jupiter-api</artifactId>
			<version>5.2.0</version>
		</dependency>
```
* Save

#### Give CloudFormation permission to create an IAM role
21. Go to [**AWS IAM Console**](https://console.aws.amazon.com/iamv2/).
* Click **Roles**.
* Type ```CodeStarWorker-flightspecialsa-CloudFormation``` to the search bar and press **Enter**
* Click **CodeStarWorker-flightspecialsa-CloudFormation**. 
{{% notice note %}} 
If you can’t find the role, it may be too early - CodeStar may still be provisioning the pipeline and may not yet have created the role. Check the progress of the provisioning in the CodeStar dashboard.
{{% /notice %}}
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-019.png?featherlight=false&width=90pc)
22. Click **Add permissions**
* Click **Attach Policies**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-020.png?featherlight=false&width=90pc)
23. Type ```idevelop``` to the search bar and press **Enter**
* Select **idevelopCodeStarCloudFormationPolicy**
* Click **Attach Policies**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-021.png?featherlight=false&width=90pc)
#### Update placeholder parameters in the CloudFormation template
24. Trong Eclipse IDE, open the **template.yml** file
* Do the same step 68 and step 69 in the 3.3 section to get the **DatabaseSecurityGroup** value, the **DatabaseSubnet1** value, the **DatabaseSubnet2** value and the **RDSEndpoint** value
* Replace **\<DatabaseSecurityGroup\>** with the **DatabaseSecurityGroup** value
* Replace **\<DatabaseSubnet1\>** with the **DatabaseSubnet1** value
* Replace **\<DatabaseSubnet2\>** with the **DatabaseSubnet2** value
* Replace **\<RDSEndpoint\>** with the **RDSEndpoint** value
* Save
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-023.png?featherlight=false&width=90pc)
#### Update the target AWS region in the swagger.yml API definition file
The **swagger.yml** file provided in the zip bundle is the definition for the API that exposes the microservice via Amazon API Gateway. It needs to be updated with details of your lab AWS Account Id and target AWS Region before you can deploy your microservice.

25. In the Eclipse IDE, open the **swagger.yml** file
* Press **Ctrl+F** shortcut
* In the **Find** section, type ```REPLACE_AWS_REGION```
* In the **Replace with** section, type your **Region**
* Click **Replace All** to replace
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-025.png?featherlight=false&width=90pc)
26. In the **Find** section, type ```REPLACE_AWS_ACCOUNTID```
* In the **Replace with** section, type your **AWS Account Id**
* Click **Replace All** to replace
* Save
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-025b.png?featherlight=false&width=90pc)
27. Now that you have completed updating files, you need to add the changed files to your **new-implementation** git branch and commit the files.
* Open **Command Prompt**, execute the below command to navigate to the directory of the **FlightSpecialsAPI** folder and review the changed code files
```
cd C:\Users\Administrator\git\FlightSpecialsAPI
git status
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-026.png?featherlight=false&width=60pc)
28. Execute the below command to add in the changed files
```
git add .
git commit -m "Baseline implementation"
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-027.png?featherlight=false&width=60pc)
29. Execute the below command to switch back to the **master** branch
```
git checkout master
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-028.png?featherlight=false&width=60pc)
30. Execute the below command to merge the changes for your **new-implementation** branch into the **master** branch
```
git merge new-implementation
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-029.png?featherlight=false&width=60pc)
31. In the Eclipse IDE, right-click on the **FlightSpecialsAPI** project
* Click **Team** 
* Click **Push to origin**. 
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-030.png?featherlight=false&width=90pc)
32. Click **Close**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-031.png?featherlight=false&width=90pc)

You need to perform the push from Eclipse because the git credentials are embedded within the Eclipse environment. You could also configure the command line environment with the git credentials but that is beyond the scope of this lab.

It will take a few moments to push the code and commence the deployment. Checking in the source code and templates will trigger the pipeline to build and deploy the new implementation. AWS CodePipeline will now use CloudFormation to deploy the following resources:
* The Lambda function implemented by the Java code you checked into CodeCommit
* IAM role for the Lambda function
* API Gateway configuration for the API

While you have some time, spend a few minutes to explore the **buildspec.yml**, **swagger.yml** and **template.yml** files which define the Amazon API Gateway, AWS Lambda function and the build/deployment process through AWS CodeBuild. You will notice that the **builspec.yml** file uses the same AWS CLI command to package the deployment that you used when you manually packaged the **HotelSpecials API** earlier.

{{% notice warning %}} 
Do not execute these commands below, they are here as a reference!
{{% /notice %}}

```
mvn package shade:shade
aws cloudformation package --template template.yml --s3-bucket $S3_BUCKET --output-template template-export.yml
```

The **template.yml** file uses the **Serverless Application Model (SAM)** transform to define the REST API, as opposed to how we approached this in the **HotelSpecials API** example. In **HotelSpecials**, the **CloudFormation template** used canonical CloudFormation to define the REST API so that it could be explicit about the API definition and include the **swagger** definition inline. The **FlightSpecials** example uses a more declarative approach and left the details to SAM. You are free to mix CloudFormation and SAM in the same template, as you can see from these examples.

#### Test the FlightSpecials API

33. Go to [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Type **iDevelop - Flight Specials API** to the search bar and press **Enter**
* Click **iDevelop - Flight Specials API**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-032.png?featherlight=false&width=90pc)
34. Click **Stages**
* Expand the **prod** root element
* Click **GET**
* Click **Invoke URL**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-033.png?featherlight=false&width=90pc)
35. After a moment while the Lambda function is initialised, you should see the JSON result of querying the mySQL database from the Lambda function
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-034.png?featherlight=false&width=90pc)

If you see a JSON payload with no errors, you have successfully deployed an API and supporting Lambda function that queries the mySQL database. Notice how much quicker and easier that was to deploy without any manual intervention, and you didn’t even have to interact with the AWS CLI or Console? Everything was driven by the source control check-in process.

You are now ready to integrate these APIs with the **TravelBuddy** web site.