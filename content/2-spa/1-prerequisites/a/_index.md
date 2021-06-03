+++
title = "Eclipse Environment"
date = 2021
weight = 1
chapter = false
pre = "<b>Option A. </b>"
+++

In this exercise, you will connect to your Windows Development host. We will be using the provided Windows Development environment to run this lab.

**Contents**
- [Install & Configure Prerequisites - Windows Eclipse Development](#install--configure-prerequisites---windows-eclipse-development)
- [DynamoDB Setup](#dynamodb-setup)


#### Install & Configure Prerequisites - Windows Eclipse Development

In this exercise, you will connect to your Windows Development host. We will be using the provided Windows Development environment to run this lab. You will need to configure your windows instances and install the AWS CLI.

1. An **AWS EC2 windows instance** has been set up for you. To gain access to the Workspace, follow the instructions outlined in [Section 1.2 - Remote enviroment & Configure the AWS CLI](../../../1-prerequisites/2-remote-env-config-cli/), then continue this lab:

#### DynamoDB Setup
We need to populate a DynamoDB table with information that will be used during the lab. This information will be used to calculate trips between different cities.

Only complete this step after your Windows eclipse environment has been set up.

2. **Download** the following file to your **Windows Eclipse environment**: [**populate_tripsector.sh**](https://workshops.devax.academy/monoliths-to-microservices/module6/files/populate_tripsector.sh)

{{%attachments title="DB file" pattern=".*(sh)"/%}}

3. Execute the following in your **Windows Eclipse Environment**. You will need to use ```git bash``` that has been included in your installation.

```bash
bash populate_tripsector.sh <AWS_REGION>
```

![Kinesis](/images/2/kinesisconsumerproducerapparch.png?width=90pc)

4. Open the **DynamoDB** service in the console and check the table **TravelBuddyTripSectors table** and confirm there are **50 rows** in the table.

![DynamoDB](/images/2/5.png?width=90pc)