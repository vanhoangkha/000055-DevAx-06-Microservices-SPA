+++
title = "Tạo và Cung cấp API"
date = 2021
weight = 3
chapter = false
pre = "<b>2.3. </b>"
+++

**Tạo và Cung cấp API với Amazon API Gateway**

Hiện tại, bạn đã tạo xong các hàm Lambda, đã đến lúc tạo và triển khai thủ công API Gateway sẽ cung cấp microservice dưới dạng API.

**Nội dung**
- [Cung cấp **/tripsfromcity** RESTful API endpoint](#cung-cấp-tripsfromcity-restful-api-endpoint)
- [Cung cấp **/tripstocity** RESTful API endpoint](#cung-cấp-tripstocity-restful-api-endpoint)
- [Triển khai API và Kiểm thử](#triển-khai-api-và-kiểm-thử)
- [Exercise 2 - Use CloudFormation/SAM via the AWS CLI to deploy the HotelSearch microservice](#exercise-2---use-cloudformationsam-via-the-aws-cli-to-deploy-the-hotelsearch-microservice)
- [Kiểm thử HotelSpecials API](#kiểm-thử-hotelspecials-api)

1. Truy cập **AWS API Gateway console** thông qua menu **Services** và tìm ```api``` trong thanh tìm kiếm. Nhấn **Enter**.
2. Chọn **Get Started** nếu xuất hiện.
3. Đi đến **Create REST API** và chọn **Build**. Chắc rằng bạn **không** chọn lựa chọn có từ "**Private**".

![API Gateway](/images/2/6.png?width=90pc)

4. Ở màn hình kế tiếp, chọn **OK**. Chắc rằng bạn lựa chọn **New API** :

![API Gateway](/images/2/7.png?width=90pc)

5. Ở **API Name** nhập ```iDevelop - Trip Search API```
6. Ở **Description** nhập **Allows searching ở trips from/to cities**
7. Chọn **Create API**.

![API Gateway](/images/2/9.png?width=90pc)

8. API sẽ được tạo và chỉ có đường dẫn **root**. Chọn vào đường dẫn gốc **/** và chọn **Actions** để xem menu. Chọn **Create Resource**.

![API Gateway](/images/2/10.png?width=90pc)

9. Trong **New Child Resource**, ở **Resource Name** nhập ```trips```
10. Ở **Resource Path** nhập ```trips```
11. Đánh dấu vào **Enable API Gateway CORS** 
12. Chọn **Create Resource**

![API Gateway](/images/2/11.png?width=90pc)

13. Resource **/trips** sẽ được tạo. Chọn vào đường dẫn **/trips**, sau đó chọn  **Actions** và chọn **Create Method**.

![API Gateway](/images/2/12.png?width=90pc)

14. Trong danh sách liệt kê xuất hiện, chọn **GET**

![API Gateway](/images/2/13.png?width=90pc)

15. Chọn **dấu tick** bên cạnh để xác nhận lưu thiết lập.
16. Bảng **/trips - GET - Setup** sẽ xuất hiện. Ở **Lambda Region** chọn ```ap-northeast-1``` (hoặc region của bạn)
17. Ở **Lambda Function**, nhập ```idevelop``` để thấy các hàm đang có trong region và chọn ```idevelopTripSearchFull```.

![API Gateway](/images/2/14.png?width=90pc)

18. Chọn **Save**.
19. Trong hộp thoại xuất hiện sau khi phần quyền cho Lambda, chọn **OK**.
20. Khi method được tạo, bạn sẽ thấy bảng **Method Execution**:

![API Gateway](/images/2/15.png?width=90pc)

Để kiểm tra hàm Lambda được gọi bởi API, chọn nút **Test**.

21. Trong bảng **Method Test**, kéo xuống để thấy nút **Test**.

![API Gateway](/images/2/16.png?width=90pc)

22. Chọn nút **Test**. Sau một vài phút để hàm Lambda khởi chạy và thực thi, bạn sẽ thấy kết quả tương tự như sau:

![API Gateway](/images/2/17.png?width=90pc)

{{% notice note %}}
Lưu ý rằng dữ liệu bạn thấy sẽ khác vì nó được tạo ngẫu nhiên bởi quá trình thiết lập bài thực hành.
{{% /notice %}}

23. Để cho phép truy cập từ trình duyệt, bạn cần bật CORS - Cross-origin scripting.
Chọn vào **/trips** và từ menu **Actions**, chọn **Enable CORS**.
24. Chọn **Enable CORS and replace existing CORS headers**.
25. Trong hộp thoại xuất hiện, chọn **Yes, replace existing values**. Khi các mục liệt kê có **dấu tick xanh**, bạn có thể tiếp tục các bước kế. Sẽ mất một ít thời gian để hoàn thành.

#### Cung cấp **/tripsfromcity** RESTful API endpoint

Đường dẫn đầu tiên mà chúng ta cung cấp khá đơn giản - /trips sẽ lấy tất cả các chuyến đi trong hệ thống. 

Nhưng chúng ta biết việc triển khai mã nguồn của chúng ta cho phép chúng ta chỉ định một bộ lọc để truy vấn ở các chuyến đi **xuất phát** từ một thành phố cụ thể hoặc có **điểm đến** cụ thể. Vì vậy chúng ta muốn hiển thị chức năng này cho người dùng API của mình. Đầu tiên, chúng ta sẽ hiển thị đường dẫn **/tripfromcity**.

26. Chọn vàp **/** trong cây **Resources** 
27. Từ menu **Actions** chọn **Create Resource**
28. Ở **Resource Name** nhập ```tripsfromcity```
29. Chọn vào **Enable API Gateway CORS** 
30. Chọn **Create Resource**
31. Lệnh gọi của chúng ta vào hàm Lambda yêu cầu thông số **city**. Chúng ta sẽ đi theo tiêu chuẩn ở RESTful interface và chuyển tham số này vào dưới dạng tham số truyền trên URL. Chọn vào **/tripsfromcity**, từ menu **Actions**, chọn **Create Resource**
32. Ở **Resource Name** nhập ```{city}```
33. Ở **Resource Path**, xóa nội dung mặc định và nhập ```{city}```
34. Chọn **Create Resource**
35. Chọn vào **/{city}**, từ menu **Actions**, chọn **Create Method**
36. Trong danh sách liệt kê, chọn **GET**
37. Chọn **dấu tick xám** bên cạnh để xác nhận lưu thiết lập.
38. Bảng **/tripsfromcity/{city} - GET - Setup** sẽ xuất hiện. Ở **Lambda Region** chọn ```ap-northeast-1``` (hoặc region của bạn)
39. Ở **Lambda Function**, nhập ```idevelop``` để thấy các hàm đang có trong region và chọn ```idevelopTripSearchFromCity```
40. Chọn **Save**
41. Trong hộp thoại xuất hiện sau khi phần quyền cho Lambda, chọn **OK**.
42. Khi method được tạo, bạn sẽ thấy bảng **Method Execution** như bước trước tạo resource **/trips**. Chúng ta không thể tiếp tục thực hiện kiểm thử gọi đến API bởi vì chúng ta cần biến đổi yêu cầu thông qua API Gateway nhằm lấy được thông tin {city} được truyền qua hàm Lambda chính xác.

**devlounge.lambda.FindTripsFromCityHandler** handler cần thấy được thông số truyền vào từ yêu cầu như sau:

```json
{
	"payload" : 
	{
        "city": "Melbourne"
    }
}
```
{{% notice note %}}
Điều này sẽ khiến hàm Lambda tìm kiếm DynamoDB ở tất cả các chuyến đi xuất phát từ Melbourne. Chúng ta cần thêm một **Body Mapping Template** cho method này ở API Gateway nhằm chuyển đổi thông số cho đúng theo yêu cầu.
{{% /notice %}}

43. Trong bảng **/tripsfromcity/{city} - GET - Method Execution**, chọn **Integration Request**
44. Kéo xuống **Mapping Templates** và mở rộng mục bằng cách chọn vào dấu tam giác.
45. Chọn lựa chọn **When there are no templates defined (recommended)**
46. Chọn **Add mapping template**
47. Ở **Content-Type** nhập ```application/json``` và chọn **dấu tick xám** để lưu lựa chọn
48. Kéo xuống nữa để thấy khung nhập liệu. Nhập vào template sau:

```json
{
    "payload" : {
        "city": "$input.params('city')"
    }
}
```

49. Chọn **Save**.

Template này sẽ lấy tham số ```{city}``` từ URL và thêm nó vào JSON payload và gửi đến hàm Lambda giống như hàm Lambda mong đợi.

![API Gateway](/images/2/18.png?width=90pc)

{{% notice note %}}
Schema được định nghĩa ở đây cho hàm Lambda này là hoàn toàn có thể tùy chỉnh và trong ứng dụng của bạn, bạn có thể sử dụng một mô hình hoàn toàn khác. Mẫu ánh xạ cung cấp cho bạn sự linh hoạt để chuyển đổi dữ liệu đến một cách nhanh chóng thông qua API Gateway endpoint.
{{% /notice %}}

50. Bây giờ chúng ta đã có thể kiểm thử. Chọn **Method Execution** và quay về bảng **Method Execution**.
51. Chọn **Test** để hiện bảng Test.
52. Ở mục **Path**, ở thông số **{city}**, nhập ```Melbourne```
53. Chọn **Test**.

API Gateway sẽ thực hiện lệnh gọi vào hàm Lambda, truyền giá trị Melbourne vào Body Mapping Template mà bạn đã xác định, chèn tham số tìm kiếm Melbourne vào JSON payload được gửi đến hàm Lambda. Điều này sẽ khiến handler sử dụng JSON và thực hiện tìm kiếm trong bảng DynamoDB và trả về kết quả. Bạn sẽ thấy một kết quả tương tự như sau:

![API Gateway](/images/2/19.png?width=90pc)

54. Để cho phép truy cập từ trình duyệt, bạn cần bật CORS - Cross-origin scripting.
Chọn vào **/tripsfromcity/{city}** và từ menu **Actions**, chọn **Enable CORS**.
55. Chọn **Enable CORS and replace existing CORS headers**.
56. Trong hộp thoại xuất hiện, chọn **Yes, replace existing values**. Khi các mục liệt kê có **dấu tick xanh**, bạn có thể tiếp tục các bước kế. Sẽ mất một ít thời gian để hoàn thành.

#### Cung cấp **/tripstocity** RESTful API endpoint
Kế đến, chúng ta sẽ cung cấp Resource cuối cùng - **Trips API**, **/tripstocity**:

57. Chọn vàp **/** trong cây **Resources** 
58. Từ menu **Actions** chọn **Create Resource**
59. Ở **Resource Name** nhập ```tripstocity```
60. Chọn vào **Enable API Gateway CORS** 
61. Chọn **Create Resource**
62. Lệnh gọi của chúng ta vào hàm Lambda yêu cầu thông số **city**. Chúng ta sẽ đi theo tiêu chuẩn ở RESTful interface và chuyển tham số này vào dưới dạng tham số truyền trên URL. Chọn vào **/tripstocity**, từ menu **Actions**, chọn **Create Resource**
63. Ở **Resource Name** nhập ```{city}```
64. Ở **Resource Path**, xóa nội dung mặc định và nhập ```{city}```
65. Check the **Enable API Gateway CORS** checkbox
66. Chọn **Create Resource**
67. Chọn vào **/{city}**, từ menu **Actions**, chọn **Create Method**
68. Trong danh sách liệt kê, chọn **GET**
69. Chọn **dấu tick xám** bên cạnh để xác nhận lưu thiết lập.
70. Bảng **/tripstocity/{city} - GET - Setup** sẽ xuất hiện. Ở **Lambda Region** chọn ```ap-northeast-1``` (hoặc region của bạn)
71. Ở **Lambda Function**, nhập ```idevelop``` để thấy các hàm đang có trong region và chọn ```idevelopTripSearchToCity```
72. Chọn **Save**
73. Trong hộp thoại xuất hiện sau khi phần quyền cho Lambda, chọn **OK**.
74. Khi method được tạo, bạn sẽ thấy bảng **Method Execution** như bước trước tạo resource **/trips**. Chúng ta không thể tiếp tục thực hiện kiểm thử gọi đến API bởi vì chúng ta cần biến đổi yêu cầu thông qua API Gateway nhằm lấy được thông tin {city} được truyền qua hàm Lambda chính xác.

**devlounge.lambda.FindTripsToCityHandler** handler cần thấy được thông số truyền vào từ yêu cầu như sau:

```json
{
	"payload" : 
	{
        "city": "Melbourne"
    }
}
```

{{% notice note %}}
Điều này sẽ khiến hàm Lambda tìm kiếm DynamoDB ở tất cả các chuyến đi xuất phát từ Melbourne. Chúng ta cần thêm một **Body Mapping Template** cho method này ở API Gateway nhằm chuyển đổi thông số cho đúng theo yêu cầu.
{{% /notice %}}

75. Trong bảng **/tripstocity/{city} - GET - Method Execution**, chọn **Integration Request**
76. Kéo xuống **Mapping Templates** và mở rộng mục bằng cách chọn vào dấu tam giác.
77. Chọn lựa chọn **When there are no templates defined (recommended)**
78. Chọn **Add mapping template**
79. Ở **Content-Type** nhập ```application/json``` và chọn **dấu tick xám** để lưu lựa chọn
80. Kéo xuống nữa để thấy khung nhập liệu. Nhập vào template sau:

```json
{
    "payload" : {
        "city": "$input.params('city')"
    }
}
```

81. Chọn **Save**

Template này sẽ lấy tham số ```{city}``` từ URL và thêm nó vào JSON payload và gửi đến hàm Lambda giống như hàm Lambda mong đợi.

82. Kiểm thử gọi đến API **/tripstocity** để chắc chắn nó đã hoạt động.

![API Gateway](/images/2/20.png?width=90pc)

83. Để cho phép truy cập từ trình duyệt, bạn cần bật CORS - Cross-origin scripting.
Chọn vào **/tripstocity/{city}** và từ menu **Actions**, chọn **Enable CORS**.
84. Chọn **Enable CORS and replace existing CORS headers**
85. Trong hộp thoại xuất hiện, chọn **Yes, replace existing values**. Khi các mục liệt kê có **dấu tick xanh**, bạn có thể tiếp tục các bước kế. Sẽ mất một ít thời gian để hoàn thành.

Nếu đã hoàn thành đến đây, bạn sẽ có một cây Resource nhìn tương tự như thế này:

![API Gateway](/images/2/21.png?width=90pc)

#### Triển khai API và Kiểm thử

86. Bây giờ bạn chắc chắn rằng các microservices đang hoạt động bình thường, bạn đã sẵn sàng triển khai API và kiểm tra nó từ endpoint công khai. Chọn vàp **/** của API và chọn nút **Actions**.
87. Chọn **Deploy API**

![API Gateway](/images/2/22.png?width=90pc)

88. Trong hộp thoại **Deploy API** xuất hiện, ở **Deployment stage** chọn ```[New Stage]``` để tạo một stage mới.
89. Ở **Stage name** nhập ```prod```
90. Ở **Stage description** nhập ```Trips API```
91. Ở **Deployment description** nhập ```Initial deployment```
92. Chọn **Deploy**

![API Gateway](/images/2/23.png?width=90pc)

Stage mới tên **prod** sẽ được tạo và bạn sẽ thấy **prod Stage Editor**

![API Gateway](/images/2/24.png?width=90pc)

93. Chọn đường dẫn **Invoke URL**. Một cửa sổ mới sẽ mở ra và truy cập đến địa chỉ đó. Bạn sẽ thấy một thông báo lỗi nêu rõ ```{"message":"Missing Authentication Token"}```. Điều này là do không có trình xử lý ở đường dẫn gốc của stage - bạn chỉ có các resources/methods được xác định bên dưới các đường dẫn **/trips, /tripsfromcity** và **/tripstocity**. Chỉnh sửa URL trong thanh URL của trình duyệt và  thêm **/trips** rồi nhấn **Enter**. Trang sẽ làm mới và sau đó hiển thị tất cả các chuyến đi có sẵn dưới dạng JSON. Đầu ra sẽ tương tự như sau:

```json
{
	"succeeded": true,
	"message": "",
	"errorCode": 0,
	"data": [{
		"date": 1511866019000,
		"originCity": "Dallas",
		"destinationCity": "Santigo de Chile",
		"airline": "Qantas"
	}, {
		"date": 1514831014000,
		"originCity": "London",
		"destinationCity": "Melbourne",
		"airline": "Qantas"
	}]
}
```

94. Kiểm tra hai cái method còn lại **/tripsfromcity** và **/tripstocity** theo cách tương tự, nhưng lần này, bạn cần cung cấp thành phố để tìm kiếm. Ví dụ, sử dụng ```/tripsfromcity/Melbourne``` để tìm kiếm tất cả các chuyến đi khởi hành từ Melbourne.

Nếu dữ liệu có vẻ đúng và không có lỗi, bạn đã sẵn sàng chuyển sang bài tập tiếp theo.

#### Exercise 2 - Use CloudFormation/SAM via the AWS CLI to deploy the HotelSearch microservice

Trong các bước trước đó, bạn đã triển khai và cấu hình vi microservice **TripSearch** theo cách **thủ công**, bao gồm các hàm Lambda và API Gateway resource. Bạn sẽ nhận thấy rằng có khá nhiều bước cần làm và thực hiện việc này theo cách thủ công rất tốn thời gian và dễ xảy ra lỗi. Trong bước này, bạn sẽ sử dụng AWS CLI và CloudFormation/SAM để triển khai microservice **HotelSearch**, thay vì triển khai thủ công các tài nguyên.

Bằng cách sử dụng CloudFormation/SAM, nhiều bước thủ công sẽ được thực hiện cho bạn, sắp xếp quy trình triển khai. Bạn vẫn sẽ phải kích hoạt quy trình theo cách thủ công, nhưng việc triển khai thực tế sẽ được tự động hóa.

**HotelSpecials** microservice cần truy cập vào cơ sở dữ liệu MySQL để truy xuất dữ liệu về các dữ liệu đặc biệt của khách sạn. Môi trường bài thực hành đã tự động triển khai và tạo cơ sở dữ liệu cho bạn và chi tiết kết nối được cung cấp trong **CloudFormation Outputs** với hướng dẫn bên dưới về nơi cập nhật các thông số trong template mà bạn sẽ sử dụng để triển khai microservice. Cơ sở dữ liệu MySQL đã được triển khai bằng Amazon RDS và không thể truy cập công khai vì nó được khởi chạy trong một mạng con riêng tư. Do đó, để hàm Lambda để có thể kết nối với cơ sở dữ liệu, hàm Lambda cũng sẽ cần được triển khai thành một mạng con riêng bằng cách kích hoạt VPC Integration. Tập tin ```template.yml``` được cung cấp có tất cả các thiết lập cần thiết để thực hiện việc này, bạn chỉ cần cập nhật các thông số theo hướng dẫn bên dưới.

95. Môi trường bài thực hành đã tạo một S3 bucket cho bạn để lưu trữ phần mềm triển khai cho hàm Lambda ở microservice HotelSpecials. Đầu tiên, bạn cần kiểm tra và xây dựng gói triển khai.

Tải xuống gói mã nguồn từ [HotelSpecials.zip](https://workshops.devax.academy/monoliths-to-microservices/module6/files/HotelSpecials.zip) và giải nén trên máy bạn.

{{%attachments title="HotelSpecials source code bundle" pattern=".*(zip)"/%}}

96. Trong cửa số lệnh, ```cd``` vào vị trí giải nén mã nguồn **HotelSpecials** và xây dựng các thành phần triển khai bằng lệnh sau:

```bash
mvn package shade:shade
```

Phần mềm xây dựng xong (JAR file) sẽ được lưu tại ```./target/hotelspecials-1.0.0.jar```

97. Tìm tập tin ```template.yml``` trong thư mục mã nguồn **HotelSpecials** và mở nó trong trình soạn thảo văn bản như Eclipse. **Tìm và thay thế** các thông số sau với thông tin lấy từ **CloudFormation Outputs**:

- \<DatabaseSecurityGroup\>
- \<DatabaseSubnet1\>
- \<DatabaseSubnet2\>
- \<RDSEndpoint\>

Lưu tập tin ```template.yml``` sau khi đã thay đổi.

98. Sử dụng AWS CLI để đóng gói hàm Lambda (từ thành phần triển khai bạn vừa tạo). Chạy lệnh sau từ cửa sổ dòng lệnh:

```bash
aws cloudformation package --template template.yml --s3-bucket <S3BucketLambdaCode> --output-template template-export.yml
```

{{% notice note %}}
Thay giá trị trong **Cloudformation Outputs** bằng giá trị của  **S3BucketLambdaCodeBucketName**. **Không** thêm ký tự \**<** và \**>**.
{{% /notice %}}

Lệnh sẽ tải lên các artifact vào S3 bucket, sau đó cập nhật con trỏ ```template.yml``` thành artifact trên S3 và ghi ra một mẫu mới có kèm theo bản cập nhật này vào một tệp có tên ```template-export.yml```.

{{% notice tip %}}
Sẽ mất một hoặc hai phút để hoàn tất quá trình tải lên artifact.
{{% /notice %}}

99. Sử dụng **AWS CLI** để tạo và triển khai **CloudFormation Change Set**:

```bash
aws cloudformation deploy --template-file template-export.yml --stack-name HotelSpecialsAPI --capabilities CAPABILITY_IAM
```

100. Trong web browser, mở **CloudFormation console**. Bạn sẽ thấy một kết quả như thế này:

![API Gateway](/images/2/25.png?width=90pc)

Điều này cho thấy rằng **CloudFormation Change Set** đã được tạo. Lệnh bạn đã đưa ra sẽ tạo Change Set và sau đó tự động thực hiện Change Set, vì vậy nếu bạn làm mới lại stack, bạn sẽ thấy:

![API Gateway](/images/2/26.png?width=90pc)

Điều này cho thấy rằng Change Set đang được áp dụng cho CloudFormation stack có tên **HotelSpecialsAPI**

Sẽ mất một vài phút để hoàn tất quá trình thực thi. Nếu bạn làm mới, cuối cùng bạn sẽ thấy:

![API Gateway](/images/2/27.png?width=90pc)

101. Chọn **HotelSpecialsAPI** stack để đánh dấu, chọn **Events** và xem lại các bước mà CloudFormation template đã áp dụng cho môi trường của bạn. Chúng sẽ khớp với các tài nguyên và hành động trong tập tin ```template-output.yml```.

102. Khi Change Set đã được thực thi, **HotelSpecials API** của bạn đã được triển khai. Mở **API Gateway console** trong trình duyệt và trong **APIs**, chọn liên kết **iDevelop - Hotel Specials API** để hiển thị các tài nguyên trong API:

![API Gateway](/images/2/28.png?width=90pc)

{{% notice note %}}
Lưu ý rằng một phương thức **GET** duy nhất được xác định, theo mẫu CloudFormation template ```template.yml``` mà bạn đã triển khai.
{{% /notice %}}

103. Chọn vào **GET** method ở **/hotelspecials** để thấy bảng **/hotelspecials - GET - Method Execution**. Chọn **Integration Request**

![API Gateway](/images/2/29.png?width=90pc)

104. Bảng **Integration Request** sẽ xuất hiện. **Lambda Function** xác định rõ:

![API Gateway](/images/2/30.png?width=90pc)

The specified value is not a Lambda function, but instead, is a **Stage Variable** that will be replaced at runtime by API Gateway. Therefore, in order for this API call to succeed, the **Stage** in API Gateway must have defined a value for the ```envHotelSpecials``` stage variable.

Giá trị được chỉ định không phải là một hàm Lambda, mà thay vào đó, là một **Stage Variable** sẽ được thay thế trong thời gian chạy bằng API Gateway. Do đó, để lệnh gọi API này thành công, **Stage** trong API Gateway phải xác định một giá trị cho **Stage Variable** ```envHotelSpecials```.

Chọn vào **Stages** bên dưới **iDevelop - Hotel Specials API**:

![API Gateway](/images/2/31.png?width=90pc)

105. Chọn vào đường dẫn **prod** 

![API Gateway](/images/2/32.png?width=90pc)

106. Trong **prod Stage Editor** chọn **Stage Variables** 

![API Gateway](/images/2/33.png?width=90pc)

{{% notice note %}}
Lưu ý rằng một biến duy nhất được xác định - ```envHotelSpecials``` - tương quan với tên biến giai đoạn mà phương thức **GET** đã mong đợi. Giá trị của biến là **GetHotelSpecials** là tên của hàm Lambda mà mẫu được tạo bằng cách sử dụng tập tin JAR mà bạn đã tạo và tải lên trong quá trình đóng gói/triển khai.
{{% /notice %}}

Việc sử dụng các biến giai đoạn cung cấp cho bạn mức độ chuyển hướng trong thời gian chạy và cả khi thiết kế các CloudFormation/SAM templates của bạn. Bạn có thể cập nhật giá trị của biến giai đoạn bất kỳ lúc nào mà không cần phải triển khai lại API.

#### Kiểm thử HotelSpecials API

Bây giờ bạn đã sẵn sàng để kiểm tra HotelSpecials API.

107. Mở rộng **prod** trong **Stages** để xem cấu trúc.
108. Chọn vào method **GET**
109. Chọn vào **Invoke URL** trong bảng **prod - GET - /hotelspecials**. Sau một khoảng thời gian, hàm Lambda khởi tạo, bạn sẽ thấy kết quả JSON truy xuất dữ liệu từ cơ sở dữ liệu MySQL về từ hàm Lambda.

```json
{
	"succeeded": true,
	"message": "",
	"errorCode": 0,
	"data": [{
		"hotel": "Sommerset Hotel",
		"description": "Minimum stay 3 nights",
		"cost": 474,
		"expiryDate": 1504064184038,
		"location": "Sydney",
		"id": 1
	}, {
		"hotel": "Freedmom Apartments",
		"description": "Pets allowed!",
		"cost": 501,
		"expiryDate": 1504068564781,
		"location": "Sydney",
		"id": 2
	}]
}
```

Nếu bạn thấy một kết quả JSON không có lỗi, bạn đã triển khai thành công một API và hỗ trợ hàm Lambda truy vấn cơ sở dữ liệu mySQL.

Chú ý rằng chúng nhanh hơn và dễ hơn việc triển khai thủ công như thế nào? 

Đó là sức mạnh của tự động hóa. Trong bài tập tiếp theo, chúng ta sẽ thực hiện bước này xa hơn, sử dụng phương pháp tiếp cận CI/CD pipeline (hiện đã phổ biến) để triển khai API tiếp theo của chúng ta.
