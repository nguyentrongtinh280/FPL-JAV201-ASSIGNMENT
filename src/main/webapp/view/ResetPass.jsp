<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Khôi Phục Mật Khẩu</title>
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
            width: 500px;
            background: radial-gradient(circle at top, #1e3c72, #0f2027);
            border-radius: 18px;
            padding: 35px 40px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.35);
            animation: fadeIn 0.6s ease;
        }

        .logo-img {
            width: 120px;
            margin-bottom:  3px;
        }

        h2 {
            margin: 15px 0 25px;
            font-weight: 700;
            font-size: 24px;
            color: #aebdd6;
        }

        label {
            float: left;
            margin-bottom: 6px;
            font-weight: 600;
            color: #bfb7b7;
        }

        .form-control {
            background: #f7f7f7;
            border: 1px solid #ccc;
            color: #333;
            padding: 10px;
            border-radius: 8px;
            width: 100%;
        }

        .form-control:focus {
            border-color: #1e88e5;
            box-shadow: 0 0 6px rgba(30,136,229,0.4);
        }

        .btn-reset {
            background: linear-gradient(90deg, #1e88e5, #1565c0);
            border: none;
            padding: 10px 38px;
            border-radius: 8px;
            color: white;
            font-weight: bold;
            margin-top: 18px;
            transition: 0.3s;
        }

        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(21,101,192,0.4);
        }

        @keyframes fadeIn {
            from {opacity:0; transform: scale(0.95);}
            to {opacity:1; transform: scale(1);}
        }
    </style>

</head>

<body>

<div class="reset-box">

    <!-- LOGO -->
    <img src="${pageContext.request.contextPath}/images/TTSHop.png" class="logo-img">

    <!-- TITLE -->
    <h2>Đặt Lại Mật Khẩu</h2>

    <!-- FORM -->
    <form action="reset-password" method="post">

        <div class="mb-3 text-start">
            <label>Mật Khẩu Mới</label>
            <input type="password" name="newPassword" class="form-control" required>
        </div>

        <div class="mb-3 text-start">
            <label>Xác Nhận Mật Khẩu Mới</label>
            <input type="password" name="confirmPassword" class="form-control" required>
        </div>

        <button type="submit" class="btn-reset">Thay Đổi Mật Khẩu</button>

    </form>

</div>

</body>
</html>
