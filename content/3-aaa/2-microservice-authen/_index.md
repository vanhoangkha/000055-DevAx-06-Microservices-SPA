+++
title = "Microservice Authentication"
date = 2021
weight = 2
chapter = false
pre = "<b>3.2. </b>"
+++

**Setting up Authentication for the Microservice**

Right now, if you click the **Go!** button on the web site and do not enter a city to filter, you will see a dialog with all available trips. We want to change this behaviour so that you must be logged in in order to be able to search for all trips without a filter. This is just an example to demonstrate how we could limit certain API calls to only authenticated users.

**Contents**
- [Update the AWS API Gateway](#update-the-aws-api-gateway)
- [Create an Authorizer that uses the Cognito User Pool](#create-an-authorizer-that-uses-the-cognito-user-pool)
- [Mark the **/trips** microservices to require authentication](#mark-the-trips-microservices-to-require-authentication)

#### Update the AWS API Gateway

1. Open the **AWS API Gateway console**, and click on the **Gateway Responses** link beneath the **iDevelop - Trip Search API** link.
2. In the **Gateway Responses** panel, scroll down to locate the ```Unauthorized (401)``` panel and open it.
3. Click **Edit**
4. In order for our web application to be able to receive the **unauthorized 401** status, we need to add **CORS headers** to the response. Without the headers, the browser will not have permission to receive the 401 status. We have already enabled CORS for status 200 responses when we set up the API Gateway endpoints earlier. But we need to explicitly allow for status 401 to be returned.

In the **Response Headers** section, add in the following two header/value pairs:

|          Header name         | 'static value' |
|:----------------------------:|:--------------:|
| Access-Control-Allow-Origin  | '*'            |
| Access-Control-Allow-Headers | '*'            |

{{% notice warning %}}
You must provide the single-quotes around the static value as shown above. Don't provide * by itself, surround it with single-quotes like shown. Make sure that there is no trailing space after the header name if you copy/pasted from the lab cloudformation values.
{{% /notice %}}

![microservices](/images/3/4.png?width=90pc)

5. Click the **Save** button in the ```401``` panel to **commit** the changes.

#### Create an Authorizer that uses the Cognito User Pool

**API Gateway** integrates tightly with **Cognito** for authorization. You simply need to declare your **Cognito User Pool** as an **authorizer** for your API.

6. Click the **Authorizers** link beneath the iDevelop - Trip Search API link on the left navigation panel
7. Click **Create New Authorizer**
8. For **Name** type ```TravelBuddy```
9. For **Type** select ```Cognito```
10. Select the ```TravelBuddy``` entry from the drop-down list for **Cognito User Pool** by first clicking inside the text entry field.
11. For **Token Source** type ```Authorization``` and note that spelling and capitalization are important.
12. Click **Create**

#### Mark the **/trips** microservices to require authentication

13. Click the **Resources** link beneath the **iDevelop - Trip Search API** link on the left navigation panel
14. Click the **GET** method beneath ```/trips```
15. Click **Method Request**
16. Click the **pencil icon** next to the **Authorization** field and from the menu that appears, select ```TravelBuddy```. This is the authoriser we created in the previous step, and links to the **Cognito User Pool** we are using for our user database. If it does not appear, try refreshing your browser.

![microservices](/images/3/5.png?width=90pc)

17. Click the **grey tick** next to the field to **save** the change.
