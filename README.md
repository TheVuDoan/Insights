# INSIGHTS

Hệ thống tự động thu thập tin tức từ các trang báo điện tử, và gợi ý tới người dùng những tin tức phù hợp.

### Hướng dẫn cài đặt

(Hướng dẫn cài đặt dành cho hệ điều hành Linux)

1. Cài đặt Ruby

* Chuẩn bị các thư viện liên quan

```
sudo apt-get install curl
sudo apt-get install gnupg2
```

* Cài đặt RVM

RVM viết tắt của "Ruby Version Manager" (Bộ quản lý phiên bản Ruby). RVM cung cấp cách hiệu quả để cài đặt Ruby với các phiên bản bất kỳ trên Ubuntu.

```
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
```

Sau khi cài đặt, reset cửa sổ terminal. Cài đặt những thư viện khác một cách tự động bằng câu lệnh:
```
rvm requirements
```
Để kiểm tra, thử liệt kê những phiên bản ruby hiện tại:
```
rvm list known
```

* Cài đặt Ruby
```
rvm install 2.6.5
```
Trong trường hợp có nhiều hơn 1 phiên bản ruby trong máy, cần chỉ định phiên bản ruby sẽ sử dụng:
```
rvm use 2.6.5 --default
```

*Chú ý, nếu gặp phải lỗi*
```
RVM is not a function, selecting rubies with 'rvm use ...' will not work.
 
You need to change your terminal emulator preferences to allow login shell.
Sometimes it is required to use `/bin/bash --login` as the command.
Please visit https://rvm.io/integration/gnome-terminal/ for a example.
```
*Làm theo hướng dẫn, thực thi lệnh `/bin/bash --login` và restart lại cửa sổ terminal.*

Kiểm tra phiên bản Ruby vừa cài đặt
```
ruby --version
```

2. Cài đặt Rails
```
gem install rails --version=5.2.3
```
Kiểm tra phiên bản vừa cài đặt
```
rails -v
```

3. Cài đặt MySQL
```
sudo apt-get install mysql
```

4. Cài đặt project

Pull từ github
```
git clone https://github.com/TheVuDoan/Insights.git
```
Hoặc giải nén file đính kèm

5. Đăng kí ứng dụng google (phục vụ cho tính năng thu thập video từ youtube)

Làm theo hướng dẫn chi tiết tại trang: https://github.com/Fullscreen/yt#configuring-your-app

Sau khi có `api_key`, tạo file .env ở thư mục gốc, thêm vào trường
```
YOUTUBE_API_KEY=<your_api_key>
```
Trong terminal, gõ lệnh sau để ghi các task vào file crontab
```
whenever -w
```
Như vậy là hệ thống sẽ tự động thu thập tin tức từ các trang báo điện tử và Youtube

6. Cấu hình gửi mail cho người dùng

Thêm vào file .env những trường sau
```
SENDMAIL_PASSWORD=<your_password>
SENDMAIL_USERNAME=<your_email>
MAIL_HOST=localhost:3000
```

7. Khởi tạo database
Cấu hình database.yml theo tài khoản MySQL. Ví dụ
```
development:
  adapter: mysql2
  database: Insights
  host: localhost
  username: dev
  password: 123456
  encoding: utf8
```

Trong terminal, gõ lệnh sau để khởi tạo CSDL:
```
rails db:migrate
```

Thêm các nguồn tin và thể loại:
```
rake db:seed
```

8. Chạy project

Trong terminal, gõ lệnh
```
rails s
```
Truy cập đường dẫn `localhost:3000` để xem kết quả