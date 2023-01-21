+++
title = "Tracing Application Performance With AWS X-Ray"
date = 2020
weight = 5
chapter = false
pre = "<b>5. </b>"
+++

#### Tracing Application Performance With AWS X-Ray

The **TripSearch**, **HotelSpecials** and **FlightSpecials** Lambda functions each contain the necessary dependencies to support emitting tracing events to AWS X-ray, to allow you to easily trace the calls between the components of your distributed system. In this exercise, you will enable the feature and review the AWS X-ray console.

1. Go to [**AWS Lambda console**](https://console.aws.amazon.com/lambda/home).
* Click **Functions**.
* Type **idevelopTripSearchFull** to the search bar and press **Enter**.
* Click **idevelopTripSearchFull**.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-001.png?featherlight=false&width=90pc)
2. Click **Configuration**
* Click **Monitoring and operations tools**
* Click **Edit**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-002.png?featherlight=false&width=90pc)
3. In the **AWS X-Ray** section, enable the **Active tracing**
* Click **Save**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-003.png?featherlight=false&width=90pc)
4. Go to the **TravelBuddy SPA** page.
* Sign in to the application if you are not already signed in.
* Click **Go!** button without any text entered, to invoke the **idevelopTripSearchFull** Lambda function. It will take a moment to complete.
* the dialog is shown displaying the trips.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-004.png?featherlight=false&width=90pc)
5. Go to [**AWS CloudWatch Console**](https://console.aws.amazon.com/cloudwatch/home).
* Open **X-Ray traces**.
* Click **Service map**
* Open **Legend and options**
* Click **Metrics**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-005.png?featherlight=false&width=90pc)
6. Click **Service map**, you will see **Service map**.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-006.png?featherlight=false&width=90pc)
7. Go to [**AWS Lambda console**](https://console.aws.amazon.com/lambda/home).
* Click **Functions**.
* Type **idevelopTripSearchFull** to the search bar and press **Enter**.
* Click **idevelopTripSearchFull**.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-007.png?featherlight=false&width=90pc)
8. Click **Monitor**
* Click **Traces**
* You can now also see the **service map** directly from Lambda console.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-008.png?featherlight=false&width=90pc)
9. Back to the [**AWS CloudWatch Console**](https://console.aws.amazon.com/cloudwatch/home).
* Click **Service map**
* Click **Client**
* Click **View traces**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-005b.png?featherlight=false&width=90pc)
10. In the In the Traces list, click the **ID** of the the first item
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-009.png?featherlight=false&width=90pc)
11. You will be able to see a timeline view of the various actions and their execution durations
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-010.png?featherlight=false&width=90pc)

Here, you can see that the overall call took 5,98s, 1.67s of which was taken by the scan of the **TravelBuddyTripSectors DynamoDB** table.

Enable active tracing on the other Lambda functions that have been created as part of this lab: **idevelopTripSearchFull**, **idevelopTripSearchFromCity**, **idevelopTripSearchToCity** and **GetHotelSpecials**. You can do this manually using the console. However, note that the function created through automation with a name starting with **awscodestar** will have its configuration overwritten if you re-deploy the code