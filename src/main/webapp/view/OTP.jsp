<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Nhập OTP</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', sans-serif;
            background: #c3c3c3;
        }

        .reset-box {
            width: 600px;
            padding: 40px 45px;
            border-radius: 25px;
            background: radial-gradient(circle at top, #1e3c72, #0f2027);
            box-shadow: 0 0 30px rgba(0,0,0,0.8);
            color: white;
        }

        .logo-box {
            text-align: center;
            margin-bottom: 15px;
        }

        .logo-box img {
            width: 90px;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: 600;
        }

        label {
            font-size: 15px;
            font-weight: 500;
            margin-bottom: 6px;
            display: block;
            color: #ccc;
        }

        .input-dark {
            background: #f7f7f7;
            border: 1px solid #ccc;
            color: #333;
            padding: 10px;
            border-radius: 8px;
        }

        .row-line {
            margin-bottom: 18px;
        }

        .btn-outline-light {
            border-radius: 8px;
            padding: 10px 16px;
            font-weight: 600;
            border: 1px solid #555;
            background: transparent;
            color: white;
            white-space: nowrap;
        }

        .btn-outline-light:hover {
            background: #2f9bff;
            border-color: #2f9bff;
        }
    </style>
</head>

<body>

<div class="reset-box">

    <!-- LOGO -->
    <div class="logo-box">
        <img src="${pageContext.request.contextPath}/images/TTSHop.png">
    </div>

    <h2>Khôi Phục Mật Khẩu</h2>

    <!-- HIỂN THỊ THÔNG BÁO -->
    <c:if test="${not empty message}">
        <div class="alert alert-warning text-center">
                ${message}
        </div>
    </c:if>
    <form action="${pageContext.request.contextPath}/forgot-password" method="post">

        <!-- USERNAME -->
        <div class="row-line">
            <label>Tên đăng nhập</label>
            <input type="text" name="username"
                   value="${param.username}"
                   class="form-control input-dark" required>
        </div>

        <!-- EMAIL + SEND OTP -->
        <div class="row-line">
            <label>Email</label>
            <div class="d-flex gap-2">
                <input type="email" name="email"
                       value="${param.email}"
                       class="form-control input-dark" required>

                <button type="submit" name="action" value="sendOtp"
                        class="btn btn-outline-light">
                    Gửi OTP
                </button>
            </div>
        </div>

        <!-- CHỈ HIỆN OTP SAU KHI GỬI -->
        <c:if test="${not empty sessionScope.otp}">
            <div class="row-line">
                <label>Nhập OTP</label>
                <div class="d-flex gap-2">
                    <input type="text" name="otp"
                           class="form-control input-dark"
                           placeholder="Nhập mã OTP" required>

                    <button type="submit" name="action" value="verifyOtp"
                            class="btn btn-outline-light">
                        Xác Nhận
                    </button>
                </div>
            </div>
        </c:if>

    </form>



</div>

</body>
</html>
