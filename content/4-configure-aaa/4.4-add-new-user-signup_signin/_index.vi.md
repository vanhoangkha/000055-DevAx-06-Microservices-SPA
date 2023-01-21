+++
title = "Đăng ký người dùng mới và đăng nhập"
date = 2020
weight = 4
chapter = false
pre = "<b>4.4. </b>"
+++
#### Đăng ký người dùng mới và đăng nhập

1. Truy cập [**Amazon Cognito Console**](https://console.aws.amazon.com/cognito/home).
* Click **Federated Identities**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-001.png?featherlight=false&width=90pc)
2. Click **TravelBuddy**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-002.png?featherlight=false&width=90pc)
3. Click **Edit identity pool**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-003.png?featherlight=false&width=90pc)
4. Tại đây chúng ta có thể thiết lập **Unauthenticated** roles (roles xác định khi người dùng không đăng nhập), và **Authenticated** roles (roles xác định khi người dùng đăng nhập).
* Xác minh rằng **Unauthenticated** role được thiết lập chứa chuỗi **CognitoIAMUnauthenticatedRole**. Thông tin này được thiết lập khi tạo bài thực hành.
* Xác minh rằng **Authenticated** role được thiết lập chứa chuỗi **CognitoIAMAuthenticatedRole**. Thông tin này được thiết lập khi tạo bài thực hành.
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-004.png?featherlight=false&width=90pc)

Giờ đây, bạn đã có mọi thứ để đăng ký và đăng nhập với tư cách người dùng, sau đó kiểm tra hành vi đăng nhập của microservice /trips bây giờ rằng nó được bảo vệ bằng cách yêu cầu ủy quyền.

5. Trong trang **TravelBuddy**, click **Login or Register**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-005.png?featherlight=false&width=90pc)
6. Click **Sign-up here!**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-006.png?featherlight=false&width=90pc)
7. Tại mục **First Name**, nhập tên của bạn
* Tại mục **Last Name**, nhập họ của bạn
* Tại mục **Email Address**, nhập địa chỉ email của bạn
{{% notice note %}} 
Bạn phải cung cấp địa chỉ email hợp lệ - địa chỉ mà bạn có quyền truy cập, để bạn sẽ nhận được một mã xác minh.
{{% /notice %}}
* Tại mục **Password** nhập mật khẩu của bạn
* Click **Register**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-007.png?featherlight=false&width=90pc)
8. Kiểm tra email của bạn, lưu lại mã xác minh
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-008.png?featherlight=false&width=90pc)
9. Tại mục **Verification Code**, nhập mã xác minh đã lưu trong bước 8
* Click **Verify**
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-009.png?featherlight=false&width=90pc)
10. Đăng nhập bằng thông tin đăng nhập (địa chỉ email và mật khẩu) bạn đã cung cấp trong quá trình đăng ký.
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-010.png?featherlight=false&width=90pc)
11. Bây giờ bạn đã đăng nhập và bạn sẽ thấy phần **My Account**
* Click **My Account**, chúng ta sẽ thấy tính năng duy nhất được triển khai là tùy chọn đăng xuất
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-011.png?featherlight=false&width=90pc)
12. Click **Go!** mà không nhập bất cứ nội dung gì. Chúng ta sẽ thấy danh sách đầy đủ các chuyến đi trong hộp thoại
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-012.png?featherlight=false&width=90pc)
13. Đăng xuất và click **Go!** mà không nhập bất cứ nội dung gì. Chúng ta sẽ thấy thông báo lỗi.
![Add New User Sign Up and Sign In](/images/4-configure-aaa/4.4-add-new-user-signup_signin/add-new-user-signup_signin-013.png?featherlight=false&width=90pc)


