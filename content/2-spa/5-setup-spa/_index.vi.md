+++
title = "Thiết lập trang SPA"
date = 2021
weight = 5
chapter = false
pre = "<b>2.5. </b>"
+++

**Thiết lập Ứng dụng Đơn trang**

Bây giờ chúng ta đã thiết lập ba API, chúng ta đã sẵn sàng gọi chúng từ trang web. Trước tiên, chúng ta cần thiết lập ứng dụng web đơn trang (SPA) và host nó trên Amazon S3.

Chúng ta đã quyết định sử dụng AngularJS framework cho SPA của mình. Tất nhiên bạn có thể sử dụng bất kỳ framework nào mà bạn cảm thấy phù hợp. Mục đích của bài thực hành này không phải để dạy bạn AngularJS hoặc bất kỳ framework SPA nào khác, vì vậy chúng ta sẽ không đi sâu vào chi tiết về cách hoạt động của trang, ngoài việc hướng dẫn bạn cách kết nối các lệnh gọi API mà SPA sẽ cần thực hiện để điền các phần tử dữ liệu của nó.

**Nội dung**
- [Tạo client SDK cho từng API trong số ba API và triển khai tới SPA](#tạo-client-sdk-cho-từng-api-trong-số-ba-api-và-triển-khai-tới-spa)
- [Đẩy các tập tin SPA lên Amazon S3](#đẩy-các-tập-tin-spa-lên-amazon-s3)

1. Tải xuống gói mã nguồn từ [www.zip](https://workshops.devax.academy/monoliths-to-microservices/module6/files/www.zip) và giải nén trên môi trường làm việc của bạn.

{{%attachments title="Mã nguồn ứng dụng" pattern=".*(zip)"/%}}

#### Tạo client SDK cho từng API trong số ba API và triển khai tới SPA

Việc triển khai SPA mà bạn được cung cấp đã triển khai sơ bộ ba API mà chúng ta muốn cung cấp cho người dùng của mình. Họ có triển khai vừa đủ để không gây ra lỗi trên trang khi được thực thi, nhưng họ không cung cấp bất kỳ dữ liệu nào. Để 'kết nối' các API của chúng ta với SPA, chúng ta sẽ cần tạo các Javascript client SDK có liên quan đến các API này và lưu trữ chúng trong đường dẫn thích hợp.

**Đối với từng API mà chúng ta đã tạo, hãy làm theo các hướng dẫn sau, sử dụng tên TripSearch, HotelSpecials hoặc FlightSpecials cho phù hợp:**

2. Truy cập vào **API Gateway console** và ở mục **APIs**, chọn **iDevelop - Flight Specials API** để xem các Resource của API.
3. Chọn **Stages**
4. Chọn **prod**
5. Chọn **SDK Generation**
6. Ở **Platform**, chọn ```Javascript```
7. Chọn **Generate SDK**. Javascript SDK cho API sẽ được tải về từ trình duyệt của bạn.
8. **Giải nén** tập tin ZIP và tìm tới tập tin ```apigClient.js```
9. **Đổi tên** tập tin thành ```apigClient_FlightSpecials.js```
10. Mở tập tin đã đổi tên trong Eclipse/Cloud9 IDE. Chỉnh sửa nó dưới dạng tập tin văn bản - chỉ cần kéo nó vào IDE hoặc mở tập tin bằng menu.
11. Dùng **Search/Replace** và thay hết các nội dung ```apigClientFactory``` bằng ```apigClientFactory_FlightSpecials```. Sẽ có **2 lần xuất hiện** để thay thế, cả hai lần xuất hiện ở đầu tập tin.
12. **Lưu** tập tin
13. **Sao chép** tập tin từ vị trí hiện tại sang thư mục ```api``` trong thư mục ```www``` của ứng dụng đơn trang trong môi trường làm việc của bạn. **Thay thế** bằng tập tin mà bạn lấy từ tập tin zip.

{{% notice note %}}
**Lặp lại** hướng dẫn ở trên hai lần - cho cả **TripSearch** và **HotelSpecials** API, hãy đảm bảo là tập tin ```apigClient.js``` từ các SDK tải về đổi thành ```apigClient_HotelSpecials.js``` và ```apigClient_TripSearch.js``` tương ứng, và bạn cần dùng **search/replace** nội dung ```apigClientFactory``` và thay bằng ```apigClientFactory_HotelSpecials``` và ```apigClientFactory_TripSearch``` tương ứng.
{{% /notice %}}

#### Đẩy các tập tin SPA lên Amazon S3

Với các API SDK đã có, giờ đây bạn đã sẵn sàng triển khai mã nguồn SPA lên Amazon S3 Bucket đê trang web hoạt động. Quá trình thiết lập bài thực hành đã cung cấp một S3 bucket phù hợp, đã được kích hoạt WebSite Hosting. Vì vậy, bạn sẽ chỉ cần đẩy tất cả các tập tin từ máy của bạn sang S3 bucket để có thể kiểm tra ứng dụng.

14. Trong cửa sổ lệnh, ```cd``` vào thư mục chứa mã nguồn của trang web SPA của bạn.
15. Đưa ra lệnh sau để đồng bộ hóa giữa máy cục bộ của bạn và S3 bucket. Đảm bảo thay thế \<S3BucketWWW\> bằng giá trị được chỉ định trong **Cloudformation Outputs**:

```bash
aws s3 sync . s3://<S3BucketWWW> --acl public-read
```

16. Khi quá trình đồng bộ hóa hoàn tất, bạn đã sẵn sàng để kiểm tra SPA của mình được lưu trữ trên S3. Mở URL sau trong trình duyệt web, thay thế tên của nhóm S3 bằng giá trị được hiển thị trong **Cloudformation Outputs** ``` S3BucketWWW``` :

```bash
http://<S3BucketWWW>.s3-website-ap-southeast-2.amazonaws.com
```

Trang web ```TravelBuddy``` quen thuộc sẽ hiển thị trong trình duyệt của bạn. Trước đây, bạn đã từng thấy trang web này khi nó là một ứng dụng Java monolithic được cài đặt lên EC2 do Elastic Beanstalk quản lý. Nhưng bây giờ, trang web là một ứng dụng web một trang và được lưu trữ trong S3 bucket thực hiện các lệnh gọi API đến Amazon API Gateway để cung cấp dữ liệu cho trang web.

Bạn sẽ thấy danh sách **Hotel Specials** và **Flight Specials** được hiển thị trên trang.

Ngoài ra, tùy chọn **Find trips to...** có sẵn. Để kiểm tra điều này, hãy nhập ```Melbourne``` vào trường văn bản và nhấp vào nút **Go!**. Một hộp thoại sẽ xuất hiện hiển thị kết quả tìm kiếm. Dữ liệu này đang được cung cấp từ việc gọi đến ```TripSearchAPI```, ở đường dẫn ```/tripsfromcity```.

Nếu bạn xóa giá trị trong trường và nhấp vào nút **Go!**, bạn sẽ thấy danh sách tất cả các chuyến đi có sẵn, được phục vụ từ lệnh gọi **TripSearchAPI** đến ```/trips```.

Nếu bạn không thấy dữ liệu là kết quả của các lệnh gọi API, hãy xem developer console trong trình duyệt để xem liệu có bất kỳ lỗi nào giúp tìm ra sự cố hay không.
