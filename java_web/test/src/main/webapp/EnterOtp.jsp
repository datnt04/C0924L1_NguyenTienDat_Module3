<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>Xác thực OTP - Book Haven</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='css/forgot-password.css' rel='stylesheet'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header">
                <i class="fas fa-key fa-2x mb-3"></i>
                <h2>Nhập mã OTP</h2>
            </div>
            <div class="otp-container">
                <%
                if(request.getAttribute("message")!=null) {
                    out.println("<p class='text-danger mb-3'>"+request.getAttribute("message")+"</p>");
                }
                %>
                
                <p class="text-muted mb-4">Vui lòng nhập mã OTP đã được gửi đến email của bạn</p>
                
                <form action="ValidateOtp" method="post">
                    <div class="form-group">
                        <i class="fas fa-lock"></i>
                        <input type="text" class="form-control" name="otp" 
                               placeholder="Nhập mã OTP" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check mr-2"></i>Xác nhận OTP
                    </button>
                    
                    <a href="forgotPassword.jsp" class="btn btn-secondary">
                        <i class="fas fa-arrow-left mr-2"></i>Quay lại
                    </a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>