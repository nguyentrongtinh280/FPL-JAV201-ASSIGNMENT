<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            background: #1a6363;
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
            filter: drop-shadow(0 0 6px rgba(0,153,255,0.6));
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: 600;
            letter-spacing: 1px;
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

        .input-dark:focus {
            border-color: #2f9bff;
            box-shadow: 0 0 6px rgba(47,155,255,0.6);
        }

        .row-line {
            margin-bottom: 20px;
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

    <!-- TITLE -->
    <h2>Khôi Phục Mật Khẩu</h2>

    <!-- FORM -->
    <form action="reset-password" method="post">

        <!-- Username -->
        <div class="row-line">
            <label>Tên đăng nhập</label>
            <input type="text" name="username" class="form-control input-dark" required>
        </div>

        <!-- Email + Send OTP -->
        <div class="row-line">
            <label>Nhập Email</label>
            <div class="d-flex gap-2">
                <input type="email" name="email" class="form-control input-dark" required>
                <button type="button" class="btn btn-outline-light">Gửi OTP</button>
            </div>
        </div>

        <!-- OTP + Confirm -->
        <div class="row-line">
            <label>Nhập OTP</label>
            <div class="d-flex gap-2">
                <input type="text" name="otp" class="form-control input-dark" required>
                <button type="submit" class="btn btn-outline-light">Xác Nhận</button>
            </div>
        </div>

    </form>

</div>

</body>
</html>
