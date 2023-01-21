+++
title = "Tạo một Ứng dụng Đơn trang (SPA) được xác thực"
date = 2021
weight = 1
chapter = false
+++
# Tạo một Ứng dụng Đơn trang (SPA) được xác thực

#### Tổng quan

Trong bài thực hành này, chúng ta sẽ lặp lại quá trình triển khai **TravelBuddy monolithic** và chuyển nó sang kiến trúc **serverless/serviceful** với **microservices**. Trong những bài thực hành trước, chúng ta đã tìm hiểu về các **serverless concepts**, ví dụ như **AWS Lambda** và **Amazon API Gateway**, nhưng trong bài thực hành này, chúng ta sẽ xem xét lại về nguyên tắc khối (monolith) của chúng ta, chuyển sang mô hình hoàn toàn không máy chủ (serverless model) và kết hợp xác thực và cấp quyền bằng **Amazon Cognito**.

Bạn sẽ thực hiện nhiều cách tiếp cận khác nhau khi triển khai các **Lambda functions** tạo nên các **microservice**, từ triển khai thủ công đến triển khai tự động CI/CD để đảm bảo bạn hiểu rõ về từng phần của kiến trúc và cách đơn giản hóa sự tự động hóa cơ sở hạ tầng và hợp lý hóa việc triển khai.

#### Nội dung:

1. [Giới thiệu](1-introduction/)
2. [Chuẩn bị](2-prepare/)
3. [Tạo Single Page Application](3-create-single-page-app/)
4. [Cấu hình Authentication, Authorization và Accounting (AAA)](4-configure-aaa/)
5. [Theo dõi Hiệu năng Ứng dụng với AWS X-Ray](5-tracing-application-performance-with-xray/)
6. [Bài tập nâng cao](6-challenge/)
7. [Dọn dẹp tài nguyên](7-cleanup/)