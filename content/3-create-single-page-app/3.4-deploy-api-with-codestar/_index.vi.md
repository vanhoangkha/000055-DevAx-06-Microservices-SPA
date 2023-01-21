+++
title = "Triển khai API với Codestar và CI/CD"
date = 2020
weight = 4
chapter = false
pre = "<b>3.4. </b>"
+++
#### Tạo một CI/CD pipeline với AWS CodeStar

1. Truy cập [**AWS CodeStar Console**](https://console.aws.amazon.com/codesuite/codestar/home).
* Click **Projects**
* Click **Create project**
{{% notice note %}} 
Click **Create service role** nếu đây là lần đầu bạn truy cập vào dịch vụ **AWS CodeStar**.
{{% /notice %}}
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-001.png?featherlight=false&width=90pc)
2. Trong phần **Templates**, chọn **Java** và **AWS Lambda**
* Chọn **Java Spring**
* Click **Next**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-002.png?featherlight=false&width=90pc)
3. Tại mục **Project name**, nhập ```FlightSpecialsAPI```
* Click **Next**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-003.png?featherlight=false&width=90pc)
4. Tại trang **Review**, click **Create project**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-004.png?featherlight=false&width=90pc)
5. Thêm tài khoản **awsstudent** vào Team với vai trò **Owner**.
* Click **Team**
* Click **Add team member**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-005.png?featherlight=false&width=90pc)
6. Trong phần **Team member details**
* Tại mục **User**, chọn **awsstudent**
* Tại mục **Email address**, điền email của bạn
* Tại mục **Project role**, chọn **Owner**
* CLick **Allow SSH access to project instances.**
* Click **Add team member**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-006.png?featherlight=false&width=90pc)
7. Kiểm tra team member được add vào thành công
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-007.png?featherlight=false&width=90pc)
8. Truy cập [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).
* Click **Stack**.
* Nhập ```DevAx-06``` vào ô tìm kiếm và nhấn **Enter**.
* Click **DevAx-06**.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-008.png?featherlight=false&width=90pc)
9. Click tab **Output**
* Lưu lại giá trị **GitPassword** và **GitUserName** để sử dụng trong bước tiếp theo.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-009.png?featherlight=false&width=90pc)
10. Mở **Eclipse IDE**.
* Click dấu mũi tên xuống cạnh biểu tượng **AWS**
* Click **Import AWS CodeStar Project…**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-010.png?featherlight=false&width=90pc)
11. Chọn region chúng ta đang sử dụng
* Chọn ```FlightSpecialsAPI```
* Điền thông tin đã lưu trong bước 9 vào phần **User name** và **Password**
* Click **Next**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-011.png?featherlight=false&width=90pc)
12. Click **OK**, bỏ qua lỗi **org.eclipse.egit.ui.internal.repository.tree.RepositoryTreeNodeType.getIcon()Lorg/eclipse/swt/graphics/Image;**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-012.png?featherlight=false&width=90pc)
13. Chọn **master** branch và click **Next**.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-013.png?featherlight=false&width=90pc)
14. Click **Finish**. 
* Click **No** để bỏ qua thiết lập password hint.
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-014.png?featherlight=false&width=90pc)
15. Project sample tạo bởi CodeStar đã được import hoàn chỉnh
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-015.png?featherlight=false&width=90pc)
16. Mở **Command Prompt**, chạy câu lệnh dưới đây để chuyển đường dẫn tới project CodeStar bạn đã import và tạo nhánh mới
```
cd C:\Users\Administrator\git\FlightSpecialsAPI
git checkout -b "new-implementation"
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-016.png?featherlight=false&width=60pc)

{{%attachments title="FlightSpecials Project" style="orange" pattern="FlightSpecials.zip"/%}}

17. Tải file project **FlightSpecials.zip** về và giải nén.
18. Trong **Command Prompt**, chuyển đường dẫn tới thư mục project **FlightSpecials** đã giải nén trong bước 17
* Chạy câu lệnh dưới đây để ghi đè phần triển khai do CodeStar cung cấp bằng nội dung của tập tin **FlightSpecials.zip** đã giải nén trong bước 17. Chúng ta có script **copy_files.sh** trong tập tin **FlightSpecials.zip** mà bạn có thể dùng để ghi đè
```
copy_files.sh C:\Users\Administrator\git\FlightSpecialsAPI
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-017.png?featherlight=false&width=60pc)
19. Trong Eclipse IDE, nhấp chuột phải vào project **FlightSpecialsAPI** chúng ta đã import 
* Click **Maven**
* Click **Update Project...**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-018.png?featherlight=false&width=90pc)
20. Trong Eclipse IDE, mở tập tin **pom.xml**
* Thêm nội dung dưới đây vào sau dòng 113
```
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot</artifactId>
			<version>2.0.3.RELEASE</version>
		</dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-autoconfigure</artifactId>
			<version>2.0.3.RELEASE</version>
		</dependency>
		<dependency>
    		<groupId>org.json</groupId>
    		<artifactId>json</artifactId>
    		<version>20180130</version>
		</dependency>
		<dependency>
			<groupId>com.amazonaws.serverless</groupId>
			<artifactId>aws-serverless-java-container-core</artifactId>
			<version>1.1.3</version>
		</dependency>
		<dependency>
			<groupId>org.junit.jupiter</groupId>
			<artifactId>junit-jupiter-api</artifactId>
			<version>5.2.0</version>
		</dependency>
```
* Lưu lại

#### Cấp quyền cho CloudFormation để tạo IAM role
21. Truy cập vào [**AWS IAM Console**](https://console.aws.amazon.com/iamv2/).
* Click **Roles**.
* Nhập ```CodeStarWorker-flightspecialsa-CloudFormation``` vào ô tìm kiếm và nhấn **Enter**
* Click **CodeStarWorker-flightspecialsa-CloudFormation**. 
{{% notice note %}} 
Nếu bạn không thể tìm thấy role, có thể do còn quá sớm - CodeStar vẫn đang trong quy trình cấp phát và có thể chưa tạo role. Kiểm tra tiến trình cung cấp trong CodeStar dashboard.
{{% /notice %}}
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-019.png?featherlight=false&width=90pc)
22. Click **Add permissions**
* Click **Attach Policies**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-020.png?featherlight=false&width=90pc)
23. Nhập ```idevelop``` vào ô tìm kiếm và nhấn **Enter**
* Chọn **idevelopCodeStarCloudFormationPolicy**
* Click **Attach Policies**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-021.png?featherlight=false&width=90pc)
#### Cập nhật các thông số trong CloudFormation template
24. Trong Eclipse IDE, mở tập tin **template.yml**
* Làm tương tự bước 68 và bước 69 trong phần 3.3 để lấy giá trị **DatabaseSecurityGroup**, **DatabaseSubnet1**, **DatabaseSubnet2** và **RDSEndpoint**
* Thay **\<DatabaseSecurityGroup\>** bằng giá trị **DatabaseSecurityGroup**
* Thay **\<DatabaseSubnet1\>** bằng giá trị **DatabaseSubnet1**
* Thay **\<DatabaseSubnet2\>** bằng giá trị **DatabaseSubnet2**
* Thay **\<RDSEndpoint\>** bằng giá trị **RDSEndpoint**
* Lưu lại
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-023.png?featherlight=false&width=90pc)
#### Cập nhật AWS region trong tập tin định nghĩa API swagger.yml 
Tập tin **swagger.yml** được cung cấp trong gói zip là định nghĩa cho API sẽ cung cấp microservice thông qua Amazon API Gateway. Nó cần được cập nhật thông tin chi tiết về AWS Account ID trong bài thực hành của bạn và Region AWS mục tiêu trước khi bạn có thể triển khai dịch vụ vi mô của mình.

25. Trong Eclipse IDE, mở tập tin **swagger.yml**
* Nhấn tổ hợp phím **Ctrl+F**
* Tại mục **Find**, điền ```REPLACE_AWS_REGION```
* Tại mục **Replace with**, điền **Region** bạn đang làm bài thực hành này
* Click **Replace All** để thay thế
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-025.png?featherlight=false&width=90pc)
26. Tại mục **Find**, điền ```REPLACE_AWS_ACCOUNTID```
* Tại mục **Replace with**, điền **AWS Account Id** của bạn
* Click **Replace All** để thay thế
* Lưu lại
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-025b.png?featherlight=false&width=90pc)
27. Bây giờ bạn đã hoàn tất cập nhật tập tin, bạn cần thêm các tập tin đã thay đổi vào **new-implementation** git branch và xác nhận các thay đổi.
* Mở **Command Prompt**, chạy câu lệnh dưới đây để chuyển đường dẫn tới thư mục project **FlightSpecialsAPI** và xem lại thay đổi chưa được commit
```
cd C:\Users\Administrator\git\FlightSpecialsAPI
git status
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-026.png?featherlight=false&width=60pc)
28. Chạy lệnh dưới đây để thêm những tập tin thay đổi
```
git add .
git commit -m "Baseline implementation"
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-027.png?featherlight=false&width=60pc)
29. Chạy lệnh dưới đây để chuyển về nhánh **master**
```
git checkout master
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-028.png?featherlight=false&width=60pc)
30. Chạy lệnh dưới đây để để merge thay đổi từ nhánh **new-implementation** vào nhánh **master**
```
git merge new-implementation
```
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-029.png?featherlight=false&width=60pc)
31. Trong Eclipse IDE, nhấp chuột phải vào project **FlightSpecialsAPI** 
* Click **Team** 
* Click **Push to origin**. 
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-030.png?featherlight=false&width=90pc)
32. Click **Close**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-031.png?featherlight=false&width=90pc)

Bạn cần thực hiện đẩy từ Eclipse vì thông tin xác thực git được nhúng trong môi trường Eclipse. Bạn cũng có thể định cấu hình môi trường dòng lệnh bằng thông tin đăng nhập git nhưng điều đó nằm ngoài phạm vi của phòng thí nghiệm này.

Sẽ mất một vài phút để đẩy mã và bắt đầu triển khai. Kiểm tra mã nguồn và các template sẽ kích hoạt quá trình xây dựng và triển khai thực hiện mới. AWS CodePipeline hiện sẽ sử dụng CloudFormation để triển khai các tài nguyên sau:
* Hàm Lambda được triển khai bởi mã Java mà bạn đã kiểm tra trong CodeCommit
* IAM role cho hàm Lambda
* Cấu hình API Gateway cho API

Trong khi bạn có chút thời gian, hãy dành vài phút để khám phá **buildspec.yml**, **swagger.yml** và **template.yml** các tệp xác định Amazon API Gateway, hàm AWS Lambda và quá trình build/deploy thông qua AWS CodeBuild. Bạn sẽ nhận thấy rằng tập tin **builspec.yml** sử dụng cùng một lệnh AWS CLI để đóng gói triển khai mà bạn đã sử dụng khi đóng gói **HotelSpecials API** theo cách thủ công trước đó:

{{% notice warning %}} 
Đừng thực thi lệnh bên dưới, chúng chỉ để bạn tham khảo thêm.
{{% /notice %}}

```
mvn package shade:shade
aws cloudformation package --template template.yml --s3-bucket $S3_BUCKET --output-template template-export.yml
```

Tập tin **template.yml** sử dụng **Serverless Application Model (SAM)** chuyển đổi để xác định API REST, trái ngược với cách chúng ta tiếp cận điều này trong **HotelSpecials API**. Trong **HotelSpecials**, **CloudFormation template** đã sử dụng CloudFormation chuẩn để xác định API REST để nó có thể rõ ràng về định nghĩa API và bao gồm **swagger**. **FlightSpecials** sử dụng cách tiếp cận khai báo nhiều hơn và để lại thông tin chi tiết cho SAM. Bạn có thể tự do kết hợp CloudFormation và SAM trong cùng một template, như bạn có thể thấy từ các ví dụ này. Lưu ý rằng biến môi trường **$S3_BUCKET** được CodeBuild tự động thay thế khi bước xây dựng được thực hiện và được thay thế bằng S3 bucket mà CodeStar đã cung cấp khi thiết lập dự án.

#### Kiểm thử API FlightSpecials

33. Truy cập [**AWS API Gateway console**](https://console.aws.amazon.com/apigateway/home)
* Nhập **iDevelop - Flight Specials API** vào ô tìm kiếm và nhấn **Enter**
* Click **iDevelop - Flight Specials API**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-032.png?featherlight=false&width=90pc)
34. Click **Stages**
* Click dấu mũi tên bên cạnh **prod**
* Click **GET**
* Click **Invoke URL**
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-033.png?featherlight=false&width=90pc)
35. Sau một lúc khi hàm Lambda được khởi tạo, bạn sẽ thấy kết quả JSON của việc truy vấn cơ sở dữ liệu MySQL từ hàm Lambda
![Deploy the api using code star and CI/CD](/images/3-create-single-page-app/3.4-deploy-api-with-codestar/deploy-api-with-codestar-034.png?featherlight=false&width=90pc)

Nếu bạn thấy một JSON payload không có lỗi, bạn đã triển khai thành công một API và hỗ trợ hàm Lambda truy vấn cơ sở dữ liệu MySQL. Lưu ý rằng việc triển khai nhanh hơn và dễ dàng hơn mà không cần bất kỳ sự can thiệp thủ công nào và bạn thậm chí không phải tương tác với AWS CLI hoặc Bảng điều khiển? Mọi thứ được thúc đẩy bởi quá trình đăng ký kiểm soát nguồn.

Bây giờ bạn đã sẵn sàng tích hợp các API này với website **TravelBuddy**.















