+++
title = "Serverless Microservices"
date = 2021
weight = 2
chapter = false
pre = "<b>2.2. </b>"
+++

**Xây dựng và Triển khai Serverless Microservice thủ công**

In this exercise, you will manually create and configure a serverless microservice. As you progress through this lab, you will use other techniques for build and deployment, so that you can compare and contrast the efficiencies of each approach and how automation makes the development experience more agile and increases developer efficiency.

Trong bài tập này, bạn sẽ tự tạo và cấu hình một serverless microservice. Trong quá trình làm bài thực hành, bạn sẽ sử dụng các kỹ thuật khác nhau để xây dựng và triển khai, khi đó bạn có thể so sánh và đối chiếu hiệu quả của từng cách tiếp cận và phương pháp tự động hóa làm cho việc phát triển ứng dụng trở nên nhanh hơn và hiệu quả hơn cho các developer.

Bạn sẽ tạo thủ công TripSearch microservice. TripSearch microservice cung cấp các hàm sau:

> - **/trips** - trả về danh sách tất cả các chuyến đi có sẵn trong hệ thống.
> - **/tripsfromcity** - trả về danh sách tất cả các chuyến đi xuất phát từ một thành phố nhất định.
> - **/tripstocity** - trả về danh sách tất cả các chuyến đi có điểm đến là một thành phố nhất định

Đây là cùng một microservice mà chúng ta đã xem xét trong bài thực hành trước đây. Nhưng lần này, chúng ta sẽ cung cấp chức năng này trong trang web TravelBuddy của chúng ta và do đó, cần triển khai dịch vụ để chuẩn bị cho trang web. Trước đây, việc cấu hình API Gateway được quản lý bởi pipeline triển khai cho bạn - trong bài tập này, bạn sẽ cấu hình thủ công thiết cho cả hàm Lambda và API Gateway.

**Nội dung**
- [Tải mã nguồn và xây dựng thành phần cho triển khai](#tải-mã-nguồn-và-xây-dựng-thành-phần-cho-triển-khai)
- [Tại sao bạn lại thấy thông báo **AWS X-ray unavailable - ignoring**?](#tại-sao-bạn-lại-thấy-thông-báo-aws-x-ray-unavailable---ignoring)
- [Tạo hai hàm Lambda mới sử dụng chung cá thành phần triển khai](#tạo-hai-hàm-lambda-mới-sử-dụng-chung-cá-thành-phần-triển-khai)

#### Tải mã nguồn và xây dựng thành phần cho triển khai

1. Bài thực hành này đã tạo sẵn một **S3 bucket** để bạn lưu trữ **thành phần triển khai** cho hàm Lambda cho **TripSearch microservice**. Trước tiên, bạn cần kiểm thử và xây dựng gói triển khai.\
Tải về mã nguồn tại [TripSearchFull.zip](https://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchFull.zip) và giải nén tập tin zip trong hệ thống của bạn. Bạn có thể thực hiện trên hệ điều hành Windows hay Cloud9. Lệnh sau sẽ thực hiện tải về gói mã nguồn:

```bash
curl -L http://workshops.devax.academy/monoliths-to-microservices/module6/files/TripSearchFull.zip --output TripSearchFull.zip
```

Hoặc tải về bên dưới:

{{%attachments title="Source code bundle" pattern=".*(zip)"/%}}

2. ```cd``` vào vị trí đặt thư mục giải nén mã nguồn **TripSearchFull**và chạy unit test bằng lệnh sau: 

**Với MacOS/Linux:**
```bash
export DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors; mvn test
```

**Với Windows:**
```bash
set DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors
mvn test
```

**Với Cloud9 - Nếu bạn chưa thiết lập:**
```bash
set DDB_TAB
sudo yum install -y java-1.8.0-openjdk-devel
sudo alternatives --config java #enter 1.8 version #enter 2
sudo alternatives --config javac #enter 1.8 version #enter 2
sudo yum remove -y java-1.7.0-openjdk-devel
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
```

**Chạy kiểm thử trên Cloud9:**

```bash
export DDB_TABLENAME_TRIPSECTOR=TravelBuddyTripSectors; mvn test
```

{{% notice tip %}}
Nếu việc kiểm thử ra kết quả **fail**, hãy thử thiết lập lại profile aws mặc định cho hệ thống của bạn.
**Trên Windows:** ```set AWS_PROFILE=devaxacademy``` 
**Trên MacOS/Linux:** ```export AWS_PROFILE=devaxacademy```
{{% /notice %}}

{{% notice tip %}}
Nếu việc kiểm thử vẫn ra kết quả **fail**, có thể là do môi trường bài thực hành chưa được triển khai xong. Hãy kiểm tra và chắc chắn template đã được triển khai hoàn thành.
{{% /notice %}}

{{% notice tip %}}
Nếu việc kiểm thử tiếp tục ra kết quả **fail** và thông báo lỗi đầu tiên là **"Unable to load AWS credentials from any provider in the chain"**. Hãy kiểm tra và chắc chắn bạn đã thiết lập **thông tin đăng nhập cho AWS CLI**.
{{% /notice %}}

Lệnh này đặt tên table cho DynamoDB table khớp với tên của bảng do thiết lập của bài thực hành đặt. Bạn sẽ thấy kết quả như sau:
```bash
2021-03-30 18:03:55 <> WARN  BasicProfileConfigLoader:96 - The legacy profile format requires the 'profile ' prefix before the profile name. The latest code does not require
 such prefix, and will consider it as part of the profile name. Please remove the prefix if you are seeing this warning.
EnvVar DDB_TABLENAME_TRIPSECTOR detected - overriding DDB TableName to TravelBuddyTripSectors
AWS X-ray unavailable - ignoring
Found 52 total trips.
Sun Jun 20 23:52:23 UTC 2021 > Melbourne to Geelong on Qantas
Tue Jun 15 02:12:51 UTC 2021 > Geelong to Brisbane on Qantas
Tue Aug 17 20:29:29 UTC 2021 > Melbourne to Cairo on Qantas
Sat Mar 12 23:18:51 UTC 2022 > Sydney to Singapore on Qantas
Thu May 27 02:55:51 UTC 2021 > Perth to Hobart on Qantas
.....<omitted>
Starting devlounge.lambda.FindTripsFromCityHandler Lambda with input Melbourne

AWS X-ray unavailable - ignoring
Found 8 total trips.

Sun Jun 20 23:52:23 UTC 2021 > Melbourne to Geelong on Qantas
Tue Aug 17 20:29:29 UTC 2021 > Melbourne to Cairo on Qantas
Tue Jun 08 04:55:44 UTC 2021 > Melbourne to Dallas on Qantas
Thu Dec 09 22:15:45 UTC 2021 > Melbourne to Singapore on Qantas
Tue Jun 15 06:55:59 UTC 2021 > Melbourne to Broome on Qantas
Sun Dec 19 18:06:06 UTC 2021 > Melbourne to Geelong on Qantas
Fri Apr 09 05:45:41 UTC 2021 > Melbourne to Newcastle on Qantas
Sun Apr 03 15:19:34 UTC 2022 > Melbourne to Sydney on Qantas
Starting devlounge.lambda.FindTripsToCityHandler Lambda with city Sydney

AWS X-ray unavailable - ignoring
Found 2 total trips.

Mon Feb 28 19:39:13 UTC 2022 > Perth to Sydney on Qantas
Sun Apr 03 15:19:34 UTC 2022 > Melbourne to Sydney on Qantas
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 2.111 sec

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
```

{{% notice note %}}
Nhớ rằng thành phố đi và đến thể hiện ở đây và thời gian, ngày tháng sẽ khác so với môi trường triển khai của bạn vì nó được tạo ngẫu nhiên.
{{% /notice %}}

{{% notice info %}}
Bạn sẽ thấy không có thông báo lỗi nào khi chạy unit test và điều đó chắc chắn rằng mã nguồn của bạn đã chạy được như dự kiến. Nếu vẫn thấy lỗi, hãy thử kiểm tra thêm.
{{% /notice %}}

#### Tại sao bạn lại thấy thông báo **AWS X-ray unavailable - ignoring**?

Khi bạn chạy test trong môi trường Development local, AWS X-RAy agent không khả dụng, và vì như vậy việc gọi từ AWS SDK không được ghi nhận vào X-Ray. Tuy nhiên, thiết lập trong ```pom.xml``` xác định sử dụng AWS X-Ray recorder, tất cả các lệnh gọi tới thông qua SDK (VD: gọi tới DynamoDB) sẽ được ghi nhận. Việc này sẽ gây phát sinh lỗi và test sẽ fail.

Chú ý rằng mỗi một lớp Lambda handler đều extend từ một lớp nền tên là **LambdaHandlerWithXRayBase**. Trong lớp này, có một khởi tạo static và nó xây dựng đối tượn **ContextMissingStrategy**, ghi đè hành động khi không có AWS X-Ray và thiết lập đó là hành động mặc định. Trong quá trình triển khai **contextMissing handler**, chúng ta có xuất ra một nội dung ra console, thay vì hành động mặc định là đưa ra exception. Việc triển khai lớp **LambdaHandlerWithXRayBase** tương tự như sau:

```java
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

```bash
com.amazonaws.xray.exceptions.SegmentNotFoundException: Thread failed to begin a subsegment: segment not found. Verify that a segment is in progress, and that the SegmentContextResolverChain is configured correctly in order to discover the segment.
```

Nếu không có agent, và lệnh gọi hàm Lambda trong trường hợp Id tương quan được chuyển chính xác đến nó, **SegmentContextResolverChain** không thể xác định phân vùng AWS X-ray để đính kèm metadata đã ghi vào và đưa ra exception. Việc triển khai chúng ta cung cấp trong lớp cơ sở sẽ ghi đè hành vi này, nhằm bỏ qua điều kiện này một cách an toàn trong khi thử nghiệm trên môi trường phát triển của bạn.

3. Nếu quá trình chạy unit test thành công, bạn đã sẵn sàng xây dựng thành phần triển khai. Từ dòng lệnh, hãy thực hiện như sau:

```bash
mvn package shade:shade
```

4. Kết quả triển khai (tệp JAR) sẽ được xây dựng và lưu trữ trong ```./target/tripsearch-1.0.0.jar```

Trong trường hợp cần tạo hàm AWS Lambda từ tập tin JAR. Bạn cần đẩy các build artifact vào **S3BucketLambdaCode S3 bucket** có thể được truy cập bởi môi trường  AWS Lambda trong cùng **Region** mà hàm Lambda đã được tạo. Thực thi lệnh bên dưới sau khi thay đổi một số thông số cho phù hợp:

```bash
aws s3 cp target/tripsearch-1.0.0.jar s3://<S3BucketLambdaCode> --region ap-northeast-1
```

{{% notice note %}}
Thay giá trị trong **Cloudformation Outputs** bằng giá trị của  **S3BucketLambdaCodeBucketName**. **Không** thêm ký tự \**<** và \**>**.
{{% /notice %}}

5. Tạo một hàm Lambda mới từ cấu phần triển khai này, bằng cách thực thi lệnh sau sau khi thay thế các tham số liên quan được ghi chú bên dưới:

```bash
aws lambda create-function --function-name idevelopTripSearchFull --runtime java8 --role <LambdaRole> --handler devlounge.lambda.FindAllTripsHandler --code S3Bucket=<S3BucketLambdaCode>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindAllTrips" --memory-size 1024 --region ap-northeast-1
```

{{% notice note %}}
Thay giá trị trong **Cloudformation Outputs** bằng giá trị của  **S3BucketLambdaCodeBucketName**.
Thay giá trị trong **Cloudformation Outputs** thay cho khóa **LambdaRoleARN**.
**Không** thêm ký tự \**<** và \**>**.
{{% /notice %}} 

Nếu thành công, hàm Lambda mới của bạn sẽ được tạo và bạn sẽ thấy kết quả trả về tương tự như sau:

```bash
{
    "FunctionName": "idevelopTripSearchFull",
    "FunctionArn": "arn:aws:lambda:ap-northeast-1:XXXXXXXXXXXX:function:idevelopTripSearchFull",
    "Runtime": "java8",
    "Role": "arn:aws:iam::XXXXXXXXXXXX:role/LambdaRole",
    "Handler": "devlounge.lambda.FindAllTripsHandler",
    "CodeSize": 9737054,
    "Description": "TravelBuddy TripSearch microservice - FindAllTrips",
    "Timeout": 15,
    "MemorySize": 1024,
    "LastModified": "2021-03-30T18:10:38.011+0000",
    "CodeSha256": "EGhfTqT/kThg05Ibn8ivLWcKSabLZtIh/t3brnmvyHA=",
    "Version": "$LATEST",
    "TracingConfig": {
        "Mode": "PassThrough"
    },
    "RevisionId": "4fdee380-f0ce-4e1e-ab1e-d42e74e89308",
    "State": "Active",
    "LastUpdateStatus": "Successful",
    "PackageType": "Zip"
}
```

#### Tạo hai hàm Lambda mới sử dụng chung cá thành phần triển khai

Mã triển khai chức năng TripSearch của chúng ta có ba handler được cung cấp - một để tìm tất cả các chuyến đi; một để tìm các chuyến đi bắt nguồn từ một thành phố nhất định; và một để tìm các chuyến đi có một thành phố nhất định làm điểm đến. Hiện tại, chúng ta mới chỉ tiếp xúc với một handler - tìm kiếm cho tất cả các chuyến đi. Trong phần này, chúng ta sẽ tạo hai hàm Lambda mới, mỗi hàm cung cấp một trong hai handler còn lại.

6. Tạo một hàm Lambda mới từ cùng một cấu phần triển khai mà chúng tôi đã tải lên trước đó. Chúng ta có thể tạo các hàm Lambda khác nhau từ cùng một thành phần vì tạo tác xuất ra nhiều Lambda handler. Ở bước trên, chúng tôi đã cung cấp **devlounge.lambda.FindAllTripsHandler**. Trong bước này, chúng ta sẽ cung cấp **devlounge.lambda.FindTripsFromCityHandler**. CHúng ta có thể chạy lại các lệnh phía trên nhưng thay đổi handler nên bạn có thể đặt một tên riêng cố định. 

Thực hiện câu lệnh sau khi cập nhật các thông số thay đổi từ Cloud Formation:

```bash
aws lambda create-function --function-name idevelopTripSearchFromCity --runtime java8 --role <LambdaRole> --handler devlounge.lambda.FindTripsFromCityHandler --code S3Bucket=<S3BucketLambdaCode>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsFromCity" --memory-size 1024 --region ap-northeast-1
```

Thay giá trị trong **Cloudformation Outputs** bằng giá trị của  **S3BucketLambdaCodeBucketName**. Thay giá trị trong **Cloudformation Outputs** thay cho khóa **LambdaRoleARN**.

Chắc chắn rằng bạn sẽ được nhận các phản hồi thành công tương tự với việc bạn đã tạo hàm Lambda đầu tiên:

7. Tạo hàm Lambda cuối cùng với cùng thành phần triển khai, lần này là cho **FindTripsToCity**. Cũng như các bước trên, lần này chúng ta sẽ cung cấp **devlounge.lambda.FindTripsToCityHandler**.

Thực hiện câu lệnh sau khi cập nhật các thông số thay đổi từ Cloud Formation:

```bash
aws lambda create-function --function-name idevelopFindTripsToCity --runtime java8 --role <LambdaRole> --handler devlounge.lambda.FindTripsToCityHandler --code S3Bucket=<S3BucketLambdaCode>,S3Key=tripsearch-1.0.0.jar --timeout 15 --description "TravelBuddy TripSearch microservice - FindTripsToCity" --memory-size 1024 --region ap-northeast-1
```

Thay giá trị trong **Cloudformation Outputs** bằng giá trị của  **S3BucketLambdaCodeBucketName**. Thay giá trị trong **Cloudformation Outputs** thay cho khóa **LambdaRoleARN**.

Chắc chắn rằng bạn sẽ được nhận các phản hồi thành công tương tự với việc bạn đã tạo hàm Lambda.