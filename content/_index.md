+++
title = "Creating an Authenticated Single Page Application (SPA)"
date = 2021
weight = 1
chapter = false
+++

# Creating an Authenticated Single Page Application (SPA)

In this lab we will iterate on our TravelBuddy monolithic implementation, and move it to a serverless/serviceful architecture, with microservices. In previous Labs, we have looked at various serverless concepts - for example, AWS Lambda and Amazon API Gateway - but in this lab, we will rethink our monolith, move to a completely serverless model and incorporate authentication and authorisation using Amazon Cognito.

You will take various approaches when deploying the Lambda functions that make up the microservices, from manual deployment to automated CI/CD deployment, to ensure you have a good understanding of each of parts of the architecture, and how infrastructure automation simplifies and streamlines deployment.

The overall architecture you will build is as follows:

![SPA](/images/0.png)

The source code for the Single-Page Web Application will be provided for you, but you will need to configure the details that relate to your AWS account and host the SPA in Amazon S3.

You will make use of the following services:

#### Amazon Cognito
Amazon Cognito lets you easily add user sign-up and sign-in to your mobile and web apps. With Amazon Cognito, you also have the options to authenticate users through social identity providers such as Facebook, Twitter, or Amazon, with SAML identity solutions, or by using your own identity system.

[Click here for more information about Amazon Cognito](https://aws.amazon.com/cognito/)


#### Amazon API Gateway
Amazon API Gateway is an AWS service that enables developers to create, publish, maintain, monitor, and secure APIs at any scale. You can create APIs that access AWS or other web services, as well as data stored in the AWS Cloud. API Gateway can be considered a backplane in the cloud to connect AWS services and other public or private web sites. It provides consistent RESTful application programming interfaces (APIs) for mobile and web applications to access AWS services.

[Click here for more information about Amazon API Gateway](https://aws.amazon.com/apigateway/)

#### Topics Covered
By the end of this lab, you will be able to:
- Understand how you can take a monolithic application and distill it down into a
- Single Page Web Application hosted on Amazon S3, with supporting business logic provided by Amazon API Gateway and AWS Lambda
- Use the AWS Console to create and configure an Amazon Cognito User Pool and Identity Pool for use in your serverless application
- Manually deploy a Lambda function using the AWS CLI
- Manually deploy a Lambda function using the AWS CLI CloudFormation tool
- Manually configure an API in Amazon API Gateway
- Automate the full deployment of an API using CodeStar
- Generate SDKs from Amazon API Gateway

#### Technical Knowledge Prerequisites
To successfully complete this lab, you should be familiar with basic navigation of the AWS Management Console and have intermediate experience using the Eclipse IDE and the Java Programming language.

#### Contents

1. [Prerequisite](1-prerequisites/)
2. [Creating A Single Page Application](2-spa/)
3. [Configure Authentication, Authorization and Accounting (AAA)](3-aaa/)
4. [Tracing Application Performance With AWS X-Ray](4-xray/)
5. [Challenge](5-challenge/)
6. [Conclusion](6-conclusion/)
7. [Reference Resources](7-resources/)