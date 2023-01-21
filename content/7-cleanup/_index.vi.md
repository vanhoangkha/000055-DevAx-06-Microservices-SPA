+++
title = "Dọn dẹp tài nguyên"
date = 2020
weight = 7
chapter = false
pre = "<b>7. </b>"
+++
Bạn sẽ dọn dẹp tài nguyên theo thứ tự sau:

#### Terminate EC2 Instance
1. Truy cập [**Amazon EC2 console**](https://console.aws.amazon.com/ec2/).
* Trên thanh điều hướng bên trái, click **Intances**.
* Chọn **DevAxWindowsHost**. 
* Click **Instance state**
* Click **Terminate instance**
![Clean up reources](/images/7-cleanup/cleanup-001.png?featherlight=false&width=90pc)
2. Click **Terminate**
![Clean up reources](/images/7-cleanup/cleanup-002.png?featherlight=false&width=90pc)

#### Xóa Users
1. Truy cập vào [**AWS IAM Console**](https://console.aws.amazon.com/iamv2/).
* Click **Users**.
* Nhập ```awsstudent``` vào ô tìm kiếm
* Chọn **awsstudent**. 
* Click **Delete**
![Clean up reources](/images/7-cleanup/cleanup-003.png?featherlight=false&width=90pc)
2. Điền ```awsstudent``` để xác nhận, sau đó click **Delete**
![Clean up reources](/images/7-cleanup/cleanup-004.png?featherlight=false&width=90pc)

#### Xóa policy

1. Truy cập vào [**AWS IAM Console**](https://console.aws.amazon.com/iamv2/).
* Click **Policies**.
* Nhập ```idevelop``` vào ô tìm kiếm và nhấn **Enter**
* Chọn **idevelopCodeStarCloudFormationPolicy**
* Click **Actions**
* Click **Delete**
![Clean up reources](/images/7-cleanup/cleanup-007.png?featherlight=false&width=90pc)
2. Điền tên của policy để xác nhận, sau đó click **Delete** để xóa
![Clean up reources](/images/7-cleanup/cleanup-008.png?featherlight=false&width=90pc)

#### Xóa DynamoDB
1. Truy cập [**AWS DynamoDB Console**](https://console.aws.amazon.com/dynamodbv2/home).
* Click **Tables**
* Chọn tất cả **DynamoDB** đã tạo trong bài lab
* Click **Delete**
![Clean up reources](/images/7-cleanup/cleanup-004a.png?featherlight=false&width=90pc)
2. Điền ```delete``` để xác nhận, sau đó click **Delete tables** để xóa
![Clean up reources](/images/7-cleanup/cleanup-004b.png?featherlight=false&width=90pc)

#### Xóa API Gateway
1. Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home).
* Chọn **iDevelop - Trip Search API**
* Click **Actions**
* Click **Delete**
![Clean up reources](/images/7-cleanup/cleanup-004c.png?featherlight=false&width=90pc)
2. Click **Delete** để xóa
![Clean up reources](/images/7-cleanup/cleanup-004d.png?featherlight=false&width=90pc)

#### Xóa CodeStar
1. Truy cập [**AWS CodeStar Console**](https://console.aws.amazon.com/codesuite/codestar/home).
* Click **Projects**
* Chọn **FlightSpecialsAPI**
* Click **Delete**
![Clean up reources](/images/7-cleanup/cleanup-004e.png?featherlight=false&width=90pc)
2. Điền ```delete``` để xác nhận, sau đó click **Delete** để xóa
![Clean up reources](/images/7-cleanup/cleanup-004f.png?featherlight=false&width=90pc)

#### Xóa CloudFormation Stack
1. Truy cập [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).
* Chọn **DevAx-06**.
* Click **Delete**
![Clean up reources](/images/7-cleanup/cleanup-005.png?featherlight=false&width=90pc)
2. Click **Delete stack**
![Clean up reources](/images/7-cleanup/cleanup-006.png?featherlight=false&width=90pc)
3. Làm tương tự với những **CloudFormation Stack** còn lại

#### Xóa S3 bucket
1. Truy cập vào [**AWS S3 Console**](https://s3.console.aws.amazon.com/s3/).
* Click **Buckets**
* Chọn **aws-codestart-us-east-1...**.
* Click **Empty**.
![Clean up reources](/images/7-cleanup/cleanup-009.png?featherlight=false&width=90pc)
2. Điền ```permanently delete``` để xác nhận, sau đó click **Empty** để xóa toàn bộ dữ liệu trong S3 bucket.
![Clean up reources](/images/7-cleanup/cleanup-010.png?featherlight=false&width=90pc)
3. Click **Exit** để trở lại giao diện S3.
![Clean up reources](/images/7-cleanup/cleanup-011.png?featherlight=false&width=90pc)
4. Click **Delete**.
![Clean up reources](/images/7-cleanup/cleanup-012.png?featherlight=false&width=90pc)
5. Điền tên bucket sau đó click **Delete bucket** để xóa S3 bucket.
![Clean up reources](/images/7-cleanup/cleanup-013.png?featherlight=false&width=90pc)
6. Làm tương tự cho S3 bucket còn lại