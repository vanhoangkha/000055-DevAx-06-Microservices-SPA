+++
title = "Triển khai API với CodeStar và CI/CD"
date = 2021
weight = 4
chapter = false
pre = "<b>2.4. </b>"
+++

Microservice tiếp theo mà chúng ta cần cho ứng dụng serverless TravelBuddy của mình là FlightSpecials API. Chúng ta đã xem FlightSpecials trước đây trong bài thực hành này, vì vậy nó sẽ quen thuộc với bạn. Nó hoạt động giống như HotelSpecials API ở chỗ nó phải được triển khai tích hợp với VPC để có thể kết nối với cơ sở dữ liệu MySQL để truy vấn dữ liệu. Thay vì đóng gói và triển khai microservice này theo cách thủ công, chúng ta sẽ sử dụng CodeStar để xây dựng CI/CD pipeline đầy đủ cho chúng ta, như chúng ta đã làm trong các bài thực hành trước đây. Vì vậy, vì bạn đã tạo đường ống CI / CD bằng AWS CodeStar một vài lần, nên chúng ta sẽ không cung cấp cho bạn hướng dẫn từng bước đầy đủ. Nếu bạn cần trợ giúp, hãy hỏi thêm chuyển gia cách hoàn thành các tác vụ cần thiết để tạo một dự án CodeStar mới và triển khai mã FlightSpecials trên ứng dụng mẫu do CodeStar cung cấp.

Tùy thuộc vào việc bạn chọn sử dụng **Eclipse** hay **AWS Cloud9**, hãy chọn hướng dẫn thực hành thích hợp bên dưới:

**Nội dung**
1. [Lựa chọn A: Sử dụng Eclipse](a/)
2. [Lựa chọn B: Sử dụng AWS Cloud9](b/)