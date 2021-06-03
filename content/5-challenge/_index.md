+++
title = "Challenge"
date = 2021
weight = 5
chapter = false
pre = "<b>5. </b>"
+++

As an optional task, you are challenged with implementing active tracing using automation for the functions deployed using the AWS CLI and CodeStar. We are not going to give you all the answers! But to help you on your journey, check out the [**AWS::Lambda::Function**](http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-lambda-function.html) CloudFormation documentation, and [AWS SAM](https://github.com/awslabs/serverless-application-model/blob/master/versions/2016-10-31.md) documentation.

When you have fully implemented tracing for the Lambda functions, you will see the tracing segments on the AWS X-ray console. Trigger the execution of the various lambda functions using the TravelBuddy SPA web page, and you will see results such as:

![Challenge](/images/5/tracingsample.png?width=90pc)