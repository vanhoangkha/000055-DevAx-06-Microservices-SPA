+++
title = "Thiết lập Xác thực cho Microservice"
date = 2020
weight = 2
chapter = false
pre = "<b>4.2. </b>"
+++
#### Thiết lập Xác thực cho Microservice

Ngay bây giờ, nếu bạn nhấp vào nút **Go!** trên trang web và không nhập thành phố để lọc, bạn sẽ thấy một hộp thoại với tất cả các chuyến đi có sẵn. Chúng ta muốn thay đổi hành vi này để bạn phải đăng nhập để có thể tìm kiếm tất cả các chuyến đi mà không cần bộ lọc. Đây chỉ là một ví dụ để chứng minh cách chúng ta có thể giới hạn các lệnh gọi API nhất định cho chỉ những người dùng được xác thực.

1. Truy cập [**AWS API Gateway Console**](https://console.aws.amazon.com/apigateway/home).
* Nhập ```iDevelop - Trip Search API``` vào ô tìm kiếm
* Click **iDevelop - Trip Search API**
![Microservice Authentication](/images/4-configure-aaa/4.2-setup-authentication/setup-authentication-001.png?featherlight=false&width=90pc)
2. Click **Gateway Responses**
* Chọn **Unauthorized**
* Click **Edit**
![Microservice Authentication](/images/4-configure-aaa/4.2-setup-authentication/setup-authentication-002.png?featherlight=false&width=90pc)
4. Để ứng dụng web của chúng ta có thể nhận được trạng thái **unauthorized (401)**, chúng ta cần thêm **CORS headers** vào phản hồi. Nếu không có header, trình duyệt sẽ không có quyền nhận trạng thái 401. Chúng ta đã bật CORS cho phản hồi trạng thái 200 khi chúng ta thiết lập các API Gateway endpoint trước đó. Nhưng chúng ta cần cho phép trả lại trạng thái 401 một cách rõ ràng.
* Click **Add response header**
* Trong cột **Response header** của **Response Header** thứ 1, nhập ```Access-Control-Allow-Origin```
* Cột **Value**, nhập ```'*'```
* Trong cột **Response header** của **Response Header** thứ 2, nhập ```Access-Control-Allow-Headers```
* Cột **Value**, nhập ```'*'```
* Click **Save**
![Microservice Authentication](/images/4-configure-aaa/4.2-setup-authentication/setup-authentication-003.png?featherlight=false&width=90pc)

#### Tạo một Authorizer sử dụng Cognito User Pool

**API Gateway** tích hợp chặt chẽ với **Cognito** cho xác thực. Bạn chỉ cần khai báo **Cognito User Pool** là một **authorizer** cho API của bạn.

5. Click **Authorizers**
* Click **Create New Authorizer**
* Tại mục **Name**, nhập ```TravelBuddy```
* Tại mục **Type**, chọn **Cognito**
* Tại mục **Cognito User Pool**, chọn **TravelBuddy**
* Tại mục **Token Source**, nhập ```Authorization```
* Click **Create**
![Microservice Authentication](/images/4-configure-aaa/4.2-setup-authentication/setup-authentication-005.png?featherlight=false&width=90pc)

#### Mở yêu cầu xác thực cho microservice **/trips**

6. Click **Resources**
* Chọn method **GET** trong **/trips**
* Click **Method Request**
![Microservice Authentication](/images/4-configure-aaa/4.2-setup-authentication/setup-authentication-006.png?featherlight=false&width=90pc)
7. Tại mục **Authorization**, click biểu tượng bút chì
![Microservice Authentication](/images/4-configure-aaa/4.2-setup-authentication/setup-authentication-007.png?featherlight=false&width=90pc)
8. Chọn **TravelBuddy**.Đây là authoriser mà chúng ta đã tạo ở bước trước và liên kết đến **Cognito User Pool** chúng ta đang sử dụng cho cơ sở dữ liệu người dùng. Nếu nó không xuất hiện, hãy thử làm mới trình duyệt của bạn.
* Click dấu tích xám để lưu lại
![Microservice Authentication](/images/4-configure-aaa/4.2-setup-authentication/setup-authentication-008.png?featherlight=false&width=90pc)



