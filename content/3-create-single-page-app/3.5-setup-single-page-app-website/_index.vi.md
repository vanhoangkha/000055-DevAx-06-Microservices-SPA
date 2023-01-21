+++
title = "Thiết lập trang SPA "
date = 2020
weight = 5
chapter = false
pre = "<b>3.5. </b>"
+++
#### Thiết lập trang SPA

Bây giờ chúng ta đã thiết lập ba API, chúng ta đã sẵn sàng gọi chúng từ trang web. Trước tiên, chúng ta cần thiết lập ứng dụng web đơn trang (SPA) và host nó trên Amazon S3.

Chúng ta đã quyết định sử dụng AngularJS framework cho SPA của mình. Tất nhiên bạn có thể sử dụng bất kỳ framework nào mà bạn cảm thấy phù hợp. Mục đích của bài thực hành này không phải để dạy bạn AngularJS hoặc bất kỳ framework SPA nào khác, vì vậy chúng ta sẽ không đi sâu vào chi tiết về cách hoạt động của trang, ngoài việc hướng dẫn bạn cách kết nối các lệnh gọi API mà SPA sẽ cần thực hiện để điền các phần tử dữ liệu của nó.

{{%attachments title="SPA Project" style="orange" pattern="www.zip"/%}}

1. Tải file **www.zip** và giải nén

#### Tạo client SDK cho từng API trong số ba API và triển khai tới SPA

Việc triển khai SPA mà bạn được cung cấp đã triển khai sơ bộ ba API mà chúng ta muốn cung cấp cho người dùng của mình. Họ có triển khai vừa đủ để không gây ra lỗi trên trang khi được thực thi, nhưng họ không cung cấp bất kỳ dữ liệu nào. Để ‘kết nối’ các API của chúng ta với SPA, chúng ta sẽ cần tạo các Javascript client SDK có liên quan đến các API này và lưu trữ chúng trong đường dẫn thích hợp.

2. Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Nhập **iDevelop - Flight Specials API** vào ô tìm kiếm và nhấn **Enter**
* Click **iDevelop - Flight Specials API**
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-001.png?featherlight=false&width=90pc)
3. Click **Stages**
* Chọn **prod**
* Click tab **SDK Generation**
* Tại mục **Platform**, chọn **Javascript**
* Click **Generate SDK**. Javascript SDK cho API sẽ được tải về từ trình duyệt của bạn.
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-002.png?featherlight=false&width=90pc)
4. Giải nén tệp tin tải về trong bước 3
* Tìm file **apigClient.js** trong thư mục vừa giải nén và đổi tên thành **apigClient_FlightSpecials.js**
5. Mở file **apigClient_FlightSpecials.js** trong Eclipse IDE. Dùng **Search/Replace** và thay hết các nội dung **apigClientFactory** bằng **apigClientFactory_FlightSpecials**. Sẽ có 2 lần xuất hiện để thay thế, cả hai lần xuất hiện ở đầu tập tin.
* Nhấn tổ hợp phím **Ctrl+F**
* Tại mục **Find**, điền ```apigClientFactory```
* Tại mục **Replace with**, điền ```apigClientFactory_FlightSpecials```
* Click **Replace All** để thay thế
* Lưu lại
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-003.png?featherlight=false&width=90pc)
6. Sao chép tập tin **apigClient_FlightSpecials.js** sang thư mục **api** trong thư mục **www** của ứng dụng đơn trang trong môi trường làm việc của bạn. Thay thế tệp tin **apigClient_FlightSpecials.js** trong thư mục **api**
7. Với **iDevelop - Hotel Specials API** làm tương tự như **iDevelop - Flight Specials API**
* Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Nhập **iDevelop - Hotel Specials API** vào ô tìm kiếm và nhấn **Enter**
* Click **iDevelop - Hotel Specials API**
8. Click **Stages**
* Chọn **prod**
* Click tab **SDK Generation**
* Tại mục **Platform**, chọn **Javascript**
* Click **Generate SDK**. Javascript SDK cho API sẽ được tải về từ trình duyệt của bạn.
9. Giải nén tệp tin tải về trong bước 8
* Tìm file **apigClient.js** trong thư mục vừa giải nén và đổi tên thành **apigClient_HotelSpecials.js**
10. Mở file **apigClient_HotelSpecials.js** trong Eclipse IDE. Dùng **Search/Replace** và thay hết các nội dung **apigClientFactory** bằng **apigClientFactory_HotelSpecials**.
* Nhấn tổ hợp phím **Ctrl+F**
* Tại mục **Find**, điền ```apigClientFactory```
* Tại mục **Replace with**, điền ```apigClientFactory_HotelSpecials```
* Click **Replace All** để thay thế
* Lưu lại
11. Sao chép tập tin **apigClient_HotelSpecials.js** sang thư mục **api** trong thư mục **www** của ứng dụng đơn trang trong môi trường làm việc của bạn. Thay thế tệp tin **apigClient_HotelSpecials.js** trong thư mục **api**
12. Với **iDevelop - Trip Search API** làm tương tự như **iDevelop - Flight Specials API**
* Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Nhập **iDevelop - Trip Search API** vào ô tìm kiếm và nhấn **Enter**
* Click **iDevelop - Trip Search API**
13. Click **Stages**
* Chọn **prod**
* Click tab **SDK Generation**
* Tại mục **Platform**, chọn **Javascript**
* Click **Generate SDK**. Javascript SDK cho API sẽ được tải về từ trình duyệt của bạn.
14. Giải nén tệp tin tải về trong bước 13
* Tìm file **apigClient.js** trong thư mục vừa giải nén và đổi tên thành **apigClient_TripSearch.js**
15. Mở file **apigClient_TripSearch.js** trong Eclipse IDE. Dùng **Search/Replace** và thay hết các nội dung **apigClientFactory** bằng **apigClientFactory_TripSearch**.
* Nhấn tổ hợp phím **Ctrl+F**
* Tại mục **Find**, điền ```apigClientFactory```
* Tại mục **Replace with**, điền ```apigClientFactory_TripSearch```
* Click **Replace All** để thay thế
* Lưu lại
16. Sao chép tập tin **apigClient_TripSearch.js** sang thư mục **api** trong thư mục **www** của ứng dụng đơn trang trong môi trường làm việc của bạn. Thay thế tệp tin **apigClient_TripSearch.js** trong thư mục **api**

#### Đẩy các tập tin SPA lên Amazon S3

Với các API SDK đã có, giờ đây bạn đã sẵn sàng triển khai mã nguồn SPA lên Amazon S3 Bucket đê trang web hoạt động. Quá trình thiết lập bài thực hành đã cung cấp một S3 bucket phù hợp, đã được kích hoạt WebSite Hosting. Vì vậy, bạn sẽ chỉ cần đẩy tất cả các tập tin từ máy của bạn sang S3 bucket để có thể kiểm tra ứng dụng.

17. Mở **Command Prompt** , chuyển đường dẫn tới project **www** đã giải nén trong bước 1
* Chạy câu lệnh dưới đây để đồng bộ hóa giữa máy cục bộ của bạn và S3 bucket
```
set AWS_PROFILE=devaxacademy
aws s3 sync . s3://<S3BucketWWWBucketName> --acl public-read
```
{{% notice note %}} 
Thay **\<S3BucketWWWBucketName\>** bằng giá trị **S3BucketWWWBucketName** trong tab **Output** của stack **DevAx-06**
{{% /notice %}}
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-004.png?featherlight=false&width=60pc)
18. Khi quá trình đồng bộ hóa hoàn tất, bạn đã sẵn sàng để kiểm tra SPA của mình được lưu trữ trên S3. Mở URL sau trong trình duyệt web
```
http://<S3BucketWWWBucketName>.s3-website-<YOUR_REGION>.amazonaws.com
```
{{% notice note %}} 
Thay **\<S3BucketWWWBucketName\>** bằng giá trị **S3BucketWWWBucketName** trong tab **Output** của stack **DevAx-06**\
Thay **<YOUR_REGION>** bằng **Region** của bạn
{{% /notice %}}
![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-005.png?featherlight=false&width=90pc)

Trang web TravelBuddy quen thuộc sẽ hiển thị trong trình duyệt của bạn. Trước đây, bạn đã từng thấy trang web này khi nó là một ứng dụng Java monolithic được cài đặt lên EC2 do Elastic Beanstalk quản lý. Nhưng bây giờ, trang web là một ứng dụng web một trang và được lưu trữ trong S3 bucket thực hiện các lệnh gọi API đến Amazon API Gateway để cung cấp dữ liệu cho trang web.

Bạn sẽ thấy danh sách Hotel Specials và Flight Specials được hiển thị trên trang.

Ngoài ra, tùy chọn **Find trips to…** có sẵn. Để kiểm tra điều này, hãy nhập ```Melbourne``` vào ô **Find trips to...** và nhấp vào nút **Go!**. Một hộp thoại sẽ xuất hiện hiển thị kết quả tìm kiếm. Dữ liệu này đang được cung cấp từ việc gọi đến **TripSearchAPI**, ở đường dẫn **/tripstocity**.

![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-006.png?featherlight=false&width=90pc)

Nếu bạn xóa giá trị trong trường và nhấp vào nút **Go!**, bạn sẽ thấy danh sách tất cả các chuyến đi có sẵn, được phục vụ từ lệnh gọi **TripSearchAPI** đến **/trips**.

![Setup The Single Page Application Website](/images/3-create-single-page-app/3.5-setup-single-page-app-website/setup-single-page-app-website-007.png?featherlight=false&width=90pc)

Nếu bạn không thấy dữ liệu là kết quả của các lệnh gọi API, hãy xem developer console trong trình duyệt để xem liệu có bất kỳ lỗi nào giúp tìm ra sự cố hay không.