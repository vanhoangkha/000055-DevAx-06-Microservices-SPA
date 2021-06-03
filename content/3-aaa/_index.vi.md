+++
title = "Cấu hình AAA"
date = 2021
weight = 3
chapter = false
pre = "<b>3. </b>"
+++

**Cấu hình Authentication, Authorization và Accounting (AAA)**

Hiện tại, **TravelBuddy SPA** của chúng ta không yêu cầu bất kỳ xác thực nào để gọi các dịch vụ API mà chúng ta đã cung cấp. Quá trình thiết lập bài thực hành đã cung cấp **Cognito User Pool** và một **Cognito Identity Pool** trong tài khoản của bạn. **Cognito User Pool** là hệ thống hồ sơ được quản lý hoàn toàn về người dùng trong ứng dụng của bạn. **Identity Pool** được sử dụng để lấy thông tin đăng nhập AWS IAM tạm thời để ký các yêu cầu yêu cầu SigV4 signing. **Cognito Identity Pool** liên kết giữa nhiều **Identity Providers**, nhưng trong ví dụ thực hành của chúng ta, chúng ta chỉ có một Identity Provider (User Pool). TravelBuddy SPA của chúng ta thực tế không có yêu cầu về thông tin xác thực IAM, nhưng chúng ta đã triển khai tính năng này để chứng minh cách bạn có thể thực hiện điều này. Trong một Bài tập thử thách, chúng ta sẽ yêu cầu bạn triển khai **AWS IAM Authorization** cho việc gọi vào API Gateway, nhưng đây là một nhiệm vụ khong bắt buộc đối với bài thực hành.

#### Nội dung
1. [Thêm Xác thực vào SPA sử dụng Amazon Cognito User Pools](1-cognito/)
2. [Thiết lập Xác thực cho Microservice](2-microservice-authen/)
3. [Triển khai và Kiểm thử Hành động mới](3-deploy-test/)
4. [Thêm Đăng ký và Đăng nhập Người dùng](4-signup-signin/)