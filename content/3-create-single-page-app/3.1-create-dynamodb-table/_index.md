+++
title = "Create A DynamoDB Table"
date = 2020
weight = 1
chapter = false
pre = "<b>3.1. </b>"
+++
#### Create A DynamoDB Table

{{%attachments title="populate_tripsector.sh" style="orange" pattern="populate_tripsector.sh"/%}}
1. Download **populate_tripsector.sh** file to **Downloads** folder in the Windows virtual machine.
2. Open **Command Prompt**
* Execute the below command:
```
set AWS_DEFAULT_PROFILE=devaxacademy
cd Downloads
populate_tripsector.sh <YOUR_REGION>
```
{{% notice note %}} 
Replace **<YOUR_REGION>** by your **Region**
{{% /notice %}}
![Create A DynamoDB Table](/images/3-create-single-page-app/3.1-create-dynamodb-table/create-dynamodb-table-001.png?featherlight=false&width=90pc)

3. Go to [**AWS DynamoDB Console**](https://console.aws.amazon.com/dynamodbv2/home).
* Click **Explore items**
* Type ```TravelBuddyTripSectors``` in the search bar and press **Enter**
* Select **TravelBuddyTripSectors** 
* In **Items returned** section, You will see 50 records.
![Create A DynamoDB Table](/images/3-create-single-page-app/3.1-create-dynamodb-table/create-dynamodb-table-002.png?featherlight=false&width=90pc)