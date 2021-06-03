+++
title = "Dùng AWS Cloud9"
date = 2021
weight = 2
chapter = false
pre = "<b>Cách B. </b>"
+++

Dịch vụ vi mô tiếp theo mà chúng ta cần cho ứng dụng không máy chủ **TravelBuddy** của chúng ta là **FlightSpecials API**. Chúng ta đã xem **FlightSpecials** trước đây trong các phần trước, vì vậy nó sẽ quen thuộc với bạn. Nó hoạt động giống như **HotelSpecials API** ở chỗ nó phải được triển khai tích hợp với VPC để nó có thể kết nối với cơ sở dữ liệu MySQL để truy vấn dữ liệu. Thay vì đóng gói và triển khai microservice này theo cách thủ công, chúng ta sẽ sử dụng CodeStar để xây dựng CI/CD pipeline đầy đủ cho chúng ta, như chúng ta đã làm trong các bài thực hành trước đây. Vì vậy, do bạn đã tạo CI/CD pipeline bằng AWS CodeStar một vài lần, nên chúng ta sẽ không cung cấp cho bạn hướng dẫn từng bước đầy đủ. Nếu bạn cần trợ giúp, hãy tham khảo các tài liệu về cách hoàn thành các tác vụ cần thiết để tạo một dự án CodeStar mới và triển khai mã **FlightSpecials** trên ứng dụng mẫu do CodeStar cung cấp.

**Nội dung**
- [Tạo một CI/CD pipeline với AWS CodeStar](#tạo-một-cicd-pipeline-với-aws-codestar)
- [Cập nhật các thông số trong CloudFormation template](#cập-nhật-các-thông-số-trong-cloudformation-template)
- [Cập nhật AWS region trong tập tin định nghĩa API ```swagger.yml```](#cập-nhật-aws-region-trong-tập-tin-định-nghĩa-api-swaggeryml)
- [Tạo CodeStar Project](#tạo-codestar-project)
- [Thiết lập CodeCommit trên AWS Cloud9](#thiết-lập-codecommit-trên-aws-cloud9)
- [Kiểm tra các thay đổi đưa vào quản lý mã nguồn để kích hoạt quá trình triển khai](#kiểm-tra-các-thay-đổi-đưa-vào-quản-lý-mã-nguồn-để-kích-hoạt-quá-trình-triển-khai)
- [Kiểm thử API FlightSpecials](#kiểm-thử-api-flightspecials)


#### Tạo một CI/CD pipeline với AWS CodeStar

1. Tạo một project **AWS CodeStar Web Service** mới với mục tiêu là **Java** trên **AWS Lambda**. Đặt tên cho project là ```FlightSpecialsAPI```. \
Bạn có thể tham khảo thêm tại [Tài liệu CodeStar](https://docs.aws.amazon.com/codestar/latest/userguide/how-to-create-project.html).
2. Tạo một project **AWS CodeStar** từ **Cloud9 IDE**.
[Xem thêm tài liệu](https://docs.aws.amazon.com/codestar/latest/userguide/setting-up-ide-ec.html) nếu bạn cần tham khảo. \
Nếu sử dụng **Cloud9**, hãy nhớ thêm ```git config helpers```.

```bash
cd ~/environment
aws codestar create-project --generate-cli-skeleton | tee template.yml
```

This will create a ```template.yml``` file with the base skeleton. It requires details the following details to be updated. You can think of this as an overlay to create your CodeStar project, which will use the toolchain and zip file for your creation of the codestar project

   - S3 bucket name and key: This is the details for codestar deployment on where to grab the build for the pipeline.
   - Destination: This is the name of the codecommit repository or github repository, we are only using codecommit, but you can adapt this if you need to grab from your github repo.
   - Toolchain: this is a cloudformation template which sets up the required toolchain elements. It is the same as what has been done for you in eclipse, and will will create the following resources.
     - CodeCommit - s3bucket and policies to store the artifact
     - CodeCommit event - codecommit change occurs to action a new build
     - CodeBuild project - to build based off of the buildspec.yml
     - CodePipeline - project pipeline which will action all the required phases

3. Tải về và mở tập tin [toolchain.yml](https://workshops.devax.academy/monoliths-to-microservices/module6/files/toolchain.yml)

Chúng ta cần thay đổi các chi tiết cho tập tin toolchain.yml để trỏ đến đúng docker container sẽ được sử dụng. Docker container có tất cả các yêu cầu được xây dựng sẵn dựa trên các yêu cầu khác nhau. Trong trang web này, hãy tìm cái phù hợp với yêu cầu JAVA 1.8, maven của chúng ta. https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html

Trong ```toolchain.yml``` tìm docker container hiện tại sẽ trông như sau:

```yml
  CodeBuildProject:
    DependsOn:
    - CodeBuildPolicy
    Properties:
      Artifacts:
        Packaging: zip
        Type: codepipeline
      Cache:
        Type: S3
        Location: !Sub '${S3Bucket}/codebuildcache'
      Description: !Sub "AWS CodeStar created CodeBuild Project for ${ProjectId}"
      Environment:
        ComputeType: small
        # This environment variable informs AWS CodeBuild where it can retrieve your code artifact.
        # You can specify any other environment variables your buildspec.yml is looking for.
        EnvironmentVariables:
        - Name: S3_BUCKET
          Value: !Ref 'S3Bucket'
        # Replace this Docker image if necessary: https://docs.aws.amazon.com/codebuild/latest/userguide/build-env-ref-available.html
        Image: aws/codebuild/eb-nodejs-6.10.0-amazonlinux-64:4.0.0
        Type: LINUX_CONTAINER
```

4. Thay đổi hình ảnh thành phiên bản bạn cần cho java.

```bash
aws codebuild list-curated-environment-images
```

5. Bạn cũng có thể làm điều này bằng cách truy vấn **json** payload:

```bash
aws codebuild list-curated-environment-images --query "platforms[].languages[?language=='JAVA'].images"
```

6. Thay thế cái mới nhất trong **toolchain.yml**: ```Image:aws/codebuild/eb-java-8-amazonlinux-64:2.4.3-1.0.0```

Hãy nhớ thay đổi những điều này khi các phiên bản mới hơn được phát hành để đảm bảo rằng bạn đang sử dụng phiên bản mới nhất.

Phần khác cần xem lại là cách bộ nhớ đệm và ```buildspec``` hoạt động. Lưu ý thành phần bộ nhớ cache:

```yml
      Cache:
        Type: S3
        Location: !Sub '${S3Bucket}/codebuildcache'
```

Đây là thiết lập cho một S3 bucket, được sử dụng trong thiết lập cho tập tin ```buildspec.yml``` được hiển thị bên dưới:

```yml
cache:
  paths:
    - '/root/.m2/**/*'
```

7. Bạn cũng cần cung cấp service role bắt buộc cho template.yml mà bạn đã tạo. Để lấy ví dụ về điều này, bạn có thể làm như sau:

```bash
aws codestar create-project help

# check the examples to get the service role : 
"roleArn": "arn:aws:iam::123456789012:role/service-role/aws-codestar-service-role"
```

8. Tải về mã nguồn của [FlightSpecials](https://workshops.devax.academy/monoliths-to-microservices/module6/files/FlightSpecials.zip) và giải nén trong môi trường làm việc của bạn

{{%attachments title="Mã nguồn FlightSpecials" pattern=".*(zip)"/%}}

#### Cập nhật các thông số trong CloudFormation template

9. Chỉnh sửa tập tin ```FlightSpecials/template_cloud9.yml``` và thay thế chúng bằng các giá trị được tìm thấy trong **Cloudformation Outputs**:

|     Mục để thay thế     |                    Mô tả                   |
|:-----------------------:|:------------------------------------------:|
| <DatabaseSubnet1>       | Mạng con đầu tiên cho cơ sở dữ liệu MySQL  |
| <DatabaseSubnet2>       | Mạng con thứ hai cho cơ sở dữ liệu MySQL   |
| <DatabaseSecurityGroup> | Security group cho cơ sở dữ liệu MySQL     |
| <RDSEndpoint>           | MySQL database endpoint                    |

Khi bạn đã cập nhật xong các giá trị, mục **VPCConfig** sẽ trông tương tự như sau (với các giá trị khác nhau):

```yml
VpcConfig:
  SecurityGroupIds:
    - sg-858e61e3
  SubnetIds:
    - subnet-3c989d4a
    - subnet-a04255c4
Environment:
  Variables:
    JDBC_CONNECTION_STRING: jdbc:mysql://qlxx5jzrxxxby.cig0rzmdedgf.ap-northeast-1.rds.amazonaws.com:3306/travelbuddy?useSSL=false&serverTimezone=UTC&autoReconnect=true
    JDBC_UID: root
    JDBC_PWD: labpassword
```

#### Cập nhật AWS region trong tập tin định nghĩa API ```swagger.yml```

Tập tin ```swagger.yml``` được cung cấp trong gói zip là định nghĩa cho API sẽ cung cấp microservice thông qua Amazon API Gateway. Nó cần được cập nhật thông tin chi tiết về AWS Account ID trong bài thực hành của bạn và Region AWS mục tiêu trước khi bạn có thể triển khai dịch vụ vi mô của mình. 

10. Trong **Cloud9 IDE**, tìm tập tin ```swagger.yml``` và mở ra trong trình soạn thảo văn bản.
11. Tìm kiếm ```REPLACE_AWS_REGION``` và thay thế nó bằng khu vực bạn đang sử dụng(VD: ```ap-northeast-1```)
12. Tìm kiếm ```REPLACE_AWS_ACCOUNTID``` và thay thế nó bằng AWS Account Id. Bạn có thể tìm thấy AWS Account ID của mình trong trang tổng quan của bài thực hành.
13. Lưu tập tin.
14. Khi gói tập tin zip được sử dụng trong codedeploy, bạn cần phải gói từ thư mục nguồn. Để làm điều này, hãy chạy như sau: 

```bash
cd ~/environment/FlightSpecials
zip -r ../FlightSpecials.zip *
```

15. Nén tập tin ```FlightSpecials.zip``` với các cập nhật.

```bash
cd ~/environment
rm FlightSpecials.zip
cd FlightSpecials
zip -r FlightSpecials.zip *
adding: buildspec.yml (deflated 53%)
  adding: copy_files.sh (deflated 63%)
  adding: pom.xml (deflated 75%)
  adding: src/ (stored 0%)
  adding: src/test/ (stored 0%)
  adding: src/test/java/ (stored 0%)
  adding: src/test/java/devlounge/ (stored 0%)
  adding: src/test/java/devlounge/lambda/ (stored 0%)
  adding: src/test/java/devlounge/lambda/test/ (stored 0%)
  adding: src/test/java/devlounge/lambda/test/TestContext.java (deflated 76%)
  adding: src/test/java/devlounge/lambda/test/TestUtils.java (deflated 79%)
  adding: src/test/java/devlounge/lambda/test/LambdaFunctionHandlerTest.java (deflated 57%)
  adding: src/main/ (stored 0%)
  adding: src/main/java/ (stored 0%)
  adding: src/main/java/devlounge/ (stored 0%)
  adding: src/main/java/devlounge/model/ (stored 0%)
  adding: src/main/java/devlounge/model/FlightSpecial.java (deflated 73%)
  adding: src/main/java/devlounge/model/LambdaResult.java (deflated 62%)
  adding: src/main/java/devlounge/lambda/ (stored 0%)
  adding: src/main/java/devlounge/lambda/FlightSpecialsHandler.java (deflated 65%)
  adding: swagger.yml (deflated 68%)
  adding: template-configuration.json (deflated 18%)
  adding: template.yml (deflated 65%)
```

{{% notice note %}}
Lưu ý rằng thư mục **FlightSpecials** hiện đã bị bỏ qua, điều này rất quan trọng để bắt buộc chỉ có mã nguồn ở đó.
{{% /notice %}}

{{% notice note %}}
Lưu ý rằng cấu trúc thư mục ở đây là ** THỰC SỰ ** quan trọng: https://docs.aws.amazon.com/codebuild/latest/userguide/getting-started-cli-upload-source-code.html
{{% /notice %}}

#### Tạo CodeStar Project

16. Sao chép mã vào **FlightSpecials**. Bucket thực hành của bạn sẽ trông giống như thế này ```mod-9c10d0af24f74a4a-s3bucketlambdacode-vsuckr33vysr```

```bash
aws s3 cp FlightSpecials.zip s3://<Lambdabucket>
```

17. Sao chép tập tin ```toolchain.yml``` vào **Lamdba bucket**

```bash
aws s3 cp toolchain.yml s3://<Lambdabucket>
```

18. Tạo codepipeline template cho **flightspecials**, sẽ giống như sau:

Thay đổi **XXX** bằng tài khoản của bạn bên dưới để template hoạt động.

```json
{
    "name": "flightspecials",
    "id": "flightspecials",
    "description": "flight specials java8 example using ci/cd",
    "sourceCode": [
        {
            "source": {
                "s3": {
                    "bucketName": "<Lambdabucket>",
                    "bucketKey": "FlightSpecials.zip"
                }
            },
            "destination": {
                "codeCommit": {
                    "name": "flightspecials"
                }
            }
        }
    ],
    "toolchain": {
        "source": {
            "s3": {
                "bucketName": "<Lambdabucket>",
                "bucketKey": "toolchain.yml"
            }
        },
        "roleArn": "arn:aws:iam::XXX:role/service-role/aws-codestar-service-role",
        "stackParameters": {
            "ProjectId": "flightspecials"
        }
    }
}
```

19.  Tạo project **AWS Codestar**:

```json
aws codestar create-project --cli-input-json file://template.json
{
    "arn": "arn:aws:codestar:ap-northeast-1:436753246579:project/flightspecials"
}
```

Bây giờ hãy kiểm tra thông tin CloudFormation đã hoàn thành, repo CodeCommit đã tạo và bản build đầu tiên đã được khởi động.

Nếu bất kỳ lỗi nào trong số này không thành công, hãy xem các lỗi. Bạn sẽ cần xóa s3 bucket đã tạo và tạo lại nếu có bất kỳ sự cố nào. Nếu bạn đang thay đổi bất kỳ mã nào cho ```FlightSpecials.zip``` và hãy nhớ tải lên bucket.

Để kiểm tra hoạt động : ```aws codestar describe-project --id flightspecials```

#### Thiết lập CodeCommit trên AWS Cloud9

Sau khi tạo xong, bạn cần thiết lập git repo cần thiết cho codecommit mà bạn đã định cấu hình trước đó.

20. Di chuyển tập tin zip ban đầu, vì đây chỉ là tệp tải lên lần đầu tiên, sau đó thiết lập helper class cần thiết và tải về repository của bạn.

```bash
mv FlightSpecials FlightSpecials_orig
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git clone https://git-codecommit.ap-northeast-1.amazonaws.com/v1/repos/flightspecials
cd flightspecials
```

**Cấp quyền cho CloudFormation để tạo IAM role**

Là một phần của việc thiết lập microservice của chúng ta, chúng ta sẽ chỉ định IAM Role mới cho hàm Lambda của chúng ta để cho phép nó thực hiện các tác vụ khác nhau. Khi **CodeStar** tạo project, nó đã tạo một IAM Role cấp cho CloudFormation vừa đủ quyền để triển khai dịch vụ **Hello World example**. Các quyền này không đủ cho các yêu cầu nâng cao hơn của chúng ta. Vì vậy, chúng ta cần điều chỉnh các chính sách được chỉ định cho **CloudFormation role**, để mở rộng các quyền đó.

21. Truy cập **AWS IAM Console** trên trình duyệt.
22. Chọn **Roles** ở thanh điều hướng bên trái.
23. Trong ô **Filter** nhập ```CodeStarWorker-flightspecialsa-CloudFormation``` để tìm đúng **IAM Role**.

{{% notice note %}}
Nếu bạn không thể tìm thấy role, có thể do còn quá sớm - CodeStar vẫn đang trong quy trình cấp phát và có thể chưa tạo role. Kiểm tra tiến trình cung cấp trong CodeStar dashboard.
{{% /notice %}}

24. Chọn vào role để mở bảng thông tin chi tiết.
25. Chọn **Attach Policy**, trong ô **Filter** nhập ```idevelop``` để chọn các chính sách có sẵn. Chọn chính sách ```idevelopCodeStarCloudFormationPolicy``` trong danh sách. Chính sách này đã được tạo cho bạn bởi quá trình thiết lập bài thực hành và có các quyền được chỉ định cho nó để cho phép CloudFormation làm việc thay mặt chúng ta khi tạo role thực thi Lambda.
26. Chọn chính sách được liệt kê và nhấp vào **Attach Policy**

#### Kiểm tra các thay đổi đưa vào quản lý mã nguồn để kích hoạt quá trình triển khai

27.  Bây giờ bạn đã hoàn tất cập nhật tập tin, bạn cần thêm các tập tin đã thay đổi vào ```new-implementation``` git branch và xác nhận các thay đổi. Bạn có thể dùng Cloud9 IDE:
    - Thực thi ```git status``` để kiểm tra lại các thay đổi về code.
    - Thực thi ```git add .``` để thêm vào các tập tin đã thay đổi.
    - Thực thi ```git commit -m "Baseline implementation"``` xác nhận các thay đổi và cung cấp một thông báo
    - Thực thi ```git checkout master``` để chuyển trở lại master branch
    - Bây giờ hợp nhất các thay đổi cho triển khai mới của bạn vào nhánh chính bằng cách phát hành ```git merge new-implementation```
    - Đẩy các thay đổi lên **CodeCommit**.

Sẽ mất một vài phút để đẩy mã và bắt đầu triển khai. Kiểm tra mã nguồn và các template sẽ kích hoạt quá trình xây dựng và triển khai thực hiện mới. AWS CodePipeline hiện sẽ sử dụng CloudFormation để triển khai các tài nguyên sau:

Trong khi bạn có chút thời gian, hãy dành vài phút để khám phá ```buildspec.yml```, ```swagger.yml``` và ```template.yml``` các tệp xác định Amazon API Gateway, hàm AWS Lambda và quá trình build/deploy thông qua AWS CodeBuild. Bạn sẽ nhận thấy rằng tập tin ```builspec.yml``` sử dụng cùng một lệnh AWS CLI để đóng gói triển khai mà bạn đã sử dụng khi đóng gói **HotelSpecials API** theo cách thủ công trước đó 

{{% notice warning %}}
Đừng thực thi lệnh bên dưới, chúng chỉ để bạn tham khảo thêm.
{{% /notice %}}

```bash
mvn package shade:shade
aws cloudformation package --template template.yml --s3-bucket $S3_BUCKET --output-template template-export.yml
```

Tập tin ```template.yml``` sử dụng **Serverless Application Model (SAM)** chuyển đổi để xác định API REST, trái ngược với cách chúng ta tiếp cận điều này trong **HotelSpecials API** 

Ví dụ: Trong **HotelSpecials**, **CloudFormation template** đã sử dụng CloudFormation chuẩn để xác định API REST để nó có thể rõ ràng về định nghĩa API và bao gồm ```swagger```. Ví dụ **FlightSpecials** sử dụng cách tiếp cận khai báo nhiều hơn và để lại thông tin chi tiết cho SAM. Bạn có thể tự do kết hợp CloudFormation và SAM trong cùng một template, như bạn có thể thấy từ các ví dụ này.

{{% notice note %}}
Lưu ý rằng biến môi trường ```$S3_BUCKET``` được CodeBuild tự động thay thế khi bước xây dựng được thực hiện và được thay thế bằng S3 bucket mà CodeStar đã cung cấp khi thiết lập dự án. 
{{% /notice %}}

#### Kiểm thử API FlightSpecials

Bạn có thể kiểm tra **trạng thái** của việc triển khai thay đổi mã nguồn thông qua đường dẫn trên CodeStar project dashboard. Khi quá trình triển khai đã hoàn tất thông qua CI/CD pipeline, bạn đã sẵn sàng để kiểm tra API.

28. Truy cập **API Gateway console** trên trình duyệt và vào **APIs**, chọn ```iDevelop - Flight Specials API``` để tiết lộ các tài nguyên cho API.
29. Chọn vào **Stages** ở dưới **iDevelop - Flight Specials API**.
30. Mở rộng **prod** trong danh sách **Stages** .
31. Chọn vào method **GET** 
32. Chọn vào **Invoke URL** trong bảng **prod - GET - /flightspecials**. Sau một lúc khi hàm Lambda được khởi tạo, bạn sẽ thấy kết quả JSON của việc truy vấn cơ sở dữ liệu MySQL từ hàm Lambda. Ví dụ:

```json
{
	"succeeded": true,
	"message": "",
	"errorCode": 0,
	"data": [
        {
            "id": 1,
            "header": "London to Prague",
            "body": "Jewel of the East",
            "cost": 93,
            "expiryDate": 1504072439813
        }, 
        {
            "id": 2,
            "header": "Paris to London",
            "body": "Weekend getaway!",
            "cost": 182,
            "expiryDate": 1504074888702
        }
    ]
}
```

Nếu bạn thấy một JSON payload không có lỗi, bạn đã triển khai thành công một API và hỗ trợ hàm Lambda truy vấn cơ sở dữ liệu MySQL. Lưu ý rằng việc triển khai nhanh hơn và dễ dàng hơn mà không cần bất kỳ sự can thiệp thủ công nào và bạn thậm chí không phải tương tác với AWS CLI hoặc Bảng điều khiển? Mọi thứ được thúc đẩy bởi quá trình đăng ký kiểm soát nguồn.

Bây giờ bạn đã sẵn sàng tích hợp các API này với website **TravelBuddy**.
