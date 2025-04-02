<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Đặt lại mật khẩu - Book Haven</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='css/forgot-password.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <i class="fas fa-key fa-2x mb-3"></i>
                <h2>Đặt lại mật khẩu</h2>
            </div>
            <div class="new-password-container">
                <form action="newPassword" method="POST">
                    <div class="form-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" class="form-control" name="password" 
                               placeholder="Nhập mật khẩu mới" required>
                    </div>
                    
                    <div class="form-group">
                        <i class="fas fa-lock"></i>
                        <input type="password" class="form-control" name="confPassword" 
                               placeholder="Xác nhận mật khẩu mới" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save mr-2"></i>Lưu mật khẩu mới
                    </button>
                    
                    <a href="login.jsp" class="btn btn-secondary">
                        <i class="fas fa-sign-in-alt mr-2"></i>Đăng nhập
                    </a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>