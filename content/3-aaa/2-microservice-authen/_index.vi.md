+++
title = "Xác thực cho Microservice"
date = 2021
weight = 2
chapter = false
pre = "<b>3.2. </b>"
+++

**Thiết lập Xác thực cho Microservice**

Ngay bây giờ, nếu bạn nhấp vào nút **Go!**trên trang web và không nhập thành phố để lọc, bạn sẽ thấy một hộp thoại với tất cả các chuyến đi có sẵn. Chúng ta muốn thay đổi hành vi này để bạn phải đăng nhập để có thể tìm kiếm tất cả các chuyến đi mà không cần bộ lọc. Đây chỉ là một ví dụ để chứng minh cách chúng ta có thể giới hạn các lệnh gọi API nhất định cho chỉ những người dùng được xác thực.

**Contents**
- [Cập nhật AWS API Gateway](#cập-nhật-aws-api-gateway)
- [Tạo một Authorizer sử dụng Cognito User Pool](#tạo-một-authorizer-sử-dụng-cognito-user-pool)
- [Mở yêu cầu xác thực cho microservice **/trips**](#mở-yêu-cầu-xác-thực-cho-microservice-trips)

#### Cập nhật AWS API Gateway

1. Truy cập **AWS API Gateway console**, chọn liên kết **Gateway Responses** ở mục liên kết **iDevelop - Trip Search API** link.
2. Trong bảng **Gateway Responses**, kéo xuống và chọn ```Unauthorized (401)``` để mở thiết lập.
3. Chọn **Edit**
4. Để ứng dụng web của chúng ta có thể nhận được trạng thái **unauthorized 401**, chúng ta cần thêm **CORS headers** vào phản hồi. Nếu không có header, trình duyệt sẽ không có quyền nhận trạng thái 401. Chúng ta đã bật CORS cho phản hồi trạng thái 200 khi chúng ta thiết lập các API Gateway endpoint trước đó. Nhưng chúng ta cần cho phép trả lại trạng thái 401 một cách rõ ràng.

Trong phần **Response Headers**, thêm hai cặp header/giá trị sau:

|          Tên Header          | 'static value' |
|:----------------------------:|:--------------:|
| Access-Control-Allow-Origin  | '*'            |
| Access-Control-Allow-Headers | '*'            |

{{% notice warning %}}
Bạn phải thêm các dấu nháy đơn xung quanh giá trị tĩnh như được hiển thị ở trên. Không thêm * bởi chính nó, hãy bao quanh nó bằng các dấu ngoặc kép như được hiển thị. Đảm bảo rằng không có khoảng trắng sau tên tiêu đề nếu bạn sao chép/dán từ các cloudformation của bài thực hành. 
{{% /notice %}}

![microservices](/images/3/4.png?width=90pc)

5. Chọn nút **Save** trong bảng ```401``` để lưu thiết lập.

#### Tạo một Authorizer sử dụng Cognito User Pool

**API Gateway** tích hợp chặt chẽ với **Cognito** cho xác thực. Bạn chỉ cần khai báo **Cognito User Pool** là một **authorizer** cho API của bạn.

6. Chọn liên kết **Authorizers** ở trong liên kết **iDevelop - Trip Search API** trong thanh điều hướng
7. Chọn **Create New Authorizer**
8. Ở **Name** nhập ```TravelBuddy```
9. Ở **Type** chọn ```Cognito```
10. Chọn giá trị ```TravelBuddy``` từ danh sách **Cognito User Pool** bằng cách chọn vào giá trị hiển thị
11. Ở **Token Source** nhập ```Authorization``` và chú ý đánh vần cũng như các chữ viết hoa chính xác.
12. Chọn **Create**

#### Mở yêu cầu xác thực cho microservice **/trips**

13. Chọn **Resources** ở trong liên kết **iDevelop - Trip Search API** trong thanh điều hướng
14. Chọn method **GET** trong ```/trips```
15. Chọn **Method Request**
16. Chọn **biểu tượng bút chì** ở cạnh mục **Authorization** từ menu hiển thị, chọn ```TravelBuddy```. Đây là authoriser mà chúng ta đã tạo ở bước trước và liên kết đến **Cognito User Pool** chúng ta đang sử dụng cho cơ sở dữ liệu người dùng. Nếu nó không xuất hiện, hãy thử làm mới trình duyệt của bạn.

![microservices](/images/3/5.png?width=90pc)

17. Chọn **dấu tick xám** ở cạnh giá trị để lưu thiết lập.
