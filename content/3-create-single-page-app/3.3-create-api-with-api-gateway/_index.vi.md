+++
title = "Tạo và Cung cấp API với Amazon API Gateway"
date = 2020
weight = 3
chapter = false
pre = "<b>3.3. </b>"
+++
#### Tạo và Cung cấp API với Amazon API Gateway

1. Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home).
* Trong phần **Choose an API type**, tìm **REST API - Develop a REST API where you gain complete control over the request and response along with API management capabilities.**
* Click **Build**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-001.png?featherlight=false&width=90pc)
2. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-002.png?featherlight=false&width=90pc)
3. Trong phần **Create new API**, chọn **New API**
* Tại mục **API name**, điền ```iDevelop - Trip Search API```
* Tại mục **Description**, điền ```Allows searching ở trips from/to cities```
* Click **Create API**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-003.png?featherlight=false&width=90pc)
4. API sẽ được tạo và chỉ có đường dẫn **root**.
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-004.png?featherlight=false&width=90pc)
5. Trong trang **New Child Resource**
* Tại mục **Resource Name**, điền ```trips```
* Đánh dấu vào **Enable API Gateway CORS**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-005.png?featherlight=false&width=90pc)
6. Resource **/trips** sẽ được tạo. Chọn vào đường dẫn **/trips**
* Click **Actions**
* Click **Create Method**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-006.png?featherlight=false&width=90pc)
7. Trong danh sách liệt kê xuất hiện, chọn **GET** 
* Chọn dấu tick nâu bên cạnh để xác nhận lưu thiết lập.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-007.png?featherlight=false&width=90pc)
8. Tại mục **Lambda Region**, chọn **Region** của bạn
* Tại mục **Lambda Function**, nhập ```idevelop``` và chọn **idevelopTripSearchFull**
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-008.png?featherlight=false&width=90pc)
9. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-009.png?featherlight=false&width=90pc)
10. Khi method được tạo, bạn sẽ thấy bảng **Method Execution**:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-010.png?featherlight=false&width=90pc)
11. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-011.png?featherlight=false&width=90pc)
12. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-012.png?featherlight=false&width=90pc)
13. Sau một vài phút để hàm Lambda khởi chạy và thực thi, bạn sẽ thấy kết quả tương tự như sau:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-013.png?featherlight=false&width=90pc)
14. Click **/trips**
* Click **Actions**
* Click **Enable CORS**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-014.png?featherlight=false&width=90pc)
15. Click **Enable CORS and replace existing CORS headers**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-015.png?featherlight=false&width=90pc)
16. Click **Yes, replace existing values**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-016.png?featherlight=false&width=90pc)
17. Khi các mục liệt kê có dấu tích xanh, bạn có thể tiếp tục các bước kế. Sẽ mất một ít thời gian để hoàn thành.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-017.png?featherlight=false&width=90pc)
#### Cung cấp **/tripsfromcity** RESTful API endpoint

Đường dẫn đầu tiên mà chúng ta cung cấp khá đơn giản - /trips sẽ lấy tất cả các chuyến đi trong hệ thống.

Nhưng chúng ta biết việc triển khai mã nguồn của chúng ta cho phép chúng ta chỉ định một bộ lọc để truy vấn ở các chuyến đi xuất phát từ một thành phố cụ thể hoặc có điểm đến cụ thể. Vì vậy chúng ta muốn hiển thị chức năng này cho người dùng API của mình. Đầu tiên, chúng ta sẽ hiển thị đường dẫn **/tripfromcity**.

18. Trong phần **Resources**, click **/**
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-018.png?featherlight=false&width=90pc)
19. Tại mục **Resource Name**, điền ```tripsfromcity```
* Chọn **Enable API Gateway CORS**
* CLick **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-019.png?featherlight=false&width=90pc)
20. Lệnh gọi của chúng ta vào hàm Lambda yêu cầu thông số **city**. Chúng ta sẽ đi theo tiêu chuẩn ở RESTful interface và chuyển tham số này vào dưới dạng tham số truyền trên URL. Chọn **/tripsfromcity**
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-020.png?featherlight=false&width=90pc)
21. Tại mục **Resource Name**, điền ```{city}```
* Tại mục **Resource Path**, xóa nội dung mặc định và điền ```{city}```
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-021.png?featherlight=false&width=90pc)
22. Click **/{city}**
* Click **Actions**
* Click **Create Method**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-022.png?featherlight=false&width=90pc)
23. Trong danh sách liệt kê, chọn **GET**
* Click tick xám bên cạnh để xác nhận lưu thiết lập.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-023.png?featherlight=false&width=90pc)
24. Tại mục **Lambda Region**. chọn **Region** của bạn
* Tại mục **Lambda Function**, nhập ```idevelop``` và chọn **idevelopTripSearchFromCity**
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-024.png?featherlight=false&width=90pc)
25. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-025.png?featherlight=false&width=90pc)
26. Khi method được tạo, bạn sẽ thấy bảng **Method Execution**. Chúng ta không thể tiếp tục thực hiện kiểm thử gọi đến API bởi vì chúng ta cần biến đổi yêu cầu thông qua API Gateway nhằm lấy được thông tin {city} được truyền qua hàm Lambda chính xác.

**devlounge.lambda.FindTripsFromCityHandler** handler cần thấy được thông số truyền vào từ yêu cầu như sau:
```
{
	"payload" : 
	{
        "city": "Melbourne"
    }
}
```
{{% notice note %}} 
Điều này sẽ khiến hàm Lambda tìm kiếm DynamoDB ở tất cả các chuyến đi xuất phát từ Melbourne. Chúng ta cần thêm một Body Mapping Template cho method này ở API Gateway nhằm chuyển đổi thông số cho đúng theo yêu cầu.
{{% /notice %}}
* Click **Integration Request**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-026.png?featherlight=false&width=90pc)
27. Click **Mapping Templates**
* Click **When there are no templates defined (recommended)**
* Click **Add mapping template**
* Trong mục **Content-Type**, nhập ```application/json```
* Click dấu tick xám để lưu lựa chọn.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-027.png?featherlight=false&width=90pc)
28. Bên dưới mục **Generate template**, nhập
```
{
    "payload" : {
        "city": "$input.params('city')"
    }
}
```
{{% notice info %}} 
Template này sẽ lấy tham số **{city}** từ URL và thêm nó vào JSON payload và gửi đến hàm Lambda giống như hàm Lambda mong đợi.
{{% /notice %}}
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-028.png?featherlight=false&width=90pc)

{{% notice note %}} 
Schema được định nghĩa ở đây cho hàm Lambda này là hoàn toàn có thể tùy chỉnh và trong ứng dụng của bạn, bạn có thể sử dụng một mô hình hoàn toàn khác. Mẫu ánh xạ cung cấp cho bạn sự linh hoạt để chuyển đổi dữ liệu đến một cách nhanh chóng thông qua API Gateway endpoint.
{{% /notice %}}

29. Click **Method Execution**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-029.png?featherlight=false&width=90pc)
30. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-030.png?featherlight=false&width=90pc)
31. Trong mục **Path**, tại trường **{city}**, nhập ```Melbourne```
* Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-031.png?featherlight=false&width=90pc)
32. API Gateway sẽ thực hiện lệnh gọi vào hàm Lambda, truyền giá trị Melbourne vào Body Mapping Template mà bạn đã xác định, chèn tham số tìm kiếm Melbourne vào JSON payload được gửi đến hàm Lambda. Điều này sẽ khiến handler sử dụng JSON và thực hiện tìm kiếm trong bảng DynamoDB và trả về kết quả. Bạn sẽ thấy một kết quả tương tự như sau:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-032.png?featherlight=false&width=90pc)
33. Chọn **/{city}** trong phần **/tripsfromcity**
* Click **Actions**
* Click **Enable CORS**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-033.png?featherlight=false&width=90pc)
34. Click **Enable CORS and replace existing CORS headers**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-034.png?featherlight=false&width=90pc)
35. Click **Yes, replace existing values**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-035.png?featherlight=false&width=90pc)
36. Khi các mục liệt kê có dấu tick xanh, bạn có thể tiếp tục các bước kế. Sẽ mất một ít thời gian để hoàn thành.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-036.png?featherlight=false&width=90pc)
37. Click **/** trong phần **Resources**
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-037.png?featherlight=false&width=90pc)
38. Tại mục **Resource Name**, nhập ```tripstocity```
* Chọn **Enable API Gateway CORS**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-038.png?featherlight=false&width=90pc)
39. Lệnh gọi của chúng ta vào hàm Lambda yêu cầu thông số **city**. Chúng ta sẽ đi theo tiêu chuẩn ở RESTful interface và chuyển tham số này vào dưới dạng tham số truyền trên URL. Click **/tripstocity**
* Click **Actions**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-039.png?featherlight=false&width=90pc)
40. Tại mục **Resource Name**, nhập ```{city}```
* Tại mục **Resource Path**, xóa nội dung mặc định và nhập ```{city}```
* Chọn **Enable API Gateway CORS**
* Click **Create Resource**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-040.png?featherlight=false&width=90pc)
41. CLick **/{city}** trong phần **/tripstocity**
* Click **Actions**
* Click **Create Method**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-041.png?featherlight=false&width=90pc)
42. Trong danh sách liệt kê, chọn **GET**
* Click dấu tick xám bên cạnh để xác nhận lưu thiết lập.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-042.png?featherlight=false&width=90pc)
43. Trong mục **Lambda Region**, chọn **Region** của bạn
* Tại mục **Lambda Function**, nhập ```idevelop``` và chọn **idevelopTripSearchToCity**
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-043.png?featherlight=false&width=90pc)
44. Click **OK**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-044.png?featherlight=false&width=90pc)
45. Khi method được tạo, bạn sẽ thấy bảng **Method Execution**. Chúng ta không thể tiếp tục thực hiện kiểm thử gọi đến API bởi vì chúng ta cần biến đổi yêu cầu thông qua API Gateway nhằm lấy được thông tin {city} được truyền qua hàm Lambda chính xác.

**devlounge.lambda.FindTripsToCityHandler** handler cần thấy được thông số truyền vào từ yêu cầu như sau:
```
{
	"payload" : 
	{
        "city": "Melbourne"
    }
}
```
{{% notice note %}} 
Điều này sẽ khiến hàm Lambda tìm kiếm DynamoDB ở tất cả các chuyến đi đến Melbourne. Chúng ta cần thêm một Body Mapping Template cho method này ở API Gateway nhằm chuyển đổi thông số cho đúng theo yêu cầu.
{{% /notice %}}
* Click **Integration Request**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-045.png?featherlight=false&width=90pc)
46. Click **Mapping Templates**
* Chọn **When there are no templates defined (recommended)**
* Click **Add mapping template**
* Tại mục **Content-Type**, nhập ```application/json```
* Click dấu tick xám để lưu lựa chọn.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-046.png?featherlight=false&width=90pc)
47. Bên dưới mục **Generate template**, nhập
```
{
    "payload" : {
        "city": "$input.params('city')"
    }
}
```
* Click **Save**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-047.png?featherlight=false&width=90pc)
49. Click **Method Execution**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-048.png?featherlight=false&width=90pc)
50. Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-049.png?featherlight=false&width=90pc)
51. Trong mục **Path**, tại trường **{city}**, nhập ```Melbourne```
* Click **Test**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-050.png?featherlight=false&width=90pc)
52. API Gateway sẽ thực hiện lệnh gọi vào hàm Lambda, truyền giá trị Melbourne vào Body Mapping Template mà bạn đã xác định, chèn tham số tìm kiếm Melbourne vào JSON payload được gửi đến hàm Lambda. Điều này sẽ khiến handler sử dụng JSON và thực hiện tìm kiếm trong bảng DynamoDB và trả về kết quả. Bạn sẽ thấy một kết quả tương tự như sau:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-051.png?featherlight=false&width=90pc)
53. Click **/{city}** trong phần **/tripstocity**
* Click **Actions**
* Click **Enable CORS**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-052.png?featherlight=false&width=90pc)
54. CLick **Enable CORS and replace existing CORS headers**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-053.png?featherlight=false&width=90pc)
55. Click **Yes, replace existing values**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-054.png?featherlight=false&width=90pc)
56. Khi các mục liệt kê có dấu tick xanh, bạn có thể tiếp tục các bước kế. Sẽ mất một ít thời gian để hoàn thành.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-055.png?featherlight=false&width=90pc)
57. Nếu đã hoàn thành đến đây, bạn sẽ có một cây Resource nhìn tương tự như thế này:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-056.png?featherlight=false&width=90pc)

#### Triển khai API và Kiểm thử

58. Trong phần **Resources**, click **/**
* Click **Actions**
* CLick **Deploy API**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-057.png?featherlight=false&width=90pc)
59. Tại mục **Deployment stage**, chọn **[New Stage]**
* Tại mục **Stage name**, nhập ```prod```
* Tại mục **Stage description**, nhập ```Trips API```
* Tại mục **Deployment description**, nhập ```Initial deployment```
* Click **Deploy**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-058.png?featherlight=false&width=90pc)
60. Stage mới tên **prod** sẽ được tạo và bạn sẽ thấy **prod Stage Editor**
* Click **Invoke URL**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-059.png?featherlight=false&width=90pc)
61. Một cửa sổ mới sẽ mở ra và truy cập đến địa chỉ đó. Bạn sẽ thấy một thông báo lỗi nêu rõ **{"message":"Missing Authentication Token"}**. Điều này là do không có trình xử lý ở đường dẫn gốc của stage - bạn chỉ có các resources/methods được xác định bên dưới các đường dẫn **/trips**, **/tripsfromcity** và **/tripstocity**. 
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-060.png?featherlight=false&width=90pc)
62. Chỉnh sửa URL trong thanh URL của trình duyệt và thêm **/trips** rồi nhấn Enter. Trang sẽ làm mới và sau đó hiển thị tất cả các chuyến đi có sẵn dưới dạng JSON. Đầu ra sẽ tương tự như sau:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-061.png?featherlight=false&width=90pc)
63. Kiểm tra method **/tripsfromcity**, sử dụng ```/tripsfromcity/Melbourne``` để tìm kiếm tất cả các chuyến đi khởi hành từ Melbourne.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-062.png?featherlight=false&width=90pc)
64. Kiểm tra method **/tripstocity**, sử dụng ```/tripstocity/Melbourne``` để tìm kiếm tất cả các chuyến đi đến Melbourne.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-063.png?featherlight=false&width=90pc)

Nếu dữ liệu có vẻ đúng và không có lỗi, bạn đã sẵn sàng chuyển sang phần tiếp theo.

#### Sử dụng CloudFormation/SAM thông qua AWS CLI để triển khai microservice HotelSearch

Trong các bước trước đó, bạn đã triển khai và cấu hình microservice **TripSearch** theo cách thủ công, bao gồm các hàm Lambda và API Gateway resource. Bạn sẽ nhận thấy rằng có khá nhiều bước cần làm và thực hiện việc này theo cách thủ công rất tốn thời gian và dễ xảy ra lỗi. Trong bước này, bạn sẽ sử dụng AWS CLI và CloudFormation/SAM để triển khai microservice **HotelSearch**, thay vì triển khai thủ công các tài nguyên.

Bằng cách sử dụng CloudFormation/SAM, nhiều bước thủ công sẽ được thực hiện cho bạn, sắp xếp quy trình triển khai. Bạn vẫn sẽ phải kích hoạt quy trình theo cách thủ công, nhưng việc triển khai thực tế sẽ được tự động hóa.

**HotelSpecials** microservice cần truy cập vào cơ sở dữ liệu MySQL để truy xuất dữ liệu về các dữ liệu đặc biệt của khách sạn. Môi trường bài thực hành đã tự động triển khai và tạo cơ sở dữ liệu cho bạn và chi tiết kết nối được cung cấp trong CloudFormation Outputs với hướng dẫn bên dưới về nơi cập nhật các thông số trong template mà bạn sẽ sử dụng để triển khai microservice. Cơ sở dữ liệu MySQL đã được triển khai bằng Amazon RDS và không thể truy cập công khai vì nó được khởi chạy trong một mạng con riêng tư. Do đó, để hàm Lambda để có thể kết nối với cơ sở dữ liệu, hàm Lambda cũng sẽ cần được triển khai thành một mạng con riêng bằng cách kích hoạt VPC Integration. Tập tin template.yml được cung cấp có tất cả các thiết lập cần thiết để thực hiện việc này, bạn chỉ cần cập nhật các thông số theo hướng dẫn bên dưới.

{{%attachments title="HotelSpecials Project" style="orange" pattern="HotelSpecials.zip"/%}}

65. Tải file **HotelSpecials.zip** và giải nén
66. Mở **Command Prompt** và chuyển đường dẫn đến project **HotelSpecials** đã giải nén ở bước 65
* Chạy câu lệnh dưới đây:
```
set AWS_PROFILE=devaxacademy
mvn package shade:shade
```
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-064.png?featherlight=false&width=60pc)
67. Sau khi tập tin JAR đã được build sẽ nằm trong thư mục **target** của project và có tên là **hotelspecials-1.0.0.jar**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-065.png?featherlight=false&width=60pc)
68. Truy cập [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).
* Click **Stack**.
* Nhập ```DevAx-06``` vào ô tìm kiếm và nhấn **Enter**.
* Click **DevAx-06**.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-066.png?featherlight=false&width=90pc)
69. Click tab **Output**
* Lưu lại giá trị **DatabaseSecurityGroup**, **DatabaseSubnet1**, **DatabaseSubnet2**, **RDSEndpoint** và **S3BucketLambdaCodeBucketName** để sử dụng trong bước tiếp theo.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-067.png?featherlight=false&width=90pc)
70. Trong Eclipse IDE, mở file **template.yml**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-068.png?featherlight=false&width=90pc)
71. Thay **\<DatabaseSecurityGroup\>** bằng giá trị **DatabaseSecurityGroup** đã lưu trong bước 69
* Thay **\<DatabaseSubnet1\>** bằng giá trị **DatabaseSubnet1** đã lưu trong bước 69
* Thay **\<DatabaseSubnet2\>** bằng giá trị **DatabaseSubnet2** đã lưu trong bước 69
* Thay **\<RDSEndpoint\>** bằng giá trị **RDSEndpoint** đã lưu trong bước 69
* Lưu lại
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-069.png?featherlight=false&width=90pc)
72. Trong **Command Prompt**, chạy câu lệnh dưới đây để để đóng gói hàm Lambda (từ thành phần triển khai bạn đã tạo)
```
aws cloudformation package --template template.yml --s3-bucket <S3BucketLambdaCodeBucketName> --output-template template-export.yml
```
{{% notice note %}} 
Thay **\<S3BucketLambdaCodeBucketName\>** bằng giá trị **S3BucketLambdaCodeBucketName** đã lưu trong bước 69
{{% /notice %}}
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-070.png?featherlight=false&width=60pc)
{{% notice info %}} 
Lệnh sẽ tải lên các artifact vào S3 bucket, sau đó cập nhật con trỏ **template.yml** thành artifact trên S3 và ghi ra một mẫu mới có kèm theo bản cập nhật này vào một tệp có tên **template-export.yml**.\
Sẽ mất một hoặc hai phút để hoàn tất quá trình tải lên artifact.
{{% /notice %}}
73. Chạy lệnh dưới đây để tạo và triển khai **CloudFormation Change Set**
```
aws cloudformation deploy --template-file template-export.yml --stack-name HotelSpecialsAPI --capabilities CAPABILITY_IAM
```
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-071.png?featherlight=false&width=60pc)
74. Truy cập [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).
* Click **Stack**.
* Bạn sẽ thấy stack có tên **HotelSpecialsAPI**. Điều này cho thấy rằng **CloudFormation Change Set** đã được tạo. Lệnh bạn đã đưa ra sẽ tạo Change Set và sau đó tự động thực hiện Change Set. Sẽ mất một vài phút để hoàn tất quá trình thực thi.
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-072.png?featherlight=false&width=90pc)
75. Chọn **HotelSpecialsAPI** stack, click tab **Events** và xem lại các bước mà CloudFormation template đã áp dụng cho môi trường của bạn. Chúng sẽ khớp với các tài nguyên và hành động trong tập tin **template-output.yml**.
76. Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Click **iDevelop - Hotel Specials API**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-073.png?featherlight=false&width=90pc)
77. Click **Get**
* Click **Integration Request**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-074.png?featherlight=false&width=90pc)
78. Bảng **Integration Request** sẽ xuất hiện. **Lambda Function** xác định:
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-075.png?featherlight=false&width=90pc)

Giá trị được chỉ định không phải là một hàm Lambda, mà thay vào đó, là một **Stage Variable** sẽ được thay thế trong thời gian chạy bằng API Gateway. Do đó, để lệnh gọi API này thành công, **Stage** trong API Gateway phải xác định một giá trị cho Stage Variable **envHotelSpecials**

79. Click **Stages**
* Click **prod**
* Click tab **Stage Variables**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-076.png?featherlight=false&width=90pc)
{{% notice info %}} 
Một biến duy nhất được xác định - **envHotelSpecials** - giống với tên biến giai đoạn mà phương thức GET đã mong đợi. Giá trị của biến là **GetHotelSpecials** là tên của hàm Lambda mà mẫu được tạo bằng cách sử dụng tập tin JAR mà bạn đã tạo và tải lên trong quá trình đóng gói/triển khai.
{{% /notice %}}

#### Kiểm thử HotelSpecials API

80. Mở rộng **prod** trong **Stages** để xem cấu trúc.
* Click **Get**
* Click **Invoke URL**
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-077.png?featherlight=false&width=90pc)
81. Sau một khoảng thời gian, hàm Lambda khởi tạo, bạn sẽ thấy kết quả JSON truy xuất dữ liệu từ cơ sở dữ liệu MySQL về từ hàm Lambda
![Create And Expose the API with Amazon API Gateway](/images/3-create-single-page-app/3.3-create-api-with-api-gateway/create-api-with-api-gateway-078.png?featherlight=false&width=90pc)

Nếu bạn thấy một kết quả JSON không có lỗi, bạn đã triển khai thành công một API và hỗ trợ hàm Lambda truy vấn cơ sở dữ liệu mySQL.

Chú ý rằng chúng nhanh hơn và dễ hơn việc triển khai thủ công như thế nào?

Đó là sức mạnh của tự động hóa. Trong bài tập tiếp theo, chúng ta sẽ thực hiện bước này xa hơn, sử dụng phương pháp tiếp cận CI/CD pipeline (hiện đã phổ biến) để triển khai API tiếp theo của chúng ta.
