+++
title = "Introduction"
date = 2020
weight = 1
chapter = false
pre = "<b>1. </b>"
+++
#### Introduction

In this lab we will iterate on our TravelBuddy monolithic implementation, and move it to a serverless/serviceful architecture, with microservices. In previous Labs, we have looked at various serverless concepts - for example, AWS Lambda and Amazon API Gateway - but in this lab, we will rethink our monolith, move to a completely serverless model and incorporate authentication and authorisation using Amazon Cognito.

You will take various approaches when deploying the Lambda functions that make up the microservices, from manual deployment to automated CI/CD deployment, to ensure you have a good understanding of each of parts of the architecture, and how infrastructure automation simplifies and streamlines deployment.

The overall architecture you will build is as follows:

![Architecture](/images/1-introduction/0.png?featherlight=false&width=50pc)

#### Amazon Cognito

**Amazon Cognito** lets you easily add user sign-up and sign-in to your mobile and web apps. With Amazon Cognito, you also have the options to authenticate users through social identity providers such as Facebook, Twitter, or Amazon, with SAML identity solutions, or by using your own identity system.

[Click here for more information about Amazon Cognito](https://aws.amazon.com/cognito/)

#### Amazon API Gateway

**Amazon API Gateway** is an AWS service that enables developers to create, publish, maintain, monitor, and secure APIs at any scale. You can create APIs that access AWS or other web services, as well as data stored in the AWS Cloud. API Gateway can be considered a backplane in the cloud to connect AWS services and other public or private web sites. It provides consistent RESTful application programming interfaces (APIs) for mobile and web applications to access AWS services.

[Click here for more information about Amazon API Gateway](https://aws.amazon.com/apigateway/)

#### Topics Covered

By the end of this lab, you will be able to:

* Understand how you can take a monolithic application and distill it down into a Single Page Web Application hosted on Amazon S3, with supporting business logic provided by Amazon API Gateway and AWS Lambda.
* Single Page Web Application hosted on Amazon S3, with supporting business logic provided by Amazon API Gateway and AWS Lambda
* Use the AWS Console to create and configure an Amazon Cognito User Pool and Identity Pool for use in your serverless application
* Manually deploy a Lambda function using the AWS CLI
* Manually deploy a Lambda function using the AWS CLI CloudFormation tool
* Manually configure an API in Amazon API Gateway
* Automate the full deployment of an API using CodeStar
* Generate SDKs from Amazon API Gateway

#### Technical Knowledge Prerequisites

To successfully complete this lab, you should be familiar with basic navigation of the AWS Management Console and have intermediate experience using the Eclipse IDE and the Java Programming language.

#### Environment

All the resources required to begin this lab have already been provisioned and set up for you. If running in your own account, use this CloudFormation template The following diagram depicts the resources that were deployed in your AWS account.

![Architecture](/images/1-introduction/architecture.png?featherlight=false&width=50pc)