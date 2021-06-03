+++
title = "Xác thực cho SPA"
weight = 1
chapter = false
pre = "<b>3.1. </b>"
+++

**Thêm Xác thực vào SPA sử dụng Amazon Cognito User Pools**

Trong bài tập này, chúng ta sẽ sử dụng **Cognito User Pool** và **Identity Pool**, đồng thời đánh dấu một trong các điểm cuối API của chúng tôi là yêu cầu xác thực qua Cognito User Pools.

1. Trong thư mục ```www```, tìm tập tin ```webapp-configuration.js``` trong ```scripts```. Trong tập tin này có phần nội dung sau:

```js
(function () {
    'use strict';

    angular
        .module('app')

        .constant('COGNITO_IDENTITY_POOL_ID',   'REPLACE_WITH_COGNITO_IDENTITY_POOL_ID')
        .constant('COGNITO_USER_POOL',          'REPLACE_WITH_COGNITO_USER_POOL')
        .constant('COGNITO_USER_POOL_CLIENT_ID','REPLACE_WITH_COGNITO_USER_POOL_CLIENT_ID')
        .constant('COGNITO_APP_WEB_DOMAIN',     'REPLACE_WITH_S3_BUCKET_WWW')

        .constant('AWS_REGION',                 'ap-northeast-1')
        .constant('APP_BANNER',                 'TravelBuddy')

})();
```

SPA được triển khai bằng cách sử dụng Angular framework, cho phép bạn xác định các hằng số toàn cục được sử dụng làm biến cấu hình trong toàn bộ ứng dụng của bạn. Tệp này xác định các giá trị của biến cấu hình mà bạn cần đặt dựa trên AWS Account's ARN và ID của bạn cho các tài nguyên Cognito khác nhau. Mở tệp ```webapp-configuration.js``` trong trình soạn thảo văn bản và giữ nó mở trong khi chúng tôi thực hiện các thay đổi trong các bước sau.
 
2. Truy cập **AWS Cognito console** bằng các tìm ```cognito``` trong thanh tìm kiếm. Nhấn **Enter**.
3. Chọn **Manage your User Pools**
4. Chọn **TravelBuddy**

![API](/images/3/1.png?width=90pc)

5. Trong bảng **General Settings**, tìm **Pool Id** và thay cho ```REPLACE_WITH_COGNITO_USER_POOL``` trong tập tin ```webapp-configuration.js```.
6. Chọn thiết lập **App Client** ở mục **App integration** trong thanh điều hướng bên trái trang **Cognito User Pools**. Tìm giá trị ```ID``` bên dưới mục App client **TravelBuddyWebApp** và sao chép chúng. Ví dụ:

![API](/images/3/2.png?width=90pc)

7. Thay thế cho giá trị ```REPLACE_WITH_COGNITO_USER_POOL_CLIENT_ID``` trong tập tin ```webapp-configuration.js``` bằng giá trị của **App client ID**.
8. Trong **Cognito console**, chọn **Federated Identities** ở thanh phía trên và chọn chuyển đổi **Cognito Identity Pools manager**.
9. Chọn vào liên kết **TravelBuddy** trong identity pool hiện ra.
10. Trong dashboard xuất hiện, ở thanh điều hướng bên trái, chọn **Sample code**.
11. Trong mục **Get AWS Credentials** , ghi nhận lại **Identity Pool ID** xuất hiện trong đoạn mã ví dụ. Sao chép **Identity Pool ID** vào bộ nhớ đệm, chúng ta sẽ sử dụng giá trị này sau:

```bash
ap-northeast-1:aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeee
```

![API](/images/3/3.png?width=90pc)

Chắc chắn rằng bạn đã sao chép luôn cả nội dung **region**.

12. Thay thế giá trị ```REPLACE_WITH_COGNITO_IDENTITY_POOL_ID``` trong tập tin ```webapp-configuration.js``` bằng giá trị của **Identity Pool Id**.
13. Trong **CloudFormation console** của bài thực hành, ở bảng **Additional Info**, sao chép giá trị ```S3BucketWWW``` - tên của S3 bucket chứa ứng dụng đơn trang (SPA) của bạn.
14. Thay thế giá trị ```REPLACE_WITH_S3_BUCKET_WWW``` trong tập tin ```webapp-configuration.js``` bằng giá trị của ```S3BucketWWW``` ở bảng **Additional Info**.
15. Hoành thành thiết lập tập tin ```webapp-configuration.js```:

```js
(function () {
    'use strict';

    angular
        .module('app')

        .constant('COGNITO_IDENTITY_POOL_ID',   'ap-northeast-1:429c1d1c-7a5e-4d53-be18-177b806c53a4')
        .constant('COGNITO_USER_POOL',          'ap-northeast-1_YSRyht4ck')
        .constant('COGNITO_USER_POOL_CLIENT_ID','3mh9486bds2f2cr3gio8bdjoik')
        .constant('COGNITO_APP_WEB_DOMAIN',     'devax-m6-s3bucketwebsite18ddbcd4-19ewci3z6hece')

        .constant('AWS_REGION',                 'ap-northeast-1')
        .constant('APP_BANNER',                 'TravelBuddy')

})();
```

16. Bây giờ bạn đã thực hiện tất cả các thay đổi bạn cần trong ```webapp-configuration.js```. Lưu và tải tập tin lên ```S3BucketWWW``` trong thư mục **scripts**, ghi đè lên tập tin hiện có. Bạn có thể thực hiện tải lên bằng Console hoặc cửa sổ lệnh.
17. Làm mới trang web **TravelBuddy** và kiểm tra developer console để xác nhận rằng không có **không có lỗi** nào sau các thay đổi bạn đã thực hiện.
