+++
title = "Xây dựng và triển khai Serverless Microservice thủ công"
date = 2020
weight = 2
chapter = false
pre = "<b>3.2. </b>"
+++
#### Xây dựng và triển khai Serverless Microservice thủ công

Trong bài tập này, bạn sẽ tự tạo và cấu hình một serverless microservice. Trong quá trình làm bài thực hành, bạn sẽ sử dụng các kỹ thuật khác nhau để xây dựng và triển khai, khi đó bạn có thể so sánh và đối chiếu hiệu quả của từng cách tiếp cận và phương pháp tự động hóa làm cho việc phát triển ứng dụng trở nên nhanh hơn và hiệu quả hơn cho các developer.


Bạn sẽ tạo thủ công TripSearch microservice. TripSearch microservice cung cấp các hàm sau:
* **/trips** - trả về danh sách tất cả các chuyến đi có sẵn trong hệ thống.
* **/tripsfromcity** - trả về danh sách tất cả các chuyến đi xuất phát từ một thành phố nhất định.
* **/tripstocity** - trả về danh sách tất cả các chuyến đi có điểm đến là một thành phố nhất định

Đây là cùng một microservice mà chúng ta đã xem xét trong bài thực hành trước đây. Nhưng lần này, chúng ta sẽ cung cấp chức năng này trong trang web TravelBuddy của chúng ta và do đó, cần triển khai dịch vụ để chuẩn bị cho trang web. Trước đây, việc cấu hình API Gateway được quản lý bởi pipeline triển khai cho bạn - trong bài tập này, bạn sẽ cấu hình thủ công thiết cho cả hàm Lambda và API Gateway.
#### Tải mã nguồn và xây dựng thành phần cho triển khai
{{%attachments title="TripSearchFull Project" style="orange" pattern="TripSearchFull.zip"/%}}
1. Bạn hãy tải tập tin **TripSearchFull.zip** và giải nén
2. Mở **Command Prompt** và chuyển đường dẫn đến project **TripSearchFull** đã giải nén ở bước 1
* Chạy lệnh dưới đây:
```
set AWS_PROFILE=devaxacademy
set DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors
mvn test
```
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-001.png?featherlight=false&width=60pc)
3. Bạn sẽ thấy kết quả:
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-002.png?featherlight=false&width=60pc)
{{% notice note %}} 
Nhớ rằng thành phố đi và đến thể hiện ở đây và thời gian, ngày tháng sẽ khác so với môi trường triển khai của bạn vì nó được tạo ngẫu nhiên.\
Bạn sẽ thấy không có thông báo lỗi nào khi chạy unit test và điều đó chắc chắn rằng mã nguồn của bạn đã chạy được như dự kiến. Nếu vẫn thấy lỗi, hãy thử kiểm tra thêm.
{{% /notice %}}
#### Tại sao bạn lại thấy thông báo **AWS X-ray unavailable - ignoring**?
Khi bạn chạy test trong môi trường Development local, AWS X-RAy agent không khả dụng, và vì như vậy việc gọi từ AWS SDK không được ghi nhận vào X-Ray. Tuy nhiên, thiết lập trong **pom.xml** xác định sử dụng AWS X-Ray recorder, tất cả các lệnh gọi tới thông qua SDK (VD: gọi tới DynamoDB) sẽ được ghi nhận. Việc này sẽ gây phát sinh lỗi và test sẽ fail.

Chú ý rằng mỗi một lớp Lambda handler đều extend từ một lớp nền tên là **LambdaHandlerWithXRayBase**. Trong lớp này, có một khởi tạo static và nó xây dựng đối tượng **ContextMissingStrategy**, ghi đè hành động khi không có AWS X-Ray và thiết lập đó là hành động mặc định. Trong quá trình triển khai **contextMissing handler**, chúng ta có xuất ra một nội dung ra console, thay vì hành động mặc định là đưa ra exception. Việc triển khai lớp **LambdaHandlerWithXRayBase** tương tự như sau:
```
public class LambdaHandlerWithXRayBase 
{
	static  
	{
	  AWSXRayRecorderBuilder builder = AWSXRayRecorderBuilder.standard();

	  builder.withContextMissingStrategy(new ContextMissingStrategy() 
	  {		
		@Override
		public void contextMissing(String arg0, Class<? extends RuntimeException> arg1) 
		{ 
			System.out.println("AWS X-ray unavailable - ignoring"); 
		}	  
	  });

	  AWSXRay.setGlobalRecorder(builder.build());
	}
}
```
Là một thử nghiệm tùy chọn, bạn có thể thử xóa trình khởi tạo static khỏi lớp cơ sở **LambdaHandlerWithXRayBase** và chạy lại **Maven build**. Bạn sẽ thấy các lỗi như:
```
com.amazonaws.xray.exceptions.SegmentNotFoundException: Thread failed to begin a subsegment: segment not found. Verify that a segment is in progress, and that the SegmentContextResolverChain is configured correctly in order to discover the segment.
```
Nếu không có agent, và lệnh gọi hàm Lambda trong trường hợp Id tương quan được chuyển chính xác đến nó, **SegmentContextResolverChain** không thể xác định phân vùng AWS X-ray để đính kèm metadata đã ghi vào và đưa ra exception. Việc triển khai chúng ta cung cấp trong lớp cơ sở sẽ ghi đè hành vi này, nhằm bỏ qua điều kiện này một cách an toàn trong khi thử nghiệm trên môi trường phát triển của bạn.

4. Nếu quá trình chạy unit test thành công, chạy câu lệnh ```mvn package shade:shade``` để build
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-003.png?featherlight=false&width=60pc)
5. Sẽ mất một chút thời gian để build mã nguồn ứng dụng. Sau khi tập tin JAR đã được build sẽ nằm trong thư mục **target** của project và có tên là **tripsearch-1.0.0.jar**
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-004.png?featherlight=false&width=60pc)
6. Truy cập [**Amazon CloudFormation Console**](https://console.aws.amazon.com/cloudformation/home).
* Click **Stacks**
* Nhập ```DevAx-06``` vào ô tìm kiếm và nhấn **Enter**
* Click **DevAx-06**
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-010.png?featherlight=false&width=90pc)
7. Click tab **Outputs**
* Lưu giá trị **LambdaRoleARN** và **S3BucketLambdaCodeBucketName** để dùng trong bước tiếp theo
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-011.png?featherlight=false&width=90pc)
8. Trong **Command Prompt**, chạy lệnh dưới đây
```
aws s3 cp target/tripsearch-1.0.0.jar s3://<S3BucketLambdaCodeBucketName> --region <YOUR_REGION>
```
{{% notice note %}} 
Thay **\<S3BucketLambdaCodeBucketName\>** bằng giá trị **S3BucketLambdaCodeBucketName** chúng ta đã lưu trong bước 7\
Thay **<YOUR_REGION>** bằng **Region** của bạn
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-005.png?featherlight=false&width=60pc)
9. Chạy lệnh dưới đây để tạo một hàm Lambda mới từ cấu phần triển khai này
```
aws lambda create-function --function-name idevelopTripSearchFull --runtime java8 --role <LambdaRoleARN> --handler devlounge.lambda.FindAllTripsHandler --code S3Bucket=<S3BucketLambdaCodeBucketName>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindAllTrips" --memory-size 1024 --region <YOUR_REGION>
```
{{% notice note %}} 
Thay **\<LambdaRoleARN\>** bằng giá trị **LambdaRoleARN** chúng ta đã lưu trong bước 7\
Thay **\<S3BucketLambdaCodeBucketName\>** bằng giá trị **S3BucketLambdaCodeBucketName** chúng ta đã lưu trong bước 7\
Thay **<YOUR_REGION>** bằng **Region** của bạn
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-006.png?featherlight=false&width=60pc)
10. Nếu thành công, hàm Lambda mới của bạn sẽ được tạo và bạn sẽ thấy kết quả trả về tương tự như sau:
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-007.png?featherlight=false&width=60pc)
#### Tạo hai hàm Lambda mới sử dụng chung các thành phần triển khai

Mã triển khai chức năng TripSearch của chúng ta có ba handler được cung cấp - một để tìm tất cả các chuyến đi; một để tìm các chuyến đi bắt nguồn từ một thành phố nhất định; và một để tìm các chuyến đi có một thành phố nhất định làm điểm đến. Hiện tại, chúng ta mới chỉ tiếp xúc với một handler - tìm kiếm cho tất cả các chuyến đi. Trong phần này, chúng ta sẽ tạo hai hàm Lambda mới, mỗi hàm cung cấp một trong hai handler còn lại.

11. Tạo một hàm Lambda mới từ cùng một cấu phần triển khai mà chúng ta đã tải lên trước đó. Chúng ta có thể tạo các hàm Lambda khác nhau từ cùng một thành phần vì tạo tác xuất ra nhiều Lambda handler. Ở bước trên, chúng ta đã cung cấp **devlounge.lambda.FindAllTripsHandler**. Trong bước này, chúng ta sẽ cung cấp **devlounge.lambda.FindTripsFromCityHandler**. Chạy câu lệnh dưới đây:
```
aws lambda create-function --function-name idevelopTripSearchFromCity --runtime java8 --role <LambdaRoleARN> --handler devlounge.lambda.FindTripsFromCityHandler --code S3Bucket=<S3BucketLambdaCodeBucketName>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsFromCity" --memory-size 1024 --region <YOUR_REGION>
```
{{% notice note %}} 
Thay **\<LambdaRoleARN\>** bằng giá trị **LambdaRoleARN** chúng ta đã lưu trong bước 7\
Thay **\<S3BucketLambdaCodeBucketName\>** bằng giá trị **S3BucketLambdaCodeBucketName** chúng ta đã lưu trong bước 7\
Thay **<YOUR_REGION>** bằng **Region** của bạn
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-008.png?featherlight=false&width=60pc)
12. Tạo hàm Lambda cuối cùng với cùng thành phần triển khai, lần này là cho **FindTripsToCity**. Cũng như các bước trên, lần này chúng ta sẽ cung cấp **devlounge.lambda.FindTripsToCityHandler**.Chạy câu lệnh dưới đây:
```
aws lambda create-function --function-name idevelopFindTripsToCity --runtime java8 --role <LambdaRoleARN> --handler devlounge.lambda.FindTripsToCityHandler --code S3Bucket=<S3BucketLambdaCodeBucketName>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsToCity" --memory-size 1024 --region <YOUR_REGION>
```
{{% notice note %}} 
Thay **\<LambdaRoleARN\>** bằng giá trị **LambdaRoleARN** chúng ta đã lưu trong bước 7\
Thay **\<S3BucketLambdaCodeBucketName\>** bằng giá trị **S3BucketLambdaCodeBucketName** chúng ta đã lưu trong bước 7\
Thay **<YOUR_REGION>** bằng **Region** của bạn
{{% /notice %}}
![Manually Build And Deploy A Serverless Microservice](/images/3-create-single-page-app/3.2-build-and-deploy-serverless-microservice/build-and-deploy-serverless-microservice-009.png?featherlight=false&width=60pc)
{{% notice note %}} 
Chắc chắn rằng bạn sẽ được nhận các phản hồi thành công tương tự với hàm Lambda đã tạo đầu tiên.
{{% /notice %}}