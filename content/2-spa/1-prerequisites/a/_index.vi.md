+++
title = "Dùng Eclipse"
date = 2021
weight = 1
chapter = false
pre = "<b>Cách A. </b>"
+++

Trong bài thực hành, bạn sẽ kết nối tới "Máy ảo Windows". Bạn sẽ sử dụng máy ảo Windows được tạo từ Cloud Formation để thực hiện bài thực hành.

**Nội dung**
- [Cài đặt & Cấu hình các bước ban đầu - Sử dụng Eclipse](#cài-đặt--cấu-hình-các-bước-ban-đầu---sử-dụng-eclipse)
- [Thiết lập DynamoDB](#thiết-lập-dynamodb)

#### Cài đặt & Cấu hình các bước ban đầu - Sử dụng Eclipse

Trong bài thực hành, bạn sẽ kết nối tới **Máy chủ Windows**. Bạn sẽ sử dụng máy ảo Windows được tạo từ Cloud Formation để thực hiện bài thực hành.

1. Một **Máy chủ Windows** đã được thiết lập cho bạn. Để truy cập vào được instance này, hãy thực hiện theo các bước trong [Phần 1.2. Môi trường Remote và Thiết lập AWS CLI](../../../1-prerequisites/2-remote-env-config-cli/), sau đó tiếp tục thực hiện bài thực hành:

#### Thiết lập DynamoDB

Chúng ta sẽ cần thực hiện đưa dữ liệu vào trong DynamoDB table, các thông tin này sẽ được sử dụng xuyên suốt bài thực hành. Dữ liệu này sẽ được sử dụng để tính toán các chuyến đi giữa các thành phố với nhau.

Bạn chỉ thực hiện bước này sau khi hoàn thành việc thiết lập Máy chủ Windows.

2. Tải tập tin sau về môi trường máy chủ Windows của bạn: [**populate_tripsector.sh**](https://workshops.devax.academy/monoliths-to-microservices/module6/files/populate_tripsector.sh)
3. Thực thi câu lệnh sau trong Eclipse trên máy chủ Windows. Bạn sẽ cần sử dụng cửa sổ lệnh `git bash` đã được cài đặt. 

```bash
bash populate_tripsector.sh <AWS_REGION>
```

![Kinesis](/images/2/kinesisconsumerproducerapparch.png?width=90pc)

4. Mở dịch vụ **DynamoDB** trong **AWS Console** và kiểm tra table **TravelBuddyTripSectors**. Hãy chắc chắn rằng đã có **50 bản ghi** được thêm vào trong table.

![DynamoDB](/images/2/5.png?width=90pc)