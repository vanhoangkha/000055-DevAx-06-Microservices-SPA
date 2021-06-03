+++
title = "Hiệu năng Ứng dụng"
date = 2021
weight = 4
chapter = false
pre = "<b>4. </b>"
+++

**Theo dõi Hiệu năng Ứng dụng với AWS X-Ray**

Mỗi hàm Lambda **TripSearch**, **HotelSpecials** và **FlightSpecials** chứa các phụ thuộc cần thiết để hỗ trợ phát ra các sự kiện theo dõi tới AWS X-ray, để cho phép bạn dễ dàng theo dõi các cuộc gọi giữa các thành phần của hệ thống phân tán của bạn. Trong bài thực hành này, bạn sẽ bật tính năng và xem lại AWS X-Ray console.

1. Trong **AWS Lambda Console**, chọn vào Lambda function **idevelopTripSearchFull**. Chọn **Configuration** và chọn bảng **Monitoring and operations tools**. Chọn nút **Edit** vầ kích hoạt **Active tracing** trong mục **AWS X-Ray**. Chọn **Save**.

![Xray](/images/4/1.png?width=90pc)

![Xray](/images/4/2.png?width=90pc)

2. Chuyển qua trang **TravelBuddy SPA** mà chúng ta đã host trên S3. Đăng nhập vào ứng dụng nếu chưa đăng nhập.
3. Chọn **Go!** mà không nhập vào địa điểm, kích hoạt hàm Lambda **idevelopTripSearchFull**. Sẽ mất một vài giây để hoàn thành. 

![Xray](/images/4/3.png?width=90pc)

4. Sau khi hộp thoại hiển thị các bản ghi, quay lại **AWS console**, tìm ```X-ray``` trên thanh tìm kiếm. Chọn vào **X-ray item** trong danh sách ở **AWS X-ray console**.
5. Trong trang **AWS X-Ray**, chọn **Get started** và chọn **Cancel**.

![Xray](/images/4/4.png?width=90pc)

6. Chọn **Service map** ở bảng bên trái.
7. Bạn sẽ thấy **Service map** tương tự như sau:

![Xray](/images/4/5.png?width=90pc)

{{% notice tip %}}
![Xray](/images/4/6.png?width=90pc)
Bây giờ, đã có thể xem Service map trực tiếp từ Lambda console.
{{% /notice %}}

8. Chọn vào vòng tròn xanh đầu tiên thể hiện cho việc gọi vào hàm Lambda. Bảng "Details" sẽ xuất hiện hiển thị thông tin về thời gian phản hồi, phân bổ phản hồi và thời gian thực thi.

![Xray](/images/4/7.png?width=90pc)

9. Chọn **View Traces**, ở dưới cùng bảng **Service details**.
10. Trong **Traces list** Chọn đối tượng đầu tiên hiển thị
11. Bảng **Traces details** sẽ xuất hiện. Bạn sẽ có thể thấy được timeline của nhiều hành động và thời gian thực thi chúng, ví dụ:

![Xray](/images/4/8.png?width=90pc)

Tại đây, bạn có thể thấy rằng việc gọi đến đã diễn ra trong 5 sec, 1.3 sec cho việc scan trong bảng **TravelBuddyTripSectors DynamoDB**.

12.  Bật tính năng theo dõi chủ động trên các hàm Lambda khác đã được tạo như một phần của bài thực hành này: **idevelopTripSearchFull**, **idevelopTripSearchFromCity**, **idevelopTripSearchToCity** và **GetHotelSpecials**. Bạn có thể thực hiện việc này theo cách thủ công bằng console. Tuy nhiên, lưu ý rằng hàm được tạo thông qua tự động hóa có tên bắt đầu bằng **awscodestar** sẽ bị ghi đè cấu hình nếu bạn triển khai lại mã.

Xem thêm [**Bài tập nâng cao**](../5-challenge/)
