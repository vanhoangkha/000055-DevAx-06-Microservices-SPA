+++
title = "Configure AAA"
date = 2021
weight = 3
chapter = false
pre = "<b>3. </b>"
+++

**Configure Authentication, Authorization and Accounting (AAA)**

Right now, our **TravelBuddy SPA** does not require any authentication in order to call the API services we have exposed. The lab setup process has provisioned a **Cognito User Pool** and a **Cognito Identity Pool** in your account. The **Cognito User Pool** is your fully-managed system of record for users in your application. The **Identity Pool** is used to obtain temporary AWS IAM credentials to sign requests that require SigV4 signing. The Cognito Identity Pool federates between multiple Identity Providers, but in our lab example, we only have one Identity Provider (the User Pool). Our TravelBuddy SPA does not actually have the requirement for IAM credentials, but we have implemented the feature to demonstrate how you can accomplish this. As a Challenge Exercise, we will ask you to implement AWS IAM Authorisation for a call into API Gateway, but this is an optional task for the lab.

#### Contents
1. [Add Authentication to the SPA using Amazon Cognito User Pools](1-cognito/)
2. [Setting up Authentication for the Microservice](2-microservice-authen/)
3. [Deploy and Test the new Behaviour](3-deploy-test/)
4. [Add new User Sign Up and Sign In](4-signup-signin/)