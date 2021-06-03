+++
title = "AWS Cloud9 Environment"
date = 2021
weight = 2
chapter = false
pre = "<b>Option B. </b>"
+++

#### Cloud Based Integrated Development Environment with AWS Cloud9
In this module we will be using AWS Cloud9. WS Cloud9 is a cloud-based integrated development environment (IDE) that lets you write, run, and debug your code with just a browser. It includes a code editor, debugger, and terminal. Cloud9 comes prepackaged with essential tools for popular programming languages, including JavaScript, Python, PHP, and more, so you don’t need to install files or configure your development machine to start new projects. Since your Cloud9 IDE is cloud-based, you can work on your projects from your office, home, or anywhere using an internet-connected machine. Cloud9 also provides a seamless experience for developing serverless applications enabling you to easily define resources, debug, and switch between local and remote execution of serverless applications. With Cloud9, you can quickly share your development environment with your team, enabling you to pair program and track each other’s inputs in real time.

**Contents**
- [Cloud Based Integrated Development Environment with AWS Cloud9](#cloud-based-integrated-development-environment-with-aws-cloud9)
- [Install the SAM CLI](#install-the-sam-cli)
- [Install maven](#install-maven)
- [DynamoDB Setup](#dynamodb-setup)

1. Using **Search box** - type in ```cloud9``` and choose **Cloud9** service. Then click **Create environment**. This will bring up a new screen, enter **Your name** in the name field and click **Next Step**.
2. For **Environment type**, choose **Create a new EC2 Instance for environment (direct access)**
3. For **Instance type**, choose a **t3.small**
4. For **Platform**, choose **Amazon Linux 2**
5. Under **VPC** chose the **DevAxNetworkVPC** (remember, you can find the VPC ID in the AWS Console under VPC) and choose the **same subnet** as the `DevAxWindowsHost` in the ec2 instance menu. Click **Next step**.
6. Review your settings and click **Create environment**.

	This will take a few minutes to start up,

![Cloud9](/images/2/1.png?width=90pc)

	and you should get redirected to the AWS Cloud9 screen.

![Cloud9](/images/2/2.png?width=90pc)

7. Start having a look around the **Cloud9 environment**, notice you have a console you can use to do your work from, and there are debugging and lambda setup on the right side. See what other lambda functions are already in the AWS account and review them.
8. Double click on the **CreateGitCredsFunction** and import it into your environment. Notice anything in the IDE?

![Cloud9](/images/2/3.png?width=90pc)

	We now need to setup the required **JAVA version to be 1.8** and change the required parameters on the IDE. We will be using Amazon Corretto, a no-cost, multiplatform, production-ready distribution of OpenJDK. Corretto comes with long-term support that will include performance enhancements and security fixes.

9. In the **Cloud9 terminal window**, install Amazon Corretto 8 by issuing the following commands:

```bash
sudo amazon-linux-extras enable corretto8
sudo yum install -y java-1.8.0-amazon-corretto-devel
```

10. In the **Cloud9 terminal window**, verify that the right Java version is installed (at the time of writing this was `1.8.0_265`):

```bash
java -version
```
You should see output similar to the following:
```bash
Admin:~/environment $ 
openjdk version "1.8.0_265"
OpenJDK Runtime Environment Corretto-8.265.01.1 (build 1.8.0_265-b01)
OpenJDK 64-Bit Server VM Corretto-8.265.01.1 (build 25.265-b01, mixed mode)
```

#### Install the SAM CLI
We will install the AWS Serverless Application Model (SAM) Cli to our AWS Cloud9 environment. The AWS Serverless Application Model (SAM) is an open-source framework for building serverless applications. It provides shorthand syntax to express functions, APIs, databases, and event source mappings. With just a few lines per resource, you can define the application you want and model it using YAML. During deployment, SAM transforms and expands the SAM syntax into AWS CloudFormation syntax, enabling you to build serverless applications faster.

11. In the **Cloud9 terminal window**, install the **SAM CLI** by issuing the following command:
```bash
sudo pip3 install --upgrade aws-sam-cli
```

#### Install maven

We will use **Apache Maven** to manage project build and dependancy management for our project.

12. To install **Apache Maven** in the **Cloud9 terminal window**, issue the following commands:
```bash
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

Unfortunately the maven installer switches our JDK to `1.7` so we need to switch back to `1.8.9`.

13. To switch our JDK to Corretto 8, issue the following commands in the **Cloud9 terminal**:
```bash
sudo alternatives --config java #enter the number for corretto 8
```

```bash
sudo alternatives --config javac #enter the number for corretto 8
```
You should see something similar to the following:

![Cloud9](/images/2/4.png?width=90pc)

#### DynamoDB Setup
We need to populate a DynamoDB table with information that will be used during the lab. This information will be used to calculate trips between different cities.

14. Download the following file to your AWS Cloud9 terminal: [**populate_tripsector.sh**](https://workshops.devax.academy/monoliths-to-microservices/module6/files/populate_tripsector.sh)

{{%attachments title="DB file" pattern=".*(sh)"/%}}

15. Execute the following in your **AWS Cloud9 terminal**.

```bash
bash populate_tripsector.sh <AWS_REGION>
```

![Kinesis](/images/2/kinesisconsumerproducerapparch.png?width=90pc)

16. Open the **DynamoDB** service in the console and check the table **TravelBuddyTripSectors table** and confirm there are **50 rows** in the table.

![DynamoDB](/images/2/5.png?width=90pc)