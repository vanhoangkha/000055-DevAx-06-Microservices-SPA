+++
title = "Đăng ký và Đăng nhập Người dùng"
date = 2021
weight = 4
chapter = false
pre = "<b>3.4. </b>"
+++

**Thêm Đăng ký và Đăng nhập Người dùng**

Chúng tôi gần như có mọi thứ chúng tôi cần để đăng ký và đăng nhập với tư cách là người dùng. Hãy kiểm tra xem các danh tính được liên kết của Cognito đã được thiết lập chính xác hay chưa.

1. Truy cập **Amazon Cognito console** và chọn **Manage Identity Pools**
2. Truy cập **TravelBuddy identity pool** và chọn vòa **tiêu đề** của nó.
3. Chọn **Edit identity pool** ở góc phải

Tại đây chúng ta có thể thiết lập ```Unauthenticated``` roles (roles xác định khi người dùng không đăng nhập), và ```Authenticated``` roles (roles xác định khi người dùng đăng nhập).

4. Xác minh rằng **Unauthenticated** role được thiết lập chứa chuỗi ```CognitoIAMUnauthenticatedRole```. Thông tin này được thiết lập khi tạo bài thực hành.
5. Xác minh rằng **Authenticated** role được thiết lập chứa chuỗi ```CognitoIAMAuthenticatedRole```. Thông tin này được thiết lập khi tạo bài thực hành.

![TravelBuddy](/images/3/7.png?width=90pc)

Giờ đây, bạn đã có mọi thứ để đăng ký và đăng nhập với tư cách người dùng, sau đó kiểm tra hành vi đăng nhập của microservice /trips bây giờ rằng nó được bảo vệ bằng cách yêu cầu ủy quyền.

6. Trong trang **TravelBuddy** , chọn **Login or Register** ở thanh điều hướng
7. Chọn **Sign-up here!**
8. Nhập thông tin đăng nhập của bạn 

{{% notice note %}}
Lưu ý rằng bạn phải cung cấp **địa chỉ email hợp lệ** - địa chỉ mà bạn có quyền truy cập ngay lập tức, để bạn sẽ được gửi một **mã xác minh**.
{{% /notice %}}

![TravelBuddy](/images/3/8.png?width=90pc)

9. Kiểm tra email của bạn, tìm **mã xác minh** và nhập mã đó vào khung **Registration Verification Code**. Chọn **Verify**.

![TravelBuddy](/images/3/9.png?width=90pc)

10. Đăng nhập bằng thông tin đăng nhập (địa chỉ email và mật khẩu) bạn đã cung cấp trong quá trình đăng ký.

![TravelBuddy](/images/3/10.png?width=90pc)

11. Bây giờ bạn sẽ đăng nhập và biểu ngữ sẽ thay đổi để hiển thị **My Account**. Nhấp vào liên kết - tính năng duy nhất được triển khai là tùy chọn Đăng xuất.

![TravelBuddy](/images/3/11.png?width=90pc)

{{% notice tip %}}
Bạn có thể đăng xuất và sau đó đăng nhập lại theo nếu bạn muốn thử.
{{% /notice %}}

12. Bây giờ bạn đã đăng nhập, hãy nhấp vào **Go!** một lần nữa mà không có bất kỳ nội dung nào được nhập. 

{{% notice note %}}
Lưu ý rằng bạn sẽ được hiển thị danh sách chuyến đi đầy đủ trong một hộp thoại, như trước khi chúng ta khai báo bảo mật.
{{% /notice %}}

Bây giờ, hãy đăng xuất bằng cách sử dụng liên kết trong menu **My Account** và thử nhấn nút **Go!**lần nữa. 

{{% notice note %}}
Lưu ý rằng bạn lại thấy thông báo lỗi, cho biết rằng bạn phải đăng nhập để sử dụng microservice ```/trips```.
{{% /notice %}}

![TravelBuddy](/images/3/12.png?width=90pc)