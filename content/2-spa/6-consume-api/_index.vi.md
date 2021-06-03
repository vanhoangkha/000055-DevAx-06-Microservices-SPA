+++
title = "Sử dụng API"
date = 2021
weight = 6
chapter = false
pre = "<b>2.6. </b>"
+++

**Tạo một Client để sử dụng API**

Bây giờ bạn có một mô hình hoạt động của trang web đang chạy như một SPA gọi dữ liệu thông qua RESTful API được lưu trữ trên AWS Lambda và cung cấp từ Amazon API Gateway. Các nguồn cấp dữ liệu này được coi là công khai vì người dùng không cần đăng nhập và cung cấp thông tin đăng nhập cho lệnh gọi tới API. Trong bài tập này, bạn sẽ xem xét cách bạn có thể yêu cầu xác thực để thực hiện lệnh gọi API và việc sử dụng Khóa API để thực thi điều chỉnh tốc độ cuộc gọi và quản lý hạn ngạch. Để chứng minh, bạn sẽ sử dụng một ứng dụng Java client, để chỉ ra cách bạn có thể sử dụng các Java SDK được tạo tự động trong các ứng dụng của bạn.

**Nội dung**
- [Tạo Response Model cho TripSearch API](#tạo-response-model-cho-tripsearch-api)
- [Gán TripsFromCityResponse model cho API **/tripsfromcity**](#gán-tripsfromcityresponse-model-cho-api-tripsfromcity)
- [Tạo một ứng dụng client Java sử dụng API](#tạo-một-ứng-dụng-client-java-sử-dụng-api)
- [Tái tạo client SDK và cài đặt trên máy development](#tái-tạo-client-sdk-và-cài-đặt-trên-máy-development)
- [Kiểm thử SDK vừa tạo mới với Ứng dụng Client Java](#kiểm-thử-sdk-vừa-tạo-mới-với-ứng-dụng-client-java)
- [Thiết lập API key trong mã nguồn Client và chạy lại Ứng dụng sử dụng API với tính năng throttling](#thiết-lập-api-key-trong-mã-nguồn-client-và-chạy-lại-ứng-dụng-sử-dụng-api-với-tính-năng-throttling)

#### Tạo Response Model cho TripSearch API

In order for the SDK generator to create the appropriate classes for a strongly-typed language like Java (as opposed to Javascript, for example) we need to tell API Gateway what the shape or schema of the request/response objects looks like. In the **TripSearch API**, we are using the **GET** method for each of the three API calls. Therefore, there is no schema for inbound requests because the **city** parameter is passed on as part of the URL. If we instead changed the method to **POST**, we would need to pass in the city parameter in the **body** payload, and would need to create a model for this object schema for the code generator to create a Java class for us to bind to.

Để trình tạo SDK có thể tạo các lớp thích hợp cho một ngôn ngữ mạnh như Java (đối lập với Javascript), chúng ta cần cho API Gateway biết hình dạng hoặc schema của các đối tượng yêu cầu/phản hồi trông như thế nào. Trong **TripSearch API**, bạn đang sử dụng phương thức **GET** cho mỗi lệnh gọi API. Do đó, không có schema nào cho các yêu cầu gửi đến vì tham số **city** được truyền như một phần của URL. Thay vào đó, nếu bạn thay đổi phương thức thành **POST**, bạn sẽ cần truyền tham số thành phố trong tải trọng **body** và sẽ cần tạo một mô hình cho schema đối tượng này cho trình tạo mã để tạo một lớp Java để bạn sử dụng.

The result data from the API calls is returned in the **body** of the response. In order for the code generator to create an appropriate class to represent this response, we need to create a response model, and set it as the method response model.
Dữ liệu kết quả từ các lệnh gọi API được trả về trong **body** của phản hồi. Để trình tạo mã có thể tạo một lớp thích hợp để đại diện cho phản hồi này, chúng ta cần tạo một mô hình phản hồi và đặt nó làm mô hình phản hồi phương thức.

1. Truy cập **API Gateway console** và chọn **Models** là ```iDevelop - Trip Search API```.
2. Chọn **Create**
3. Ở **Model name** nhập ```TripsFromCityResponse```
4. Ở **Content-type** nhập ```application/json```
5. Ở **Model schema** nhập vào mô tả bên dưới:

```json
{
  "type" : "object",
  "properties" : {
    "succeeded" : {
      "type" : "boolean"
    },
    "errorMessage" : {
      "type" : "string"
    },
    "errorType" : {
      "type" : "number"
    },
    "data" : {
      "type" : "array",
      "items" : {
        "type" : "object",
        "properties" : {

			"date": {
				"type" : "number"
			},
       		"originCity": {
				"type" : "string"
			},
			"destinationCity": {
				"type" : "string"
			},
			"airline": {
				"type" : "string"
			}
          }
        }
      }
  },
  "title" : "TripsFromCityResponse"
}
```

6. Chọn **Create model**

#### Gán TripsFromCityResponse model cho API **/tripsfromcity**

7. Chọn **Resources** là ```iDevelop - Trip Search API```.
8. Chọn method **GET** ở ```/tripsfromcity/{city}```
9. Chọn **Method Response**
10. Trong bảng **/tripsfromcity/{city} - GET - Method Response** chọn icon tam giác cạnh **HTTP Status** để xem panelpanel.
11. Ở mục **Response Body for 200** chọn **biểu tượng bút chì** kế bên **Empty model**.
12. Trường sẽ trở thành một danh sách thả xuống. Lựa chọn **TripsFromCityResponse** và nhấp vào **dấu tích màu xám** để **cam kết** thay đổi.
13. Từ menu **Actions**, chọn ```Deploy API```
14. Ở **Deployment stage** chọn ```prod``` from the list and click **Deploy**
15. Trong mục **prod Stage Editor** xuất hiện, chọn **SDK Generation** 
16. Trong mục **Platform** chọn **Java SDK**
17. Ở **Service name** nhập ```TripSearch```
18. Ở **Java package name** nhập ```idevelop.api.sdk```

![API](/images/2/35.png?width=90pc)

19. Chọn **Generate SDK**. Java SDK sẽ được tạo và tải xuống dưới dạng tệp ZIP.
20. **Giải nén** tệp ZIP đã tải xuống trên môi trường làm việc của bạn
21. Trong cửa số lệnh, ```cd``` vào vị trí giải nén mã nguồn và chạy lệnh sau:

```bash
mvn install

# if you are using Eclipse IDE on Windows
%M2_HOME%\bin\mvn install
```

Việc này sẽ **biên dịch** và **cài đặt** SDK trong kho lưu trữ Maven cục bộ của bạn và chúng tôi sẽ đề cập đến nó trong các bước tiếp theo.

#### Tạo một ứng dụng client Java sử dụng API

22. Tải xuống gói mã nguồn cho một ứng dụng thử nghiệm từ [TripSearchJavaClient.zip](https://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchJavaClient.zip) và giải nén trong môi trường làm việc của bạn.\
 Nếu bạn đang sử dụng **Cloud9**, hãy tham khảo lệnh bên dưới:
```bash
cd ~/environment
curl -L https://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchJavaClient.zip --output TripSearchJavaClient.zip
unzip TripSearchJavaClient.zip
```

{{%attachments title="TripSearchJavaClient ource code bundle" pattern=".*(zip)"/%}}

23. If you’re using Eclipse IDE, use the **Open projects from filesystem location** menu and browse to the filesystem location where you exploded the **TripSearchJavaClient** source code. Open the project.\
  If you’re using **Cloud9**, refer to the command below.
```bash
cd ~/environment/TripSearchJavaClient
mvn install

# if you are using Eclipse IDE on Windows
%M2_HOME%\bin\mvn install
```

24. Run the project. It will use the **TripSearch API** to call ```/tripsfromcity``` and search for trips with destination ```Melbourne```. You will see an output like this:

```bash
Got 2 items in 91ms
Got 2 items in 91ms
Got 2 items in 90ms
.
.
.
Got 2 items in 90ms
```

The example API consumer will time how long each call to the API takes, and display the results. It will make a maximum of 100 calls as quickly as it can.

If we had many of these clients consuming the API rapidly, we could overwhelm the provisioned infrastructure, so we need some way of throttling calls. We can use **Usage Plans** to do this.

25. On the **API Gateway console**, click **Usage Plans** beneath the **APIs** navigator panel.
26. Click **Create** to create a new **Usage Plan**
27. For **Name** type ```LabPlan```
28. Under **Throttling**, for **Rate** type ```1```
29. For **Burst** type ```1```
30. Under **Quota** type ```1000``` per month

![API](/images/2/36.png?width=90pc)

31. Click **Next**
32. Click **Add API Stage**
33. In the **API** drop-down list, select ```iDevelop - Trip Search API```
34. In the **Stage** drop-down list, select **prod**
35. Click the **grey tick** icon to commit the changes
36. Click **Next**
37. Click **Create API Key and add to Usage Plan**
38. In the dialog that appears, for **Name** type ```SDKClient```
39. Click **Save**
40. Click **Done**. A new API key will be created and associated with the usage Plan.
41. Click the **iDevelop - Trip Search API** link beneath **APIs** on the left of the **API Gateway console**.
42. Click the **GET** method beneath ```/tripsfromcity/{city}```
43. Click **Method Request**
44. Under **Settings**, for **API Key Required**, click the **pencil edit** icon, and choose ```true``` from the list.

![API](/images/2/37.png?width=90pc)

45. Click the **grey tick** icon to **commit** the change
46. From the **Actions** menu, select **Deploy API**
47. Choose the **prod** stage and click **Deploy** to deploy the changes

#### Tái tạo client SDK và cài đặt trên máy development

48. In the **prod Stage Editor**, click the **SDK Generation** tab
49. For **Platform**, choose **Java SDK**
50. For **Service name** type ```TripSearch```
51. For **Java package name** type ```idevelop.api.sdk```

![API](/images/2/38.png?width=90pc)

52. Click **Generate SDK**. The Java SDK will be generated and downloaded as a ZIP file.
53. **Explode** the downloaded ZIP file on your filesystem.
54. In a terminal window, ```cd``` into the folder where the downloaded SDK has been exploded (typically, the directory is called generated-code) and issue the following command:

```bash
mvn install
```

This will **compile** and **install** the SDK in your local Maven repository, overwriting the previous version. In the following steps, you will use this SDK artefact by referencing it in a client application POM file.

#### Kiểm thử SDK vừa tạo mới với Ứng dụng Client Java

In the IDE, re-run the application without making any changes. Since you have set the ```/tripsfromcity/{GET}``` endpoint to require an **API Key**, but have not actually set an API in the client application, you will see a **Forbidden error** in the console.

#### Thiết lập API key trong mã nguồn Client và chạy lại Ứng dụng sử dụng API với tính năng throttling

55. The provided client source code needs to be updated to set the **API Key** in order to successfully call the ```/tripsfromcity/{GET}``` method.
56. On the **AWS API Gateway Console**, click the **API Keys** tab
57. Click the **SDKClient** link
58. Click the **Show** link next to **API Key** to reveal the **auto-generated API key**. **Copy** the value into your clipboard.
59. In the **IDE**, in the ```/src/main/java/idevelop/api/tripsearch/sdk/app/App.java``` file, **paste** in the API Key in your clipboard, in the ```API_KEY``` definition, replacing the ```<REPLACE_WITH_API_KEY>``` placeholder.
60. In the same file, locate the **commented out** call to ```apiKey(API_KEY)``` in the **TripSearch builder** call. You may have to run a ```Maven Update``` on the project to pick up the ```.apiKey``` as we updated the jar in the last step and Eclipse may not have picked it up. Now that you have **required an API Key** in the API Gateway call, the SDK created for you will contain a call to allow the key to be set. If you have no API Key requirements, the code generator does not emit this functionality so in the provided code, it is commented out. You need to enable the call in the client code to allow the API Key to be set correctly.
61. Re-run the application in the IDE. Notice that the calls will now succeed, but, you will now periodically start receiving errors requesting you slow down the call-rate. This is because we set a **maximum call-rate** of **1 call per second per API key**. You will see output like this:

```bash
Got 2 items in 97ms
Got 2 items in 125ms
Too Many Requests - waiting 1 second...
.
.
.
```

62. As an experiment, edit the ```API_KEY``` you have set in the **App class** (for example, add a period at the end) which will cause it to be invalid. Re-run the app and notice that you now receive a **Forbidden** message. This is because you set the API Key as required for calls to the ```/tripsfromcity``` call.
63. Experiment with the **Rate and Burst** settings in the **Usage Plan** to see how they affect the client app calling the API. 

{{% notice note %}}
Note that you **do not need** to re-deploy the API nor re-create the SDK if you change the settings in the **Usage Plan**.
{{% /notice %}}
