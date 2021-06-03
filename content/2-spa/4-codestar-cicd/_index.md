+++
title = "Deploy the API using CodeStar and CI/CD"
date = 2021
weight = 4
chapter = false
pre = "<b>2.4. </b>"
+++

The next microservice we need for our TravelBuddy serverless application is the FlightSpecials API. We have seen FlightSpecials before in this course, so it should be familiar to you. It functions the same way as the HotelSpecials API in that it must be deployed with VPC integration so it can connect to the mySQL database to query for data. Instead of manually packaging and deploying this microservice, we will use CodeStar to build out a full CI/CD pipeline for us, as we have done in previous labs. So, since you have created CI/CD pipelines using AWS CodeStar a few times now, we are not going to provide you with full step-by-step instructions. If you need help, ask a Lab Assistant how to complete the tasks required to create a new CodeStar project and deploy the FlightSpecials code over the sample application provided by CodeStar.

Depending on whether you chose to use the Eclipse environment or AWS Cloud9 choose the appropriate lab instructions below:

**Contents**
1. [Option A: Eclipse Environment](a/)
2. [Option B: AWS Cloud9 Environment](b/)