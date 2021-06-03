+++
title = "Dùng Eclipse"
date = 2021
weight = 1
chapter = false
pre = "<b>Cách A. </b>"
+++

Dịch vụ vi mô tiếp theo mà chúng ta cần cho ứng dụng không máy chủ **TravelBuddy** của chúng ta là **FlightSpecials API**. Chúng ta đã xem **FlightSpecials** trước đây trong các phần trước, vì vậy nó sẽ quen thuộc với bạn. Nó hoạt động giống như **HotelSpecials API** ở chỗ nó phải được triển khai tích hợp với VPC để nó có thể kết nối với cơ sở dữ liệu MySQL để truy vấn dữ liệu. Thay vì đóng gói và triển khai microservice này theo cách thủ công, chúng ta sẽ sử dụng CodeStar để xây dựng CI/CD pipeline đầy đủ cho chúng ta, như chúng ta đã làm trong các bài thực hành trước đây. Vì vậy, do bạn đã tạo CI/CD pipeline bằng AWS CodeStar một vài lần, nên chúng ta sẽ không cung cấp cho bạn hướng dẫn từng bước đầy đủ. Nếu bạn cần trợ giúp, hãy tham khảo các tài liệu về cách hoàn thành các tác vụ cần thiết để tạo một dự án CodeStar mới và triển khai mã **FlightSpecials** trên ứng dụng mẫu do CodeStar cung cấp.

**Nội dung**
- [Tạo một CI/CD pipeline với AWS CodeStar](#tạo-một-cicd-pipeline-với-aws-codestar)
- [Cập nhật các thông số trong CloudFormation template](#cập-nhật-các-thông-số-trong-cloudformation-template)
- [Cập nhật AWS region trong tập tin định nghĩa API ```swagger.yml```](#cập-nhật-aws-region-trong-tập-tin-định-nghĩa-api-swaggeryml)
- [Kiểm tra các thay đổi đưa vào quản lý mã nguồn để kích hoạt quá trình triển khai](#kiểm-tra-các-thay-đổi-đưa-vào-quản-lý-mã-nguồn-để-kích-hoạt-quá-trình-triển-khai)
- [Kiểm thử API FlightSpecials](#kiểm-thử-api-flightspecials)


#### Tạo một CI/CD pipeline với AWS CodeStar
1. Tạo một project **AWS CodeStar Web Service** mới với mục tiêu là **Java** trên **AWS Lambda**. Đặt tên cho project là ```FlightSpecialsAPI```. \
Bạn có thể tham khảo thêm tại [Tài liệu CodeStar](https://docs.aws.amazon.com/codestar/latest/userguide/how-to-create-project.html).
2. Thêm project **CodeStar** vào **Eclipse IDE**. \
[Xem thêm tài liệu](https://docs.aws.amazon.com/codestar/latest/userguide/setting-up-ide-ec.html) nếu bạn cần tham khảo. \
Hãy nhớ rằng **thông tin đăng nhập Git** của bạn cho bài thực hành này được cung cấp trong phần **output** của **CloudFormation template**. \
Nếu sử dụng **Cloud9**, hãy nhớ thêm ```git config helpers```.
3. Tải về mã nguồn của [FlightSpecials](https://workshops.devax.academy/monoliths-to-microservices/module6/files/FlightSpecials.zip) và giải nén trong môi trường làm việc của bạn

{{%attachments title="Mã nguồn FlightSpecials" pattern=".*(zip)"/%}}

4. Tạo một **nhánh mới** trong git cho việc triển khai mà bạn sắp thực hiện. Đặt tên nhánh mới là ```new-implementation```.
5. Ghi đè phần triển khai do CodeStar cung cấp bằng nội dung của tập tin ZIP mà bạn vừa giải nén. Chúng ta có script ```copy_files.sh``` trong tập tin ```FlightSpecials.zip``` mà bạn có thể dùng như trong các bài thực hành trước. Để sử dụng, thực thi lệnh sau sau khi thay đường dẫn ```path/to/your/working/folder```. Ví dụ:

```bash
copy_files.sh /path/to/your/working/folder
```

Đừng quên sử dụng **Maven | Update Project** của IDE Eclipse để cập nhật lại project sau khi có thay đổi mã nguồn.

**Cấp quyền cho CloudFormation để tạo IAM role**

Là một phần của việc thiết lập microservice của chúng ta, chúng ta sẽ chỉ định IAM Role mới cho hàm Lambda của chúng ta để cho phép nó thực hiện các tác vụ khác nhau. Khi **CodeStar** tạo project, nó đã tạo một IAM Role cấp cho CloudFormation vừa đủ quyền để triển khai dịch vụ **Hello World example**. Các quyền này không đủ cho các yêu cầu nâng cao hơn của chúng ta. Vì vậy, chúng ta cần điều chỉnh các chính sách được chỉ định cho **CloudFormation role**, để mở rộng các quyền đó.

6. Truy cập **AWS IAM Console** trên trình duyệt.
7. Chọn **Roles** ở thanh điều hướng bên trái.
8. Trong ô **Filter** nhập ```CodeStarWorker-flightspecialsa-CloudFormation``` để tìm đúng **IAM Role**.

{{% notice note %}}
Nếu bạn không thể tìm thấy role, có thể do còn quá sớm - CodeStar vẫn đang trong quy trình cấp phát và có thể chưa tạo role. Kiểm tra tiến trình cung cấp trong CodeStar dashboard.
{{% /notice %}}

9. Chọn vào role để mở bảng thông tin chi tiết.
10. Chọn **Attach Policy**, trong ô **Filter** nhập ```idevelop``` để chọn các chính sách có sẵn. Chọn chính sách ```idevelopCodeStarCloudFormationPolicy``` trong danh sách. Chính sách này đã được tạo cho bạn bởi quá trình thiết lập bài thực hành và có các quyền được chỉ định cho nó để cho phép CloudFormation làm việc thay mặt chúng ta khi tạo role thực thi Lambda.
11. Chọn chính sách được liệt kê và nhấp vào **Attach Policy**

#### Cập nhật các thông số trong CloudFormation template

12. CloudFormation template ```template.yml``` được cung cấp là một phần của ```FlightSpecials.zip```. Tập tin có một số vị trí mà bạn cần cập nhật để khớp với các giá trị từ tài khoản lab của bạn trước khi bạn có thể triển khai cập nhật. Bao gồm **Subnet Ids**, **Security Group Ids** và **RDS Instance Endpoint** là các tài nguyên duy nhất của tài khoản của bạn.

Trong **Eclipse IDE**, mở tập tin ```template.yml``` và tìm kiếm từng mục trong bảng dưới đây trong cột **Item to replace**, và thay thế chúng bằng các giá trị được tìm thấy trong **Cloudformation Outputs**:

|     Mục để thay thế     |                    Mô tả                   |
|:-----------------------:|:------------------------------------------:|
| <DatabaseSubnet1>       | Mạng con đầu tiên cho cơ sở dữ liệu MySQL  |
| <DatabaseSubnet2>       | Mạng con thứ hai cho cơ sở dữ liệu MySQL   |
| <DatabaseSecurityGroup> | Security group cho cơ sở dữ liệu MySQL     |
| <RDSEndpoint>           | MySQL database endpoint                    |

13.  Khi bạn đã cập nhật xong các giá trị, mục **VPCConfig** sẽ trông tương tự như sau (với các giá trị khác nhau):

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

14. Trong **Eclipse IDE**, tìm tập tin ```swagger.yml``` và mở ra trong trình soạn thảo văn bản.
15. Tìm kiếm ```REPLACE_AWS_REGION``` và thay thế nó bằng khu vực bạn đang sử dụng(VD: ```ap-northeast-1```)
16. Tìm kiếm ```REPLACE_AWS_ACCOUNTID``` và thay thế nó bằng AWS Account Id. Bạn có thể tìm thấy AWS Account ID của mình trong trang tổng quan của bài thực hành.
17. Lưu tập tin.

#### Kiểm tra các thay đổi đưa vào quản lý mã nguồn để kích hoạt quá trình triển khai

18. Bây giờ bạn đã hoàn tất cập nhật tập tin, bạn cần thêm các tập tin đã thay đổi vào ```new-implementation``` git branch và xác nhận các thay đổi. Bạn có thể dùng Eclipse IDE hoặc CLI. Trong ví dụ này, chúng ta sẽ sử dụng Eclipse IDE, nhưng lưu ý đối với lần đẩy cuối cùng, bạn sẽ cần sử dụng IDE Eclipse vì nó được định cấu hình bằng thông tin đăng nhập Git của bạn, trong khi cửa sổ lệnh thì không:
    - Thực thi ```git status``` để kiểm tra lại các thay đổi về code.
    - Thực thi ```git add .``` để thêm vào các tập tin đã thay đổi.
    - Thực thi ```git commit -m "Baseline implementation"``` xác nhận các thay đổi và cung cấp một thông báo
    - Thực thi ```git checkout master``` để chuyển trở lại master branch
    - Bây giờ hợp nhất các thay đổi cho triển khai mới của bạn vào nhánh chính bằng cách phát hành ```git merge new-implementation```
    - Đẩy các thay đổi lên **CodeCommit** sử dụng Eclipse bằng cách nhấp chuột phải vào vị trí **root** và chọn **Team | Push to Origin...**

![API Gateway](/images/2/34.png?width=90pc)

Bạn cần thực hiện đẩy từ Eclipse vì thông tin xác thực git được nhúng trong môi trường Eclipse. Bạn cũng có thể định cấu hình môi trường dòng lệnh bằng thông tin đăng nhập git nhưng điều đó nằm ngoài phạm vi của phòng thí nghiệm này.

Sẽ mất một vài phút để đẩy mã và bắt đầu triển khai. Kiểm tra mã nguồn và các template sẽ kích hoạt quá trình xây dựng và triển khai thực hiện mới. AWS CodePipeline hiện sẽ sử dụng CloudFormation để triển khai các tài nguyên sau:

    - Hàm Lambda được triển khai bởi mã Java mà bạn đã kiểm tra trong CodeCommit
    - IAM role cho hàm Lambda
    - Cấu hình API Gateway cho API

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

1.  Truy cập **API Gateway console** trên trình duyệt và vào **APIs**, chọn ```iDevelop - Flight Specials API``` để tiết lộ các tài nguyên cho API.
2.  Chọn vào **Stages** ở dưới **iDevelop - Flight Specials API**.
3.  Mở rộng **prod** trong danh sách **Stages** .
4.  Chọn vào method **GET** 
5.  Chọn vào **Invoke URL** trong bảng **prod - GET - /flightspecials**. Sau một lúc khi hàm Lambda được khởi tạo, bạn sẽ thấy kết quả JSON của việc truy vấn cơ sở dữ liệu MySQL từ hàm Lambda. Ví dụ:

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
