+++
title = "Tạo DynamoDB Table"
date = 2020
weight = 1
chapter = false
pre = "<b>3.1. </b>"
+++
#### Tạo DynamoDB Table

{{%attachments title="populate_tripsector.sh" style="orange" pattern="populate_tripsector.sh"/%}}
1. Bạn hãy tải tập tin **populate_tripsector.sh** vào thư mục **Downloads** trong máy ảo Windows
2. Mở **Command Prompt**
* Chạy lệnh dưới đây:
```
set AWS_DEFAULT_PROFILE=devaxacademy
cd Downloads
populate_tripsector.sh <YOUR_REGION>
```
{{% notice note %}} 
Thay **<YOUR_REGION>** bằng **Region** của bạn
{{% /notice %}}
![Create A New DynamoDB Table](/images/3-create-single-page-app/3.1-create-dynamodb-table/create-dynamodb-table-001.png?featherlight=false&width=90pc)

3. Truy cập [**AWS DynamoDB Console**](https://console.aws.amazon.com/dynamodbv2/home).
* Click **Explore items**
* Nhập ```TravelBuddyTripSectors``` vào ô tìm kiếm nhấn **Enter**
* Chọn **TravelBuddyTripSectors** 
* Trong phần **Items returned**, bạn sẽ thấy có 50 bản ghi
![Create A New DynamoDB Table](/images/3-create-single-page-app/3.1-create-dynamodb-table/create-dynamodb-table-002.png?featherlight=false&width=90pc)






