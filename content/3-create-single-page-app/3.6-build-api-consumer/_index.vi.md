+++
title = "Tạo một Client để sử dụng API"
date = 2020
weight = 6
chapter = false
pre = "<b>3.6. </b>"
+++
#### Tạo một Client để sử dụng API

Bây giờ bạn có một mô hình hoạt động của trang web đang chạy như một SPA gọi dữ liệu thông qua RESTful API được lưu trữ trên AWS Lambda và cung cấp từ Amazon API Gateway. Các nguồn cấp dữ liệu này được coi là công khai vì người dùng không cần đăng nhập và cung cấp thông tin đăng nhập cho lệnh gọi tới API. Trong bài tập này, bạn sẽ xem xét cách bạn có thể yêu cầu xác thực để thực hiện lệnh gọi API và việc sử dụng Khóa API để thực thi điều chỉnh tốc độ cuộc gọi và quản lý hạn ngạch. Để chứng minh, bạn sẽ sử dụng một ứng dụng Java client, để chỉ ra cách bạn có thể sử dụng các Java SDK được tạo tự động trong các ứng dụng của bạn.

#### Tạo Response Model cho TripSearch API

Để trình tạo SDK có thể tạo các lớp thích hợp cho một ngôn ngữ mạnh như Java (đối lập với Javascript), chúng ta cần cho API Gateway biết hình dạng hoặc schema của các đối tượng yêu cầu/phản hồi trông như thế nào. Trong **TripSearch API**, bạn đang sử dụng phương thức **GET** cho mỗi lệnh gọi API. Do đó, không có schema nào cho các yêu cầu gửi đến vì tham số **city** được truyền như một phần của URL. Thay vào đó, nếu bạn thay đổi phương thức thành **POST**, bạn sẽ cần truyền tham số thành phố trong tải trọng **body** và sẽ cần tạo một mô hình cho schema đối tượng này cho trình tạo mã để tạo một lớp Java để bạn sử dụng.

Dữ liệu kết quả từ các lệnh gọi API được trả về trong body của phản hồi. Để trình tạo mã có thể tạo một lớp thích hợp để đại diện cho phản hồi này, chúng ta cần tạo một mô hình phản hồi và đặt nó làm mô hình phản hồi phương thức.

1. Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Nhập **iDevelop - Trip Search API** vào ô tìm kiếm và nhấn **Enter**
* Click **iDevelop - Trip Search API** 
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-001.png?featherlight=false&width=90pc)
2. Click **Models**
* Click **Create**
* Tại mục **Model name** nhập ```TripsFromCityResponse```
* Tại mục **Content-type** nhập ```application/json```
* Tại mục **Model schema** nhập 
```
{
  "type": "object",
  "properties": {
    "succeeded": {
      "type": "boolean"
    },
    "errorMessage": {
      "type": "string"
    },
    "errorType": {
      "type": "number"
    },
    "data": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "date": {
            "type": "number"
          },
          "originCity": {
            "type": "string"
          },
          "destinationCity": {
            "type": "string"
          },
          "airline": {
            "type": "string"
          }
        }
      }
    }
  },
  "title": "TripsFromCityResponse"
}
```
* Click **Create model**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-002.png?featherlight=false&width=90pc)

#### Gán TripsFromCityResponse model cho API **/tripsfromcity** 

3. Click **Resources**
* Chọn **GET** trong **/tripsfromcity/{city}**
* Click **Method Response**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-003.png?featherlight=false&width=90pc)
4. Trong bảng **/tripsfromcity/{city} - GET - Method Response** chọn icon tam giác cạnh **HTTP Status**
* Ở mục **Response Body for 200** click biểu tượng bút chì kế bên **Empty model**.
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-004.png?featherlight=false&width=90pc)
5. Trường sẽ trở thành một danh sách thả xuống. Chọn **TripsFromCityResponse**
* Click vào dấu tích màu xám
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-005.png?featherlight=false&width=90pc)
6. Click **Actions**
* Click **Deploy API**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-006.png?featherlight=false&width=90pc)
7. Tại mục **Deployment stage**, chọn **prod**
* Click **Deploy**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-007.png?featherlight=false&width=90pc)
8. Trong mục **prod Stage Editor** xuất hiện, click **SDK Generation**
* Tại mục **Platform**, chọn **Java SDK**
* Tại mục **Service name**, nhập ```TripSearch```
* Tại mục **Java package name**, nhập ```idevelop.api.sdk```
* Click **Generate SDK**. Java SDK sẽ được tạo và tải xuống dưới dạng tệp ZIP.
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-008.png?featherlight=false&width=90pc)
9. Giải nén tệp ZIP đã tải xuống trong bước 8
* Mở **Command Prompt** và chuyển đường dẫn đến mã nguồn vừa giải nén (thư mục được gọi là **generated-code**)
* Chạy lệnh dưới đây
```
mvn install
```
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-009.png?featherlight=false&width=60pc)
Việc này sẽ biên dịch và cài đặt SDK trong kho lưu trữ Maven cục bộ của bạn và chúng tôi sẽ đề cập đến nó trong các bước tiếp theo.

#### Tạo một ứng dụng client Java sử dụng API

{{%attachments title="TripSearchJavaClient Project" style="orange" pattern="TripSearchJavaClient.zip"/%}}

10. Tải file **TripSearchJavaClient.zip** và giải nén
11. Trong Eclipse IDE, mở froject đã giải nén trong bước 10
* Mở file **pom.xml**
* Thay nội dung file **pom.xml** bằng nội dung dưới đây
```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>idevelop.api.tripsearch.sdk.app</groupId>
  <artifactId>TripSearch-sdkClient</artifactId>
  <packaging>jar</packaging>
  <version>1.0-SNAPSHOT</version>
  <name>TripSearch-sdkClient</name>
  <url>http://maven.apache.org</url>
      <properties>
      <maven.compiler.source>1.8</maven.compiler.source>
      <maven.compiler.target>1.8</maven.compiler.target>
  </properties>
  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>3.8.1</version>
      <scope>test</scope>
    </dependency>
    <dependency>
        <groupId>idevelop.api.sdk</groupId>
        <artifactId>TripSearch</artifactId>
        <version>1.0-SNAPSHOT</version>
        <scope>compile</scope>
    </dependency>
  </dependencies>
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-shade-plugin</artifactId>
        <version>3.2.4</version>
        <executions>
          <execution>
            <phase>package</phase>
            <goals>
              <goal>shade</goal>
            </goals>
            <configuration>
              <transformers>
                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                  <mainClass>idevelop.api.tripsearch.sdk.app.App</mainClass>
                </transformer>
              </transformers>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
```
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-010.png?featherlight=false&width=90pc)
12. Trong **Command Prompt**, chuyển đường dẫn đến mã nguồn giải nén trong bước 10
* Chạy lệnh dưới đây
```
mvn package
```
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-011.png?featherlight=false&width=60pc)
13. Chạy câu lệnh dưới đây để chạy project
```
java -jar target/TripSearch-sdkClient-1.0-SNAPSHOT.jar
```
* Chúng ta sẽ thấy được kết quả.
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-012.png?featherlight=false&width=60pc)

**API consumer** sẽ tính thời gian mỗi lần gọi tới API mất bao lâu và hiển thị kết quả. Nó sẽ thực hiện tối đa 100 lần gọi nhanh nhất có thể.

Nếu chúng ta có nhiều người dùng sử dụng API liên tục. Chúng ta có thể vượt quá cơ sở hạ tầng được cung cấp, vì vậy chúng ta cần một vài cách để điều tiết các lần gọi API. Chúng ta có thể sử dụng **Usage Plans** để làm việc này.

14. Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Nhập **iDevelop - Trip Search API** vào ô tìm kiếm và nhấn **Enter**
* Click **iDevelop - Trip Search API** 
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-013.png?featherlight=false&width=90pc)
15. Click **Usage Plans**
* Click **Create**
* Tại mục **Name**, nhập ```LabPlan```
* Tại mục **Rate**, nhập ```1```
* Tại mục **Burst**, nhập ```1```
* Tại mục **Quota**, điền ```1000``` mỗi tháng
* Click **Next**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-014.png?featherlight=false&width=90pc)
16. Click **Add API Stage**
* Trong danh sách **API**, chọn **iDevelop - Trip Search API**
* Trong danh sách **Stage**, chọn **prod**
* Click dấu tích màu xám
* Click **Next**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-015.png?featherlight=false&width=90pc)
17. CLick **Create API Key and add to Usage Plan**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-016.png?featherlight=false&width=90pc)
18. Trong hộp thoại xuất hiện, tại mục **Name** điển ```SDKClient```
* Click **Save**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-017.png?featherlight=false&width=90pc)
19. Click **Done**, một **API key** được tạo và được liên kết với Usage Plan
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-018.png?featherlight=false&width=90pc)
20. Click **iDevelop - Trip Search API**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-019.png?featherlight=false&width=90pc)
21. Chọn **GET** trong **/tripsfromcity/{city}**
* Click **Method Request**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-020.png?featherlight=false&width=90pc)
22. Tại mục **API Key Required**, click biểu tượng bút chì
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-021.png?featherlight=false&width=90pc)
23. Chọn **True**
* Click dấu tích màu nâu để xác nhận
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-022.png?featherlight=false&width=90pc)
24. Click **Actions**
* Click **Deploy API**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-023.png?featherlight=false&width=90pc)
25. Trong hộp thoại hiện lên:
* Tại mục **Deployment stage**, chọn **prod**
* Click **Deploy**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-024.png?featherlight=false&width=90pc)
26. Trong mục **prod Stage Editor** xuất hiện, click **SDK Generation**
* Tại mục **Platform**, chọn **Java SDK**
* Tại mục **Service name**, nhập ```TripSearch```
* Tại mục **Java package name**, nhập ```idevelop.api.sdk```
* Click **Generate SDK**. Java SDK sẽ được tạo và tải xuống dưới dạng tệp ZIP.
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-025.png?featherlight=false&width=90pc)
27. Giải nén tệp ZIP đã tải xuống trong bước 26
* Mở **Command Prompt** và chuyển đường dẫn đến mã nguồn vừa giải nén (thư mục được gọi là **generated-code**)
* Chạy lệnh dưới đây
```
mvn install
```
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-026.png?featherlight=false&width=60pc)

Việc này sẽ biên dịch và cài đặt SDK trong kho lưu trữ Maven cục bộ của bạn và ghi đè lên phiên bản trước. 

#### Kiểm thử SDK vừa tạo mới với Ứng dụng Client Java
28. Trong **Command Prompt**, chuyển đường dẫn đến mã nguồn giải nén trong bước 10
* Chạy câu lệnh dưới đây để chạy ứng dụng
```
java -jar target/TripSearch-sdkClient-1.0-SNAPSHOT.jar
```
* Vì chúng ta đã cài đặt **/tripsfromcity/{GET} endpoint** yêu cầu **API Key**, nhưng chúng ta chưa cài đặt **API** trong **client application**. Bạn sẽ thấy lỗi **Forbidden**.
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-027.png?featherlight=false&width=60pc)

#### Thiết lập API key trong mã nguồn Client và chạy lại Ứng dụng sử dụng API với tính năng throttling

29. Click **API Keys**
* Click **SDKClient**
* Tại mục **API Key**, click **show** để hiện ra **auto-generated API key**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-028.png?featherlight=false&width=90pc)
30. Lưu lại **API key** tại mục **API key**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-029.png?featherlight=false&width=90pc)
31. Trong Eclipse IDE, mở file có đường dẫn **/src/main/java/idevelop/api/tripsearch/sdk/app/App.java**
* Thay **\<REPLACE_WITH_API_KEY\>** bằng **API key** đã lưu trong bước 30
* Bỏ comment tại dòng **apiKey(API_KEY)**. Bây giờ bạn đã có **API Key** trong lệnh gọi **API Gateway**, **SDK** được tạo cho bạn sẽ chứa lệnh gọi cho phép thiết lập khóa. Nếu bạn không có **API Key**, trình tạo mã không sử dụng hàm này, do vậy trong mã nguồn được cung cấp nó bị comment lại. Bạn cần bỏ comment trong mã nguồn được cung cấp để cho phép **API Key** được đặt chính xác.
* Lưu lại file
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-030.png?featherlight=false&width=90pc)
32. Trong Eclipse IDE, nhấp chuột phải vào project **TripSearch-sdkClient**
* Click **Maven**
* Click **Update Project...**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-031.png?featherlight=false&width=90pc)
33. Trong **Command Prompt**, chạy lệnh dưới đây
```
mvn package
```
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-032.png?featherlight=false&width=60pc)
34. Trong **Command Prompt**, chạy lệnh dưới đây
```
java -jar target/TripSearch-sdkClient-1.0-SNAPSHOT.jar
```
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-033.png?featherlight=false&width=60pc)
35. Bạn sẽ thấy kết quả
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-034.png?featherlight=false&width=60pc)
36. Hãy thử thay đổi **API_KEY** chúng ta đã đặt vào **App class** trong bước 31. Chúng ta có thể thêm dấu **.** vào cuối của chuỗi **API_KEY**
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-035.png?featherlight=false&width=90pc)
37. Trong **Command Prompt**, chạy lệnh dưới đây
```
java -jar target/TripSearch-sdkClient-1.0-SNAPSHOT.jar
```
* Chúng ta sẽ thấy kết quả
![Build A Client To Consume The API](/images/3-create-single-page-app/3.6-build-api-consumer/build-api-consumer-036.png?featherlight=false&width=60pc)
38. Hãy thử nghiệm với **Rate** và **Burst** trong **Usage Plan** để xem chúng có ảnh hưởng như thế nào đến ứng dụng khách gọi API.
{{% notice note %}} 
Bạn không cần triển khai lại API cũng như không tạo lại SDK nếu bạn thay đổi cài đặt trong **Usage Plan**.
{{% /notice %}}