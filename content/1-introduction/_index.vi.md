+++
title = "Giới thiệu"
date = 2020
weight = 1
chapter = false
pre = "<b>1. </b>"
+++
#### Giới thiệu

Trong bài thực hành này, chúng ta sẽ lặp lại quá trình triển khai **TravelBuddy monolithic** và chuyển nó sang kiến trúc **serverless/serviceful** với **microservices**. Trong những bài thực hành trước, chúng ta đã tìm hiểu về các **serverless concepts**, ví dụ như **AWS Lambda** và **Amazon API Gateway**, nhưng trong bài thực hành này, chúng ta sẽ xem xét lại về nguyên tắc khối (monolith) của chúng ta, chuyển sang mô hình hoàn toàn không máy chủ (serverless model) và kết hợp xác thực và cấp quyền bằng **Amazon Cognito**.

Bạn sẽ thực hiện nhiều cách tiếp cận khác nhau khi triển khai các **Lambda functions** tạo nên các **microservice**, từ triển khai thủ công đến triển khai tự động CI/CD để đảm bảo bạn hiểu rõ về từng phần của kiến trúc và cách đơn giản hóa sự tự động hóa cơ sở hạ tầng và hợp lý hóa việc triển khai.

Tổng quan kiến trúc chúng ta xây dựng như sau:

![Architecture](/images/1-introduction/0.png?featherlight=false&width=50pc)

#### Amazon Cognito

**Amazon Cognito** cho phép bạn bổ sung tính năng đăng ký, đăng nhập và kiểm soát truy cập người dùng vào trang web và ứng dụng di động một cách nhanh chóng và dễ dàng. Amazon Cognito có quy mô lên tới hàng triệu người dùng và hỗ trợ đăng nhập thông qua các nhà cung cấp danh tính mạng xã hội như Apple, Facebook, Google và Amazon, cũng như các nhà cung cấp danh tính doanh nghiệp thông qua SAML 2.0 và OpenID Connect.  

[Click vào đây để biết thêm thông tin về **Amazon Cognito**](https://aws.amazon.com/cognito/)

#### Amazon API Gateway

**Amazon API Gateway** là dịch vụ được quản lý hoàn toàn giúp các nhà phát triển dễ dàng tạo, phát hành, duy trì, giám sát và bảo vệ API ở mọi quy mô. API đóng vai trò là "cửa trước" cho các ứng dụng để truy cập dữ liệu, logic nghiệp vụ hoặc chức năng từ các dịch vụ backend của bạn. Bằng cách sử dụng API Gateway, bạn có thể tạo các API RESTful và API WebSocket để kích hoạt các ứng dụng giao tiếp hai chiều theo thời gian thực. API Gateway hỗ trợ các khối lượng công việc có trong container và serverless, cũng như các ứng dụng web.

[Click vào đây để biết thêm thông tin về **Amazon API Gateway**](https://aws.amazon.com/apigateway/)

#### Nội dung

Sau khi hoàn thành bài thực hành, bạn sẽ có thể:

* Hiểu cách bạn có thể sử dụng một ứng dụng **monolithic** và chuyển nó thành một ứng dụng **Single Page Web** được lưu trữ trên Amazon S3 với sự hỗ trợ logic nghiệp vụ được cung cấp bởi **Amazon API Gateway** và **AWS Lambda**.
* Sử dụng **AWS Console** để tạo và cấu hình một **Amazon Cognito User Pool** và **Identity Pool** để sử dụng trong ứng dụng **serverless** của bạn.
* Triển khai thủ công một **Lambda function** sử dụng **AWS CLI**
* Triển khai thủ công một **Lambda function** sử dụng công cụ **AWS CLI CloudFormation**
* Cấu hình thủ công một API trong **Amazon API Gateway**
* Tự động hóa việc triển khai đầy đủ một API bằng **CodeStar**
* Tạo **SDK** từ **Amazon API Gateway**

#### Kiến thức kỹ thuật cần có

Để hoàn thành bài thực hành, bạn cần quen thuộc với AWS Management Console, Eclipse IDE và ngôn ngữ Java

#### Môi trường

Môi trường phát triển của chúng ta bao gồm các thành phần:

* Java 8 JDK
* Apache Maven
* Eclipse IDE for Java EE Developers
* Tomcat 9
* AWS Toolkit for eclipse
* AWS CLI
* Elastic Beanstalk CLI

Tất cả các tài nguyên cần thiết để bắt đầu lab này đã được cung cấp và thiết lập cho bạn. Nếu chạy trong tài khoản của riêng bạn, hãy sử dụng mẫu CloudFormation này Sơ đồ sau mô tả các tài nguyên đã được triển khai trong tài khoản AWS của bạn. 

![Architecture](/images/1-introduction/architecture.png?featherlight=false&width=50pc)