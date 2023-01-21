+++
title = "Thêm Xác thực vào SPA sử dụng Amazon Cognito User Pools"
date = 2020
weight = 1
chapter = false
pre = "<b>4.1. </b>"
+++
#### Thêm Xác thực vào SPA sử dụng Amazon Cognito User Pools

Trong phần này, chúng ta sẽ sử dụng **Cognito User Pool** và **Identity Pool**, đồng thời đánh dấu một trong các điểm cuối API của chúng tôi là yêu cầu xác thực qua Cognito User Pools.

1. Truy cập [**AWS Cognito console**](https://console.aws.amazon.com/cognito/home).
* Click **User pools**
* Click **TravelBuddy**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-001.png?featherlight=false&width=90pc)
2. Lưu lại giá trị **User pool ID**
* Click **App integration**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-002.png?featherlight=false&width=90pc)
3. Lưu lại giá trị **Client ID** của **App client name** có tên **TravelBuddyWebApp**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-003.png?featherlight=false&width=90pc)
4. Click **Federated Identities**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-004.png?featherlight=false&width=90pc)
5. Click **TravelBuddy**
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-005.png?featherlight=false&width=90pc)
6. Click **Sample code**
* Trong mục **Get AWS Credentials**, lưu lại giá trị **Identity Pool ID** xuất hiện trong đoạn mã
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-006.png?featherlight=false&width=90pc)
7. Mở file có đường dẫn **www\scripts\webapp-configuration.js** trong thư mục **www** đã giải nén trong bước 1 phần 3.5
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-007.png?featherlight=false&width=90pc)

SPA được triển khai bằng cách sử dụng Angular framework, cho phép bạn xác định các hằng số toàn cục được sử dụng làm biến cấu hình trong toàn bộ ứng dụng của bạn. Tệp này xác định các giá trị của biến cấu hình mà bạn cần đặt dựa trên AWS Account’s ARN và ID của bạn cho các tài nguyên Cognito khác nhau.

8. Thay **REPLACE_WITH_COGNITO_IDENTITY_POOL_ID** bằng giá trị **Identity Pool ID** đã lưu trong bước 6
* Thay **REPLACE_WITH_COGNITO_USER_POOL** bằng giá trị **User pool ID** đã lưu trong bước 2
* Thay **REPLACE_WITH_COGNITO_USER_POOL_CLIENT_ID** bằng giá trị **Client ID** đã lưu trong bước 3
* Thay **REPLACE_WITH_S3_BUCKET_WWW** bằng giá trị **S3BucketWWWBucketName** trong tab **Output** của stack **DevAx-06**
* Trong phần **AWS_REGION** thay bằng **Region** của bạn
* Lưu lại
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-008.png?featherlight=false&width=90pc)
9. Mở **Command Prompt**, chuyển đường dẫn đến thư mục **www** đã giải nén trong bước 1 phần 3.5
* Chạy lệnh dưới đây
```
set AWS_PROFILE=devaxacademy
aws s3 sync . s3://<S3BucketWWWBucketName>
```
{{% notice note %}} 
Thay **\<S3BucketWWWBucketName\>** bằng giá trị **S3BucketWWWBucketName** trong tab **Output** của stack **DevAx-06**
{{% /notice %}}
![Add Authentication to the SPA using Amazon Cognito User Pools](/images/4-configure-aaa/4.1-add-authentication-with-cognito/add-authentication-with-cognito-009.png?featherlight=false&width=60pc)
10. Làm mới trang web **TravelBuddy** và kiểm tra developer console để xác nhận rằng không có không có lỗi nào sau các thay đổi bạn đã thực hiện.