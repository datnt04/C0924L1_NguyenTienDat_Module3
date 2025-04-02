<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Quên mật khẩu - Book Haven</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='css/forgot-password.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <i class="fas fa-lock fa-2x mb-3"></i>
                <h2>Quên mật khẩu?</h2>
            </div>
            <div class="forgot">
                <p>Đổi mật khẩu của bạn trong ba bước đơn giản. Điều này sẽ giúp bảo mật mật khẩu của bạn!</p>
                <ol class="list-unstyled">
                    <li><span class="text-primary">1. </span>Nhập địa chỉ email của bạn</li>
                    <li><span class="text-primary">2. </span>Hệ thống sẽ gửi mã OTP vào email của bạn</li>
                    <li><span class="text-primary">3. </span>Nhập mã OTP ở trang tiếp theo</li>
                </ol>
                
                <form class="mt-4" action="forgotPassword" method="POST">
                    <div class="form-group">
                        <i class="fas fa-envelope"></i>
                        <input type="email" class="form-control" name="email" 
                               placeholder="Nhập địa chỉ email" required>
                        <small class="form-text text-muted">
                            Nhập email đã đăng ký. Chúng tôi sẽ gửi mã OTP vào email này.
                        </small>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-paper-plane mr-2"></i>Gửi mã OTP
                    </button>
                    <a href="login.jsp" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>Quay lại đăng nhập
                    </a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>