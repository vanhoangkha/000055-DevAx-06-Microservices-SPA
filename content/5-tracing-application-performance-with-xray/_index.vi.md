+++
title = "Theo dõi Hiệu năng Ứng dụng với AWS X-Ray"
date = 2020
weight = 5
chapter = false
pre = "<b>5. </b>"
+++
#### Theo dõi Hiệu năng Ứng dụng với AWS X-Ray

Mỗi hàm Lambda **TripSearch**, **HotelSpecials** và **FlightSpecials** chứa các phụ thuộc cần thiết để hỗ trợ phát ra các sự kiện theo dõi tới AWS X-ray, để cho phép bạn dễ dàng theo dõi các cuộc gọi giữa các thành phần của hệ thống phân tán của bạn. Trong bài thực hành này, bạn sẽ bật tính năng và xem lại AWS X-Ray console.

1. Truy cập [**AWS Lambda console**](https://console.aws.amazon.com/lambda/home).
* Click **Functions**.
* Nhập **idevelopTripSearchFull** vào ô tìm kiếm và nhấn **Enter**.
* Click **idevelopTripSearchFull**.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-001.png?featherlight=false&width=90pc)
2. Click **Configuration**
* Click **Monitoring and operations tools**
* Click **Edit**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-002.png?featherlight=false&width=90pc)
3. Tại phần **AWS X-Ray**, kích hoạt **Active tracing**
* Click **Save**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-003.png?featherlight=false&width=90pc)
4. Truy cập trang **TravelBuddy SPA**.
* Đăng nhập nếu chưa đăng nhập
* Click **Go!** mà không nhập thành phố để kích hoạt hàm Lambda **idevelopTripSearchFull**. Sẽ mất một vài giây để hoàn thành.
* Chúng ta sẽ thấy hộp thoại hiển thị các bản ghi.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-004.png?featherlight=false&width=90pc)
5. Truy cập [**AWS CloudWatch Console**](https://console.aws.amazon.com/cloudwatch/home).
* Mở phần **X-Ray traces**.
* Click **Service map**
* Mở phần **Legend and options**
* Click **Metrics**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-005.png?featherlight=false&width=90pc)
6. Click **Service map**, bạn sẽ thấy **Service map**.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-006.png?featherlight=false&width=90pc)
7. Truy cập [**AWS Lambda console**](https://console.aws.amazon.com/lambda/home).
* Click **Functions**.
* Nhập **idevelopTripSearchFull** vào ô tìm kiếm và nhấn **Enter**.
* Click **idevelopTripSearchFull**.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-007.png?featherlight=false&width=90pc)
8. Click **Monitor**
* Click **Traces**
* Bây giờ, đã có thể xem **Service map** trực tiếp từ Lambda console.
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-008.png?featherlight=false&width=90pc)
9. Quay lại [**AWS CloudWatch Console**](https://console.aws.amazon.com/cloudwatch/home).
* Click **Service map**
* Click **Client**
* Click **View traces**
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-005b.png?featherlight=false&width=90pc)
10. Trong bảng **Traces**
* Click **ID** của đối tượng đầu tiên hiển thị
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-009.png?featherlight=false&width=90pc)
11. Bạn sẽ có thể thấy được timeline của nhiều hành động và thời gian thực thi chúng
![Tracing Application Performance With AWS X-Ray](/images/5-tracing-application-performance-with-xray/tracing-application-performance-with-xray-010.png?featherlight=false&width=90pc)

Tại đây, bạn có thể thấy rằng việc gọi đến đã diễn ra trong 5,98 giây và 1.67 giây cho việc scan trong bảng **TravelBuddyTripSectors DynamoDB**

Bật tính năng theo dõi chủ động trên các hàm Lambda khác đã được tạo như một phần của bài thực hành này: **idevelopTripSearchFull**, **idevelopTripSearchFromCity**, **idevelopTripSearchToCity** và **GetHotelSpecials**. Bạn có thể thực hiện việc này theo cách thủ công bằng console. Tuy nhiên, lưu ý rằng hàm được tạo thông qua tự động hóa có tên bắt đầu bằng **awscodestar** sẽ bị ghi đè cấu hình nếu bạn triển khai lại mã.