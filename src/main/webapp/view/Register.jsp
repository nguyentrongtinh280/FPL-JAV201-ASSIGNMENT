<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng Ký tài khoản</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
  <style>
    body {
      min-height: 100vh;
      background: linear-gradient(135deg, #6f86d6, #9f5bd1);
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .login-card {
      max-width: 900px;
      width: 100%;
      border-radius: 15px;
      overflow: hidden;
    }

    .login-left {
      background-color: #f8f9fa;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .login-left img {
      width: 70%;
      max-width: 320px;
      height: auto;
      object-fit: contain;
    }

    .login-right {
      padding: 50px;
    }

    .form-control {
      border-radius: 50px;
      padding-left: 45px;
      height: 48px;
    }

    .input-icon {
      position: absolute;
      top: 50%;
      left: 20px;
      transform: translateY(-50%);
      color: #aaa;
    }

    .form-control.is-invalid {
      background-position: right 15px center;
    }

    .invalid-feedback {
      margin-left: 20px;
    }
  </style>
</head>
<body>
<div class="card login-card shadow-lg">
  <div class="row g-0">

    <div class="col-md-6 login-left d-none d-md-flex">
      <img src="${pageContext.request.contextPath}/images/login.png" alt="Login">
    </div>

    <div class="col-md-6 login-right">
      <h3 class="text-center fw-bold mb-4 text-primary">Đăng ký tài khoản</h3>
      <form action="register" method="post" id="registerForm" novalidate>

        <div class="mb-3 position-relative">
          <i class="fa-solid fa-file-signature input-icon"></i>
          <input type="text" class="form-control" name="fullname"
                 placeholder="Họ và tên" required>
          <div class="invalid-feedback">
            Vui lòng nhập họ và tên!
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-user input-icon"></i>
          <input type="text" class="form-control" name="username"
                 placeholder="Tên đăng nhập" required>
          <div class="invalid-feedback">
            Vui lòng nhập tên đăng nhập!
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-solid fa-phone input-icon"></i>
          <input type="text" class="form-control" name="phone"
                 placeholder="Số điện thoại" required>
          <div class="invalid-feedback">
            Vui lòng nhập số điện thoại!
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-lock input-icon"></i>
          <input type="password" class="form-control" name="password"
                 placeholder="Mật khẩu" required>
          <div class="invalid-feedback">
            Vui lòng nhập mật khẩu!
          </div>
        </div>

        <div class="mb-3 position-relative">
          <i class="fa fa-lock input-icon"></i>
          <input type="password" class="form-control" name="confirmPassword"
                 placeholder="Xác nhận mật khẩu" required>
          <div class="invalid-feedback">
            Vui lòng nhập xác nhận mật khẩu!
          </div>
        </div>

        <div class="d-grid mb-3">
          <button type="submit" class="btn btn-success text-white">
            Đăng ký tài khoản
          </button>
        </div>
        <div class="text-center">
          <span>Đã có tài khoản?</span> <a href="Login.jsp" class="fw-bold text-decoration-none"> Đăng nhập </a>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  (() => {
    const form = document.getElementById('registerForm');

    form.addEventListener('submit', function (event) {
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
      }
      form.classList.add('was-validated');
    }, false);
  })();
</script>

</body>
</html>